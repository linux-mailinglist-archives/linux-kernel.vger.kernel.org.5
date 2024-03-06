Return-Path: <linux-kernel+bounces-93359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A96C872E7F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 06:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2077F2889AE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 05:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7F01BC5E;
	Wed,  6 Mar 2024 05:50:19 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7785033CA;
	Wed,  6 Mar 2024 05:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709704218; cv=none; b=Xv381KtriMFcpH0I4ENZ9XXU+oj9uHgL6VN2ytF6G7mwC1ZRtcPzBIlHi6Dl65Y1RIpt723p/aW5ywTYs8UpbjNXJW/jZ0FPraJpoT7CeeMAr1AIGgpF5nYTuNTTN4ypob12FpJcvoRd5g3UrU658rzN1w2jrhwQupuu25k32gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709704218; c=relaxed/simple;
	bh=eP1y309MQnlllItUv+qEXrncOAEA4pVGLMPU08Z16bc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k+2BD3LT0hV6PVEFYVsM2evjPczqsK4N5Pmu9e3Fp5a6AFVIULs/38vMjBzP7/CjPnZqIWUpY0ylBJcomIEIUc+4G9MfPjLgR6uvT1bFkGU4yAyBqYmQJ/sDOybL1Pb7J95tTz4Ynv+WZbHhYnE6eLmFGVpF6IOKDnv07t/3Flg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4265nsj6054367;
	Wed, 6 Mar 2024 13:49:54 +0800 (+08)
	(envelope-from surong.pang@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx05.spreadtrum.com [10.29.1.56])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TqM1c02kSz2KrC3W;
	Wed,  6 Mar 2024 13:48:52 +0800 (CST)
