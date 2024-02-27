Return-Path: <linux-kernel+bounces-83881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F825869FBD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E9351F26848
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E3F51C5C;
	Tue, 27 Feb 2024 19:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h4qU3V5Q"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ED24EB43;
	Tue, 27 Feb 2024 19:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709060500; cv=none; b=eUST9RROtQ+OOuD0z6Qr5PJx7JSYZiScyW11yiAa4MqwrHewvIIS5hcZlL+zkzzAMOCdrOb1xD+c2Muc35cWLYUPlVT3e0Fk6F2F2437kJeZEJkZ+nlA/E2s7PHmp7pMVpyp6x1tS7omvEhI48SiJjAe6kthma07bAgVdHnMGnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709060500; c=relaxed/simple;
	bh=UN6pem+oLYyRIAcDV+Q1d6G66CsBA01ua732dNvWsiU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IeXAYzzwVu5F6Gs8zLW0jGNpTBogj7ppmu+GZ/o/VtGyZm93TKXei7kHakSgEN6V5L0+n+0H1ZxDWUYwF4miivlgdc3P+cynAPYO4OkHKCsi14T3fw0nKlAe2uDx+j8c4Zk7o9KTdZvo7mTM/T3rWvBITkd9YbqhDWaqMX6iNV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h4qU3V5Q; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709060498; x=1740596498;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=UN6pem+oLYyRIAcDV+Q1d6G66CsBA01ua732dNvWsiU=;
  b=h4qU3V5Q4gjliL3G2X1QhUjJcT+BjFySFDUI+8E/s0A71r07/oNsj7GI
   zLVVw0g7T8SRqHroCNj0I2eUMdtVh0rJS8+5FiWFkp3qiRO5h9x/e4aDq
   5sXVheqqs+R08DihM2D9L431EDofHLX1vWaD5/rFXfhP3wGxw1Knrw+Gv
   yfqjK62NfQyYceeQvLOa0irTuU+/07lP3iPhzlMSFDOdHSa2YHLpOiCKW
   FuGu7grT4dBFsSjMiokNINP5+ohXQ2f0usHPLtvRRdXRF/kU5kF6+6u+i
   YiPEyzqkz7VKzGrkWy1N11Tq674UKMHyBojT3CqldyKtWd0fJtJYsmu0Q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14063661"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="14063661"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 11:01:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="7120052"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 11:01:37 -0800
Received: from debox1-desk4.lan (unknown [10.251.6.149])
	by linux.intel.com (Postfix) with ESMTP id 1EDFA580DF5;
	Tue, 27 Feb 2024 11:01:37 -0800 (PST)
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	rajvi.jingar@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH V2 2/3] platform/x86/intel/pmc/lnl: Remove SSRAM support
Date: Tue, 27 Feb 2024 11:01:33 -0800
Message-Id: <20240227190134.1592072-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227190134.1592072-1-david.e.box@linux.intel.com>
References: <20240227190134.1592072-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A recent PMC firmware change in Lunar Lake caused the pmc_core driver to
fail to probe. This is due to a change in the GUID for PMC telemetry coming
from the SSRAM device. Until a final release is ready this value may
change again. In the meantime, disable the SSRAM support for Lunar Lake so
the driver can load and provide some basic functionality.

Fixes: 3748dfdae2a6 ("platform/x86/intel/pmc: Add Lunar Lake M support to intel_pmc_core driver")
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

V2 - Removed non-imperative language in changelog.

 drivers/platform/x86/intel/pmc/lnl.c | 38 +++-------------------------
 1 file changed, 4 insertions(+), 34 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
index abad17cdd3d7..068d72504683 100644
--- a/drivers/platform/x86/intel/pmc/lnl.c
+++ b/drivers/platform/x86/intel/pmc/lnl.c
@@ -13,21 +13,6 @@
 
 #include "core.h"
 
-#define SOCM_LPM_REQ_GUID	0x11594920
-
-#define PMC_DEVID_SOCM	0xa87f
-
-static const u8 LNL_LPM_REG_INDEX[] = {0, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 20};
-
-static struct pmc_info lnl_pmc_info_list[] = {
-	{
-		.guid	= SOCM_LPM_REQ_GUID,
-		.devid	= PMC_DEVID_SOCM,
-		.map	= &lnl_socm_reg_map,
-	},
-	{}
-};
-
 const struct pmc_bit_map lnl_ltr_show_map[] = {
 	{"SOUTHPORT_A",		CNP_PMC_LTR_SPA},
 	{"SOUTHPORT_B",		CNP_PMC_LTR_SPB},
@@ -490,7 +475,6 @@ const struct pmc_reg_map lnl_socm_reg_map = {
 	.lpm_sts = lnl_lpm_maps,
 	.lpm_status_offset = MTL_LPM_STATUS_OFFSET,
 	.lpm_live_status_offset = MTL_LPM_LIVE_STATUS_OFFSET,
-	.lpm_reg_index = LNL_LPM_REG_INDEX,
 };
 
 #define LNL_NPU_PCI_DEV		0x643e
@@ -517,33 +501,19 @@ static int lnl_resume(struct pmc_dev *pmcdev)
 int lnl_core_init(struct pmc_dev *pmcdev)
 {
 	int ret;
-	int func = 2;
-	bool ssram_init = true;
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];
 
 	lnl_d3_fixup();
 
 	pmcdev->suspend = cnl_suspend;
 	pmcdev->resume = lnl_resume;
-	pmcdev->regmap_list = lnl_pmc_info_list;
-	ret = pmc_core_ssram_init(pmcdev, func);
 
-	/* If regbase not assigned, set map and discover using legacy method */
-	if (ret) {
-		ssram_init = false;
-		pmc->map = &lnl_socm_reg_map;
-		ret = get_primary_reg_base(pmc);
-		if (ret)
-			return ret;
-	}
+	pmc->map = &lnl_socm_reg_map;
+	ret = get_primary_reg_base(pmc);
+	if (ret)
+		return ret;
 
 	pmc_core_get_low_power_modes(pmcdev);
 
-	if (ssram_init) {
-		ret = pmc_core_ssram_get_lpm_reqs(pmcdev);
-		if (ret)
-			return ret;
-	}
-
 	return 0;
 }
-- 
2.34.1


