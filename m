Return-Path: <linux-kernel+bounces-96858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35B6876247
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE2CC283F9C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E665579B;
	Fri,  8 Mar 2024 10:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eQD+8iqq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F54453E01
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 10:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709894437; cv=none; b=F2g5XdVIMCSLHEsC1yCY/h6qwUHDzxcwCkU9gB4lsbsPKUpBikUjWWQAWFuy3ejfqR/s3Jr8kl4Ar9uGJbdjmvQMHIuP1vgqjjJmye7qcy9Fxq6SIwfVbRTfmNDpMT7inFCa/AmElby7M5sIVXZKUNhtI8LN1PuYT4SuV2OniXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709894437; c=relaxed/simple;
	bh=2uhKxWGX+9u6EoIE9yYtUoG0SbRFNtgP+LuuIWdCVYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K+f7b9lTeGRtn7RqOzkBS+i1qWR/keKvqahbCWP2mJzA93i70EXAvW+wc0ItCMCna10/igzS5LNTZhPQhO2TN1ByBHDPnpvQQZh1pobD8CsTCO3pPgPMz98YacFhN0PhQ7sKNZ9BTUkGTL/8ZeNd2yic4U71MG/rTuVFp9gzNgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eQD+8iqq; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709894436; x=1741430436;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2uhKxWGX+9u6EoIE9yYtUoG0SbRFNtgP+LuuIWdCVYo=;
  b=eQD+8iqqZn1LRERp2e6KkyKz8IRAsYG58Tk7PVb+mgGmbcSHbg/LtcnC
   FBzLkdnQXUorSuOpi1I6LXtwv9m+TMx5XgTKQuyXLluHyGEVcDn6hQk8a
   42foekOsJC/l91bGotTsb+/kn4Mw0Vr+Y+osOXJ2LJzCDLz0HE3wHd+qr
   xzjDuJfowRkEASCQT9ToZDRzDJOfjjoetJAIpCAepcVgf3S/EUZAfNhUy
   qUTPZcuXE0cMYrywEMCdDW3f1TvSllMLaE5VyCpG1iZrFyX26Mzqjzvs5
   970/jJUR2iOCS1F8KpyOUPLvRlQtlAOa0iyM19ulxiX0G5QUMRK8i5JLR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4468246"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="4468246"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 02:40:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="10327730"
Received: from cascade.sh.intel.com ([10.239.48.141])
  by fmviesa007.fm.intel.com with ESMTP; 08 Mar 2024 02:40:33 -0800
From: Jingqi Liu <Jingqi.liu@intel.com>
To: iommu@lists.linux.dev,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Tian Kevin <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org,
	Jingqi Liu <Jingqi.liu@intel.com>
Subject: [PATCH 1/2] iommu/vt-d: Remove debugfs use of private data field
Date: Fri,  8 Mar 2024 18:38:10 +0800
Message-Id: <20240308103811.76744-2-Jingqi.liu@intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20240308103811.76744-1-Jingqi.liu@intel.com>
References: <20240308103811.76744-1-Jingqi.liu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the page fault report and response have been tracked by ftrace,
the users can easily calculate the time used for a page fault
handling. There's no need to expose the similar functionality in
debugfs. Hence, remove the corresponding operations in debugfs.

Signed-off-by: Jingqi Liu <Jingqi.liu@intel.com>
---
 drivers/iommu/intel/debugfs.c | 7 -------
 drivers/iommu/intel/perf.h    | 1 -
 drivers/iommu/intel/svm.c     | 9 ---------
 3 files changed, 17 deletions(-)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index 86b506af7daa..affbf4a1558d 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -706,7 +706,6 @@ static ssize_t dmar_perf_latency_write(struct file *filp,
 			dmar_latency_disable(iommu, DMAR_LATENCY_INV_IOTLB);
 			dmar_latency_disable(iommu, DMAR_LATENCY_INV_DEVTLB);
 			dmar_latency_disable(iommu, DMAR_LATENCY_INV_IEC);
-			dmar_latency_disable(iommu, DMAR_LATENCY_PRQ);
 		}
 		rcu_read_unlock();
 		break;
@@ -728,12 +727,6 @@ static ssize_t dmar_perf_latency_write(struct file *filp,
 			dmar_latency_enable(iommu, DMAR_LATENCY_INV_IEC);
 		rcu_read_unlock();
 		break;
-	case 4:
-		rcu_read_lock();
-		for_each_active_iommu(iommu, drhd)
-			dmar_latency_enable(iommu, DMAR_LATENCY_PRQ);
-		rcu_read_unlock();
-		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/iommu/intel/perf.h b/drivers/iommu/intel/perf.h
index fd6db8049d1a..df9a36942d64 100644
--- a/drivers/iommu/intel/perf.h
+++ b/drivers/iommu/intel/perf.h
@@ -11,7 +11,6 @@ enum latency_type {
 	DMAR_LATENCY_INV_IOTLB = 0,
 	DMAR_LATENCY_INV_DEVTLB,
 	DMAR_LATENCY_INV_IEC,
-	DMAR_LATENCY_PRQ,
 	DMAR_LATENCY_NUM
 };
 
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index c1bed89b1026..4b2eeb55489d 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -583,12 +583,6 @@ static void intel_svm_prq_report(struct intel_iommu *iommu, struct device *dev,
 		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PRIV_DATA;
 		event.fault.prm.private_data[0] = desc->priv_data[0];
 		event.fault.prm.private_data[1] = desc->priv_data[1];
-	} else if (dmar_latency_enabled(iommu, DMAR_LATENCY_PRQ)) {
-		/*
-		 * If the private data fields are not used by hardware, use it
-		 * to monitor the prq handle latency.
-		 */
-		event.fault.prm.private_data[0] = ktime_to_ns(ktime_get());
 	}
 
 	iommu_report_device_fault(dev, &event);
@@ -768,9 +762,6 @@ void intel_svm_page_response(struct device *dev, struct iopf_fault *evt,
 		if (private_present) {
 			desc.qw2 = prm->private_data[0];
 			desc.qw3 = prm->private_data[1];
-		} else if (prm->private_data[0]) {
-			dmar_latency_update(iommu, DMAR_LATENCY_PRQ,
-				ktime_to_ns(ktime_get()) - prm->private_data[0]);
 		}
 
 		qi_submit_sync(iommu, &desc, 1, 0);
-- 
2.21.3


