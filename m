Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70CE7634D7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbjGZL0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbjGZL0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:26:20 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2992689
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690370770; x=1721906770;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bwfKi5EE9C2gzXvAS9k/Py3iTVc4SoR4oreku6UrH+Q=;
  b=YkWS4KNiy3+YJ9o/zIkZu8E9CBK4Tjj3tZgkejL75HHqIM/MzNt3iY7r
   rMVOWOuZXulYbg7PMj0x9s6hL4eCLYsDppp90D34ON0lMPzIKdOI/UEij
   x8GoEDDJJmMyivsg7G0oyQtkmQ0Nn3omwV/ymeqwYYoXNyyp1lTkMtBGm
   h21nqiME8npXU0JZrnE1gaMUYfl/9ORA6eTBhhml7lj/PGgwEMmTFopPt
   bwuWs8Xxm6ONwvsv8miJYaaup/nYxqUktMRZzoDC21f2Q7zALBsglTFgv
   grSXR7/2j99KkWOFmVnk6NK8Md2pLF8O/0QoTd8KeUDA8yGZnltCIRwgm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="370664004"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="370664004"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 04:26:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="791811016"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="791811016"
Received: from bterry-mobl2.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.209.177.246])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 04:26:03 -0700
From:   Kai Huang <kai.huang@intel.com>
To:     peterz@infradead.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com, kai.huang@intel.com
Subject: [PATCH v3 05/12] x86/tdx: Pass TDCALL/SEAMCALL input/output registers via a structure
Date:   Wed, 26 Jul 2023 23:25:07 +1200
Message-ID: <fd9886e5fffe5ccccf5895627be2fff209a69049.1690369495.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690369495.git.kai.huang@intel.com>
References: <cover.1690369495.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the TDX_MODULE_CALL asm macro, which handles both TDCALL and
SEAMCALL, takes one parameter for each input register and an optional
'struct tdx_module_output' (a collection of output registers) as output.
This is different from the TDX_HYPERCALL macro which uses a single
'struct tdx_hypercall_args' to carry all input/output registers.

The newer TDX versions introduce more TDCALLs/SEAMCALLs which use more
input/output registers.  Also, the TDH.VP.ENTER (which isn't covered
by the current TDX_MODULE_CALL macro) basically can use all registers
that the TDX_HYPERCALL does.  The current TDX_MODULE_CALL macro isn't
extendible to cover those cases.

Similar to the TDX_HYPERCALL macro, simplify the TDX_MODULE_CALL macro
to use a single structure 'struct tdx_module_args' to carry all the
input/output registers.

Currently, the TDX_MODULE_CALL macro depends on the caller to pass a
non-NULL 'struct tdx_module_output' to get additional output registers.
Similar to the TDX_HYPERCALL macro, change the TDX_MODULE_CALL macro to
take a new 'ret' macro argument to indicate whether to save the output
registers to the 'struct tdx_module_args'.  Also introduce a new
__tdcall_ret() for that purpose, similar to the __tdx_hypercall_ret().

Note the tdcall(), which is a wrapper of __tdcall(), is called by three
callers: tdx_parse_tdinfo(), tdx_get_ve_info() and tdx_early_init().
The former two need the additional output but the last one doesn't.  For
simplicity, make tdcall() always call __tdcall_ret() to avoid another
"_ret()" wrapper.  The last caller tdx_early_init() isn't performance
critical anyway.

Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kai Huang <kai.huang@intel.com>
---

v2 -> v3:
 - No change.

v1 -> v2:
 - Code change due to patch 02.
 - Minor improvement in comments and changelog.

---
 arch/x86/coco/tdx/tdcall.S        | 47 ++++++----------
 arch/x86/coco/tdx/tdx-shared.c    |  6 +-
 arch/x86/coco/tdx/tdx.c           | 44 ++++++++-------
 arch/x86/include/asm/shared/tdx.h | 10 ++--
 arch/x86/kernel/asm-offsets.c     | 12 ++--
 arch/x86/virt/vmx/tdx/tdxcall.S   | 93 ++++++++++++-------------------
 6 files changed, 95 insertions(+), 117 deletions(-)

diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
index 6aebac08f2bf..56b9cd32895e 100644
--- a/arch/x86/coco/tdx/tdcall.S
+++ b/arch/x86/coco/tdx/tdcall.S
@@ -43,37 +43,10 @@
  * __tdcall()  - Used by TDX guests to request services from the TDX
  * module (does not include VMM services) using TDCALL instruction.
  *
- * Transforms function call register arguments into the TDCALL register ABI.
- * After TDCALL operation, TDX module output is saved in @out (if it is
- * provided by the user).
- *
- *-------------------------------------------------------------------------
- * TDCALL ABI:
- *-------------------------------------------------------------------------
- * Input Registers:
- *
- * RAX                 - TDCALL Leaf number.
- * RCX,RDX,R8-R9       - TDCALL Leaf specific input registers.
- *
- * Output Registers:
- *
- * RAX                 - TDCALL instruction error code.
- * RCX,RDX,R8-R11      - TDCALL Leaf specific output registers.
- *
- *-------------------------------------------------------------------------
- *
  * __tdcall() function ABI:
  *
- * @fn  (RDI)          - TDCALL Leaf ID,    moved to RAX
- * @rcx (RSI)          - Input parameter 1, moved to RCX
- * @rdx (RDX)          - Input parameter 2, moved to RDX
- * @r8  (RCX)          - Input parameter 3, moved to R8
- * @r9  (R8)           - Input parameter 4, moved to R9
- *
- * @out (R9)           - struct tdx_module_output pointer
- *                       stored temporarily in R12 (not
- *                       shared with the TDX module). It
- *                       can be NULL.
+ * @fn   (RDI)	- TDCALL Leaf ID, moved to RAX
+ * @args (RSI)	- struct tdx_module_args for input
  *
  * Return status of TDCALL via RAX.
  */
@@ -81,6 +54,22 @@ SYM_FUNC_START(__tdcall)
 	TDX_MODULE_CALL host=0
 SYM_FUNC_END(__tdcall)
 
+/*
+ * __tdcall_ret() - Used by TDX guests to request services from the TDX
+ * module (does not include VMM services) using TDCALL instruction, with
+ * saving output registers to the 'struct tdx_module_args' used as input.
+ *
+ * __tdcall_ret() function ABI:
+ *
+ * @fn   (RDI)	- TDCALL Leaf ID, moved to RAX
+ * @args (RSI)	- struct tdx_module_args for input and output
+ *
+ * Return status of TDCALL via RAX.
+ */
+SYM_FUNC_START(__tdcall_ret)
+	TDX_MODULE_CALL host=0 ret=1
+SYM_FUNC_END(__tdcall_ret)
+
 /*
  * TDX_HYPERCALL - Make hypercalls to a TDX VMM using TDVMCALL leaf of TDCALL
  * instruction
diff --git a/arch/x86/coco/tdx/tdx-shared.c b/arch/x86/coco/tdx/tdx-shared.c
index 90631abdac34..a7396d0ddef9 100644
--- a/arch/x86/coco/tdx/tdx-shared.c
+++ b/arch/x86/coco/tdx/tdx-shared.c
@@ -5,7 +5,7 @@ static unsigned long try_accept_one(phys_addr_t start, unsigned long len,
 				    enum pg_level pg_level)
 {
 	unsigned long accept_size = page_level_size(pg_level);
-	u64 tdcall_rcx;
+	struct tdx_module_args args = {};
 	u8 page_size;
 
 	if (!IS_ALIGNED(start, accept_size))
@@ -34,8 +34,8 @@ static unsigned long try_accept_one(phys_addr_t start, unsigned long len,
 		return 0;
 	}
 
-	tdcall_rcx = start | page_size;
-	if (__tdcall(TDG_MEM_PAGE_ACCEPT, tdcall_rcx, 0, 0, 0, NULL))
+	args.rcx = start | page_size;
+	if (__tdcall(TDG_MEM_PAGE_ACCEPT, &args))
 		return 0;
 
 	return accept_size;
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 8c13944925e3..2e19cc62e59e 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -66,10 +66,9 @@ EXPORT_SYMBOL_GPL(tdx_kvm_hypercall);
  * should only be used for calls that have no legitimate reason to fail
  * or where the kernel can not survive the call failing.
  */
