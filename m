Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA1F7CC875
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343887AbjJQQLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343532AbjJQQLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:11:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D0EB0;
        Tue, 17 Oct 2023 09:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697559078; x=1729095078;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=01fBf8qyJKNXqBVJNmGz++dnHQ6+XueViQQp7+FRMJw=;
  b=mM7HiliirS0ZvkgVEkcEqT7IMQLWQf+9jynzg2YLco0rumg2lSx1zPJ2
   cGuATS0qzBm3cf+StytsUzsb9UNeF+nFYI4JKXqzp/yD4cVJ8BJm76Dg7
   Bn2LkH7mZIo+NaK+XbZvAlk8jCsys8d+UNes98dIwa1P8IJvFapgb0dY+
   f7z1mzjxVl50SBA17nELfsGly9CK0nJBtxOztRGdsyJZxnD+uNG8ho+U8
   GUS3EOZS4v31GYlmLL+yszs8EZif8c4lSsPGkBH7/itbI96bVbls8q5wN
   jhT3BlJM6Ilj9rZKbW9/gMZitCZtM+Gr2Aw5sv5H+Qh0IFnb/I4+a5mL9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="365167502"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="365167502"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 09:09:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="759865020"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="759865020"
Received: from asprado-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.55.179])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 09:09:47 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org, srinivas.kandagatla@linaro.org
Cc:     tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [RFC PATCH 1/2] soundwire: bus: introduce controller_id
Date:   Tue, 17 Oct 2023 11:09:32 -0500
Message-Id: <20231017160933.12624-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017160933.12624-1-pierre-louis.bossart@linux.intel.com>
References: <20231017160933.12624-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing SoundWire support misses a clear Controller/Manager
hiearchical definition to deal with all variants across SOC vendors.

a) Intel platforms have one controller with 4 or more Managers.
b) AMD platforms have two controllers with one Manager each, but due
to BIOS issues use two different link_id values within the scope of a
single controller.
c) QCOM platforms have one or more controller with one Manager each.

This patch adds a 'controller_id' which can be set by higher
levels. If assigned to -1, the controller_id will be set to the
system-unique IDA-assigned bus->id.

The main change is that the bus->id is no longer used for any device
name, which makes the definition completely predictable and not
dependent on any enumeration order. The bus->id is only used to insert
the Managers in the stream rt context.

Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/amd_manager.c     | 8 ++++++++
 drivers/soundwire/bus.c             | 4 ++++
 drivers/soundwire/debugfs.c         | 2 +-
 drivers/soundwire/intel_auxdevice.c | 3 +++
 drivers/soundwire/master.c          | 2 +-
 drivers/soundwire/qcom.c            | 3 +++
 include/linux/soundwire/sdw.h       | 4 +++-
 7 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index 3a99f6dcdfaf..a3b1f4e6f0f9 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -927,6 +927,14 @@ static int amd_sdw_manager_probe(struct platform_device *pdev)
 	amd_manager->bus.clk_stop_timeout = 200;
 	amd_manager->bus.link_id = amd_manager->instance;
 
+	/*
+	 * Due to BIOS compatibility, the two links are exposed within
+	 * the scope of a single controller. If this changes, the
+	 * controller_id will have to be updated with drv_data
+	 * information.
+	 */
+	amd_manager->bus.controller_id = 0;
+
 	switch (amd_manager->instance) {
 	case ACP_SDW0:
 		amd_manager->num_dout_ports = AMD_SDW0_MAX_TX_PORTS;
diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 1720031f35a3..025d3df32bd0 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -22,6 +22,10 @@ static int sdw_get_id(struct sdw_bus *bus)
 		return rc;
 
 	bus->id = rc;
+
+	if (bus->controller_id == -1)
+		bus->controller_id = rc;
+
 	return 0;
 }
 
diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.c
index d1553cb77187..67abd7e52f09 100644
--- a/drivers/soundwire/debugfs.c
+++ b/drivers/soundwire/debugfs.c
@@ -20,7 +20,7 @@ void sdw_bus_debugfs_init(struct sdw_bus *bus)
 		return;
 
 	/* create the debugfs master-N */
-	snprintf(name, sizeof(name), "master-%d-%d", bus->id, bus->link_id);
+	snprintf(name, sizeof(name), "master-%d-%d", bus->controller_id, bus->link_id);
 	bus->debugfs = debugfs_create_dir(name, sdw_debugfs_root);
 }
 
diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
index 7f15e3549e53..93698532deac 100644
--- a/drivers/soundwire/intel_auxdevice.c
+++ b/drivers/soundwire/intel_auxdevice.c
@@ -234,6 +234,9 @@ static int intel_link_probe(struct auxiliary_device *auxdev,
 	cdns->instance = sdw->instance;
 	cdns->msg_count = 0;
 
+	/* single controller for all SoundWire links */
+	bus->controller_id = 0;
+
 	bus->link_id = auxdev->id;
 	bus->clk_stop_timeout = 1;
 
diff --git a/drivers/soundwire/master.c b/drivers/soundwire/master.c
index 9b05c9e25ebe..51abedbbaa66 100644
--- a/drivers/soundwire/master.c
+++ b/drivers/soundwire/master.c
@@ -145,7 +145,7 @@ int sdw_master_device_add(struct sdw_bus *bus, struct device *parent,
 	md->dev.fwnode = fwnode;
 	md->dev.dma_mask = parent->dma_mask;
 
-	dev_set_name(&md->dev, "sdw-master-%d", bus->id);
+	dev_set_name(&md->dev, "sdw-master-%d-%d", bus->controller_id, bus->link_id);
 
 	ret = device_register(&md->dev);
 	if (ret) {
diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 55be9f4b8d59..e3ae4e4e07ac 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -1612,6 +1612,9 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 		}
 	}
 
+	/* FIXME: is there a DT-defined value to use ? */
+	ctrl->bus.controller_id = -1;
+
 	ret = sdw_bus_master_add(&ctrl->bus, dev, dev->fwnode);
 	if (ret) {
 		dev_err(dev, "Failed to register Soundwire controller (%d)\n",
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 4f3d14bb1538..c383579a008b 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -886,7 +886,8 @@ struct sdw_master_ops {
  * struct sdw_bus - SoundWire bus
  * @dev: Shortcut to &bus->md->dev to avoid changing the entire code.
  * @md: Master device
- * @link_id: Link id number, can be 0 to N, unique for each Master
+ * @controller_id: system-unique controller ID. If set to -1, the bus @id will be used.
+ * @link_id: Link id number, can be 0 to N, unique for each Controller
  * @id: bus system-wide unique id
  * @slaves: list of Slaves on this bus
  * @assigned: Bitmap for Slave device numbers.
@@ -918,6 +919,7 @@ struct sdw_master_ops {
 struct sdw_bus {
 	struct device *dev;
 	struct sdw_master_device *md;
+	int controller_id;
 	unsigned int link_id;
 	int id;
 	struct list_head slaves;
-- 
2.39.2

