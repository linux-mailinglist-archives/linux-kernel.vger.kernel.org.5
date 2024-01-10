Return-Path: <linux-kernel+bounces-22119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2066482998F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90FF11F21492
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604C5482F3;
	Wed, 10 Jan 2024 11:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="m/v6uErj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82454BA88;
	Wed, 10 Jan 2024 11:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40A8dPWG017799;
	Wed, 10 Jan 2024 11:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=BRLfzQytisT+47FgkC4vCpFwWBRnJs2JB+T+ryEinYg=; b=m/
	v6uErjPd3uvnSlbTjeyYA4/BjyLgJVaQWkCmhvnx4ZkDrkCSA/BNWhP2X+usjyO/
	bdQtY9sPkqf3JtT8wemUSwNqYxI3hnSaJtKcJwSr+jQ7s+NZkHs1ZVfhMvpt01H5
	PfHI1azhSxOOI9CDKqAMNdOn1G1jJ71NKdp/i3XEgmglxpE52F0NJ4V19tiLlIwn
	o8FvW4scjzLA8poMrkxckYivaT6MAnCKfh6eI+lSzRop6N7Cyz95IgDs4Shom4vb
	1ubhSS7Ho08zBgLmRYdreJPSD+hpp/1xSWEuelK0B8Xjsus6rsjWZ77Z5E9gIwOw
	jetork/f+0GJWq4WNAVw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhkem0wpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:42:47 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40ABgkZr020375
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:42:46 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 03:42:36 -0800
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
Subject: [PATCH net-next 10/20] net: ethernet: qualcomm: Add PPE service code config
Date: Wed, 10 Jan 2024 19:40:22 +0800
Message-ID: <20240110114033.32575-11-quic_luoj@quicinc.com>
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
X-Proofpoint-ORIG-GUID: qY2PK9JN2OLAKcYv2q47qzW5BEF3v-b0
X-Proofpoint-GUID: qY2PK9JN2OLAKcYv2q47qzW5BEF3v-b0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100096

The service code is used to bypass some PPE handlers when the
packet is passed through PPE.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/ethernet/qualcomm/ppe/ppe.c      |  22 +++-
 drivers/net/ethernet/qualcomm/ppe/ppe_ops.c  |  42 ++++++++
 drivers/net/ethernet/qualcomm/ppe/ppe_ops.h  | 107 +++++++++++++++++++
 drivers/net/ethernet/qualcomm/ppe/ppe_regs.h |  62 +++++++++++
 4 files changed, 232 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.c b/drivers/net/ethernet/qualcomm/ppe/ppe.c
index dd032a158231..acff37f9d832 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe.c
@@ -1104,9 +1104,29 @@ static int ppe_qm_init(struct ppe_device *ppe_dev)
 	return 0;
 }
 
+static int ppe_servcode_init(struct ppe_device *ppe_dev)
+{
+	struct ppe_servcode_cfg servcode_cfg;
+
+	memset(&servcode_cfg, 0, sizeof(servcode_cfg));
+	servcode_cfg.bypass_bitmap[0] = (u32)(~(BIT(FAKE_MAC_HEADER_BYP) |
+					BIT(SERVICE_CODE_BYP) |
+					BIT(FAKE_L2_PROTO_BYP)));
+	servcode_cfg.bypass_bitmap[1] = (u32)(~(BIT(ACL_POST_ROUTING_CHECK_BYP)));
+
+	/* The default service code used by CPU port */
+	return ppe_servcode_config_set(ppe_dev, 1, servcode_cfg);
+}
+
 static int ppe_dev_hw_init(struct ppe_device *ppe_dev)
 {
-	return ppe_qm_init(ppe_dev);
+	int ret;
+
+	ret = ppe_qm_init(ppe_dev);
+	if (ret)
+		return ret;
+
+	return ppe_servcode_init(ppe_dev);
 }
 
 static int qcom_ppe_probe(struct platform_device *pdev)
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_ops.c b/drivers/net/ethernet/qualcomm/ppe/ppe_ops.c
index eaa3f1e7b525..a3269c0898be 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_ops.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_ops.c
@@ -269,6 +269,48 @@ static int ppe_queue_ucast_hash_class_set(struct ppe_device *ppe_dev,
 			 reg_val);
 }
 
