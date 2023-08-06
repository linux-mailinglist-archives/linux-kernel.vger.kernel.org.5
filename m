Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3427714FD
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 14:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjHFMVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 08:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjHFMVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 08:21:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BD283;
        Sun,  6 Aug 2023 05:21:47 -0700 (PDT)
Date:   Sun, 06 Aug 2023 12:21:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691324505;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ToytmPHGrdr6MEQ8DeXVmboKkkPvmPMHlBxSOk4Fqts=;
        b=R1S2xtF97WI4Kbo1X/y+rvC7J6f0vMUWwHI4elowayWvDcUeWnSp2Cqd/3LEPKwT69BNyR
        XzG2aBKVnIQQvO5gnx9zG/2Urg+XHFUaC2KdT16oIP7JzTltsHMawNSVlaonjtC0rOKp+j
        usd8r9LD6GuJoo5WLPRtem2xn/smOL3ILrVS5SqPzjBYua3rA0U13VNfstf0n1UdhrupLZ
        ZDzKSHyJ/oQt0AbyCBuVgvNCyqkT5ufHPzB8vp0pBIytpFXvCbC69KN73juPeM1zrCZH+y
        VIWsZ8nvuObJzUxfEaqbWtP+2ScHjQgaf4MdIpexpGUEjC4WhigTqihRDNJSdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691324505;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ToytmPHGrdr6MEQ8DeXVmboKkkPvmPMHlBxSOk4Fqts=;
        b=tgElNcTrxs3e8o/sFysyB/YTuo0MUAbtmD0WEdGejqPojyliLfgFcpmD1LOkpvnCgVNoJf
        vNWA8inuYe46SGDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/vector: Replace IRQ_MOVE_CLEANUP_VECTOR with a
 timer callback
Cc:     Thomas Gleixner <tglx@linutronix.de>, Xin Li <xin3.li@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230621171248.6805-3-xin3.li@intel.com>
References: <20230621171248.6805-3-xin3.li@intel.com>
MIME-Version: 1.0
Message-ID: <169132450485.28540.1939208173197254758.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     bdc1dad299bb1d38ce329de0dad0beadc76badf4
Gitweb:        https://git.kernel.org/tip/bdc1dad299bb1d38ce329de0dad0beadc76badf4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 21 Jun 2023 10:12:47 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 06 Aug 2023 14:15:10 +02:00

x86/vector: Replace IRQ_MOVE_CLEANUP_VECTOR with a timer callback

The left overs of a moved interrupt are cleaned up once the interrupt is
raised on the new target CPU. Keeping the vector valid on the original
target CPU guarantees that there can't be an interrupt lost if the affinity
change races with an concurrent interrupt from the device.

This cleanup utilizes the lowest priority interrupt vector for this
cleanup, which makes sure that in the unlikely case when the to be cleaned
up interrupt is pending in the local APICs IRR the cleanup vector does not
live lock.

But there is no real reason to use an interrupt vector for cleaning up the
leftovers of a moved interrupt. It's not a high performance operation. The
only requirement is that it happens on the original target CPU.

Convert it to use a timer instead and adjust the code accordingly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230621171248.6805-3-xin3.li@intel.com

---
 arch/x86/include/asm/idtentry.h    |  1 +-
 arch/x86/include/asm/irq_vectors.h |  7 +--
 arch/x86/kernel/apic/vector.c      | 98 +++++++++++++++++++++++------
 arch/x86/kernel/idt.c              |  1 +-
 4 files changed, 78 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index b241af4..cd5c10a 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -648,7 +648,6 @@ DECLARE_IDTENTRY_SYSVEC(X86_PLATFORM_IPI_VECTOR,	sysvec_x86_platform_ipi);
 
 #ifdef CONFIG_SMP
 DECLARE_IDTENTRY(RESCHEDULE_VECTOR,			sysvec_reschedule_ipi);
