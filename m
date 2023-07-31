Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE167690B2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjGaIr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjGaIql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:46:41 -0400
Received: from mgamail.intel.com (unknown [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED112117
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690793123; x=1722329123;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ARAOO1pyps6zAaRXGz2FOsZTdJ2x3fTJifVNqOAkVq0=;
  b=cplt7e5wDsVu3PFbiCZ4xIGZxKDQJqowKgNrBKnL3sGG/oaRY1/CEY5U
   byHEWGLnl1YltHDQWOvtqvIcZFYlQypbRHMExl+zp4NxwgME/psAUicRT
   ROBWq/1mGoowJ8laMyYbfOA9sVXcvlG06ZSBBZeJtj9PzrFY9OmwZCVLZ
   BljT5rnxhjCj1OuqhgTAaq0NlcqilqA6TuB2KQMA8MsbTEoWi1YMfbIm/
   ArijYanfdE4Pu0uQU/tKvB8b/f+9lZI0RzC6cnymddbEDz6j9uF4TP4p4
   uJHuJ8t1sjIBqKDuCHrKalP0xDI3D0oHYcJA30QqAF6aCM9wS58Ph4C9e
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="348557448"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="348557448"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 01:45:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="678232265"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="678232265"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 01:45:21 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH v2 1/3] soundwire: extend parameters of new_peripheral_assigned() callback
Date:   Mon, 31 Jul 2023 17:13:31 +0800
Message-Id: <20230731091333.3593132-2-yung-chuan.liao@linux.intel.com>
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

The parameters are only the bus and the device number, manager ops may
need additional details on the type of peripheral connected, such as
whether it is wake-capable or not.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c             | 2 +-
 drivers/soundwire/intel_auxdevice.c | 4 +++-
 include/linux/soundwire/sdw.h       | 4 +++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index dba920ec88f6..bdd0fed45a8d 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -781,7 +781,7 @@ static int sdw_assign_device_num(struct sdw_slave *slave)
 	slave->dev_num = slave->dev_num_sticky;
 
 	if (bus->ops && bus->ops->new_peripheral_assigned)
-		bus->ops->new_peripheral_assigned(bus, dev_num);
+		bus->ops->new_peripheral_assigned(bus, slave, dev_num);
 
 	return 0;
 }
diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
index 0daa6ca9a224..cb2f199f4f97 100644
--- a/drivers/soundwire/intel_auxdevice.c
+++ b/drivers/soundwire/intel_auxdevice.c
@@ -60,7 +60,9 @@ static int generic_post_bank_switch(struct sdw_bus *bus)
 	return sdw->link_res->hw_ops->post_bank_switch(sdw);
 }
 
-static void generic_new_peripheral_assigned(struct sdw_bus *bus, int dev_num)
+static void generic_new_peripheral_assigned(struct sdw_bus *bus,
+					    struct sdw_slave *slave,
+					    int dev_num)
 {
 	struct sdw_cdns *cdns = bus_to_cdns(bus);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index f523ceabd059..94676a3fd0b5 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -862,7 +862,9 @@ struct sdw_master_ops {
 	int (*pre_bank_switch)(struct sdw_bus *bus);
 	int (*post_bank_switch)(struct sdw_bus *bus);
 	u32 (*read_ping_status)(struct sdw_bus *bus);
-	void (*new_peripheral_assigned)(struct sdw_bus *bus, int dev_num);
+	void (*new_peripheral_assigned)(struct sdw_bus *bus,
+					struct sdw_slave *slave,
+					int dev_num);
 };
 
 /**
-- 
2.25.1

