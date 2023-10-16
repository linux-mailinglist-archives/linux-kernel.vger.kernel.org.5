Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C9C7CA454
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjJPJiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjJPJiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:38:05 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C72BDAB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:38:01 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8BxJvF1BC1lX0wyAA--.31733S3;
        Mon, 16 Oct 2023 17:37:57 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxiuR0BC1lzU0mAA--.16612S2;
        Mon, 16 Oct 2023 17:37:57 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH v1] LoongArch: Use SYM_CODE to annotate exception handlers
Date:   Mon, 16 Oct 2023 17:37:56 +0800
Message-Id: <1697449076-31866-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8DxiuR0BC1lzU0mAA--.16612S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW3GryDWF1kGr4kGr1rXry5trc_yoWxWw45p3
        43AFs8GrWqgFy3XFy3Cw4UArW7JanFgay29a1DXrZagwn2gF1vq340y393XF92gayUXF40
        9r1UAw1I9FW5JwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
        kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described in include/linux/linkage.h,

  FUNC -- C-like functions (proper stack frame etc.)
  CODE -- non-C code (e.g. irq handlers with different, special stack etc.)

  SYM_FUNC_START -- use for global functions
  SYM_CODE_START -- use for non-C (special) functions

use SYM_CODE to annotate exception handlers.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/include/asm/linkage.h |  8 ++++++++
 arch/loongarch/kernel/entry.S        |  4 ++--
 arch/loongarch/kernel/genex.S        | 16 ++++++++--------
 arch/loongarch/mm/tlbex.S            | 36 ++++++++++++++++++------------------
 4 files changed, 36 insertions(+), 28 deletions(-)

diff --git a/arch/loongarch/include/asm/linkage.h b/arch/loongarch/include/asm/linkage.h
index 81b0c4c..e2eca1a 100644
--- a/arch/loongarch/include/asm/linkage.h
+++ b/arch/loongarch/include/asm/linkage.h
@@ -33,4 +33,12 @@
 	.cfi_endproc;					\
 	SYM_END(name, SYM_T_FUNC)
 
+#define SYM_CODE_START(name)				\
+	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)	\
+	.cfi_startproc;
+
+#define SYM_CODE_END(name)				\
+	.cfi_endproc;					\
+	SYM_END(name, SYM_T_NONE)
+
 #endif
diff --git a/arch/loongarch/kernel/entry.S b/arch/loongarch/kernel/entry.S
index 65518bb..1ec8e4c 100644
--- a/arch/loongarch/kernel/entry.S
+++ b/arch/loongarch/kernel/entry.S
@@ -18,7 +18,7 @@
 	.text
 	.cfi_sections	.debug_frame
 	.align	5
-SYM_FUNC_START(handle_syscall)
+SYM_CODE_START(handle_syscall)
 	csrrd		t0, PERCPU_BASE_KS
 	la.pcrel	t1, kernelsp
 	add.d		t1, t1, t0
@@ -71,7 +71,7 @@ SYM_FUNC_START(handle_syscall)
 	bl		do_syscall
 
 	RESTORE_ALL_AND_RET
-SYM_FUNC_END(handle_syscall)
+SYM_CODE_END(handle_syscall)
 _ASM_NOKPROBE(handle_syscall)
 
 SYM_CODE_START(ret_from_fork)
diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
index 78f0663..2bb3aa2 100644
--- a/arch/loongarch/kernel/genex.S
+++ b/arch/loongarch/kernel/genex.S
@@ -31,7 +31,7 @@ SYM_FUNC_START(__arch_cpu_idle)
 1:	jr	ra
 SYM_FUNC_END(__arch_cpu_idle)
 
-SYM_FUNC_START(handle_vint)
+SYM_CODE_START(handle_vint)
 	BACKUP_T0T1
 	SAVE_ALL
 	la_abs	t1, __arch_cpu_idle
@@ -46,11 +46,11 @@ SYM_FUNC_START(handle_vint)
 	la_abs	t0, do_vint
 	jirl	ra, t0, 0
 	RESTORE_ALL_AND_RET
-SYM_FUNC_END(handle_vint)
+SYM_CODE_END(handle_vint)
 
-SYM_FUNC_START(except_vec_cex)
+SYM_CODE_START(except_vec_cex)
 	b	cache_parity_error
-SYM_FUNC_END(except_vec_cex)
+SYM_CODE_END(except_vec_cex)
 
 	.macro	build_prep_badv
 	csrrd	t0, LOONGARCH_CSR_BADV
@@ -66,7 +66,7 @@ SYM_FUNC_END(except_vec_cex)
 
 	.macro	BUILD_HANDLER exception handler prep
 	.align	5
-	SYM_FUNC_START(handle_\exception)
+	SYM_CODE_START(handle_\exception)
 	666:
 	BACKUP_T0T1
 	SAVE_ALL
@@ -76,7 +76,7 @@ SYM_FUNC_END(except_vec_cex)
 	jirl	ra, t0, 0
 	668:
 	RESTORE_ALL_AND_RET
-	SYM_FUNC_END(handle_\exception)
+	SYM_CODE_END(handle_\exception)
 	SYM_DATA(unwind_hint_\exception, .word 668b - 666b)
 	.endm
 
@@ -93,7 +93,7 @@ SYM_FUNC_END(except_vec_cex)
 	BUILD_HANDLER watch watch none
 	BUILD_HANDLER reserved reserved none	/* others */
 
-SYM_FUNC_START(handle_sys)
+SYM_CODE_START(handle_sys)
 	la_abs	t0, handle_syscall
 	jr	t0
