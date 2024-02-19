Return-Path: <linux-kernel+bounces-71193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 428A685A1DB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADE23B22FC4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355D631A79;
	Mon, 19 Feb 2024 11:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ne/ohbi6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185762E835
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341732; cv=none; b=QW9CIHScMfgjBmMGmo1aRpPQIWsqsqMtdrV3gO5QSpVneWWYFV228aHLFdl0e1Z+DklNPdNRMKjB0lEzGYwwkHaOcngFaV6Gah4sBQOhNrNBZJ4xJ8maaZ83X1yw2maFBerxkrFTEHgPiPfU7rc8cWAJUPfvoMheKdZLa6m1ekY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341732; c=relaxed/simple;
	bh=c8ihMzuK+A3SWUIyq5JZpbhzCFh2xbpRUbw/s59zjdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HO1km1t66Rtk3aW639SifmTNRH13gb2jUGSplrP75thqL2kmrD3PpF3YVGjwMdNE01CK6tqRzGN5QPqAH6EMJdmZm5XFKYZD0tj0ssfsKL3lAedL6QopfimCny4lFyZBJuEcLeBq54dPbqVsV02oShP+b3fCnOUVV99TfQQqpxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ne/ohbi6; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708341732; x=1739877732;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c8ihMzuK+A3SWUIyq5JZpbhzCFh2xbpRUbw/s59zjdc=;
  b=Ne/ohbi6h39hsp6bK49dALM3TpOcEMo5M0vgGrqxZKTho7HIz1SKfv/W
   Wswb+z0Vkci/ZapFLkpz1fj/Xa8EdJTvYBHHQF2pwjxmALKpI5I52RU7g
   BBCrXlp9bUSJA1phpTo3dAa17BlTbZmwANqUyk3jv2PrtXHwOQmhLu+VA
   D5nB+M4/sfoCH8ni028A5xCYka8Ha6ZtiSf2Uy4taloSWuWZnGIbkWhay
   D6WY1Ulf5xzVER9fI3IEh7P2RYSeRXaW9lLblJ29dWYoG82tXO7WJ/Fdx
   cEDRnBcVqqQ20X0fonvaQ/upC8k5FplVqeitQFEuprlmQsHS7fRfzXByG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="13823396"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="13823396"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 03:22:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4826865"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa006.jf.intel.com with ESMTP; 19 Feb 2024 03:22:09 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Yi Liu <yi.l.liu@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] iommu/vt-d: Add missing dirty tracking set for parent domain
Date: Mon, 19 Feb 2024 19:15:59 +0800
Message-Id: <20240219111601.96405-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219111601.96405-1-baolu.lu@linux.intel.com>
References: <20240219111601.96405-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yi Liu <yi.l.liu@intel.com>

Setting dirty tracking for a s2 domain requires to loop all the related
devices and set the dirty tracking enable bit in the PASID table entry.
This includes the devices that are attached to the nested domains of a
s2 domain if this s2 domain is used as parent. However, the existing dirty
tracking set only loops s2 domain's own devices. It will miss dirty page
logs in the parent domain.

Now, the parent domain tracks the nested domains, so it can loop the
nested domains and the devices attached to the nested domains to ensure
dirty tracking on the parent is set completely.

Fixes: b41e38e22539 ("iommu/vt-d: Add nested domain allocation")
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240208082307.15759-9-yi.l.liu@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2ad8fbe6dc21..11652e0bcab3 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4748,6 +4748,35 @@ static int device_set_dirty_tracking(struct list_head *devices, bool enable)
 	return ret;
 }
 
+static int parent_domain_set_dirty_tracking(struct dmar_domain *domain,
+					    bool enable)
+{
+	struct dmar_domain *s1_domain;
+	unsigned long flags;
+	int ret;
+
+	spin_lock(&domain->s1_lock);
+	list_for_each_entry(s1_domain, &domain->s1_domains, s2_link) {
+		spin_lock_irqsave(&s1_domain->lock, flags);
+		ret = device_set_dirty_tracking(&s1_domain->devices, enable);
+		spin_unlock_irqrestore(&s1_domain->lock, flags);
+		if (ret)
+			goto err_unwind;
+	}
+	spin_unlock(&domain->s1_lock);
+	return 0;
+
+err_unwind:
+	list_for_each_entry(s1_domain, &domain->s1_domains, s2_link) {
+		spin_lock_irqsave(&s1_domain->lock, flags);
+		device_set_dirty_tracking(&s1_domain->devices,
+					  domain->dirty_tracking);
+		spin_unlock_irqrestore(&s1_domain->lock, flags);
+	}
+	spin_unlock(&domain->s1_lock);
+	return ret;
+}
+
 static int intel_iommu_set_dirty_tracking(struct iommu_domain *domain,
 					  bool enable)
 {
@@ -4762,6 +4791,12 @@ static int intel_iommu_set_dirty_tracking(struct iommu_domain *domain,
 	if (ret)
 		goto err_unwind;
 
+	if (dmar_domain->nested_parent) {
+		ret = parent_domain_set_dirty_tracking(dmar_domain, enable);
+		if (ret)
+			goto err_unwind;
+	}
+
 	dmar_domain->dirty_tracking = enable;
 out_unlock:
 	spin_unlock(&dmar_domain->lock);
-- 
2.34.1


