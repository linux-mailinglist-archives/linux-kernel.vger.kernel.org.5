Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B77176E029
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 08:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbjHCGZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 02:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbjHCGZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 02:25:05 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CF630D2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 23:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691043903; x=1722579903;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vGIa0chkbTg20wwAn5D+PJYLJpAtUvruvhIslT2Po64=;
  b=FuVk6Fcz1N773jST5g9oa6AGJ4zuVIiCu2ydTwXkpnnZDWGN2J2cDrff
   /4kbN96UTf0Z+06LW8dU/d+Qc7aYuZamWnOxzVbreni6EUQO14opbzxgx
   elpw1d3Zpsz8WUs1SfHHXaAeWlSwGc8FDOdSzeX72w473FjnZJxAHO0Q9
   e6zN/T9WlPrru90AXvsGONBJoMOBjJZ4vMKBTwv0A3NGJavgDnetYXL+z
   rKvPTTLM/ZwP78o5nwY3iFv0kpIUKS1w23MK7WOiJpqx0EJ4Yhv4pAYE1
   OX0pllHEV6n30VaCKmzFzGts0Pz3mOYRxkaPWdVKQ5l8lo6qj5jxtb5jg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="350075340"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="350075340"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 23:24:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="1060117900"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="1060117900"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 23:24:00 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 2/2] soundWire: intel_auxdevice: resume 'sdw-master' on startup and system resume
Date:   Thu,  3 Aug 2023 14:52:20 +0800
Message-Id: <20230803065220.3823269-3-yung-chuan.liao@linux.intel.com>
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

The SoundWire bus is handled with a dedicated device, which is placed
between the Intel auxiliary device and peripheral devices, e.g.

soundwire_intel.link.0/sdw-master-0/sdw:0:025d:0711:01

The functionality of this 'sdw-master' device is limited, specifically
for pm_runtime the ASoC framework will not rely on
pm_runtime_get_sync() since it does not register any components. It
will only change status thanks to the parent-child relationship which
guarantees that the 'sdw-master' device will be pm_runtime resumed
before any peripheral device.

However on startup and system resume it's possible that only the
auxiliary device is pm_runtime active, and the peripheral will only
become active during its io_init routine, leading to another
occurrence of the error reported by the pm_runtime framework:

rt711 sdw:0:025d:0711:00: runtime PM trying to activate child device
sdw:0:025d:0711:00 but parent (sdw-master-0) is not active

This patch suggests aligning the sdw-master device status to that of
the auxiliary device. The difference between the two is completely
notional and their pm_status shouldn't be different during the startup
and system resume steps.

This problem was exposed by recent changes in the timing of the bus
reset, but was present in this driver since we introduced pm_runtime
support.

Closes: https://github.com/thesofproject/linux/issues/4328
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_auxdevice.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
index f51c776eeeff..91c86b46a5a1 100644
--- a/drivers/soundwire/intel_auxdevice.c
+++ b/drivers/soundwire/intel_auxdevice.c
@@ -257,6 +257,8 @@ int intel_link_startup(struct auxiliary_device *auxdev)
 
 		pm_runtime_set_active(dev);
 		pm_runtime_enable(dev);
+
+		pm_runtime_resume(bus->dev);
 	}
 
 	/* start bus */
@@ -294,6 +296,7 @@ int intel_link_startup(struct auxiliary_device *auxdev)
 	 * definition of Master properties.
 	 */
 	if (!(link_flags & SDW_INTEL_MASTER_DISABLE_PM_RUNTIME_IDLE)) {
+		pm_runtime_mark_last_busy(bus->dev);
 		pm_runtime_mark_last_busy(dev);
 		pm_runtime_idle(dev);
 	}
@@ -557,6 +560,8 @@ static int __maybe_unused intel_resume(struct device *dev)
 		pm_runtime_mark_last_busy(dev);
 		pm_runtime_enable(dev);
 
+		pm_runtime_resume(bus->dev);
+
 		link_flags = md_flags >> (bus->link_id * 8);
 
 		if (!(link_flags & SDW_INTEL_MASTER_DISABLE_PM_RUNTIME_IDLE))
@@ -592,6 +597,7 @@ static int __maybe_unused intel_resume(struct device *dev)
 	 * counters and delay the pm_runtime suspend by several
 	 * seconds, by when all enumeration should be complete.
 	 */
+	pm_runtime_mark_last_busy(bus->dev);
 	pm_runtime_mark_last_busy(dev);
 
 	return 0;
-- 
2.25.1

