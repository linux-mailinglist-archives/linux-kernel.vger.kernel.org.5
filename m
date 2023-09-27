Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239507B0789
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjI0PB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjI0PBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:01:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5D1196;
        Wed, 27 Sep 2023 08:01:34 -0700 (PDT)
Date:   Wed, 27 Sep 2023 15:01:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695826892;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ZhjOmSStMre4n+1d7k4HxOZCTiNq9yelwWAhe5xHFM=;
        b=VksODYStvXKNho2lLF7tELW2L0FHJBbGSlP/9czDTTXsLak4fQ/9QpR71/T/8hRZbo5Vyk
        ISpBA0pJt8jcso+qVeStMv1RkxDmZotu7J5aygVwydcTslp0D7YZYfcT3YN8AmtLIYBfcR
        8kmez+zK3xXTSr7leYS+gV9SMPsugZ1CUwwjB5B8GWlB+CE/YnQrRPeUAfahdNZN1WxoWS
        YfnmR4U5hx8Xg9AZbemQ/Lx6j0InEoHvsbaQcpKblOh0pS7NJbtyOtXvhf906SOCJG/kfQ
        FjiEIeD33T97hOqnGAvZw6xsZI0F3mc8eUH6WvZexl4iiZGJM7hOGGN5VBw/pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695826892;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ZhjOmSStMre4n+1d7k4HxOZCTiNq9yelwWAhe5xHFM=;
        b=4ifXXgSQSnqb1Ezd+9cuijaif3i3PdydetiSXEXVNJpsbwZFFERwJ2WnA0gSAcQHB8F/Su
        1KTG02d/4zI9rLCw==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Tag (hr)timer softirq as hotplug safe
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        stable@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230912104406.312185-6-frederic@kernel.org>
References: <20230912104406.312185-6-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <169582689232.27769.17167363673386375890.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     1a6a464774947920dcedcf7409be62495c7cedd0
Gitweb:        https://git.kernel.org/tip/1a6a464774947920dcedcf7409be62495c7cedd0
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 12 Sep 2023 12:44:06 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 27 Sep 2023 16:54:03 +02:00

timers: Tag (hr)timer softirq as hotplug safe

Specific stress involving frequent CPU-hotplug operations, such as
running rcutorture for example, may trigger the following message:

  NOHZ tick-stop error: local softirq work is pending, handler #02!!!"

This happens in the CPU-down hotplug process, after
CPUHP_AP_SMPBOOT_THREADS whose teardown callback parks ksoftirqd, and
before the target CPU shuts down through CPUHP_AP_IDLE_DEAD. In this
fragile intermediate state, softirqs waiting for threaded handling may be
forever ignored and eventually reported by the idle task as in the above
example.

However some vectors are known to be safe as long as the corresponding
subsystems have teardown callbacks handling the migration of their
events. The above error message reports pending timers softirq although
this vector can be considered as hotplug safe because the
CPUHP_TIMERS_PREPARE teardown callback performs the necessary migration
of timers after the death of the CPU. Hrtimers also have a similar
hotplug handling.

Therefore this error message, as far as (hr-)timers are concerned, can
be considered spurious and the relevant softirq vectors can be marked as
hotplug safe.

Fixes: 0345691b24c0 ("tick/rcu: Stop allowing RCU_SOFTIRQ in idle")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230912104406.312185-6-frederic@kernel.org
---
 include/linux/interrupt.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index a92bce4..4a1dc88 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -569,8 +569,12 @@ enum
  * 	2) rcu_report_dead() reports the final quiescent states.
  *
  * _ IRQ_POLL: irq_poll_cpu_dead() migrates the queue
+ *
+ * _ (HR)TIMER_SOFTIRQ: (hr)timers_dead_cpu() migrates the queue
  */
-#define SOFTIRQ_HOTPLUG_SAFE_MASK (BIT(RCU_SOFTIRQ) | BIT(IRQ_POLL_SOFTIRQ))
+#define SOFTIRQ_HOTPLUG_SAFE_MASK (BIT(TIMER_SOFTIRQ) | BIT(IRQ_POLL_SOFTIRQ) |\
+				   BIT(HRTIMER_SOFTIRQ) | BIT(RCU_SOFTIRQ))
+
 
 /* map softirq index to softirq name. update 'softirq_to_name' in
  * kernel/softirq.c when adding a new softirq.
