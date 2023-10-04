Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B125D7B768A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 04:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241117AbjJDCDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 22:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241295AbjJDCC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 22:02:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51781CC0;
        Tue,  3 Oct 2023 19:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696384964; x=1727920964;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=LHsSYfNJf3gMxAStJ+kuLS48h4EgbNe50A3znIUvOBE=;
  b=H0M8Vo5pwuw6N683NEjcc3ne6D0OoGE3BUX6yJwhesjHP+pti4iI0Tqa
   CnGKJrL99z+SwFZGlYTSETHuTBxSU9zyIApDeklbz2Xh0UhiE/7KBUNeO
   +gcRjMwz6wbHnxEMwU3gbKr/3kbZZ57rAdRgS88YCTdRHa+I6n0+bv7tH
   kz27j1lx6AjFvj19doUY2YrZ6BOx2qyPv9ktvcP4QIEgBYxH3mipIX3x1
   hx0o/fwIZN1pzZO6x88c+gXq/k3++L3j4NZfKO0e62ysas8z9RIAoYtGV
   yUnmAUg5+0NAVH4LIRjiZ6xgo1YlXgNcaTi6iR2oWMsz7eHTfPOEzX2+f
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1625876"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="1625876"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 19:02:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="700926302"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="700926302"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 19:02:23 -0700
Received: from debox1-desk4.intel.com (unknown [10.209.24.172])
        by linux.intel.com (Postfix) with ESMTP id 9F0FC580CBC;
        Tue,  3 Oct 2023 19:02:23 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Subject: [PATCH V2 11/13] platform/x86/intel/pmc: Retrieve LPM information using Intel PMT
Date:   Tue,  3 Oct 2023 19:02:20 -0700
Message-Id: <20231004020222.193445-12-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004020222.193445-1-david.e.box@linux.intel.com>
References: <20231004020222.193445-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xi Pardee <xi.pardee@intel.com>

On supported platforms, the low power mode (LPM) requirements for entering
each idle substate are described in Platform Monitoring Technology (PMT)
telemetry entries. Provide a function for platform code to attempt to find
and read the requirements from the telemetry entries.

Signed-off-by: Xi Pardee <xi.pardee@intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
V2 - remove extra parens

 drivers/platform/x86/intel/pmc/core.h       |   3 +
 drivers/platform/x86/intel/pmc/core_ssram.c | 135 ++++++++++++++++++++
 2 files changed, 138 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index edaa70067e41..85b6f6ae4995 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -320,6 +320,7 @@ struct pmc_reg_map {
 	const u32 lpm_status_offset;
 	const u32 lpm_live_status_offset;
 	const u32 etr3_offset;
+	const u8  *lpm_reg_index;
 };
 
 /**
@@ -329,6 +330,7 @@ struct pmc_reg_map {
  *			specific attributes
  */
 struct pmc_info {
+	u32 guid;
 	u16 devid;
 	const struct pmc_reg_map *map;
 };
@@ -486,6 +488,7 @@ extern const struct pmc_bit_map *mtl_ioem_lpm_maps[];
 extern const struct pmc_reg_map mtl_ioem_reg_map;
 
 extern void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev);
+extern int pmc_core_ssram_get_lpm_reqs(struct pmc_dev *pmcdev);
 extern int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value);
 
 int pmc_core_resume_common(struct pmc_dev *pmcdev);
diff --git a/drivers/platform/x86/intel/pmc/core_ssram.c b/drivers/platform/x86/intel/pmc/core_ssram.c
index b2abaf106bc5..76c09f375803 100644
--- a/drivers/platform/x86/intel/pmc/core_ssram.c
+++ b/drivers/platform/x86/intel/pmc/core_ssram.c
@@ -23,6 +23,140 @@
 #define SSRAM_IOE_OFFSET	0x68
 #define SSRAM_DEVID_OFFSET	0x70
 
