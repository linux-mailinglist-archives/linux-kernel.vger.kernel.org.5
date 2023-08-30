Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2711578E03C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbjH3TGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243473AbjH3LJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:09:21 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79D6CC9;
        Wed, 30 Aug 2023 04:09:17 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37UB97vl031894;
        Wed, 30 Aug 2023 06:09:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1693393747;
        bh=RnBikyZAnIc+ZL8nSNz4B0TJYq9Df1Vo4LH2vpJvH54=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SLjqpc20e+f34ZG3uIPhLlzbAvUvj2Yc1DRMG2BSS9wpgop5BvBxbFfBNd8b87NcE
         lijrkmwoYuvxx3uZPaskGkLmXLNVD66ooTtZ+qSry1E0CMVwRkLYnkpBRX5r1ogiqz
         w7sgdI2BST10ophnA0RhQaKPdsGjtNoXTj2c34uU=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37UB970r021757
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Aug 2023 06:09:07 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 30
 Aug 2023 06:09:07 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 30 Aug 2023 06:09:07 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37UB978k100458;
        Wed, 30 Aug 2023 06:09:07 -0500
Received: from localhost (uda0501179.dhcp.ti.com [172.24.227.35])
        by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 37UB96nV006010;
        Wed, 30 Aug 2023 06:09:07 -0500
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
Subject: [RFC PATCH net-next 2/4] net: ti: icssg-switch: Add switchdev based driver for ethernet switch support
Date:   Wed, 30 Aug 2023 16:38:45 +0530
Message-ID: <20230830110847.1219515-3-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830110847.1219515-1-danishanwar@ti.com>
References: <20230830110847.1219515-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

ICSSG can operating in switch mode with 2 ext port and 1 host port with
VLAN/FDB/MDB and STP offloading. Add switchdev based driver to
support the same.

Driver itself will be integrated with icssg_prueth in future commits

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  |   1 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  36 ++
 .../net/ethernet/ti/icssg/icssg_switchdev.c   | 478 ++++++++++++++++++
 .../net/ethernet/ti/icssg/icssg_switchdev.h   |  13 +
 4 files changed, 528 insertions(+)
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_switchdev.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_switchdev.h

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 410612f43cbd..c35fb51f08af 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -30,6 +30,7 @@
 
 #include "icssg_prueth.h"
 #include "icssg_mii_rt.h"
+#include "icssg_switchdev.h"
 #include "../k3-cppi-desc-pool.h"
 
 #define PRUETH_MODULE_DESCRIPTION "PRUSS ICSSG Ethernet driver"
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 1011917924c8..6e18da06c786 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -118,6 +118,15 @@ struct prueth_rx_chn {
 	char name[32];
 };
 
+enum prueth_devlink_param_id {
+	PRUETH_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
+	PRUETH_DL_PARAM_SWITCH_MODE,
+};
+
+struct prueth_devlink {
+	struct prueth *prueth;
+};
+
 /* There are 4 Tx DMA channels, but the highest priority is CH3 (thread 3)
  * and lower three are lower priority channels or threads.
  */
@@ -173,6 +182,10 @@ struct prueth_emac {
 
 	struct pruss_mem_region dram;
 
+	bool offload_fwd_mark;
+	struct devlink_port devlink_port;
+	int port_vlan;
+
 	struct delayed_work stats_work;
 	u64 stats[ICSSG_NUM_STATS];
 };
