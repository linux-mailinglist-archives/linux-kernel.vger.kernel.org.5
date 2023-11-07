Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27847E49BD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbjKGUVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235331AbjKGUUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:20:53 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827CC10D7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 12:20:36 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da2b87dd614so7658850276.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 12:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699388435; x=1699993235; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y8QOX5ssztoDkuUgIXj56BbHOfE75T4joHq9+2piv0I=;
        b=pENGfChkORxTBr/8paQZY5huwtJaTd2dI2htow/kQpBiKA0LiEJgZUUW6qpIwNWsDT
         K6F5Y8slafK6fA1KhLyl6+PxUP7dcboIbeaXvicqOur1lFrLdjujod2SrCsBkRXm9Afo
         HhBrdg+YCN5isaLQ/DFlZli9b6F/PTOQEMg9Oec6wybKURZ61XdDzClx7wsQY+n8Pimw
         cNWpGcIfdDUJEzfx3ntp0ZBIao9JD7VAsKCUeFtBul4bWbNDEqHzK3CZ9GQ/oBWtsTtG
         7e+PILzJCUs71AsrwcHmqArQLnbfVXqRgGrAw4sv+veBgtwulmn2Wb+mUMi5x4p21/ic
         cqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699388435; x=1699993235;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y8QOX5ssztoDkuUgIXj56BbHOfE75T4joHq9+2piv0I=;
        b=j1YZRpmqcIGDBJEmdI/fjBUhmnueL3dgqcdeHXxWH9u3nxz1GW8GuyIU2QkdFI4xqC
         rUuV32UB7NiqIOpnCR+qOaCQ+EQtnB1Rqxf5VmYhReygXc/Xp3csB2hxVxcy5XaGVW8m
         14MRrv0Y48w1Uq24Sg8vGZkGncRlgRM3t4lvvp9vqDlTDKLHfBlRV5erlzzcogksIMhP
         r7cnD/GP+Od3AwNn0xrg49C+l0QZtHOwyXdnlyU87suS9dYbp7rQFoxZOfqDRKCdi5GZ
         FKL4SEX+/WXn/3B2SDbRpgSXPxslfFVQzAO2H6jVvky7d3gKMAmTNjsl7A84ovnqO+m+
         +0Hg==
X-Gm-Message-State: AOJu0YxVkVaX4nhT1Gz5SAE4BCx0ICFVzfZZ9Zi9/UGZusUU4aCLwRpb
        snIaw1mZdevMqUNUFwNAADGZZrasbcLv1Q==
X-Google-Smtp-Source: AGHT+IEq/h9JD8pqR2MuSr0bQ3WrYReri9lAbPPdUWqZUlGkvIoffaqx3ygtJ2OX7/OTvw3xBu0uNXjGHkJ4zA==
X-Received: from aghulati-dev.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:18bb])
 (user=aghulati job=sendgmr) by 2002:a25:8286:0:b0:d9a:c3a2:48a3 with SMTP id
 r6-20020a258286000000b00d9ac3a248a3mr636616ybk.6.1699388435765; Tue, 07 Nov
 2023 12:20:35 -0800 (PST)
Date:   Tue,  7 Nov 2023 20:19:58 +0000
In-Reply-To: <20231107202002.667900-1-aghulati@google.com>
Mime-Version: 1.0
References: <20231107202002.667900-1-aghulati@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231107202002.667900-11-aghulati@google.com>
Subject: [RFC PATCH 10/14] KVM: VMX: Move VMX enable and disable into VAC
From:   Anish Ghulati <aghulati@google.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        hpa@zytor.com, Vitaly Kuznetsov <vkuznets@redhat.com>,
        peterz@infradead.org, paulmck@kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Anish Ghulati <aghulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move loaded_vmcss_on_cpu into VAC. loaded_vmcss_on_cpu is a list of
VMCSs that have been loaded on a CPU; when offlining or kexec/crashing,
this needs to be VMCLEAR'd.

Register and unregister callbacks for vmx_emergency_disable in
vac_vmx_init/exit. These are init and exit functions for the VMX portion
of VAC. Temporarily call init and exit from vmx_init and __vmx_exit.
This will change once VAC is a module (the init/exit will be called via
module init and exit functions).

Move the call to hv_reset_evmcs from vmx_hardware_disable to
vmx_module_exit. This is because vmx_hardware_enable/disable is now part
of VAC.

Signed-off-by: Anish Ghulati <aghulati@google.com>
---
 arch/x86/kvm/vac.h     |  14 +++
 arch/x86/kvm/vmx/vac.c | 190 +++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/vmx/vac.h |   7 +-
 arch/x86/kvm/vmx/vmx.c | 182 ++-------------------------------------
 4 files changed, 219 insertions(+), 174 deletions(-)

