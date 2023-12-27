Return-Path: <linux-kernel+bounces-12077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9128981EFB1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0066D1F222DF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 15:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762FD45C0A;
	Wed, 27 Dec 2023 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="NxNyJc+I"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.tkos.co.il (mail.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB5A4594F;
	Wed, 27 Dec 2023 15:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Received: from tarshish.tkos.co.il (unknown [10.0.8.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id 83D11440F4F;
	Wed, 27 Dec 2023 17:02:44 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1703689364;
	bh=z/R1KgqdKS7NyxMFjGVmdIDGKoIBS1QfbhFNrs3Fnbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NxNyJc+IY8RZrFmWwyP1yFuErwO6dUxa893heT/GsEdHBoJSid19eX8xWM4HFb1vh
	 Tb1WRVA0fGMIvU7ofAVvI8euZs3sZyT3MJao8Svo6d0Ey4smRJZkOUB3lc3Usiy9Ec
	 9h/aOPBmjcxWrfCbFHxxe2SzF8IIuwFbEoAxy7qX0HeeH6bArOLQNjEFdSS15LEhjG
	 6JvO61GhQB8nCCrYzuYHnsOE0XzMmzmQ+cOjLbto2inSFTfw9F53XOhBM1LMGmx7oa
	 UioelDo5PlbEIUGcplg4IFzjWB/YoP6iaQIjYrI/ay6trFf02fqvkv5k4f56mKm4hW
	 PiOD+SINQYQ6A==
From: Baruch Siach <baruch@tkos.co.il>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Baruch Siach <baruch@tkos.co.il>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Petr=20Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>,
	Ramon Fried <ramon@neureality.ai>
Subject: [PATCH RFC 4/4] arm64: mm: take DMA zone offset into account
Date: Wed, 27 Dec 2023 17:04:28 +0200
Message-ID: <c6dbd432196c4ba5f390845db14b1a422cc77d4c.1703683642.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1703683642.git.baruch@tkos.co.il>
References: <cover.1703683642.git.baruch@tkos.co.il>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 791ab8b2e3db ("arm64: Ignore any DMA offsets in the
max_zone_phys() calculation") made DMA/DMA32 zones span the entire RAM
when RAM starts above 32-bits. This breaks hardware with DMA area that
start above 32-bits. But the commit log says that "we haven't noticed
any such hardware". It turns out that such hardware does exist.

One such platform has RAM starting at 32GB with an internal bus that has
the following DMA limits:

  #address-cells = <2>;
  #size-cells = <2>;
  dma-ranges = <0x00 0xc0000000 0x08 0x00000000 0x00 0x40000000>;

Devices under this bus can see 1GB of DMA range between 3GB-4GB in each
device address space. This range is mapped to CPU memory at 32GB-33GB.
With current code DMA allocations for devices under this bus are not
limited to DMA area, leading to run-time allocation failure.

Modify 'zone_dma_bits' calculation (via dt_zone_dma_bits) to only cover
the actual DMA area starting at 'zone_dma_off'. Use the newly introduced
'min' parameter of of_dma_get_cpu_limits() to set 'zone_dma_off'.

DMA32 zone is useless in this configuration, so make its limit the same
as the DMA zone when the lower DMA limit is higher than 32-bits.

The result is DMA zone that properly reflects the hardware constraints
as follows:

[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000800000000-0x000000083fffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   [mem 0x0000000840000000-0x0000000bffffffff]

Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm64/mm/init.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index d6c723ae6fb0..4a8fd8394ce6 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -118,10 +118,11 @@ static void __init arch_reserve_crashkernel(void)
  * limit. If DRAM starts above 32-bit, expand the zone to the maximum
  * available memory, otherwise cap it at 32-bit.
  */
-static phys_addr_t __init max_zone_phys(unsigned int zone_bits)
+static phys_addr_t __init max_zone_phys(unsigned int zone_bits,
+		phys_addr_t zone_off)
 {
 	phys_addr_t zone_mask = DMA_BIT_MASK(zone_bits);
-	phys_addr_t phys_start = memblock_start_of_DRAM();
+	phys_addr_t phys_start = memblock_start_of_DRAM() - zone_off;
 
 	if (phys_start > U32_MAX)
 		zone_mask = PHYS_ADDR_MAX;
@@ -137,14 +138,19 @@ static void __init zone_sizes_init(void)
 	unsigned int __maybe_unused acpi_zone_dma_bits;
 	unsigned int __maybe_unused dt_zone_dma_bits;
 	phys_addr_t __maybe_unused max_cpu_address;
-	phys_addr_t __maybe_unused dma32_phys_limit = max_zone_phys(32);
+	phys_addr_t __maybe_unused min_cpu_address;
+	phys_addr_t __maybe_unused dma32_phys_limit = max_zone_phys(32, 0);
 
 #ifdef CONFIG_ZONE_DMA
 	acpi_zone_dma_bits = fls64(acpi_iort_dma_get_max_cpu_address());
-	of_dma_get_cpu_limits(NULL, &max_cpu_address, NULL);
-	dt_zone_dma_bits = fls64(max_cpu_address);
+	of_dma_get_cpu_limits(NULL, &max_cpu_address, &min_cpu_address);
+	dt_zone_dma_bits = fls64(max_cpu_address - min_cpu_address);
 	zone_dma_bits = min3(32U, dt_zone_dma_bits, acpi_zone_dma_bits);
-	arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
+	zone_dma_off = min_cpu_address;
+	arm64_dma_phys_limit = max_zone_phys(zone_dma_bits, zone_dma_off)
+		+ zone_dma_off;
+	if (zone_dma_off > U32_MAX)
+		dma32_phys_limit = arm64_dma_phys_limit;
 	max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
 #endif
 #ifdef CONFIG_ZONE_DMA32
-- 
2.43.0


