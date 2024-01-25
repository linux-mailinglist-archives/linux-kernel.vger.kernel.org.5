Return-Path: <linux-kernel+bounces-38799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F2083C623
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DB211F23E55
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A66E6EB56;
	Thu, 25 Jan 2024 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lq5ExDP+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C906EB43
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 15:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706195480; cv=none; b=q9z/Ply/I9g6bAbsJtILm8UZd+3GK3zjka5waVM1u+s5QE9ybV/DfMxFo2wro6Y8dnNIhPK/cXB8y9Tk6sOilidoqTCDTKdZNEI/kPqlAw6f7Ipaqafuiqtxvj5Vc9E8q/0iPefR4YCofVVmSH96ljrYL0q9vtgE05Ed6BA7U60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706195480; c=relaxed/simple;
	bh=VdSMPHq9c7sR9UiOhE5GzJdCBp/tPQFpSJmR+kQEo9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WteScnS9go6TnHWSf5Dol+aefMi/4lFFZdNYa+TpMl4x1HpGr0g/LeaVC+/UKM/4osGSQZFSime3i+iZ78ElXy3TUIHmCe9vm17ZRAC9nxo69jd1dPI7A2XQLAkCIAEeZxWt5INuKVDmEn9uRJSJwuuSli0defas5jqvtmwJMA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lq5ExDP+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72034C433C7;
	Thu, 25 Jan 2024 15:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706195480;
	bh=VdSMPHq9c7sR9UiOhE5GzJdCBp/tPQFpSJmR+kQEo9Y=;
	h=From:To:Cc:Subject:Date:From;
	b=Lq5ExDP+hnvKvAN5e33VVvQPicB2+YzePhlbp/M7p2hCzMHivadA/0gUlfi6N81OM
	 ijFt55wI5xvg4wl2ClkhJsmbcg/LmN++brzAPZ9zhYCqGehQVqPoM1Po8BjENfHo25
	 lHnSWb5LZL8pmHwCvErL4WQWyzCW3c84XuifN2MXDN+L4YlxtT9uJ4iSWjMV6G4+GZ
	 IZNXxvmEC95Af2vY6MEPYmpqoOYD1UKBS4w8MApj18YmRUaGvMV6Ty7OUD9N2ay1mL
	 NR6O4VJgcg1XJmz8AFRPvF0Ty131J/z3mYXYLexREcQQHoQvIsXbRGeW2kvDLuR0rK
	 /UhSMiuzyY2ew==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v3] riscv: mm: still create swiotlb buffer for kmalloc() bouncing if required
Date: Thu, 25 Jan 2024 22:58:31 +0800
Message-ID: <20240125145831.947-1-jszhang@kernel.org>
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
index 32cad6a65ccd..3359472df9a5 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -162,11 +162,25 @@ static void print_vm_layout(void) { }
 
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


