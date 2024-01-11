Return-Path: <linux-kernel+bounces-23158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E80482A879
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A53EE1C21269
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D92D299;
	Thu, 11 Jan 2024 07:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N6FpV21f"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD1FD28F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 07:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704958705; x=1736494705;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1P8soOsSAg4WFnLHZTKMOzbTMCW8wETbL0uhEPdgccw=;
  b=N6FpV21fHeJknRBKaPXaG/kKeWdYqsgJLMwDQ9ynSW7vShP1ZfLk/ALh
   qG6wkO0yYKjDAWsF9bRuhR3XN6s1s7y6ZGXVyuJ4WO01Jn9h3isT/0o8m
   fxi6OjbG3aR7OSMKIBQE9ZqR2+/5q1G5+4zZEIj5oDKmSz85nR+zOXdQE
   jMCzIWVJvW8CoqG9OstXg82rIevgzuCHR55byhH+qakZGmPq0+78IDdxX
   3RgwSEUOsZLRWq0iNkE37iaLbU4byEjW96Vx0K78ZQwOcDO2XLrA/hnvS
   T0jmmRlpSl9CjMEgckV+eVnT/KwxIjHnWkAE2UOZ0K5YrzDt9t646UIe/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="463056662"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="463056662"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 23:37:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="30909609"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa001.jf.intel.com with ESMTP; 10 Jan 2024 23:37:35 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommufd/selftest: Use right iommu_ops for mock device
Date: Thu, 11 Jan 2024 15:32:13 +0800
Message-Id: <20240111073213.180020-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the iommu probe device path, __iommu_probe_device() gets the iommu_ops
for the device from dev->iommu->fwspec if this field has been initialized
before probing. Otherwise, it will lookup the global iommu device list
and use the iommu_ops of the first iommu device which has no
dev->iommu->fwspec. This causes the wrong iommu_ops to be used for the mock
device on x86 platforms where dev->iommu->fwspec is not used.

Preallocate the fwspec for the mock device so that the right iommu ops can
be used.

Fixes: 17de3f5fdd35 ("iommu: Retire bus ops")
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommufd/selftest.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index cf3e9fed039e..4eca67b8a5c6 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -611,6 +611,8 @@ static void mock_dev_release(struct device *dev)
 
 static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 {
+	struct iommu_fwspec *fwspec;
+	struct dev_iommu *param;
 	struct mock_dev *mdev;
 	int rc;
 
@@ -621,10 +623,28 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 	if (!mdev)
 		return ERR_PTR(-ENOMEM);
 
+	/* fwspec and param will be freed in the iommu core */
+	fwspec = kzalloc(sizeof(*fwspec), GFP_KERNEL);
+	if (!fwspec) {
+		kfree(mdev);
+		return ERR_PTR(-ENOMEM);
+	}
+	fwspec->ops = &mock_ops;
+
+	param = kzalloc(sizeof(*param), GFP_KERNEL);
+	if (!param) {
+		kfree(mdev);
+		kfree(fwspec);
+		return ERR_PTR(-ENOMEM);
+	}
+	mutex_init(&param->lock);
+	param->fwspec = fwspec;
+
 	device_initialize(&mdev->dev);
 	mdev->flags = dev_flags;
 	mdev->dev.release = mock_dev_release;
 	mdev->dev.bus = &iommufd_mock_bus_type.bus;
+	mdev->dev.iommu = param;
 
 	rc = dev_set_name(&mdev->dev, "iommufd_mock%u",
 			  atomic_inc_return(&mock_dev_num));
@@ -638,6 +658,8 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 
 err_put:
 	put_device(&mdev->dev);
+	kfree(param);
+	kfree(fwspec);
 	return ERR_PTR(rc);
 }
 
-- 
2.34.1


