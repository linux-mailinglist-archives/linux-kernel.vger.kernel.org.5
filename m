Return-Path: <linux-kernel+bounces-151795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBE48AB3F4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C664DB212D0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E10B4C63A;
	Fri, 19 Apr 2024 16:56:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D093C13C69B;
	Fri, 19 Apr 2024 16:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545791; cv=none; b=MvR3MWojTk4ywvevUKWrmkGXWP+NxbKZ7ca4smx+X5hz10kkXKRzxvApglfeAN5R+IYLmTNvDEERsWj9ghbCSEGcSO6QpfPNJtobF3aF3YyLbWqdWw8v0kwhX8eYektx/WavONgGSu3mAXmyrX1unlX/E1bR9BuLTqEV+x4gZyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545791; c=relaxed/simple;
	bh=flTdBTtwOQyaAf+NPWtA6POYHGpThO5iFJo8u6ia0hg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=leLdRn9vTDgCwu9XfUf2phQhlr7hn2gkAVR5fyW3fN+1aWZhb3jt74b3TCC7yzpfU6+Ws/BVXrbRkyIu7pfNetKzmEtPkpGVPV/a4jiDAjuJuDBjpzKkiONZ0oma0UJ2wTLwAm3qbF35xNz6X2c9/tEK6SreeGIiUcozjBUd2gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D298F1424;
	Fri, 19 Apr 2024 09:56:56 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5D2603F792;
	Fri, 19 Apr 2024 09:56:26 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>
Cc: linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH 3/4] OF: Simplify of_iommu_configure()
Date: Fri, 19 Apr 2024 17:56:01 +0100
Message-Id: <7467a9487b23ebae62d4bda73b9c736d3cb3c68c.1713523251.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1713523251.git.robin.murphy@arm.com>
References: <cover.1713523251.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We no longer have a notion of partially-initialised fwspecs existing,
and we also no longer need to use an iommu_ops pointer to return status
to of_dma_configure(). Clean up the remains of those, which lends itself
to clarifying the logic around the dma_range_map allocation as well.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/of_iommu.c | 29 ++++++++++-------------------
 drivers/of/device.c      | 30 +++++++++++-------------------
 2 files changed, 21 insertions(+), 38 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index bbfe960cdc13..a5d6ff8e4e72 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -108,7 +108,6 @@ static int of_iommu_configure_device(struct device_node *master_np,
 int of_iommu_configure(struct device *dev, struct device_node *master_np,
 		       const u32 *id)
 {
-	struct iommu_fwspec *fwspec;
 	int err;
 
 	if (!master_np)
@@ -116,14 +115,9 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
 
 	/* Serialise to make dev->iommu stable under our potential fwspec */
 	mutex_lock(&iommu_probe_device_lock);
-	fwspec = dev_iommu_fwspec_get(dev);
-	if (fwspec) {
-		if (fwspec->ops) {
-			mutex_unlock(&iommu_probe_device_lock);
-			return 0;
-		}
-		/* In the deferred case, start again from scratch */
-		iommu_fwspec_free(dev);
+	if (dev_iommu_fwspec_get(dev)) {
+		mutex_unlock(&iommu_probe_device_lock);
+		return 0;
 	}
 
 	/*
@@ -143,20 +137,17 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
 	} else {
 		err = of_iommu_configure_device(master_np, dev, id);
 	}
+
+	if (err)
+		iommu_fwspec_free(dev);
 	mutex_unlock(&iommu_probe_device_lock);
 
-	if (err == -ENODEV || err == -EPROBE_DEFER)
-		return err;
-	if (err)
-		goto err_log;
+	if (!err && dev->bus)
+		err = iommu_probe_device(dev);
 
-	err = iommu_probe_device(dev);
-	if (err)
-		goto err_log;
-	return 0;
+	if (err && err != -EPROBE_DEFER)
+		dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
 
-err_log:
-	dev_dbg(dev, "Adding to IOMMU failed: %pe\n", ERR_PTR(err));
 	return err;
 }
 
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 312c63361211..edf3be197265 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -96,8 +96,7 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 	const struct bus_dma_region *map = NULL;
 	struct device_node *bus_np;
 	u64 mask, end = 0;
-	bool coherent;
-	int iommu_ret;
+	bool coherent, set_map = false;
 	int ret;
 
 	if (np == dev->of_node)
@@ -118,6 +117,7 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 	} else {
 		/* Determine the overall bounds of all DMA regions */
 		end = dma_range_map_max(map);
+		set_map = true;
 	}
 
 	/*
@@ -144,7 +144,7 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 	dev->coherent_dma_mask &= mask;
 	*dev->dma_mask &= mask;
 	/* ...but only set bus limit and range map if we found valid dma-ranges earlier */
-	if (!ret) {
+	if (set_map) {
 		dev->bus_dma_limit = end;
 		dev->dma_range_map = map;
 	}
@@ -153,29 +153,21 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 	dev_dbg(dev, "device is%sdma coherent\n",
 		coherent ? " " : " not ");
 
-	iommu_ret = of_iommu_configure(dev, np, id);
-	if (iommu_ret == -EPROBE_DEFER) {
+	ret = of_iommu_configure(dev, np, id);
+	if (ret == -EPROBE_DEFER) {
 		/* Don't touch range map if it wasn't set from a valid dma-ranges */
-		if (!ret)
+		if (set_map)
 			dev->dma_range_map = NULL;
 		kfree(map);
 		return -EPROBE_DEFER;
-	} else if (iommu_ret == -ENODEV) {
-		dev_dbg(dev, "device is not behind an iommu\n");
-	} else if (iommu_ret) {
-		dev_err(dev, "iommu configuration for device failed with %pe\n",
-			ERR_PTR(iommu_ret));
-
-		/*
-		 * Historically this routine doesn't fail driver probing
-		 * due to errors in of_iommu_configure()
-		 */
-	} else
-		dev_dbg(dev, "device is behind an iommu\n");
+	}
+	/* Take all other IOMMU errors to mean we'll just carry on without it */
+	dev_dbg(dev, "device is%sbehind an iommu\n",
+		!ret ? " " : " not ");
 
 	arch_setup_dma_ops(dev, coherent);
 
-	if (iommu_ret)
+	if (ret)
 		of_dma_set_restricted_buffer(dev, np);
 
 	return 0;
-- 
2.39.2.101.g768bb238c484.dirty


