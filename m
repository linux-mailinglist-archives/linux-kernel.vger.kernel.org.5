Return-Path: <linux-kernel+bounces-40013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 890A383D8C6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADAB31C2756B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D26717565;
	Fri, 26 Jan 2024 10:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GrsK9Fmj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CA51427A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 10:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706266769; cv=none; b=npxYE7XSAMxT19Z80oWaVHcX0E4gOPw1m8wDviyaqLZ9NMv/hvyb39K2l5YbtCizyjFTy2CkZhYq1d84G8nl2+8DxnAoqXuRM1AO2UiguxLvu/ABTKfnjmxLjtdtIX7SPa+U7sqRvir3R0ASDOc1sTeruhGZKhIrI1SFhSsuPJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706266769; c=relaxed/simple;
	bh=b4leudU2y75I7gVeqH5B2NhuCYSTwTPov4fkwl1ZnBs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=msKJx9vQY0IoBjmeQd3izeXDLK1Ta/IEY3bcy1WRb7TvWa1rqzo2A3AnSrW0eK9QKWESp+ufZxT31/A0S6QZ7D8VbGhF9GTPlK6yWs5kUedvOvNtYpw8inmmbOsKjInZJXeWIG+rCmtgVcSWNBpNQp36SdhL0CAJl4BT3RjOJ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GrsK9Fmj; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706266760; x=1737802760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b4leudU2y75I7gVeqH5B2NhuCYSTwTPov4fkwl1ZnBs=;
  b=GrsK9FmjLx7P+kQXFxngAyvxH57O275Sq3hEglLu+pz+Vck20YHoKZQj
   Hx5xVUHQh1mASnpN19hwbm/31X0KLumRatain7w3A0//Z2Qoywu62uB0C
   CticCQsUkULI7rxv7TJnmfAW++EyemuuPLSaUlQS1LeURcZKrBO4DsC2V
   wRibZYwxTM/zvPcfbW9JefNM/NWJNlbsdTvlYLFL5reZwNux4DZH29tmG
   JKLGoKziNtLEfVEvmow/9iHkPreaMFEkcfM88IgFDXlh9JL0nuEkFUAW3
   7xgtYQW59KpzUFhI69WzNU18oSa1sx1iRMaIRTkD3nlZZuFXZQ7+fyqWy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9123376"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9123376"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 02:59:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="857367852"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="857367852"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga004.fm.intel.com with ESMTP; 26 Jan 2024 02:59:16 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 2/2] iommu: Probe right iommu_ops for device
Date: Fri, 26 Jan 2024 18:53:41 +0800
Message-Id: <20240126105341.78086-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126105341.78086-1-baolu.lu@linux.intel.com>
References: <20240126105341.78086-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, in the iommu probe device path, __iommu_probe_device() gets
the iommu_ops for the device from dev->iommu->fwspec if this field has
been initialized before probing. Otherwise, it is assumed that only one
of Intel, AMD, s390, PAMU or legacy SMMUv2 can be present, hence it's
feasible to lookup the global iommu device list and use the iommu_ops of
the first iommu device which has no dev->iommu->fwspec.

The assumption mentioned above is no longer correct with the introduction
of the IOMMUFD mock device on x86 platforms. There might be multiple
instances of iommu drivers, none of which have the dev->iommu->fwspec
field populated.

Probe the right iommu_ops for device by iterating over all the global
drivers and call their probe function to find a match.

Fixes: 17de3f5fdd35 ("iommu: Retire bus ops")
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 76 +++++++++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0af0b5544072..2cdb01e411fa 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -396,30 +396,69 @@ void dev_iommu_priv_set(struct device *dev, void *priv)
 }
 EXPORT_SYMBOL_GPL(dev_iommu_priv_set);
 