Received: from zeshkernups01.spreadtrum.com (10.29.55.99) by
 shmbx05.spreadtrum.com (10.29.1.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 6 Mar 2024 13:49:52 +0800
From: Surong Pang <surong.pang@unisoc.com>
To: <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <Orson.Zhai@unisoc.com>, <Zhiyong.liu@unisoc.com>, <Surong.Pang@gmail.com>
Subject: [PATCH] usb: gadget: rndis: add multi packages support for rndis
Date: Wed, 6 Mar 2024 13:49:49 +0800
Message-ID: <20240306054949.324172-1-surong.pang@unisoc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 shmbx05.spreadtrum.com (10.29.1.56)
X-MAIL:SHSQR01.spreadtrum.com 4265nsj6054367

As ncm, aggergate multi skb packages and transfer them at one URB.
In USB2.0, the network throughput can be improved from about 18MB/S
to 35MB/S.

Signed-off-by: Surong Pang <surong.pang@unisoc.com>
---
 drivers/usb/gadget/function/f_rndis.c | 123 ++++++++++++++++++++---
 drivers/usb/gadget/function/rndis.c   | 135 +++++++++++++++++++++-----
 drivers/usb/gadget/function/rndis.h   |  13 ++-
 3 files changed, 234 insertions(+), 37 deletions(-)

diff --git a/drivers/usb/gadget/function/f_rndis.c b/drivers/usb/gadget/function/f_rndis.c
index b47f99d17ee9..a87497b80946 100644
--- a/drivers/usb/gadget/function/f_rndis.c
+++ b/drivers/usb/gadget/function/f_rndis.c
@@ -77,6 +77,12 @@ struct f_rndis {
 	struct usb_ep			*notify;
 	struct usb_request		*notify_req;
 	atomic_t			notify_count;
+
+	struct net_device		*netdev;
+	/* For multi-frame RNDIS TX */
+	u16				prepared_tx_skb_count;
+	struct sk_buff			*prepared_tx_skb;
+	struct hrtimer			task_timer;
 };
 
 static inline struct f_rndis *func_to_rndis(struct usb_function *f)
@@ -92,6 +98,7 @@ static inline struct f_rndis *func_to_rndis(struct usb_function *f)
 #define RNDIS_STATUS_INTERVAL_MS	32
 #define STATUS_BYTECOUNT		8	/* 8 bytes data */
 
+#define TX_TIMEOUT_NSECS 200000
 
 /* interface descriptor: */
 
@@ -102,9 +109,9 @@ static struct usb_interface_descriptor rndis_control_intf = {
 	/* .bInterfaceNumber = DYNAMIC */
 	/* status endpoint is optional; this could be patched later */
 	.bNumEndpoints =	1,
-	.bInterfaceClass =	USB_CLASS_COMM,
-	.bInterfaceSubClass =   USB_CDC_SUBCLASS_ACM,
-	.bInterfaceProtocol =   USB_CDC_ACM_PROTO_VENDOR,
+	.bInterfaceClass =	USB_CLASS_WIRELESS_CONTROLLER,
+	.bInterfaceSubClass =	0x01,
+	.bInterfaceProtocol =	USB_CDC_ACM_PROTO_AT_PCCA101_WAKE,
 	/* .iInterface = DYNAMIC */
 };
 
@@ -162,10 +169,10 @@ rndis_iad_descriptor = {
 	.bDescriptorType =	USB_DT_INTERFACE_ASSOCIATION,
 
 	.bFirstInterface =	0, /* XXX, hardcoded */
-	.bInterfaceCount = 	2,	// control + data
-	.bFunctionClass =	USB_CLASS_COMM,
-	.bFunctionSubClass =	USB_CDC_SUBCLASS_ETHERNET,
-	.bFunctionProtocol =	USB_CDC_PROTO_NONE,
+	.bInterfaceCount =	2, // control + data
+	.bFunctionClass =	USB_CLASS_WIRELESS_CONTROLLER,
+	.bFunctionSubClass =	0x01,
+	.bFunctionProtocol =	USB_CDC_ACM_PROTO_AT_PCCA101_WAKE,
 	/* .iFunction = DYNAMIC */
 };
 
@@ -352,20 +359,104 @@ static struct usb_gadget_strings *rndis_strings[] = {
 	NULL,
 };
 
+/*
+ * The transmit should only be run if no skb data has been sent
+ * for a certain duration.
+ */
+static enum hrtimer_restart rndis_tx_timeout(struct hrtimer *data)
+{
+	struct f_rndis *rndis = container_of(data, struct f_rndis, task_timer);
+	struct net_device *netdev = READ_ONCE(rndis->netdev);
+
+	if (netdev) {
+		/* XXX This allowance of a NULL skb argument to ndo_start_xmit
+		 * XXX is not sane.  The gadget layer should be redesigned so
+		 * XXX that the dev->wrap() invocations to build SKBs is transparent
+		 * XXX and performed in some way outside of the ndo_start_xmit
+		 * XXX interface.
+		 *
+		 * This will call directly into u_ether's eth_start_xmit()
+		 */
+		netdev->netdev_ops->ndo_start_xmit(NULL, netdev);
+	}
+	return HRTIMER_NORESTART;
+}
+
+static struct sk_buff *package_for_tx(struct f_rndis *rndis)
+{
+	struct sk_buff *skb = NULL;
+
+	/* Stop the timer */
+	hrtimer_try_to_cancel(&rndis->task_timer);
+
+	/* Merge the skbs */
+	swap(skb, rndis->prepared_tx_skb);
+
+	return skb;
+}
+
 /*-------------------------------------------------------------------------*/
 
 static struct sk_buff *rndis_add_header(struct gether *port,
 					struct sk_buff *skb)
 {
-	struct sk_buff *skb2;
+	struct f_rndis *rndis = func_to_rndis(&port->func);
+	struct usb_composite_dev *cdev = rndis->port.func.config->cdev;
+	struct rndis_params *params = rndis->params;
+	struct sk_buff *skb2 = NULL;
+	int head_len = sizeof(struct rndis_packet_msg_type);
+
+	if (skb) {
+		if (rndis->prepared_tx_skb &&
+			(rndis->prepared_tx_skb_count >= params->max_in_pkts_per_xfer ||
+			(rndis->prepared_tx_skb->len + skb->len + head_len) >=
+			params->max_in_size_per_xfer)) {
+			DBG(cdev, "prepared tx skb count %d, len %d\n",
+				rndis->prepared_tx_skb_count, rndis->prepared_tx_skb->len);
+			skb2 = package_for_tx(rndis);
+		}
+
+		if (!rndis->prepared_tx_skb) {
+			/* Create a new skb for multi xfer. */
+			DBG(cdev, "create a new multi skb, len %d\n", params->max_in_size_per_xfer);
+
+			rndis->prepared_tx_skb =
+				alloc_skb(params->max_in_size_per_xfer, GFP_ATOMIC);
+			if (!rndis->prepared_tx_skb)
+				goto err;
 
-	if (!skb)
-		return NULL;
+			rndis->prepared_tx_skb->dev = rndis->netdev;
+			rndis->prepared_tx_skb_count = 0;
 
+			/* Start the timer. */
+			hrtimer_start(&rndis->task_timer, TX_TIMEOUT_NSECS,
+				      HRTIMER_MODE_REL_SOFT);
+		}
+
+		/*
+		 * Add the new data to the skb
+		 * PacketAlignmentFactor is 0, no need to add padding
+		 */
+		rndis_copy_hdr(rndis->prepared_tx_skb, skb);
+		skb_put_data(rndis->prepared_tx_skb, skb->data, skb->len);
+		rndis->prepared_tx_skb_count++;
+		dev_consume_skb_any(skb);
+		skb = NULL;
+	} else if (rndis->prepared_tx_skb) {
+		/* If we get here eth_start_xmit() was called with NULL skb by
+		 * rndis_tx_timeout() - hence, this is our signal to flush/send.
+		 */
+		DBG(cdev, "timer expired, prepared tx skb count %d, len %d\n",
+			rndis->prepared_tx_skb_count, rndis->prepared_tx_skb->len);
+		skb2 = package_for_tx(rndis);
+	}
+	return skb2;
+
+err:
 	skb2 = skb_realloc_headroom(skb, sizeof(struct rndis_packet_msg_type));
 	rndis_add_hdr(skb2);
 
-	dev_kfree_skb(skb);
+	dev_consume_skb_any(skb);
 	return skb2;
 }
 
@@ -546,6 +637,7 @@ static int rndis_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 
 		if (rndis->port.in_ep->enabled) {
 			DBG(cdev, "reset rndis\n");
+			rndis->netdev = NULL;
 			gether_disconnect(&rndis->port);
 		}
 
@@ -582,8 +674,9 @@ static int rndis_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 		net = gether_connect(&rndis->port);
 		if (IS_ERR(net))
 			return PTR_ERR(net);
+		rndis->netdev = net;
 
-		rndis_set_param_dev(rndis->params, net,
+		rndis_set_param_dev(&rndis->port, rndis->params, net,
 				&rndis->port.cdc_filter);
 	} else
 		goto fail;
@@ -604,6 +697,7 @@ static void rndis_disable(struct usb_function *f)
 	DBG(cdev, "rndis deactivated\n");
 
 	rndis_uninit(rndis->params);
+	rndis->netdev = NULL;
 	gether_disconnect(&rndis->port);
 
 	usb_ep_disable(rndis->notify);
@@ -793,6 +887,9 @@ rndis_bind(struct usb_configuration *c, struct usb_function *f)
 		goto fail_free_descs;
 	}
 
