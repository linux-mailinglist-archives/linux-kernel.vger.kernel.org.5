Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2425776836
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjHITNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbjHITMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:12:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15B4272B;
        Wed,  9 Aug 2023 12:12:26 -0700 (PDT)
Date:   Wed, 09 Aug 2023 19:12:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691608341;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=WxRoM4gtGS38corwnXV+fKzv9TspAszFMMcn85hmThI=;
        b=fUb805uvC7SVBmr5/qEkMjS+YhvXI6r2Tu7YdsmlpK2DuffN0/kdPiNqbEAyZufq03qArP
        k5kCHFBvRKki0pDPu9p2sBq6o6wr9QRjZ9g4T1cy6s0f191nGK997/8FdZ6bMeE/1ROSjq
        R5z7RqhIo9ExPKIFB2NSvwMmzJJed/Ln62sbSu5ZnbxXTOJVFJia9UE4Dypyu8RVO5mRty
        WDW/HW4yOB3ngs2/2jdfJnT9RkPKOLQoTtuULkVUxt6yFkqu11sxry+mfm+hbA/p1w6TcJ
        BfU8wb4IrXJaW3+eQnWhr1NSU5OiXSbEVtZo1Dti8/pZahJWYw14w1Hwsv+vYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691608341;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=WxRoM4gtGS38corwnXV+fKzv9TspAszFMMcn85hmThI=;
        b=pw1NP3Sp2Xutr+GYR+aDIPaYBblRQuS4+UgUdzZQvBnkwHqGW3SJo3Wo2Yba6EBwSNmav6
        YXTFzBmh93G5odCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic/32: Remove x86_cpu_to_logical_apicid
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169160834121.27769.5674155288403974899.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     f2bb0b4f150595e53aad09201be33d474ed6f4b7
Gitweb:        https://git.kernel.org/tip/f2bb0b4f150595e53aad09201be33d474ed6f4b7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:03:53 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:23 -07:00

x86/apic/32: Remove x86_cpu_to_logical_apicid

This per CPU variable is just yet another form of voodoo programming. The
boot ordering is:

  per_cpu(x86_cpu_to_logical_apicid, cpu) = 1U << cpu;

  .....

  setup_apic()
     apic->init_apic_ldr()
       default_init_apic_ldr()
         apic_write(SET_APIC_LOGICAL_ID(1UL << smp_processor_id(), APIC_LDR);

     id = GET_APIC_LOGICAL_ID(apic_read(APIC_LDR);
     WARN_ON(id != per_cpu(x86_cpu_to_logical_apicid, cpu));
     per_cpu(x86_cpu_to_logical_apicid, cpu) = id;

So first write the default into LDR and then validate it against the same default
which was set up during early boot APIC enumeration.

Brilliant, isn't it?

The comment above the per CPU variable declaration describes it well:
'Let's keep it ugly for now.'

Remove the useless gunk and use '1U << cpu' consistently all over the place.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/include/asm/smp.h     |  3 +---
 arch/x86/kernel/apic/apic.c    | 31 +----------------------------
 arch/x86/kernel/apic/ipi.c     | 36 ++++++++-------------------------
 arch/x86/kernel/setup_percpu.c |  7 +------
 4 files changed, 9 insertions(+), 68 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 8d96d9a..8ece65b 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -22,9 +22,6 @@ DECLARE_PER_CPU_READ_MOSTLY(u16, cpu_l2c_id);
 
 DECLARE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_cpu_to_apicid);
 DECLARE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_acpiid);
-#if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86_32)
-DECLARE_EARLY_PER_CPU_READ_MOSTLY(int, x86_cpu_to_logical_apicid);
-#endif
 
 struct task_struct;
 
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 89f2a7e..224dff4 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -113,15 +113,6 @@ EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_apicid);
 EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_acpiid);
 
 #ifdef CONFIG_X86_32
-
-/*
- * On x86_32, the mapping between cpu and logical apicid may vary
- * depending on apic in use.  The following early percpu variable is
- * used for the mapping.  This is where the behaviors of x86_64 and 32
- * actually diverge.  Let's keep it ugly for now.
- */
-DEFINE_EARLY_PER_CPU_READ_MOSTLY(int, x86_cpu_to_logical_apicid, BAD_APICID);
-
 /* Local APIC was disabled by the BIOS and enabled by the kernel */
 static int enabled_via_apicbase __ro_after_init;
 
@@ -1589,24 +1580,6 @@ static void setup_local_APIC(void)
 	 */
 	apic->init_apic_ldr();
 
