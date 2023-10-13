Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329097C7B00
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 03:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjJMBBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 21:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJMBA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 21:00:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DADD6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 18:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697158857; x=1728694857;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A8vxlDAoN4G/XceJuG50VnLiTJyN1JUtwmw+OsBrbOE=;
  b=njhLgN/MRZMjz7bk5ZQSFQ0gmIxyCQopxWR5R3QcnL3EJkTSK5LGFkc/
   kUe3ymxaIyZ8nUQqZSmmb1Qq7EYFvPkxS0CGw6YSaXP5287tO9nDlxa99
   IZdVKi/Tjo9q7jqymY35fNkuVk9592aoqENR1BW8nypkjh/M8c0tb8gW9
   zFWr5ZQvAdTDFXgw9t82ksU3hjq2PW6AfXvcUPDy4hShyAwPK/T7oK2hH
   +Iic0VHgkYtSnrYRUmTvRErZaofNn1veODHMwSkNlTyrGEnTmeAxXvtfb
   EfP55CSqGuO0JwsF8Kaz121P/klO3QSWUVlxM757IFb3U8yDGEy4FdT50
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="370147607"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="370147607"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 18:00:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="870824070"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="870824070"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 18:00:53 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH] soundwire: bus: improve error handling for clock stop prepare/deprepare
Date:   Fri, 13 Oct 2023 09:08:12 +0800
Message-Id: <20231013010812.114216-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The same logic is used for clock stop prepare and deprepare, and
having different logs for the two steps helps identify problems.

In addition, when the "NotFinished" bit remains set, the error
handling is not quite right:

a) for the clock stop prepare, the error is handled at the caller
level, and the error is ignored: there's no good reason to prevent the
pm_runtime suspend from happening. Throwing an error that is later
ignored is confusing.

b) for the clock stop deprepare, the error is ignored in bus.c and a
dev_warn() log shown. Throwing an error is also alarming users for no
good reason.

For both cases, demoting the error to dev_dbg() makes more sense.

Link: https://github.com/thesofproject/linux/issues/4619
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 1720031f35a3..327ce316fed9 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1022,7 +1022,7 @@ static int sdw_slave_clk_stop_prepare(struct sdw_slave *slave,
 	return ret;
 }
 
-static int sdw_bus_wait_for_clk_prep_deprep(struct sdw_bus *bus, u16 dev_num)
+static int sdw_bus_wait_for_clk_prep_deprep(struct sdw_bus *bus, u16 dev_num, bool prepare)
 {
 	int retry = bus->clk_stop_timeout;
 	int val;
@@ -1036,7 +1036,8 @@ static int sdw_bus_wait_for_clk_prep_deprep(struct sdw_bus *bus, u16 dev_num)
 		}
 		val &= SDW_SCP_STAT_CLK_STP_NF;
 		if (!val) {
-			dev_dbg(bus->dev, "clock stop prep/de-prep done slave:%d\n",
+			dev_dbg(bus->dev, "clock stop %s done slave:%d\n",
+				prepare ? "prepare" : "deprepare",
 				dev_num);
 			return 0;
 		}
@@ -1045,7 +1046,8 @@ static int sdw_bus_wait_for_clk_prep_deprep(struct sdw_bus *bus, u16 dev_num)
 		retry--;
 	} while (retry);
 
-	dev_err(bus->dev, "clock stop prep/de-prep failed slave:%d\n",
+	dev_dbg(bus->dev, "clock stop %s did not complete for slave:%d\n",
+		prepare ? "prepare" : "deprepare",
 		dev_num);
 
 	return -ETIMEDOUT;
@@ -1116,7 +1118,7 @@ int sdw_bus_prep_clk_stop(struct sdw_bus *bus)
 	 */
 	if (!simple_clk_stop) {
 		ret = sdw_bus_wait_for_clk_prep_deprep(bus,
-						       SDW_BROADCAST_DEV_NUM);
+						       SDW_BROADCAST_DEV_NUM, true);
 		/*
 		 * if there are no Slave devices present and the reply is
 		 * Command_Ignored/-ENODATA, we don't need to continue with the
@@ -1236,7 +1238,7 @@ int sdw_bus_exit_clk_stop(struct sdw_bus *bus)
 	 * state machine
 	 */
 	if (!simple_clk_stop) {
-		ret = sdw_bus_wait_for_clk_prep_deprep(bus, SDW_BROADCAST_DEV_NUM);
+		ret = sdw_bus_wait_for_clk_prep_deprep(bus, SDW_BROADCAST_DEV_NUM, false);
 		if (ret < 0)
 			dev_warn(bus->dev, "clock stop deprepare wait failed:%d\n", ret);
 	}
-- 
2.25.1

