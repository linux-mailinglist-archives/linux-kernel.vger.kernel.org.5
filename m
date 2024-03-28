Return-Path: <linux-kernel+bounces-98784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D81877F5E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1581C2187F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF583BBF0;
	Mon, 11 Mar 2024 11:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="vRs06jc7"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3024838394;
	Mon, 11 Mar 2024 11:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710158239; cv=none; b=QqbNULuJyBpbMIOWCMbDLoOgzZzuDCkNaSnryFGhydYgdTC2YifZuhg3g88HHUwJWcf2m/h3exaGWycGF/KvAtBmKwP+4hNoAy6WwtBKNFFXIRU1crtnnqcLh8ItV2YHDfkk6a+q11y6HOohK02fqm1kelD/1E1+1TdS6h1OcOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710158239; c=relaxed/simple;
	bh=522rLaAZZanrfms8TvddDnRPh0VdvCQ5dbSvePIaewg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UsRZnkwjonnFgo2r3+aHIpRWDsh9BQ1Pt5G7WuCvFR0Pjlcz5GLbx/GYnPho9988xfHrkRIVmGTWVdgDmjywE2rWKWfEkf4gRFOPqQ+EIei2t40i9d+nqCiVHksYWH/I1l2+oXPrJ1v8jZAVe1TDQXZqIBeWo4c5wnesg8+MnlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=vRs06jc7; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 636FC875FC;
	Mon, 11 Mar 2024 12:57:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1710158229;
	bh=zTgGSEQmq0/W1toe4jgHytT8uGDxeOmPFzquEHMMRDg=;
	h=From:To:Cc:Subject:Date:From;
	b=vRs06jc72WOVoto+XPWO9dCGGwYVmPSrOu4O2AxgqX+SK384W5z4q6j/7gjWeK4f2
	 QWSs4vyCOiffFdsQp2zYmAhflIAz02f9SGUbhais0yA0ZfS+8ZvAwaDRl1ZFeYTyws
	 pasPSgtHj6UTm+DEJq/lTkCBgQEaE6KWvII+a4/QXCyQxWOrmfMWCdCx2a6OgeinYg
	 ldBPZ94tZXl6I/yEzd7BT7jvJX9TRXcSQUNihzMcMzGGT6+b0cAYwY3jwm86MEhnoV
	 Yvotgntt5w3uxtIb2XVGPKtkn3FAAVN4wn+VNGCT+U3Cs5vw0KBYk97njWdOeVt1XD
	 CpspR1AY0bOOA==
From: Lukasz Majewski <lukma@denx.de>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Simon Horman <horms@kernel.org>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Ziyang Xuan <william.xuanziyang@huawei.com>,
	Kristian Overskeid <koverskeid@gmail.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	linux-kernel@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v3] net: hsr: Provide RedBox support
Date: Mon, 11 Mar 2024 12:56:44 +0100
Message-Id: <20240311115644.823829-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Introduce RedBox support (HSR-SAN to be more precise) for HSR networks.
Following traffic reduction optimizations have been implemented:
- Do not send HSR supervisory frames to Port C (interlink)
- Do not forward to HSR ring frames addressed to Port C
- Do not forward to Port C frames from HSR ring
- Do not send duplicate HSR frame to HSR ring when destination is Port C

The corresponding patch to modify iptable2 sources has already been sent:
https://lore.kernel.org/netdev/20240308145729.490863-1-lukma@denx.de/T/

Testing procedure:
------------------
The EVB-KSZ9477 has been used for testing on net-next branch
(SHA1: 709776ea8562).

Ports 4/5 were used for SW managed HSR (hsr1) as first hsr0 for ports 1/2
(with HW offloading for ksz9477) was created. Port 3 has been used as
interlink port (single USB-ETH dongle).

Configuration - RedBox (EVB-KSZ9477):
ifconfig lan1 down;ifconfig lan2 down
ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 supervision 45 version 1
ip link add name hsr1 type hsr slave1 lan4 slave2 lan5 interlink lan3 supervision 45 version 1
ifconfig lan4 up;ifconfig lan5 up
ifconfig lan3 up
ifconfig hsr1 192.168.0.11 up

