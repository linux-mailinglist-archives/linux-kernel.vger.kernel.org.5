Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F0E77A255
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 22:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjHLUGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 16:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbjHLUGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 16:06:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D0A170C
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 13:06:23 -0700 (PDT)
Message-ID: <20230812195729.512632124@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691870369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ad2nYm8qlvD7vUCrpLZZfynt58mvDeIySR0Zislle5k=;
        b=H/8c1sqo/pB7GrLVFZYNapjMORyLh3Ddt07Y3godhlLNGr/xRMkZu7loqb2mn0VdYjnK0W
        mw3cg8Wo4pnKKnWmHh7bTJug1sMl92v22mb09Fi3rc9ETOjVkY8TC19pg1+VG3wNNFhnFP
        QA/C7NX2GkMJLJH7B/XpDSdL482fa1gfxqXiItsu0VCsUv740BT7QEZwrTQFfidn24tA7J
        r3K8VpYRCdt6h0wIbbEoLqOZ2kZiQBZbRxpVLn3+1uVnMta9sB1bt5Ju+Wy5GMTIlFXlQD
        zpfHdBT3PERL8fgGQvZWytHALtk8qaXwz4qQAG/xOy/ocLKKDOUfafx2LVvEHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691870369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ad2nYm8qlvD7vUCrpLZZfynt58mvDeIySR0Zislle5k=;
        b=a23JQp9H80BMWWvd6gaOQ7bMea4kRZ2gC7x7OCmSetUPGxWsZ9LYj68kUqlmIR48N1eyZU
        7srT2AzDJCOlmqAw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V2 34/37] x86/apic: Provide apic_force_nmi_on_cpu()
References: <20230812194003.682298127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 12 Aug 2023 21:59:29 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

When SMT siblings are soft-offlined and parked in one of the play_dead()
variants they still react on NMI, which is problematic on affected Intel
CPUs. The default play_dead() variant uses MWAIT on modern CPUs, which is
not guaranteed to be safe when updated concurrently.

Right now late loading is prevented when not all SMT siblings are online,
but as they still react on NMI, it is possible to bring them out of their
park position into a trivial rendevouz handler.

Provide a function which allows to do that. I does sanity checks whether
the target is in the cpus_booted_once_mask and whether the APIC driver
supports it.

Mark X2APIC and XAPIC as capable, but exclude 32bit and the UV and NUMACHIP
variants as that needs feedback from the relevant experts.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/include/asm/apic.h           |    5 +++++
 arch/x86/kernel/apic/apic_flat_64.c   |    2 ++
 arch/x86/kernel/apic/ipi.c            |    9 ++++++++-
 arch/x86/kernel/apic/x2apic_cluster.c |    1 +
 arch/x86/kernel/apic/x2apic_phys.c    |    1 +
 5 files changed, 17 insertions(+), 1 deletion(-)
---
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -301,6 +301,9 @@ struct apic {
 	enum apic_delivery_modes delivery_mode;
 	bool	dest_mode_logical;
 
+	/* Allows to send an NMI to an "offline" CPU which hangs in *play_dead() */
+	bool	nmi_to_offline_cpu;
+
 	u32	(*calc_dest_apicid)(unsigned int cpu);
 
 	/* ICR related functions */
@@ -505,6 +508,8 @@ extern void default_ioapic_phys_id_map(p
 extern int default_cpu_present_to_apicid(int mps_cpu);
 extern int default_check_phys_apicid_present(int phys_apicid);
 
+void apic_send_nmi_to_offline_cpu(unsigned int cpu);
+
 #endif /* CONFIG_X86_LOCAL_APIC */
 
 #ifdef CONFIG_SMP
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -138,6 +138,7 @@ static struct apic apic_flat __ro_after_
 	.send_IPI_allbutself		= default_send_IPI_allbutself,
 	.send_IPI_all			= default_send_IPI_all,
 	.send_IPI_self			= default_send_IPI_self,
+	.nmi_to_offline_cpu		= true,
 
 	.inquire_remote_apic		= default_inquire_remote_apic,
 
@@ -229,6 +230,7 @@ static struct apic apic_physflat __ro_af
 	.send_IPI_allbutself		= default_send_IPI_allbutself,
 	.send_IPI_all			= default_send_IPI_all,
 	.send_IPI_self			= default_send_IPI_self,
+	.nmi_to_offline_cpu		= true,
 
 	.inquire_remote_apic		= default_inquire_remote_apic,
 
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -95,8 +95,15 @@ void native_send_call_func_ipi(const str
 	apic->send_IPI_mask(mask, CALL_FUNCTION_VECTOR);
 }
 
+void apic_send_nmi_to_offline_cpu(unsigned int cpu)
+{
+	if (WARN_ON_ONCE(!apic->nmi_to_offline_cpu))
+		return;
+	if (WARN_ON_ONCE(!cpumask_test_cpu(cpu, &cpus_booted_once_mask)))
+		return;
+	apic->send_IPI(cpu, NMI_VECTOR);
+}
 #endif /* CONFIG_SMP */
-
 static inline int __prepare_ICR2(unsigned int mask)
 {
 	return SET_XAPIC_DEST_FIELD(mask);
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -264,6 +264,7 @@ static struct apic apic_x2apic_cluster _
 	.send_IPI_allbutself		= x2apic_send_IPI_allbutself,
 	.send_IPI_all			= x2apic_send_IPI_all,
 	.send_IPI_self			= x2apic_send_IPI_self,
+	.nmi_to_offline_cpu		= true,
 
 	.inquire_remote_apic		= NULL,
 
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -188,6 +188,7 @@ static struct apic apic_x2apic_phys __ro
 	.send_IPI_allbutself		= x2apic_send_IPI_allbutself,
 	.send_IPI_all			= x2apic_send_IPI_all,
 	.send_IPI_self			= x2apic_send_IPI_self,
+	.nmi_to_offline_cpu		= true,
 
 	.inquire_remote_apic		= NULL,
 