@@ -181,10 +194,12 @@ struct prueth_emac {
  * struct prueth_pdata - PRUeth platform data
  * @fdqring_mode: Free desc queue mode
  * @quirk_10m_link_issue: 10M link detect errata
+ * @switch_mode: switch firmware support
  */
 struct prueth_pdata {
 	enum k3_ring_mode fdqring_mode;
 	u32	quirk_10m_link_issue:1;
+	u32	switch_mode:1;
 };
 
 /**
@@ -210,6 +225,16 @@ struct prueth_pdata {
  * @iep0: pointer to IEP0 device
  * @iep1: pointer to IEP1 device
  * @vlan_tbl: VLAN-FID table pointer
+ * @hw_bridge_dev: pointer to HW bridge net device
+ * @br_members: bitmask of bridge member ports
+ * @prueth_netdevice_nb: netdevice notifier block
+ * @prueth_switchdevice_nb: switchdev notifier block
+ * @prueth_switchdev_bl_nb: switchdev blocking notifier block
+ * @is_switch_mode: flag to indicate if device is in Switch mode
+ * @is_switchmode_supported: indicates platform support for switch mode
+ * @switch_id: ID for mapping switch ports to bridge
+ * @default_vlan: Default VLAN for host
+ * @devlink: pointer to devlink
  */
 struct prueth {
 	struct device *dev;
@@ -235,6 +260,17 @@ struct prueth {
 	struct icss_iep *iep0;
 	struct icss_iep *iep1;
 	struct prueth_vlan_tbl *vlan_tbl;
+
+	struct net_device *hw_bridge_dev;
+	u8 br_members;
+	struct notifier_block prueth_netdevice_nb;
+	struct notifier_block prueth_switchdev_nb;
+	struct notifier_block prueth_switchdev_bl_nb;
+	bool is_switch_mode;
+	bool is_switchmode_supported;
+	unsigned char switch_id[MAX_PHYS_ITEM_ID_LEN];
+	int default_vlan;
+	struct devlink *devlink;
 };
 
 struct emac_tx_ts_response {
diff --git a/drivers/net/ethernet/ti/icssg/icssg_switchdev.c b/drivers/net/ethernet/ti/icssg/icssg_switchdev.c
new file mode 100644
index 000000000000..48d8ed4fa7a8
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssg/icssg_switchdev.c
@@ -0,0 +1,478 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Texas Instruments K3 ICSSG Ethernet Switchdev Driver
+ *
+ * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ */
+
+#include <linux/etherdevice.h>
+#include <linux/if_bridge.h>
+#include <linux/netdevice.h>
+#include <linux/workqueue.h>
+#include <net/switchdev.h>
+
+#include "icssg_prueth.h"
+#include "icssg_switchdev.h"
+#include "icss_mii_rt.h"
+
+struct prueth_switchdev_event_work {
+	struct work_struct work;
+	struct switchdev_notifier_fdb_info fdb_info;
+	struct prueth_emac *emac;
+	unsigned long event;
+};
+
+static int prueth_switchdev_stp_state_set(struct prueth_emac *emac,
+					  u8 state)
+{
+	enum icssg_port_state_cmd emac_state;
+	int ret = 0;
+
+	switch (state) {
+	case BR_STATE_FORWARDING:
+		emac_state = ICSSG_EMAC_PORT_FORWARD;
+		break;
+	case BR_STATE_DISABLED:
+		emac_state = ICSSG_EMAC_PORT_DISABLE;
+		break;
+	case BR_STATE_LEARNING:
+	case BR_STATE_LISTENING:
+	case BR_STATE_BLOCKING:
+		emac_state = ICSSG_EMAC_PORT_BLOCK;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	emac_set_port_state(emac, emac_state);
+	netdev_dbg(emac->ndev, "STP state: %u\n", emac_state);
+
+	return ret;
+}
+
+static int prueth_switchdev_attr_br_flags_set(struct prueth_emac *emac,
+					      struct net_device *orig_dev,
+					      struct switchdev_brport_flags brport_flags)
+{
+	enum icssg_port_state_cmd emac_state;
+
+	if (brport_flags.mask & BR_MCAST_FLOOD)
+		emac_state = ICSSG_EMAC_PORT_MC_FLOODING_ENABLE;
+	else
+		emac_state = ICSSG_EMAC_PORT_MC_FLOODING_DISABLE;
+
+	netdev_dbg(emac->ndev, "BR_MCAST_FLOOD: %d port %u\n",
+		   emac_state, emac->port_id);
+
+	emac_set_port_state(emac, emac_state);
+
+	return 0;
+}
+
+static int prueth_switchdev_attr_br_flags_pre_set(struct net_device *netdev,
+						  struct switchdev_brport_flags brport_flags)
+{
+	if (brport_flags.mask & ~(BR_LEARNING | BR_MCAST_FLOOD))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int prueth_switchdev_attr_set(struct net_device *ndev, const void *ctx,
+				     const struct switchdev_attr *attr,
+				     struct netlink_ext_ack *extack)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	int ret;
+
+	netdev_dbg(ndev, "attr: id %u port: %u\n", attr->id, emac->port_id);
+
+	switch (attr->id) {
+	case SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS:
+		ret = prueth_switchdev_attr_br_flags_pre_set(ndev,
+							     attr->u.brport_flags);
+		break;
+	case SWITCHDEV_ATTR_ID_PORT_STP_STATE:
+		ret = prueth_switchdev_stp_state_set(emac,
+						     attr->u.stp_state);
+		netdev_dbg(ndev, "stp state: %u\n", attr->u.stp_state);
+		break;
+	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
+		ret = prueth_switchdev_attr_br_flags_set(emac, attr->orig_dev,
+							 attr->u.brport_flags);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	return ret;
+}
+
+static void prueth_switchdev_fdb_offload_notify(struct net_device *ndev,
+						struct switchdev_notifier_fdb_info *rcv)
+{
+	struct switchdev_notifier_fdb_info info;
+
+	memset(&info, 0, sizeof(info));
+	info.addr = rcv->addr;
+	info.vid = rcv->vid;
+	info.offloaded = true;
+	call_switchdev_notifiers(SWITCHDEV_FDB_OFFLOADED,
+				 ndev, &info.info, NULL);
+}
+
+static void prueth_switchdev_event_work(struct work_struct *work)
+{
+	struct prueth_switchdev_event_work *switchdev_work =
+		container_of(work, struct prueth_switchdev_event_work, work);
+	struct prueth_emac *emac = switchdev_work->emac;
+	struct switchdev_notifier_fdb_info *fdb;
+	int port_id = emac->port_id;
+	int ret;
+
+	rtnl_lock();
+	switch (switchdev_work->event) {
+	case SWITCHDEV_FDB_ADD_TO_DEVICE:
+		fdb = &switchdev_work->fdb_info;
+
+		netdev_dbg(emac->ndev, "prueth_fdb_add: MACID = %pM vid = %u flags = %u %u -- port %d\n",
+			   fdb->addr, fdb->vid, fdb->added_by_user,
+			   fdb->offloaded, port_id);
+
+		if (!fdb->added_by_user)
+			break;
+		if (memcmp(emac->mac_addr, (u8 *)fdb->addr, ETH_ALEN) == 0)
+			break;
+
+		ret = icssg_fdb_add_del(emac, fdb->addr, fdb->vid,
+					BIT(port_id), true);
+		if (!ret)
+			prueth_switchdev_fdb_offload_notify(emac->ndev, fdb);
+		break;
+	case SWITCHDEV_FDB_DEL_TO_DEVICE:
+		fdb = &switchdev_work->fdb_info;
+
+		netdev_dbg(emac->ndev, "prueth_fdb_del: MACID = %pM vid = %u flags = %u %u -- port %d\n",
+			   fdb->addr, fdb->vid, fdb->added_by_user,
+			   fdb->offloaded, port_id);
+
+		if (!fdb->added_by_user)
+			break;
+		if (memcmp(emac->mac_addr, (u8 *)fdb->addr, ETH_ALEN) == 0)
+			break;
+		icssg_fdb_add_del(emac, fdb->addr, fdb->vid,
+				  BIT(port_id), false);
+		break;
+	default:
+		break;
+	}
+	rtnl_unlock();
+
+	kfree(switchdev_work->fdb_info.addr);
+	kfree(switchdev_work);
+	dev_put(emac->ndev);
+}
+
+static int prueth_switchdev_event(struct notifier_block *unused,
+				  unsigned long event, void *ptr)
+{
+	struct net_device *ndev = switchdev_notifier_info_to_dev(ptr);
+	struct prueth_switchdev_event_work *switchdev_work;
+	struct switchdev_notifier_fdb_info *fdb_info = ptr;
+	struct prueth_emac *emac = netdev_priv(ndev);
+	int err;
+
+	if (!prueth_dev_check(ndev))
+		return NOTIFY_DONE;
+
+	if (event == SWITCHDEV_PORT_ATTR_SET) {
+		err = switchdev_handle_port_attr_set(ndev, ptr,
+						     prueth_dev_check,
+						     prueth_switchdev_attr_set);
+		return notifier_from_errno(err);
+	}
+
+	switchdev_work = kzalloc(sizeof(*switchdev_work), GFP_ATOMIC);
+	if (WARN_ON(!switchdev_work))
+		return NOTIFY_BAD;
+
+	INIT_WORK(&switchdev_work->work, prueth_switchdev_event_work);
+	switchdev_work->emac = emac;
+	switchdev_work->event = event;
+
+	switch (event) {
+	case SWITCHDEV_FDB_ADD_TO_DEVICE:
+	case SWITCHDEV_FDB_DEL_TO_DEVICE:
+		memcpy(&switchdev_work->fdb_info, ptr,
+		       sizeof(switchdev_work->fdb_info));
+		switchdev_work->fdb_info.addr = kzalloc(ETH_ALEN, GFP_ATOMIC);
+		if (!switchdev_work->fdb_info.addr)
+			goto err_addr_alloc;
+		ether_addr_copy((u8 *)switchdev_work->fdb_info.addr,
+				fdb_info->addr);
+		dev_hold(ndev);
+		break;
+	default:
+		kfree(switchdev_work);
+		return NOTIFY_DONE;
+	}
+
+	queue_work(system_long_wq, &switchdev_work->work);
+
+	return NOTIFY_DONE;
+
+err_addr_alloc:
+	kfree(switchdev_work);
+	return NOTIFY_BAD;
+}
+
+static int prueth_switchdev_vlan_add(struct prueth_emac *emac, bool untag, bool pvid,
+				     u8 vid, struct net_device *orig_dev)
+{
+	bool cpu_port = netif_is_bridge_master(orig_dev);
+	int untag_mask = 0;
+	int port_mask;
+	int ret = 0;
+
+	if (cpu_port)
+		port_mask = BIT(PRUETH_PORT_HOST);
+	else
+		port_mask = BIT(emac->port_id);
+
+	if (untag)
+		untag_mask = port_mask;
+
+	icssg_vtbl_modify(emac, vid, port_mask, untag_mask, true);
+
+	netdev_dbg(emac->ndev, "VID add vid:%u port_mask:%X untag_mask %X PVID %d\n",
+		   vid, port_mask, untag_mask, pvid);
+
+	if (!pvid)
+		return ret;
+
+	icssg_set_pvid(emac->prueth, vid, emac->port_id);
+
+	return ret;
+}
+
+static int prueth_switchdev_vlan_del(struct prueth_emac *emac, u16 vid,
+				     struct net_device *orig_dev)
+{
+	bool cpu_port = netif_is_bridge_master(orig_dev);
+	int port_mask;
+	int ret = 0;
+
+	if (cpu_port)
+		port_mask = BIT(PRUETH_PORT_HOST);
+	else
+		port_mask = BIT(emac->port_id);
+
+	icssg_vtbl_modify(emac, vid, port_mask, 0, false);
+
+	if (cpu_port)
+		icssg_fdb_add_del(emac, emac->mac_addr, vid,
+				  BIT(PRUETH_PORT_HOST), false);
+
+	if (vid == icssg_get_pvid(emac))
+		icssg_set_pvid(emac->prueth, 0, emac->port_id);
+
+	netdev_dbg(emac->ndev, "VID del vid:%u port_mask:%X\n",
+		   vid, port_mask);
+
+	return ret;
+}
+
+static int prueth_switchdev_vlans_add(struct prueth_emac *emac,
+				      const struct switchdev_obj_port_vlan *vlan)
+{
+	bool untag = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
+	struct net_device *orig_dev = vlan->obj.orig_dev;
+	bool cpu_port = netif_is_bridge_master(orig_dev);
+	bool pvid = vlan->flags & BRIDGE_VLAN_INFO_PVID;
+
+	netdev_dbg(emac->ndev, "VID add vid:%u flags:%X\n",
+		   vlan->vid, vlan->flags);
+
+	if (cpu_port && !(vlan->flags & BRIDGE_VLAN_INFO_BRENTRY))
+		return 0;
+
+	if (vlan->vid > 0xff)
+		return 0;
+
+	return prueth_switchdev_vlan_add(emac, untag, pvid, vlan->vid,
+					 orig_dev);
+}
+
+static int prueth_switchdev_vlans_del(struct prueth_emac *emac,
+				      const struct switchdev_obj_port_vlan *vlan)
+{
+	if (vlan->vid > 0xff)
+		return 0;
+
+	return prueth_switchdev_vlan_del(emac, vlan->vid,
+					 vlan->obj.orig_dev);
+}
+
+static int prueth_switchdev_mdb_add(struct prueth_emac *emac,
+				    struct switchdev_obj_port_mdb *mdb)
+{
+	struct net_device *orig_dev = mdb->obj.orig_dev;
+	u8 port_mask, fid_c2;
+	bool cpu_port;
+	int err;
+
+	cpu_port = netif_is_bridge_master(orig_dev);
+
+	if (cpu_port)
+		port_mask = BIT(PRUETH_PORT_HOST);
+	else
+		port_mask = BIT(emac->port_id);
+
+	fid_c2 = icssg_fdb_lookup(emac, mdb->addr, mdb->vid);
+
+	err = icssg_fdb_add_del(emac, mdb->addr, mdb->vid, fid_c2 | port_mask, true);
+	netdev_dbg(emac->ndev, "MDB add vid %u:%pM  ports: %X\n",
+		   mdb->vid, mdb->addr, port_mask);
+
+	return err;
+}
+
+static int prueth_switchdev_mdb_del(struct prueth_emac *emac,
+				    struct switchdev_obj_port_mdb *mdb)
+{
+	struct net_device *orig_dev = mdb->obj.orig_dev;
+	int del_mask, ret, fid_c2;
+	bool cpu_port;
+
+	cpu_port = netif_is_bridge_master(orig_dev);
+
+	if (cpu_port)
+		del_mask = BIT(PRUETH_PORT_HOST);
+	else
+		del_mask = BIT(emac->port_id);
+
+	fid_c2 = icssg_fdb_lookup(emac, mdb->addr, mdb->vid);
+
+	if (fid_c2 & ~del_mask)
+		ret = icssg_fdb_add_del(emac, mdb->addr, mdb->vid, fid_c2 & ~del_mask, true);
+	else
+		ret = icssg_fdb_add_del(emac, mdb->addr, mdb->vid, 0, false);
+
+	netdev_dbg(emac->ndev, "MDB del vid %u:%pM  ports: %X\n",
+		   mdb->vid, mdb->addr, del_mask);
+
+	return ret;
+}
+
+static int prueth_switchdev_obj_add(struct net_device *ndev, const void *ctx,
+				    const struct switchdev_obj *obj,
+				    struct netlink_ext_ack *extack)
+{
+	struct switchdev_obj_port_vlan *vlan = SWITCHDEV_OBJ_PORT_VLAN(obj);
+	struct switchdev_obj_port_mdb *mdb = SWITCHDEV_OBJ_PORT_MDB(obj);
+	struct prueth_emac *emac = netdev_priv(ndev);
+	int err = 0;
+
+	netdev_dbg(ndev, "obj_add: id %u port: %u\n", obj->id, emac->port_id);
+
+	switch (obj->id) {
+	case SWITCHDEV_OBJ_ID_PORT_VLAN:
+		err = prueth_switchdev_vlans_add(emac, vlan);
+		break;
+	case SWITCHDEV_OBJ_ID_PORT_MDB:
+	case SWITCHDEV_OBJ_ID_HOST_MDB:
+		err = prueth_switchdev_mdb_add(emac, mdb);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+		break;
+	}
+
+	return err;
+}
+
+static int prueth_switchdev_obj_del(struct net_device *ndev, const void *ctx,
+				    const struct switchdev_obj *obj)
+{
+	struct switchdev_obj_port_vlan *vlan = SWITCHDEV_OBJ_PORT_VLAN(obj);
+	struct switchdev_obj_port_mdb *mdb = SWITCHDEV_OBJ_PORT_MDB(obj);
+	struct prueth_emac *emac = netdev_priv(ndev);
+	int err = 0;
+
+	netdev_dbg(ndev, "obj_del: id %u port: %u\n", obj->id, emac->port_id);
+
+	switch (obj->id) {
+	case SWITCHDEV_OBJ_ID_PORT_VLAN:
+		err = prueth_switchdev_vlans_del(emac, vlan);
+		break;
+	case SWITCHDEV_OBJ_ID_PORT_MDB:
+	case SWITCHDEV_OBJ_ID_HOST_MDB:
+		err = prueth_switchdev_mdb_del(emac, mdb);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+		break;
+	}
+
+	return err;
+}
+
+static int prueth_switchdev_blocking_event(struct notifier_block *unused,
+					   unsigned long event, void *ptr)
+{
+	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
+	int err;
+
+	switch (event) {
+	case SWITCHDEV_PORT_OBJ_ADD:
+		err = switchdev_handle_port_obj_add(dev, ptr,
+						    prueth_dev_check,
+						    prueth_switchdev_obj_add);
+		return notifier_from_errno(err);
+	case SWITCHDEV_PORT_OBJ_DEL:
+		err = switchdev_handle_port_obj_del(dev, ptr,
+						    prueth_dev_check,
+						    prueth_switchdev_obj_del);
+		return notifier_from_errno(err);
+	case SWITCHDEV_PORT_ATTR_SET:
+		err = switchdev_handle_port_attr_set(dev, ptr,
+						     prueth_dev_check,
+						     prueth_switchdev_attr_set);
+		return notifier_from_errno(err);
+	default:
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+int prueth_switchdev_register_notifiers(struct prueth *prueth)
+{
+	int ret = 0;
+
+	prueth->prueth_switchdev_nb.notifier_call = &prueth_switchdev_event;
+	ret = register_switchdev_notifier(&prueth->prueth_switchdev_nb);
+	if (ret) {
+		dev_err(prueth->dev, "register switchdev notifier fail ret:%d\n",
+			ret);
+		return ret;
+	}
+
+	prueth->prueth_switchdev_bl_nb.notifier_call = &prueth_switchdev_blocking_event;
+	ret = register_switchdev_blocking_notifier(&prueth->prueth_switchdev_bl_nb);
+	if (ret) {
+		dev_err(prueth->dev, "register switchdev blocking notifier ret:%d\n",
+			ret);
+		unregister_switchdev_notifier(&prueth->prueth_switchdev_nb);
+	}
+
+	return ret;
+}
+
+void prueth_switchdev_unregister_notifiers(struct prueth *prueth)
+{
+	unregister_switchdev_blocking_notifier(&prueth->prueth_switchdev_bl_nb);
+	unregister_switchdev_notifier(&prueth->prueth_switchdev_nb);
+}
diff --git a/drivers/net/ethernet/ti/icssg/icssg_switchdev.h b/drivers/net/ethernet/ti/icssg/icssg_switchdev.h
new file mode 100644
index 000000000000..0e64e7760a00
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssg/icssg_switchdev.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
+ */
+#ifndef __NET_TI_ICSSG_SWITCHDEV_H
+#define __NET_TI_ICSSG_SWITCHDEV_H
+
+#include "icssg_prueth.h"
+
+int prueth_switchdev_register_notifiers(struct prueth *prueth);
+void prueth_switchdev_unregister_notifiers(struct prueth *prueth);
+bool prueth_dev_check(const struct net_device *ndev);
+
+#endif /* __NET_TI_ICSSG_SWITCHDEV_H */
-- 
2.34.1

