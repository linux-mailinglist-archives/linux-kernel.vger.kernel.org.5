Return-Path: <linux-kernel+bounces-22120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4B3829994
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F6E1F25906
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282764878C;
	Wed, 10 Jan 2024 11:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jlUuGLgk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7EA4BA88;
	Wed, 10 Jan 2024 11:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40A8cuZc016858;
	Wed, 10 Jan 2024 11:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=HBiFy42qBlaFvrnH9YHTSHnmPsM9rV0K5AEc3oKwSrA=; b=jl
	UuGLgkaZJjBWEvYOeme39jnr/jdO3zhK5LcX6p9UlIIUgBxFrXFuXMuzvnA0xd9O
	JS8jzuN5hpHtfjmosD0QZQvtVvZxmYhbYZLU7VJ/bgIIsKtewQ0kqCXIL6ztsjda
	PTpiR0kPJ1rmSi+86xixRBLTasZ4RpThBjBb6Bsv+ME4BzUg/aXYla7gSFYSulCW
	+TA9Be02tmD5lubngL4PTyZqjhG/CMDg3RU3+cR+ayXuJrm9yEZwKxT6/AJaYhl9
	AvDfcaR8fgYLI5FtEt/3x4iAZzX6eIF2gMSxHwsUWM8w6azIz9jb3uRzLGxmXFwS
	+r+yZU/pGlybSpP7SAqQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhkem0wqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:42:57 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40ABgu1s007560
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:42:56 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 03:42:46 -0800
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
Subject: [PATCH net-next 11/20] net: ethernet: qualcomm: Add PPE port control config
Date: Wed, 10 Jan 2024 19:40:23 +0800
Message-ID: <20240110114033.32575-12-quic_luoj@quicinc.com>
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
X-Proofpoint-ORIG-GUID: mTifMKrqsOpyC9mm8_I2ywpB7iO33oSp
X-Proofpoint-GUID: mTifMKrqsOpyC9mm8_I2ywpB7iO33oSp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100096

1. Enable the port statistics counter for the physical port.

2. Configure the default action as drop when the packet size is more
   than the configured MTU of physical port.

3. For IPQ5322, the number of PPE port is 3.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/ethernet/qualcomm/ppe/ppe.c      | 60 ++++++++++++++++-
 drivers/net/ethernet/qualcomm/ppe/ppe.h      | 10 +++
 drivers/net/ethernet/qualcomm/ppe/ppe_ops.c  | 22 +++++++
 drivers/net/ethernet/qualcomm/ppe/ppe_ops.h  |  1 +
 drivers/net/ethernet/qualcomm/ppe/ppe_regs.h | 69 ++++++++++++++++++++
 5 files changed, 161 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.c b/drivers/net/ethernet/qualcomm/ppe/ppe.c
index acff37f9d832..bce0a9137c9f 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe.c
@@ -18,6 +18,7 @@
 #include "ppe_ops.h"
 
 #define PPE_SCHEDULER_PORT_NUM		8
+#define MPPE_SCHEDULER_PORT_NUM		3
 #define PPE_SCHEDULER_L0_NUM		300
 #define PPE_SCHEDULER_L1_NUM		64
 #define PPE_SP_PRIORITY_NUM		8
@@ -1118,6 +1119,59 @@ static int ppe_servcode_init(struct ppe_device *ppe_dev)
 	return ppe_servcode_config_set(ppe_dev, 1, servcode_cfg);
 }
 
