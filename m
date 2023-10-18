Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236387CE8D5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjJRU2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbjJRU2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:28:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D00CA4;
        Wed, 18 Oct 2023 13:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697660889; x=1729196889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UuuOxe1ayDWcBL4iJoYF1ljlKR4ova3kpskzCkH/pAA=;
  b=C3CEQu3qsQbw6TG1InNoVdWUlECs0jkD4pmg9MZxf7DEH1waqbz+5fQT
   qxh4aWRV0cRjRfxNrW3hxffRGz935zQQstlMigFd8ojvkIVV8RpBg2pvo
   zEhSaHNY6nXRjP8ZlBYF29ZJY4KK4F1vZYA9skCAom9G6+WQS5XIoxuqO
   ateF/inGWjPSPRhxcnrE1CVbMXOthHaGYI9F3/AWrC0PryH6NavlOxz4A
   Kzno2MzChdyf25qEckLmPHRj5DAnT+zbmFiKZDrB3QjbfllRoOBoPewvl
   vdlBSloZ7xY4YSzwEfnGkZKk55qGO03HdwoxQ3kPN5kXyNTxE4MswJ+k7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="389984353"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="389984353"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 13:28:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="1003937690"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="1003937690"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga006.fm.intel.com with ESMTP; 18 Oct 2023 13:27:59 -0700
Received: from pkitszel-desk.intel.com (unknown [10.255.194.180])
        by irvmail002.ir.intel.com (Postfix) with ESMTP id E7C7F33E9D;
        Wed, 18 Oct 2023 21:27:52 +0100 (IST)
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
Subject: [PATCH net-next v3 07/11] mlxsw: core: devlink health: use retained error fmsg API
Date:   Wed, 18 Oct 2023 22:26:43 +0200
Message-Id: <20231018202647.44769-8-przemyslaw.kitszel@intel.com>
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

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
add/remove: 0/8 grow/shrink: 0/3 up/down: 0/-694 (-694)
---
 drivers/net/ethernet/mellanox/mlxsw/core.c | 171 ++++++---------------
 1 file changed, 47 insertions(+), 124 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.c b/drivers/net/ethernet/mellanox/mlxsw/core.c
