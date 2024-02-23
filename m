Return-Path: <linux-kernel+bounces-77782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FD2860A2C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 962821F25F33
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890CD125AF;
	Fri, 23 Feb 2024 05:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XoUy9ZEh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6177211738
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 05:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708665545; cv=none; b=sYhFew7U3z1SaT7s3F9ENzCyVxK44zKTF+Bl1QK1bggI9CMWK+OKbnbA4PYeiAJF1cof4IEHuprg4dgOSHiRvfOQbbJiz4qhIcM4iv6ZbaoHNmt8DS9sUqUsl3Bl8mCu97FTi91i7GfGvVPEnN4DMhgDnedExJ/M0O/2JZwAlpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708665545; c=relaxed/simple;
	bh=Tk9A4I0oMmelCpHSwdKZxqF1e4tJfbiF9SDU75PTANQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JW01FW6N+xBciHXKaALe3ZS/cxw0sotytTEiu9ZebPy4BLgU1b4RKZmUKAI9Q905rOd97LdDuEFsfM64VEU21j404FW2PCWgVcDOdokck8g4emgK350JwfnHaTPpuO8ki1ju39vTIptjQG/7gM9Dbi3igbjcV/PYsiFbxSzZ2Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XoUy9ZEh; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708665544; x=1740201544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tk9A4I0oMmelCpHSwdKZxqF1e4tJfbiF9SDU75PTANQ=;
  b=XoUy9ZEhcb/1WdMDoh2xB+cxXgDkXzLTQq1CA/zYUy0eFejj2EiJYHAl
   QKXC99QAtS+bL+0whhLWtlpARk2t10FpgajrYXPb7XyWUfAt6fC3Q2Jeb
   AsVt6XmVd9YJB+EztX8xj0Ju93913+xIvCxNtMwTR5JEu8zlpAdux272v
   rbmzXU0pcREbNUis9Lh+NXMGvFOGXGhMgekUb3xLMQt76ErNpKiu12+L/
   w7X7pVWN9/vPmGBdshMHurSFFwMhjNhgNcFlsdU3T2j0p9DrBRA0RcZMt
   TcwhYKQhpTxbh+MEF+CKAj+qOq8NXc+UsKKx/ndqo0NXm6whDzjnZccTh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="28395436"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="28395436"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 21:19:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5999892"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa006.fm.intel.com with ESMTP; 22 Feb 2024 21:19:02 -0800
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
Subject: [PATCH 1/2] iommu: Add static iommu_ops->release_domain
Date: Fri, 23 Feb 2024 13:13:01 +0800
Message-Id: <20240223051302.177596-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223051302.177596-1-baolu.lu@linux.intel.com>
References: <20240223051302.177596-1-baolu.lu@linux.intel.com>
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
---
 include/linux/iommu.h |  1 +
 drivers/iommu/iommu.c | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index de839fd01bb8..e3d9365b0fa9 100644
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
index 210dc7b4c8cf..fb06c3f47320 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -459,6 +459,18 @@ static void iommu_deinit_device(struct device *dev)
 
 	iommu_device_unlink(dev->iommu->iommu_dev, dev);
 
+	/*
+	 * If the iommu driver provides release_domain then the core code
+	 * ensures that domain is attached prior to calling release_device.
+	 * Drivers can use this to enforce a translation on the idle iommu.
+	 * Usually the global static blocked_domain is a good choice.
+	 *
+	 * Anyway, if a deferred attach never happened then the release
+	 * should still avoid touching any hardware configuration either.
+	 */
+	if (!dev->iommu->attach_deferred && ops->release_domain)
+		ops->release_domain->ops->attach_dev(ops->release_domain, dev);
+
 	/*
 	 * release_device() must stop using any attached domain on the device.
 	 * If there are still other devices in the group they are not effected
-- 
2.34.1