+static int ppe_port_ctrl_init(struct ppe_device *ppe_dev)
+{
+	union ppe_mru_mtu_ctrl_cfg_u mru_mtu_cfg;
+	int ret, port_num = PPE_SCHEDULER_PORT_NUM;
+	u32 reg_val;
+
+	if (ppe_type_get(ppe_dev) == PPE_TYPE_MPPE) {
+		for (ret = 0; ret < MPPE_SCHEDULER_PORT_NUM; ret++) {
+			reg_val = FIELD_PREP(PPE_TX_BUFF_THRSH_XOFF, 3) |
+				  FIELD_PREP(PPE_TX_BUFF_THRSH_XON, 3);
+			ppe_write(ppe_dev, PPE_TX_BUFF_THRSH + PPE_TX_BUFF_THRSH_INC * ret,
+				  reg_val);
+
+			/* Fix 147B line rate on physical port */
+			if (ret != 0)
+				ppe_mask(ppe_dev, PPE_RX_FIFO_CFG + PPE_RX_FIFO_CFG_INC * ret,
+					 PPE_RX_FIFO_CFG_THRSH,
+					 FIELD_PREP(PPE_RX_FIFO_CFG_THRSH, 7));
+		}
+
+		port_num = MPPE_SCHEDULER_PORT_NUM;
+	}
+
+	for (ret = 0; ret < port_num; ret++) {
+		if (ret != 0) {
+			memset(&mru_mtu_cfg, 0, sizeof(mru_mtu_cfg));
+			ppe_read_tbl(ppe_dev,
+				     PPE_MRU_MTU_CTRL_TBL + PPE_MRU_MTU_CTRL_TBL_INC * ret,
+				     mru_mtu_cfg.val, sizeof(mru_mtu_cfg.val));
+
+			/* Drop the packet when the packet size is more than
+			 * the MTU of the physical interface.
+			 */
+			mru_mtu_cfg.bf.mru_cmd = PPE_ACTION_DROP;
+			mru_mtu_cfg.bf.mtu_cmd = PPE_ACTION_DROP;
+
+			ppe_write_tbl(ppe_dev,
+				      PPE_MRU_MTU_CTRL_TBL + PPE_MRU_MTU_CTRL_TBL_INC * ret,
+				      mru_mtu_cfg.val, sizeof(mru_mtu_cfg.val));
+
+			ppe_mask(ppe_dev,
+				 PPE_MC_MTU_CTRL_TBL + PPE_MC_MTU_CTRL_TBL_INC * ret,
+				 PPE_MC_MTU_CTRL_TBL_MTU_CMD,
+				 FIELD_PREP(PPE_MC_MTU_CTRL_TBL_MTU_CMD, PPE_ACTION_DROP));
+		}
+
+		/* Enable PPE port counter */
+		ppe_counter_set(ppe_dev, ret, true);
+	}
+
+	return 0;
+}
+
 static int ppe_dev_hw_init(struct ppe_device *ppe_dev)
 {
 	int ret;
@@ -1126,7 +1180,11 @@ static int ppe_dev_hw_init(struct ppe_device *ppe_dev)
 	if (ret)
 		return ret;
 
-	return ppe_servcode_init(ppe_dev);
+	ret = ppe_servcode_init(ppe_dev);
+	if (ret)
+		return ret;
+
+	return ppe_port_ctrl_init(ppe_dev);
 }
 
 static int qcom_ppe_probe(struct platform_device *pdev)
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.h b/drivers/net/ethernet/qualcomm/ppe/ppe.h
index 84b1c9761f79..507626b6ab2e 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe.h
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe.h
@@ -132,6 +132,16 @@ enum {
 	PPE_TYPE_MAX = 0xff,
 };
 
