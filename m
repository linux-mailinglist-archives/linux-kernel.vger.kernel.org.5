Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA567CD8E9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjJRKKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjJRKKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:10:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945F895
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697623844; x=1729159844;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0TviPh5D209AYMkM4B05lZWreiuWP+oC6y7l4yN98lU=;
  b=lHbIvcmxy1bS2cGp4umLT2o2MYXkwSDV6oLJd4D28EqQC/AL9lawgjaX
   rkjxWBzc+c0cxgAuPXGocet3J1NOdb+JqDpFHx56SQyxyKwV10EeWlDhF
   DyUAJ7cvn7OiuwoDoBwNh33v4svDplv3Y9l6NbiRGzX2/bmqyr5+wjFNt
   gcP/jOcKY7FrnSOdqZHbbWFVxSbqIoPXHf7NK19BgWkKtON0Rw75yQ3wE
   7MIH8YPKhqAZltf5jJL4qTkO94nQCuZW2ZCpKy8Ai5YZSSPJZGhafmmJ1
   oSLzugZvN/s2yA+oEeEZv9cBGMscgXAxI6SE1jpoAHTRwCqpIhiJ+eBri
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="4578734"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="4578734"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 03:10:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="847206385"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="847206385"
Received: from twinkler-lnx.jer.intel.com ([10.12.231.216])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 03:10:41 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 2/2] mei: add empty handlers for ops functions
Date:   Wed, 18 Oct 2023 13:10:24 +0300
Message-ID: <20231018101024.271437-2-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018101024.271437-1-tomas.winkler@intel.com>
References: <20231018101024.271437-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Lubart <vitaly.lubart@intel.com>

When the offline bit is set and the device is being removed
we should prevent the driver from accessing the hardware because
at this stage the hardware may be no longer available.
Replace the operation handlers with the empty ones to ensure
no hardware registers are being accessed by the driver.

Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/gsc-me.c | 293 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 293 insertions(+)

diff --git a/drivers/misc/mei/gsc-me.c b/drivers/misc/mei/gsc-me.c
index 6be8f1cc052c13be3607432f..8ff2aae245aca26aee11e0b4 100644
--- a/drivers/misc/mei/gsc-me.c
+++ b/drivers/misc/mei/gsc-me.c
@@ -23,6 +23,11 @@
 
 #define MEI_GSC_RPM_TIMEOUT 500
 
