Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49A879C924
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjILIBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbjILH7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:59:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9972735
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:58:28 -0700 (PDT)
Message-ID: <20230912065502.447323060@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694505507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=5EsTuHLRMt+mh9/+wwjfJDEI240zRMwQu4qtcC7nL1o=;
        b=JIweMxVumgLN2Jb9TYNX4i6lx3NVqn5j9hplEau6xHGzTKkg+WFNcyVH895L1WO9Gr/1+i
        icl8vj10fqY31MV0CjcfTOE5k360HfwWOtLcB/NWFttcWmEEfxfOnU041zsrlWql2DC0ix
        Y8GXH/+U02p7fCXbNWXOiWyqCw22faG2CTXLfz8Diw9xLeyXGeKwq1xrYgDQMTy4LzeR0S
        tDLVlAOsDRn/8COgxxpX/xySnZZ4N6MXzMKzirgZSm5kwA7kuaXDZYeY2J6GeuUpD2D+6A
        7b0cW/oofG4xVoTcbKidHjxIuPXOSR46dEl8JS77wT1MsVsC103GtuOgBWBPYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694505507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=5EsTuHLRMt+mh9/+wwjfJDEI240zRMwQu4qtcC7nL1o=;
        b=onPRJkE8jmhAVCNUauItBBIxPd3hEt/0KKcvmTt+3Fd5TSeUNrP5uxkLpaQhwhK5kqGQeU
        MOohhjhtM2pfGlBg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V3 27/30] x86/apic: Provide apic_force_nmi_on_cpu()
References: <20230912065249.695681286@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 12 Sep 2023 09:58:26 +0200 (CEST)
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
 arch/x86/include/asm/apic.h           |    5 ++++-
 arch/x86/kernel/apic/apic_flat_64.c   |    2 ++
 arch/x86/kernel/apic/ipi.c            |    8 ++++++++
 arch/x86/kernel/apic/x2apic_cluster.c |    1 +
 arch/x86/kernel/apic/x2apic_phys.c    |    1 +
 5 files changed, 16 insertions(+), 1 deletion(-)
---
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -276,7 +276,8 @@ struct apic {
 
 	u32	disable_esr		: 1,
 		dest_mode_logical	: 1,
-		x2apic_set_max_apicid	: 1;
+		x2apic_set_max_apicid	: 1,
+		nmi_to_offline_cpu	: 1;
 
 	u32	(*calc_dest_apicid)(unsigned int cpu);
 
@@ -542,6 +543,8 @@ extern bool default_check_apicid_used(ph
 extern void default_ioapic_phys_id_map(physid_mask_t *phys_map, physid_mask_t *retmap);
 extern int default_cpu_present_to_apicid(int mps_cpu);
 
+void apic_send_nmi_to_offline_cpu(unsigned int cpu);
+
 #else /* CONFIG_X86_LOCAL_APIC */
 
 static inline unsigned int read_apic_id(void) { return 0; }
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -103,6 +103,7 @@ static struct apic apic_flat __ro_after_
 	.send_IPI_allbutself		= default_send_IPI_allbutself,
 	.send_IPI_all			= default_send_IPI_all,
 	.send_IPI_self			= default_send_IPI_self,
+	.nmi_to_offline_cpu		= true,
 
 	.read				= native_apic_mem_read,
 	.write				= native_apic_mem_write,
@@ -175,6 +176,7 @@ static struct apic apic_physflat __ro_af
 	.send_IPI_allbutself		= default_send_IPI_allbutself,
 	.send_IPI_all			= default_send_IPI_all,
 	.send_IPI_self			= default_send_IPI_self,
+	.nmi_to_offline_cpu		= true,
 
 	.read				= native_apic_mem_read,
 	.write				= native_apic_mem_write,
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -97,6 +97,14 @@ void native_send_call_func_ipi(const str
 	__apic_send_IPI_mask(mask, CALL_FUNCTION_VECTOR);
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
 
 static inline int __prepare_ICR2(unsigned int mask)
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -251,6 +251,7 @@ static struct apic apic_x2apic_cluster _
 	.send_IPI_allbutself		= x2apic_send_IPI_allbutself,
 	.send_IPI_all			= x2apic_send_IPI_all,
 	.send_IPI_self			= x2apic_send_IPI_self,
+	.nmi_to_offline_cpu		= true,
 
 	.read				= native_apic_msr_read,
 	.write				= native_apic_msr_write,
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -166,6 +166,7 @@ static struct apic apic_x2apic_phys __ro
 	.send_IPI_allbutself		= x2apic_send_IPI_allbutself,
 	.send_IPI_all			= x2apic_send_IPI_all,
 	.send_IPI_self			= x2apic_send_IPI_self,
+	.nmi_to_offline_cpu		= true,
 
 	.read				= native_apic_msr_read,
 	.write				= native_apic_msr_write,

