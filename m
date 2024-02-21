Return-Path: <linux-kernel+bounces-75505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E300885E9B2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 978A61F246E4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B569D1292EA;
	Wed, 21 Feb 2024 21:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HJ5ko6aI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769421272B6;
	Wed, 21 Feb 2024 21:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708549928; cv=none; b=RVlwXj3paf7EnRzNDUMUXUywhQztXeC3ewFULIxXyXUv1eK15BDyVjLc0f2IYD9ufo44zj3Ch/EVd+s1kE9YBWPtFnYnj6Gw6KNuzvNgMjOogppn5EBLMZOX/QyUtpz2vWT4lBWJkcqe1xPW7GiRWGf3ncegCJHCjEHZXUcPbuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708549928; c=relaxed/simple;
	bh=ZisVPYMGWqQkxkgSAqnP3vYo3/NAqEjcSBmQQo5muuo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J1aDNSr1OX5ZunyqlG95mlMGO0eEwPM9fSbzBzZXqBmQ43pyVS+mgAIAzkiFNiycH2UV08a7uilo8vdQW6N4Vt1iwEdCQXRc1pNVIHeACQgTlmebarH8THITNu3goTqxkbX7mSKYbdwFts19RssrVCMPi55NcBKQwGFRv1fs9iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HJ5ko6aI; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708549927; x=1740085927;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=ZisVPYMGWqQkxkgSAqnP3vYo3/NAqEjcSBmQQo5muuo=;
  b=HJ5ko6aI2Xa5waK6uxc0RBPNsRYSpafbb8BnKYT767POLhj31P+s69ok
   sNwPjIUJvPLHrioVIKkE4CjXKk5GBvL0d9gZJVNpsGJQgM2DxKDlyDbY/
   Eh1n66Myy00vXyhtnuoQy+JYZS4yU/EwpYRCPVDIpkMWZcf62YpU5k0uk
   IVS0kbWV0/ni5pTiEZ2GspRHgPLNfg2Bt3fqf4AbyYVLnDHc4eWbjhSvT
   l6TysxYUFeVu7Gf20ZKbpfYXsLcCVL+QCIZHVQXKEQJ9eplDkFqWBD28F
   bf3HlfC7xE3jytHepMDIKnEY13+AMmrEhMOvMx2wccsmvSV0YrSB8KYzW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="13865876"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="13865876"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 13:12:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="5214082"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 13:12:04 -0800
Received: from debox1-desk4.lan (unknown [10.209.70.184])
	by linux.intel.com (Postfix) with ESMTP id 5B887580DED;
	Wed, 21 Feb 2024 13:12:04 -0800 (PST)
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	rajvi.jingar@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH 2/3] platform/x86/intel/pmc/lnl: Remove SSRAM support
Date: Wed, 21 Feb 2024 13:12:02 -0800
Message-Id: <20240221211204.515159-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240221211204.515159-1-david.e.box@linux.intel.com>
References: <20240221211204.515159-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A recent PMC firmware change in Lunar Lake caused the pmc_core driver to
fail to probe. This is due to a change in the GUID for PMC telemetry
coming from the SSRAM device. We are told the current update may change
again before a final release so we can't upstream a fix just yet. In the
meantime, remove SSRAM support for Lunar Lake so the driver can load and
provide some basic functionality.

Fixes: 3748dfdae2a6 ("platform/x86/intel/pmc: Add Lunar Lake M support to intel_pmc_core driver")
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
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


