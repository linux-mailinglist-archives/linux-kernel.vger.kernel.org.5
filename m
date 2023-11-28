Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454127FC3CE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346546AbjK1S4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 13:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjK1S4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 13:56:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE25510E2;
        Tue, 28 Nov 2023 10:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701197797; x=1732733797;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w2WLuGYFo65Ah4GBkw4OoNcB8sscL4pJ3RZxkL2Mj+A=;
  b=ZlAz+qdBsrLmre+en5pa1D4J757H9p3OtRtq9sx+7IJFUgodlb85dGkE
   oYZK0nlcd8rwldS6Q/MwdyYGRd/2D7s7s88F+AZAu0bxO4S1iNkrsaNYW
   8GSHRC8GcbltgoQHXG+HSLiBwTBuJjtisnAsuLYbUarjYExLrQoboJKdk
   Wdbd28EyaXHyAPl0+msQaSHzMkMA7LAFuOaoZGjH9WppRMnnLa7xRTxD7
   2tGyQ/5tbVrgI+qwegzNrxAkBogbzUbpnRjS4lRuruFWsBB2iAQutrNsU
   CGfeFtct82DvPSMwGc88EB/WzN1uo1ONlalyOsPvlcOYCB/jp7DwrKoip
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="372366975"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="372366975"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 10:56:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="892165783"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="892165783"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by orsmga004.jf.intel.com with ESMTP; 28 Nov 2023 10:56:11 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 4/6] platform/x86/intel/tpmi: Move TPMI ID definitions
Date:   Tue, 28 Nov 2023 10:56:03 -0800
Message-Id: <20231128185605.3027653-5-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231128185605.3027653-1-srinivas.pandruvada@linux.intel.com>
References: <20231128185605.3027653-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
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

Move TPMI ID definitions to common include file. In this way other
feature drivers don't have to redefine.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/platform/x86/intel/tpmi.c | 13 -------------
 include/linux/intel_tpmi.h        | 13 +++++++++++++
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/intel/tpmi.c b/drivers/platform/x86/intel/tpmi.c
index 44773c210324..14575da91d2c 100644
--- a/drivers/platform/x86/intel/tpmi.c
+++ b/drivers/platform/x86/intel/tpmi.c
@@ -176,19 +176,6 @@ struct tpmi_feature_state {
 	u32 locked:1;
 } __packed;
 
-/*
- * List of supported TMPI IDs.
- * Some TMPI IDs are not used by Linux, so the numbers are not consecutive.
- */
-enum intel_tpmi_id {
-	TPMI_ID_RAPL = 0, /* Running Average Power Limit */
-	TPMI_ID_PEM = 1, /* Power and Perf excursion Monitor */
-	TPMI_ID_UNCORE = 2, /* Uncore Frequency Scaling */
-	TPMI_ID_SST = 5, /* Speed Select Technology */
-	TPMI_CONTROL_ID = 0x80, /* Special ID for getting feature status */
-	TPMI_INFO_ID = 0x81, /* Special ID for PCI BDF and Package ID information */
-};
-
 /*
  * The size from hardware is in u32 units. This size is from a trusted hardware,
  * but better to verify for pre silicon platforms. Set size to 0, when invalid.
diff --git a/include/linux/intel_tpmi.h b/include/linux/intel_tpmi.h
index a240e15ef77f..6c31768cdb83 100644
--- a/include/linux/intel_tpmi.h
+++ b/include/linux/intel_tpmi.h
@@ -12,6 +12,19 @@
 #define TPMI_MINOR_VERSION(val)	FIELD_GET(GENMASK(4, 0), val)
 #define TPMI_MAJOR_VERSION(val)	FIELD_GET(GENMASK(7, 5), val)
 
+/*
+ * List of supported TMPI IDs.
+ * Some TMPI IDs are not used by Linux, so the numbers are not consecutive.
+ */
+enum intel_tpmi_id {
+	TPMI_ID_RAPL = 0, /* Running Average Power Limit */
+	TPMI_ID_PEM = 1, /* Power and Perf excursion Monitor */
+	TPMI_ID_UNCORE = 2, /* Uncore Frequency Scaling */
+	TPMI_ID_SST = 5, /* Speed Select Technology */
+	TPMI_CONTROL_ID = 0x80, /* Special ID for getting feature status */
+	TPMI_INFO_ID = 0x81, /* Special ID for PCI BDF and Package ID information */
+};
+
 /**
  * struct intel_tpmi_plat_info - Platform information for a TPMI device instance
  * @cdie_mask:	Mask of all compute dies in the partition
-- 
2.41.0

