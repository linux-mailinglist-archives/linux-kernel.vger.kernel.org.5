Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BA576B5B7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbjHANY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbjHANYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:24:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5EE198D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 06:24:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CD1661594
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 13:24:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFEDC433CA;
        Tue,  1 Aug 2023 13:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690896292;
        bh=vb0eW648+k9SO6deOUTYMYcSVwD0/SVM0GpxXUYmFVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DivxzMVQpdG0eYF91RGmaydcwUI6rJqX/Eh1Q2gJdYvQasfpLmBSaExyfOVmDFC/b
         vTywotqFfXyX6HJyrvhKIrH95pEym5ZDYyujswn+zCZqtV5e726DqIs13NQuU9VAOK
         RYjntqOs3CqvUP6yDz2oFWbAXSIXBZxtmFyYBo0rzMJVA+o5KikYNYm7fiqfIiU6sG
         Nai3Tmk+XjdQzGejIVIu6VA3m/Yw1Q0IcKgWx7LW8Ncm9xcaUY5LtB5jZnzpk9h30q
         ruMyRtUdRgRV0vDp2UaVRvcO67ZkPCdSnxa1CZJ24yPF9vupAlpCkmmqa6zDmX991f
         yw3xq1ru+dgBQ==
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
Subject: [RFC PATCH 2/6] softirq: Make softirq handling entry/exit generally available
Date:   Tue,  1 Aug 2023 15:24:37 +0200
Message-Id: <20230801132441.559222-3-frederic@kernel.org>
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

In order to prepare for re-enabling softirqs from vector callbacks that
are known safe, make the code incrementing the preempt count while
servicing softirqs more generally available.

No intended behaviour change.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/bottom_half.h |  7 +++++++
 kernel/softirq.c            | 22 ++++++++++++++++------
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
index fc53e0ad56d9..2243c7de4917 100644
--- a/include/linux/bottom_half.h
+++ b/include/linux/bottom_half.h
@@ -33,6 +33,13 @@ static inline void local_bh_enable(void)
 	__local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
 }
 
+static inline void local_bh_enter(void)
+{
+	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
+}
+
+extern void local_bh_exit(void);
+
 #ifdef CONFIG_PREEMPT_RT
 extern bool local_bh_blocked(void);
 #else
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 1a3c3fe341ea..ba998d572ef4 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -247,21 +247,26 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 }
 EXPORT_SYMBOL(__local_bh_enable_ip);
 
+inline void local_bh_exit(void)
+{
+	__local_bh_enable(SOFTIRQ_OFFSET, true);
+	WARN_ON_ONCE(in_interrupt());
+}
+
 /*
  * Invoked from ksoftirqd_run() outside of the interrupt disabled section
  * to acquire the per CPU local lock for reentrancy protection.
  */
 static inline void ksoftirqd_run_begin(void)
 {
-	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
+	local_bh_enter();
 	local_irq_disable();
 }
 
 /* Counterpart to ksoftirqd_run_begin() */
 static inline void ksoftirqd_run_end(void)
 {
-	__local_bh_enable(SOFTIRQ_OFFSET, true);
-	WARN_ON_ONCE(in_interrupt());
+	local_bh_exit();
 	local_irq_enable();
 }
 
@@ -389,15 +394,20 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 }
 EXPORT_SYMBOL(__local_bh_enable_ip);
 
+inline void local_bh_exit(void)
+{
+	__local_bh_enable(SOFTIRQ_OFFSET);
+	WARN_ON_ONCE(in_interrupt());
+}
+
 static inline void softirq_handle_begin(void)
 {
-	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
+	local_bh_enter();
 }
 
 static inline void softirq_handle_end(void)
 {
-	__local_bh_enable(SOFTIRQ_OFFSET);
-	WARN_ON_ONCE(in_interrupt());
+	local_bh_exit();
 }
 
 static inline void ksoftirqd_run_begin(void)
-- 
2.34.1

