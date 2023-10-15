Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8517C9852
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 10:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbjJOIF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 04:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbjJOIF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 04:05:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0811DF
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 01:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697357154; x=1728893154;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dVnXzS81Xv4M7l2gKOOzWsxw0Sm1Wb2Oce1WoQnzXr0=;
  b=i33mQB4NM6vwPHdWVXpY3qoRiaH3LQdjEcAXkS8PEfotE9GRgtWHekIg
   LbTOugjMWJ0o54P1qs9gJSwNQo3A995+OyPwRg9QyPduUQd5OsnBtPsCx
   U4HwXLCzuu6sIhizUhrvYcIqG8usai/cfgtntKPFrZrtdzrcH/cCvlOIO
   rmh+/6hLvX7biFryLIn4t5zCgzQrWbAmJA9lcInnf4sSi807G7SinELsQ
   F4U8ALjw7ETBlBTRhBYd8lt1hM1TIq4eteco13sFF3Pdqle6UkLlwhFAd
   +u/j+s02+mn6vU4bQU7MTW2yhan0UIzCvofIHZP3/tHyA+CHURwae0keK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="364735538"
X-IronPort-AV: E=Sophos;i="6.03,226,1694761200"; 
   d="scan'208";a="364735538"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 01:05:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="731909137"
X-IronPort-AV: E=Sophos;i="6.03,226,1694761200"; 
   d="scan'208";a="731909137"
Received: from twinkler-lnx.jer.intel.com ([10.12.231.216])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 01:05:51 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next] mei: me: emit error only if reset was unexpected
Date:   Sun, 15 Oct 2023 11:05:40 +0300
Message-ID: <20231015080540.95922-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Lubart <vitaly.lubart@intel.com>

GSC devices perform legal firmware initiated resets due to state transition
that may appear as unexpected to the driver. Lower the log level for those
devices to debug level and save the firmware status registers.
When the device comes out of the reset it is possible to check whether the
resets was due to a firmware error or an exception
and only than produce a warning.

Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/hw-me-regs.h |  3 ++
 drivers/misc/mei/hw-me.c      | 61 +++++++++++++++++++++++++++++++++--
 drivers/misc/mei/init.c       | 27 ++++++++++++++--
 drivers/misc/mei/mei_dev.h    | 47 +++++++++++++++++++++++++++
 4 files changed, 133 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
index bdc65d50b945fc3c8f65f576..961e5d53a27a8c4221b4b33c 100644
--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -123,6 +123,9 @@
 #  define PCI_CFG_HFS_1_OPMODE_MSK 0xf0000 /* OP MODE Mask: SPS <= 4.0 */
 #  define PCI_CFG_HFS_1_OPMODE_SPS 0xf0000 /* SPS SKU : SPS <= 4.0 */
 #define PCI_CFG_HFS_2         0x48
+#  define PCI_CFG_HFS_2_PM_CMOFF_TO_CMX_ERROR 0x1000000 /* CMoff->CMx wake after an error */
+#  define PCI_CFG_HFS_2_PM_CM_RESET_ERROR     0x5000000 /* CME reset due to exception */
+#  define PCI_CFG_HFS_2_PM_EVENT_MASK         0xf000000
 #define PCI_CFG_HFS_3         0x60
 #  define PCI_CFG_HFS_3_FW_SKU_MSK   0x00000070
 #  define PCI_CFG_HFS_3_FW_SKU_IGN   0x00000000
diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
index da4ef0b51954ca27aedeb948..233b67f034998cf5b45c2ea8 100644
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -443,11 +443,22 @@ static void mei_gsc_pxp_check(struct mei_device *dev)
 	struct mei_me_hw *hw = to_me_hw(dev);
 	u32 fwsts5 = 0;
 
-	if (dev->pxp_mode == MEI_DEV_PXP_DEFAULT)
+	if (!kind_is_gsc(dev) && !kind_is_gscfi(dev))
 		return;
 
 	hw->read_fws(dev, PCI_CFG_HFS_5, &fwsts5);
 	trace_mei_pci_cfg_read(dev->dev, "PCI_CFG_HFS_5", PCI_CFG_HFS_5, fwsts5);
