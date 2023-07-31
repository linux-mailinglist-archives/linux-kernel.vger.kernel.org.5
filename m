Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF497690B4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjGaIrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjGaIqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:46:42 -0400
Received: from mgamail.intel.com (unknown [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7972123
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690793125; x=1722329125;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u6mmbSMHH8jP59to7FzadHeajz1BccvQWhym7sQFvGo=;
  b=n/NwYQiw2CFRAH9fNgsRLE4LDRdIuO4n6JzEGwUZnAbJGFhQ7JoigJ8C
   LU56TLEspNZysIuB/44q3I1y1hWmfcTAuLxbm7uIOzpJzx+o738UGqR26
   gIM94+Du/hqJuIR+CuN7RUi4HRi++S6Ow9WoJBuz/SPRsJn4kid7qCBqh
   aqd+LugRNeLabm9qdlI1iDqwLpN7xV12Ck2t4w+m6XwrdbUXaHOmaT5GN
   qShBQpdHkmuFvI7WIJ/EObmT/6vWsHVqnAhedCgi06gniDD33gBAzTF5X
   5bKGqix++sck0kxHSNpPrfpURw4fb5kFz7HM/+GQHK56kP7V2os+FstDU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="348557489"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="348557489"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 01:45:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="678232312"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="678232312"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 01:45:23 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH v2 2/3] soundwire: bus: add callbacks for device_number allocation
Date:   Mon, 31 Jul 2023 17:13:32 +0800
Message-Id: <20230731091333.3593132-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230731091333.3593132-1-yung-chuan.liao@linux.intel.com>
References: <20230731091333.3593132-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Rather than add logic in the core for vendor-specific usages, add
callbacks for vendor-specific device_number allocation and release.

This patch only moves the existing IDA-based allocator used only by
Intel to the intel_auxdevice.c file and does not change the
functionality. Follow-up patches will extend the behavior by modifying
the Intel callbacks.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c             | 16 +++++++---------
 drivers/soundwire/intel_auxdevice.c | 17 ++++++++++++++++-
 include/linux/soundwire/sdw.h       |  8 ++++----
 3 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index bdd0fed45a8d..0e1e4bedc708 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -12,7 +12,6 @@
 #include "sysfs_local.h"
 
 static DEFINE_IDA(sdw_bus_ida);
-static DEFINE_IDA(sdw_peripheral_ida);
 
 static int sdw_get_id(struct sdw_bus *bus)
 {
@@ -168,8 +167,8 @@ static int sdw_delete_slave(struct device *dev, void *data)
 
 	if (slave->dev_num) { /* clear dev_num if assigned */
 		clear_bit(slave->dev_num, bus->assigned);
-		if (bus->dev_num_ida_min)
-			ida_free(&sdw_peripheral_ida, slave->dev_num);
+		if (bus->ops && bus->ops->put_device_num)
+			bus->ops->put_device_num(bus, slave);
 	}
 	list_del_init(&slave->node);
 	mutex_unlock(&bus->bus_lock);
@@ -710,16 +709,15 @@ EXPORT_SYMBOL(sdw_compare_devid);
 /* called with bus_lock held */
 static int sdw_get_device_num(struct sdw_slave *slave)
 {
+	struct sdw_bus *bus = slave->bus;
 	int bit;
 
-	if (slave->bus->dev_num_ida_min) {
-		bit = ida_alloc_range(&sdw_peripheral_ida,
-				      slave->bus->dev_num_ida_min, SDW_MAX_DEVICES,
-				      GFP_KERNEL);
+	if (bus->ops && bus->ops->get_device_num) {
+		bit = bus->ops->get_device_num(bus, slave);
 		if (bit < 0)
 			goto err;
 	} else {
-		bit = find_first_zero_bit(slave->bus->assigned, SDW_MAX_DEVICES);
+		bit = find_first_zero_bit(bus->assigned, SDW_MAX_DEVICES);
 		if (bit == SDW_MAX_DEVICES) {
 			bit = -ENODEV;
 			goto err;
@@ -730,7 +728,7 @@ static int sdw_get_device_num(struct sdw_slave *slave)
 	 * Do not update dev_num in Slave data structure here,
 	 * Update once program dev_num is successful
 	 */
-	set_bit(bit, slave->bus->assigned);
+	set_bit(bit, bus->assigned);
 
 err:
 	return bit;
diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
index cb2f199f4f97..9d998a010162 100644
--- a/drivers/soundwire/intel_auxdevice.c
+++ b/drivers/soundwire/intel_auxdevice.c
@@ -125,6 +125,20 @@ static int intel_prop_read(struct sdw_bus *bus)
 	return 0;
 }
 
+static DEFINE_IDA(intel_peripheral_ida);
+
+static int intel_get_device_num_ida(struct sdw_bus *bus, struct sdw_slave *slave)
+{
+	return ida_alloc_range(&intel_peripheral_ida,
+			       INTEL_DEV_NUM_IDA_MIN, SDW_MAX_DEVICES,
+			       GFP_KERNEL);
+}
+
+static void intel_put_device_num_ida(struct sdw_bus *bus, struct sdw_slave *slave)
+{
+	return ida_free(&intel_peripheral_ida, slave->dev_num);
+}
+
 static struct sdw_master_ops sdw_intel_ops = {
 	.read_prop = intel_prop_read,
 	.override_adr = sdw_dmi_override_adr,
@@ -134,6 +148,8 @@ static struct sdw_master_ops sdw_intel_ops = {
 	.pre_bank_switch = generic_pre_bank_switch,
 	.post_bank_switch = generic_post_bank_switch,
 	.read_ping_status = cdns_read_ping_status,
+	.get_device_num =  intel_get_device_num_ida,
+	.put_device_num = intel_put_device_num_ida,
 	.new_peripheral_assigned = generic_new_peripheral_assigned,
 };
 
@@ -167,7 +183,6 @@ static int intel_link_probe(struct auxiliary_device *auxdev,
 	cdns->msg_count = 0;
 
 	bus->link_id = auxdev->id;
-	bus->dev_num_ida_min = INTEL_DEV_NUM_IDA_MIN;
 	bus->clk_stop_timeout = 1;
 
 	sdw_cdns_probe(cdns);
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 94676a3fd0b5..bde93ca6aaa6 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -847,6 +847,8 @@ struct sdw_defer {
  * @post_bank_switch: Callback for post bank switch
  * @read_ping_status: Read status from PING frames, reported with two bits per Device.
  * Bits 31:24 are reserved.
+ * @get_device_num: Callback for vendor-specific device_number allocation
+ * @put_device_num: Callback for vendor-specific device_number release
  * @new_peripheral_assigned: Callback to handle enumeration of new peripheral.
  */
 struct sdw_master_ops {
@@ -862,6 +864,8 @@ struct sdw_master_ops {
 	int (*pre_bank_switch)(struct sdw_bus *bus);
 	int (*post_bank_switch)(struct sdw_bus *bus);
 	u32 (*read_ping_status)(struct sdw_bus *bus);
+	int (*get_device_num)(struct sdw_bus *bus, struct sdw_slave *slave);
+	void (*put_device_num)(struct sdw_bus *bus, struct sdw_slave *slave);
 	void (*new_peripheral_assigned)(struct sdw_bus *bus,
 					struct sdw_slave *slave,
 					int dev_num);
@@ -898,9 +902,6 @@ struct sdw_master_ops {
  * meaningful if multi_link is set. If set to 1, hardware-based
  * synchronization will be used even if a stream only uses a single
  * SoundWire segment.
- * @dev_num_ida_min: if set, defines the minimum values for the IDA
- * used to allocate system-unique device numbers. This value needs to be
- * identical across all SoundWire bus in the system.
  */
 struct sdw_bus {
 	struct device *dev;
@@ -927,7 +928,6 @@ struct sdw_bus {
 	u32 bank_switch_timeout;
 	bool multi_link;
 	int hw_sync_min_links;
-	int dev_num_ida_min;
 };
 
 int sdw_bus_master_add(struct sdw_bus *bus, struct device *parent,
-- 
2.25.1

