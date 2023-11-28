Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAC67FBA33
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 13:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344674AbjK1MfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 07:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344178AbjK1MfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 07:35:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64321D6D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 04:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701174918; x=1732710918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=/3sAMg2V84H5Vstw+gUHNTtgnS/tko/sRA+QSibSk9w=;
  b=bVVf/jQWfwTE/cYBZG9a99mQpiatgcVPP2qroNRkI8Bjql1Zee9iQWbB
   cZhRiHy4h2wZ3aVgqy5YRMNM4g7EbhU8j+4rUPj+GDp94tt4CZ3tpK7hG
   kWdprmPL97OhX9lVgFvtoXywDMfAiqzACsJAZNNujUZ/qo3hLcyzO5oqp
   dD/41RJTums1L4dB1Rua/ZajWZDmEWB9iZNGEZK8Jo+r1tVOMTfoZyGke
   eQziqgavSCYWModcuNK+kbFxgnL8YG8o6OaBOPXilYtBjqvuCEIhmzgjO
   BX8CphST7aeI4Kt0GpBpgsYnPfKvidn7QMjNQDdQ7x/JNLWWoYPMKul8I
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="373086880"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="373086880"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 04:35:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="9935687"
Received: from shsensorbuild2.sh.intel.com ([10.239.134.197])
  by orviesa002.jf.intel.com with ESMTP; 28 Nov 2023 04:35:15 -0800
From:   Wentong Wu <wentong.wu@intel.com>
To:     gregkh@linuxfoundation.org, tomas.winkler@intel.com,
        hdegoede@redhat.com
Cc:     andriy.shevchenko@linux.intel.com, sakari.ailus@linux.intel.com,
        alexander.usyskin@intel.com, zhifeng.wang@intel.com,
        linux-kernel@vger.kernel.org, Wentong Wu <wentong.wu@intel.com>
Subject: [PATCH 2/2] mei: Add MEI hardware support for IVSC device
Date:   Tue, 28 Nov 2023 20:34:06 +0800
Message-Id: <1701174846-16316-3-git-send-email-wentong.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1701174846-16316-1-git-send-email-wentong.wu@intel.com>
References: <1701174846-16316-1-git-send-email-wentong.wu@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The protocol used for the IVSC device to communicate with HOST is MEI.
The MEI hardware interfaces for the IVSC device are implemented.

The APIs are exposed by MEI framework to mei clients, e.g. mei_csi and
mei_ace.

Signed-off-by: Wentong Wu <wentong.wu@intel.com>
Reviewed-by: Alexander Usyskin <alexander.usyskin@intel.com>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/misc/mei/Kconfig        |  13 ++
 drivers/misc/mei/Makefile       |   3 +
 drivers/misc/mei/platform-vsc.c | 442 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 458 insertions(+)
 create mode 100644 drivers/misc/mei/platform-vsc.c

diff --git a/drivers/misc/mei/Kconfig b/drivers/misc/mei/Kconfig
index 470957a..2c5312b 100644
--- a/drivers/misc/mei/Kconfig
+++ b/drivers/misc/mei/Kconfig
@@ -71,6 +71,19 @@ config INTEL_MEI_VSC_HW
 	  This driver can also be built as a module. If so, the module
 	  will be called mei-vsc-hw.
 
+config INTEL_MEI_VSC
+	tristate "Intel visual sensing controller device with ME interface"
+	select INTEL_MEI_VSC_HW
+	depends on INTEL_MEI
+	help
+	  Intel MEI over SPI driver for Intel visual sensing controller
+	  (IVSC) device embedded in IA platform. It supports camera sharing
+	  between IVSC for context sensing and IPU for typical media usage.
+	  Select this config will enable transport layer for IVSC device.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called mei-vsc.
+
 source "drivers/misc/mei/hdcp/Kconfig"
 source "drivers/misc/mei/pxp/Kconfig"
 source "drivers/misc/mei/gsc_proxy/Kconfig"