-DECLARE_IDTENTRY_SYSVEC(IRQ_MOVE_CLEANUP_VECTOR,	sysvec_irq_move_cleanup);
 DECLARE_IDTENTRY_SYSVEC(REBOOT_VECTOR,			sysvec_reboot);
 DECLARE_IDTENTRY_SYSVEC(CALL_FUNCTION_SINGLE_VECTOR,	sysvec_call_function_single);
 DECLARE_IDTENTRY_SYSVEC(CALL_FUNCTION_VECTOR,		sysvec_call_function);
diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
index 43dcb92..3a19904 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -35,13 +35,6 @@
  */
 #define FIRST_EXTERNAL_VECTOR		0x20
 
-/*
- * Reserve the lowest usable vector (and hence lowest priority)  0x20 for
- * triggering cleanup after irq migration. 0x21-0x2f will still be used
- * for device interrupts.
- */
-#define IRQ_MOVE_CLEANUP_VECTOR		FIRST_EXTERNAL_VECTOR
-
 #define IA32_SYSCALL_VECTOR		0x80
 
 /*
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index aa370bd..01c359a 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -44,7 +44,18 @@ static cpumask_var_t vector_searchmask;
 static struct irq_chip lapic_controller;
 static struct irq_matrix *vector_matrix;
 #ifdef CONFIG_SMP
-static DEFINE_PER_CPU(struct hlist_head, cleanup_list);
+
+static void vector_cleanup_callback(struct timer_list *tmr);
+
+struct vector_cleanup {
+	struct hlist_head	head;
+	struct timer_list	timer;
+};
+
+static DEFINE_PER_CPU(struct vector_cleanup, vector_cleanup) = {
+	.head	= HLIST_HEAD_INIT,
+	.timer	= __TIMER_INITIALIZER(vector_cleanup_callback, TIMER_PINNED),
+};
 #endif
 
 void lock_vector_lock(void)
@@ -841,10 +852,21 @@ void lapic_online(void)
 		this_cpu_write(vector_irq[vector], __setup_vector_irq(vector));
 }
 
+static void __vector_cleanup(struct vector_cleanup *cl, bool check_irr);
+
 void lapic_offline(void)
 {
+	struct vector_cleanup *cl = this_cpu_ptr(&vector_cleanup);
+
 	lock_vector_lock();
+
+	/* In case the vector cleanup timer has not expired */
+	__vector_cleanup(cl, false);
+
 	irq_matrix_offline(vector_matrix);
+	WARN_ON_ONCE(try_to_del_timer_sync(&cl->timer) < 0);
+	WARN_ON_ONCE(!hlist_empty(&cl->head));
+
 	unlock_vector_lock();
 }
 
@@ -934,49 +956,85 @@ static void free_moved_vector(struct apic_chip_data *apicd)
 	apicd->move_in_progress = 0;
 }
 
