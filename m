Return-Path: <linux-kernel+bounces-18803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AE382632F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 07:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47E8BB21CB0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 06:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E61134C5;
	Sun,  7 Jan 2024 06:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agAcaV/N"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2A612B83
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 06:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65CDC433C7;
	Sun,  7 Jan 2024 06:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704609053;
	bh=Bpr3cN4ZdKoHQcirLqVi0ln0qEuA20LN4TwxV/9UyIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=agAcaV/NvLQp39pnbxq5D6E3FwE2Kwp0XpWaz5aMDV3I4idAjyymK1ctu+sf4nhWS
	 KryA/Rv1bnzYa+sqzTyoCklXBMwfcoByx13WuGYsH7hOdoeC65nTGu1jvoU2atK2rW
	 9dKKWkvCl7wL1uw/b64Aov6lca1OdzHYKTYA8XNFMKhMY8rksmoWPRHEO+Iy75Wq0c
	 K1WPlv/dFlIWmbIWHvuVJPr+DEKOTQi4hjBfifT38XFMsF9ZDsFzrkeRauqlhLsyN1
	 L7IkKLk97GgFAkFu0zFiekkJDLVgUj1jln47xCpWyWHAiGGk8arh1tKhbYWLKsRSWs
	 jinIrjKHkMGsA==
From: guoren@kernel.org
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	alexghiti@rivosinc.com,
	charlie@rivosinc.com,
	guoren@kernel.org,
	panqinglin2020@iscas.ac.cn,
	bjorn@rivosinc.com,
	conor.dooley@microchip.com,
	leobras@redhat.com,
	cleger@rivosinc.com,
	willy@infradead.org
Cc: linux-kernel@vger.kernel.org,
	Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V4 4/4] riscv: mm: Optimize TASK_SIZE definition
Date: Sun,  7 Jan 2024 01:30:25 -0500
Message-Id: <20240107063025.1628475-5-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240107063025.1628475-1-guoren@kernel.org>
References: <20240107063025.1628475-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Guo Ren <guoren@linux.alibaba.com>

Unify the TASK_SIZE definition with VA_BITS for better readability.
Add COMPAT mode user address space info in the comment.

Reviewed-by: Leonardo Bras <leobras@redhat.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/pgtable.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index e415582276ec..271565e1956f 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -866,6 +866,7 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
  * Note that PGDIR_SIZE must evenly divide TASK_SIZE.
  * Task size is:
  * -        0x9fc00000	(~2.5GB) for RV32.
+ * -        0x80000000	(   2GB) for RV64 compat mode
  * -      0x4000000000	( 256GB) for RV64 using SV39 mmu
  * -    0x800000000000	( 128TB) for RV64 using SV48 mmu
  * - 0x100000000000000	(  64PB) for RV64 using SV57 mmu
@@ -877,10 +878,10 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
  * Similarly for SV57, bits 63–57 must be equal to bit 56.
  */
 #ifdef CONFIG_64BIT
-#define TASK_SIZE_64	(PGDIR_SIZE * PTRS_PER_PGD / 2)
+#define TASK_SIZE_64	(UL(1) << (VA_BITS - 1))
 
 #ifdef CONFIG_COMPAT
-#define TASK_SIZE_32	(_AC(0x80000000, UL))
+#define TASK_SIZE_32	(UL(1) << (VA_BITS_SV32 - 1))
 #define TASK_SIZE	(test_thread_flag(TIF_32BIT) ? \
 			 TASK_SIZE_32 : TASK_SIZE_64)
 #else
-- 
2.40.1