Configuration - DAN-H (EVB-KSZ9477):

ifconfig lan1 down;ifconfig lan2 down
ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 supervision 45 version 1
ip link add name hsr1 type hsr slave1 lan4 slave2 lan5 supervision 45 version 1
ifconfig lan4 up;ifconfig lan5 up
ifconfig hsr1 192.168.0.12 up

This approach uses only SW based HSR devices (hsr1).

--------------          -----------------       ------------
DAN-H  Port5 | <------> | Port5         |       |
       Port4 | <------> | Port4   Port3 | <---> | PC
             |          | (RedBox)      |       | (USB-ETH)
EVB-KSZ9477  |          | EVB-KSZ9477   |       |
--------------          -----------------       ------------

Signed-off-by: Lukasz Majewski <lukma@denx.de>

---
Changes for v2:

- Add deleting of HSR_PT_INTERLINK node to hsr_del_ports()
- Rewrite handle_std_frame() to awoid code duplication
- Fix reverse christmas tree in hsr_prune_proxy_nodes() as well as
  remove stale node indication as interlink doesn't need this detection
  (only check if node is inactive for more than HSR_PROXY_NODE_FORGET_TIME
  is required)
- Rewrite commit message

Changes for v3:

- Modify frame passed Port C (Interlink) to have RedBox's source address (SA)
  This fixes issue with connecting L2 switch to Interlink Port as switches
  drop frames with SA other than one registered in their (internal) routing
  tables.

- Do not forward to port C (Interlink) frames from nodes A and B if DA is
  in NodeTable.

- Fix problem with ProxyNodeTable being pollued by nodes already registered
  in HSR ring.

- Prevent from sending frames to HSR ring when destination addresses (DA)
  are in ProxyNodeTable
---
 include/uapi/linux/if_link.h |  1 +
 net/hsr/hsr_device.c         | 36 ++++++++++++++-
 net/hsr/hsr_device.h         |  4 +-
 net/hsr/hsr_forward.c        | 85 ++++++++++++++++++++++++++++++++----
 net/hsr/hsr_framereg.c       | 52 ++++++++++++++++++++++
 net/hsr/hsr_framereg.h       |  6 +++
 net/hsr/hsr_main.h           |  7 +++
 net/hsr/hsr_netlink.c        | 29 ++++++++++--
 net/hsr/hsr_slave.c          |  1 +
 9 files changed, 205 insertions(+), 16 deletions(-)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index ab9bcff96e4d..b93a3acdd83f 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1770,6 +1770,7 @@ enum {
 	IFLA_HSR_PROTOCOL,		/* Indicate different protocol than
 					 * HSR. For example PRP.
 					 */
+	IFLA_HSR_INTERLINK,		/* HSR interlink network device */
 	__IFLA_HSR_MAX,
 };
 
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 904cd8f8f830..1be6563e0231 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -156,6 +156,9 @@ static int hsr_dev_open(struct net_device *dev)
 		case HSR_PT_SLAVE_B:
 			designation = "Slave B";
 			break;
+		case HSR_PT_INTERLINK:
+			designation = "Interlink";
+			break;
 		default:
 			designation = "Unknown";
 		}
