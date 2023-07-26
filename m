Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DED17634E2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbjGZL1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbjGZL1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:27:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2184F2D61
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690370803; x=1721906803;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PCqk/V8S9JuDbXKPeJIkYLpPXwKGYNM/R3Cxhj2/vcE=;
  b=bqmDYNbbmWA50IgNuv3M0xvtsYNJZoZwV6H2fwAzRDX0yriLXd1pxtbW
   b/xOwoizopnlJxLM7yEL9jt7Xva5lhBH1NCv9e9xrHrjhko1lKguebLLt
   87u3mae+Vn4OKnvfixk5qL+mlsTVNYccAjNEI8WfBwRLzoRinanjtG1wi
   owJadqOhzk0nTrATRlE9xfBXHyQeNFWeZmON5eg5DA4kWFk9keeQtpENf
   Q19hJx+v2YnjViL1qlW7QnAvPFSfGQAPaYZiIwteiQDm8lTxEy+wzeUdj
   Db0m9KNiPNn/EzPnMJN+Jjeys3CUv23hBcB8dNYDTnWQR7TaCHrhLZguf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="370664229"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="370664229"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 04:26:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="791811223"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="791811223"
Received: from bterry-mobl2.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.209.177.246])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 04:26:23 -0700
From:   Kai Huang <kai.huang@intel.com>
To:     peterz@infradead.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com, kai.huang@intel.com
Subject: [PATCH v3 11/12] x86/virt/tdx: Allow SEAMCALL to handle #UD and #GP
Date:   Wed, 26 Jul 2023 23:25:13 +1200
Message-ID: <659b10910c206cb4a8de314fcf7cd58814279aa6.1690369495.git.kai.huang@intel.com>
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

TDX memory has integrity and confidentiality protections.  Violations of
this integrity protection are supposed to only affect TDX operations and
are never supposed to affect the host kernel itself.  In other words,
the host kernel should never, itself, see machine checks induced by the
TDX integrity hardware.

Alas, the first few generations of TDX hardware have an erratum.  A
partial write to a TDX private memory cacheline will silently "poison"
the line.  Subsequent reads will consume the poison and generate a
machine check.  According to the TDX hardware spec, neither of these
things should have happened.

On the platform with this erratum, it would be nice if the #MC handler
could print additional information to show the #MC was TDX private
memory error due to possible kernel bug.

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
index 3ed6d8b8d2a9..ccb7ff08078a 100644
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
+	movq $TDX_SW_ERROR, %rdi
+	orq  %rdi, %rax
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

