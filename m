Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4AB7E4318
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbjKGPPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234855AbjKGPOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:14:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0255BAD;
        Tue,  7 Nov 2023 07:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699369319; x=1730905319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=je9GimHBDY23lqMYlMjujJ0fofZktRdZTCxLfHeRfiE=;
  b=UQ2sBoL/JU9ORdK5HGmKqvggTzxRGjc+VNW1fOWkR0n7LQ+uNxbov6fH
   jYeyr27rHtUYvQLyn8GcIQYw82JH02criuT0g+VFJSdu/pb5hKA1KhWHg
   RJ5hgLfsW+VEcaMYkMzgHvc24+TKCKxxL/a0Vm4mTrTBqzkOVcW7I1Tm9
   x/JULh9QkiYcZzYumdHkat6cj9if7CSGbSBcSX3RH7uxOPQ2i8R/IFRuc
   9IGlqWvf2BiH5JxXTP+amVnZjoPF/lNtVW8wp79a5UgqDaGFL3sfGQNgP
   b+6JlKd6VcCyaAgj8oPL1nw6wP49SrH7kKdVNT2eZ6MfjuEVOdDgKidK+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="2462585"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="2462585"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 06:58:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="10851581"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 06:58:24 -0800
From:   isaku.yamahata@intel.com
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@intel.com, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Sean Christopherson <seanjc@google.com>,
        Sagi Shahar <sagis@google.com>,
        David Matlack <dmatlack@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>, chen.bo@intel.com,
        hang.yuan@intel.com, tina.zhang@intel.com
Subject: [PATCH v17 092/116] KVM: TDX: Handle TDX PV HLT hypercall
Date:   Tue,  7 Nov 2023 06:56:58 -0800
Message-Id: <7ca4b7af33646e3f5693472b4394ba0179b550e1.1699368322.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1699368322.git.isaku.yamahata@intel.com>
References: <cover.1699368322.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Isaku Yamahata <isaku.yamahata@intel.com>

Wire up TDX PV HLT hypercall to the KVM backend function.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 arch/x86/kvm/vmx/tdx.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 arch/x86/kvm/vmx/tdx.h |  3 +++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 3a1fe74b95c3..4e48989d364f 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -662,7 +662,32 @@ void tdx_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 bool tdx_protected_apic_has_interrupt(struct kvm_vcpu *vcpu)
 {
-	return pi_has_pending_interrupt(vcpu);
+	bool ret = pi_has_pending_interrupt(vcpu);
+	struct vcpu_tdx *tdx = to_tdx(vcpu);
+
+	if (ret || vcpu->arch.mp_state != KVM_MP_STATE_HALTED)
+		return true;
+
+	if (tdx->interrupt_disabled_hlt)
+		return false;
+
+	/*
+	 * This is for the case where the virtual interrupt is recognized,
+	 * i.e. set in vmcs.RVI, between the STI and "HLT".  KVM doesn't have
+	 * access to RVI and the interrupt is no longer in the PID (because it
+	 * was "recognized".  It doesn't get delivered in the guest because the
+	 * TDCALL completes before interrupts are enabled.
+	 *
+	 * TDX modules sets RVI while in an STI interrupt shadow.
+	 * - TDExit(typically TDG.VP.VMCALL<HLT>) from the guest to TDX module.
+	 *   The interrupt shadow at this point is gone.
+	 * - It knows that there is an interrupt that can be delivered
+	 *   (RVI > PPR && EFLAGS.IF=1, the other conditions of 29.2.2 don't
+	 *    matter)
+	 * - It forwards the TDExit nevertheless, to a clueless hypervisor that
+	 *   has no way to glean either RVI or PPR.
+	 */
+	return !!xchg(&tdx->buggy_hlt_workaround, 0);
 }
 
 void tdx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
@@ -1104,6 +1129,17 @@ static int tdx_emulate_cpuid(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
+static int tdx_emulate_hlt(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_tdx *tdx = to_tdx(vcpu);
+
+	/* See tdx_protected_apic_has_interrupt() to avoid heavy seamcall */
+	tdx->interrupt_disabled_hlt = tdvmcall_a0_read(vcpu);
+
+	tdvmcall_set_return_code(vcpu, TDG_VP_VMCALL_SUCCESS);
+	return kvm_emulate_halt_noskip(vcpu);
+}
+
 static int handle_tdvmcall(struct kvm_vcpu *vcpu)
 {
 	if (tdvmcall_exit_type(vcpu))
@@ -1112,6 +1148,8 @@ static int handle_tdvmcall(struct kvm_vcpu *vcpu)
 	switch (tdvmcall_leaf(vcpu)) {
 	case EXIT_REASON_CPUID:
 		return tdx_emulate_cpuid(vcpu);
+	case EXIT_REASON_HLT:
+		return tdx_emulate_hlt(vcpu);
 	default:
 		break;
 	}
@@ -1486,6 +1524,8 @@ void tdx_deliver_interrupt(struct kvm_lapic *apic, int delivery_mode,
 	struct kvm_vcpu *vcpu = apic->vcpu;
 	struct vcpu_tdx *tdx = to_tdx(vcpu);
 
+	/* See comment in tdx_protected_apic_has_interrupt(). */
+	tdx->buggy_hlt_workaround = 1;
 	/* TDX supports only posted interrupt.  No lapic emulation. */
 	__vmx_deliver_posted_interrupt(vcpu, &tdx->pi_desc, vector);
 }
diff --git a/arch/x86/kvm/vmx/tdx.h b/arch/x86/kvm/vmx/tdx.h
index 870a0d15e073..4ddcf804c0a4 100644
--- a/arch/x86/kvm/vmx/tdx.h
+++ b/arch/x86/kvm/vmx/tdx.h
@@ -101,6 +101,9 @@ struct vcpu_tdx {
 	bool host_state_need_restore;
 	u64 msr_host_kernel_gs_base;
 
+	bool interrupt_disabled_hlt;
+	unsigned int buggy_hlt_workaround;
+
 	/*
 	 * Dummy to make pmu_intel not corrupt memory.
 	 * TODO: Support PMU for TDX.  Future work.
-- 
2.25.1

