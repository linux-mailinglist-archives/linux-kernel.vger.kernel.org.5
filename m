Return-Path: <linux-kernel+bounces-88051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8C186DCB4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B7361F26514
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1BE69E04;
	Fri,  1 Mar 2024 08:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eauSVewi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC3F69E03
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 08:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709280479; cv=none; b=ilofXo76dDOrf7Q7cReSJE81UWoY0AqA6KTREedP9390DRu6XJCUC67/7WsHDQuEvB3vCnAigAoLDUUhKCTQtlKSl97WkwH2hePC73rS2ID57QTY9fgThxlo3XVun9yL3QbQphLWgk/d+h6ZTDE2IxAy4rcvLVR8MNhTGMgMy7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709280479; c=relaxed/simple;
	bh=/cVxTPK8YMoBH+k7owpPAvLO8OBKEisXNbpy2Gi5tXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KoF1CLz9yG9TkX63uvWlG8awDNXXACKPpP8wSnbC62btpXFzyLdeKZCkL0VBKwzd7XZbRJ9ytvnVgqNUaEAbJHk738jUzAHvokFPVGkfXy4KGdgCaxyUMB36D/498Wqv5Vo+iudEgtFfefhd+T1/SXKrjM/Bj3iU2e4RRxA9940=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eauSVewi; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709280478; x=1740816478;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/cVxTPK8YMoBH+k7owpPAvLO8OBKEisXNbpy2Gi5tXs=;
  b=eauSVewi23opmyVnh7gJL1Jq27r6WB7PpKnu+2xGJduAfTYjM82P7jgo
   IGfF1/Uy8lOTUb46dMNiq5ELOT5d3dWMcqLrMBtWbpPuuhEnAg4Udnas3
   nGvRdhNiD7xfj9phHRgFdQLweDHPCiNAn0LW78AQtR6ezrjKLQAeeuH/z
   3a3mZxsfuRc+C+9feWKELdJR97MUgNt3BuHTHilu8MT/HY0tFxmwrMmRq
   G30mcgkExt8NI3E5q8YjhjfrphfbDlbtEW1F5xCC9meP9JEZbcQi+C69e
   am8y9zRB0lUmTg73SdMvQ63ktydxdq2E31DyPtjQnZfugVsBZ1fyWrP3V
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="15240430"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="15240430"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 00:07:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="8187527"
Received: from unknown (HELO ply01-vm-store.amr.corp.intel.com) ([10.238.153.201])
  by orviesa009.jf.intel.com with ESMTP; 01 Mar 2024 00:07:52 -0800
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
To: baolu.lu@linux.intel.com,
	bhelgaas@google.com,
	robin.murphy@arm.com,
	jgg@ziepe.ca
Cc: kevin.tian@intel.com,
	dwmw2@infradead.org,
	will@kernel.org,
	lukas@wunner.de,
	yi.l.liu@intel.com,
	dan.carpenter@linaro.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ethan Zhao <haifeng.zhao@linux.intel.com>
Subject: [PATCH v14 3/3] iommu/vt-d: improve ITE fault handling if target device isn't present
Date: Fri,  1 Mar 2024 03:07:27 -0500
Message-Id: <20240301080727.3529832-4-haifeng.zhao@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240301080727.3529832-1-haifeng.zhao@linux.intel.com>
References: <20240301080727.3529832-1-haifeng.zhao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 drivers/iommu/intel/dmar.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index d14797aabb7a..fa1ac111a6e2 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1273,6 +1273,8 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 {
 	u32 fault;
 	int head, tail;
+	u64 iqe_err, ite_sid;
+	struct device *dev = NULL;
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
+				!pci_device_is_present(to_pci_dev(dev)))
+				return -ETIMEDOUT;
+		}
 		if (qi->desc_status[wait_index] == QI_ABORT)
 			return -EAGAIN;
 	}
-- 
2.31.1


