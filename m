Return-Path: <linux-kernel+bounces-20295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F93827CF8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51DB9B23225
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090D228FD;
	Tue,  9 Jan 2024 02:46:00 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA22B257B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 02:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4T8Fd31BrYz1Q7Pj;
	Tue,  9 Jan 2024 10:44:23 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (unknown [7.193.23.147])
	by mail.maildlp.com (Postfix) with ESMTPS id 488B51402CB;
	Tue,  9 Jan 2024 10:45:54 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 10:45:53 +0800
From: Peng Zhang <zhangpeng362@huawei.com>
To: <hch@lst.de>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
	<petr.tesarik1@huawei-partners.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>,
	<zhangpeng362@huawei.com>
Subject: [PATCH v2] swiotlb: check alloc_size before the allocation of a new memory pool
Date: Tue, 9 Jan 2024 10:45:47 +0800
Message-ID: <20240109024547.3541529-1-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600020.china.huawei.com (7.193.23.147)

From: ZhangPeng <zhangpeng362@huawei.com>

The allocation request for swiotlb contiguous memory greater than
128*2KB cannot be fulfilled because it exceeds the maximum contiguous
memory limit. If the swiotlb memory we allocate is larger than 128*2KB,
swiotlb_find_slots() will still schedule the allocation of a new memory
pool, which will increase memory overhead.

Fix it by adding a check with alloc_size no more than 128*2KB before
scheduling the allocation of a new memory pool in swiotlb_find_slots().

Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
Reviewed-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
---
v1->v2:
- Rebased on for-next branch per Christoph Hellwig
- Added RB from Petr Tesarik

 kernel/dma/swiotlb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 97c298b210bc..b079a9a8e087 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1136,6 +1136,9 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 	int cpu, i;
 	int index;
 
+	if (alloc_size > IO_TLB_SEGSIZE * IO_TLB_SIZE)
+		return -1;
+
 	cpu = raw_smp_processor_id();
 	for (i = 0; i < default_nareas; ++i) {
 		index = swiotlb_search_area(dev, cpu, i, orig_addr, alloc_size,
-- 
2.25.1


