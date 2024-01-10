Return-Path: <linux-kernel+bounces-22117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E43829988
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63006B24C68
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F404A981;
	Wed, 10 Jan 2024 11:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mnTObix7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478F948CD0;
	Wed, 10 Jan 2024 11:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40A8uJcV019169;
	Wed, 10 Jan 2024 11:42:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=KXa545erCC7IL/SR3Q1tYN9da3OhrBWH5vwzqsjR1kk=; b=mn
	TObix73RwHCs9yIHc+2g5h++yXZz1gq1U45WV07B1DEG3F4+W4FgNrNz6nKaS8X6
	RBSnFNNlC3TYp8qoLItz7hJbMO1iJ/EDq1AQrgQOutVTEMYBy4Gh1g6MKI5TdRaV
	4dd5ZyQY5LD4WqcctGU/yXY+XO6BUVMfRGeR03bWwCBwZP6eMQxPQjMYiS673JIL
	WhE5NFxrMV3oqnoUxQmKCppR+7KUr4bgpK7d949O8sUuhzakdfsorrzb6PDvweKc
	AR8+GZh+aiOpmOqL2tkzglk5mEdZmjZo4kUKPwtfsOg9m80dYMDyxvYODSHy925H
	mOLb0RaRRm6B1s9VfQPA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh9vfj5xy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:42:12 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40ABfuQJ019414
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:41:56 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 03:41:46 -0800
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
Subject: [PATCH net-next 05/20] net: ethernet: qualcomm: Add PPE queue management config
Date: Wed, 10 Jan 2024 19:40:17 +0800
Message-ID: <20240110114033.32575-6-quic_luoj@quicinc.com>
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
X-Proofpoint-GUID: 9TXgj9jodKNsLq6Ckt0_0WO-00vA_jJW
X-Proofpoint-ORIG-GUID: 9TXgj9jodKNsLq6Ckt0_0WO-00vA_jJW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100096

QM(queue management) config decides the length of queue and the
threshold to drop packet, there are two kinds of queue, unicast
queue and multicast queue to transmit different type of packet.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/ethernet/qualcomm/ppe/ppe.c      | 158 ++++++++++++++++++-
 drivers/net/ethernet/qualcomm/ppe/ppe_regs.h | 106 +++++++++++++
 2 files changed, 263 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.c b/drivers/net/ethernet/qualcomm/ppe/ppe.c
index 94fa13dd17da..122e325b407d 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe.c
@@ -475,10 +475,166 @@ static int of_parse_ppe_bm(struct ppe_device *ppe_dev,
 	return ret;
 }
 
