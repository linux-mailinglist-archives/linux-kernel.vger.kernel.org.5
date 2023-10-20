Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0AE7D1662
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 21:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjJTTjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 15:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjJTTiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 15:38:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDC1D57
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 12:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697830680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=liS46vsUVMjr0UpLYLHHAI9LilS02tfCiv83DAZ55ec=;
        b=Jt+gDefgEwVDlG5wriAvY6IuHrpyLguNYLOLwtUvMuLHyRjidyH4UteH0x+d0/M0zrCaYz
        JEtXPN2f+2TpYVP0QRwlNFv/HqF/2SQoBwJ7xBPKMqCOJ1Y8rGL3Q8OsH4FUbsp/PEEPJg
        XkBzyk6qcupJ3Sr20Y0cgGvmn+nfufc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-477-e6VzbXuXNCy9rTgqhBO5Lw-1; Fri, 20 Oct 2023 15:37:55 -0400
X-MC-Unique: e6VzbXuXNCy9rTgqhBO5Lw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 310E988B76E;
        Fri, 20 Oct 2023 19:37:55 +0000 (UTC)
Received: from p1.luc.com (unknown [10.45.226.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB01AC15BB8;
        Fri, 20 Oct 2023 19:37:52 +0000 (UTC)
From:   Ivan Vecera <ivecera@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Jacob Keller <jacob.e.keller@intel.com>, mschmidt@redhat.com,
        dacampbe@redhat.com, poros@redhat.com,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH iwl-next 3/6] i40e: Use DECLARE_BITMAP for flags and hw_features fields in i40e_pf
Date:   Fri, 20 Oct 2023 21:37:39 +0200
Message-ID: <20231020193746.2274379-3-ivecera@redhat.com>
In-Reply-To: <20231020193746.2274379-1-ivecera@redhat.com>
References: <20231020193746.2274379-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert flags and hw_features fields from i40e_pf from u32 to
bitmaps and their usage to use bit access functions.

Changes:
- Convert "pf_ptr->(flags|hw_features) & FL" to "test_bit(FL, ...)"
- Convert "pf_ptr->(flags|hw_features) |= FL" to "set_bit(FL, ...)"
- Convert "pf_ptr->(flags|hw_features) &= ~FL" to "clear_bit(FL, ...)"
- Rename flag field to bitno in i40e_priv_flags and adjust ethtool
  callbacks to work with flags bitmap
- Rename flag names where '_ENABLED'->'_ENA' and '_DISABLED'->'_DIS'
  like in ice driver

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h        | 165 ++---
 drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c |  24 +-
 .../net/ethernet/intel/i40e/i40e_debugfs.c    |   4 +-
 .../net/ethernet/intel/i40e/i40e_ethtool.c    | 209 ++++---
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 587 +++++++++---------
 drivers/net/ethernet/intel/i40e/i40e_ptp.c    |  26 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  20 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   |   4 +-
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  20 +-
 9 files changed, 544 insertions(+), 515 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index b3cb79fb8791..8088e566123d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -33,11 +33,11 @@
 #define I40E_MIN_VSI_ALLOC		83 /* LAN, ATR, FCOE, 64 VF */
 /* max 16 qps */
 #define i40e_default_queues_per_vmdq(pf) \
-		(((pf)->hw_features & I40E_HW_RSS_AQ_CAPABLE) ? 4 : 1)
+	(test_bit(I40E_HW_RSS_AQ_CAPABLE, (pf)->hw_features) ? 4 : 1)
 #define I40E_DEFAULT_QUEUES_PER_VF	4
 #define I40E_MAX_VF_QUEUES		16
 #define i40e_pf_get_max_q_per_tc(pf) \
-		(((pf)->hw_features & I40E_HW_128_QP_RSS_CAPABLE) ? 128 : 64)
+	(test_bit(I40E_HW_128_QP_RSS_CAPABLE, (pf)->hw_features) ? 128 : 64)
 #define I40E_FDIR_RING_COUNT		32
 #define I40E_MAX_AQ_BUF_SIZE		4096
 #define I40E_AQ_LEN			256
@@ -138,6 +138,82 @@ enum i40e_vsi_state {
 	__I40E_VSI_STATE_SIZE__,
 };
 
+enum i40e_pf_hw_features {
+	I40E_HW_RSS_AQ_CAPABLE,
+	I40E_HW_128_QP_RSS_CAPABLE,
+	I40E_HW_ATR_EVICT_CAPABLE,
+	I40E_HW_WB_ON_ITR_CAPABLE,
+	I40E_HW_MULTIPLE_TCP_UDP_RSS_PCTYPE,
+	I40E_HW_NO_PCI_LINK_CHECK,
+	I40E_HW_100M_SGMII_CAPABLE,
+	I40E_HW_NO_DCB_SUPPORT,
+	I40E_HW_USE_SET_LLDP_MIB,
+	I40E_HW_GENEVE_OFFLOAD_CAPABLE,
+	I40E_HW_PTP_L4_CAPABLE,
+	I40E_HW_WOL_MC_MAGIC_PKT_WAKE,
+	I40E_HW_HAVE_CRT_RETIMER,
+	I40E_HW_OUTER_UDP_CSUM_CAPABLE,
+	I40E_HW_PHY_CONTROLS_LEDS,
+	I40E_HW_STOP_FW_LLDP,
+	I40E_HW_PORT_ID_VALID,
+	I40E_HW_RESTART_AUTONEG,
+	I40E_PF_HW_FEATURES_NBITS,	/* must be last */
+};
+
+enum i40e_pf_flags {
+	I40E_FLAG_MSI_ENA,
+	I40E_FLAG_MSIX_ENA,
+	I40E_FLAG_RSS_ENA,
+	I40E_FLAG_VMDQ_ENA,
+	I40E_FLAG_SRIOV_ENA,
+	I40E_FLAG_DCB_CAPABLE,
+	I40E_FLAG_DCB_ENA,
+	I40E_FLAG_FD_SB_ENA,
+	I40E_FLAG_FD_ATR_ENA,
+	I40E_FLAG_MFP_ENA,
+	I40E_FLAG_HW_ATR_EVICT_ENA,
+	I40E_FLAG_VEB_MODE_ENA,
+	I40E_FLAG_VEB_STATS_ENA,
+	I40E_FLAG_LINK_POLLING_ENA,
+	I40E_FLAG_TRUE_PROMISC_ENA,
+	I40E_FLAG_LEGACY_RX_ENA,
+	I40E_FLAG_PTP_ENA,
+	I40E_FLAG_IWARP_ENA,
+	I40E_FLAG_LINK_DOWN_ON_CLOSE_ENA,
+	I40E_FLAG_SOURCE_PRUNING_DIS,
+	I40E_FLAG_TC_MQPRIO_ENA,
+	I40E_FLAG_FD_SB_INACTIVE,
+	I40E_FLAG_FD_SB_TO_CLOUD_FILTER,
+	I40E_FLAG_FW_LLDP_DIS,
+	I40E_FLAG_RS_FEC,
+	I40E_FLAG_BASE_R_FEC,
+	/* TOTAL_PORT_SHUTDOWN_ENA
+	 * Allows to physically disable the link on the NIC's port.
+	 * If enabled, (after link down request from the OS)
+	 * no link, traffic or led activity is possible on that port.
+	 *
+	 * If I40E_FLAG_TOTAL_PORT_SHUTDOWN_ENA is set, the
+	 * I40E_FLAG_LINK_DOWN_ON_CLOSE_ENA must be explicitly forced
+	 * to true and cannot be disabled by system admin at that time.
+	 * The functionalities are exclusive in terms of configuration, but
+	 * they also have similar behavior (allowing to disable physical
+	 * link of the port), with following differences:
+	 * - LINK_DOWN_ON_CLOSE_ENA is configurable at host OS run-time and
+	 *   is supported by whole family of 7xx Intel Ethernet Controllers
+	 * - TOTAL_PORT_SHUTDOWN_ENA may be enabled only before OS loads
+	 *   (in BIOS) only if motherboard's BIOS and NIC's FW has support of it
+	 * - when LINK_DOWN_ON_CLOSE_ENABLED is used, the link is being brought
+	 *   down by sending phy_type=0 to NIC's FW
+	 * - when TOTAL_PORT_SHUTDOWN_ENA is used, phy_type is not altered,
+	 *   instead the link is being brought down by clearing
+	 *   bit (I40E_AQ_PHY_ENABLE_LINK) in abilities field of
+	 *   i40e_aq_set_phy_config structure
+	 */
+	I40E_FLAG_TOTAL_PORT_SHUTDOWN_ENA,
+	I40E_FLAG_VF_VLAN_PRUNING_ENA,
+	I40E_PF_FLAGS_NBITS,		/* must be last */
+};
+
 enum i40e_interrupt_policy {
 	I40E_INTERRUPT_BEST_CASE,
 	I40E_INTERRUPT_MEDIUM,
@@ -480,77 +556,8 @@ struct i40e_pf {
 	struct timer_list service_timer;
 	struct work_struct service_task;
 
-	u32 hw_features;
-#define I40E_HW_RSS_AQ_CAPABLE			BIT(0)
-#define I40E_HW_128_QP_RSS_CAPABLE		BIT(1)
-#define I40E_HW_ATR_EVICT_CAPABLE		BIT(2)
-#define I40E_HW_WB_ON_ITR_CAPABLE		BIT(3)
-#define I40E_HW_MULTIPLE_TCP_UDP_RSS_PCTYPE	BIT(4)
-#define I40E_HW_NO_PCI_LINK_CHECK		BIT(5)
-#define I40E_HW_100M_SGMII_CAPABLE		BIT(6)
-#define I40E_HW_NO_DCB_SUPPORT			BIT(7)
-#define I40E_HW_USE_SET_LLDP_MIB		BIT(8)
-#define I40E_HW_GENEVE_OFFLOAD_CAPABLE		BIT(9)
-#define I40E_HW_PTP_L4_CAPABLE			BIT(10)
-#define I40E_HW_WOL_MC_MAGIC_PKT_WAKE		BIT(11)
-#define I40E_HW_HAVE_CRT_RETIMER		BIT(13)
-#define I40E_HW_OUTER_UDP_CSUM_CAPABLE		BIT(14)
-#define I40E_HW_PHY_CONTROLS_LEDS		BIT(15)
-#define I40E_HW_STOP_FW_LLDP			BIT(16)
-#define I40E_HW_PORT_ID_VALID			BIT(17)
-#define I40E_HW_RESTART_AUTONEG			BIT(18)
-
-	u32 flags;
-#define I40E_FLAG_MSI_ENABLED			BIT(0)
-#define I40E_FLAG_MSIX_ENABLED			BIT(1)
-#define I40E_FLAG_RSS_ENABLED			BIT(2)
-#define I40E_FLAG_VMDQ_ENABLED			BIT(3)
-#define I40E_FLAG_SRIOV_ENABLED			BIT(4)
-#define I40E_FLAG_DCB_CAPABLE			BIT(5)
-#define I40E_FLAG_DCB_ENABLED			BIT(6)
-#define I40E_FLAG_FD_SB_ENABLED			BIT(7)
-#define I40E_FLAG_FD_ATR_ENABLED		BIT(8)
-#define I40E_FLAG_MFP_ENABLED			BIT(9)
-#define I40E_FLAG_HW_ATR_EVICT_ENABLED		BIT(10)
-#define I40E_FLAG_VEB_MODE_ENABLED		BIT(11)
-#define I40E_FLAG_VEB_STATS_ENABLED		BIT(12)
-#define I40E_FLAG_LINK_POLLING_ENABLED		BIT(13)
-#define I40E_FLAG_TRUE_PROMISC_SUPPORT		BIT(14)
-#define I40E_FLAG_LEGACY_RX			BIT(15)
-#define I40E_FLAG_PTP				BIT(16)
-#define I40E_FLAG_IWARP_ENABLED			BIT(17)
-#define I40E_FLAG_LINK_DOWN_ON_CLOSE_ENABLED	BIT(18)
-#define I40E_FLAG_SOURCE_PRUNING_DISABLED       BIT(19)
-#define I40E_FLAG_TC_MQPRIO			BIT(20)
-#define I40E_FLAG_FD_SB_INACTIVE		BIT(21)
-#define I40E_FLAG_FD_SB_TO_CLOUD_FILTER		BIT(22)
-#define I40E_FLAG_DISABLE_FW_LLDP		BIT(23)
-#define I40E_FLAG_RS_FEC			BIT(24)
-#define I40E_FLAG_BASE_R_FEC			BIT(25)
-/* TOTAL_PORT_SHUTDOWN
- * Allows to physically disable the link on the NIC's port.
- * If enabled, (after link down request from the OS)
- * no link, traffic or led activity is possible on that port.
- *
- * If I40E_FLAG_TOTAL_PORT_SHUTDOWN_ENABLED is set, the
- * I40E_FLAG_LINK_DOWN_ON_CLOSE_ENABLED must be explicitly forced to true
- * and cannot be disabled by system admin at that time.
- * The functionalities are exclusive in terms of configuration, but they also
- * have similar behavior (allowing to disable physical link of the port),
- * with following differences:
- * - LINK_DOWN_ON_CLOSE_ENABLED is configurable at host OS run-time and is
- *   supported by whole family of 7xx Intel Ethernet Controllers
- * - TOTAL_PORT_SHUTDOWN may be enabled only before OS loads (in BIOS)
- *   only if motherboard's BIOS and NIC's FW has support of it
- * - when LINK_DOWN_ON_CLOSE_ENABLED is used, the link is being brought down
- *   by sending phy_type=0 to NIC's FW
- * - when TOTAL_PORT_SHUTDOWN is used, phy_type is not altered, instead
- *   the link is being brought down by clearing bit (I40E_AQ_PHY_ENABLE_LINK)
- *   in abilities field of i40e_aq_set_phy_config structure
- */
-#define I40E_FLAG_TOTAL_PORT_SHUTDOWN_ENABLED	BIT(26)
-#define I40E_FLAG_VF_VLAN_PRUNING		BIT(27)
-
+	DECLARE_BITMAP(hw_features, I40E_PF_HW_FEATURES_NBITS);
+	DECLARE_BITMAP(flags, I40E_PF_FLAGS_NBITS);
 	struct i40e_client_instance *cinst;
 	bool stat_offsets_loaded;
 	struct i40e_hw_port_stats stats;
@@ -1271,7 +1278,7 @@ struct i40e_mac_filter *i40e_find_mac(struct i40e_vsi *vsi, const u8 *macaddr);
 void i40e_vlan_stripping_enable(struct i40e_vsi *vsi);
 static inline bool i40e_is_sw_dcb(struct i40e_pf *pf)
 {
-	return !!(pf->flags & I40E_FLAG_DISABLE_FW_LLDP);
+	return test_bit(I40E_FLAG_FW_LLDP_DIS, pf->flags);
 }
 
 #ifdef CONFIG_I40E_DCB
@@ -1305,7 +1312,7 @@ int i40e_set_partition_bw_setting(struct i40e_pf *pf);
 int i40e_commit_partition_bw_setting(struct i40e_pf *pf);
 void i40e_print_link_message(struct i40e_vsi *vsi, bool isup);
 
-void i40e_set_fec_in_flags(u8 fec_cfg, u32 *flags);
+void i40e_set_fec_in_flags(u8 fec_cfg, unsigned long *flags);
 
 static inline bool i40e_enabled_xdp_vsi(struct i40e_vsi *vsi)
 {
@@ -1325,13 +1332,13 @@ int i40e_add_del_cloud_filter_big_buf(struct i40e_vsi *vsi,
  * i40e_is_tc_mqprio_enabled - check if TC MQPRIO is enabled on PF
  * @pf: pointer to a pf.
  *
- * Check and return value of flag I40E_FLAG_TC_MQPRIO.
+ * Check and return state of flag I40E_FLAG_TC_MQPRIO.
  *
- * Return: I40E_FLAG_TC_MQPRIO set state.
+ * Return: true/false if I40E_FLAG_TC_MQPRIO is set or not
  **/
-static inline u32 i40e_is_tc_mqprio_enabled(struct i40e_pf *pf)
+static inline bool i40e_is_tc_mqprio_enabled(struct i40e_pf *pf)
 {
-	return pf->flags & I40E_FLAG_TC_MQPRIO;
+	return test_bit(I40E_FLAG_TC_MQPRIO_ENA, pf->flags);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c b/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
index 077a95dad32c..1ee77a2433c0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
@@ -310,8 +310,8 @@ static u8 i40e_dcbnl_getstate(struct net_device *netdev)
 	struct i40e_pf *pf = i40e_netdev_to_pf(netdev);
 
 	dev_dbg(&pf->pdev->dev, "DCB state=%d\n",
-		!!(pf->flags & I40E_FLAG_DCB_ENABLED));
-	return !!(pf->flags & I40E_FLAG_DCB_ENABLED);
+		test_bit(I40E_FLAG_DCB_ENA, pf->flags) ? 1 : 0);
+	return test_bit(I40E_FLAG_DCB_ENA, pf->flags) ? 1 : 0;
 }
 
 /**
@@ -331,19 +331,19 @@ static u8 i40e_dcbnl_setstate(struct net_device *netdev, u8 state)
 		return ret;
 
 	dev_dbg(&pf->pdev->dev, "new state=%d current state=%d\n",
-		state, (pf->flags & I40E_FLAG_DCB_ENABLED) ? 1 : 0);
+		state, test_bit(I40E_FLAG_DCB_ENA, pf->flags) ? 1 : 0);
 	/* Nothing to do */
-	if (!state == !(pf->flags & I40E_FLAG_DCB_ENABLED))
+	if (!state == !test_bit(I40E_FLAG_DCB_ENA, pf->flags))
 		return ret;
 
 	if (i40e_is_sw_dcb(pf)) {
 		if (state) {
-			pf->flags |= I40E_FLAG_DCB_ENABLED;
+			set_bit(I40E_FLAG_DCB_ENA, pf->flags);
 			memcpy(&pf->hw.desired_dcbx_config,
 			       &pf->hw.local_dcbx_config,
 			       sizeof(struct i40e_dcbx_config));
 		} else {
-			pf->flags &= ~I40E_FLAG_DCB_ENABLED;
+			clear_bit(I40E_FLAG_DCB_ENA, pf->flags);
 		}
 	} else {
 		/* Cannot directly manipulate FW LLDP Agent */
@@ -653,7 +653,7 @@ static u8 i40e_dcbnl_get_cap(struct net_device *netdev, int capid, u8 *cap)
 {
 	struct i40e_pf *pf = i40e_netdev_to_pf(netdev);
 
-	if (!(pf->flags & I40E_FLAG_DCB_CAPABLE))
+	if (!test_bit(I40E_FLAG_DCB_CAPABLE, pf->flags))
 		return I40E_DCBNL_STATUS_ERROR;
 
 	switch (capid) {
@@ -693,7 +693,7 @@ static int i40e_dcbnl_getnumtcs(struct net_device *netdev, int tcid, u8 *num)
 {
 	struct i40e_pf *pf = i40e_netdev_to_pf(netdev);
 
-	if (!(pf->flags & I40E_FLAG_DCB_CAPABLE))
+	if (!test_bit(I40E_FLAG_DCB_CAPABLE, pf->flags))
 		return -EINVAL;
 
 	*num = I40E_MAX_TRAFFIC_CLASS;
@@ -891,11 +891,11 @@ void i40e_dcbnl_set_all(struct i40e_vsi *vsi)
 		return;
 
 	/* DCB not enabled */
-	if (!(pf->flags & I40E_FLAG_DCB_ENABLED))
+	if (!test_bit(I40E_FLAG_DCB_ENA, pf->flags))
 		return;
 
 	/* MFP mode but not an iSCSI PF so return */
-	if ((pf->flags & I40E_FLAG_MFP_ENABLED) && !(hw->func_caps.iscsi))
+	if (test_bit(I40E_FLAG_MFP_ENA, pf->flags) && !(hw->func_caps.iscsi))
 		return;
 
 	dcbxcfg = &hw->local_dcbx_config;
@@ -1002,7 +1002,7 @@ void i40e_dcbnl_flush_apps(struct i40e_pf *pf,
 	int i;
 
 	/* MFP mode but not an iSCSI PF so return */
-	if ((pf->flags & I40E_FLAG_MFP_ENABLED) && !(pf->hw.func_caps.iscsi))
+	if (test_bit(I40E_FLAG_MFP_ENA, pf->flags) && !(pf->hw.func_caps.iscsi))
 		return;
 
 	for (i = 0; i < old_cfg->numapps; i++) {
@@ -1025,7 +1025,7 @@ void i40e_dcbnl_setup(struct i40e_vsi *vsi)
 	struct i40e_pf *pf = i40e_netdev_to_pf(dev);
 
 	/* Not DCB capable */
-	if (!(pf->flags & I40E_FLAG_DCB_CAPABLE))
+	if (!test_bit(I40E_FLAG_DCB_CAPABLE, pf->flags))
 		return;
 
 	dev->dcbnl_ops = &dcbnl_ops;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 999c9708def5..e0849f0c9c27 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -820,8 +820,8 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 		/* By default we are in VEPA mode, if this is the first VF/VMDq
 		 * VSI to be added switch to VEB mode.
 		 */
-		if (!(pf->flags & I40E_FLAG_VEB_MODE_ENABLED)) {
-			pf->flags |= I40E_FLAG_VEB_MODE_ENABLED;
+		if (!test_bit(I40E_FLAG_VEB_MODE_ENA, pf->flags)) {
+			set_bit(I40E_FLAG_VEB_MODE_ENA, pf->flags);
 			i40e_do_reset_safe(pf, I40E_PF_RESET_FLAG);
 		}
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 43ab47f38510..ed47a7f14122 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -432,35 +432,35 @@ static const char i40e_gstrings_test[][ETH_GSTRING_LEN] = {
 
 struct i40e_priv_flags {
 	char flag_string[ETH_GSTRING_LEN];
-	u64 flag;
+	u8 bitno;
 	bool read_only;
 };
 
-#define I40E_PRIV_FLAG(_name, _flag, _read_only) { \
+#define I40E_PRIV_FLAG(_name, _bitno, _read_only) { \
 	.flag_string = _name, \
-	.flag = _flag, \
+	.bitno = _bitno, \
 	.read_only = _read_only, \
 }
 
 static const struct i40e_priv_flags i40e_gstrings_priv_flags[] = {
 	/* NOTE: MFP setting cannot be changed */
-	I40E_PRIV_FLAG("MFP", I40E_FLAG_MFP_ENABLED, 1),
+	I40E_PRIV_FLAG("MFP", I40E_FLAG_MFP_ENA, 1),
 	I40E_PRIV_FLAG("total-port-shutdown",
-		       I40E_FLAG_TOTAL_PORT_SHUTDOWN_ENABLED, 1),
-	I40E_PRIV_FLAG("LinkPolling", I40E_FLAG_LINK_POLLING_ENABLED, 0),
-	I40E_PRIV_FLAG("flow-director-atr", I40E_FLAG_FD_ATR_ENABLED, 0),
-	I40E_PRIV_FLAG("veb-stats", I40E_FLAG_VEB_STATS_ENABLED, 0),
-	I40E_PRIV_FLAG("hw-atr-eviction", I40E_FLAG_HW_ATR_EVICT_ENABLED, 0),
+		       I40E_FLAG_TOTAL_PORT_SHUTDOWN_ENA, 1),
+	I40E_PRIV_FLAG("LinkPolling", I40E_FLAG_LINK_POLLING_ENA, 0),
+	I40E_PRIV_FLAG("flow-director-atr", I40E_FLAG_FD_ATR_ENA, 0),
+	I40E_PRIV_FLAG("veb-stats", I40E_FLAG_VEB_STATS_ENA, 0),
+	I40E_PRIV_FLAG("hw-atr-eviction", I40E_FLAG_HW_ATR_EVICT_ENA, 0),
 	I40E_PRIV_FLAG("link-down-on-close",
-		       I40E_FLAG_LINK_DOWN_ON_CLOSE_ENABLED, 0),
-	I40E_PRIV_FLAG("legacy-rx", I40E_FLAG_LEGACY_RX, 0),
+		       I40E_FLAG_LINK_DOWN_ON_CLOSE_ENA, 0),
+	I40E_PRIV_FLAG("legacy-rx", I40E_FLAG_LEGACY_RX_ENA, 0),
 	I40E_PRIV_FLAG("disable-source-pruning",
-		       I40E_FLAG_SOURCE_PRUNING_DISABLED, 0),
-	I40E_PRIV_FLAG("disable-fw-lldp", I40E_FLAG_DISABLE_FW_LLDP, 0),
+		       I40E_FLAG_SOURCE_PRUNING_DIS, 0),
+	I40E_PRIV_FLAG("disable-fw-lldp", I40E_FLAG_FW_LLDP_DIS, 0),
 	I40E_PRIV_FLAG("rs-fec", I40E_FLAG_RS_FEC, 0),
 	I40E_PRIV_FLAG("base-r-fec", I40E_FLAG_BASE_R_FEC, 0),
 	I40E_PRIV_FLAG("vf-vlan-pruning",
-		       I40E_FLAG_VF_VLAN_PRUNING, 0),
+		       I40E_FLAG_VF_VLAN_PRUNING_ENA, 0),
 };
 
 #define I40E_PRIV_FLAGS_STR_LEN ARRAY_SIZE(i40e_gstrings_priv_flags)
@@ -468,7 +468,7 @@ static const struct i40e_priv_flags i40e_gstrings_priv_flags[] = {
 /* Private flags with a global effect, restricted to PF 0 */
 static const struct i40e_priv_flags i40e_gl_gstrings_priv_flags[] = {
 	I40E_PRIV_FLAG("vf-true-promisc-support",
-		       I40E_FLAG_TRUE_PROMISC_SUPPORT, 0),
+		       I40E_FLAG_TRUE_PROMISC_ENA, 0),
 };
 
 #define I40E_GL_PRIV_FLAGS_STR_LEN ARRAY_SIZE(i40e_gl_gstrings_priv_flags)
@@ -504,7 +504,7 @@ static void i40e_phy_type_to_ethtool(struct i40e_pf *pf,
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_1GB)
 			ethtool_link_ksettings_add_link_mode(ks, advertising,
 							     1000baseT_Full);
-		if (pf->hw_features & I40E_HW_100M_SGMII_CAPABLE) {
+		if (test_bit(I40E_HW_100M_SGMII_CAPABLE, pf->hw_features)) {
 			ethtool_link_ksettings_add_link_mode(ks, supported,
 							     100baseT_Full);
 			ethtool_link_ksettings_add_link_mode(ks, advertising,
@@ -603,7 +603,7 @@ static void i40e_phy_type_to_ethtool(struct i40e_pf *pf,
 							     10000baseKX4_Full);
 	}
 	if (phy_types & I40E_CAP_PHY_TYPE_10GBASE_KR &&
-	    !(pf->hw_features & I40E_HW_HAVE_CRT_RETIMER)) {
+	    !test_bit(I40E_HW_HAVE_CRT_RETIMER, pf->hw_features)) {
 		ethtool_link_ksettings_add_link_mode(ks, supported,
 						     10000baseKR_Full);
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_10GB)
@@ -611,7 +611,7 @@ static void i40e_phy_type_to_ethtool(struct i40e_pf *pf,
 							     10000baseKR_Full);
 	}
 	if (phy_types & I40E_CAP_PHY_TYPE_1000BASE_KX &&
-	    !(pf->hw_features & I40E_HW_HAVE_CRT_RETIMER)) {
+	    !test_bit(I40E_HW_HAVE_CRT_RETIMER, pf->hw_features)) {
 		ethtool_link_ksettings_add_link_mode(ks, supported,
 						     1000baseKX_Full);
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_1GB)
@@ -919,7 +919,7 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_1GB)
 			ethtool_link_ksettings_add_link_mode(ks, advertising,
 							     1000baseT_Full);
-		if (pf->hw_features & I40E_HW_100M_SGMII_CAPABLE) {
+		if (test_bit(I40E_HW_100M_SGMII_CAPABLE, pf->hw_features)) {
 			ethtool_link_ksettings_add_link_mode(ks, supported,
 							     100baseT_Full);
 			if (hw_link_info->requested_speeds &
@@ -1490,12 +1490,8 @@ static int i40e_set_fec_cfg(struct net_device *netdev, u8 fec_cfg)
 	struct i40e_pf *pf = np->vsi->back;
 	struct i40e_hw *hw = &pf->hw;
 	int status = 0;
-	u32 flags = 0;
 	int err = 0;
 
-	flags = READ_ONCE(pf->flags);
-	i40e_set_fec_in_flags(fec_cfg, &flags);
-
 	/* Get the current phy config */
 	memset(&abilities, 0, sizeof(abilities));
 	status = i40e_aq_get_phy_capabilities(hw, false, false, &abilities,
@@ -1527,7 +1523,7 @@ static int i40e_set_fec_cfg(struct net_device *netdev, u8 fec_cfg)
 			err = -EAGAIN;
 			goto done;
 		}
-		pf->flags = flags;
+		i40e_set_fec_in_flags(fec_cfg, pf->flags);
 		status = i40e_update_link_info(hw);
 		if (status)
 			/* debug level message only due to relation to the link
@@ -2432,7 +2428,7 @@ static void i40e_get_ethtool_stats(struct net_device *netdev,
 
 	veb_stats = ((pf->lan_veb != I40E_NO_VEB) &&
 		     (pf->lan_veb < I40E_MAX_VEB) &&
-		     (pf->flags & I40E_FLAG_VEB_STATS_ENABLED));
+		     test_bit(I40E_FLAG_VEB_STATS_ENA, pf->flags));
 
 	if (veb_stats) {
 		veb = pf->veb[pf->lan_veb];
@@ -2561,7 +2557,7 @@ static int i40e_get_ts_info(struct net_device *dev,
 	struct i40e_pf *pf = i40e_netdev_to_pf(dev);
 
 	/* only report HW timestamping if PTP is enabled */
-	if (!(pf->flags & I40E_FLAG_PTP))
+	if (!test_bit(I40E_FLAG_PTP_ENA, pf->flags))
 		return ethtool_op_get_ts_info(dev, info);
 
 	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
@@ -2583,7 +2579,7 @@ static int i40e_get_ts_info(struct net_device *dev,
 			   BIT(HWTSTAMP_FILTER_PTP_V2_L2_SYNC) |
 			   BIT(HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ);
 
-	if (pf->hw_features & I40E_HW_PTP_L4_CAPABLE)
+	if (test_bit(I40E_HW_PTP_L4_CAPABLE, pf->hw_features))
 		info->rx_filters |= BIT(HWTSTAMP_FILTER_PTP_V1_L4_SYNC) |
 				    BIT(HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ) |
 				    BIT(HWTSTAMP_FILTER_PTP_V2_EVENT) |
@@ -2832,7 +2828,7 @@ static int i40e_set_phys_id(struct net_device *netdev,
 
 	switch (state) {
 	case ETHTOOL_ID_ACTIVE:
-		if (!(pf->hw_features & I40E_HW_PHY_CONTROLS_LEDS)) {
+		if (!test_bit(I40E_HW_PHY_CONTROLS_LEDS, pf->hw_features)) {
 			pf->led_status = i40e_led_get(hw);
 		} else {
 			if (!(hw->flags & I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE))
@@ -2844,19 +2840,19 @@ static int i40e_set_phys_id(struct net_device *netdev,
 		}
 		return blink_freq;
 	case ETHTOOL_ID_ON:
-		if (!(pf->hw_features & I40E_HW_PHY_CONTROLS_LEDS))
+		if (!test_bit(I40E_HW_PHY_CONTROLS_LEDS, pf->hw_features))
 			i40e_led_set(hw, 0xf, false);
 		else
 			ret = i40e_led_set_phy(hw, true, pf->led_status, 0);
 		break;
 	case ETHTOOL_ID_OFF:
-		if (!(pf->hw_features & I40E_HW_PHY_CONTROLS_LEDS))
+		if (!test_bit(I40E_HW_PHY_CONTROLS_LEDS, pf->hw_features))
 			i40e_led_set(hw, 0x0, false);
 		else
 			ret = i40e_led_set_phy(hw, false, pf->led_status, 0);
 		break;
 	case ETHTOOL_ID_INACTIVE:
-		if (!(pf->hw_features & I40E_HW_PHY_CONTROLS_LEDS)) {
+		if (!test_bit(I40E_HW_PHY_CONTROLS_LEDS, pf->hw_features)) {
 			i40e_led_set(hw, pf->led_status, false);
 		} else {
 			ret = i40e_led_set_phy(hw, false, pf->led_status,
@@ -3641,7 +3637,7 @@ static int i40e_set_rss_hash_opt(struct i40e_pf *pf, struct ethtool_rxnfc *nfc)
 
 	bitmap_zero(flow_pctypes, FLOW_PCTYPES_SIZE);
 
-	if (pf->flags & I40E_FLAG_MFP_ENABLED) {
+	if (test_bit(I40E_FLAG_MFP_ENA, pf->flags)) {
 		dev_err(&pf->pdev->dev,
 			"Change of RSS hash input set is not supported when MFP mode is enabled\n");
 		return -EOPNOTSUPP;
@@ -3657,19 +3653,22 @@ static int i40e_set_rss_hash_opt(struct i40e_pf *pf, struct ethtool_rxnfc *nfc)
 	switch (nfc->flow_type) {
 	case TCP_V4_FLOW:
 		set_bit(I40E_FILTER_PCTYPE_NONF_IPV4_TCP, flow_pctypes);
-		if (pf->hw_features & I40E_HW_MULTIPLE_TCP_UDP_RSS_PCTYPE)
+		if (test_bit(I40E_HW_MULTIPLE_TCP_UDP_RSS_PCTYPE,
+			     pf->hw_features))
 			set_bit(I40E_FILTER_PCTYPE_NONF_IPV4_TCP_SYN_NO_ACK,
 				flow_pctypes);
 		break;
 	case TCP_V6_FLOW:
 		set_bit(I40E_FILTER_PCTYPE_NONF_IPV6_TCP, flow_pctypes);
-		if (pf->hw_features & I40E_HW_MULTIPLE_TCP_UDP_RSS_PCTYPE)
+		if (test_bit(I40E_HW_MULTIPLE_TCP_UDP_RSS_PCTYPE,
+			     pf->hw_features))
 			set_bit(I40E_FILTER_PCTYPE_NONF_IPV6_TCP_SYN_NO_ACK,
 				flow_pctypes);
 		break;
 	case UDP_V4_FLOW:
 		set_bit(I40E_FILTER_PCTYPE_NONF_IPV4_UDP, flow_pctypes);
-		if (pf->hw_features & I40E_HW_MULTIPLE_TCP_UDP_RSS_PCTYPE) {
+		if (test_bit(I40E_HW_MULTIPLE_TCP_UDP_RSS_PCTYPE,
+			     pf->hw_features)) {
 			set_bit(I40E_FILTER_PCTYPE_NONF_UNICAST_IPV4_UDP,
 				flow_pctypes);
 			set_bit(I40E_FILTER_PCTYPE_NONF_MULTICAST_IPV4_UDP,
@@ -3679,7 +3678,8 @@ static int i40e_set_rss_hash_opt(struct i40e_pf *pf, struct ethtool_rxnfc *nfc)
 		break;
 	case UDP_V6_FLOW:
 		set_bit(I40E_FILTER_PCTYPE_NONF_IPV6_UDP, flow_pctypes);
-		if (pf->hw_features & I40E_HW_MULTIPLE_TCP_UDP_RSS_PCTYPE) {
+		if (test_bit(I40E_HW_MULTIPLE_TCP_UDP_RSS_PCTYPE,
+			     pf->hw_features)) {
 			set_bit(I40E_FILTER_PCTYPE_NONF_UNICAST_IPV6_UDP,
 				flow_pctypes);
 			set_bit(I40E_FILTER_PCTYPE_NONF_MULTICAST_IPV6_UDP,
@@ -4657,7 +4657,7 @@ static int i40e_check_fdir_input_set(struct i40e_vsi *vsi,
 	 * main port cannot change them when in MFP mode as this would impact
 	 * any filters on the other ports.
 	 */
-	if (pf->flags & I40E_FLAG_MFP_ENABLED) {
+	if (test_bit(I40E_FLAG_MFP_ENA, pf->flags)) {
 		netif_err(pf, drv, vsi->netdev, "Cannot change Flow Director input sets while MFP is enabled\n");
 		return -EOPNOTSUPP;
 	}
@@ -4817,7 +4817,7 @@ static int i40e_add_fdir_ethtool(struct i40e_vsi *vsi,
 		return -EINVAL;
 	pf = vsi->back;
 
-	if (!(pf->flags & I40E_FLAG_FD_SB_ENABLED))
+	if (!test_bit(I40E_FLAG_FD_SB_ENA, pf->flags))
 		return -EOPNOTSUPP;
 
 	if (test_bit(__I40E_FD_SB_AUTO_DISABLED, pf->state))
@@ -5014,7 +5014,7 @@ static void i40e_get_channels(struct net_device *dev,
 	ch->max_combined = i40e_max_channels(vsi);
 
 	/* report info for other vector */
-	ch->other_count = (pf->flags & I40E_FLAG_FD_SB_ENABLED) ? 1 : 0;
+	ch->other_count = test_bit(I40E_FLAG_FD_SB_ENA, pf->flags) ? 1 : 0;
 	ch->max_other = ch->other_count;
 
 	/* Note: This code assumes DCB is disabled for now. */
@@ -5057,7 +5057,7 @@ static int i40e_set_channels(struct net_device *dev,
 		return -EINVAL;
 
 	/* verify other_count has not changed */
-	if (ch->other_count != ((pf->flags & I40E_FLAG_FD_SB_ENABLED) ? 1 : 0))
+	if (ch->other_count != (test_bit(I40E_FLAG_FD_SB_ENA, pf->flags) ? 1 : 0))
 		return -EINVAL;
 
 	/* verify the number of channels does not exceed hardware limits */
@@ -5228,11 +5228,11 @@ static u32 i40e_get_priv_flags(struct net_device *dev)
 	u32 i, j, ret_flags = 0;
 
 	for (i = 0; i < I40E_PRIV_FLAGS_STR_LEN; i++) {
-		const struct i40e_priv_flags *priv_flags;
+		const struct i40e_priv_flags *priv_flag;
 
-		priv_flags = &i40e_gstrings_priv_flags[i];
+		priv_flag = &i40e_gstrings_priv_flags[i];
 
-		if (priv_flags->flag & pf->flags)
+		if (test_bit(priv_flag->bitno, pf->flags))
 			ret_flags |= BIT(i);
 	}
 
@@ -5240,11 +5240,11 @@ static u32 i40e_get_priv_flags(struct net_device *dev)
 		return ret_flags;
 
 	for (j = 0; j < I40E_GL_PRIV_FLAGS_STR_LEN; j++) {
-		const struct i40e_priv_flags *priv_flags;
+		const struct i40e_priv_flags *priv_flag;
 
-		priv_flags = &i40e_gl_gstrings_priv_flags[j];
+		priv_flag = &i40e_gl_gstrings_priv_flags[j];
 
-		if (priv_flags->flag & pf->flags)
+		if (test_bit(priv_flag->bitno, pf->flags))
 			ret_flags |= BIT(i + j);
 	}
 
@@ -5258,8 +5258,10 @@ static u32 i40e_get_priv_flags(struct net_device *dev)
  **/
 static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 {
+	DECLARE_BITMAP(changed_flags, I40E_PF_FLAGS_NBITS);
+	DECLARE_BITMAP(orig_flags, I40E_PF_FLAGS_NBITS);
+	DECLARE_BITMAP(new_flags, I40E_PF_FLAGS_NBITS);
 	struct i40e_netdev_priv *np = netdev_priv(dev);
-	u64 orig_flags, new_flags, changed_flags;
 	enum i40e_admin_queue_err adq_err;
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
@@ -5267,51 +5269,57 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 	int status;
 	u32 i, j;
 
-	orig_flags = READ_ONCE(pf->flags);
-	new_flags = orig_flags;
+	bitmap_copy(orig_flags, pf->flags, I40E_PF_FLAGS_NBITS);
+	bitmap_copy(new_flags, pf->flags, I40E_PF_FLAGS_NBITS);
 
 	for (i = 0; i < I40E_PRIV_FLAGS_STR_LEN; i++) {
-		const struct i40e_priv_flags *priv_flags;
-
-		priv_flags = &i40e_gstrings_priv_flags[i];
+		const struct i40e_priv_flags *priv_flag;
+		bool new_val;
 
-		if (flags & BIT(i))
-			new_flags |= priv_flags->flag;
-		else
-			new_flags &= ~(priv_flags->flag);
+		priv_flag = &i40e_gstrings_priv_flags[i];
+		new_val = (flags & BIT(i)) ? true : false;
 
 		/* If this is a read-only flag, it can't be changed */
-		if (priv_flags->read_only &&
-		    ((orig_flags ^ new_flags) & ~BIT(i)))
+		if (priv_flag->read_only &&
+		    test_bit(priv_flag->bitno, orig_flags) != new_val)
 			return -EOPNOTSUPP;
+
+		if (new_val)
+			set_bit(priv_flag->bitno, new_flags);
+		else
+			clear_bit(priv_flag->bitno, new_flags);
 	}
 
 	if (pf->hw.pf_id != 0)
 		goto flags_complete;
 
 	for (j = 0; j < I40E_GL_PRIV_FLAGS_STR_LEN; j++) {
-		const struct i40e_priv_flags *priv_flags;
-
-		priv_flags = &i40e_gl_gstrings_priv_flags[j];
+		const struct i40e_priv_flags *priv_flag;
+		bool new_val;
 
-		if (flags & BIT(i + j))
-			new_flags |= priv_flags->flag;
-		else
-			new_flags &= ~(priv_flags->flag);
+		priv_flag = &i40e_gl_gstrings_priv_flags[j];
+		new_val = (flags & BIT(i + j)) ? true : false;
 
 		/* If this is a read-only flag, it can't be changed */
-		if (priv_flags->read_only &&
-		    ((orig_flags ^ new_flags) & ~BIT(i)))
+		if (priv_flag->read_only &&
+		    test_bit(priv_flag->bitno, orig_flags) != new_val)
 			return -EOPNOTSUPP;
+
+		if (new_val)
+			set_bit(priv_flag->bitno, new_flags);
+		else
+			clear_bit(priv_flag->bitno, new_flags);
 	}
 
 flags_complete:
-	changed_flags = orig_flags ^ new_flags;
+	bitmap_xor(changed_flags, pf->flags, orig_flags, I40E_PF_FLAGS_NBITS);
 
-	if (changed_flags & I40E_FLAG_DISABLE_FW_LLDP)
+	if (test_bit(I40E_FLAG_FW_LLDP_DIS, changed_flags))
 		reset_needed = I40E_PF_RESET_AND_REBUILD_FLAG;
-	if (changed_flags & (I40E_FLAG_VEB_STATS_ENABLED |
-	    I40E_FLAG_LEGACY_RX | I40E_FLAG_SOURCE_PRUNING_DISABLED))
+
+	if (test_bit(I40E_FLAG_VEB_STATS_ENA, changed_flags) ||
+	    test_bit(I40E_FLAG_LEGACY_RX_ENA, changed_flags) ||
+	    test_bit(I40E_FLAG_SOURCE_PRUNING_DIS, changed_flags))
 		reset_needed = BIT(__I40E_PF_RESET_REQUESTED);
 
 	/* Before we finalize any flag changes, we need to perform some
@@ -5319,8 +5327,8 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 	 */
 
 	/* ATR eviction is not supported on all devices */
-	if ((new_flags & I40E_FLAG_HW_ATR_EVICT_ENABLED) &&
-	    !(pf->hw_features & I40E_HW_ATR_EVICT_CAPABLE))
+	if (test_bit(I40E_FLAG_HW_ATR_EVICT_ENA, new_flags) &&
+	    !test_bit(I40E_HW_ATR_EVICT_CAPABLE, pf->hw_features))
 		return -EOPNOTSUPP;
 
 	/* If the driver detected FW LLDP was disabled on init, this flag could
@@ -5331,15 +5339,14 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 	 * disable LLDP, however we _must_ not allow the user to enable/disable
 	 * LLDP with this flag on unsupported FW versions.
 	 */
-	if (changed_flags & I40E_FLAG_DISABLE_FW_LLDP) {
-		if (!(pf->hw.flags & I40E_HW_FLAG_FW_LLDP_STOPPABLE)) {
-			dev_warn(&pf->pdev->dev,
-				 "Device does not support changing FW LLDP\n");
-			return -EOPNOTSUPP;
-		}
+	if (test_bit(I40E_FLAG_FW_LLDP_DIS, changed_flags) &&
+	    (!(pf->hw.flags & I40E_HW_FLAG_FW_LLDP_STOPPABLE))) {
+		dev_warn(&pf->pdev->dev,
+			 "Device does not support changing FW LLDP\n");
+		return -EOPNOTSUPP;
 	}
 
-	if (changed_flags & I40E_FLAG_RS_FEC &&
+	if (test_bit(I40E_FLAG_RS_FEC, changed_flags) &&
 	    pf->hw.device_id != I40E_DEV_ID_25G_SFP28 &&
 	    pf->hw.device_id != I40E_DEV_ID_25G_B) {
 		dev_warn(&pf->pdev->dev,
@@ -5347,7 +5354,7 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 		return -EOPNOTSUPP;
 	}
 
-	if (changed_flags & I40E_FLAG_BASE_R_FEC &&
+	if (test_bit(I40E_FLAG_BASE_R_FEC, changed_flags) &&
 	    pf->hw.device_id != I40E_DEV_ID_25G_SFP28 &&
 	    pf->hw.device_id != I40E_DEV_ID_25G_B &&
 	    pf->hw.device_id != I40E_DEV_ID_KX_X722) {
@@ -5362,17 +5369,17 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 	 */
 
 	/* Flush current ATR settings if ATR was disabled */
-	if ((changed_flags & I40E_FLAG_FD_ATR_ENABLED) &&
-	    !(new_flags & I40E_FLAG_FD_ATR_ENABLED)) {
+	if (test_bit(I40E_FLAG_FD_ATR_ENA, changed_flags) &&
+	    !test_bit(I40E_FLAG_FD_ATR_ENA, new_flags)) {
 		set_bit(__I40E_FD_ATR_AUTO_DISABLED, pf->state);
 		set_bit(__I40E_FD_FLUSH_REQUESTED, pf->state);
 	}
 
-	if (changed_flags & I40E_FLAG_TRUE_PROMISC_SUPPORT) {
+	if (test_bit(I40E_FLAG_TRUE_PROMISC_ENA, changed_flags)) {
 		u16 sw_flags = 0, valid_flags = 0;
 		int ret;
 
-		if (!(new_flags & I40E_FLAG_TRUE_PROMISC_SUPPORT))
+		if (!test_bit(I40E_FLAG_TRUE_PROMISC_ENA, new_flags))
 			sw_flags = I40E_AQ_SET_SWITCH_CFG_PROMISC;
 		valid_flags = I40E_AQ_SET_SWITCH_CFG_PROMISC;
 		ret = i40e_aq_set_switch_config(&pf->hw, sw_flags, valid_flags,
@@ -5387,17 +5394,17 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 		}
 	}
 
-	if ((changed_flags & I40E_FLAG_RS_FEC) ||
-	    (changed_flags & I40E_FLAG_BASE_R_FEC)) {
+	if (test_bit(I40E_FLAG_RS_FEC, changed_flags) ||
+	    test_bit(I40E_FLAG_BASE_R_FEC, changed_flags)) {
 		u8 fec_cfg = 0;
 
-		if (new_flags & I40E_FLAG_RS_FEC &&
-		    new_flags & I40E_FLAG_BASE_R_FEC) {
+		if (test_bit(I40E_FLAG_RS_FEC, new_flags) &&
+		    test_bit(I40E_FLAG_BASE_R_FEC, new_flags)) {
 			fec_cfg = I40E_AQ_SET_FEC_AUTO;
-		} else if (new_flags & I40E_FLAG_RS_FEC) {
+		} else if (test_bit(I40E_FLAG_RS_FEC, new_flags)) {
 			fec_cfg = (I40E_AQ_SET_FEC_REQUEST_RS |
 				   I40E_AQ_SET_FEC_ABILITY_RS);
-		} else if (new_flags & I40E_FLAG_BASE_R_FEC) {
+		} else if (test_bit(I40E_FLAG_BASE_R_FEC, new_flags)) {
 			fec_cfg = (I40E_AQ_SET_FEC_REQUEST_KR |
 				   I40E_AQ_SET_FEC_ABILITY_KR);
 		}
@@ -5405,35 +5412,35 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 			dev_warn(&pf->pdev->dev, "Cannot change FEC config\n");
 	}
 
-	if ((changed_flags & I40E_FLAG_LINK_DOWN_ON_CLOSE_ENABLED) &&
-	    (orig_flags & I40E_FLAG_TOTAL_PORT_SHUTDOWN_ENABLED)) {
+	if (test_bit(I40E_FLAG_LINK_DOWN_ON_CLOSE_ENA, changed_flags) &&
+	    test_bit(I40E_FLAG_TOTAL_PORT_SHUTDOWN_ENA, orig_flags)) {
 		dev_err(&pf->pdev->dev,
 			"Setting link-down-on-close not supported on this port (because total-port-shutdown is enabled)\n");
 		return -EOPNOTSUPP;
 	}
 
-	if ((changed_flags & I40E_FLAG_VF_VLAN_PRUNING) &&
+	if (test_bit(I40E_FLAG_VF_VLAN_PRUNING_ENA, changed_flags) &&
 	    pf->num_alloc_vfs) {
 		dev_warn(&pf->pdev->dev,
 			 "Changing vf-vlan-pruning flag while VF(s) are active is not supported\n");
 		return -EOPNOTSUPP;
 	}
 
-	if ((changed_flags & I40E_FLAG_LEGACY_RX) &&
+	if (test_bit(I40E_FLAG_LEGACY_RX_ENA, changed_flags) &&
 	    I40E_2K_TOO_SMALL_WITH_PADDING) {
 		dev_warn(&pf->pdev->dev,
 			 "2k Rx buffer is too small to fit standard MTU and skb_shared_info\n");
 		return -EOPNOTSUPP;
 	}
 
-	if ((changed_flags & new_flags &
-	     I40E_FLAG_LINK_DOWN_ON_CLOSE_ENABLED) &&
-	    (new_flags & I40E_FLAG_MFP_ENABLED))
+	if (test_bit(I40E_FLAG_LINK_DOWN_ON_CLOSE_ENA, changed_flags) &&
+	    test_bit(I40E_FLAG_LINK_DOWN_ON_CLOSE_ENA, new_flags) &&
+	    test_bit(I40E_FLAG_MFP_ENA, new_flags))
 		dev_warn(&pf->pdev->dev,
 			 "Turning on link-down-on-close flag may affect other partitions\n");
 
-	if (changed_flags & I40E_FLAG_DISABLE_FW_LLDP) {
-		if (new_flags & I40E_FLAG_DISABLE_FW_LLDP) {
+	if (test_bit(I40E_FLAG_FW_LLDP_DIS, changed_flags)) {
+		if (test_bit(I40E_FLAG_FW_LLDP_DIS, new_flags)) {
 #ifdef CONFIG_I40E_DCB
 			i40e_dcb_sw_default_config(pf);
 #endif /* CONFIG_I40E_DCB */
@@ -5474,7 +5481,7 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 	 * initialization or (b) while holding the RTNL lock, we don't need
 	 * anything fancy here.
 	 */
-	pf->flags = new_flags;
+	bitmap_copy(pf->flags, new_flags, I40E_PF_FLAGS_NBITS);
 
 	/* Issue reset to cause things to take effect, as additional bits
 	 * are added we will need to create a mask of bits requiring reset
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index b44d8d8b0474..d79edab64560 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -371,7 +371,7 @@ static void i40e_tx_timeout(struct net_device *netdev, unsigned int txqueue)
 	if (tx_ring) {
 		head = i40e_get_head(tx_ring);
 		/* Read interrupt register */
-		if (pf->flags & I40E_FLAG_MSIX_ENABLED)
+		if (test_bit(I40E_FLAG_MSIX_ENA, pf->flags))
 			val = rd32(&pf->hw,
 			     I40E_PFINT_DYN_CTLN(tx_ring->q_vector->v_idx +
 						tx_ring->vsi->base_vector - 1));
@@ -1209,13 +1209,13 @@ static void i40e_update_pf_stats(struct i40e_pf *pf)
 			   pf->stat_offsets_loaded,
 			   &osd->rx_lpi_count, &nsd->rx_lpi_count);
 
-	if (pf->flags & I40E_FLAG_FD_SB_ENABLED &&
+	if (test_bit(I40E_FLAG_FD_SB_ENA, pf->flags) &&
 	    !test_bit(__I40E_FD_SB_AUTO_DISABLED, pf->state))
 		nsd->fd_sb_status = true;
 	else
 		nsd->fd_sb_status = false;
 
-	if (pf->flags & I40E_FLAG_FD_ATR_ENABLED &&
+	if (test_bit(I40E_FLAG_FD_ATR_ENA, pf->flags) &&
 	    !test_bit(__I40E_FD_ATR_AUTO_DISABLED, pf->state))
 		nsd->fd_atr_status = true;
 	else
@@ -1485,7 +1485,7 @@ static s16 i40e_get_vf_new_vlan(struct i40e_vsi *vsi,
 		return pvid;
 
 	is_any = (trusted ||
-		  !(pf->flags & I40E_FLAG_VF_VLAN_PRUNING));
+		  !test_bit(I40E_FLAG_VF_VLAN_PRUNING_ENA, pf->flags));
 
 	if ((vlan_filters && f->vlan == I40E_VLAN_ANY) ||
 	    (!is_any && !vlan_filters && f->vlan == I40E_VLAN_ANY) ||
@@ -1890,7 +1890,7 @@ static int i40e_vsi_config_rss(struct i40e_vsi *vsi)
 	u8 *lut;
 	int ret;
 
-	if (!(pf->hw_features & I40E_HW_RSS_AQ_CAPABLE))
+	if (!test_bit(I40E_HW_RSS_AQ_CAPABLE, pf->hw_features))
 		return 0;
 	if (!vsi->rss_size)
 		vsi->rss_size = min_t(int, pf->alloc_rss_size,
@@ -2045,7 +2045,7 @@ static void i40e_vsi_setup_queue_map(struct i40e_vsi *vsi,
 		 */
 		if (vsi->req_queue_pairs > 0)
 			vsi->num_queue_pairs = vsi->req_queue_pairs;
-		else if (pf->flags & I40E_FLAG_MSIX_ENABLED)
+		else if (test_bit(I40E_FLAG_MSIX_ENA, pf->flags))
 			vsi->num_queue_pairs = pf->num_lan_msix;
 		else
 			vsi->num_queue_pairs = 1;
@@ -2058,7 +2058,7 @@ static void i40e_vsi_setup_queue_map(struct i40e_vsi *vsi,
 	else
 		num_tc_qps = vsi->alloc_queue_pairs;
 
-	if (enabled_tc && (vsi->back->flags & I40E_FLAG_DCB_ENABLED)) {
+	if (enabled_tc && test_bit(I40E_FLAG_DCB_ENA, vsi->back->flags)) {
 		/* Find numtc from enabled TC bitmap */
 		for (i = 0, numtc = 0; i < I40E_MAX_TRAFFIC_CLASS; i++) {
 			if (enabled_tc & BIT(i)) /* TC is enabled */
@@ -2077,7 +2077,7 @@ static void i40e_vsi_setup_queue_map(struct i40e_vsi *vsi,
 	vsi->tc_config.enabled_tc = enabled_tc ? enabled_tc : 1;
 
 	/* Do not allow use more TC queue pairs than MSI-X vectors exist */
-	if (pf->flags & I40E_FLAG_MSIX_ENABLED)
+	if (test_bit(I40E_FLAG_MSIX_ENA, pf->flags))
 		num_tc_qps = min_t(int, num_tc_qps, pf->num_lan_msix);
 
 	/* Setup queue offset/count for all TCs for given VSI */
@@ -2089,8 +2089,10 @@ static void i40e_vsi_setup_queue_map(struct i40e_vsi *vsi,
 
 			switch (vsi->type) {
 			case I40E_VSI_MAIN:
-				if (!(pf->flags & (I40E_FLAG_FD_SB_ENABLED |
-				    I40E_FLAG_FD_ATR_ENABLED)) ||
+				if ((!test_bit(I40E_FLAG_FD_SB_ENA,
+					       pf->flags) &&
+				     !test_bit(I40E_FLAG_FD_ATR_ENA,
+					       pf->flags)) ||
 				    vsi->tc_config.enabled_tc != 1) {
 					qcount = min_t(int, pf->alloc_rss_size,
 						       num_tc_qps);
@@ -2476,7 +2478,7 @@ static int i40e_set_promiscuous(struct i40e_pf *pf, bool promisc)
 
 	if (vsi->type == I40E_VSI_MAIN &&
 	    pf->lan_veb != I40E_NO_VEB &&
-	    !(pf->flags & I40E_FLAG_MFP_ENABLED)) {
+	    !test_bit(I40E_FLAG_MFP_ENA, pf->flags)) {
 		/* set defport ON for Main VSI instead of true promisc
 		 * this way we will get all unicast/multicast and VLAN
 		 * promisc behavior but will not get VF or VMDq traffic
@@ -2907,7 +2909,7 @@ static void i40e_sync_filters_subtask(struct i40e_pf *pf)
  */
 static u16 i40e_calculate_vsi_rx_buf_len(struct i40e_vsi *vsi)
 {
-	if (!vsi->netdev || (vsi->back->flags & I40E_FLAG_LEGACY_RX))
+	if (!vsi->netdev || test_bit(I40E_FLAG_LEGACY_RX_ENA, vsi->back->flags))
 		return SKB_WITH_OVERHEAD(I40E_RXBUFFER_2048);
 
 	return PAGE_SIZE < 8192 ? I40E_RXBUFFER_3072 : I40E_RXBUFFER_2048;
@@ -3462,7 +3464,7 @@ static int i40e_configure_tx_ring(struct i40e_ring *ring)
 		ring->xsk_pool = i40e_xsk_pool(ring);
 
 	/* some ATR related tx ring init */
-	if (vsi->back->flags & I40E_FLAG_FD_ATR_ENABLED) {
+	if (test_bit(I40E_FLAG_FD_ATR_ENA, vsi->back->flags)) {
 		ring->atr_sample_rate = vsi->back->atr_sample_rate;
 		ring->atr_count = 0;
 	} else {
@@ -3478,9 +3480,11 @@ static int i40e_configure_tx_ring(struct i40e_ring *ring)
 	tx_ctx.new_context = 1;
 	tx_ctx.base = (ring->dma / 128);
 	tx_ctx.qlen = ring->count;
-	tx_ctx.fd_ena = !!(vsi->back->flags & (I40E_FLAG_FD_SB_ENABLED |
-					       I40E_FLAG_FD_ATR_ENABLED));
-	tx_ctx.timesync_ena = !!(vsi->back->flags & I40E_FLAG_PTP);
+	if (test_bit(I40E_FLAG_FD_SB_ENA, vsi->back->flags) ||
+	    test_bit(I40E_FLAG_FD_ATR_ENA, vsi->back->flags))
+		tx_ctx.fd_ena = 1;
+	if (test_bit(I40E_FLAG_PTP_ENA, vsi->back->flags))
+		tx_ctx.timesync_ena = 1;
 	/* FDIR VSI tx ring can still use RS bit and writebacks */
 	if (vsi->type != I40E_VSI_FDIR)
 		tx_ctx.head_wb_ena = 1;
@@ -3663,7 +3667,7 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 	}
 
 	/* configure Rx buffer alignment */
-	if (!vsi->netdev || (vsi->back->flags & I40E_FLAG_LEGACY_RX)) {
+	if (!vsi->netdev || test_bit(I40E_FLAG_LEGACY_RX_ENA, vsi->back->flags)) {
 		if (I40E_2K_TOO_SMALL_WITH_PADDING) {
 			dev_info(&vsi->back->pdev->dev,
 				 "2k Rx buffer is too small to fit standard MTU and skb_shared_info\n");
@@ -3761,7 +3765,7 @@ static void i40e_vsi_config_dcb_rings(struct i40e_vsi *vsi)
 	u16 qoffset, qcount;
 	int i, n;
 
-	if (!(vsi->back->flags & I40E_FLAG_DCB_ENABLED)) {
+	if (!test_bit(I40E_FLAG_DCB_ENA, vsi->back->flags)) {
 		/* Reset the TC information */
 		for (i = 0; i < vsi->num_queue_pairs; i++) {
 			rx_ring = vsi->rx_rings[i];
@@ -3828,7 +3832,7 @@ static void i40e_fdir_filter_restore(struct i40e_vsi *vsi)
 	struct i40e_pf *pf = vsi->back;
 	struct hlist_node *node;
 
-	if (!(pf->flags & I40E_FLAG_FD_SB_ENABLED))
+	if (!test_bit(I40E_FLAG_FD_SB_ENA, pf->flags))
 		return;
 
 	/* Reset FDir counters as we're replaying all existing filters */
@@ -3966,10 +3970,10 @@ static void i40e_enable_misc_int_causes(struct i40e_pf *pf)
 	      I40E_PFINT_ICR0_ENA_VFLR_MASK          |
 	      I40E_PFINT_ICR0_ENA_ADMINQ_MASK;
 
-	if (pf->flags & I40E_FLAG_IWARP_ENABLED)
+	if (test_bit(I40E_FLAG_IWARP_ENA, pf->flags))
 		val |= I40E_PFINT_ICR0_ENA_PE_CRITERR_MASK;
 
-	if (pf->flags & I40E_FLAG_PTP)
+	if (test_bit(I40E_FLAG_PTP_ENA, pf->flags))
 		val |= I40E_PFINT_ICR0_ENA_TIMESYNC_MASK;
 
 	wr32(hw, I40E_PFINT_ICR0_ENA, val);
@@ -4205,7 +4209,7 @@ static void i40e_vsi_disable_irq(struct i40e_vsi *vsi)
 	}
 
 	/* disable each interrupt */
-	if (pf->flags & I40E_FLAG_MSIX_ENABLED) {
+	if (test_bit(I40E_FLAG_MSIX_ENA, pf->flags)) {
 		for (i = vsi->base_vector;
 		     i < (vsi->num_q_vectors + vsi->base_vector); i++)
 			wr32(hw, I40E_PFINT_DYN_CTLN(i - 1), 0);
@@ -4231,7 +4235,7 @@ static int i40e_vsi_enable_irq(struct i40e_vsi *vsi)
 	struct i40e_pf *pf = vsi->back;
 	int i;
 
-	if (pf->flags & I40E_FLAG_MSIX_ENABLED) {
+	if (test_bit(I40E_FLAG_MSIX_ENA, pf->flags)) {
 		for (i = 0; i < vsi->num_q_vectors; i++)
 			i40e_irq_dynamic_enable(vsi, i);
 	} else {
@@ -4252,7 +4256,7 @@ static void i40e_free_misc_vector(struct i40e_pf *pf)
 	wr32(&pf->hw, I40E_PFINT_ICR0_ENA, 0);
 	i40e_flush(&pf->hw);
 
-	if (pf->flags & I40E_FLAG_MSIX_ENABLED && pf->msix_entries) {
+	if (test_bit(I40E_FLAG_MSIX_ENA, pf->flags) && pf->msix_entries) {
 		free_irq(pf->msix_entries[0].vector, pf);
 		clear_bit(__I40E_MISC_IRQ_REQUESTED, pf->state);
 	}
@@ -4287,7 +4291,7 @@ static irqreturn_t i40e_intr(int irq, void *data)
 	    (icr0 & I40E_PFINT_ICR0_SWINT_MASK))
 		pf->sw_int_count++;
 
-	if ((pf->flags & I40E_FLAG_IWARP_ENABLED) &&
+	if (test_bit(I40E_FLAG_IWARP_ENA, pf->flags) &&
 	    (icr0 & I40E_PFINT_ICR0_ENA_PE_CRITERR_MASK)) {
 		ena_mask &= ~I40E_PFINT_ICR0_ENA_PE_CRITERR_MASK;
 		dev_dbg(&pf->pdev->dev, "cleared PE_CRITERR\n");
@@ -4487,7 +4491,7 @@ static bool i40e_clean_fdir_tx_irq(struct i40e_ring *tx_ring, int budget)
 	i += tx_ring->count;
 	tx_ring->next_to_clean = i;
 
-	if (vsi->back->flags & I40E_FLAG_MSIX_ENABLED)
+	if (test_bit(I40E_FLAG_MSIX_ENA, vsi->back->flags))
 		i40e_irq_dynamic_enable(vsi, tx_ring->q_vector->v_idx);
 
 	return budget > 0;
@@ -4600,9 +4604,9 @@ static int i40e_vsi_request_irq(struct i40e_vsi *vsi, char *basename)
 	struct i40e_pf *pf = vsi->back;
 	int err;
 
-	if (pf->flags & I40E_FLAG_MSIX_ENABLED)
+	if (test_bit(I40E_FLAG_MSIX_ENA, pf->flags))
 		err = i40e_vsi_request_irq_msix(vsi, basename);
-	else if (pf->flags & I40E_FLAG_MSI_ENABLED)
+	else if (test_bit(I40E_FLAG_MSI_ENA, pf->flags))
 		err = request_irq(pf->pdev->irq, i40e_intr, 0,
 				  pf->int_name, pf);
 	else
@@ -4634,7 +4638,7 @@ static void i40e_netpoll(struct net_device *netdev)
 	if (test_bit(__I40E_VSI_DOWN, vsi->state))
 		return;
 
-	if (pf->flags & I40E_FLAG_MSIX_ENABLED) {
+	if (test_bit(I40E_FLAG_MSIX_ENA, pf->flags)) {
 		for (i = 0; i < vsi->num_q_vectors; i++)
 			i40e_msix_clean_rings(0, vsi->q_vectors[i]);
 	} else {
@@ -4974,7 +4978,7 @@ static void i40e_vsi_free_irq(struct i40e_vsi *vsi)
 	u32 val, qp;
 	int i;
 
-	if (pf->flags & I40E_FLAG_MSIX_ENABLED) {
+	if (test_bit(I40E_FLAG_MSIX_ENA, pf->flags)) {
 		if (!vsi->q_vectors)
 			return;
 
@@ -5136,16 +5140,17 @@ static void i40e_vsi_free_q_vectors(struct i40e_vsi *vsi)
 static void i40e_reset_interrupt_capability(struct i40e_pf *pf)
 {
 	/* If we're in Legacy mode, the interrupt was cleaned in vsi_close */
-	if (pf->flags & I40E_FLAG_MSIX_ENABLED) {
+	if (test_bit(I40E_FLAG_MSIX_ENA, pf->flags)) {
 		pci_disable_msix(pf->pdev);
 		kfree(pf->msix_entries);
 		pf->msix_entries = NULL;
 		kfree(pf->irq_pile);
 		pf->irq_pile = NULL;
-	} else if (pf->flags & I40E_FLAG_MSI_ENABLED) {
+	} else if (test_bit(I40E_FLAG_MSI_ENA, pf->flags)) {
 		pci_disable_msi(pf->pdev);
 	}
-	pf->flags &= ~(I40E_FLAG_MSIX_ENABLED | I40E_FLAG_MSI_ENABLED);
+	clear_bit(I40E_FLAG_MSI_ENA, pf->flags);
+	clear_bit(I40E_FLAG_MSIX_ENA, pf->flags);
 }
 
 /**
@@ -5485,11 +5490,11 @@ static u8 i40e_pf_get_num_tc(struct i40e_pf *pf)
 		return pf->vsi[pf->lan_vsi]->mqprio_qopt.qopt.num_tc;
 
 	/* If neither MQPRIO nor DCB is enabled, then always use single TC */
-	if (!(pf->flags & I40E_FLAG_DCB_ENABLED))
+	if (!test_bit(I40E_FLAG_DCB_ENA, pf->flags))
 		return 1;
 
 	/* SFP mode will be enabled for all TCs on port */
-	if (!(pf->flags & I40E_FLAG_MFP_ENABLED))
+	if (!test_bit(I40E_FLAG_MFP_ENA, pf->flags))
 		return i40e_dcb_get_num_tc(dcbcfg);
 
 	/* MFP mode return count of enabled TCs for this PF */
@@ -5519,11 +5524,11 @@ static u8 i40e_pf_get_tc_map(struct i40e_pf *pf)
 	/* If neither MQPRIO nor DCB is enabled for this PF then just return
 	 * default TC
 	 */
-	if (!(pf->flags & I40E_FLAG_DCB_ENABLED))
+	if (!test_bit(I40E_FLAG_DCB_ENA, pf->flags))
 		return I40E_DEFAULT_TRAFFIC_CLASS;
 
 	/* SFP mode we want PF to be enabled for all TCs */
-	if (!(pf->flags & I40E_FLAG_MFP_ENABLED))
+	if (!test_bit(I40E_FLAG_MFP_ENA, pf->flags))
 		return i40e_dcb_get_enabled_tc(&pf->hw.local_dcbx_config);
 
 	/* MFP enabled and iSCSI PF type */
@@ -5612,7 +5617,7 @@ static int i40e_vsi_configure_bw_alloc(struct i40e_vsi *vsi, u8 enabled_tc,
 	/* There is no need to reset BW when mqprio mode is on.  */
 	if (i40e_is_tc_mqprio_enabled(pf))
 		return 0;
-	if (!vsi->mqprio_qopt.qopt.hw && !(pf->flags & I40E_FLAG_DCB_ENABLED)) {
+	if (!vsi->mqprio_qopt.qopt.hw && !test_bit(I40E_FLAG_DCB_ENA, pf->flags)) {
 		ret = i40e_set_bw_limit(vsi, vsi->seid, 0);
 		if (ret)
 			dev_info(&pf->pdev->dev,
@@ -5865,7 +5870,7 @@ static int i40e_vsi_config_tc(struct i40e_vsi *vsi, u8 enabled_tc)
 		}
 		vsi->reconfig_rss = false;
 	}
-	if (vsi->back->flags & I40E_FLAG_IWARP_ENABLED) {
+	if (test_bit(I40E_FLAG_IWARP_ENA, vsi->back->flags)) {
 		ctxt.info.valid_sections |=
 				cpu_to_le16(I40E_AQ_VSI_PROP_QUEUE_OPT_VALID);
 		ctxt.info.queueing_opt_flags |= I40E_AQ_VSI_QUE_OPT_TCP_ENA;
@@ -6278,7 +6283,7 @@ static int i40e_add_channel(struct i40e_pf *pf, u16 uplink_seid,
 	if (ch->type == I40E_VSI_VMDQ2)
 		ctxt.flags = I40E_AQ_VSI_TYPE_VMDQ2;
 
-	if (pf->flags & I40E_FLAG_VEB_MODE_ENABLED) {
+	if (test_bit(I40E_FLAG_VEB_MODE_ENA, pf->flags)) {
 		ctxt.info.valid_sections |=
 		     cpu_to_le16(I40E_AQ_VSI_PROP_SWITCH_VALID);
 		ctxt.info.switch_id =
@@ -6583,8 +6588,8 @@ int i40e_create_queue_channel(struct i40e_vsi *vsi,
 	 * VSI to be added switch to VEB mode.
 	 */
 
-	if (!(pf->flags & I40E_FLAG_VEB_MODE_ENABLED)) {
-		pf->flags |= I40E_FLAG_VEB_MODE_ENABLED;
+	if (!test_bit(I40E_FLAG_VEB_MODE_ENA, pf->flags)) {
+		set_bit(I40E_FLAG_VEB_MODE_ENA, pf->flags);
 
 		if (vsi->type == I40E_VSI_MAIN) {
 			if (i40e_is_tc_mqprio_enabled(pf))
@@ -6995,9 +7000,9 @@ int i40e_hw_dcb_config(struct i40e_pf *pf, struct i40e_dcbx_config *new_cfg)
 	if (need_reconfig) {
 		/* Enable DCB tagging only when more than one TC */
 		if (new_numtc > 1)
-			pf->flags |= I40E_FLAG_DCB_ENABLED;
+			set_bit(I40E_FLAG_DCB_ENA, pf->flags);
 		else
-			pf->flags &= ~I40E_FLAG_DCB_ENABLED;
+			clear_bit(I40E_FLAG_DCB_ENA, pf->flags);
 
 		set_bit(__I40E_PORT_SUSPENDED, pf->state);
 		/* Reconfiguration needed quiesce all VSIs */
@@ -7087,7 +7092,7 @@ int i40e_hw_dcb_config(struct i40e_pf *pf, struct i40e_dcbx_config *new_cfg)
 			set_bit(__I40E_CLIENT_L2_CHANGE, pf->state);
 		}
 		/* registers are set, lets apply */
-		if (pf->hw_features & I40E_HW_USE_SET_LLDP_MIB)
+		if (test_bit(I40E_HW_USE_SET_LLDP_MIB, pf->hw_features))
 			ret = i40e_hw_set_dcb_config(pf, new_cfg);
 	}
 
@@ -7108,7 +7113,7 @@ int i40e_dcb_sw_default_config(struct i40e_pf *pf)
 	struct i40e_hw *hw = &pf->hw;
 	int err;
 
-	if (pf->hw_features & I40E_HW_USE_SET_LLDP_MIB) {
+	if (test_bit(I40E_HW_USE_SET_LLDP_MIB, pf->hw_features)) {
 		/* Update the local cached instance with TC0 ETS */
 		memset(&pf->tmp_cfg, 0, sizeof(struct i40e_dcbx_config));
 		pf->tmp_cfg.etscfg.willing = I40E_IEEE_DEFAULT_ETS_WILLING;
@@ -7169,12 +7174,12 @@ static int i40e_init_pf_dcb(struct i40e_pf *pf)
 	/* Do not enable DCB for SW1 and SW2 images even if the FW is capable
 	 * Also do not enable DCBx if FW LLDP agent is disabled
 	 */
-	if (pf->hw_features & I40E_HW_NO_DCB_SUPPORT) {
+	if (test_bit(I40E_HW_NO_DCB_SUPPORT, pf->hw_features)) {
 		dev_info(&pf->pdev->dev, "DCB is not supported.\n");
 		err = -EOPNOTSUPP;
 		goto out;
 	}
-	if (pf->flags & I40E_FLAG_DISABLE_FW_LLDP) {
+	if (test_bit(I40E_FLAG_FW_LLDP_DIS, pf->flags)) {
 		dev_info(&pf->pdev->dev, "FW LLDP is disabled, attempting SW DCB\n");
 		err = i40e_dcb_sw_default_config(pf);
 		if (err) {
@@ -7185,8 +7190,8 @@ static int i40e_init_pf_dcb(struct i40e_pf *pf)
 		pf->dcbx_cap = DCB_CAP_DCBX_HOST |
 			       DCB_CAP_DCBX_VER_IEEE;
 		/* at init capable but disabled */
-		pf->flags |= I40E_FLAG_DCB_CAPABLE;
-		pf->flags &= ~I40E_FLAG_DCB_ENABLED;
+		set_bit(I40E_FLAG_DCB_CAPABLE, pf->flags);
+		clear_bit(I40E_FLAG_DCB_ENA, pf->flags);
 		goto out;
 	}
 	err = i40e_init_dcb(hw, true);
@@ -7201,20 +7206,20 @@ static int i40e_init_pf_dcb(struct i40e_pf *pf)
 			pf->dcbx_cap = DCB_CAP_DCBX_LLD_MANAGED |
 				       DCB_CAP_DCBX_VER_IEEE;
 
-			pf->flags |= I40E_FLAG_DCB_CAPABLE;
+			set_bit(I40E_FLAG_DCB_CAPABLE, pf->flags);
 			/* Enable DCB tagging only when more than one TC
 			 * or explicitly disable if only one TC
 			 */
 			if (i40e_dcb_get_num_tc(&hw->local_dcbx_config) > 1)
-				pf->flags |= I40E_FLAG_DCB_ENABLED;
+				set_bit(I40E_FLAG_DCB_ENA, pf->flags);
 			else
-				pf->flags &= ~I40E_FLAG_DCB_ENABLED;
+				clear_bit(I40E_FLAG_DCB_ENA, pf->flags);
 			dev_dbg(&pf->pdev->dev,
 				"DCBX offload is supported for this PF.\n");
 		}
 	} else if (pf->hw.aq.asq_last_status == I40E_AQ_RC_EPERM) {
 		dev_info(&pf->pdev->dev, "FW LLDP disabled for this PF.\n");
-		pf->flags |= I40E_FLAG_DISABLE_FW_LLDP;
+		set_bit(I40E_FLAG_FW_LLDP_DIS, pf->flags);
 	} else {
 		dev_info(&pf->pdev->dev,
 			 "Query for DCB configuration failed, err %pe aq_err %s\n",
@@ -7374,7 +7379,7 @@ static int i40e_up_complete(struct i40e_vsi *vsi)
 	struct i40e_pf *pf = vsi->back;
 	int err;
 
-	if (pf->flags & I40E_FLAG_MSIX_ENABLED)
+	if (test_bit(I40E_FLAG_MSIX_ENA, pf->flags))
 		i40e_vsi_configure_msix(vsi);
 	else
 		i40e_configure_msi_and_legacy(vsi);
@@ -7478,7 +7483,7 @@ static int i40e_force_link_state(struct i40e_pf *pf, bool is_up)
 	 * and its speed values are OK, no need for a flap
 	 * if non_zero_phy_type was set, still need to force up
 	 */
-	if (pf->flags & I40E_FLAG_TOTAL_PORT_SHUTDOWN_ENABLED)
+	if (test_bit(I40E_FLAG_TOTAL_PORT_SHUTDOWN_ENA, pf->flags))
 		non_zero_phy_type = true;
 	else if (is_up && abilities.phy_type != 0 && abilities.link_speed != 0)
 		return 0;
@@ -7494,7 +7499,7 @@ static int i40e_force_link_state(struct i40e_pf *pf, bool is_up)
 		non_zero_phy_type ? (u8)((mask >> 32) & 0xff) : 0;
 	/* Copy the old settings, except of phy_type */
 	config.abilities = abilities.abilities;
-	if (pf->flags & I40E_FLAG_TOTAL_PORT_SHUTDOWN_ENABLED) {
+	if (test_bit(I40E_FLAG_TOTAL_PORT_SHUTDOWN_ENA, pf->flags)) {
 		if (is_up)
 			config.abilities |= I40E_AQ_PHY_ENABLE_LINK;
 		else
@@ -7544,8 +7549,8 @@ int i40e_up(struct i40e_vsi *vsi)
 	int err;
 
 	if (vsi->type == I40E_VSI_MAIN &&
-	    (vsi->back->flags & I40E_FLAG_LINK_DOWN_ON_CLOSE_ENABLED ||
-	     vsi->back->flags & I40E_FLAG_TOTAL_PORT_SHUTDOWN_ENABLED))
+	    (test_bit(I40E_FLAG_LINK_DOWN_ON_CLOSE_ENA, vsi->back->flags) ||
+	     test_bit(I40E_FLAG_TOTAL_PORT_SHUTDOWN_ENA, vsi->back->flags)))
 		i40e_force_link_state(vsi->back, true);
 
 	err = i40e_vsi_configure(vsi);
@@ -7573,8 +7578,8 @@ void i40e_down(struct i40e_vsi *vsi)
 	i40e_vsi_disable_irq(vsi);
 	i40e_vsi_stop_rings(vsi);
 	if (vsi->type == I40E_VSI_MAIN &&
-	   (vsi->back->flags & I40E_FLAG_LINK_DOWN_ON_CLOSE_ENABLED ||
-	    vsi->back->flags & I40E_FLAG_TOTAL_PORT_SHUTDOWN_ENABLED))
+	   (test_bit(I40E_FLAG_LINK_DOWN_ON_CLOSE_ENA, vsi->back->flags) ||
+	    test_bit(I40E_FLAG_TOTAL_PORT_SHUTDOWN_ENA, vsi->back->flags)))
 		i40e_force_link_state(vsi->back, false);
 	i40e_napi_disable_all(vsi);
 
@@ -7980,7 +7985,7 @@ static void *i40e_fwd_add(struct net_device *netdev, struct net_device *vdev)
 	struct i40e_fwd_adapter *fwd;
 	int avail_macvlan, ret;
 
-	if ((pf->flags & I40E_FLAG_DCB_ENABLED)) {
+	if (test_bit(I40E_FLAG_DCB_ENA, pf->flags)) {
 		netdev_info(netdev, "Macvlans are not supported when DCB is enabled\n");
 		return ERR_PTR(-EINVAL);
 	}
@@ -8175,23 +8180,23 @@ static int i40e_setup_tc(struct net_device *netdev, void *type_data)
 	hw = mqprio_qopt->qopt.hw;
 	mode = mqprio_qopt->mode;
 	if (!hw) {
-		pf->flags &= ~I40E_FLAG_TC_MQPRIO;
+		clear_bit(I40E_FLAG_TC_MQPRIO_ENA, pf->flags);
 		memcpy(&vsi->mqprio_qopt, mqprio_qopt, sizeof(*mqprio_qopt));
 		goto config_tc;
 	}
 
 	/* Check if MFP enabled */
-	if (pf->flags & I40E_FLAG_MFP_ENABLED) {
+	if (test_bit(I40E_FLAG_MFP_ENA, pf->flags)) {
 		netdev_info(netdev,
 			    "Configuring TC not supported in MFP mode\n");
 		return ret;
 	}
 	switch (mode) {
 	case TC_MQPRIO_MODE_DCB:
-		pf->flags &= ~I40E_FLAG_TC_MQPRIO;
+		clear_bit(I40E_FLAG_TC_MQPRIO_ENA, pf->flags);
 
 		/* Check if DCB enabled to continue */
-		if (!(pf->flags & I40E_FLAG_DCB_ENABLED)) {
+		if (!test_bit(I40E_FLAG_DCB_ENA, pf->flags)) {
 			netdev_info(netdev,
 				    "DCB is not enabled for adapter\n");
 			return ret;
@@ -8205,20 +8210,20 @@ static int i40e_setup_tc(struct net_device *netdev, void *type_data)
 		}
 		break;
 	case TC_MQPRIO_MODE_CHANNEL:
-		if (pf->flags & I40E_FLAG_DCB_ENABLED) {
+		if (test_bit(I40E_FLAG_DCB_ENA, pf->flags)) {
 			netdev_info(netdev,
 				    "Full offload of TC Mqprio options is not supported when DCB is enabled\n");
 			return ret;
 		}
-		if (!(pf->flags & I40E_FLAG_MSIX_ENABLED))
+		if (!test_bit(I40E_FLAG_MSIX_ENA, pf->flags))
 			return ret;
 		ret = i40e_validate_mqprio_qopt(vsi, mqprio_qopt);
 		if (ret)
 			return ret;
 		memcpy(&vsi->mqprio_qopt, mqprio_qopt,
 		       sizeof(*mqprio_qopt));
-		pf->flags |= I40E_FLAG_TC_MQPRIO;
-		pf->flags &= ~I40E_FLAG_DCB_ENABLED;
+		set_bit(I40E_FLAG_TC_MQPRIO_ENA, pf->flags);
+		clear_bit(I40E_FLAG_DCB_ENA, pf->flags);
 		break;
 	default:
 		return -EINVAL;
@@ -8802,11 +8807,11 @@ static int i40e_configure_clsflower(struct i40e_vsi *vsi,
 		return -EINVAL;
 	}
 
-	if (vsi->back->flags & I40E_FLAG_FD_SB_ENABLED) {
+	if (test_bit(I40E_FLAG_FD_SB_ENA, vsi->back->flags)) {
 		dev_err(&vsi->back->pdev->dev,
 			"Disable Flow Director Sideband, configuring Cloud filters via tc-flower\n");
-		vsi->back->flags &= ~I40E_FLAG_FD_SB_ENABLED;
-		vsi->back->flags |= I40E_FLAG_FD_SB_TO_CLOUD_FILTER;
+		clear_bit(I40E_FLAG_FD_SB_ENA, vsi->back->flags);
+		clear_bit(I40E_FLAG_FD_SB_TO_CLOUD_FILTER, vsi->back->flags);
 	}
 
 	filter = kzalloc(sizeof(*filter), GFP_KERNEL);
@@ -8902,11 +8907,11 @@ static int i40e_delete_clsflower(struct i40e_vsi *vsi,
 
 	pf->num_cloud_filters--;
 	if (!pf->num_cloud_filters)
-		if ((pf->flags & I40E_FLAG_FD_SB_TO_CLOUD_FILTER) &&
-		    !(pf->flags & I40E_FLAG_FD_SB_INACTIVE)) {
-			pf->flags |= I40E_FLAG_FD_SB_ENABLED;
-			pf->flags &= ~I40E_FLAG_FD_SB_TO_CLOUD_FILTER;
-			pf->flags &= ~I40E_FLAG_FD_SB_INACTIVE;
+		if (test_bit(I40E_FLAG_FD_SB_TO_CLOUD_FILTER, pf->flags) &&
+		    !test_bit(I40E_FLAG_FD_SB_INACTIVE, pf->flags)) {
+			set_bit(I40E_FLAG_FD_SB_ENA, pf->flags);
+			clear_bit(I40E_FLAG_FD_SB_TO_CLOUD_FILTER, pf->flags);
+			clear_bit(I40E_FLAG_FD_SB_INACTIVE, pf->flags);
 		}
 	return 0;
 }
@@ -9207,11 +9212,11 @@ static void i40e_cloud_filter_exit(struct i40e_pf *pf)
 	}
 	pf->num_cloud_filters = 0;
 
-	if ((pf->flags & I40E_FLAG_FD_SB_TO_CLOUD_FILTER) &&
-	    !(pf->flags & I40E_FLAG_FD_SB_INACTIVE)) {
-		pf->flags |= I40E_FLAG_FD_SB_ENABLED;
-		pf->flags &= ~I40E_FLAG_FD_SB_TO_CLOUD_FILTER;
-		pf->flags &= ~I40E_FLAG_FD_SB_INACTIVE;
+	if (test_bit(I40E_FLAG_FD_SB_TO_CLOUD_FILTER, pf->flags) &&
+	    !test_bit(I40E_FLAG_FD_SB_INACTIVE, pf->flags)) {
+		set_bit(I40E_FLAG_FD_SB_ENA, pf->flags);
+		clear_bit(I40E_FLAG_FD_SB_TO_CLOUD_FILTER, pf->flags);
+		clear_bit(I40E_FLAG_FD_SB_INACTIVE, pf->flags);
 	}
 }
 
@@ -9299,7 +9304,7 @@ void i40e_do_reset(struct i40e_pf *pf, u32 reset_flags, bool lock_acquired)
 		i40e_prep_for_reset(pf);
 		i40e_reset_and_rebuild(pf, true, lock_acquired);
 		dev_info(&pf->pdev->dev,
-			 pf->flags & I40E_FLAG_DISABLE_FW_LLDP ?
+			 test_bit(I40E_FLAG_FW_LLDP_DIS, pf->flags) ?
 			 "FW LLDP is disabled\n" :
 			 "FW LLDP is enabled\n");
 
@@ -9414,12 +9419,12 @@ static int i40e_handle_lldp_event(struct i40e_pf *pf,
 	if (I40E_IS_X710TL_DEVICE(hw->device_id) &&
 	    (hw->phy.link_info.link_speed &
 	     ~(I40E_LINK_SPEED_2_5GB | I40E_LINK_SPEED_5GB)) &&
-	     !(pf->flags & I40E_FLAG_DCB_CAPABLE))
+	     !test_bit(I40E_FLAG_DCB_CAPABLE, pf->flags))
 		/* let firmware decide if the DCB should be disabled */
-		pf->flags |= I40E_FLAG_DCB_CAPABLE;
+		set_bit(I40E_FLAG_DCB_CAPABLE, pf->flags);
 
 	/* Not DCB capable or capability disabled */
-	if (!(pf->flags & I40E_FLAG_DCB_CAPABLE))
+	if (!test_bit(I40E_FLAG_DCB_CAPABLE, pf->flags))
 		return ret;
 
 	/* Ignore if event is not for Nearest Bridge */
@@ -9455,7 +9460,7 @@ static int i40e_handle_lldp_event(struct i40e_pf *pf,
 		     (I40E_LINK_SPEED_2_5GB | I40E_LINK_SPEED_5GB))) {
 			dev_warn(&pf->pdev->dev,
 				 "DCB is not supported for X710-T*L 2.5/5G speeds\n");
-			pf->flags &= ~I40E_FLAG_DCB_CAPABLE;
+			clear_bit(I40E_FLAG_DCB_CAPABLE, pf->flags);
 		} else {
 			dev_info(&pf->pdev->dev,
 				 "Failed querying DCB configuration data from firmware, err %pe aq_err %s\n",
@@ -9483,9 +9488,9 @@ static int i40e_handle_lldp_event(struct i40e_pf *pf,
 
 	/* Enable DCB tagging only when more than one TC */
 	if (i40e_dcb_get_num_tc(&hw->local_dcbx_config) > 1)
-		pf->flags |= I40E_FLAG_DCB_ENABLED;
+		set_bit(I40E_FLAG_DCB_ENA, pf->flags);
 	else
-		pf->flags &= ~I40E_FLAG_DCB_ENABLED;
+		clear_bit(I40E_FLAG_DCB_ENA, pf->flags);
 
 	set_bit(__I40E_PORT_SUSPENDED, pf->state);
 	/* Reconfiguration needed quiesce all VSIs */
@@ -9617,7 +9622,7 @@ u32 i40e_get_global_fd_count(struct i40e_pf *pf)
 static void i40e_reenable_fdir_sb(struct i40e_pf *pf)
 {
 	if (test_and_clear_bit(__I40E_FD_SB_AUTO_DISABLED, pf->state))
-		if ((pf->flags & I40E_FLAG_FD_SB_ENABLED) &&
+		if (test_bit(I40E_FLAG_FD_SB_ENA, pf->flags) &&
 		    (I40E_DEBUG_FD & pf->hw.debug_mask))
 			dev_info(&pf->pdev->dev, "FD Sideband/ntuple is being enabled since we have space in the table now\n");
 }
@@ -9638,7 +9643,7 @@ static void i40e_reenable_fdir_atr(struct i40e_pf *pf)
 					I40E_L3_SRC_MASK | I40E_L3_DST_MASK |
 					I40E_L4_SRC_MASK | I40E_L4_DST_MASK);
 
-		if ((pf->flags & I40E_FLAG_FD_ATR_ENABLED) &&
+		if (test_bit(I40E_FLAG_FD_ATR_ENA, pf->flags) &&
 		    (I40E_DEBUG_FD & pf->hw.debug_mask))
 			dev_info(&pf->pdev->dev, "ATR is being enabled since we have space in the table and there are no conflicting ntuple rules\n");
 	}
@@ -9955,7 +9960,7 @@ static void i40e_link_event(struct i40e_pf *pf)
 	if (pf->vf)
 		i40e_vc_notify_link_state(pf);
 
-	if (pf->flags & I40E_FLAG_PTP)
+	if (test_bit(I40E_FLAG_PTP_ENA, pf->flags))
 		i40e_ptp_set_increment(pf);
 #ifdef CONFIG_I40E_DCB
 	if (new_link == old_link)
@@ -9972,13 +9977,13 @@ static void i40e_link_event(struct i40e_pf *pf)
 		memset(&pf->tmp_cfg, 0, sizeof(pf->tmp_cfg));
 		err = i40e_dcb_sw_default_config(pf);
 		if (err) {
-			pf->flags &= ~(I40E_FLAG_DCB_CAPABLE |
-				       I40E_FLAG_DCB_ENABLED);
+			clear_bit(I40E_FLAG_DCB_CAPABLE, pf->flags);
+			clear_bit(I40E_FLAG_DCB_ENA, pf->flags);
 		} else {
 			pf->dcbx_cap = DCB_CAP_DCBX_HOST |
 				       DCB_CAP_DCBX_VER_IEEE;
-			pf->flags |= I40E_FLAG_DCB_CAPABLE;
-			pf->flags &= ~I40E_FLAG_DCB_ENABLED;
+			set_bit(I40E_FLAG_DCB_CAPABLE, pf->flags);
+			clear_bit(I40E_FLAG_DCB_ENA, pf->flags);
 		}
 	}
 #endif /* CONFIG_I40E_DCB */
@@ -10004,7 +10009,7 @@ static void i40e_watchdog_subtask(struct i40e_pf *pf)
 	pf->service_timer_previous = jiffies;
 	i40e_trace(state_watchdog, pf, pf->service_timer_previous);
 
-	if ((pf->flags & I40E_FLAG_LINK_POLLING_ENABLED) ||
+	if (test_bit(I40E_FLAG_LINK_POLLING_ENA, pf->flags) ||
 	    test_bit(__I40E_TEMP_LINK_POLLING, pf->state))
 		i40e_link_event(pf);
 
@@ -10015,7 +10020,7 @@ static void i40e_watchdog_subtask(struct i40e_pf *pf)
 		if (pf->vsi[i] && pf->vsi[i]->netdev)
 			i40e_update_stats(pf->vsi[i]);
 
-	if (pf->flags & I40E_FLAG_VEB_STATS_ENABLED) {
+	if (test_bit(I40E_FLAG_VEB_STATS_ENA, pf->flags)) {
 		/* Update the stats for the active switching components */
 		for (i = 0; i < I40E_MAX_VEB; i++)
 			if (pf->veb[i])
@@ -10108,7 +10113,7 @@ static void i40e_handle_link_event(struct i40e_pf *pf,
 		if ((status->link_info & I40E_AQ_MEDIA_AVAILABLE) &&
 		    (!(status->an_info & I40E_AQ_QUALIFIED_MODULE)) &&
 		    (!(status->link_info & I40E_AQ_LINK_UP)) &&
-		    (!(pf->flags & I40E_FLAG_LINK_DOWN_ON_CLOSE_ENABLED))) {
+		    (!test_bit(I40E_FLAG_LINK_DOWN_ON_CLOSE_ENA, pf->flags))) {
 			dev_err(&pf->pdev->dev,
 				"Rx/Tx is disabled on this device because an unsupported SFP module type was detected.\n");
 			dev_err(&pf->pdev->dev,
@@ -10416,7 +10421,7 @@ static int i40e_reconstitute_veb(struct i40e_veb *veb)
 	if (ret)
 		goto end_reconstitute;
 
-	if (pf->flags & I40E_FLAG_VEB_MODE_ENABLED)
+	if (test_bit(I40E_FLAG_VEB_MODE_ENA, pf->flags))
 		veb->bridge_mode = BRIDGE_MODE_VEB;
 	else
 		veb->bridge_mode = BRIDGE_MODE_VEPA;
@@ -10561,7 +10566,7 @@ static void i40e_fdir_sb_setup(struct i40e_pf *pf)
 			wr32(&pf->hw, I40E_GLQF_HKEY(i), hkey[i]);
 	}
 
-	if (!(pf->flags & I40E_FLAG_FD_SB_ENABLED))
+	if (!test_bit(I40E_FLAG_FD_SB_ENA, pf->flags))
 		return;
 
 	/* find existing VSI and see if it needs configuring */
@@ -10573,8 +10578,8 @@ static void i40e_fdir_sb_setup(struct i40e_pf *pf)
 				     pf->vsi[pf->lan_vsi]->seid, 0);
 		if (!vsi) {
 			dev_info(&pf->pdev->dev, "Couldn't create FDir VSI\n");
-			pf->flags &= ~I40E_FLAG_FD_SB_ENABLED;
-			pf->flags |= I40E_FLAG_FD_SB_INACTIVE;
+			clear_bit(I40E_FLAG_FD_SB_ENA, pf->flags);
+			set_bit(I40E_FLAG_FD_SB_INACTIVE, pf->flags);
 			return;
 		}
 	}
@@ -10951,14 +10956,14 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 			i40e_aq_set_dcb_parameters(hw, false, NULL);
 			dev_warn(&pf->pdev->dev,
 				 "DCB is not supported for X710-T*L 2.5/5G speeds\n");
-			pf->flags &= ~I40E_FLAG_DCB_CAPABLE;
+			clear_bit(I40E_FLAG_DCB_CAPABLE, pf->flags);
 		} else {
 			i40e_aq_set_dcb_parameters(hw, true, NULL);
 			ret = i40e_init_pf_dcb(pf);
 			if (ret) {
 				dev_info(&pf->pdev->dev, "DCB init failed %d, disabled\n",
 					 ret);
-				pf->flags &= ~I40E_FLAG_DCB_CAPABLE;
+				clear_bit(I40E_FLAG_DCB_CAPABLE, pf->flags);
 				/* Continue without DCB enabled */
 			}
 		}
@@ -11079,7 +11084,7 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 		wr32(hw, I40E_REG_MSS, val);
 	}
 
-	if (pf->hw_features & I40E_HW_RESTART_AUTONEG) {
+	if (test_bit(I40E_HW_RESTART_AUTONEG, pf->hw_features)) {
 		msleep(75);
 		ret = i40e_aq_set_link_restart_an(&pf->hw, true, NULL);
 		if (ret)
@@ -11089,7 +11094,7 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 					     pf->hw.aq.asq_last_status));
 	}
 	/* reinit the misc interrupt */
-	if (pf->flags & I40E_FLAG_MSIX_ENABLED) {
+	if (test_bit(I40E_FLAG_MSIX_ENA, pf->flags)) {
 		ret = i40e_setup_misc_vector(pf);
 		if (ret)
 			goto end_unlock;
@@ -11365,7 +11370,7 @@ static int i40e_set_num_rings_in_vsi(struct i40e_vsi *vsi)
 		if (!vsi->num_rx_desc)
 			vsi->num_rx_desc = ALIGN(I40E_DEFAULT_NUM_DESCRIPTORS,
 						 I40E_REQ_DESCRIPTOR_MULTIPLE);
-		if (pf->flags & I40E_FLAG_MSIX_ENABLED)
+		if (test_bit(I40E_FLAG_MSIX_ENA, pf->flags))
 			vsi->num_q_vectors = pf->num_lan_msix;
 		else
 			vsi->num_q_vectors = 1;
@@ -11683,7 +11688,7 @@ static int i40e_alloc_rings(struct i40e_vsi *vsi)
 		ring->count = vsi->num_tx_desc;
 		ring->size = 0;
 		ring->dcb_tc = 0;
-		if (vsi->back->hw_features & I40E_HW_WB_ON_ITR_CAPABLE)
+		if (test_bit(I40E_HW_WB_ON_ITR_CAPABLE, vsi->back->hw_features))
 			ring->flags = I40E_TXR_FLAGS_WB_ON_ITR;
 		ring->itr_setting = pf->tx_itr_default;
 		WRITE_ONCE(vsi->tx_rings[i], ring++);
@@ -11700,7 +11705,7 @@ static int i40e_alloc_rings(struct i40e_vsi *vsi)
 		ring->count = vsi->num_tx_desc;
 		ring->size = 0;
 		ring->dcb_tc = 0;
-		if (vsi->back->hw_features & I40E_HW_WB_ON_ITR_CAPABLE)
+		if (test_bit(I40E_HW_WB_ON_ITR_CAPABLE, vsi->back->hw_features))
 			ring->flags = I40E_TXR_FLAGS_WB_ON_ITR;
 		set_ring_xdp(ring);
 		ring->itr_setting = pf->tx_itr_default;
@@ -11764,7 +11769,7 @@ static int i40e_init_msix(struct i40e_pf *pf)
 	int v_actual;
 	int iwarp_requested = 0;
 
-	if (!(pf->flags & I40E_FLAG_MSIX_ENABLED))
+	if (!test_bit(I40E_FLAG_MSIX_ENA, pf->flags))
 		return -ENODEV;
 
 	/* The number of vectors we'll request will be comprised of:
@@ -11803,7 +11808,7 @@ static int i40e_init_msix(struct i40e_pf *pf)
 	vectors_left -= pf->num_lan_msix;
 
 	/* reserve one vector for sideband flow director */
-	if (pf->flags & I40E_FLAG_FD_SB_ENABLED) {
+	if (test_bit(I40E_FLAG_FD_SB_ENA, pf->flags)) {
 		if (vectors_left) {
 			pf->num_fdsb_msix = 1;
 			v_budget++;
@@ -11814,7 +11819,7 @@ static int i40e_init_msix(struct i40e_pf *pf)
 	}
 
 	/* can we reserve enough for iWARP? */
-	if (pf->flags & I40E_FLAG_IWARP_ENABLED) {
+	if (test_bit(I40E_FLAG_IWARP_ENA, pf->flags)) {
 		iwarp_requested = pf->num_iwarp_msix;
 
 		if (!vectors_left)
@@ -11826,7 +11831,7 @@ static int i40e_init_msix(struct i40e_pf *pf)
 	}
 
 	/* any vectors left over go for VMDq support */
-	if (pf->flags & I40E_FLAG_VMDQ_ENABLED) {
+	if (test_bit(I40E_FLAG_VMDQ_ENA, pf->flags)) {
 		if (!vectors_left) {
 			pf->num_vmdq_msix = 0;
 			pf->num_vmdq_qps = 0;
@@ -11883,7 +11888,7 @@ static int i40e_init_msix(struct i40e_pf *pf)
 	v_actual = i40e_reserve_msix_vectors(pf, v_budget);
 
 	if (v_actual < I40E_MIN_MSIX) {
-		pf->flags &= ~I40E_FLAG_MSIX_ENABLED;
+		clear_bit(I40E_FLAG_MSIX_ENA, pf->flags);
 		kfree(pf->msix_entries);
 		pf->msix_entries = NULL;
 		pci_disable_msix(pf->pdev);
@@ -11921,7 +11926,7 @@ static int i40e_init_msix(struct i40e_pf *pf)
 			pf->num_lan_msix = 1;
 			break;
 		case 3:
-			if (pf->flags & I40E_FLAG_IWARP_ENABLED) {
+			if (test_bit(I40E_FLAG_IWARP_ENA, pf->flags)) {
 				pf->num_lan_msix = 1;
 				pf->num_iwarp_msix = 1;
 			} else {
@@ -11929,7 +11934,7 @@ static int i40e_init_msix(struct i40e_pf *pf)
 			}
 			break;
 		default:
-			if (pf->flags & I40E_FLAG_IWARP_ENABLED) {
+			if (test_bit(I40E_FLAG_IWARP_ENA, pf->flags)) {
 				pf->num_iwarp_msix = min_t(int, (vec / 3),
 						 iwarp_requested);
 				pf->num_vmdq_vsis = min_t(int, (vec / 3),
@@ -11938,7 +11943,7 @@ static int i40e_init_msix(struct i40e_pf *pf)
 				pf->num_vmdq_vsis = min_t(int, (vec / 2),
 						  I40E_DEFAULT_NUM_VMDQ_VSI);
 			}
-			if (pf->flags & I40E_FLAG_FD_SB_ENABLED) {
+			if (test_bit(I40E_FLAG_FD_SB_ENA, pf->flags)) {
 				pf->num_fdsb_msix = 1;
 				vec--;
 			}
@@ -11950,22 +11955,20 @@ static int i40e_init_msix(struct i40e_pf *pf)
 		}
 	}
 
-	if ((pf->flags & I40E_FLAG_FD_SB_ENABLED) &&
-	    (pf->num_fdsb_msix == 0)) {
+	if (test_bit(I40E_FLAG_FD_SB_ENA, pf->flags) && pf->num_fdsb_msix == 0) {
 		dev_info(&pf->pdev->dev, "Sideband Flowdir disabled, not enough MSI-X vectors\n");
-		pf->flags &= ~I40E_FLAG_FD_SB_ENABLED;
-		pf->flags |= I40E_FLAG_FD_SB_INACTIVE;
+		clear_bit(I40E_FLAG_FD_SB_ENA, pf->flags);
+		set_bit(I40E_FLAG_FD_SB_INACTIVE, pf->flags);
 	}
-	if ((pf->flags & I40E_FLAG_VMDQ_ENABLED) &&
-	    (pf->num_vmdq_msix == 0)) {
+	if (test_bit(I40E_FLAG_VMDQ_ENA, pf->flags) && pf->num_vmdq_msix == 0) {
 		dev_info(&pf->pdev->dev, "VMDq disabled, not enough MSI-X vectors\n");
-		pf->flags &= ~I40E_FLAG_VMDQ_ENABLED;
+		clear_bit(I40E_FLAG_VMDQ_ENA, pf->flags);
 	}
 
-	if ((pf->flags & I40E_FLAG_IWARP_ENABLED) &&
-	    (pf->num_iwarp_msix == 0)) {
+	if (test_bit(I40E_FLAG_IWARP_ENA, pf->flags) &&
+	    pf->num_iwarp_msix == 0) {
 		dev_info(&pf->pdev->dev, "IWARP disabled, not enough MSI-X vectors\n");
-		pf->flags &= ~I40E_FLAG_IWARP_ENABLED;
+		clear_bit(I40E_FLAG_IWARP_ENA, pf->flags);
 	}
 	i40e_debug(&pf->hw, I40E_DEBUG_INIT,
 		   "MSI-X vector distribution: PF %d, VMDq %d, FDSB %d, iWARP %d\n",
@@ -12019,7 +12022,7 @@ static int i40e_vsi_alloc_q_vectors(struct i40e_vsi *vsi)
 	int err, v_idx, num_q_vectors;
 
 	/* if not MSIX, give the one vector only to the LAN VSI */
-	if (pf->flags & I40E_FLAG_MSIX_ENABLED)
+	if (test_bit(I40E_FLAG_MSIX_ENA, pf->flags))
 		num_q_vectors = vsi->num_q_vectors;
 	else if (vsi == pf->vsi[pf->lan_vsi])
 		num_q_vectors = 1;
@@ -12050,38 +12053,39 @@ static int i40e_init_interrupt_scheme(struct i40e_pf *pf)
 	int vectors = 0;
 	ssize_t size;
 
-	if (pf->flags & I40E_FLAG_MSIX_ENABLED) {
+	if (test_bit(I40E_FLAG_MSIX_ENA, pf->flags)) {
 		vectors = i40e_init_msix(pf);
 		if (vectors < 0) {
-			pf->flags &= ~(I40E_FLAG_MSIX_ENABLED	|
-				       I40E_FLAG_IWARP_ENABLED	|
-				       I40E_FLAG_RSS_ENABLED	|
-				       I40E_FLAG_DCB_CAPABLE	|
-				       I40E_FLAG_DCB_ENABLED	|
-				       I40E_FLAG_SRIOV_ENABLED	|
-				       I40E_FLAG_FD_SB_ENABLED	|
-				       I40E_FLAG_FD_ATR_ENABLED	|
-				       I40E_FLAG_VMDQ_ENABLED);
-			pf->flags |= I40E_FLAG_FD_SB_INACTIVE;
+			clear_bit(I40E_FLAG_MSIX_ENA, pf->flags);
+			clear_bit(I40E_FLAG_IWARP_ENA, pf->flags);
+			clear_bit(I40E_FLAG_RSS_ENA, pf->flags);
+			clear_bit(I40E_FLAG_DCB_CAPABLE, pf->flags);
+			clear_bit(I40E_FLAG_DCB_ENA, pf->flags);
+			clear_bit(I40E_FLAG_SRIOV_ENA, pf->flags);
+			clear_bit(I40E_FLAG_FD_SB_ENA, pf->flags);
+			clear_bit(I40E_FLAG_FD_ATR_ENA, pf->flags);
+			clear_bit(I40E_FLAG_VMDQ_ENA, pf->flags);
+			set_bit(I40E_FLAG_FD_SB_INACTIVE, pf->flags);
 
 			/* rework the queue expectations without MSIX */
 			i40e_determine_queue_usage(pf);
 		}
 	}
 
-	if (!(pf->flags & I40E_FLAG_MSIX_ENABLED) &&
-	    (pf->flags & I40E_FLAG_MSI_ENABLED)) {
+	if (!test_bit(I40E_FLAG_MSIX_ENA, pf->flags) &&
+	    test_bit(I40E_FLAG_MSI_ENA, pf->flags)) {
 		dev_info(&pf->pdev->dev, "MSI-X not available, trying MSI\n");
 		vectors = pci_enable_msi(pf->pdev);
 		if (vectors < 0) {
 			dev_info(&pf->pdev->dev, "MSI init failed - %d\n",
 				 vectors);
-			pf->flags &= ~I40E_FLAG_MSI_ENABLED;
+			clear_bit(I40E_FLAG_MSI_ENA, pf->flags);
 		}
 		vectors = 1;  /* one MSI or Legacy vector */
 	}
 
-	if (!(pf->flags & (I40E_FLAG_MSIX_ENABLED | I40E_FLAG_MSI_ENABLED)))
+	if (!test_bit(I40E_FLAG_MSI_ENA, pf->flags) &&
+	    !test_bit(I40E_FLAG_MSIX_ENA, pf->flags))
 		dev_info(&pf->pdev->dev, "MSI-X and MSI not available, falling back to Legacy IRQ\n");
 
 	/* set up vector assignment tracking */
@@ -12114,7 +12118,8 @@ static int i40e_restore_interrupt_scheme(struct i40e_pf *pf)
 	 * scheme. We need to re-enabled them here in order to attempt to
 	 * re-acquire the MSI or MSI-X vectors
 	 */
-	pf->flags |= (I40E_FLAG_MSIX_ENABLED | I40E_FLAG_MSI_ENABLED);
+	set_bit(I40E_FLAG_MSI_ENA, pf->flags);
+	set_bit(I40E_FLAG_MSIX_ENA, pf->flags);
 
 	err = i40e_init_interrupt_scheme(pf);
 	if (err)
@@ -12136,7 +12141,7 @@ static int i40e_restore_interrupt_scheme(struct i40e_pf *pf)
 	if (err)
 		goto err_unwind;
 
-	if (pf->flags & I40E_FLAG_IWARP_ENABLED)
+	if (test_bit(I40E_FLAG_IWARP_ENA, pf->flags))
 		i40e_client_update_msix_info(pf);
 
 	return 0;
@@ -12164,7 +12169,7 @@ static int i40e_setup_misc_vector_for_recovery_mode(struct i40e_pf *pf)
 {
 	int err;
 
-	if (pf->flags & I40E_FLAG_MSIX_ENABLED) {
+	if (test_bit(I40E_FLAG_MSIX_ENA, pf->flags)) {
 		err = i40e_setup_misc_vector(pf);
 
 		if (err) {
@@ -12174,7 +12179,7 @@ static int i40e_setup_misc_vector_for_recovery_mode(struct i40e_pf *pf)
 			return err;
 		}
 	} else {
-		u32 flags = pf->flags & I40E_FLAG_MSI_ENABLED ? 0 : IRQF_SHARED;
+		u32 flags = test_bit(I40E_FLAG_MSI_ENA, pf->flags) ? 0 : IRQF_SHARED;
 
 		err = request_irq(pf->pdev->irq, i40e_intr, flags,
 				  pf->int_name, pf);
@@ -12378,7 +12383,7 @@ int i40e_config_rss(struct i40e_vsi *vsi, u8 *seed, u8 *lut, u16 lut_size)
 {
 	struct i40e_pf *pf = vsi->back;
 
-	if (pf->hw_features & I40E_HW_RSS_AQ_CAPABLE)
+	if (test_bit(I40E_HW_RSS_AQ_CAPABLE, pf->hw_features))
 		return i40e_config_rss_aq(vsi, seed, lut, lut_size);
 	else
 		return i40e_config_rss_reg(vsi, seed, lut, lut_size);
@@ -12397,7 +12402,7 @@ int i40e_get_rss(struct i40e_vsi *vsi, u8 *seed, u8 *lut, u16 lut_size)
 {
 	struct i40e_pf *pf = vsi->back;
 
-	if (pf->hw_features & I40E_HW_RSS_AQ_CAPABLE)
+	if (test_bit(I40E_HW_RSS_AQ_CAPABLE, pf->hw_features))
 		return i40e_get_rss_aq(vsi, seed, lut, lut_size);
 	else
 		return i40e_get_rss_reg(vsi, seed, lut, lut_size);
@@ -12500,7 +12505,7 @@ int i40e_reconfig_rss_queues(struct i40e_pf *pf, int queue_count)
 	struct i40e_vsi *vsi = pf->vsi[pf->lan_vsi];
 	int new_rss_size;
 
-	if (!(pf->flags & I40E_FLAG_RSS_ENABLED))
+	if (!test_bit(I40E_FLAG_RSS_ENA, pf->flags))
 		return 0;
 
 	queue_count = min_t(int, queue_count, num_online_cpus());
@@ -12733,7 +12738,9 @@ static int i40e_sw_init(struct i40e_pf *pf)
 	u16 pow;
 
 	/* Set default capability flags */
-	pf->flags = I40E_FLAG_MSI_ENABLED | I40E_FLAG_MSIX_ENABLED;
+	bitmap_zero(pf->flags, I40E_PF_FLAGS_NBITS);
+	set_bit(I40E_FLAG_MSI_ENA, pf->flags);
+	set_bit(I40E_FLAG_MSIX_ENA, pf->flags);
 
 	/* Set default ITR */
 	pf->rx_itr_default = I40E_ITR_RX_DEF;
@@ -12753,14 +12760,14 @@ static int i40e_sw_init(struct i40e_pf *pf)
 	pf->rss_size_max = min_t(int, pf->rss_size_max, pow);
 
 	if (pf->hw.func_caps.rss) {
-		pf->flags |= I40E_FLAG_RSS_ENABLED;
+		set_bit(I40E_FLAG_RSS_ENA, pf->flags);
 		pf->alloc_rss_size = min_t(int, pf->rss_size_max,
 					   num_online_cpus());
 	}
 
 	/* MFP mode enabled */
 	if (pf->hw.func_caps.npar_enable || pf->hw.func_caps.flex10_enable) {
-		pf->flags |= I40E_FLAG_MFP_ENABLED;
+		set_bit(I40E_FLAG_MFP_ENA, pf->flags);
 		dev_info(&pf->pdev->dev, "MFP mode Enabled\n");
 		if (i40e_get_partition_bw_setting(pf)) {
 			dev_warn(&pf->pdev->dev,
@@ -12777,14 +12784,14 @@ static int i40e_sw_init(struct i40e_pf *pf)
 
 	if ((pf->hw.func_caps.fd_filters_guaranteed > 0) ||
 	    (pf->hw.func_caps.fd_filters_best_effort > 0)) {
-		pf->flags |= I40E_FLAG_FD_ATR_ENABLED;
+		set_bit(I40E_FLAG_FD_ATR_ENA, pf->flags);
 		pf->atr_sample_rate = I40E_DEFAULT_ATR_SAMPLE_RATE;
-		if (pf->flags & I40E_FLAG_MFP_ENABLED &&
+		if (test_bit(I40E_FLAG_MFP_ENA, pf->flags) &&
 		    pf->hw.num_partitions > 1)
 			dev_info(&pf->pdev->dev,
 				 "Flow Director Sideband mode Disabled in MFP mode\n");
 		else
-			pf->flags |= I40E_FLAG_FD_SB_ENABLED;
+			set_bit(I40E_FLAG_FD_SB_ENA, pf->flags);
 		pf->fdir_pf_filter_count =
 				 pf->hw.func_caps.fd_filters_guaranteed;
 		pf->hw.fdir_shared_filter_count =
@@ -12792,69 +12799,69 @@ static int i40e_sw_init(struct i40e_pf *pf)
 	}
 
 	if (pf->hw.mac.type == I40E_MAC_X722) {
-		pf->hw_features |= (I40E_HW_RSS_AQ_CAPABLE |
-				    I40E_HW_128_QP_RSS_CAPABLE |
-				    I40E_HW_ATR_EVICT_CAPABLE |
-				    I40E_HW_WB_ON_ITR_CAPABLE |
-				    I40E_HW_MULTIPLE_TCP_UDP_RSS_PCTYPE |
-				    I40E_HW_NO_PCI_LINK_CHECK |
-				    I40E_HW_USE_SET_LLDP_MIB |
-				    I40E_HW_GENEVE_OFFLOAD_CAPABLE |
-				    I40E_HW_PTP_L4_CAPABLE |
-				    I40E_HW_WOL_MC_MAGIC_PKT_WAKE |
-				    I40E_HW_OUTER_UDP_CSUM_CAPABLE);
+		set_bit(I40E_HW_RSS_AQ_CAPABLE, pf->hw_features);
+		set_bit(I40E_HW_128_QP_RSS_CAPABLE, pf->hw_features);
+		set_bit(I40E_HW_ATR_EVICT_CAPABLE, pf->hw_features);
+		set_bit(I40E_HW_WB_ON_ITR_CAPABLE, pf->hw_features);
+		set_bit(I40E_HW_MULTIPLE_TCP_UDP_RSS_PCTYPE, pf->hw_features);
+		set_bit(I40E_HW_NO_PCI_LINK_CHECK, pf->hw_features);
+		set_bit(I40E_HW_USE_SET_LLDP_MIB, pf->hw_features);
+		set_bit(I40E_HW_GENEVE_OFFLOAD_CAPABLE, pf->hw_features);
+		set_bit(I40E_HW_PTP_L4_CAPABLE, pf->hw_features);
+		set_bit(I40E_HW_WOL_MC_MAGIC_PKT_WAKE, pf->hw_features);
+		set_bit(I40E_HW_OUTER_UDP_CSUM_CAPABLE, pf->hw_features);
 
 #define I40E_FDEVICT_PCTYPE_DEFAULT 0xc03
 		if (rd32(&pf->hw, I40E_GLQF_FDEVICTENA(1)) !=
 		    I40E_FDEVICT_PCTYPE_DEFAULT) {
 			dev_warn(&pf->pdev->dev,
 				 "FD EVICT PCTYPES are not right, disable FD HW EVICT\n");
-			pf->hw_features &= ~I40E_HW_ATR_EVICT_CAPABLE;
+			clear_bit(I40E_HW_ATR_EVICT_CAPABLE, pf->hw_features);
 		}
 	} else if ((pf->hw.aq.api_maj_ver > 1) ||
 		   ((pf->hw.aq.api_maj_ver == 1) &&
 		    (pf->hw.aq.api_min_ver > 4))) {
 		/* Supported in FW API version higher than 1.4 */
-		pf->hw_features |= I40E_HW_GENEVE_OFFLOAD_CAPABLE;
+		set_bit(I40E_HW_GENEVE_OFFLOAD_CAPABLE, pf->hw_features);
 	}
 
 	/* Enable HW ATR eviction if possible */
-	if (pf->hw_features & I40E_HW_ATR_EVICT_CAPABLE)
-		pf->flags |= I40E_FLAG_HW_ATR_EVICT_ENABLED;
+	if (test_bit(I40E_HW_ATR_EVICT_CAPABLE, pf->hw_features))
+		set_bit(I40E_FLAG_HW_ATR_EVICT_ENA, pf->flags);
 
 	if ((pf->hw.mac.type == I40E_MAC_XL710) &&
 	    (((pf->hw.aq.fw_maj_ver == 4) && (pf->hw.aq.fw_min_ver < 33)) ||
 	    (pf->hw.aq.fw_maj_ver < 4))) {
-		pf->hw_features |= I40E_HW_RESTART_AUTONEG;
+		set_bit(I40E_HW_RESTART_AUTONEG, pf->hw_features);
 		/* No DCB support  for FW < v4.33 */
-		pf->hw_features |= I40E_HW_NO_DCB_SUPPORT;
+		set_bit(I40E_HW_NO_DCB_SUPPORT, pf->hw_features);
 	}
 
 	/* Disable FW LLDP if FW < v4.3 */
 	if ((pf->hw.mac.type == I40E_MAC_XL710) &&
 	    (((pf->hw.aq.fw_maj_ver == 4) && (pf->hw.aq.fw_min_ver < 3)) ||
 	    (pf->hw.aq.fw_maj_ver < 4)))
-		pf->hw_features |= I40E_HW_STOP_FW_LLDP;
+		set_bit(I40E_HW_STOP_FW_LLDP, pf->hw_features);
 
 	/* Use the FW Set LLDP MIB API if FW > v4.40 */
 	if ((pf->hw.mac.type == I40E_MAC_XL710) &&
 	    (((pf->hw.aq.fw_maj_ver == 4) && (pf->hw.aq.fw_min_ver >= 40)) ||
 	    (pf->hw.aq.fw_maj_ver >= 5)))
-		pf->hw_features |= I40E_HW_USE_SET_LLDP_MIB;
+		set_bit(I40E_HW_USE_SET_LLDP_MIB, pf->hw_features);
 
 	/* Enable PTP L4 if FW > v6.0 */
 	if (pf->hw.mac.type == I40E_MAC_XL710 &&
 	    pf->hw.aq.fw_maj_ver >= 6)
-		pf->hw_features |= I40E_HW_PTP_L4_CAPABLE;
+		set_bit(I40E_HW_PTP_L4_CAPABLE, pf->hw_features);
 
 	if (pf->hw.func_caps.vmdq && num_online_cpus() != 1) {
 		pf->num_vmdq_vsis = I40E_DEFAULT_NUM_VMDQ_VSI;
-		pf->flags |= I40E_FLAG_VMDQ_ENABLED;
+		set_bit(I40E_FLAG_VMDQ_ENA, pf->flags);
 		pf->num_vmdq_qps = i40e_default_queues_per_vmdq(pf);
 	}
 
 	if (pf->hw.func_caps.iwarp && num_online_cpus() != 1) {
-		pf->flags |= I40E_FLAG_IWARP_ENABLED;
+		set_bit(I40E_FLAG_IWARP_ENA, pf->flags);
 		/* IWARP needs one extra vector for CQP just like MISC.*/
 		pf->num_iwarp_msix = (int)num_online_cpus() + 1;
 	}
@@ -12871,7 +12878,7 @@ static int i40e_sw_init(struct i40e_pf *pf)
 #ifdef CONFIG_PCI_IOV
 	if (pf->hw.func_caps.num_vfs && pf->hw.partition_id == 1) {
 		pf->num_vf_qps = I40E_DEFAULT_QUEUES_PER_VF;
-		pf->flags |= I40E_FLAG_SRIOV_ENABLED;
+		set_bit(I40E_FLAG_SRIOV_ENA, pf->flags);
 		pf->num_req_vfs = min_t(int,
 					pf->hw.func_caps.num_vfs,
 					I40E_MAX_VF_COUNT);
@@ -12882,7 +12889,7 @@ static int i40e_sw_init(struct i40e_pf *pf)
 	pf->lan_vsi = I40E_NO_VSI;
 
 	/* By default FW has this off for performance reasons */
-	pf->flags &= ~I40E_FLAG_VEB_STATS_ENABLED;
+	clear_bit(I40E_FLAG_VEB_STATS_ENA, pf->flags);
 
 	/* set up queue assignment tracking */
 	size = sizeof(struct i40e_lump_tracking)
@@ -12901,8 +12908,8 @@ static int i40e_sw_init(struct i40e_pf *pf)
 		/* Link down on close must be on when total port shutdown
 		 * is enabled for a given port
 		 */
-		pf->flags |= (I40E_FLAG_TOTAL_PORT_SHUTDOWN_ENABLED |
-			      I40E_FLAG_LINK_DOWN_ON_CLOSE_ENABLED);
+		set_bit(I40E_FLAG_TOTAL_PORT_SHUTDOWN_ENA, pf->flags);
+		set_bit(I40E_FLAG_LINK_DOWN_ON_CLOSE_ENA, pf->flags);
 		dev_info(&pf->pdev->dev,
 			 "total-port-shutdown was enabled, link-down-on-close is forced on\n");
 	}
@@ -12928,31 +12935,31 @@ bool i40e_set_ntuple(struct i40e_pf *pf, netdev_features_t features)
 	 */
 	if (features & NETIF_F_NTUPLE) {
 		/* Enable filters and mark for reset */
-		if (!(pf->flags & I40E_FLAG_FD_SB_ENABLED))
+		if (!test_bit(I40E_FLAG_FD_SB_ENA, pf->flags))
 			need_reset = true;
 		/* enable FD_SB only if there is MSI-X vector and no cloud
 		 * filters exist
 		 */
 		if (pf->num_fdsb_msix > 0 && !pf->num_cloud_filters) {
-			pf->flags |= I40E_FLAG_FD_SB_ENABLED;
-			pf->flags &= ~I40E_FLAG_FD_SB_INACTIVE;
+			set_bit(I40E_FLAG_FD_SB_ENA, pf->flags);
+			clear_bit(I40E_FLAG_FD_SB_INACTIVE, pf->flags);
 		}
 	} else {
 		/* turn off filters, mark for reset and clear SW filter list */
-		if (pf->flags & I40E_FLAG_FD_SB_ENABLED) {
+		if (test_bit(I40E_FLAG_FD_SB_ENA, pf->flags)) {
 			need_reset = true;
 			i40e_fdir_filter_exit(pf);
 		}
-		pf->flags &= ~I40E_FLAG_FD_SB_ENABLED;
+		clear_bit(I40E_FLAG_FD_SB_ENA, pf->flags);
 		clear_bit(__I40E_FD_SB_AUTO_DISABLED, pf->state);
-		pf->flags |= I40E_FLAG_FD_SB_INACTIVE;
+		set_bit(I40E_FLAG_FD_SB_INACTIVE, pf->flags);
 
 		/* reset fd counters */
 		pf->fd_add_err = 0;
 		pf->fd_atr_cnt = 0;
 		/* if ATR was auto disabled it can be re-enabled. */
 		if (test_and_clear_bit(__I40E_FD_ATR_AUTO_DISABLED, pf->state))
-			if ((pf->flags & I40E_FLAG_FD_ATR_ENABLED) &&
+			if (test_bit(I40E_FLAG_FD_ATR_ENA, pf->flags) &&
 			    (I40E_DEBUG_FD & pf->hw.debug_mask))
 				dev_info(&pf->pdev->dev, "ATR re-enabled.\n");
 	}
@@ -13101,7 +13108,7 @@ static int i40e_get_phys_port_id(struct net_device *netdev,
 	struct i40e_pf *pf = np->vsi->back;
 	struct i40e_hw *hw = &pf->hw;
 
-	if (!(pf->hw_features & I40E_HW_PORT_ID_VALID))
+	if (!test_bit(I40E_HW_PORT_ID_VALID, pf->hw_features))
 		return -EOPNOTSUPP;
 
 	ppid->id_len = min_t(int, sizeof(hw->mac.port_addr), sizeof(ppid->id));
@@ -13130,7 +13137,7 @@ static int i40e_ndo_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 	struct i40e_pf *pf = np->vsi->back;
 	int err = 0;
 
-	if (!(pf->flags & I40E_FLAG_SRIOV_ENABLED))
+	if (!test_bit(I40E_FLAG_SRIOV_ENA, pf->flags))
 		return -EOPNOTSUPP;
 
 	if (vid) {
@@ -13230,9 +13237,9 @@ static int i40e_ndo_bridge_setlink(struct net_device *dev,
 			veb->bridge_mode = mode;
 			/* TODO: If no VFs or VMDq VSIs, disallow VEB mode */
 			if (mode == BRIDGE_MODE_VEB)
-				pf->flags |= I40E_FLAG_VEB_MODE_ENABLED;
+				set_bit(I40E_FLAG_VEB_MODE_ENA, pf->flags);
 			else
-				pf->flags &= ~I40E_FLAG_VEB_MODE_ENABLED;
+				clear_bit(I40E_FLAG_VEB_MODE_ENA, pf->flags);
 			i40e_do_reset(pf, I40E_PF_RESET_FLAG, true);
 			break;
 		}
@@ -13566,7 +13573,7 @@ static void i40e_queue_pair_enable_irq(struct i40e_vsi *vsi, int queue_pair)
 	struct i40e_hw *hw = &pf->hw;
 
 	/* All rings in a qp belong to the same qvector. */
-	if (pf->flags & I40E_FLAG_MSIX_ENABLED)
+	if (test_bit(I40E_FLAG_MSIX_ENA, pf->flags))
 		i40e_irq_dynamic_enable(vsi, rxr->q_vector->v_idx);
 	else
 		i40e_irq_dynamic_enable_icr0(pf);
@@ -13591,7 +13598,7 @@ static void i40e_queue_pair_disable_irq(struct i40e_vsi *vsi, int queue_pair)
 	 *
 	 * All rings in a qp belong to the same qvector.
 	 */
-	if (pf->flags & I40E_FLAG_MSIX_ENABLED) {
+	if (test_bit(I40E_FLAG_MSIX_ENA, pf->flags)) {
 		u32 intpf = vsi->base_vector + rxr->q_vector->v_idx;
 
 		wr32(hw, I40E_PFINT_DYN_CTLN(intpf - 1), 0);
@@ -13776,7 +13783,7 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
 			  NETIF_F_RXCSUM		|
 			  0;
 
-	if (!(pf->hw_features & I40E_HW_OUTER_UDP_CSUM_CAPABLE))
+	if (!test_bit(I40E_HW_OUTER_UDP_CSUM_CAPABLE, pf->hw_features))
 		netdev->gso_partial_features |= NETIF_F_GSO_UDP_TUNNEL_CSUM;
 
 	netdev->udp_tunnel_nic_info = &pf->udp_tunnel_nic;
@@ -13812,7 +13819,7 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
 		      NETIF_F_HW_VLAN_CTAG_TX	|
 		      NETIF_F_HW_VLAN_CTAG_RX;
 
-	if (!(pf->flags & I40E_FLAG_MFP_ENABLED))
+	if (!test_bit(I40E_FLAG_MFP_ENA, pf->flags))
 		hw_features |= NETIF_F_NTUPLE | NETIF_F_HW_TC;
 
 	netdev->hw_features |= hw_features | NETIF_F_LOOPBACK;
@@ -14003,7 +14010,7 @@ static int i40e_add_vsi(struct i40e_vsi *vsi)
 		 * negative logic - if it's set, we need to fiddle with
 		 * the VSI to disable source pruning.
 		 */
-		if (pf->flags & I40E_FLAG_SOURCE_PRUNING_DISABLED) {
+		if (test_bit(I40E_FLAG_SOURCE_PRUNING_DIS, pf->flags)) {
 			memset(&ctxt, 0, sizeof(ctxt));
 			ctxt.seid = pf->main_vsi_seid;
 			ctxt.pf_num = pf->hw.pf_id;
@@ -14025,7 +14032,7 @@ static int i40e_add_vsi(struct i40e_vsi *vsi)
 		}
 
 		/* MFP mode setup queue map and update VSI */
-		if ((pf->flags & I40E_FLAG_MFP_ENABLED) &&
+		if (test_bit(I40E_FLAG_MFP_ENA, pf->flags) &&
 		    !(pf->hw.func_caps.iscsi)) { /* NIC type PF */
 			memset(&ctxt, 0, sizeof(ctxt));
 			ctxt.seid = pf->main_vsi_seid;
@@ -14073,7 +14080,7 @@ static int i40e_add_vsi(struct i40e_vsi *vsi)
 		ctxt.uplink_seid = vsi->uplink_seid;
 		ctxt.connection_type = I40E_AQ_VSI_CONN_TYPE_NORMAL;
 		ctxt.flags = I40E_AQ_VSI_TYPE_PF;
-		if ((pf->flags & I40E_FLAG_VEB_MODE_ENABLED) &&
+		if (test_bit(I40E_FLAG_VEB_MODE_ENA, pf->flags) &&
 		    (i40e_is_vsi_uplink_mode_veb(vsi))) {
 			ctxt.info.valid_sections |=
 			     cpu_to_le16(I40E_AQ_VSI_PROP_SWITCH_VALID);
@@ -14121,7 +14128,7 @@ static int i40e_add_vsi(struct i40e_vsi *vsi)
 				cpu_to_le16(I40E_AQ_VSI_SW_ID_FLAG_ALLOW_LB);
 		}
 
-		if (vsi->back->flags & I40E_FLAG_IWARP_ENABLED) {
+		if (test_bit(I40E_FLAG_IWARP_ENA, vsi->back->flags)) {
 			ctxt.info.valid_sections |=
 				cpu_to_le16(I40E_AQ_VSI_PROP_QUEUE_OPT_VALID);
 			ctxt.info.queueing_opt_flags |=
@@ -14335,7 +14342,7 @@ static int i40e_vsi_setup_vectors(struct i40e_vsi *vsi)
 	/* In Legacy mode, we do not have to get any other vector since we
 	 * piggyback on the misc/ICR0 for queue interrupts.
 	*/
-	if (!(pf->flags & I40E_FLAG_MSIX_ENABLED))
+	if (!test_bit(I40E_FLAG_MSIX_ENA, pf->flags))
 		return ret;
 	if (vsi->num_q_vectors)
 		vsi->base_vector = i40e_get_lump(pf, pf->irq_pile,
@@ -14502,9 +14509,9 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 			 * already enabled, in which case we can't force VEPA
 			 * mode.
 			 */
-			if (!(pf->flags & I40E_FLAG_VEB_MODE_ENABLED)) {
+			if (!test_bit(I40E_FLAG_VEB_MODE_ENA, pf->flags)) {
 				veb->bridge_mode = BRIDGE_MODE_VEPA;
-				pf->flags &= ~I40E_FLAG_VEB_MODE_ENABLED;
+				clear_bit(I40E_FLAG_VEB_MODE_ENA, pf->flags);
 			}
 			i40e_config_bridge_mode(veb);
 		}
@@ -14600,8 +14607,8 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 		break;
 	}
 
-	if ((pf->hw_features & I40E_HW_RSS_AQ_CAPABLE) &&
-	    (vsi->type == I40E_VSI_VMDQ2)) {
+	if (test_bit(I40E_HW_RSS_AQ_CAPABLE, pf->hw_features) &&
+	    vsi->type == I40E_VSI_VMDQ2) {
 		ret = i40e_vsi_config_rss(vsi);
 	}
 	return vsi;
@@ -14843,7 +14850,7 @@ void i40e_veb_release(struct i40e_veb *veb)
 static int i40e_add_veb(struct i40e_veb *veb, struct i40e_vsi *vsi)
 {
 	struct i40e_pf *pf = veb->pf;
-	bool enable_stats = !!(pf->flags & I40E_FLAG_VEB_STATS_ENABLED);
+	bool enable_stats = !!test_bit(I40E_FLAG_VEB_STATS_ENA, pf->flags);
 	int ret;
 
 	ret = i40e_aq_add_veb(&pf->hw, veb->uplink_seid, vsi->seid,
@@ -15143,7 +15150,7 @@ static int i40e_setup_pf_switch(struct i40e_pf *pf, bool reinit, bool lock_acqui
 	*/
 
 	if ((pf->hw.pf_id == 0) &&
-	    !(pf->flags & I40E_FLAG_TRUE_PROMISC_SUPPORT)) {
+	    !test_bit(I40E_FLAG_TRUE_PROMISC_ENA, pf->flags)) {
 		flags = I40E_AQ_SET_SWITCH_CFG_PROMISC;
 		pf->last_sw_conf_flags = flags;
 	}
@@ -15210,7 +15217,7 @@ static int i40e_setup_pf_switch(struct i40e_pf *pf, bool reinit, bool lock_acqui
 	/* enable RSS in the HW, even for only one queue, as the stack can use
 	 * the hash
 	 */
-	if ((pf->flags & I40E_FLAG_RSS_ENABLED))
+	if (test_bit(I40E_FLAG_RSS_ENA, pf->flags))
 		i40e_pf_config_rss(pf);
 
 	/* fill in link information and enable LSE reporting */
@@ -15252,42 +15259,42 @@ static void i40e_determine_queue_usage(struct i40e_pf *pf)
 	queues_left = pf->hw.func_caps.num_tx_qp;
 
 	if ((queues_left == 1) ||
-	    !(pf->flags & I40E_FLAG_MSIX_ENABLED)) {
+	    !test_bit(I40E_FLAG_MSIX_ENA, pf->flags)) {
 		/* one qp for PF, no queues for anything else */
 		queues_left = 0;
 		pf->alloc_rss_size = pf->num_lan_qps = 1;
 
 		/* make sure all the fancies are disabled */
-		pf->flags &= ~(I40E_FLAG_RSS_ENABLED	|
-			       I40E_FLAG_IWARP_ENABLED	|
-			       I40E_FLAG_FD_SB_ENABLED	|
-			       I40E_FLAG_FD_ATR_ENABLED	|
-			       I40E_FLAG_DCB_CAPABLE	|
-			       I40E_FLAG_DCB_ENABLED	|
-			       I40E_FLAG_SRIOV_ENABLED	|
-			       I40E_FLAG_VMDQ_ENABLED);
-		pf->flags |= I40E_FLAG_FD_SB_INACTIVE;
-	} else if (!(pf->flags & (I40E_FLAG_RSS_ENABLED |
-				  I40E_FLAG_FD_SB_ENABLED |
-				  I40E_FLAG_FD_ATR_ENABLED |
-				  I40E_FLAG_DCB_CAPABLE))) {
+		clear_bit(I40E_FLAG_RSS_ENA, pf->flags);
+		clear_bit(I40E_FLAG_IWARP_ENA, pf->flags);
+		clear_bit(I40E_FLAG_FD_SB_ENA, pf->flags);
+		clear_bit(I40E_FLAG_FD_ATR_ENA, pf->flags);
+		clear_bit(I40E_FLAG_DCB_CAPABLE, pf->flags);
+		clear_bit(I40E_FLAG_DCB_ENA, pf->flags);
+		clear_bit(I40E_FLAG_SRIOV_ENA, pf->flags);
+		clear_bit(I40E_FLAG_VMDQ_ENA, pf->flags);
+		set_bit(I40E_FLAG_FD_SB_INACTIVE, pf->flags);
+	} else if (!test_bit(I40E_FLAG_RSS_ENA, pf->flags) &&
+		   !test_bit(I40E_FLAG_FD_SB_ENA, pf->flags) &&
+		   !test_bit(I40E_FLAG_FD_ATR_ENA, pf->flags) &&
+		   !test_bit(I40E_FLAG_DCB_CAPABLE, pf->flags)) {
 		/* one qp for PF */
 		pf->alloc_rss_size = pf->num_lan_qps = 1;
 		queues_left -= pf->num_lan_qps;
 
-		pf->flags &= ~(I40E_FLAG_RSS_ENABLED	|
-			       I40E_FLAG_IWARP_ENABLED	|
-			       I40E_FLAG_FD_SB_ENABLED	|
-			       I40E_FLAG_FD_ATR_ENABLED	|
-			       I40E_FLAG_DCB_ENABLED	|
-			       I40E_FLAG_VMDQ_ENABLED);
-		pf->flags |= I40E_FLAG_FD_SB_INACTIVE;
+		clear_bit(I40E_FLAG_RSS_ENA, pf->flags);
+		clear_bit(I40E_FLAG_IWARP_ENA, pf->flags);
+		clear_bit(I40E_FLAG_FD_SB_ENA, pf->flags);
+		clear_bit(I40E_FLAG_FD_ATR_ENA, pf->flags);
+		clear_bit(I40E_FLAG_DCB_ENA, pf->flags);
+		clear_bit(I40E_FLAG_VMDQ_ENA, pf->flags);
+		set_bit(I40E_FLAG_FD_SB_INACTIVE, pf->flags);
 	} else {
 		/* Not enough queues for all TCs */
-		if ((pf->flags & I40E_FLAG_DCB_CAPABLE) &&
-		    (queues_left < I40E_MAX_TRAFFIC_CLASS)) {
-			pf->flags &= ~(I40E_FLAG_DCB_CAPABLE |
-					I40E_FLAG_DCB_ENABLED);
+		if (test_bit(I40E_FLAG_DCB_CAPABLE, pf->flags) &&
+		    queues_left < I40E_MAX_TRAFFIC_CLASS) {
+			clear_bit(I40E_FLAG_DCB_CAPABLE, pf->flags);
+			clear_bit(I40E_FLAG_DCB_ENA, pf->flags);
 			dev_info(&pf->pdev->dev, "not enough queues for DCB. DCB is disabled.\n");
 		}
 
@@ -15300,24 +15307,24 @@ static void i40e_determine_queue_usage(struct i40e_pf *pf)
 		queues_left -= pf->num_lan_qps;
 	}
 
-	if (pf->flags & I40E_FLAG_FD_SB_ENABLED) {
+	if (test_bit(I40E_FLAG_FD_SB_ENA, pf->flags)) {
 		if (queues_left > 1) {
 			queues_left -= 1; /* save 1 queue for FD */
 		} else {
-			pf->flags &= ~I40E_FLAG_FD_SB_ENABLED;
-			pf->flags |= I40E_FLAG_FD_SB_INACTIVE;
+			clear_bit(I40E_FLAG_FD_SB_ENA, pf->flags);
+			set_bit(I40E_FLAG_FD_SB_INACTIVE, pf->flags);
 			dev_info(&pf->pdev->dev, "not enough queues for Flow Director. Flow Director feature is disabled\n");
 		}
 	}
 
-	if ((pf->flags & I40E_FLAG_SRIOV_ENABLED) &&
+	if (test_bit(I40E_FLAG_SRIOV_ENA, pf->flags) &&
 	    pf->num_vf_qps && pf->num_req_vfs && queues_left) {
 		pf->num_req_vfs = min_t(int, pf->num_req_vfs,
 					(queues_left / pf->num_vf_qps));
 		queues_left -= (pf->num_req_vfs * pf->num_vf_qps);
 	}
 
-	if ((pf->flags & I40E_FLAG_VMDQ_ENABLED) &&
+	if (test_bit(I40E_FLAG_VMDQ_ENA, pf->flags) &&
 	    pf->num_vmdq_vsis && pf->num_vmdq_qps && queues_left) {
 		pf->num_vmdq_vsis = min_t(int, pf->num_vmdq_vsis,
 					  (queues_left / pf->num_vmdq_qps));
@@ -15328,7 +15335,7 @@ static void i40e_determine_queue_usage(struct i40e_pf *pf)
 	dev_dbg(&pf->pdev->dev,
 		"qs_avail=%d FD SB=%d lan_qs=%d lan_tc0=%d vf=%d*%d vmdq=%d*%d, remaining=%d\n",
 		pf->hw.func_caps.num_tx_qp,
-		!!(pf->flags & I40E_FLAG_FD_SB_ENABLED),
+		!!test_bit(I40E_FLAG_FD_SB_ENA, pf->flags),
 		pf->num_lan_qps, pf->alloc_rss_size, pf->num_req_vfs,
 		pf->num_vf_qps, pf->num_vmdq_vsis, pf->num_vmdq_qps,
 		queues_left);
@@ -15352,7 +15359,8 @@ static int i40e_setup_pf_filter_control(struct i40e_pf *pf)
 	settings->hash_lut_size = I40E_HASH_LUT_SIZE_128;
 
 	/* Flow Director is enabled */
-	if (pf->flags & (I40E_FLAG_FD_SB_ENABLED | I40E_FLAG_FD_ATR_ENABLED))
+	if (test_bit(I40E_FLAG_FD_SB_ENA, pf->flags) ||
+	    test_bit(I40E_FLAG_FD_ATR_ENA, pf->flags))
 		settings->enable_fdir = true;
 
 	/* Ethtype and MACVLAN filters enabled for PF */
@@ -15384,21 +15392,21 @@ static void i40e_print_features(struct i40e_pf *pf)
 	i += scnprintf(&buf[i], REMAIN(i), " VSIs: %d QP: %d",
 		      pf->hw.func_caps.num_vsis,
 		      pf->vsi[pf->lan_vsi]->num_queue_pairs);
-	if (pf->flags & I40E_FLAG_RSS_ENABLED)
+	if (test_bit(I40E_FLAG_RSS_ENA, pf->flags))
 		i += scnprintf(&buf[i], REMAIN(i), " RSS");
-	if (pf->flags & I40E_FLAG_FD_ATR_ENABLED)
+	if (test_bit(I40E_FLAG_FD_ATR_ENA, pf->flags))
 		i += scnprintf(&buf[i], REMAIN(i), " FD_ATR");
-	if (pf->flags & I40E_FLAG_FD_SB_ENABLED) {
+	if (test_bit(I40E_FLAG_FD_SB_ENA, pf->flags)) {
 		i += scnprintf(&buf[i], REMAIN(i), " FD_SB");
 		i += scnprintf(&buf[i], REMAIN(i), " NTUPLE");
 	}
-	if (pf->flags & I40E_FLAG_DCB_CAPABLE)
+	if (test_bit(I40E_FLAG_DCB_CAPABLE, pf->flags))
 		i += scnprintf(&buf[i], REMAIN(i), " DCB");
 	i += scnprintf(&buf[i], REMAIN(i), " VxLAN");
 	i += scnprintf(&buf[i], REMAIN(i), " Geneve");
-	if (pf->flags & I40E_FLAG_PTP)
+	if (test_bit(I40E_FLAG_PTP_ENA, pf->flags))
 		i += scnprintf(&buf[i], REMAIN(i), " PTP");
-	if (pf->flags & I40E_FLAG_VEB_MODE_ENABLED)
+	if (test_bit(I40E_FLAG_VEB_MODE_ENA, pf->flags))
 		i += scnprintf(&buf[i], REMAIN(i), " VEB");
 	else
 		i += scnprintf(&buf[i], REMAIN(i), " VEPA");
@@ -15429,22 +15437,26 @@ static void i40e_get_platform_mac_addr(struct pci_dev *pdev, struct i40e_pf *pf)
  * @fec_cfg: FEC option to set in flags
  * @flags: ptr to flags in which we set FEC option
  **/
-void i40e_set_fec_in_flags(u8 fec_cfg, u32 *flags)
+void i40e_set_fec_in_flags(u8 fec_cfg, unsigned long *flags)
 {
-	if (fec_cfg & I40E_AQ_SET_FEC_AUTO)
-		*flags |= I40E_FLAG_RS_FEC | I40E_FLAG_BASE_R_FEC;
+	if (fec_cfg & I40E_AQ_SET_FEC_AUTO) {
+		set_bit(I40E_FLAG_RS_FEC, flags);
+		set_bit(I40E_FLAG_BASE_R_FEC, flags);
+	}
 	if ((fec_cfg & I40E_AQ_SET_FEC_REQUEST_RS) ||
 	    (fec_cfg & I40E_AQ_SET_FEC_ABILITY_RS)) {
-		*flags |= I40E_FLAG_RS_FEC;
-		*flags &= ~I40E_FLAG_BASE_R_FEC;
+		set_bit(I40E_FLAG_RS_FEC, flags);
+		clear_bit(I40E_FLAG_BASE_R_FEC, flags);
 	}
 	if ((fec_cfg & I40E_AQ_SET_FEC_REQUEST_KR) ||
 	    (fec_cfg & I40E_AQ_SET_FEC_ABILITY_KR)) {
-		*flags |= I40E_FLAG_BASE_R_FEC;
-		*flags &= ~I40E_FLAG_RS_FEC;
+		set_bit(I40E_FLAG_BASE_R_FEC, flags);
+		clear_bit(I40E_FLAG_RS_FEC, flags);
+	}
+	if (fec_cfg == 0) {
+		clear_bit(I40E_FLAG_RS_FEC, flags);
+		clear_bit(I40E_FLAG_BASE_R_FEC, flags);
 	}
-	if (fec_cfg == 0)
-		*flags &= ~(I40E_FLAG_RS_FEC | I40E_FLAG_BASE_R_FEC);
 }
 
 /**
@@ -15926,7 +15938,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * Ignore error return codes because if it was already disabled via
 	 * hardware settings this will fail
 	 */
-	if (pf->hw_features & I40E_HW_STOP_FW_LLDP) {
+	if (test_bit(I40E_HW_STOP_FW_LLDP, pf->hw_features)) {
 		dev_info(&pdev->dev, "Stopping firmware LLDP agent.\n");
 		i40e_aq_stop_lldp(hw, true, false, NULL);
 	}
@@ -15943,7 +15955,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	ether_addr_copy(hw->mac.perm_addr, hw->mac.addr);
 	i40e_get_port_mac_addr(hw, hw->mac.port_addr);
 	if (is_valid_ether_addr(hw->mac.port_addr))
-		pf->hw_features |= I40E_HW_PORT_ID_VALID;
+		set_bit(I40E_HW_PORT_ID_VALID, pf->hw_features);
 
 	i40e_ptp_alloc_pins(pf);
 	pci_set_drvdata(pdev, pf);
@@ -15953,10 +15965,10 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	status = i40e_get_fw_lldp_status(&pf->hw, &lldp_status);
 	(!status &&
 	 lldp_status == I40E_GET_FW_LLDP_STATUS_ENABLED) ?
-		(pf->flags &= ~I40E_FLAG_DISABLE_FW_LLDP) :
-		(pf->flags |= I40E_FLAG_DISABLE_FW_LLDP);
+		(clear_bit(I40E_FLAG_FW_LLDP_DIS, pf->flags)) :
+		(set_bit(I40E_FLAG_FW_LLDP_DIS, pf->flags));
 	dev_info(&pdev->dev,
-		 (pf->flags & I40E_FLAG_DISABLE_FW_LLDP) ?
+		 test_bit(I40E_FLAG_FW_LLDP_DIS, pf->flags) ?
 			"FW LLDP is disabled\n" :
 			"FW LLDP is enabled\n");
 
@@ -15966,7 +15978,8 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	err = i40e_init_pf_dcb(pf);
 	if (err) {
 		dev_info(&pdev->dev, "DCB init failed %d, disabled\n", err);
-		pf->flags &= ~(I40E_FLAG_DCB_CAPABLE | I40E_FLAG_DCB_ENABLED);
+		clear_bit(I40E_FLAG_DCB_CAPABLE, pf->flags);
+		clear_bit(I40E_FLAG_DCB_ENA, pf->flags);
 		/* Continue without DCB enabled */
 	}
 #endif /* CONFIG_I40E_DCB */
@@ -16034,11 +16047,11 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 #ifdef CONFIG_PCI_IOV
 	/* prep for VF support */
-	if ((pf->flags & I40E_FLAG_SRIOV_ENABLED) &&
-	    (pf->flags & I40E_FLAG_MSIX_ENABLED) &&
+	if (test_bit(I40E_FLAG_SRIOV_ENA, pf->flags) &&
+	    test_bit(I40E_FLAG_MSIX_ENA, pf->flags) &&
 	    !test_bit(__I40E_BAD_EEPROM, pf->state)) {
 		if (pci_num_vf(pdev))
-			pf->flags |= I40E_FLAG_VEB_MODE_ENABLED;
+			set_bit(I40E_FLAG_VEB_MODE_ENA, pf->flags);
 	}
 #endif
 	err = i40e_setup_pf_switch(pf, false, false);
@@ -16079,7 +16092,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		wr32(hw, I40E_REG_MSS, val);
 	}
 
-	if (pf->hw_features & I40E_HW_RESTART_AUTONEG) {
+	if (test_bit(I40E_HW_RESTART_AUTONEG, pf->hw_features)) {
 		msleep(75);
 		err = i40e_aq_set_link_restart_an(&pf->hw, true, NULL);
 		if (err)
@@ -16099,7 +16112,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * the misc functionality and queue processing is combined in
 	 * the same vector and that gets setup at open.
 	 */
-	if (pf->flags & I40E_FLAG_MSIX_ENABLED) {
+	if (test_bit(I40E_FLAG_MSIX_ENA, pf->flags)) {
 		err = i40e_setup_misc_vector(pf);
 		if (err) {
 			dev_info(&pdev->dev,
@@ -16112,8 +16125,8 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 #ifdef CONFIG_PCI_IOV
 	/* prep for VF support */
-	if ((pf->flags & I40E_FLAG_SRIOV_ENABLED) &&
-	    (pf->flags & I40E_FLAG_MSIX_ENABLED) &&
+	if (test_bit(I40E_FLAG_SRIOV_ENA, pf->flags) &&
+	    test_bit(I40E_FLAG_MSIX_ENA, pf->flags) &&
 	    !test_bit(__I40E_BAD_EEPROM, pf->state)) {
 		/* disable link interrupts for VFs */
 		val = rd32(hw, I40E_PFGEN_PORTMDIO_NUM);
@@ -16133,7 +16146,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 #endif /* CONFIG_PCI_IOV */
 
-	if (pf->flags & I40E_FLAG_IWARP_ENABLED) {
+	if (test_bit(I40E_FLAG_IWARP_ENA, pf->flags)) {
 		pf->iwarp_base_vector = i40e_get_lump(pf, pf->irq_pile,
 						      pf->num_iwarp_msix,
 						      I40E_IWARP_IRQ_PILE_ID);
@@ -16141,7 +16154,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			dev_info(&pdev->dev,
 				 "failed to get tracking for %d vectors for IWARP err=%d\n",
 				 pf->num_iwarp_msix, pf->iwarp_base_vector);
-			pf->flags &= ~I40E_FLAG_IWARP_ENABLED;
+			clear_bit(I40E_FLAG_IWARP_ENA, pf->flags);
 		}
 	}
 
@@ -16155,7 +16168,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		  round_jiffies(jiffies + pf->service_timer_period));
 
 	/* add this PF to client device list and launch a client service task */
-	if (pf->flags & I40E_FLAG_IWARP_ENABLED) {
+	if (test_bit(I40E_FLAG_IWARP_ENA, pf->flags)) {
 		err = i40e_lan_add_device(pf);
 		if (err)
 			dev_info(&pdev->dev, "Failed to add PF to client API service list: %d\n",
@@ -16168,7 +16181,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * and will report PCI Gen 1 x 1 by default so don't bother
 	 * checking them.
 	 */
-	if (!(pf->hw_features & I40E_HW_NO_PCI_LINK_CHECK)) {
+	if (!test_bit(I40E_HW_NO_PCI_LINK_CHECK, pf->hw_features)) {
 		char speed[PCI_SPEED_SIZE] = "Unknown";
 		char width[PCI_WIDTH_SIZE] = "Unknown";
 
@@ -16222,7 +16235,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	pf->hw.phy.link_info.requested_speeds = abilities.link_speed;
 
 	/* set the FEC config due to the board capabilities */
-	i40e_set_fec_in_flags(abilities.fec_cfg_curr_mod_ext_info, &pf->flags);
+	i40e_set_fec_in_flags(abilities.fec_cfg_curr_mod_ext_info, pf->flags);
 
 	/* get the supported phy types from the fw */
 	err = i40e_aq_get_phy_capabilities(hw, false, true, &abilities, NULL);
@@ -16249,10 +16262,10 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 						       pf->main_vsi_seid);
 
 	if ((pf->hw.device_id == I40E_DEV_ID_10G_BASE_T) ||
-		(pf->hw.device_id == I40E_DEV_ID_10G_BASE_T4))
-		pf->hw_features |= I40E_HW_PHY_CONTROLS_LEDS;
+	    (pf->hw.device_id == I40E_DEV_ID_10G_BASE_T4))
+		set_bit(I40E_HW_PHY_CONTROLS_LEDS, pf->hw_features);
 	if (pf->hw.device_id == I40E_DEV_ID_SFP_I_X722)
-		pf->hw_features |= I40E_HW_HAVE_CRT_RETIMER;
+		set_bit(I40E_HW_HAVE_CRT_RETIMER, pf->hw_features);
 	/* print a string summarizing features */
 	i40e_print_features(pf);
 
@@ -16321,10 +16334,10 @@ static void i40e_remove(struct pci_dev *pdev)
 		usleep_range(1000, 2000);
 	set_bit(__I40E_IN_REMOVE, pf->state);
 
-	if (pf->flags & I40E_FLAG_SRIOV_ENABLED) {
+	if (test_bit(I40E_FLAG_SRIOV_ENA, pf->flags)) {
 		set_bit(__I40E_VF_RESETS_DISABLED, pf->state);
 		i40e_free_vfs(pf);
-		pf->flags &= ~I40E_FLAG_SRIOV_ENABLED;
+		clear_bit(I40E_FLAG_SRIOV_ENA, pf->flags);
 	}
 	/* no more scheduling of any task */
 	set_bit(__I40E_SUSPENDED, pf->state);
@@ -16379,7 +16392,7 @@ static void i40e_remove(struct pci_dev *pdev)
 	i40e_cloud_filter_exit(pf);
 
 	/* remove attached clients */
-	if (pf->flags & I40E_FLAG_IWARP_ENABLED) {
+	if (test_bit(I40E_FLAG_IWARP_ENA, pf->flags)) {
 		ret_code = i40e_lan_del_device(pf);
 		if (ret_code)
 			dev_warn(&pdev->dev, "Failed to delete client device: %d\n",
@@ -16398,7 +16411,7 @@ static void i40e_remove(struct pci_dev *pdev)
 unmap:
 	/* Free MSI/legacy interrupt 0 when in recovery mode. */
 	if (test_bit(__I40E_RECOVERY_MODE, pf->state) &&
-	    !(pf->flags & I40E_FLAG_MSIX_ENABLED))
+	    !test_bit(I40E_FLAG_MSIX_ENA, pf->flags))
 		free_irq(pf->pdev->irq, pf);
 
 	/* shutdown the adminq */
@@ -16614,7 +16627,8 @@ static void i40e_shutdown(struct pci_dev *pdev)
 	 */
 	i40e_notify_client_of_netdev_close(pf->vsi[pf->lan_vsi], false);
 
-	if (pf->wol_en && (pf->hw_features & I40E_HW_WOL_MC_MAGIC_PKT_WAKE))
+	if (test_bit(I40E_HW_WOL_MC_MAGIC_PKT_WAKE, pf->hw_features) &&
+	    pf->wol_en)
 		i40e_enable_mc_magic_wake(pf);
 
 	i40e_prep_for_reset(pf);
@@ -16626,7 +16640,7 @@ static void i40e_shutdown(struct pci_dev *pdev)
 
 	/* Free MSI/legacy interrupt 0 when in recovery mode. */
 	if (test_bit(__I40E_RECOVERY_MODE, pf->state) &&
-	    !(pf->flags & I40E_FLAG_MSIX_ENABLED))
+	    !test_bit(I40E_FLAG_MSIX_ENA, pf->flags))
 		free_irq(pf->pdev->irq, pf);
 
 	/* Since we're going to destroy queues during the
@@ -16667,7 +16681,8 @@ static int __maybe_unused i40e_suspend(struct device *dev)
 	 */
 	i40e_notify_client_of_netdev_close(pf->vsi[pf->lan_vsi], false);
 
-	if (pf->wol_en && (pf->hw_features & I40E_HW_WOL_MC_MAGIC_PKT_WAKE))
+	if (test_bit(I40E_HW_WOL_MC_MAGIC_PKT_WAKE, pf->hw_features) &&
+	    pf->wol_en)
 		i40e_enable_mc_magic_wake(pf);
 
 	/* Since we're going to destroy queues during the
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index 65c714d0bfff..10fb83d2ffe1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -680,7 +680,7 @@ void i40e_ptp_rx_hang(struct i40e_pf *pf)
 	 * configured. We don't want to spuriously warn about Rx timestamp
 	 * hangs if we don't care about the timestamps.
 	 */
-	if (!(pf->flags & I40E_FLAG_PTP) || !pf->ptp_rx)
+	if (!test_bit(I40E_FLAG_PTP_ENA, pf->flags) || !pf->ptp_rx)
 		return;
 
 	spin_lock_bh(&pf->ptp_rx_lock);
@@ -733,7 +733,7 @@ void i40e_ptp_tx_hang(struct i40e_pf *pf)
 {
 	struct sk_buff *skb;
 
-	if (!(pf->flags & I40E_FLAG_PTP) || !pf->ptp_tx)
+	if (!test_bit(I40E_FLAG_PTP_ENA, pf->flags) || !pf->ptp_tx)
 		return;
 
 	/* Nothing to do if we're not already waiting for a timestamp */
@@ -771,7 +771,7 @@ void i40e_ptp_tx_hwtstamp(struct i40e_pf *pf)
 	u32 hi, lo;
 	u64 ns;
 
-	if (!(pf->flags & I40E_FLAG_PTP) || !pf->ptp_tx)
+	if (!test_bit(I40E_FLAG_PTP_ENA, pf->flags) || !pf->ptp_tx)
 		return;
 
 	/* don't attempt to timestamp if we don't have an skb */
@@ -818,7 +818,7 @@ void i40e_ptp_rx_hwtstamp(struct i40e_pf *pf, struct sk_buff *skb, u8 index)
 	/* Since we cannot turn off the Rx timestamp logic if the device is
 	 * doing Tx timestamping, check if Rx timestamping is configured.
 	 */
-	if (!(pf->flags & I40E_FLAG_PTP) || !pf->ptp_rx)
+	if (!test_bit(I40E_FLAG_PTP_ENA, pf->flags) || !pf->ptp_rx)
 		return;
 
 	hw = &pf->hw;
@@ -924,7 +924,7 @@ int i40e_ptp_get_ts_config(struct i40e_pf *pf, struct ifreq *ifr)
 {
 	struct hwtstamp_config *config = &pf->tstamp_config;
 
-	if (!(pf->flags & I40E_FLAG_PTP))
+	if (!test_bit(I40E_FLAG_PTP_ENA, pf->flags))
 		return -EOPNOTSUPP;
 
 	return copy_to_user(ifr->ifr_data, config, sizeof(*config)) ?
@@ -1211,7 +1211,7 @@ static int i40e_ptp_set_timestamp_mode(struct i40e_pf *pf,
 	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
 	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
 	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
-		if (!(pf->hw_features & I40E_HW_PTP_L4_CAPABLE))
+		if (!test_bit(I40E_HW_PTP_L4_CAPABLE, pf->hw_features))
 			return -ERANGE;
 		pf->ptp_rx = true;
 		tsyntype = I40E_PRTTSYN_CTL1_V1MESSTYPE0_MASK |
@@ -1225,7 +1225,7 @@ static int i40e_ptp_set_timestamp_mode(struct i40e_pf *pf,
 	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
 	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
 	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
-		if (!(pf->hw_features & I40E_HW_PTP_L4_CAPABLE))
+		if (!test_bit(I40E_HW_PTP_L4_CAPABLE, pf->hw_features))
 			return -ERANGE;
 		fallthrough;
 	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
@@ -1234,7 +1234,7 @@ static int i40e_ptp_set_timestamp_mode(struct i40e_pf *pf,
 		pf->ptp_rx = true;
 		tsyntype = I40E_PRTTSYN_CTL1_V2MESSTYPE0_MASK |
 			   I40E_PRTTSYN_CTL1_TSYNTYPE_V2;
-		if (pf->hw_features & I40E_HW_PTP_L4_CAPABLE) {
+		if (test_bit(I40E_HW_PTP_L4_CAPABLE, pf->hw_features)) {
 			tsyntype |= I40E_PRTTSYN_CTL1_UDP_ENA_MASK;
 			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
 		} else {
@@ -1308,7 +1308,7 @@ int i40e_ptp_set_ts_config(struct i40e_pf *pf, struct ifreq *ifr)
 	struct hwtstamp_config config;
 	int err;
 
-	if (!(pf->flags & I40E_FLAG_PTP))
+	if (!test_bit(I40E_FLAG_PTP_ENA, pf->flags))
 		return -EOPNOTSUPP;
 
 	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
@@ -1426,7 +1426,7 @@ static long i40e_ptp_create_clock(struct i40e_pf *pf)
 void i40e_ptp_save_hw_time(struct i40e_pf *pf)
 {
 	/* don't try to access the PTP clock if it's not enabled */
-	if (!(pf->flags & I40E_FLAG_PTP))
+	if (!test_bit(I40E_FLAG_PTP_ENA, pf->flags))
 		return;
 
 	i40e_ptp_gettimex(&pf->ptp_caps, &pf->ptp_prev_hw_time, NULL);
@@ -1483,7 +1483,7 @@ void i40e_ptp_init(struct i40e_pf *pf)
 	pf_id = (rd32(hw, I40E_PRTTSYN_CTL0) & I40E_PRTTSYN_CTL0_PF_ID_MASK) >>
 		I40E_PRTTSYN_CTL0_PF_ID_SHIFT;
 	if (hw->pf_id != pf_id) {
-		pf->flags &= ~I40E_FLAG_PTP;
+		clear_bit(I40E_FLAG_PTP_ENA, pf->flags);
 		dev_info(&pf->pdev->dev, "%s: PTP not supported on %s\n",
 			 __func__,
 			 netdev->name);
@@ -1504,7 +1504,7 @@ void i40e_ptp_init(struct i40e_pf *pf)
 
 		if (pf->hw.debug_mask & I40E_DEBUG_LAN)
 			dev_info(&pf->pdev->dev, "PHC enabled\n");
-		pf->flags |= I40E_FLAG_PTP;
+		set_bit(I40E_FLAG_PTP_ENA, pf->flags);
 
 		/* Ensure the clocks are running. */
 		regval = rd32(hw, I40E_PRTTSYN_CTL0);
@@ -1539,7 +1539,7 @@ void i40e_ptp_stop(struct i40e_pf *pf)
 	struct i40e_hw *hw = &pf->hw;
 	u32 regval;
 
-	pf->flags &= ~I40E_FLAG_PTP;
+	clear_bit(I40E_FLAG_PTP_ENA, pf->flags);
 	pf->ptp_tx = false;
 	pf->ptp_rx = false;
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index dd410b15000f..b82df5bdfac0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -464,7 +464,7 @@ static int i40e_add_del_fdir_tcp(struct i40e_vsi *vsi,
 			       &pf->fd_tcp6_filter_cnt);
 
 	if (add) {
-		if ((pf->flags & I40E_FLAG_FD_ATR_ENABLED) &&
+		if (test_bit(I40E_FLAG_FD_ATR_ENA, pf->flags) &&
 		    I40E_DEBUG_FD & pf->hw.debug_mask)
 			dev_info(&pf->pdev->dev, "Forcing ATR off, sideband rules for TCP/IPv4 flow being applied\n");
 		set_bit(__I40E_FD_ATR_AUTO_DISABLED, pf->state);
@@ -734,7 +734,7 @@ static void i40e_fd_handle_status(struct i40e_ring *rx_ring, u64 qword0_raw,
 		 * FD ATR/SB and then re-enable it when there is room.
 		 */
 		if (fcnt_prog >= (fcnt_avail - I40E_FDIR_BUFFER_FULL_MARGIN)) {
-			if ((pf->flags & I40E_FLAG_FD_SB_ENABLED) &&
+			if (test_bit(I40E_FLAG_FD_SB_ENA, pf->flags) &&
 			    !test_and_set_bit(__I40E_FD_SB_AUTO_DISABLED,
 					      pf->state))
 				if (I40E_DEBUG_FD & pf->hw.debug_mask)
@@ -1071,7 +1071,7 @@ static void i40e_enable_wb_on_itr(struct i40e_vsi *vsi,
 	if (q_vector->arm_wb_state)
 		return;
 
-	if (vsi->back->flags & I40E_FLAG_MSIX_ENABLED) {
+	if (test_bit(I40E_FLAG_MSIX_ENA, vsi->back->flags)) {
 		val = I40E_PFINT_DYN_CTLN_WB_ON_ITR_MASK |
 		      I40E_PFINT_DYN_CTLN_ITR_INDX_MASK; /* set noitr */
 
@@ -1095,7 +1095,7 @@ static void i40e_enable_wb_on_itr(struct i40e_vsi *vsi,
  **/
 void i40e_force_wb(struct i40e_vsi *vsi, struct i40e_q_vector *q_vector)
 {
-	if (vsi->back->flags & I40E_FLAG_MSIX_ENABLED) {
+	if (test_bit(I40E_FLAG_MSIX_ENA, vsi->back->flags)) {
 		u32 val = I40E_PFINT_DYN_CTLN_INTENA_MASK |
 			  I40E_PFINT_DYN_CTLN_ITR_INDX_MASK | /* set noitr */
 			  I40E_PFINT_DYN_CTLN_SWINT_TRIG_MASK |
@@ -2699,7 +2699,7 @@ static inline void i40e_update_enable_itr(struct i40e_vsi *vsi,
 	u32 intval;
 
 	/* If we don't have MSIX, then we only need to re-enable icr0 */
-	if (!(vsi->back->flags & I40E_FLAG_MSIX_ENABLED)) {
+	if (!test_bit(I40E_FLAG_MSIX_ENA, vsi->back->flags)) {
 		i40e_irq_dynamic_enable_icr0(vsi->back);
 		return;
 	}
@@ -2888,7 +2888,7 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	u16 i;
 
 	/* make sure ATR is enabled */
-	if (!(pf->flags & I40E_FLAG_FD_ATR_ENABLED))
+	if (!test_bit(I40E_FLAG_FD_ATR_ENA, pf->flags))
 		return;
 
 	if (test_bit(__I40E_FD_ATR_AUTO_DISABLED, pf->state))
@@ -2933,7 +2933,7 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	/* Due to lack of space, no more new filters can be programmed */
 	if (th->syn && test_bit(__I40E_FD_ATR_AUTO_DISABLED, pf->state))
 		return;
-	if (pf->flags & I40E_FLAG_HW_ATR_EVICT_ENABLED) {
+	if (test_bit(I40E_FLAG_HW_ATR_EVICT_ENA, pf->flags)) {
 		/* HW ATR eviction will take care of removing filters on FIN
 		 * and RST packets.
 		 */
@@ -2995,7 +2995,7 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 			I40E_TXD_FLTR_QW1_CNTINDEX_SHIFT) &
 			I40E_TXD_FLTR_QW1_CNTINDEX_MASK;
 
-	if (pf->flags & I40E_FLAG_HW_ATR_EVICT_ENABLED)
+	if (test_bit(I40E_FLAG_HW_ATR_EVICT_ENA, pf->flags))
 		dtype_cmd |= I40E_TXD_FLTR_QW1_ATR_MASK;
 
 	fdir_desc->qindex_flex_ptype_vsi = cpu_to_le32(flex_ptype);
@@ -3053,7 +3053,7 @@ static inline int i40e_tx_prepare_vlan_flags(struct sk_buff *skb,
 		tx_flags |= I40E_TX_FLAGS_SW_VLAN;
 	}
 
-	if (!(tx_ring->vsi->back->flags & I40E_FLAG_DCB_ENABLED))
+	if (!test_bit(I40E_FLAG_DCB_ENA, tx_ring->vsi->back->flags))
 		goto out;
 
 	/* Insert 802.1p priority into VLAN header */
@@ -3229,7 +3229,7 @@ static int i40e_tsyn(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	 * we are not already transmitting a packet to be timestamped
 	 */
 	pf = i40e_netdev_to_pf(tx_ring->netdev);
-	if (!(pf->flags & I40E_FLAG_PTP))
+	if (!test_bit(I40E_FLAG_PTP_ENA, pf->flags))
 		return 0;
 
 	if (pf->ptp_tx &&
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index 1c667408f687..cbc2eda0ddaa 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -92,8 +92,8 @@ enum i40e_dyn_idx {
 	BIT_ULL(I40E_FILTER_PCTYPE_NONF_MULTICAST_IPV6_UDP))
 
 #define i40e_pf_get_default_rss_hena(pf) \
-	(((pf)->hw_features & I40E_HW_MULTIPLE_TCP_UDP_RSS_PCTYPE) ? \
-	  I40E_DEFAULT_RSS_HENA_EXPANDED : I40E_DEFAULT_RSS_HENA)
+	(test_bit(I40E_HW_MULTIPLE_TCP_UDP_RSS_PCTYPE, (pf)->hw_features) ? \
+	 I40E_DEFAULT_RSS_HENA_EXPANDED : I40E_DEFAULT_RSS_HENA)
 
 /* Supported Rx Buffer Sizes (a multiple of 128) */
 #define I40E_RXBUFFER_256   256
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 08d7edccfb8d..8236baedfadd 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1808,7 +1808,7 @@ int i40e_alloc_vfs(struct i40e_pf *pf, u16 num_alloc_vfs)
 	if (pci_num_vf(pf->pdev) != num_alloc_vfs) {
 		ret = pci_enable_sriov(pf->pdev, num_alloc_vfs);
 		if (ret) {
-			pf->flags &= ~I40E_FLAG_VEB_MODE_ENABLED;
+			clear_bit(I40E_FLAG_VEB_MODE_ENA, pf->flags);
 			pf->num_alloc_vfs = 0;
 			goto err_iov;
 		}
@@ -1919,8 +1919,8 @@ int i40e_pci_sriov_configure(struct pci_dev *pdev, int num_vfs)
 	}
 
 	if (num_vfs) {
-		if (!(pf->flags & I40E_FLAG_VEB_MODE_ENABLED)) {
-			pf->flags |= I40E_FLAG_VEB_MODE_ENABLED;
+		if (!test_bit(I40E_FLAG_VEB_MODE_ENA, pf->flags)) {
+			set_bit(I40E_FLAG_VEB_MODE_ENA, pf->flags);
 			i40e_do_reset_safe(pf, I40E_PF_RESET_AND_REBUILD_FLAG);
 		}
 		ret = i40e_pci_sriov_enable(pdev, num_vfs);
@@ -1929,7 +1929,7 @@ int i40e_pci_sriov_configure(struct pci_dev *pdev, int num_vfs)
 
 	if (!pci_vfs_assigned(pf->pdev)) {
 		i40e_free_vfs(pf);
-		pf->flags &= ~I40E_FLAG_VEB_MODE_ENABLED;
+		clear_bit(I40E_FLAG_VEB_MODE_ENA, pf->flags);
 		i40e_do_reset_safe(pf, I40E_PF_RESET_AND_REBUILD_FLAG);
 	} else {
 		dev_warn(&pdev->dev, "Unable to free VFs because some are assigned to VMs.\n");
@@ -2137,14 +2137,14 @@ static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf, u8 *msg)
 	if (vf->driver_caps & VIRTCHNL_VF_OFFLOAD_RSS_PF) {
 		vfres->vf_cap_flags |= VIRTCHNL_VF_OFFLOAD_RSS_PF;
 	} else {
-		if ((pf->hw_features & I40E_HW_RSS_AQ_CAPABLE) &&
+		if (test_bit(I40E_HW_RSS_AQ_CAPABLE, pf->hw_features) &&
 		    (vf->driver_caps & VIRTCHNL_VF_OFFLOAD_RSS_AQ))
 			vfres->vf_cap_flags |= VIRTCHNL_VF_OFFLOAD_RSS_AQ;
 		else
 			vfres->vf_cap_flags |= VIRTCHNL_VF_OFFLOAD_RSS_REG;
 	}
 
-	if (pf->hw_features & I40E_HW_MULTIPLE_TCP_UDP_RSS_PCTYPE) {
+	if (test_bit(I40E_HW_MULTIPLE_TCP_UDP_RSS_PCTYPE, pf->hw_features)) {
 		if (vf->driver_caps & VIRTCHNL_VF_OFFLOAD_RSS_PCTYPE_V2)
 			vfres->vf_cap_flags |=
 				VIRTCHNL_VF_OFFLOAD_RSS_PCTYPE_V2;
@@ -2153,12 +2153,12 @@ static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf, u8 *msg)
 	if (vf->driver_caps & VIRTCHNL_VF_OFFLOAD_ENCAP)
 		vfres->vf_cap_flags |= VIRTCHNL_VF_OFFLOAD_ENCAP;
 
-	if ((pf->hw_features & I40E_HW_OUTER_UDP_CSUM_CAPABLE) &&
+	if (test_bit(I40E_HW_OUTER_UDP_CSUM_CAPABLE, pf->hw_features) &&
 	    (vf->driver_caps & VIRTCHNL_VF_OFFLOAD_ENCAP_CSUM))
 		vfres->vf_cap_flags |= VIRTCHNL_VF_OFFLOAD_ENCAP_CSUM;
 
 	if (vf->driver_caps & VIRTCHNL_VF_OFFLOAD_RX_POLLING) {
-		if (pf->flags & I40E_FLAG_MFP_ENABLED) {
+		if (test_bit(I40E_FLAG_MFP_ENA, pf->flags)) {
 			dev_err(&pf->pdev->dev,
 				"VF %d requested polling mode: this feature is supported only when the device is running in single function per port (SFP) mode\n",
 				 vf->vf_id);
@@ -2168,7 +2168,7 @@ static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf, u8 *msg)
 		vfres->vf_cap_flags |= VIRTCHNL_VF_OFFLOAD_RX_POLLING;
 	}
 
-	if (pf->hw_features & I40E_HW_WB_ON_ITR_CAPABLE) {
+	if (test_bit(I40E_HW_WB_ON_ITR_CAPABLE, pf->hw_features)) {
 		if (vf->driver_caps & VIRTCHNL_VF_OFFLOAD_WB_ON_ITR)
 			vfres->vf_cap_flags |=
 					VIRTCHNL_VF_OFFLOAD_WB_ON_ITR;
@@ -4841,7 +4841,7 @@ int i40e_ndo_set_vf_trust(struct net_device *netdev, int vf_id, bool setting)
 		goto out;
 	}
 
-	if (pf->flags & I40E_FLAG_MFP_ENABLED) {
+	if (test_bit(I40E_FLAG_MFP_ENA, pf->flags)) {
 		dev_err(&pf->pdev->dev, "Trusted VF not supported in MFP mode.\n");
 		ret = -EINVAL;
 		goto out;
-- 
2.41.0

