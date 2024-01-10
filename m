Return-Path: <linux-kernel+bounces-22124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF118299AD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E2941C259BE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10E14C3B1;
	Wed, 10 Jan 2024 11:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WaTr5Ati"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C72347F61;
	Wed, 10 Jan 2024 11:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40A8eEdu022800;
	Wed, 10 Jan 2024 11:43:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=Qf2WPleeirlifByI4BG67UHUNLw0nveqotq4R5OSAUQ=; b=Wa
	Tr5Ati/Gin64tdO0CpimNPILY+hGqVYSGW3PzpGN49+xlIJAhbZ1BNIu+wvZXRXF
	iRlyLNe3tF5it/mDfSjhs/Z4vV/wIX8o8B2VEt8HFJ/KFvl18t0LCOH6Pqnf3gcf
	m3v0hPlyOhB5PRlbwNbDjRTY/q1VXeuioYZfh9yZRd+6Yb98tMUgpMlvrWhQW3QQ
	t+nJAcZRC+J337uyG6ZyWFeV3kdbtJoH2KbM5ckIhdrEv0U4pp68O04hnaIri7UJ
	HGZNamBzjN6qrMUxVPwK1B2EJPSwUmVaivldIOep0NMgP0SlDmb8AfInB4f/6dkO
	ww8zpH3hFsnEuhm9Y21A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh9vfj64r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:43:47 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40ABhkOl008393
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:43:46 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 03:43:36 -0800
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
Subject: [PATCH net-next 16/20] net: ethernet: qualcomm: Add PPE L2 bridge initialization
Date: Wed, 10 Jan 2024 19:40:28 +0800
Message-ID: <20240110114033.32575-17-quic_luoj@quicinc.com>
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
X-Proofpoint-GUID: pXo3J6gbFD-h4LmHcYTH1GwRdbvRb1pk
X-Proofpoint-ORIG-GUID: pXo3J6gbFD-h4LmHcYTH1GwRdbvRb1pk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 adultscore=0 bulkscore=0 mlxlogscore=942 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100096

From: Lei Wei <quic_leiwei@quicinc.com>

Add PPE L2 bridge initialization. The default per-port
settings are as follows: For PPE physical port, the L2
learning is enabled and the forward action is initialized
to forward to CPU port. The PPE bridge tx is also enabled
for PPE CPU port and disabled for PPE physical port.

Signed-off-by: Lei Wei <quic_leiwei@quicinc.com>
Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/ethernet/qualcomm/ppe/ppe.c      |  78 ++++++++++++++
 drivers/net/ethernet/qualcomm/ppe/ppe.h      |  10 ++
 drivers/net/ethernet/qualcomm/ppe/ppe_regs.h | 102 +++++++++++++++++++
 3 files changed, 190 insertions(+)

diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.c b/drivers/net/ethernet/qualcomm/ppe/ppe.c
index 71973bce2cd2..04f80589c05b 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe.c
@@ -1260,6 +1260,80 @@ static int ppe_rss_hash_init(struct ppe_device *ppe_dev)
 						  hash_cfg);
 }
 
