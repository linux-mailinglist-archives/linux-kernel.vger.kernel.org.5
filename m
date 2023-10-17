Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9F57CC12D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 12:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343824AbjJQKys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 06:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343818AbjJQKyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 06:54:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE71121;
        Tue, 17 Oct 2023 03:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697540076; x=1729076076;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ebh5asCR9zczFsjdhVHECljj1NFu/TcL0Zk/T2NDBV8=;
  b=c7w6D+ZI+3Y/NnfEdblG3M8MnVXswRNibEBF+5JxgTkZJBocmZrPE5Jc
   Q5EBZjUpfZPZ17EIP5SCrSU55T8xI+O+g6JelOR7Ib4J2tUU5lGDd7Avc
   +yJRZcfu2rU7v3B9p4bnjZ75CqA58jbZvOl+5nga7Ktfj/3leYrPpjWMT
   kt18nNWLIOFMCsvekecfniokyO9La+169pZ6XQROvTMRB9ZvcshRKHDKi
   xt5UqJWwb7H5g/9KGtqqsiR+16e/jzH8Wg1RS9mOkTOz2Tp3S8Ds1ORg1
   3VQCvNUz525uCTt6AlUGDwrQq6iwX0szsoUi3PtKzZ9VcoM3T8LDI33fD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="366012704"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="366012704"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 03:54:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="785445342"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="785445342"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga008.jf.intel.com with ESMTP; 17 Oct 2023 03:54:27 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
        by irvmail002.ir.intel.com (Postfix) with ESMTP id 214C4312D3;
        Tue, 17 Oct 2023 11:54:25 +0100 (IST)
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
Subject: [PATCH net-next v2 07/11] mlxsw: core: devlink health: use retained error fmsg API
Date:   Tue, 17 Oct 2023 12:53:37 +0200
Message-Id: <20231017105341.415466-8-przemyslaw.kitszel@intel.com>
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
2.40.1