+/* The action of packet received by PPE can be forwarded, dropped, copied
+ * to CPU(enter multicast queue), redirected to CPU(enter unicast queue).
+ */
+enum {
+	PPE_ACTION_FORWARD = 0,
+	PPE_ACTION_DROP,
+	PPE_ACTION_COPY_TO_CPU,
+	PPE_ACTION_REDIRECTED_TO_CPU
+};
+
 /* PPE private data of different PPE type device */
 struct ppe_data {
 	int ppe_type;
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_ops.c b/drivers/net/ethernet/qualcomm/ppe/ppe_ops.c
index a3269c0898be..b017983e7cbf 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_ops.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_ops.c
@@ -311,6 +311,28 @@ int ppe_servcode_config_set(struct ppe_device *ppe_dev,
 	return ppe_write(ppe_dev, PPE_TL_SERVICE_TBL + PPE_TL_SERVICE_TBL_INC * servcode, val);
 }
 
+int ppe_counter_set(struct ppe_device *ppe_dev, int port, bool enable)
+{
+	union ppe_mru_mtu_ctrl_cfg_u mru_mtu_cfg;
+
+	memset(&mru_mtu_cfg, 0, sizeof(mru_mtu_cfg));
+
+	ppe_read_tbl(ppe_dev, PPE_MRU_MTU_CTRL_TBL + PPE_MRU_MTU_CTRL_TBL_INC * port,
+		     mru_mtu_cfg.val, sizeof(mru_mtu_cfg.val));
+	mru_mtu_cfg.bf.rx_cnt_en = enable;
+	mru_mtu_cfg.bf.tx_cnt_en = enable;
+	ppe_write_tbl(ppe_dev, PPE_MRU_MTU_CTRL_TBL + PPE_MRU_MTU_CTRL_TBL_INC * port,
+		      mru_mtu_cfg.val, sizeof(mru_mtu_cfg.val));
+
+	ppe_mask(ppe_dev, PPE_MC_MTU_CTRL_TBL + PPE_MC_MTU_CTRL_TBL_INC * port,
+		 PPE_MC_MTU_CTRL_TBL_TX_CNT_EN,
+		 FIELD_PREP(PPE_MC_MTU_CTRL_TBL_TX_CNT_EN, enable));
+
+	return ppe_mask(ppe_dev, PPE_PORT_EG_VLAN + PPE_PORT_EG_VLAN_INC * port,
+			PPE_PORT_EG_VLAN_TX_COUNTING_EN,
+			FIELD_PREP(PPE_PORT_EG_VLAN_TX_COUNTING_EN, enable));
+}
+
 static const struct ppe_queue_ops qcom_ppe_queue_config_ops = {
 	.queue_scheduler_set = ppe_queue_scheduler_set,
 	.queue_scheduler_get = ppe_queue_scheduler_get,
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_ops.h b/drivers/net/ethernet/qualcomm/ppe/ppe_ops.h
index b3c1ade7c948..ab64a760b60b 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_ops.h
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_ops.h
@@ -183,4 +183,5 @@ const struct ppe_queue_ops *ppe_queue_config_ops_get(void);
 int ppe_servcode_config_set(struct ppe_device *ppe_dev,
 			    int servcode,
 			    struct ppe_servcode_cfg cfg);
+int ppe_counter_set(struct ppe_device *ppe_dev, int port, bool enable);
 #endif
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
index 66ddfd5cd123..3e61de54f921 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
@@ -14,6 +14,11 @@
 #define PPE_BM_TDM_CTRL_TDM_OFFSET				GENMASK(14, 8)
 #define PPE_BM_TDM_CTRL_TDM_EN					BIT(31)
 
+#define PPE_RX_FIFO_CFG						0xb004
+#define PPE_RX_FIFO_CFG_NUM					8
+#define PPE_RX_FIFO_CFG_INC					4
+#define PPE_RX_FIFO_CFG_THRSH					GENMASK(2, 0)
+
 #define PPE_BM_TDM_CFG_TBL					0xc000
 #define PPE_BM_TDM_CFG_TBL_NUM					128
 #define PPE_BM_TDM_CFG_TBL_INC					0x10
@@ -43,6 +48,17 @@ union ppe_service_cfg_u {
 	struct ppe_service_cfg bf;
 };
 
+#define PPE_PORT_EG_VLAN					0x20020
+#define PPE_PORT_EG_VLAN_NUM					8
+#define PPE_PORT_EG_VLAN_INC					4
+#define PPE_PORT_EG_VLAN_PORT_VLAN_TYPE				BIT(0)
+#define PPE_PORT_EG_VLAN_PORT_EG_VLAN_CTAG_MODE			GENMASK(2, 1)
+#define PPE_PORT_EG_VLAN_PORT_EG_VLAN_STAG_MODE			GENMASK(4, 3)
+#define PPE_PORT_EG_VLAN_VSI_TAG_MODE_EN			BIT(5)
+#define PPE_PORT_EG_VLAN_PORT_EG_PCP_PROP_CMD			BIT(6)
+#define PPE_PORT_EG_VLAN_PORT_EG_DEI_PROP_CMD			BIT(7)
+#define PPE_PORT_EG_VLAN_TX_COUNTING_EN				BIT(8)
+
 #define PPE_EG_BRIDGE_CONFIG					0x20044
 #define PPE_EG_BRIDGE_CONFIG_QUEUE_CNT_EN			BIT(2)
 
@@ -73,6 +89,59 @@ union ppe_eg_service_cfg_u {
 	struct ppe_eg_service_cfg bf;
 };
 
+#define PPE_TX_BUFF_THRSH					0x26100
+#define PPE_TX_BUFF_THRSH_NUM					8
+#define PPE_TX_BUFF_THRSH_INC					4
+#define PPE_TX_BUFF_THRSH_XOFF					GENMASK(7, 0)
+#define PPE_TX_BUFF_THRSH_XON					GENMASK(15, 8)
+
+#define PPE_MC_MTU_CTRL_TBL					0x60a00
+#define PPE_MC_MTU_CTRL_TBL_NUM					8
+#define PPE_MC_MTU_CTRL_TBL_INC					4
+#define PPE_MC_MTU_CTRL_TBL_MTU					GENMASK(13, 0)
+#define PPE_MC_MTU_CTRL_TBL_MTU_CMD				GENMASK(15, 14)
+#define PPE_MC_MTU_CTRL_TBL_TX_CNT_EN				BIT(16)
+
+#define PPE_MRU_MTU_CTRL_TBL					0x65000
+#define PPE_MRU_MTU_CTRL_TBL_NUM				256
+#define PPE_MRU_MTU_CTRL_TBL_INC				0x10
+
+/* PPE port control configuration, the MTU and QoS are configured by
+ * this table.
+ */
+struct ppe_mru_mtu_ctrl_cfg {
+	u32 mru:14,
+	    mru_cmd:2,
+	    mtu:14,
+	    mtu_cmd:2;
+
+	u32 rx_cnt_en:1,
+	    tx_cnt_en:1,
+	    src_profile:2,
+	    pcp_qos_group_id:1,
+	    dscp_qos_group_id:1,
+	    pcp_res_prec_force:1,
+	    dscp_res_prec_force:1,
+	    preheader_res_prec:3,
+	    pcp_res_prec:3,
+	    dscp_res_prec:3,
+	    flow_res_prec:3,
+	    pre_acl_res_prec:3,
+	    post_acl_res_prec:3,
+	    source_filtering_bypass:1,
+	    source_filtering_mode:1,
+	    pre_ipo_outer_res_prec:3,
+	    pre_ipo_inner_res_prec_0:1;
+
+	u32 pre_ipo_inner_res_prec_1:2,
+	    res0:30;
+};
+
+union ppe_mru_mtu_ctrl_cfg_u {
+	u32 val[3];
+	struct ppe_mru_mtu_ctrl_cfg bf;
+};
+
 #define PPE_IN_L2_SERVICE_TBL					0x66000
 #define PPE_IN_L2_SERVICE_TBL_NUM				256
 #define PPE_IN_L2_SERVICE_TBL_INC				0x10
-- 
2.42.0


