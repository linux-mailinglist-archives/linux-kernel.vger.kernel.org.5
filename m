Return-Path: <linux-kernel+bounces-116886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D9B88A4D3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12A33300627
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2581BAC48;
	Mon, 25 Mar 2024 11:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/hKpDDf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100681BAC21
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 11:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711365231; cv=none; b=RzodYVjXy9a2NxqPduficj+tDheoHhYu1OOZLFEgaYcS7Ik1UQXW/0/VFxEyj5rA3iaI8UBLyDMWTD2nCytSy8krZ/1SHgwnv5oJony+vsREQotEXex7xxzQ6YOrbwc33rsp0VNi3lykQONzt4gIAO+XbdV+UiULwk3JYrGHbbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711365231; c=relaxed/simple;
	bh=sf6mJcuyNikMRdduR4UQlk6A2RQlNed9frvcHXQotOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ht293Pexmbq+B2s8BTwurXu1EPQQJOKzMKyJmTkupTTPAI538Ncnxbnz4nbVf59xK/QW8bWfSmJAUJxqSg4rqLlJAbl/dkEC+cw+GZb/Ht9Lk3muDdnJY3pEpyj4V3nKpHIH8bXEvEw7cIRJUZ4MDIpr+ekskszWKxk6mh3vKt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/hKpDDf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655F0C433C7;
	Mon, 25 Mar 2024 11:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711365230;
	bh=sf6mJcuyNikMRdduR4UQlk6A2RQlNed9frvcHXQotOo=;
	h=From:To:Cc:Subject:Date:From;
	b=b/hKpDDf2yVvm7N4rbZtQBjtnrHFpaBGU1tuIUV3FJrPb+AzjmE8ksDN3KwvvZBNK
	 rpjeuG8OYc0tAjZWSaqBai301lcOAGUOb/kKtkvvSapOkRqniavt6XXBfwCv1efMWW
	 zj/z0cvYEh87mR18EsFoD55kJ9kevJuUwm3r5UE5Wf7MACpyuBGPPZVxWuoHbcxHUZ
	 b9BCFopMO010/aVJYK9pSef+Kmzb4vH3wjCyhp5vKCME7LO/esuThbCG+utkHfeY5w
	 kdhDdrMCQdzr/6xCYMEdrWaES2E3qT6DttCFSDEgSs+jXE2HQJ56+GvLALTekJkiiG
	 RItNXxDm++hKA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v3 RESEND] riscv: mm: still create swiotlb buffer for kmalloc() bouncing if required
Date: Mon, 25 Mar 2024 19:00:36 +0800
Message-ID: <20240325110036.1564-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit f51f7a0fc2f4 ("riscv: enable DMA_BOUNCE_UNALIGNED_KMALLOC
for !dma_coherent"), for non-coherent platforms with less than 4GB
memory, we rely on users to pass "swiotlb=mmnn,force" kernel parameters
to enable DMA bouncing for unaligned kmalloc() buffers. Now let's go
further: If no bouncing needed for ZONE_DMA, let kernel automatically
allocate 1MB swiotlb buffer per 1GB of RAM for kmalloc() bouncing on
non-coherent platforms, so that no need to pass "swiotlb=mmnn,force"
any more.

The math of "1MB swiotlb buffer per 1GB of RAM for kmalloc() bouncing"
is taken from arm64. Users can still force smaller swiotlb buffer by
passing "swiotlb=mmnn".

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
since v2:
 - rebase on v6.8-rc1
 - collect Reviewed-by tag

since v1
 - fix build error if CONFIG_RISCV_DMA_NONCOHERENT=n

 arch/riscv/include/asm/cache.h |  2 +-
 arch/riscv/mm/init.c           | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/cache.h b/arch/riscv/include/asm/cache.h
index 2174fe7bac9a..570e9d8acad1 100644
--- a/arch/riscv/include/asm/cache.h
+++ b/arch/riscv/include/asm/cache.h
@@ -26,8 +26,8 @@
 
 #ifndef __ASSEMBLY__
 
-#ifdef CONFIG_RISCV_DMA_NONCOHERENT
 extern int dma_cache_alignment;
+#ifdef CONFIG_RISCV_DMA_NONCOHERENT
 #define dma_get_cache_alignment dma_get_cache_alignment
 static inline int dma_get_cache_alignment(void)
 {
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index fe8e159394d8..ac5e7f64c05c 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -161,11 +161,25 @@ static void print_vm_layout(void) { }
 
 void __init mem_init(void)
 {
+	bool swiotlb = max_pfn > PFN_DOWN(dma32_phys_limit);
 #ifdef CONFIG_FLATMEM
 	BUG_ON(!mem_map);
 #endif /* CONFIG_FLATMEM */
 
-	swiotlb_init(max_pfn > PFN_DOWN(dma32_phys_limit), SWIOTLB_VERBOSE);
+	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) && !swiotlb &&
+	    dma_cache_alignment != 1) {
+		/*
+		 * If no bouncing needed for ZONE_DMA, allocate 1MB swiotlb
+		 * buffer per 1GB of RAM for kmalloc() bouncing on
+		 * non-coherent platforms.
+		 */
+		unsigned long size =
+			DIV_ROUND_UP(memblock_phys_mem_size(), 1024);
+		swiotlb_adjust_size(min(swiotlb_size_or_default(), size));
+		swiotlb = true;
+	}
+
+	swiotlb_init(swiotlb, SWIOTLB_VERBOSE);
 	memblock_free_all();
 
 	print_vm_layout();
-- 
2.43.0


