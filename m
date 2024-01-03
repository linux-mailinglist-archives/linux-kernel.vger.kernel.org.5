Return-Path: <linux-kernel+bounces-15783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8248231F2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8518D28A041
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBCE1C28C;
	Wed,  3 Jan 2024 17:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="jvOCz2V+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17F41BDF1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mx0b-0016f401.pphosted.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4037XV5w020443;
	Wed, 3 Jan 2024 09:00:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=rUWlKryE
	b22Hs4Pknbtj0KZ4rivmTLmOvfofmKYCJ9o=; b=jvOCz2V+yeYee+v97KGlg+sg
	XsSMQOQrBMlp5perPvk7ONdWmmonzPBKt6XNIWPCZo8RMeBryVkL1e5eBzflETV9
	EpjwA4CW17E/nnoFSjyfQLC5pZteEQ4/WkAi0tc+7yL1nPZUSKrsNvtkGxlvA1iV
	UueT+47PU/C1NYR72JhaVTU2qp6r5nH5ErQ7lmmrwsgHZ3D6lNyTK141rnD+Cc08
	vRLXeiYw36ngwyh+4VccuBrdHQN+PBHQzNIRvbpm/+wcZdMBwwgBf9nwUMve0BUf
	iMyuGgHhzeXZf0v3jUhbHjs6/CxccPzurkcdaNKbSerdktU3EjKZqWlZLOkZoQ==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3vd39qaa6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 09:00:13 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 3 Jan
 2024 09:00:11 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 3 Jan 2024 09:00:11 -0800
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
	by maili.marvell.com (Postfix) with ESMTP id 8DF825B6932;
	Wed,  3 Jan 2024 09:00:08 -0800 (PST)
From: Elad Nachman <enachman@marvell.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <thunder.leizhen@huawei.com>,
        <bhe@redhat.com>, <akpm@linux-foundation.org>, <yajun.deng@linux.dev>,
        <chris.zjh@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: <enachman@marvell.com>
Subject: [PATCH] arm64: mm: Fix SOCs with DDR starting above zero
Date: Wed, 3 Jan 2024 19:00:02 +0200
Message-ID: <20240103170002.1793197-1-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1sQMRFjHCwKBbSEVaX6Mi0lWPunAi6je
X-Proofpoint-GUID: 1sQMRFjHCwKBbSEVaX6Mi0lWPunAi6je
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

From: Elad Nachman <enachman@marvell.com>

Some SOCs, like the Marvell AC5/X/IM, have a combination
of DDR starting at 0x2_0000_0000 coupled with DMA controllers
limited to 31 and 32 bit of addressing.
This requires to properly arrange ZONE_DMA and ZONE_DMA32 for
these SOCs, so swiotlb and coherent DMA allocation would work
properly.
Change initialization so device tree dma zone bits are taken as
function of offset from DRAM start, and when calculating the
maximal zone physical RAM address for physical DDR starting above
32-bit, combine the physical address start plus the zone mask
passed as parameter.
This creates the proper zone splitting for these SOCs:
0..2GB for ZONE_DMA
2GB..4GB for ZONE_DMA32
4GB..8GB for ZONE_NORMAL

Signed-off-by: Elad Nachman <enachman@marvell.com>
---
 arch/arm64/mm/init.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 74c1db8ce271..8288c778916e 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -115,20 +115,21 @@ static void __init arch_reserve_crashkernel(void)
 
 /*
  * Return the maximum physical address for a zone accessible by the given bits
- * limit. If DRAM starts above 32-bit, expand the zone to the maximum
- * available memory, otherwise cap it at 32-bit.
+ * limit. If DRAM starts above 32-bit, expand the zone to the available memory
+ * start limited by the zone bits mask, otherwise cap it at 32-bit.
  */
 static phys_addr_t __init max_zone_phys(unsigned int zone_bits)
 {
 	phys_addr_t zone_mask = DMA_BIT_MASK(zone_bits);
 	phys_addr_t phys_start = memblock_start_of_DRAM();
+	phys_addr_t phys_end = memblock_end_of_DRAM();
 
 	if (phys_start > U32_MAX)
-		zone_mask = PHYS_ADDR_MAX;
+		zone_mask = phys_start | zone_mask;
 	else if (phys_start > zone_mask)
 		zone_mask = U32_MAX;
 
-	return min(zone_mask, memblock_end_of_DRAM() - 1) + 1;
+	return min(zone_mask, phys_end - 1) + 1;
 }
 
 static void __init zone_sizes_init(void)
@@ -140,7 +141,16 @@ static void __init zone_sizes_init(void)
 
 #ifdef CONFIG_ZONE_DMA
 	acpi_zone_dma_bits = fls64(acpi_iort_dma_get_max_cpu_address());
-	dt_zone_dma_bits = fls64(of_dma_get_max_cpu_address(NULL));
+	/*
+	 * When calculating the dma zone bits from the device tree, subtract
+	 * the DRAM start address, in case it does not start from address
+	 * zero. This way. we pass only the zone size related bits to
+	 * max_zone_phys(), which will add them to the base of the DRAM.
+	 * This prevents miscalculations on arm64 SOCs which combines
+	 * DDR starting above 4GB with memory controllers limited to
+	 * 32-bits or less:
+	 */
+	dt_zone_dma_bits = fls64(of_dma_get_max_cpu_address(NULL) - memblock_start_of_DRAM());
 	zone_dma_bits = min3(32U, dt_zone_dma_bits, acpi_zone_dma_bits);
 	arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
 	max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
-- 
2.25.1


