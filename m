Return-Path: <linux-kernel+bounces-92370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CAC871F28
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36FEA288053
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3A55B68D;
	Tue,  5 Mar 2024 12:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fHtum+OI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E895B685
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 12:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709641654; cv=none; b=i/dGTH6BL/EjKPpgXn1sGtQhE8ssD7IvHjXABpcujXmd21B5fdXBqVkdo6kaLFhLWjnURVfTfWdj5OmlF+nqwTaN+enKr2/TsiTSB0d7GV/9O8XRxttMTZrp80+X2CJ6NU3j0ZxHgPc4aps51KYPDfrRZcuvbgj6cNwmpabVaqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709641654; c=relaxed/simple;
	bh=Wea79WtDueDcsbl7gYJzerSqx45NPTieanVyZzD4qvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PnJOzkpGeOqxC9Gi8O6QFg7WR39XeRJ44SjzqTuPiWi2Iod+FDJi0u1gUzhAjNkKAd4tsxMyjXYYZ/94p/wtR1urPx+tCxl09o7Ci2fC265iyuf0EVrpzRO9KKeKHEddAVAbD5PbJdqDjvtmIe8I+cGo/I85mNtQDxEvZmEwBbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fHtum+OI; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709641652; x=1741177652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wea79WtDueDcsbl7gYJzerSqx45NPTieanVyZzD4qvA=;
  b=fHtum+OIi8Eub/3wMyZCJgd3qTkjkRBEE4VbcZH1e5ynHn529DPrp+dv
   IR8Ln5WKekm6OT8/afWRA+ooJfvPT92ON1TS4ieA0V30rcc8zYxw8k6H4
   t4s/SNt9aO0aEW624u/DLTDDQ7g/Varm5PYF9k+l1Ye33aI0A7XTUj45l
   LFt4yWQM+GU97yFo/dJwEAdYA8QKfEmOsbvBEAuk+8bf3Co39LpWXNvZt
   5sQMUEsDp23xCJGTl5Ua7Z9maraxpu8TD/GXfUL1v4XGXwnFD/a8c/Lj6
   XxrVYxF3z+bqcMULOgW0BQ76bqNEbGMPN5aJJ2W3utD28ZawekwykcSX7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="21648461"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="21648461"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 04:27:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9330097"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 05 Mar 2024 04:27:30 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Ethan Zhao <haifeng.zhao@linux.intel.com>,
	Eric Badger <ebadger@purestorage.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] iommu/vt-d: Improve ITE fault handling if target device isn't present
Date: Tue,  5 Mar 2024 20:21:16 +0800
Message-Id: <20240305122121.211482-4-baolu.lu@linux.intel.com>
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

From: Ethan Zhao <haifeng.zhao@linux.intel.com>

Because surprise removal could happen anytime, e.g. user could request safe
removal to EP(endpoint device) via sysfs and brings its link down to do
surprise removal cocurrently. such aggressive cases would cause ATS
invalidation request issued to non-existence target device, then deadly
loop to retry that request after ITE fault triggered in interrupt context.
this patch aims to optimize the ITE handling by checking the target device
presence state to avoid retrying the timeout request blindly, thus avoid
hard lockup or system hang.

Devices TLB should only be invalidated when devices are in the
iommu->device_rbtree (probed, not released) and present.

Fixes: 6ba6c3a4cacf ("VT-d: add device IOTLB invalidation support")
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
Link: https://lore.kernel.org/r/20240301080727.3529832-4-haifeng.zhao@linux.intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/dmar.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index d14797aabb7a..36d7427b1202 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1273,6 +1273,8 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 {
 	u32 fault;
 	int head, tail;
+	struct device *dev;
+	u64 iqe_err, ite_sid;
 	struct q_inval *qi = iommu->qi;
 	int shift = qi_shift(iommu);
 
@@ -1317,6 +1319,13 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 		tail = readl(iommu->reg + DMAR_IQT_REG);
 		tail = ((tail >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
 
+		/*
+		 * SID field is valid only when the ITE field is Set in FSTS_REG
+		 * see Intel VT-d spec r4.1, section 11.4.9.9
+		 */
+		iqe_err = dmar_readq(iommu->reg + DMAR_IQER_REG);
+		ite_sid = DMAR_IQER_REG_ITESID(iqe_err);
+
 		writel(DMA_FSTS_ITE, iommu->reg + DMAR_FSTS_REG);
 		pr_info("Invalidation Time-out Error (ITE) cleared\n");
 
@@ -1326,6 +1335,19 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 			head = (head - 2 + QI_LENGTH) % QI_LENGTH;
 		} while (head != tail);
 
+		/*
+		 * If device was released or isn't present, no need to retry
+		 * the ATS invalidate request anymore.
+		 *
+		 * 0 value of ite_sid means old VT-d device, no ite_sid value.
+		 * see Intel VT-d spec r4.1, section 11.4.9.9
+		 */
+		if (ite_sid) {
+			dev = device_rbtree_find(iommu, ite_sid);
+			if (!dev || !dev_is_pci(dev) ||
+			    !pci_device_is_present(to_pci_dev(dev)))
+				return -ETIMEDOUT;
+		}
 		if (qi->desc_status[wait_index] == QI_ABORT)
 			return -EAGAIN;
 	}
-- 
2.34.1


