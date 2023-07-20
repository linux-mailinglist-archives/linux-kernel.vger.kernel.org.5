Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B4575AE59
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjGTM3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjGTM26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:28:58 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9A92135
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 05:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689856137; x=1721392137;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ct+uL9V/Rc7tnRZgZAKb4rgrX0FhggxsItIZrGpJOi4=;
  b=HQkGyYutT8qKsBmXjioFCPRqSb4C8WGWuZ2DBibErz6HHheiB9G8+U4U
   JGoRC/o/arNsUvnQmzgOaC/j+JMlH10KdpTBhhZFV09Isb6hzkqAZwwhg
   pQtKONfO7H0XhCIL6sZPwSc5wcxvKT2zj2DNcHgkb0QkGnQEQuS0FTth+
   HFMJMvAO1Vs5zty0tHAIhHb2o47pr3jTzsOGHGtPMxKL5UIjzGzw/jzOO
   iRecd8cST/aHUVHOVzTwiXjja5K7RlxP0fCwOw8B2FsVNOGFYNc/LACOy
   oVYQwvT86qpLn9KSDy7ba7O0/P8fLeit8EimfYqnMbp1sgQ4+DBv0lB0I
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="356677956"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="356677956"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 05:28:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="898255871"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="898255871"
Received: from moorer9x-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.209.157.3])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 05:28:53 -0700
From:   Kai Huang <kai.huang@intel.com>
To:     peterz@infradead.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com, kai.huang@intel.com
Subject: [PATCH v2 02/11] x86/tdx: Skip saving output regs when SEAMCALL fails with VMFailInvalid
Date:   Fri, 21 Jul 2023 00:28:05 +1200
Message-ID: <a87cdb87489a533601fb42599275f6a8eb603b04.1689855280.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689855280.git.kai.huang@intel.com>
References: <cover.1689855280.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If SEAMCALL fails with VMFailInvalid, the SEAM software (e.g., the TDX
module) won't have chance to set any output register.  Skip saving the
output registers to the structure in this case.

Also, as '.Lno_output_struct' is the very last symbol before RET, rename
it to '.Lout' to make it short.

Opportunistically make the asm directives unindented.

Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kai Huang <kai.huang@intel.com>
---

v1 -> v2:
 - A new patch to improve SEAMCALL VMFailInvalid failure, with v1 patch
   "x86/tdx: Move FRAME_BEGIN/END to TDX_MODULE_CALL asm macro" merged.

---
 arch/x86/coco/tdx/tdcall.S      |  3 ---
 arch/x86/virt/vmx/tdx/tdxcall.S | 29 ++++++++++++++++++++---------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
index 2eca5f43734f..e5d4b7d8ecd4 100644
--- a/arch/x86/coco/tdx/tdcall.S
+++ b/arch/x86/coco/tdx/tdcall.S
@@ -78,10 +78,7 @@
  * Return status of TDCALL via RAX.
  */
 SYM_FUNC_START(__tdx_module_call)
-	FRAME_BEGIN
 	TDX_MODULE_CALL host=0
-	FRAME_END
-	RET
 SYM_FUNC_END(__tdx_module_call)
 
 /*
diff --git a/arch/x86/virt/vmx/tdx/tdxcall.S b/arch/x86/virt/vmx/tdx/tdxcall.S
index 49a54356ae99..6bdf6e137953 100644
--- a/arch/x86/virt/vmx/tdx/tdxcall.S
+++ b/arch/x86/virt/vmx/tdx/tdxcall.S
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <asm/asm-offsets.h>
+#include <asm/frame.h>
 #include <asm/tdx.h>
 
 /*
@@ -18,6 +19,7 @@
  *            TDX module.
  */
 .macro TDX_MODULE_CALL host:req
+	FRAME_BEGIN
 	/*
 	 * R12 will be used as temporary storage for struct tdx_module_output
 	 * pointer. Since R12-R15 registers are not used by TDCALL/SEAMCALL
@@ -44,7 +46,7 @@
 	mov %rsi, %rcx
 	/* Leave input param 2 in RDX */
 
-	.if \host
+.if \host
 	seamcall
 	/*
 	 * SEAMCALL instruction is essentially a VMExit from VMX root
@@ -57,13 +59,10 @@
 	 * This value will never be used as actual SEAMCALL error code as
 	 * it is from the Reserved status code class.
 	 */
-	jnc .Lno_vmfailinvalid
-	mov $TDX_SEAMCALL_VMFAILINVALID, %rax
-.Lno_vmfailinvalid:
-
-	.else
+	jc .Lseamcall_vmfailinvalid
+.else
 	tdcall
-	.endif
+.endif
 
 	/*
 	 * Fetch output pointer from stack to R12 (It is used
@@ -80,7 +79,7 @@
 	 * Other registers may contain details of the failure.
 	 */
 	test %r12, %r12
-	jz .Lno_output_struct
+	jz .Lout
 
 	/* Copy result registers to output struct: */
 	movq %rcx, TDX_MODULE_rcx(%r12)
@@ -90,7 +89,19 @@
 	movq %r10, TDX_MODULE_r10(%r12)
 	movq %r11, TDX_MODULE_r11(%r12)
 
-.Lno_output_struct:
+.Lout:
 	/* Restore the state of R12 register */
 	pop %r12
+
+	FRAME_END
+	RET
+
+.if \host
+.Lseamcall_vmfailinvalid:
+	mov $TDX_SEAMCALL_VMFAILINVALID, %rax
+	/* pop the unused output pointer back to %r9 */
+	pop %r9
+	jmp .Lout
+.endif	/* \host */
+
 .endm
-- 
2.41.0

