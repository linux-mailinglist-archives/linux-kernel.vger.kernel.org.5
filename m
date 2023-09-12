Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A7779D4F5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236508AbjILPcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236408AbjILPcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:32:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A03810E3;
        Tue, 12 Sep 2023 08:32:06 -0700 (PDT)
Date:   Tue, 12 Sep 2023 15:32:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694532725;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=K97jYLZQiggbcOskDIL09Azt3us2kUi04HAnPmdVB4o=;
        b=2F0sir8+6ax7w1bbfdW9Lg53VZyVY67kPQUiJ9ZD0Xv759otJF5jSGxfpi0QX9jhn69tVZ
        nHKhbuYng4Jtutr1nzsx46J81F0ydQI6JbqLx4l1gf5HMFcZ1aa34vC7EbIbmWAIO/jy3W
        uiYOOiF0gn7deWlXEDUL5yfoj9/6BiqdJllj4157HrMBelXomH1mIhwAG1NO47ithrCz7g
        572mDIocFsQx3MQl0HMhtJ0qht9CDcEaDqVUNBtS1Z5Sv5arOCw/ECPGWtUu8PRstmBOPN
        xAyM3/Gcjg/gYScTDmjcy1cl+jccROwGfvQR1MRkwpnFHwDRs1ehz0hFNDrLuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694532725;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=K97jYLZQiggbcOskDIL09Azt3us2kUi04HAnPmdVB4o=;
        b=ok6CW6Xiqj6tX7KpdjI3QGVM+QQChDoK3lktM4/OK8/+oPiARCFu70XwqZiaSY75IdBVfi
        8+cy+zf7kdrT1zAA==
From:   "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Skip saving output regs when SEAMCALL fails
 with VMFailInvalid
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Kai Huang <kai.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169453272448.27769.14213285124047968939.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     03a423d40cb30e0e1cb77a801acb56ddb0bf6f5e
Gitweb:        https://git.kernel.org/tip/03a423d40cb30e0e1cb77a801acb56ddb0bf6f5e
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Tue, 15 Aug 2023 23:01:56 +12:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 11 Sep 2023 16:32:23 -07:00

x86/tdx: Skip saving output regs when SEAMCALL fails with VMFailInvalid

If SEAMCALL fails with VMFailInvalid, the SEAM software (e.g., the TDX
module) won't have chance to set any output register.  Skip saving the
output registers to the structure in this case.

Also, as '.Lno_output_struct' is the very last symbol before RET, rename
it to '.Lout' to make it short.

Opportunistically make the asm directives unindented.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/704088f5b4d72c7e24084f7f15bd1ac5005b7213.1692096753.git.kai.huang%40intel.com
---
 arch/x86/coco/tdx/tdcall.S      |  3 ---
 arch/x86/virt/vmx/tdx/tdxcall.S | 29 ++++++++++++++++++++---------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
index 2eca5f4..e5d4b7d 100644
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
index 49a5435..6bdf6e1 100644
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
