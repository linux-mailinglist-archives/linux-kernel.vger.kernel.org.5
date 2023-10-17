Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568A77CC11D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 12:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343745AbjJQKy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 06:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbjJQKyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 06:54:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAE0EA;
        Tue, 17 Oct 2023 03:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697540062; x=1729076062;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OBDkjTVWbZs+PGvWObSQensGWSm4eGfY5pBdmo87lTk=;
  b=JsvIRCjzjw83g54Yub6sF751CbvnUfk8vkEjM2a0UqSx0nzMeMSqS4qP
   SZIp6TxVln77rgTjnBD3W8dl4N+D50o5jSzNP2DBhmW0a1swz+STrls/g
   PexzdrW0u1CsER4wX+i5yOLBb3PAMvTa23SvO9/O6Az1fR++QMKMJd/Hu
   QBxQDRnohvzp/khQ6CuZFP2ZeADwwNSAR4vNe77c81W7ke25+5xL7oUMC
   fPt6a2toIQuPNIAgKx2XHF+15jw3oT3oF4UgnFRh4WMQABgDfEMupznGv
   GPjjPtr9fSEcK+LlQzElol9gsZcAVmG+4d2KPJNCSUD1poBLbhawycQbi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="366012624"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="366012624"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 03:54:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="785445283"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="785445283"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga008.jf.intel.com with ESMTP; 17 Oct 2023 03:54:14 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
        by irvmail002.ir.intel.com (Postfix) with ESMTP id 2A551312D3;
        Tue, 17 Oct 2023 11:54:12 +0100 (IST)
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
Subject: [PATCH net-next v2 02/11] netdevsim: devlink health: use retained error fmsg API
Date:   Tue, 17 Oct 2023 12:53:32 +0200
Message-Id: <20231017105341.415466-3-przemyslaw.kitszel@intel.com>
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
add/remove: 2/2 grow/shrink: 0/2 up/down: 424/-705 (-281)
---
 drivers/net/netdevsim/health.c | 118 +++++++++------------------------
 1 file changed, 32 insertions(+), 86 deletions(-)

