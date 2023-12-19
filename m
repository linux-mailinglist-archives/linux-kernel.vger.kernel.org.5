Return-Path: <linux-kernel+bounces-4668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A40818073
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24BB81C22D24
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E137479;
	Tue, 19 Dec 2023 04:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fBhPUg42"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E105388;
	Tue, 19 Dec 2023 04:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702959753; x=1734495753;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1LZxjxPHrj5Hy4pXU6f/fg8syl4gP5AqPpkWahW5tYs=;
  b=fBhPUg42o+BSGmFmBwn0UaTkBj102S/iAbED4+FvtkqK49moOayFgcvA
   UdjQ40PX5Aw68GdY9Fl8DIP00nvgB9Vq3yUTzeEQ165syz72GicMGRbSe
   uCgWjWU3/3rUTcSgsdc8SwuCyoRgIhOzk3Wjs4YD5ZYTL3WfvRSX7YIF5
   gPhumDuwp41bCF+EgKuh0+qe20aSqXnruk7BgqUwAUGE2Ah+wJ09zm9tr
   ntx7ZWVIJ0LvSFXrm2+lk5N4Wmuy0WhpqzCJCU6W2ylniN3T20ePZs5ZC
   luG8Y4pxVmu7LbslE4Gifwo8rMqrZp97Q7g7T25tUrTEV6tXBoCGAm0vM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="2455974"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="2455974"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 20:22:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="919503099"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="919503099"
Received: from mnichels-mobl1.amr.corp.intel.com (HELO rjingar-desk5.intel.com) ([10.212.29.225])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 20:22:30 -0800
From: rjingar <rajvi.jingar@linux.intel.com>
To: irenic.rajneesh@gmail.com,
	david.e.box@intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rajvi.jingar@linux.intel.com,
	Michael Bottini <michael.a.bottini@linux.intel.com>,
	"David E . Box" <david.e.box@linux.intel.com>
Subject: [PATCH 2/8] platform/x86/intel/pmc: Add PSON residency counter
Date: Mon, 18 Dec 2023 20:22:10 -0800
Message-Id: <20231219042216.2592029-2-rajvi.jingar@linux.intel.com>
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

Tiger Lake platform onwards, devices have the capability to track the
duration of time that their Power Supply Units (PSUs) are turned off
during S0ix. This patch adds a debugfs file `pson_residency_usec` to
provide access to this counter.

Signed-off-by: Michael Bottini <michael.a.bottini@linux.intel.com>
Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 37 +++++++++++++++++++++++++++
 drivers/platform/x86/intel/pmc/core.h |  2 ++
 2 files changed, 39 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 983e3a8f4910..91e5e500eb41 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -208,6 +208,20 @@ static int pmc_core_dev_state_get(void *data, u64 *val)
 
 DEFINE_DEBUGFS_ATTRIBUTE(pmc_core_dev_state, pmc_core_dev_state_get, NULL, "%llu\n");
 
+static int pmc_core_pson_residency_get(void *data, u64 *val)
+{
+	struct pmc *pmc = data;
+	const struct pmc_reg_map *map = pmc->map;
+	u32 value;
+
+	value = pmc_core_reg_read(pmc, map->pson_residency_offset);
+	*val = (u64)value * map->pson_residency_counter_step;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(pmc_core_pson_residency, pmc_core_pson_residency_get, NULL, "%llu\n");
+
 static int pmc_core_check_read_lock_bit(struct pmc *pmc)
 {
 	u32 value;
@@ -1092,6 +1106,24 @@ int get_primary_reg_base(struct pmc *pmc)
 	return 0;
 }
 
+static bool pmc_core_is_pson_residency_enabled(struct pmc_dev *pmcdev)
+{
+	struct platform_device *pdev = pmcdev->pdev;
+	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
+	u8 val;
+
+	if (!adev)
+		return false;
+
+	if (fwnode_property_read_u8(acpi_fwnode_handle(adev),
+				    "intel-cec-pson-switching-enabled-in-s0",
+				    &val))
+		return false;
+
+	return val == 1;
+}
+
+
 static void pmc_core_dbgfs_unregister(struct pmc_dev *pmcdev)
 {
 	debugfs_remove_recursive(pmcdev->dbgfs_dir);
@@ -1162,6 +1194,11 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
 				    &pmc_core_substate_req_regs_fops);
 	}
 
+	if (primary_pmc->map->pson_residency_offset && pmc_core_is_pson_residency_enabled(pmcdev)) {
+		debugfs_create_file("pson_residency_usec", 0444,
+				    pmcdev->dbgfs_dir, primary_pmc, &pmc_core_pson_residency);
+	}
+
 	if (pmcdev->has_die_c6) {
 		debugfs_create_file("die_c6_us_show", 0444,
 				    pmcdev->dbgfs_dir, pmcdev,
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 6d7673145f90..91cb34a6505c 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -323,6 +323,8 @@ struct pmc_reg_map {
 	const u32 lpm_live_status_offset;
 	const u32 etr3_offset;
 	const u8  *lpm_reg_index;
+	const u32 pson_residency_offset;
+	const u32 pson_residency_counter_step;
 };
 
 /**
-- 
2.34.1