diff --git a/drivers/misc/mei/Makefile b/drivers/misc/mei/Makefile
index 3d0da19..6f9fdbf 100644
--- a/drivers/misc/mei/Makefile
+++ b/drivers/misc/mei/Makefile
@@ -35,3 +35,6 @@ obj-$(CONFIG_INTEL_MEI_GSC_PROXY) += gsc_proxy/
 obj-$(CONFIG_INTEL_MEI_VSC_HW) += mei-vsc-hw.o
 mei-vsc-hw-y := vsc-tp.o
 mei-vsc-hw-y += vsc-fw-loader.o
+
+obj-$(CONFIG_INTEL_MEI_VSC) += mei-vsc.o
+mei-vsc-y := platform-vsc.o
diff --git a/drivers/misc/mei/platform-vsc.c b/drivers/misc/mei/platform-vsc.c
new file mode 100644
index 0000000..8bd016d
--- /dev/null
+++ b/drivers/misc/mei/platform-vsc.c
@@ -0,0 +1,442 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023, Intel Corporation.
+ * Intel Visual Sensing Controller Interface Linux driver
+ */
+
+#include <linux/align.h>
+#include <linux/cache.h>
+#include <linux/cleanup.h>
+#include <linux/iopoll.h>
+#include <linux/list.h>
+#include <linux/mei.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/overflow.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/timekeeping.h>
+#include <linux/types.h>
+
+#include <asm-generic/bug.h>
+#include <asm-generic/unaligned.h>
+
+#include "mei_dev.h"
+#include "vsc-tp.h"
+
+#define VSC_MEI_MAX_MSG_SIZE		512
+
+#define MEI_VSC_POLL_DELAY_US		(50 * USEC_PER_MSEC)
+#define MEI_VSC_POLL_TIMEOUT_US		(200 * USEC_PER_MSEC)
+
+#define mei_dev_to_vsc_hw(dev)		((struct mei_vsc_hw *)((dev)->hw))
+
+struct mei_vsc_host_timestamp {
+	u64 realtime;
+	u64 boottime;
+};
+
+struct mei_vsc_hw {
+	struct vsc_tp *tp;
+
+	bool fw_ready;
+	bool host_ready;
+
+	atomic_t write_lock_cnt;
+
+	u32 rx_len;
+	u32 rx_hdr;
+
+	/* buffer for tx */
+	char tx_buf[VSC_MEI_MAX_MSG_SIZE + sizeof(struct mei_msg_hdr)] ____cacheline_aligned;
+	/* buffer for rx */
+	char rx_buf[VSC_MEI_MAX_MSG_SIZE + sizeof(struct mei_msg_hdr)] ____cacheline_aligned;
+};
+
+static int mei_vsc_read_helper(struct mei_vsc_hw *hw, u8 *buf,
+			       u32 max_len)
+{
+	struct mei_vsc_host_timestamp ts = {
+		.realtime = ktime_to_ns(ktime_get_real()),
+		.boottime = ktime_to_ns(ktime_get_boottime()),
+	};
+
+	return vsc_tp_xfer(hw->tp, VSC_TP_CMD_READ, &ts, sizeof(ts),
+			   buf, max_len);
+}
+
+static int mei_vsc_write_helper(struct mei_vsc_hw *hw, u8 *buf, u32 len)
+{
+	u8 status;
+
+	return vsc_tp_xfer(hw->tp, VSC_TP_CMD_WRITE, buf, len, &status,
+			   sizeof(status));
+}
+
+static int mei_vsc_fw_status(struct mei_device *mei_dev,
+			     struct mei_fw_status *fw_status)
+{
+	if (!fw_status)
+		return -EINVAL;
+
+	fw_status->count = 0;
+
+	return 0;
+}
+
+static inline enum mei_pg_state mei_vsc_pg_state(struct mei_device *mei_dev)
+{
+	return MEI_PG_OFF;
+}
+
+static void mei_vsc_intr_enable(struct mei_device *mei_dev)
+{
+	struct mei_vsc_hw *hw = mei_dev_to_vsc_hw(mei_dev);
+
+	vsc_tp_intr_enable(hw->tp);
+}
+
+static void mei_vsc_intr_disable(struct mei_device *mei_dev)
+{
+	struct mei_vsc_hw *hw = mei_dev_to_vsc_hw(mei_dev);
+
+	vsc_tp_intr_disable(hw->tp);
+}
+
+/* mei framework requires this ops */
+static void mei_vsc_intr_clear(struct mei_device *mei_dev)
+{
+}
+
+/* wait for pending irq handler */
+static void mei_vsc_synchronize_irq(struct mei_device *mei_dev)
+{
+	struct mei_vsc_hw *hw = mei_dev_to_vsc_hw(mei_dev);
+
+	vsc_tp_intr_synchronize(hw->tp);
+}
+
+static int mei_vsc_hw_config(struct mei_device *mei_dev)
+{
+	return 0;
+}
+
+static bool mei_vsc_host_is_ready(struct mei_device *mei_dev)
+{
+	struct mei_vsc_hw *hw = mei_dev_to_vsc_hw(mei_dev);
+
+	return hw->host_ready;
+}
+
+static bool mei_vsc_hw_is_ready(struct mei_device *mei_dev)
+{
+	struct mei_vsc_hw *hw = mei_dev_to_vsc_hw(mei_dev);
+
+	return hw->fw_ready;
+}
+
+static int mei_vsc_hw_start(struct mei_device *mei_dev)
+{
+	struct mei_vsc_hw *hw = mei_dev_to_vsc_hw(mei_dev);
+	int ret, rlen;
+	u8 buf;
+
+	hw->host_ready = true;
+
+	vsc_tp_intr_enable(hw->tp);
+
+	ret = read_poll_timeout(mei_vsc_read_helper, rlen,
+				rlen >= 0, MEI_VSC_POLL_DELAY_US,
+				MEI_VSC_POLL_TIMEOUT_US, true,
+				hw, &buf, sizeof(buf));
+	if (ret) {
+		dev_err(mei_dev->dev, "wait fw ready failed: %d\n", ret);
+		return ret;
+	}
+
+	hw->fw_ready = true;
+
+	return 0;
+}
+
+static bool mei_vsc_hbuf_is_ready(struct mei_device *mei_dev)
+{
+	struct mei_vsc_hw *hw = mei_dev_to_vsc_hw(mei_dev);
+
+	return atomic_read(&hw->write_lock_cnt) == 0;
+}
+
+static int mei_vsc_hbuf_empty_slots(struct mei_device *mei_dev)
+{
+	return VSC_MEI_MAX_MSG_SIZE / MEI_SLOT_SIZE;
+}
+
+static u32 mei_vsc_hbuf_depth(const struct mei_device *mei_dev)
+{
+	return VSC_MEI_MAX_MSG_SIZE / MEI_SLOT_SIZE;
+}
+
+static int mei_vsc_write(struct mei_device *mei_dev,
+			 const void *hdr, size_t hdr_len,
+			 const void *data, size_t data_len)
+{
+	struct mei_vsc_hw *hw = mei_dev_to_vsc_hw(mei_dev);
+	char *buf = hw->tx_buf;
+	int ret;
+
+	if (WARN_ON(!hdr || !IS_ALIGNED(hdr_len, 4)))
+		return -EINVAL;
+
+	if (!data || data_len > VSC_MEI_MAX_MSG_SIZE)
+		return -EINVAL;
+
+	atomic_inc(&hw->write_lock_cnt);
+
+	memcpy(buf, hdr, hdr_len);
+	memcpy(buf + hdr_len, data, data_len);
+
+	ret = mei_vsc_write_helper(hw, buf, hdr_len + data_len);
+
+	atomic_dec_if_positive(&hw->write_lock_cnt);
+
+	return ret < 0 ? ret : 0;
+}
+
+static inline u32 mei_vsc_read(const struct mei_device *mei_dev)
+{
+	struct mei_vsc_hw *hw = mei_dev_to_vsc_hw(mei_dev);
+	int ret;
+
+	ret = mei_vsc_read_helper(hw, hw->rx_buf, sizeof(hw->rx_buf));
+	if (ret < 0 || ret < sizeof(u32))
+		return 0;
+	hw->rx_len = ret;
+
+	hw->rx_hdr = get_unaligned_le32(hw->rx_buf);
+
+	return hw->rx_hdr;
+}
+
+static int mei_vsc_count_full_read_slots(struct mei_device *mei_dev)
+{
+	return VSC_MEI_MAX_MSG_SIZE / MEI_SLOT_SIZE;
+}
+
+static int mei_vsc_read_slots(struct mei_device *mei_dev, unsigned char *buf,
+			      unsigned long len)
+{
+	struct mei_vsc_hw *hw = mei_dev_to_vsc_hw(mei_dev);
+	struct mei_msg_hdr *hdr;
+
+	hdr = (struct mei_msg_hdr *)&hw->rx_hdr;
+	if (len != hdr->length || hdr->length + sizeof(*hdr) != hw->rx_len)
+		return -EINVAL;
+
+	memcpy(buf, hw->rx_buf + sizeof(*hdr), len);
+
+	return 0;
+}
+
+static bool mei_vsc_pg_in_transition(struct mei_device *mei_dev)
+{
+	return mei_dev->pg_event >= MEI_PG_EVENT_WAIT &&
+	       mei_dev->pg_event <= MEI_PG_EVENT_INTR_WAIT;
+}
+
+static bool mei_vsc_pg_is_enabled(struct mei_device *mei_dev)
+{
+	return false;
+}
+
+static int mei_vsc_hw_reset(struct mei_device *mei_dev, bool intr_enable)
+{
+	struct mei_vsc_hw *hw = mei_dev_to_vsc_hw(mei_dev);
+
+	vsc_tp_reset(hw->tp);
+
+	vsc_tp_intr_disable(hw->tp);
+
+	return vsc_tp_init(hw->tp, mei_dev->dev);
+}
+
+static const struct mei_hw_ops mei_vsc_hw_ops = {
+	.fw_status = mei_vsc_fw_status,
+	.pg_state = mei_vsc_pg_state,
+
+	.host_is_ready = mei_vsc_host_is_ready,
+	.hw_is_ready = mei_vsc_hw_is_ready,
+	.hw_reset = mei_vsc_hw_reset,
+	.hw_config = mei_vsc_hw_config,
+	.hw_start = mei_vsc_hw_start,
+
+	.pg_in_transition = mei_vsc_pg_in_transition,
+	.pg_is_enabled = mei_vsc_pg_is_enabled,
+
+	.intr_clear = mei_vsc_intr_clear,
+	.intr_enable = mei_vsc_intr_enable,
+	.intr_disable = mei_vsc_intr_disable,
+	.synchronize_irq = mei_vsc_synchronize_irq,
+
+	.hbuf_free_slots = mei_vsc_hbuf_empty_slots,
+	.hbuf_is_ready = mei_vsc_hbuf_is_ready,
+	.hbuf_depth = mei_vsc_hbuf_depth,
+	.write = mei_vsc_write,
+
+	.rdbuf_full_slots = mei_vsc_count_full_read_slots,
+	.read_hdr = mei_vsc_read,
+	.read = mei_vsc_read_slots,
+};
+
+static void mei_vsc_event_cb(void *context)
+{
+	struct mei_device *mei_dev = context;
+	struct mei_vsc_hw *hw = mei_dev_to_vsc_hw(mei_dev);
+	struct list_head cmpl_list;
+	s32 slots;
+	int ret;
+
+	if (mei_dev->dev_state == MEI_DEV_RESETTING ||
+	    mei_dev->dev_state == MEI_DEV_INITIALIZING)
+		return;
+
+	INIT_LIST_HEAD(&cmpl_list);
+
+	guard(mutex)(&mei_dev->device_lock);
+
+	while (vsc_tp_need_read(hw->tp)) {
+		/* check slots available for reading */
+		slots = mei_count_full_read_slots(mei_dev);
+
+		ret = mei_irq_read_handler(mei_dev, &cmpl_list, &slots);
+		if (ret) {
+			if (ret != -ENODATA) {
+				if (mei_dev->dev_state != MEI_DEV_RESETTING &&
+				    mei_dev->dev_state != MEI_DEV_POWER_DOWN)
+					schedule_work(&mei_dev->reset_work);
+			}
+
+			return;
+		}
+	}
+
+	mei_dev->hbuf_is_ready = mei_hbuf_is_ready(mei_dev);
+	ret = mei_irq_write_handler(mei_dev, &cmpl_list);
+	if (ret)
+		dev_err(mei_dev->dev, "dispatch write request failed: %d\n", ret);
+
+	mei_dev->hbuf_is_ready = mei_hbuf_is_ready(mei_dev);
+	mei_irq_compl_handler(mei_dev, &cmpl_list);
+}
+
+static int mei_vsc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mei_device *mei_dev;
+	struct mei_vsc_hw *hw;
+	struct vsc_tp *tp;
+	int ret;
+
+	tp = *(struct vsc_tp **)dev_get_platdata(dev);
+	if (!tp)
+		return dev_err_probe(dev, -ENODEV, "no platform data\n");
+
+	mei_dev = devm_kzalloc(dev, size_add(sizeof(*mei_dev), sizeof(*hw)),
+			       GFP_KERNEL);
+	if (!mei_dev)
+		return -ENOMEM;
+
+	mei_device_init(mei_dev, dev, false, &mei_vsc_hw_ops);
+	mei_dev->fw_f_fw_ver_supported = 0;
+	mei_dev->kind = "ivsc";
+
+	hw = mei_dev_to_vsc_hw(mei_dev);
+	atomic_set(&hw->write_lock_cnt, 0);
+	hw->tp = tp;
+
+	platform_set_drvdata(pdev, mei_dev);
+
+	vsc_tp_register_event_cb(tp, mei_vsc_event_cb, mei_dev);
+
+	ret = mei_start(mei_dev);
+	if (ret) {
+		dev_err_probe(dev, ret, "init hw failed\n");
+		goto err_cancel;
+	}
+
+	ret = mei_register(mei_dev, dev);
+	if (ret)
+		goto err_stop;
+
+	pm_runtime_enable(mei_dev->dev);
+
+	return 0;
+
+err_stop:
+	mei_stop(mei_dev);
+
+err_cancel:
+	mei_cancel_work(mei_dev);
+
+	mei_disable_interrupts(mei_dev);
+
+	return ret;
+}
+
+static int mei_vsc_remove(struct platform_device *pdev)
+{
+	struct mei_device *mei_dev = platform_get_drvdata(pdev);
+
+	pm_runtime_disable(mei_dev->dev);
+
+	mei_stop(mei_dev);
+
+	mei_disable_interrupts(mei_dev);
+
+	mei_deregister(mei_dev);
+
+	return 0;
+}
+
+static int mei_vsc_suspend(struct device *dev)
+{
+	struct mei_device *mei_dev = dev_get_drvdata(dev);
+
+	mei_stop(mei_dev);
+
+	return 0;
+}
+
+static int mei_vsc_resume(struct device *dev)
+{
+	struct mei_device *mei_dev = dev_get_drvdata(dev);
+	int ret;
+
+	ret = mei_restart(mei_dev);
+	if (ret)
+		return ret;
+
+	/* start timer if stopped in suspend */
+	schedule_delayed_work(&mei_dev->timer_work, HZ);
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(mei_vsc_pm_ops, mei_vsc_suspend, mei_vsc_resume);
+
+static struct platform_driver mei_vsc_drv = {
+	.probe = mei_vsc_probe,
+	.remove = mei_vsc_remove,
+	.driver = {
+		.name = "intel_vsc",
+		.pm = &mei_vsc_pm_ops,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+};
+module_platform_driver(mei_vsc_drv);
+
+MODULE_AUTHOR("Wentong Wu <wentong.wu@intel.com>");
+MODULE_AUTHOR("Zhifeng Wang <zhifeng.wang@intel.com>");
+MODULE_DESCRIPTION("Intel Visual Sensing Controller Interface");
+MODULE_ALIAS("platform:intel_vsc");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(VSC_TP);
-- 
2.7.4

