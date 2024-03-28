Return-Path: <linux-kernel+bounces-123829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EC2890E93
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D994B2211D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3661369AA;
	Thu, 28 Mar 2024 23:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JuFeTuoZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5053645946;
	Thu, 28 Mar 2024 23:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711668985; cv=none; b=TmWDTBJOX5IxrDbVaKp8jKZ+nduJuaBkbkNRT1z1DnKHX4KzgsFAQ4G/U3DQjnx3WYzKnoJWq6v84mxk03dms4z9bm4CfPVkXZc68gTcZQzUbfikeBOOHi7+ZkQZ9u0f3xVu0D7mI8L1/OLPV/WPb7l7URzlMwGmiAng+ksmhm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711668985; c=relaxed/simple;
	bh=NnMJNMeGqiueLLDh7TDKU7YX0ZhibM0QI0SnK7T9+jw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qvmUcJ2LXUhvIg8udbigOWKtRwdU5/LzR9ONv3zzzLm013m6t9znquZ1kjFXw8c4dVd/fMOqQGSD6Lnk37q+tm9BV/y/5e5NtxR/kRd1lQpVGAvqrVHT4akq8Hx6wJYSZKhb25AGYbn5EiYq1nWlsCQ+QqjAkRNCEcdCkSJJ3f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JuFeTuoZ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711668983; x=1743204983;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NnMJNMeGqiueLLDh7TDKU7YX0ZhibM0QI0SnK7T9+jw=;
  b=JuFeTuoZxaOLNGyl7W4dAwxUvfaaPERdBJL7zNAAdp0aGFTKMSC/g5B/
   NguCOi/5lwHhzVtXUBPIvgBtmgSi4KFWxUbNHTcwwv1rV3wFjJQqXX1A1
   TP3x9tpjrbb/9e6LzXbWQzecqoXOWOGJ2o5twmsY/m/Pi0OAqCvqtep1Z
   U7abDKYMyd6LyZpSuy/Xq44eadr6cCWS8HBIraCD+ALwpKVp9imahh7LD
   foht+bUu+r5QGo/1tX+EjBYFCzq5c8bwKztIp7T09rmXRgHHycvX6S8qE
   n0oer4drRTWOpC9x0/JfNVH1XU68EnRSNPM6h22V7Rw+g1gEPnxU/Z4h2
   g==;
X-CSE-ConnectionGUID: oFCqViAWQCqjQLV5jhUhWw==
X-CSE-MsgGUID: JeYVmvlRSGCOTR18iichXA==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="17407991"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="17407991"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 16:36:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="21457516"
Received: from sj-4150-psse-sw-opae-dev3.sj.intel.com ([10.233.115.74])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 16:36:23 -0700
From: Peter Colberg <peter.colberg@intel.com>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Lee Jones <lee@kernel.org>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Russ Weight <russell.h.weight@intel.com>,
	Peter Colberg <peter.colberg@intel.com>
Subject: [PATCH] mfd: intel-m10-bmc: Change staging size to a variable
Date: Thu, 28 Mar 2024 19:35:59 -0400
Message-ID: <20240328233559.6949-1-peter.colberg@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

The size of the staging area in FLASH for FPGA updates is dependent on the
size of the FPGA. Currently, the staging size is defined as a constant.
Larger FPGAs are coming soon and it will soon be necessary to support
different sizes for the staging area. Add a new staging_size member to the
csr_map structure to support a variable staging size.

The secure update driver does a sanity-check of the image size in
comparison to the size of the staging area in FLASH. Change the
staging size reference to a variable instead of a constant in order
to more readily support future, larger FPGAs.

Co-developed-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Peter Colberg <peter.colberg@intel.com>
---
 drivers/fpga/intel-m10-bmc-sec-update.c | 3 ++-
 drivers/mfd/intel-m10-bmc-pmci.c        | 1 +
 drivers/mfd/intel-m10-bmc-spi.c         | 1 +
 include/linux/mfd/intel-m10-bmc.h       | 1 +
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
index 89851b133709..7ac9f9f5af12 100644
--- a/drivers/fpga/intel-m10-bmc-sec-update.c
+++ b/drivers/fpga/intel-m10-bmc-sec-update.c
@@ -529,11 +529,12 @@ static enum fw_upload_err m10bmc_sec_prepare(struct fw_upload *fwl,
 					     const u8 *data, u32 size)
 {
 	struct m10bmc_sec *sec = fwl->dd_handle;
+	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
 	u32 ret;
 
 	sec->cancel_request = false;
 
-	if (!size || size > M10BMC_STAGING_SIZE)
+	if (!size || size > csr_map->staging_size)
 		return FW_UPLOAD_ERR_INVALID_SIZE;
 
 	if (sec->m10bmc->flash_bulk_ops)
diff --git a/drivers/mfd/intel-m10-bmc-pmci.c b/drivers/mfd/intel-m10-bmc-pmci.c
index 0392ef8b57d8..698c5933938b 100644
--- a/drivers/mfd/intel-m10-bmc-pmci.c
+++ b/drivers/mfd/intel-m10-bmc-pmci.c
@@ -370,6 +370,7 @@ static const struct m10bmc_csr_map m10bmc_n6000_csr_map = {
 	.pr_reh_addr = M10BMC_N6000_PR_REH_ADDR,
 	.pr_magic = M10BMC_N6000_PR_PROG_MAGIC,
 	.rsu_update_counter = M10BMC_N6000_STAGING_FLASH_COUNT,
+	.staging_size = M10BMC_STAGING_SIZE,
 };
 
 static const struct intel_m10bmc_platform_info m10bmc_pmci_n6000 = {
diff --git a/drivers/mfd/intel-m10-bmc-spi.c b/drivers/mfd/intel-m10-bmc-spi.c
index cbeb7de9e041..d64d28199df6 100644
--- a/drivers/mfd/intel-m10-bmc-spi.c
+++ b/drivers/mfd/intel-m10-bmc-spi.c
@@ -109,6 +109,7 @@ static const struct m10bmc_csr_map m10bmc_n3000_csr_map = {
 	.pr_reh_addr = M10BMC_N3000_PR_REH_ADDR,
 	.pr_magic = M10BMC_N3000_PR_PROG_MAGIC,
 	.rsu_update_counter = M10BMC_N3000_STAGING_FLASH_COUNT,
+	.staging_size = M10BMC_STAGING_SIZE,
 };
 
 static struct mfd_cell m10bmc_d5005_subdevs[] = {
diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
index ee66c9751003..988f1cd90032 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -205,6 +205,7 @@ struct m10bmc_csr_map {
 	unsigned int pr_reh_addr;
 	unsigned int pr_magic;
 	unsigned int rsu_update_counter;
+	unsigned int staging_size;
 };
 
 /**
-- 
2.44.0


