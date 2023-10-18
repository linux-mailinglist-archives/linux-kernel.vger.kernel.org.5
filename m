Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8137CE8C3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjJRU14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjJRU1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:27:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C0FF7;
        Wed, 18 Oct 2023 13:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697660860; x=1729196860;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uBq0mn/KWsPThzvu8vYwD7SGaiak2SEULwdsVYDWNkE=;
  b=P5J2xF9mWbqUtNTW7KOh6Fuf+MiLyiMYzO4gb9k4biwP1lr4XcPrau4w
   JwMqSWz+cBJrO1uJOnDDXkNdPZZQxlyozEVNPM+4+Rf5rV05umb2G7WMk
   3UThViwXnf6/IXrq8JMQXieVa2WwXDoS6gY1bTr4UwSOn0oqu00n75wL8
   J9AETP1Q7hGBcedekD8Vw58R0IjKCDqBi4fojPR7qHs50WAeqaHVVuiRm
   GuMo8dVjQ6d1O2n4RcJiTmI9DdjdMHhnZhkApS6quJppZl0mD4i6dDXV9
   aJs/YJo/5L23sh99u1p9nesJlajBaVq6KC8a6XTMv7UiWIaNymCQs6/if
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="366352995"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="366352995"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 13:27:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="4691357"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa001.fm.intel.com with ESMTP; 18 Oct 2023 13:27:35 -0700
Received: from pkitszel-desk.intel.com (unknown [10.255.194.180])
        by irvmail002.ir.intel.com (Postfix) with ESMTP id 81E7E33E92;
        Wed, 18 Oct 2023 21:27:24 +0100 (IST)
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
        Coiby Xu <coiby.xu@gmail.com>, Simon Horman <horms@kernel.org>
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
        linux-kernel@vger.kernel.org, Benjamin Poirier <bpoirier@suse.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next v3 03/11] pds_core: devlink health: use retained error fmsg API
Date:   Wed, 18 Oct 2023 22:26:39 +0200
Message-Id: <20231018202647.44769-4-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231018202647.44769-1-przemyslaw.kitszel@intel.com>
References: <20231018202647.44769-1-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop unneeded error checking.

devlink_fmsg_*() family of functions is now retaining errors,
so there is no need to check for them after each call.

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
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
2.38.1

