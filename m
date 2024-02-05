Return-Path: <linux-kernel+bounces-52918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CED849E53
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EBFB28A265
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE5F2DF9D;
	Mon,  5 Feb 2024 15:32:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AFF3FE51
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 15:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707147175; cv=none; b=SmMF5IxsbVLpd42P/1QCiuUVoTNZj9C8YdmftFsRxbdGgcwjf9BHs7OEByEnDjBRydhDBMfREApLDWZ8HezXfuL3yiiJ6reHId9gyJ020+D898nTvnHIW5l6RnoWjCRA6hppZaUYZkJYiS5dszLetFWtHuBs4N5MX+0H3u+T1ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707147175; c=relaxed/simple;
	bh=gp8tv3IVxGAchewnqQ11OPRI0Ycp1XlYtKMxh98HcZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XBgGj4ZxVrDwUVuC7cPkTqBsOTHRC+mNByKt8QenrA5OZFDkZd2E8qLD+Z93zR6qgzJcgNuIiG6Zc5mNaTO5QTXu3mHo7goeZSO77QYdO76ORi5hBs6AUov52Nxj+Zrk342gGOmcBOJUGIvcQf0O25qIMiWVJJXU4fHPT11QpSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14C211FB;
	Mon,  5 Feb 2024 07:33:36 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 483403F5A1;
	Mon,  5 Feb 2024 07:32:52 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org
Cc: will@kernel.org,
	pasha.tatashin@soleen.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	rientjes@google.com,
	yosryahmed@google.com,
	john.g.garry@oracle.com
Subject: [PATCH v3 3/3] iommu/iova: use named kmem_cache for iova magazines
Date: Mon,  5 Feb 2024 15:32:41 +0000
Message-Id: <dc5c51aaba50906a92b9ba1a5137ed462484a7be.1707144953.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1707144953.git.robin.murphy@arm.com>
References: <cover.1707144953.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pasha Tatashin <pasha.tatashin@soleen.com>

The magazine buffers can take gigabytes of kmem memory, dominating all
other allocations. For observability purpose create named slab cache so
the iova magazine memory overhead can be clearly observed.

With this change:

> slabtop -o | head
 Active / Total Objects (% used)    : 869731 / 952904 (91.3%)
 Active / Total Slabs (% used)      : 103411 / 103974 (99.5%)
 Active / Total Caches (% used)     : 135 / 211 (64.0%)
 Active / Total Size (% used)       : 395389.68K / 411430.20K (96.1%)
 Minimum / Average / Maximum Object : 0.02K / 0.43K / 8.00K

OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
244412 244239 99%    1.00K  61103       4    244412K iommu_iova_magazine
 91636  88343 96%    0.03K    739     124      2956K kmalloc-32
 75744  74844 98%    0.12K   2367      32      9468K kernfs_node_cache

On this machine it is now clear that magazine use 242M of kmem memory.

Acked-by: David Rientjes <rientjes@google.com>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
[ rm: adjust to rework of iova_cache_{get,put} ]
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iova.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index b5de865ee50b..d59d0ea2fd21 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -590,6 +590,8 @@ struct iova_rcache {
 	struct delayed_work work;
 };
 
+static struct kmem_cache *iova_magazine_cache;
+
 unsigned long iova_rcache_range(void)
 {
 	return PAGE_SIZE << (IOVA_RANGE_CACHE_MAX_SIZE - 1);
@@ -599,7 +601,7 @@ static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
 {
 	struct iova_magazine *mag;
 
-	mag = kmalloc(sizeof(*mag), flags);
+	mag = kmem_cache_alloc(iova_magazine_cache, flags);
 	if (mag)
 		mag->size = 0;
 
@@ -608,7 +610,7 @@ static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
 
 static void iova_magazine_free(struct iova_magazine *mag)
 {
-	kfree(mag);
+	kmem_cache_free(iova_magazine_cache, mag);
 }
 
 static void
@@ -953,6 +955,12 @@ int iova_cache_get(void)
 		if (!iova_cache)
 			goto out_err;
 
+		iova_magazine_cache = kmem_cache_create("iommu_iova_magazine",
+							sizeof(struct iova_magazine),
+							0, SLAB_HWCACHE_ALIGN, NULL);
+		if (!iova_magazine_cache)
+			goto out_err;
+
 		err = cpuhp_setup_state_multi(CPUHP_IOMMU_IOVA_DEAD, "iommu/iova:dead",
 					      NULL, iova_cpuhp_dead);
 		if (err) {
@@ -968,6 +976,7 @@ int iova_cache_get(void)
 
 out_err:
 	kmem_cache_destroy(iova_cache);
+	kmem_cache_destroy(iova_magazine_cache);
 	mutex_unlock(&iova_cache_mutex);
 	return err;
 }
@@ -984,6 +993,7 @@ void iova_cache_put(void)
 	if (!iova_cache_users) {
 		cpuhp_remove_multi_state(CPUHP_IOMMU_IOVA_DEAD);
 		kmem_cache_destroy(iova_cache);
+		kmem_cache_destroy(iova_magazine_cache);
 	}
 	mutex_unlock(&iova_cache_mutex);
 }
-- 
2.39.2.101.g768bb238c484.dirty


