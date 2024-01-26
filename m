Return-Path: <linux-kernel+bounces-40012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE99883D8C5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FD521F29107
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F1214282;
	Fri, 26 Jan 2024 10:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hn9Odf3J"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD071427E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 10:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706266768; cv=none; b=AwfsHxOco+CmOCT9pXuLyGjATg+ia3NBNIJxFSFtKKyk1xJHybXxT1dOOIKjtJRVoC9rROfrBI0DDQUSI7ZZNJwTwKSIdtRyzPpo5+REuLVHQxms8zeMy1/9HYugSNyxHyAch2aAXYf1cfWTg+yf66lf3EQQGYNXnr3O+nF3Nss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706266768; c=relaxed/simple;
	bh=zo5LBMZV0B5NEfxZY5cK3SYRyArtsbTV+MJeKCnjfLM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ez85ImVNVw40oYGFZrbgMOpwRkjYrLAPknJRouDGrKwBDwP6jUMa35Bdf4T5JR+SkQbWzrU0++FkqPXgvxTp7679wtAu1j0DcE1j/II4UhgNdm4xnZ3TmT2Kyjpd4ndd8eTYhwnaZJYo6Ds9CZvhm4uqcvODxAKHmyc1o+UwuqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hn9Odf3J; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706266757; x=1737802757;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zo5LBMZV0B5NEfxZY5cK3SYRyArtsbTV+MJeKCnjfLM=;
  b=hn9Odf3JaJL5JyZgOnfiFqE7GolbQX2OhDVHCul1hwDBk/cjZl8iD/Si
   NicqzVz75HWelJtyvE6BdA298vipgvhCFmZfijaPha+W1qgYfa2Ry7Emp
   NAvHVT0JuAsyGe/7HJwZ/h6JCjx5fopbsqDgu7WZHhjrS3j9VW0XUxdSm
   QbFOnH49vyKE8qlSbtdg7pU7cJpc36TgwjGvGBVw/UlgtGmYolfRajetN
   psl3ZxsLcj4DXKTOzjLdWbRqJb6Zq3oKwQgVSR15XP6OPDDvwr14Ontso
   oyX+y9Vo8XXCLHzl72Kfq2wsFyp1cyDaYJQJ/MUSKN7ZiWuYbot0y3/30
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9123363"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9123363"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 02:59:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="857367842"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="857367842"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga004.fm.intel.com with ESMTP; 26 Jan 2024 02:59:14 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 1/2] iommu: Use mutex instead of spinlock for iommu_device_list
Date: Fri, 26 Jan 2024 18:53:40 +0800
Message-Id: <20240126105341.78086-2-baolu.lu@linux.intel.com>
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

The iommu_device_lock spinlock was used to protect the iommu device
list. However, there is no requirement to access the iommu device
list in interrupt context. Therefore, a mutex is sufficient.

This also prepares for the next change, which will iterate the iommu
device list and call the probe callback within the locking area.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 68e648b55767..0af0b5544072 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -146,7 +146,7 @@ struct iommu_group_attribute iommu_group_attr_##_name =		\
 	container_of(_kobj, struct iommu_group, kobj)
 
 static LIST_HEAD(iommu_device_list);
-static DEFINE_SPINLOCK(iommu_device_lock);
+static DEFINE_MUTEX(iommu_device_lock);
 
 static const struct bus_type * const iommu_buses[] = {
 	&platform_bus_type,
@@ -262,9 +262,9 @@ int iommu_device_register(struct iommu_device *iommu,
 	if (hwdev)
 		iommu->fwnode = dev_fwnode(hwdev);
 
-	spin_lock(&iommu_device_lock);
+	mutex_lock(&iommu_device_lock);
 	list_add_tail(&iommu->list, &iommu_device_list);
-	spin_unlock(&iommu_device_lock);
+	mutex_unlock(&iommu_device_lock);
 
 	for (int i = 0; i < ARRAY_SIZE(iommu_buses) && !err; i++)
 		err = bus_iommu_probe(iommu_buses[i]);
@@ -279,9 +279,9 @@ void iommu_device_unregister(struct iommu_device *iommu)
 	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++)
 		bus_for_each_dev(iommu_buses[i], NULL, iommu, remove_iommu_group);
 
-	spin_lock(&iommu_device_lock);
+	mutex_lock(&iommu_device_lock);
 	list_del(&iommu->list);
-	spin_unlock(&iommu_device_lock);
+	mutex_unlock(&iommu_device_lock);
 
 	/* Pairs with the alloc in generic_single_device_group() */
 	iommu_group_put(iommu->singleton_group);
@@ -316,9 +316,9 @@ int iommu_device_register_bus(struct iommu_device *iommu,
 	if (err)
 		return err;
 
-	spin_lock(&iommu_device_lock);
+	mutex_lock(&iommu_device_lock);
 	list_add_tail(&iommu->list, &iommu_device_list);
-	spin_unlock(&iommu_device_lock);
+	mutex_unlock(&iommu_device_lock);
 
 	err = bus_iommu_probe(bus);
 	if (err) {
@@ -2033,9 +2033,9 @@ bool iommu_present(const struct bus_type *bus)
 
 	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
 		if (iommu_buses[i] == bus) {
-			spin_lock(&iommu_device_lock);
+			mutex_lock(&iommu_device_lock);
 			ret = !list_empty(&iommu_device_list);
-			spin_unlock(&iommu_device_lock);
+			mutex_unlock(&iommu_device_lock);
 		}
 	}
 	return ret;
@@ -2983,13 +2983,13 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 	const struct iommu_ops *ops = NULL;
 	struct iommu_device *iommu;
 
-	spin_lock(&iommu_device_lock);
+	mutex_lock(&iommu_device_lock);
 	list_for_each_entry(iommu, &iommu_device_list, list)
 		if (iommu->fwnode == fwnode) {
 			ops = iommu->ops;
 			break;
 		}
-	spin_unlock(&iommu_device_lock);
+	mutex_unlock(&iommu_device_lock);
 	return ops;
 }
 
-- 
2.34.1