@@ -295,6 +298,7 @@ static void send_hsr_supervision_frame(struct hsr_port *master,
 	struct hsr_priv *hsr = master->hsr;
 	__u8 type = HSR_TLV_LIFE_CHECK;
 	struct hsr_sup_payload *hsr_sp;
+	struct hsr_sup_tlv *hsr_stlv;
 	struct hsr_sup_tag *hsr_stag;
 	struct sk_buff *skb;
 
@@ -334,6 +338,16 @@ static void send_hsr_supervision_frame(struct hsr_port *master,
 	hsr_sp = skb_put(skb, sizeof(struct hsr_sup_payload));
 	ether_addr_copy(hsr_sp->macaddress_A, master->dev->dev_addr);
 
+	if (hsr->redbox) {
+		hsr_stlv = skb_put(skb, sizeof(struct hsr_sup_tlv));
+		hsr_stlv->HSR_TLV_type = PRP_TLV_REDBOX_MAC;
+		hsr_stlv->HSR_TLV_length = sizeof(struct hsr_sup_payload);
+
+		/* Payload: MacAddressRedBox */
+		hsr_sp = skb_put(skb, sizeof(struct hsr_sup_payload));
+		ether_addr_copy(hsr_sp->macaddress_A, hsr->macaddress_redbox);
+	}
+
 	if (skb_put_padto(skb, ETH_ZLEN)) {
 		spin_unlock_bh(&hsr->seqnr_lock);
 		return;
@@ -418,6 +432,10 @@ void hsr_del_ports(struct hsr_priv *hsr)
 	port = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
 	if (port)
 		hsr_del_port(port);
+
+	port = hsr_port_get_hsr(hsr, HSR_PT_INTERLINK);
+	if (port)
+		hsr_del_port(port);
 }
 
 static void hsr_set_rx_mode(struct net_device *dev)
@@ -544,8 +562,8 @@ static const unsigned char def_multicast_addr[ETH_ALEN] __aligned(2) = {
 };
 
 int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
-		     unsigned char multicast_spec, u8 protocol_version,
-		     struct netlink_ext_ack *extack)
+		     struct net_device *interlink, unsigned char multicast_spec,
+		     u8 protocol_version, struct netlink_ext_ack *extack)
 {
 	bool unregister = false;
 	struct hsr_priv *hsr;
@@ -554,6 +572,7 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
 	hsr = netdev_priv(hsr_dev);
 	INIT_LIST_HEAD(&hsr->ports);
 	INIT_LIST_HEAD(&hsr->node_db);
+	INIT_LIST_HEAD(&hsr->proxy_node_db);
 	spin_lock_init(&hsr->list_lock);
 
 	eth_hw_addr_set(hsr_dev, slave[0]->dev_addr);
@@ -579,6 +598,7 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
 	/* Overflow soon to find bugs easier: */
 	hsr->sequence_nr = HSR_SEQNR_START;
 	hsr->sup_sequence_nr = HSR_SUP_SEQNR_START;
+	hsr->interlink_sequence_nr = HSR_SEQNR_START;
 
 	timer_setup(&hsr->announce_timer, hsr_announce, 0);
 	timer_setup(&hsr->prune_timer, hsr_prune_nodes, 0);
@@ -614,6 +634,18 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
 	if (res)
 		goto err_unregister;
 
+	if (interlink) {
+		res = hsr_add_port(hsr, interlink, HSR_PT_INTERLINK, extack);
+		if (res)
+			goto err_unregister;
+
+		hsr->redbox = true;
+		ether_addr_copy(hsr->macaddress_redbox, interlink->dev_addr);
+		timer_setup(&hsr->prune_proxy_timer, hsr_prune_proxy_nodes, 0);
+		mod_timer(&hsr->prune_proxy_timer,
+			  jiffies + msecs_to_jiffies(PRUNE_PROXY_PERIOD));
+	}
+
 	hsr_debugfs_init(hsr, hsr_dev);
 	mod_timer(&hsr->prune_timer, jiffies + msecs_to_jiffies(PRUNE_PERIOD));
 
diff --git a/net/hsr/hsr_device.h b/net/hsr/hsr_device.h
index 9060c92168f9..655284095b78 100644
--- a/net/hsr/hsr_device.h
+++ b/net/hsr/hsr_device.h
@@ -16,8 +16,8 @@
 void hsr_del_ports(struct hsr_priv *hsr);
 void hsr_dev_setup(struct net_device *dev);
 int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
-		     unsigned char multicast_spec, u8 protocol_version,
-		     struct netlink_ext_ack *extack);
+		     struct net_device *interlink, unsigned char multicast_spec,
+		     u8 protocol_version, struct netlink_ext_ack *extack);
 void hsr_check_carrier_and_operstate(struct hsr_priv *hsr);
 int hsr_get_max_mtu(struct hsr_priv *hsr);
 #endif /* __HSR_DEVICE_H */
diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 5d68cb181695..7c5a4bda1cca 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -377,6 +377,15 @@ static int hsr_xmit(struct sk_buff *skb, struct hsr_port *port,
 		 */
 		ether_addr_copy(eth_hdr(skb)->h_source, port->dev->dev_addr);
 	}
