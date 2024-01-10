Return-Path: <linux-kernel+bounces-22115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AC0829981
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DA81287476
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD99495CA;
	Wed, 10 Jan 2024 11:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SVdp9zgq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478C548CCF;
	Wed, 10 Jan 2024 11:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40A8d862021796;
	Wed, 10 Jan 2024 11:42:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=jWjCIVTM2vJ8qNVYNESE3ciTPQ7JcSTFNXkTggauntY=; b=SV
	dp9zgqI+tvEDHsFiyySWuTJjRXCFCmY3ZMOfV8T1kU6s47pIiQkLaMdd0pFJ04ss
	zZQh4QHN2+3rBu0shwrRfAnh2XnoOrg6fykndJSxncKUyxi2tFP84guxmVALCNI6
	005FkhyhWCdvPVcpuXKcL4DV/BGUAHN3KniqMZWFvC39a3Q5e/NTDLNRkxvf6/um
	+BUKFkSrpYRaU6Or6mb7N/M8Nr5uDUhsYwjxU/yqIOaHrdV7nE6ko6s3n8WyIC/j
	83zSaQzu7u1mwTr5hks6eydCN1jr5X0+9B0xGqG+YPCMmF3TDepQGZbApV1KscRg
	zqirnf8lOUOB5xMMjiug==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhjh2s1tc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:42:11 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40ABg60r018763
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:42:07 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 03:41:56 -0800
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
Subject: [PATCH net-next 06/20] net: ethernet: qualcomm: Add PPE TDM config
Date: Wed, 10 Jan 2024 19:40:18 +0800
Message-ID: <20240110114033.32575-7-quic_luoj@quicinc.com>
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
X-Proofpoint-ORIG-GUID: hOygooSlE6Zdi0cPE3pVpl50NbBzHuPC
X-Proofpoint-GUID: hOygooSlE6Zdi0cPE3pVpl50NbBzHuPC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100096

TDM(Time Division Multiplex) config controls the performance of the
PPE ports, which assigns the clock tickets for the PPE port to receive
and transmit packet.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/ethernet/qualcomm/ppe/ppe.c      | 111 ++++++++++++++++++-
 drivers/net/ethernet/qualcomm/ppe/ppe_regs.h |  30 +++++
 2 files changed, 140 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.c b/drivers/net/ethernet/qualcomm/ppe/ppe.c
index 122e325b407d..85d8b06a326b 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe.c
@@ -625,6 +625,111 @@ static int of_parse_ppe_qm(struct ppe_device *ppe_dev,
 	return ret;
 }
 
