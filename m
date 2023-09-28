Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D9D7B1846
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 12:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjI1KbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 06:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjI1KbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 06:31:14 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D82126;
        Thu, 28 Sep 2023 03:31:10 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38SAU9pY033037;
        Thu, 28 Sep 2023 05:30:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695897009;
        bh=4MYgZL/v0SY2zszXGXkMEoGiEC3tmZ+vWgShu2LXlgI=;
        h=From:To:CC:Subject:Date;
        b=WgJi8uNyA3YGsqcGePz9FATOP/uhV9aDktdyoTqWqvT9JKysninNxxyJbqYrzfTtk
         W5wE/HQW45wT1Jy1BNHd9AzXdmUfA9uZYB9TsXKUapzTRzhNvMvVocNxIVZEHIe9P1
         YZV041XPyS4Jjr8BxW/dqOo5yaMuujWU+NpOHURs=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38SAU9K3020496
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Sep 2023 05:30:09 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Sep 2023 05:30:08 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Sep 2023 05:30:08 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38SAU8mW076858;
        Thu, 28 Sep 2023 05:30:08 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.199])
        by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 38SAU72G025231;
        Thu, 28 Sep 2023 05:30:07 -0500
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Andrew Lunn <andrew@lunn.ch>, Roger Quadros <rogerq@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        MD Danish Anwar <danishanwar@ti.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, <vladimir.oltean@nxp.com>,
        Simon Horman <horms@kernel.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <srk@ti.com>, <r-gunasekaran@ti.com>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Roger Quadros <rogerq@ti.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [PATCH net-next v3] net: ti: icssg_prueth: add TAPRIO offload support
Date:   Thu, 28 Sep 2023 16:00:00 +0530
Message-ID: <20230928103000.186304-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roger Quadros <rogerq@ti.com>

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
Cc: Roger Quadros <rogerq@ti.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Changes from v2 to v3:
*) Rebased on the latest next-20230828 linux-next.
*) Retained original authorship of the patch.
*) Addressed Roger's comments and modified emac_setup_taprio() and
   emac_set_taprio() APIs accordingly.
*) Removed netif_running() check from emac_setup_taprio().
*) Addressed Vinicius' comments and added check for MIN and MAX cycle time.
*) Added check for allocation failure of est_new in emac_setup_taprio().

Changes from v1 to v2:
*) Rebased on the latest next-20230821 linux-next.
*) Dropped the RFC tag as merge window is open now.
*) Splitted this patch from the switch mode series [v1].
*) Removed TODO comment as asked by Andrew and Roger.
*) Changed Copyright to 2023 as asked by Roger.

v2: https://lore.kernel.org/all/20230921070031.795788-1-danishanwar@ti.com/
v1: https://lore.kernel.org/all/20230830110847.1219515-1-danishanwar@ti.com/

 drivers/net/ethernet/ti/Makefile             |   3 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c |   5 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |   6 +
 drivers/net/ethernet/ti/icssg/icssg_qos.c    | 295 +++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_qos.h    | 124 ++++++++
 5 files changed, 431 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.h

diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index 34fd7a716ba6..0df60ded1b2d 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -37,5 +37,6 @@ icssg-prueth-y := k3-cppi-desc-pool.o \
 		  icssg/icssg_config.o \
 		  icssg/icssg_mii_cfg.o \
 		  icssg/icssg_stats.o \
-		  icssg/icssg_ethtool.o
+		  icssg/icssg_ethtool.o \
+		  icssg/icssg_qos.o
 obj-$(CONFIG_TI_ICSS_IEP) += icssg/icss_iep.o
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 6635b28bc672..89c301716926 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1166,7 +1166,7 @@ static int emac_phy_connect(struct prueth_emac *emac)
 	return 0;
 }
 
-static u64 prueth_iep_gettime(void *clockops_data, struct ptp_system_timestamp *sts)
+u64 prueth_iep_gettime(void *clockops_data, struct ptp_system_timestamp *sts)
 {
 	u32 hi_rollover_count, hi_rollover_count_r;
 	struct prueth_emac *emac = clockops_data;
@@ -1403,6 +1403,8 @@ static int emac_ndo_open(struct net_device *ndev)
 		napi_enable(&emac->tx_chns[i].napi_tx);
 	napi_enable(&emac->napi_rx);
 
+	icssg_qos_tas_init(ndev);
+
 	/* start PHY */
 	phy_start(ndev->phydev);
 
@@ -1669,6 +1671,7 @@ static const struct net_device_ops emac_netdev_ops = {
 	.ndo_set_rx_mode = emac_ndo_set_rx_mode,
 	.ndo_eth_ioctl = emac_ndo_ioctl,
 	.ndo_get_stats64 = emac_ndo_get_stats64,
+	.ndo_setup_tc = icssg_qos_ndo_setup_tc,
 };
 
 /* get emac_port corresponding to eth_node name */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 8b6d6b497010..7cbf0e561905 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -37,6 +37,7 @@
 #include "icssg_config.h"
 #include "icss_iep.h"
 #include "icssg_switch_map.h"
+#include "icssg_qos.h"
 
 #define PRUETH_MAX_MTU          (2000 - ETH_HLEN - ETH_FCS_LEN)
 #define PRUETH_MIN_PKT_SIZE     (VLAN_ETH_ZLEN)
@@ -174,6 +175,8 @@ struct prueth_emac {
 
 	struct pruss_mem_region dram;
 
+	struct prueth_qos qos;
+
 	struct delayed_work stats_work;
 	u64 stats[ICSSG_NUM_STATS];
 };
@@ -285,4 +288,7 @@ u32 icssg_queue_level(struct prueth *prueth, int queue);
 void emac_stats_work_handler(struct work_struct *work);
 void emac_update_hardware_stats(struct prueth_emac *emac);
 int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name);
