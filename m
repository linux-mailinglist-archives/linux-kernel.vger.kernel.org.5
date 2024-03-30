Return-Path: <linux-kernel+bounces-125616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB718929B2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 09:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E88EE1F21C19
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 08:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9729C1C0DD5;
	Sat, 30 Mar 2024 08:31:54 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F544179
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 08:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711787514; cv=none; b=VCLkLZS2TDlNMZog2JNeOW0jD24Y327qkl9HA3fel8ueppj3tZdilMF16yDmiBn0NnZaWXAH+RZAKmaQ1q9bwqGxvlLrrhHpdUOUaEPqNKb0hR2DM/FbA7huuxQ11A9d6B6gIm5jct3HuUKsAojyIi/L0zTW70ws6tIxwMwyF9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711787514; c=relaxed/simple;
	bh=NL+dsLVqbh4Q40NGTmOOcM/fOeLV7YkY7jwLXQtfS8s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OtF5iCoUiSF1TvsnLNsar+qWOwckmM+c8zRbCzratPIty4sHiWzaXbfPCHZA8Sm9g65TS4LDd9tFF7In5QwezClSCo3Pl9ELKP8oWsVPgeZC32QHLTa83i4Q47HWf/wgKePj/QClwUzfqKoLli/l/ajESdC1gen910NjYAW38BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4V69Tt0fSqz1GDdV;
	Sat, 30 Mar 2024 16:31:14 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (unknown [7.185.36.236])
	by mail.maildlp.com (Postfix) with ESMTPS id 1F38E1A0188;
	Sat, 30 Mar 2024 16:31:48 +0800 (CST)
Received: from mdc.huawei.com (10.175.112.208) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 30 Mar 2024 16:31:47 +0800
From: Chen Jun <chenjun102@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <cl@linux.com>,
	<penberg@kernel.org>, <rientjes@google.com>, <iamjoonsoo.kim@lge.com>,
	<akpm@linux-foundation.org>, <vbabka@suse.cz>, <roman.gushchin@linux.dev>,
	<42.hyeyoo@gmail.com>
CC: <xuqiang36@huawei.com>, <chenjun102@huawei.com>,
	<wangkefeng.wang@huawei.com>
Subject: [PATCH v2] mm/slub: Reduce memory consumption in extreme scenarios
Date: Sat, 30 Mar 2024 16:23:35 +0800
Message-ID: <20240330082335.29710-1-chenjun102@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)

When kmalloc_node() is called without __GFP_THISNODE and the target node
lacks sufficient memory, SLUB allocates a folio from a different node
other than the requested node, instead of taking a partial slab from it.

However, since the allocated folio does not belong to the requested
node, it is deactivated and added to the partial slab list of the node
it belongs to.

This behavior can result in excessive memory usage when the requested
node has insufficient memory, as SLUB will repeatedly allocate folios
from other nodes without reusing the previously allocated ones.

To prevent memory wastage,
when (node != NUMA_NO_NODE) && !(gfpflags & __GFP_THISNODE) is,
1) try to get a partial slab from target node with GFP_NOWAIT |
   __GFP_THISNODE opportunistically.
2) if 1) failed, try to allocate a new slab from target node with
   GFP_NOWAIT | __GFP_THISNODE opportunistically too.
3) if 2) failed, retry 1) and 2) with orignal gfpflags.

when node != NUMA_NO_NODE || (gfpflags & __GFP_THISNODE), the behavior
remains unchanged.

On qemu with 4 numa nodes and each numa has 1G memory. Write a test ko
to call kmalloc_node(196, GFP_KERNEL, 3) for (4 * 1024 + 4) * 1024 times.

cat /proc/slabinfo shows:
kmalloc-256       4200530 13519712    256   32    2 : tunables..

after this patch,
cat /proc/slabinfo shows:
kmalloc-256       4200558 4200768    256   32    2 : tunables..

Signed-off-by: Chen Jun <chenjun102@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
v2: 
- try to alloc partial slab or new slab with GFP_NOWAIT(it includes
  __GFP_NOWARN) opportunistically, then fallback to orignal gfpflag,
  suggested by Vlastimil Babka,
- update changelog

v1: https://lore.kernel.org/linux-mm/20230314123403.100158-1-chenjun102@huawei.com/

 mm/slub.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 1bb2a93cf7b6..c1c51595a59f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2699,7 +2699,7 @@ static struct slab *get_partial(struct kmem_cache *s, int node,
 		searchnode = numa_mem_id();
 
 	slab = get_partial_node(s, get_node(s, searchnode), pc);
-	if (slab || node != NUMA_NO_NODE)
+	if (slab || (node != NUMA_NO_NODE && (pc->flags & __GFP_THISNODE)))
 		return slab;
 
 	return get_any_partial(s, pc);
@@ -3375,6 +3375,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	struct slab *slab;
 	unsigned long flags;
 	struct partial_context pc;
+	bool try_thisnode = true;
 
 	stat(s, ALLOC_SLOWPATH);
 
@@ -3501,6 +3502,17 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 new_objects:
 
 	pc.flags = gfpflags;
+	/*
+	 * when (node != NUMA_NO_NODE) && !(gfpflags & __GFP_THISNODE)
+	 * 1) try to get a partial slab from target node with GPF_NOWAIT |
+	 *    __GFP_THISNODE opportunistically.
+	 * 2) if 1) failed, try to allocate a new slab from target node with
+	 *    GPF_NOWAIT | __GFP_THISNODE opportunistically too.
+	 * 3) if 2) failed, retry 1) and 2) with original gfpflags.
+	 */
+	if (node != NUMA_NO_NODE && !(gfpflags & __GFP_THISNODE) && try_thisnode)
+		pc.flags = GFP_NOWAIT | __GFP_THISNODE;
+
 	pc.orig_size = orig_size;
 	slab = get_partial(s, node, &pc);
 	if (slab) {
@@ -3522,10 +3534,15 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	}
 
 	slub_put_cpu_ptr(s->cpu_slab);
-	slab = new_slab(s, gfpflags, node);
+	slab = new_slab(s, pc.flags, node);
 	c = slub_get_cpu_ptr(s->cpu_slab);
 
 	if (unlikely(!slab)) {
+		if (node != NUMA_NO_NODE && !(gfpflags & __GFP_THISNODE) &&
+		    try_thisnode) {
+			try_thisnode = false;
+			goto new_objects;
+		}
 		slab_out_of_memory(s, gfpflags, node);
 		return NULL;
 	}
-- 
2.27.0


