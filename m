Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256D077CB77
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236669AbjHOLDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236604AbjHOLC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:02:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12F7E6B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 04:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692097376; x=1723633376;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cSyfx3hnRQU1k3wALJQOySWn/MpRhvobP74R9g7vYM0=;
  b=EGAW2CGoNmlxgQ0ET4qaQAU5w1bk8MfKqTdYua+ZeZXMPP7RVVz5DjO0
   dU0r9XZFgSbxEKVKAX7unM3YV0Tsswnxr+lzxt3myKcqNTQVsVS6u/bm7
   N7TqO34NN4sq+q7AwbCrqMffN/4dsi0DlQ4dl+A05k98HYBkY49w+SrEA
   gVLLqLYC+vwNazNpgaaBuEm2VINqcIYh36ocA4UwUjFkljp+OIM35ZprP
   K7ZIB6LfibgydaCNjQSuo0SEEEsgZQyp6dPmg595Ys7qGsI0VkHQ07dt2
   9DUgHGd6axJLNZvfjyHHoFVoXePwfpgWYr0NpAWzpUUSULq0VUkxhGb2S
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="436148398"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="436148398"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 04:02:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="763236183"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="763236183"
Received: from fwafula-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.212.73.197])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 04:02:53 -0700
From:   Kai Huang <kai.huang@intel.com>
To:     peterz@infradead.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com, kai.huang@intel.com
Subject: [PATCH v4 11/12] x86/virt/tdx: Make TDX_MODULE_CALL handle SEAMCALL #UD and #GP
Date:   Tue, 15 Aug 2023 23:02:05 +1200
Message-ID: <de975832a367f476aab2d0eb0d9de66019a16b54.1692096753.git.kai.huang@intel.com>
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

SEAMCALL instruction causes #UD if the CPU isn't in VMX operation.
Currently the TDX_MODULE_CALL assembly doesn't handle #UD, thus making
SEAMCALL when VMX is disabled would cause Oops.

Unfortunately, there are legal cases that SEAMCALL can be made when VMX
is disabled.  For instance, VMX can be disabled due to emergency reboot
while there are still TDX guests running.

Extend the TDX_MODULE_CALL assembly to return an error code for #UD to
handle this case gracefully, e.g., KVM can then quietly eat all SEAMCALL
errors caused by emergency reboot.

SEAMCALL instruction also causes #GP when TDX isn't enabled by the BIOS.
Use _ASM_EXTABLE_FAULT() to catch both exceptions with the trap number
recorded, and define two new error codes by XORing the trap number to
the TDX_SW_ERROR.  This opportunistically handles #GP too while using
the same simple assembly code.

A bonus is when kernel mistakenly calls SEAMCALL when CPU isn't in VMX
operation, or when TDX isn't enabled by the BIOS, or when the BIOS is
buggy, the kernel can get a nicer error code rather than a less
understandable Oops.

This is basically based on Peter's code.

Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kai Huang <kai.huang@intel.com>
---

v3 -> v4:
 - Changed changelog to use emergency reboot as justification instead of
   the erratum.
 - Slight changed patch title to be more precise.
 
v2 -> v3:
 - Added more material to the changelog to explain the TDX erratum
  (hoping it can be merged together with this series).
 - Changed to use %rdi to hold $TDX_SW_ERROR instead of %r12 as the
   latter is callee-saved.

v1 -> v2:
 - Skip saving output registers when SEAMCALL #UD/#GP


---
 arch/x86/include/asm/tdx.h      |  4 ++++
 arch/x86/virt/vmx/tdx/tdxcall.S | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index a69bb7d3061b..adcbe3f1de30 100644
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
index 3f0b83a9977e..016a2a1ec1d6 100644
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
@@ -191,11 +193,28 @@
 .if \host
 .Lseamcall_vmfailinvalid\@:
 	mov $TDX_SEAMCALL_VMFAILINVALID, %rax
+	jmp .Lseamcall_fail\@
+
+.Lseamcall_trap\@:
+	/*
+	 * SEAMCALL caused #GP or #UD.  By reaching here RAX contains
+	 * the trap number.  Convert the trap number to the TDX error
+	 * code by setting TDX_SW_ERROR to the high 32-bits of RAX.
+	 *
+	 * Note cannot OR TDX_SW_ERROR directly to RAX as OR instruction
+	 * only accepts 32-bit immediate at most.
+	 */
+	movq $TDX_SW_ERROR, %rdi
+	orq  %rdi, %rax
+
+.Lseamcall_fail\@:
 .if \ret && \saved
 	/* pop the unused structure pointer back to RSI */
 	popq %rsi
 .endif
 	jmp .Lout\@
+
+	_ASM_EXTABLE_FAULT(.Lseamcall\@, .Lseamcall_trap\@)
 .endif	/* \host */
 
 .endm
-- 
2.41.0

