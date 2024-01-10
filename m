Return-Path: <linux-kernel+bounces-22128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 271D88299C1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67A30B25654
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6DA48CEC;
	Wed, 10 Jan 2024 11:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZoswQW+W"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4F0481DE;
	Wed, 10 Jan 2024 11:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40ABSTw1003609;
	Wed, 10 Jan 2024 11:44:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=VoEP7zXSTHcfqOzpJJQQyV8U8txZQY38+CGYrXU01Nw=; b=Zo
	swQW+Wcwi1tlpw7z5sYMhEIPjUoToqt29Jg0uNF3KlBs/Pcfj9ZycOYj6aDy3F+K
	4obUJdrf9j0NK9vXQYYCFnDewk0xh+Fdj1Oe4b6BlFRhIU9etxQZROF3RnDa/ArA
	D7OyTshcl+dxxqHd8S+qSDH5ZarQEp/CFDQ0yxxqA8t/ybI6kP0yPnJNVnL+7Icz
	8bagyjQpRYdN5PXHBmA1Fc4aD2AfqaSnGwxtSc3NCoYaWbn+n0p4uzffAfwm2Ian
	OxVqgNGuQ46R2d/1UM2DGIDkjeVXxQrj/35NGDfatvgD9r0/+xukCZk6WfAFa278
	9COBmgeUssuAkgCuhMtQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh9evt90m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:44:17 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40ABiGVr015523
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:44:16 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 03:44:06 -0800
From: Luo Jie <quic_luoj@quicinc.com>
To: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <linux@armlinux.org.uk>,
        <shannon.nelson@amd.com>, <anthony.l.nguyen@intel.com>,
        <jasowang@redhat.com>, <brett.creeley@amd.com>,
        <rrameshbabu@nvidia.com>, <joshua.a.hay@intel.com>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <neil.armstrong@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <nfraprado@collabora.com>,
        <m.szyprowski@samsung.com>, <u-kumar1@ti.com>,
        <jacob.e.keller@intel.com>, <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <ryazanov.s.a@gmail.com>, <ansuelsmth@gmail.com>,
        <quic_kkumarcs@quicinc.com>, <quic_suruchia@quicinc.com>,
        <quic_soni@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_souravp@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_leiwei@quicinc.com>
Subject: [PATCH net-next 19/20] net: ethernet: qualcomm: Add PPE MAC functions
Date: Wed, 10 Jan 2024 19:40:31 +0800
Message-ID: <20240110114033.32575-20-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240110114033.32575-1-quic_luoj@quicinc.com>
References: <20240110114033.32575-1-quic_luoj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: o3I8_Ph6Bi_JmZWCA8wVzBLW-FXXtTT1
X-Proofpoint-ORIG-GUID: o3I8_Ph6Bi_JmZWCA8wVzBLW-FXXtTT1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100096

From: Lei Wei <quic_leiwei@quicinc.com>

Add PPE MAC functions including MAC MIB statistics, MAC eee and MAC
address setting related operations which used by ethtool and netdev ops.

Signed-off-by: Lei Wei <quic_leiwei@quicinc.com>
Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/ethernet/qualcomm/ppe/ppe.c      | 698 +++++++++++++++++++
 drivers/net/ethernet/qualcomm/ppe/ppe.h      |  98 +++
 drivers/net/ethernet/qualcomm/ppe/ppe_regs.h | 172 +++++
 include/linux/soc/qcom/ppe.h                 |  30 +
 4 files changed, 998 insertions(+)

diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.c b/drivers/net/ethernet/qualcomm/ppe/ppe.c
index d241ff3eab84..680d228a5307 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe.c
@@ -28,6 +28,115 @@
 #define PPE_SCHEDULER_L1_NUM		64
 #define PPE_SP_PRIORITY_NUM		8
 
