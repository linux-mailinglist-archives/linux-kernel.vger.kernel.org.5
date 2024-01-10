Return-Path: <linux-kernel+bounces-22116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9696B829986
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11C971F21918
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87709495EA;
	Wed, 10 Jan 2024 11:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DhRyuPXa"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4789748CCE;
	Wed, 10 Jan 2024 11:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40AAHBa3022353;
	Wed, 10 Jan 2024 11:42:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=HSN83xm0MAklsY72NPc6rbsnsIVOIUqwLKSPTHcLRAU=; b=Dh
	RyuPXayDbFNPZE3Us4SdQFbNmtrkfltWcAxYw8kicm2kcQKOketQznU5kRbuMUe2
	Z6sWS6PjCp2Itjof9MvuMTzGjIvA2TgHbf+quCD0+FsCRaQxR+oFdGQNAmzRj3x5
	QSCMDm/SY5YmJcMTN/Fg9bM5xTjbAkeeeiZeOJm3mqM9/V5Pcpk3Nhc0KUuGPPIN
	apHa0J+WavFs9RD6JbxDP5sZnshxc2RiRUFdKLDN6nwggGh8YF05CxaBmwB5EdKZ
	3OSzFlum5wjaNQY6FTcwGLIURR2habEYnfYUbkKNe+k9QAGpp4ccdH46qz79sA3b
	SA2HYAn4m1eMdyqRLzvA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhsb2g6vj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:42:10 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40ABfkUi019367
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:41:46 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 03:41:36 -0800
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
Subject: [PATCH net-next 04/20] net: ethernet: qualcomm: Add PPE buffer manager configuration
Date: Wed, 10 Jan 2024 19:40:16 +0800
Message-ID: <20240110114033.32575-5-quic_luoj@quicinc.com>
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
X-Proofpoint-ORIG-GUID: E3iDeNHKChlPgbDsOEcbED2JqqftY4GN
X-Proofpoint-GUID: E3iDeNHKChlPgbDsOEcbED2JqqftY4GN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100096

The BM config controls the flow control or pause frame generated on the
physical port.  The number of hardware buffers configured for the port
influence the function of the flow control for that port.

In addition, the PPE register access functions are added.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/ethernet/qualcomm/ppe/ppe.c      | 164 +++++++++++++++++++
 drivers/net/ethernet/qualcomm/ppe/ppe.h      |   6 +
 drivers/net/ethernet/qualcomm/ppe/ppe_regs.h |  49 ++++++
 3 files changed, 219 insertions(+)
 create mode 100644 drivers/net/ethernet/qualcomm/ppe/ppe_regs.h

diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.c b/drivers/net/ethernet/qualcomm/ppe/ppe.c
index 23f9de105062..94fa13dd17da 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe.c
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/soc/qcom/ppe.h>
 #include "ppe.h"
