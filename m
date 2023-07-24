Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F24875E6FA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjGXBYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjGXBXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:23:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84191709;
        Sun, 23 Jul 2023 18:22:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5254B60F08;
        Mon, 24 Jul 2023 01:22:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A52C433C8;
        Mon, 24 Jul 2023 01:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161741;
        bh=qhh8Lf1XCfAF8rtfnerjBiHBNF3y9GF83zIN60JVDwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IsgamPdO699Bmu1zbUMzpHQx6Bi8O92CV2/0RHvR1B/X1aoM9lnXYeC/h3zs3SRER
         7wu9/oTe51A0f6kJfgwxyQkaaGm3laRfK4Wfr4eacYu3ktMC1XcAUuJSYRPWfdAd3L
         PZfMLzovPGH3CIuInE3SSeiciAV5JB/hZz8QUCBNawS7cav4bxFYmHhkRTiGnl0a3Y
         9RU34QvAr2UxoKzAXO+qom4Ndqlv+sOqVOi3uou8/l3WzveLRJqhIrRFdRgzD96XCK
         SMQWfQV1DuLgYFIiNUuP7LAqZ1ixsPbY+48ZVvoXblxtt9eMEyVYR8bHDoBypynE3i
         +daFXRBj9HuZA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 17/41] iopoll: Call cpu_relax() in busy loops
Date:   Sun, 23 Jul 2023 21:20:50 -0400
Message-Id: <20230724012118.2316073-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724012118.2316073-1-sashal@kernel.org>
References: <20230724012118.2316073-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.40
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit b407460ee99033503993ac7437d593451fcdfe44 ]

It is considered good practice to call cpu_relax() in busy loops, see
Documentation/process/volatile-considered-harmful.rst.  This can not
only lower CPU power consumption or yield to a hyperthreaded twin
processor, but also allows an architecture to mitigate hardware issues
(e.g. ARM Erratum 754327 for Cortex-A9 prior to r2p0) in the
architecture-specific cpu_relax() implementation.

In addition, cpu_relax() is also a compiler barrier.  It is not
immediately obvious that the @op argument "function" will result in an
actual function call (e.g. in case of inlining).

Where a function call is a C sequence point, this is lost on inlining.
Therefore, with agressive enough optimization it might be possible for
the compiler to hoist the:

        (val) = op(args);

"load" out of the loop because it doesn't see the value changing. The
addition of cpu_relax() would inhibit this.

As the iopoll helpers lack calls to cpu_relax(), people are sometimes
reluctant to use them, and may fall back to open-coded polling loops
(including cpu_relax() calls) instead.

Fix this by adding calls to cpu_relax() to the iopoll helpers:
  - For the non-atomic case, it is sufficient to call cpu_relax() in
    case of a zero sleep-between-reads value, as a call to
    usleep_range() is a safe barrier otherwise.  However, it doesn't
    hurt to add the call regardless, for simplicity, and for similarity
    with the atomic case below.
  - For the atomic case, cpu_relax() must be called regardless of the
    sleep-between-reads value, as there is no guarantee all
    architecture-specific implementations of udelay() handle this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Link: https://lore.kernel.org/r/45c87bec3397fdd704376807f0eec5cc71be440f.1685692810.git.geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/iopoll.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
index 2c8860e406bd8..0417360a6db9b 100644
--- a/include/linux/iopoll.h
+++ b/include/linux/iopoll.h
@@ -53,6 +53,7 @@
 		} \
 		if (__sleep_us) \
 			usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
+		cpu_relax(); \
 	} \
 	(cond) ? 0 : -ETIMEDOUT; \
 })
@@ -95,6 +96,7 @@
 		} \
 		if (__delay_us) \
 			udelay(__delay_us); \
+		cpu_relax(); \
 	} \
 	(cond) ? 0 : -ETIMEDOUT; \
 })
-- 
2.39.2