+
+u64 prueth_iep_gettime(void *clockops_data, struct ptp_system_timestamp *sts);
+
 #endif /* __NET_TI_ICSSG_PRUETH_H */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.c b/drivers/net/ethernet/ti/icssg/icssg_qos.c
new file mode 100644
index 000000000000..95a8b1902879
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssg/icssg_qos.c
@@ -0,0 +1,295 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Texas Instruments ICSSG PRUETH QoS submodule
+ * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#include <linux/printk.h>
+#include "icssg_prueth.h"
+#include "icssg_switch_map.h"
+
+static void tas_update_fw_list_pointers(struct prueth_emac *emac)
+{
+	struct tas_config *tas = &emac->qos.tas.config;
+
+	if ((readb(tas->active_list)) == TAS_LIST0) {
+		tas->fw_active_list = emac->dram.va + TAS_GATE_MASK_LIST0;
+		tas->fw_shadow_list = emac->dram.va + TAS_GATE_MASK_LIST1;
+	} else {
+		tas->fw_active_list = emac->dram.va + TAS_GATE_MASK_LIST1;
+		tas->fw_shadow_list = emac->dram.va + TAS_GATE_MASK_LIST0;
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
+	memset_io(tas->fw_active_list, 0, sizeof(*tas->fw_active_list));
+	memset_io(tas->fw_shadow_list, 0, sizeof(*tas->fw_shadow_list));
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
+	if (admin_list->cycle_time < TAS_MIN_CYCLE_TIME)
+		return -EINVAL;
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
+	if (admin_list->cycle_time > TAS_MAX_CYCLE_TIME)
+		return -EINVAL;
+
+	tas_update_fw_list_pointers(emac);
+
+	for (idx = 0; idx < admin_list->num_entries; idx++) {
+		writeb(admin_list->entries[idx].gate_mask,
+		       &tas->fw_shadow_list->gate_mask_list[idx]);
+		tas_acc_gate_close_time += admin_list->entries[idx].interval;
+
+		/* extend last entry till end of cycle time */
+		if (idx == admin_list->num_entries - 1)
+			writel(admin_list->cycle_time,
+			       &tas->fw_shadow_list->win_end_time_list[idx]);
+		else
+			writel(tas_acc_gate_close_time,
+			       &tas->fw_shadow_list->win_end_time_list[idx]);
+	}
+
+	/* clear remaining entries */
+	for (idx = admin_list->num_entries; idx < TAS_MAX_CMD_LISTS; idx++) {
+		writeb(0, &tas->fw_shadow_list->gate_mask_list[idx]);
+		writel(0, &tas->fw_shadow_list->win_end_time_list[idx]);
+	}
+
+	/* update the Array of gate close time for each queue in each window */
+	for (idx = 0 ; idx < admin_list->num_entries; idx++) {
+		/* On Linux, only PRUETH_MAX_TX_QUEUES are supported per port */
+		for (gate_idx = 0; gate_idx < PRUETH_MAX_TX_QUEUES; gate_idx++) {
+			u8 gate_mask_list_idx = readb(&tas->fw_shadow_list->gate_mask_list[idx]);
+			u32 gate_close_time = 0;
+
+			if (gate_mask_list_idx & BIT(gate_idx))
+				gate_close_time = readl(&tas->fw_shadow_list->win_end_time_list[idx]);
+
+			writel(gate_close_time,
+			       &tas->fw_shadow_list->gate_close_time_list[idx][gate_idx]);
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
+	switch (taprio->cmd) {
+	case TAPRIO_CMD_DESTROY:
+		ret = tas_set_state(emac, TAS_STATE_DISABLE);
+		break;
+	case TAPRIO_CMD_REPLACE:
+		ret = tas_update_oper_list(emac);
+		if (ret)
+			return ret;
+		ret =  tas_set_state(emac, TAS_STATE_ENABLE);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+	}
+
+	return ret;
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
+static int emac_setup_taprio(struct net_device *ndev, void *type_data)
+{
+	struct tc_taprio_qopt_offload *taprio = type_data;
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct tc_taprio_qopt_offload *est_new;
+	int ret, idx;
+
+	if (taprio->cycle_time_extension) {
+		netdev_err(ndev, "Failed to set cycle time extension");
+		return -EOPNOTSUPP;
+	}
+
+	if (taprio->num_entries == 0 ||
+	    taprio->num_entries > TAS_MAX_CMD_LISTS) {
+		NL_SET_ERR_MSG_FMT_MOD(taprio->extack, "unsupported num_entries %ld in taprio config\n",
+				       taprio->num_entries);
+		return -EINVAL;
+	}
+
+	/* If any time_interval is 0 in between the list, then exit */
+	for (idx = 0; idx < taprio->num_entries; idx++) {
+		if (taprio->entries[idx].interval == 0) {
+			NL_SET_ERR_MSG_MOD(taprio->extack, "0 interval in taprio config not supported\n");
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
+	if (!est_new)
+		return -ENOMEM;
+
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
+void icssg_qos_tas_init(struct net_device *ndev)
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
index 000000000000..c3d455adc0f8
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssg/icssg_qos.h
@@ -0,0 +1,124 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
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
+ * Minimum cycle time supported by implementation (in ns)
+ */
+#define TAS_MAX_CYCLE_TIME  (4000000000)
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
+	struct tas_firmware_list __iomem *fw_active_list;
+	/* shadow List pointer, used by driver */
+	struct tas_firmware_list __iomem *fw_shadow_list;
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
+void icssg_qos_tas_init(struct net_device *ndev);
+int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
+			   void *type_data);
+#endif /* __NET_TI_ICSSG_QOS_H */
-- 
2.34.1