+
+	/* When HSR node is used as RedBox - the frame received from HSR ring
+	 * requires source MAC address (SA) replacement to one which can be
+	 * recognized by SAN devices (otherwise, frames are dropped by switch)
+	 */
+	if (port->type == HSR_PT_INTERLINK)
+		memcpy(&eth_hdr(skb)->h_source, port->hsr->macaddress_redbox,
+		       ETH_ALEN);
+
 	return dev_queue_xmit(skb);
 }
 
@@ -390,9 +399,57 @@ bool prp_drop_frame(struct hsr_frame_info *frame, struct hsr_port *port)
 
 bool hsr_drop_frame(struct hsr_frame_info *frame, struct hsr_port *port)
 {
+	struct sk_buff *skb;
+
 	if (port->dev->features & NETIF_F_HW_HSR_FWD)
 		return prp_drop_frame(frame, port);
 
+	/* RedBox specific frames dropping policies
+	 *
+	 * Do not send HSR supervisory frames to SAN devices
+	 */
+	if (frame->is_supervision && port->type == HSR_PT_INTERLINK)
+		return true;
+
+	/* Do not forward to other HSR port (A or B) unicast frames which
+	 * are addressed to interlink port (and are in the ProxyNodeTable).
+	 */
+	skb = frame->skb_hsr;
+	if (skb && prp_drop_frame(frame, port) &&
+	    is_unicast_ether_addr(eth_hdr(skb)->h_dest) &&
+	    hsr_is_node_in_db(&port->hsr->proxy_node_db,
+			      eth_hdr(skb)->h_dest)) {
+		return true;
+	}
+
+	/* Do not forward to port C (Interlink) frames from nodes A and B
+	 * if DA is in NodeTable.
+	 */
+	if ((frame->port_rcv->type == HSR_PT_SLAVE_A ||
+	     frame->port_rcv->type == HSR_PT_SLAVE_B) &&
+	    port->type == HSR_PT_INTERLINK) {
+		skb = frame->skb_hsr;
+		if (skb && is_unicast_ether_addr(eth_hdr(skb)->h_dest) &&
+		    hsr_is_node_in_db(&port->hsr->node_db,
+				      eth_hdr(skb)->h_dest)) {
+			return true;
+		}
+	}
+
+	/* Do not forward to port A and B unicast frames received on the
+	 * interlink port if it is addressed to one of nodes registered in
+	 * the ProxyNodeTable.
+	 */
+	if ((port->type == HSR_PT_SLAVE_A || port->type == HSR_PT_SLAVE_B) &&
+	    frame->port_rcv->type == HSR_PT_INTERLINK) {
+		skb = frame->skb_std;
+		if (skb && is_unicast_ether_addr(eth_hdr(skb)->h_dest) &&
+		    hsr_is_node_in_db(&port->hsr->proxy_node_db,
+				      eth_hdr(skb)->h_dest)) {
+			return true;
+		}
+	}
+
 	return false;
 }
 
@@ -448,13 +505,14 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
 		}
 
 		/* Check if frame is to be dropped. Eg. for PRP no forward
-		 * between ports.
+		 * between ports, or sending HSR supervision to RedBox.
 		 */
 		if (hsr->proto_ops->drop_frame &&
 		    hsr->proto_ops->drop_frame(frame, port))
 			continue;
 
-		if (port->type != HSR_PT_MASTER)
+		if (port->type == HSR_PT_SLAVE_A ||
+		    port->type == HSR_PT_SLAVE_B)
 			skb = hsr->proto_ops->create_tagged_frame(frame, port);
 		else
 			skb = hsr->proto_ops->get_untagged_frame(frame, port);
@@ -469,7 +527,9 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
 			hsr_deliver_master(skb, port->dev, frame->node_src);
 		} else {
 			if (!hsr_xmit(skb, port, frame))
-				sent = true;
+				if (port->type == HSR_PT_SLAVE_A ||
+				    port->type == HSR_PT_SLAVE_B)
+					sent = true;
 		}
 	}
 }