diff --git a/arch/x86/kvm/vac.h b/arch/x86/kvm/vac.h
index 135d3be5461e..59cbf36ff8ce 100644
--- a/arch/x86/kvm/vac.h
+++ b/arch/x86/kvm/vac.h
@@ -5,6 +5,20 @@
 
 #include <linux/user-return-notifier.h>
 
+int __init vac_init(void);
+void vac_exit(void);
+
+#ifdef CONFIG_KVM_INTEL
+int __init vac_vmx_init(void);
+void vac_vmx_exit(void);
+#else
+int __init vac_vmx_init(void)
+{
+	return 0;
+}
+void vac_vmx_exit(void) {}
+#endif
+
 /*
  * Restoring the host value for MSRs that are only consumed when running in
  * usermode, e.g. SYSCALL MSRs and TSC_AUX, can be deferred until the CPU
diff --git a/arch/x86/kvm/vmx/vac.c b/arch/x86/kvm/vmx/vac.c
index 7b8ade0fb97f..202686ccbaec 100644
--- a/arch/x86/kvm/vmx/vac.c
+++ b/arch/x86/kvm/vmx/vac.c
@@ -1,10 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <asm/percpu.h>
+#include <asm/reboot.h>
 #include <linux/percpu-defs.h>
 
 #include "vac.h"
+#include "vmx_ops.h"
+#include "posted_intr.h"
 
+/*
+ * We maintain a per-CPU linked-list of VMCS loaded on that CPU. This is needed
+ * when a CPU is brought down, and we need to VMCLEAR all VMCSs loaded on it.
+ */
+static DEFINE_PER_CPU(struct list_head, loaded_vmcss_on_cpu);
 
 static DEFINE_PER_CPU(struct vmcs *, vmxarea);
 
@@ -47,3 +55,185 @@ void free_vpid(int vpid)
 	__clear_bit(vpid, vmx_vpid_bitmap);
 	spin_unlock(&vmx_vpid_lock);
 }