diff --git a/drivers/net/netdevsim/health.c b/drivers/net/netdevsim/health.c
index eb04ed715d2d..70e8bdf34be9 100644
--- a/drivers/net/netdevsim/health.c
+++ b/drivers/net/netdevsim/health.c
@@ -63,126 +63,72 @@ nsim_dev_dummy_reporter_recover(struct devlink_health_reporter *reporter,
 static int nsim_dev_dummy_fmsg_put(struct devlink_fmsg *fmsg, u32 binary_len)
 {
 	char *binary;
-	int err;
 	int i;
 
-	err = devlink_fmsg_bool_pair_put(fmsg, "test_bool", true);
-	if (err)
-		return err;
-	err = devlink_fmsg_u8_pair_put(fmsg, "test_u8", 1);
-	if (err)
-		return err;
-	err = devlink_fmsg_u32_pair_put(fmsg, "test_u32", 3);
-	if (err)
-		return err;
-	err = devlink_fmsg_u64_pair_put(fmsg, "test_u64", 4);
-	if (err)
-		return err;
-	err = devlink_fmsg_string_pair_put(fmsg, "test_string", "somestring");
-	if (err)
-		return err;
+	devlink_fmsg_bool_pair_put(fmsg, "test_bool", true);
+	devlink_fmsg_u8_pair_put(fmsg, "test_u8", 1);
+	devlink_fmsg_u32_pair_put(fmsg, "test_u32", 3);
+	devlink_fmsg_u64_pair_put(fmsg, "test_u64", 4);
+	devlink_fmsg_string_pair_put(fmsg, "test_string", "somestring");
 
 	binary = kmalloc(binary_len, GFP_KERNEL | __GFP_NOWARN);
 	if (!binary)
 		return -ENOMEM;
 	get_random_bytes(binary, binary_len);
-	err = devlink_fmsg_binary_pair_put(fmsg, "test_binary", binary, binary_len);
+	devlink_fmsg_binary_pair_put(fmsg, "test_binary", binary, binary_len);
 	kfree(binary);
-	if (err)
-		return err;
 
-	err = devlink_fmsg_pair_nest_start(fmsg, "test_nest");
-	if (err)
-		return err;
-	err = devlink_fmsg_obj_nest_start(fmsg);
-	if (err)
-		return err;
-	err = devlink_fmsg_bool_pair_put(fmsg, "nested_test_bool", false);
-	if (err)
-		return err;
-	err = devlink_fmsg_u8_pair_put(fmsg, "nested_test_u8", false);
-	if (err)
-		return err;
-	err = devlink_fmsg_obj_nest_end(fmsg);
-	if (err)
-		return err;
-	err = devlink_fmsg_pair_nest_end(fmsg);
-	if (err)
-		return err;
+	devlink_fmsg_pair_nest_start(fmsg, "test_nest");
+	devlink_fmsg_obj_nest_start(fmsg);
+	devlink_fmsg_bool_pair_put(fmsg, "nested_test_bool", false);
+	devlink_fmsg_u8_pair_put(fmsg, "nested_test_u8", false);
+	devlink_fmsg_obj_nest_end(fmsg);
+	devlink_fmsg_pair_nest_end(fmsg);
+	devlink_fmsg_arr_pair_nest_end(fmsg);
+	devlink_fmsg_arr_pair_nest_start(fmsg, "test_u32_array");
 
-	err = devlink_fmsg_arr_pair_nest_end(fmsg);
-	if (err)
-		return err;
+	for (i = 0; i < 10; i++)
+		devlink_fmsg_u32_put(fmsg, i);
+	devlink_fmsg_arr_pair_nest_end(fmsg);
+	devlink_fmsg_arr_pair_nest_start(fmsg, "test_array_of_objects");
 
-	err = devlink_fmsg_arr_pair_nest_start(fmsg, "test_u32_array");
-	if (err)
-		return err;
 	for (i = 0; i < 10; i++) {
-		err = devlink_fmsg_u32_put(fmsg, i);
-		if (err)
-			return err;
+		devlink_fmsg_obj_nest_start(fmsg);
+		devlink_fmsg_bool_pair_put(fmsg, "in_array_nested_test_bool",
+					   false);
+		devlink_fmsg_u8_pair_put(fmsg, "in_array_nested_test_u8", i);
+		devlink_fmsg_obj_nest_end(fmsg);
 	}
-	err = devlink_fmsg_arr_pair_nest_end(fmsg);
-	if (err)
-		return err;
+	devlink_fmsg_arr_pair_nest_end(fmsg);
 
-	err = devlink_fmsg_arr_pair_nest_start(fmsg, "test_array_of_objects");
-	if (err)
-		return err;
-	for (i = 0; i < 10; i++) {
-		err = devlink_fmsg_obj_nest_start(fmsg);
-		if (err)
-			return err;
-		err = devlink_fmsg_bool_pair_put(fmsg,
-						 "in_array_nested_test_bool",
-						 false);
-		if (err)
-			return err;
-		err = devlink_fmsg_u8_pair_put(fmsg,
-					       "in_array_nested_test_u8",
-					       i);
-		if (err)
-			return err;
-		err = devlink_fmsg_obj_nest_end(fmsg);
-		if (err)
-			return err;
-	}
-	return devlink_fmsg_arr_pair_nest_end(fmsg);
+	return 0;
 }
 
 static int
 nsim_dev_dummy_reporter_dump(struct devlink_health_reporter *reporter,
 			     struct devlink_fmsg *fmsg, void *priv_ctx,
 			     struct netlink_ext_ack *extack)
 {
 	struct nsim_dev_health *health = devlink_health_reporter_priv(reporter);
 	struct nsim_dev_dummy_reporter_ctx *ctx = priv_ctx;
-	int err;
 
-	if (ctx) {
-		err = devlink_fmsg_string_pair_put(fmsg, "break_message",
-						   ctx->break_msg);
-		if (err)
-			return err;
-	}
+	if (ctx)
+		devlink_fmsg_string_pair_put(fmsg, "break_message", ctx->break_msg);
+
 	return nsim_dev_dummy_fmsg_put(fmsg, health->binary_len);
 }
 
 static int
 nsim_dev_dummy_reporter_diagnose(struct devlink_health_reporter *reporter,
 				 struct devlink_fmsg *fmsg,
 				 struct netlink_ext_ack *extack)
 {
 	struct nsim_dev_health *health = devlink_health_reporter_priv(reporter);
-	int err;
 
-	if (health->recovered_break_msg) {
-		err = devlink_fmsg_string_pair_put(fmsg,
-						   "recovered_break_message",
-						   health->recovered_break_msg);
-		if (err)
-			return err;
-	}
+	if (health->recovered_break_msg)
+		devlink_fmsg_string_pair_put(fmsg, "recovered_break_message",
+					     health->recovered_break_msg);
+
 	return nsim_dev_dummy_fmsg_put(fmsg, health->binary_len);
 }
 
-- 
2.40.1

