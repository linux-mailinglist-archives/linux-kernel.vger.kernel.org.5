Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AEA779588
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236400AbjHKRBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236258AbjHKRBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:01:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D34C30F4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:01:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B406B65816
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 17:01:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9C4C433CC;
        Fri, 11 Aug 2023 17:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691773275;
        bh=MZmgDtu6USFXQ4e5nMMY/JREFBhjkYnO2RkDI2BMkjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tsZvUQ8ySYF4A2/3RW0XnSo8R5YkRZYqdUrubU/I4yprZB7EkuAc8o0ZDWS6CgdIj
         /pti4fyBFMT4Sv5SBTP1DZ9IRU8YcGYdjcDmsKDoZ/rHHBT5zmVCoPU9Q3MjhOn8/C
         E9AuFAiCgmS2cl/iDyxSVbPN47DpkxdEM6o8+FBYHd0GnoMFW3PT3fUriTZ71egoNH
         by8fx8X7n9VDlixdvztUxnZdl4Hwp0qoCeTXDXltjXgxrB/tHMV9Q2f0oVRYsGAPD4
         xUhRjxJQ6Bdp+cro5zKPo1PCtBsS9f+d30qWxh2lr1VXdSqk/+Te1ThPAtMV016YG5
         4HiBbDkUAESlA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 09/10] x86: Remove the current_clr_polling() call upon mwait exit
Date:   Fri, 11 Aug 2023 19:00:48 +0200
Message-Id: <20230811170049.308866-10-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811170049.308866-1-frederic@kernel.org>
References: <20230811170049.308866-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mwait_idle_with_hints() is mostly called from cpuidle which already sets
back TIF_NR_POLLING and fold TIF_NEED_RESCHED if necessary.

The only non-cpuidle caller is power_saving_thread() which acts as an idle
loop and is the only reason why mwait_idle_with_hints() carries a costly
fully ordered atomic operation upon idle exit.

Make this overhead proper to power_saving_thread() instead which already
duplicates quite some cpuidle code.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/x86/include/asm/mwait.h | 1 -
 drivers/acpi/acpi_pad.c      | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index 920426d691ce..c1be3775b94a 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -134,7 +134,6 @@ static __always_inline void mwait_idle_with_hints(unsigned long eax, unsigned lo
 			}
 		}
 	}
-	current_clr_polling();
 }
 
 /*
diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 7a453c5ff303..5a44afafe185 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -174,6 +174,7 @@ static int power_saving_thread(void *data)
 			stop_critical_timings();
 
 			mwait_idle_with_hints(power_saving_mwait_eax, 1);
+			current_clr_polling();
 
 			start_critical_timings();
 			tick_broadcast_exit();
-- 
2.34.1

