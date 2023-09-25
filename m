Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1827ADFAB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 21:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjIYTmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 15:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjIYTmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 15:42:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385F3107;
        Mon, 25 Sep 2023 12:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695670951; x=1727206951;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9oM54xEf8dPLMvypihERmumuD5XI/N6GjavUBV+K/xk=;
  b=ch3BmMRtU7IoVtD2QDPQ5P6XxgRfghTbpaP3oDm5HC+xax5t6SOq6hzI
   wJb4yV/fmnqpBYWl2LLn6LJDNkiBGBhNT+JFn3cRQNAvpplKkX107K7fm
   hVDNjAplmhbgYD4vqofCmMg2+ZUWYO1scgX5wME3Wwv5PWAUlmI2dVIbo
   mPQKYM/S/9jbX7E0KZcB3KJc47LX21ec28iKDLwzNwQEMMSDOALVe4a7S
   PBrJRFh8rK5TpaKQiMVyGYFuHcXvC1H2PmpMoLapY8J2FEvK05qFZm2zr
   rcvFA4wHIDQ456sB7riDq+2gg2y0vjX9N7MdcAvu34ibBed8RXDhjruuo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="445483126"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="445483126"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 12:42:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="864069660"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="864069660"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmsmga002.fm.intel.com with ESMTP; 25 Sep 2023 12:42:30 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] platform/x86/intel/tpmi: Add debugfs support for read/write blocked
Date:   Mon, 25 Sep 2023 12:42:19 -0700
Message-Id: <20230925194219.966602-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Display read and write blocked status of each TPMI feature in addition
to disabled and locked status.

This will require reading of read/write blocked state from the hardware.
Currently tpmi_read_feature_status(), doesn't provide this state.

Define TPMI feature state as defined in the TPMI spec. Modify the function
tpmi_read_feature_status() to update full feature state instead of just
disabled and locked state.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/platform/x86/intel/tpmi.c | 81 +++++++++++++++++++++----------
 1 file changed, 56 insertions(+), 25 deletions(-)

diff --git a/drivers/platform/x86/intel/tpmi.c b/drivers/platform/x86/intel/tpmi.c
index 0a95736d97e4..311abcac894a 100644
--- a/drivers/platform/x86/intel/tpmi.c
+++ b/drivers/platform/x86/intel/tpmi.c
@@ -143,6 +143,33 @@ struct tpmi_info_header {
 	u64 lock:1;
 } __packed;
 
+/**
+ * struct tpmi_feature_state - Structure to read hardware state of a feature
+ * @enabled:	Enable state of a feature, 1: enabled, 0: disabled
+ * @reserved_1:	Reserved for future use
+ * @write_blocked: Writes are blocked means all write operations are ignored
+ * @read_blocked: Reads are blocked means will read 0xFFs
+ * @pcs_select:	Interface used by out of band software, not used in OS
+ * @reserved_2:	Reserved for future use
+ * @id:		TPMI ID of the feature
+ * @reserved_3:	Reserved for future use
+ * @locked:	When set to 1, OS can't change this register.
+ *
+ * The structure is used to read hardware state of a TPMI feature. This
+ * information is used for debug and restricting operations for this feature.
+ */
+struct tpmi_feature_state {
+	u32 enabled:1;
+	u32 reserved_1:3;
+	u32 write_blocked:1;
+	u32 read_blocked:1;
+	u32 pcs_select:1;
+	u32 reserved_2:1;
+	u32 id:8;
+	u32 reserved_3:15;
+	u32 locked:1;
+} __packed;
+
 /*
  * List of supported TMPI IDs.
  * Some TMPI IDs are not used by Linux, so the numbers are not consecutive.
@@ -202,6 +229,7 @@ EXPORT_SYMBOL_NS_GPL(tpmi_get_resource_at_index, INTEL_TPMI);
 
 #define TPMI_CONTROL_STATUS_OFFSET	0x00
 #define TPMI_COMMAND_OFFSET		0x08
+#define TMPI_CONTROL_DATA_VAL_OFFSET	0x0c
 
 /*
  * Spec is calling for max 1 seconds to get ownership at the worst
@@ -230,7 +258,6 @@ EXPORT_SYMBOL_NS_GPL(tpmi_get_resource_at_index, INTEL_TPMI);
 
 /* TPMI command data registers */
 #define TMPI_CONTROL_DATA_CMD		GENMASK_ULL(7, 0)
-#define TMPI_CONTROL_DATA_VAL		GENMASK_ULL(63, 32)
 #define TPMI_CONTROL_DATA_VAL_FEATURE	GENMASK_ULL(48, 40)
 
 /* Command to send via control interface */
@@ -240,9 +267,6 @@ EXPORT_SYMBOL_NS_GPL(tpmi_get_resource_at_index, INTEL_TPMI);
 
 #define TPMI_CMD_LEN_MASK		GENMASK_ULL(18, 16)
 
