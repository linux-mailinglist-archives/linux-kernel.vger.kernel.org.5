Return-Path: <linux-kernel+bounces-3460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 503B1816CA2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C74ED28467D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E64225CD;
	Mon, 18 Dec 2023 11:38:15 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BEB33CC1
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 11:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1rFBwa-0000Vp-1R; Mon, 18 Dec 2023 12:37:56 +0100
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Mon, 18 Dec 2023 12:37:11 +0100
Subject: [PATCH RFC 4/4] virtio-net: support future packet transmit time
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231218-v6-7-topic-virtio-net-ptp-v1-4-cac92b2d8532@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3486;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=EJKihRWjT7yjMqK7mYnH5LqaBkCEuOfwqbOCbJtPME4=;
 b=owGbwMvMwCUmvd38QH3grB+Mp9WSGFIb9DlzuBpkjv/4xRqe7PNzyqbvkl0fPvhOcl38L1LD4Vv9
 BFaHjlIWBjEuBlkxRZbItYc0Ngt/1vly/DwDzBxWJpAhDFycAjARXimG/yHrJpyqnCP0fNO1iYbWpt
 8fqRbxd+oskHC31OVeFmddu5+R4ULJFDenlOA/+S+WXTzoYubj0PPN5V3nu90c11cp3Zv8nxkA
X-Developer-Key: i=s.trumtrar@pengutronix.de; a=openpgp;
 fpr=59ADC228B313F32CF4C7CF001BB737C07F519AF8
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

Add optional transmit time (SO_TXTIME) offload for virtio-net.

The Linux TCP/IP stack tries to avoid bursty transmission and network
congestion through pacing: computing an skb delivery time based on
congestion information. Userspace protocol implementations can achieve
the same with SO_TXTIME. This may also reduce scheduling jitter and
improve RTT estimation.

Pacing can be implemented in ETF or FQ qdiscs or offloaded to NIC
hardware. Allow virtio-net driver to offload for the same reasons.

The timestamp straddles (virtual) hardware domains. Like PTP, use
international atomic time (CLOCK_TAI) as global clock base. The driver
must sync with the device, e.g., through kvm-clock.

Changes RFC - RFCv2
  - rename from transmit timestamp to future packet transmit time
  - convert cpu_to_virtioXX to cpu_to_leXX

Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/net/virtio_net.c        | 13 ++++++++++++-
 include/uapi/linux/virtio_net.h |  1 +
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4065834957fbd..fb3572074e8b8 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -286,6 +286,9 @@ struct virtnet_info {
 	/* Device will pass tx timestamp. Requires has_tx_tstamp */
 	bool enable_tx_tstamp;
 
+	/* Driver will pass CLOCK_TAI delivery time to the device */
+	bool has_tx_time;
+
 	/* Has control virtqueue */
 	bool has_cvq;
 
@@ -2371,6 +2374,8 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
 	}
 	if (vi->enable_tx_tstamp && skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)
 		ht->hash.hdr.flags |= VIRTIO_NET_HDR_F_TSTAMP;
+	if (vi->has_tx_time && skb->tstamp)
+		ht->tstamp = cpu_to_le64(skb->tstamp);
 
 	sg_init_table(sq->sg, skb_shinfo(skb)->nr_frags + (can_push ? 1 : 2));
 	if (can_push) {
@@ -4698,6 +4703,11 @@ static int virtnet_probe(struct virtio_device *vdev)
 		vi->hdr_len = sizeof(struct virtio_net_hdr_hash_ts);
 	}
 
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_TX_TIME)) {
+		vi->has_tx_time = true;
+		vi->hdr_len = sizeof(struct virtio_net_hdr_hash_ts);
+	}
+
 	if (virtio_has_feature(vdev, VIRTIO_F_ANY_LAYOUT) ||
 	    virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
 		vi->any_header_sg = true;
@@ -4941,7 +4951,8 @@ static struct virtio_device_id id_table[] = {
 	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL, \
 	VIRTIO_NET_F_VQ_NOTF_COAL, \
 	VIRTIO_NET_F_GUEST_HDRLEN, \
-	VIRTIO_NET_F_TX_HASH, VIRTIO_NET_F_RX_TSTAMP, VIRTIO_NET_F_TX_TSTAMP
+	VIRTIO_NET_F_TX_HASH, VIRTIO_NET_F_RX_TSTAMP, VIRTIO_NET_F_TX_TSTAMP, \
+	VIRTIO_NET_F_TX_TIME
 
 static unsigned int features[] = {
 	VIRTNET_FEATURES,
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 03a7ef45372d7..18db1e1130d92 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -56,6 +56,7 @@
 #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
+#define VIRTIO_NET_F_TX_TIME	  48	/* Driver sets TAI delivery time */
 #define VIRTIO_NET_F_TX_TSTAMP	  49	/* Device sends TAI transmit time */
 #define VIRTIO_NET_F_RX_TSTAMP	  50	/* Device sends TAI receive time */
 #define VIRTIO_NET_F_TX_HASH	  51	/* Driver sends hash report */

-- 
2.42.0


