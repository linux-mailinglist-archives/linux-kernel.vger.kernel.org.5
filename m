Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DAA7E4428
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343599AbjKGPuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343764AbjKGPQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:16:07 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF2A1709;
        Tue,  7 Nov 2023 06:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699369140; x=1730905140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9/kmZKrf7B9khfHFvO8l/MtKpBky5QWjWGvvbIbUtXs=;
  b=hHn0li6F3J5GSA2DzbZSrHM1fdagTB82J1r9nsQqsei7CdfM44pSbsPS
   CLtAm26aAyIb0CilrfC/QwjKMqHy98Lktl0OoYtisTRKUdWTgu11scZon
   mY4egJXmmEZ6eodzDECulEKh9X4muWYKek5x/peWmtBb8Z2Yf3gchwE1c
   97sPdsI4LPvV/x7TViRLy8ff7AuKZp4mQCGy/krZuBvbOe1H3I9DbrCZG
   IQwCCVEdRxvrzajm8Fj2+6FAZBSZkL2ucB0VTYUs4xt/ege/IBloKMxn8
   36tEQXw0AA48qTZk56CJzzMwfPczWn3M6jeh5FfLAQ60P/ufc82Z5YQNl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="2462327"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="2462327"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 06:58:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="10851394"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 06:58:12 -0800
From:   isaku.yamahata@intel.com
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@intel.com, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Sean Christopherson <seanjc@google.com>,
        Sagi Shahar <sagis@google.com>,
        David Matlack <dmatlack@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>, chen.bo@intel.com,
        hang.yuan@intel.com, tina.zhang@intel.com,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH v17 049/116] KVM: VMX: Split out guts of EPT violation to common/exposed function
Date:   Tue,  7 Nov 2023 06:56:15 -0800
Message-Id: <cd037252e13e7ee2a8b3832b377553367d77a855.1699368322.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1699368322.git.isaku.yamahata@intel.com>
References: <cover.1699368322.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

The difference of TDX EPT violation is how to retrieve information, GPA,
and exit qualification.  To share the code to handle EPT violation, split
out the guts of EPT violation handler so that VMX/TDX exit handler can call
it after retrieving GPA and exit qualification.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
---
 arch/x86/kvm/vmx/common.h | 33 +++++++++++++++++++++++++++++++++
 arch/x86/kvm/vmx/vmx.c    | 25 +++----------------------
 2 files changed, 36 insertions(+), 22 deletions(-)
 create mode 100644 arch/x86/kvm/vmx/common.h

diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
new file mode 100644
index 000000000000..235908f3e044
--- /dev/null
+++ b/arch/x86/kvm/vmx/common.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __KVM_X86_VMX_COMMON_H
+#define __KVM_X86_VMX_COMMON_H
+
+#include <linux/kvm_host.h>
+
+#include "mmu.h"
+
+static inline int __vmx_handle_ept_violation(struct kvm_vcpu *vcpu, gpa_t gpa,
+					     unsigned long exit_qualification)
+{
+	u64 error_code;
+
+	/* Is it a read fault? */
+	error_code = (exit_qualification & EPT_VIOLATION_ACC_READ)
+		     ? PFERR_USER_MASK : 0;
+	/* Is it a write fault? */
+	error_code |= (exit_qualification & EPT_VIOLATION_ACC_WRITE)
+		      ? PFERR_WRITE_MASK : 0;
+	/* Is it a fetch fault? */
+	error_code |= (exit_qualification & EPT_VIOLATION_ACC_INSTR)
+		      ? PFERR_FETCH_MASK : 0;
+	/* ept page table entry is present? */
+	error_code |= (exit_qualification & EPT_VIOLATION_RWX_MASK)
+		      ? PFERR_PRESENT_MASK : 0;
+
+	error_code |= (exit_qualification & EPT_VIOLATION_GVA_TRANSLATED) != 0 ?
+	       PFERR_GUEST_FINAL_MASK : PFERR_GUEST_PAGE_MASK;
+
+	return kvm_mmu_page_fault(vcpu, gpa, error_code, NULL, 0);
+}
+
+#endif /* __KVM_X86_VMX_COMMON_H */
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b239684425b3..af31ad8e893b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -50,6 +50,7 @@
 #include <asm/vmx.h>
 
 #include "capabilities.h"
+#include "common.h"
 #include "cpuid.h"
 #include "hyperv.h"
 #include "kvm_onhyperv.h"
@@ -5780,11 +5781,8 @@ static int handle_task_switch(struct kvm_vcpu *vcpu)
 
 static int handle_ept_violation(struct kvm_vcpu *vcpu)
 {
-	unsigned long exit_qualification;
+	unsigned long exit_qualification = vmx_get_exit_qual(vcpu);
 	gpa_t gpa;
-	u64 error_code;
-
-	exit_qualification = vmx_get_exit_qual(vcpu);
 
 	/*
 	 * EPT violation happened while executing iret from NMI,
@@ -5799,23 +5797,6 @@ static int handle_ept_violation(struct kvm_vcpu *vcpu)
 
 	gpa = vmcs_read64(GUEST_PHYSICAL_ADDRESS);
 	trace_kvm_page_fault(vcpu, gpa, exit_qualification);
-
-	/* Is it a read fault? */
-	error_code = (exit_qualification & EPT_VIOLATION_ACC_READ)
-		     ? PFERR_USER_MASK : 0;
-	/* Is it a write fault? */
-	error_code |= (exit_qualification & EPT_VIOLATION_ACC_WRITE)
-		      ? PFERR_WRITE_MASK : 0;
-	/* Is it a fetch fault? */
-	error_code |= (exit_qualification & EPT_VIOLATION_ACC_INSTR)
-		      ? PFERR_FETCH_MASK : 0;
-	/* ept page table entry is present? */
-	error_code |= (exit_qualification & EPT_VIOLATION_RWX_MASK)
-		      ? PFERR_PRESENT_MASK : 0;
-
-	error_code |= (exit_qualification & EPT_VIOLATION_GVA_TRANSLATED) != 0 ?
-	       PFERR_GUEST_FINAL_MASK : PFERR_GUEST_PAGE_MASK;
-
 	vcpu->arch.exit_qualification = exit_qualification;
 
 	/*
@@ -5829,7 +5810,7 @@ static int handle_ept_violation(struct kvm_vcpu *vcpu)
 	if (unlikely(allow_smaller_maxphyaddr && kvm_vcpu_is_illegal_gpa(vcpu, gpa)))
 		return kvm_emulate_instruction(vcpu, 0);
 
-	return kvm_mmu_page_fault(vcpu, gpa, error_code, NULL, 0);
+	return __vmx_handle_ept_violation(vcpu, gpa, exit_qualification);
 }
 
 static int handle_ept_misconfig(struct kvm_vcpu *vcpu)
-- 
2.25.1

