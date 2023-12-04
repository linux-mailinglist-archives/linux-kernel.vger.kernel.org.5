Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69157804186
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 23:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbjLDWRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 17:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbjLDWRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 17:17:43 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78E3CB;
        Mon,  4 Dec 2023 14:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701728269; x=1733264269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dsVx0Rv5ZtRcfupl4LgN9IaDABv2etpZtPWU/ZZQsGs=;
  b=dgHUd9IPUz+MIwfkLrPftuA/aFwdPMV2yOiidfsrztbB2uzZrzSg7ltv
   51ym7YRdvpEo2ltUc2SvmvVLhnGk9xVRB/kWdTl9ujBp7CydLEK1S5udu
   OWY4bUv6OKTo1k6uIngE7+GipwjbkViOKiy1Es5VEYncg93MF+yE7IGkP
   Ys8v4GV9c8hGB2svxRXt9gaXpr8POl/hjIWLAU1HHXTbs/UHMNkMEjTKR
   6Wl2EkhXdS6GI/+X7qHbg8MP3XSeFSUHt1iqGtM/dnJCXgiGjK/g8lotR
   G2+YJRvlV7IX4CiIBzVwIIaivkWfg8fv6oLGzdo0Clc5Tcayf+xrFFNiG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="480000884"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="480000884"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 14:17:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="764111956"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="764111956"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by orsmga007.jf.intel.com with ESMTP; 04 Dec 2023 14:17:46 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 5/5] platform/x86/intel-uncore-freq: Process read/write blocked feature status
Date:   Mon,  4 Dec 2023 14:17:40 -0800
Message-Id: <20231204221740.3645130-6-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231204221740.3645130-1-srinivas.pandruvada@linux.intel.com>
References: <20231204221740.3645130-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a feature is read blocked, don't continue to read uncore information
and register with uncore core.

When the feature is write blocked, continue to offer read interface but
block setting uncore limits.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
v3
- Rebased on top of /pdx86/platform-drivers-x86 review-hans
v2
- Change read_blocked, write_blocked to bool

 .../uncore-frequency/uncore-frequency-tpmi.c      | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
index 4fb790552c47..bd75d61ff8a6 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
@@ -66,6 +66,7 @@ struct tpmi_uncore_struct {
 	int min_ratio;
 	struct tpmi_uncore_power_domain_info *pd_info;
 	struct tpmi_uncore_cluster_info root_cluster;
+	bool write_blocked;
 };
 
 #define UNCORE_GENMASK_MIN_RATIO	GENMASK_ULL(21, 15)
@@ -157,6 +158,9 @@ static int uncore_write_control_freq(struct uncore_data *data, unsigned int inpu
 	cluster_info = container_of(data, struct tpmi_uncore_cluster_info, uncore_data);
 	uncore_root = cluster_info->uncore_root;
 
+	if (uncore_root->write_blocked)
+		return -EPERM;
+
 	/* Update each cluster in a package */
 	if (cluster_info->root_domain) {
 		struct tpmi_uncore_struct *uncore_root = cluster_info->uncore_root;
@@ -233,11 +237,21 @@ static void remove_cluster_entries(struct tpmi_uncore_struct *tpmi_uncore)
 
 static int uncore_probe(struct auxiliary_device *auxdev, const struct auxiliary_device_id *id)
 {
+	bool read_blocked = 0, write_blocked = 0;
 	struct intel_tpmi_plat_info *plat_info;
 	struct tpmi_uncore_struct *tpmi_uncore;
 	int ret, i, pkg = 0;
 	int num_resources;
 
+	ret = tpmi_get_feature_status(auxdev, TPMI_ID_UNCORE, &read_blocked, &write_blocked);
+	if (ret)
+		dev_info(&auxdev->dev, "Can't read feature status: ignoring blocked status\n");
+
+	if (read_blocked) {
+		dev_info(&auxdev->dev, "Firmware has blocked reads, exiting\n");
+		return -ENODEV;
+	}
+
 	/* Get number of power domains, which is equal to number of resources */
 	num_resources = tpmi_get_resource_count(auxdev);
 	if (!num_resources)
@@ -266,6 +280,7 @@ static int uncore_probe(struct auxiliary_device *auxdev, const struct auxiliary_
 	}
 
 	tpmi_uncore->power_domain_count = num_resources;
+	tpmi_uncore->write_blocked = write_blocked;
 
 	/* Get the package ID from the TPMI core */
 	plat_info = tpmi_get_platform_data(auxdev);
-- 
2.40.1

