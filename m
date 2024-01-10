Return-Path: <linux-kernel+bounces-22125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CADBF8299B2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15AA91F21772
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A20C4CDE1;
	Wed, 10 Jan 2024 11:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="olybZN85"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB7847F63;
	Wed, 10 Jan 2024 11:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40A8eLkC020792;
	Wed, 10 Jan 2024 11:43:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=/dgiYyq5vxUPou7DP/kFT/Rv+s01GrxEpagrJuG98FQ=; b=ol
	ybZN85xQyZjr8JFPxTOjWrXc0NON3FEpeis9Ogxk/6ekJa+1DogK5ztFih/i9/Gz
	MqqQqsJvyZrQnjDZGgj14TQjLksMYBXlJraCYi4RKRKEMkiLXgMjcKGgUthgPx4a
	XhdkG98LMyWypBW/NhiiNwo9DOZC7sxkFldI/UFstbfD/DzKjnurEPTxOKdnbOHu
	0RzgEDeLu21fP/rOrIMhriuLvUP9YPV7z+XRdfmGa21foBVKuxUcMno6BecP8GmC
	xd3tJbbOWx1aD1iUL+vJsjLjWRBiy31OJ5xe0BlNN4GTkzupydcrweJFCi9k1Ttu
	ZQgKjJMVfOyTnBvihVpw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh9evt8wy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:43:38 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40ABhbiV020379
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:43:37 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 03:43:26 -0800
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
Subject: [PATCH net-next 15/20] net: ethernet: qualcomm: Add PPE debugfs counters
Date: Wed, 10 Jan 2024 19:40:27 +0800
Message-ID: <20240110114033.32575-16-quic_luoj@quicinc.com>
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
X-Proofpoint-GUID: xDhMHNgXx0Ucdc1-NaxYH2Befo0bPjYP
X-Proofpoint-ORIG-GUID: xDhMHNgXx0Ucdc1-NaxYH2Befo0bPjYP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100096

The PPE counter is checked with the command below.
"cat /sys/kernel/debug/ppe/packet_counter"

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/ethernet/qualcomm/ppe/Makefile    |   2 +-
 drivers/net/ethernet/qualcomm/ppe/ppe.c       |   8 +
 .../net/ethernet/qualcomm/ppe/ppe_debugfs.c   | 953 ++++++++++++++++++
 .../net/ethernet/qualcomm/ppe/ppe_debugfs.h   |  25 +
 drivers/net/ethernet/qualcomm/ppe/ppe_regs.h  | 256 +++++
 include/linux/soc/qcom/ppe.h                  |   1 +
 6 files changed, 1244 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/qualcomm/ppe/ppe_debugfs.c
 create mode 100644 drivers/net/ethernet/qualcomm/ppe/ppe_debugfs.h

diff --git a/drivers/net/ethernet/qualcomm/ppe/Makefile b/drivers/net/ethernet/qualcomm/ppe/Makefile
index c00265339aa7..516ea23443ab 100644
--- a/drivers/net/ethernet/qualcomm/ppe/Makefile
+++ b/drivers/net/ethernet/qualcomm/ppe/Makefile
@@ -4,4 +4,4 @@
 #
 
 obj-$(CONFIG_QCOM_PPE) += qcom-ppe.o
-qcom-ppe-objs := ppe.o ppe_ops.o
+qcom-ppe-objs := ppe.o ppe_ops.o ppe_debugfs.o
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.c b/drivers/net/ethernet/qualcomm/ppe/ppe.c
index d0e0fa9d5609..71973bce2cd2 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe.c
@@ -17,6 +17,7 @@
 #include "ppe.h"
 #include "ppe_regs.h"
 #include "ppe_ops.h"
+#include "ppe_debugfs.h"
 
 #define PPE_SCHEDULER_PORT_NUM		8
 #define MPPE_SCHEDULER_PORT_NUM		3
@@ -1328,11 +1329,18 @@ static int qcom_ppe_probe(struct platform_device *pdev)
 
 	ppe_dev->ppe_ops = &qcom_ppe_ops;
 	ppe_dev->is_ppe_probed = true;
