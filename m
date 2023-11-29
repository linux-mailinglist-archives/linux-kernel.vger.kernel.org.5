Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF957FE30B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343814AbjK2WWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343573AbjK2WVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:21:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206BE10E6;
        Wed, 29 Nov 2023 14:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701296506; x=1732832506;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=cUaNFCRzY0WgtBRcu6J9Bq4TnaUOe6SPpfBzkDLbR18=;
  b=C7ij0lydHDRv9j4Pw27SGw5WYeKnR7rDOGKhKxYRPkQ8gcXMxLXgXwMp
   DpCd5GuKPZfm/+LxJfnuWA5nX1YZtjkeDFuc1O310mRss14qMCB+h2yb+
   vq3edVdF4kyk3RMGk07GdDU/CfhqL5dmBeRaUWZprfsf+MkDwfm0duqkL
   fLZcoshmCmBdhzzb8hORBkcocnCr7F8+eDvFlYVUqoT80xKCgfWrAe47O
   De1aIbikmnCucXtjOuG4HyvlqBviD6pMQCQ8JiSY+rNo09ZDEmwNlrcWa
   MnrvYV/YZVU5X0DFhZSK6U5R1nuPgafllVW4ZyM+6ca65WvFpH1gxNdIT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="11937012"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="11937012"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 14:21:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="798070442"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="798070442"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 14:21:35 -0800
Received: from debox1-desk4.lan (unknown [10.209.108.167])
        by linux.intel.com (Postfix) with ESMTP id C3AD3580ABB;
        Wed, 29 Nov 2023 14:21:34 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Subject: [PATCH V6 17/20] platform/x86/intel/pmc: Retrieve LPM information using Intel PMT
Date:   Wed, 29 Nov 2023 14:21:29 -0800
Message-Id: <20231129222132.2331261-18-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129222132.2331261-1-david.e.box@linux.intel.com>
References: <20231129222132.2331261-1-david.e.box@linux.intel.com>
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

From: Xi Pardee <xi.pardee@intel.com>

On supported platforms, the low power mode (LPM) requirements for entering
each idle substate are described in Platform Monitoring Technology (PMT)
telemetry entries. Provide a function for platform code to attempt to find
and read the requirements from the telemetry entries.

Signed-off-by: Xi Pardee <xi.pardee@intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
V6 - no change

V5 - no change

V4 - no change

V3 - no change

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
index 9ca720f9cbb2..3501c7bd6b33 100644
--- a/drivers/platform/x86/intel/pmc/core_ssram.c
+++ b/drivers/platform/x86/intel/pmc/core_ssram.c
@@ -24,8 +24,142 @@
 #define SSRAM_IOE_OFFSET	0x68
 #define SSRAM_DEVID_OFFSET	0x70
 
+/* PCH query */
+#define LPM_HEADER_OFFSET	1
+#define LPM_REG_COUNT		28
+#define LPM_MODE_OFFSET		1
+
 DEFINE_FREE(pmc_core_iounmap, void __iomem *, iounmap(_T));
 
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
@@ -189,3 +323,4 @@ int pmc_core_ssram_init(struct pmc_dev *pmcdev)
 	return ret;
 }
 MODULE_IMPORT_NS(INTEL_VSEC);
+MODULE_IMPORT_NS(INTEL_PMT_TELEMETRY);
-- 
2.34.1

