Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B49275AE67
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjGTMa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjGTMaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:30:12 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094722690
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 05:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689856190; x=1721392190;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u4VXKW00l9nuZjzaABoEM8JPyms2bsYwqjtZoFsNtLc=;
  b=MEHojBK0zFkDLVZJND+HLmavDQjHCQmpLEDS+vn/vtmLW2HlHv12oN+v
   dTBopyTJyf4Y6FKm/sOh2lsqqu83SF4RYwHik/NfMha5Vs+6yhXOtLKWR
   THWt4SAmo2waYnYlrkxp53EGtM8CPSVw0olgxBe0yTU9o56RQwJPWWzle
   3saDuqOwtxLJAzq64+L3LdZ++1n9p64MAsqchOR5KBNqh9tNpoFCNJ3O7
   aCfg9P4FdIc0bVdfebDefmI+ut0ljYx06JBbCGiMndVJo0b3VGm31ops8
   xYnHC4GNiB+PDNvr3R9iZBt/W0yAlrz00SpysjVqE3zaXG7Y6EInAdr+2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="356678169"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="356678169"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 05:29:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="898255995"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="898255995"
Received: from moorer9x-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.209.157.3])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 05:29:28 -0700
From:   Kai Huang <kai.huang@intel.com>
To:     peterz@infradead.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com, kai.huang@intel.com
Subject: [PATCH v2 11/11] x86/virt/tdx: Allow SEAMCALL to handle #UD and #GP
Date:   Fri, 21 Jul 2023 00:28:14 +1200
Message-ID: <ae144939f2f6aa30c9620f61e67953db9dd4400c.1689855280.git.kai.huang@intel.com>
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

On the platform with the "partial write machine check" erratum, a kernel
partial write to TDX private memory may cause unexpected machine check.
It would be nice if the #MC handler could print additional information
to show the #MC was TDX private memory error due to possible kernel bug.

To do that, the machine check handler needs to use SEAMCALL to query
page type of the error memory from the TDX module, because there's no
existing infrastructure to track TDX private pages.

SEAMCALL instruction causes #UD if CPU isn't in VMX operation.  In #MC
handler, it is legal that CPU isn't in VMX operation when making this
SEAMCALL.  Extend the TDX_MODULE_CALL macro to handle #UD so the
SEAMCALL can return error code instead of Oops in the #MC handler.
Opportunistically handles #GP too since they share the same code.

A bonus is when kernel mistakenly calls SEAMCALL when CPU isn't in VMX
operation, or when TDX isn't enabled by the BIOS, or when the BIOS is
buggy, the kernel can get a nicer error message rather than a less
understandable Oops.

This is basically based on Peter's code.

Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kai Huang <kai.huang@intel.com>
---

v1 -> v2:
 - Skip saving output registers when SEAMCALL #UD/#GP

---
 arch/x86/include/asm/tdx.h      |  4 ++++
 arch/x86/virt/vmx/tdx/tdxcall.S | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 942edc8e9ba8..a51ca2bcd289 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -8,6 +8,7 @@
 
 #include <asm/errno.h>
 #include <asm/ptrace.h>
+#include <asm/trapnr.h>
 #include <asm/shared/tdx.h>
 
 /*
@@ -20,6 +21,9 @@
 #define TDX_SW_ERROR			(TDX_ERROR | GENMASK_ULL(47, 40))
 #define TDX_SEAMCALL_VMFAILINVALID	(TDX_SW_ERROR | _UL(0xFFFF0000))
 
+#define TDX_SEAMCALL_GP			(TDX_SW_ERROR | X86_TRAP_GP)
+#define TDX_SEAMCALL_UD			(TDX_SW_ERROR | X86_TRAP_UD)
+
 #ifndef __ASSEMBLY__
 
 /*
diff --git a/arch/x86/virt/vmx/tdx/tdxcall.S b/arch/x86/virt/vmx/tdx/tdxcall.S
index 3ed6d8b8d2a9..0eface625b59 100644
--- a/arch/x86/virt/vmx/tdx/tdxcall.S
+++ b/arch/x86/virt/vmx/tdx/tdxcall.S
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <asm/asm-offsets.h>
 #include <asm/frame.h>
+#include <asm/asm.h>
 #include <asm/tdx.h>
 
 /*
@@ -85,6 +86,7 @@
 .endif	/* \saved */
 
 .if \host
+.Lseamcall\@:
 	seamcall
 	/*
 	 * SEAMCALL instruction is essentially a VMExit from VMX root
@@ -192,11 +194,28 @@
 .if \host
 .Lseamcall_vmfailinvalid\@:
 	mov $TDX_SEAMCALL_VMFAILINVALID, %rax
+	jmp .Lseamcall_fail\@
+
+.Lseamcall_trap\@:
+	/*
+	 * SEAMCALL caused #GP or #UD.  By reaching here %eax contains
+	 * the trap number.  Convert the trap number to the TDX error
+	 * code by setting TDX_SW_ERROR to the high 32-bits of %rax.
+	 *
+	 * Note cannot OR TDX_SW_ERROR directly to %rax as OR instruction
+	 * only accepts 32-bit immediate at most.
+	 */
+	movq $TDX_SW_ERROR, %r12
+	orq  %r12, %rax
+
+.Lseamcall_fail\@:
 .if \ret && \saved
 	/* pop the unused structure pointer back to %rsi */
 	popq %rsi
 .endif
 	jmp .Lout\@
+
+	_ASM_EXTABLE_FAULT(.Lseamcall\@, .Lseamcall_trap\@)
 .endif	/* \host */
 
 .endm
-- 
2.41.0

