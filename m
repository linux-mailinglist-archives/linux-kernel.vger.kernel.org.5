Return-Path: <linux-kernel+bounces-3457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2EE816C9A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97759B209FA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D119832C81;
	Mon, 18 Dec 2023 11:38:11 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9712D7A4
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 11:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1rFBwZ-0000Vp-E4; Mon, 18 Dec 2023 12:37:55 +0100
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Mon, 18 Dec 2023 12:37:10 +0100
Subject: [PATCH RFC 3/4] virtio-net: support transmit timestamp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231218-v6-7-topic-virtio-net-ptp-v1-3-cac92b2d8532@pengutronix.de>
References: <20231218-v6-7-topic-virtio-net-ptp-v1-0-cac92b2d8532@pengutronix.de>
In-Reply-To: <20231218-v6-7-topic-virtio-net-ptp-v1-0-cac92b2d8532@pengutronix.de>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Willem de Bruijn <willemb@google.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8554;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=8hMAxYNzHYaVhUxwKSBTNbNGO8KM+28aw/y7rrmeGlo=;
 b=owGbwMvMwCUmvd38QH3grB+Mp9WSGFIb9FmzBJi5L3y8EKam4PA96br4Mp/DM07fN8m8JxV/uPla
 4vPSjlIWBjEuBlkxRZbItYc0Ngt/1vly/DwDzBxWJpAhDFycAjCRq8WMDLc3fv0YeSjis6a1sPWEkw
 /PpzJ/KAhbnR2aMuHjhvKn/u2MDPOuc568EqiyNNFm3e5D4Udf9QXduzXtVfxWp6SItSwlnxkB
X-Developer-Key: i=s.trumtrar@pengutronix.de; a=openpgp;
 fpr=59ADC228B313F32CF4C7CF001BB737C07F519AF8
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

Add optional PTP hardware tx timestamp offload for virtio-net.

Accurate RTT measurement requires timestamps close to the wire.
Introduce virtio feature VIRTIO_NET_F_TX_TSTAMP, the transmit
equivalent to VIRTIO_NET_F_RX_TSTAMP.

The driver sets VIRTIO_NET_HDR_F_TSTAMP to request a timestamp
returned on completion. If the feature is negotiated, the device
either places the timestamp or clears the feature bit.

The timestamp straddles (virtual) hardware domains. Like PTP, use
international atomic time (CLOCK_TAI) as global clock base. The driver
must sync with the device, e.g., through kvm-clock.

Modify can_push to ensure that on tx completion the header, and thus
timestamp, is in a predicatable location at skb_vnet_hdr.

Tested: modified txtimestamp.c to with h/w timestamping:
  -       sock_opt = SOF_TIMESTAMPING_SOFTWARE |
  +       sock_opt = SOF_TIMESTAMPING_RAW_HARDWARE |
  + do_test(family, SOF_TIMESTAMPING_TX_HARDWARE);

Signed-off-by: Willem de Bruijn <willemb@google.com>
Co-developed-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

--
  Changes to original RFC v2:
  - append write-able descriptor for TX timestamp

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/net/virtio_net.c        | 79 +++++++++++++++++++++++++++++++++++------
 include/uapi/linux/virtio_net.h |  1 +
 2 files changed, 70 insertions(+), 10 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 9bb6cdaf49cc9..4065834957fbd 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -280,6 +280,12 @@ struct virtnet_info {
 	/* Device will pass rx timestamp. Requires has_rx_tstamp */
 	bool enable_rx_tstamp;
 
+	/* Device can pass CLOCK_TAI transmit time to the driver */
+	bool has_tx_tstamp;
+
+	/* Device will pass tx timestamp. Requires has_tx_tstamp */
+	bool enable_tx_tstamp;
+
 	/* Has control virtqueue */
 	bool has_cvq;
 
@@ -760,6 +766,21 @@ static void virtnet_rq_set_premapped(struct virtnet_info *vi)
 	}
 }
 