-#define TPMI_STATE_DISABLED		BIT_ULL(0)
-#define TPMI_STATE_LOCKED		BIT_ULL(31)
-
 /* Mutex to complete get feature status without interruption */
 static DEFINE_MUTEX(tpmi_dev_lock);
 
@@ -256,7 +280,7 @@ static int tpmi_wait_for_owner(struct intel_tpmi_info *tpmi_info, u8 owner)
 }
 
 static int tpmi_read_feature_status(struct intel_tpmi_info *tpmi_info, int feature_id,
-				    int *locked, int *disabled)
+				    struct tpmi_feature_state *feature_state)
 {
 	u64 control, data;
 	int ret;
@@ -306,17 +330,8 @@ static int tpmi_read_feature_status(struct intel_tpmi_info *tpmi_info, int featu
 	}
 
 	/* Response is ready */
-	data = readq(tpmi_info->tpmi_control_mem + TPMI_COMMAND_OFFSET);
-	data = FIELD_GET(TMPI_CONTROL_DATA_VAL, data);
-
-	*disabled = 0;
-	*locked = 0;
-
-	if (!(data & TPMI_STATE_DISABLED))
-		*disabled = 1;
-
-	if (data & TPMI_STATE_LOCKED)
-		*locked = 1;
+	memcpy_fromio(feature_state, tpmi_info->tpmi_control_mem + TMPI_CONTROL_DATA_VAL_OFFSET,
+		      sizeof(*feature_state));
 
 	ret = 0;
 
@@ -335,34 +350,50 @@ int tpmi_get_feature_status(struct auxiliary_device *auxdev, int feature_id,
 {
 	struct intel_vsec_device *intel_vsec_dev = dev_to_ivdev(auxdev->dev.parent);
 	struct intel_tpmi_info *tpmi_info = auxiliary_get_drvdata(&intel_vsec_dev->auxdev);
+	struct tpmi_feature_state feature_state;
+	int ret;
+
+	ret = tpmi_read_feature_status(tpmi_info, feature_id, &feature_state);
+	if (ret)
+		return ret;
 
-	return tpmi_read_feature_status(tpmi_info, feature_id, locked, disabled);
+	*locked = feature_state.locked;
+	*disabled = !feature_state.enabled;
+
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(tpmi_get_feature_status, INTEL_TPMI);
 
 static int tpmi_pfs_dbg_show(struct seq_file *s, void *unused)
 {
 	struct intel_tpmi_info *tpmi_info = s->private;
+	int locked, disabled, read_blocked, write_blocked;
+	struct tpmi_feature_state feature_state;
 	struct intel_tpmi_pm_feature *pfs;
-	int locked, disabled, ret, i;
+	int ret, i;
+
 
 	seq_printf(s, "tpmi PFS start offset 0x:%llx\n", tpmi_info->pfs_start);
-	seq_puts(s, "tpmi_id\t\tentries\t\tsize\t\tcap_offset\tattribute\tvsec_offset\tlocked\tdisabled\n");
+	seq_puts(s, "tpmi_id\t\tentries\t\tsize\t\tcap_offset\tattribute\tvsec_offset\tlocked\tdisabled\tread_blocked\twrite_blocked\n");
 	for (i = 0; i < tpmi_info->feature_count; ++i) {
 		pfs = &tpmi_info->tpmi_features[i];
-		ret = tpmi_read_feature_status(tpmi_info, pfs->pfs_header.tpmi_id, &locked,
-					       &disabled);
+		ret = tpmi_read_feature_status(tpmi_info, pfs->pfs_header.tpmi_id, &feature_state);
 		if (ret) {
 			locked = 'U';
 			disabled = 'U';
+			read_blocked = 'U';
+			write_blocked = 'U';
 		} else {
-			disabled = disabled ? 'Y' : 'N';
-			locked = locked ? 'Y' : 'N';
+			disabled = feature_state.enabled ? 'N' : 'Y';
+			locked = feature_state.locked ? 'Y' : 'N';
+			read_blocked = feature_state.read_blocked ? 'Y' : 'N';
+			write_blocked = feature_state.write_blocked ? 'Y' : 'N';
 		}
-		seq_printf(s, "0x%02x\t\t0x%02x\t\t0x%04x\t\t0x%04x\t\t0x%02x\t\t0x%08x\t%c\t%c\n",
+		seq_printf(s, "0x%02x\t\t0x%02x\t\t0x%04x\t\t0x%04x\t\t0x%02x\t\t0x%08x\t%c\t%c\t\t%c\t\t%c\n",
 			   pfs->pfs_header.tpmi_id, pfs->pfs_header.num_entries,
 			   pfs->pfs_header.entry_size, pfs->pfs_header.cap_offset,
-			   pfs->pfs_header.attribute, pfs->vsec_offset, locked, disabled);
+			   pfs->pfs_header.attribute, pfs->vsec_offset, locked, disabled,
+			   read_blocked, write_blocked);
 	}
 
 	return 0;
-- 
2.41.0

