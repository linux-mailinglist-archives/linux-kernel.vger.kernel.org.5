Return-Path: <linux-kernel+bounces-85319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7039586B421
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C926128334B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272D915F32E;
	Wed, 28 Feb 2024 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lI0S+4B7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3D515E5DD;
	Wed, 28 Feb 2024 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136264; cv=none; b=WFDvYLIB9r8S4zsMOVV7nvAlBzq3VENk0HcqmJDFxQFajEwuquOcYW80O//WxDJbt3KOUjtZrWY/nyaMNzhZbF0MRinsB/Lwaj9UiymeBnXzbqTZihNc7wQYgChqh7/KhxdzaN+n0IVdcgcuQEAEr/ZouGe8F6V3FK8bQUwYIRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136264; c=relaxed/simple;
	bh=uZmeeZD3VWIvcaruww88Mst1ibscMXXKLJg4+styrpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNpEmRmPongRRYWcy4U7qbJQGsKp4vXuDrzJsezdsCQFpWN2LA+/Px3R4vtf/etkTnr8Ay8bOovoAG8dHxt0FuinSdLqKGY3jMw1B4Dkui3VRS5m1kztKiaWArOiJwJJ5ZmmjapCsV6XqQk4Qzjc6CnlVLeNUGtOwTVYbI20zdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lI0S+4B7; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709136262; x=1740672262;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uZmeeZD3VWIvcaruww88Mst1ibscMXXKLJg4+styrpY=;
  b=lI0S+4B7cxeuLuzbA68hlJ6rLR0LXZYOFQcjhBs6T76QVLTKbdKoIIcJ
   Ywc2LW8ymOHgwGAT56dNUki9XlViBxVWgB500Scy65Lk5NubMT2JPwWIb
   4DV2/wzaOPSs2D/y2I4BNhBRkSuI1CuKe9t0Z7pinvTCUKEAqTlM/qCD+
   suXQeSir30CzLnAKJyXQSlN9328205k74J/KD1H/wgUeBaKpOxahUA4ii
   0YQ0N3llMtoDjiwM5VGEa5IxFRq9YWxuPOBy+++ZfxjLjd1FGYplv03s6
   Xur3CsSQvfqBqajR4Sz/XXmFoz6b0xsRFkOLoAlAM9rxvLXBySMe/ldKo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3706623"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="3706623"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 08:04:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="7527778"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa009.jf.intel.com with ESMTP; 28 Feb 2024 08:04:14 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 0D7E536820;
	Wed, 28 Feb 2024 16:04:11 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mateusz Pacuszka <mateuszx.pacuszka@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Lukasz Plachno <lukasz.plachno@intel.com>,
	Jakub Buchocki <jakubx.buchocki@intel.com>,
	Pawel Kaminski <pawel.kaminski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [PATCH iwl-net 3/5] ice: Do not add LLDP-specific filter
Date: Wed, 28 Feb 2024 16:59:47 +0100
Message-ID: <20240228155957.408036-4-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228155957.408036-1-larysa.zaremba@intel.com>
References: <20240228155957.408036-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 34295a3696fbd0d90ee7 ("ice: implement new LLDP filter command")
has introduced the ability to use LLDP-specific filter that directs all
LLDP traffic to a single VSI. However, current goal is for all trusted VFs
to be able to see LLDP neighbors. Therefore, replace the functionality with
previously used generic ethernet protocol filter.

The command was added as a way to solve an "issue with some NVMs where an
already existent LLDP filter is blocking the creation of a filter to allow
LLDP packets". Preserve this utility and remove LLDP-specific filter
before configuring another one.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  1 -
 drivers/net/ethernet/intel/ice/ice_common.c   | 26 ---------------
 drivers/net/ethernet/intel/ice/ice_common.h   |  2 --
 drivers/net/ethernet/intel/ice/ice_lib.c      | 33 +++++++++++++++----
 4 files changed, 26 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 8040317c9561..2855c955d8b4 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1883,7 +1883,6 @@ struct ice_aqc_lldp_stop_start_specific_agent {
 /* LLDP Filter Control (direct 0x0A0A) */
 struct ice_aqc_lldp_filter_ctrl {
 	u8 cmd_flags;
-#define ICE_AQC_LLDP_FILTER_ACTION_ADD		0x0
 #define ICE_AQC_LLDP_FILTER_ACTION_DELETE	0x1
 	u8 reserved1;
 	__le16 vsi_num;
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 9266f25a9978..f5cca0e2ead6 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -5911,32 +5911,6 @@ bool ice_fw_supports_lldp_fltr_ctrl(struct ice_hw *hw)
 				     ICE_FW_API_LLDP_FLTR_PATCH);
 }
 
