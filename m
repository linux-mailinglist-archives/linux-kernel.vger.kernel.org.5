Return-Path: <linux-kernel+bounces-71190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 311A785A1D8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5A26B229DC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A559A2D608;
	Mon, 19 Feb 2024 11:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nQXPKWNL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6DA2D606
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341726; cv=none; b=Y6JdPpW4HbSp5d+B0kuDG37QvLGnLklcxTfJLhZPIySGD8no4qMBxbu4GwEdMBeRpotRHtZ8v2YFAJ77yoG91Xdm+gqBixJl6b2K6Y5660dVBmXZvjbgSCv0L/W3HtGUxTEiTqlRxEuRmlQLta/vsoVo2GnBPFAkChvSWOakaP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341726; c=relaxed/simple;
	bh=Czn+l+8Z40u8Nj0hak+E8ur277wY/U7sKfZyklmUb7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A+P918l5te6P6JQQFC7pgiHJBtsNlcIkjMDCK2WQdoUu9ybHaI0BAcZqHWM2NLSHtz+Uc8pUoqdatFceE1+tfFqgmR6oPOutmH5N2EVY/BCXkwQgv94GOwdQAS9wQ8SIx56BYvj99kE0e190nEICOuxbIepJz2Pw3eOGLW1/yps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nQXPKWNL; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708341725; x=1739877725;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Czn+l+8Z40u8Nj0hak+E8ur277wY/U7sKfZyklmUb7M=;
  b=nQXPKWNLOVgJ/MROYRudmVFp+/96fl0cG5lawf8NFo/ScaqOOVzlpssm
   3yA7ZrpVAMLSbeCFMDNsC5ERqPwXxmrsEMYKfIw/v/8JQCYcWRSIsWH6n
   IbPJbEdeqgUTyccT0jfxU/p1DgmWtDehDIr6e5RUn9TVEfrIZTwRjsCFO
   Cw3wY7yRymXj/kxVmcd1+WuWpu2iu/7hUpXrbMM6kA3sOFy+nc7fSjVef
   t3aOhSgF1DiilPcxf/kfkZncLCQVPgTonkvgvDoFru7PVTEAC27xllJ3e
   DRfyQyO3zSZwA+lLZnYJx/RqntZJTQSI4ZpRmmeRcDrw283PwmL/dTB8m
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="13823369"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="13823369"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 03:22:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4826834"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa006.jf.intel.com with ESMTP; 19 Feb 2024 03:22:02 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Yi Liu <yi.l.liu@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] iommu/vt-d: Add missing device iotlb flush for parent domain
Date: Mon, 19 Feb 2024 19:15:56 +0800
Message-Id: <20240219111601.96405-6-baolu.lu@linux.intel.com>
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

ATS-capable devices cache the result of nested translation. This result
relies on the mappings in s2 domain (a.k.a. parent). When there are
modifications in the s2 domain, the related nested translation caches on
the device should be flushed. This includes the devices that are attached
to the s1 domain. However, the existing code ignores this fact to only
loops its own devices.

As there is no easy way to identify the exact set of nested translations
affected by the change of s2 domain. So, this just flushes the entire
device iotlb on the device.

As above, driver loops the s2 domain's s1_domains list and loops the
devices list of each s1_domain to flush the entire device iotlb on the
devices.

Fixes: b41e38e22539 ("iommu/vt-d: Add nested domain allocation")
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240208082307.15759-6-yi.l.liu@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 711c3e3fe095..2eee83b5441b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1461,12 +1461,30 @@ static void parent_domain_flush(struct dmar_domain *domain,
 
 	spin_lock(&domain->s1_lock);
 	list_for_each_entry(s1_domain, &domain->s1_domains, s2_link) {
+		struct device_domain_info *device_info;
 		struct iommu_domain_info *info;
+		unsigned long flags;
 		unsigned long i;
 
 		xa_for_each(&s1_domain->iommu_array, i, info)
 			__iommu_flush_iotlb_psi(info->iommu, info->did,
 						pfn, pages, ih);
+
+		if (!s1_domain->has_iotlb_device)
+			continue;
+
+		spin_lock_irqsave(&s1_domain->lock, flags);
+		list_for_each_entry(device_info, &s1_domain->devices, link)
+			/*
+			 * Address translation cache in device side caches the
+			 * result of nested translation. There is no easy way
+			 * to identify the exact set of nested translations
+			 * affected by a change in S2. So just flush the entire
+			 * device cache.
+			 */
+			__iommu_flush_dev_iotlb(device_info, 0,
+						MAX_AGAW_PFN_WIDTH);
+		spin_unlock_irqrestore(&s1_domain->lock, flags);
 	}
 	spin_unlock(&domain->s1_lock);
 }
-- 
2.34.1


