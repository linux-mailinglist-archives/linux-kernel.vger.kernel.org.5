Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C425D7CC876
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344029AbjJQQLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343776AbjJQQLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:11:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5513E9E;
        Tue, 17 Oct 2023 09:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697559079; x=1729095079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5TkiqnrgGUR9l/9JjizuOwqg19NNV0hU60DdfXEYDDc=;
  b=MzMPTeh0rVnc5zh/g61/WcPmeqP80KMkI+28KdC4Fi4Z8cWMiP1MotmO
   caPcUSQ+jUJMVjv/uHiGKuPHsI0BdLgjkGo0eryqRXNbMLpvs3daGaAjP
   93CZvL/racL50jpABYGcMFOg3NNEsRqynnXe91FWqTFU5sNHcp5nekwH1
   Um14S4a9XdfETZuBEhlY+978uw32dgMEWQmuCsZtDU8kjY9KbbeXdYuB7
   y6Osd8wm9IKCEq8fRbKbvj6AyBx6UDaG9bCbq38mhKCHut/ogJkRj2yQ0
   oiZdCX16Pr1oSTb2miFbM28t2n9f3RSiT+TaPz+nH/7I5U6P3wMLdrXv/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="365167515"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="365167515"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 09:09:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="759865021"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="759865021"
Received: from asprado-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.55.179])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 09:09:48 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org, srinivas.kandagatla@linaro.org
Cc:     tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 2/2] soundwire: fix initializing sysfs for same devices on different buses
Date:   Tue, 17 Oct 2023 11:09:33 -0500
Message-Id: <20231017160933.12624-3-pierre-louis.bossart@linux.intel.com>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

If same devices with same device IDs are present on different soundwire
buses, the probe fails due to conflicting device names and sysfs
entries:

  sysfs: cannot create duplicate filename '/bus/soundwire/devices/sdw:0:0217:0204:00:0'

The link ID is 0 for both devices, so they should be differentiated by
the controller ID. Add the controller ID so, the device names and sysfs entries look
like:

  sdw:1:0:0217:0204:00:0 -> ../../../devices/platform/soc@0/6ab0000.soundwire-controller/sdw-master-1-0/sdw:1:0:0217:0204:00:0
  sdw:3:0:0217:0204:00:0 -> ../../../devices/platform/soc@0/6b10000.soundwire-controller/sdw-master-3-0/sdw:3:0:0217:0204:00:0

[PLB changes: use bus->controller_id instead of bus->id]

Fixes: 7c3cd189b86d ("soundwire: Add Master registration")
Cc: <stable@vger.kernel.org>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Co-developed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soundwire/slave.c        | 12 ++++++------
 sound/soc/intel/boards/sof_sdw.c |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index c1c1a2ac293a..060c2982e26b 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -39,14 +39,14 @@ int sdw_slave_add(struct sdw_bus *bus,
 	slave->dev.fwnode = fwnode;
 
 	if (id->unique_id == SDW_IGNORED_UNIQUE_ID) {
-		/* name shall be sdw:link:mfg:part:class */
-		dev_set_name(&slave->dev, "sdw:%01x:%04x:%04x:%02x",
-			     bus->link_id, id->mfg_id, id->part_id,
+		/* name shall be sdw:ctrl:link:mfg:part:class */
+		dev_set_name(&slave->dev, "sdw:%01x:%01x:%04x:%04x:%02x",
+			     bus->controller_id, bus->link_id, id->mfg_id, id->part_id,
 			     id->class_id);
 	} else {
-		/* name shall be sdw:link:mfg:part:class:unique */
-		dev_set_name(&slave->dev, "sdw:%01x:%04x:%04x:%02x:%01x",
-			     bus->link_id, id->mfg_id, id->part_id,
+		/* name shall be sdw:ctrl:link:mfg:part:class:unique */
+		dev_set_name(&slave->dev, "sdw:%01x:%01x:%04x:%04x:%02x:%01x",
+			     bus->controller_id, bus->link_id, id->mfg_id, id->part_id,
 			     id->class_id, id->unique_id);
 	}
 
diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 869dacb81133..6575549b8407 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -1242,11 +1242,11 @@ static int fill_sdw_codec_dlc(struct device *dev,
 	else if (is_unique_device(adr_link, sdw_version, mfg_id, part_id,
 				  class_id, adr_index))
 		codec->name = devm_kasprintf(dev, GFP_KERNEL,
-					     "sdw:%01x:%04x:%04x:%02x", link_id,
+					     "sdw:0:%01x:%04x:%04x:%02x", link_id,
 					     mfg_id, part_id, class_id);
 	else
 		codec->name = devm_kasprintf(dev, GFP_KERNEL,
-					     "sdw:%01x:%04x:%04x:%02x:%01x", link_id,
+					     "sdw:0:%01x:%04x:%04x:%02x:%01x", link_id,
 					     mfg_id, part_id, class_id, unique_id);
 
 	if (!codec->name)
-- 
2.39.2

