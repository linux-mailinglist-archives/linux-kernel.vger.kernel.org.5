Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8147DB124
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjJ2XaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbjJ2X3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:29:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9910E325C;
        Sun, 29 Oct 2023 15:56:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A73C433C9;
        Sun, 29 Oct 2023 22:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620191;
        bh=1SHLZbshLGB8vLgpREn8v8IpnOkMDMDQ5Q3UAsfjWDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HML9sNK2FKKmiy/gboSiNaHO6S6oZWflLX+vHVivf1VBvdyaxpESLwwoQ/WLCHzlB
         s8Gog/BnWhobRM7cbt3/hN/SGsDUoMuvo6qfI53003e3/eZV1GHnAjCxBkrGtN3JE8
         YlEnPfPlHOPoY+cdVIVN5S8Dny7CJ2l5PG6VzHs498Vt6dK1IJZVNN2OC01NBy4HOb
         ZEQVrn64fANv8E+G4QeNmKnCnZAh90za37SzYOpv5ipcTzjcH9ezHZQLxup6zf+k6H
         57nf7S1PjVFVcNzCQHThdZ74XusocTB0k//OCpE02EhO+3ibKOkzjfzo8t2Li/TgFj
         P+m5u8rkQMWAg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Sasha Levin <sashal@kernel.org>, chenhuacai@kernel.org,
        zhoubinbin@loongson.cn, xry111@xry111.site, lihui@loongson.cn,
        zhangqing@loongson.cn, hejinyang@loongson.cn,
        tangyouling@loongson.cn, git@xen0n.name, yijun@loongson.cn,
        masahiroy@kernel.org, loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.5 40/52] LoongArch: Use SYM_CODE_* to annotate exception handlers
Date:   Sun, 29 Oct 2023 18:53:27 -0400
Message-ID: <20231029225441.789781-40-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225441.789781-1-sashal@kernel.org>
References: <20231029225441.789781-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.9
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tiezhu Yang <yangtiezhu@loongson.cn>

[ Upstream commit 00c2ca84c680f64b79b5e10a482ca435fd7d98ce ]

As described in include/linux/linkage.h,

  FUNC -- C-like functions (proper stack frame etc.)
  CODE -- non-C code (e.g. irq handlers with different, special stack etc.)

  SYM_FUNC_{START, END} -- use for global functions
  SYM_CODE_{START, END} -- use for non-C (special) functions

So use SYM_CODE_* to annotate exception handlers.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/include/asm/linkage.h |  8 +++++++
 arch/loongarch/kernel/entry.S        |  4 ++--
 arch/loongarch/kernel/genex.S        | 16 ++++++-------
 arch/loongarch/mm/tlbex.S            | 36 ++++++++++++++--------------
 4 files changed, 36 insertions(+), 28 deletions(-)

diff --git a/arch/loongarch/include/asm/linkage.h b/arch/loongarch/include/asm/linkage.h
index 81b0c4cfbf4f2..e2eca1a25b4ef 100644
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
index d737e3cf42d3f..1781c6a5befa2 100644
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
@@ -66,7 +66,7 @@ SYM_FUNC_START(handle_syscall)
 	bl		do_syscall
 
 	RESTORE_ALL_AND_RET
-SYM_FUNC_END(handle_syscall)
+SYM_CODE_END(handle_syscall)
 _ASM_NOKPROBE(handle_syscall)
 
 SYM_CODE_START(ret_from_fork)
diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
index 78f0663846575..2bb3aa2dcfcb2 100644
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
index ca17dd3a19153..d5d682f3d29f3 100644
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
2.42.0