+
+	if ((fwsts5 & GSC_CFG_HFS_5_BOOT_TYPE_MSK) == GSC_CFG_HFS_5_BOOT_TYPE_PXP) {
+		if (dev->gsc_reset_to_pxp == MEI_DEV_RESET_TO_PXP_DEFAULT)
+			dev->gsc_reset_to_pxp = MEI_DEV_RESET_TO_PXP_PERFORMED;
+	} else {
+		dev->gsc_reset_to_pxp = MEI_DEV_RESET_TO_PXP_DEFAULT;
+	}
+
+	if (dev->pxp_mode == MEI_DEV_PXP_DEFAULT)
+		return;
+
 	if ((fwsts5 & GSC_CFG_HFS_5_BOOT_TYPE_MSK) == GSC_CFG_HFS_5_BOOT_TYPE_PXP) {
 		dev_dbg(dev->dev, "pxp mode is ready 0x%08x\n", fwsts5);
 		dev->pxp_mode = MEI_DEV_PXP_READY;
@@ -482,6 +493,43 @@ static int mei_me_hw_ready_wait(struct mei_device *dev)
 	return 0;
 }
 
+/**
+ * mei_me_check_fw_reset - check for the firmware reset error and exception conditions
+ *
+ * @dev: mei device
+ */
+static void mei_me_check_fw_reset(struct mei_device *dev)
+{
+	struct mei_fw_status fw_status;
+	char fw_sts_str[MEI_FW_STATUS_STR_SZ] = {0};
+	int ret;
+	u32 fw_pm_event = 0;
+
+	if (!dev->saved_fw_status_flag)
+		goto end;
+
+	if (dev->gsc_reset_to_pxp == MEI_DEV_RESET_TO_PXP_PERFORMED) {
+		ret = mei_fw_status(dev, &fw_status);
+		if (!ret) {
+			fw_pm_event = fw_status.status[1] & PCI_CFG_HFS_2_PM_EVENT_MASK;
+			if (fw_pm_event != PCI_CFG_HFS_2_PM_CMOFF_TO_CMX_ERROR &&
+			    fw_pm_event != PCI_CFG_HFS_2_PM_CM_RESET_ERROR)
+				goto end;
+		} else {
+			dev_err(dev->dev, "failed to read firmware status: %d\n", ret);
+		}
+	}
+
+	mei_fw_status2str(&dev->saved_fw_status, fw_sts_str, sizeof(fw_sts_str));
+	dev_warn(dev->dev, "unexpected reset: fw_pm_event = 0x%x, dev_state = %u fw status = %s\n",
+		 fw_pm_event, dev->saved_dev_state, fw_sts_str);
+
+end:
+	if (dev->gsc_reset_to_pxp == MEI_DEV_RESET_TO_PXP_PERFORMED)
+		dev->gsc_reset_to_pxp = MEI_DEV_RESET_TO_PXP_DONE;
+	dev->saved_fw_status_flag = false;
+}
+
 /**
  * mei_me_hw_start - hw start routine
  *
@@ -492,6 +540,8 @@ static int mei_me_hw_start(struct mei_device *dev)
 {
 	int ret = mei_me_hw_ready_wait(dev);
 
+	if (kind_is_gsc(dev) || kind_is_gscfi(dev))
+		mei_me_check_fw_reset(dev);
 	if (ret)
 		return ret;
 	dev_dbg(dev->dev, "hw is ready\n");
@@ -1300,8 +1350,13 @@ irqreturn_t mei_me_irq_thread_handler(int irq, void *dev_id)
 
 	/* check if ME wants a reset */
 	if (!mei_hw_is_ready(dev) && dev->dev_state != MEI_DEV_RESETTING) {
-		dev_warn(dev->dev, "FW not ready: resetting: dev_state = %d pxp = %d\n",
-			 dev->dev_state, dev->pxp_mode);
+		if (kind_is_gsc(dev) || kind_is_gscfi(dev)) {
+			dev_dbg(dev->dev, "FW not ready: resetting: dev_state = %d\n",
+				dev->dev_state);
+		} else {
+			dev_warn(dev->dev, "FW not ready: resetting: dev_state = %d\n",
+				 dev->dev_state);
+		}
 		if (dev->dev_state == MEI_DEV_POWERING_DOWN ||
 		    dev->dev_state == MEI_DEV_POWER_DOWN)
 			mei_cl_all_disconnect(dev);
diff --git a/drivers/misc/mei/init.c b/drivers/misc/mei/init.c
index c35e005b26be4fb81f7d0748..8ef2b1df8ac7693d2bf8c0c1 100644
--- a/drivers/misc/mei/init.c
+++ b/drivers/misc/mei/init.c
@@ -89,6 +89,22 @@ void mei_cancel_work(struct mei_device *dev)
 }
 EXPORT_SYMBOL_GPL(mei_cancel_work);
 
