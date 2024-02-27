Return-Path: <linux-kernel+bounces-82593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9EF8686CF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 212371C289EE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFFB4F1E5;
	Tue, 27 Feb 2024 02:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CEwkZYR4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7431B38DDC
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 02:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709000449; cv=none; b=kNOVEy1ODS3iApSMMyim5axD1UJXm9417G9oBJLnWNuNvjb6dJV6C4qFYC/eqGj+GcIsTpeuRZeqAKjxPDUIb1F9tN7CWye/llToNi2o1ZbMr8d0/T1X9vushkYXdvt5IcdQJB1jHv03E3wNw/f8BHtmvvV27Pjs7KmLIJmU0iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709000449; c=relaxed/simple;
	bh=rGkjK8I6tdNmwQIoAe5T5sY8845ERzQRM0cTXjlxP3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bOYGKQ7qywA3ShuyKdzYSk8kTcu1HgAcI1iDPAvslUlDTn8NcGRu5JS9SrP8IJL3IOf2LmGErXWOqfAkUsmplKchCgzn/GqUw5PkEQns0n5H1jiAb0EYQmNxIaKX80T8NVtd4nOCqzt8OUzsV+wAiV62ToS2HD3Ie6ZQf/I9CBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CEwkZYR4; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709000448; x=1740536448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rGkjK8I6tdNmwQIoAe5T5sY8845ERzQRM0cTXjlxP3Y=;
  b=CEwkZYR46vbarV65BOMW8xBqTZQJ0UPRmA0NF7aNii6r7SCv1PvLTSmz
   qxb4tCR32VgTR1Gx+2Y8qa5OmUKCF1jwuGxn13WTrdlc1ugdcXQL9AmhP
   GwuXU8jwum6cwQJR9wVV/Tl1Y3dlUv8zK3hbghGv6o+2/+qwlNzGg033X
   rYBf47wwY2RoUHucr8Nus48FTA+WHVcU/IGlDN3vPW2kvPrzW7ppMTCjj
   rBh7qqmzNz13bXfhiux9FaNOLXX0b43pKeb0Pz5mPIqkkUbo3U1/JI0Lf
   I9u3FW+9x9YROet0RNVVUNa7BUmZjC28dIZIezW1l+628PfPHdT5FCIXf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="6273120"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="6273120"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 18:20:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7418300"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 26 Feb 2024 18:20:46 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Erick Archer <erick.archer@gmx.com>,
	Jingqi Liu <Jingqi.liu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] iommu/vt-d: Remove initialization for dynamically heap-allocated rcu_head
Date: Tue, 27 Feb 2024 10:14:38 +0800
Message-Id: <20240227021441.50434-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227021441.50434-1-baolu.lu@linux.intel.com>
References: <20240227021441.50434-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tina Zhang <tina.zhang@intel.com>

The rcu_head structures allocated dynamically in the heap don't need any
initialization. Therefore, remove the init_rcu_head().

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
Link: https://lore.kernel.org/r/20240219125723.1645703-3-tina.zhang@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index a815362c8e60..a92a9e2239e2 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -360,7 +360,6 @@ static int intel_svm_bind_mm(struct intel_iommu *iommu, struct device *dev,
 	sdev->iommu = iommu;
 	sdev->did = FLPT_DEFAULT_DID;
 	sdev->sid = PCI_DEVID(info->bus, info->devfn);
-	init_rcu_head(&sdev->rcu);
 	if (info->ats_enabled) {
 		sdev->qdep = info->ats_qdep;
 		if (sdev->qdep >= QI_DEV_EIOTLB_MAX_INVS)
-- 
2.34.1


