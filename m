Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970A67CC122
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 12:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343765AbjJQKy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 06:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234877AbjJQKy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 06:54:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05615B0;
        Tue, 17 Oct 2023 03:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697540065; x=1729076065;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JiFO0Fqm2ckPnb/YIHKHWKu6u2FkwmpZq9Xq6Dn3S5A=;
  b=Lf0ntuAs7ECGbWBUhUpOnCS16/9HwOlRpaNCOGYXm0hJbXiCw16sA7Wc
   C6LaZD0LpviGoqhbL5g9nzMhUbsLeVQ1jEdhYrp/bQ38Uv7Bz5twahP+O
   xBq7HY3Q8hbKTDW62AgNXM1j3x0NAsdoOpOVmxsLkNf4AQlljoBzFSsE4
   iSb0+VeRStcBWMm7BI3CUvYDInTvte4ku8e8p0r53Q76upW2eNGwaFGJk
   1p8EmS1t9H7Horxy0HeckTPPbSy9wKFmWfVJPHONMjio4UYTScw1yPBSz
   DElTvQ3x1o0bj3vNS6wUb2YvGG9B97V9yEp6B+rgXhiw+cjbaRloc9vCL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="366012640"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="366012640"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 03:54:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="785445297"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="785445297"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga008.jf.intel.com with ESMTP; 17 Oct 2023 03:54:17 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
        by irvmail002.ir.intel.com (Postfix) with ESMTP id 8B493312D4;
        Tue, 17 Oct 2023 11:54:14 +0100 (IST)
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
To:     Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        George Cherian <george.cherian@marvell.com>,
        Danielle Ratson <danieller@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Ariel Elior <aelior@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        Coiby Xu <coiby.xu@gmail.com>
Cc:     Brett Creeley <brett.creeley@amd.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Eran Ben Elisha <eranbe@nvidia.com>,
        Aya Levin <ayal@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [PATCH net-next v2 03/11] pds_core: devlink health: use retained error fmsg API
Date:   Tue, 17 Oct 2023 12:53:33 +0200
Message-Id: <20231017105341.415466-4-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231017105341.415466-1-przemyslaw.kitszel@intel.com>
References: <20231017105341.415466-1-przemyslaw.kitszel@intel.com>
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

Drop unneeded error checking.

devlink_fmsg_*() family of functions is now retaining errors,
so there is no need to check for them after each call.

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-57 (-57)
---
 drivers/net/ethernet/amd/pds_core/devlink.c | 29 ++++++---------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
index d9607033bbf2..8b2b9e0d59f3 100644
--- a/drivers/net/ethernet/amd/pds_core/devlink.c
+++ b/drivers/net/ethernet/amd/pds_core/devlink.c
@@ -154,33 +154,20 @@ int pdsc_fw_reporter_diagnose(struct devlink_health_reporter *reporter,
 			      struct netlink_ext_ack *extack)
 {
 	struct pdsc *pdsc = devlink_health_reporter_priv(reporter);
-	int err;
 
 	mutex_lock(&pdsc->config_lock);
-
 	if (test_bit(PDSC_S_FW_DEAD, &pdsc->state))
-		err = devlink_fmsg_string_pair_put(fmsg, "Status", "dead");
+		devlink_fmsg_string_pair_put(fmsg, "Status", "dead");
 	else if (!pdsc_is_fw_good(pdsc))
-		err = devlink_fmsg_string_pair_put(fmsg, "Status", "unhealthy");
+		devlink_fmsg_string_pair_put(fmsg, "Status", "unhealthy");
 	else
-		err = devlink_fmsg_string_pair_put(fmsg, "Status", "healthy");
-
+		devlink_fmsg_string_pair_put(fmsg, "Status", "healthy");
 	mutex_unlock(&pdsc->config_lock);
 
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "State",
-					pdsc->fw_status &
-						~PDS_CORE_FW_STS_F_GENERATION);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "Generation",
-					pdsc->fw_generation >> 4);
-	if (err)
-		return err;
+	devlink_fmsg_u32_pair_put(fmsg, "State",
+				  pdsc->fw_status & ~PDS_CORE_FW_STS_F_GENERATION);
+	devlink_fmsg_u32_pair_put(fmsg, "Generation", pdsc->fw_generation >> 4);
+	devlink_fmsg_u32_pair_put(fmsg, "Recoveries", pdsc->fw_recoveries);
 
-	return devlink_fmsg_u32_pair_put(fmsg, "Recoveries",
-					 pdsc->fw_recoveries);
+	return 0;
 }
-- 
2.40.1

