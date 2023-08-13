Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB0677A4C3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 04:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjHMCwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 22:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjHMCwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 22:52:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFE9170A;
        Sat, 12 Aug 2023 19:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691895155; x=1723431155;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ayErGxhRHllzcsmwaeQTU9qCRuFG7WI+4RAgT9UUgu8=;
  b=fUODolnNdp2RRSymIvAVwGyAwYod0K7UOjKK4k4pLziCd6vliRl1EveH
   vMZX7SfNKmErGSRW3RYSMLhBS/sgbV1KN0wWHEhHELICxKGJNlM+c8luy
   I9KFUTYReutIEF1scPt4+NQfcu9zuBOppXC8QYJJpQ3aBQg/1OZeVbB+X
   /NF+4USC6x5AOZU68g+QIn+dtWlEfQW17DPIdRTTEOiWj+B+KXzIu4X8d
   z0V+wOuqs6EWFebNm4qzzEhrPCGtsabT932gtJ5ggSaHtCa6zXYcVY7Gd
   GVtkTBsmFiXBVhw/XvjXFN7f9izf3ZwfJSCKEk/jRjCpsXb9Fut0LjWkT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10800"; a="356823901"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="356823901"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2023 19:52:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10800"; a="762570867"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="762570867"
Received: from yingyuel-mobl.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.255.29.168])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2023 19:52:32 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rafael.j.wysocki@intel.com
Cc:     daniel.lezcano@linaro.or, srinivas.pandruvada@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH V2] thermal: intel: intel_soc_dts_iosf: Remove redundant check
Date:   Sun, 13 Aug 2023 10:52:20 +0800
Message-Id: <20230813025220.1752489-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the redundant check in remove_dts_thermal_zone() because all of
its existing callers pass a valid pointer as the argument.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/intel/intel_soc_dts_iosf.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/intel/intel_soc_dts_iosf.c b/drivers/thermal/intel/intel_soc_dts_iosf.c
index db97499f4f0a..22fc2970c67d 100644
--- a/drivers/thermal/intel/intel_soc_dts_iosf.c
+++ b/drivers/thermal/intel/intel_soc_dts_iosf.c
@@ -245,11 +245,9 @@ static int soc_dts_enable(int id)
 
 static void remove_dts_thermal_zone(struct intel_soc_dts_sensor_entry *dts)
 {
-	if (dts) {
-		iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
-			       SOC_DTS_OFFSET_ENABLE, dts->store_status);
-		thermal_zone_device_unregister(dts->tzone);
-	}
+	iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
+		       SOC_DTS_OFFSET_ENABLE, dts->store_status);
+	thermal_zone_device_unregister(dts->tzone);
 }
 
 static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts,
-- 
2.34.1