-#ifdef CONFIG_X86_32
-	if (apic->dest_mode_logical) {
-		int logical_apicid, ldr_apicid;
-
-		/*
-		 * APIC LDR is initialized.  If logical_apicid mapping was
-		 * initialized during get_smp_config(), make sure it matches
-		 * the actual value.
-		 */
-		logical_apicid = early_per_cpu(x86_cpu_to_logical_apicid, cpu);
-		ldr_apicid = GET_APIC_LOGICAL_ID(apic_read(APIC_LDR));
-		if (logical_apicid != BAD_APICID)
-			WARN_ON(logical_apicid != ldr_apicid);
-		/* Always use the value from LDR. */
-		early_per_cpu(x86_cpu_to_logical_apicid, cpu) = ldr_apicid;
-	}
-#endif
-
 	/*
 	 * Set Task Priority to 'accept all except vectors 0-31'.  An APIC
 	 * vector in the 16-31 range could be delivered if TPR == 0, but we
@@ -2434,10 +2407,6 @@ static void cpu_update_apic(int cpu, int apicid)
 #if defined(CONFIG_SMP) || defined(CONFIG_X86_64)
 	early_per_cpu(x86_cpu_to_apicid, cpu) = apicid;
 #endif
-#ifdef CONFIG_X86_32
-	if (cpu < 8)
-		early_per_cpu(x86_cpu_to_logical_apicid, cpu) = 1U << cpu;
-#endif
 	set_cpu_possible(cpu, true);
 	physid_set(apicid, phys_cpu_present_map);
 	set_cpu_present(cpu, true);
diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index 29273e0..aa51e16 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -243,50 +243,32 @@ void default_send_IPI_self(int vector)
 }
 
 #ifdef CONFIG_X86_32
-
-void default_send_IPI_mask_sequence_logical(const struct cpumask *mask,
-						 int vector)
+void default_send_IPI_mask_sequence_logical(const struct cpumask *mask, int vector)
 {
 	unsigned long flags;
-	unsigned int query_cpu;
-
-	/*
-	 * Hack. The clustered APIC addressing mode doesn't allow us to send
-	 * to an arbitrary mask, so I do a unicasts to each CPU instead. This
-	 * should be modified to do 1 message per cluster ID - mbligh
-	 */
+	unsigned int cpu;
 
 	local_irq_save(flags);
-	for_each_cpu(query_cpu, mask)
-		__default_send_IPI_dest_field(
-			early_per_cpu(x86_cpu_to_logical_apicid, query_cpu),
-			vector, APIC_DEST_LOGICAL);
+	for_each_cpu(cpu, mask)
+		__default_send_IPI_dest_field(1U << cpu, vector, APIC_DEST_LOGICAL);
 	local_irq_restore(flags);
 }
 
 void default_send_IPI_mask_allbutself_logical(const struct cpumask *mask,
 						 int vector)
 {
+	unsigned int cpu, this_cpu = smp_processor_id();
 	unsigned long flags;
-	unsigned int query_cpu;
-	unsigned int this_cpu = smp_processor_id();
-
-	/* See Hack comment above */
 
 	local_irq_save(flags);
-	for_each_cpu(query_cpu, mask) {
-		if (query_cpu == this_cpu)
+	for_each_cpu(cpu, mask) {
+		if (cpu == this_cpu)
 			continue;
-		__default_send_IPI_dest_field(
-			early_per_cpu(x86_cpu_to_logical_apicid, query_cpu),
-			vector, APIC_DEST_LOGICAL);
-		}
+		__default_send_IPI_dest_field(1U << cpu, vector, APIC_DEST_LOGICAL);
+	}
 	local_irq_restore(flags);
 }
 
-/*
- * This is only used on smaller machines.
- */
 void default_send_IPI_mask_logical(const struct cpumask *cpumask, int vector)
 {
 	unsigned long mask = cpumask_bits(cpumask)[0];
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index f6767d2..2c97bf7 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -184,10 +184,6 @@ void __init setup_per_cpu_areas(void)
 		per_cpu(x86_cpu_to_acpiid, cpu) =
 			early_per_cpu_map(x86_cpu_to_acpiid, cpu);
 #endif
-#ifdef CONFIG_X86_32
-		per_cpu(x86_cpu_to_logical_apicid, cpu) =
-			early_per_cpu_map(x86_cpu_to_logical_apicid, cpu);
-#endif
 #ifdef CONFIG_NUMA
 		per_cpu(x86_cpu_to_node_map, cpu) =
 			early_per_cpu_map(x86_cpu_to_node_map, cpu);
@@ -214,9 +210,6 @@ void __init setup_per_cpu_areas(void)
 	early_per_cpu_ptr(x86_cpu_to_apicid) = NULL;
 	early_per_cpu_ptr(x86_cpu_to_acpiid) = NULL;
 #endif
-#ifdef CONFIG_X86_32
-	early_per_cpu_ptr(x86_cpu_to_logical_apicid) = NULL;
-#endif
 #ifdef CONFIG_NUMA
 	early_per_cpu_ptr(x86_cpu_to_node_map) = NULL;
 #endif