+	ppe_debugfs_setup(ppe_dev);
+
 	return 0;
 }
 
 static int qcom_ppe_remove(struct platform_device *pdev)
 {
+	struct ppe_device *ppe_dev;
+
+	ppe_dev = platform_get_drvdata(pdev);
+	ppe_debugfs_teardown(ppe_dev);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_debugfs.c b/drivers/net/ethernet/qualcomm/ppe/ppe_debugfs.c
new file mode 100644
index 000000000000..a72c0eed9142
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_debugfs.c
@@ -0,0 +1,953 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/* PPE debugfs routines for display of PPE counters useful for debug. */
+
+#include <linux/seq_file.h>
+#include <linux/debugfs.h>
+#include <linux/soc/qcom/ppe.h>
+#include "ppe_debugfs.h"
+#include "ppe_regs.h"
+#include "ppe.h"
+
+static const char * const ppe_cpucode[] = {
+	"Forwarding to CPU",
+	"Unknown L2 protocol exception redirect/copy to CPU",
+	"PPPoE wrong version or wrong type exception redirect/copy to CPU",
+	"PPPoE wrong code exception redirect/copy to CPU",
+	"PPPoE unsupported PPP protocol exception redirect/copy to CPU",
+	"IPv4 wrong version exception redirect/copy to CPU",
+	"IPv4 small IHL exception redirect/copy to CPU",
+	"IPv4 with option exception redirect/copy to CPU",
+	"IPv4 header incomplete exception redirect/copy to CPU",
+	"IPv4 bad total length exception redirect/copy to CPU",
+	"IPv4 data incomplete exception redirect/copy to CPU",
+	"IPv4 fragment exception redirect/copy to CPU",
+	"IPv4 ping of death exception redirect/copy to CPU",
+	"IPv4 small TTL exception redirect/copy to CPU",
+	"IPv4 unknown IP protocol exception redirect/copy to CPU",
+	"IPv4 checksum error exception redirect/copy to CPU",
+	"IPv4 invalid SIP exception redirect/copy to CPU",
+	"IPv4 invalid DIP exception redirect/copy to CPU",
+	"IPv4 LAND attack exception redirect/copy to CPU",
+	"IPv4 AH header incomplete exception redirect/copy to CPU",
+	"IPv4 AH header cross 128-byte exception redirect/copy to CPU",
+	"IPv4 ESP header incomplete exception redirect/copy to CPU",
+	"IPv6 wrong version exception redirect/copy to CPU",
+	"IPv6 header incomplete exception redirect/copy to CPU",
+	"IPv6 bad total length exception redirect/copy to CPU",
+	"IPv6 data incomplete exception redirect/copy to CPU",
+	"IPv6 with extension header exception redirect/copy to CPU",
+	"IPv6 small hop limit exception redirect/copy to CPU",
+	"IPv6 invalid SIP exception redirect/copy to CPU",
+	"IPv6 invalid DIP exception redirect/copy to CPU",
+	"IPv6 LAND attack exception redirect/copy to CPU",
+	"IPv6 fragment exception redirect/copy to CPU",
+	"IPv6 ping of death exception redirect/copy to CPU",
+	"IPv6 with more than 2 extension headers exception redirect/copy to CPU",
+	"IPv6 unknown last next header exception redirect/copy to CPU",
+	"IPv6 mobility header incomplete exception redirect/copy to CPU",
+	"IPv6 mobility header cross 128-byte exception redirect/copy to CPU",
+	"IPv6 AH header incomplete exception redirect/copy to CPU",
+	"IPv6 AH header cross 128-byte exception redirect/copy to CPU",
+	"IPv6 ESP header incomplete exception redirect/copy to CPU",
+	"IPv6 ESP header cross 128-byte exception redirect/copy to CPU",
+	"IPv6 other extension header incomplete exception redirect/copy to CPU",
+	"IPv6 other extension header cross 128-byte exception redirect/copy to CPU",
+	"TCP header incomplete exception redirect/copy to CPU",
+	"TCP header cross 128-byte exception redirect/copy to CPU",
+	"TCP same SP and DP exception redirect/copy to CPU",
+	"TCP small data offset redirect/copy to CPU",
+	"TCP flags VALUE/MASK group 0 exception redirect/copy to CPU",
+	"TCP flags VALUE/MASK group 1 exception redirect/copy to CPU",
+	"TCP flags VALUE/MASK group 2 exception redirect/copy to CPU",
+	"TCP flags VALUE/MASK group 3 exception redirect/copy to CPU",
+	"TCP flags VALUE/MASK group 4 exception redirect/copy to CPU",
+	"TCP flags VALUE/MASK group 5 exception redirect/copy to CPU",
+	"TCP flags VALUE/MASK group 6 exception redirect/copy to CPU",
+	"TCP flags VALUE/MASK group 7 exception redirect/copy to CPU",
+	"TCP checksum error exception redirect/copy to CPU",
+	"UDP header incomplete exception redirect/copy to CPU",
+	"UDP header cross 128-byte exception redirect/copy to CPU",
+	"UDP same SP and DP exception redirect/copy to CPU",
+	"UDP bad length exception redirect/copy to CPU",
+	"UDP data incomplete exception redirect/copy to CPU",
+	"UDP checksum error exception redirect/copy to CPU",
+	"UDP-Lite header incomplete exception redirect/copy to CPU",
+	"UDP-Lite header cross 128-byte exception redirect/copy to CPU",
+	"UDP-Lite same SP and DP exception redirect/copy to CPU",
+	"UDP-Lite checksum coverage value 0-7 exception redirect/copy to CPU",
+	"UDP-Lite checksum coverage value too big exception redirect/copy to CPU",
+	"UDP-Lite checksum coverage value cross 128-byte exception redirect/copy to CPU",
+	"UDP-Lite checksum error exception redirect/copy to CPU",
+	"Fake L2 protocol packet redirect/copy to CPU",
+	"Fake MAC header packet redirect/copy to CPU",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"L2 MRU checking fail redirect/copy to CPU",
+	"L2 MTU checking fail redirect/copy to CPU",
+	"IP prefix broadcast redirect/copy to CPU",
+	"L3 MTU checking fail redirect/copy to CPU",
+	"L3 MRU checking fail redirect/copy to CPU",
+	"ICMP redirect/copy to CPU",
+	"IP to me routing TTL 1 redirect/copy to CPU",
+	"IP to me routing TTL 0 redirect/copy to CPU",
+	"Flow service code loop redirect/copy to CPU",
+	"Flow de-accelerate redirect/copy to CPU",
+	"Flow source interface check fail redirect/copy to CPU",
+	"Flow sync toggle mismatch redirect/copy to CPU",
+	"MTU check fail if DF set redirect/copy to CPU",
+	"PPPoE multicast redirect/copy to CPU",
+	"Flow MTU check fail redirect/copy to cpu",
+	"Flow MTU DF check fail redirect/copy to CPU",
+	"UDP CHECKSUM ZERO redirect/copy to CPU",
+	"Reserved",
+	"EAPoL packet redirect/copy to CPU",
+	"PPPoE discovery packet redirect/copy to CPU",
+	"IGMP packet redirect/copy to CPU",
+	"ARP request packet redirect/copy to CPU",
+	"ARP reply packet redirect/copy to CPU",
+	"DHCPv4 packet redirect/copy to CPU",
+	"Reserved",
+	"LINKOAM packet redirect/copy to CPU",
+	"Reserved",
+	"Reserved",
+	"MLD packet redirect/copy to CPU",
+	"NS packet redirect/copy to CPU",
+	"NA packet redirect/copy to CPU",
+	"DHCPv6 packet redirect/copy to CPU",
+	"Reserved",
+	"Reserved",
+	"PTP sync packet redirect/copy to CPU",
+	"PTP follow up packet redirect/copy to CPU",
+	"PTP delay request packet redirect/copy to CPU",
+	"PTP delay response packet redirect/copy to CPU",
+	"PTP delay request packet redirect/copy to CPU",
+	"PTP delay response packet redirect/copy to CPU",
+	"PTP delay response follow up packet redirect/copy to CPU",
+	"PTP announce packet redirect/copy to CPU",
+	"PTP management packet redirect/copy to CPU",
+	"PTP signaling packet redirect/copy to CPU",
+	"PTP message reserved type 0 packet redirect/copy to CPU",
+	"PTP message reserved type 1 packet redirect/copy to CPU",
+	"PTP message reserved type 2 packet redirect/copy to CPU",
+	"PTP message reserved type 3 packet redirect/copy to CPU",
+	"PTP message reserved type packet redirect/copy to CPU",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"IPv4 source guard unknown packet redirect/copy to CPU",
+	"IPv6 source guard unknown packet redirect/copy to CPU",
+	"ARP source guard unknown packet redirect/copy to CPU",
+	"ND source guard unknown packet redirect/copy to CPU",
+	"IPv4 source guard violation packet redirect/copy to CPU",
+	"IPv6 source guard violation packet redirect/copy to CPU",
+	"ARP source guard violation packet redirect/copy to CPU",
+	"ND source guard violation packet redirect/copy to CPU",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"L3 route host mismatch action redirect/copy to CPU",
+	"L3 flow SNAT action redirect/copy to CPU",
+	"L3 flow DNAT action redirect/copy to CPU",
+	"L3 flow routing action redirect/copy to CPU",
+	"L3 flow bridging action redirect/copy to CPU",
+	"L3 multicast bridging action redirect/copy to CPU",
+	"L3 route preheader routing action redirect/copy to CPU",
+	"L3 route preheader SNAPT action redirect/copy to CPU",
+	"L3 route preheader DNAPT action redirect/copy to CPU",
+	"L3 route preheader SNAT action redirect/copy to CPU",
+	"L3 route preheader DNAT action redirect/copy to CPU",
+	"L3 no route preheader NAT action redirect/copy to CPU",
+	"L3 no route preheader NAT error redirect/copy to CPU",
+	"L3 route action redirect/copy to CPU",
+	"L3 no route action redirect/copy to CPU",
+	"L3 no route next hop invalid action redirect/copy to CPU",
+	"L3 no route preheader action redirect/copy to CPU",
+	"L3 bridge action redirect/copy to CPU",
+	"L3 flow action redirect/copy to CPU",
+	"L3 flow miss action redirect/copy to CPU",
+	"L2 new MAC address redirect/copy to CPU",
+	"L2 hash violation redirect/copy to CPU",
+	"L2 station move redirect/copy to CPU",
+	"L2 learn limit redirect/copy to CPU",
+	"L2 SA lookup action redirect/copy to CPU",
+	"L2 DA lookup action redirect/copy to CPU",
+	"APP_CTRL action redirect/copy to CPU",
+	"INGRESS_VLAN filter  action redirect/copy to CPU",
+	"INGRSS VLAN translation miss redirect/copy to CPU",
+	"EGREE VLAN filter redirect/copy to CPU",
+	"Pre-IPO action",
+	"Post-IPO action",
+	"Service code action",
+	"L3 route Pre-IPO action redirect/copy to CPU",
+	"L3 route Pre-IPO snapt action redirect/copy to CPU",
+	"L3 route Pre-IPO dnapt action redirect/copy to CPU",
+	"L3 route Pre-IPO snat action redirect/copy to CPU",
+	"L3 route Pre-IPO dnat action redirect/copy to CPU",
+	"Tl L3 if check fail redirect/copy to CPU",
+	"TL vlan check fail redirect/copy to CPU",
+	"TL PPPoE Multicast termination redirect/copy to CPU",
+	"TL de-acceleration redirect/copy to CPU",
+	"TL UDP checksum zero redirect/copy to CPU",
+	"TL TTL exceed redirect/copy to CPU",
+	"TL LPM interface check fail redirect/copy to CPU",
+	"TL LPM vlan check fail redirect/copy to CPU",
+	"TL map src check fail redirect/copy to CPU",
+	"TL map dst check fail redirect/copy to CPU",
+	"TL map UDP checksum zero redirect/copy to CPU",
+	"TL map non TCP/UDP redirect/copy to CPU",
+	"TL forward cmd action redirect/copy to CPU",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"L2 Pre IPO action redirect/copy to CPU",
+	"L2 tunnel context check invalid redirect/copy to CPU",
+	"Reserved",
+	"Reserved",
+	"Tunnel decap ecn redirect/copy to CPU",
+	"Tunnel decap inner packet too short redirect/copy to CPU",
+	"Tunnel VXLAN header exception redirect/copy to CPU",
+	"Tunnel VXLAN-GPE header exception redirect/copy to CPU",
+	"Tunnel GENEVE header exception redirect/copy to CPU",
+	"Tunnel GRE header exception redirect/copy to CPU",
+	"Reserved",
+	"Tunnel decap unknown inner type redirect/copy to CPU",
+	"Tunnel parser VXLAN flag exception redirect/copy to CPU",
+	"Tunnel parser VXLAN-GPE flag exception redirect/copy to CPU",
+	"Tunnel parser GRE flag exception redirect/copy to CPU",
+	"Tunnel parser GENEVE flag exception redirect/copy to CPU",
+	"Tunnel parser PROGRAM0 exception redirect/copy to CPU",
+	"Tunnel parser PROGRAM1 exception redirect/copy to CPU",
+	"Tunnel parser PROGRAM2 exception redirect/copy to CPU",
+	"Tunnel parser PROGRAM3 exception redirect/copy to CPU",
+	"Tunnel parser PROGRAM4 exception redirect/copy to CPU",
+	"Tunnel parser PROGRAM5 exception redirect/copy to CPU",
+	"Trap for flooding",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"Reserved",
+	"Egress mirror to CPU",
+	"Ingress mirror to CPU",
+};
+
+static const char * const ppe_dropcode[] = {
+	"None",
+	"Unknown L2 protocol exception drop",
+	"PPPoE wrong version or wrong type exception drop",
+	"PPPoE unsupported PPP protocol exception  drop",
+	"IPv4 wrong version exception drop",
+	"IPv4 small IHL or header incomplete or data incomplete exception drop",
+	"IPv4 with option exception drop",
+	"IPv4 bad total length exception drop",
+	"IPv4 fragment exception drop",
+	"IPv4 ping of death exception drop",
+	"IPv4 small TTL exception drop",
+	"IPv4 unknown IP protocol exception drop",
+	"IPv4 checksum error exception drop",
+	"IPv4 invalid SIP/DIP exception drop",
+	"IPv4 LAND attack exception drop",
+	"IPv4 AH or ESP header incomplete or AH header cross 128 byte exception drop",
+	"IPv6 wrong version exception drop",
+	"IPv6 header or data incomplete exception drop",
+	"IPv6 bad payload length exception drop",
+	"IPv6 with extension header exception drop",
+	"IPv6 small hop limit exception drop",
+	"IPv6 invalid SIP/DIP exception drop",
+	"IPv6 LAND attack exception drop",
+	"IPv6 fragment exception drop",
+	"IPv6 ping of death exception drop",
+	"IPv6 with more than 2 extension headers or unknown last next header exception drop",
+	"IPv6 AH/ESP/other extension/mobility header incomplete/cross 128 bytes exception drop",
+	"TCP header incomplete or cross 128 byte or small data offset exception drop",
+	"TCP same SP and DP exception drop",
+	"TCP flags VALUE/MASK group 0/1/2/3/4/5/6/7 exception drop",
+	"TCP checksum error exception drop",
+	"UDP header incomplete or cross 128 byte or data incomplete exception drop",
+	"UDP same SP and DP exception drop",
+	"UDP bad length exception drop",
+	"UDP checksum error exception drop",
+	"UDP-Lite header incomplete/same SP and DP/checksum coverage invalid value exception drop",
+	"UDP-Lite checksum error exception drop",
+	"L3 route Pre-IPO action exception drop",
+	"L3 route  Pre-IPO snapt action exception drop",
+	"L3 route Pre-IPO dnapt action exception drop",
+	"L3 route Pre-IPO snat action exception drop",
+	"L3 route Pre-IPO dnat action exception drop",
+	"Tl L3 if check fail exception drop",
+	"TL vlan check fail exception drop",
+	"TL PPPoE Multicast termination exception drop",
+	"TL de-acceleration exception drop",
+	"TL UDP checksum zero exception drop",
+	"TL TTL exceed exception drop",
+	"TL LPM interface check fail exception drop",
+	"TL LPM vlan check fail exception drop",
+	"TL map src check fail exception drop",
+	"TL map dst check fail exception drop",
+	"TL map UDP checksum zero exception drop",
+	"TL map non TCP/UDP exception drop",
+	"L2 Pre IPO action redirect/copy to CPU",
+	"L2 tunnel context check invalid redirect/copy to CPU",
+	"Reserved",
+	"Reserved",
+	"Tunnel decap ecn exception drop",
+	"Tunnel decap inner packet too short exception drop",
+	"Tunnel VXLAN header exception drop",
+	"Tunnel VXLAN-GPE header exception drop",
+	"Tunnel GENEVE header exception drop",
+	"Tunnel GRE header exception drop",
+	"Reserved",
+	"Tunnel decap unknown inner type exception drop",
+	"Tunnel parser VXLAN, VXLAN-GPE, GRE or GENEVE flag exception drop",
+	"Tunnel parser PROGRAM0~ PROGRAM5 exception drop",
+	"TL forward cmd action exception drop",
+	"L3 multicast bridging action",
+	"L3 no route with preheader NAT action",
+	"L3 no route with preheader NAT action error configuration",
+	"L3 route action drop",
+	"L3 no route action drop",
+	"L3 no route next hop invalid action drop",
+	"L3 no route preheader action drop",
+	"L3 bridge action drop",
+	"L3 flow action drop",
+	"L3 flow miss action drop",
+	"L2 MRU checking fail drop",
+	"L2 MTU checking fail drop",
+	"L3 IP prefix broadcast drop",
+	"L3 MTU checking fail drop",
+	"L3 MRU checking fail drop",
+	"L3 ICMP redirect drop",
+	"Fake MAC header indicated packet not routing or bypass L3 edit drop",
+	"L3 IP route TTL zero drop",
+	"L3 flow service code loop drop",
+	"L3 flow de-accelerate drop",
+	"L3 flow source interface check fail drop",
+	"Flow toggle mismatch exception drop",
+	"MTU check exception if DF set drop",
+	"PPPoE multicast packet with IP routing enabled drop",
+	"IPv4 SG unknown drop",
+	"IPv6 SG unknown drop",
+	"ARP SG unknown drop",
+	"ND SG unknown drop",
+	"IPv4 SG violation drop",
+	"IPv6 SG violation drop",
+	"ARP SG violation drop",
+	"ND SG violation drop",
+	"L2 new MAC address drop",
+	"L2 hash violation drop",
+	"L2 station move drop",
+	"L2 learn limit drop",
+	"L2 SA lookup action drop",
+	"L2 DA lookup action drop",
+	"APP_CTRL action drop",
+	"Ingress VLAN filtering action drop",
+	"Ingress VLAN translation miss drop",
+	"Egress VLAN filtering drop",
+	"Pre-IPO entry hit action drop",
+	"Post-IPO entry hit action drop",
+	"Multicast SA or broadcast SA drop",
+	"No destination drop",
+	"STG ingress filtering drop",
+	"STG egress filtering drop",
+	"Source port filter drop",
+	"Trunk select fail drop",
+	"TX MAC disable drop",
+	"Ingress VLAN tag format drop",
+	"CRC error drop",
+	"PAUSE frame drop",
+	"Promiscuous drop",
+	"Isolation drop",
+	"Management packet APP_CTRL drop",
+	"Fake L2 protocol indicated packet not routing or bypass L3 edit drop",
+	"Policing drop",
+};
+
+static int ppe_prx_drop_counter_get(struct ppe_device *ppe_dev,
+				    struct seq_file *seq)
+{
+	int i, tag;
+	u32 val;
+
+	/* The counter for the packet dropped because of no buffer available,
+	 * no need to release the buffer.
+	 */
+	PREFIX_S("PRX_DROP_CNT", "SILENT_DROP:");
+	tag = 0;
+	for (i = 0; i < PPE_DROP_CNT_NUM; i++) {
+		ppe_read(ppe_dev, PPE_DROP_CNT + i * PPE_DROP_CNT_INC, &val);
+
+		if (val > 0) {
+			tag++;
+			if (!(tag % 4)) {
+				seq_putc(seq, '\n');
+				PREFIX_S("", "");
+			}
+
+			CNT_ONE_TYPE(val, "port", i);
+		}
+	}
+
+	seq_putc(seq, '\n');
+	return 0;
+}
+
+static int ppe_prx_bm_drop_counter_get(struct ppe_device *ppe_dev,
+				       struct seq_file *seq)
+{
+	union ppe_drop_stat_u drop_stat;
+	int i, tag;
+
+	/* The counter for the packet dropped because of no enough buffer
+	 * to cache packet, some buffer allocated for the part of packet.
+	 */
+	PREFIX_S("PRX_BM_DROP_CNT", "OVERFLOW_DROP:");
+	tag = 0;
+	for (i = 0; i < PPE_DROP_STAT_NUM; i++) {
+		memset(&drop_stat, 0, sizeof(drop_stat));
+		ppe_read_tbl(ppe_dev, PPE_DROP_STAT + PPE_DROP_STAT_INC * i,
+			     drop_stat.val, sizeof(drop_stat.val));
+
+		if (drop_stat.bf.pkt_cnt > 0) {
+			tag++;
+			if (!(tag % 4)) {
+				seq_putc(seq, '\n');
+				PREFIX_S("", "");
+			}
+
+			CNT_ONE_TYPE(drop_stat.bf.pkt_cnt, "port", i);
+		}
+	}
+
+	seq_putc(seq, '\n');
+	return 0;
+}
+
+static int ppe_prx_bm_port_counter_get(struct ppe_device *ppe_dev,
+				       struct seq_file *seq)
+{
+	int used_cnt, react_cnt;
+	int i, tag;
+	u32 val;
+
+	/* This is read only counter, which can't be flused. */
+	PREFIX_S("PRX_BM_PORT_CNT", "USED/REACT:");
+	tag = 0;
+	for (i = 0; i < PPE_BM_USED_CNT_NUM; i++) {
+		ppe_read(ppe_dev, PPE_BM_USED_CNT + i * PPE_BM_USED_CNT_INC, &val);
+		used_cnt = FIELD_GET(PPE_BM_USED_CNT_VAL, val);
+
+		ppe_read(ppe_dev, PPE_BM_REACT_CNT + i * PPE_BM_REACT_CNT_INC, &val);
+		react_cnt = FIELD_GET(PPE_BM_REACT_CNT_VAL, val);
+
+		if (used_cnt > 0 || react_cnt > 0) {
+			tag++;
+			if (!(tag % 4)) {
+				seq_putc(seq, '\n');
+				PREFIX_S("", "");
+			}
+
+			CNT_TWO_TYPE(used_cnt, react_cnt, "port", i);
+		}
+	}
+
+	seq_putc(seq, '\n');
+	return 0;
+}
+
+static int ppe_ipx_pkt_counter_get(struct ppe_device *ppe_dev,
+				   struct seq_file *seq)
+{
+	u32 val, tunnel_val;
+	int i, tag;
+
+	PREFIX_S("IPR_PKT_CNT", "TPRX/IPRX:");
+	tag = 0;
+	for (i = 0; i < PPE_IPR_PKT_CNT_NUM; i++) {
+		ppe_read(ppe_dev, PPE_TPR_PKT_CNT + i * PPE_IPR_PKT_CNT_INC, &tunnel_val);
+		ppe_read(ppe_dev, PPE_IPR_PKT_CNT + i * PPE_IPR_PKT_CNT_INC, &val);
+
+		if (tunnel_val > 0 || val > 0) {
+			tag++;
+			if (!(tag % 4)) {
+				seq_putc(seq, '\n');
+				PREFIX_S("", "");
+			}
+
+			CNT_TWO_TYPE(tunnel_val, val, "port", i);
+		}
+	}
+
+	seq_putc(seq, '\n');
+	return 0;
+}
+
+static int ppe_port_rx_counter_get(struct ppe_device *ppe_dev,
+				   struct seq_file *seq)
+{
+	union ppe_phy_port_rx_cnt_tbl_u phy_port_rx_cnt;
+	int i, tag;
+
+	PREFIX_S("PORT_RX_CNT", "RX/RX_DROP:");
+	tag = 0;
+	for (i = 0; i < PPE_PHY_PORT_RX_CNT_TBL_NUM; i++) {
+		memset(&phy_port_rx_cnt, 0, sizeof(phy_port_rx_cnt));
+		ppe_read_tbl(ppe_dev, PPE_PHY_PORT_RX_CNT_TBL + PPE_PHY_PORT_RX_CNT_TBL_INC * i,
+			     phy_port_rx_cnt.val, sizeof(phy_port_rx_cnt.val));
+
+		if (phy_port_rx_cnt.bf.pkt_cnt > 0) {
+			tag++;
+			if (!(tag % 4)) {
+				seq_putc(seq, '\n');
+				PREFIX_S("", "");
+			}
+
+			CNT_TWO_TYPE(phy_port_rx_cnt.bf.pkt_cnt, phy_port_rx_cnt.bf.drop_pkt_cnt_0 |
+			       phy_port_rx_cnt.bf.drop_pkt_cnt_1 << 24, "port", i);
+		}
+	}
+
+	seq_putc(seq, '\n');
+	return 0;
+}
+
+static int ppe_vp_rx_counter_get(struct ppe_device *ppe_dev,
+				 struct seq_file *seq)
+{
+	union ppe_port_rx_cnt_tbl_u port_rx_cnt;
+	int i, tag;
+
+	PREFIX_S("VPORT_RX_CNT", "RX/RX_DROP:");
+	tag = 0;
+	for (i = 0; i < PPE_PORT_RX_CNT_TBL_NUM; i++) {
+		memset(&port_rx_cnt, 0, sizeof(port_rx_cnt));
+		ppe_read_tbl(ppe_dev, PPE_PORT_RX_CNT_TBL + PPE_PORT_RX_CNT_TBL_INC * i,
+			     port_rx_cnt.val, sizeof(port_rx_cnt.val));
+
+		if (port_rx_cnt.bf.pkt_cnt > 0) {
+			tag++;
+			if (!(tag % 4)) {
+				seq_putc(seq, '\n');
+				PREFIX_S("", "");
+			}
+
+			CNT_TWO_TYPE(port_rx_cnt.bf.pkt_cnt, port_rx_cnt.bf.drop_pkt_cnt_0 |
+			       port_rx_cnt.bf.drop_pkt_cnt_1 << 24, "port", i);
+		}
+	}
+
+	seq_putc(seq, '\n');
+	return 0;
+}
+
+static int ppe_pre_l2_counter_get(struct ppe_device *ppe_dev,
+				  struct seq_file *seq)
+{
+	union ppe_pre_l2_cnt_tbl_u pre_l2_cnt;
+	int i, tag;
+
+	PREFIX_S("PRE_L2_CNT", "RX/RX_DROP:");
+	tag = 0;
+	for (i = 0; i < PPE_PRE_L2_CNT_TBL_NUM; i++) {
+		memset(&pre_l2_cnt, 0, sizeof(pre_l2_cnt));
+		ppe_read_tbl(ppe_dev, PPE_PRE_L2_CNT_TBL + PPE_PRE_L2_CNT_TBL_INC * i,
+			     pre_l2_cnt.val, sizeof(pre_l2_cnt.val));
+
+		if (pre_l2_cnt.bf.pkt_cnt > 0) {
+			tag++;
+			if (!(tag % 4)) {
+				seq_putc(seq, '\n');
+				PREFIX_S("", "");
+			}
+
+			CNT_TWO_TYPE(pre_l2_cnt.bf.pkt_cnt, pre_l2_cnt.bf.drop_pkt_cnt_0 |
+			       pre_l2_cnt.bf.drop_pkt_cnt_1 << 24, "vsi", i);
+		}
+	}
+
+	seq_putc(seq, '\n');
+	return 0;
+}
+
+static int ppe_vlan_counter_get(struct ppe_device *ppe_dev,
+				struct seq_file *seq)
+{
+	union ppe_vlan_cnt_u vlan_cnt;
+	int i, tag;
+
+	PREFIX_S("VLAN_CNT", "RX:");
+	tag = 0;
+	for (i = 0; i < PPE_VLAN_CNT_TBL_NUM; i++) {
+		memset(&vlan_cnt, 0, sizeof(vlan_cnt));
+		ppe_read_tbl(ppe_dev, PPE_VLAN_CNT_TBL + PPE_VLAN_CNT_TBL_INC * i,
+			     vlan_cnt.val, sizeof(vlan_cnt.val));
+
+		if (vlan_cnt.bf.pkt_cnt > 0) {
+			tag++;
+			if (!(tag % 4)) {
+				seq_putc(seq, '\n');
+				PREFIX_S("", "");
+			}
+
+			CNT_ONE_TYPE(vlan_cnt.bf.pkt_cnt, "vsi", i);
+		}
+	}
+
+	seq_putc(seq, '\n');
+	return 0;
+}
+
+static int ppe_cpu_code_counter_get(struct ppe_device *ppe_dev,
+				    struct seq_file *seq)
+{
+	union ppe_drop_cpu_cnt_u drop_cpu_cnt;
+	int i;
+
+	PREFIX_S("CPU_CODE_CNT", "CODE:");
+	for (i = 0; i < PPE_DROP_CPU_CNT_TBL_NUM; i++) {
+		memset(&drop_cpu_cnt, 0, sizeof(drop_cpu_cnt));
+		ppe_read_tbl(ppe_dev, PPE_DROP_CPU_CNT_TBL + PPE_DROP_CPU_CNT_TBL_INC * i,
+			     drop_cpu_cnt.val, sizeof(drop_cpu_cnt.val));
+
+		/* entry index i = cpucode when i < 256;
+		 * entry index i = 256 + dropcode * 8 + port & 7 when i > =256.
+		 */
+		if (!drop_cpu_cnt.bf.pkt_cnt)
+			continue;
+
+		if (i < 256)
+			CNT_CPU_CODE(drop_cpu_cnt.bf.pkt_cnt, ppe_cpucode[i], i);
+		else
+			CNT_DROP_CODE(drop_cpu_cnt.bf.pkt_cnt,
+				      ppe_dropcode[(i - 256) / 8],
+				      (i - 256) % 8, (i - 256) / 8);
+
+		seq_putc(seq, '\n');
+		PREFIX_S("", "");
+	}
+
+	seq_putc(seq, '\n');
+	return 0;
+}
+
+static int ppe_eg_vsi_counter_get(struct ppe_device *ppe_dev,
+				  struct seq_file *seq)
+{
+	union ppe_eg_vsi_cnt_tbl_u eg_vsi_cnt;
+	int i, tag;
+
+	PREFIX_S("EG_VSI_CNT", "TX:");
+	tag = 0;
+	for (i = 0; i < PPE_EG_VSI_COUNTER_TBL_NUM; i++) {
+		memset(&eg_vsi_cnt, 0, sizeof(eg_vsi_cnt));
+		ppe_read_tbl(ppe_dev, PPE_EG_VSI_COUNTER_TBL + PPE_EG_VSI_COUNTER_TBL_INC * i,
+			     eg_vsi_cnt.val, sizeof(eg_vsi_cnt.val));
+
+		if (eg_vsi_cnt.bf.pkt_cnt > 0) {
+			tag++;
+			if (!(tag % 4)) {
+				seq_putc(seq, '\n');
+				PREFIX_S("", "");
+			}
+
+			CNT_ONE_TYPE(eg_vsi_cnt.bf.pkt_cnt, "vsi", i);
+		}
+	}
+
+	seq_putc(seq, '\n');
+	return 0;
+}
+
+static int ppe_vp_tx_counter_get(struct ppe_device *ppe_dev,
+				 struct seq_file *seq)
+{
+	union ppe_vport_tx_counter_tbl_u vport_tx_counter;
+	union ppe_vport_tx_drop_u vport_tx_drop;
+	int i, tag;
+
+	PREFIX_S("VPORT_TX_CNT", "TX/TX_DROP:");
+	tag = 0;
+	for (i = 0; i < PPE_VPORT_TX_COUNTER_TBL_NUM; i++) {
+		memset(&vport_tx_counter, 0, sizeof(vport_tx_counter));
+		memset(&vport_tx_drop, 0, sizeof(vport_tx_drop));
+
+		ppe_read_tbl(ppe_dev, PPE_VPORT_TX_COUNTER_TBL + PPE_VPORT_TX_COUNTER_TBL_INC * i,
+			     vport_tx_counter.val, sizeof(vport_tx_counter.val));
+		ppe_read_tbl(ppe_dev, PPE_VPORT_TX_DROP_CNT_TBL + PPE_VPORT_TX_DROP_CNT_TBL_INC * i,
+			     vport_tx_drop.val, sizeof(vport_tx_drop.val));
+
+		if (vport_tx_counter.bf.pkt_cnt > 0 || vport_tx_drop.bf.pkt_cnt > 0) {
+			tag++;
+			if (!(tag % 4)) {
+				seq_putc(seq, '\n');
+				PREFIX_S("", "");
+			}
+
+			CNT_TWO_TYPE(vport_tx_counter.bf.pkt_cnt,
+				     vport_tx_drop.bf.pkt_cnt, "port", i);
+		}
+	}
+
+	seq_putc(seq, '\n');
+	return 0;
+}
+
+static int ppe_port_tx_counter_get(struct ppe_device *ppe_dev,
+				   struct seq_file *seq)
+{
+	union ppe_port_tx_counter_tbl_u port_tx_counter;
+	union ppe_port_tx_drop_u port_tx_drop;
+	int i, tag;
+
+	PREFIX_S("PORT_TX_CNT", "TX/TX_DROP:");
+	tag = 0;
+	for (i = 0; i < PPE_PORT_TX_COUNTER_TBL_NUM; i++) {
+		memset(&port_tx_counter, 0, sizeof(port_tx_counter));
+		memset(&port_tx_drop, 0, sizeof(port_tx_drop));
+
+		ppe_read_tbl(ppe_dev, PPE_PORT_TX_COUNTER_TBL + PPE_PORT_TX_COUNTER_TBL_INC * i,
+			     port_tx_counter.val, sizeof(port_tx_counter.val));
+		ppe_read_tbl(ppe_dev, PPE_PORT_TX_DROP_CNT_TBL + PPE_PORT_TX_DROP_CNT_TBL_INC * i,
+			     port_tx_drop.val, sizeof(port_tx_drop.val));
+
+		if (port_tx_counter.bf.pkt_cnt > 0 || port_tx_drop.bf.pkt_cnt > 0) {
+			tag++;
+			if (!(tag % 4)) {
+				seq_putc(seq, '\n');
+				PREFIX_S("", "");
+			}
+
+			CNT_TWO_TYPE(port_tx_counter.bf.pkt_cnt,
+				     port_tx_drop.bf.pkt_cnt, "port", i);
+		}
+	}
+
+	seq_putc(seq, '\n');
+	return 0;
+}
+
+static int ppe_queue_tx_counter_get(struct ppe_device *ppe_dev,
+				    struct seq_file *seq)
+{
+	union ppe_queue_tx_counter_tbl_u queue_tx_counter;
+	u32 val, pend_cnt;
+	int i, tag;
+
+	PREFIX_S("QUEUE_TX_CNT", "TX/PEND:");
+	tag = 0;
+	for (i = 0; i < PPE_QUEUE_TX_COUNTER_TBL_NUM; i++) {
+		memset(&queue_tx_counter, 0, sizeof(queue_tx_counter));
+		ppe_read_tbl(ppe_dev, PPE_QUEUE_TX_COUNTER_TBL + PPE_QUEUE_TX_COUNTER_TBL_INC * i,
+			     queue_tx_counter.val, sizeof(queue_tx_counter.val));
+
+		if (i < PPE_AC_UNI_QUEUE_CFG_TBL_NUM) {
+			ppe_read(ppe_dev, PPE_AC_UNI_QUEUE_CNT_TBL +
+				 PPE_AC_UNI_QUEUE_CNT_TBL_INC * i, &val);
+			pend_cnt = FIELD_GET(PPE_AC_UNI_QUEUE_CNT_TBL_PEND_CNT, val);
+		} else {
+			ppe_read(ppe_dev, PPE_AC_MUL_QUEUE_CNT_TBL +
+				 PPE_AC_MUL_QUEUE_CNT_TBL_INC *
+				 (i - PPE_AC_UNI_QUEUE_CFG_TBL_NUM), &val);
+			pend_cnt = FIELD_GET(PPE_AC_MUL_QUEUE_CNT_TBL_PEND_CNT, val);
+		}
+
+		if (queue_tx_counter.bf.pkt_cnt > 0 || pend_cnt > 0) {
+			tag++;
+			if (!(tag % 4)) {
+				seq_putc(seq, '\n');
+				PREFIX_S("", "");
+			}
+
+			CNT_TWO_TYPE(queue_tx_counter.bf.pkt_cnt, pend_cnt, "queue", i);
+		}
+	}
+
+	seq_putc(seq, '\n');
+	return 0;
+}
+
+static int ppe_packet_counter_show(struct seq_file *seq, void *v)
+{
+	struct ppe_device *ppe_dev = seq->private;
+
+	ppe_prx_drop_counter_get(ppe_dev, seq);
+	ppe_prx_bm_drop_counter_get(ppe_dev, seq);
+	ppe_prx_bm_port_counter_get(ppe_dev, seq);
+	ppe_ipx_pkt_counter_get(ppe_dev, seq);
+	ppe_port_rx_counter_get(ppe_dev, seq);
+	ppe_vp_rx_counter_get(ppe_dev, seq);
+	ppe_pre_l2_counter_get(ppe_dev, seq);
+	ppe_vlan_counter_get(ppe_dev, seq);
+	ppe_cpu_code_counter_get(ppe_dev, seq);
+	ppe_eg_vsi_counter_get(ppe_dev, seq);
+	ppe_vp_tx_counter_get(ppe_dev, seq);
+	ppe_port_tx_counter_get(ppe_dev, seq);
+	ppe_queue_tx_counter_get(ppe_dev, seq);
+
+	return 0;
+}
+
+static int ppe_packet_counter_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, ppe_packet_counter_show, inode->i_private);
+}
+
+static ssize_t ppe_packet_counter_clear(struct file *file,
+					const char __user *buf,
+					size_t count, loff_t *pos)
+{
+	union ppe_port_tx_counter_tbl_u port_tx_counter;
+	union ppe_vport_tx_counter_tbl_u vport_tx_counter;
+	union ppe_queue_tx_counter_tbl_u queue_tx_counter;
+	union ppe_phy_port_rx_cnt_tbl_u phy_port_rx_cnt;
+	union ppe_port_rx_cnt_tbl_u port_rx_cnt;
+	union ppe_pre_l2_cnt_tbl_u pre_l2_cnt;
+	union ppe_eg_vsi_cnt_tbl_u eg_vsi_cnt;
+	union ppe_vport_tx_drop_u vport_tx_drop;
+	union ppe_port_tx_drop_u port_tx_drop;
+	union ppe_drop_cpu_cnt_u drop_cpu_cnt;
+	union ppe_drop_stat_u drop_stat;
+	union ppe_vlan_cnt_u vlan_cnt;
+	struct ppe_device *ppe_dev;
+	u32 val;
+	int i;
+
+	memset(&drop_stat, 0, sizeof(drop_stat));
+	memset(&vlan_cnt, 0, sizeof(vlan_cnt));
+	memset(&pre_l2_cnt, 0, sizeof(pre_l2_cnt));
+	memset(&port_tx_drop, 0, sizeof(port_tx_drop));
+	memset(&eg_vsi_cnt, 0, sizeof(eg_vsi_cnt));
+	memset(&port_tx_counter, 0, sizeof(port_tx_counter));
+	memset(&vport_tx_counter, 0, sizeof(vport_tx_counter));
+	memset(&queue_tx_counter, 0, sizeof(queue_tx_counter));
+	memset(&vport_tx_drop, 0, sizeof(vport_tx_drop));
+	memset(&drop_cpu_cnt, 0, sizeof(drop_cpu_cnt));
+	memset(&port_rx_cnt, 0, sizeof(port_rx_cnt));
+	memset(&phy_port_rx_cnt, 0, sizeof(phy_port_rx_cnt));
+
+	val = 0;
+	ppe_dev = file_inode(file)->i_private;
+	for (i = 0; i < PPE_DROP_CNT_NUM; i++)
+		ppe_write(ppe_dev, PPE_DROP_CNT + i * PPE_DROP_CNT_INC, val);
+
+	for (i = 0; i < PPE_DROP_STAT_NUM; i++)
+		ppe_write_tbl(ppe_dev, PPE_DROP_STAT + PPE_DROP_STAT_INC * i,
+			      drop_stat.val, sizeof(drop_stat.val));
+
+	for (i = 0; i < PPE_IPR_PKT_CNT_NUM; i++)
+		ppe_write(ppe_dev, PPE_IPR_PKT_CNT + i * PPE_IPR_PKT_CNT_INC, val);
+
+	for (i = 0; i < PPE_VLAN_CNT_TBL_NUM; i++)
+		ppe_write_tbl(ppe_dev, PPE_VLAN_CNT_TBL + PPE_VLAN_CNT_TBL_INC * i,
+			      vlan_cnt.val, sizeof(vlan_cnt.val));
+
+	for (i = 0; i < PPE_PRE_L2_CNT_TBL_NUM; i++)
+		ppe_write_tbl(ppe_dev, PPE_PRE_L2_CNT_TBL + PPE_PRE_L2_CNT_TBL_INC * i,
+			      pre_l2_cnt.val, sizeof(pre_l2_cnt.val));
+
+	for (i = 0; i < PPE_PORT_TX_DROP_CNT_TBL_NUM; i++)
+		ppe_write_tbl(ppe_dev, PPE_PORT_TX_DROP_CNT_TBL + PPE_PORT_TX_DROP_CNT_TBL_INC * i,
+			      port_tx_drop.val, sizeof(port_tx_drop.val));
+
+	for (i = 0; i < PPE_EG_VSI_COUNTER_TBL_NUM; i++)
+		ppe_write_tbl(ppe_dev, PPE_EG_VSI_COUNTER_TBL + PPE_EG_VSI_COUNTER_TBL_INC * i,
+			      eg_vsi_cnt.val, sizeof(eg_vsi_cnt.val));
+
+	for (i = 0; i < PPE_PORT_TX_COUNTER_TBL_NUM; i++)
+		ppe_write_tbl(ppe_dev, PPE_PORT_TX_COUNTER_TBL + PPE_PORT_TX_COUNTER_TBL_INC * i,
+			      port_tx_counter.val, sizeof(port_tx_counter.val));
+
+	for (i = 0; i < PPE_VPORT_TX_COUNTER_TBL_NUM; i++)
+		ppe_write_tbl(ppe_dev, PPE_VPORT_TX_COUNTER_TBL + PPE_VPORT_TX_COUNTER_TBL_INC * i,
+			      vport_tx_counter.val, sizeof(vport_tx_counter.val));
+
+	for (i = 0; i < PPE_QUEUE_TX_COUNTER_TBL_NUM; i++)
+		ppe_write_tbl(ppe_dev, PPE_QUEUE_TX_COUNTER_TBL + PPE_QUEUE_TX_COUNTER_TBL_INC * i,
+			      queue_tx_counter.val, sizeof(queue_tx_counter.val));
+
+	ppe_write(ppe_dev, PPE_EPE_DBG_IN_CNT, val);
+	ppe_write(ppe_dev, PPE_EPE_DBG_OUT_CNT, val);
+
+	for (i = 0; i < PPE_VPORT_TX_DROP_CNT_TBL_NUM; i++)
+		ppe_write_tbl(ppe_dev, PPE_VPORT_TX_DROP_CNT_TBL +
+			      PPE_VPORT_TX_DROP_CNT_TBL_INC * i,
+			      vport_tx_drop.val, sizeof(vport_tx_drop.val));
+
+	for (i = 0; i < PPE_DROP_CPU_CNT_TBL_NUM; i++)
+		ppe_write_tbl(ppe_dev, PPE_DROP_CPU_CNT_TBL + PPE_DROP_CPU_CNT_TBL_INC * i,
+			      drop_cpu_cnt.val, sizeof(drop_cpu_cnt.val));
+
+	for (i = 0; i < PPE_PORT_RX_CNT_TBL_NUM; i++)
+		ppe_write_tbl(ppe_dev, PPE_PORT_RX_CNT_TBL + PPE_PORT_RX_CNT_TBL_INC * i,
+			      port_rx_cnt.val, sizeof(port_rx_cnt.val));
+
+	for (i = 0; i < PPE_PHY_PORT_RX_CNT_TBL_NUM; i++)
+		ppe_write_tbl(ppe_dev, PPE_PHY_PORT_RX_CNT_TBL + PPE_PHY_PORT_RX_CNT_TBL_INC * i,
+			      phy_port_rx_cnt.val, sizeof(phy_port_rx_cnt.val));
+
+	return count;
+}
+
+static const struct file_operations ppe_debugfs_packet_counter_fops = {
+	.owner   = THIS_MODULE,
+	.open    = ppe_packet_counter_open,
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = single_release,
+	.write   = ppe_packet_counter_clear,
+};
+
+int ppe_debugfs_setup(struct ppe_device *ppe_dev)
+{
+	ppe_dev->debugfs_root = debugfs_create_dir("ppe", NULL);
+	debugfs_create_file("packet_counter", 0444,
+			    ppe_dev->debugfs_root,
+			    ppe_dev,
+			    &ppe_debugfs_packet_counter_fops);
+	return 0;
+}
+
+void ppe_debugfs_teardown(struct ppe_device *ppe_dev)
+{
+	debugfs_remove_recursive(ppe_dev->debugfs_root);
+	ppe_dev->debugfs_root = NULL;
+}
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_debugfs.h b/drivers/net/ethernet/qualcomm/ppe/ppe_debugfs.h
new file mode 100644
index 000000000000..97463216d5af
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_debugfs.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/* PPE debugfs counters setup. */
+
+#ifndef __PPE_DEBUGFS_H__
+#define __PPE_DEBUGFS_H__
+
+#define PREFIX_S(desc, cnt_type) \
+	seq_printf(seq, "%-16s %16s", desc, cnt_type)
+#define CNT_ONE_TYPE(cnt, str, index) \
+	seq_printf(seq, "%10u(%s=%04d)", cnt, str, index)
+#define CNT_TWO_TYPE(cnt, cnt1, str, index) \
+	seq_printf(seq, "%10u/%u(%s=%04d)", cnt, cnt1, str, index)
+#define CNT_CPU_CODE(cnt, str, index) \
+	seq_printf(seq, "%10u(%s),cpucode:%d", cnt, str, index)
+#define CNT_DROP_CODE(cnt, str, port, index) \
+	seq_printf(seq, "%10u(port=%d:%s),dropcode:%d", cnt, port, str, index)
+
+int ppe_debugfs_setup(struct ppe_device *ppe_dev);
+void ppe_debugfs_teardown(struct ppe_device *ppe_dev);
+
+#endif
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
index ef12037ffed5..98bf19f974ce 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
@@ -19,6 +19,105 @@
 #define PPE_RX_FIFO_CFG_INC					4
 #define PPE_RX_FIFO_CFG_THRSH					GENMASK(2, 0)
 
