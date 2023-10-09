Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDA77BEA46
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378288AbjJITGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346669AbjJITGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:06:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD36A6;
        Mon,  9 Oct 2023 12:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696878361; x=1728414361;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W6zzGblXuAW0BZTuDD5sFXKfa/7j59nBAlUOuhT8dvU=;
  b=JdVueqFxRloNKB8CBB7hxQXwVoKlibrL0xCdfkpg7tDRcINOEwUn1ayK
   D85oudzXXQHLwGVWwlcGyT4wF+kqeZAInOZ3ltpajN5F1j6N1EsFe8Df6
   GYVk4yAy/XNvnuyp+hdSftz19YHU1MU1Oc2F0O3uQpkBp/5C1wUqaUWvq
   bI7vQVhAYRUOIbMEE3kjlVjuWcGVZ9Wm/UDARJVCiP0DoUTR+3qvqPQrr
   G7SeZwb4Ww2DgrmxmfZSClxMSD4ywVL/djuo7de/QzWec/8x2LgeD5c+q
   vtDv5W7hhJ6beeDdB0MPFBhze55Xzx2JSSr9OAstO+/W0hESMzK3tvjur
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="415213768"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="415213768"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 12:06:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="823445836"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="823445836"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmsmga004.fm.intel.com with ESMTP; 09 Oct 2023 12:06:00 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 1/7] thermal: int340x: processor_thermal: Move interrupt status MMIO offset to common header
Date:   Mon,  9 Oct 2023 12:05:32 -0700
Message-Id: <20231009190538.2488792-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231009190538.2488792-1-srinivas.pandruvada@linux.intel.com>
References: <20231009190538.2488792-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move define SOC_WT_RES_INT_STATUS_OFFSET to processor_thermal_device.h.
This way it can be reused in other modules.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2:
- New patch in the series

 .../thermal/intel/int340x_thermal/processor_thermal_device.h    | 2 ++
 .../thermal/intel/int340x_thermal/processor_thermal_wt_hint.c   | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
index dd025c8c2bac..8ed6e8e94c8a 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
@@ -91,6 +91,8 @@ void proc_thermal_wt_req_remove(struct pci_dev *pdev);
 #define MBOX_DATA_BIT_AC_DC		30
 #define MBOX_DATA_BIT_VALID		31
 
+#define SOC_WT_RES_INT_STATUS_OFFSET	0x5B18
+
 int processor_thermal_send_mbox_read_cmd(struct pci_dev *pdev, u16 id, u64 *resp);
 int processor_thermal_send_mbox_write_cmd(struct pci_dev *pdev, u16 id, u32 data);
 int processor_thermal_mbox_interrupt_config(struct pci_dev *pdev, bool enable, int enable_bit,
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_hint.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_hint.c
index fabd8a363abb..c08838eb10c8 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_hint.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_hint.c
@@ -32,7 +32,6 @@
 #include <linux/pci.h>
 #include "processor_thermal_device.h"
 
-#define SOC_WT_RES_INT_STATUS_OFFSET	0x5B18
 #define SOC_WT				GENMASK_ULL(47, 40)
 
 #define SOC_WT_PREDICTION_INT_ENABLE_BIT	23
-- 
2.40.1

