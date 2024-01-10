Return-Path: <linux-kernel+bounces-22113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E09D82996F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2026F285C70
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4D347F79;
	Wed, 10 Jan 2024 11:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c9ntwD5M"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A1D47F4C;
	Wed, 10 Jan 2024 11:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40ABdQvs021045;
	Wed, 10 Jan 2024 11:42:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=Ie2G8t7oOiIvC5kJqbLMgvfmGANPENjmn5lKMyAJNH0=; b=c9
	ntwD5M4zfIojx3IHMyBb9lmFhI/pWs5Gz8XoVYZtZDsZ0hnrf46rmoH3ISs7SbWb
	UFp+eDPBmvS0F7wP7MB7e3evq5h5QxP9dz+MaokTN30R9/ec7bPG8xDxtLDCg7km
	mvQXGnATPCrEOqRgnA5HVK4M8RCPdM7fgabTAVL1y54P/mToF/HfYPsUGIgLxhpo
	OugzaPEcIwbXPtTTI6/xuRj8LPB1QljJIsmq/d9FZXx75NNoqs5vWjr+0FP2WI7h
	o4jBpDQUBtUCHFG8kZ0GMwdLC/btCk+iAdtalapoMQsWphvF7g6ePX73L4WsA/EL
	/TyNG1sgRpVekaMV4J5w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh85t2e05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:42:26 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40ABgG8x016338
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:42:16 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 03:42:06 -0800
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
Subject: [PATCH net-next 07/20] net: ethernet: qualcomm: Add PPE port scheduler resource
Date: Wed, 10 Jan 2024 19:40:19 +0800
Message-ID: <20240110114033.32575-8-quic_luoj@quicinc.com>
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
X-Proofpoint-ORIG-GUID: tc2H1RhkRFvlVEm2lsEFmfeA1ffyYQ-U
X-Proofpoint-GUID: tc2H1RhkRFvlVEm2lsEFmfeA1ffyYQ-U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=985 clxscore=1015
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100096

PPE port scheduler resource is used to dispatch the packet with
QoS offloaded to PPE hardware, which includes the hardware queue,
DRR(deficit round robin) and SP(strict priority).

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/ethernet/qualcomm/ppe/ppe.c | 83 ++++++++++++++++++++++++-
 drivers/net/ethernet/qualcomm/ppe/ppe.h | 13 ++++
 2 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.c b/drivers/net/ethernet/qualcomm/ppe/ppe.c
index 85d8b06a326b..8bf32a7265d2 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe.c
@@ -16,6 +16,7 @@
 #include "ppe.h"
 #include "ppe_regs.h"
 