+#define PPE_ETHTOOL_XGMIB_STAT(x) { #x, \
+				    offsetof(struct ppe_xgmib_hw_stats, x) / sizeof(u64) }
+#define PPE_ETHTOOL_GMIB_STAT(x) { #x, \
+				   offsetof(struct ppe_gmib_hw_stats, x) / sizeof(u64) }
+
+/* Poll interval time to poll GMAC MIBs for overflow protection */
+#define PPE_GMIB_STATS_POLL_INTERVAL	120000
+
+/* XGMAC strings used by ethtool */
+static const struct ppe_ethtool_gstrings_xgmib_stats {
+	char name[ETH_GSTRING_LEN];
+	u32 offset;
+} ppe_ethtool_gstrings_xgmib_stats[] = {
+	PPE_ETHTOOL_XGMIB_STAT(rx_frames),
+	PPE_ETHTOOL_XGMIB_STAT(rx_bytes),
+	PPE_ETHTOOL_XGMIB_STAT(rx_bytes_g),
+	PPE_ETHTOOL_XGMIB_STAT(rx_broadcast_g),
+	PPE_ETHTOOL_XGMIB_STAT(rx_multicast_g),
+	PPE_ETHTOOL_XGMIB_STAT(rx_unicast_g),
+	PPE_ETHTOOL_XGMIB_STAT(rx_crc_err),
+	PPE_ETHTOOL_XGMIB_STAT(rx_runt_err),
+	PPE_ETHTOOL_XGMIB_STAT(rx_jabber_err),
+	PPE_ETHTOOL_XGMIB_STAT(rx_undersize_g),
+	PPE_ETHTOOL_XGMIB_STAT(rx_oversize_g),
+	PPE_ETHTOOL_XGMIB_STAT(rx_pkt64),
+	PPE_ETHTOOL_XGMIB_STAT(rx_pkt65to127),
+	PPE_ETHTOOL_XGMIB_STAT(rx_pkt128to255),
+	PPE_ETHTOOL_XGMIB_STAT(rx_pkt256to511),
+	PPE_ETHTOOL_XGMIB_STAT(rx_pkt512to1023),
+	PPE_ETHTOOL_XGMIB_STAT(rx_pkt1024tomax),
+	PPE_ETHTOOL_XGMIB_STAT(rx_len_err),
+	PPE_ETHTOOL_XGMIB_STAT(rx_outofrange_err),
+	PPE_ETHTOOL_XGMIB_STAT(rx_pause),
+	PPE_ETHTOOL_XGMIB_STAT(rx_fifo_overflow),
+	PPE_ETHTOOL_XGMIB_STAT(rx_vlan),
+	PPE_ETHTOOL_XGMIB_STAT(rx_wdog_err),
+	PPE_ETHTOOL_XGMIB_STAT(rx_lpi_usec),
+	PPE_ETHTOOL_XGMIB_STAT(rx_lpi_tran),
+	PPE_ETHTOOL_XGMIB_STAT(rx_drop_frames),
+	PPE_ETHTOOL_XGMIB_STAT(rx_drop_bytes),
+	PPE_ETHTOOL_XGMIB_STAT(tx_bytes),
+	PPE_ETHTOOL_XGMIB_STAT(tx_bytes_g),
+	PPE_ETHTOOL_XGMIB_STAT(tx_frames),
+	PPE_ETHTOOL_XGMIB_STAT(tx_frame_g),
+	PPE_ETHTOOL_XGMIB_STAT(tx_broadcast),
+	PPE_ETHTOOL_XGMIB_STAT(tx_broadcast_g),
+	PPE_ETHTOOL_XGMIB_STAT(tx_multicast),
+	PPE_ETHTOOL_XGMIB_STAT(tx_multicast_g),
+	PPE_ETHTOOL_XGMIB_STAT(tx_unicast),
+	PPE_ETHTOOL_XGMIB_STAT(tx_pkt64),
+	PPE_ETHTOOL_XGMIB_STAT(tx_pkt65to127),
+	PPE_ETHTOOL_XGMIB_STAT(tx_pkt128to255),
+	PPE_ETHTOOL_XGMIB_STAT(tx_pkt256to511),
+	PPE_ETHTOOL_XGMIB_STAT(tx_pkt512to1023),
+	PPE_ETHTOOL_XGMIB_STAT(tx_pkt1024tomax),
+	PPE_ETHTOOL_XGMIB_STAT(tx_underflow_err),
+	PPE_ETHTOOL_XGMIB_STAT(tx_pause),
+	PPE_ETHTOOL_XGMIB_STAT(tx_vlan_g),
+	PPE_ETHTOOL_XGMIB_STAT(tx_lpi_usec),
+	PPE_ETHTOOL_XGMIB_STAT(tx_lpi_tran),
+};
+
+/* GMAC strings used by ethtool */
+static const struct ppe_ethtool_gstrings_gmib_stats {
+	char name[ETH_GSTRING_LEN];
+	u32 offset;
+} ppe_ethtool_gstrings_gmib_stats[] = {
+	PPE_ETHTOOL_GMIB_STAT(rx_broadcast),
+	PPE_ETHTOOL_GMIB_STAT(rx_pause),
+	PPE_ETHTOOL_GMIB_STAT(rx_unicast),
+	PPE_ETHTOOL_GMIB_STAT(rx_multicast),
+	PPE_ETHTOOL_GMIB_STAT(rx_fcserr),
+	PPE_ETHTOOL_GMIB_STAT(rx_alignerr),
+	PPE_ETHTOOL_GMIB_STAT(rx_runt),
+	PPE_ETHTOOL_GMIB_STAT(rx_frag),
+	PPE_ETHTOOL_GMIB_STAT(rx_jmbfcserr),
+	PPE_ETHTOOL_GMIB_STAT(rx_jmbalignerr),
+	PPE_ETHTOOL_GMIB_STAT(rx_pkt64),
+	PPE_ETHTOOL_GMIB_STAT(rx_pkt65to127),
+	PPE_ETHTOOL_GMIB_STAT(rx_pkt128to255),
+	PPE_ETHTOOL_GMIB_STAT(rx_pkt256to511),
+	PPE_ETHTOOL_GMIB_STAT(rx_pkt512to1023),
+	PPE_ETHTOOL_GMIB_STAT(rx_pkt1024to1518),
+	PPE_ETHTOOL_GMIB_STAT(rx_pkt1519tomax),
+	PPE_ETHTOOL_GMIB_STAT(rx_toolong),
+	PPE_ETHTOOL_GMIB_STAT(rx_pktgoodbyte),
+	PPE_ETHTOOL_GMIB_STAT(rx_pktbadbyte),
+	PPE_ETHTOOL_GMIB_STAT(tx_broadcast),
+	PPE_ETHTOOL_GMIB_STAT(tx_pause),
+	PPE_ETHTOOL_GMIB_STAT(tx_multicast),
+	PPE_ETHTOOL_GMIB_STAT(tx_underrun),
+	PPE_ETHTOOL_GMIB_STAT(tx_pkt64),
+	PPE_ETHTOOL_GMIB_STAT(tx_pkt65to127),
+	PPE_ETHTOOL_GMIB_STAT(tx_pkt128to255),
+	PPE_ETHTOOL_GMIB_STAT(tx_pkt256to511),
+	PPE_ETHTOOL_GMIB_STAT(tx_pkt512to1023),
+	PPE_ETHTOOL_GMIB_STAT(tx_pkt1024to1518),
+	PPE_ETHTOOL_GMIB_STAT(tx_pkt1519tomax),
+	PPE_ETHTOOL_GMIB_STAT(tx_pktbyte),
+	PPE_ETHTOOL_GMIB_STAT(tx_collisions),
+	PPE_ETHTOOL_GMIB_STAT(tx_abortcol),
+	PPE_ETHTOOL_GMIB_STAT(tx_multicol),
+	PPE_ETHTOOL_GMIB_STAT(tx_singlecol),
+	PPE_ETHTOOL_GMIB_STAT(tx_exesdeffer),
+	PPE_ETHTOOL_GMIB_STAT(tx_deffer),
+	PPE_ETHTOOL_GMIB_STAT(tx_latecol),
+	PPE_ETHTOOL_GMIB_STAT(tx_unicast),
+};
+
 static const char * const ppe_clock_name[PPE_CLK_MAX] = {
 	"cmn_ahb",
 	"cmn_sys",
@@ -694,6 +803,362 @@ static int ppe_port_bridge_txmac_en_set(struct ppe_device *ppe_dev, int port, bo
 	return 0;
 }
 
+/* Get GMAC MIBs from GMAC registers and update to PPE port gmib stats */
+static void ppe_gmib_stats_update(struct ppe_port *ppe_port)
+{
+	u32 val, hi;
+	struct ppe_device *ppe_dev = ppe_port->ppe_dev;
+	int port = ppe_port->port_id;
+
+	spin_lock(&ppe_port->stats_lock);
+
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_RXBROAD, &val);
+	ppe_port->gmib_stats->rx_broadcast += (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_RXPAUSE, &val);
+	ppe_port->gmib_stats->rx_pause += (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_RXMULTI, &val);
+	ppe_port->gmib_stats->rx_multicast += (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_RXFCSERR, &val);
+	ppe_port->gmib_stats->rx_fcserr += (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_RXALIGNERR, &val);
+	ppe_port->gmib_stats->rx_alignerr += (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_RXRUNT, &val);
+	ppe_port->gmib_stats->rx_runt += (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_RXFRAG, &val);
+	ppe_port->gmib_stats->rx_frag += (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_RXJUMBOFCSERR, &val);
+	ppe_port->gmib_stats->rx_jmbfcserr += (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_RXJUMBOALIGNERR, &val);
+	ppe_port->gmib_stats->rx_jmbalignerr += (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_RXPKT64, &val);
+	ppe_port->gmib_stats->rx_pkt64 += (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_RXPKT65TO127, &val);
+	ppe_port->gmib_stats->rx_pkt65to127 += (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_RXPKT128TO255, &val);
+	ppe_port->gmib_stats->rx_pkt128to255 += (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_RXPKT256TO511, &val);
+	ppe_port->gmib_stats->rx_pkt256to511 += (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_RXPKT512TO1023, &val);
+	ppe_port->gmib_stats->rx_pkt512to1023 += (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_RXPKT1024TO1518, &val);
+	ppe_port->gmib_stats->rx_pkt1024to1518 += (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_RXPKT1519TOX, &val);
+	ppe_port->gmib_stats->rx_pkt1519tomax += (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_RXTOOLONG, &val);
+	ppe_port->gmib_stats->rx_toolong += (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_RXGOODBYTE_L, &val);
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_RXGOODBYTE_H, &hi);
+	ppe_port->gmib_stats->rx_pktgoodbyte += (u64)val | (u64)hi << 32;
+
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_RXBADBYTE_L, &val);
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_RXBADBYTE_H, &hi);
+	ppe_port->gmib_stats->rx_pktbadbyte += (u64)val | (u64)hi << 32;
+
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_RXUNI, &val);
+	ppe_port->gmib_stats->rx_unicast += (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_TXBROAD, &val);
+	ppe_port->gmib_stats->tx_broadcast += (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_TXPAUSE, &val);
+	ppe_port->gmib_stats->tx_pause += (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_TXMULTI, &val);
+	ppe_port->gmib_stats->tx_multicast += (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_TXUNDERRUN, &val);
+	ppe_port->gmib_stats->tx_underrun += (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_TXPKT64, &val);
+	ppe_port->gmib_stats->tx_pkt64 += (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_TXPKT65TO127, &val);
+	ppe_port->gmib_stats->tx_pkt65to127 += (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_TXPKT128TO255, &val);
+	ppe_port->gmib_stats->tx_pkt128to255 += (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_TXPKT256TO511, &val);
+	ppe_port->gmib_stats->tx_pkt256to511 += (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_TXPKT512TO1023, &val);
+	ppe_port->gmib_stats->tx_pkt512to1023 += (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_TXPKT1024TO1518, &val);
+	ppe_port->gmib_stats->tx_pkt1024to1518 += (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_TXPKT1519TOX, &val);
+	ppe_port->gmib_stats->tx_pkt1519tomax += (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_TXBYTE_L, &val);
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_TXBYTE_H, &hi);
+	ppe_port->gmib_stats->tx_pktbyte += (u64)val | (u64)hi << 32;
+
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_TXCOLLISIONS, &val);
+	ppe_port->gmib_stats->tx_collisions += (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_TXABORTCOL, &val);
+	ppe_port->gmib_stats->tx_abortcol += (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_TXMULTICOL, &val);
+	ppe_port->gmib_stats->tx_multicol += (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_TXSINGLECOL, &val);
+	ppe_port->gmib_stats->tx_singlecol += (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_TXEXCESSIVEDEFER, &val);
+	ppe_port->gmib_stats->tx_exesdeffer += (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_TXDEFER, &val);
+	ppe_port->gmib_stats->tx_deffer += (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_TXLATECOL, &val);
+	ppe_port->gmib_stats->tx_latecol += (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_TXUNI, &val);
+	ppe_port->gmib_stats->tx_unicast += (u64)val;
+
+	spin_unlock(&ppe_port->stats_lock);
+}
+
+/* Get XGMAC MIBs from XGMAC registers */
+static void ppe_xgmib_stats_update(struct ppe_device *ppe_dev, int port,
+				   struct ppe_xgmib_hw_stats *xgmib_hw_stats)
+{
+	u32 val, hi;
+
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_OCTET_COUNT_GOOD_BAD_LOW, &val);
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_OCTET_COUNT_GOOD_BAD_HIGH, &hi);
+	xgmib_hw_stats->tx_bytes = (u64)val | (u64)hi << 32;
+
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_FRAME_COUNT_GOOD_BAD_LOW, &val);
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_FRAME_COUNT_GOOD_BAD_HIGH, &hi);
+	xgmib_hw_stats->tx_frames = (u64)val | (u64)hi << 32;
+
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_BROADCAST_FRAMES_GOOD_LOW, &val);
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_BROADCAST_FRAMES_GOOD_HIGH, &hi);
+	xgmib_hw_stats->tx_broadcast_g = (u64)val | (u64)hi << 32;
+
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_MULTICAST_FRAMES_GOOD_LOW, &val);
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_MULTICAST_FRAMES_GOOD_HIGH, &hi);
+	xgmib_hw_stats->tx_multicast_g = (u64)val | (u64)hi << 32;
+
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_64OCTETS_FRAMES_GOOD_BAD_LOW, &val);
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_64OCTETS_FRAMES_GOOD_BAD_HIGH, &hi);
+	xgmib_hw_stats->tx_pkt64 = (u64)val | (u64)hi << 32;
+
+	ppe_read(ppe_dev,
+		 PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_65TO127OCTETS_FRAMES_GOOD_BAD_LOW, &val);
+	ppe_read(ppe_dev,
+		 PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_65TO127OCTETS_FRAMES_GOOD_BAD_HIGH, &hi);
+	xgmib_hw_stats->tx_pkt65to127 = (u64)val | (u64)hi << 32;
+
+	ppe_read(ppe_dev,
+		 PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_128TO255OCTETS_FRAMES_GOOD_BAD_LOW, &val);
+	ppe_read(ppe_dev,
+		 PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_128TO255OCTETS_FRAMES_GOOD_BAD_HIGH, &hi);
+	xgmib_hw_stats->tx_pkt128to255 = (u64)val | (u64)hi << 32;
+
+	ppe_read(ppe_dev,
+		 PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_256TO511OCTETS_FRAMES_GOOD_BAD_LOW, &val);
+	ppe_read(ppe_dev,
+		 PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_256TO511OCTETS_FRAMES_GOOD_BAD_HIGH, &hi);
+	xgmib_hw_stats->tx_pkt256to511 = (u64)val | (u64)hi << 32;
+
+	ppe_read(ppe_dev,
+		 PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_512TO1023OCTETS_FRAMES_GOOD_BAD_LOW, &val);
+	ppe_read(ppe_dev,
+		 PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_512TO1023OCTETS_FRAMES_GOOD_BAD_HIGH, &hi);
+	xgmib_hw_stats->tx_pkt512to1023 = (u64)val | (u64)hi << 32;
+
+	ppe_read(ppe_dev,
+		 PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_1024TOMAXOCTETS_FRAMES_GOOD_BAD_LOW, &val);
+	ppe_read(ppe_dev,
+		 PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_1024TOMAXOCTETS_FRAMES_GOOD_BAD_HIGH, &hi);
+	xgmib_hw_stats->tx_pkt1024tomax = (u64)val | (u64)hi << 32;
+
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_UNICAST_FRAMES_GOOD_BAD_LOW, &val);
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_UNICAST_FRAMES_GOOD_BAD_HIGH, &hi);
+	xgmib_hw_stats->tx_unicast = (u64)val | (u64)hi << 32;
+
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_MULTICAST_FRAMES_GOOD_BAD_LOW, &val);
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_MULTICAST_FRAMES_GOOD_BAD_HIGH, &hi);
+	xgmib_hw_stats->tx_multicast = (u64)val | (u64)hi << 32;
+
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_BROADCAST_FRAMES_GOOD_BAD_LOW, &val);
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_BROADCAST_FRAMES_GOOD_BAD_HIGH, &hi);
+	xgmib_hw_stats->tx_broadcast = (u64)val | (u64)hi << 32;
+
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_UNDERFLOW_ERROR_FRAMES_LOW, &val);
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_UNDERFLOW_ERROR_FRAMES_HIGH, &hi);
+	xgmib_hw_stats->tx_underflow_err = (u64)val | (u64)hi << 32;
+
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_OCTET_COUNT_GOOD_LOW, &val);
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_OCTET_COUNT_GOOD_HIGH, &hi);
+	xgmib_hw_stats->tx_bytes_g = (u64)val | (u64)hi << 32;
+
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_FRAME_COUNT_GOOD_LOW, &val);
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_FRAME_COUNT_GOOD_HIGH, &hi);
+	xgmib_hw_stats->tx_frame_g = (u64)val | (u64)hi << 32;
+
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_PAUSE_FRAMES_LOW, &val);
+	xgmib_hw_stats->tx_pause = (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_VLAN_FRAMES_GOOD_LOW, &val);
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_VLAN_FRAMES_GOOD_HIGH, &hi);
+	xgmib_hw_stats->tx_vlan_g = (u64)val | (u64)hi << 32;
+
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_LPI_USEC_CNTR, &val);
+	xgmib_hw_stats->tx_lpi_usec = (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_LPI_TRAN_CNTR, &val);
+	xgmib_hw_stats->tx_lpi_tran = (u64)val;
+
+	/* rx mib stats */
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_FRAME_COUNT_GOOD_BAD_LOW, &val);
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_FRAME_COUNT_GOOD_BAD_HIGH, &hi);
+	xgmib_hw_stats->rx_frames = (u64)val | (u64)hi << 32;
+
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_OCTET_COUNT_GOOD_BAD_LOW, &val);
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_OCTET_COUNT_GOOD_BAD_HIGH, &hi);
+	xgmib_hw_stats->rx_bytes = (u64)val | (u64)hi << 32;
+
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_OCTET_COUNT_GOOD_LOW, &val);
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_OCTET_COUNT_GOOD_HIGH, &hi);
+	xgmib_hw_stats->rx_bytes_g = (u64)val | (u64)hi << 32;
+
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_BROADCAST_FRAMES_GOOD_LOW, &val);
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_BROADCAST_FRAMES_GOOD_HIGH, &hi);
+	xgmib_hw_stats->rx_broadcast_g = (u64)val | (u64)hi << 32;
+
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_MULTICAST_FRAMES_GOOD_LOW, &val);
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_MULTICAST_FRAMES_GOOD_HIGH, &hi);
+	xgmib_hw_stats->rx_multicast_g = (u64)val | (u64)hi << 32;
+
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_CRC_ERROR_FRAMES_LOW, &val);
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_CRC_ERROR_FRAMES_HIGH, &hi);
+	xgmib_hw_stats->rx_crc_err = (u64)val | (u64)hi << 32;
+
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_FRAG_ERROR_FRAMES, &val);
+	xgmib_hw_stats->rx_runt_err = (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_JABBER_ERROR_FRAMES, &val);
+	xgmib_hw_stats->rx_jabber_err = (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_UNDERSIZE_FRAMES_GOOD, &val);
+	xgmib_hw_stats->rx_undersize_g = (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_OVERSIZE_FRAMES_GOOD, &val);
+	xgmib_hw_stats->rx_oversize_g = (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_64OCTETS_FRAMES_GOOD_BAD_LOW, &val);
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_64OCTETS_FRAMES_GOOD_BAD_HIGH, &hi);
+	xgmib_hw_stats->rx_pkt64 = (u64)val | (u64)hi << 32;
+
+	ppe_read(ppe_dev,
+		 PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_65TO127OCTETS_FRAMES_GOOD_BAD_LOW, &val);
+	ppe_read(ppe_dev,
+		 PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_65TO127OCTETS_FRAMES_GOOD_BAD_HIGH, &hi);
+	xgmib_hw_stats->rx_pkt65to127 = (u64)val | (u64)hi << 32;
+
+	ppe_read(ppe_dev,
+		 PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_128TO255OCTETS_FRAMES_GOOD_BAD_LOW, &val);
+	ppe_read(ppe_dev,
+		 PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_128TO255OCTETS_FRAMES_GOOD_BAD_HIGH, &hi);
+	xgmib_hw_stats->rx_pkt128to255 = (u64)val | (u64)hi << 32;
+
+	ppe_read(ppe_dev,
+		 PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_256TO511OCTETS_FRAMES_GOOD_BAD_LOW, &val);
+	ppe_read(ppe_dev,
+		 PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_256TO511OCTETS_FRAMES_GOOD_BAD_HIGH, &hi);
+	xgmib_hw_stats->rx_pkt256to511 = (u64)val | (u64)hi << 32;
+
+	ppe_read(ppe_dev,
+		 PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_512TO1023OCTETS_FRAMES_GOOD_BAD_LOW, &val);
+	ppe_read(ppe_dev,
+		 PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_512TO1023OCTETS_FRAMES_GOOD_BAD_HIGH, &hi);
+	xgmib_hw_stats->rx_pkt512to1023 = (u64)val | (u64)hi << 32;
+
+	ppe_read(ppe_dev,
+		 PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_1024TOMAXOCTETS_FRAMES_GOOD_BAD_LOW, &val);
+	ppe_read(ppe_dev,
+		 PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_1024TOMAXOCTETS_FRAMES_GOOD_BAD_HIGH, &hi);
+	xgmib_hw_stats->rx_pkt1024tomax = (u64)val | (u64)hi << 32;
+
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_UNICAST_FRAMES_GOOD_LOW, &val);
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_UNICAST_FRAMES_GOOD_HIGH, &hi);
+	xgmib_hw_stats->rx_unicast_g = (u64)val | (u64)hi << 32;
+
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_LENGTH_ERROR_FRAMES_LOW, &val);
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_LENGTH_ERROR_FRAMES_HIGH, &hi);
+	xgmib_hw_stats->rx_len_err = (u64)val | (u64)hi << 32;
+
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_OUTOFRANGE_FRAMES_LOW, &val);
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_OUTOFRANGE_FRAMES_HIGH, &hi);
+	xgmib_hw_stats->rx_outofrange_err = (u64)val | (u64)hi << 32;
+
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_PAUSE_FRAMES_LOW, &val);
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_PAUSE_FRAMES_HIGH, &hi);
+	xgmib_hw_stats->rx_pause = (u64)val | (u64)hi << 32;
+
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_FIFOOVERFLOW_FRAMES_LOW, &val);
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_FIFOOVERFLOW_FRAMES_HIGH, &hi);
+	xgmib_hw_stats->rx_fifo_overflow = (u64)val | (u64)hi << 32;
+
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_VLAN_FRAMES_GOOD_BAD_LOW, &val);
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_VLAN_FRAMES_GOOD_BAD_HIGH, &hi);
+	xgmib_hw_stats->rx_vlan = (u64)val | (u64)hi << 32;
+
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_WATCHDOG_ERROR_FRAMES, &val);
+	xgmib_hw_stats->rx_wdog_err = (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_LPI_USEC_CNTR, &val);
+	xgmib_hw_stats->rx_lpi_usec = (u64)val;
+
+	ppe_read(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_LPI_TRAN_CNTR, &val);
+	xgmib_hw_stats->rx_lpi_tran = (u64)val;
+
+	ppe_read(ppe_dev,
+		 PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_DISCARD_FRAME_COUNT_GOOD_BAD_LOW, &val);
+	ppe_read(ppe_dev,
+		 PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_DISCARD_FRAME_COUNT_GOOD_BAD_HIGH, &hi);
+	xgmib_hw_stats->rx_drop_frames = (u64)val | (u64)hi << 32;
+
+	ppe_read(ppe_dev,
+		 PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_DISCARD_OCTET_COUNT_GOOD_BAD_LOW, &val);
+	ppe_read(ppe_dev,
+		 PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_DISCARD_OCTET_COUNT_GOOD_BAD_HIGH, &hi);
+	xgmib_hw_stats->rx_drop_bytes = (u64)val | (u64)hi << 32;
+}
+
+static void ppe_gmib_stats_poll(struct work_struct *work)
+{
+	struct ppe_port *ppe_port = container_of(work, struct ppe_port,
+						 gmib_read.work);
+
+	ppe_gmib_stats_update(ppe_port);
+
+	schedule_delayed_work(&ppe_port->gmib_read,
+			      msecs_to_jiffies(PPE_GMIB_STATS_POLL_INTERVAL));
+}
+
 static void ppe_phylink_mac_config(struct ppe_device *ppe_dev, int port,
 				   unsigned int mode, const struct phylink_link_state *state)
 {
@@ -862,6 +1327,9 @@ static void ppe_phylink_mac_link_up(struct ppe_device *ppe_dev, int port,
 	/* Enable ppe bridge port tx mac */
 	ppe_port_bridge_txmac_en_set(ppe_dev, port, true);
 
+	/* Start gmib statistics polling */
+	schedule_delayed_work(&ppe_port->gmib_read, 0);
+
 	dev_info(ppe_dev->dev,
 		 "PPE port %d interface %s link up - %s%s - pause tx %d rx %d\n",
 		 port, phy_modes(interface), phy_speed_to_str(speed),
@@ -886,6 +1354,9 @@ static void ppe_phylink_mac_link_down(struct ppe_device *ppe_dev, int port,
 	/* Disable ppe mac tx */
 	ppe_mac_txmac_en_set(ppe_dev, port, false);
 
+	/* Stop gmib statistics polling */
+	cancel_delayed_work_sync(&ppe_port->gmib_read);
+
 	dev_info(ppe_dev->dev, "PPE port %d interface %s link down\n",
 		 port, phy_modes(interface));
 }
@@ -938,6 +1409,11 @@ static int ppe_mac_init(struct platform_device *pdev)
 		ppe_ports->port[i].speed = SPEED_UNKNOWN;
 		ppe_ports->port[i].duplex = DUPLEX_UNKNOWN;
 		ppe_ports->port[i].pause = MLO_PAUSE_NONE;
+		ppe_ports->port[i].gmib_stats = devm_kzalloc(&pdev->dev,
+							     sizeof(*ppe_ports->port[i].gmib_stats),
+							     GFP_KERNEL);
+		spin_lock_init(&ppe_ports->port[i].stats_lock);
+		INIT_DELAYED_WORK(&ppe_ports->port[i].gmib_read, ppe_gmib_stats_poll);
 		i++;
 
 		/* Port gmac HW initialization */
@@ -1180,6 +1656,218 @@ static void ppe_phylink_destroy(struct ppe_device *ppe_dev, int port)
 	}
 }
 
+static int ppe_get_sset_count(struct ppe_device *ppe_dev, int port, int sset)
+{
+	struct ppe_port *ppe_port = ppe_port_get(ppe_dev, port);
+
+	if (!ppe_port) {
+		dev_err(ppe_dev->dev, "Failed to find ppe port %d\n", port);
+		return -ENODEV;
+	}
+
+	if (sset != ETH_SS_STATS)
+		return 0;
+
+	if (ppe_port->mac_type == PPE_MAC_TYPE_XGMAC)
+		return ARRAY_SIZE(ppe_ethtool_gstrings_xgmib_stats);
+	else
+		return ARRAY_SIZE(ppe_ethtool_gstrings_gmib_stats);
+}
+
+static void ppe_get_strings(struct ppe_device *ppe_dev, int port, u32 stringset, u8 *data)
+{
+	struct ppe_port *ppe_port = ppe_port_get(ppe_dev, port);
+	int i;
+
+	if (!ppe_port)
+		dev_err(ppe_dev->dev, "Failed to find ppe port %d\n", port);
+
+	if (stringset != ETH_SS_STATS)
+		return;
+
+	if (ppe_port->mac_type == PPE_MAC_TYPE_XGMAC) {
+		for (i = 0; i < ARRAY_SIZE(ppe_ethtool_gstrings_xgmib_stats); i++)
+			memcpy(data + i * ETH_GSTRING_LEN,
+			       ppe_ethtool_gstrings_xgmib_stats[i].name, ETH_GSTRING_LEN);
+	} else {
+		for (i = 0; i < ARRAY_SIZE(ppe_ethtool_gstrings_gmib_stats); i++)
+			memcpy(data + i * ETH_GSTRING_LEN,
+			       ppe_ethtool_gstrings_gmib_stats[i].name, ETH_GSTRING_LEN);
+	}
+}
+
+static void ppe_get_ethtool_stats(struct ppe_device *ppe_dev, int port, u64 *data)
+{
+	struct ppe_port *ppe_port = ppe_port_get(ppe_dev, port);
+	u64 *data_src;
+	int i;
+
+	if (!ppe_port)
+		dev_err(ppe_dev->dev, "Failed to find ppe port %d\n", port);
+
+	if (ppe_port->mac_type == PPE_MAC_TYPE_XGMAC) {
+		struct ppe_xgmib_hw_stats xgmib_hw_stats;
+
+		ppe_xgmib_stats_update(ppe_dev, port, &xgmib_hw_stats);
+		data_src = (u64 *)(&xgmib_hw_stats);
+		for (i = 0; i < ARRAY_SIZE(ppe_ethtool_gstrings_xgmib_stats); i++)
+			data[i] = *(data_src + ppe_ethtool_gstrings_xgmib_stats[i].offset);
+	} else {
+		ppe_gmib_stats_update(ppe_port);
+		data_src = (u64 *)(ppe_port->gmib_stats);
+		for (i = 0; i < ARRAY_SIZE(ppe_ethtool_gstrings_gmib_stats); i++)
+			data[i] = *(data_src + ppe_ethtool_gstrings_gmib_stats[i].offset);
+	}
+}
+
+static void ppe_get_stats64(struct ppe_device *ppe_dev, int port, struct rtnl_link_stats64 *s)
+{
+	struct ppe_port *ppe_port = ppe_port_get(ppe_dev, port);
+
+	if (!ppe_port)
+		dev_err(ppe_dev->dev, "Failed to find ppe port %d\n", port);
+
+	if (ppe_port->mac_type == PPE_MAC_TYPE_XGMAC) {
+		struct ppe_xgmib_hw_stats xgmib_hw_stats;
+
+		ppe_xgmib_stats_update(ppe_dev, port, &xgmib_hw_stats);
+		s->rx_packets = xgmib_hw_stats.rx_unicast_g +
+			xgmib_hw_stats.rx_broadcast_g + xgmib_hw_stats.rx_multicast_g;
+		s->tx_packets = xgmib_hw_stats.tx_unicast +
+			xgmib_hw_stats.tx_broadcast_g + xgmib_hw_stats.tx_multicast_g;
+		s->rx_bytes = xgmib_hw_stats.rx_bytes;
+		s->tx_bytes = xgmib_hw_stats.tx_bytes;
+		s->multicast = xgmib_hw_stats.rx_multicast_g;
+
+		s->rx_crc_errors = xgmib_hw_stats.rx_crc_err;
+		s->rx_frame_errors = xgmib_hw_stats.rx_runt_err;
+		s->rx_fifo_errors = xgmib_hw_stats.rx_fifo_overflow;
+		s->rx_length_errors = xgmib_hw_stats.rx_len_err;
+		s->rx_errors = s->rx_crc_errors + s->rx_frame_errors +
+			s->rx_fifo_errors + s->rx_length_errors;
+		s->rx_dropped = xgmib_hw_stats.rx_drop_frames + s->rx_errors;
+
+		s->tx_fifo_errors = xgmib_hw_stats.tx_underflow_err;
+		s->tx_errors = s->tx_fifo_errors;
+	} else {
+		ppe_gmib_stats_update(ppe_port);
+		s->rx_packets = ppe_port->gmib_stats->rx_unicast +
+			ppe_port->gmib_stats->rx_broadcast + ppe_port->gmib_stats->rx_multicast;
+		s->tx_packets = ppe_port->gmib_stats->tx_unicast +
+			ppe_port->gmib_stats->tx_broadcast + ppe_port->gmib_stats->tx_multicast;
+		s->rx_bytes = ppe_port->gmib_stats->rx_pktgoodbyte;
+		s->tx_bytes = ppe_port->gmib_stats->tx_pktbyte;
+
+		s->rx_crc_errors = ppe_port->gmib_stats->rx_fcserr +
+			ppe_port->gmib_stats->rx_jmbfcserr;
+		s->rx_frame_errors = ppe_port->gmib_stats->rx_alignerr +
+			ppe_port->gmib_stats->rx_jmbalignerr;
+		s->rx_fifo_errors = ppe_port->gmib_stats->rx_runt;
+		s->rx_errors = s->rx_crc_errors + s->rx_frame_errors + s->rx_fifo_errors;
+		s->rx_dropped = ppe_port->gmib_stats->rx_toolong + s->rx_errors;
+
+		s->tx_fifo_errors = ppe_port->gmib_stats->tx_underrun;
+		s->tx_aborted_errors = ppe_port->gmib_stats->tx_abortcol;
+		s->tx_errors = s->tx_fifo_errors + s->tx_aborted_errors;
+		s->collisions = ppe_port->gmib_stats->tx_collisions;
+		s->multicast = ppe_port->gmib_stats->rx_multicast;
+	}
+}
+
+static int ppe_set_mac_address(struct ppe_device *ppe_dev, int port, u8 *macaddr)
+{
+	u32 reg_val;
+	struct ppe_port *ppe_port = ppe_port_get(ppe_dev, port);
+
+	if (!ppe_port) {
+		dev_err(ppe_dev->dev, "Failed to find ppe port %d\n", port);
+		return -ENODEV;
+	}
+
+	if (ppe_port->mac_type == PPE_MAC_TYPE_XGMAC) {
+		reg_val = (macaddr[5] << 8) | macaddr[4] | XGMAC_ADDR_EN;
+		ppe_write(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_MAC_ADDR0_HIGH, reg_val);
+		reg_val = (macaddr[3] << 24) | (macaddr[2] << 16) | (macaddr[1] << 8) | macaddr[0];
+		ppe_write(ppe_dev, PPE_PORT_XGMAC_ADDR(port) + XGMAC_MAC_ADDR0_LOW, reg_val);
+	} else {
+		reg_val = (macaddr[5] << 8) | macaddr[4];
+		ppe_write(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_GOL_MAC_ADDR0, reg_val);
+		reg_val = (macaddr[0] << 24) | (macaddr[1] << 16) | (macaddr[2] << 8) | macaddr[3];
+		ppe_write(ppe_dev, PPE_PORT_GMAC_ADDR(port) + GMAC_GOL_MAC_ADDR1, reg_val);
+	}
+
+	return 0;
+}
+
+static int ppe_set_mac_eee(struct ppe_device *ppe_dev, int port, struct ethtool_eee *eee)
+{
+	struct ppe_port *ppe_port = ppe_port_get(ppe_dev, port);
+	u32 reg_val;
+
+	if (!ppe_port) {
+		dev_err(ppe_dev->dev, "Failed to find ppe port %d\n", port);
+		return -ENODEV;
+	}
+
+	if (ppe_port->mac_type == PPE_MAC_TYPE_XGMAC) {
+		ppe_read(ppe_dev,
+			 PPE_PORT_XGMAC_ADDR(port) + XGMAC_LPI_CONTROL_STATUS,
+			 &reg_val);
+		reg_val |= (XGMAC_LPI_PLS | XGMAC_LPI_TXA | XGMAC_LPI_TE);
+		if (eee->tx_lpi_enabled)
+			reg_val |= XGMAC_LPI_TXEN;
+		else
+			reg_val &= ~XGMAC_LPI_TXEN;
+		ppe_write(ppe_dev,
+			  PPE_PORT_XGMAC_ADDR(port) + XGMAC_LPI_CONTROL_STATUS,
+			  reg_val);
+		ppe_mask(ppe_dev,
+			 PPE_PORT_XGMAC_ADDR(port) + XGMAC_1US_TIC_COUNTER,
+			 XGMAC_1US_TIC_CNTR, FIELD_PREP(XGMAC_1US_TIC_CNTR, 0x15f));
+		ppe_mask(ppe_dev,
+			 PPE_PORT_XGMAC_ADDR(port) + XGMAC_LPI_AUTO_ENTRY_TIMER,
+			 XGMAC_LPI_ET, FIELD_PREP(XGMAC_LPI_ET, 0x2c));
+	} else {
+		ppe_read(ppe_dev, PPE_LPI_LPI_EN, &reg_val);
+		if (eee->tx_lpi_enabled)
+			reg_val |= PPE_LPI_PORT_EN(port);
+		else
+			reg_val &= ~PPE_LPI_PORT_EN(port);
+		ppe_write(ppe_dev, PPE_LPI_LPI_EN, reg_val);
+	}
+
+	return 0;
+}
+
+static int ppe_get_mac_eee(struct ppe_device *ppe_dev, int port, struct ethtool_eee *eee)
+{
+	struct ppe_port *ppe_port = ppe_port_get(ppe_dev, port);
+	u32 reg_val;
+
+	if (!ppe_port) {
+		dev_err(ppe_dev->dev, "Failed to find ppe port %d\n", port);
+		return -ENODEV;
+	}
+
+	if (ppe_port->mac_type == PPE_MAC_TYPE_XGMAC) {
+		ppe_read(ppe_dev,
+			 PPE_PORT_XGMAC_ADDR(port) + XGMAC_LPI_CONTROL_STATUS,
+			 &reg_val);
+		if (reg_val & XGMAC_LPI_TXEN)
+			eee->tx_lpi_enabled = 1;
+		else
+			eee->tx_lpi_enabled = 0;
+	} else {
+		ppe_read(ppe_dev, PPE_LPI_LPI_EN, &reg_val);
+		if (reg_val & PPE_LPI_PORT_EN(port))
+			eee->tx_lpi_enabled = 1;
+		else
+			eee->tx_lpi_enabled = 0;
+	}
+
+	return 0;
+}
+
 bool ppe_is_probed(struct platform_device *pdev)
 {
 	struct ppe_device *ppe_dev = platform_get_drvdata(pdev);
@@ -1236,6 +1924,13 @@ static struct ppe_device_ops qcom_ppe_ops = {
 	.phylink_mac_link_up = ppe_phylink_mac_link_up,
 	.phylink_mac_link_down = ppe_phylink_mac_link_down,
 	.phylink_mac_select_pcs = ppe_phylink_mac_select_pcs,
+	.get_sset_count = ppe_get_sset_count,
+	.get_strings = ppe_get_strings,
+	.get_ethtool_stats = ppe_get_ethtool_stats,
+	.get_stats64 = ppe_get_stats64,
+	.set_mac_address = ppe_set_mac_address,
+	.set_mac_eee = ppe_set_mac_eee,
+	.get_mac_eee = ppe_get_mac_eee,
 	.set_maxframe = ppe_port_maxframe_set,
 };
 
@@ -2340,6 +3035,9 @@ static int qcom_ppe_remove(struct platform_device *pdev)
 	ppe_debugfs_teardown(ppe_dev);
 
 	for (i = 0; i < ppe_ports->num; i++) {
+		/* Stop gmib statistics polling */
+		cancel_delayed_work_sync(&ppe_ports->port[i].gmib_read);
+
 		/* Reset ppe port parent clock to XO clock */
 		port = ppe_ports->port[i].port_id;
 		clk_set_rate(ppe_dev_priv->clk[PPE_NSS_PORT1_RX_CLK + ((port - 1) << 1)],
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.h b/drivers/net/ethernet/qualcomm/ppe/ppe.h
index 532d53c05bf9..5c43d7c19d98 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe.h
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe.h
@@ -183,6 +183,101 @@ struct ppe_scheduler_port_resource {
 	int l1edrr[2];
 };
 
+/* PPE GMAC statistics */
+struct ppe_gmib_hw_stats {
+	u64 rx_broadcast;
+	u64 rx_pause;
+	u64 rx_multicast;
+	u64 rx_fcserr;
+	u64 rx_alignerr;
+	u64 rx_runt;
+	u64 rx_frag;
+	u64 rx_jmbfcserr;
+	u64 rx_jmbalignerr;
+	u64 rx_pkt64;
+	u64 rx_pkt65to127;
+	u64 rx_pkt128to255;
+	u64 rx_pkt256to511;
+	u64 rx_pkt512to1023;
+	u64 rx_pkt1024to1518;
+	u64 rx_pkt1519tomax;
+	u64 rx_toolong;
+	u64 rx_pktgoodbyte;
+	u64 rx_pktbadbyte;
+	u64 rx_unicast;
+	u64 tx_broadcast;
+	u64 tx_pause;
+	u64 tx_multicast;
+	u64 tx_underrun;
+	u64 tx_pkt64;
+	u64 tx_pkt65to127;
+	u64 tx_pkt128to255;
+	u64 tx_pkt256to511;
+	u64 tx_pkt512to1023;
+	u64 tx_pkt1024to1518;
+	u64 tx_pkt1519tomax;
+	u64 tx_pktbyte;
+	u64 tx_collisions;
+	u64 tx_abortcol;
+	u64 tx_multicol;
+	u64 tx_singlecol;
+	u64 tx_exesdeffer;
+	u64 tx_deffer;
+	u64 tx_latecol;
+	u64 tx_unicast;
+};
+
+/* PPE XGMAC statistics */
+struct ppe_xgmib_hw_stats {
+	u64 tx_bytes;
+	u64 tx_frames;
+	u64 tx_broadcast_g;
+	u64 tx_multicast_g;
+	u64 tx_pkt64;
+	u64 tx_pkt65to127;
+	u64 tx_pkt128to255;
+	u64 tx_pkt256to511;
+	u64 tx_pkt512to1023;
+	u64 tx_pkt1024tomax;
+	u64 tx_unicast;
+	u64 tx_multicast;
+	u64 tx_broadcast;
+	u64 tx_underflow_err;
+	u64 tx_bytes_g;
+	u64 tx_frame_g;
+	u64 tx_pause;
+	u64 tx_vlan_g;
+	u64 tx_lpi_usec;
+	u64 tx_lpi_tran;
+	u64 rx_frames;
+	u64 rx_bytes;
+	u64 rx_bytes_g;
+	u64 rx_broadcast_g;
+	u64 rx_multicast_g;
+	u64 rx_crc_err;
+	u64 rx_runt_err;
+	u64 rx_jabber_err;
+	u64 rx_undersize_g;
+	u64 rx_oversize_g;
+	u64 rx_pkt64;
+	u64 rx_pkt65to127;
+	u64 rx_pkt128to255;
+	u64 rx_pkt256to511;
+	u64 rx_pkt512to1023;
+	u64 rx_pkt1024tomax;
+	u64 rx_unicast_g;
+	u64 rx_len_err;
+	u64 rx_outofrange_err;
+	u64 rx_pause;
+	u64 rx_fifo_overflow;
+	u64 rx_vlan;
+	u64 rx_wdog_err;
+	u64 rx_lpi_usec;
+	u64 rx_lpi_tran;
+	u64 rx_drop_frames;
+	u64 rx_drop_bytes;
+};
+
 /* PPE per port data type to record port settings such as phylink
  * setting, mac type, interface mode and link speed.
  */
@@ -197,6 +292,9 @@ struct ppe_port {
 	int speed;
 	int duplex;
 	int pause;
+	struct delayed_work gmib_read;
+	struct ppe_gmib_hw_stats *gmib_stats;
+	spinlock_t stats_lock; /* Protects gmib stats */
 };
 
 /* PPE ports data type */
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
index 43cd067c8c73..242ed494bcfc 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
@@ -17,6 +17,15 @@
 #define PPE_PORT5_PCS_SEL					BIT(4)
 #define PPE_PORT_MAC_SEL(x)					(PPE_PORT1_MAC_SEL << ((x) - 1))
 
+#define PPE_LPI_LPI_EN						0x400
+#define PPE_LPI_PORT1_EN					BIT(0)
+#define PPE_LPI_PORT2_EN					BIT(1)
+#define PPE_LPI_PORT3_EN					BIT(2)
+#define PPE_LPI_PORT4_EN					BIT(3)
+#define PPE_LPI_PORT5_EN					BIT(4)
+#define PPE_LPI_PORT6_EN					BIT(5)
+#define PPE_LPI_PORT_EN(x)					(PPE_LPI_PORT1_EN << ((x) - 1))
+
 #define PPE_BM_TDM_CTRL						0xb000
 #define PPE_BM_TDM_CTRL_NUM					1
 #define PPE_BM_TDM_CTRL_INC					4
@@ -848,6 +857,16 @@ union ppe_ac_grp_cfg_u {
 #define GMAC_SPEED_100						1
 #define GMAC_SPEED_1000						2
 
+#define GMAC_GOL_MAC_ADDR0					0x8
+#define MAC_ADDR_BYTE5						GENMASK(15, 8)
+#define MAC_ADDR_BYTE4						GENMASK(7, 0)
+
+#define GMAC_GOL_MAC_ADDR1					0xC
+#define MAC_ADDR_BYTE0						GENMASK(31, 24)
+#define MAC_ADDR_BYTE1						GENMASK(23, 16)
+#define MAC_ADDR_BYTE2						GENMASK(15, 8)
+#define MAC_ADDR_BYTE3						GENMASK(7, 0)
+
 #define GMAC_MAC_CTRL2						0x18
 #define GMAC_TX_THD_MASK					GENMASK(27, 24)
 #define GMAC_MAXFR_MASK						GENMASK(21, 8)
@@ -871,6 +890,50 @@ union ppe_ac_grp_cfg_u {
 #define MAC_MIB_RESET						BIT(1)
 #define MAC_MIB_EN						BIT(0)
 
+#define GMAC_RXBROAD						0x40
+#define GMAC_RXPAUSE						0x44
+#define GMAC_RXMULTI						0x48
+#define GMAC_RXFCSERR						0x4C
+#define GMAC_RXALIGNERR						0x50
+#define GMAC_RXRUNT						0x54
+#define GMAC_RXFRAG						0x58
+#define GMAC_RXJUMBOFCSERR					0x5C
+#define GMAC_RXJUMBOALIGNERR					0x60
+#define GMAC_RXPKT64						0x64
+#define GMAC_RXPKT65TO127					0x68
+#define GMAC_RXPKT128TO255					0x6C
+#define GMAC_RXPKT256TO511					0x70
+#define GMAC_RXPKT512TO1023					0x74
+#define GMAC_RXPKT1024TO1518					0x78
+#define GMAC_RXPKT1519TOX					0x7C
+#define GMAC_RXTOOLONG						0x80
+#define GMAC_RXGOODBYTE_L					0x84
+#define GMAC_RXGOODBYTE_H					0x88
+#define GMAC_RXBADBYTE_L					0x8C
+#define GMAC_RXBADBYTE_H					0x90
+#define GMAC_RXUNI						0x94
+#define GMAC_TXBROAD						0xA0
+#define GMAC_TXPAUSE						0xA4
+#define GMAC_TXMULTI						0xA8
+#define GMAC_TXUNDERRUN						0xAC
+#define GMAC_TXPKT64						0xB0
+#define GMAC_TXPKT65TO127					0xB4
+#define GMAC_TXPKT128TO255					0xB8
+#define GMAC_TXPKT256TO511					0xBC
+#define GMAC_TXPKT512TO1023					0xC0
+#define GMAC_TXPKT1024TO1518					0xC4
+#define GMAC_TXPKT1519TOX					0xC8
+#define GMAC_TXBYTE_L						0xCC
+#define GMAC_TXBYTE_H						0xD0
+#define GMAC_TXCOLLISIONS					0xD4
+#define GMAC_TXABORTCOL						0xD8
+#define GMAC_TXMULTICOL						0xDC
+#define GMAC_TXSINGLECOL					0xE0
+#define GMAC_TXEXCESSIVEDEFER					0xE4
+#define GMAC_TXDEFER						0xE8
+#define GMAC_TXLATECOL						0xEC
+#define GMAC_TXUNI						0xF0
+
 /* XGMAC Registers */
 #define XGMAC_TX_CONFIGURATION					0x0
 #define XGMAC_SPEED_MASK					GENMASK(31, 29)
@@ -927,8 +990,117 @@ union ppe_ac_grp_cfg_u {
 #define XGMAC_RX_FLOW_CTRL					0x90
 #define XGMAC_RFE						BIT(0)
 
+#define XGMAC_LPI_CONTROL_STATUS				0xd0
+#define XGMAC_LPI_TXEN						BIT(16)
+#define XGMAC_LPI_PLS						BIT(17)
+#define XGMAC_LPI_TXA						BIT(19)
+#define XGMAC_LPI_TE						BIT(20)
+
+#define XGMAC_LPI_TIMERS_CONTROL				0xd4
+#define XGMAC_LPI_TWT						GENMASK(15, 0)
+#define XGMAC_LPI_LST						GENMASK(25, 16)
+
+#define XGMAC_LPI_AUTO_ENTRY_TIMER				0xd8
+#define XGMAC_LPI_ET						GENMASK(19, 3)
+
+#define XGMAC_1US_TIC_COUNTER					0xdc
+#define XGMAC_1US_TIC_CNTR					GENMASK(11, 0)
+
+#define XGMAC_MAC_ADDR0_HIGH					0x300
+#define XGMAC_ADDR_EN						BIT(31)
+#define XGMAC_ADDRHI						GENMASK(15, 0)
+
+#define XGMAC_MAC_ADDR0_LOW					0x304
+#define XGMAC_ADDRLO						GENMASK(31, 0)
+
 #define XGMAC_MMC_CONTROL					0x800
 #define XGMAC_MCF						BIT(3)
 #define XGMAC_CNTRST						BIT(0)
 
+#define XGMAC_TX_OCTET_COUNT_GOOD_BAD_LOW			0x814
+#define XGMAC_TX_OCTET_COUNT_GOOD_BAD_HIGH			0x818
+#define XGMAC_TX_FRAME_COUNT_GOOD_BAD_LOW			0x81C
+#define XGMAC_TX_FRAME_COUNT_GOOD_BAD_HIGH			0x820
+#define XGMAC_TX_BROADCAST_FRAMES_GOOD_LOW			0x824
+#define XGMAC_TX_BROADCAST_FRAMES_GOOD_HIGH			0x828
+#define XGMAC_TX_MULTICAST_FRAMES_GOOD_LOW			0x82C
+#define XGMAC_TX_MULTICAST_FRAMES_GOOD_HIGH			0x830
+#define XGMAC_TX_64OCTETS_FRAMES_GOOD_BAD_LOW			0x834
+#define XGMAC_TX_64OCTETS_FRAMES_GOOD_BAD_HIGH			0x838
+#define XGMAC_TX_65TO127OCTETS_FRAMES_GOOD_BAD_LOW		0x83C
+#define XGMAC_TX_65TO127OCTETS_FRAMES_GOOD_BAD_HIGH		0x840
+#define XGMAC_TX_128TO255OCTETS_FRAMES_GOOD_BAD_LOW		0x844
+#define XGMAC_TX_128TO255OCTETS_FRAMES_GOOD_BAD_HIGH		0x848
+#define XGMAC_TX_256TO511OCTETS_FRAMES_GOOD_BAD_LOW		0x84C
+#define XGMAC_TX_256TO511OCTETS_FRAMES_GOOD_BAD_HIGH		0x850
+#define XGMAC_TX_512TO1023OCTETS_FRAMES_GOOD_BAD_LOW		0x854
+#define XGMAC_TX_512TO1023OCTETS_FRAMES_GOOD_BAD_HIGH		0x858
+#define XGMAC_TX_1024TOMAXOCTETS_FRAMES_GOOD_BAD_LOW		0x85C
+#define XGMAC_TX_1024TOMAXOCTETS_FRAMES_GOOD_BAD_HIGH		0x860
+#define XGMAC_TX_UNICAST_FRAMES_GOOD_BAD_LOW			0x864
+#define XGMAC_TX_UNICAST_FRAMES_GOOD_BAD_HIGH			0x868
+#define XGMAC_TX_MULTICAST_FRAMES_GOOD_BAD_LOW			0x86C
+#define XGMAC_TX_MULTICAST_FRAMES_GOOD_BAD_HIGH			0x870
+#define XGMAC_TX_BROADCAST_FRAMES_GOOD_BAD_LOW			0x874
+#define XGMAC_TX_BROADCAST_FRAMES_GOOD_BAD_HIGH			0x878
+#define XGMAC_TX_UNDERFLOW_ERROR_FRAMES_LOW			0x87C
+#define XGMAC_TX_UNDERFLOW_ERROR_FRAMES_HIGH			0x880
+#define XGMAC_TX_OCTET_COUNT_GOOD_LOW				0x884
+#define XGMAC_TX_OCTET_COUNT_GOOD_HIGH				0x888
+#define XGMAC_TX_FRAME_COUNT_GOOD_LOW				0x88C
+#define XGMAC_TX_FRAME_COUNT_GOOD_HIGH				0x890
+#define XGMAC_TX_PAUSE_FRAMES_LOW				0x894
+#define XGMAC_TX_PAUSE_FRAMES_HIGH				0x898
+#define XGMAC_TX_VLAN_FRAMES_GOOD_LOW				0x89C
+#define XGMAC_TX_VLAN_FRAMES_GOOD_HIGH				0x8A0
+#define XGMAC_TX_LPI_USEC_CNTR					0x8A4
+#define XGMAC_TX_LPI_TRAN_CNTR					0x8A8
+#define XGMAC_RX_FRAME_COUNT_GOOD_BAD_LOW			0x900
+#define XGMAC_RX_FRAME_COUNT_GOOD_BAD_HIGH			0x904
+#define XGMAC_RX_OCTET_COUNT_GOOD_BAD_LOW			0x908
+#define XGMAC_RX_OCTET_COUNT_GOOD_BAD_HIGH			0x90C
+#define XGMAC_RX_OCTET_COUNT_GOOD_LOW				0x910
+#define XGMAC_RX_OCTET_COUNT_GOOD_HIGH				0x914
+#define XGMAC_RX_BROADCAST_FRAMES_GOOD_LOW			0x918
+#define XGMAC_RX_BROADCAST_FRAMES_GOOD_HIGH			0x91C
+#define XGMAC_RX_MULTICAST_FRAMES_GOOD_LOW			0x920
+#define XGMAC_RX_MULTICAST_FRAMES_GOOD_HIGH			0x924
+#define XGMAC_RX_CRC_ERROR_FRAMES_LOW				0x928
+#define XGMAC_RX_CRC_ERROR_FRAMES_HIGH				0x92C
+#define XGMAC_RX_FRAG_ERROR_FRAMES				0x930
+#define XGMAC_RX_JABBER_ERROR_FRAMES				0x934
+#define XGMAC_RX_UNDERSIZE_FRAMES_GOOD				0x938
+#define XGMAC_RX_OVERSIZE_FRAMES_GOOD				0x93C
+#define XGMAC_RX_64OCTETS_FRAMES_GOOD_BAD_LOW			0x940
+#define XGMAC_RX_64OCTETS_FRAMES_GOOD_BAD_HIGH			0x944
+#define XGMAC_RX_65TO127OCTETS_FRAMES_GOOD_BAD_LOW		0x948
+#define XGMAC_RX_65TO127OCTETS_FRAMES_GOOD_BAD_HIGH		0x94C
+#define XGMAC_RX_128TO255OCTETS_FRAMES_GOOD_BAD_LOW		0x950
+#define XGMAC_RX_128TO255OCTETS_FRAMES_GOOD_BAD_HIGH		0x954
+#define XGMAC_RX_256TO511OCTETS_FRAMES_GOOD_BAD_LOW		0x958
+#define XGMAC_RX_256TO511OCTETS_FRAMES_GOOD_BAD_HIGH		0x95C
+#define XGMAC_RX_512TO1023OCTETS_FRAMES_GOOD_BAD_LOW		0x960
+#define XGMAC_RX_512TO1023OCTETS_FRAMES_GOOD_BAD_HIGH		0x964
+#define XGMAC_RX_1024TOMAXOCTETS_FRAMES_GOOD_BAD_LOW		0x968
+#define XGMAC_RX_1024TOMAXOCTETS_FRAMES_GOOD_BAD_HIGH		0x96C
+#define XGMAC_RX_UNICAST_FRAMES_GOOD_LOW			0x970
+#define XGMAC_RX_UNICAST_FRAMES_GOOD_HIGH			0x974
+#define XGMAC_RX_LENGTH_ERROR_FRAMES_LOW			0x978
+#define XGMAC_RX_LENGTH_ERROR_FRAMES_HIGH			0x97C
+#define XGMAC_RX_OUTOFRANGE_FRAMES_LOW				0x980
+#define XGMAC_RX_OUTOFRANGE_FRAMES_HIGH				0x984
+#define XGMAC_RX_PAUSE_FRAMES_LOW				0x988
+#define XGMAC_RX_PAUSE_FRAMES_HIGH				0x98C
+#define XGMAC_RX_FIFOOVERFLOW_FRAMES_LOW			0x990
+#define XGMAC_RX_FIFOOVERFLOW_FRAMES_HIGH			0x994
+#define XGMAC_RX_VLAN_FRAMES_GOOD_BAD_LOW			0x998
+#define XGMAC_RX_VLAN_FRAMES_GOOD_BAD_HIGH			0x99C
+#define XGMAC_RX_WATCHDOG_ERROR_FRAMES				0x9A0
+#define XGMAC_RX_LPI_USEC_CNTR					0x9A4
+#define XGMAC_RX_LPI_TRAN_CNTR					0x9A8
+#define XGMAC_RX_DISCARD_FRAME_COUNT_GOOD_BAD_LOW		0x9AC
+#define XGMAC_RX_DISCARD_FRAME_COUNT_GOOD_BAD_HIGH		0x9B0
+#define XGMAC_RX_DISCARD_OCTET_COUNT_GOOD_BAD_LOW		0x9B4
+#define XGMAC_RX_DISCARD_OCTET_COUNT_GOOD_BAD_HIGH		0x9B8
+
 #endif
diff --git a/include/linux/soc/qcom/ppe.h b/include/linux/soc/qcom/ppe.h
index 40e69a262650..8f3652675ce3 100644
--- a/include/linux/soc/qcom/ppe.h
+++ b/include/linux/soc/qcom/ppe.h
@@ -10,6 +10,7 @@
 
 #include <linux/platform_device.h>
 #include <linux/phylink.h>
+#include <linux/if_link.h>
 
 /* PPE platform private data, which is used by external driver like
  * Ethernet DMA driver.
@@ -57,6 +58,35 @@ struct ppe_device_ops {
 	struct phylink_pcs *(*phylink_mac_select_pcs)(struct ppe_device *ppe_dev,
 						      int port,
 						      phy_interface_t interface);
+	/*
+	 * Port statistics counters
+	 */
+	void	(*get_stats64)(struct ppe_device *ppe_dev,
+			       int port,
+			       struct rtnl_link_stats64 *s);
+	void	(*get_strings)(struct ppe_device *ppe_dev,
+			       int port,
+			       u32 stringset,
+			       u8 *data);
+	int	(*get_sset_count)(struct ppe_device *ppe_dev,
+				  int port,
+				  int sset);
+	void	(*get_ethtool_stats)(struct ppe_device *ppe_dev,
+				     int port,
+				     u64 *data);
+	/*
+	 * Port MAC address setting
+	 */
+	int	(*set_mac_address)(struct ppe_device *ppe_dev,
+				   int port,
+				   u8 *macaddr);
+	/*
+	 * Port MAC EEE settings
+	 */
+	int	(*set_mac_eee)(struct ppe_device *ppe_dev, int port,
+			       struct ethtool_eee *eee);
+	int	(*get_mac_eee)(struct ppe_device *ppe_dev, int port,
+			       struct ethtool_eee *eee);
 	/*
 	 * Port maximum frame size setting
 	 */
-- 
2.42.0