-static inline void tdcall(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
-			  struct tdx_module_output *out)
+static inline void tdcall(u64 fn, struct tdx_module_args *args)
 {
-	if (__tdcall(fn, rcx, rdx, r8, r9, out))
+	if (__tdcall_ret(fn, args))
 		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
 }
 
@@ -89,11 +88,14 @@ static inline void tdcall(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
  */
 int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport)
 {
+	struct tdx_module_args args = {
+		.rcx = virt_to_phys(tdreport),
+		.rdx = virt_to_phys(reportdata),
+		.r8 = TDREPORT_SUBTYPE_0,
+	};
 	u64 ret;
 
-	ret = __tdcall(TDG_MR_REPORT, virt_to_phys(tdreport),
-			virt_to_phys(reportdata), TDREPORT_SUBTYPE_0,
-			0, NULL);
+	ret = __tdcall(TDG_MR_REPORT, &args);
 	if (ret) {
 		if (TDCALL_RETURN_CODE(ret) == TDCALL_INVALID_OPERAND)
 			return -EINVAL;
@@ -141,7 +143,7 @@ static void __noreturn tdx_panic(const char *msg)
 
 static void tdx_parse_tdinfo(u64 *cc_mask)
 {
-	struct tdx_module_output out;
+	struct tdx_module_args args = {};
 	unsigned int gpa_width;
 	u64 td_attr;
 
@@ -152,7 +154,7 @@ static void tdx_parse_tdinfo(u64 *cc_mask)
 	 * Guest-Host-Communication Interface (GHCI), section 2.4.2 TDCALL
 	 * [TDG.VP.INFO].
 	 */
-	tdcall(TDG_VP_INFO, 0, 0, 0, 0, &out);
+	tdcall(TDG_VP_INFO, &args);
 
 	/*
 	 * The highest bit of a guest physical address is the "sharing" bit.
@@ -161,7 +163,7 @@ static void tdx_parse_tdinfo(u64 *cc_mask)
 	 * The GPA width that comes out of this call is critical. TDX guests
 	 * can not meaningfully run without it.
 	 */
-	gpa_width = out.rcx & GENMASK(5, 0);
+	gpa_width = args.rcx & GENMASK(5, 0);
 	*cc_mask = BIT_ULL(gpa_width - 1);
 
 	/*
@@ -169,7 +171,7 @@ static void tdx_parse_tdinfo(u64 *cc_mask)
 	 * memory.  Ensure that no #VE will be delivered for accesses to
 	 * TD-private memory.  Only VMM-shared memory (MMIO) will #VE.
 	 */
-	td_attr = out.rdx;
+	td_attr = args.rdx;
 	if (!(td_attr & ATTR_SEPT_VE_DISABLE)) {
 		const char *msg = "TD misconfiguration: SEPT_VE_DISABLE attribute must be set.";
 
@@ -577,7 +579,7 @@ __init bool tdx_early_handle_ve(struct pt_regs *regs)
 
 void tdx_get_ve_info(struct ve_info *ve)
 {
-	struct tdx_module_output out;
+	struct tdx_module_args args = {};
 
 	/*
 	 * Called during #VE handling to retrieve the #VE info from the
@@ -594,15 +596,15 @@ void tdx_get_ve_info(struct ve_info *ve)
 	 * Note, the TDX module treats virtual NMIs as inhibited if the #VE
 	 * valid flag is set. It means that NMI=>#VE will not result in a #DF.
 	 */
-	tdcall(TDG_VP_VEINFO_GET, 0, 0, 0, 0, &out);
+	tdcall(TDG_VP_VEINFO_GET, &args);
 
 	/* Transfer the output parameters */
-	ve->exit_reason = out.rcx;
-	ve->exit_qual   = out.rdx;
-	ve->gla         = out.r8;
-	ve->gpa         = out.r9;
-	ve->instr_len   = lower_32_bits(out.r10);
-	ve->instr_info  = upper_32_bits(out.r10);
+	ve->exit_reason = args.rcx;
+	ve->exit_qual   = args.rdx;
+	ve->gla         = args.r8;
+	ve->gpa         = args.r9;
+	ve->instr_len   = lower_32_bits(args.r10);
+	ve->instr_info  = upper_32_bits(args.r10);
 }
 
 /*
@@ -759,6 +761,10 @@ static bool tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
 
 void __init tdx_early_init(void)
 {
+	struct tdx_module_args args = {
+		.rdx = TDCS_NOTIFY_ENABLES,
+		.r9 = -1ULL,
+	};
 	u64 cc_mask;
 	u32 eax, sig[3];
 
@@ -774,7 +780,7 @@ void __init tdx_early_init(void)
 	cc_set_mask(cc_mask);
 
 	/* Kernel does not use NOTIFY_ENABLES and does not need random #VEs */
-	tdcall(TDG_VM_WR, 0, TDCS_NOTIFY_ENABLES, 0, -1ULL, NULL);
+	tdcall(TDG_VM_WR, &args);
 
 	/*
 	 * All bits above GPA width are reserved and kernel treats shared bit
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 9e3699b751ef..1d338a401b88 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -74,22 +74,24 @@ static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
 void __tdx_hypercall_failed(void);
 
 /*
- * Used in __tdx_module_call() to gather the output registers' values of the
+ * Used in __tdcall*() to gather the input/output registers' values of the
  * TDCALL instruction when requesting services from the TDX module. This is a
  * software only structure and not part of the TDX module/VMM ABI
  */
-struct tdx_module_output {
+struct tdx_module_args {
+	/* input/output */
 	u64 rcx;
 	u64 rdx;
 	u64 r8;
 	u64 r9;
+	/* additional output */
 	u64 r10;
 	u64 r11;
 };
 
 /* Used to communicate with the TDX module */
-u64 __tdcall(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
-	     struct tdx_module_output *out);
+u64 __tdcall(u64 fn, struct tdx_module_args *args);
+u64 __tdcall_ret(u64 fn, struct tdx_module_args *args);
 
 bool tdx_accept_memory(phys_addr_t start, phys_addr_t end);
 
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index dc3576303f1a..50383bc46dd7 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -68,12 +68,12 @@ static void __used common(void)
 #endif
 
 	BLANK();
-	OFFSET(TDX_MODULE_rcx, tdx_module_output, rcx);
-	OFFSET(TDX_MODULE_rdx, tdx_module_output, rdx);
-	OFFSET(TDX_MODULE_r8,  tdx_module_output, r8);
-	OFFSET(TDX_MODULE_r9,  tdx_module_output, r9);
-	OFFSET(TDX_MODULE_r10, tdx_module_output, r10);
-	OFFSET(TDX_MODULE_r11, tdx_module_output, r11);
+	OFFSET(TDX_MODULE_rcx, tdx_module_args, rcx);
+	OFFSET(TDX_MODULE_rdx, tdx_module_args, rdx);
+	OFFSET(TDX_MODULE_r8,  tdx_module_args, r8);
+	OFFSET(TDX_MODULE_r9,  tdx_module_args, r9);
+	OFFSET(TDX_MODULE_r10, tdx_module_args, r10);
+	OFFSET(TDX_MODULE_r11, tdx_module_args, r11);
 
 	BLANK();
 	OFFSET(TDX_HYPERCALL_r8,  tdx_hypercall_args, r8);
diff --git a/arch/x86/virt/vmx/tdx/tdxcall.S b/arch/x86/virt/vmx/tdx/tdxcall.S
index 6bdf6e137953..a0e7fe81bf63 100644
--- a/arch/x86/virt/vmx/tdx/tdxcall.S
+++ b/arch/x86/virt/vmx/tdx/tdxcall.S
@@ -17,34 +17,33 @@
  *            TDX module and hypercalls to the VMM.
  * SEAMCALL - used by TDX hosts to make requests to the
  *            TDX module.
+ *
+ *-------------------------------------------------------------------------
+ * TDCALL/SEAMCALL ABI:
+ *-------------------------------------------------------------------------
+ * Input Registers:
+ *
+ * RAX                 - TDCALL/SEAMCALL Leaf number.
+ * RCX,RDX,R8-R9       - TDCALL/SEAMCALL Leaf specific input registers.
+ *
+ * Output Registers:
+ *
+ * RAX                 - TDCALL/SEAMCALL instruction error code.
+ * RCX,RDX,R8-R11      - TDCALL/SEAMCALL Leaf specific output registers.
+ *
+ *-------------------------------------------------------------------------
  */
-.macro TDX_MODULE_CALL host:req
+.macro TDX_MODULE_CALL host:req ret=0
 	FRAME_BEGIN
-	/*
-	 * R12 will be used as temporary storage for struct tdx_module_output
-	 * pointer. Since R12-R15 registers are not used by TDCALL/SEAMCALL
-	 * services supported by this function, it can be reused.
-	 */
-
-	/* Callee saved, so preserve it */
-	push %r12
-
-	/*
-	 * Push output pointer to stack.
-	 * After the operation, it will be fetched into R12 register.
-	 */
-	push %r9
 
-	/* Mangle function call ABI into TDCALL/SEAMCALL ABI: */
 	/* Move Leaf ID to RAX */
 	mov %rdi, %rax
-	/* Move input 4 to R9 */
-	mov %r8,  %r9
-	/* Move input 3 to R8 */
-	mov %rcx, %r8
-	/* Move input 1 to RCX */
-	mov %rsi, %rcx
-	/* Leave input param 2 in RDX */
+
+	/* Move other input regs from 'struct tdx_module_args' */
+	movq	TDX_MODULE_rcx(%rsi), %rcx
+	movq	TDX_MODULE_rdx(%rsi), %rdx
+	movq	TDX_MODULE_r8(%rsi), %r8
+	movq	TDX_MODULE_r9(%rsi), %r9
 
 .if \host
 	seamcall
@@ -59,49 +58,31 @@
 	 * This value will never be used as actual SEAMCALL error code as
 	 * it is from the Reserved status code class.
 	 */
-	jc .Lseamcall_vmfailinvalid
+	jc .Lseamcall_vmfailinvalid\@
 .else
 	tdcall
 .endif
 
-	/*
-	 * Fetch output pointer from stack to R12 (It is used
-	 * as temporary storage)
-	 */
-	pop %r12
-
-	/*
-	 * Since this macro can be invoked with NULL as an output pointer,
-	 * check if caller provided an output struct before storing output
-	 * registers.
-	 *
-	 * Update output registers, even if the call failed (RAX != 0).
-	 * Other registers may contain details of the failure.
-	 */
-	test %r12, %r12
-	jz .Lout
-
-	/* Copy result registers to output struct: */
-	movq %rcx, TDX_MODULE_rcx(%r12)
-	movq %rdx, TDX_MODULE_rdx(%r12)
-	movq %r8,  TDX_MODULE_r8(%r12)
-	movq %r9,  TDX_MODULE_r9(%r12)
-	movq %r10, TDX_MODULE_r10(%r12)
-	movq %r11, TDX_MODULE_r11(%r12)
-
-.Lout:
-	/* Restore the state of R12 register */
-	pop %r12
+.if \ret
+	/* Copy output registers to the structure */
+	movq %rcx, TDX_MODULE_rcx(%rsi)
+	movq %rdx, TDX_MODULE_rdx(%rsi)
+	movq %r8,  TDX_MODULE_r8(%rsi)
+	movq %r9,  TDX_MODULE_r9(%rsi)
+	movq %r10, TDX_MODULE_r10(%rsi)
+	movq %r11, TDX_MODULE_r11(%rsi)
+.endif
 
+.if \host
+.Lout\@:
+.endif
 	FRAME_END
 	RET
 
 .if \host
-.Lseamcall_vmfailinvalid:
+.Lseamcall_vmfailinvalid\@:
 	mov $TDX_SEAMCALL_VMFAILINVALID, %rax
-	/* pop the unused output pointer back to %r9 */
-	pop %r9
-	jmp .Lout
+	jmp .Lout\@
 .endif	/* \host */
 
 .endm
-- 
2.41.0

