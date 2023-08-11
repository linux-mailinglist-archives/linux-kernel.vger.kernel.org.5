Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09D8779587
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbjHKRBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236208AbjHKRBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:01:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB52C30CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:01:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61BBA645D4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 17:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30619C433BA;
        Fri, 11 Aug 2023 17:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691773270;
        bh=TVovZjwyix5rQdhW8ECdApx6w3lNWl+b+lPUjWG+UIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A4PolbeRtyjUDFVWk+7yFw7BYAFBwaI4HrMy6fwJNiTWTirl79pOSGigmrem5nhhh
         N2kc0CnhxTT5A+ddzcDvVN90XSyvLjVp0XdycOwkMO8WHTqGcOEiGtE2vjixmyjkdj
         v02fmOiWR09SWyMYyW6mksAtAZp31nh1M4vDoJFTAjK/GgO/J2+97rgUMnRuScK1f3
         Ye0JvYUa80GerYbElkN0TchAmUmsvacjyoGg1nNFhmLQkFrem36wwm6EeE0lTzooOu
         CBm6UAIJXt3rHZnpoPtTrd35G1eB8egqnGgoK0bSYg+ujZiEX9AdpP1Tb+wcKGEFZn
         yulqZnvlHCM5w==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 07/10] cpuidle: Remove unnecessary current_clr_polling() on poll_idle()
Date:   Fri, 11 Aug 2023 19:00:46 +0200
Message-Id: <20230811170049.308866-8-frederic@kernel.org>
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

There is no point in clearing TIF_NR_POLLING and folding TIF_NEED_RESCHED
upon poll_idle() exit because cpuidle_idle_call() is going to set again
TIF_NR_POLLING anyway. Also if TIF_NEED_RESCHED is set, it will be
folded and TIF_NR_POLLING will be cleared at the end of do_idle().

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 drivers/cpuidle/poll_state.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
index 009f46f121ae..44a656464d06 100644
--- a/drivers/cpuidle/poll_state.c
+++ b/drivers/cpuidle/poll_state.c
@@ -48,8 +48,6 @@ static int __cpuidle poll_idle(struct cpuidle_device *dev,
 	}
 	raw_local_irq_disable();
 
-	current_clr_polling();
-
 	return index;
 }
 
-- 
2.34.1

