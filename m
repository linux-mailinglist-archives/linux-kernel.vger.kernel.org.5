Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79CA37CE8DD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjJRU3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344608AbjJRU2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:28:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047AA181;
        Wed, 18 Oct 2023 13:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697660913; x=1729196913;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=41Cw0M5oWSuOe/byt5eX4fcv0uhH1yjV2sbnWcgT1iQ=;
  b=alXd+jUVz8lbLSi62cNi/x8Pb+wcWXmd0bTmB0UPPljTOUGbZlVeDkLs
   qfVvrY4AwdnFqzsFhrjhPd9IzFZantBM1p2FQK2RAnOJEd+ggL9NWIj2l
   jWszCyeBmxEFcccS0YKeKclzA0u7kNKX7a1C/udFQRJUy+553uBlwaBdP
   Adx01rmzwEv4q8v46Bb1kVUbHbw9q9BNnFZzdVQAoA6WdB30vUTm8BCRY
   FhllaYakrJEZcSISUwYf1JpzanaArkpbKTbnOpX8sHwUmomeVwv3k0ecB
   L7fLm3yVlpd6s1W1mLpbXTghszTW1wq+87KxA2JzV1q1Tc7JIjegXABuN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="371168140"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="371168140"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 13:28:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="756722410"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="756722410"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga002.jf.intel.com with ESMTP; 18 Oct 2023 13:28:23 -0700
Received: from pkitszel-desk.intel.com (unknown [10.255.194.180])
        by irvmail002.ir.intel.com (Postfix) with ESMTP id 8C3B033E8B;
        Wed, 18 Oct 2023 21:28:15 +0100 (IST)
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
        Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next v3 10/11] staging: qlge: devlink health: use retained error fmsg API
Date:   Wed, 18 Oct 2023 22:26:46 +0200
Message-Id: <20231018202647.44769-11-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231018202647.44769-1-przemyslaw.kitszel@intel.com>
References: <20231018202647.44769-1-przemyslaw.kitszel@intel.com>
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

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/staging/qlge/qlge_devlink.c | 60 ++++++++---------------------
 1 file changed, 16 insertions(+), 44 deletions(-)

diff --git a/drivers/staging/qlge/qlge_devlink.c b/drivers/staging/qlge/qlge_devlink.c
index 0ab02d6d3817..0b19363ca2e9 100644
--- a/drivers/staging/qlge/qlge_devlink.c
+++ b/drivers/staging/qlge/qlge_devlink.c
@@ -2,51 +2,29 @@
 #include "qlge.h"
 #include "qlge_devlink.h"
 
-static int qlge_fill_seg_(struct devlink_fmsg *fmsg,
-			  struct mpi_coredump_segment_header *seg_header,
-			  u32 *reg_data)
+static void qlge_fill_seg_(struct devlink_fmsg *fmsg,
+			   struct mpi_coredump_segment_header *seg_header,
+			   u32 *reg_data)
 {
 	int regs_num = (seg_header->seg_size
 			- sizeof(struct mpi_coredump_segment_header)) / sizeof(u32);
-	int err;
 	int i;
 
-	err = devlink_fmsg_pair_nest_start(fmsg, seg_header->description);
-	if (err)
-		return err;
-	err = devlink_fmsg_obj_nest_start(fmsg);
-	if (err)
-		return err;
-	err = devlink_fmsg_u32_pair_put(fmsg, "segment", seg_header->seg_num);
-	if (err)
-		return err;
-	err = devlink_fmsg_arr_pair_nest_start(fmsg, "values");
-	if (err)
-		return err;
+	devlink_fmsg_pair_nest_start(fmsg, seg_header->description);
+	devlink_fmsg_obj_nest_start(fmsg);
+	devlink_fmsg_u32_pair_put(fmsg, "segment", seg_header->seg_num);
+	devlink_fmsg_arr_pair_nest_start(fmsg, "values");
 	for (i = 0; i < regs_num; i++) {
-		err = devlink_fmsg_u32_put(fmsg, *reg_data);
-		if (err)
-			return err;
+		devlink_fmsg_u32_put(fmsg, *reg_data);
 		reg_data++;
 	}
-	err = devlink_fmsg_obj_nest_end(fmsg);
-	if (err)
-		return err;
-	err = devlink_fmsg_arr_pair_nest_end(fmsg);
-	if (err)
-		return err;
-	err = devlink_fmsg_pair_nest_end(fmsg);
-	return err;
+	devlink_fmsg_obj_nest_end(fmsg);
+	devlink_fmsg_arr_pair_nest_end(fmsg);
+	devlink_fmsg_pair_nest_end(fmsg);
 }
 
-#define FILL_SEG(seg_hdr, seg_regs)			                    \
-	do {                                                                \
-		err = qlge_fill_seg_(fmsg, &dump->seg_hdr, dump->seg_regs); \
-		if (err) {					            \
-			kvfree(dump);                                       \
-			return err;				            \
-		}                                                           \
-	} while (0)
+#define FILL_SEG(seg_hdr, seg_regs) \
+	qlge_fill_seg_(fmsg, &dump->seg_hdr, dump->seg_regs)
 
 static int qlge_reporter_coredump(struct devlink_health_reporter *reporter,
 				  struct devlink_fmsg *fmsg, void *priv_ctx,
@@ -114,14 +92,8 @@ static int qlge_reporter_coredump(struct devlink_health_reporter *reporter,
 	FILL_SEG(xfi_hss_tx_hdr, serdes_xfi_hss_tx);
 	FILL_SEG(xfi_hss_rx_hdr, serdes_xfi_hss_rx);
 	FILL_SEG(xfi_hss_pll_hdr, serdes_xfi_hss_pll);
-
-	err = qlge_fill_seg_(fmsg, &dump->misc_nic_seg_hdr,
-			     (u32 *)&dump->misc_nic_info);
-	if (err) {
-		kvfree(dump);
-		return err;
-	}
-
+	qlge_fill_seg_(fmsg, &dump->misc_nic_seg_hdr,
+		       (u32 *)&dump->misc_nic_info);
 	FILL_SEG(intr_states_seg_hdr, intr_states);
 	FILL_SEG(cam_entries_seg_hdr, cam_entries);
 	FILL_SEG(nic_routing_words_seg_hdr, nic_routing_words);
@@ -140,7 +112,7 @@ static int qlge_reporter_coredump(struct devlink_health_reporter *reporter,
 	FILL_SEG(sem_regs_seg_hdr, sem_regs);
 
 	kvfree(dump);
-	return err;
+	return 0;
 }
 
 static const struct devlink_health_reporter_ops qlge_reporter_ops = {
-- 
2.38.1

