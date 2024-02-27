Return-Path: <linux-kernel+bounces-82590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 872448686CC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D0451F23D8B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1071E89A;
	Tue, 27 Feb 2024 02:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HINFzjDG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902BEFBEA
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 02:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709000444; cv=none; b=XihzBrKzkMeH91Jcv3taH8Og26A1rra04sZyLUyg61s168Bx8IdyQgnRSd1bFMOU8C0yxky6DB1X7+a/NpIF0usSlCBE9/imxiZ1mKVK6y7jTYvqwtkHYQrYEjcln4SGjYQaB63EY8HFCt8pNXS3EYyXm7V/A12vuvwa4CTRz6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709000444; c=relaxed/simple;
	bh=p9nNzOoMCIFWnVV6qNejGepeajPPfvnPiqBXwo2zx2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RkPXocxIQBJh7nF0mmt9pJXLxaGFfbdzetI+7wM0pr62K3LP4IqTdsnu9ujfhyervELjtRGOBl5IcCB4Ozq4aLkgeYgAV1QzUvmsH2+sQZ+CG3BQPVEU3M3HbLX7Dti976qOiG7kIXz8QALdXgG15oubZRKokY1v/OMgjmNisps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HINFzjDG; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709000442; x=1740536442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p9nNzOoMCIFWnVV6qNejGepeajPPfvnPiqBXwo2zx2A=;
  b=HINFzjDGr2y2kPV6lLeKTDu8njXJ/kOebnMsFFx1RRpiqgxvITFgUPGv
   l5mK0vq3CsaojSFqE1rZR/sHobocK4pCBG9r1F4dosbhqipMTLLfOO0tk
   1TUTy4N9JWRRWiSgoJaITiTf4SbqrAykeEyusqO+RPlStFUtyDnIIVU3/
   navajfdrTfGYTYJRbCOM9YXH/tVK+FcR9CKO/nO4HSfcU3G1Eji0mVBYM
   ZqOkVT86tpcUSs32/VxLcmHcBpzr4i/fGC4cVSODmG+23ZpQBz/uTUhmp
   x7Fk3z18d/3yVSCBoeVdJetMN/5Fc+3mqfPAl1v/JyNhB7QZihQ4nK6UB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="6273103"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="6273103"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 18:20:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7418288"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 26 Feb 2024 18:20:40 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Erick Archer <erick.archer@gmx.com>,
	Jingqi Liu <Jingqi.liu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] iommu/vt-d: Use kcalloc() instead of kzalloc()
Date: Tue, 27 Feb 2024 10:14:35 +0800
Message-Id: <20240227021441.50434-3-baolu.lu@linux.intel.com>
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

From: Erick Archer <erick.archer@gmx.com>

This is an effort to get rid of all multiplications from allocation
functions in order to prevent integer overflows [1].

Here the multiplication is obviously safe because DMAR_LATENCY_NUM
is the number of latency types defined in the "latency_type" enum.

enum latency_type {
	DMAR_LATENCY_INV_IOTLB = 0,
	DMAR_LATENCY_INV_DEVTLB,
	DMAR_LATENCY_INV_IEC,
	DMAR_LATENCY_PRQ,
	DMAR_LATENCY_NUM
};

However, using kcalloc() is more appropriate [2] and improves
readability. This patch has no effect on runtime behavior.

Link: https://github.com/KSPP/linux/issues/162 [1]
Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
Signed-off-by: Erick Archer <erick.archer@gmx.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Link: https://lore.kernel.org/r/20240211175143.9229-1-erick.archer@gmx.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/perf.c b/drivers/iommu/intel/perf.c
index 94ee70ac38e3..adc4de6bbd88 100644
--- a/drivers/iommu/intel/perf.c
+++ b/drivers/iommu/intel/perf.c
@@ -33,7 +33,7 @@ int dmar_latency_enable(struct intel_iommu *iommu, enum latency_type type)
 
 	spin_lock_irqsave(&latency_lock, flags);
 	if (!iommu->perf_statistic) {
-		iommu->perf_statistic = kzalloc(sizeof(*lstat) * DMAR_LATENCY_NUM,
+		iommu->perf_statistic = kcalloc(DMAR_LATENCY_NUM, sizeof(*lstat),
 						GFP_ATOMIC);
 		if (!iommu->perf_statistic) {
 			ret = -ENOMEM;
-- 
2.34.1


