Return-Path: <linux-kernel+bounces-19660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 691CB827080
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07CE4283A32
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DEF46552;
	Mon,  8 Jan 2024 14:00:16 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C9346442
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 14:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4T7wdX71J2z1Q7sX;
	Mon,  8 Jan 2024 21:58:40 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (unknown [7.193.23.147])
	by mail.maildlp.com (Postfix) with ESMTPS id 9EF3C140416;
	Mon,  8 Jan 2024 22:00:11 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 22:00:10 +0800
From: Peng Zhang <zhangpeng362@huawei.com>
To: <hch@lst.de>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
	<petr.tesarik1@huawei-partners.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>,
	<zhangpeng362@huawei.com>
Subject: [PATCH] swiotlb: check alloc_size before the allocation of a new memory pool
Date: Mon, 8 Jan 2024 22:00:05 +0800
Message-ID: <20240108140005.3355316-1-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
---
 kernel/dma/swiotlb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 33d942615be5..cc92cff02c60 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1126,6 +1126,9 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 	u64 phys_limit;
 	int index;
 
+	if (alloc_size > IO_TLB_SEGSIZE * IO_TLB_SIZE)
+		return -1;
+
 	rcu_read_lock();
 	list_for_each_entry_rcu(pool, &mem->pools, node) {
 		index = swiotlb_pool_find_slots(dev, pool, orig_addr,
-- 
2.25.1