+
+void add_vmcs_to_loaded_vmcss_on_cpu(
+		struct list_head *loaded_vmcss_on_cpu_link,
+		int cpu)
+{
+	list_add(loaded_vmcss_on_cpu_link, &per_cpu(loaded_vmcss_on_cpu, cpu));
+}
+
+static void __loaded_vmcs_clear(void *arg)
+{
+	struct loaded_vmcs *loaded_vmcs = arg;
+	int cpu = raw_smp_processor_id();
+
+	if (loaded_vmcs->cpu != cpu)
+		return; /* vcpu migration can race with cpu offline */
+	if (per_cpu(current_vmcs, cpu) == loaded_vmcs->vmcs)
+		per_cpu(current_vmcs, cpu) = NULL;
+
+	vmcs_clear(loaded_vmcs->vmcs);
+	if (loaded_vmcs->shadow_vmcs && loaded_vmcs->launched)
+		vmcs_clear(loaded_vmcs->shadow_vmcs);
+
+	list_del(&loaded_vmcs->loaded_vmcss_on_cpu_link);
+
+	/*
+	 * Ensure all writes to loaded_vmcs, including deleting it from its
+	 * current percpu list, complete before setting loaded_vmcs->cpu to
+	 * -1, otherwise a different cpu can see loaded_vmcs->cpu == -1 first
+	 * and add loaded_vmcs to its percpu list before it's deleted from this
+	 * cpu's list. Pairs with the smp_rmb() in vmx_vcpu_load_vmcs().
+	 */
+	smp_wmb();
+
+	loaded_vmcs->cpu = -1;
+	loaded_vmcs->launched = 0;
+}
+
+void loaded_vmcs_clear(struct loaded_vmcs *loaded_vmcs)
+{
+	int cpu = loaded_vmcs->cpu;
+
+	if (cpu != -1)
+		smp_call_function_single(cpu,
+			 __loaded_vmcs_clear, loaded_vmcs, 1);
+
+}
+
+static int kvm_cpu_vmxon(u64 vmxon_pointer)
+{
+	u64 msr;
+
+	cr4_set_bits(X86_CR4_VMXE);
+
+	asm_volatile_goto("1: vmxon %[vmxon_pointer]\n\t"
+			  _ASM_EXTABLE(1b, %l[fault])
+			  : : [vmxon_pointer] "m"(vmxon_pointer)
+			  : : fault);
+	return 0;
+
+fault:
+	WARN_ONCE(1, "VMXON faulted, MSR_IA32_FEAT_CTL (0x3a) = 0x%llx\n",
+		  rdmsrl_safe(MSR_IA32_FEAT_CTL, &msr) ? 0xdeadbeef : msr);
+	cr4_clear_bits(X86_CR4_VMXE);
+
+	return -EFAULT;
+}
+
+int vmx_hardware_enable(void)
+{
+	int cpu = raw_smp_processor_id();
+	u64 phys_addr = __pa(vac_get_vmxarea(cpu));
+	int r;
+
+	if (cr4_read_shadow() & X86_CR4_VMXE)
+		return -EBUSY;
+
+	/*
+	 * This can happen if we hot-added a CPU but failed to allocate
+	 * VP assist page for it.
+	 */
+	if (kvm_is_using_evmcs() && !hv_get_vp_assist_page(cpu))
+		return -EFAULT;
+
+	intel_pt_handle_vmx(1);
+
+	r = kvm_cpu_vmxon(phys_addr);
+	if (r) {
+		intel_pt_handle_vmx(0);
+		return r;
+	}
+
+	if (enable_ept)
+		ept_sync_global();
+
+	return 0;
+}
+
+static void vmclear_local_loaded_vmcss(void)
+{
+	int cpu = raw_smp_processor_id();
+	struct loaded_vmcs *v, *n;
+
+	list_for_each_entry_safe(v, n, &per_cpu(loaded_vmcss_on_cpu, cpu),
+				 loaded_vmcss_on_cpu_link)
+		__loaded_vmcs_clear(v);
+}
+
+/*
+ * Disable VMX and clear CR4.VMXE (even if VMXOFF faults)
+ *
+ * Note, VMXOFF causes a #UD if the CPU is !post-VMXON, but it's impossible to
+ * atomically track post-VMXON state, e.g. this may be called in NMI context.
+ * Eat all faults as all other faults on VMXOFF faults are mode related, i.e.
+ * faults are guaranteed to be due to the !post-VMXON check unless the CPU is
+ * magically in RM, VM86, compat mode, or at CPL>0.
+ */
+static int kvm_cpu_vmxoff(void)
+{
+	asm_volatile_goto("1: vmxoff\n\t"
+			  _ASM_EXTABLE(1b, %l[fault])
+			  ::: "cc", "memory" : fault);
+
+	cr4_clear_bits(X86_CR4_VMXE);
+	return 0;
+
+fault:
+	cr4_clear_bits(X86_CR4_VMXE);
+	return -EIO;
+}
+
+static void vmx_emergency_disable(void)
+{
+	int cpu = raw_smp_processor_id();
+	struct loaded_vmcs *v;
+
+	kvm_rebooting = true;
+
+	/*
+	 * Note, CR4.VMXE can be _cleared_ in NMI context, but it can only be
+	 * set in task context.  If this races with VMX is disabled by an NMI,
+	 * VMCLEAR and VMXOFF may #UD, but KVM will eat those faults due to
+	 * kvm_rebooting set.
+	 */
+	if (!(__read_cr4() & X86_CR4_VMXE))
+		return;
+
+	list_for_each_entry(v, &per_cpu(loaded_vmcss_on_cpu, cpu),
+			    loaded_vmcss_on_cpu_link)
+		vmcs_clear(v->vmcs);
+
+	kvm_cpu_vmxoff();
+}
+
+void vmx_hardware_disable(void)
+{
+	vmclear_local_loaded_vmcss();
+
+	if (kvm_cpu_vmxoff())
+		kvm_spurious_fault();
+
+	intel_pt_handle_vmx(0);
+}
+
+int __init vac_vmx_init(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		INIT_LIST_HEAD(&per_cpu(loaded_vmcss_on_cpu, cpu));
+
+		pi_init_cpu(cpu);
+	}
+
+	cpu_emergency_register_virt_callback(vmx_emergency_disable);
+
+	return 0;
+}
+
+void vac_vmx_exit(void)
+{
+	cpu_emergency_unregister_virt_callback(vmx_emergency_disable);
+}
diff --git a/arch/x86/kvm/vmx/vac.h b/arch/x86/kvm/vmx/vac.h
index 46c54fe7447d..daeea8ef0d33 100644
--- a/arch/x86/kvm/vmx/vac.h
+++ b/arch/x86/kvm/vmx/vac.h
@@ -9,4 +9,9 @@ void vac_set_vmxarea(struct vmcs *vmcs, int cpu);
 
 struct vmcs *vac_get_vmxarea(int cpu);
 int allocate_vpid(void);