+/* PCH query */
+#define LPM_HEADER_OFFSET	1
+#define LPM_REG_COUNT		28
+#define LPM_MODE_OFFSET		1
+
+static u32 pmc_core_find_guid(struct pmc_info *list, const struct pmc_reg_map *map)
+{
+	for (; list->map; ++list)
+		if (list->map == map)
+			return list->guid;
+
+	return 0;
+}
+
+static int pmc_core_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc)
+{
+	struct telem_endpoint *ep;
+	const u8 *lpm_indices;
+	int num_maps, mode_offset = 0;
+	int ret, mode, i;
+	int lpm_size;
+	u32 guid;
+
+	lpm_indices = pmc->map->lpm_reg_index;
+	num_maps = pmc->map->lpm_num_maps;
+	lpm_size = LPM_MAX_NUM_MODES * num_maps;
+
+	guid = pmc_core_find_guid(pmcdev->regmap_list, pmc->map);
+	if (!guid)
+		return -ENXIO;
+
+	ep = pmt_telem_find_and_register_endpoint(pmcdev->ssram_pcidev, guid, 0);
+	if (IS_ERR(ep)) {
+		dev_dbg(&pmcdev->pdev->dev, "couldn't get telem endpoint %ld",
+			PTR_ERR(ep));
+		return -EPROBE_DEFER;
+	}
+
+	pmc->lpm_req_regs = devm_kzalloc(&pmcdev->pdev->dev,
+					 lpm_size * sizeof(u32),
+					 GFP_KERNEL);
+	if (!pmc->lpm_req_regs) {
+		ret = -ENOMEM;
+		goto unregister_ep;
+	}
+
+	/*
+	 * PMC Low Power Mode (LPM) table
+	 *
+	 * In telemetry space, the LPM table contains a 4 byte header followed
+	 * by 8 consecutive mode blocks (one for each LPM mode). Each block
+	 * has a 4 byte header followed by a set of registers that describe the
+	 * IP state requirements for the given mode. The IP mapping is platform
+	 * specific but the same for each block, making for easy analysis.
+	 * Platforms only use a subset of the space to track the requirements
+	 * for their IPs. Callers provide the requirement registers they use as
+	 * a list of indices. Each requirement register is associated with an
+	 * IP map that's maintained by the caller.
+	 *
+	 * Header
+	 * +----+----------------------------+----------------------------+
+	 * |  0 |      REVISION              |      ENABLED MODES         |
+	 * +----+--------------+-------------+-------------+--------------+
+	 *
+	 * Low Power Mode 0 Block
+	 * +----+--------------+-------------+-------------+--------------+
+	 * |  1 |     SUB ID   |     SIZE    |   MAJOR     |   MINOR      |
+	 * +----+--------------+-------------+-------------+--------------+
+	 * |  2 |           LPM0 Requirements 0                           |
+	 * +----+---------------------------------------------------------+
+	 * |    |                  ...                                    |
+	 * +----+---------------------------------------------------------+
+	 * | 29 |           LPM0 Requirements 27                          |
+	 * +----+---------------------------------------------------------+
+	 *
+	 * ...
+	 *
+	 * Low Power Mode 7 Block
+	 * +----+--------------+-------------+-------------+--------------+
+	 * |    |     SUB ID   |     SIZE    |   MAJOR     |   MINOR      |
+	 * +----+--------------+-------------+-------------+--------------+
+	 * | 60 |           LPM7 Requirements 0                           |
+	 * +----+---------------------------------------------------------+
+	 * |    |                  ...                                    |
+	 * +----+---------------------------------------------------------+
+	 * | 87 |           LPM7 Requirements 27                          |
+	 * +----+---------------------------------------------------------+
+	 *
+	 */
+	mode_offset = LPM_HEADER_OFFSET + LPM_MODE_OFFSET;
+	pmc_for_each_mode(i, mode, pmcdev) {
+		u32 *req_offset = pmc->lpm_req_regs + (mode * num_maps);
+		int m;
+
+		for (m = 0; m < num_maps; m++) {
+			u8 sample_id = lpm_indices[m] + mode_offset;
+
+			ret = pmt_telem_read32(ep, sample_id, req_offset, 1);
+			if (ret) {
+				dev_err(&pmcdev->pdev->dev,
+					"couldn't read Low Power Mode requirements: %d\n", ret);
+				devm_kfree(&pmcdev->pdev->dev, pmc->lpm_req_regs);
+				goto unregister_ep;
+			}
+			++req_offset;
+		}
+		mode_offset += LPM_REG_COUNT + LPM_MODE_OFFSET;
+	}
+
+unregister_ep:
+	pmt_telem_unregister_endpoint(ep);
+
+	return ret;
+}
+
+int pmc_core_ssram_get_lpm_reqs(struct pmc_dev *pmcdev)
+{
+	int ret, i;
+
+	if (!pmcdev->ssram_pcidev)
+		return -ENODEV;
+
+	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
+		if (!pmcdev->pmcs[i])
+			continue;
+
+		ret = pmc_core_get_lpm_req(pmcdev, pmcdev->pmcs[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static void
 pmc_add_pmt(struct pmc_dev *pmcdev, u64 ssram_base, void __iomem *ssram)
 {
@@ -234,3 +368,4 @@ int pmc_core_ssram_init(struct pmc_dev *pmcdev)
 	return ret;
 }
 MODULE_IMPORT_NS(INTEL_VSEC);
+MODULE_IMPORT_NS(INTEL_PMT_TELEMETRY);
-- 
2.34.1

