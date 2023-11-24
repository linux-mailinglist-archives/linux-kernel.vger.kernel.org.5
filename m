Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1E57F6D74
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 09:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjKXH7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 02:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbjKXH6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 02:58:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B9E10FE;
        Thu, 23 Nov 2023 23:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700812726; x=1732348726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7gIlli28NAJ1pKc76K/U/2zO+cqXE7s5YVtpL5cIwfg=;
  b=eJXHa7QA1l9R1PZXdQtJcCPceL0xdfop/+7crl8XQpogZ4QhIEVpsVId
   0kBNgkEB3Z7KnQSiXQudvdz2KAlBqJGMSYueaz7yMrfAZJ2NAUtZ6qjkX
   3eKl77MeQKadL0/edX5gtNcNLrgU9ZsZKRJW3sL+ebLKpGM0m5/3Ugdn2
   tJ3OMKGVZfBhiJC7kr75Zeuc0eutqvXztqtUCjDHneM3vLeElTFof3Vsc
   fARzBGwDuIbP+wKlYezrAwQpD55GdECoep1r9h9Z4dR7eXs3OmHcsJafE
   mSEt86guv8jff9pdEWU9EjGvxRS4orIqJWNn0eLP6CjsvC9s4YBQKD7Gy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="458872368"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="458872368"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 23:58:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="833629843"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="833629843"
Received: from unknown (HELO embargo.jf.intel.com) ([10.165.9.183])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 23:58:41 -0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     seanjc@google.com, pbonzini@redhat.com, dave.hansen@intel.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, mlevitsk@redhat.com,
        john.allen@amd.com, weijiang.yang@intel.com
Subject: [PATCH v7 17/26] KVM: x86: Report KVM supported CET MSRs as to-be-saved
Date:   Fri, 24 Nov 2023 00:53:21 -0500
Message-Id: <20231124055330.138870-18-weijiang.yang@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231124055330.138870-1-weijiang.yang@intel.com>
References: <20231124055330.138870-1-weijiang.yang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CET MSRs to the list of MSRs reported to userspace if the feature,
i.e. IBT or SHSTK, associated with the MSRs is supported by KVM.

SSP can only be read via RDSSP. Writing even requires destructive and
potentially faulting operations such as SAVEPREVSSP/RSTORSSP or
SETSSBSY/CLRSSBSY. Let the host use a pseudo-MSR that is just a wrapper
for the GUEST_SSP field of the VMCS.

Suggested-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
---
 arch/x86/include/uapi/asm/kvm_para.h |  1 +
 arch/x86/kvm/vmx/vmx.c               |  2 ++
 arch/x86/kvm/x86.c                   | 18 ++++++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
index 6e64b27b2c1e..9864bbcf2470 100644
--- a/arch/x86/include/uapi/asm/kvm_para.h
+++ b/arch/x86/include/uapi/asm/kvm_para.h
@@ -58,6 +58,7 @@
 #define MSR_KVM_ASYNC_PF_INT	0x4b564d06
 #define MSR_KVM_ASYNC_PF_ACK	0x4b564d07
 #define MSR_KVM_MIGRATION_CONTROL	0x4b564d08
+#define MSR_KVM_SSP	0x4b564d09
 
 struct kvm_steal_time {
 	__u64 steal;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index be20a60047b1..d3d0d74fef70 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7009,6 +7009,8 @@ static bool vmx_has_emulated_msr(struct kvm *kvm, u32 index)
 	case MSR_AMD64_TSC_RATIO:
 		/* This is AMD only.  */
 		return false;
+	case MSR_KVM_SSP:
+		return kvm_cpu_cap_has(X86_FEATURE_SHSTK);
 	default:
 		return true;
 	}
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 44b8cf459dfc..74d2d00a1681 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1476,6 +1476,9 @@ static const u32 msrs_to_save_base[] = {
 
 	MSR_IA32_XFD, MSR_IA32_XFD_ERR,
 	MSR_IA32_XSS,
+	MSR_IA32_U_CET, MSR_IA32_S_CET,
+	MSR_IA32_PL0_SSP, MSR_IA32_PL1_SSP, MSR_IA32_PL2_SSP,
+	MSR_IA32_PL3_SSP, MSR_IA32_INT_SSP_TAB,
 };
 
 static const u32 msrs_to_save_pmu[] = {
@@ -1576,6 +1579,7 @@ static const u32 emulated_msrs_all[] = {
 
 	MSR_K7_HWCR,
 	MSR_KVM_POLL_CONTROL,
+	MSR_KVM_SSP,
 };
 
 static u32 emulated_msrs[ARRAY_SIZE(emulated_msrs_all)];
@@ -7371,6 +7375,20 @@ static void kvm_probe_msr_to_save(u32 msr_index)
 		if (!kvm_caps.supported_xss)
 			return;
 		break;
+	case MSR_IA32_U_CET:
+	case MSR_IA32_S_CET:
+		if (!kvm_cpu_cap_has(X86_FEATURE_SHSTK) &&
+		    !kvm_cpu_cap_has(X86_FEATURE_IBT))
+			return;
+		break;
+	case MSR_IA32_INT_SSP_TAB:
+		if (!kvm_cpu_cap_has(X86_FEATURE_LM))
+			return;
+		fallthrough;
+	case MSR_IA32_PL0_SSP ... MSR_IA32_PL3_SSP:
+		if (!kvm_cpu_cap_has(X86_FEATURE_SHSTK))
+			return;
+		break;
 	default:
 		break;
 	}
-- 
2.27.0

