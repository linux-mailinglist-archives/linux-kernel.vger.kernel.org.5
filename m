Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DA97E4333
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343816AbjKGPRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343821AbjKGPRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:17:18 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8382618D;
        Tue,  7 Nov 2023 07:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699369321; x=1730905321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NwN0SYIH6mizCFNs7YIs5+JEoTAflI2MWC6dCHlRaFo=;
  b=RZ6y/xNPc0oVDot0Fir5Vy+WFX5jdG75xdSbSz78eR+1qHVHmN0shZwr
   GSp03FBdJMN+SfE4LLy9kq29KxvVQ4muJX1TapgVoBGOKsWP2xhdsedDu
   EWU4EVD2NQvZ6kHf9qyap3iQ50U3jpq+yV0sssq4vlBJnM0Rvglf6W3fk
   J/VvwAwthq3Uxc8RfShWqKHmJTkY1Umq/BsYNEinwSZnqSc6oQBl8IULh
   OdJ6dSX/y407agNbSmqUR+qJORvKEcdsJoEj5IAKN0VD/4ZNPgROA/Oyi
   MFJ0ahPTALR6ktYc5QI7liznAP0q/e1MyLrYvHYKidrkiacVt/u5STJ4+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="2462674"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="2462674"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 06:58:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="10851656"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 06:58:29 -0800
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
Subject: [PATCH v17 110/116] KVM: TDX: Inhibit APICv for TDX guest
Date:   Tue,  7 Nov 2023 06:57:16 -0800
Message-Id: <e74f121bb45211c8906e1363b3cb1381a8dd6863.1699368322.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1699368322.git.isaku.yamahata@intel.com>
References: <cover.1699368322.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Isaku Yamahata <isaku.yamahata@intel.com>

TDX doesn't support APICV, inhibit APICv for TDX guest.  Follow how SEV
does it.  Define a new inhibit reason for TDX, set it on TD
initialization, and add the flag to kvm_x86_ops.required_apicv_inhibits.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 arch/x86/include/asm/kvm_host.h | 9 +++++++++
 arch/x86/kvm/vmx/main.c         | 3 ++-
 arch/x86/kvm/vmx/tdx.c          | 6 ++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index cbcb038f4a04..33d99d5c9c16 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1293,6 +1293,15 @@ enum kvm_apicv_inhibit {
 	 * mapping between logical ID and vCPU.
 	 */
 	APICV_INHIBIT_REASON_LOGICAL_ID_ALIASED,
+
+	/*********************************************************/
+	/* INHIBITs that are relevant only to the Intel's APICv. */
+	/*********************************************************/
+
+	/*
+	 * APICv is disabled because TDX doesn't support it.
+	 */
+	APICV_INHIBIT_REASON_TDX,
 };
 
 struct kvm_arch {
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 08d8cbd12540..ba7557b6dc57 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -1001,7 +1001,8 @@ static int vt_vcpu_mem_enc_ioctl(struct kvm_vcpu *vcpu, void __user *argp)
 	 BIT(APICV_INHIBIT_REASON_BLOCKIRQ) |			\
 	 BIT(APICV_INHIBIT_REASON_PHYSICAL_ID_ALIASED) |	\
 	 BIT(APICV_INHIBIT_REASON_APIC_ID_MODIFIED) |		\
-	 BIT(APICV_INHIBIT_REASON_APIC_BASE_MODIFIED))
+	 BIT(APICV_INHIBIT_REASON_APIC_BASE_MODIFIED) |		\
+	 BIT(APICV_INHIBIT_REASON_TDX))
 
 struct kvm_x86_ops vt_x86_ops __initdata = {
 	.name = KBUILD_MODNAME,
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 38ce503611f0..20590b2bb330 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -2471,6 +2471,8 @@ static int __tdx_td_init(struct kvm *kvm, struct td_params *td_params,
 		goto teardown;
 	}
 
+	kvm_set_apicv_inhibit(kvm, APICV_INHIBIT_REASON_TDX);
+
 	return 0;
 
 	/*
@@ -2834,6 +2836,10 @@ static int tdx_td_vcpu_init(struct kvm_vcpu *vcpu, u64 vcpu_rcx)
 	}
 
 	vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
+
+	WARN_ON_ONCE(kvm_apicv_activated(vcpu->kvm));
+	vcpu->arch.apic->apicv_active = false;
+
 	return 0;
 
 free_tdvpx:
-- 
2.25.1

