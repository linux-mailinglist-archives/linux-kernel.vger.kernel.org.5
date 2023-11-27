Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54437F9F96
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbjK0McP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbjK0McH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:32:07 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F12FA8;
        Mon, 27 Nov 2023 04:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701088334; x=1732624334;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4AjPIatTPDkq5wBY0ALs6UFh15FS5cCycMP5jH/dnGU=;
  b=guCC8skDjzbVpbLsh221uAFfVzlzA7hzocUWWrFLdJRurWPho9Klwyrc
   GibXVCjDs9wdjFo8TzlrOCSsetzmvAWvKbHr+HpTpU4IqKljxqbQuRmT3
   MAlZT30EqI/ZY07wjVIYoQZNcIbtOXHlCp7gqzOtam5gKaLsTCAADFQWv
   SAdr7RRR+9LxXI+xt4XVZJIW8GNl7ICwK/UfxWIimO8jP2I9rBepNnTfh
   AUU8B+I6q2a3PKexEubr//JLEgFMQD8PXwxQ9gRHgxXpclO9DdiBXExxm
   DyDn+lj/OpRgJGY2P0m0splejT4Frkt3kTKPypHlBcx5iNNPAXwJ5hTHK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="5881415"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="5881415"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 04:32:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="9607086"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 04:32:12 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     linux-sound@vger.kernel.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH] soundwire: generic_bandwidth_allocation use bus->params.max_dr_freq
Date:   Mon, 27 Nov 2023 20:44:05 +0800
Message-Id: <20231127124405.2080431-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bus->params.max_dr_freq is calculated and set in sdw_bus_master_add().
We can use it directly instead of calculating it again.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
---
 drivers/soundwire/generic_bandwidth_allocation.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/generic_bandwidth_allocation.c b/drivers/soundwire/generic_bandwidth_allocation.c
index 31162f2b5638..c70a63d009ae 100644
--- a/drivers/soundwire/generic_bandwidth_allocation.c
+++ b/drivers/soundwire/generic_bandwidth_allocation.c
@@ -333,7 +333,7 @@ static int sdw_select_row_col(struct sdw_bus *bus, int clk_freq)
  */
 static int sdw_compute_bus_params(struct sdw_bus *bus)
 {
-	unsigned int max_dr_freq, curr_dr_freq = 0;
+	unsigned int curr_dr_freq = 0;
 	struct sdw_master_prop *mstr_prop = &bus->prop;
 	int i, clk_values, ret;
 	bool is_gear = false;
@@ -351,14 +351,12 @@ static int sdw_compute_bus_params(struct sdw_bus *bus)
 		clk_buf = NULL;
 	}
 
-	max_dr_freq = mstr_prop->max_clk_freq * SDW_DOUBLE_RATE_FACTOR;
-
 	for (i = 0; i < clk_values; i++) {
 		if (!clk_buf)
-			curr_dr_freq = max_dr_freq;
+			curr_dr_freq = bus->params.max_dr_freq;
 		else
 			curr_dr_freq = (is_gear) ?
-				(max_dr_freq >>  clk_buf[i]) :
+				(bus->params.max_dr_freq >>  clk_buf[i]) :
 				clk_buf[i] * SDW_DOUBLE_RATE_FACTOR;
 
 		if (curr_dr_freq <= bus->params.bandwidth)
-- 
2.25.1

