Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB26769AC3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjGaP13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjGaP10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:27:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46FE1706;
        Mon, 31 Jul 2023 08:27:24 -0700 (PDT)
Date:   Mon, 31 Jul 2023 15:27:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690817242;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZkZOxfb5DjcupVWqTwMGJ6YsU7wMnmDh4F1M/WLCvtk=;
        b=UiwOvHjInWr2o3oe3nA/IpWDXkkXL1nMpF/chRb8RRCyC/6QHdut7ZGWl/D5ARz/TUCQ8b
        JXyh5NkzyQnX4PWPBzleizsaBFzSPsMVN64IfjdLrZE7+yfchU9PXBOwr/AN7a5eJykANR
        4tzkzjX/Iggxg9IO6WERyvh9grIZdpRHzBM38CtkDZP+zXIliRqr2BpqF7Y+3Y6uYQf5g3
        i1J49xh2TOAX5wf98HiFUKLf4GTpeQniJopXmF8ru1zGi1KjQRNoxSk7sKt+YRUFoK+dLT
        lIqxoXYATwEobZGldwpc9XFLStOi6/3Rwr2GlLzOe84SdEoHSYrlxKUrq9Nxvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690817242;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZkZOxfb5DjcupVWqTwMGJ6YsU7wMnmDh4F1M/WLCvtk=;
        b=vgdiVi7ScT+o8xdyk+5Bl0Z5MSaWJtUGmIL99wsGVldB1z2smn5bjT4mTuzIC1zykP1QbG
        IO1CrHSp/bSQ+tBg==
From:   "tip-bot2 for Vincent Whitchurch" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Prevent nested thread vs
 synchronize_hardirq() deadlock
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20230613-genirq-nested-v3-1-ae58221143eb@axis.com>
References: <20230613-genirq-nested-v3-1-ae58221143eb@axis.com>
MIME-Version: 1.0
Message-ID: <169081724175.28540.15276914612023519757.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     e2c12739ccf76aae12e9e949526a475b9d17adaa
Gitweb:        https://git.kernel.org/tip/e2c12739ccf76aae12e9e949526a475b9d17adaa
Author:        Vincent Whitchurch <vincent.whitchurch@axis.com>
AuthorDate:    Thu, 06 Jul 2023 16:22:25 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 31 Jul 2023 17:24:22 +02:00

genirq: Prevent nested thread vs synchronize_hardirq() deadlock

There is a possibility of deadlock if synchronize_hardirq() is called
when the nested threaded interrupt is active.  The following scenario
was observed on a uniprocessor PREEMPT_NONE system:

 Thread 1                      Thread 2

 handle_nested_thread()
  Set INPROGRESS
  Call ->thread_fn()
   thread_fn goes to sleep

                              free_irq()
                               __synchronize_hardirq()
                                Busy-loop forever waiting for INPROGRESS
                                to be cleared

The INPROGRESS flag is only supposed to be used for hard interrupt
handlers.  Remove the incorrect usage in the nested threaded interrupt
case and instead re-use the threads_active / wait_for_threads mechanism
to wait for nested threaded interrupts to complete.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230613-genirq-nested-v3-1-ae58221143eb@axis.com

---
 kernel/irq/chip.c      | 11 ++++-------
 kernel/irq/internals.h |  2 ++
 kernel/irq/manage.c    | 26 ++++++++++++++------------
 3 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index ee8c0ac..dc94e0b 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -473,11 +473,12 @@ void handle_nested_irq(unsigned int irq)
 	action = desc->action;
 	if (unlikely(!action || irqd_irq_disabled(&desc->irq_data))) {
 		desc->istate |= IRQS_PENDING;
-		goto out_unlock;
+		raw_spin_unlock_irq(&desc->lock);
+		return;
 	}
 
 	kstat_incr_irqs_this_cpu(desc);
-	irqd_set(&desc->irq_data, IRQD_IRQ_INPROGRESS);
+	atomic_inc(&desc->threads_active);
 	raw_spin_unlock_irq(&desc->lock);
 
 	action_ret = IRQ_NONE;
@@ -487,11 +488,7 @@ void handle_nested_irq(unsigned int irq)
 	if (!irq_settings_no_debug(desc))
 		note_interrupt(desc, action_ret);
 
-	raw_spin_lock_irq(&desc->lock);
-	irqd_clear(&desc->irq_data, IRQD_IRQ_INPROGRESS);
-
-out_unlock:
-	raw_spin_unlock_irq(&desc->lock);
+	wake_threads_waitq(desc);
 }
 EXPORT_SYMBOL_GPL(handle_nested_irq);
 
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index bdd35bb..831f383 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -121,6 +121,8 @@ void irq_resend_init(struct irq_desc *desc);
 bool irq_wait_for_poll(struct irq_desc *desc);
 void __irq_wake_thread(struct irq_desc *desc, struct irqaction *action);
 
+void wake_threads_waitq(struct irq_desc *desc);
+
 #ifdef CONFIG_PROC_FS
 extern void register_irq_proc(unsigned int irq, struct irq_desc *desc);
 extern void unregister_irq_proc(unsigned int irq, struct irq_desc *desc);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index d2742af..d309ba8 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -108,6 +108,16 @@ bool synchronize_hardirq(unsigned int irq)
 }
 EXPORT_SYMBOL(synchronize_hardirq);
 
+static void __synchronize_irq(struct irq_desc *desc)
+{
+	__synchronize_hardirq(desc, true);
+	/*
+	 * We made sure that no hardirq handler is running. Now verify that no
+	 * threaded handlers are active.
+	 */
+	wait_event(desc->wait_for_threads, !atomic_read(&desc->threads_active));
+}
+
 /**
  *	synchronize_irq - wait for pending IRQ handlers (on other CPUs)
  *	@irq: interrupt number to wait for
@@ -127,16 +137,8 @@ void synchronize_irq(unsigned int irq)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
 
-	if (desc) {
-		__synchronize_hardirq(desc, true);
-		/*
-		 * We made sure that no hardirq handler is
-		 * running. Now verify that no threaded handlers are
-		 * active.
-		 */
-		wait_event(desc->wait_for_threads,
-			   !atomic_read(&desc->threads_active));
-	}
+	if (desc)
+		__synchronize_irq(desc);
 }
 EXPORT_SYMBOL(synchronize_irq);
 
@@ -1216,7 +1218,7 @@ static irqreturn_t irq_thread_fn(struct irq_desc *desc,
 	return ret;
 }
 
-static void wake_threads_waitq(struct irq_desc *desc)
+void wake_threads_waitq(struct irq_desc *desc)
 {
 	if (atomic_dec_and_test(&desc->threads_active))
 		wake_up(&desc->wait_for_threads);
@@ -1944,7 +1946,7 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 	 * supports it also make sure that there is no (not yet serviced)
 	 * interrupt in flight at the hardware level.
 	 */
-	__synchronize_hardirq(desc, true);
+	__synchronize_irq(desc);
 
 #ifdef CONFIG_DEBUG_SHIRQ
 	/*