-void free_vpid(int vpid);
+void add_vmcs_to_loaded_vmcss_on_cpu(
+		struct list_head *loaded_vmcss_on_cpu_link,
+		int cpu);
+void loaded_vmcs_clear(struct loaded_vmcs *loaded_vmcs);
+int vmx_hardware_enable(void);
+void vmx_hardware_disable(void);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 407e37810419..46e2d5c69d1d 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -456,12 +456,6 @@ noinline void invept_error(unsigned long ext, u64 eptp, gpa_t gpa)
 			ext, eptp, gpa);
 }
 
-/*
- * We maintain a per-CPU linked-list of VMCS loaded on that CPU. This is needed
- * when a CPU is brought down, and we need to VMCLEAR all VMCSs loaded on it.
- */
-static DEFINE_PER_CPU(struct list_head, loaded_vmcss_on_cpu);
-
 struct vmcs_config vmcs_config __ro_after_init;
 struct vmx_capability vmx_capability __ro_after_init;
 
@@ -716,90 +710,6 @@ static int vmx_set_guest_uret_msr(struct vcpu_vmx *vmx,
 	return ret;
 }
 
-/*
- * Disable VMX and clear CR4.VMXE (even if VMXOFF faults)
- *
- * Note, VMXOFF causes a #UD if the CPU is !post-VMXON, but it's impossible to
- * atomically track post-VMXON state, e.g. this may be called in NMI context.
- * Eat all faults as all other faults on VMXOFF faults are mode related, i.e.
- * faults are guaranteed to be due to the !post-VMXON check unless the CPU is
- * magically in RM, VM86, compat mode, or at CPL>0.
- */
-static int kvm_cpu_vmxoff(void)
-{
-	asm_volatile_goto("1: vmxoff\n\t"
-			  _ASM_EXTABLE(1b, %l[fault])
-			  ::: "cc", "memory" : fault);
-
-	cr4_clear_bits(X86_CR4_VMXE);
-	return 0;
-
-fault:
-	cr4_clear_bits(X86_CR4_VMXE);
-	return -EIO;
-}
-
-static void vmx_emergency_disable(void)
-{
-	int cpu = raw_smp_processor_id();
-	struct loaded_vmcs *v;
-
-	kvm_rebooting = true;
-
-	/*
-	 * Note, CR4.VMXE can be _cleared_ in NMI context, but it can only be
-	 * set in task context.  If this races with VMX is disabled by an NMI,
-	 * VMCLEAR and VMXOFF may #UD, but KVM will eat those faults due to
-	 * kvm_rebooting set.
-	 */
-	if (!(__read_cr4() & X86_CR4_VMXE))
-		return;
-
-	list_for_each_entry(v, &per_cpu(loaded_vmcss_on_cpu, cpu),
-			    loaded_vmcss_on_cpu_link)
-		vmcs_clear(v->vmcs);
-
-	kvm_cpu_vmxoff();
-}
-
-static void __loaded_vmcs_clear(void *arg)
-{
-	struct loaded_vmcs *loaded_vmcs = arg;
-	int cpu = raw_smp_processor_id();
-
-	if (loaded_vmcs->cpu != cpu)
-		return; /* vcpu migration can race with cpu offline */
-	if (per_cpu(current_vmcs, cpu) == loaded_vmcs->vmcs)
-		per_cpu(current_vmcs, cpu) = NULL;
-
-	vmcs_clear(loaded_vmcs->vmcs);
-	if (loaded_vmcs->shadow_vmcs && loaded_vmcs->launched)
-		vmcs_clear(loaded_vmcs->shadow_vmcs);
-
-	list_del(&loaded_vmcs->loaded_vmcss_on_cpu_link);
-
-	/*
-	 * Ensure all writes to loaded_vmcs, including deleting it from its
-	 * current percpu list, complete before setting loaded_vmcs->cpu to
-	 * -1, otherwise a different cpu can see loaded_vmcs->cpu == -1 first
-	 * and add loaded_vmcs to its percpu list before it's deleted from this
-	 * cpu's list. Pairs with the smp_rmb() in vmx_vcpu_load_vmcs().
-	 */
-	smp_wmb();
-
-	loaded_vmcs->cpu = -1;
-	loaded_vmcs->launched = 0;
-}
-
-void loaded_vmcs_clear(struct loaded_vmcs *loaded_vmcs)
-{
-	int cpu = loaded_vmcs->cpu;
-
-	if (cpu != -1)
-		smp_call_function_single(cpu,
-			 __loaded_vmcs_clear, loaded_vmcs, 1);
-}
-
 static bool vmx_segment_cache_test_set(struct vcpu_vmx *vmx, unsigned seg,
 				       unsigned field)
 {
@@ -1411,8 +1321,9 @@ void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu,
 		 */
 		smp_rmb();
 
-		list_add(&vmx->loaded_vmcs->loaded_vmcss_on_cpu_link,
-			 &per_cpu(loaded_vmcss_on_cpu, cpu));
+		add_vmcs_to_loaded_vmcss_on_cpu(
+				&vmx->loaded_vmcs->loaded_vmcss_on_cpu_link,
+				cpu);
 		local_irq_enable();
 	}
 