+#include "ppe_regs.h"
 
 static const char * const ppe_clock_name[PPE_CLK_MAX] = {
 	"cmn_ahb",
@@ -111,6 +112,49 @@ static const char * const ppe_reset_name[PPE_RST_MAX] = {
 	"nss_port6_mac",
 };
 
+int ppe_write(struct ppe_device *ppe_dev, u32 reg, unsigned int val)
+{
+	return regmap_write(ppe_dev->regmap, reg, val);
+}
+
+int ppe_read(struct ppe_device *ppe_dev, u32 reg, unsigned int *val)
+{
+	return regmap_read(ppe_dev->regmap, reg, val);
+}
+
+int ppe_mask(struct ppe_device *ppe_dev, u32 reg, u32 mask, unsigned int set)
+{
+	return regmap_update_bits(ppe_dev->regmap, reg, mask, set);
+}
+
+int ppe_write_tbl(struct ppe_device *ppe_dev, u32 reg,
+		  const unsigned int *val, int cnt)
+{
+	int i, ret;
+
+	for (i = 0; i < cnt / 4; i++) {
+		ret = ppe_write(ppe_dev, reg + i * 4, val[i]);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
+int ppe_read_tbl(struct ppe_device *ppe_dev, u32 reg,
+		 unsigned int *val, int cnt)
+{
+	int i, ret;
+
+	for (i = 0; i < cnt / 4; i++) {
+		ret = ppe_read(ppe_dev, reg + i * 4, &val[i]);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
 int ppe_type_get(struct ppe_device *ppe_dev)
 {
 	struct ppe_data *ppe_dev_priv = ppe_dev->ppe_priv;
@@ -323,6 +367,120 @@ static struct ppe_data *ppe_data_init(struct platform_device *pdev)
 	return ppe_dev_priv;
 }
 
+static int of_parse_ppe_bm(struct ppe_device *ppe_dev,
+			   struct device_node *ppe_node)
+{
+	union ppe_bm_port_fc_cfg_u fc_cfg;
+	struct device_node *bm_node;
+	int ret, cnt;
+	u32 *cfg, reg_val;
+
+	bm_node = of_get_child_by_name(ppe_node, "buffer-management-config");
+	if (!bm_node)
+		return dev_err_probe(ppe_dev->dev, -ENODEV,
+				     "Fail to get buffer-management-config\n");
+
+	cnt = of_property_count_u32_elems(bm_node, "qcom,group-config");
+	if (cnt < 0)
+		return dev_err_probe(ppe_dev->dev, cnt,
+				     "Fail to qcom,group-config\n");
+
+	cfg = kmalloc_array(cnt, sizeof(*cfg), GFP_KERNEL | __GFP_ZERO);
+	if (!cfg)
+		return -ENOMEM;
+
+	ret = of_property_read_u32_array(bm_node, "qcom,group-config", cfg, cnt);
+	if (ret) {
+		dev_err(ppe_dev->dev, "Fail to get qcom,group-config %d\n", ret);
+		goto parse_bm_err;
+	}
+
+	/* Parse BM group configuration,
+	 * the dts propert: qcom,group-config = <group group_buf>;
+	 *
+	 * There are 3 kinds of buffer types, guaranteed buffer(port based),
+	 * shared buffer(group based) and react buffer(cache in-flight packets).
+	 *
+	 * Maximum 4 groups supported by PPE.
+	 */
+	ret = 0;
+	while ((cnt - ret) / 2) {
+		if (cfg[ret] < PPE_BM_SHARED_GROUP_CFG_NUM) {
+			reg_val = FIELD_PREP(PPE_BM_SHARED_GROUP_CFG_SHARED_LIMIT, cfg[ret + 1]);
+
+			ppe_write(ppe_dev, PPE_BM_SHARED_GROUP_CFG +
+				  PPE_BM_SHARED_GROUP_CFG_INC * cfg[ret], reg_val);
+		}
+		ret += 2;
+	}
+
+	cnt = of_property_count_u32_elems(bm_node, "qcom,port-config");
+	if (cnt < 0) {
+		dev_err(ppe_dev->dev, "Fail to get qcom,port-config %d\n", cnt);
+		goto parse_bm_err;
+	}
+
+	cfg = krealloc_array(cfg, cnt, sizeof(*cfg), GFP_KERNEL | __GFP_ZERO);
+	if (!cfg) {
+		ret = -ENOMEM;
+		goto parse_bm_err;
+	}
+
+	ret = of_property_read_u32_array(bm_node, "qcom,port-config", cfg, cnt);
+	if (ret) {
+		dev_err(ppe_dev->dev, "Fail to get qcom,port-config %d\n", ret);
+		goto parse_bm_err;
+	}
+
+	/* Parse BM port configuration,
+	 * the dts property: qcom,port-config = <group port prealloc react ceil
+	 * weight res_off res_ceil dynamic>;
+	 *
+	 * The port based buffer is assigned to the group ID, which is the
+	 * buffer dedicated to BM port, and the threshold to generate the
+	 * pause frame, the threshold can be configured as the static value
+	 * or dynamically adjusted according to the remain buffer.
+	 */
+	ret = 0;
+	while ((cnt - ret) / 9) {
+		if (cfg[ret + 1] < PPE_BM_PORT_FC_MODE_NUM) {
+			memset(&fc_cfg, 0, sizeof(fc_cfg));
+
+			fc_cfg.bf.pre_alloc = cfg[ret + 2];
+			fc_cfg.bf.react_limit = cfg[ret + 3];
+			fc_cfg.bf.shared_ceiling_0 = cfg[ret + 4] & 0x7;
+			fc_cfg.bf.shared_ceiling_1 = cfg[ret + 4] >> 3;
+			fc_cfg.bf.shared_weight = cfg[ret + 5];
+			fc_cfg.bf.resum_offset = cfg[ret + 6];
+			fc_cfg.bf.resum_floor_th = cfg[ret + 7];
+			fc_cfg.bf.shared_dynamic = cfg[ret + 8];
+			ppe_write_tbl(ppe_dev, PPE_BM_PORT_FC_CFG +
+				      PPE_BM_PORT_FC_CFG_INC * cfg[ret + 1],
+				      fc_cfg.val, sizeof(fc_cfg.val));
+
+			reg_val = FIELD_PREP(PPE_BM_PORT_GROUP_ID_SHARED_GROUP_ID, cfg[ret]);
+			ppe_write(ppe_dev, PPE_BM_PORT_GROUP_ID +
+				  PPE_BM_PORT_GROUP_ID_INC * cfg[ret + 1], reg_val);
+
+			reg_val = FIELD_PREP(PPE_BM_PORT_FC_MODE_EN, 1);
+			ppe_write(ppe_dev, PPE_BM_PORT_FC_MODE +
+				  PPE_BM_PORT_FC_MODE_INC * cfg[ret + 1], reg_val);
+		}
+		ret += 9;
+	}
+	ret = 0;
+
+parse_bm_err:
+	kfree(cfg);
+	return ret;
+}
+
+static int of_parse_ppe_config(struct ppe_device *ppe_dev,
+			       struct device_node *ppe_node)
+{
+	return of_parse_ppe_bm(ppe_dev, ppe_node);
+}
+
 static int qcom_ppe_probe(struct platform_device *pdev)
 {
 	struct ppe_device *ppe_dev;
@@ -359,6 +517,12 @@ static int qcom_ppe_probe(struct platform_device *pdev)
 				     ret,
 				     "ppe clock config failed\n");
 
+	ret = of_parse_ppe_config(ppe_dev, pdev->dev.of_node);
+	if (ret)
+		return dev_err_probe(&pdev->dev,
+				     ret,
+				     "of parse ppe failed\n");
+
 	ppe_dev->is_ppe_probed = true;
 	return 0;
 }
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.h b/drivers/net/ethernet/qualcomm/ppe/ppe.h
index f54406a6feb7..6caef42ab235 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe.h
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe.h
@@ -140,4 +140,10 @@ struct ppe_data {
 };
 
 int ppe_type_get(struct ppe_device *ppe_dev);
+
+int ppe_write(struct ppe_device *ppe_dev, u32 reg, unsigned int val);
+int ppe_read(struct ppe_device *ppe_dev, u32 reg, unsigned int *val);
+int ppe_mask(struct ppe_device *ppe_dev, u32 reg, u32 mask, unsigned int set);
+int ppe_write_tbl(struct ppe_device *ppe_dev, u32 reg, const unsigned int *val, int cnt);
+int ppe_read_tbl(struct ppe_device *ppe_dev, u32 reg, unsigned int *val, int cnt);
 #endif
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
new file mode 100644
index 000000000000..e11d8f2a26b7
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/* PPE hardware register and table declarations. */
+#ifndef __PPE_REGS_H__
+#define __PPE_REGS_H__
+
+#define PPE_BM_PORT_FC_MODE					0x600100
+#define PPE_BM_PORT_FC_MODE_NUM					15
+#define PPE_BM_PORT_FC_MODE_INC					4
+#define PPE_BM_PORT_FC_MODE_EN					BIT(0)
+
+#define PPE_BM_PORT_GROUP_ID					0x600180
+#define PPE_BM_PORT_GROUP_ID_NUM				15
+#define PPE_BM_PORT_GROUP_ID_INC				4
+#define PPE_BM_PORT_GROUP_ID_SHARED_GROUP_ID			GENMASK(1, 0)
+
+#define PPE_BM_SHARED_GROUP_CFG					0x600290
+#define PPE_BM_SHARED_GROUP_CFG_NUM				4
+#define PPE_BM_SHARED_GROUP_CFG_INC				4
+#define PPE_BM_SHARED_GROUP_CFG_SHARED_LIMIT			GENMASK(10, 0)
+
+#define PPE_BM_PORT_FC_CFG					0x601000
+#define PPE_BM_PORT_FC_CFG_NUM					15
+#define PPE_BM_PORT_FC_CFG_INC					0x10
+
+/* BM port configurations, BM port(0-7) for CPU port, BM port(8-13) for physical
+ * port 1-6.
+ */
+struct ppe_bm_port_fc_cfg {
+	u32 react_limit:9,
+	    resum_floor_th:9,
+	    resum_offset:11,
+	    shared_ceiling_0:3;
+	u32 shared_ceiling_1:8,
+	    shared_weight:3,
+	    shared_dynamic:1,
+	    pre_alloc:11,
+	    res0:9;
+};
+
+union ppe_bm_port_fc_cfg_u {
+	u32 val[2];
+	struct ppe_bm_port_fc_cfg bf;
+};
+
+#endif
-- 
2.42.0


