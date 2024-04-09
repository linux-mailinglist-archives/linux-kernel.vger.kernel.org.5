Return-Path: <linux-kernel+bounces-136283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5693C89D238
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87EDC1C212A6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F296A7172F;
	Tue,  9 Apr 2024 06:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="SUexIQz8"
Received: from mail.tkos.co.il (guitar.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E7D524AF;
	Tue,  9 Apr 2024 06:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712643504; cv=none; b=EeKCDzvCq08XfAVcQjySJm86ldQg2hS+U2RerxpmDoTPPwSD1G9lX8vf+sXg7iCqOdFA/WFJFomMcJoLKBvNwdIzuxLD9CuO79um/Efdf/9ShJsNcNtMd3GXBTyv9PKelgwuw9d1BhLr2bB0Czbl3gn8esokmvPUZy00mrDwNIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712643504; c=relaxed/simple;
	bh=R7K6bnEO9GvrFuZ5cBFijMFOruRQKScFkxZi8ojrTRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UXxhH/KOyLIjo0v7B+ttvaOzE24upXLbyKk6jN5lgihovaLs8lCX1EyZrFeG9z15pkO3LDfxAK8uwLS5vcMm7V4zXxDsLuOyvle/AhiUZFZKQ7/oGJyFJ9Hsvykz3ksTXxiS3uFYMb8MiTNw3LOL2GLYKRq5teE7y0NoinpfPPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=SUexIQz8; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id 48858440459;
	Tue,  9 Apr 2024 09:17:45 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1712643465;
	bh=R7K6bnEO9GvrFuZ5cBFijMFOruRQKScFkxZi8ojrTRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SUexIQz8PPD4zBDvys8qW4vICsMoWwrv/Gnfl1XbfryJUgAXmhmvGF4hBnq0rrs9u
	 dJkOWwvsTTJp49f/96CsJAOe7SVxyJYmn5IBK2tBlDDM4FQfyhOmfOsb7RCYJ7mGFQ
	 Z4pxD5uzbWSNMoTrZSEaMPdDEDESwEICV6BGapb1jO3WPznEXPBWQu8Uyy1eK7bhgh
	 VJ2vFMvDL4Ab8KkyRmwnBkXCZkJWEUa948eREug5DCra0Vd7D1+U+jx3rFF10m0DVj
	 SXe8/7ivvfBvgkUsoa+sOWN7M+3AT9z4tW1kFS6QMaNP60x6miJmpnTgoukgFTIE6O
	 pV1sS2D6zWaJw==
From: Baruch Siach <baruch@tkos.co.il>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Baruch Siach <baruch@tkos.co.il>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	=?UTF-8?q?Petr=20Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>,
	Ramon Fried <ramon@neureality.ai>,
	Elad Nachman <enachman@marvell.com>
Subject: [PATCH RFC v2 5/5] arm64: mm: take DMA zone offset into account
Date: Tue,  9 Apr 2024 09:17:58 +0300
Message-ID: <2fa9d7954a99b018a32314b9baab25ba18504f15.1712642324.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1712642324.git.baruch@tkos.co.il>
References: <cover.1712642324.git.baruch@tkos.co.il>
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
 arch/arm64/mm/init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 77e942ca578b..cd283ae0178d 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -128,9 +128,11 @@ static void __init zone_sizes_init(void)
 
 #ifdef CONFIG_ZONE_DMA
 	acpi_zone_dma_limit = acpi_iort_dma_get_max_cpu_address();
-	of_dma_get_cpu_limits(NULL, &dt_zone_dma_limit, NULL);
+	of_dma_get_cpu_limits(NULL, &dt_zone_dma_limit, &zone_dma_base);
 	zone_dma_limit = min(dt_zone_dma_limit, acpi_zone_dma_limit);
 	arm64_dma_phys_limit = max_zone_phys(zone_dma_limit);
+	if (zone_dma_base > U32_MAX)
+		dma32_phys_limit = arm64_dma_phys_limit;
 	max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
 #endif
 #ifdef CONFIG_ZONE_DMA32
-- 
2.43.0