+static void virtnet_record_tx_tstamp(const struct send_queue *sq,
+				     struct sk_buff *skb)
+{
+	const struct virtio_net_hdr_hash_ts *h = skb_vnet_hdr_ht(skb);
+	const struct virtnet_info *vi = sq->vq->vdev->priv;
+	struct skb_shared_hwtstamps ts;
+
+	if (h->hash.hdr.flags & VIRTIO_NET_HDR_F_TSTAMP &&
+	    vi->enable_tx_tstamp) {
+		/* Write the timestamp from the userspace to the skb */
+		ts.hwtstamp = ns_to_ktime(le64_to_cpu(h->tstamp));
+		skb_tstamp_tx(skb, &ts);
+	}
+}
+
 static void free_old_xmit_skbs(struct send_queue *sq, bool in_napi)
 {
 	unsigned int len;
@@ -771,6 +792,7 @@ static void free_old_xmit_skbs(struct send_queue *sq, bool in_napi)
 		if (likely(!is_xdp_frame(ptr))) {
 			struct sk_buff *skb = ptr;
 
+			virtnet_record_tx_tstamp(sq, skb);
 			pr_debug("Sent skb %p\n", skb);
 
 			bytes += skb->len;
@@ -2312,7 +2334,7 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
 	struct virtio_net_hdr_mrg_rxbuf *hdr;
 	const unsigned char *dest = ((struct ethhdr *)skb->data)->h_dest;
 	struct virtnet_info *vi = sq->vq->vdev->priv;
-	struct virtio_net_hdr_v1_hash *ht;
+	struct virtio_net_hdr_hash_ts *ht;
 	int num_sg;
 	unsigned hdr_len = vi->hdr_len;
 	bool can_push;
@@ -2321,7 +2343,8 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
 
 	can_push = vi->any_header_sg &&
 		!((unsigned long)skb->data & (__alignof__(*hdr) - 1)) &&
-		!skb_header_cloned(skb) && skb_headroom(skb) >= hdr_len;
+		!skb_header_cloned(skb) && skb_headroom(skb) >= hdr_len &&
+		!vi->enable_tx_tstamp;
 	/* Even if we can, don't push here yet as this would skew
 	 * csum_start offset below. */
 	if (can_push)
@@ -2342,10 +2365,12 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
 		u16 report = skb->l4_hash ? VIRTIO_NET_HASH_REPORT_L4 :
 					    VIRTIO_NET_HASH_REPORT_OTHER;
 
-		ht->hash_value = cpu_to_le32(skb->hash);
-		ht->hash_report = cpu_to_le16(report);
-		ht->hash_state = cpu_to_le16(VIRTIO_NET_HASH_STATE_DEFAULT);
+		ht->hash.value = cpu_to_le32(skb->hash);
+		ht->hash.report = cpu_to_le16(report);
+		ht->hash.flow_state = cpu_to_le16(VIRTIO_NET_HASH_STATE_DEFAULT);
 	}
+	if (vi->enable_tx_tstamp && skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)
+		ht->hash.hdr.flags |= VIRTIO_NET_HDR_F_TSTAMP;
 
 	sg_init_table(sq->sg, skb_shinfo(skb)->nr_frags + (can_push ? 1 : 2));
 	if (can_push) {
@@ -2362,7 +2387,23 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
 			return num_sg;
 		num_sg++;
 	}
-	return virtqueue_add_outbuf(sq->vq, sq->sg, num_sg, skb, GFP_ATOMIC);
+
+	/* Append a writeable descriptor after the RO ones. TX timestamp is
+	 * received via this descriptor
+	 */
+	if (ht->hash.hdr.flags & VIRTIO_NET_HDR_F_TSTAMP) {
+		struct virtio_net_hdr_hash_ts *h = skb_vnet_hdr_ht(skb);
+		struct scatterlist *sgs[2];
+		struct scatterlist sg_in;
+
+		sg_init_one(&sg_in, &h->tstamp, sizeof(h->tstamp));
+		sgs[0] = sq->sg;
+		sgs[1] = &sg_in;
+
+		return virtqueue_add_sgs(sq->vq, sgs, 1, 1, skb, GFP_ATOMIC);
+	} else {
+		return virtqueue_add_outbuf(sq->vq, sq->sg, num_sg, skb, GFP_ATOMIC);
+	}
 }
 
 static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
@@ -3556,7 +3597,13 @@ static int virtnet_get_ts_info(struct net_device *dev,
 		info->rx_filters = HWTSTAMP_FILTER_NONE;
 	}
 
