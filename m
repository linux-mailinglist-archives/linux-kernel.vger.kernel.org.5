Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F142A78DFDF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238726AbjH3THx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243477AbjH3LJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:09:35 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E08CC9;
        Wed, 30 Aug 2023 04:09:31 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37UB9L3u031932;
        Wed, 30 Aug 2023 06:09:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1693393761;
        bh=Kqr5dLZzkBx6wyWnqci/ghP0iyaEO83iLV+pRYlW/RE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=McQTqf2dbEFz6oGw5/Aw1oh2zx+i4ULgfDBEaacRJ6SVBeWYlCapIi3bM1JpGIiDy
         hxWj+001cMwBanTv0G5cLwWyG3L6fW1YifO0JYIPXYEbiOmM9CMvSD0Srl2pl4NERc
         MoWsy6M//nQzLHbjBzTTuDoQEz+Vr5pt44BdZPB4=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37UB9Lif021857
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Aug 2023 06:09:21 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 30
 Aug 2023 06:09:21 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 30 Aug 2023 06:09:20 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37UB9Li4054807;
        Wed, 30 Aug 2023 06:09:21 -0500
Received: from localhost (uda0501179.dhcp.ti.com [172.24.227.35])
        by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 37UB9KNF028948;
        Wed, 30 Aug 2023 06:09:20 -0500
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Simon Horman <horms@kernel.org>, Roger Quadros <rogerq@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Andrew Lunn <andrew@lunn.ch>,
        MD Danish Anwar <danishanwar@ti.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH net-next 4/4] net: ti: icssg_prueth: add TAPRIO offload support
Date:   Wed, 30 Aug 2023 16:38:47 +0530
Message-ID: <20230830110847.1219515-5-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830110847.1219515-1-danishanwar@ti.com>
References: <20230830110847.1219515-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roger Quadros <rogerq@kernel.org>

ICSSG dual-emac f/w supports Enhanced Scheduled Traffic (EST – defined
in P802.1Qbv/D2.2 that later got included in IEEE 802.1Q-2018)
configuration. EST allows express queue traffic to be scheduled
(placed) on the wire at specific repeatable time intervals. In
Linux kernel, EST configuration is done through tc command and
the taprio scheduler in the net core implements a software only
scheduler (SCH_TAPRIO). If the NIC is capable of EST configuration,
user indicate "flag 2" in the command which is then parsed by
taprio scheduler in net core and indicate that the command is to
be offloaded to h/w. taprio then offloads the command to the
driver by calling ndo_setup_tc() ndo ops. This patch implements
ndo_setup_tc() to offload EST configuration to ICSSG.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/Makefile             |   3 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c |   5 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |   7 +
 drivers/net/ethernet/ti/icssg/icssg_qos.c    | 294 +++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_qos.h    | 119 ++++++++
 5 files changed, 426 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.h

diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index 3adceff760ce..de348c20eff9 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -38,5 +38,6 @@ icssg-prueth-y := k3-cppi-desc-pool.o \
 		  icssg/icssg_mii_cfg.o \
 		  icssg/icssg_stats.o \
 		  icssg/icssg_ethtool.o \
-		  icssg/icssg_switchdev.o
+		  icssg/icssg_switchdev.o \
+		  icssg/icssg_qos.o
 obj-$(CONFIG_TI_ICSS_IEP) += icssg/icss_iep.o
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 5b7e7297ce23..3236af45aa4e 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1179,7 +1179,7 @@ static int emac_phy_connect(struct prueth_emac *emac)
 	return 0;
 }
 
