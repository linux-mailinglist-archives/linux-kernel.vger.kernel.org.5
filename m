Return-Path: <linux-kernel+bounces-3458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAE8816C9B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97CBF28395D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA01334545;
	Mon, 18 Dec 2023 11:38:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EC931747
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 11:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1rFBwY-0000Vp-Or; Mon, 18 Dec 2023 12:37:54 +0100
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Mon, 18 Dec 2023 12:37:09 +0100
Subject: [PATCH RFC 2/4] virtio-net: support receive timestamp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231218-v6-7-topic-virtio-net-ptp-v1-2-cac92b2d8532@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9439;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=/amFfGGN0ySjYA0bFqG8F1jrShubaLWAjnl+dO9RuW8=;
 b=owGbwMvMwCUmvd38QH3grB+Mp9WSGFIb9BmL9dvdJb3/hR9bZJG+i9u3yf+Yl+FMF8bPu1McvI/c
 OqzQUcrCIMbFICumyBK59pDGZuHPOl+On2eAmcPKBDKEgYtTACbyi4+RYcmhW7p/lLT4blf8PtdU6L
 LloFxpxFvLKUU7jiS81ffTMWL4724eLRoa9Sz+duaE1EtnGH9XlJmozNmxgFvzyM7Fu7aacAIA
X-Developer-Key: i=s.trumtrar@pengutronix.de; a=openpgp;
 fpr=59ADC228B313F32CF4C7CF001BB737C07F519AF8
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

Add optional PTP hardware rx timestamp offload for virtio-net.

Accurate RTT measurement requires timestamps close to the wire.
Introduce virtio feature VIRTIO_NET_F_RX_TSTAMP. If negotiated, the
virtio-net header is expanded with room for a timestamp.

A device may pass receive timestamps for all or some packets. Flag
VIRTIO_NET_HDR_F_TSTAMP signals whether a timestamp is recorded.

A driver that supports hardware timestamping must also support
ioctl SIOCSHWTSTAMP. Implement that, as well as information getters
ioctl SIOCGHWTSTAMP and ethtool get_ts_info (`ethtool -T $DEV`).

The timestamp straddles (virtual) hardware domains. Like PTP, use
international atomic time (CLOCK_TAI) as global clock base. The driver
must sync with the device, e.g., through kvm-clock.

Tested:
  guest: ./timestamping eth0 \
          SOF_TIMESTAMPING_RAW_HARDWARE \
          SOF_TIMESTAMPING_RX_HARDWARE
  host: nc -4 -u 192.168.1.1 319

Changes RFC -> RFCv2
  - rename virtio_net_hdr_v12 to virtio_net_hdr_hash_ts
  - add ethtool .get_ts_info to query capabilities
  - add ioctl SIOC[GS]HWTSTAMP to configure feature
  - add vi->enable_rx_tstamp to store configuration
  - convert virtioXX_to_cpu to leXX_to_cpu
  - convert reserved to __u32

Signed-off-by: Willem de Bruijn <willemb@google.com>
Co-developed-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

--
  Changes to original RFCv2
  - move virtio_net_hdr_v1 into hash-struct
---
 drivers/net/virtio_net.c        | 113 +++++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/virtio_net.h |  13 +++++
 2 files changed, 124 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 8c9de31af8942..9bb6cdaf49cc9 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -274,6 +274,12 @@ struct virtnet_info {
 	/* Driver will pass tx path info to the device */
 	bool has_tx_hash;
 
+	/* Device can pass CLOCK_TAI receive time to the driver */
+	bool has_rx_tstamp;
+
+	/* Device will pass rx timestamp. Requires has_rx_tstamp */
+	bool enable_rx_tstamp;
+
 	/* Has control virtqueue */
 	bool has_cvq;
 
@@ -384,6 +390,13 @@ skb_vnet_common_hdr(struct sk_buff *skb)
 	return (struct virtio_net_common_hdr *)skb->cb;
 }
 
