Return-Path: <linux-kernel+bounces-92371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F77871F29
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41725B24FBD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3E55BAFD;
	Tue,  5 Mar 2024 12:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iKlym7RD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048445B68A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 12:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709641655; cv=none; b=YiYyKpr3mA7Z3C5tPH32+OS0uN1K2Yt3dZZqyQOl5BWkjGXoA5dYJ4BDzhIYaXk6dof9NCkmwzE0ffu4VJbmghOZ0WDJk6yswhwzXchBnEzXYdVxvpFVjiP7kzaMonIH8VMuI4ZC1rm24nso4r56EKVi4MAYhc+OLEL0c67HhuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709641655; c=relaxed/simple;
	bh=maKNjl3/k7YtNAhNUBytDuUXRmMI86juobu03Z7Ayi0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hf687CcAs0ZYyoe7/czp7khVhwjYFglPpiz/VooRmvl5hY8NPqNbemoz6oNNdlFgnlJ3R5OPnadOru5YHbMGmfudMWNxVjPeNUp/A1tFiPQQ3+U7L++4/4MJjgC+v/zQguNm7JSK57Y6YBf7Ni2utEAP2hPs9/TEpsrCBuDIF48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iKlym7RD; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709641654; x=1741177654;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=maKNjl3/k7YtNAhNUBytDuUXRmMI86juobu03Z7Ayi0=;
  b=iKlym7RD50XrfGRApYpZBGTUV3HfJacix0vQ7aB8yTRhDpc2rw2BUXGy
   znYnFtz9OtQVRj8ZYMxa0ZACvGC8tuMVxni5CfH8SPcWYEdbH9HIRvpVh
   tYkpFeWuVrfCVP5Fi4w2nqrmuqLA/Pz13XyrW70gvSrL/7YFaaWMstPL1
   1Cq/A8G4zexvmt+RisrrCyO9Xqea9NiLW7BgPjVHwARwTJWFqm1qRSBtq
   xDJMzDQJ6jrazzw/cASTiFwG5vR9UDPMJzaqHF/7QACf8WkZ60fCbHzlH
   Wd+iU5Kxw5dWfcyUoQ9ClXFvUrNSsnbwmReow48a9X51M9j5QPaiz73qa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="21648471"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="21648471"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 04:27:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9330112"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 05 Mar 2024 04:27:32 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Ethan Zhao <haifeng.zhao@linux.intel.com>,
	Eric Badger <ebadger@purestorage.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] iommu: Add static iommu_ops->release_domain
Date: Tue,  5 Mar 2024 20:21:17 +0800
Message-Id: <20240305122121.211482-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305122121.211482-1-baolu.lu@linux.intel.com>
References: <20240305122121.211482-1-baolu.lu@linux.intel.com>
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
Link: https://lore.kernel.org/r/20240305013305.204605-2-baolu.lu@linux.intel.com
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