-DEFINE_IDTENTRY_SYSVEC(sysvec_irq_move_cleanup)
+static void __vector_cleanup(struct vector_cleanup *cl, bool check_irr)
 {
-	struct hlist_head *clhead = this_cpu_ptr(&cleanup_list);
 	struct apic_chip_data *apicd;
 	struct hlist_node *tmp;
+	bool rearm = false;
 
-	ack_APIC_irq();
-	/* Prevent vectors vanishing under us */
-	raw_spin_lock(&vector_lock);
+	lockdep_assert_held(&vector_lock);
 
-	hlist_for_each_entry_safe(apicd, tmp, clhead, clist) {
+	hlist_for_each_entry_safe(apicd, tmp, &cl->head, clist) {
 		unsigned int irr, vector = apicd->prev_vector;
 
 		/*
 		 * Paranoia: Check if the vector that needs to be cleaned
-		 * up is registered at the APICs IRR. If so, then this is
-		 * not the best time to clean it up. Clean it up in the
-		 * next attempt by sending another IRQ_MOVE_CLEANUP_VECTOR
-		 * to this CPU. IRQ_MOVE_CLEANUP_VECTOR is the lowest
-		 * priority external vector, so on return from this
-		 * interrupt the device interrupt will happen first.
+		 * up is registered at the APICs IRR. That's clearly a
+		 * hardware issue if the vector arrived on the old target
+		 * _after_ interrupts were disabled above. Keep @apicd
+		 * on the list and schedule the timer again to give the CPU
+		 * a chance to handle the pending interrupt.
+		 *
+		 * Do not check IRR when called from lapic_offline(), because
+		 * fixup_irqs() was just called to scan IRR for set bits and
+		 * forward them to new destination CPUs via IPIs.
 		 */
-		irr = apic_read(APIC_IRR + (vector / 32 * 0x10));
+		irr = check_irr ? apic_read(APIC_IRR + (vector / 32 * 0x10)) : 0;
 		if (irr & (1U << (vector % 32))) {
-			apic->send_IPI_self(IRQ_MOVE_CLEANUP_VECTOR);
+			pr_warn_once("Moved interrupt pending in old target APIC %u\n", apicd->irq);
+			rearm = true;
 			continue;
 		}
 		free_moved_vector(apicd);
 	}
 
-	raw_spin_unlock(&vector_lock);
+	/*
+	 * Must happen under vector_lock to make the timer_pending() check
+	 * in __vector_schedule_cleanup() race free against the rearm here.
+	 */
+	if (rearm)
+		mod_timer(&cl->timer, jiffies + 1);
+}
+
+static void vector_cleanup_callback(struct timer_list *tmr)
+{
+	struct vector_cleanup *cl = container_of(tmr, typeof(*cl), timer);
+
+	/* Prevent vectors vanishing under us */
+	raw_spin_lock_irq(&vector_lock);
+	__vector_cleanup(cl, true);
+	raw_spin_unlock_irq(&vector_lock);
 }
 
 static void __vector_schedule_cleanup(struct apic_chip_data *apicd)
 {
-	unsigned int cpu;
+	unsigned int cpu = apicd->prev_cpu;
 
 	raw_spin_lock(&vector_lock);
 	apicd->move_in_progress = 0;
-	cpu = apicd->prev_cpu;
 	if (cpu_online(cpu)) {
-		hlist_add_head(&apicd->clist, per_cpu_ptr(&cleanup_list, cpu));
-		apic->send_IPI(cpu, IRQ_MOVE_CLEANUP_VECTOR);
+		struct vector_cleanup *cl = per_cpu_ptr(&vector_cleanup, cpu);
+
+		hlist_add_head(&apicd->clist, &cl->head);
+
+		/*
+		 * The lockless timer_pending() check is safe here. If it
+		 * returns true, then the callback will observe this new
+		 * apic data in the hlist as everything is serialized by
+		 * vector lock.
+		 *
+		 * If it returns false then the timer is either not armed
+		 * or the other CPU executes the callback, which again
+		 * would be blocked on vector lock. Rearming it in the
+		 * latter case makes it fire for nothing.
+		 *
+		 * This is also safe against the callback rearming the timer
+		 * because that's serialized via vector lock too.
+		 */
+		if (!timer_pending(&cl->timer)) {
+			cl->timer.expires = jiffies + 1;
+			add_timer_on(&cl->timer, cpu);
+		}
 	} else {
 		apicd->prev_vector = 0;
 	}
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index a58c6bc..f395826 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -131,7 +131,6 @@ static const __initconst struct idt_data apic_idts[] = {
 	INTG(RESCHEDULE_VECTOR,			asm_sysvec_reschedule_ipi),
 	INTG(CALL_FUNCTION_VECTOR,		asm_sysvec_call_function),
 	INTG(CALL_FUNCTION_SINGLE_VECTOR,	asm_sysvec_call_function_single),
-	INTG(IRQ_MOVE_CLEANUP_VECTOR,		asm_sysvec_irq_move_cleanup),
 	INTG(REBOOT_VECTOR,			asm_sysvec_reboot),
 #endif
 