+static int of_parse_ppe_qm(struct ppe_device *ppe_dev,
+			   struct device_node *ppe_node)
+{
+	union ppe_ac_uni_queue_cfg_u uni_queue_cfg;
+	union ppe_ac_mul_queue_cfg_u mul_queue_cfg;
+	union ppe_ac_grp_cfg_u group_cfg;
+	struct device_node *qm_node;
+	int ret, cnt, queue_id;
+	u32 *cfg;
+
+	qm_node = of_get_child_by_name(ppe_node, "queue-management-config");
+	if (!qm_node)
+		return dev_err_probe(ppe_dev->dev, -ENODEV,
+				     "Fail to get queue-management-config\n");
+
+	cnt = of_property_count_u32_elems(qm_node, "qcom,group-config");
+	if (cnt < 0)
+		return dev_err_probe(ppe_dev->dev, -ENODEV,
+				     "Fail to get qcom,group-config\n");
+
+	cfg = kmalloc_array(cnt, sizeof(*cfg), GFP_KERNEL | __GFP_ZERO);
+	if (!cfg)
+		return -ENOMEM;
+
+	ret = of_property_read_u32_array(qm_node, "qcom,group-config", cfg, cnt);
+	if (ret) {
+		dev_err(ppe_dev->dev, "Fail to get qcom,group-config\n");
+		goto parse_qm_err;
+	}
+
+	/* Parse QM group config:
+	 * qcom,group-config = <group total prealloc ceil resume_off>;
+	 *
+	 * For packet enqueue, there are two kinds of buffer type available,
+	 * queue based buffer and group(shared) buffer, the queue based buffer
+	 * is used firstly, then shared buffer used.
+	 *
+	 * Maximum 4 groups buffer supported by PPE.
+	 */
+	ret = 0;
+	while ((cnt - ret) / 5) {
+		memset(&group_cfg, 0, sizeof(group_cfg));
+
+		ppe_read_tbl(ppe_dev, PPE_AC_GRP_CFG_TBL +
+			     PPE_AC_GRP_CFG_TBL_INC * cfg[ret],
+			     group_cfg.val, sizeof(group_cfg.val));
+
+		group_cfg.bf.limit = cfg[ret + 1];
+		group_cfg.bf.prealloc_limit = cfg[ret + 2];
+		group_cfg.bf.dp_thrd_0 = cfg[ret + 3] & 0x3f;
+		group_cfg.bf.dp_thrd_1 = cfg[ret + 3] >> 7;
+		group_cfg.bf.grn_resume = cfg[ret + 4];
+
+		ppe_write_tbl(ppe_dev, PPE_AC_GRP_CFG_TBL +
+			      PPE_AC_GRP_CFG_TBL_INC * cfg[ret],
+			      group_cfg.val, sizeof(group_cfg.val));
+		ret += 5;
+	}
+
+	cnt = of_property_count_u32_elems(qm_node, "qcom,queue-config");
+	if (cnt < 0) {
+		dev_err(ppe_dev->dev, "Fail to get qcom,queue-config\n");
+		goto parse_qm_err;
+	}
+
+	cfg = krealloc_array(cfg, cnt, sizeof(*cfg), GFP_KERNEL | __GFP_ZERO);
+	if (!cfg) {
+		ret = -ENOMEM;
+		goto parse_qm_err;
+	}
+
+	ret = of_property_read_u32_array(qm_node, "qcom,queue-config", cfg, cnt);
+	if (ret) {
+		dev_err(ppe_dev->dev, "Fail to get qcom,queue-config\n");
+		goto parse_qm_err;
+	}
+
+	/* Parse queue based config:
+	 * qcom,queue-config = <queue_base queue_num group prealloc
+	 * ceil weight resume_off dynamic>;
+	 *
+	 * There are totally 256(queue id 0-255) unicast queues and 44(256-299)
+	 * multicast queues available in PPE, each queue is assigned the
+	 * dedicated buffer and ceil to drop packet, the unicast queue supports
+	 * static configured ceil value and dynamic ceil value that is adjusted
+	 * according to the available group buffers, multicast queue only supports
+	 * static ceil.
+	 */
+	ret = 0;
+	while ((cnt - ret) / 8) {
+		queue_id = 0;
+		while (queue_id < cfg[ret + 1]) {
+			if (cfg[ret] + queue_id < PPE_AC_UNI_QUEUE_CFG_TBL_NUM) {
+				memset(&uni_queue_cfg, 0, sizeof(uni_queue_cfg));
+
+				ppe_read_tbl(ppe_dev, PPE_AC_UNI_QUEUE_CFG_TBL +
+					     PPE_AC_UNI_QUEUE_CFG_TBL_INC * (cfg[ret] + queue_id),
+					     uni_queue_cfg.val, sizeof(uni_queue_cfg.val));
+
+				uni_queue_cfg.bf.ac_grp_id = cfg[ret + 2];
+				uni_queue_cfg.bf.prealloc_limit = cfg[ret + 3];
+				uni_queue_cfg.bf.shared_ceiling = cfg[ret + 4];
+				uni_queue_cfg.bf.shared_weight = cfg[ret + 5];
+				uni_queue_cfg.bf.grn_resume = cfg[ret + 6];
+				uni_queue_cfg.bf.shared_dynamic = cfg[ret + 7];
+				uni_queue_cfg.bf.ac_en = 1;
+
+				ppe_write_tbl(ppe_dev, PPE_AC_UNI_QUEUE_CFG_TBL +
+					      PPE_AC_UNI_QUEUE_CFG_TBL_INC * (cfg[ret] + queue_id),
+					      uni_queue_cfg.val, sizeof(uni_queue_cfg.val));
+			} else {
+				memset(&mul_queue_cfg, 0, sizeof(mul_queue_cfg));
+
+				ppe_read_tbl(ppe_dev, PPE_AC_MUL_QUEUE_CFG_TBL +
+					     PPE_AC_MUL_QUEUE_CFG_TBL_INC * (cfg[ret] + queue_id),
+					     mul_queue_cfg.val, sizeof(mul_queue_cfg.val));
+
+				mul_queue_cfg.bf.ac_grp_id = cfg[ret + 2];
+				mul_queue_cfg.bf.prealloc_limit = cfg[ret + 3];
+				mul_queue_cfg.bf.shared_ceiling = cfg[ret + 4];
+				mul_queue_cfg.bf.grn_resume = cfg[ret + 6];
+				mul_queue_cfg.bf.ac_en = 1;
+
+				ppe_write_tbl(ppe_dev, PPE_AC_MUL_QUEUE_CFG_TBL +
+					      PPE_AC_MUL_QUEUE_CFG_TBL_INC * (cfg[ret] + queue_id),
+					      mul_queue_cfg.val, sizeof(mul_queue_cfg.val));
+			}
+
+			ppe_mask(ppe_dev, PPE_ENQ_OPR_TBL +
+				 PPE_ENQ_OPR_TBL_INC * (cfg[ret] + queue_id),
+				 PPE_ENQ_OPR_TBL_DEQ_DISABLE, 0);
+
+			ppe_mask(ppe_dev, PPE_DEQ_OPR_TBL +
+				 PPE_DEQ_OPR_TBL_INC * (cfg[ret] + queue_id),
+				 PPE_ENQ_OPR_TBL_DEQ_DISABLE, 0);
+
+			queue_id++;
+		}
+		ret += 8;
+	}
+
+	/* Enable queue counter */
+	ret = ppe_mask(ppe_dev, PPE_EG_BRIDGE_CONFIG,
+		       PPE_EG_BRIDGE_CONFIG_QUEUE_CNT_EN,
+		       PPE_EG_BRIDGE_CONFIG_QUEUE_CNT_EN);
+parse_qm_err:
+	kfree(cfg);
+	return ret;
+}
+
 static int of_parse_ppe_config(struct ppe_device *ppe_dev,
 			       struct device_node *ppe_node)
 {
-	return of_parse_ppe_bm(ppe_dev, ppe_node);
+	int ret;
+
+	ret = of_parse_ppe_bm(ppe_dev, ppe_node);
+	if (ret)
+		return ret;
+
+	return of_parse_ppe_qm(ppe_dev, ppe_node);
 }
 
 static int qcom_ppe_probe(struct platform_device *pdev)
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
index e11d8f2a26b7..3e75b75fa48c 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
@@ -7,6 +7,14 @@
 #ifndef __PPE_REGS_H__
 #define __PPE_REGS_H__
 