index 1ccf3b73ed72..6df0711607ac 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
@@ -1792,122 +1792,78 @@ static void mlxsw_core_health_listener_func(const struct mlxsw_reg_info *reg,
 static const struct mlxsw_listener mlxsw_core_health_listener =
 	MLXSW_CORE_EVENTL(mlxsw_core_health_listener_func, MFDE);
 
-static int
+static void
 mlxsw_core_health_fw_fatal_dump_fatal_cause(const char *mfde_pl,
 					    struct devlink_fmsg *fmsg)
 {
 	u32 val, tile_v;
-	int err;
 
 	val = mlxsw_reg_mfde_fatal_cause_id_get(mfde_pl);
-	err = devlink_fmsg_u32_pair_put(fmsg, "cause_id", val);
-	if (err)
-		return err;
+	devlink_fmsg_u32_pair_put(fmsg, "cause_id", val);
 	tile_v = mlxsw_reg_mfde_fatal_cause_tile_v_get(mfde_pl);
 	if (tile_v) {
 		val = mlxsw_reg_mfde_fatal_cause_tile_index_get(mfde_pl);
-		err = devlink_fmsg_u8_pair_put(fmsg, "tile_index", val);
-		if (err)
-			return err;
+		devlink_fmsg_u8_pair_put(fmsg, "tile_index", val);
 	}
-
-	return 0;
 }
 
-static int
+static void
 mlxsw_core_health_fw_fatal_dump_fw_assert(const char *mfde_pl,
 					  struct devlink_fmsg *fmsg)
 {
 	u32 val, tile_v;
-	int err;
 
 	val = mlxsw_reg_mfde_fw_assert_var0_get(mfde_pl);
-	err = devlink_fmsg_u32_pair_put(fmsg, "var0", val);
-	if (err)
-		return err;
+	devlink_fmsg_u32_pair_put(fmsg, "var0", val);
 	val = mlxsw_reg_mfde_fw_assert_var1_get(mfde_pl);
-	err = devlink_fmsg_u32_pair_put(fmsg, "var1", val);
-	if (err)
-		return err;
+	devlink_fmsg_u32_pair_put(fmsg, "var1", val);
 	val = mlxsw_reg_mfde_fw_assert_var2_get(mfde_pl);
-	err = devlink_fmsg_u32_pair_put(fmsg, "var2", val);
-	if (err)
-		return err;
+	devlink_fmsg_u32_pair_put(fmsg, "var2", val);
 	val = mlxsw_reg_mfde_fw_assert_var3_get(mfde_pl);
-	err = devlink_fmsg_u32_pair_put(fmsg, "var3", val);
-	if (err)
-		return err;
+	devlink_fmsg_u32_pair_put(fmsg, "var3", val);
 	val = mlxsw_reg_mfde_fw_assert_var4_get(mfde_pl);
-	err = devlink_fmsg_u32_pair_put(fmsg, "var4", val);
-	if (err)
-		return err;
+	devlink_fmsg_u32_pair_put(fmsg, "var4", val);
 	val = mlxsw_reg_mfde_fw_assert_existptr_get(mfde_pl);
-	err = devlink_fmsg_u32_pair_put(fmsg, "existptr", val);
-	if (err)
-		return err;
+	devlink_fmsg_u32_pair_put(fmsg, "existptr", val);
 	val = mlxsw_reg_mfde_fw_assert_callra_get(mfde_pl);
-	err = devlink_fmsg_u32_pair_put(fmsg, "callra", val);
-	if (err)
-		return err;
+	devlink_fmsg_u32_pair_put(fmsg, "callra", val);
 	val = mlxsw_reg_mfde_fw_assert_oe_get(mfde_pl);
-	err = devlink_fmsg_bool_pair_put(fmsg, "old_event", val);
-	if (err)
-		return err;
+	devlink_fmsg_bool_pair_put(fmsg, "old_event", val);
 	tile_v = mlxsw_reg_mfde_fw_assert_tile_v_get(mfde_pl);
 	if (tile_v) {
 		val = mlxsw_reg_mfde_fw_assert_tile_index_get(mfde_pl);
-		err = devlink_fmsg_u8_pair_put(fmsg, "tile_index", val);
-		if (err)
-			return err;
+		devlink_fmsg_u8_pair_put(fmsg, "tile_index", val);
 	}
 	val = mlxsw_reg_mfde_fw_assert_ext_synd_get(mfde_pl);
-	err = devlink_fmsg_u32_pair_put(fmsg, "ext_synd", val);
-	if (err)
-		return err;
-
-	return 0;
+	devlink_fmsg_u32_pair_put(fmsg, "ext_synd", val);
 }
 
-static int
+static void
 mlxsw_core_health_fw_fatal_dump_kvd_im_stop(const char *mfde_pl,
 					    struct devlink_fmsg *fmsg)
 {
 	u32 val;
-	int err;
 
 	val = mlxsw_reg_mfde_kvd_im_stop_oe_get(mfde_pl);
-	err = devlink_fmsg_bool_pair_put(fmsg, "old_event", val);
-	if (err)
-		return err;
+	devlink_fmsg_bool_pair_put(fmsg, "old_event", val);
 	val = mlxsw_reg_mfde_kvd_im_stop_pipes_mask_get(mfde_pl);
-	return devlink_fmsg_u32_pair_put(fmsg, "pipes_mask", val);
+	devlink_fmsg_u32_pair_put(fmsg, "pipes_mask", val);
 }
 
-static int
+static void
 mlxsw_core_health_fw_fatal_dump_crspace_to(const char *mfde_pl,
 					   struct devlink_fmsg *fmsg)
 {
 	u32 val;
-	int err;
 
 	val = mlxsw_reg_mfde_crspace_to_log_address_get(mfde_pl);
-	err = devlink_fmsg_u32_pair_put(fmsg, "log_address", val);
-	if (err)
-		return err;
+	devlink_fmsg_u32_pair_put(fmsg, "log_address", val);
 	val = mlxsw_reg_mfde_crspace_to_oe_get(mfde_pl);
-	err = devlink_fmsg_bool_pair_put(fmsg, "old_event", val);
-	if (err)
-		return err;
+	devlink_fmsg_bool_pair_put(fmsg, "old_event", val);
 	val = mlxsw_reg_mfde_crspace_to_log_id_get(mfde_pl);
-	err = devlink_fmsg_u8_pair_put(fmsg, "log_irisc_id", val);
-	if (err)
-		return err;
+	devlink_fmsg_u8_pair_put(fmsg, "log_irisc_id", val);
 	val = mlxsw_reg_mfde_crspace_to_log_ip_get(mfde_pl);
-	err = devlink_fmsg_u64_pair_put(fmsg, "log_ip", val);
-	if (err)
-		return err;
-
-	return 0;
+	devlink_fmsg_u64_pair_put(fmsg, "log_ip", val);
 }
 
 static int mlxsw_core_health_fw_fatal_dump(struct devlink_health_reporter *reporter,
@@ -1918,24 +1874,17 @@ static int mlxsw_core_health_fw_fatal_dump(struct devlink_health_reporter *repor
 	char *val_str;
 	u8 event_id;
 	u32 val;
-	int err;
 
 	if (!priv_ctx)
 		/* User-triggered dumps are not possible */
 		return -EOPNOTSUPP;
 
 	val = mlxsw_reg_mfde_irisc_id_get(mfde_pl);
-	err = devlink_fmsg_u8_pair_put(fmsg, "irisc_id", val);
-	if (err)
-		return err;
-	err = devlink_fmsg_arr_pair_nest_start(fmsg, "event");
-	if (err)
-		return err;
+	devlink_fmsg_u8_pair_put(fmsg, "irisc_id", val);
 
+	devlink_fmsg_arr_pair_nest_start(fmsg, "event");
 	event_id = mlxsw_reg_mfde_event_id_get(mfde_pl);
-	err = devlink_fmsg_u32_pair_put(fmsg, "id", event_id);
-	if (err)
-		return err;
+	devlink_fmsg_u32_pair_put(fmsg, "id", event_id);
 	switch (event_id) {
 	case MLXSW_REG_MFDE_EVENT_ID_CRSPACE_TO:
 		val_str = "CR space timeout";
@@ -1955,24 +1904,13 @@ static int mlxsw_core_health_fw_fatal_dump(struct devlink_health_reporter *repor
 	default:
 		val_str = NULL;
 	}
-	if (val_str) {
-		err = devlink_fmsg_string_pair_put(fmsg, "desc", val_str);
-		if (err)
-			return err;
-	}
-
-	err = devlink_fmsg_arr_pair_nest_end(fmsg);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_arr_pair_nest_start(fmsg, "severity");
-	if (err)
-		return err;
+	if (val_str)
+		devlink_fmsg_string_pair_put(fmsg, "desc", val_str);
+	devlink_fmsg_arr_pair_nest_end(fmsg);
 
+	devlink_fmsg_arr_pair_nest_start(fmsg, "severity");
 	val = mlxsw_reg_mfde_severity_get(mfde_pl);
-	err = devlink_fmsg_u8_pair_put(fmsg, "id", val);
-	if (err)
-		return err;
+	devlink_fmsg_u8_pair_put(fmsg, "id", val);
 	switch (val) {
 	case MLXSW_REG_MFDE_SEVERITY_FATL:
 		val_str = "Fatal";
@@ -1986,15 +1924,9 @@ static int mlxsw_core_health_fw_fatal_dump(struct devlink_health_reporter *repor
 	default:
 		val_str = NULL;
 	}
-	if (val_str) {
-		err = devlink_fmsg_string_pair_put(fmsg, "desc", val_str);
-		if (err)
-			return err;
-	}
-
-	err = devlink_fmsg_arr_pair_nest_end(fmsg);
-	if (err)
-		return err;
+	if (val_str)
+		devlink_fmsg_string_pair_put(fmsg, "desc", val_str);
+	devlink_fmsg_arr_pair_nest_end(fmsg);
 
 	val = mlxsw_reg_mfde_method_get(mfde_pl);
 	switch (val) {
@@ -2007,16 +1939,11 @@ static int mlxsw_core_health_fw_fatal_dump(struct devlink_health_reporter *repor
 	default:
 		val_str = NULL;
 	}
-	if (val_str) {
-		err = devlink_fmsg_string_pair_put(fmsg, "method", val_str);
-		if (err)
-			return err;
-	}
+	if (val_str)
+		devlink_fmsg_string_pair_put(fmsg, "method", val_str);
 
 	val = mlxsw_reg_mfde_long_process_get(mfde_pl);
-	err = devlink_fmsg_bool_pair_put(fmsg, "long_process", val);
-	if (err)
-		return err;
+	devlink_fmsg_bool_pair_put(fmsg, "long_process", val);
 
 	val = mlxsw_reg_mfde_command_type_get(mfde_pl);
 	switch (val) {
@@ -2032,29 +1959,25 @@ static int mlxsw_core_health_fw_fatal_dump(struct devlink_health_reporter *repor
 	default:
 		val_str = NULL;
 	}
-	if (val_str) {
-		err = devlink_fmsg_string_pair_put(fmsg, "command_type", val_str);
-		if (err)
-			return err;
-	}
+	if (val_str)
+		devlink_fmsg_string_pair_put(fmsg, "command_type", val_str);
 
 	val = mlxsw_reg_mfde_reg_attr_id_get(mfde_pl);
-	err = devlink_fmsg_u32_pair_put(fmsg, "reg_attr_id", val);
-	if (err)
-		return err;
+	devlink_fmsg_u32_pair_put(fmsg, "reg_attr_id", val);
 
 	switch (event_id) {
 	case MLXSW_REG_MFDE_EVENT_ID_CRSPACE_TO:
-		return mlxsw_core_health_fw_fatal_dump_crspace_to(mfde_pl,
-								  fmsg);
+		mlxsw_core_health_fw_fatal_dump_crspace_to(mfde_pl, fmsg);
+		break;
 	case MLXSW_REG_MFDE_EVENT_ID_KVD_IM_STOP:
-		return mlxsw_core_health_fw_fatal_dump_kvd_im_stop(mfde_pl,
-								   fmsg);
+		mlxsw_core_health_fw_fatal_dump_kvd_im_stop(mfde_pl, fmsg);
+		break;
 	case MLXSW_REG_MFDE_EVENT_ID_FW_ASSERT:
-		return mlxsw_core_health_fw_fatal_dump_fw_assert(mfde_pl, fmsg);
+		mlxsw_core_health_fw_fatal_dump_fw_assert(mfde_pl, fmsg);
+		break;
 	case MLXSW_REG_MFDE_EVENT_ID_FATAL_CAUSE:
-		return mlxsw_core_health_fw_fatal_dump_fatal_cause(mfde_pl,
-								   fmsg);
+		mlxsw_core_health_fw_fatal_dump_fatal_cause(mfde_pl, fmsg);
+		break;
 	}
 
 	return 0;
-- 
2.38.1

