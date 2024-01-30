Return-Path: <linux-kernel+bounces-43733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8444F841877
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84AF31C22F7B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A370536126;
	Tue, 30 Jan 2024 01:39:36 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3432A36114
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578776; cv=none; b=RT/Sxz0VF3icfOAoGIW+C+IX07ZV+jDE2ChUVBJfjNI3TXO1pV17OwYfjbk3wrjLCCpCWy78siewnUvcjQi2nysn+hGHVIWOqxCDZDXQDhCkCXHZEUV0GEtttRuk1R1WtJOUOujnaUfTcXUGgfmXaKnhFXQ2b+rSK6ATO4Q1ay8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578776; c=relaxed/simple;
	bh=urRqlIqLu6PJACjhufX8qN5lQX7duFCU85eiVyFHyjc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B3bvQdjv26hW9TsjqC6St29b8J0fsBJlwG7j3bR1wMuU7nUIjwY5p+/xAuWKpAlAbn58XdM1Z2U3nrvQOnHwpBMAju2poCvKWCN0bIBXP7Tae8B+Hgr/bTAapfUqOGv9yTL8KXFx7bU4tJ1xwB/35ls0AZ5VBxxcXa17d8bi7KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TP7B16qH4z1vskm;
	Tue, 30 Jan 2024 09:39:05 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (unknown [7.185.36.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 708DD1404F1;
	Tue, 30 Jan 2024 09:39:30 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 09:39:30 +0800
From: Zheng Yejian <zhengyejian1@huawei.com>
To: <cl@linux.com>, <penberg@kernel.org>, <rientjes@google.com>,
	<iamjoonsoo.kim@lge.com>, <akpm@linux-foundation.org>, <vbabka@suse.cz>,
	<roman.gushchin@linux.dev>, <42.hyeyoo@gmail.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<zhengyejian1@huawei.com>
Subject: [PATCH] mm/slub: remove parameter 'flags' in create_kmalloc_caches()
Date: Tue, 30 Jan 2024 09:41:07 +0800
Message-ID: <20240130014107.1262373-1-zhengyejian1@huawei.com>
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
 dggpeml500012.china.huawei.com (7.185.36.15)

After commit 16a1d968358a ("mm/slab: remove mm/slab.c and slab_def.h"),
parameter 'flags' is only passed as 0 in create_kmalloc_caches(), and
then it is only passed to new_kmalloc_cache().

So we can change parameter 'flags' to be a local variable with
initial value 0 in new_kmalloc_cache() and remove parameter 'flags'
in create_kmalloc_caches(). Also make new_kmalloc_cache() static
due to it is only used in mm/slab_common.c.

Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 mm/slab.h        |  4 +---
 mm/slab_common.c | 13 +++++++------
 mm/slub.c        |  2 +-
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 54deeb0428c6..09c673346ece 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -387,7 +387,7 @@ extern const struct kmalloc_info_struct {
 
 /* Kmalloc array related functions */
 void setup_kmalloc_cache_index_table(void);
-void create_kmalloc_caches(slab_flags_t);
+void create_kmalloc_caches(void);
 
 extern u8 kmalloc_size_index[24];
 
@@ -422,8 +422,6 @@ gfp_t kmalloc_fix_flags(gfp_t flags);
 int __kmem_cache_create(struct kmem_cache *, slab_flags_t flags);
 
 void __init kmem_cache_init(void);
-void __init new_kmalloc_cache(int idx, enum kmalloc_cache_type type,
-			      slab_flags_t flags);
 extern void create_boot_cache(struct kmem_cache *, const char *name,
 			unsigned int size, slab_flags_t flags,
 			unsigned int useroffset, unsigned int usersize);
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 238293b1dbe1..61530df8b35b 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -853,9 +853,10 @@ static unsigned int __kmalloc_minalign(void)
 	return max(minalign, arch_slab_minalign());
 }
 
-void __init
-new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
+static void __init
+new_kmalloc_cache(int idx, enum kmalloc_cache_type type)
 {
+	slab_flags_t flags = 0;
 	unsigned int minalign = __kmalloc_minalign();
 	unsigned int aligned_size = kmalloc_info[idx].size;
 	int aligned_idx = idx;
@@ -902,7 +903,7 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
  * may already have been created because they were needed to
  * enable allocations for slab creation.
  */
-void __init create_kmalloc_caches(slab_flags_t flags)
+void __init create_kmalloc_caches(void)
 {
 	int i;
 	enum kmalloc_cache_type type;
@@ -913,7 +914,7 @@ void __init create_kmalloc_caches(slab_flags_t flags)
 	for (type = KMALLOC_NORMAL; type < NR_KMALLOC_TYPES; type++) {
 		for (i = KMALLOC_SHIFT_LOW; i <= KMALLOC_SHIFT_HIGH; i++) {
 			if (!kmalloc_caches[type][i])
-				new_kmalloc_cache(i, type, flags);
+				new_kmalloc_cache(i, type);
 
 			/*
 			 * Caches that are not of the two-to-the-power-of size.
@@ -922,10 +923,10 @@ void __init create_kmalloc_caches(slab_flags_t flags)
 			 */
 			if (KMALLOC_MIN_SIZE <= 32 && i == 6 &&
 					!kmalloc_caches[type][1])
-				new_kmalloc_cache(1, type, flags);
+				new_kmalloc_cache(1, type);
 			if (KMALLOC_MIN_SIZE <= 64 && i == 7 &&
 					!kmalloc_caches[type][2])
-				new_kmalloc_cache(2, type, flags);
+				new_kmalloc_cache(2, type);
 		}
 	}
 #ifdef CONFIG_RANDOM_KMALLOC_CACHES
diff --git a/mm/slub.c b/mm/slub.c
index 2ef88bbf56a3..4f912f5ec11c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5663,7 +5663,7 @@ void __init kmem_cache_init(void)
 
 	/* Now we can use the kmem_cache to allocate kmalloc slabs */
 	setup_kmalloc_cache_index_table();
-	create_kmalloc_caches(0);
+	create_kmalloc_caches();
 
 	/* Setup random freelists for each cache */
 	init_freelist_randomization();
-- 
2.25.1


