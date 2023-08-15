Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FD077CB75
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236686AbjHOLDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236612AbjHOLDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:03:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8FBE6B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 04:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692097380; x=1723633380;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KfA+OEQel2hlB9E3+pafaAI8n8ikzj6Tz1k0C8sfZTY=;
  b=a/7WHoUTJ1lMJ99aEzvj8VY9ZpFVUdyT1nBwIbQtsnNO3SWT+fH3DYdL
   HS46cvnysczqKhJwO+JIuzEHYgwrf4Cs+c5lY+MMd65zF6Bk9XFhPytAX
   VGh03JlJQUIR14kD4pMy/zSsZrhAQJ/CyTPoO//SanhOLOIAIxQATfoAK
   LkiZltCG7/OYWS8B5xoO4htwBdOgcETi06wXpL0ObB8URgBLCqxlPTdt2
   Qz1tc6P714sL4ZKAOxACEM70Dc6/LlaBi4Fz5mvwutpOrCCvhmTLI6pa1
   TL7IxzdjpTbpaUcasfOpyX1OHS7rB21rzJ9M089zyJTL5iR2Q2f/cpa8V
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="436148416"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="436148416"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 04:03:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="763236187"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="763236187"
Received: from fwafula-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.212.73.197])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 04:02:56 -0700
From:   Kai Huang <kai.huang@intel.com>
To:     peterz@infradead.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com, kai.huang@intel.com
Subject: [PATCH v4 12/12] x86/virt/tdx: Adjust 'struct tdx_module_args' to use x86 "register index" layout
Date:   Tue, 15 Aug 2023 23:02:06 +1200
Message-ID: <fb599b890b34c7d76c57543a784c281111ea0bf0.1692096753.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692096753.git.kai.huang@intel.com>
References: <cover.1692096753.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For TDX guest, KVM needs to call __seamcall_saved_ret() to make the
TDH.VP.ENTER SEAMCALL to enter the guest, possibly taking all registers
in 'struct tdx_module_args' as input/output.

KVM caches guest's GPRs in 'kvm_vcpu_arch::regs[]', which follows the
"register index" hardware layout of x86 GPRs.  On the other hand, the
__seamcall_saved_ret() takes the pointer of 'struct tdx_module_args' as
argument, thus there's a mismatch.

KVM could choose to copy input registers from 'vcpu::regs[]' to a
'struct tdx_module_args' and use that as argument to make the SEAMCALL,
but such memory copy isn't desired and should be avoided if possible.

It's not feasible to change KVM's 'vcpu::regs[]' layout due to various
reasons (e.g., emulation code uses decoded register index as array index
to access the register).  Therefore, adjust 'struct tdx_module_args' to
match KVM's 'vcpu::regs[]' layout so that KVM can simply do below:

	__seamcall_saved_ret(TDH_VP_ENTER,
			(struct tdx_module_args *)vcpu->arch.regs);

Note RAX/RSP/RBP are not used by the TDX_MODULE_CALL assembly, but they
are necessary in order to match the layout of 'struct tdx_module_args'
to KVM's 'vcpu::regs[]'.  Thus add them to the structure, but name them
as *_unused.  Also don't include them to asm-offset.c so that any misuse
of them in the assembly would result in build error.

Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Isaku Yamahata <isaku.yamahata@intel.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kai Huang <kai.huang@intel.com>
Tested-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 arch/x86/include/asm/shared/tdx.h | 19 +++++++++++++------
 arch/x86/kernel/asm-offsets.c     |  6 +++---
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 74fc466dfdcd..8d1427562c63 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -58,24 +58,31 @@
  * Used in __tdcall*() to gather the input/output registers' values of the
  * TDCALL instruction when requesting services from the TDX module. This is a
  * software only structure and not part of the TDX module/VMM ABI
+ *
+ * Note those *_unused are not used by the TDX_MODULE_CALL assembly.
+ * The layout of this structure also matches KVM's kvm_vcpu_arch::regs[]
+ * layout, which follows the "register index" order of x86 GPRs.  KVM
+ * then can simply type cast kvm_vcpu_arch::regs[] to this structure to
+ * avoid the extra memory copy between two structures when making
+ * TDH.VP.ENTER SEAMCALL.
  */
 struct tdx_module_args {
-	/* callee-clobbered */
+	u64 rax_unused;
 	u64 rcx;
 	u64 rdx;
+	u64 rbx;
+	u64 rsp_unused;
+	u64 rbp_unused;
+	u64 rsi;
+	u64 rdi;
 	u64 r8;
 	u64 r9;
-	/* extra callee-clobbered */
 	u64 r10;
 	u64 r11;
-	/* callee-saved + rdi/rsi */
 	u64 r12;
 	u64 r13;
 	u64 r14;
 	u64 r15;
-	u64 rbx;
-	u64 rdi;
-	u64 rsi;
 };
 
 /* Used to communicate with the TDX module */
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 6913b372ccf7..e4ad822d3acd 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -70,6 +70,9 @@ static void __used common(void)
 	BLANK();
 	OFFSET(TDX_MODULE_rcx, tdx_module_args, rcx);
 	OFFSET(TDX_MODULE_rdx, tdx_module_args, rdx);
+	OFFSET(TDX_MODULE_rbx, tdx_module_args, rbx);
+	OFFSET(TDX_MODULE_rsi, tdx_module_args, rsi);
+	OFFSET(TDX_MODULE_rdi, tdx_module_args, rdi);
 	OFFSET(TDX_MODULE_r8,  tdx_module_args, r8);
 	OFFSET(TDX_MODULE_r9,  tdx_module_args, r9);
 	OFFSET(TDX_MODULE_r10, tdx_module_args, r10);
@@ -78,9 +81,6 @@ static void __used common(void)
 	OFFSET(TDX_MODULE_r13, tdx_module_args, r13);
 	OFFSET(TDX_MODULE_r14, tdx_module_args, r14);
 	OFFSET(TDX_MODULE_r15, tdx_module_args, r15);
-	OFFSET(TDX_MODULE_rbx, tdx_module_args, rbx);
-	OFFSET(TDX_MODULE_rdi, tdx_module_args, rdi);
-	OFFSET(TDX_MODULE_rsi, tdx_module_args, rsi);
 
 	BLANK();
 	OFFSET(BP_scratch, boot_params, scratch);
-- 
2.41.0