@@ -503,10 +563,12 @@ static void handle_std_frame(struct sk_buff *skb,
 	frame->skb_prp = NULL;
 	frame->skb_std = skb;
 
-	if (port->type != HSR_PT_MASTER) {
+	if (port->type != HSR_PT_MASTER)
 		frame->is_from_san = true;
-	} else {
-		/* Sequence nr for the master node */
+
+	if (port->type == HSR_PT_MASTER ||
+	    port->type == HSR_PT_INTERLINK) {
+		/* Sequence nr for the master/interlink node */
 		lockdep_assert_held(&hsr->seqnr_lock);
 		frame->sequence_nr = hsr->sequence_nr;
 		hsr->sequence_nr++;
@@ -564,6 +626,7 @@ static int fill_frame_info(struct hsr_frame_info *frame,
 {
 	struct hsr_priv *hsr = port->hsr;
 	struct hsr_vlan_ethhdr *vlan_hdr;
+	struct list_head *n_db;
 	struct ethhdr *ethhdr;
 	__be16 proto;
 	int ret;
@@ -574,9 +637,13 @@ static int fill_frame_info(struct hsr_frame_info *frame,
 
 	memset(frame, 0, sizeof(*frame));
 	frame->is_supervision = is_supervision_frame(port->hsr, skb);
-	frame->node_src = hsr_get_node(port, &hsr->node_db, skb,
-				       frame->is_supervision,
-				       port->type);
+
+	n_db = &hsr->node_db;
+	if (port->type == HSR_PT_INTERLINK)
+		n_db = &hsr->proxy_node_db;
+
+	frame->node_src = hsr_get_node(port, n_db, skb,
+				       frame->is_supervision, port->type);
 	if (!frame->node_src)
 		return -1; /* Unknown node and !is_supervision, or no mem */
 
diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 6d14d935ee82..68ecf85790bd 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -71,6 +71,14 @@ static struct hsr_node *find_node_by_addr_A(struct list_head *node_db,
 	return NULL;
 }
 
+/* Check if node for a given MAC address is already present in data base
+ */
+bool hsr_is_node_in_db(struct list_head *node_db,
+		       const unsigned char addr[ETH_ALEN])
+{
+	return !!find_node_by_addr_A(node_db, addr);
+}
+
 /* Helper for device init; the self_node is used in hsr_rcv() to recognize
  * frames from self that's been looped over the HSR ring.
  */
@@ -223,6 +231,15 @@ struct hsr_node *hsr_get_node(struct hsr_port *port, struct list_head *node_db,
 		}
 	}
 
+	/* Check if required node is not in proxy nodes table */
+	list_for_each_entry_rcu(node, &hsr->proxy_node_db, mac_list) {
+		if (ether_addr_equal(node->macaddress_A, ethhdr->h_source)) {
+			if (hsr->proto_ops->update_san_info)
+				hsr->proto_ops->update_san_info(node, is_sup);
+			return node;
+		}
+	}
+
 	/* Everyone may create a node entry, connected node to a HSR/PRP
 	 * device.
 	 */
@@ -414,6 +431,10 @@ void hsr_addr_subst_dest(struct hsr_node *node_src, struct sk_buff *skb,
 
 	node_dst = find_node_by_addr_A(&port->hsr->node_db,
 				       eth_hdr(skb)->h_dest);
+	if (!node_dst && port->hsr->redbox)
+		node_dst = find_node_by_addr_A(&port->hsr->proxy_node_db,
+					       eth_hdr(skb)->h_dest);
+
 	if (!node_dst) {
 		if (port->hsr->prot_version != PRP_V1 && net_ratelimit())
 			netdev_err(skb->dev, "%s: Unknown node\n", __func__);
@@ -557,6 +578,37 @@ void hsr_prune_nodes(struct timer_list *t)
 		  jiffies + msecs_to_jiffies(PRUNE_PERIOD));
 }
 
+void hsr_prune_proxy_nodes(struct timer_list *t)
+{
+	struct hsr_priv *hsr = from_timer(hsr, t, prune_proxy_timer);
+	unsigned long timestamp;
+	struct hsr_node *node;
+	struct hsr_node *tmp;
+
+	spin_lock_bh(&hsr->list_lock);
+	list_for_each_entry_safe(node, tmp, &hsr->proxy_node_db, mac_list) {
+		timestamp = node->time_in[HSR_PT_INTERLINK];
+
+		/* Prune old entries */
+		if (time_is_before_jiffies(timestamp +
+				msecs_to_jiffies(HSR_PROXY_NODE_FORGET_TIME))) {
+			hsr_nl_nodedown(hsr, node->macaddress_A);
+			if (!node->removed) {
+				list_del_rcu(&node->mac_list);
+				node->removed = true;
+				/* Note that we need to free this entry later: */
+				kfree_rcu(node, rcu_head);
+			}
+		}
+	}
+
+	spin_unlock_bh(&hsr->list_lock);
+
+	/* Restart timer */
+	mod_timer(&hsr->prune_proxy_timer,
+		  jiffies + msecs_to_jiffies(PRUNE_PROXY_PERIOD));
+}
+
 void *hsr_get_next_node(struct hsr_priv *hsr, void *_pos,
 			unsigned char addr[ETH_ALEN])
 {
diff --git a/net/hsr/hsr_framereg.h b/net/hsr/hsr_framereg.h
index b23556251d62..67456a75d8fe 100644
--- a/net/hsr/hsr_framereg.h
+++ b/net/hsr/hsr_framereg.h
@@ -46,6 +46,7 @@ int hsr_register_frame_out(struct hsr_port *port, struct hsr_node *node,
 			   u16 sequence_nr);
 
 void hsr_prune_nodes(struct timer_list *t);
+void hsr_prune_proxy_nodes(struct timer_list *t);
 
 int hsr_create_self_node(struct hsr_priv *hsr,
 			 const unsigned char addr_a[ETH_ALEN],
@@ -63,10 +64,15 @@ int hsr_get_node_data(struct hsr_priv *hsr,
 		      int *if2_age,
 		      u16 *if2_seq);
 
+void hsr_handle_san_frame(bool san, enum hsr_port_type port,
+			  struct hsr_node *node);
 void prp_handle_san_frame(bool san, enum hsr_port_type port,
 			  struct hsr_node *node);
 void prp_update_san_info(struct hsr_node *node, bool is_sup);
 
+bool hsr_is_node_in_db(struct list_head *node_db,
+		       const unsigned char addr[ETH_ALEN]);
+
 struct hsr_node {
 	struct list_head	mac_list;
 	/* Protect R/W access to seq_out */
diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index 18e01791ad79..23850b16d1ea 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -21,6 +21,7 @@
  */
 #define HSR_LIFE_CHECK_INTERVAL		 2000 /* ms */
 #define HSR_NODE_FORGET_TIME		60000 /* ms */
+#define HSR_PROXY_NODE_FORGET_TIME	60000 /* ms */
 #define HSR_ANNOUNCE_INTERVAL		  100 /* ms */
 #define HSR_ENTRY_FORGET_TIME		  400 /* ms */
 
@@ -35,6 +36,7 @@
  * HSR_NODE_FORGET_TIME?
  */
 #define PRUNE_PERIOD			 3000 /* ms */
+#define PRUNE_PROXY_PERIOD		 3000 /* ms */
 #define HSR_TLV_EOT				   0  /* End of TLVs */
 #define HSR_TLV_ANNOUNCE		   22
 #define HSR_TLV_LIFE_CHECK		   23
@@ -192,11 +194,14 @@ struct hsr_priv {
 	struct rcu_head		rcu_head;
 	struct list_head	ports;
 	struct list_head	node_db;	/* Known HSR nodes */
+	struct list_head	proxy_node_db;	/* RedBox HSR proxy nodes */
 	struct hsr_self_node	__rcu *self_node;	/* MACs of slaves */
 	struct timer_list	announce_timer;	/* Supervision frame dispatch */
 	struct timer_list	prune_timer;
+	struct timer_list	prune_proxy_timer;
 	int announce_count;
 	u16 sequence_nr;
+	u16 interlink_sequence_nr; /* Interlink port seq_nr */
 	u16 sup_sequence_nr;	/* For HSRv1 separate seq_nr for supervision */
 	enum hsr_version prot_version;	/* Indicate if HSRv0, HSRv1 or PRPv1 */
 	spinlock_t seqnr_lock;	/* locking for sequence_nr */
@@ -209,6 +214,8 @@ struct hsr_priv {
 				 * of lan_id
 				 */
 	bool fwd_offloaded;	/* Forwarding offloaded to HW */
+	bool redbox;            /* Device supports HSR RedBox */
+	unsigned char		macaddress_redbox[ETH_ALEN];
 	unsigned char		sup_multicast_addr[ETH_ALEN] __aligned(sizeof(u16));
 				/* Align to u16 boundary to avoid unaligned access
 				 * in ether_addr_equal
diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index 78fe40eb9f01..86eae49009cb 100644
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -23,6 +23,7 @@ static const struct nla_policy hsr_policy[IFLA_HSR_MAX + 1] = {
 	[IFLA_HSR_SUPERVISION_ADDR]	= { .len = ETH_ALEN },
 	[IFLA_HSR_SEQ_NR]		= { .type = NLA_U16 },
 	[IFLA_HSR_PROTOCOL]		= { .type = NLA_U8 },
+	[IFLA_HSR_INTERLINK]		= { .type = NLA_U32 },
 };
 
 /* Here, it seems a netdevice has already been allocated for us, and the
@@ -35,8 +36,8 @@ static int hsr_newlink(struct net *src_net, struct net_device *dev,
 	enum hsr_version proto_version;
 	unsigned char multicast_spec;
 	u8 proto = HSR_PROTOCOL_HSR;
-	struct net_device *link[2];
 
+	struct net_device *link[2], *interlink = NULL;
 	if (!data) {
 		NL_SET_ERR_MSG_MOD(extack, "No slave devices specified");
 		return -EINVAL;
@@ -67,6 +68,20 @@ static int hsr_newlink(struct net *src_net, struct net_device *dev,
 		return -EINVAL;
 	}
 
+	if (data[IFLA_HSR_INTERLINK])
+		interlink = __dev_get_by_index(src_net,
+					       nla_get_u32(data[IFLA_HSR_INTERLINK]));
+
+	if (interlink && interlink == link[0]) {
+		NL_SET_ERR_MSG_MOD(extack, "Interlink and Slave1 are the same");
+		return -EINVAL;
+	}
+
+	if (interlink && interlink == link[1]) {
+		NL_SET_ERR_MSG_MOD(extack, "Interlink and Slave2 are the same");
+		return -EINVAL;
+	}
+
 	if (!data[IFLA_HSR_MULTICAST_SPEC])
 		multicast_spec = 0;
 	else
@@ -96,10 +111,17 @@ static int hsr_newlink(struct net *src_net, struct net_device *dev,
 		}
 	}
 
-	if (proto == HSR_PROTOCOL_PRP)
+	if (proto == HSR_PROTOCOL_PRP) {
 		proto_version = PRP_V1;
+		if (interlink) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Interlink only works with HSR");
+			return -EINVAL;
+		}
+	}
 
-	return hsr_dev_finalize(dev, link, multicast_spec, proto_version, extack);
+	return hsr_dev_finalize(dev, link, interlink, multicast_spec,
+				proto_version, extack);
 }
 
 static void hsr_dellink(struct net_device *dev, struct list_head *head)
@@ -114,6 +136,7 @@ static void hsr_dellink(struct net_device *dev, struct list_head *head)
 
 	hsr_del_self_node(hsr);
 	hsr_del_nodes(&hsr->node_db);
+	hsr_del_nodes(&hsr->proxy_node_db);
 
 	unregister_netdevice_queue(dev, head);
 }
diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index e5742f2a2d52..136e3917f477 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -55,6 +55,7 @@ static rx_handler_result_t hsr_handle_frame(struct sk_buff **pskb)
 	protocol = eth_hdr(skb)->h_proto;
 
 	if (!(port->dev->features & NETIF_F_HW_HSR_TAG_RM) &&
+	    port->type != HSR_PT_INTERLINK &&
 	    hsr->proto_ops->invalid_dan_ingress_frame &&
 	    hsr->proto_ops->invalid_dan_ingress_frame(protocol))
 		goto finish_pass;
-- 
2.20.1