+#define PPE_DROP_CNT						0xb024
+#define PPE_DROP_CNT_NUM					8
+#define PPE_DROP_CNT_INC					4
+#define PPE_DROP_CNT_PKT_CNT					GENMASK(31, 0)
+
+#define PPE_DROP_STAT						0xe000
+#define PPE_DROP_STAT_NUM					30
+#define PPE_DROP_STAT_INC					0x10
+#define PPE_DROP_STAT_PKT_CNT					GENMASK(31, 0)
+
+/* BM port drop counter */
+struct ppe_drop_stat {
+	u32 pkt_cnt;
+	u32 byte_cnt_0;
+	u32 byte_cnt_1:8,
+	    res0:24;
+};
+
+union ppe_drop_stat_u {
+	u32 val[3];
+	struct ppe_drop_stat bf;
+};
+
+#define PPE_EPE_DBG_IN_CNT					0x26054
+#define PPE_EPE_DBG_IN_CNT_NUM					1
+#define PPE_EPE_DBG_IN_CNT_INC					0x4
+
+#define PPE_EPE_DBG_OUT_CNT					0x26070
+#define PPE_EPE_DBG_OUT_CNT_NUM					1
+#define PPE_EPE_DBG_OUT_CNT_INC					0x4
+
+#define PPE_EG_VSI_COUNTER_TBL					0x41000
+#define PPE_EG_VSI_COUNTER_TBL_NUM				64
+#define PPE_EG_VSI_COUNTER_TBL_INC				0x10
+
+/* Egress VLAN counter */
+struct ppe_eg_vsi_cnt_tbl {
+	u32 pkt_cnt;
+	u32 byte_cnt_0;
+	u32 byte_cnt_1:8,
+	    res0:24;
+};
+
+union ppe_eg_vsi_cnt_tbl_u {
+	u32 val[3];
+	struct ppe_eg_vsi_cnt_tbl bf;
+};
+
+#define PPE_PORT_TX_COUNTER_TBL					0x45000
+#define PPE_PORT_TX_COUNTER_TBL_NUM				8
+#define PPE_PORT_TX_COUNTER_TBL_INC				0x10
+
+/* Port TX counter */
+struct ppe_port_tx_counter_tbl {
+	u32 pkt_cnt;
+	u32 byte_cnt_0;
+	u32 byte_cnt_1:8,
+	    res0:24;
+};
+
+union ppe_port_tx_counter_tbl_u {
+	u32 val[3];
+	struct ppe_port_tx_counter_tbl bf;
+};
+
+#define PPE_VPORT_TX_COUNTER_TBL				0x47000
+#define PPE_VPORT_TX_COUNTER_TBL_NUM				256
+#define PPE_VPORT_TX_COUNTER_TBL_INC				0x10
+
+/* Virtual port TX counter */
+struct ppe_vport_tx_counter_tbl {
+	u32 pkt_cnt;
+	u32 byte_cnt_0;
+	u32 byte_cnt_1:8,
+	    res0:24;
+};
+
+union ppe_vport_tx_counter_tbl_u {
+	u32 val[3];
+	struct ppe_vport_tx_counter_tbl bf;
+};
+
+#define PPE_QUEUE_TX_COUNTER_TBL				0x4a000
+#define PPE_QUEUE_TX_COUNTER_TBL_NUM				300
+#define PPE_QUEUE_TX_COUNTER_TBL_INC				0x10
+
+/* Queue counter */
+struct ppe_queue_tx_counter_tbl {
+	u32 pkt_cnt;
+	u32 byte_cnt_0;
+	u32 byte_cnt_1:8,
+	    res0:24;
+};
+
+union ppe_queue_tx_counter_tbl_u {
+	u32 val[3];
+	struct ppe_queue_tx_counter_tbl bf;
+};
+
 #define PPE_RSS_HASH_MASK					0xb4318
 #define PPE_RSS_HASH_MASK_NUM					1
 #define PPE_RSS_HASH_MASK_INC					4
