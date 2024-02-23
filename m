Return-Path: <linux-kernel+bounces-77783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16339860A2E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4F49288829
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114E512B7B;
	Fri, 23 Feb 2024 05:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J8HQ4a42"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4C6125B8
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 05:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708665548; cv=none; b=fmEI2CfYBoxh+YmhZ2wNGqe9R6YuG894VTtIIAW4I3t81Xn59T2Yy7e4+JHo57a9rOqxr2O3Q+SOSWNsnSeHNdLZnoF8lTpaXWGu3MsoiHFXfMdx98RioFfUSptPZ8aFSzDg0yOvpQbK5QW51b1pzQ2PN/pZmIi9dLZuhZIOwy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708665548; c=relaxed/simple;
	bh=aj8WBi473QKu6WuNMZasSmz84DJgvffMYsFTZXTEz2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aCiUqPw4fMebwTF/aJnT6kEx874TUkr+HIc+dIcAune5o+ASuoE7kXiWQsU6OmmoYZOWJxQUzyJtVPe4kzAYG5LSia4SXsVvuNyKtUrEkb8ukcocnmeBBq1kQ4aF1L9BxFclm+AuW9hfUak1aWhoGNRNpgJsTuALT62+AWjYKfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J8HQ4a42; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708665547; x=1740201547;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aj8WBi473QKu6WuNMZasSmz84DJgvffMYsFTZXTEz2c=;
  b=J8HQ4a42Y9/M9eF6VjeULe0cmZ+gQDAsCXydSNqqGZHt2cq3uZ91OI++
   52DqxWehh7/toKzE09GRn6mk/lOuyWbOWtAuVT4Yb/Ne05LeB/YyozMTR
   6R09jHtBnwIf03339E7hW0txNyNEBzdw2ZQY6F27cEAcgPoG+H2eoBlas
   ZFpsPFj1EZsa5+x75QkFYyi6D9qTjnZppCA0LbDvk7yIMYtWXzBblViRX
   N7cWEyqYnSB9b4pDSXCOsJPPjHc7vKEV0sE8wYUqE/33e16ic6yPzWkDa
   Ul2T6shG3bNDwPATeRIvcLnTCru6Yb7QkJCQenqAoEch2oVNuhWTdg8mH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="28395445"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="28395445"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 21:19:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5999900"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa006.fm.intel.com with ESMTP; 22 Feb 2024 21:19:04 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Eric Badger <ebadger@purestorage.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 2/2] iommu/vt-d: Fix NULL domain on device release
Date: Fri, 23 Feb 2024 13:13:02 +0800
Message-Id: <20240223051302.177596-3-baolu.lu@linux.intel.com>
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

In the kdump kernel, the IOMMU operates in deferred_attach mode. In this
mode, info->domain may not yet be assigned by the time the release_device
function is called. It leads to the following crash in the crash kernel:

    BUG: kernel NULL pointer dereference, address: 000000000000003c
    ...
    RIP: 0010:do_raw_spin_lock+0xa/0xa0
    ...
    _raw_spin_lock_irqsave+0x1b/0x30
    intel_iommu_release_device+0x96/0x170
    iommu_deinit_device+0x39/0xf0
    __iommu_group_remove_device+0xa0/0xd0
    iommu_bus_notifier+0x55/0xb0
    notifier_call_chain+0x5a/0xd0
    blocking_notifier_call_chain+0x41/0x60
    bus_notify+0x34/0x50
    device_del+0x269/0x3d0
    pci_remove_bus_device+0x77/0x100
    p2sb_bar+0xae/0x1d0
    ...
    i801_probe+0x423/0x740

Use the release_domain mechanism to fix it.

Fixes: 586081d3f6b1 ("iommu/vt-d: Remove DEFER_DEVICE_DOMAIN_INFO")
Reported-by: Eric Badger <ebadger@purestorage.com>
Closes: https://lore.kernel.org/r/20240113181713.1817855-1-ebadger@purestorage.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 26 +-------------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 61bb35046ea4..2c04ea90d22f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3798,30 +3798,6 @@ static void domain_context_clear(struct device_domain_info *info)
 			       &domain_context_clear_one_cb, info);
 }
 
-static void dmar_remove_one_dev_info(struct device *dev)
-{
-	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	struct dmar_domain *domain = info->domain;
-	struct intel_iommu *iommu = info->iommu;
-	unsigned long flags;
-
-	if (!dev_is_real_dma_subdevice(info->dev)) {
-		if (dev_is_pci(info->dev) && sm_supported(iommu))
-			intel_pasid_tear_down_entry(iommu, info->dev,
-					IOMMU_NO_PASID, false);
-
-		iommu_disable_pci_caps(info);
-		domain_context_clear(info);
-	}
-
-	spin_lock_irqsave(&domain->lock, flags);
-	list_del(&info->link);
-	spin_unlock_irqrestore(&domain->lock, flags);
-
-	domain_detach_iommu(domain, iommu);
-	info->domain = NULL;
-}
-
 /*
  * Clear the page table pointer in context or pasid table entries so that
  * all DMA requests without PASID from the device are blocked. If the page
@@ -4348,7 +4324,6 @@ static void intel_iommu_release_device(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 
-	dmar_remove_one_dev_info(dev);
 	intel_pasid_free_table(dev);
 	intel_iommu_debugfs_remove_dev(info);
 	kfree(info);
@@ -4839,6 +4814,7 @@ static const struct iommu_dirty_ops intel_dirty_ops = {
 
 const struct iommu_ops intel_iommu_ops = {
 	.blocked_domain		= &blocking_domain,
+	.release_domain		= &blocking_domain,
 	.capable		= intel_iommu_capable,
 	.hw_info		= intel_iommu_hw_info,
 	.domain_alloc		= intel_iommu_domain_alloc,
-- 
2.34.1


