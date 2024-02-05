Return-Path: <linux-kernel+bounces-52917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FB8849E51
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 681A21C21E6E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF37E3FB32;
	Mon,  5 Feb 2024 15:32:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F813B18D
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707147171; cv=none; b=TBSw+UYmpDo9qTAe3ZmoTSCA5ysPNNH5HtnUAVT8hALpj6P+WpydEQv/QCyCJdOklNk3gRnl2BPQPmZJTx4s/i0314B3B1q5vqOqMyrIZ2QcdEwc34Kl2kNnqK1rt8qZ+6br2V0E59EeAImM3Q+feVuSi8CkX1+BJHRrPN7EhoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707147171; c=relaxed/simple;
	bh=r1hkzYJmSuuIn0H8ddW+ei/JSVISOgRUUYc6h1WMsCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Iasucun0u9DQNhGSiSncUAe76rYj+gju9hNoezNLNcXmE5i69DqAavWTmMOePaI2azUH0mAeW/ysOqx6nogVsk+WW9/+hcyAZUT9Qn5+I5KFk0oAj4N/P35/1t7xq4nrLQmNF7x84pL+Pwrj9ydbG/jKKBf2tpZ5yTYMDLDLOGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9287C12FC;
	Mon,  5 Feb 2024 07:33:31 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C60753F5A1;
	Mon,  5 Feb 2024 07:32:47 -0800 (PST)
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
Subject: [PATCH v3 2/3] iommu/iova: Reorganise some code
Date: Mon,  5 Feb 2024 15:32:40 +0000
Message-Id: <d4753562f4faa0e6b3aeebcbf88fdb60cc22d715.1707144953.git.robin.murphy@arm.com>
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

The iova_cache_{get,put}() calls really represent top-level lifecycle
management for the whole IOVA library, so it's long been rather
confusing to have them buried right in the middle of the allocator
implementation details. Move them to a more expected position at the end
of the file, where it will then also be easier to expand them. With
this, we can also move the rcache hotplug handler (plus another stray
function) into the rcache portion of the file.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iova.c | 128 +++++++++++++++++++++----------------------
 1 file changed, 64 insertions(+), 64 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index cf95001d85c0..b5de865ee50b 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -24,24 +24,8 @@ static bool iova_rcache_insert(struct iova_domain *iovad,
 static unsigned long iova_rcache_get(struct iova_domain *iovad,
 				     unsigned long size,
 				     unsigned long limit_pfn);
-static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
 static void free_iova_rcaches(struct iova_domain *iovad);
-
-unsigned long iova_rcache_range(void)
-{
-	return PAGE_SIZE << (IOVA_RANGE_CACHE_MAX_SIZE - 1);
-}
-
-static int iova_cpuhp_dead(unsigned int cpu, struct hlist_node *node)
-{
-	struct iova_domain *iovad;
-
-	iovad = hlist_entry_safe(node, struct iova_domain, cpuhp_dead);
-
-	free_cpu_cached_iovas(cpu, iovad);
-	return 0;
-}
-
+static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
 static void free_global_cached_iovas(struct iova_domain *iovad);
 
 static struct iova *to_iova(struct rb_node *node)
@@ -252,53 +236,6 @@ static void free_iova_mem(struct iova *iova)
 		kmem_cache_free(iova_cache, iova);
 }
 