+	hrtimer_init(&rndis->task_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
+	rndis->task_timer.function = rndis_tx_timeout;
+
 	/* NOTE:  all that is done without knowing or caring about
 	 * the network link ... which is unavailable to this code
 	 * until we're activated via set_alt().
@@ -956,6 +1053,8 @@ static void rndis_unbind(struct usb_configuration *c, struct usb_function *f)
 {
 	struct f_rndis		*rndis = func_to_rndis(f);
 
+	hrtimer_cancel(&rndis->task_timer);
+
 	kfree(f->os_desc_table);
 	f->os_desc_n = 0;
 	usb_free_all_descriptors(f);
diff --git a/drivers/usb/gadget/function/rndis.c b/drivers/usb/gadget/function/rndis.c
index 29bf8664bf58..fd321b53e46f 100644
--- a/drivers/usb/gadget/function/rndis.c
+++ b/drivers/usb/gadget/function/rndis.c
@@ -39,6 +39,8 @@
 
 #include "rndis.h"
 
+static int max_out_pkts_per_xfer;
+static int max_out_size_per_xfer;
 
 /* The driver for your USB chip needs to support ep0 OUT to work with
  * RNDIS, plus all three CDC Ethernet endpoints (interrupt not optional).
@@ -574,12 +576,12 @@ static int rndis_init_response(struct rndis_params *params,
 	resp->MinorVersion = cpu_to_le32(RNDIS_MINOR_VERSION);
 	resp->DeviceFlags = cpu_to_le32(RNDIS_DF_CONNECTIONLESS);
 	resp->Medium = cpu_to_le32(RNDIS_MEDIUM_802_3);
-	resp->MaxPacketsPerTransfer = cpu_to_le32(1);
-	resp->MaxTransferSize = cpu_to_le32(
-		  params->dev->mtu
+	resp->MaxPacketsPerTransfer = cpu_to_le32(params->max_out_pkts_per_xfer);
+	resp->MaxTransferSize = cpu_to_le32(params->max_out_pkts_per_xfer *
+		  (params->dev->mtu
 		+ sizeof(struct ethhdr)
 		+ sizeof(struct rndis_packet_msg_type)
-		+ 22);
+		+ 22));
 	resp->PacketAlignmentFactor = cpu_to_le32(0);
 	resp->AFListOffset = cpu_to_le32(0);
 	resp->AFListSize = cpu_to_le32(0);
@@ -790,7 +792,7 @@ EXPORT_SYMBOL_GPL(rndis_set_host_mac);
  */
 int rndis_msg_parser(struct rndis_params *params, u8 *buf)
 {
-	u32 MsgType, MsgLength;
+	u32 MsgType, MsgLength, RequestID, MajorVersion, MinorVersion, MaxTransferSize;
 	__le32 *tmp;
 
 	if (!buf)
@@ -813,7 +815,12 @@ int rndis_msg_parser(struct rndis_params *params, u8 *buf)
 	case RNDIS_MSG_INIT:
 		pr_debug("%s: RNDIS_MSG_INIT\n",
 			__func__);
+		RequestID   = get_unaligned_le32(tmp++);
+		MajorVersion = get_unaligned_le32(tmp++);
+		MinorVersion = get_unaligned_le32(tmp++);
+		MaxTransferSize = get_unaligned_le32(tmp++);
 		params->state = RNDIS_INITIALIZED;
+		params->max_in_size_per_xfer = MaxTransferSize;
 		return rndis_init_response(params, (rndis_init_msg_type *)buf);
 
 	case RNDIS_MSG_HALT:
@@ -922,6 +929,8 @@ struct rndis_params *rndis_register(void (*resp_avail)(void *v), void *v)
 	params->media_state = RNDIS_MEDIA_STATE_DISCONNECTED;
 	params->resp_avail = resp_avail;
 	params->v = v;
+	params->max_in_pkts_per_xfer  = RNDIS_MAX_IN_PKTS_PER_XFER;
+	params->max_out_pkts_per_xfer = RNDIS_MAX_OUT_PKTS_PER_XFER;
 	INIT_LIST_HEAD(&params->resp_queue);
 	spin_lock_init(&params->resp_lock);
 	pr_debug("%s: configNr = %d\n", __func__, i);
@@ -954,8 +963,8 @@ void rndis_deregister(struct rndis_params *params)
 	rndis_put_nr(i);
 }
 EXPORT_SYMBOL_GPL(rndis_deregister);
-int rndis_set_param_dev(struct rndis_params *params, struct net_device *dev,
-			u16 *cdc_filter)
+int rndis_set_param_dev(struct gether *port, struct rndis_params *params,
+			struct net_device *dev, u16 *cdc_filter)
 {
 	pr_debug("%s:\n", __func__);
 	if (!dev)
@@ -965,7 +974,18 @@ int rndis_set_param_dev(struct rndis_params *params, struct net_device *dev,
 
 	params->dev = dev;
 	params->filter = cdc_filter;
-
+	params->max_out_size_per_xfer = (params->max_out_pkts_per_xfer *
+					(dev->mtu
+					+ sizeof(struct ethhdr)
+					+ sizeof(struct rndis_packet_msg_type)
+					+ 22));
+	port->is_fixed = true;
+	port->fixed_out_len = params->max_out_size_per_xfer;
+
+	pr_debug("mtu %d, fixed_out_len %d\n", dev->mtu, port->fixed_out_len);
+
+	max_out_pkts_per_xfer = params->max_out_pkts_per_xfer;
+	max_out_size_per_xfer = params->max_out_size_per_xfer;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(rndis_set_param_dev);
@@ -1013,6 +1033,23 @@ void rndis_add_hdr(struct sk_buff *skb)
 }
 EXPORT_SYMBOL_GPL(rndis_add_hdr);
 
+void rndis_copy_hdr(struct sk_buff *dest_skb, struct sk_buff *new_skb)
+{
+	struct rndis_packet_msg_type header;
+	int head_len = sizeof(header);
+
+	if (!dest_skb || !new_skb)
+		return;
+
+	memset(&header, 0, head_len);
+	header.MessageType = cpu_to_le32(RNDIS_MSG_PACKET);
+	header.MessageLength = cpu_to_le32(head_len + new_skb->len);
+	header.DataOffset = cpu_to_le32(36);
+	header.DataLength = cpu_to_le32(new_skb->len);
+	skb_put_data(dest_skb, &header, head_len);
+}
+EXPORT_SYMBOL_GPL(rndis_copy_hdr);
+
 void rndis_free_response(struct rndis_params *params, u8 *buf)
 {
 	rndis_resp_t *r, *n;
@@ -1071,26 +1108,78 @@ int rndis_rm_hdr(struct gether *port,
 			struct sk_buff *skb,
 			struct sk_buff_head *list)
 {
-	/* tmp points to a struct rndis_packet_msg_type */
-	__le32 *tmp = (void *)skb->data;
+	int ret = 0;
+	int num_pkts = 1;
 
-	/* MessageType, MessageLength */
-	if (cpu_to_le32(RNDIS_MSG_PACKET)
-			!= get_unaligned(tmp++)) {
-		dev_kfree_skb_any(skb);
-		return -EINVAL;
-	}
-	tmp++;
+	while (skb->len) {
+		struct rndis_packet_msg_type *hdr;
+		struct sk_buff *skb2;
+		u32 msg_len, data_offset, data_len;
+
+		/* some rndis hosts send extra byte to avoid zlp, ignore it */
+		if (skb->len == 1) {
+			pr_info("skb len 1, should ignore!\n");
+			break;
+		}
+
+		if (skb->len < sizeof(*hdr)) {
+			pr_err("invalid rndis pkt: skblen:%u hdr_len:%zu",
+			       skb->len, sizeof(*hdr));
+			skb->len = 0;
+			ret = -EINVAL;
+			break;
+		}
 
-	/* DataOffset, DataLength */
-	if (!skb_pull(skb, get_unaligned_le32(tmp++) + 8)) {
-		dev_kfree_skb_any(skb);
-		return -EOVERFLOW;
+		hdr = (void *)skb->data;
+		msg_len = le32_to_cpu(hdr->MessageLength);
+		data_offset = le32_to_cpu(hdr->DataOffset);
+		data_len = le32_to_cpu(hdr->DataLength);
+
+		if (skb->len < msg_len ||
+		    ((data_offset + data_len + 8) > msg_len)) {
+			pr_err("invalid rndis message: %d/%d/%d/%d, len:%d\n",
+			       le32_to_cpu(hdr->MessageType),
+			       msg_len, data_offset, data_len, skb->len);
+			skb->len = 0;
+			ret = -EOVERFLOW;
+			break;
+		}
+		if (le32_to_cpu(hdr->MessageType) != RNDIS_MSG_PACKET) {
+			pr_err("invalid rndis message: %d/%d/%d/%d, len:%d\n",
+			       le32_to_cpu(hdr->MessageType), msg_len,
+			       data_offset, data_len, skb->len);
+			skb->len = 0;
+			ret = -EINVAL;
+			break;
+		}
+
+		skb_pull(skb, data_offset + 8);
+
+		if (data_len == skb->len) {
+			skb_trim(skb, data_len);
+			break;
+		}
+
+		skb2 = skb_clone(skb, GFP_ATOMIC);
+		if (!skb2) {
+			pr_err("%s:skb clone failed\n", __func__);
+			skb->len = 0;
+			ret = -ENOMEM;
+			break;
+		}
+
+		skb_pull(skb, msg_len - (data_offset + 8));
+		skb_trim(skb2, data_len);
+		skb_queue_tail(list, skb2);
+
+		num_pkts++;
 	}
-	skb_trim(skb, get_unaligned_le32(tmp++));
+
+	if (num_pkts > max_out_pkts_per_xfer)
+		pr_err("max out pkts per xfer rcvd %d\n", num_pkts);
 
 	skb_queue_tail(list, skb);
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(rndis_rm_hdr);
 
diff --git a/drivers/usb/gadget/function/rndis.h b/drivers/usb/gadget/function/rndis.h
index 6206b8b7490f..d6acbc1577f8 100644
--- a/drivers/usb/gadget/function/rndis.h
+++ b/drivers/usb/gadget/function/rndis.h
@@ -19,6 +19,9 @@
 #define RNDIS_MAXIMUM_FRAME_SIZE	1518
 #define RNDIS_MAX_TOTAL_SIZE		1558
 
+#define RNDIS_MAX_IN_PKTS_PER_XFER	10
+#define RNDIS_MAX_OUT_PKTS_PER_XFER	3
+
 typedef struct rndis_init_msg_type {
 	__le32	MessageType;
 	__le32	MessageLength;
@@ -175,18 +178,24 @@ typedef struct rndis_params {
 	void			*v;
 	struct list_head	resp_queue;
 	spinlock_t		resp_lock;
+
+	u32			max_in_size_per_xfer;
+	u32			max_in_pkts_per_xfer;
+	u32			max_out_size_per_xfer;
+	u32			max_out_pkts_per_xfer;
 } rndis_params;
 
 /* RNDIS Message parser and other useless functions */
 int  rndis_msg_parser(struct rndis_params *params, u8 *buf);
 struct rndis_params *rndis_register(void (*resp_avail)(void *v), void *v);
 void rndis_deregister(struct rndis_params *params);
-int  rndis_set_param_dev(struct rndis_params *params, struct net_device *dev,
-			 u16 *cdc_filter);
+int  rndis_set_param_dev(struct gether *port, struct rndis_params *params,
+			 struct net_device *dev, u16 *cdc_filter);
 int  rndis_set_param_vendor(struct rndis_params *params, u32 vendorID,
 			    const char *vendorDescr);
 int  rndis_set_param_medium(struct rndis_params *params, u32 medium,
 			     u32 speed);
+void rndis_copy_hdr(struct sk_buff *dest_skb, struct sk_buff *new_skb);
 void rndis_add_hdr(struct sk_buff *skb);
 int rndis_rm_hdr(struct gether *port, struct sk_buff *skb,
 			struct sk_buff_head *list);
-- 
2.34.1