@@ -2765,78 +2676,6 @@ static int vmx_check_processor_compat(void)
 	return 0;
 }
 
-static int kvm_cpu_vmxon(u64 vmxon_pointer)
-{
-	u64 msr;
-
-	cr4_set_bits(X86_CR4_VMXE);
-
-	asm_volatile_goto("1: vmxon %[vmxon_pointer]\n\t"
-			  _ASM_EXTABLE(1b, %l[fault])
-			  : : [vmxon_pointer] "m"(vmxon_pointer)
-			  : : fault);
-	return 0;
-
-fault:
-	WARN_ONCE(1, "VMXON faulted, MSR_IA32_FEAT_CTL (0x3a) = 0x%llx\n",
-		  rdmsrl_safe(MSR_IA32_FEAT_CTL, &msr) ? 0xdeadbeef : msr);
-	cr4_clear_bits(X86_CR4_VMXE);
-
-	return -EFAULT;
-}
-
-static int vmx_hardware_enable(void)
-{
-	int cpu = raw_smp_processor_id();
-	u64 phys_addr = __pa(vac_get_vmxarea(cpu));
-	int r;
-
-	if (cr4_read_shadow() & X86_CR4_VMXE)
-		return -EBUSY;
-
-	/*
-	 * This can happen if we hot-added a CPU but failed to allocate
-	 * VP assist page for it.
-	 */
-	if (kvm_is_using_evmcs() && !hv_get_vp_assist_page(cpu))
-		return -EFAULT;
-
-	intel_pt_handle_vmx(1);
-
-	r = kvm_cpu_vmxon(phys_addr);
-	if (r) {
-		intel_pt_handle_vmx(0);
-		return r;
-	}
-
-	if (enable_ept)
-		ept_sync_global();
-
-	return 0;
-}
-
-static void vmclear_local_loaded_vmcss(void)
-{
-	int cpu = raw_smp_processor_id();
-	struct loaded_vmcs *v, *n;
-
-	list_for_each_entry_safe(v, n, &per_cpu(loaded_vmcss_on_cpu, cpu),
-				 loaded_vmcss_on_cpu_link)
-		__loaded_vmcs_clear(v);
-}
-
-static void vmx_hardware_disable(void)
-{
-	vmclear_local_loaded_vmcss();
-
-	if (kvm_cpu_vmxoff())
-		kvm_spurious_fault();
-
-	hv_reset_evmcs();
-
-	intel_pt_handle_vmx(0);
-}
-
 struct vmcs *alloc_vmcs_cpu(bool shadow, int cpu, gfp_t flags)
 {
 	int node = cpu_to_node(cpu);
@@ -8182,13 +8021,15 @@ static void __vmx_exit(void)
 {
 	allow_smaller_maxphyaddr = false;
 
-	cpu_emergency_unregister_virt_callback(vmx_emergency_disable);
+	//TODO: Remove this exit call once VAC is a module
+	vac_vmx_exit();
 
 	vmx_cleanup_l1d_flush();
 }
 
 void vmx_module_exit(void)
 {
+	hv_reset_evmcs();
 	__vmx_exit();
 }
 
@@ -8603,7 +8444,7 @@ static struct kvm_x86_init_ops vmx_init_ops __initdata = {
 
 int __init vmx_init(void)
 {
-	int r, cpu;
+	int r;
 
 	/*
 	 * Note, hv_init_evmcs() touches only VMX knobs, i.e. there's nothing
@@ -8626,13 +8467,8 @@ int __init vmx_init(void)
 	if (r)
 		goto err_l1d_flush;
 
-	for_each_possible_cpu(cpu) {
-		INIT_LIST_HEAD(&per_cpu(loaded_vmcss_on_cpu, cpu));
-
-		pi_init_cpu(cpu);
-	}
-
-	cpu_emergency_register_virt_callback(vmx_emergency_disable);
+	//TODO: Remove this init call once VAC is a module
+	vac_vmx_init();
 
 	vmx_check_vmcs12_offsets();
 
-- 
2.42.0.869.gea05f2083d-goog