+static void mei_save_fw_status(struct mei_device *dev)
+{
+	struct mei_fw_status fw_status;
+	int ret;
+
+	ret = mei_fw_status(dev, &fw_status);
+	if (ret) {
+		dev_err(dev->dev, "failed to read firmware status: %d\n", ret);
+		return;
+	}
+
+	dev->saved_dev_state = dev->dev_state;
+	dev->saved_fw_status_flag = true;
+	memcpy(&dev->saved_fw_status, &fw_status, sizeof(fw_status));
+}
+
 /**
  * mei_reset - resets host and fw.
  *
@@ -109,8 +125,14 @@ int mei_reset(struct mei_device *dev)
 		char fw_sts_str[MEI_FW_STATUS_STR_SZ];
 
 		mei_fw_status_str(dev, fw_sts_str, MEI_FW_STATUS_STR_SZ);
-		dev_warn(dev->dev, "unexpected reset: dev_state = %s fw status = %s\n",
-			 mei_dev_state_str(state), fw_sts_str);
+		if (kind_is_gsc(dev) || kind_is_gscfi(dev)) {
+			dev_dbg(dev->dev, "unexpected reset: dev_state = %s fw status = %s\n",
+				mei_dev_state_str(state), fw_sts_str);
+			mei_save_fw_status(dev);
+		} else {
+			dev_warn(dev->dev, "unexpected reset: dev_state = %s fw status = %s\n",
+				 mei_dev_state_str(state), fw_sts_str);
+		}
 	}
 
 	mei_clear_interrupts(dev);
@@ -394,6 +416,7 @@ void mei_device_init(struct mei_device *dev,
 	dev->open_handle_count = 0;
 
 	dev->pxp_mode = MEI_DEV_PXP_DEFAULT;
+	dev->gsc_reset_to_pxp = MEI_DEV_RESET_TO_PXP_DEFAULT;
 
 	/*
 	 * Reserving the first client ID
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index fca0094a2310e4a2710883ac..37d7fb15cad74416c20ea986 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -82,6 +82,19 @@ enum mei_dev_pxp_mode {
 	MEI_DEV_PXP_READY   = 3,
 };
 
+/**
+ * enum mei_dev_reset_to_pxp - reset to PXP mode performed
+ *
+ * @MEI_DEV_RESET_TO_PXP_DEFAULT: before reset
+ * @MEI_DEV_RESET_TO_PXP_PERFORMED: reset performed
+ * @MEI_DEV_RESET_TO_PXP_DONE: reset processed
+ */
+enum mei_dev_reset_to_pxp {
+	MEI_DEV_RESET_TO_PXP_DEFAULT = 0,
+	MEI_DEV_RESET_TO_PXP_PERFORMED = 1,
+	MEI_DEV_RESET_TO_PXP_DONE = 2,
+};
+
 const char *mei_dev_state_str(int state);
 
 enum mei_file_transaction_states {
@@ -534,6 +547,11 @@ struct mei_dev_timeouts {
  *
  * @dbgfs_dir   : debugfs mei root directory
  *
+ * @saved_fw_status      : saved firmware status
+ * @saved_dev_state      : saved device state
+ * @saved_fw_status_flag : flag indicating that firmware status was saved
+ * @gsc_reset_to_pxp     : state of reset to the PXP mode
+ *
  * @ops:        : hw specific operations
  * @hw          : hw specific data
  */
@@ -630,6 +648,11 @@ struct mei_device {
 	struct dentry *dbgfs_dir;
 #endif /* CONFIG_DEBUG_FS */
 
+	struct mei_fw_status saved_fw_status;
+	enum mei_dev_state saved_dev_state;
+	bool saved_fw_status_flag;
+	enum mei_dev_reset_to_pxp gsc_reset_to_pxp;
+
 	const struct mei_hw_ops *ops;
 	char hw[] __aligned(sizeof(void *));
 };
@@ -874,5 +897,29 @@ static inline ssize_t mei_fw_status_str(struct mei_device *dev,
 	return ret;
 }
 
+/**
+ * kind_is_gsc - checks whether the device is gsc
+ *
+ * @dev: the device structure
+ *
+ * Return: whether the device is gsc
+ */
+static inline bool kind_is_gsc(struct mei_device *dev)
+{
+	/* check kind for NULL because it may be not set, like at the fist call to hw_start */
+	return dev->kind && (strcmp(dev->kind, "gsc") == 0);
+}
 
+/**
+ * kind_is_gscfi - checks whether the device is gscfi
+ *
+ * @dev: the device structure
+ *
+ * Return: whether the device is gscfi
+ */
+static inline bool kind_is_gscfi(struct mei_device *dev)
+{
+	/* check kind for NULL because it may be not set, like at the fist call to hw_start */
+	return dev->kind && (strcmp(dev->kind, "gscfi") == 0);
+}
 #endif
-- 
2.41.0