+static inline struct virtio_net_hdr_hash_ts *skb_vnet_hdr_ht(struct sk_buff *skb)
+{
+	BUILD_BUG_ON(sizeof(struct virtio_net_hdr_hash_ts) > sizeof(skb->cb));
+
+	return (void *)skb->cb;
+}
+
 /*
  * private is used to chain pages for big packets, put the whole
  * most recent used list in the beginning for reuse
@@ -1755,6 +1768,19 @@ static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr_hash,
 	skb_set_hash(skb, __le32_to_cpu(hdr_hash->hash_value), rss_hash_type);
 }
 
+static inline void virtnet_record_rx_tstamp(const struct virtnet_info *vi,
+					    struct sk_buff *skb)
+{
+	const struct virtio_net_hdr_hash_ts *h = skb_vnet_hdr_ht(skb);
+
+	if (h->hash.hdr.flags & VIRTIO_NET_HDR_F_TSTAMP &&
+	    vi->enable_rx_tstamp) {
+		u64 ts = le64_to_cpu(h->tstamp);
+
+		skb_hwtstamps(skb)->hwtstamp = ns_to_ktime(ts);
+	}
+}
+
 static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 			void *buf, unsigned int len, void **ctx,
 			unsigned int *xdp_xmit,
@@ -1797,6 +1823,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 		goto frame_err;
 	}
 
+	virtnet_record_rx_tstamp(vi, skb);
 	skb_record_rx_queue(skb, vq2rxq(rq->vq));
 	skb->protocol = eth_type_trans(skb, dev);
 	pr_debug("Receiving skb proto 0x%04x len %i type %i\n",
@@ -3512,6 +3539,28 @@ static int virtnet_get_per_queue_coalesce(struct net_device *dev,
 	return 0;
 }
 
+static int virtnet_get_ts_info(struct net_device *dev,
+			       struct ethtool_ts_info *info)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+
+	/* setup default software timestamp */
+	ethtool_op_get_ts_info(dev, info);
+
+	/* return rx capabilities (which may differ from current enable) */
+	if (vi->has_rx_tstamp) {
+		info->so_timestamping |= SOF_TIMESTAMPING_RX_HARDWARE |
+					 SOF_TIMESTAMPING_RAW_HARDWARE;
+		info->rx_filters = HWTSTAMP_FILTER_ALL;
+	} else {
+		info->rx_filters = HWTSTAMP_FILTER_NONE;
+	}
+
+	info->tx_types = HWTSTAMP_TX_OFF;
+
+	return 0;
+}
+
 static void virtnet_init_settings(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
@@ -3637,7 +3686,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.get_ethtool_stats = virtnet_get_ethtool_stats,
 	.set_channels = virtnet_set_channels,
 	.get_channels = virtnet_get_channels,
-	.get_ts_info = ethtool_op_get_ts_info,
+	.get_ts_info = virtnet_get_ts_info,
 	.get_link_ksettings = virtnet_get_link_ksettings,
 	.set_link_ksettings = virtnet_set_link_ksettings,
 	.set_coalesce = virtnet_set_coalesce,
@@ -3926,6 +3975,60 @@ static void virtnet_tx_timeout(struct net_device *dev, unsigned int txqueue)
 		   jiffies_to_usecs(jiffies - READ_ONCE(txq->trans_start)));
 }
 
