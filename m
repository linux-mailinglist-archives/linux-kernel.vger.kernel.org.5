Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8EE76B5BD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbjHANZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbjHANZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:25:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36825269F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 06:25:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1624615A3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 13:25:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509D6C433C8;
        Tue,  1 Aug 2023 13:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690896302;
        bh=rciJFUiyVsvhXbHYtyfujY9ldyQ8u3jv3Unlkm5oJ8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lnp7XiqARKpzKndW55oU0pFk++KVe7qMUYvK5aKtl891T2uF5+HHyVOFY++Pfj7cb
         9hIF71vVnTxKoWv8urpMEhOPN9X+JwnUUTcJ0iKi2dnt6OrQecFIZq/jtkqDOHeIRx
         0B6hJ1R3KNBOfN8wHxkzYjsgIXm2rGyxDV2qS5hr6qHZ6cn+mg7ijE4vbVyFziZpGJ
         63bdbmru35c+St1REUh6OG8y0Z4iaOlXWpJvmsgypEio81WHULIM+b0B8qX94ygl7H
         2ekN/heycVbwDUdNup6qsP/UYHcyO3HEwuovJ3oE71r8F4iINoP3dB1axgSedSDqPd
         usHOdgqfR2MhA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Eric Dumazet <edumazet@google.com>
Subject: [RFC PATCH 6/6] timers: Make process_timeout() soft-interruptible
Date:   Tue,  1 Aug 2023 15:24:41 +0200
Message-Id: <20230801132441.559222-7-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801132441.559222-1-frederic@kernel.org>
References: <20230801132441.559222-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The most frequent timer can be safely interrupted by other vectors as
it's only performing a wake-up.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 1e43f54def0e..0f6eb9c0901c 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2180,7 +2180,7 @@ signed long __sched schedule_timeout(signed long timeout)
 	expire = timeout + jiffies;
 
 	timer.task = current;
-	timer_setup_on_stack(&timer.timer, process_timeout, 0);
+	timer_setup_on_stack(&timer.timer, process_timeout, TIMER_SOFTINTERRUPTIBLE);
 	__mod_timer(&timer.timer, expire, MOD_TIMER_NOTPENDING);
 	schedule();
 	del_timer_sync(&timer.timer);
-- 
2.34.1

