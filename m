Return-Path: <linux-kernel+bounces-91501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 120C4871264
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43D241C21A19
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DA118045;
	Tue,  5 Mar 2024 01:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jvMpyosq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A00817C74
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 01:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709602760; cv=none; b=iRFhj5DRHEMalTnH7K8Qtgw4ZK6SLyP427SO5MyXhFNyrgJKIQ/YOI0PcCsLZv/7P9g9a8o9OAcbWH9Q5zMULKyHKCHBcL7uZAGa4UBgDAp1LyWxJZlnlNpZW8lsMRNBnHPEDlUEP0Y+FScqSv7BwCIa+grXddkdYbyN58fijOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709602760; c=relaxed/simple;
	bh=jSRINu5rWaem2uvB6vunlGLVk7IHvJV3l54DVIsljm8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=muD8BHwEPJ7HiHOfRVVzMPDzaymSnJVaFPC9jrRhMEoAx2/97Qhy7Jpn/xMcJLk7oDC8MbuYArw9xo9V+O0LWo/K9OeiTqbZOOUiLOTSyp4O52HleReAEcb5DnlUsoDGXhhwkm9epJBkr7/ChRpYTHnxZf1HHHnJviJ+TK7CATQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jvMpyosq; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709602760; x=1741138760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jSRINu5rWaem2uvB6vunlGLVk7IHvJV3l54DVIsljm8=;
  b=jvMpyosqLPwXOzsZaoNVU4WqDFXS682e+d3r9I5Wxavy+/+xbHDFYXoH
   ys9HItYXBg5DMt7N5DGwqy8Nsdo/1eSLWLTIkbGQh+7OWi5lAv573/hlN
   365A6X04kv6wkCJ+B78iOh2uVaAxkr3sexH8mod1RnrN+khoduOvFIT0d
   gt3Eyj9bul41edO/thpzDmjpEIqm0NyjUtBeRseq9DuX/U5lVWIm5jFZN
   aXyssajhmuhoxBtjp81ClT7nPSG7D8fuKd9ZOgiCsxRjAGz2wsd9o3EEn
   vNzrWspCjxxJlg027uxjs+KjNy5pZAYuvoPcZJ+46ejnHgBAmEIsT494n
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4286689"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4286689"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 17:39:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="13865441"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 04 Mar 2024 17:39:16 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Eric Badger <ebadger@purestorage.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 1/5] iommu: Add static iommu_ops->release_domain
Date: Tue,  5 Mar 2024 09:33:01 +0800
Message-Id: <20240305013305.204605-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305013305.204605-1-baolu.lu@linux.intel.com>
References: <20240305013305.204605-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current device_release callback for individual iommu drivers does the
following:

1) Silent IOMMU DMA translation: It detaches any existing domain from the
   device and puts it into a blocking state (some drivers might use the
   identity state).
2) Resource release: It releases resources allocated during the
   device_probe callback and restores the device to its pre-probe state.

Step 1 is challenging for individual iommu drivers because each must check
if a domain is already attached to the device. Additionally, if a deferred
attach never occurred, the device_release should avoid modifying hardware
configuration regardless of the reason for its call.

To simplify this process, introduce a static release_domain within the
iommu_ops structure. It can be either a blocking or identity domain
depending on the iommu hardware. The iommu core will decide whether to
attach this domain before the device_release callback, eliminating the
need for repetitive code in various drivers.

Consequently, the device_release callback can focus solely on the opposite
operations of device_probe, including releasing all resources allocated
during that callback.

Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 include/linux/iommu.h |  1 +
 drivers/iommu/iommu.c | 19 +++++++++++++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index af6c367ed673..2e925b5eba53 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -585,6 +585,7 @@ struct iommu_ops {
 	struct module *owner;
 	struct iommu_domain *identity_domain;
 	struct iommu_domain *blocked_domain;
+	struct iommu_domain *release_domain;
 	struct iommu_domain *default_domain;
 };
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index eb50543bf956..098869007c69 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -462,13 +462,24 @@ static void iommu_deinit_device(struct device *dev)
 
 	/*
 	 * release_device() must stop using any attached domain on the device.
-	 * If there are still other devices in the group they are not effected
+	 * If there are still other devices in the group, they are not affected
 	 * by this callback.
 	 *
-	 * The IOMMU driver must set the device to either an identity or
-	 * blocking translation and stop using any domain pointer, as it is
-	 * going to be freed.
+	 * If the iommu driver provides release_domain, the core code ensures
+	 * that domain is attached prior to calling release_device. Drivers can
+	 * use this to enforce a translation on the idle iommu. Typically, the
+	 * global static blocked_domain is a good choice.
+	 *
+	 * Otherwise, the iommu driver must set the device to either an identity
+	 * or a blocking translation in release_device() and stop using any
+	 * domain pointer, as it is going to be freed.
+	 *
+	 * Regardless, if a delayed attach never occurred, then the release
+	 * should still avoid touching any hardware configuration either.
 	 */
+	if (!dev->iommu->attach_deferred && ops->release_domain)
+		ops->release_domain->ops->attach_dev(ops->release_domain, dev);
+
 	if (ops->release_device)
 		ops->release_device(dev);
 
-- 
2.34.1