+static int virtnet_ioctl_set_hwtstamp(struct net_device *dev, struct ifreq *ifr)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	struct hwtstamp_config tsconf;
+
+	if (copy_from_user(&tsconf, ifr->ifr_data, sizeof(tsconf)))
+		return -EFAULT;
+	if (tsconf.flags)
+		return -EINVAL;
+	if (tsconf.tx_type != HWTSTAMP_TX_OFF)
+		return -ERANGE;
+	if (tsconf.rx_filter != HWTSTAMP_FILTER_NONE &&
+	    tsconf.rx_filter != HWTSTAMP_FILTER_ALL)
+		tsconf.rx_filter = HWTSTAMP_FILTER_ALL;
+
+	if (!vi->has_rx_tstamp)
+		tsconf.rx_filter = HWTSTAMP_FILTER_NONE;
+	else
+		vi->enable_rx_tstamp = tsconf.rx_filter == HWTSTAMP_FILTER_ALL;
+
+	if (copy_to_user(ifr->ifr_data, &tsconf, sizeof(tsconf)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int virtnet_ioctl_get_hwtstamp(struct net_device *dev, struct ifreq *ifr)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	struct hwtstamp_config tsconf;
+
+	tsconf.flags = 0;
+	tsconf.rx_filter = vi->enable_rx_tstamp ? HWTSTAMP_FILTER_ALL :
+						  HWTSTAMP_FILTER_NONE;
+	tsconf.tx_type = HWTSTAMP_TX_OFF;
+
+	if (copy_to_user(ifr->ifr_data, &tsconf, sizeof(tsconf)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int virtnet_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
+{
+	switch (cmd) {
+	case SIOCSHWTSTAMP:
+		return virtnet_ioctl_set_hwtstamp(dev, ifr);
+
+	case SIOCGHWTSTAMP:
+		return virtnet_ioctl_get_hwtstamp(dev, ifr);
+	}
+	return -EOPNOTSUPP;
+}
+
 static const struct net_device_ops virtnet_netdev = {
 	.ndo_open            = virtnet_open,
 	.ndo_stop   	     = virtnet_close,
@@ -3942,6 +4045,7 @@ static const struct net_device_ops virtnet_netdev = {
 	.ndo_get_phys_port_name	= virtnet_get_phys_port_name,
 	.ndo_set_features	= virtnet_set_features,
 	.ndo_tx_timeout		= virtnet_tx_timeout,
+	.ndo_eth_ioctl		= virtnet_ioctl,
 };
 
 static void virtnet_config_changed_work(struct work_struct *work)
@@ -4530,6 +4634,11 @@ static int virtnet_probe(struct virtio_device *vdev)
 		vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash);
 	}
 
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_RX_TSTAMP)) {
+		vi->has_rx_tstamp = true;
+		vi->hdr_len = sizeof(struct virtio_net_hdr_hash_ts);
+	}
+
 	if (virtio_has_feature(vdev, VIRTIO_F_ANY_LAYOUT) ||
 	    virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
 		vi->any_header_sg = true;
@@ -4773,7 +4882,7 @@ static struct virtio_device_id id_table[] = {
 	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL, \
 	VIRTIO_NET_F_VQ_NOTF_COAL, \
 	VIRTIO_NET_F_GUEST_HDRLEN, \
-	VIRTIO_NET_F_TX_HASH
+	VIRTIO_NET_F_TX_HASH, VIRTIO_NET_F_RX_TSTAMP
 
 static unsigned int features[] = {
 	VIRTNET_FEATURES,
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 698a11f8c6ab9..6a0a6f299a13b 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -56,6 +56,7 @@
 #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
+#define VIRTIO_NET_F_RX_TSTAMP	  50	/* Device sends TAI receive time */
 #define VIRTIO_NET_F_TX_HASH	  51	/* Driver sends hash report */
 #define VIRTIO_NET_F_VQ_NOTF_COAL 52	/* Device supports virtqueue notification coalescing */
 #define VIRTIO_NET_F_NOTF_COAL	53	/* Device supports notifications coalescing */
@@ -131,6 +132,7 @@ struct virtio_net_hdr_v1 {
 #define VIRTIO_NET_HDR_F_NEEDS_CSUM	1	/* Use csum_start, csum_offset */
 #define VIRTIO_NET_HDR_F_DATA_VALID	2	/* Csum is valid */
 #define VIRTIO_NET_HDR_F_RSC_INFO	4	/* rsc info in csum_ fields */
+#define VIRTIO_NET_HDR_F_TSTAMP		8	/* timestamp is recorded */
 	__u8 flags;
 #define VIRTIO_NET_HDR_GSO_NONE		0	/* Not a GSO frame */
 #define VIRTIO_NET_HDR_GSO_TCPV4	1	/* GSO frame, IPv4 TCP (TSO) */
@@ -187,6 +189,17 @@ struct virtio_net_hdr_v1_hash {
 	};
 };
 
+struct virtio_net_hdr_hash_ts {
+	struct {
+		struct virtio_net_hdr_v1 hdr;
+		__le32 value;
+		__le16 report;
+		__le16 flow_state;
+	} hash;
+	__u32 reserved;
+	__le64 tstamp;
+};
+
 #ifndef VIRTIO_NET_NO_LEGACY
 /* This header comes first in the scatter-gather list.
  * For legacy virtio, if VIRTIO_F_ANY_LAYOUT is not negotiated, it must

-- 
2.42.0


