Return-Path: <linux-kernel+bounces-4673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C760681807C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB0EC1C22D21
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727F7F51C;
	Tue, 19 Dec 2023 04:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FZUzpkRw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6952779F6;
	Tue, 19 Dec 2023 04:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702959756; x=1734495756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HcJNEX6TY0JDIkG3oUHhh/95hAwtSa+S5zZq/pwDtr8=;
  b=FZUzpkRwwnalxbG5bsfu82ctPBSTNVC53remWlBE5B8E0/SRXF5Qi7UB
   2pkdayOuMYmJBAeG+21KEhsJGLGwjkJt+22p6eqibcA++e0mTj1m5CfdK
   IGrS2eABGJvb14TWMbtXmOUNmTGqChR1Ii/7/bgyy4Y2yb8jpm+YozdCX
   QPd4Ealq/AZE4ZOQu2aipyjp7nl2Gjcfn7kAhsZukm1yfUiXULho5GUGb
   2iZRCweXVRuFsVTrtRydH0kxCjVwS12ZlHFc2PDDMutZQC17xfszgYLIW
   vZDawsHf4nTYhU0FcYL1OI2DwQ4yP7ely2yoP0A0DtL+kc/wmr9XpjrzV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="2455990"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="2455990"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 20:22:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="919503119"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="919503119"
Received: from mnichels-mobl1.amr.corp.intel.com (HELO rjingar-desk5.intel.com) ([10.212.29.225])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 20:22:31 -0800
From: rjingar <rajvi.jingar@linux.intel.com>
To: irenic.rajneesh@gmail.com,
	david.e.box@intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rajvi.jingar@linux.intel.com
Subject: [PATCH 6/8] platform/x86/intel/pmc: Add ssram_init flag in PMC discovery in Meteor Lake
Date: Mon, 18 Dec 2023 20:22:14 -0800
Message-Id: <20231219042216.2592029-6-rajvi.jingar@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219042216.2592029-1-rajvi.jingar@linux.intel.com>
References: <20231219042216.2592029-1-rajvi.jingar@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rajvi Jingar <rajvi.jingar@linux.intel.com>

If PMC discovery using pmc_core_ssram_init() was unsuccessful for the
Meteor Lake platform, the legacy enumeration method is used. In this
case pci device struct for the PMC SSRAM is not available
and pmc_core_ssram_get_lpm_reqs() will not work. Add ssram_init flag to
indicate if the PMC SSRAM initialization was successful or not. Call
pmc_core_ssram_get_lpm_reqs() only if the ssram_init flag is set to true.

Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/mtl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index d2470f800298..e75431325dda 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -994,6 +994,7 @@ int mtl_core_init(struct pmc_dev *pmcdev)
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];
 	int ret;
 	int func = 2;
+	bool ssram_init = true;
 
 	mtl_d3_fixup();
 
@@ -1006,6 +1007,7 @@ int mtl_core_init(struct pmc_dev *pmcdev)
 	 */
 	ret = pmc_core_ssram_init(pmcdev, func);
 	if (ret) {
+		ssram_init = false;
 		dev_warn(&pmcdev->pdev->dev,
 			 "ssram init failed, %d, using legacy init\n", ret);
 		pmc->map = &mtl_socm_reg_map;
@@ -1023,5 +1025,8 @@ int mtl_core_init(struct pmc_dev *pmcdev)
 	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
 	pmc_core_send_ltr_ignore(pmcdev, 3);
 
-	return pmc_core_ssram_get_lpm_reqs(pmcdev);
+	if (ssram_init)
+		return pmc_core_ssram_get_lpm_reqs(pmcdev);
+
+	return 0;
 }
-- 
2.34.1