+static int ppe_bridge_init(struct ppe_device *ppe_dev)
+{
+	union ppe_l2_vp_port_tbl_u port_tbl;
+	union ppe_vsi_tbl_u vsi_tbl;
+	u32 reg_val = 0;
+	int i = 0;
+
+	/* CPU port0 initialization */
+	reg_val = FIELD_PREP(PPE_PORT_BRIDGE_CTRL_ISOLATION_BITMAP, 0x7F) |
+			PPE_PORT_BRIDGE_CTRL_PROMISC_EN;
+	ppe_mask(ppe_dev,
+		 PPE_PORT_BRIDGE_CTRL + PPE_PORT_BRIDGE_CTRL_INC * PPE_PORT0,
+		 PPE_PORT_BRIDGE_CTRL_MASK,
+		 reg_val | PPE_PORT_BRIDGE_CTRL_TXMAC_EN);
+
+	/* Physical and virtual physical port initialization */
+	reg_val |= (PPE_PORT_BRIDGE_CTRL_STATION_MODE_LRN_EN |
+			PPE_PORT_BRIDGE_CTRL_NEW_ADDR_LRN_EN);
+	for (i = PPE_PORT1; i <= PPE_PORT6; i++) {
+		ppe_mask(ppe_dev,
+			 PPE_PORT_BRIDGE_CTRL + PPE_PORT_BRIDGE_CTRL_INC * i,
+			 PPE_PORT_BRIDGE_CTRL_MASK,
+			 reg_val);
+
+		/* Invalid vsi fowarding to CPU port0 */
+		memset(&port_tbl, 0, sizeof(port_tbl));
+		ppe_read_tbl(ppe_dev,
+			     PPE_L2_VP_PORT_TBL + PPE_L2_VP_PORT_TBL_INC * i,
+			     port_tbl.val,
+			     sizeof(port_tbl.val));
+		port_tbl.bf.invalid_vsi_forwarding_en = true;
+		port_tbl.bf.dst_info = PPE_PORT0;
+		ppe_write_tbl(ppe_dev,
+			      PPE_L2_VP_PORT_TBL + PPE_L2_VP_PORT_TBL_INC * i,
+			      port_tbl.val,
+			      sizeof(port_tbl.val));
+	}
+
+	/* Internal port7 initialization */
+	ppe_mask(ppe_dev,
+		 PPE_PORT_BRIDGE_CTRL + PPE_PORT_BRIDGE_CTRL_INC * PPE_PORT7,
+		 PPE_PORT_BRIDGE_CTRL_MASK,
+		 reg_val | PPE_PORT_BRIDGE_CTRL_TXMAC_EN);
+
+	/* Enable Global L2 Learn and Ageing */
+	ppe_mask(ppe_dev,
+		 PPE_L2_GLOBAL_CONFIG,
+		 PPE_L2_GLOBAL_CONFIG_LRN_EN | PPE_L2_GLOBAL_CONFIG_AGE_EN,
+		 PPE_L2_GLOBAL_CONFIG_LRN_EN | PPE_L2_GLOBAL_CONFIG_AGE_EN);
+
+	/* Vsi initialization */
+	for (i = 0; i < PPE_VSI_TBL_NUM; i++) {
+		memset(&vsi_tbl, 0, sizeof(vsi_tbl));
+		ppe_read_tbl(ppe_dev,
+			     PPE_VSI_TBL + PPE_VSI_TBL_INC * i,
+			     vsi_tbl.val,
+			     sizeof(vsi_tbl.val));
+		vsi_tbl.bf.member_port_bitmap = BIT(PPE_PORT0);
+		vsi_tbl.bf.uuc_bitmap = BIT(PPE_PORT0);
+		vsi_tbl.bf.umc_bitmap = BIT(PPE_PORT0);
+		vsi_tbl.bf.bc_bitmap = BIT(PPE_PORT0);
+		vsi_tbl.bf.new_addr_lrn_en = true;
+		vsi_tbl.bf.new_addr_fwd_cmd = 0;
+		vsi_tbl.bf.station_move_lrn_en = true;
+		vsi_tbl.bf.station_move_fwd_cmd = 0;
+		ppe_write_tbl(ppe_dev,
+			      PPE_VSI_TBL + PPE_VSI_TBL_INC * i,
+			      vsi_tbl.val,
+			      sizeof(vsi_tbl.val));
+	}
+
+	return 0;
+}
+
 static int ppe_dev_hw_init(struct ppe_device *ppe_dev)
 {
 	int ret;
@@ -1276,6 +1350,10 @@ static int ppe_dev_hw_init(struct ppe_device *ppe_dev)
 	if (ret)
 		return ret;
 
+	ret = ppe_bridge_init(ppe_dev);
+	if (ret)
+		return ret;
+
 	return ppe_rss_hash_init(ppe_dev);
 }
 
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.h b/drivers/net/ethernet/qualcomm/ppe/ppe.h
index 507626b6ab2e..828d467540c9 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe.h
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe.h
@@ -11,6 +11,16 @@
 #include <linux/clk.h>
 #include <linux/reset.h>
 
