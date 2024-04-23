Return-Path: <linux-kernel+bounces-155867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 145A78AF834
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF81E282FFC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D20914430C;
	Tue, 23 Apr 2024 20:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S/BfbSfS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3730143867;
	Tue, 23 Apr 2024 20:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713905188; cv=none; b=uYBhbniav4NEY/fIuoqg33UragwdjdKRJ7WJwO4QhE4hJO4NenwvRqjbDhjeJOj7rC27rdmjbhNa4m4gcFmhZGQ5WbtGktJWxRYCjswdYiHCz/CA6W3OGoiEOQv3e45MuDGg2bbrKQaZrR6MVZEn5E2Zo5eB8m+eHU6xgSxGNuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713905188; c=relaxed/simple;
	bh=jfU3dzd4SPr7mq9zoRtWVOh9h4/eadyn/4Ne8nL61HA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qIfEFJD3DoTyqYJuOfr/km+QdeYEtRP3nnLqqilwTKKLQfs/Mk54EONdZPUcSeu+0Z/1z0dxETKaUajEoEcLsdtIm8fQRQvLlTghIbTp80Kg8ml0D5jLfzcSJlyBYtq/xCqRjhYaVlnB6TvuCc53a7m8MuX+v5gKUcxFlzcxHVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S/BfbSfS; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713905187; x=1745441187;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jfU3dzd4SPr7mq9zoRtWVOh9h4/eadyn/4Ne8nL61HA=;
  b=S/BfbSfS2jG4+p4LpI6FL7RE/ZwAHto3M9NNquuqLYpg7ifG49D5OY7c
   H2ej+9SOE7bS79g3ZHipb18xRgtmksDfAmRV/YJ7sh/kJZnNX74w5cIo6
   F0leWAqZUf1fnNPMx1X7FzsnHwr3IfdtKOE53UmSfZNl7mf0QP8KsaNRU
   7oqMq9pqCYDN+HHn9cETm99e/F7+JzySbFBCIjt+cPXDLVsqdnh3mPhuj
   55iLywYIPjAVqXPDmsjgNeuAIlGsh6jcj+XVYmtuH0lOFIiqwC5roRIAT
   /7nJbco0TDfXzIxsVZ6VQ8S5R6Z9Cw1eMWB3wcIqxZviBWfETE2hDPyL7
   A==;
