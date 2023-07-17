Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D28757062
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjGQXQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjGQXQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:16:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A999172E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:15:45 -0700 (PDT)
Message-ID: <20230717223224.328307760@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=RDUEJbQ4kWbt2l91v1HLuRRyZwh425n2zPuDH8hhE+w=;
        b=EQ3Rk00rf3sVU10BxtvPZV6/6BI2sAMv0ynyJSJy/ZQqfJYlDchem0giciNwE4fkR0LiIU
        h1IWUm6bDWXUkjLh1icTpmQ5rJJvKR7tAlFBevC2C0nqVCbLd2/plc2gTMEHgFsjAnvZ4T
        c9ZW65DamhpU+j+AZIWXIsxO0foCDrdsmYLzDPgcyh3W/D1ORWz57jXWCezRQDo10GA6M2
        iia08BiH8QBiQpMKoydcAT9mJCPnmD0mTJ0aKDXdP/XfefJKD+iHmLx/oP56X5dOzdIDkv
        ASzgwR1C6ZYyKc+i/AoLJkOKFrQN8ZHNgMlxXc+T+iI9cw7811WPUOwSKdAHdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=RDUEJbQ4kWbt2l91v1HLuRRyZwh425n2zPuDH8hhE+w=;
        b=M59EGHjAOsvIzjUf7LmE/wgADhnqezVIlDcvVLUqSDmSgmyL4ug52kJfOBduHpim92br9C
        RLEqt6oxqAP+h7DQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 21/58] x86/apic/32: Remove x86_cpu_to_logical_apicid
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:15:07 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 arch/x86/include/asm/smp.h     |    3 ---
 arch/x86/kernel/apic/apic.c    |   31 -------------------------------
 arch/x86/kernel/apic/ipi.c     |   36 +++++++++---------------------------
 arch/x86/kernel/setup_percpu.c |    7 -------
 4 files changed, 9 insertions(+), 68 deletions(-)

--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -22,9 +22,6 @@ DECLARE_PER_CPU_READ_MOSTLY(u16, cpu_l2c
 
 DECLARE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_cpu_to_apicid);
 DECLARE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_acpiid);
-#if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86_32)
-DECLARE_EARLY_PER_CPU_READ_MOSTLY(int, x86_cpu_to_logical_apicid);
-#endif
 
 struct task_struct;
 
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -113,15 +113,6 @@ EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_a
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
@@ -2433,10 +2406,6 @@ static void cpu_update_apic(int cpu, int
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