-/**
- * ice_lldp_fltr_add_remove - add or remove a LLDP Rx switch filter
- * @hw: pointer to HW struct
- * @vsi_num: absolute HW index for VSI
- * @add: boolean for if adding or removing a filter
- */
-int
-ice_lldp_fltr_add_remove(struct ice_hw *hw, u16 vsi_num, bool add)
-{
-	struct ice_aqc_lldp_filter_ctrl *cmd;
-	struct ice_aq_desc desc;
-
-	cmd = &desc.params.lldp_filter_ctrl;
-
-	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_lldp_filter_ctrl);
-
-	if (add)
-		cmd->cmd_flags = ICE_AQC_LLDP_FILTER_ACTION_ADD;
-	else
-		cmd->cmd_flags = ICE_AQC_LLDP_FILTER_ACTION_DELETE;
-
-	cmd->vsi_num = cpu_to_le16(vsi_num);
-
-	return ice_aq_send_cmd(hw, &desc, NULL, 0, NULL);
-}
-
 /**
  * ice_lldp_execute_pending_mib - execute LLDP pending MIB request
  * @hw: pointer to HW struct
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index 32fd10de620c..900926e6414c 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -267,8 +267,6 @@ int
 ice_aq_set_lldp_mib(struct ice_hw *hw, u8 mib_type, void *buf, u16 buf_size,
 		    struct ice_sq_cd *cd);
 bool ice_fw_supports_lldp_fltr_ctrl(struct ice_hw *hw);
-int
-ice_lldp_fltr_add_remove(struct ice_hw *hw, u16 vsi_num, bool add);
 int ice_lldp_execute_pending_mib(struct ice_hw *hw);
 int
 ice_aq_read_i2c(struct ice_hw *hw, struct ice_aqc_link_topo_addr topo_addr,
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 60e0d824195e..a774bcdcc0c4 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2039,6 +2039,27 @@ static void ice_vsi_set_tc_cfg(struct ice_vsi *vsi)
 	ice_vsi_set_dcb_tc_cfg(vsi);
 }
 
+/**
+ * ice_lldp_fltr_remove_from_port - Remove a LLDP Rx filter from the port
+ * @hw: port
+ *
+ * Remove a LLDP Rx switch filter from the port. For some NVMs,
+ * such leftover filter can prevent us from configuring another one.
+ */
+static void ice_lldp_fltr_remove_from_port(struct ice_hw *hw)
+{
+	struct ice_aqc_lldp_filter_ctrl *cmd;
+	struct ice_aq_desc desc;
+
+	cmd = &desc.params.lldp_filter_ctrl;
+
+	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_lldp_filter_ctrl);
+
+	cmd->cmd_flags = ICE_AQC_LLDP_FILTER_ACTION_DELETE;
+
+	ice_aq_send_cmd(hw, &desc, NULL, 0, NULL);
+}
+
 /**
  * ice_cfg_sw_lldp - Config switch rules for LLDP packet handling
  * @vsi: the VSI being configured
@@ -2060,13 +2081,11 @@ void ice_cfg_sw_lldp(struct ice_vsi *vsi, bool tx, bool create)
 		status = eth_fltr(vsi, ETH_P_LLDP, ICE_FLTR_TX,
 				  ICE_DROP_PACKET);
 	} else {
-		if (ice_fw_supports_lldp_fltr_ctrl(&pf->hw)) {
-			status = ice_lldp_fltr_add_remove(&pf->hw, vsi->vsi_num,
-							  create);
-		} else {
-			status = eth_fltr(vsi, ETH_P_LLDP, ICE_FLTR_RX,
-					  ICE_FWD_TO_VSI);
-		}
+		if (create && ice_fw_supports_lldp_fltr_ctrl(&pf->hw))
+			ice_lldp_fltr_remove_from_port(&vsi->back->hw);
+
+		status = eth_fltr(vsi, ETH_P_LLDP, ICE_FLTR_RX,
+				  ICE_FWD_TO_VSI);
 	}
 
 	if (status)
-- 
2.43.0


