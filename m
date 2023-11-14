Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDB67EAC94
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 10:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjKNJIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 04:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbjKNJIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 04:08:34 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AC41B9;
        Tue, 14 Nov 2023 01:08:23 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7B138C0006;
        Tue, 14 Nov 2023 09:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699952902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LCp5bzOMm1SE9sHgkID7hCafvEXFQGl5Zu4RUxQpYXc=;
        b=o0Hbhk7puxx1sHXHfTMGCJnsYtPxr+95oxJn3cKbEIIFfxRwHQPxsZNGbsgDveqazj9xvt
        MB/1xNLiUPxhLyaBSjMr/Wnnj6m30gbgh6Uzy5/GRZlgxZotbSOUV3pyNgD7EjIEjPHCnr
        uDPkZyZYgQkJFirk+IJyhVkDms/bTwxj2rDerDuGN9z5H2L/oq9acMNtgT3TSfP/9dZVAZ
        Ip+3REt5HVJr1hMhHTZZ6I6ThffxiUsYlmscgl+CQykDIaKqej0mOx3toTdMhPlN7K1k5L
        B+3ghP5wJ0nPO37HmWKGeZKFlp7P4vUlx86jYbHfFKGbLIrPy4qLtf084CSgWg==
From:   Romain Gantois <romain.gantois@bootlin.com>
To:     davem@davemloft.net, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Romain Gantois <romain.gantois@bootlin.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: [PATCH net-next v2 5/8] net: qualcomm: ipqess: add bridge offloading features to the IPQESS driver
Date:   Tue, 14 Nov 2023 10:07:31 +0100
Message-ID: <20231114090743.865453-6-romain.gantois@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231114090743.865453-1-romain.gantois@bootlin.com>
References: <20231114090743.865453-1-romain.gantois@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: romain.gantois@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IPQ4019 ESS switch is capable of offloading various bridge features.
Add netdev and switchdev notifiers to offload bridge uppers, link state
changes, FDB and MDB accesses and VLANs.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/net/dsa/qca/qca8k-8xxx.c              |   49 +-
 drivers/net/dsa/qca/qca8k-common.c            |   42 +-
 drivers/net/ethernet/qualcomm/Kconfig         |    1 +
 drivers/net/ethernet/qualcomm/ipqess/Makefile |    2 +-
 .../ethernet/qualcomm/ipqess/ipqess_edma.c    |    7 +
 .../qualcomm/ipqess/ipqess_notifiers.c        |  306 +++++
 .../ethernet/qualcomm/ipqess/ipqess_port.c    | 1050 +++++++++++++++--
 .../ethernet/qualcomm/ipqess/ipqess_port.h    |   33 +
 .../ethernet/qualcomm/ipqess/ipqess_switch.c  |   15 +-
 include/linux/dsa/qca8k.h                     |   16 +-
 10 files changed, 1391 insertions(+), 130 deletions(-)
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_notifiers.c

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 210667755b00..7f2bde8ed311 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -1979,34 +1979,71 @@ qca8k_setup(struct dsa_switch *ds)
 	return 0;
 }
 