-	info->tx_types = HWTSTAMP_TX_OFF;
+	if (vi->has_tx_tstamp) {
+		info->so_timestamping |= SOF_TIMESTAMPING_TX_HARDWARE |
+					 SOF_TIMESTAMPING_RAW_HARDWARE;
+		info->tx_types = HWTSTAMP_TX_ON;
+	} else {
+		info->tx_types = HWTSTAMP_TX_OFF;
+	}
 
 	return 0;
 }
@@ -3984,7 +4031,8 @@ static int virtnet_ioctl_set_hwtstamp(struct net_device *dev, struct ifreq *ifr)
 		return -EFAULT;
 	if (tsconf.flags)
 		return -EINVAL;
-	if (tsconf.tx_type != HWTSTAMP_TX_OFF)
+	if (tsconf.tx_type != HWTSTAMP_TX_OFF &&
+	    tsconf.tx_type != HWTSTAMP_TX_ON)
 		return -ERANGE;
 	if (tsconf.rx_filter != HWTSTAMP_FILTER_NONE &&
 	    tsconf.rx_filter != HWTSTAMP_FILTER_ALL)
@@ -3995,6 +4043,11 @@ static int virtnet_ioctl_set_hwtstamp(struct net_device *dev, struct ifreq *ifr)
 	else
 		vi->enable_rx_tstamp = tsconf.rx_filter == HWTSTAMP_FILTER_ALL;
 
+	if (!vi->has_tx_tstamp)
+		tsconf.tx_type = HWTSTAMP_TX_OFF;
+	else
+		vi->enable_tx_tstamp = tsconf.tx_type == HWTSTAMP_TX_ON;
+
 	if (copy_to_user(ifr->ifr_data, &tsconf, sizeof(tsconf)))
 		return -EFAULT;
 
@@ -4009,7 +4062,8 @@ static int virtnet_ioctl_get_hwtstamp(struct net_device *dev, struct ifreq *ifr)
 	tsconf.flags = 0;
 	tsconf.rx_filter = vi->enable_rx_tstamp ? HWTSTAMP_FILTER_ALL :
 						  HWTSTAMP_FILTER_NONE;
-	tsconf.tx_type = HWTSTAMP_TX_OFF;
+	tsconf.tx_type = vi->enable_tx_tstamp ? HWTSTAMP_TX_ON :
+						HWTSTAMP_TX_OFF;
 
 	if (copy_to_user(ifr->ifr_data, &tsconf, sizeof(tsconf)))
 		return -EFAULT;
@@ -4639,6 +4693,11 @@ static int virtnet_probe(struct virtio_device *vdev)
 		vi->hdr_len = sizeof(struct virtio_net_hdr_hash_ts);
 	}
 
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_TX_TSTAMP)) {
+		vi->has_tx_tstamp = true;
+		vi->hdr_len = sizeof(struct virtio_net_hdr_hash_ts);
+	}
+
 	if (virtio_has_feature(vdev, VIRTIO_F_ANY_LAYOUT) ||
 	    virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
 		vi->any_header_sg = true;
@@ -4882,7 +4941,7 @@ static struct virtio_device_id id_table[] = {
 	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL, \
 	VIRTIO_NET_F_VQ_NOTF_COAL, \
 	VIRTIO_NET_F_GUEST_HDRLEN, \
-	VIRTIO_NET_F_TX_HASH, VIRTIO_NET_F_RX_TSTAMP
+	VIRTIO_NET_F_TX_HASH, VIRTIO_NET_F_RX_TSTAMP, VIRTIO_NET_F_TX_TSTAMP
 
 static unsigned int features[] = {
 	VIRTNET_FEATURES,
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 6a0a6f299a13b..03a7ef45372d7 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -56,6 +56,7 @@
 #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
+#define VIRTIO_NET_F_TX_TSTAMP	  49	/* Device sends TAI transmit time */
 #define VIRTIO_NET_F_RX_TSTAMP	  50	/* Device sends TAI receive time */
 #define VIRTIO_NET_F_TX_HASH	  51	/* Driver sends hash report */
 #define VIRTIO_NET_F_VQ_NOTF_COAL 52	/* Device supports virtqueue notification coalescing */

-- 
2.42.0


