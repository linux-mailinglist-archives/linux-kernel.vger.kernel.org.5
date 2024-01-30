Return-Path: <linux-kernel+bounces-44462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3A7842250
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7901F2502B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5899867753;
	Tue, 30 Jan 2024 11:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kwN0S6WB"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A6F65BD1;
	Tue, 30 Jan 2024 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613009; cv=none; b=UmEnHfSctMsX3b+ks0FDESN9dsN2ug3FZvUGpamkSPgJ4kGbrp8cgTQVaWwzRCuBOWnUlgFm0ZNuwdw7Czx8zVwyyEDm7dpB64Rq0sPRU1tS1Gj0jyoZa4IIKCaNA1GktUu9kbCuImRVx1fQ16K/XFohVIpn4U/UzoX9zruVTlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613009; c=relaxed/simple;
	bh=oGKQ4VIBZ3R0H8ztybGkZoTw1V+p+t5P91wTT/xkoVU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WnHVN4RlB/86uJ9wp313qHXeSyvot8B6n1G6Hu8skz/+NlQp8HxsLgdLyMXW6Z+sk5TmyVFlUMUeveOfYri79L18xi7+FMouVyVpshnbSpXa4nZ+dmYWvYY2kwY5IM1S59dy+y3MQpvaqoFYjMAWoCR1lkRvrVsMcZXGNFR5eiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kwN0S6WB; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40UB9sV4088089;
	Tue, 30 Jan 2024 05:09:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706612994;
	bh=/V7a58F1h3DLOzTckEeq6hpC2iW8uzFzmbeUl9ahhvg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=kwN0S6WBVIpdlzAzObfC4BhZ1HXcU58V5/b8xj305w3SME3oVyrbuQeojVvIE5G2o
	 i652VRBifpow3EbQzP43KPfp5DAbpLxBQJ2DMjOaWYF2XR2Wp80HRlfXB5yIWAguXt
	 yBGrNdhxl1SQB9xgZL1h2ZsB6vcAmz/XkFkE2M+Y=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40UB9sAa006299
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jan 2024 05:09:54 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jan 2024 05:09:54 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jan 2024 05:09:54 -0600
Received: from uda0500640.dal.design.ti.com (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40UB9ilN088313;
	Tue, 30 Jan 2024 05:09:51 -0600
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <andrew@lunn.ch>, <rogerq@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <s-vadapalli@ti.com>, <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH net-next 2/2] net: ethernet: ti: inter-core-virt-eth: Register as network device
Date: Tue, 30 Jan 2024 16:39:44 +0530
Message-ID: <20240130110944.26771-3-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240130110944.26771-1-r-gunasekaran@ti.com>
References: <20240130110944.26771-1-r-gunasekaran@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Register the RPMsg driver as network device and add support for
basic ethernet functionality by using the shared memory for data
plane.

The shared memory layout is as below, with the region between
PKT_1_LEN to PKT_N modelled as circular buffer.

-------------------------
|          HEAD         |
-------------------------
|          TAIL         |
-------------------------
|       PKT_1_LEN       |
|         PKT_1         |
-------------------------
|       PKT_2_LEN       |
|         PKT_2         |
-------------------------
|           .           |
|           .           |
-------------------------
|       PKT_N_LEN       |
|         PKT_N         |
-------------------------

The offset between the HEAD and TAIL is polled to process the Rx packets.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
---
 drivers/net/ethernet/ti/inter-core-virt-eth.c | 316 ++++++++++++++++++
 drivers/net/ethernet/ti/inter-core-virt-eth.h |  16 +
 2 files changed, 332 insertions(+)

diff --git a/drivers/net/ethernet/ti/inter-core-virt-eth.c b/drivers/net/ethernet/ti/inter-core-virt-eth.c
index d3b689eab1c0..735482001f4d 100644
--- a/drivers/net/ethernet/ti/inter-core-virt-eth.c
+++ b/drivers/net/ethernet/ti/inter-core-virt-eth.c
@@ -6,6 +6,50 @@
 
 #include "inter-core-virt-eth.h"
 