+#define PPE_EG_BRIDGE_CONFIG					0x20044
+#define PPE_EG_BRIDGE_CONFIG_QUEUE_CNT_EN			BIT(2)
+
+#define PPE_DEQ_OPR_TBL						0x430000
+#define PPE_DEQ_OPR_TBL_NUM					300
+#define PPE_DEQ_OPR_TBL_INC					0x10
+#define PPE_ENQ_OPR_TBL_DEQ_DISABLE				BIT(0)
+
 #define PPE_BM_PORT_FC_MODE					0x600100
 #define PPE_BM_PORT_FC_MODE_NUM					15
 #define PPE_BM_PORT_FC_MODE_INC					4
@@ -46,4 +54,102 @@ union ppe_bm_port_fc_cfg_u {
 	struct ppe_bm_port_fc_cfg bf;
 };
 
+#define PPE_AC_UNI_QUEUE_CFG_TBL				0x848000
+#define PPE_AC_UNI_QUEUE_CFG_TBL_NUM				256
+#define PPE_AC_UNI_QUEUE_CFG_TBL_INC				0x10
+
+/* PPE unicast queue(0-255) configurations, the threshold supports to be
+ * configured static or dynamic.
+ *
+ * For dynamic threshold, the queue threshold depends on the remain buffer.
+ */
+struct ppe_ac_uni_queue_cfg {
+	u32 ac_en:1,
+	    wred_en:1,
+	    force_ac_en:1,
+	    color_aware:1,
+	    ac_grp_id:2,
+	    prealloc_limit:11,
+	    shared_dynamic:1,
+	    shared_weight:3,
+	    shared_ceiling:11;
+	u32 gap_grn_grn_min:11,
+	    gap_grn_yel_max:11,
+	    gap_grn_yel_min_0:10;
+	u32 gap_grn_yel_min_1:1,
+	    gap_grn_red_max:11,
+	    gap_grn_red_min:11,
+	    red_resume_0:9;
+	u32 red_resume_1:2,
+	    yel_resume:11,
+	    grn_resume:11,
+	    res0:8;
+};
+
+union ppe_ac_uni_queue_cfg_u {
+	u32 val[4];
+	struct ppe_ac_uni_queue_cfg bf;
+};
+
+#define PPE_AC_MUL_QUEUE_CFG_TBL				0x84a000
+#define PPE_AC_MUL_QUEUE_CFG_TBL_NUM				44
+#define PPE_AC_MUL_QUEUE_CFG_TBL_INC				0x10
+
+/* PPE multicast queue(256-299) configurations, the mutlicast queues are
+ * fixed to the PPE ports, which only support static threshold.
+ */
+struct ppe_ac_mul_queue_cfg {
+	u32 ac_en:1,
+	    force_ac_en:1,
+	    color_aware:1,
+	    ac_grp_id:2,
+	    prealloc_limit:11,
+	    shared_ceiling:11,
+	    gap_grn_yel_0:5;
+	u32 gap_grn_yel_1:6,
+	    gap_grn_red:11,
+	    red_resume:11,
+	    yel_resume_0:4;
+	u32 yel_resume_1:7,
+	    grn_resume:11,
+	    res0:14;
+};
+
+union ppe_ac_mul_queue_cfg_u {
+	u32 val[3];
+	struct ppe_ac_mul_queue_cfg bf;
+};
+
+#define PPE_AC_GRP_CFG_TBL					0x84c000
+#define PPE_AC_GRP_CFG_TBL_NUM					4
+#define PPE_AC_GRP_CFG_TBL_INC					0x10
+
+/* PPE admission control of group configurations */
+struct ppe_ac_grp_cfg {
+	u32 ac_en:1,
+	    force_ac_en:1,
+	    color_aware:1,
+	    gap_grn_red:11,
+	    gap_grn_yel:11,
+	    dp_thrd_0:7;
+	u32 dp_thrd_1:4,
+	    limit:11,
+	    red_resume:11,
+	    yel_resume_0:6;
+	u32 yel_resume_1:5,
+	    grn_resume:11,
+	    prealloc_limit:11,
+	    res0:5;
+};
+
+union ppe_ac_grp_cfg_u {
+	u32 val[3];
+	struct ppe_ac_grp_cfg bf;
+};
+
+#define PPE_ENQ_OPR_TBL						0x85c000
+#define PPE_ENQ_OPR_TBL_NUM					300
+#define PPE_ENQ_OPR_TBL_INC					0x10
+#define PPE_ENQ_OPR_TBL_ENQ_DISABLE				BIT(0)
+
 #endif
-- 
2.42.0


