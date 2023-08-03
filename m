Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9111A76E028
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 08:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjHCGZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 02:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbjHCGY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 02:24:58 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3F51724
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 23:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691043895; x=1722579895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W+Eg75sBaZEQWO5+zNepejl6stQbwCVziILn+2POhMQ=;
  b=IWsZMFcmSwwS/yoiI3VOdPbh3xyQRWA3JZ+E+6LnKDjZfrQTGJMnyh31
   CNAmaDSHRbbbH2Uwkci1JBPY1fLUGeNbnXJen/u/Ka6GkaBmXoycZR0sK
   mfNrUroFUcMWseSMvaePgEmMk3KXVl9VDTz2+jUype6MhVVLZieyB192r
   7wmKxpBH93RGFa6rQzFq/1+7oHgP7QshQxmkK8JYVL08SjiOwpD3ncuVf
   ZNLA1XEEEEKh9EGpuiNzMlK2Mk4Viak0L1x4V3ee/6Nna3HG5FKZTTNbh
   59SCrrOrSK3l2ctHpwJKeaRiDUEV88mRWaNmJSkEe2D+Uii9+ypwkqkMf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="350075275"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="350075275"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 23:24:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="1060117891"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="1060117891"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 23:23:59 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 1/2] soundwire: intel_auxdevice: enable pm_runtime earlier on startup
Date:   Thu,  3 Aug 2023 14:52:19 +0800
Message-Id: <20230803065220.3823269-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230803065220.3823269-1-yung-chuan.liao@linux.intel.com>
References: <20230803065220.3823269-1-yung-chuan.liao@linux.intel.com>
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

As soon as the bus starts, physical peripheral devices may report as
ATTACHED and set their status with pm_runtime_set_active() in their
update_status()/io_init().

This is problematic with the existing code, since the parent
pm_runtime status is changed to "active" after starting the bus. This
creates a time window where the pm_runtime framework can report an
issue, e.g.

"rt711 sdw:0:025d:0711:00: runtime PM trying to activate child device
sdw:0:025d:0711:00 but parent (sdw-master-0) is not active"

This patch enables runtime_pm earlier to make sure the auxiliary
device is pm_runtime active after powering-up, but before starting the
bus.

This problem was exposed by recent changes in the timing of the bus
reset, but was present in this driver since we introduced pm_runtime
support.

Closes: https://github.com/thesofproject/linux/issues/4328
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_auxdevice.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
index 0daa6ca9a224..f51c776eeeff 100644
--- a/drivers/soundwire/intel_auxdevice.c
+++ b/drivers/soundwire/intel_auxdevice.c
@@ -248,13 +248,6 @@ int intel_link_startup(struct auxiliary_device *auxdev)
 
 	sdw_intel_debugfs_init(sdw);
 
-	/* start bus */
-	ret = sdw_intel_start_bus(sdw);
-	if (ret) {
-		dev_err(dev, "bus start failed: %d\n", ret);
-		goto err_power_up;
-	}
-
 	/* Enable runtime PM */
 	if (!(link_flags & SDW_INTEL_MASTER_DISABLE_PM_RUNTIME)) {
 		pm_runtime_set_autosuspend_delay(dev,
@@ -266,6 +259,13 @@ int intel_link_startup(struct auxiliary_device *auxdev)
 		pm_runtime_enable(dev);
 	}
 
+	/* start bus */
+	ret = sdw_intel_start_bus(sdw);
+	if (ret) {
+		dev_err(dev, "bus start failed: %d\n", ret);
+		goto err_pm_runtime;
+	}
+
 	clock_stop_quirks = sdw->link_res->clock_stop_quirks;
 	if (clock_stop_quirks & SDW_INTEL_CLK_STOP_NOT_ALLOWED) {
 		/*
@@ -293,12 +293,17 @@ int intel_link_startup(struct auxiliary_device *auxdev)
 	 * with a delay. A more complete solution would require the
 	 * definition of Master properties.
 	 */
-	if (!(link_flags & SDW_INTEL_MASTER_DISABLE_PM_RUNTIME_IDLE))
+	if (!(link_flags & SDW_INTEL_MASTER_DISABLE_PM_RUNTIME_IDLE)) {
+		pm_runtime_mark_last_busy(dev);
 		pm_runtime_idle(dev);
+	}
 
 	sdw->startup_done = true;
 	return 0;
 
+err_pm_runtime:
+	if (!(link_flags & SDW_INTEL_MASTER_DISABLE_PM_RUNTIME))
+		pm_runtime_disable(dev);
 err_power_up:
 	sdw_intel_link_power_down(sdw);
 err_init:
-- 
2.25.1