+#define ICVE_MIN_PACKET_SIZE	ETH_ZLEN
+#define ICVE_MAX_PACKET_SIZE	(ETH_FRAME_LEN + ETH_FCS_LEN)
+#define ICVE_MAX_TX_QUEUES	1
+#define ICVE_MAX_RX_QUEUES	1
+
+#define TEST_DEBUG		1
+
+#ifdef TEST_DEBUG
+#define ICVE_MAX_BUFFERS	100 //TODO : Set to power of 2 to leverage shift operations
+#endif
+
+#define PKT_LEN_SIZE_TYPE	sizeof(u32)
+
+/* 4 bytes to hold packet length and ICVE_MAX_PACKET_SIZE to hold packet */
+#define ICVE_BUFFER_SIZE	(ICVE_MAX_PACKET_SIZE + PKT_LEN_SIZE_TYPE)
+
+#define RX_POLL_TIMEOUT		250
+
+#define icve_ndev_to_priv(ndev) \
+	((struct icve_ndev_priv *)netdev_priv(ndev))
+#define icve_ndev_to_port(ndev) (icve_ndev_to_priv(ndev)->port)
+#define icve_ndev_to_common(ndev) (icve_ndev_to_port(ndev)->common)
+
+static void icve_rx_timer(struct timer_list *timer)
+{
+	struct icve_port *port = from_timer(port, timer, rx_timer);
+	struct napi_struct *napi;
+	int num_pkts = 0;
+	u32 head, tail;
+
+	head = port->rx_buffer->head;
+	tail = port->rx_buffer->tail;
+
+	num_pkts = tail - head;
+	num_pkts = num_pkts >= 0 ? num_pkts : (num_pkts + port->icve_max_buffers);
+
+	napi = &port->rx_napi;
+	if (num_pkts && likely(napi_schedule_prep(napi))) {
+		__napi_schedule(napi);
+	} else {
+		mod_timer(&port->rx_timer, RX_POLL_TIMEOUT);
+	}
+}
+
 static int icve_rpmsg_cb(struct rpmsg_device *rpdev, void *data, int len, void *priv, u32 src)
 {
 	struct icve_common *common = dev_get_drvdata(&rpdev->dev);
@@ -57,6 +101,18 @@ static int icve_rpmsg_cb(struct rpmsg_device *rpdev, void *data, int len, void *
 			break;
 		}
 		break;
+	case ICVE_NOTIFY_MSG:
+		rpmsg_type = msg->notify_msg.type;
+		switch (rpmsg_type) {
+		case ICVE_NOTIFY_REMOTE_READY:
+			/* Turn on carrier once remote core signals ready */
+			netif_carrier_on(port->ndev);
+			break;
+		case ICVE_NOTIFY_PORT_UP:
+		case ICVE_NOTIFY_PORT_DOWN:
+			break;
+		}
+		break;
 	default:
 		dev_err(common->dev, "Invalid msg type\n");
 		break;
@@ -77,6 +133,10 @@ static int create_request(struct icve_common *common, enum icve_rpmsg_type rpmsg
 	case ICVE_REQ_SHM_INFO:
 		msg->msg_hdr.msg_type = ICVE_REQUEST_MSG;
 		break;
+	case ICVE_NOTIFY_PORT_UP:
+	case ICVE_NOTIFY_PORT_DOWN:
+		msg->msg_hdr.msg_type = ICVE_NOTIFY_MSG;
+		break;
 	default:
 		ret = -EINVAL;
 		dev_err(common->dev, "Invalid RPMSG request\n");
@@ -85,11 +145,262 @@ static int create_request(struct icve_common *common, enum icve_rpmsg_type rpmsg
 	return ret;
 }
 
+static int icve_rx_packets(struct napi_struct *napi, int budget)
+{
+	struct icve_port *port = container_of(napi, struct icve_port, rx_napi);
+	u32 count, process_pkts;
+	struct sk_buff *skb;
+	u32 head, tail;
+	u32 pkt_len;
+	int num_pkts;
+
+	head = port->rx_buffer->head;
+	tail = port->rx_buffer->tail;
+
+	num_pkts = tail - head;
+	num_pkts = num_pkts >= 0 ? num_pkts : (num_pkts + port->icve_max_buffers);
+	process_pkts = min(num_pkts, budget);
+	count = 0;
+	while (count < process_pkts) {
+		memcpy((void *)&pkt_len,
+		       (void *)port->rx_buffer->base_addr + ((head + count) * ICVE_BUFFER_SIZE),
+		       PKT_LEN_SIZE_TYPE);
+
+		/* Start building the skb */
+		skb = napi_alloc_skb(napi, pkt_len);
+		skb->dev = port->ndev;
+		skb_put(skb, pkt_len);
+
+		memcpy((void *)skb->data,
+		       (void *)(port->rx_buffer->base_addr + PKT_LEN_SIZE_TYPE) + ((head + count) * ICVE_BUFFER_SIZE),
+		       pkt_len);
+
+		skb->protocol = eth_type_trans(skb, port->ndev);
+
+		/* Push skb into network stack */
+		napi_gro_receive(napi, skb);
+
+		count++;
+	}
+
+	if (num_pkts) {
+		port->rx_buffer->head = (port->rx_buffer->head + count) % port->icve_max_buffers;
+
+		if (num_pkts < budget && napi_complete_done(napi, count))
+			mod_timer(&port->rx_timer, RX_POLL_TIMEOUT);
+	}
+	return count;
+}
+
+#ifdef TEST_DEBUG
+static int test_tx_rx_path(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct icve_port *port = icve_ndev_to_port(ndev);
+	u32 *data;
+	u32 len;
+
+	len = skb_headlen(skb);
+
+	/* Copy length */
+	memcpy((void *)port->rx_buffer->base_addr + (port->rx_buffer->tail * ICVE_BUFFER_SIZE),
+	       (void *)&len, PKT_LEN_SIZE_TYPE);
+
+	/* Copy data to shared mem */
+	memcpy((void *)(port->rx_buffer->base_addr + PKT_LEN_SIZE_TYPE) + (port->rx_buffer->tail * ICVE_BUFFER_SIZE),
+	       (void *)skb->data, len);
+
+	data = (u32 *)(port->rx_buffer->base_addr + (port->rx_buffer->tail * ICVE_BUFFER_SIZE));
+
+	port->rx_buffer->tail = (port->rx_buffer->tail + 1) % ICVE_MAX_BUFFERS;
+
+	return 0;
+}
+#endif
+
+static int icve_ndo_open(struct net_device *ndev)
+{
+	struct icve_common *common = icve_ndev_to_common(ndev);
+	struct icve_port *port = icve_ndev_to_port(ndev);
+	unsigned long flags;
+
+	/* Send a msg to remote core signalling that we are ready */
+	spin_lock_irqsave(&common->send_msg_lock, flags);
+#ifndef TEST_DEBUG
+	create_request(common, ICVE_NOTIFY_PORT_UP);
+	rpmsg_send(common->rpdev->ept, (void *)(&common->send_msg), sizeof(common->send_msg));
+#endif
+	spin_unlock_irqrestore(&common->send_msg_lock, flags);
+
+	if (!(port->tx_buffer && port->rx_buffer)) {
+		netdev_err(ndev, "Shared memory not setup\n");
+		return -EPERM;
+	}
+
+	netif_napi_add(ndev, &port->rx_napi, icve_rx_packets);
+	napi_enable(&port->rx_napi);
+
+	timer_setup(&port->rx_timer, icve_rx_timer, 0);
+	mod_timer(&port->rx_timer, RX_POLL_TIMEOUT);
+
+	return 0;
+}
+
+static int icve_ndo_stop(struct net_device *ndev)
+{
+	struct icve_common *common = icve_ndev_to_common(ndev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&common->send_msg_lock, flags);
+#ifndef TEST_DEBUG
+	create_request(common, ICVE_NOTIFY_PORT_DOWN);
+	rpmsg_send(common->rpdev->ept, (void *)(&common->send_msg), sizeof(common->send_msg));
+#endif
+	spin_unlock_irqrestore(&common->send_msg_lock, flags);
+	return 0;
+}
+
+static netdev_tx_t icve_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct icve_port *port = icve_ndev_to_port(ndev);
+	struct ethhdr *ether;
+	u32 head, tail;
+	u32 num_pkts;
+	u32 len;
+
+	ether = eth_hdr(skb);
+	len = skb_headlen(skb);
+
+	head = port->tx_buffer->head;
+	tail = port->tx_buffer->tail;
+
+	/* If the buffer queue is full, then drop packet */
+	num_pkts = tail - head;
+	num_pkts = num_pkts >= 0 ? num_pkts : (num_pkts + port->icve_max_buffers);
+	if ((num_pkts + 1) == port->icve_max_buffers) {
+		netdev_warn(ndev, "Tx buffer full\n");
+		goto ring_full;
+	}
+
+	/* Copy length */
+	memcpy((void *)port->tx_buffer->base_addr + (port->tx_buffer->tail * ICVE_BUFFER_SIZE),
+	       (void *)&len, PKT_LEN_SIZE_TYPE);
+
+	/* Copy data to shared mem */
+	memcpy((void *)(port->tx_buffer->base_addr + PKT_LEN_SIZE_TYPE) +
+	       (port->tx_buffer->tail * ICVE_BUFFER_SIZE),
+	       (void *)skb->data, len);
+
+#ifdef TEST_DEBUG
+	/* For quick Rx path testing, inject Tx pkt back into network */
+	test_tx_rx_path(skb, ndev);
+#endif
+	port->tx_buffer->tail = (port->tx_buffer->tail + 1) % port->icve_max_buffers;
+
+	dev_consume_skb_any(skb);
+
+	return NETDEV_TX_OK;
+
+ring_full:
+	return NETDEV_TX_BUSY;
+}
+
+static int icve_set_mac_address(struct net_device *ndev, void *addr)
+{
+	eth_mac_addr(ndev, addr);
+
+	/* TODO : Inform remote core about MAC address change */
+	return 0;
+}
+
+static const struct net_device_ops icve_netdev_ops = {
+	.ndo_open		= icve_ndo_open,
+	.ndo_stop		= icve_ndo_stop,
+	.ndo_start_xmit		= icve_start_xmit,
+	.ndo_set_mac_address	= icve_set_mac_address,
+};
+
+static int icve_init_ndev(struct icve_common *common)
+{
+	struct device *dev = &common->rpdev->dev;
+	struct icve_ndev_priv *ndev_priv;
+	struct icve_port *port;
+	static u32 port_id;
+	int err;
+
+	port = common->port;
+	port->common = common;
+	port->port_id = port_id++;
+
+	port->ndev = devm_alloc_etherdev_mqs(common->dev, sizeof(*ndev_priv),
+					     ICVE_MAX_TX_QUEUES,
+					     ICVE_MAX_RX_QUEUES);
+
+	if (!port->ndev) {
+		dev_err(dev, "error allocating net_device\n");
+		return -ENOMEM;
+	}
+
+	ndev_priv = netdev_priv(port->ndev);
+	ndev_priv->port = port;
+	SET_NETDEV_DEV(port->ndev, dev);
+
+	port->ndev->min_mtu = ICVE_MIN_PACKET_SIZE;
+	port->ndev->max_mtu = ICVE_MAX_PACKET_SIZE;
+	port->ndev->netdev_ops = &icve_netdev_ops;
+
+#ifdef TEST_DEBUG
+	/* Allocate memory to test without actual RPMsg handshaking */
+	port->tx_buffer = devm_kzalloc(dev, sizeof(port->tx_buffer),
+				       GFP_KERNEL);
+	if (!port->tx_buffer) {
+		dev_err(dev, "Memory not available\n");
+		return -ENOMEM;
+	}
+
+	port->tx_buffer->base_addr = devm_kzalloc(dev, ICVE_BUFFER_SIZE * ICVE_MAX_BUFFERS,
+						  GFP_KERNEL);
+	if (!port->tx_buffer->base_addr) {
+		dev_err(dev, "Memory not available\n");
+		return -ENOMEM;
+	}
+
+	port->rx_buffer = devm_kzalloc(dev, sizeof(port->rx_buffer),
+				       GFP_KERNEL);
+	if (!port->rx_buffer) {
+		dev_err(dev, "Memory not available\n");
+		return -ENOMEM;
+	};
+
+	port->rx_buffer->base_addr = devm_kzalloc(dev, ICVE_BUFFER_SIZE * ICVE_MAX_BUFFERS,
+						  GFP_KERNEL);
+	if (!port->rx_buffer->base_addr) {
+		dev_err(dev, "Memory not available\n");
+		return -ENOMEM;
+	}
+
+	port->icve_max_buffers = ICVE_MAX_BUFFERS;
+#else
+	/* Shared memory details will be sent by the remote core.
+	 * So turn off the carrier, until both the virtual port and
+	 * remote core is ready
+	 */
+	netif_carrier_off(port->ndev);
+
+#endif
+	err = register_netdev(port->ndev);
+
+	if (err)
+		dev_err(dev, "error registering icve net device %d\n", err);
+
+	return 0;
+}
+
 static int icve_rpmsg_probe(struct rpmsg_device *rpdev)
 {
 	struct device *dev = &rpdev->dev;
 	struct icve_common *common;
 	unsigned long flags;
+	int ret;
 
 	common = devm_kzalloc(&rpdev->dev, sizeof(*common), GFP_KERNEL);
 	if (!common)
@@ -104,6 +415,11 @@ static int icve_rpmsg_probe(struct rpmsg_device *rpdev)
 	spin_lock_init(&common->send_msg_lock);
 	spin_lock_init(&common->recv_msg_lock);
 
+	/* Register the network device */
+	ret = icve_init_ndev(common);
+	if (ret)
+		return ret;
+
 	/* Send request to fetch shared memory details from remote core */
 	spin_lock_irqsave(&common->send_msg_lock, flags);
 	create_request(common, ICVE_REQ_SHM_INFO);
diff --git a/drivers/net/ethernet/ti/inter-core-virt-eth.h b/drivers/net/ethernet/ti/inter-core-virt-eth.h
index 063cc371eeb3..c3386a5ff714 100644
--- a/drivers/net/ethernet/ti/inter-core-virt-eth.h
+++ b/drivers/net/ethernet/ti/inter-core-virt-eth.h
@@ -7,13 +7,16 @@
 #ifndef __INTER_CORE_VIRT_ETH_H__
 #define __INTER_CORE_VIRT_ETH_H__
 
+#include <linux/etherdevice.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/netdevice.h>
 #include <linux/rpmsg.h>
 
 enum icve_msg_type {
 	ICVE_REQUEST_MSG = 0,
 	ICVE_RESPONSE_MSG,
+	ICVE_NOTIFY_MSG,
 };
 
 enum icve_rpmsg_type {
@@ -22,6 +25,11 @@ enum icve_rpmsg_type {
 
 	/* Response types */
 	ICVE_RESP_SHM_INFO,
+
+	/* Notification types */
+	ICVE_NOTIFY_PORT_UP,
+	ICVE_NOTIFY_PORT_DOWN,
+	ICVE_NOTIFY_REMOTE_READY,
 };
 
 struct icve_shm_info {
@@ -70,7 +78,11 @@ struct shared_mem {
 struct icve_port {
 	struct shared_mem *tx_buffer; /* Write buffer for data to be consumed remote side */
 	struct shared_mem *rx_buffer; /* Read buffer for data to be consumed by this driver */
+	struct timer_list rx_timer;
 	struct icve_common *common;
+	struct napi_struct rx_napi;
+	u8 local_mac_addr[ETH_ALEN];
+	struct net_device *ndev;
 	u32 icve_max_buffers;
 	u32 port_id; /* Unique ID for the port : TODO: Define range for use by Linux and non linux */
 
@@ -86,4 +98,8 @@ struct icve_common {
 	struct device *dev;
 } __packed;
 
+struct icve_ndev_priv {
+	struct icve_port *port;
+};
+
 #endif /* __INTER_CORE_VIRT_ETH_H__ */
-- 
2.17.1