+#define PPE_SCHEDULER_PORT_NUM		8
 static const char * const ppe_clock_name[PPE_CLK_MAX] = {
 	"cmn_ahb",
 	"cmn_sys",
@@ -112,6 +113,8 @@ static const char * const ppe_reset_name[PPE_RST_MAX] = {
 	"nss_port6_mac",
 };
 
+static struct ppe_scheduler_port_resource ppe_scheduler_res[PPE_SCHEDULER_PORT_NUM];
+
 int ppe_write(struct ppe_device *ppe_dev, u32 reg, unsigned int val)
 {
 	return regmap_write(ppe_dev->regmap, reg, val);
@@ -730,6 +733,80 @@ static int of_parse_ppe_tdm(struct ppe_device *ppe_dev,
 	return ret;
 };
 
+static int of_parse_ppe_scheduler_resource(struct ppe_device *ppe_dev,
+					   struct device_node *resource_node)
+{
+	struct device_node *port_node;
+	u32 port;
+
+	for_each_available_child_of_node(resource_node, port_node) {
+		if (of_property_read_u32(port_node, "port-id", &port))
+			return dev_err_probe(ppe_dev->dev, -ENODEV,
+					     "port-id not defined on resource\n");
+
+		if (port >= ARRAY_SIZE(ppe_scheduler_res))
+			return dev_err_probe(ppe_dev->dev, -EINVAL,
+					     "Invalid port-id defined on resource\n");
+
+		if (of_property_read_u32_array(port_node, "qcom,ucast-queue",
+					       ppe_scheduler_res[port].ucastq,
+					       ARRAY_SIZE(ppe_scheduler_res[port].ucastq)))
+			return dev_err_probe(ppe_dev->dev, -EINVAL,
+					     "Invalid qcom,ucast-queue defined on resource\n");
+
+		if (of_property_read_u32_array(port_node, "qcom,mcast-queue",
+					       ppe_scheduler_res[port].mcastq,
+					       ARRAY_SIZE(ppe_scheduler_res[port].mcastq)))
+			return dev_err_probe(ppe_dev->dev, -EINVAL,
+					     "Invalid qcom,mcast-queue defined on resource\n");
+
+		if (of_property_read_u32_array(port_node, "qcom,l0sp",
+					       ppe_scheduler_res[port].l0sp,
+					       ARRAY_SIZE(ppe_scheduler_res[port].l0sp)))
+			return dev_err_probe(ppe_dev->dev, -EINVAL,
+					     "Invalid qcom,l0sp defined on resource\n");
+
+		if (of_property_read_u32_array(port_node, "qcom,l0cdrr",
+					       ppe_scheduler_res[port].l0cdrr,
+					       ARRAY_SIZE(ppe_scheduler_res[port].l0cdrr)))
+			return dev_err_probe(ppe_dev->dev, -EINVAL,
+					     "Invalid qcom,l0cdrr defined on resource\n");
+
+		if (of_property_read_u32_array(port_node, "qcom,l0edrr",
+					       ppe_scheduler_res[port].l0edrr,
+					       ARRAY_SIZE(ppe_scheduler_res[port].l0edrr)))
+			return dev_err_probe(ppe_dev->dev, -EINVAL,
+					     "Invalid qcom,l0edrr defined on resource\n");
+
+		if (of_property_read_u32_array(port_node, "qcom,l1cdrr",
+					       ppe_scheduler_res[port].l1cdrr,
+					       ARRAY_SIZE(ppe_scheduler_res[port].l1cdrr)))
+			return dev_err_probe(ppe_dev->dev, -EINVAL,
+					     "Invalid qcom,l1cdrr defined on resource\n");
+
+		if (of_property_read_u32_array(port_node, "qcom,l1edrr",
+					       ppe_scheduler_res[port].l1edrr,
+					       ARRAY_SIZE(ppe_scheduler_res[port].l1edrr)))
+			return dev_err_probe(ppe_dev->dev, -EINVAL,
+					     "Invalid qcom,l1edrr defined on resource\n");
+	}
+
+	return 0;
+}
+
+static int of_parse_ppe_scheduler(struct ppe_device *ppe_dev,
+				  struct device_node *ppe_node)
+{
+	struct device_node *scheduler_node;
+
+	scheduler_node = of_get_child_by_name(ppe_node, "port-scheduler-resource");
+	if (!scheduler_node)
+		return dev_err_probe(ppe_dev->dev, -ENODEV,
+				     "port-scheduler-resource is not defined\n");
+
+	return of_parse_ppe_scheduler_resource(ppe_dev, scheduler_node);
+}
+
 static int of_parse_ppe_config(struct ppe_device *ppe_dev,
 			       struct device_node *ppe_node)
 {
@@ -743,7 +820,11 @@ static int of_parse_ppe_config(struct ppe_device *ppe_dev,
 	if (ret)
 		return ret;
 
-	return of_parse_ppe_tdm(ppe_dev, ppe_node);
+	ret = of_parse_ppe_tdm(ppe_dev, ppe_node);
+	if (ret)
+		return ret;
+
+	return of_parse_ppe_scheduler(ppe_dev, ppe_node);
 }
 
 static int qcom_ppe_probe(struct platform_device *pdev)
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.h b/drivers/net/ethernet/qualcomm/ppe/ppe.h
index 6caef42ab235..84b1c9761f79 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe.h
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe.h
@@ -139,6 +139,19 @@ struct ppe_data {
 	struct reset_control *rst[PPE_RST_MAX];
 };
 
+/* PPE port QoS resource, which includes the queue range and
+ * DRR(deficit round robin), SP(strict priority).
+ */
+struct ppe_scheduler_port_resource {
+	int ucastq[2];
+	int mcastq[2];
+	int l0sp[2];
+	int l0cdrr[2];
+	int l0edrr[2];
+	int l1cdrr[2];
+	int l1edrr[2];
+};
+
 int ppe_type_get(struct ppe_device *ppe_dev);
 
 int ppe_write(struct ppe_device *ppe_dev, u32 reg, unsigned int val);
-- 
2.42.0


