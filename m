Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02637E4339
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343870AbjKGPSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbjKGPRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:17:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE41759FA;
        Tue,  7 Nov 2023 07:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699369317; x=1730905317;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AwXIjSNDFphI+OlUSHBIa9GEHbnefbKg+VQD+yT3BRQ=;
  b=XBEo31P0ublV3kLdm5bA/+03jrWD4CbS5/oJjnwkWSlYJcS6qqCHNg/B
   3Sp+0IfHcSNFYj4Sp/eqbHVDz3ooknu1zYEMByL5x9x0lujo70p73oFjK
   XmbqRQqyskHbLtSgNu8ymnCU1pdkZUIQtf4y5grI/6Y6GUN7fr7D8WG22
   PbYsUu+0LnTTi/WcJfbSqN41b+QCc1o3BsdedwVZr+beRkJU9RZ2yI46g
   NqvXAslU2BvEvngW4qSPGAroR7NaHX590b+gxm1xfBc20l/4OeBcupVJ+
   A+OHcNulyKos3i9uLD4k6uhWizvAQW4jcOW1dEC8ViLho9RRES8yIblKF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="2462559"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="2462559"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 06:58:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="10851546"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 06:58:23 -0800
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
Subject: [PATCH v17 085/116] KVM: TDX: handle ept violation/misconfig exit
Date:   Tue,  7 Nov 2023 06:56:51 -0800
Message-Id: <8d71a2f1cb63984aa5365dc15273b4916eef82c5.1699368322.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1699368322.git.isaku.yamahata@intel.com>
References: <cover.1699368322.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Isaku Yamahata <isaku.yamahata@intel.com>

On EPT violation, call a common function, __vmx_handle_ept_violation() to
trigger x86 MMU code.  On EPT misconfiguration, exit to ring 3 with
KVM_EXIT_UNKNOWN.  because EPT misconfiguration can't happen as MMIO is
trigged by TDG.VP.VMCALL. No point to set a misconfiguration value for the
fast path.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>

---
v14 -> v15:
- use PFERR_GUEST_ENC_MASK to tell the fault is private
---
 arch/x86/kvm/vmx/common.h |  3 +++
 arch/x86/kvm/vmx/tdx.c    | 49 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
index 632af7a76d0a..027aa4175d2c 100644
--- a/arch/x86/kvm/vmx/common.h
+++ b/arch/x86/kvm/vmx/common.h
@@ -87,6 +87,9 @@ static inline int __vmx_handle_ept_violation(struct kvm_vcpu *vcpu, gpa_t gpa,
 	error_code |= (exit_qualification & EPT_VIOLATION_GVA_TRANSLATED) != 0 ?
 	       PFERR_GUEST_FINAL_MASK : PFERR_GUEST_PAGE_MASK;
 
+	if (kvm_is_private_gpa(vcpu->kvm, gpa))
+		error_code |= PFERR_GUEST_ENC_MASK;
+
 	return kvm_mmu_page_fault(vcpu, gpa, error_code, NULL, 0);
 }
 
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index bfa6c5e925aa..09b7bf9c7980 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1261,6 +1261,51 @@ void tdx_deliver_interrupt(struct kvm_lapic *apic, int delivery_mode,
 	__vmx_deliver_posted_interrupt(vcpu, &tdx->pi_desc, vector);
 }
 
+static int tdx_handle_ept_violation(struct kvm_vcpu *vcpu)
+{
+	unsigned long exit_qual;
+
+	if (kvm_is_private_gpa(vcpu->kvm, tdexit_gpa(vcpu))) {
+		/*
+		 * Always treat SEPT violations as write faults.  Ignore the
+		 * EXIT_QUALIFICATION reported by TDX-SEAM for SEPT violations.
+		 * TD private pages are always RWX in the SEPT tables,
+		 * i.e. they're always mapped writable.  Just as importantly,
+		 * treating SEPT violations as write faults is necessary to
+		 * avoid COW allocations, which will cause TDAUGPAGE failures
+		 * due to aliasing a single HPA to multiple GPAs.
+		 */
+#define TDX_SEPT_VIOLATION_EXIT_QUAL	EPT_VIOLATION_ACC_WRITE
+		exit_qual = TDX_SEPT_VIOLATION_EXIT_QUAL;
+	} else {
+		exit_qual = tdexit_exit_qual(vcpu);
+		if (exit_qual & EPT_VIOLATION_ACC_INSTR) {
+			pr_warn("kvm: TDX instr fetch to shared GPA = 0x%lx @ RIP = 0x%lx\n",
+				tdexit_gpa(vcpu), kvm_rip_read(vcpu));
+			vcpu->run->exit_reason = KVM_EXIT_EXCEPTION;
+			vcpu->run->ex.exception = PF_VECTOR;
+			vcpu->run->ex.error_code = exit_qual;
+			return 0;
+		}
+	}
+
+	trace_kvm_page_fault(vcpu, tdexit_gpa(vcpu), exit_qual);
+	return __vmx_handle_ept_violation(vcpu, tdexit_gpa(vcpu), exit_qual);
+}
+
+static int tdx_handle_ept_misconfig(struct kvm_vcpu *vcpu)
+{
+	WARN_ON_ONCE(1);
+
+	vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+	vcpu->run->internal.suberror = KVM_INTERNAL_ERROR_UNEXPECTED_EXIT_REASON;
+	vcpu->run->internal.ndata = 2;
+	vcpu->run->internal.data[0] = EXIT_REASON_EPT_MISCONFIG;
+	vcpu->run->internal.data[1] = vcpu->arch.last_vmentry_cpu;
+
+	return 0;
+}
+
 int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
 {
 	union tdx_exit_reason exit_reason = to_tdx(vcpu)->exit_reason;
@@ -1321,6 +1366,10 @@ int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
 	WARN_ON_ONCE(fastpath != EXIT_FASTPATH_NONE);
 
 	switch (exit_reason.basic) {
+	case EXIT_REASON_EPT_VIOLATION:
+		return tdx_handle_ept_violation(vcpu);
+	case EXIT_REASON_EPT_MISCONFIG:
+		return tdx_handle_ept_misconfig(vcpu);
 	case EXIT_REASON_OTHER_SMI:
 		/*
 		 * If reach here, it's not a Machine Check System Management
-- 
2.25.1