-static u64 prueth_iep_gettime(void *clockops_data, struct ptp_system_timestamp *sts)
+u64 prueth_iep_gettime(void *clockops_data, struct ptp_system_timestamp *sts)
 {
 	u32 hi_rollover_count, hi_rollover_count_r;
 	struct prueth_emac *emac = clockops_data;
@@ -1416,6 +1416,8 @@ static int emac_ndo_open(struct net_device *ndev)
 		napi_enable(&emac->tx_chns[i].napi_tx);
 	napi_enable(&emac->napi_rx);
 
+	icssg_qos_init(ndev);
+
 	/* start PHY */
 	phy_start(ndev->phydev);
 
@@ -1695,6 +1697,7 @@ static const struct net_device_ops emac_netdev_ops = {
 	.ndo_set_rx_mode = emac_ndo_set_rx_mode,
 	.ndo_eth_ioctl = emac_ndo_ioctl,
 	.ndo_get_stats64 = emac_ndo_get_stats64,
+	.ndo_setup_tc = icssg_qos_ndo_setup_tc,
 };
 
 /* get emac_port corresponding to eth_node name */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 6e18da06c786..43b67213d8c7 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -37,6 +37,7 @@
 #include "icssg_config.h"
 #include "icss_iep.h"
 #include "icssg_switch_map.h"
+#include "icssg_qos.h"
 
 #define PRUETH_MAX_MTU          (2000 - ETH_HLEN - ETH_FCS_LEN)
 #define PRUETH_MIN_PKT_SIZE     (VLAN_ETH_ZLEN)
@@ -186,6 +187,9 @@ struct prueth_emac {
 	struct devlink_port devlink_port;
 	int port_vlan;
 
+	struct prueth_qos qos;
+	struct work_struct ts_work;
+
 	struct delayed_work stats_work;
 	u64 stats[ICSSG_NUM_STATS];
 };
@@ -331,4 +335,7 @@ void icssg_set_pvid(struct prueth *prueth, u8 vid, u8 port);
 void emac_stats_work_handler(struct work_struct *work);
 void emac_update_hardware_stats(struct prueth_emac *emac);
 int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name);
+
+u64 prueth_iep_gettime(void *clockops_data, struct ptp_system_timestamp *sts);
+
 #endif /* __NET_TI_ICSSG_PRUETH_H */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.c b/drivers/net/ethernet/ti/icssg/icssg_qos.c