+/* PPE Ports */
+#define PPE_PORT0		0
+#define PPE_PORT1		1
+#define PPE_PORT2		2
+#define PPE_PORT3		3
+#define PPE_PORT4		4
+#define PPE_PORT5		5
+#define PPE_PORT6		6
+#define PPE_PORT7		7
+
 enum ppe_clk_id {
 	/* clocks for CMN PLL */
 	PPE_CMN_AHB_CLK,
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
index 98bf19f974ce..13115405bad9 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
@@ -238,6 +238,39 @@ union ppe_eg_service_cfg_u {
 #define PPE_TX_BUFF_THRSH_XOFF					GENMASK(7, 0)
 #define PPE_TX_BUFF_THRSH_XON					GENMASK(15, 8)
 
+#define PPE_L2_GLOBAL_CONFIG					0x60038
+#define PPE_L2_GLOBAL_CONFIG_LRN_EN				BIT(6)
+#define PPE_L2_GLOBAL_CONFIG_AGE_EN				BIT(7)
+
+#define PPE_MIRROR_ANALYZER					0x60040
+#define PPE_MIRROR_ANALYZER_NUM					1
+#define PPE_MIRROR_ANALYZER_INC					4
+#define PPE_MIRROR_ANALYZER_INGRESS_PORT			GENMASK(5, 0)
+#define PPE_MIRROR_ANALYZER_EGRESS_PORT				GENMASK(13, 8)
+
+#define PPE_PORT_BRIDGE_CTRL					0x60300
+#define PPE_PORT_BRIDGE_CTRL_NUM				8
+#define PPE_PORT_BRIDGE_CTRL_INC				4
+#define PPE_PORT_BRIDGE_CTRL_NEW_ADDR_LRN_EN			BIT(0)
+#define PPE_PORT_BRIDGE_CTRL_NEW_ADDR_FWD_CMD			GENMASK(2, 1)
+#define PPE_PORT_BRIDGE_CTRL_STATION_MODE_LRN_EN		BIT(3)
+#define PPE_PORT_BRIDGE_CTRL_STATION_MODE_FWD_CMD		GENMASK(5, 4)
+#define PPE_PORT_BRIDGE_CTRL_ISOLATION_BITMAP			GENMASK(15, 8)
+#define PPE_PORT_BRIDGE_CTRL_TXMAC_EN				BIT(16)
+#define PPE_PORT_BRIDGE_CTRL_PROMISC_EN				BIT(17)
+#define PPE_PORT_BRIDGE_CTRL_MASK				GENMASK(17, 0)
+
+#define PPE_PORT_MIRROR						0x60800
+#define PPE_PORT_MIRROR_NUM					8
+#define PPE_PORT_MIRROR_INC					4
+#define PPE_PORT_MIRROR_INGRESS_EN				BIT(0)
+#define PPE_PORT_MIRROR_EGRESS_EN				BIT(1)
+
+#define PPE_CST_STATE						0x60100
+#define PPE_CST_STATE_NUM					8
+#define PPE_CST_STATE_INC					4
+#define PPE_CST_STATE_PORT_STATE				GENMASK(1, 0)
+
 #define PPE_MC_MTU_CTRL_TBL					0x60a00
 #define PPE_MC_MTU_CTRL_TBL_NUM					8
 #define PPE_MC_MTU_CTRL_TBL_INC					4
@@ -245,6 +278,28 @@ union ppe_eg_service_cfg_u {
 #define PPE_MC_MTU_CTRL_TBL_MTU_CMD				GENMASK(15, 14)
 #define PPE_MC_MTU_CTRL_TBL_TX_CNT_EN				BIT(16)
 
+#define PPE_VSI_TBL						0x63800
+#define PPE_VSI_TBL_NUM						64
+#define PPE_VSI_TBL_INC						0x10
+
+/* PPE vsi configurations */
+struct ppe_vsi_tbl {
+	u32 member_port_bitmap:8,
+	    uuc_bitmap:8,
+	    umc_bitmap:8,
+	    bc_bitmap:8;
+	u32 new_addr_lrn_en:1,
+	    new_addr_fwd_cmd:2,
+	    station_move_lrn_en:1,
+	    station_move_fwd_cmd:2,
+	    res0:26;
+};
+
+union ppe_vsi_tbl_u {
+	u32 val[2];
+	struct ppe_vsi_tbl bf;
+};
+
 #define PPE_MRU_MTU_CTRL_TBL					0x65000
 #define PPE_MRU_MTU_CTRL_TBL_NUM				256
 #define PPE_MRU_MTU_CTRL_TBL_INC				0x10
@@ -295,6 +350,53 @@ union ppe_mru_mtu_ctrl_cfg_u {
 #define PPE_IN_L2_SERVICE_TBL_RX_CNT_EN				BIT(30)
 #define PPE_IN_L2_SERVICE_TBL_TX_CNT_EN				BIT(31)
 
+#define PPE_L2_VP_PORT_TBL					0x98000
+#define PPE_L2_VP_PORT_TBL_NUM					256
+#define PPE_L2_VP_PORT_TBL_INC					0x10
+
+/* Port configurations */
+struct ppe_l2_vp_port_tbl {
+	u32 invalid_vsi_forwarding_en:1,
+	    promisc_en:1,
+	    dst_info:8,
+	    physical_port:3,
+	    new_addr_lrn_en:1,
+	    new_addr_fwd_cmd:2,
+	    station_move_lrn_en:1,
+	    station_move_fwd_cmd:2,
+	    lrn_lmt_cnt:12,
+	    lrn_lmt_en:1;
+	u32 lrn_lmt_exceed_fwd:2,
+	    eg_vlan_fltr_cmd:1,
+	    port_isolation_bitmap:8,
+	    isol_profile:6,
+	    isol_en:1,
+	    policer_en:1,
+	    policer_index:9,
+	    vp_state_check_en:1,
+	    vp_type:1,
+	    vp_context_active:1,
+	    vp_eg_data_valid:1;
+	u32 physical_port_mtu_check_en:1,
+	    mtu_check_type:1,
+	    extra_header_len:8,
+	    eg_vlan_fmt_valid:1,
+	    eg_stag_fmt:1,
+	    eg_ctag_fmt:1,
+	    exception_fmt_ctrl:1,
+	    enq_service_code_en:1,
+	    enq_service_code:8,
+	    enq_phy_port:3,
+	    app_ctrl_profile_0:6;
+	u32 app_ctrl_profile_1:2,
+	    res0:30;
+};
+
+union ppe_l2_vp_port_tbl_u {
+	u32 val[4];
+	struct ppe_l2_vp_port_tbl bf;
+};
+
 #define PPE_PORT_RX_CNT_TBL					0x150000
 #define PPE_PORT_RX_CNT_TBL_NUM					256
 #define PPE_PORT_RX_CNT_TBL_INC					0x20
-- 
2.42.0