+int ppe_servcode_config_set(struct ppe_device *ppe_dev,
+			    int servcode,
+			    struct ppe_servcode_cfg cfg)
+{
+	union ppe_eg_service_cfg_u eg_service_cfg;
+	union ppe_service_cfg_u service_cfg;
+	int val;
+
+	memset(&service_cfg, 0, sizeof(service_cfg));
+	memset(&eg_service_cfg, 0, sizeof(eg_service_cfg));
+
+	val = FIELD_PREP(PPE_IN_L2_SERVICE_TBL_DST_PORT_ID_VALID, cfg.dest_port_valid) |
+		FIELD_PREP(PPE_IN_L2_SERVICE_TBL_DST_PORT_ID, cfg.dest_port) |
+		FIELD_PREP(PPE_IN_L2_SERVICE_TBL_DST_DIRECTION, cfg.is_src) |
+		FIELD_PREP(PPE_IN_L2_SERVICE_TBL_DST_BYPASS_BITMAP, cfg.bypass_bitmap[1]) |
+		FIELD_PREP(PPE_IN_L2_SERVICE_TBL_RX_CNT_EN,
+			   cfg.bypass_bitmap[2] & BIT(1) ? 1 : 0) |
+		FIELD_PREP(PPE_IN_L2_SERVICE_TBL_TX_CNT_EN,
+			   cfg.bypass_bitmap[2] & BIT(3) ? 1 : 0);
+	ppe_write(ppe_dev, PPE_IN_L2_SERVICE_TBL + PPE_IN_L2_SERVICE_TBL_INC * servcode, val);
+
+	ppe_read_tbl(ppe_dev, PPE_SERVICE_TBL + PPE_SERVICE_TBL_INC * servcode,
+		     service_cfg.val, sizeof(service_cfg.val));
+	service_cfg.bf.bypass_bitmap = cfg.bypass_bitmap[0];
+	service_cfg.bf.rx_counting_en = cfg.bypass_bitmap[2] & BIT(0);
+	ppe_write_tbl(ppe_dev, PPE_SERVICE_TBL + PPE_SERVICE_TBL_INC * servcode,
+		      service_cfg.val, sizeof(service_cfg.val));
+
+	ppe_read_tbl(ppe_dev, PPE_EG_SERVICE_TBL + PPE_EG_SERVICE_TBL_INC * servcode,
+		     eg_service_cfg.val, sizeof(eg_service_cfg.val));
+	eg_service_cfg.bf.field_update_action = cfg.field_update_bitmap;
+	eg_service_cfg.bf.next_service_code = cfg.next_service_code;
+	eg_service_cfg.bf.hw_services = cfg.hw_service;
+	eg_service_cfg.bf.offset_sel = cfg.offset_sel;
+	eg_service_cfg.bf.tx_counting_en = cfg.bypass_bitmap[2] & BIT(2) ? 1 : 0;
+	ppe_write_tbl(ppe_dev, PPE_EG_SERVICE_TBL + PPE_EG_SERVICE_TBL_INC * servcode,
+		      eg_service_cfg.val, sizeof(eg_service_cfg.val));
+
+	val = FIELD_PREP(PPE_TL_SERVICE_TBL_BYPASS_BITMAP, cfg.bypass_bitmap[3]);
+	return ppe_write(ppe_dev, PPE_TL_SERVICE_TBL + PPE_TL_SERVICE_TBL_INC * servcode, val);
+}
+
 static const struct ppe_queue_ops qcom_ppe_queue_config_ops = {
 	.queue_scheduler_set = ppe_queue_scheduler_set,
 	.queue_scheduler_get = ppe_queue_scheduler_get,
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_ops.h b/drivers/net/ethernet/qualcomm/ppe/ppe_ops.h
index 181dbd4a3d90..b3c1ade7c948 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_ops.h
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_ops.h
@@ -45,6 +45,109 @@ struct ppe_queue_ucast_dest {
 	int dest_port;
 };
 
+/* bypss_bitmap_0 */
+enum {
+	IN_VLAN_TAG_FMT_CHECK_BYP = 0,
+	IN_VLAN_MEMBER_CHECK_BYP,
+	IN_VLAN_XLT_BYP,
+	MY_MAC_CHECK_BYP,
+	DIP_LOOKUP_BYP,
+	FLOW_LOOKUP_BYP = 5,
+	FLOW_ACTION_BYP,
+	ACL_BYP,
+	FAKE_MAC_HEADER_BYP,
+	SERVICE_CODE_BYP,
+	WRONG_PKT_FMT_L2_BYP = 10,
+	WRONG_PKT_FMT_L3_IPV4_BYP,
+	WRONG_PKT_FMT_L3_IPV6_BYP,
+	WRONG_PKT_FMT_L4_BYP,
+	FLOW_SERVICE_CODE_BYP,
+	ACL_SERVICE_CODE_BYP = 15,
+	FAKE_L2_PROTO_BYP,
+	PPPOE_TERMINATION_BYP,
+	DEFAULT_VLAN_BYP,
+	DEFAULT_PCP_BYP,
+	VSI_ASSIGN_BYP,
+	IN_VLAN_ASSIGN_FAIL_BYP = 24,
+	SOURCE_GUARD_BYP,
+	MRU_MTU_CHECK_BYP,
+	FLOW_SRC_CHECK_BYP,
+	FLOW_QOS_BYP,
+};
+
+/* bypss_bitmap_1 */
+enum {
+	EG_VLAN_MEMBER_CHECK_BYP = 0,
+	EG_VLAN_XLT_BYP,
+	EG_VLAN_TAG_FMT_CTRL_BYP,
+	FDB_LEARN_BYP,
+	FDB_REFRESH_BYP,
+	L2_SOURCE_SEC_BYP = 5,
+	MANAGEMENT_FWD_BYP,
+	BRIDGING_FWD_BYP,
+	IN_STP_FLTR_BYP,
+	EG_STP_FLTR_BYP,
+	SOURCE_FLTR_BYP = 10,
+	POLICER_BYP,
+	L2_PKT_EDIT_BYP,
+	L3_PKT_EDIT_BYP,
+	ACL_POST_ROUTING_CHECK_BYP,
+	PORT_ISOLATION_BYP = 15,
+	PRE_ACL_QOS_BYP,
+	POST_ACL_QOS_BYP,
+	DSCP_QOS_BYP,
+	PCP_QOS_BYP,
+	PREHEADER_QOS_BYP = 20,
+	FAKE_MAC_DROP_BYP,
+	TUNL_CONTEXT_BYP,
+	FLOW_POLICER_BYP,
+};
+
+/* bypss_bitmap_2 */
+enum {
+	RX_VLAN_COUNTER_BYP = 0,
+	RX_COUNTER_BYP,
+	TX_VLAN_COUNTER_BYP,
+	TX_COUNTER_BYP,
+};
+
+/* bypass_bitmap_3 */
+enum {
+	TL_SERVICE_CODE_BYP = 0,
+	TL_BYP,
+	TL_L3_IF_CHECK_BYP,
+	TL_VLAN_CHECK_BYP,
+	TL_DMAC_CHECK_BYP,
+	TL_UDP_CSUM_0_CHECK_BYP = 5,
+	TL_TBL_DE_ACCE_CHECK_BYP,
+	TL_PPPOE_MC_TERM_CHECK_BYP,
+	TL_TTL_EXCEED_CHECK_BYP,
+	TL_MAP_SRC_CHECK_BYP,
+	TL_MAP_DST_CHECK_BYP = 10,
+	TL_LPM_DST_LOOKUP_BYP,
+	TL_LPM_LOOKUP_BYP,
+	TL_WRONG_PKT_FMT_L2_BYP,
+	TL_WRONG_PKT_FMT_L3_IPV4_BYP,
+	TL_WRONG_PKT_FMT_L3_IPV6_BYP = 15,
+	TL_WRONG_PKT_FMT_L4_BYP,
+	TL_WRONG_PKT_FMT_TUNNEL_BYP,
+	TL_PRE_IPO_BYP = 20,
+};
+
+/* PPE service code is used to bypass hardware handler when the packet pass
+ * through PPE, the supported service code number is 256.
+ */
+struct ppe_servcode_cfg {
+	bool dest_port_valid;
+	int dest_port;
+	u32 bypass_bitmap[4];
+	bool is_src;
+	int field_update_bitmap;
+	int next_service_code;
+	int hw_service;
+	int offset_sel;
+};
+
 /* The operations are used to configure the PPE queue related resource */
 struct ppe_queue_ops {
 	int (*queue_scheduler_set)(struct ppe_device *ppe_dev,
@@ -76,4 +179,8 @@ struct ppe_queue_ops {
 };
 
 const struct ppe_queue_ops *ppe_queue_config_ops_get(void);
+
+int ppe_servcode_config_set(struct ppe_device *ppe_dev,
+			    int servcode,
+			    struct ppe_servcode_cfg cfg);
 #endif
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
index 9fdb9592b44b..66ddfd5cd123 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
@@ -23,9 +23,71 @@
 #define PPE_BM_TDM_CFG_TBL_SECOND_PORT_VALID			BIT(6)
 #define PPE_BM_TDM_CFG_TBL_SECOND_PORT				GENMASK(11, 8)
 
+#define PPE_SERVICE_TBL						0x15000
+#define PPE_SERVICE_TBL_NUM					256
+#define PPE_SERVICE_TBL_INC					0x10
+#define PPE_SERVICE_TBL_BYPASS_BITMAP				GENMASK(31, 0)
+#define PPE_SERVICE_TBL_RX_COUNTING_EN				BIT(32)
+
+/* service code for the ingress packet, the PPE features can be bypassed
+ * with service config.
+ */
+struct ppe_service_cfg {
+	u32 bypass_bitmap;
+	u32 rx_counting_en:1,
+	    res0:31;
+};
+
+union ppe_service_cfg_u {
+	u32 val[2];
+	struct ppe_service_cfg bf;
+};
+
 #define PPE_EG_BRIDGE_CONFIG					0x20044
 #define PPE_EG_BRIDGE_CONFIG_QUEUE_CNT_EN			BIT(2)
 
+#define PPE_EG_SERVICE_TBL					0x43000
+#define PPE_EG_SERVICE_TBL_NUM					256
+#define PPE_EG_SERVICE_TBL_INC					0x10
+
+/* service code config for the egress packet, the new service code can be
+ * generated and ath header can be configured.
+ */
+struct ppe_eg_service_cfg {
+	u32 field_update_action;
+	u32 next_service_code:8,
+	    hw_services:6,
+	    offset_sel:1,
+	    tx_counting_en:1,
+	    ip_length_update:1,
+	    ath_hdr_insert_dis:1,
+	    ath_hdr_type:3,
+	    ath_from_cpu:1,
+	    ath_disable_bit:1,
+	    ath_port_bitmap:7,
+	    res0:2;
+};
+
+union ppe_eg_service_cfg_u {
+	u32 val[2];
+	struct ppe_eg_service_cfg bf;
+};
+
+#define PPE_IN_L2_SERVICE_TBL					0x66000
+#define PPE_IN_L2_SERVICE_TBL_NUM				256
+#define PPE_IN_L2_SERVICE_TBL_INC				0x10
+#define PPE_IN_L2_SERVICE_TBL_DST_PORT_ID_VALID			BIT(0)
+#define PPE_IN_L2_SERVICE_TBL_DST_PORT_ID			GENMASK(4, 1)
+#define PPE_IN_L2_SERVICE_TBL_DST_DIRECTION			BIT(5)
+#define PPE_IN_L2_SERVICE_TBL_DST_BYPASS_BITMAP			GENMASK(29, 6)
+#define PPE_IN_L2_SERVICE_TBL_RX_CNT_EN				BIT(30)
+#define PPE_IN_L2_SERVICE_TBL_TX_CNT_EN				BIT(31)
+
+#define PPE_TL_SERVICE_TBL					0x306000
+#define PPE_TL_SERVICE_TBL_NUM					256
+#define PPE_TL_SERVICE_TBL_INC					4
+#define PPE_TL_SERVICE_TBL_BYPASS_BITMAP			GENMASK(31, 0)
+
 #define PPE_PSCH_TDM_DEPTH_CFG					0x400000
 #define PPE_PSCH_TDM_DEPTH_CFG_NUM				1
 #define PPE_PSCH_TDM_DEPTH_CFG_INC				4
-- 
2.42.0