new file mode 100644
index 000000000000..e8102703e257
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssg/icssg_qos.c
@@ -0,0 +1,294 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Texas Instruments ICSSG PRUETH QoS submodule
+ * Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#include <linux/printk.h>
+#include "icssg_prueth.h"
+#include "icssg_switch_map.h"
+
+static void icssg_qos_tas_init(struct net_device *ndev);
+
+void icssg_qos_init(struct net_device *ndev)
+{
+	icssg_qos_tas_init(ndev);
+
+	/* IET init goes here */
+}
+
+static void tas_update_fw_list_pointers(struct prueth_emac *emac)
+{
+	struct tas_config *tas = &emac->qos.tas.config;
+
+	if ((readb(tas->active_list)) == TAS_LIST0) {
+		tas->fw_active_list = (struct tas_firmware_list __force *)emac->dram.va +
+				       TAS_GATE_MASK_LIST0;
+		tas->fw_shadow_list = (struct tas_firmware_list __force *)emac->dram.va +
+				       TAS_GATE_MASK_LIST1;
+	} else {
+		tas->fw_active_list = (struct tas_firmware_list __force *)emac->dram.va +
+				       TAS_GATE_MASK_LIST1;
+		tas->fw_shadow_list = (struct tas_firmware_list __force *)emac->dram.va +
+				       TAS_GATE_MASK_LIST0;
+	}
+}
+
+static void tas_update_maxsdu_table(struct prueth_emac *emac)
+{
+	struct tas_config *tas = &emac->qos.tas.config;
+	u16 __iomem *max_sdu_tbl_ptr;
+	u8 gate_idx;
+
+	/* update the maxsdu table */
+	max_sdu_tbl_ptr = emac->dram.va + TAS_QUEUE_MAX_SDU_LIST;
+
+	for (gate_idx = 0; gate_idx < TAS_MAX_NUM_QUEUES; gate_idx++)
+		writew(tas->max_sdu_table.max_sdu[gate_idx], &max_sdu_tbl_ptr[gate_idx]);
+}
+
+static void tas_reset(struct prueth_emac *emac)
+{
+	struct tas_config *tas = &emac->qos.tas.config;
+	int i;
+
+	for (i = 0; i < TAS_MAX_NUM_QUEUES; i++)
+		tas->max_sdu_table.max_sdu[i] = 2048;
+
+	tas_update_maxsdu_table(emac);
+
+	writeb(TAS_LIST0, tas->active_list);
+
+	memset_io((void __iomem __force *)tas->fw_active_list, 0, sizeof(*tas->fw_active_list));
+	memset_io((void __iomem __force *)tas->fw_shadow_list, 0, sizeof(*tas->fw_shadow_list));
+}
+
+static int tas_set_state(struct prueth_emac *emac, enum tas_state state)
+{
+	struct tas_config *tas = &emac->qos.tas.config;
+	int ret;
+
+	if (tas->state == state)
+		return 0;
+
+	switch (state) {
+	case TAS_STATE_RESET:
+		tas_reset(emac);
+		ret = emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_RESET);
+		tas->state = TAS_STATE_RESET;
+		break;
+	case TAS_STATE_ENABLE:
+		ret = emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_ENABLE);
+		tas->state = TAS_STATE_ENABLE;
+		break;
+	case TAS_STATE_DISABLE:
+		ret = emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_DISABLE);
+		tas->state = TAS_STATE_DISABLE;
+		break;
+	default:
+		netdev_err(emac->ndev, "%s: unsupported state\n", __func__);
+		ret = -EINVAL;
+		break;
+	}
+
+	if (ret)
+		netdev_err(emac->ndev, "TAS set state failed %d\n", ret);
+	return ret;
+}
+
+static int tas_set_trigger_list_change(struct prueth_emac *emac)
+{
+	struct tc_taprio_qopt_offload *admin_list = emac->qos.tas.taprio_admin;
+	struct tas_config *tas = &emac->qos.tas.config;
+	struct ptp_system_timestamp sts;
+	u32 change_cycle_count;
+	u32 cycle_time;
+	u64 base_time;
+	u64 cur_time;
+
+	cycle_time = admin_list->cycle_time - 4; /* -4ns to compensate for IEP wraparound time */
+	base_time = admin_list->base_time;
+	cur_time = prueth_iep_gettime(emac, &sts);
+
+	if (base_time > cur_time)
+		change_cycle_count = DIV_ROUND_UP_ULL(base_time - cur_time, cycle_time);
+	else
+		change_cycle_count = 1;
+
+	writel(cycle_time, emac->dram.va + TAS_ADMIN_CYCLE_TIME);
+	writel(change_cycle_count, emac->dram.va + TAS_CONFIG_CHANGE_CYCLE_COUNT);
+	writeb(admin_list->num_entries, emac->dram.va + TAS_ADMIN_LIST_LENGTH);
+
+	/* config_change cleared by f/w to ack reception of new shadow list */
+	writeb(1, &tas->config_list->config_change);
+	/* config_pending cleared by f/w when new shadow list is copied to active list */
+	writeb(1, &tas->config_list->config_pending);
+
+	return emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_TRIGGER);
+}
+
+static int tas_update_oper_list(struct prueth_emac *emac)
+{
+	struct tc_taprio_qopt_offload *admin_list = emac->qos.tas.taprio_admin;
+	struct tas_config *tas = &emac->qos.tas.config;
+	u32 tas_acc_gate_close_time = 0;
+	u8 idx, gate_idx, val;
+	int ret;
+
+	tas_update_fw_list_pointers(emac);
+
+	for (idx = 0; idx < admin_list->num_entries; idx++) {
+		tas->fw_shadow_list->gate_mask_list[idx] = admin_list->entries[idx].gate_mask;
+		tas_acc_gate_close_time += admin_list->entries[idx].interval;
+
+		/* extend last entry till end of cycle time */
+		if (idx == admin_list->num_entries - 1)
+			tas->fw_shadow_list->win_end_time_list[idx] = admin_list->cycle_time;
+		else
+			tas->fw_shadow_list->win_end_time_list[idx] = tas_acc_gate_close_time;
+	}
+
+	/* clear remaining entries */
+	for (idx = admin_list->num_entries; idx < TAS_MAX_CMD_LISTS; idx++) {
+		tas->fw_shadow_list->gate_mask_list[idx] = 0;
+		tas->fw_shadow_list->win_end_time_list[idx] = 0;
+	}
+
+	/* update the Array of gate close time for each queue in each window */
+	for (idx = 0 ; idx < admin_list->num_entries; idx++) {
+		/* On Linux, only PRUETH_MAX_TX_QUEUES are supported per port */
+		for (gate_idx = 0; gate_idx < PRUETH_MAX_TX_QUEUES; gate_idx++) {
+			u32 gate_close_time = 0;
+
+			if (tas->fw_shadow_list->gate_mask_list[idx] & BIT(gate_idx))
+				gate_close_time = tas->fw_shadow_list->win_end_time_list[idx];
+
+			tas->fw_shadow_list->gate_close_time_list[idx][gate_idx] = gate_close_time;
+		}
+	}
+
+	/* tell f/w to swap active & shadow list */
+	ret = tas_set_trigger_list_change(emac);
+	if (ret) {
+		netdev_err(emac->ndev, "failed to swap f/w config list: %d\n", ret);
+		return ret;
+	}
+
+	/* Wait for completion */
+	ret = readb_poll_timeout(&tas->config_list->config_change, val, !val,
+				 USEC_PER_MSEC, 10 * USEC_PER_MSEC);
+	if (ret) {
+		netdev_err(emac->ndev, "TAS list change completion time out\n");
+		return ret;
+	}
+
+	tas_update_fw_list_pointers(emac);
+
+	return 0;
+}
+
+static int emac_set_taprio(struct prueth_emac *emac)
+{
+	struct tc_taprio_qopt_offload *taprio = emac->qos.tas.taprio_admin;
+	int ret;
+
+	if (taprio->cmd == TAPRIO_CMD_DESTROY)
+		return tas_set_state(emac, TAS_STATE_DISABLE);
+
+	if (taprio->cmd != TAPRIO_CMD_REPLACE)
+		return -EOPNOTSUPP;
+
+	ret = tas_update_oper_list(emac);
+	if (ret)
+		return ret;
+
+	return tas_set_state(emac, TAS_STATE_ENABLE);
+}
+
+static void emac_cp_taprio(struct tc_taprio_qopt_offload *from,
+			   struct tc_taprio_qopt_offload *to)
+{
+	int i;
+
+	*to = *from;
+	for (i = 0; i < from->num_entries; i++)
+		to->entries[i] = from->entries[i];
+}
+
+static int emac_setup_taprio(struct net_device *ndev, struct tc_taprio_qopt_offload *taprio)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct tc_taprio_qopt_offload *est_new;
+	int ret, idx;
+
+	if (!netif_running(ndev)) {
+		netdev_err(ndev, "interface is down, link speed unknown\n");
+		return -ENETDOWN;
+	}
+
+	if (taprio->cycle_time_extension) {
+		netdev_err(ndev, "Failed to set cycle time extension");
+		return -EOPNOTSUPP;
+	}
+
+	if (taprio->num_entries == 0 ||
+	    taprio->num_entries > TAS_MAX_CMD_LISTS) {
+		netdev_err(ndev, "unsupported num_entries %ld in taprio config\n",
+			   taprio->num_entries);
+		return -EINVAL;
+	}
+
+	/* If any time_interval is 0 in between the list, then exit */
+	for (idx = 0; idx < taprio->num_entries; idx++) {
+		if (taprio->entries[idx].interval == 0) {
+			netdev_err(ndev, "0 interval in taprio config not supported\n");
+			return -EINVAL;
+		}
+	}
+
+	if (emac->qos.tas.taprio_admin)
+		devm_kfree(&ndev->dev, emac->qos.tas.taprio_admin);
+
+	est_new = devm_kzalloc(&ndev->dev,
+			       struct_size(est_new, entries, taprio->num_entries),
+			       GFP_KERNEL);
+	emac_cp_taprio(taprio, est_new);
+	emac->qos.tas.taprio_admin = est_new;
+	ret = emac_set_taprio(emac);
+	if (ret)
+		devm_kfree(&ndev->dev, est_new);
+
+	return ret;
+}
+
+int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
+			   void *type_data)
+{
+	switch (type) {
+	case TC_SETUP_QDISC_TAPRIO:
+		return emac_setup_taprio(ndev, type_data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static void icssg_qos_tas_init(struct net_device *ndev)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	bool need_setup = false;
+	struct tas_config *tas;
+
+	tas = &emac->qos.tas.config;
+
+	if (tas->state == TAS_STATE_ENABLE)
+		need_setup = true;
+
+	tas->config_list = emac->dram.va + TAS_CONFIG_CHANGE_TIME;
+	tas->active_list = emac->dram.va + TAS_ACTIVE_LIST_INDEX;
+
+	tas_update_fw_list_pointers(emac);
+
+	tas_set_state(emac, TAS_STATE_RESET);
+
+	if (need_setup)
+		emac_set_taprio(emac);
+}
diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.h b/drivers/net/ethernet/ti/icssg/icssg_qos.h
new file mode 100644
index 000000000000..645c367bf9d0
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssg/icssg_qos.h
@@ -0,0 +1,119 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#ifndef __NET_TI_ICSSG_QOS_H
+#define __NET_TI_ICSSG_QOS_H
+
+#include <linux/atomic.h>
+#include <linux/netdevice.h>
+#include <net/pkt_sched.h>
+
+/**
+ * Maximum number of gate command entries in each list.
+ */
+#define TAS_MAX_CMD_LISTS   (16)
+
+/**
+ * Maximum number of transmit queues supported by implementation
+ */
+#define TAS_MAX_NUM_QUEUES  (8)
+
+/**
+ * Minimum cycle time supported by implementation (in ns)
+ */
+#define TAS_MIN_CYCLE_TIME  (1000000)
+
+/**
+ * Minimum TAS window duration supported by implementation (in ns)
+ */
+#define TAS_MIN_WINDOW_DURATION  (10000)
+
+/**
+ * List number 0 or 1. Also the value at memory location TAS_ACTIVE_LIST_INDEX
+ */
+enum tas_list_num {
+	TAS_LIST0 = 0,
+	TAS_LIST1 = 1
+};
+
+/**
+ * state of TAS in f/w
+ */
+enum tas_state {
+	/* PRU's are idle */
+	TAS_STATE_DISABLE = 0,
+	/* Enable TAS */
+	TAS_STATE_ENABLE = 1,
+	/* Firmware will reset the state machine */
+	TAS_STATE_RESET = 2,
+};
+
+/**
+ * Config state machine variables. See IEEE Std 802.1Q-2018 8.6.8.4
+ */
+struct tas_config_list {
+	/* New list is copied at this time */
+	u64 config_change_time;
+	/* config change error counter, incremented if
+	 * admin->BaseTime < current time and TAS_enabled is true
+	 */
+	u32 config_change_error_counter;
+	/* True if list update is pending */
+	u8 config_pending;
+	/* Set to true when application trigger updating of admin list
+	 * to active list, cleared when configChangeTime is updated
+	 */
+	u8 config_change;
+};
+
+/**
+ * Max SDU table. See IEEE Std 802.1Q-2018 12.29.1.1
+ */
+struct tas_max_sdu_table {
+	u16 max_sdu[TAS_MAX_NUM_QUEUES];
+};
+
+/**
+ * TAS List Structure based on firmware memory map
+ */
+struct tas_firmware_list {
+	/* window gate mask list */
+	u8 gate_mask_list[TAS_MAX_CMD_LISTS];
+	/* window end time list */
+	u32 win_end_time_list[TAS_MAX_CMD_LISTS];
+	/* Array of gate close time for each queue in each window */
+	u32 gate_close_time_list[TAS_MAX_CMD_LISTS][TAS_MAX_NUM_QUEUES];
+};
+
+/**
+ * Main Time Aware Shaper Handle
+ */
+struct tas_config {
+	enum tas_state state;
+	struct tas_max_sdu_table max_sdu_table;
+	/* Config change variables */
+	struct tas_config_list __iomem *config_list;
+	/* Whether list 1 or list 2 is the operating list */
+	u8 __iomem *active_list;
+	/* active List pointer, used by firmware */
+	struct tas_firmware_list *fw_active_list;
+	/* shadow List pointer, used by driver */
+	struct tas_firmware_list *fw_shadow_list;
+};
+
+struct prueth_qos_tas {
+	struct tc_taprio_qopt_offload *taprio_admin;
+	struct tc_taprio_qopt_offload *taprio_oper;
+	struct tas_config config;
+};
+
+struct prueth_qos {
+	/* IET data structure goes here */
+	struct prueth_qos_tas tas;
+};
+
+void icssg_qos_init(struct net_device *ndev);
+int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
+			   void *type_data);
+#endif /* __NET_TI_ICSSG_QOS_H */
-- 
2.34.1

