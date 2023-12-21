Return-Path: <linux-kernel+bounces-8130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B4581B273
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E39C51C23F71
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1364E618;
	Thu, 21 Dec 2023 09:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KQ0VxQ73"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61AF4CDE0;
	Thu, 21 Dec 2023 09:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BL6IACf018998;
	Thu, 21 Dec 2023 01:29:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=y1pQJ1UwDUcQ8/e6TvSExPJRrZtD1vKnuacCGjynOYg=; b=KQ0
	VxQ73MBI5qWYPTKMf8Hz29t+5u9hWTvbNXFYaYtwVmTvd8BB94Lxty3EJonrNk/c
	1Yft4Y4Z3aEmubwfXOJew2YtPIyXmfMd8msn4F4Crg8wSvu4H4FXZO9Vp88jxez4
	z8srWP+cpKlWsQy75uRImujDDQhDMdyXAvMsruY8DvwPN75aaPS6LGBsyjC+KY9o
	Kp+3tyvA+72dlP9c9ED1YiBu+r6FfIPuEZmUaYzZHDGSKySdYkAVJzeGVGnwcf4t
	+uGSZa+QketL6kEGMLK3bjvxpoL10Fw1RTE9VThpkc0IMdX3KpaG+vbkn7Jdr5KL
	3cGF3ENp/UMvA6/4XZA==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3v4fyr147r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 01:29:49 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 21 Dec
 2023 01:29:48 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 21 Dec 2023 01:29:48 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id A71393F7048;
	Thu, 21 Dec 2023 01:29:47 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <vimleshk@marvell.com>, <sedara@marvell.com>,
        <srasheed@marvell.com>, <egallen@redhat.com>, <mschmidt@redhat.com>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <horms@kernel.org>,
        <wizhao@redhat.com>, <kheib@redhat.com>, <konguyen@redhat.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Satananda Burla
	<sburla@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>
Subject: [PATCH net-next v1 5/8] octeon_ep_vf: add support for ndo ops
Date: Thu, 21 Dec 2023 01:28:41 -0800
Message-ID: <20231221092844.2885872-6-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231221092844.2885872-1-srasheed@marvell.com>
References: <20231221092844.2885872-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: XaniDbJPXIf50EXVPqg3HvEkBSdl5Mms
X-Proofpoint-ORIG-GUID: XaniDbJPXIf50EXVPqg3HvEkBSdl5Mms
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

Add support for ndo ops to set MAC address, change MTU, get stats.
Add control path support to set MAC address, change MTU, get stats,
set speed, get and set link mode.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
 .../marvell/octeon_ep_vf/octep_vf_main.c      | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
index 1bb621de5165..c29f99e8f121 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
@@ -188,6 +188,23 @@ static netdev_tx_t octep_vf_start_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
+int octep_vf_get_if_stats(struct octep_vf_device *oct)
+{
+	struct octep_vf_iface_rxtx_stats vf_stats;
+	int ret, size;
+
+	memset(&vf_stats, 0, sizeof(struct octep_vf_iface_rxtx_stats));
+	ret = octep_vf_mbox_bulk_read(oct, OCTEP_PFVF_MBOX_CMD_GET_STATS,
+				      (u8 *)&vf_stats, &size);
+	if (!ret) {
+		memcpy(&oct->iface_rx_stats, &vf_stats.iface_rx_stats,
+		       sizeof(struct octep_vf_iface_rx_stats));
+		memcpy(&oct->iface_tx_stats, &vf_stats.iface_tx_stats,
+		       sizeof(struct octep_vf_iface_tx_stats));
+	}
+	return ret;
+}
+
 int octep_vf_get_link_info(struct octep_vf_device *oct)
 {
 	int ret, size;
@@ -201,6 +218,42 @@ int octep_vf_get_link_info(struct octep_vf_device *oct)
 	return 0;
 }
 
+/**
+ * octep_vf_get_stats64() - Get Octeon network device statistics.
+ *
+ * @netdev: kernel network device.
+ * @stats: pointer to stats structure to be filled in.
+ */
+static void octep_vf_get_stats64(struct net_device *netdev,
+				 struct rtnl_link_stats64 *stats)
+{
+	struct octep_vf_device *oct = netdev_priv(netdev);
+	u64 tx_packets, tx_bytes, rx_packets, rx_bytes;
+	int q;
+
+	tx_packets = 0;
+	tx_bytes = 0;
+	rx_packets = 0;
+	rx_bytes = 0;
+	for (q = 0; q < oct->num_oqs; q++) {
+		struct octep_vf_iq *iq = oct->iq[q];
+		struct octep_vf_oq *oq = oct->oq[q];
+
+		tx_packets += iq->stats.instr_completed;
+		tx_bytes += iq->stats.bytes_sent;
+		rx_packets += oq->stats.packets;
+		rx_bytes += oq->stats.bytes;
+	}
+	stats->tx_packets = tx_packets;
+	stats->tx_bytes = tx_bytes;
+	stats->rx_packets = rx_packets;
+	stats->rx_bytes = rx_bytes;
+	if (!octep_vf_get_if_stats(oct)) {
+		stats->multicast = oct->iface_rx_stats.mcast_pkts;
+		stats->rx_errors = oct->iface_rx_stats.err_pkts;
+	}
+}
+
 /**
  * octep_vf_tx_timeout_task - work queue task to Handle Tx queue timeout.
  *
@@ -313,6 +366,7 @@ static const struct net_device_ops octep_vf_netdev_ops = {
 	.ndo_open                = octep_vf_open,
 	.ndo_stop                = octep_vf_stop,
 	.ndo_start_xmit          = octep_vf_start_xmit,
+	.ndo_get_stats64         = octep_vf_get_stats64,
 	.ndo_tx_timeout          = octep_vf_tx_timeout,
 	.ndo_set_mac_address     = octep_vf_set_mac,
 	.ndo_change_mtu          = octep_vf_change_mtu,
-- 
2.25.1


