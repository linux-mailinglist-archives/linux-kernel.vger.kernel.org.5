Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D837690B5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjGaIrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjGaIqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:46:43 -0400
Received: from mgamail.intel.com (unknown [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A512134
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690793128; x=1722329128;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q8SJvmTRN/QrgEBLtmSIU3TUp+MWJ40CCg6CQ8CCKx0=;
  b=Q0Vbhuwhb/PTAKuWIKPObiJcA6btxGQEsh0QMG4j7rWXBf/77vt/p8XA
   KJn534mM6WG0/B99TOV0rLtLDJV9AEsFGej1lxH4YpYaSwo47+Y8bYF2G
   QlVqTYY6pr0EwwnFIqB2q+y0dIMESxSrecmnIMkIzme0mIc+5Qw3FGQ06
   nQSHX+G4EyArObfClXM1ZFr5wKH8KPuyMyT2uNhlgaEJaCjqvBHo0zA0C
   LLwS1kY2/NbWz/kfS7Qxvp2glTCVbFFT6T30SDf+7LegHOsNRreumXhLj
   XY7Ed98yLtuL8q/l0iubQO3VCFfBsaUeCT+VPTSauLOQ5bUe7djwtsHJ3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="348557538"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="348557538"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 01:45:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="678232351"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="678232351"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 01:45:25 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH v2 3/3] soundwire: intel_auxdevice: add hybrid IDA-based device_number allocation
Date:   Mon, 31 Jul 2023 17:13:33 +0800
Message-Id: <20230731091333.3593132-4-yung-chuan.liao@linux.intel.com>
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

The IDA-based allocation is useful to simplify debug, but it was also
introduced as a prerequisite to deal with the Intel Lunar Lake
hardware programming sequences: the wake-ups have to be handled with a
system-unique SDI address at the HDaudio controller level.

At the time, the restriction introduced by the IDA to 8 devices total
seemed perfectly fine, but recently hardware vendors created
configurations with more than 8 devices.

Add a new allocation strategy to allow for more than 8 devices using
information on the type of devices, and only use the IDA-based
allocation for devices capable of generating a wake.

In theory the information on wake capabilities should come from
firmware, but none of the existing ACPI tables provide it. The drivers
set the 'wake_capable' property, but this cannot be used reliably: if
the driver probe happens *after* the enumeration, then that property
is not initialized yet. Trying to modify the device_number on-the-fly
proved to be an impossible task generating race conditions left and
right.

The only reliable work-around to control the enumeration is to add a
quirk table. It's ugly but until platform firmware improves, hopefully as a
result of MIPI/SDCA stardization, we can expect that quirk table to
grow for each new headset or microphone codec.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_auxdevice.c | 72 +++++++++++++++++++++++++----
 include/linux/soundwire/sdw_intel.h |  7 +++
 2 files changed, 69 insertions(+), 10 deletions(-)

diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
index 9d998a010162..238025a0e35c 100644
--- a/drivers/soundwire/intel_auxdevice.c
+++ b/drivers/soundwire/intel_auxdevice.c
@@ -23,9 +23,6 @@
 #include "intel.h"
 #include "intel_auxdevice.h"
 
-/* IDA min selected to avoid conflicts with HDaudio/iDISP SDI values */
-#define INTEL_DEV_NUM_IDA_MIN           4
-
 #define INTEL_MASTER_SUSPEND_DELAY_MS	3000
 
 /*
@@ -44,6 +41,39 @@ static int md_flags;
 module_param_named(sdw_md_flags, md_flags, int, 0444);
 MODULE_PARM_DESC(sdw_md_flags, "SoundWire Intel Master device flags (0x0 all off)");
 
+struct wake_capable_part {
+	const u16 mfg_id;
+	const u16 part_id;
+};
+
+static struct wake_capable_part wake_capable_list[] = {
+	{0x025d, 0x5682},
+	{0x025d, 0x700},
+	{0x025d, 0x711},
+	{0x025d, 0x1712},
+	{0x025d, 0x1713},
+	{0x025d, 0x1716},
+	{0x025d, 0x1717},
+	{0x025d, 0x712},
+	{0x025d, 0x713},
+	{0x025d, 0x714},
+	{0x025d, 0x715},
+	{0x025d, 0x716},
+	{0x025d, 0x717},
+	{0x025d, 0x722},
+};
+
+static bool is_wake_capable(struct sdw_slave *slave)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(wake_capable_list); i++)
+		if (slave->id.part_id == wake_capable_list[i].part_id &&
+		    slave->id.mfg_id == wake_capable_list[i].mfg_id)
+			return true;
+	return false;
+}
+
 static int generic_pre_bank_switch(struct sdw_bus *bus)
 {
 	struct sdw_cdns *cdns = bus_to_cdns(bus);
@@ -66,14 +96,26 @@ static void generic_new_peripheral_assigned(struct sdw_bus *bus,
 {
 	struct sdw_cdns *cdns = bus_to_cdns(bus);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
+	int dev_num_min;
+	int dev_num_max;
+	bool wake_capable = slave->prop.wake_capable || is_wake_capable(slave);
+
+	if (wake_capable) {
+		dev_num_min = SDW_INTEL_DEV_NUM_IDA_MIN;
+		dev_num_max = SDW_MAX_DEVICES;
+	} else {
+		dev_num_min = 1;
+		dev_num_max = SDW_INTEL_DEV_NUM_IDA_MIN - 1;
+	}
 
 	/* paranoia check, this should never happen */
-	if (dev_num < INTEL_DEV_NUM_IDA_MIN || dev_num > SDW_MAX_DEVICES)  {
-		dev_err(bus->dev, "%s: invalid dev_num %d\n", __func__, dev_num);
+	if (dev_num < dev_num_min || dev_num > dev_num_max)  {
+		dev_err(bus->dev, "%s: invalid dev_num %d, wake supported %d\n",
+			__func__, dev_num, slave->prop.wake_capable);
 		return;
 	}
 
-	if (sdw->link_res->hw_ops->program_sdi)
+	if (sdw->link_res->hw_ops->program_sdi && wake_capable)
 		sdw->link_res->hw_ops->program_sdi(sdw, dev_num);
 }
 
@@ -129,14 +171,24 @@ static DEFINE_IDA(intel_peripheral_ida);
 
 static int intel_get_device_num_ida(struct sdw_bus *bus, struct sdw_slave *slave)
 {
-	return ida_alloc_range(&intel_peripheral_ida,
-			       INTEL_DEV_NUM_IDA_MIN, SDW_MAX_DEVICES,
-			       GFP_KERNEL);
+	int bit;
+
+	if (slave->prop.wake_capable || is_wake_capable(slave))
+		return ida_alloc_range(&intel_peripheral_ida,
+				       SDW_INTEL_DEV_NUM_IDA_MIN, SDW_MAX_DEVICES,
+				       GFP_KERNEL);
+
+	bit = find_first_zero_bit(slave->bus->assigned, SDW_MAX_DEVICES);
+	if (bit == SDW_MAX_DEVICES)
+		return -ENODEV;
+
+	return bit;
 }
 
 static void intel_put_device_num_ida(struct sdw_bus *bus, struct sdw_slave *slave)
 {
-	return ida_free(&intel_peripheral_ida, slave->dev_num);
+	if (slave->prop.wake_capable || is_wake_capable(slave))
+		ida_free(&intel_peripheral_ida, slave->dev_num);
 }
 
 static struct sdw_master_ops sdw_intel_ops = {
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 11fc88fb0d78..3a824cae7379 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -433,4 +433,11 @@ struct sdw_intel_hw_ops {
 extern const struct sdw_intel_hw_ops sdw_intel_cnl_hw_ops;
 extern const struct sdw_intel_hw_ops sdw_intel_lnl_hw_ops;
 
+/*
+ * IDA min selected to allow for 5 unconstrained devices per link,
+ * and 6 system-unique Device Numbers for wake-capable devices.
+ */
+
+#define SDW_INTEL_DEV_NUM_IDA_MIN           6
+
 #endif
-- 
2.25.1