-int iova_cache_get(void)
-{
-	int err = -ENOMEM;
-
-	mutex_lock(&iova_cache_mutex);
-	if (!iova_cache_users) {
-		iova_cache = kmem_cache_create("iommu_iova", sizeof(struct iova), 0,
-					       SLAB_HWCACHE_ALIGN, NULL);
-		if (!iova_cache)
-			goto out_err;
-
-		err = cpuhp_setup_state_multi(CPUHP_IOMMU_IOVA_DEAD, "iommu/iova:dead",
-					      NULL, iova_cpuhp_dead);
-		if (err) {
-			pr_err("IOVA: Couldn't register cpuhp handler: %pe\n", ERR_PTR(err));
-			goto out_err;
-		}
-	}
-
-	iova_cache_users++;
-	mutex_unlock(&iova_cache_mutex);
-
-	return 0;
-
-out_err:
-	kmem_cache_destroy(iova_cache);
-	mutex_unlock(&iova_cache_mutex);
-	return err;
-}
-EXPORT_SYMBOL_GPL(iova_cache_get);
-
-void iova_cache_put(void)
-{
-	mutex_lock(&iova_cache_mutex);
-	if (WARN_ON(!iova_cache_users)) {
-		mutex_unlock(&iova_cache_mutex);
-		return;
-	}
-	iova_cache_users--;
-	if (!iova_cache_users) {
-		cpuhp_remove_multi_state(CPUHP_IOMMU_IOVA_DEAD);
-		kmem_cache_destroy(iova_cache);
-	}
-	mutex_unlock(&iova_cache_mutex);
-}
-EXPORT_SYMBOL_GPL(iova_cache_put);
-
 /**
  * alloc_iova - allocates an iova
  * @iovad: - iova domain in question
@@ -653,6 +590,11 @@ struct iova_rcache {
 	struct delayed_work work;
 };
 
+unsigned long iova_rcache_range(void)
+{
+	return PAGE_SIZE << (IOVA_RANGE_CACHE_MAX_SIZE - 1);
+}
+
 static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
 {
 	struct iova_magazine *mag;
@@ -989,5 +931,63 @@ static void free_global_cached_iovas(struct iova_domain *iovad)
 		spin_unlock_irqrestore(&rcache->lock, flags);
 	}
 }
+
+static int iova_cpuhp_dead(unsigned int cpu, struct hlist_node *node)
+{
+	struct iova_domain *iovad;
+
+	iovad = hlist_entry_safe(node, struct iova_domain, cpuhp_dead);
+
+	free_cpu_cached_iovas(cpu, iovad);
+	return 0;
+}
+
+int iova_cache_get(void)
+{
+	int err = -ENOMEM;
+
+	mutex_lock(&iova_cache_mutex);
+	if (!iova_cache_users) {
+		iova_cache = kmem_cache_create("iommu_iova", sizeof(struct iova), 0,
+					       SLAB_HWCACHE_ALIGN, NULL);
+		if (!iova_cache)
+			goto out_err;
+
+		err = cpuhp_setup_state_multi(CPUHP_IOMMU_IOVA_DEAD, "iommu/iova:dead",
+					      NULL, iova_cpuhp_dead);
+		if (err) {
+			pr_err("IOVA: Couldn't register cpuhp handler: %pe\n", ERR_PTR(err));
+			goto out_err;
+		}
+	}
+
+	iova_cache_users++;
+	mutex_unlock(&iova_cache_mutex);
+
+	return 0;
+
+out_err:
+	kmem_cache_destroy(iova_cache);
+	mutex_unlock(&iova_cache_mutex);
+	return err;
+}
+EXPORT_SYMBOL_GPL(iova_cache_get);
+
+void iova_cache_put(void)
+{
+	mutex_lock(&iova_cache_mutex);
+	if (WARN_ON(!iova_cache_users)) {
+		mutex_unlock(&iova_cache_mutex);
+		return;
+	}
+	iova_cache_users--;
+	if (!iova_cache_users) {
+		cpuhp_remove_multi_state(CPUHP_IOMMU_IOVA_DEAD);
+		kmem_cache_destroy(iova_cache);
+	}
+	mutex_unlock(&iova_cache_mutex);
+}
+EXPORT_SYMBOL_GPL(iova_cache_put);
+
 MODULE_AUTHOR("Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>");
 MODULE_LICENSE("GPL");
-- 
2.39.2.101.g768bb238c484.dirty