+static int of_parse_ppe_tdm(struct ppe_device *ppe_dev,
+			    struct device_node *ppe_node)
+{
+	struct device_node *tdm_node;
+	u32 *cfg, reg_val;
+	int ret, cnt;
+
+	tdm_node = of_get_child_by_name(ppe_node, "tdm-config");
+	if (!tdm_node)
+		return dev_err_probe(ppe_dev->dev, -ENODEV,
+				     "tdm-config is not defined\n");
+
+	cnt = of_property_count_u32_elems(tdm_node, "qcom,tdm-bm-config");
+	if (cnt < 0)
+		return dev_err_probe(ppe_dev->dev, -EINVAL,
+				     "Fail to get qcom,tdm-bm-config\n");
+
+	cfg = kmalloc_array(cnt, sizeof(*cfg), GFP_KERNEL | __GFP_ZERO);
+	if (!cfg)
+		return -ENOMEM;
+
+	ret = of_property_read_u32_array(tdm_node, "qcom,tdm-bm-config", cfg, cnt);
+	if (ret) {
+		dev_err(ppe_dev->dev, "Fail to get qcom,tdm-bm-config\n");
+		goto parse_tdm_err;
+	}
+
+	/* Parse TDM BM configuration,
+	 * the dts property:
+	 * qcom,tdm-bm-config = <valid dir port second_valid second_port>;
+	 *
+	 * This config decides the number ticks available for physical port
+	 * to utilize buffer for receiving and transmiting packet.
+	 */
+	reg_val = FIELD_PREP(PPE_BM_TDM_CTRL_TDM_DEPTH, cnt / 5) |
+		  FIELD_PREP(PPE_BM_TDM_CTRL_TDM_OFFSET, 0) |
+		  FIELD_PREP(PPE_BM_TDM_CTRL_TDM_EN, 1);
+	ret = ppe_write(ppe_dev, PPE_BM_TDM_CTRL, reg_val);
+	if (ret)
+		return ret;
+
+	ret = 0;
+	while ((cnt - ret) / 5) {
+		reg_val = FIELD_PREP(PPE_BM_TDM_CFG_TBL_VALID, cfg[ret]) |
+			  FIELD_PREP(PPE_BM_TDM_CFG_TBL_DIR, cfg[ret + 1]) |
+			  FIELD_PREP(PPE_BM_TDM_CFG_TBL_PORT_NUM, cfg[ret + 2]) |
+			  FIELD_PREP(PPE_BM_TDM_CFG_TBL_SECOND_PORT_VALID, cfg[ret + 3]) |
+			  FIELD_PREP(PPE_BM_TDM_CFG_TBL_SECOND_PORT, cfg[ret + 4]);
+
+		ppe_write(ppe_dev,
+			  PPE_BM_TDM_CFG_TBL + (ret / 5) * PPE_BM_TDM_CFG_TBL_INC,
+			  reg_val);
+		ret += 5;
+	}
+
+	cnt = of_property_count_u32_elems(tdm_node, "qcom,tdm-port-scheduler-config");
+	if (cnt < 0) {
+		dev_err(ppe_dev->dev, "Fail to get qcom,tdm-port-scheduler-config\n");
+		goto parse_tdm_err;
+	}
+
+	cfg = krealloc_array(cfg, cnt, sizeof(*cfg), GFP_KERNEL | __GFP_ZERO);
+	if (!cfg) {
+		ret = -ENOMEM;
+		goto parse_tdm_err;
+	}
+
+	ret = of_property_read_u32_array(tdm_node, "qcom,tdm-port-scheduler-config",
+					 cfg, cnt);
+	if (ret) {
+		dev_err(ppe_dev->dev, "Fail to get qcom,tdm-port-scheduler-config\n");
+		goto parse_tdm_err;
+	}
+
+	/* Parse TDM scheduler configuration,
+	 * the dts property:
+	 * qcom,tdm-port-scheduler-config = <ensch_bmp ensch_port desch_port
+	 * desch_second_valid desch_second_port>;
+	 *
+	 * This config decides the ticks number available for packet enqueue
+	 * and dequeue on the physical port.
+	 */
+	reg_val = FIELD_PREP(PPE_PSCH_TDM_DEPTH_CFG_TDM_DEPTH, cnt / 5);
+	ppe_write(ppe_dev, PPE_PSCH_TDM_DEPTH_CFG, reg_val);
+
+	ret = 0;
+	while ((cnt - ret) / 5) {
+		reg_val = FIELD_PREP(PPE_PSCH_TDM_CFG_TBL_ENS_PORT_BITMAP, cfg[ret]) |
+			  FIELD_PREP(PPE_PSCH_TDM_CFG_TBL_ENS_PORT, cfg[ret + 1]) |
+			  FIELD_PREP(PPE_PSCH_TDM_CFG_TBL_DES_PORT, cfg[ret + 2]) |
+			  FIELD_PREP(PPE_PSCH_TDM_CFG_TBL_DES_SECOND_PORT_EN, cfg[ret + 3]) |
+			  FIELD_PREP(PPE_PSCH_TDM_CFG_TBL_DES_SECOND_PORT, cfg[ret + 4]);
+
+		ppe_write(ppe_dev,
+			  PPE_PSCH_TDM_CFG_TBL + (ret / 5) * PPE_PSCH_TDM_CFG_TBL_INC,
+			  reg_val);
+		ret += 5;
+	}
+
+	ret = 0;
+parse_tdm_err:
+	kfree(cfg);
+	return ret;
+};
+
 static int of_parse_ppe_config(struct ppe_device *ppe_dev,
 			       struct device_node *ppe_node)
 {
@@ -634,7 +739,11 @@ static int of_parse_ppe_config(struct ppe_device *ppe_dev,
 	if (ret)
 		return ret;
 
-	return of_parse_ppe_qm(ppe_dev, ppe_node);
+	ret = of_parse_ppe_qm(ppe_dev, ppe_node);
+	if (ret)
+		return ret;
+
+	return of_parse_ppe_tdm(ppe_dev, ppe_node);
 }
 
 static int qcom_ppe_probe(struct platform_device *pdev)
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
index 3e75b75fa48c..589f92a4f607 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
@@ -7,14 +7,44 @@
 #ifndef __PPE_REGS_H__
 #define __PPE_REGS_H__
 
+#define PPE_BM_TDM_CTRL						0xb000
+#define PPE_BM_TDM_CTRL_NUM					1
+#define PPE_BM_TDM_CTRL_INC					4
+#define PPE_BM_TDM_CTRL_TDM_DEPTH				GENMASK(7, 0)
+#define PPE_BM_TDM_CTRL_TDM_OFFSET				GENMASK(14, 8)
+#define PPE_BM_TDM_CTRL_TDM_EN					BIT(31)
+
+#define PPE_BM_TDM_CFG_TBL					0xc000
+#define PPE_BM_TDM_CFG_TBL_NUM					128
+#define PPE_BM_TDM_CFG_TBL_INC					0x10
+#define PPE_BM_TDM_CFG_TBL_PORT_NUM				GENMASK(3, 0)
+#define PPE_BM_TDM_CFG_TBL_DIR					BIT(4)
+#define PPE_BM_TDM_CFG_TBL_VALID				BIT(5)
+#define PPE_BM_TDM_CFG_TBL_SECOND_PORT_VALID			BIT(6)
+#define PPE_BM_TDM_CFG_TBL_SECOND_PORT				GENMASK(11, 8)
+
 #define PPE_EG_BRIDGE_CONFIG					0x20044
 #define PPE_EG_BRIDGE_CONFIG_QUEUE_CNT_EN			BIT(2)
 
+#define PPE_PSCH_TDM_DEPTH_CFG					0x400000
+#define PPE_PSCH_TDM_DEPTH_CFG_NUM				1
+#define PPE_PSCH_TDM_DEPTH_CFG_INC				4
+#define PPE_PSCH_TDM_DEPTH_CFG_TDM_DEPTH			GENMASK(7, 0)
+
 #define PPE_DEQ_OPR_TBL						0x430000
 #define PPE_DEQ_OPR_TBL_NUM					300
 #define PPE_DEQ_OPR_TBL_INC					0x10
 #define PPE_ENQ_OPR_TBL_DEQ_DISABLE				BIT(0)
 
+#define PPE_PSCH_TDM_CFG_TBL					0x47a000
+#define PPE_PSCH_TDM_CFG_TBL_NUM				128
+#define PPE_PSCH_TDM_CFG_TBL_INC				0x10
+#define PPE_PSCH_TDM_CFG_TBL_DES_PORT				GENMASK(3, 0)
+#define PPE_PSCH_TDM_CFG_TBL_ENS_PORT				GENMASK(7, 4)
+#define PPE_PSCH_TDM_CFG_TBL_ENS_PORT_BITMAP			GENMASK(15, 8)
+#define PPE_PSCH_TDM_CFG_TBL_DES_SECOND_PORT_EN			BIT(16)
+#define PPE_PSCH_TDM_CFG_TBL_DES_SECOND_PORT			GENMASK(20, 17)
+
 #define PPE_BM_PORT_FC_MODE					0x600100
 #define PPE_BM_PORT_FC_MODE_NUM					15
 #define PPE_BM_PORT_FC_MODE_INC					4
-- 
2.42.0


