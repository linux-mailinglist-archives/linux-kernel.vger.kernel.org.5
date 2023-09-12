Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2DF79D4E2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236382AbjILPcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236248AbjILPcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:32:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FBF10E2;
        Tue, 12 Sep 2023 08:32:02 -0700 (PDT)
Date:   Tue, 12 Sep 2023 15:31:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694532720;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PP5wRTRD08bVm357yqI9pRN4yJatwNf9xjVkvOAQadI=;
        b=0HEWXDPKtBkmaXtNCwDODf09lmg8Oek8U3TOVAIW7wKbmbUTv9HeOhqhugal5Y1wgZTZGf
        6H4O58IiBFakW35o16I+sJI0gNWSRvcgs9p6b4xvixtHQKKvpaXime57PxJscYKrnp6y19
        k9YHZGh+uQ3VvZwdI3Dn73LX7suGY45aP4SooLcwpD+PjOv7lzDXaaQwnbiAOXJmUxwIFn
        UxTmOQIEUcYfqSZl80qm+Ens6TYGqLkfv2EBhsf6zmFCSgvNsM9Ia2mk7WmVFz4uEYikxw
        U7Qel5g9t2A/jMI2GfXtI5VeHP4+pRyIz+GsX2/WmL948byeC8dA+JeK0I7lfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694532720;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PP5wRTRD08bVm357yqI9pRN4yJatwNf9xjVkvOAQadI=;
        b=VKuDCuYIf4KvkG0aPgbEp4mXjRpdaGDKWVyAfwcrnJ7vf0CTUrd2/1CMKFJAVNdouBRyO3
        G6nvpuX/lL9DAVBQ==
From:   "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/virt/tdx: Make TDX_MODULE_CALL handle SEAMCALL #UD and #GP
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Kai Huang <kai.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169453272013.27769.12828428554321636529.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     d6cb0f01644c5cd2bc51b88df933e07849cfaa76
Gitweb:        https://git.kernel.org/tip/d6cb0f01644c5cd2bc51b88df933e07849cfaa76
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Tue, 15 Aug 2023 23:02:05 +12:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 11 Sep 2023 16:35:04 -07:00

x86/virt/tdx: Make TDX_MODULE_CALL handle SEAMCALL #UD and #GP

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

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/de975832a367f476aab2d0eb0d9de66019a16b54.1692096753.git.kai.huang%40intel.com
---
 arch/x86/include/asm/tdx.h      |  4 ++++
 arch/x86/virt/vmx/tdx/tdxcall.S | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index a69bb7d..adcbe3f 100644
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
index 3f0b83a..016a2a1 100644
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