X-CSE-ConnectionGUID: MAw0CquPRcmgJQR2x3nLGA==
X-CSE-MsgGUID: 1L2MUnBVQomUkIH+SIYNNg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="34912325"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="34912325"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 13:46:24 -0700
X-CSE-ConnectionGUID: U3ROb7qxQBaH/V1PeusWMQ==
X-CSE-MsgGUID: wl6PVotwSGSYeKS/6N3EYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24533086"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmviesa010.fm.intel.com with ESMTP; 23 Apr 2024 13:46:24 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 05/10] platform/x86: ISST: Use local variable for auxdev->dev
Date: Tue, 23 Apr 2024 13:46:14 -0700
Message-Id: <20240423204619.3946901-6-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240423204619.3946901-1-srinivas.pandruvada@linux.intel.com>
References: <20240423204619.3946901-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Define a local variable for &auxdev->dev and use to shorten length of
lines. No functional change is done.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 .../intel/speed_select_if/isst_tpmi_core.c    | 27 ++++++++++---------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index 1d918000d72b..4e09a5611aca 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -313,12 +313,11 @@ static int sst_add_perf_profiles(struct auxiliary_device *auxdev,
 				 struct tpmi_per_power_domain_info *pd_info,
 				 int levels)
 {
+	struct device *dev = &auxdev->dev;
 	u64 perf_level_offsets;
 	int i;
 
-	pd_info->perf_levels = devm_kcalloc(&auxdev->dev, levels,
-					    sizeof(struct perf_level),
-					    GFP_KERNEL);
+	pd_info->perf_levels = devm_kcalloc(dev, levels, sizeof(struct perf_level), GFP_KERNEL);
 	if (!pd_info->perf_levels)
 		return 0;
 
@@ -349,6 +348,7 @@ static int sst_add_perf_profiles(struct auxiliary_device *auxdev,
 
 static int sst_main(struct auxiliary_device *auxdev, struct tpmi_per_power_domain_info *pd_info)
 {
+	struct device *dev = &auxdev->dev;
 	int i, mask, levels;
 
 	*((u64 *)&pd_info->sst_header) = readq(pd_info->sst_base);
@@ -359,13 +359,13 @@ static int sst_main(struct auxiliary_device *auxdev, struct tpmi_per_power_domai
 		return -ENODEV;
 
 	if (TPMI_MAJOR_VERSION(pd_info->sst_header.interface_version) != ISST_MAJOR_VERSION) {
-		dev_err(&auxdev->dev, "SST: Unsupported major version:%lx\n",
+		dev_err(dev, "SST: Unsupported major version:%lx\n",
 			TPMI_MAJOR_VERSION(pd_info->sst_header.interface_version));
 		return -ENODEV;
 	}
 
 	if (TPMI_MINOR_VERSION(pd_info->sst_header.interface_version) != ISST_MINOR_VERSION)
-		dev_info(&auxdev->dev, "SST: Ignore: Unsupported minor version:%lx\n",
+		dev_info(dev, "SST: Ignore: Unsupported minor version:%lx\n",
 			 TPMI_MINOR_VERSION(pd_info->sst_header.interface_version));
 
 	/* Read SST CP Header */
@@ -1273,28 +1273,29 @@ int tpmi_sst_dev_add(struct auxiliary_device *auxdev)
 {
 	bool read_blocked = 0, write_blocked = 0;
 	struct intel_tpmi_plat_info *plat_info;
+	struct device *dev = &auxdev->dev;
 	struct tpmi_sst_struct *tpmi_sst;
 	int i, ret, pkg = 0, inst = 0;
 	int num_resources;
 
 	ret = tpmi_get_feature_status(auxdev, TPMI_ID_SST, &read_blocked, &write_blocked);
 	if (ret)
-		dev_info(&auxdev->dev, "Can't read feature status: ignoring read/write blocked status\n");
+		dev_info(dev, "Can't read feature status: ignoring read/write blocked status\n");
 
 	if (read_blocked) {
-		dev_info(&auxdev->dev, "Firmware has blocked reads, exiting\n");
+		dev_info(dev, "Firmware has blocked reads, exiting\n");
 		return -ENODEV;
 	}
 
 	plat_info = tpmi_get_platform_data(auxdev);
 	if (!plat_info) {
-		dev_err(&auxdev->dev, "No platform info\n");
+		dev_err(dev, "No platform info\n");
 		return -EINVAL;
 	}
 
 	pkg = plat_info->package_id;
 	if (pkg >= topology_max_packages()) {
-		dev_err(&auxdev->dev, "Invalid package id :%x\n", pkg);
+		dev_err(dev, "Invalid package id :%x\n", pkg);
 		return -EINVAL;
 	}
 
@@ -1306,11 +1307,11 @@ int tpmi_sst_dev_add(struct auxiliary_device *auxdev)
 	if (!num_resources)
 		return -EINVAL;
 
-	tpmi_sst = devm_kzalloc(&auxdev->dev, sizeof(*tpmi_sst), GFP_KERNEL);
+	tpmi_sst = devm_kzalloc(dev, sizeof(*tpmi_sst), GFP_KERNEL);
 	if (!tpmi_sst)
 		return -ENOMEM;
 
-	tpmi_sst->power_domain_info = devm_kcalloc(&auxdev->dev, num_resources,
+	tpmi_sst->power_domain_info = devm_kcalloc(dev, num_resources,
 						   sizeof(*tpmi_sst->power_domain_info),
 						   GFP_KERNEL);
 	if (!tpmi_sst->power_domain_info)
@@ -1331,13 +1332,13 @@ int tpmi_sst_dev_add(struct auxiliary_device *auxdev)
 		tpmi_sst->power_domain_info[i].power_domain_id = i;
 		tpmi_sst->power_domain_info[i].auxdev = auxdev;
 		tpmi_sst->power_domain_info[i].write_blocked = write_blocked;
-		tpmi_sst->power_domain_info[i].sst_base = devm_ioremap_resource(&auxdev->dev, res);
+		tpmi_sst->power_domain_info[i].sst_base = devm_ioremap_resource(dev, res);
 		if (IS_ERR(tpmi_sst->power_domain_info[i].sst_base))
 			return PTR_ERR(tpmi_sst->power_domain_info[i].sst_base);
 
 		ret = sst_main(auxdev, &tpmi_sst->power_domain_info[i]);
 		if (ret) {
-			devm_iounmap(&auxdev->dev, tpmi_sst->power_domain_info[i].sst_base);
+			devm_iounmap(dev, tpmi_sst->power_domain_info[i].sst_base);
 			tpmi_sst->power_domain_info[i].sst_base =  NULL;
 			continue;
 		}
-- 
2.40.1


