Return-Path: <linux-kernel+bounces-3456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A287816C99
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3488428449B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B3F31A62;
	Mon, 18 Dec 2023 11:38:11 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829BF2D7A7
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 11:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1rFBwY-0000Vp-2R; Mon, 18 Dec 2023 12:37:54 +0100
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Mon, 18 Dec 2023 12:37:08 +0100
Subject: [PATCH RFC 1/4] virtio-net: support transmit hash report
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231218-v6-7-topic-virtio-net-ptp-v1-1-cac92b2d8532@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5344;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=9Uw8CA+6ibAmUraUAydQKoNaof2rIiZIlLZkYPxWA6M=;
 b=owGbwMvMwCUmvd38QH3grB+Mp9WSGFIb9P4VLZ0SNVOgJY/7bPn08DMN318JaGTN+nHt27ZrDVkz
 rAssOkpZGMS4GGTFFFki1x7S2Cz8WefL8fMMMHNYmUCGMHBxCsBEZv5j+J909ta09xvmC4cGvhfneX
 NjxoWPZr1bl2ueY/k2oefgbaNdjAzXJnR8/b2Ht8a6bF5S47G+K/v4cp4kz91+jnHmatcW/TwOAA==
X-Developer-Key: i=s.trumtrar@pengutronix.de; a=openpgp;
 fpr=59ADC228B313F32CF4C7CF001BB737C07F519AF8
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

Virtio-net supports sharing the flow hash from device to driver on rx.
Do the same in the other direction for robust routing and telemetry.

Linux derives ipv6 flowlabel and ECMP multipath from sk->sk_txhash,
and updates this field on error with sk_rethink_txhash. Allow the host
stack to do the same.

Concrete examples of error conditions that are resolved are
mentioned in the commits that add sk_rethink_txhash calls. Such as
commit 7788174e8726 ("tcp: change IPv6 flow-label upon receiving
spurious retransmission").

Experimental results mirror what the theory suggests: where IPv6
FlowLabel is included in path selection (e.g., LAG/ECMP), flowlabel
rotation on TCP timeout avoids the vast majority of TCP disconnects
that would otherwise have occurred during link failures in long-haul
backbones, when an alternative path is available.

Rotation can be applied to various bad connection signals, such as
timeouts and spurious retransmissions. In aggregate, such flow level
signals can help locate network issues. Reserve field hash_state to
share this info. For now, always set VIRTIO_NET_HASH_STATE_DEFAULT.
Passing information between TCP stack and driver is future work.

Changes RFC->RFCv2
  - drop unused VIRTIO_NET_HASH_STATE_TIMEOUT_BIT
  - convert from cpu_to_virtioXX to cpu_to_leXX

Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/net/virtio_net.c        | 26 +++++++++++++++++++++++---
 include/uapi/linux/virtio_net.h |  9 ++++++++-
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d16f592c2061f..8c9de31af8942 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -271,6 +271,9 @@ struct virtnet_info {
 	u32 rss_hash_types_supported;
 	u32 rss_hash_types_saved;
 
+	/* Driver will pass tx path info to the device */
+	bool has_tx_hash;
+
 	/* Has control virtqueue */
 	bool has_cvq;
 
@@ -512,9 +515,9 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 
 	hdr_len = vi->hdr_len;
 	if (vi->mergeable_rx_bufs)
-		hdr_padded_len = hdr_len;
+		hdr_padded_len = max_t(unsigned int, hdr_len, sizeof(*hdr));
 	else
-		hdr_padded_len = sizeof(struct padded_vnet_hdr);
+		hdr_padded_len = ALIGN(hdr_len, 16);
 
 	buf = p - headroom;
 	len -= hdr_len;
@@ -2282,6 +2285,7 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
 	struct virtio_net_hdr_mrg_rxbuf *hdr;
 	const unsigned char *dest = ((struct ethhdr *)skb->data)->h_dest;
 	struct virtnet_info *vi = sq->vq->vdev->priv;
+	struct virtio_net_hdr_v1_hash *ht;
 	int num_sg;
 	unsigned hdr_len = vi->hdr_len;
 	bool can_push;
@@ -2306,6 +2310,16 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
 	if (vi->mergeable_rx_bufs)
 		hdr->num_buffers = 0;
 
+	ht = (void *)hdr;
+	if (vi->has_tx_hash) {
+		u16 report = skb->l4_hash ? VIRTIO_NET_HASH_REPORT_L4 :
+					    VIRTIO_NET_HASH_REPORT_OTHER;
+
+		ht->hash_value = cpu_to_le32(skb->hash);
+		ht->hash_report = cpu_to_le16(report);
+		ht->hash_state = cpu_to_le16(VIRTIO_NET_HASH_STATE_DEFAULT);
+	}
+
 	sg_init_table(sq->sg, skb_shinfo(skb)->nr_frags + (can_push ? 1 : 2));
 	if (can_push) {
 		__skb_push(skb, hdr_len);
@@ -4511,6 +4525,11 @@ static int virtnet_probe(struct virtio_device *vdev)
 	else
 		vi->hdr_len = sizeof(struct virtio_net_hdr);
 
+	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_TX_HASH)) {
+		vi->has_tx_hash = true;
+		vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash);
+	}
+
 	if (virtio_has_feature(vdev, VIRTIO_F_ANY_LAYOUT) ||
 	    virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
 		vi->any_header_sg = true;
@@ -4753,7 +4772,8 @@ static struct virtio_device_id id_table[] = {
 	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
 	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL, \
 	VIRTIO_NET_F_VQ_NOTF_COAL, \
-	VIRTIO_NET_F_GUEST_HDRLEN
+	VIRTIO_NET_F_GUEST_HDRLEN, \
+	VIRTIO_NET_F_TX_HASH
 
 static unsigned int features[] = {
 	VIRTNET_FEATURES,
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index cc65ef0f3c3e2..698a11f8c6ab9 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -56,6 +56,7 @@
 #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
+#define VIRTIO_NET_F_TX_HASH	  51	/* Driver sends hash report */
 #define VIRTIO_NET_F_VQ_NOTF_COAL 52	/* Device supports virtqueue notification coalescing */
 #define VIRTIO_NET_F_NOTF_COAL	53	/* Device supports notifications coalescing */
 #define VIRTIO_NET_F_GUEST_USO4	54	/* Guest can handle USOv4 in. */
@@ -176,8 +177,14 @@ struct virtio_net_hdr_v1_hash {
 #define VIRTIO_NET_HASH_REPORT_IPv6_EX         7
 #define VIRTIO_NET_HASH_REPORT_TCPv6_EX        8
 #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
+#define VIRTIO_NET_HASH_REPORT_L4              10
+#define VIRTIO_NET_HASH_REPORT_OTHER           11
 	__le16 hash_report;
-	__le16 padding;
+	union {
+		__le16 padding;
+#define VIRTIO_NET_HASH_STATE_DEFAULT          0
+		__le16 hash_state;
+	};
 };
 
 #ifndef VIRTIO_NET_NO_LEGACY

-- 
2.42.0


