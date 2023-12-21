Return-Path: <linux-kernel+bounces-8706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDE381BB48
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B14371C25F4F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EBC59905;
	Thu, 21 Dec 2023 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhWq7HNl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD9458215
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 15:47:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FAB8C433CC;
	Thu, 21 Dec 2023 15:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703173645;
	bh=AsvVmmiuGWBFu5stNq3XoYXyaKfmZAWOgztQ+Ek0sqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uhWq7HNl8+B0YhiTGUMxZjDlYDFYfy7vtI+h7lvAxn2hltTLuvJqzyS9lA/OSTMQ0
	 j/bRnzscfA31jLF0OIf5dpyilmyauPu/t8bsZprZPn/fTJSo8BvWwOh+dZXoX5KH7U
	 3Q2TrfEKJzGctJ3WbHBq/y/ehYU4EvRzS0xyLxbDLJO8CwhMQZhtsL7VBEVK1b6HjW
	 QRFIwyuTmIHOEffqdhjB93JeIiBsMZFxYWtGK0x4+Sxi/pfczeoY2E6FJdQUNlfPN9
	 7X6ptv0pxxlOjUC0t5dE/n9RDR+UOaYXjMozP+dC1l2Tb1OToPPtbQaU9CGN/MjHpd
	 6446AbwEvSzUw==
From: guoren@kernel.org
To: linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	alexghiti@rivosinc.com,
	charlie@rivosinc.com,
	xiao.w.wang@intel.com,
	guoren@kernel.org,
	david@redhat.com,
	panqinglin2020@iscas.ac.cn,
	rick.p.edgecombe@intel.com,
	willy@infradead.org,
	bjorn@rivosinc.com,
	conor.dooley@microchip.com,
	cleger@rivosinc.com,
	leobras@redhat.com
Cc: linux-riscv@lists.infradead.org,
	Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2 4/4] riscv: mm: Optimize TASK_SIZE definition
Date: Thu, 21 Dec 2023 10:47:01 -0500
Message-Id: <20231221154702.2267684-5-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231221154702.2267684-1-guoren@kernel.org>
References: <20231221154702.2267684-1-guoren@kernel.org>
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

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/pgtable.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index e415582276ec..d165ddae3b42 100644
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
@@ -877,11 +878,11 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
  * Similarly for SV57, bits 63–57 must be equal to bit 56.
  */
 #ifdef CONFIG_64BIT
-#define TASK_SIZE_64	(PGDIR_SIZE * PTRS_PER_PGD / 2)
+#define TASK_SIZE_64	(UL(1) << (VA_BITS - 1))
 
 #ifdef CONFIG_COMPAT
-#define TASK_SIZE_32	(_AC(0x80000000, UL))
-#define TASK_SIZE	(test_thread_flag(TIF_32BIT) ? \
+#define TASK_SIZE_32	(UL(1) << (VA_BITS_SV32 - 1))
+#define TASK_SIZE	(is_compat_task() ? \
 			 TASK_SIZE_32 : TASK_SIZE_64)
 #else
 #define TASK_SIZE	TASK_SIZE_64
-- 
2.40.1