-SYM_FUNC_END(handle_sys)
+SYM_CODE_END(handle_sys)
diff --git a/arch/loongarch/mm/tlbex.S b/arch/loongarch/mm/tlbex.S
index ca17dd3..d5d682f 100644
--- a/arch/loongarch/mm/tlbex.S
+++ b/arch/loongarch/mm/tlbex.S
@@ -17,7 +17,7 @@
 #define PTRS_PER_PTE_BITS	(PAGE_SHIFT - 3)
 
 	.macro tlb_do_page_fault, write
-	SYM_FUNC_START(tlb_do_page_fault_\write)
+	SYM_CODE_START(tlb_do_page_fault_\write)
 	SAVE_ALL
 	csrrd		a2, LOONGARCH_CSR_BADV
 	move		a0, sp
@@ -25,13 +25,13 @@
 	li.w		a1, \write
 	bl		do_page_fault
 	RESTORE_ALL_AND_RET
-	SYM_FUNC_END(tlb_do_page_fault_\write)
+	SYM_CODE_END(tlb_do_page_fault_\write)
 	.endm
 
 	tlb_do_page_fault 0
 	tlb_do_page_fault 1
 
-SYM_FUNC_START(handle_tlb_protect)
+SYM_CODE_START(handle_tlb_protect)
 	BACKUP_T0T1
 	SAVE_ALL
 	move		a0, sp
@@ -41,9 +41,9 @@ SYM_FUNC_START(handle_tlb_protect)
 	la_abs		t0, do_page_fault
 	jirl		ra, t0, 0
 	RESTORE_ALL_AND_RET
-SYM_FUNC_END(handle_tlb_protect)
+SYM_CODE_END(handle_tlb_protect)
 
-SYM_FUNC_START(handle_tlb_load)
+SYM_CODE_START(handle_tlb_load)
 	csrwr		t0, EXCEPTION_KS0
 	csrwr		t1, EXCEPTION_KS1
 	csrwr		ra, EXCEPTION_KS2
@@ -187,16 +187,16 @@ nopage_tlb_load:
 	csrrd		ra, EXCEPTION_KS2
 	la_abs		t0, tlb_do_page_fault_0
 	jr		t0
-SYM_FUNC_END(handle_tlb_load)
+SYM_CODE_END(handle_tlb_load)
 
-SYM_FUNC_START(handle_tlb_load_ptw)
+SYM_CODE_START(handle_tlb_load_ptw)
 	csrwr		t0, LOONGARCH_CSR_KS0
 	csrwr		t1, LOONGARCH_CSR_KS1
 	la_abs		t0, tlb_do_page_fault_0
 	jr		t0
-SYM_FUNC_END(handle_tlb_load_ptw)
+SYM_CODE_END(handle_tlb_load_ptw)
 
-SYM_FUNC_START(handle_tlb_store)
+SYM_CODE_START(handle_tlb_store)
 	csrwr		t0, EXCEPTION_KS0
 	csrwr		t1, EXCEPTION_KS1
 	csrwr		ra, EXCEPTION_KS2
@@ -343,16 +343,16 @@ nopage_tlb_store:
 	csrrd		ra, EXCEPTION_KS2
 	la_abs		t0, tlb_do_page_fault_1
 	jr		t0
-SYM_FUNC_END(handle_tlb_store)
+SYM_CODE_END(handle_tlb_store)
 
-SYM_FUNC_START(handle_tlb_store_ptw)
+SYM_CODE_START(handle_tlb_store_ptw)
 	csrwr		t0, LOONGARCH_CSR_KS0
 	csrwr		t1, LOONGARCH_CSR_KS1
 	la_abs		t0, tlb_do_page_fault_1
 	jr		t0
-SYM_FUNC_END(handle_tlb_store_ptw)
+SYM_CODE_END(handle_tlb_store_ptw)
 
-SYM_FUNC_START(handle_tlb_modify)
+SYM_CODE_START(handle_tlb_modify)
 	csrwr		t0, EXCEPTION_KS0
 	csrwr		t1, EXCEPTION_KS1
 	csrwr		ra, EXCEPTION_KS2
@@ -497,16 +497,16 @@ nopage_tlb_modify:
 	csrrd		ra, EXCEPTION_KS2
 	la_abs		t0, tlb_do_page_fault_1
 	jr		t0
-SYM_FUNC_END(handle_tlb_modify)
+SYM_CODE_END(handle_tlb_modify)
 
-SYM_FUNC_START(handle_tlb_modify_ptw)
+SYM_CODE_START(handle_tlb_modify_ptw)
 	csrwr		t0, LOONGARCH_CSR_KS0
 	csrwr		t1, LOONGARCH_CSR_KS1
 	la_abs		t0, tlb_do_page_fault_1
 	jr		t0
-SYM_FUNC_END(handle_tlb_modify_ptw)
+SYM_CODE_END(handle_tlb_modify_ptw)
 
-SYM_FUNC_START(handle_tlb_refill)
+SYM_CODE_START(handle_tlb_refill)
 	csrwr		t0, LOONGARCH_CSR_TLBRSAVE
 	csrrd		t0, LOONGARCH_CSR_PGD
 	lddir		t0, t0, 3
@@ -521,4 +521,4 @@ SYM_FUNC_START(handle_tlb_refill)
 	tlbfill
 	csrrd		t0, LOONGARCH_CSR_TLBRSAVE
 	ertn
-SYM_FUNC_END(handle_tlb_refill)
+SYM_CODE_END(handle_tlb_refill)
-- 
2.1.0