+static struct iommu_device *
+__iommu_do_probe_device(struct device *dev, const struct iommu_ops *ops)
+{
+	struct iommu_device *iommu_dev;
+
+	if (!try_module_get(ops->owner))
+		return ERR_PTR(-EINVAL);
+
+	iommu_dev = ops->probe_device(dev);
+	if (IS_ERR(iommu_dev))
+		module_put(ops->owner);
+
+	return iommu_dev;
+}
+
+static struct iommu_device *iommu_probe_device_ops(struct device *dev)
+{
+	struct iommu_device *iter, *iommu_dev = ERR_PTR(-ENODEV);
+	struct iommu_fwspec *fwspec;
+
+	/*
+	 * For FDT-based systems and ACPI IORT/VIOT, drivers register IOMMU
+	 * instances with non-NULL fwnodes, and client devices should have been
+	 * identified with a fwspec by this point. Otherwise, we will iterate
+	 * over all the global drivers and call their probe function to find a
+	 * match.
+	 */
+	fwspec = dev_iommu_fwspec_get(dev);
+	if (fwspec && fwspec->ops)
+		return __iommu_do_probe_device(dev, fwspec->ops);
+
+	mutex_lock(&iommu_device_lock);
+	list_for_each_entry(iter, &iommu_device_list, list) {
+		iommu_dev = __iommu_do_probe_device(dev, iter->ops);
+		if (!IS_ERR(iommu_dev))
+			break;
+	}
+	mutex_unlock(&iommu_device_lock);
+
+	return iommu_dev;
+}
+
 /*
  * Init the dev->iommu and dev->iommu_group in the struct device and get the
  * driver probed
  */
-static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
+static int iommu_init_device(struct device *dev)
 {
 	struct iommu_device *iommu_dev;
+	const struct iommu_ops *ops;
 	struct iommu_group *group;
 	int ret;
 
 	if (!dev_iommu_get(dev))
 		return -ENOMEM;
 
-	if (!try_module_get(ops->owner)) {
-		ret = -EINVAL;
-		goto err_free;
-	}
-
-	iommu_dev = ops->probe_device(dev);
+	iommu_dev = iommu_probe_device_ops(dev);
 	if (IS_ERR(iommu_dev)) {
 		ret = PTR_ERR(iommu_dev);
-		goto err_module_put;
+		goto err_free;
 	}
 	dev->iommu->iommu_dev = iommu_dev;
+	ops = dev_iommu_ops(dev);
 
 	ret = iommu_device_link(iommu_dev, dev);
 	if (ret)
@@ -444,7 +483,6 @@ static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
 err_release:
 	if (ops->release_device)
 		ops->release_device(dev);
-err_module_put:
 	module_put(ops->owner);
 err_free:
 	dev->iommu->iommu_dev = NULL;
@@ -499,28 +537,10 @@ DEFINE_MUTEX(iommu_probe_device_lock);
 
 static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
 {
-	const struct iommu_ops *ops;
-	struct iommu_fwspec *fwspec;
 	struct iommu_group *group;
 	struct group_device *gdev;
 	int ret;
 
-	/*
-	 * For FDT-based systems and ACPI IORT/VIOT, drivers register IOMMU
-	 * instances with non-NULL fwnodes, and client devices should have been
-	 * identified with a fwspec by this point. Otherwise, we can currently
-	 * assume that only one of Intel, AMD, s390, PAMU or legacy SMMUv2 can
-	 * be present, and that any of their registered instances has suitable
-	 * ops for probing, and thus cheekily co-opt the same mechanism.
-	 */
-	fwspec = dev_iommu_fwspec_get(dev);
-	if (fwspec && fwspec->ops)
-		ops = fwspec->ops;
-	else
-		ops = iommu_ops_from_fwnode(NULL);
-
-	if (!ops)
-		return -ENODEV;
 	/*
 	 * Serialise to avoid races between IOMMU drivers registering in
 	 * parallel and/or the "replay" calls from ACPI/OF code via client
@@ -534,7 +554,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	if (dev->iommu_group)
 		return 0;
 
-	ret = iommu_init_device(dev, ops);
+	ret = iommu_init_device(dev);
 	if (ret)
 		return ret;
 
-- 
2.34.1


