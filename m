Return-Path: <linux-kernel+bounces-127331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C592A8949DC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 05:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FF7C283E83
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 03:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405B714AB4;
	Tue,  2 Apr 2024 03:11:09 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3A54C96
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 03:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712027468; cv=none; b=ec4s0CNnb/SZayvujSSKyoc5jbUQCrYieaUVMj0KT0Zw6X0W9NhnYphyY/M0rowNWtccBWiH1exwyf2rZU9mqEkevc/AzPpAOX5N+1gY6CpyAFKQUS18G2TxkAubbv6LFp4Du8UY8kO7PYIrP1fh93FE8o38TcpwI8YjE/3B1Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712027468; c=relaxed/simple;
	bh=lPYQzZyLPSJrBGpypklNNkVEZMcWl3CnRL3VJNsHg9E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FIl7XN6TK2n/xF+wwc+UErXgRQ6Hx/xinNym3yI5dWsKnd9sNfxz/xLLNDd4YkuMe/6XnMthKmQjUCUpnxd87UWJhmJsU7ADe+51yS0tGQSJTsDHKFxIpU5MsIDpxEgXhaVymg0rQ2/snOb91dxp3aIht5CqD/jaFa3LXccF6b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4V7tB63fh6ztR23;
	Tue,  2 Apr 2024 11:08:30 +0800 (CST)
Received: from dggpemd100003.china.huawei.com (unknown [7.185.36.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 299CE1404F6;
	Tue,  2 Apr 2024 11:11:03 +0800 (CST)
Received: from huawei.com (10.174.184.140) by dggpemd100003.china.huawei.com
 (7.185.36.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Tue, 2 Apr
 2024 11:11:02 +0800
From: Ming Yang <yangming73@huawei.com>
To: <cl@linux.com>, <penberg@kernel.org>, <rientjes@google.com>,
	<iamjoonsoo.kim@lge.com>, <akpm@linux-foundation.org>, <vbabka@suse.cz>,
	<roman.gushchin@linux.dev>, <42.hyeyoo@gmail.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
CC: <yangming73@huawei.com>, <zhangliang5@huawei.com>,
	<wangzhigang17@huawei.com>, <liushixin2@huawei.com>, <alex.chen@huawei.com>,
	<pengyi.pengyi@huawei.com>, <xiqi2@huawei.com>
Subject: [PATCH] slub: fix slub segmentation
Date: Tue, 2 Apr 2024 11:10:25 +0800
Message-ID: <20240402031025.1097-1-yangming73@huawei.com>
X-Mailer: git-send-email 2.32.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemd100003.china.huawei.com (7.185.36.199)

When one of numa nodes runs out of memory and lots of processes still
booting, slabinfo shows much slub segmentation exits. The following
shows some of them:

tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs>
<num_slabs> <sharedavail>
kmalloc-512        84309 380800   1024   32    8 :
tunables    0    0    0 : slabdata  11900  11900      0
kmalloc-256        65869 365408    512   32    4 :
tunables    0    0    0 : slabdata  11419  11419      0

365408 "kmalloc-256" objects are alloced but only 65869 of them are
used; While 380800 "kmalloc-512" objects are alloced but only 84309
of them are used.

This problem exits in the following senario:
1. Multiple numa nodes, e.g. four nodes.
2. Lack of memory in any one node.
3. Functions which alloc many slub memory in certain numa nodes,
like alloc_fair_sched_group.

The slub segmentation generated because of the following reason:
In function "___slab_alloc" a new slab is attempted to be gotten via
function "get_partial". If the argument 'node' is assigned but there
are neither partial memory nor buddy memory in that assigned node, no
slab could be gotten. And then the program attempt to alloc new slub
from buddy system, as mentationed before: no buddy memory in that
assigned node left, a new slub might be alloced from the buddy system
of other node directly, no matter whether there is free partil memory
left on other node. As a result slub segmentation generated.

The key point of above allocation flow is: the slab should be alloced
from the partial of other node first, instead of the buddy system of
other node directly.

In this commit a new slub allocation flow is proposed:
1. Attempt to get a slab via function get_partial (first step in
new_objects lable).
2. If no slab is gotten and 'node' is assigned, try to alloc a new
slab just from the assigned node instead of all node.
3. If no slab could be alloced from the assigned node, try to alloc
slub from partial of other node.
4. If the alloctation in step 3 fails, alloc a new slub from buddy
system of all node.

Signed-off-by: Ming Yang <yangming73@huawei.com>
Signed-off-by: Liang Zhang <zhangliang5@huawei.com>
Signed-off-by: Zhigang Wang <wangzhigang17@huawei.com>
Reviewed-by: Shixin Liu <liushixin2@huawei.com>
---
This patch can be tested and verified by following steps:
1. First, try to run out memory on node0. echo 1000(depending on your memory) > 
/sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages.
2. Second, boot 10000(depending on your memory) processes which use setsid 
systemcall, as the setsid systemcall may likely call function 
alloc_fair_sched_group.
3. Last, check slabinfo, cat /proc/slabinfo.

Hardware info:
Memory : 8GiB
CPU (total #): 120
numa node: 4

Test clang code example:
int main() {
    void *p = malloc(1024);
    setsid();
    while(1);
}

 mm/slub.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index 1bb2a93cf7..3eb2e7d386 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3522,7 +3522,18 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	}
 
 	slub_put_cpu_ptr(s->cpu_slab);
+	if (node != NUMA_NO_NODE) {
+		slab = new_slab(s, gfpflags | __GFP_THISNODE, node);
+		if (slab)
+			goto slab_alloced;
+
+		slab = get_any_partial(s, &pc);
+		if (slab)
+			goto slab_alloced;
+	}
 	slab = new_slab(s, gfpflags, node);
+
+slab_alloced:
 	c = slub_get_cpu_ptr(s->cpu_slab);
 
 	if (unlikely(!slab)) {
-- 
2.33.0