@@ -196,6 +295,143 @@ union ppe_mru_mtu_ctrl_cfg_u {
 #define PPE_IN_L2_SERVICE_TBL_RX_CNT_EN				BIT(30)
 #define PPE_IN_L2_SERVICE_TBL_TX_CNT_EN				BIT(31)
 
+#define PPE_PORT_RX_CNT_TBL					0x150000
+#define PPE_PORT_RX_CNT_TBL_NUM					256
+#define PPE_PORT_RX_CNT_TBL_INC					0x20
+
+/* Port RX counter */
+struct ppe_port_rx_cnt_tbl {
+	u32 pkt_cnt;
+	u32 byte_cnt_0;
+	u32 byte_cnt_1:8,
+	    drop_pkt_cnt_0:24;
+	u32 drop_pkt_cnt_1:8,
+	    drop_byte_cnt_0:24;
+	u32 drop_byte_cnt_1:16,
+	    res0:16;
+};
+
+union ppe_port_rx_cnt_tbl_u {
+	u32 val[5];
+	struct ppe_port_rx_cnt_tbl bf;
+};
+
+#define PPE_PHY_PORT_RX_CNT_TBL					0x156000
+#define PPE_PHY_PORT_RX_CNT_TBL_NUM				8
+#define PPE_PHY_PORT_RX_CNT_TBL_INC				0x20
+
+/* Physical port RX and RX drop counter */
+struct ppe_phy_port_rx_cnt_tbl {
+	u32 pkt_cnt;
+	u32 byte_cnt_0;
+	u32 byte_cnt_1:8,
+	    drop_pkt_cnt_0:24;
+	u32 drop_pkt_cnt_1:8,
+	    drop_byte_cnt_0:24;
+	u32 drop_byte_cnt_1:16,
+	    res0:16;
+};
+
+union ppe_phy_port_rx_cnt_tbl_u {
+	u32 val[5];
+	struct ppe_phy_port_rx_cnt_tbl bf;
+};
+
+#define PPE_DROP_CPU_CNT_TBL					0x160000
+#define PPE_DROP_CPU_CNT_TBL_NUM				1280
+#define PPE_DROP_CPU_CNT_TBL_INC				0x10
+
+/* counter for the packet to CPU port */
+struct ppe_drop_cpu_cnt {
+	u32 pkt_cnt;
+	u32 byte_cnt_0;
+	u32 byte_cnt_1:8,
+	    res0:24;
+};
+
+union ppe_drop_cpu_cnt_u {
+	u32 val[3];
+	struct ppe_drop_cpu_cnt bf;
+};
+
+#define PPE_VLAN_CNT_TBL					0x178000
+#define PPE_VLAN_CNT_TBL_NUM					64
+#define PPE_VLAN_CNT_TBL_INC					0x10
+
+/* VLAN counter */
+struct ppe_vlan_cnt {
+	u32 pkt_cnt;
+	u32 byte_cnt_0;
+	u32 byte_cnt_1:8,
+	    res0:24;
+};
+
+union ppe_vlan_cnt_u {
+	u32 val[3];
+	struct ppe_vlan_cnt bf;
+};
+
+#define PPE_PRE_L2_CNT_TBL					0x17c000
+#define PPE_PRE_L2_CNT_TBL_NUM					64
+#define PPE_PRE_L2_CNT_TBL_INC					0x20
+
+/* PPE L2 counter */
+struct ppe_pre_l2_cnt_tbl {
+	u32 pkt_cnt;
+	u32 byte_cnt_0;
+	u32 byte_cnt_1:8,
+	    drop_pkt_cnt_0:24;
+	u32 drop_pkt_cnt_1:8,
+	    drop_byte_cnt_0:24;
+	u32 drop_byte_cnt_1:16,
+	    res0:16;
+};
+
+union ppe_pre_l2_cnt_tbl_u {
+	u32 val[5];
+	struct ppe_pre_l2_cnt_tbl bf;
+};
+
+#define PPE_PORT_TX_DROP_CNT_TBL				0x17d000
+#define PPE_PORT_TX_DROP_CNT_TBL_NUM				8
+#define PPE_PORT_TX_DROP_CNT_TBL_INC				0x10
+
+/* Port TX drop counter */
+struct ppe_port_tx_drop_cnt {
+	u32 pkt_cnt;
+	u32 byte_cnt_0;
+	u32 byte_cnt_1:8,
+	    res0:24;
+};
+
+union ppe_port_tx_drop_u {
+	u32 val[3];
+	struct ppe_port_tx_drop_cnt bf;
+};
+
+#define PPE_VPORT_TX_DROP_CNT_TBL				0x17e000
+#define PPE_VPORT_TX_DROP_CNT_TBL_NUM				256
+#define PPE_VPORT_TX_DROP_CNT_TBL_INC				0x10
+
+/* Virtual port TX counter */
+struct ppe_vport_tx_drop_cnt {
+	u32 pkt_cnt;
+	u32 byte_cnt_0;
+	u32 byte_cnt_1:8,
+	    res0:24;
+};
+
+union ppe_vport_tx_drop_u {
+	u32 val[3];
+	struct ppe_vport_tx_drop_cnt bf;
+};
+
+#define PPE_TPR_PKT_CNT						0x1d0080
+#define PPE_IPR_PKT_CNT						0x1e0080
+#define PPE_IPR_PKT_CNT_NUM					8
+#define PPE_IPR_PKT_CNT_INC					4
+#define PPE_IPR_PKT_CNT_PKT_CNT					GENMASK(31, 0)
+
 #define PPE_TL_SERVICE_TBL					0x306000
 #define PPE_TL_SERVICE_TBL_NUM					256
 #define PPE_TL_SERVICE_TBL_INC					4
@@ -318,6 +554,16 @@ union ppe_ring_q_map_cfg_u {
 #define PPE_BM_PORT_GROUP_ID_INC				4
 #define PPE_BM_PORT_GROUP_ID_SHARED_GROUP_ID			GENMASK(1, 0)
 
+#define PPE_BM_USED_CNT						0x6001c0
+#define PPE_BM_USED_CNT_NUM					15
+#define PPE_BM_USED_CNT_INC					0x4
+#define PPE_BM_USED_CNT_VAL					GENMASK(10, 0)
+
+#define PPE_BM_REACT_CNT					0x600240
+#define PPE_BM_REACT_CNT_NUM					15
+#define PPE_BM_REACT_CNT_INC					0x4
+#define PPE_BM_REACT_CNT_VAL					GENMASK(8, 0)
+
 #define PPE_BM_SHARED_GROUP_CFG					0x600290
 #define PPE_BM_SHARED_GROUP_CFG_NUM				4
 #define PPE_BM_SHARED_GROUP_CFG_INC				4
@@ -456,6 +702,16 @@ union ppe_ac_grp_cfg_u {
 	struct ppe_ac_grp_cfg bf;
 };
 
+#define PPE_AC_UNI_QUEUE_CNT_TBL				0x84e000
+#define PPE_AC_UNI_QUEUE_CNT_TBL_NUM				256
+#define PPE_AC_UNI_QUEUE_CNT_TBL_INC				0x10
+#define PPE_AC_UNI_QUEUE_CNT_TBL_PEND_CNT			GENMASK(12, 0)
+
+#define PPE_AC_MUL_QUEUE_CNT_TBL				0x852000
+#define PPE_AC_MUL_QUEUE_CNT_TBL_NUM				44
+#define PPE_AC_MUL_QUEUE_CNT_TBL_INC				0x10
+#define PPE_AC_MUL_QUEUE_CNT_TBL_PEND_CNT			GENMASK(12, 0)
+
 #define PPE_ENQ_OPR_TBL						0x85c000
 #define PPE_ENQ_OPR_TBL_NUM					300
 #define PPE_ENQ_OPR_TBL_INC					0x10
diff --git a/include/linux/soc/qcom/ppe.h b/include/linux/soc/qcom/ppe.h
index 70ee192d9ef0..268109c823ad 100644
--- a/include/linux/soc/qcom/ppe.h
+++ b/include/linux/soc/qcom/ppe.h
@@ -17,6 +17,7 @@ struct ppe_device {
 	struct device *dev;
 	struct regmap *regmap;
 	struct ppe_device_ops *ppe_ops;
+	struct dentry *debugfs_root;
 	bool is_ppe_probed;
 	void *ppe_priv;
 };
-- 
2.42.0


