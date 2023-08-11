Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA59677891F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 10:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbjHKIpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 04:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjHKIpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 04:45:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828E52738;
        Fri, 11 Aug 2023 01:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691743538; x=1723279538;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8vz5t52xNIp4mr/rEj23o9gWzLO26c4qJAjHt04rgXk=;
  b=akd/D3jYdetQfMiHUjpDpf7rt1iHV4U1YIErM6bgtm/ffhpBM1VQPQFZ
   GcqZymUCz6fD9vmumGflIhBBSW3TyaNUrCLNH3jYawCVTrBew/MKSX8/u
   GLQBNiE5p3qXdd1CAZ95+0986Bwu+7ie220t1vEMw4s41yPSfZ/sfMfOJ
   jWJQPh3AVdnIJr1qCpOwVMx4bUWaYmTdteNdsyM8HSP6lqjC3086sSZjd
   1gtFik98nTYiAcxcm3k4EGK4N2ntrhLnlEVl9Blhm7evQ+fji3AopNZAG
   BRBMwoSEcYfr2LYmamejxiQSddd5+86qAtAfpRTm92VRuGhu9jl0etrqf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="351234626"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="351234626"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 01:45:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="822594658"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="822594658"
Received: from llei-mobl1.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.254.214.187])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 01:45:35 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rafael.j.wysocki@intel.com
Cc:     daniel.lezcano@linaro.or, srinivas.pandruvada@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH] thermal: intel: intel_soc_dts_iosf: Fix thermal_zone removal
Date:   Fri, 11 Aug 2023 16:45:23 +0800
Message-Id: <20230811084523.1689671-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of the existing callers of remove_dts_thermal_zone() pass a valid
pointer as the argument, so checking for the NULL pointer is redundant.

Plus, when calling remove_dts_thermal_zone() from
intel_soc_dts_iosf_init(), it is possible that
1. dts->tzone is an error pointer, when the sensor fails to be
   registered as a valid thermal zone
2. dts->tzone is unregistered in add_dts_thermal_zone(), when some
   failure occurs after thermal zone registered
In both cases, there is no need to unregister dts->tzone in
remove_dts_thermal_zone().

Clear dst->tzone when add_dts_thermal_zone() fails. And do thermal zone
removal in remove_dts_thermal_zone() only when dts->tzone is set.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/intel/intel_soc_dts_iosf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_soc_dts_iosf.c b/drivers/thermal/intel/intel_soc_dts_iosf.c
index 7a66d0f077b0..c5203ba8f0b9 100644
--- a/drivers/thermal/intel/intel_soc_dts_iosf.c
+++ b/drivers/thermal/intel/intel_soc_dts_iosf.c
@@ -212,7 +212,7 @@ static int soc_dts_enable(int id)
 
 static void remove_dts_thermal_zone(struct intel_soc_dts_sensor_entry *dts)
 {
-	if (dts) {
+	if (dts->tzone) {
 		iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
 			       SOC_DTS_OFFSET_ENABLE, dts->store_status);
 		thermal_zone_device_unregister(dts->tzone);
@@ -277,6 +277,7 @@ static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts,
 err_enable:
 	thermal_zone_device_unregister(dts->tzone);
 err_ret:
+	dts->tzone = NULL;
 	return ret;
 }
 
-- 
2.34.1