+int qca8k_dsa_port_fdb_dump(struct dsa_switch *ds, int port,
+			    dsa_fdb_dump_cb_t *cb, void *data)
+{
+	return qca8k_port_fdb_dump(ds->priv, port, cb, data);
+}
+
+void qca8k_dsa_port_stp_state_set(struct dsa_switch *ds, int port,
+				  u8 state)
+{
+	qca8k_port_stp_state_set(ds->priv, port, state,
+				 dsa_to_port(ds, port)->learning, true);
+}
+
+void qca8k_dsa_port_fast_age(struct dsa_switch *ds, int port)
+{
+	qca8k_port_fast_age(ds->priv, port);
+}
+
+int qca8k_dsa_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
+{
+	return qca8k_set_ageing_time(ds->priv, msecs);
+}
+
+int qca8k_dsa_port_vlan_filtering(struct dsa_switch *ds, int port,
+				  bool vlan_filtering,
+				  struct netlink_ext_ack *extack)
+{
+	return qca8k_port_vlan_filtering(ds->priv, port, vlan_filtering);
+}
+
+int qca8k_dsa_vlan_add(struct dsa_switch *ds, int port,
+		       const struct switchdev_obj_port_vlan *vlan,
+		       struct netlink_ext_ack *extack)
+{
+	return qca8k_port_vlan_add(ds->priv, port, vlan, extack);
+}
+
 static const struct dsa_switch_ops qca8k_switch_ops = {
 	.get_tag_protocol	= qca8k_get_tag_protocol,
 	.setup			= qca8k_setup,
 	.get_strings		= qca8k_get_strings,
 	.get_ethtool_stats	= qca8k_get_ethtool_stats,
 	.get_sset_count		= qca8k_get_sset_count,
-	.set_ageing_time	= qca8k_set_ageing_time,
+	.set_ageing_time	= qca8k_dsa_set_ageing_time,
 	.get_mac_eee		= qca8k_get_mac_eee,
 	.set_mac_eee		= qca8k_set_mac_eee,
 	.port_enable		= qca8k_port_enable,
 	.port_disable		= qca8k_port_disable,
 	.port_change_mtu	= qca8k_port_change_mtu,
 	.port_max_mtu		= qca8k_port_max_mtu,
-	.port_stp_state_set	= qca8k_port_stp_state_set,
+	.port_stp_state_set	= qca8k_dsa_port_stp_state_set,
 	.port_pre_bridge_flags	= qca8k_port_pre_bridge_flags,
 	.port_bridge_flags	= qca8k_port_bridge_flags,
 	.port_bridge_join	= qca8k_port_bridge_join,
 	.port_bridge_leave	= qca8k_port_bridge_leave,
-	.port_fast_age		= qca8k_port_fast_age,
+	.port_fast_age		= qca8k_dsa_port_fast_age,
 	.port_fdb_add		= qca8k_port_fdb_add,
 	.port_fdb_del		= qca8k_port_fdb_del,
-	.port_fdb_dump		= qca8k_port_fdb_dump,
+	.port_fdb_dump		= qca8k_dsa_port_fdb_dump,
 	.port_mdb_add		= qca8k_port_mdb_add,
 	.port_mdb_del		= qca8k_port_mdb_del,
 	.port_mirror_add	= qca8k_port_mirror_add,
 	.port_mirror_del	= qca8k_port_mirror_del,
-	.port_vlan_filtering	= qca8k_port_vlan_filtering,
-	.port_vlan_add		= qca8k_port_vlan_add,
+	.port_vlan_filtering	= qca8k_dsa_port_vlan_filtering,
+	.port_vlan_add		= qca8k_dsa_vlan_add,
 	.port_vlan_del		= qca8k_port_vlan_del,
 	.phylink_get_caps	= qca8k_phylink_get_caps,
 	.phylink_mac_select_pcs	= qca8k_phylink_mac_select_pcs,
diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
index a66a821ce4d6..3d6ff6f24288 100644
--- a/drivers/net/dsa/qca/qca8k-common.c
+++ b/drivers/net/dsa/qca/qca8k-common.c
@@ -595,11 +595,9 @@ int qca8k_get_mac_eee(struct dsa_switch *ds, int port,
 }
 EXPORT_SYMBOL_GPL(qca8k_get_mac_eee);
 
-static int qca8k_port_configure_learning(struct dsa_switch *ds, int port,
+static int qca8k_port_configure_learning(struct qca8k_priv *priv, int port,
 					 bool learning)
 {
-	struct qca8k_priv *priv = ds->priv;
-
 	if (learning)
 		return regmap_set_bits(priv->regmap,
 				       QCA8K_PORT_LOOKUP_CTRL(port),
@@ -610,10 +608,10 @@ static int qca8k_port_configure_learning(struct dsa_switch *ds, int port,
 					 QCA8K_PORT_LOOKUP_LEARN);
 }
 
-void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
+void qca8k_port_stp_state_set(struct qca8k_priv *priv,
+			      int port, u8 state,
+			      bool port_learning, int set_learning)
 {
-	struct dsa_port *dp = dsa_to_port(ds, port);
-	struct qca8k_priv *priv = ds->priv;
 	bool learning = false;
 	u32 stp_state;
 
@@ -629,10 +627,10 @@ void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 		break;
 	case BR_STATE_LEARNING:
 		stp_state = QCA8K_PORT_LOOKUP_STATE_LEARNING;
-		learning = dp->learning;
+		learning = port_learning;
 		break;
 	case BR_STATE_FORWARDING:
-		learning = dp->learning;
+		learning = port_learning;
 		fallthrough;
 	default:
 		stp_state = QCA8K_PORT_LOOKUP_STATE_FORWARD;
@@ -642,7 +640,8 @@ void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 	qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port),
 		  QCA8K_PORT_LOOKUP_STATE_MASK, stp_state);
 
-	qca8k_port_configure_learning(ds, port, learning);
+	if (set_learning)
+		qca8k_port_configure_learning(priv, port, learning);
 }
 EXPORT_SYMBOL_GPL(qca8k_port_stp_state_set);
 
@@ -664,7 +663,7 @@ int qca8k_port_bridge_flags(struct dsa_switch *ds, int port,
 	int ret;
 
 	if (flags.mask & BR_LEARNING) {
-		ret = qca8k_port_configure_learning(ds, port,
+		ret = qca8k_port_configure_learning(ds->priv, port,
 						    flags.val & BR_LEARNING);
 		if (ret)
 			return ret;
@@ -740,19 +739,16 @@ void qca8k_port_bridge_leave(struct dsa_switch *ds, int port,
 }
 EXPORT_SYMBOL_GPL(qca8k_port_bridge_leave);
 
-void qca8k_port_fast_age(struct dsa_switch *ds, int port)
+void qca8k_port_fast_age(struct qca8k_priv *priv, int port)
 {
-	struct qca8k_priv *priv = ds->priv;
-
 	mutex_lock(&priv->reg_mutex);
 	qca8k_fdb_access(priv, QCA8K_FDB_FLUSH_PORT, port);
 	mutex_unlock(&priv->reg_mutex);
 }
 EXPORT_SYMBOL_GPL(qca8k_port_fast_age);
 
-int qca8k_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
+int qca8k_set_ageing_time(struct qca8k_priv *priv, unsigned int msecs)
 {
-	struct qca8k_priv *priv = ds->priv;
 	unsigned int secs = msecs / 1000;
 	u32 val;
 
@@ -877,10 +873,9 @@ int qca8k_port_fdb_del(struct dsa_switch *ds, int port,
 }
 EXPORT_SYMBOL_GPL(qca8k_port_fdb_del);
 
-int qca8k_port_fdb_dump(struct dsa_switch *ds, int port,
+int qca8k_port_fdb_dump(struct qca8k_priv *priv, int port,
 			dsa_fdb_dump_cb_t *cb, void *data)
 {
-	struct qca8k_priv *priv = ds->priv;
 	struct qca8k_fdb _fdb = { 0 };
 	int cnt = QCA8K_NUM_FDB_RECORDS;
 	bool is_static;
@@ -933,8 +928,8 @@ int qca8k_port_mdb_del(struct dsa_switch *ds, int port,
 EXPORT_SYMBOL_GPL(qca8k_port_mdb_del);
 
 int qca8k_port_mirror_add(struct dsa_switch *ds, int port,
-				 struct dsa_mall_mirror_tc_entry *mirror,
-				 bool ingress, struct netlink_ext_ack *extack)
+			  struct dsa_mall_mirror_tc_entry *mirror,
+			  bool ingress, struct netlink_ext_ack *extack)
 {
 	struct qca8k_priv *priv = ds->priv;
 	int monitor_port, ret;
@@ -1025,11 +1020,9 @@ void qca8k_port_mirror_del(struct dsa_switch *ds, int port,
 }
 EXPORT_SYMBOL_GPL(qca8k_port_mirror_del);
 
-int qca8k_port_vlan_filtering(struct dsa_switch *ds, int port,
-			      bool vlan_filtering,
-			      struct netlink_ext_ack *extack)
+int qca8k_port_vlan_filtering(struct qca8k_priv *priv, int port,
+			      bool vlan_filtering)
 {
-	struct qca8k_priv *priv = ds->priv;
 	int ret;
 
 	if (vlan_filtering) {
@@ -1046,13 +1039,12 @@ int qca8k_port_vlan_filtering(struct dsa_switch *ds, int port,
 }
 EXPORT_SYMBOL_GPL(qca8k_port_vlan_filtering);
 
-int qca8k_port_vlan_add(struct dsa_switch *ds, int port,
+int qca8k_port_vlan_add(struct qca8k_priv *priv, int port,
 			const struct switchdev_obj_port_vlan *vlan,
 			struct netlink_ext_ack *extack)
 {
 	bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
 	bool pvid = vlan->flags & BRIDGE_VLAN_INFO_PVID;
-	struct qca8k_priv *priv = ds->priv;
 	int ret;
 
 	ret = qca8k_vlan_add(priv, port, vlan->vid, untagged);
diff --git a/drivers/net/ethernet/qualcomm/Kconfig b/drivers/net/ethernet/qualcomm/Kconfig
index 008d20ec9eae..15d120d9e64a 100644
--- a/drivers/net/ethernet/qualcomm/Kconfig
+++ b/drivers/net/ethernet/qualcomm/Kconfig
@@ -66,6 +66,7 @@ config QCOM_IPQ4019_ESS
 	depends on (OF && ARCH_QCOM) || COMPILE_TEST
 	select PHYLINK
 	select NET_DSA
+	select NET_SWITCHDEV
 	select NET_DSA_QCA8K_LIB
 	select PAGE_POOL
 	help
diff --git a/drivers/net/ethernet/qualcomm/ipqess/Makefile b/drivers/net/ethernet/qualcomm/ipqess/Makefile
index 6253f1b0ffd2..b12142bbc7e5 100644
--- a/drivers/net/ethernet/qualcomm/ipqess/Makefile
+++ b/drivers/net/ethernet/qualcomm/ipqess/Makefile
@@ -5,4 +5,4 @@
 
 obj-$(CONFIG_QCOM_IPQ4019_ESS) += ipqess.o
 
-ipqess-objs := ipqess_port.o ipqess_switch.o ipqess_edma.o ipqess_ethtool.o
+ipqess-objs := ipqess_port.o ipqess_switch.o ipqess_edma.o ipqess_ethtool.o ipqess_notifiers.o
diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_edma.c b/drivers/net/ethernet/qualcomm/ipqess/ipqess_edma.c
index 008e92de9eb7..13be40c70750 100644
--- a/drivers/net/ethernet/qualcomm/ipqess/ipqess_edma.c
+++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_edma.c
@@ -22,6 +22,7 @@
 #include "ipqess_edma.h"
 #include "ipqess_port.h"
 #include "ipqess_switch.h"
+#include "ipqess_notifiers.h"
 
 static void ipqess_edma_w32(struct ipqess_edma *edma, u32 reg, u32 val)
 {
@@ -1152,6 +1153,10 @@ int ipqess_edma_init(struct platform_device *pdev, struct device_node *np)
 			port->edma = edma;
 	}
 
+	err = ipqess_notifiers_register();
+	if (err)
+		goto err_hw_stop;
+
 	return 0;
 
 err_hw_stop:
@@ -1172,6 +1177,8 @@ void ipqess_edma_uninit(struct ipqess_edma *edma)
 	struct qca8k_priv *priv = edma->sw->priv;
 	u32 val;
 
+	ipqess_notifiers_unregister();
+
 	ipqess_edma_irq_disable(edma);
 	ipqess_edma_hw_stop(edma);
 
diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_notifiers.c b/drivers/net/ethernet/qualcomm/ipqess/ipqess_notifiers.c
new file mode 100644
index 000000000000..77f6d79c2ff6
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_notifiers.c
@@ -0,0 +1,306 @@
+// SPDX-License-Identifier: GPL-2.0 OR ISC
+/*
+ * Copyright (c) 2023, Romain Gantois <romain.gantois@bootlin.com>
+ * Based on net/dsa/slave.c
+ */
+
+#include <net/switchdev.h>
+
+#include <linux/etherdevice.h>
+#include <linux/if_vlan.h>
+#include <linux/if_hsr.h>
+
+#include "ipqess_notifiers.h"
+#include "ipqess_port.h"
+
+static struct workqueue_struct *ipqess_owq;
+
+static bool ipqess_schedule_work(struct work_struct *work)
+{
+	return queue_work(ipqess_owq, work);
+}
+
+void ipqess_flush_workqueue(void)
+{
+	flush_workqueue(ipqess_owq);
+}
+
+/* switchdev */
+
+static int ipqess_port_fdb_event(struct net_device *netdev,
+				 struct net_device *orig_netdev,
+				 unsigned long event, const void *ctx,
+				 const struct switchdev_notifier_fdb_info *fdb_info)
+{
+	struct ipqess_switchdev_event_work *switchdev_work;
+	struct ipqess_port *port = netdev_priv(netdev);
+	bool host_addr = fdb_info->is_local;
+
+	if (ctx && ctx != port)
+		return 0;
+
+	if (!port->bridge)
+		return 0;
+
+	if (switchdev_fdb_is_dynamically_learned(fdb_info) &&
+	    ipqess_port_offloads_bridge_port(port, orig_netdev))
+		return 0;
+
+	/* Also treat FDB entries on foreign interfaces bridged with us as host
+	 * addresses.
+	 */
+	if (ipqess_port_dev_is_foreign(netdev, orig_netdev))
+		host_addr = true;
+
+	switchdev_work = kzalloc(sizeof(*switchdev_work), GFP_ATOMIC);
+	if (!switchdev_work)
+		return -ENOMEM;
+
+	netdev_dbg(netdev, "%s FDB entry towards %s, addr %pM vid %d%s\n",
+		   event == SWITCHDEV_FDB_ADD_TO_DEVICE ? "Adding" : "Deleting",
+		   orig_netdev->name, fdb_info->addr, fdb_info->vid,
+		   host_addr ? " as host address" : "");
+
+	INIT_WORK(&switchdev_work->work, ipqess_port_switchdev_event_work);
+	switchdev_work->event = event;
+	switchdev_work->netdev = netdev;
+	switchdev_work->orig_netdev = orig_netdev;
+
+	ether_addr_copy(switchdev_work->addr, fdb_info->addr);
+	switchdev_work->vid = fdb_info->vid;
+	switchdev_work->host_addr = host_addr;
+
+	ipqess_schedule_work(&switchdev_work->work);
+
+	return 0;
+}
+
+/* Called under rcu_read_lock() */
+static int ipqess_switchdev_event(struct notifier_block *unused,
+				  unsigned long event, void *ptr)
+{
+	struct net_device *netdev = switchdev_notifier_info_to_dev(ptr);
+	int err;
+
+	switch (event) {
+	case SWITCHDEV_PORT_ATTR_SET:
+		err = switchdev_handle_port_attr_set(netdev, ptr,
+						     ipqess_port_recognize_netdev,
+						     ipqess_port_attr_set);
+		return notifier_from_errno(err);
+	case SWITCHDEV_FDB_ADD_TO_DEVICE:
+	case SWITCHDEV_FDB_DEL_TO_DEVICE:
+		err = switchdev_handle_fdb_event_to_device(netdev, event, ptr,
+							   ipqess_port_recognize_netdev,
+							   ipqess_port_dev_is_foreign,
+							   ipqess_port_fdb_event);
+		return notifier_from_errno(err);
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_OK;
+}
+
+static int ipqess_switchdev_blocking_event(struct notifier_block *unused,
+					   unsigned long event, void *ptr)
+{
+	struct net_device *netdev = switchdev_notifier_info_to_dev(ptr);
+	int err;
+
+	switch (event) {
+	case SWITCHDEV_PORT_OBJ_ADD:
+		err = switchdev_handle_port_obj_add_foreign(netdev, ptr,
+							    ipqess_port_recognize_netdev,
+							    ipqess_port_dev_is_foreign,
+							    ipqess_port_obj_add);
+		return notifier_from_errno(err);
+	case SWITCHDEV_PORT_OBJ_DEL:
+		err = switchdev_handle_port_obj_del_foreign(netdev, ptr,
+							    ipqess_port_recognize_netdev,
+							    ipqess_port_dev_is_foreign,
+							    ipqess_port_obj_del);
+		return notifier_from_errno(err);
+	case SWITCHDEV_PORT_ATTR_SET:
+		err = switchdev_handle_port_attr_set(netdev, ptr,
+						     ipqess_port_recognize_netdev,
+						     ipqess_port_attr_set);
+		return notifier_from_errno(err);
+	}
+
+	return NOTIFY_DONE;
+}
+
+/* netdevice */
+
+static int ipqess_port_changeupper(struct net_device *netdev,
+				   struct netdev_notifier_changeupper_info *info)
+{
+	struct ipqess_port *port = netdev_priv(netdev);
+	struct netlink_ext_ack *extack;
+	int err = NOTIFY_DONE;
+
+	if (!ipqess_port_recognize_netdev(netdev))
+		return err;
+
+	extack = netdev_notifier_info_to_extack(&info->info);
+
+	if (netif_is_bridge_master(info->upper_dev)) {
+		if (info->linking) {
+			err = ipqess_port_bridge_join(port, info->upper_dev, extack);
+			if (err == -EOPNOTSUPP) {
+				NL_SET_ERR_MSG_WEAK_MOD(extack,
+							"Offloading not supported");
+				err = NOTIFY_DONE;
+			}
+			err = notifier_from_errno(err);
+		} else {
+			ipqess_port_bridge_leave(port, info->upper_dev);
+			err = NOTIFY_OK;
+		}
+	} else if (netif_is_lag_master(info->upper_dev)) {
+		/* LAG offloading is not supported by this driver */
+		NL_SET_ERR_MSG_WEAK_MOD(extack,
+					"Offloading not supported");
+		err = NOTIFY_DONE;
+	} else if (is_hsr_master(info->upper_dev)) {
+		if (info->linking) {
+			NL_SET_ERR_MSG_WEAK_MOD(extack,
+						"Offloading not supported");
+			err = NOTIFY_DONE;
+		} else {
+			err = NOTIFY_OK;
+		}
+	}
+
+	return err;
+}
+
+static int ipqess_port_prechangeupper(struct net_device *netdev,
+				      struct netdev_notifier_changeupper_info *info)
+{
+	struct ipqess_port *port = netdev_priv(netdev);
+	struct net_device *brport_dev;
+	int err;
+
+	/* sanity check */
+	if (is_vlan_dev(info->upper_dev)) {
+		err = ipqess_port_check_8021q_upper(netdev, info);
+		if (notifier_to_errno(err))
+			return err;
+	}
+
+	/* prechangeupper */
+	if (netif_is_bridge_master(info->upper_dev) && !info->linking)
+		brport_dev = ipqess_port_get_bridged_netdev(port);
+	else
+		return NOTIFY_DONE;
+
+	if (!brport_dev)
+		return NOTIFY_DONE;
+
+	switchdev_bridge_port_unoffload(brport_dev, port,
+					&ipqess_switchdev_notifier,
+					&ipqess_switchdev_blocking_notifier);
+
+	ipqess_flush_workqueue();
+
+	return NOTIFY_DONE;
+}
+
+static int ipqess_netdevice_event(struct notifier_block *nb,
+				  unsigned long event, void *ptr)
+{
+	struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
+	int err;
+
+	if (!ipqess_port_recognize_netdev(netdev))
+		return NOTIFY_DONE;
+
+	switch (event) {
+	case NETDEV_PRECHANGEUPPER: {
+		err = ipqess_port_prechangeupper(netdev, ptr);
+		if (notifier_to_errno(err))
+			return err;
+
+		break;
+	}
+
+	case NETDEV_CHANGEUPPER: {
+		err = ipqess_port_changeupper(netdev, ptr);
+		if (notifier_to_errno(err))
+			return err;
+
+		break;
+	}
+
+	/* Handling this is only useful for LAG offloading, which this driver
+	 * doesn't support
+	 */
+	case NETDEV_CHANGELOWERSTATE:
+		return NOTIFY_DONE;
+	case NETDEV_CHANGE:
+	case NETDEV_UP:
+	case NETDEV_GOING_DOWN:
+	default:
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+struct notifier_block ipqess_switchdev_notifier = {
+	.notifier_call = ipqess_switchdev_event,
+};
+
+struct notifier_block ipqess_switchdev_blocking_notifier = {
+	.notifier_call = ipqess_switchdev_blocking_event,
+};
+
+static struct notifier_block ipqess_nb __read_mostly = {
+	.notifier_call = ipqess_netdevice_event,
+};
+
+int ipqess_notifiers_register(void)
+{
+	int err;
+
+	ipqess_owq = alloc_ordered_workqueue("ipqess_ordered",
+					     WQ_MEM_RECLAIM);
+	if (!ipqess_owq)
+		return -ENOMEM;
+
+	err = register_netdevice_notifier(&ipqess_nb);
+	if (err)
+		goto err_netdev_nb;
+
+	err = register_switchdev_notifier(&ipqess_switchdev_notifier);
+	if (err)
+		goto err_switchdev_nb;
+
+	err = register_switchdev_blocking_notifier(&ipqess_switchdev_blocking_notifier);
+	if (err)
+		goto err_switchdev_blocking_nb;
+
+	return 0;
+
+err_switchdev_blocking_nb:
+	unregister_switchdev_notifier(&ipqess_switchdev_notifier);
+err_switchdev_nb:
+	unregister_netdevice_notifier(&ipqess_nb);
+err_netdev_nb:
+	destroy_workqueue(ipqess_owq);
+
+	return err;
+}
+EXPORT_SYMBOL(ipqess_notifiers_register);
+
+void ipqess_notifiers_unregister(void)
+{
+	unregister_switchdev_blocking_notifier(&ipqess_switchdev_blocking_notifier);
+	unregister_switchdev_notifier(&ipqess_switchdev_notifier);
+	unregister_netdevice_notifier(&ipqess_nb);
+
+	destroy_workqueue(ipqess_owq);
+}
+EXPORT_SYMBOL(ipqess_notifiers_unregister);
diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c
index 52d7baa7cae0..29420820c3d8 100644
--- a/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c
+++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c
@@ -23,50 +23,50 @@ static struct device_type ipqess_port_type = {
 	.name	= "switch",
 };
 
+struct net_device *ipqess_port_get_bridged_netdev(const struct ipqess_port *port)
+{
+	if (!port->bridge)
+		return NULL;
+
+	return port->netdev;
+}
+
 /* netdev ops */
 
+static void ipqess_port_notify_bridge_fdb_flush(const struct ipqess_port *port,
+						u16 vid)
+{
+	struct net_device *brport_dev = ipqess_port_get_bridged_netdev(port);
+	struct switchdev_notifier_fdb_info info = {
+		.vid = vid,
+	};
+
+	/* When the port becomes standalone it has already left the bridge.
+	 * Don't notify the bridge in that case.
+	 */
+	if (!brport_dev)
+		return;
+
+	call_switchdev_notifiers(SWITCHDEV_FDB_FLUSH_TO_BRIDGE,
+				 brport_dev, &info.info, NULL);
+}
+
 static void ipqess_port_fast_age(const struct ipqess_port *port)
 {
 	struct qca8k_priv *priv = port->sw->priv;
 
-	mutex_lock(&priv->reg_mutex);
-	qca8k_fdb_access(priv, QCA8K_FDB_FLUSH_PORT, port->index);
-	mutex_unlock(&priv->reg_mutex);
+	qca8k_port_fast_age(priv, port->index);
+
+	/* Flush all VLANs */
+	ipqess_port_notify_bridge_fdb_flush(port, 0);
 }
 
 static void ipqess_port_stp_state_set(struct ipqess_port *port,
 				      u8 state)
 {
 	struct qca8k_priv *priv = port->sw->priv;
-	u32 stp_state;
-	int err;
 
-	switch (state) {
-	case BR_STATE_DISABLED:
-		stp_state = QCA8K_PORT_LOOKUP_STATE_DISABLED;
-		break;
-	case BR_STATE_BLOCKING:
-		stp_state = QCA8K_PORT_LOOKUP_STATE_BLOCKING;
-		break;
-	case BR_STATE_LISTENING:
-		stp_state = QCA8K_PORT_LOOKUP_STATE_LISTENING;
-		break;
-	case BR_STATE_LEARNING:
-		stp_state = QCA8K_PORT_LOOKUP_STATE_LEARNING;
-		break;
-	case BR_STATE_FORWARDING:
-	default:
-		stp_state = QCA8K_PORT_LOOKUP_STATE_FORWARD;
-		break;
-	}
-
-	err = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port->index),
-			QCA8K_PORT_LOOKUP_STATE_MASK, stp_state);
-
-	if (err)
-		dev_warn(priv->dev,
-			 "failed to set STP state %d for port %d: err %d\n",
-			 stp_state, port->index, err);
+	qca8k_port_stp_state_set(priv, port->index, state, false, false);
 }
 
 static void ipqess_port_set_state_now(struct ipqess_port *port,
@@ -93,7 +93,8 @@ static int ipqess_port_enable_rt(struct ipqess_port *port,
 
 	phy_support_asym_pause(phy);
 
-	ipqess_port_set_state_now(port, BR_STATE_FORWARDING, false);
+	if (!port->bridge)
+		ipqess_port_set_state_now(port, BR_STATE_FORWARDING, false);
 
 	if (port->pl)
 		phylink_start(port->pl);
@@ -108,7 +109,8 @@ static void ipqess_port_disable_rt(struct ipqess_port *port)
 	if (port->pl)
 		phylink_stop(port->pl);
 
-	ipqess_port_set_state_now(port, BR_STATE_DISABLED, false);
+	if (!port->bridge)
+		ipqess_port_set_state_now(port, BR_STATE_DISABLED, false);
 
 	qca8k_port_set_status(priv, port->index, 0);
 	priv->port_enabled_map &= ~BIT(port->index);
@@ -204,34 +206,9 @@ static int ipqess_port_change_mtu(struct net_device *dev, int new_mtu)
 	return 0;
 }
 
-static int ipqess_port_do_vlan_add(struct qca8k_priv *priv, int port_index,
-				   const struct switchdev_obj_port_vlan *vlan,
-				   struct netlink_ext_ack *extack)
+static inline struct net_device *ipqess_port_bridge_dev_get(struct ipqess_port *port)
 {
-	bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
-	bool pvid = vlan->flags & BRIDGE_VLAN_INFO_PVID;
-	int ret;
-
-	ret = qca8k_vlan_add(priv, port_index, vlan->vid, untagged);
-	if (ret) {
-		dev_err(priv->dev, "Failed to add VLAN to port %d (%d)", port_index,
-			ret);
-		return ret;
-	}
-
-	if (pvid) {
-		ret = qca8k_rmw(priv, QCA8K_EGRESS_VLAN(port_index),
-				QCA8K_EGREES_VLAN_PORT_MASK(port_index),
-				QCA8K_EGREES_VLAN_PORT(port_index, vlan->vid));
-		if (ret)
-			return ret;
-
-		ret = qca8k_write(priv, QCA8K_REG_PORT_VLAN_CTRL0(port_index),
-				  QCA8K_PORT_VLAN_CVID(vlan->vid) |
-				  QCA8K_PORT_VLAN_SVID(vlan->vid));
-	}
-
-	return ret;
+	return port->bridge ? port->bridge->netdev : NULL;
 }
 
 static int ipqess_port_vlan_rx_add_vid(struct net_device *dev, __be16 proto,
@@ -248,7 +225,7 @@ static int ipqess_port_vlan_rx_add_vid(struct net_device *dev, __be16 proto,
 	int ret;
 
 	/* User port... */
-	ret = ipqess_port_do_vlan_add(port->sw->priv, port->index, &vlan, &extack);
+	ret = qca8k_port_vlan_add(port->sw->priv, port->index, &vlan, &extack);
 	if (ret) {
 		if (extack._msg)
 			netdev_err(dev, "%s\n", extack._msg);
@@ -256,7 +233,7 @@ static int ipqess_port_vlan_rx_add_vid(struct net_device *dev, __be16 proto,
 	}
 
 	/* And CPU port... */
-	ret = ipqess_port_do_vlan_add(port->sw->priv, 0, &vlan, &extack);
+	ret = qca8k_port_vlan_add(port->sw->priv, 0, &vlan, &extack);
 	if (ret) {
 		if (extack._msg)
 			netdev_err(dev, "CPU port %d: %s\n", 0, extack._msg);
@@ -340,24 +317,13 @@ ipqess_port_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb,
 		.cb = cb,
 		.idx = *idx,
 	};
-	int cnt = QCA8K_NUM_FDB_RECORDS;
-	struct qca8k_fdb _fdb = { 0 };
-	bool is_static;
 	int ret = 0;
 
-	mutex_lock(&priv->reg_mutex);
-	while (cnt-- && !qca8k_fdb_next(priv, &_fdb, port->index)) {
-		if (!_fdb.aging)
-			break;
-		is_static = (_fdb.aging == QCA8K_ATU_STATUS_STATIC);
-		ret = ipqess_port_fdb_do_dump(_fdb.mac, _fdb.vid, is_static, &dump);
-		if (ret)
-			break;
-	}
-	mutex_unlock(&priv->reg_mutex);
-
 	*idx = dump.idx;
 
+	ret = qca8k_port_fdb_dump(priv, port->index, ipqess_port_fdb_do_dump,
+				  &dump);
+
 	return ret;
 }
 
@@ -374,6 +340,882 @@ static const struct net_device_ops ipqess_port_netdev_ops = {
 	.ndo_fdb_dump           = ipqess_port_fdb_dump,
 };
 
+/* Bridge ops */
+
+static int ipqess_port_bridge_alloc(struct ipqess_port *port,
+				    struct net_device *br,
+				    struct netlink_ext_ack *extack)
+{
+	struct ipqess_bridge *bridge;
+
+	bridge = kzalloc(sizeof(*bridge), GFP_KERNEL);
+	if (!bridge)
+		return -ENOMEM;
+
+	refcount_set(&bridge->refcount, 1);
+
+	bridge->netdev = br;
+
+	port->bridge = bridge;
+
+	return 0;
+}
+
+/* Must be called under rcu_read_lock() */
+static bool ipqess_port_can_apply_vlan_filtering(struct ipqess_port *port,
+						 bool vlan_filtering,
+						 struct netlink_ext_ack *extack)
+{
+	int err;
+
+	/* VLAN awareness was off, so the question is "can we turn it on".
+	 * We may have had 8021q uppers, those need to go. Make sure we don't
+	 * enter an inconsistent state: deny changing the VLAN awareness state
+	 * as long as we have 8021q uppers.
+	 */
+	if (vlan_filtering) {
+		struct net_device *br = ipqess_port_bridge_dev_get(port);
+		struct net_device *upper_dev, *netdev = port->netdev;
+		struct list_head *iter;
+
+		netdev_for_each_upper_dev_rcu(netdev, upper_dev, iter) {
+			struct bridge_vlan_info br_info;
+			u16 vid;
+
+			if (!is_vlan_dev(upper_dev))
+				continue;
+
+			vid = vlan_dev_vlan_id(upper_dev);
+
+			/* br_vlan_get_info() returns -EINVAL or -ENOENT if the
+			 * device, respectively the VID is not found, returning
+			 * 0 means success, which is a failure for us here.
+			 */
+			err = br_vlan_get_info(br, vid, &br_info);
+			if (err == 0) {
+				NL_SET_ERR_MSG_MOD(extack,
+						   "Must first remove VLAN uppers having VIDs also present in bridge");
+				return false;
+			}
+		}
+	}
+
+	/* VLAN filtering is not global so we can just return true here */
+	return true;
+}
+
+static int ipqess_port_restore_vlan(struct net_device *vdev, int vid, void *arg)
+{
+	__be16 proto = vdev ? vlan_dev_vlan_proto(vdev) : htons(ETH_P_8021Q);
+
+	return ipqess_port_vlan_rx_add_vid(arg, proto, vid);
+}
+
+static int ipqess_port_clear_vlan(struct net_device *vdev, int vid, void *arg)
+{
+	__be16 proto = vdev ? vlan_dev_vlan_proto(vdev) : htons(ETH_P_8021Q);
+
+	return ipqess_port_vlan_rx_kill_vid(arg, proto, vid);
+}
+
+/* Keep the VLAN RX filtering list in sync with the hardware only if VLAN
+ * filtering is enabled.
+ */
+static int ipqess_port_manage_vlan_filtering(struct net_device *netdev,
+					     bool vlan_filtering)
+{
+	int err;
+
+	if (vlan_filtering) {
+		netdev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
+
+		err = vlan_for_each(netdev, ipqess_port_restore_vlan, netdev);
+		if (err) {
+			netdev_err(netdev,
+				   "Failed to restore all VLAN's successfully, error %d\n",
+				   err);
+			vlan_for_each(netdev, ipqess_port_clear_vlan, netdev);
+			netdev->features &= ~NETIF_F_HW_VLAN_CTAG_FILTER;
+			return err;
+		}
+	} else {
+		err = vlan_for_each(netdev, ipqess_port_clear_vlan, netdev);
+		if (err)
+			return err;
+
+		netdev->features &= ~NETIF_F_HW_VLAN_CTAG_FILTER;
+	}
+
+	return 0;
+}
+
+static int ipqess_port_vlan_filtering(struct ipqess_port *port,
+				      bool vlan_filtering,
+				      struct netlink_ext_ack *extack)
+{
+	bool old_vlan_filtering = port->vlan_filtering;
+	bool apply;
+	int err;
+
+	/* We are called from ipqess_port_switchdev_blocking_event(),
+	 * which is not under rcu_read_lock(), unlike
+	 * ipqess_port_switchdev_event().
+	 */
+	rcu_read_lock();
+	apply = ipqess_port_can_apply_vlan_filtering(port, vlan_filtering, extack);
+	rcu_read_unlock();
+	if (!apply)
+		return -EINVAL;
+
+	if (old_vlan_filtering == vlan_filtering)
+		return 0;
+
+	err = qca8k_port_vlan_filtering(port->sw->priv, port->index,
+					vlan_filtering);
+
+	if (err)
+		return err;
+
+	port->vlan_filtering = vlan_filtering;
+
+	err = ipqess_port_manage_vlan_filtering(port->netdev,
+						vlan_filtering);
+	if (err)
+		goto restore;
+
+	return 0;
+
+restore:
+	err = qca8k_port_vlan_filtering(port->sw->priv, port->index,
+					old_vlan_filtering);
+	port->vlan_filtering = old_vlan_filtering;
+
+	return err;
+}
+
+static void ipqess_port_reset_vlan_filtering(struct ipqess_port *port,
+					     struct ipqess_bridge *bridge)
+{
+	struct netlink_ext_ack extack = {0};
+	bool change_vlan_filtering = false;
+	bool vlan_filtering;
+	int err;
+
+	if (br_vlan_enabled(bridge->netdev)) {
+		change_vlan_filtering = true;
+		vlan_filtering = false;
+	}
+
+	if (!change_vlan_filtering)
+		return;
+
+	err = ipqess_port_vlan_filtering(port, vlan_filtering, &extack);
+	if (extack._msg) {
+		dev_err(&port->netdev->dev, "port %d: %s\n", port->index,
+			extack._msg);
+	}
+	if (err && err != -EOPNOTSUPP) {
+		dev_err(&port->netdev->dev,
+			"port %d failed to reset VLAN filtering to %d: %pe\n",
+			port->index, vlan_filtering, ERR_PTR(err));
+	}
+}
+
+static int ipqess_port_ageing_time(struct ipqess_port *port,
+				   clock_t ageing_clock)
+{
+	unsigned long ageing_jiffies = clock_t_to_jiffies(ageing_clock);
+	unsigned int ageing_time = jiffies_to_msecs(ageing_jiffies);
+
+	if (ageing_time < IPQESS_SWITCH_AGEING_TIME_MIN ||
+	    ageing_time > IPQESS_SWITCH_AGEING_TIME_MAX)
+		return -ERANGE;
+
+	/* Program the fastest ageing time in case of multiple bridges */
+	ageing_time = ipqess_switch_fastest_ageing_time(port->sw, ageing_time);
+
+	port->ageing_time = ageing_time;
+	return ipqess_set_ageing_time(port->sw, ageing_time);
+}
+
+static int ipqess_port_switchdev_sync_attrs(struct ipqess_port *port,
+					    struct netlink_ext_ack *extack)
+{
+	struct net_device *brport_dev = ipqess_port_get_bridged_netdev(port);
+	struct net_device *br = ipqess_port_bridge_dev_get(port);
+	int err;
+
+	ipqess_port_set_state_now(port, br_port_get_stp_state(brport_dev), false);
+
+	err = ipqess_port_vlan_filtering(port, br_vlan_enabled(br), extack);
+	if (err)
+		return err;
+
+	err = ipqess_port_ageing_time(port, br_get_ageing_time(br));
+	if (err && err != -EOPNOTSUPP)
+		return err;
+
+	return 0;
+}
+
+static void ipqess_port_switchdev_unsync_attrs(struct ipqess_port *port,
+					       struct ipqess_bridge *bridge)
+{
+	/* Port left the bridge, put in BR_STATE_DISABLED by the bridge layer,
+	 * so allow it to be in BR_STATE_FORWARDING to be kept functional
+	 */
+	ipqess_port_set_state_now(port, BR_STATE_FORWARDING, true);
+
+	ipqess_port_reset_vlan_filtering(port, bridge);
+
+	/* Ageing time is global to the switch chip, so don't change it
+	 * here because we have no good reason (or value) to change it to.
+	 */
+}
+
+static inline bool ipqess_port_offloads_bridge(struct ipqess_port *port,
+					       const struct ipqess_bridge *bridge)
+{
+	return ipqess_port_bridge_dev_get(port) == bridge->netdev;
+}
+
+bool ipqess_port_offloads_bridge_port(struct ipqess_port *port,
+				      const struct net_device *netdev)
+{
+	return ipqess_port_get_bridged_netdev(port) == netdev;
+}
+
+static inline bool
+ipqess_port_offloads_bridge_dev(struct ipqess_port *port,
+				const struct net_device *bridge_dev)
+{
+	/* QCA8K ports connected to a bridge, and event was emitted
+	 * for the bridge.
+	 */
+	return ipqess_port_bridge_dev_get(port) == bridge_dev;
+}
+
+static void ipqess_port_bridge_destroy(struct ipqess_port *port,
+				       const struct net_device *br)
+{
+	struct ipqess_bridge *bridge = port->bridge;
+
+	port->bridge = NULL;
+
+	if (!refcount_dec_and_test(&bridge->refcount))
+		return;
+
+	kfree(bridge);
+}
+
+int ipqess_port_bridge_join(struct ipqess_port *port, struct net_device *br,
+			    struct netlink_ext_ack *extack)
+{
+	struct ipqess_switch *sw = port->sw;
+	struct ipqess_bridge *bridge = NULL;
+	struct qca8k_priv *priv = sw->priv;
+	struct ipqess_port *other_port;
+	struct net_device *brport_dev;
+	int port_id = port->index;
+	int port_mask = 0;
+	int i, err;
+
+	/* QCA8K doesn't support MST */
+	if (br_mst_enabled(br)) {
+		err = -EOPNOTSUPP;
+		goto out_err;
+	}
+
+	/* Check if we already registered this bridge with
+	 * another switch port
+	 */
+	for (i = 0; i < IPQESS_SWITCH_MAX_PORTS; i++) {
+		other_port = sw->port_list[i];
+		if (other_port && other_port->bridge &&
+		    other_port->bridge->netdev == br)
+			bridge = other_port->bridge;
+	}
+
+	if (bridge) {
+		refcount_inc(&bridge->refcount);
+		port->bridge = bridge;
+	} else {
+		err = ipqess_port_bridge_alloc(port, br, extack);
+		if (err)
+			goto out_err;
+	}
+	bridge = port->bridge;
+
+	for (i = 1; i <= IPQESS_SWITCH_MAX_PORTS; i++) {
+		other_port = sw->port_list[i - 1];
+		if (!other_port || !ipqess_port_offloads_bridge(other_port, bridge))
+			continue;
+		/* Add this port to the portvlan mask of the other ports
+		 * in the bridge
+		 */
+		err = regmap_set_bits(priv->regmap,
+				      QCA8K_PORT_LOOKUP_CTRL(i),
+				      BIT(port_id));
+		if (err)
+			goto out_rollback;
+		if (i != port_id)
+			port_mask |= BIT(i);
+	}
+	/* Also add the CPU port */
+	err = regmap_set_bits(priv->regmap,
+			      QCA8K_PORT_LOOKUP_CTRL(0),
+			      BIT(port_id));
+	port_mask |= BIT(0);
+
+	/* Add all other ports to this ports portvlan mask */
+	err = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port_id),
+			QCA8K_PORT_LOOKUP_MEMBER, port_mask);
+	if (err)
+		goto out_rollback;
+
+	brport_dev = ipqess_port_get_bridged_netdev(port);
+
+	err = switchdev_bridge_port_offload(brport_dev, port->netdev, port,
+					    &ipqess_switchdev_notifier,
+					    &ipqess_switchdev_blocking_notifier,
+					    false, extack);
+	if (err)
+		goto out_rollback_unbridge;
+
+	err = ipqess_port_switchdev_sync_attrs(port, extack);
+	if (err)
+		goto out_rollback_unoffload;
+
+	return 0;
+
+out_rollback_unoffload:
+	switchdev_bridge_port_unoffload(brport_dev, port,
+					&ipqess_switchdev_notifier,
+					&ipqess_switchdev_blocking_notifier);
+	ipqess_flush_workqueue();
+out_rollback_unbridge:
+	for (i = 1; i <= IPQESS_SWITCH_MAX_PORTS; i++) {
+		other_port = sw->port_list[i - 1];
+		if (!other_port ||
+		    !ipqess_port_offloads_bridge(other_port, port->bridge))
+			continue;
+		/* Remove this port from the portvlan mask of the other ports
+		 * in the bridge
+		 */
+		regmap_clear_bits(priv->regmap,
+				  QCA8K_PORT_LOOKUP_CTRL(i),
+				  BIT(port_id));
+	}
+
+	/* Set the cpu port to be the only one in the portvlan mask of
+	 * this port
+	 */
+	qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port_id),
+		  QCA8K_PORT_LOOKUP_MEMBER, BIT(0));
+out_rollback:
+	ipqess_port_bridge_destroy(port, br);
+out_err:
+	dev_err(&port->netdev->dev, "Failed to join bridge: errno %d\n", err);
+	return err;
+}
+
+void ipqess_port_bridge_leave(struct ipqess_port *port, struct net_device *br)
+{
+	struct ipqess_bridge *bridge = port->bridge;
+	struct ipqess_switch *sw = port->sw;
+	struct qca8k_priv *priv = sw->priv;
+	struct ipqess_port *other_port;
+	int port_id = port->index;
+	int i;
+
+	/* If the port could not be offloaded to begin with, then
+	 * there is nothing to do.
+	 */
+	if (!bridge)
+		return;
+
+	for (i = 1; i <= IPQESS_SWITCH_MAX_PORTS; i++) {
+		other_port = sw->port_list[i - 1];
+		if (!other_port || !ipqess_port_offloads_bridge(other_port, bridge))
+			continue;
+		/* Remove this port from the portvlan mask of the other ports
+		 * in the bridge
+		 */
+		regmap_clear_bits(priv->regmap,
+				  QCA8K_PORT_LOOKUP_CTRL(i),
+				  BIT(port_id));
+	}
+
+	/* Set the cpu port to be the only one in the portvlan mask of
+	 * this port
+	 */
+	qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port_id),
+		  QCA8K_PORT_LOOKUP_MEMBER, BIT(0));
+
+	ipqess_port_switchdev_unsync_attrs(port, bridge);
+
+	/* Here the port is already unbridged. Reflect the current configuration. */
+
+	ipqess_port_bridge_destroy(port, br);
+}
+
+int ipqess_port_attr_set(struct net_device *dev, const void *ctx,
+			 const struct switchdev_attr *attr,
+			 struct netlink_ext_ack *extack)
+{
+	struct ipqess_port *port = netdev_priv(dev);
+	int ret;
+
+	if (ctx && ctx != port)
+		return 0;
+
+	switch (attr->id) {
+	case SWITCHDEV_ATTR_ID_PORT_STP_STATE:
+		if (!ipqess_port_offloads_bridge_port(port, attr->orig_dev))
+			return -EOPNOTSUPP;
+
+		ipqess_port_set_state_now(port, attr->u.stp_state, true);
+		return 0;
+	case SWITCHDEV_ATTR_ID_BRIDGE_VLAN_FILTERING:
+		if (!ipqess_port_offloads_bridge_dev(port, attr->orig_dev))
+			return -EOPNOTSUPP;
+
+		ret = ipqess_port_vlan_filtering(port, attr->u.vlan_filtering,
+						 extack);
+		break;
+	case SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME:
+		if (!ipqess_port_offloads_bridge_dev(port, attr->orig_dev))
+			return -EOPNOTSUPP;
+
+		ret = ipqess_port_ageing_time(port, attr->u.ageing_time);
+		break;
+	case SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS:
+		if (!ipqess_port_offloads_bridge_port(port, attr->orig_dev))
+			return -EOPNOTSUPP;
+
+		return -EINVAL;
+	case SWITCHDEV_ATTR_ID_BRIDGE_MST:
+	case SWITCHDEV_ATTR_ID_PORT_MST_STATE:
+	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
+	case SWITCHDEV_ATTR_ID_VLAN_MSTI:
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	return ret;
+}
+
+static int ipqess_port_vlan_check_for_8021q_uppers(struct net_device *netdev,
+						   const struct switchdev_obj_port_vlan *vlan)
+{
+	struct net_device *upper_dev;
+	struct list_head *iter;
+
+	netdev_for_each_upper_dev_rcu(netdev, upper_dev, iter) {
+		u16 vid;
+
+		if (!is_vlan_dev(upper_dev))
+			continue;
+
+		vid = vlan_dev_vlan_id(upper_dev);
+		if (vid == vlan->vid)
+			return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int ipqess_port_host_vlan_del(struct net_device *netdev,
+				     const struct switchdev_obj *obj)
+{
+	struct ipqess_port *port = netdev_priv(netdev);
+	struct net_device *br = ipqess_port_bridge_dev_get(port);
+	struct switchdev_obj_port_vlan *vlan;
+
+	/* Do nothing if this is a software bridge */
+	if (!port->bridge)
+		return -EOPNOTSUPP;
+
+	if (br && !br_vlan_enabled(br))
+		return 0;
+
+	vlan = SWITCHDEV_OBJ_PORT_VLAN(obj);
+
+	return qca8k_vlan_del(port->sw->priv, 0, vlan->vid);
+}
+
+static int ipqess_port_vlan_del(struct net_device *netdev,
+				const struct switchdev_obj *obj)
+{
+	struct ipqess_port *port = netdev_priv(netdev);
+	struct net_device *br = ipqess_port_bridge_dev_get(port);
+	struct qca8k_priv *priv = port->sw->priv;
+	struct switchdev_obj_port_vlan *vlan;
+	int ret;
+
+	if (br && !br_vlan_enabled(br))
+		return 0;
+
+	vlan = SWITCHDEV_OBJ_PORT_VLAN(obj);
+
+	ret = qca8k_vlan_del(priv, port->index, vlan->vid);
+
+	if (ret)
+		dev_err(priv->dev, "Failed to delete VLAN from port %d (%d)\n",
+			port->index, ret);
+
+	return ret;
+}
+
+static int ipqess_port_host_vlan_add(struct net_device *netdev,
+				     const struct switchdev_obj *obj,
+				     struct netlink_ext_ack *extack)
+{
+	struct ipqess_port *port = netdev_priv(netdev);
+	struct switchdev_obj_port_vlan *vlan;
+	struct net_device *br;
+
+	br = ipqess_port_bridge_dev_get(port);
+	/* Do nothing is this is a software bridge */
+	if (!port->bridge)
+		return -EOPNOTSUPP;
+
+	if (br && !br_vlan_enabled(br)) {
+		NL_SET_ERR_MSG_MOD(extack, "skipping configuration of VLAN");
+		return 0;
+	}
+
+	vlan = SWITCHDEV_OBJ_PORT_VLAN(obj);
+
+	vlan->flags &= ~BRIDGE_VLAN_INFO_PVID;
+
+	/* Add vid to CPU port */
+	return qca8k_port_vlan_add(port->sw->priv, 0, vlan, extack);
+}
+
+static int ipqess_port_vlan_add(struct net_device *netdev,
+				const struct switchdev_obj *obj,
+				struct netlink_ext_ack *extack)
+{
+	struct ipqess_port *port = netdev_priv(netdev);
+	struct net_device *br = ipqess_port_bridge_dev_get(port);
+	struct switchdev_obj_port_vlan *vlan;
+	int err;
+
+	if (br && !br_vlan_enabled(br)) {
+		NL_SET_ERR_MSG_MOD(extack, "skipping configuration of VLAN");
+		return 0;
+	}
+
+	vlan = SWITCHDEV_OBJ_PORT_VLAN(obj);
+
+	/* Deny adding a bridge VLAN when there is already an 802.1Q upper with
+	 * the same VID.
+	 */
+	if (br && br_vlan_enabled(br)) {
+		rcu_read_lock();
+		err = ipqess_port_vlan_check_for_8021q_uppers(netdev, vlan);
+		rcu_read_unlock();
+		if (err) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Port already has a VLAN upper with this VID");
+			return err;
+		}
+	}
+
+	err = qca8k_port_vlan_add(port->sw->priv, port->index, vlan, extack);
+	return err;
+}
+
+static int ipqess_port_host_mdb_del(struct ipqess_port *port,
+				    const struct switchdev_obj_port_mdb *mdb)
+{
+	struct qca8k_priv *priv = port->sw->priv;
+	const u8 *addr = mdb->addr;
+	u16 vid = mdb->vid;
+
+	return qca8k_fdb_search_and_del(priv, BIT(0), addr, vid);
+}
+
+static int ipqess_port_host_mdb_add(struct ipqess_port *port,
+				    const struct switchdev_obj_port_mdb *mdb)
+{
+	struct qca8k_priv *priv = port->sw->priv;
+	const u8 *addr = mdb->addr;
+	u16 vid = mdb->vid;
+
+	return qca8k_fdb_search_and_insert(priv, BIT(0), addr, vid,
+					   QCA8K_ATU_STATUS_STATIC);
+}
+
+static int ipqess_port_mdb_del(struct ipqess_port *port,
+			       const struct switchdev_obj_port_mdb *mdb)
+{
+	struct qca8k_priv *priv = port->sw->priv;
+	const u8 *addr = mdb->addr;
+	u16 vid = mdb->vid;
+
+	return qca8k_fdb_search_and_del(priv, BIT(port->index), addr, vid);
+}
+
+static int ipqess_port_mdb_add(struct ipqess_port *port,
+			       const struct switchdev_obj_port_mdb *mdb)
+{
+	struct qca8k_priv *priv = port->sw->priv;
+	const u8 *addr = mdb->addr;
+	u16 vid = mdb->vid;
+
+	return qca8k_fdb_search_and_insert(priv, BIT(port->index), addr, vid,
+					   QCA8K_ATU_STATUS_STATIC);
+}
+
+int ipqess_port_obj_add(struct net_device *netdev, const void *ctx,
+			const struct switchdev_obj *obj,
+			struct netlink_ext_ack *extack)
+{
+	struct ipqess_port *port = netdev_priv(netdev);
+	int err;
+
+	if (ctx && ctx != port)
+		return 0;
+
+	switch (obj->id) {
+	case SWITCHDEV_OBJ_ID_PORT_MDB:
+		if (!ipqess_port_offloads_bridge_port(port, obj->orig_dev))
+			return -EOPNOTSUPP;
+
+		err = ipqess_port_mdb_add(port, SWITCHDEV_OBJ_PORT_MDB(obj));
+		break;
+	case SWITCHDEV_OBJ_ID_HOST_MDB:
+		if (!ipqess_port_offloads_bridge_dev(port, obj->orig_dev))
+			return -EOPNOTSUPP;
+
+		err = ipqess_port_host_mdb_add(port, SWITCHDEV_OBJ_PORT_MDB(obj));
+		break;
+	case SWITCHDEV_OBJ_ID_PORT_VLAN:
+		if (ipqess_port_offloads_bridge_port(port, obj->orig_dev))
+			err = ipqess_port_vlan_add(netdev, obj, extack);
+		else
+			err = ipqess_port_host_vlan_add(netdev, obj, extack);
+		break;
+	case SWITCHDEV_OBJ_ID_MRP:
+	case SWITCHDEV_OBJ_ID_RING_ROLE_MRP:
+	default:
+		err = -EOPNOTSUPP;
+		break;
+	}
+
+	return err;
+}
+
+int ipqess_port_obj_del(struct net_device *netdev, const void *ctx,
+			const struct switchdev_obj *obj)
+{
+	struct ipqess_port *port = netdev_priv(netdev);
+	int err;
+
+	if (ctx && ctx != port)
+		return 0;
+
+	switch (obj->id) {
+	case SWITCHDEV_OBJ_ID_PORT_MDB:
+		if (!ipqess_port_offloads_bridge_port(port, obj->orig_dev))
+			return -EOPNOTSUPP;
+
+		err = ipqess_port_mdb_del(port, SWITCHDEV_OBJ_PORT_MDB(obj));
+		break;
+	case SWITCHDEV_OBJ_ID_HOST_MDB:
+		if (!ipqess_port_offloads_bridge_dev(port, obj->orig_dev))
+			return -EOPNOTSUPP;
+
+		err = ipqess_port_host_mdb_del(port, SWITCHDEV_OBJ_PORT_MDB(obj));
+		break;
+	case SWITCHDEV_OBJ_ID_PORT_VLAN:
+		if (ipqess_port_offloads_bridge_port(port, obj->orig_dev))
+			err = ipqess_port_vlan_del(netdev, obj);
+		else
+			err = ipqess_port_host_vlan_del(netdev, obj);
+		break;
+	case SWITCHDEV_OBJ_ID_MRP:
+	case SWITCHDEV_OBJ_ID_RING_ROLE_MRP:
+	default:
+		err = -EOPNOTSUPP;
+		break;
+	}
+
+	return err;
+}
+
+static int ipqess_cpu_port_fdb_del(struct ipqess_port *port,
+				   const unsigned char *addr, u16 vid)
+{
+	struct ipqess_mac_addr *mac_addr = NULL;
+	struct ipqess_mac_addr *other_mac_addr;
+	struct ipqess_switch *sw = port->sw;
+	int err = 0;
+
+	mutex_lock(&sw->addr_lists_lock);
+
+	list_for_each_entry(other_mac_addr, &sw->fdbs, list)
+		if (ether_addr_equal(other_mac_addr->addr, addr) && other_mac_addr->vid == vid)
+			mac_addr = other_mac_addr;
+
+	if (!mac_addr) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	if (!refcount_dec_and_test(&mac_addr->refcount))
+		goto out;
+
+	err = qca8k_fdb_del(sw->priv, addr, BIT(IPQESS_SWITCH_CPU_PORT), vid);
+	if (err) {
+		refcount_set(&mac_addr->refcount, 1);
+		goto out;
+	}
+
+	list_del(&mac_addr->list);
+	kfree(mac_addr);
+
+out:
+	mutex_unlock(&sw->addr_lists_lock);
+
+	return err;
+}
+
+static int ipqess_cpu_port_fdb_add(struct ipqess_port *port,
+				   const unsigned char *addr, u16 vid)
+{
+	struct ipqess_switch *sw = port->sw;
+	struct ipqess_mac_addr *other_a = NULL;
+	struct ipqess_mac_addr *a = NULL;
+	int err = 0;
+
+	mutex_lock(&sw->addr_lists_lock);
+
+	list_for_each_entry(other_a, &sw->fdbs, list)
+		if (ether_addr_equal(other_a->addr, addr) && other_a->vid == vid)
+			a = other_a;
+
+	if (a) {
+		refcount_inc(&a->refcount);
+		goto out;
+	}
+
+	a = kzalloc(sizeof(*a), GFP_KERNEL);
+	if (!a) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	err = qca8k_port_fdb_insert(port->sw->priv, addr,
+				    BIT(IPQESS_SWITCH_CPU_PORT), vid);
+	if (err) {
+		kfree(a);
+		goto out;
+	}
+
+	ether_addr_copy(a->addr, addr);
+	a->vid = vid;
+	refcount_set(&a->refcount, 1);
+	list_add_tail(&a->list, &sw->fdbs);
+
+out:
+	mutex_unlock(&sw->addr_lists_lock);
+
+	return err;
+}
+
+static void
+ipqess_fdb_offload_notify(struct ipqess_switchdev_event_work *switchdev_work)
+{
+	struct switchdev_notifier_fdb_info info = {};
+
+	info.addr = switchdev_work->addr;
+	info.vid = switchdev_work->vid;
+	info.offloaded = true;
+	call_switchdev_notifiers(SWITCHDEV_FDB_OFFLOADED,
+				 switchdev_work->orig_netdev, &info.info, NULL);
+}
+
+void ipqess_port_switchdev_event_work(struct work_struct *work)
+{
+	struct ipqess_switchdev_event_work *switchdev_work =
+		container_of(work, struct ipqess_switchdev_event_work, work);
+	struct net_device *netdev = switchdev_work->netdev;
+	const unsigned char *addr = switchdev_work->addr;
+	struct ipqess_port *port = netdev_priv(netdev);
+	struct ipqess_switch *sw = port->sw;
+	struct qca8k_priv *priv = sw->priv;
+	u16 vid = switchdev_work->vid;
+	int err;
+
+	if (!vid)
+		vid = QCA8K_PORT_VID_DEF;
+
+	switch (switchdev_work->event) {
+	case SWITCHDEV_FDB_ADD_TO_DEVICE:
+		if (switchdev_work->host_addr)
+			err = ipqess_cpu_port_fdb_add(port, addr, vid);
+		else
+			err = qca8k_port_fdb_insert(priv, addr, BIT(port->index), vid);
+		if (err) {
+			dev_err(&port->netdev->dev,
+				"port %d failed to add %pM vid %d to fdb: %d\n",
+				port->index, addr, vid, err);
+			break;
+		}
+		ipqess_fdb_offload_notify(switchdev_work);
+		break;
+
+	case SWITCHDEV_FDB_DEL_TO_DEVICE:
+		if (switchdev_work->host_addr)
+			err = ipqess_cpu_port_fdb_del(port, addr, vid);
+		else
+			err = qca8k_fdb_del(priv, addr, BIT(port->index), vid);
+		if (err) {
+			dev_err(&port->netdev->dev,
+				"port %d failed to delete %pM vid %d from fdb: %d\n",
+				port->index, addr, vid, err);
+		}
+
+		break;
+	}
+
+	kfree(switchdev_work);
+}
+
+int ipqess_port_check_8021q_upper(struct net_device *netdev,
+				  struct netdev_notifier_changeupper_info *info)
+{
+	struct ipqess_port *port = netdev_priv(netdev);
+	struct net_device *br = ipqess_port_bridge_dev_get(port);
+	struct bridge_vlan_info br_info;
+	struct netlink_ext_ack *extack;
+	int err = NOTIFY_DONE;
+	u16 vid;
+
+	if (!br || !br_vlan_enabled(br))
+		return NOTIFY_DONE;
+
+	extack = netdev_notifier_info_to_extack(&info->info);
+	vid = vlan_dev_vlan_id(info->upper_dev);
+
+	/* br_vlan_get_info() returns -EINVAL or -ENOENT if the
+	 * device, respectively the VID is not found, returning
+	 * 0 means success, which is a failure for us here.
+	 */
+	err = br_vlan_get_info(br, vid, &br_info);
+	if (err == 0) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "This VLAN is already configured by the bridge");
+		return notifier_from_errno(-EBUSY);
+	}
+
+	return NOTIFY_DONE;
+}
+
 /* phylink ops */
 
 static void
@@ -669,6 +1511,7 @@ int ipqess_port_register(struct ipqess_switch *sw,
 	port->edma = NULL; /* Assigned during edma initialization */
 	port->qid = port->index - 1;
 	port->sw = sw;
+	port->bridge = NULL;
 
 	of_get_mac_address(port_node, port->mac);
 	if (!is_zero_ether_addr(port->mac))
@@ -756,3 +1599,58 @@ void ipqess_port_unregister(struct ipqess_port *port)
 	free_netdev(netdev);
 }
 
+/* Utilities */
+
+/* Returns true if any port of this switch offloads the given net_device */
+static bool ipqess_switch_offloads_bridge_port(struct ipqess_switch *sw,
+					       const struct net_device *netdev)
+{
+	struct ipqess_port *port;
+	int i;
+
+	for (i = 0; i < IPQESS_SWITCH_MAX_PORTS; i++) {
+		port = sw->port_list[i];
+		if (port && ipqess_port_offloads_bridge_port(port, netdev))
+			return true;
+	}
+
+	return false;
+}
+
+/* Returns true if any port of this switch offloads the given bridge */
+static inline bool
+ipqess_switch_offloads_bridge_dev(struct ipqess_switch *sw,
+				  const struct net_device *bridge_dev)
+{
+	struct ipqess_port *port;
+	int i;
+
+	for (i = 0; i < IPQESS_SWITCH_MAX_PORTS; i++) {
+		port = sw->port_list[i];
+		if (port && ipqess_port_offloads_bridge_dev(port, bridge_dev))
+			return true;
+	}
+
+	return false;
+}
+
+bool ipqess_port_recognize_netdev(const struct net_device *netdev)
+{
+	return netdev->netdev_ops == &ipqess_port_netdev_ops;
+}
+
+bool ipqess_port_dev_is_foreign(const struct net_device *netdev,
+				const struct net_device *foreign_netdev)
+{
+	struct ipqess_port *port = netdev_priv(netdev);
+	struct ipqess_switch *sw = port->sw;
+
+	if (netif_is_bridge_master(foreign_netdev))
+		return !ipqess_switch_offloads_bridge_dev(sw, foreign_netdev);
+
+	if (netif_is_bridge_port(foreign_netdev))
+		return !ipqess_switch_offloads_bridge_port(sw, foreign_netdev);
+
+	/* Everything else is foreign */
+	return true;
+}
diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h
index 19d4b5d73625..00f0dff9c39d 100644
--- a/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h
+++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h
@@ -9,6 +9,11 @@
 #include "ipqess_edma.h"
 #include "ipqess_switch.h"
 
+struct ipqess_bridge {
+	struct net_device *netdev;
+	refcount_t refcount;
+};
+
 struct ipqess_port {
 	u16 index;
 	u16 qid;
@@ -20,6 +25,7 @@ struct ipqess_port {
 	struct device_node *dn;
 	struct mii_bus *mii_bus;
 	struct net_device *netdev;
+	struct ipqess_bridge *bridge;
 	struct devlink_port devlink_port;
 
 	u8       stp_state;
@@ -62,4 +68,31 @@ void ipqess_port_unregister(struct ipqess_port *port);
 /* Defined in ipqess_ethtool.c */
 void ipqess_port_set_ethtool_ops(struct net_device *netdev);
 
+bool ipqess_port_recognize_netdev(const struct net_device *netdev);
+bool ipqess_port_dev_is_foreign(const struct net_device *netdev,
+				const struct net_device *foreign_netdev);
+
+int ipqess_port_bridge_join(struct ipqess_port *port, struct net_device *br,
+			    struct netlink_ext_ack *extack);
+void ipqess_port_bridge_leave(struct ipqess_port *port, struct net_device *br);
+
+int ipqess_port_attr_set(struct net_device *dev, const void *ctx,
+			 const struct switchdev_attr *attr,
+			 struct netlink_ext_ack *extack);
+
+void ipqess_port_switchdev_event_work(struct work_struct *work);
+
+int ipqess_port_check_8021q_upper(struct net_device *netdev,
+				  struct netdev_notifier_changeupper_info *info);
+
+struct net_device *ipqess_port_get_bridged_netdev(const struct ipqess_port *port);
+
+int ipqess_port_obj_add(struct net_device *netdev, const void *ctx,
+			const struct switchdev_obj *obj,
+			struct netlink_ext_ack *extack);
+int ipqess_port_obj_del(struct net_device *netdev, const void *ctx,
+			const struct switchdev_obj *obj);
+
+bool ipqess_port_offloads_bridge_port(struct ipqess_port *port,
+				      const struct net_device *netdev);
 #endif
diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.c b/drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.c
index 927f834a62bc..d09d0aa8314f 100644
--- a/drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.c
+++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.c
@@ -80,21 +80,8 @@ unsigned int ipqess_switch_fastest_ageing_time(struct ipqess_switch *sw,
 int ipqess_set_ageing_time(struct ipqess_switch *sw, unsigned int msecs)
 {
 	struct qca8k_priv *priv = sw->priv;
-	unsigned int secs = msecs / 1000;
-	u32 val;
 
-	/* AGE_TIME reg is set in 7s step */
-	val = secs / 7;
-
-	/* Handle case with 0 as val to NOT disable
-	 * learning
-	 */
-	if (!val)
-		val = 1;
-
-	return regmap_update_bits(priv->regmap, QCA8K_REG_ATU_CTRL,
-				  QCA8K_ATU_AGE_TIME_MASK,
-				  QCA8K_ATU_AGE_TIME(val));
+	return qca8k_set_ageing_time(priv, msecs);
 }
 
 static struct qca8k_pcs *pcs_to_qca8k_pcs(struct phylink_pcs *pcs)
diff --git a/include/linux/dsa/qca8k.h b/include/linux/dsa/qca8k.h
index cafb727f4e8b..9ad016f7201e 100644
--- a/include/linux/dsa/qca8k.h
+++ b/include/linux/dsa/qca8k.h
@@ -553,7 +553,8 @@ int qca8k_set_mac_eee(struct dsa_switch *ds, int port, struct ethtool_eee *eee);
 int qca8k_get_mac_eee(struct dsa_switch *ds, int port, struct ethtool_eee *e);
 
 /* Common bridge function */
-void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state);
+void qca8k_port_stp_state_set(struct qca8k_priv *priv, int port, u8 state,
+			      bool port_learning, int set_learning);
 int qca8k_port_pre_bridge_flags(struct dsa_switch *ds, int port,
 				struct switchdev_brport_flags flags,
 				struct netlink_ext_ack *extack);
@@ -577,8 +578,8 @@ int qca8k_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu);
 int qca8k_port_max_mtu(struct dsa_switch *ds, int port);
 
 /* Common fast age function */
-void qca8k_port_fast_age(struct dsa_switch *ds, int port);
-int qca8k_set_ageing_time(struct dsa_switch *ds, unsigned int msecs);
+void qca8k_port_fast_age(struct qca8k_priv *priv, int port);
+int qca8k_set_ageing_time(struct qca8k_priv *priv, unsigned int msecs);
 
 /* Common FDB function */
 int qca8k_port_fdb_insert(struct qca8k_priv *priv, const u8 *addr,
@@ -589,7 +590,7 @@ int qca8k_port_fdb_add(struct dsa_switch *ds, int port,
 int qca8k_port_fdb_del(struct dsa_switch *ds, int port,
 		       const unsigned char *addr, u16 vid,
 		       struct dsa_db db);
-int qca8k_port_fdb_dump(struct dsa_switch *ds, int port,
+int qca8k_port_fdb_dump(struct qca8k_priv *priv, int port,
 			dsa_fdb_dump_cb_t *cb, void *data);
 int qca8k_fdb_del(struct qca8k_priv *priv, const u8 *mac,
 		  u16 port_mask, u16 vid);
@@ -618,13 +619,12 @@ void qca8k_port_mirror_del(struct dsa_switch *ds, int port,
 			   struct dsa_mall_mirror_tc_entry *mirror);
 
 /* Common port VLAN function */
-int qca8k_port_vlan_filtering(struct dsa_switch *ds, int port,
-			      bool vlan_filtering,
-			      struct netlink_ext_ack *extack);
+int qca8k_port_vlan_filtering(struct qca8k_priv *priv, int port,
+			      bool vlan_filtering);
 int qca8k_vlan_add(struct qca8k_priv *priv, u8 port, u16 vid,
 		   bool untagged);
 int qca8k_vlan_del(struct qca8k_priv *priv, u8 port, u16 vid);
-int qca8k_port_vlan_add(struct dsa_switch *ds, int port,
+int qca8k_port_vlan_add(struct qca8k_priv *priv, int port,
 			const struct switchdev_obj_port_vlan *vlan,
 			struct netlink_ext_ack *extack);
 int qca8k_port_vlan_del(struct dsa_switch *ds, int port,
-- 
2.42.0