+static inline bool mei_gsc_hw_is_unavailable(const struct device *dev)
+{
+	return dev->offline;
+}
+
 static int mei_gsc_read_hfs(const struct mei_device *dev, int where, u32 *val)
 {
 	struct mei_me_hw *hw = to_me_hw(dev);
@@ -43,6 +48,291 @@ static void mei_gsc_set_ext_op_mem(const struct mei_me_hw *hw, struct resource *
 	iowrite32(limit, hw->mem_addr + H_GSC_EXT_OP_MEM_LIMIT_REG);
 }
 
+/**
+ * mei_gsc_mecbrw_read_null - read 32bit data from ME circular buffer (empty implementation)
+ *  read window register
+ *
+ * @dev: the device structure
+ *
+ * Return: always 0
+ */
+static inline u32 mei_gsc_mecbrw_read_null(const struct mei_device *dev)
+{
+	return 0;
+}
+
+/**
+ * mei_gsc_trc_status_null - read trc status register (empty implementation)
+ *
+ * @dev: mei device
+ * @trc: trc status register value
+ *
+ * Return: always 0
+ */
+static int mei_gsc_trc_status_null(struct mei_device *dev, u32 *trc)
+{
+	*trc = 0;
+	return 0;
+}
+
+/**
+ * mei_gsc_fw_status_null - read fw status register from pci config space (empty implementation)
+ *
+ * @dev: mei device
+ * @fw_status: fw status register values
+ *
+ * Return: always 0
+ */
+static int mei_gsc_fw_status_null(struct mei_device *dev,
+				  struct mei_fw_status *fw_status)
+{
+	return 0;
+}
+
+/**
+ * mei_gsc_hw_config_null - configure hw dependent settings (empty implementation)
+ *
+ * @dev: mei device
+ *
+ * Return: always 0
+ *
+ */
+static int mei_gsc_hw_config_null(struct mei_device *dev)
+{
+	return 0;
+}
+
+/**
+ * mei_gsc_pg_state_null  - translate internal pg state (empty implementation)
+ *   to the mei power gating state
+ *
+ * @dev:  mei device
+ *
+ * Return: always MEI_PG_OFF
+ */
+static inline enum mei_pg_state mei_gsc_pg_state_null(struct mei_device *dev)
+{
+	return MEI_PG_OFF;
+}
+
+/**
+ * mei_gsc_intr_clear_null - clear and stop interrupts (empty implementation)
+ *
+ * @dev: the device structure
+ */
+static void mei_gsc_intr_clear_null(struct mei_device *dev)
+{
+}
+
+/**
+ * mei_gsc_intr_enable_null - enables mei device interrupts (empty implementation)
+ *
+ * @dev: the device structure
+ */
+static void mei_gsc_intr_enable_null(struct mei_device *dev)
+{
+}
+
+/**
+ * mei_gsc_intr_disable_null - disables mei device interrupts (empty implementation)
+ *
+ * @dev: the device structure
+ */
+static void mei_gsc_intr_disable_null(struct mei_device *dev)
+{
+}
+
+/**
+ * mei_gsc_synchronize_irq_null - wait for pending IRQ handlers (empty implementation)
+ *
+ * @dev: the device structure
+ */
+static void mei_gsc_synchronize_irq_null(struct mei_device *dev)
+{
+}
+
+/**
+ * mei_gsc_host_is_ready_null - check whether the host has turned ready (empty implementation)
+ *
+ * @dev: mei device
+ * Return: always true
+ */
+static bool mei_gsc_host_is_ready_null(struct mei_device *dev)
+{
+	return true;
+}
+
+/**
+ * mei_gsc_hw_start_null - hw start routine (empty implementation)
+ *
+ * @dev: mei device
+ * Return: always 0
+ */
+static int mei_gsc_hw_start_null(struct mei_device *dev)
+{
+	return 0;
+}
+
+/**
+ * mei_gsc_hbuf_is_empty_null - checks if host buffer is empty (empty implementation)
+ *
+ * @dev: the device structure
+ *
+ * Return: always true
+ */
+static bool mei_gsc_hbuf_is_empty_null(struct mei_device *dev)
+{
+	return true;
+}
+
+/**
+ * mei_gsc_hbuf_empty_slots_null - counts write empty slots (empty implementation)
+ *
+ * @dev: the device structure
+ *
+ * Return: always -EOVERFLOW
+ */
+static int mei_gsc_hbuf_empty_slots_null(struct mei_device *dev)
+{
+	return -EOVERFLOW;
+}
+
+/**
+ * mei_gsc_hbuf_depth_null - returns depth of the hw buffer (empty implementation)
+ *
+ * @dev: the device structure
+ *
+ * Return: always 1
+ */
+static u32 mei_gsc_hbuf_depth_null(const struct mei_device *dev)
+{
+	return 0;
+}
+
+/**
+ * mei_gsc_hbuf_write_null - writes a message to host hw buffer (empty implementation)
+ *
+ * @dev: the device structure
+ * @hdr: header of message
+ * @hdr_len: header length in bytes: must be multiplication of a slot (4bytes)
+ * @data: payload
+ * @data_len: payload length in bytes
+ *
+ * Return: always 0
+ */
+static int mei_gsc_hbuf_write_null(struct mei_device *dev,
+				   const void *hdr, size_t hdr_len,
+				   const void *data, size_t data_len)
+{
+	return 0;
+}
+
+/**
+ * mei_gsc_count_full_read_slots_null - counts read full slots (empty implementation)
+ *
+ * @dev: the device structure
+ *
+ * Return: always -EOVERFLOW
+ */
+static int mei_gsc_count_full_read_slots_null(struct mei_device *dev)
+{
+	return -EOVERFLOW;
+}
+
+/**
+ * mei_gsc_read_slots_null - reads a message from mei device (empty implementation)
+ *
+ * @dev: the device structure
+ * @buffer: message buffer will be written
+ * @buffer_length: message size will be read
+ *
+ * Return: always 0
+ */
+static int mei_gsc_read_slots_null(struct mei_device *dev, unsigned char *buffer,
+				   unsigned long buffer_length)
+{
+	return 0;
+}
+
+/**
+ * mei_gsc_pg_in_transition_null - is device now in pg transition (empty implementation)
+ *
+ * @dev: the device structure
+ *
+ * Return: always false
+ */
+static bool mei_gsc_pg_in_transition_null(struct mei_device *dev)
+{
+	return false;
+}
+
+/**
+ * mei_gsc_pg_is_enabled_null - detect if PG is supported by HW (empty implementation)
+ *
+ * @dev: the device structure
+ *
+ * Return: always false
+ */
+static bool mei_gsc_pg_is_enabled_null(struct mei_device *dev)
+{
+	return false;
+}
+
+/**
+ * mei_gsc_hw_is_ready_null - check whether the me(hw) has turned ready (empty implementation)
+ *
+ * @dev: mei device
+ * Return: always true
+ */
+static bool mei_gsc_hw_is_ready_null(struct mei_device *dev)
+{
+	return true;
+}
+
+/**
+ * mei_gsc_hw_reset_null - resets fw via mei csr register (empty implementation)
+ *
+ * @dev: the device structure
+ * @intr_enable: if interrupt should be enabled after reset.
+ *
+ * Return: always 0
+ */
+static int mei_gsc_hw_reset_null(struct mei_device *dev, bool intr_enable)
+{
+	return 0;
+}
+
+static const struct mei_hw_ops mei_gsc_hw_ops_null = {
+	.trc_status = mei_gsc_trc_status_null,
+	.fw_status = mei_gsc_fw_status_null,
+	.pg_state  = mei_gsc_pg_state_null,
+
+	.host_is_ready = mei_gsc_host_is_ready_null,
+
+	.hw_is_ready = mei_gsc_hw_is_ready_null,
+	.hw_reset = mei_gsc_hw_reset_null,
+	.hw_config = mei_gsc_hw_config_null,
+	.hw_start = mei_gsc_hw_start_null,
+
+	.pg_in_transition = mei_gsc_pg_in_transition_null,
+	.pg_is_enabled = mei_gsc_pg_is_enabled_null,
+
+	.intr_clear = mei_gsc_intr_clear_null,
+	.intr_enable = mei_gsc_intr_enable_null,
+	.intr_disable = mei_gsc_intr_disable_null,
+	.synchronize_irq = mei_gsc_synchronize_irq_null,
+
+	.hbuf_free_slots = mei_gsc_hbuf_empty_slots_null,
+	.hbuf_is_ready = mei_gsc_hbuf_is_empty_null,
+	.hbuf_depth = mei_gsc_hbuf_depth_null,
+
+	.write = mei_gsc_hbuf_write_null,
+
+	.rdbuf_full_slots = mei_gsc_count_full_read_slots_null,
+	.read_hdr = mei_gsc_mecbrw_read_null,
+	.read = mei_gsc_read_slots_null
+};
+
 static int mei_gsc_probe(struct auxiliary_device *aux_dev,
 			 const struct auxiliary_device_id *aux_dev_id)
 {
@@ -149,6 +439,9 @@ static void mei_gsc_remove(struct auxiliary_device *aux_dev)
 
 	hw = to_me_hw(dev);
 
+	if (mei_gsc_hw_is_unavailable(&aux_dev->dev))
+		dev->ops = &mei_gsc_hw_ops_null;
+
 	mei_stop(dev);
 
 	hw = to_me_hw(dev);
-- 
2.41.0

