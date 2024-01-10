Return-Path: <linux-kernel+bounces-22114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0498829974
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B548B260A3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC4148CC6;
	Wed, 10 Jan 2024 11:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="StE8A9wc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584EF47F73;
	Wed, 10 Jan 2024 11:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40A8cVEK029302;
	Wed, 10 Jan 2024 11:42:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=N2xtE1BKY9KueIYulPUjl18OGm2MSY28i/flBVkRln8=; b=St
	E8A9wcpv47ZwBB03w7f3UAlbhdnapCoq+fwD81fY2CAANPVYUcS75rrC0PQfSYfg
	xyhzqtyRIX7uijE1Y/f1tax/mCCY9HjX7XorUuavxfESOGaZVZhuLhr1l5RIp6JP
	WnNjCub7h8r0w9WEOigjkF0Kbf3OBADOrqdGCj0Wk/KJDVhx7Rc1PGbuPAkpdniY
	rba+HtnGgxoiRwlnTLpv2BIYXUWfXq+uMYP0ZA6IEknVbBa0shqE0+ttZKNdwEB8
	06acsyVNGo7SqTP3MDfCxFsvwEvQfXrR/4q9zk84gr1Y1i1AXRb+DXdI1naAew3a
	kGXjRHPDmF0EaMnf9g5Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhq2h0fuy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:42:27 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40ABgQM2013702
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:42:26 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 03:42:16 -0800
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
Subject: [PATCH net-next 08/20] net: ethernet: qualcomm: Add PPE scheduler config
Date: Wed, 10 Jan 2024 19:40:20 +0800
Message-ID: <20240110114033.32575-9-quic_luoj@quicinc.com>
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
X-Proofpoint-GUID: SORAcphA__vHuWCv7xoXFJqeuQ4Wxui4
X-Proofpoint-ORIG-GUID: SORAcphA__vHuWCv7xoXFJqeuQ4Wxui4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100096

PPE scheduler is configured according to the device tree. This
configuration is read and used for initialization by PPE driver,
and adjusted later by the EDMA driver.

PPE scheduler config determines the priority of scheduling the
packet. PPE supports two level QoS hierarchy, Level 0 and Level 1.
The scheduler config helps with the construction of the PPE QoS
hierarchies for each physical port.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/ethernet/qualcomm/ppe/Makefile   |   2 +-
 drivers/net/ethernet/qualcomm/ppe/ppe.c      | 194 ++++++++++++++++-
 drivers/net/ethernet/qualcomm/ppe/ppe_ops.c  | 206 +++++++++++++++++++
 drivers/net/ethernet/qualcomm/ppe/ppe_ops.h  |  45 ++++
 drivers/net/ethernet/qualcomm/ppe/ppe_regs.h |  64 ++++++
 5 files changed, 508 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/qualcomm/ppe/ppe_ops.c
 create mode 100644 drivers/net/ethernet/qualcomm/ppe/ppe_ops.h

diff --git a/drivers/net/ethernet/qualcomm/ppe/Makefile b/drivers/net/ethernet/qualcomm/ppe/Makefile
index 795aff6501e4..c00265339aa7 100644
--- a/drivers/net/ethernet/qualcomm/ppe/Makefile
+++ b/drivers/net/ethernet/qualcomm/ppe/Makefile
@@ -4,4 +4,4 @@
 #
 
 obj-$(CONFIG_QCOM_PPE) += qcom-ppe.o
-qcom-ppe-objs := ppe.o
+qcom-ppe-objs := ppe.o ppe_ops.o
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.c b/drivers/net/ethernet/qualcomm/ppe/ppe.c
index 8bf32a7265d2..75c24a87e2be 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe.c
@@ -15,8 +15,13 @@
 #include <linux/soc/qcom/ppe.h>
 #include "ppe.h"
 #include "ppe_regs.h"
+#include "ppe_ops.h"
 
 #define PPE_SCHEDULER_PORT_NUM		8
+#define PPE_SCHEDULER_L0_NUM		300
+#define PPE_SCHEDULER_L1_NUM		64
+#define PPE_SP_PRIORITY_NUM		8
+
 static const char * const ppe_clock_name[PPE_CLK_MAX] = {
 	"cmn_ahb",
 	"cmn_sys",
@@ -794,17 +799,202 @@ static int of_parse_ppe_scheduler_resource(struct ppe_device *ppe_dev,
 	return 0;
 }
 
+static int of_parse_ppe_scheduler_group_config(struct ppe_device *ppe_dev,
+					       struct device_node *group_node,
+					       int port,
+					       const char *node_name,
+					       const char *loop_name)
+{
+	struct ppe_qos_scheduler_cfg qos_cfg;
+	const struct ppe_queue_ops *ppe_queue_ops;
+	const __be32 *paddr;
+	int ret, len, i, node_id, level, node_max;
+	u32 tmp_cfg[5], pri_loop, max_pri;
+
+	ppe_queue_ops = ppe_queue_config_ops_get();
+	if (!ppe_queue_ops->queue_scheduler_set)
+		return -EINVAL;
+
+	/* The value of the property node_name can be single value
+	 * or array value.
+	 *
+	 * If the array value is defined, the property loop_name should not
+	 * be specified.
+	 *
+	 * If the single value is defined, the queue ID will be added in the
+	 * loop value defined by the loop_name.
+	 */
+	paddr = of_get_property(group_node, node_name, &len);
+	if (!paddr)
+		return dev_err_probe(ppe_dev->dev, -ENODEV,
+				     "Fail to get queue %s of port %d\n",
+				     node_name, port);
+
+	len /= sizeof(u32);
+
+	/* There are two levels scheduler configs, the level 0 scheduler
+	 * config is configured on the queue, the level 1 scheduler is
+	 * configured on the flow that is from the output of level 0
+	 * scheduler.
+	 */
+	if (!strcmp(node_name, "qcom,flow")) {
+		level = 1;
+		node_max = PPE_SCHEDULER_L1_NUM;
+	} else {
+		level = 0;
+		node_max = PPE_SCHEDULER_L0_NUM;
+	}
+
+	if (of_property_read_u32_array(group_node, "qcom,scheduler-config",
+				       tmp_cfg, ARRAY_SIZE(tmp_cfg)))
+		return dev_err_probe(ppe_dev->dev, -ENODEV,
+				     "Fail to get qcom,scheduler-config of port %d\n",
+				     port);
+
+	if (of_property_read_u32(group_node, loop_name, &pri_loop)) {
+		for (i = 0; i < len; i++) {
+			node_id = be32_to_cpup(paddr + i);
+			if (node_id >= node_max)
+				return dev_err_probe(ppe_dev->dev, -EINVAL,
+						     "Invalid node ID %d of port %d\n",
+						     node_id, port);
+
+			memset(&qos_cfg, 0, sizeof(qos_cfg));
+
+			qos_cfg.sp_id = tmp_cfg[0];
+			qos_cfg.c_pri = tmp_cfg[1];
+			qos_cfg.c_drr_id = tmp_cfg[2];
+			qos_cfg.e_pri = tmp_cfg[3];
+			qos_cfg.e_drr_id = tmp_cfg[4];
+			qos_cfg.c_drr_wt = 1;
+			qos_cfg.e_drr_wt = 1;
+			ret = ppe_queue_ops->queue_scheduler_set(ppe_dev,
+								 node_id,
+								 level,
+								 port,
+								 qos_cfg);
+			if (ret)
+				return dev_err_probe(ppe_dev->dev, ret,
+						     "scheduler set fail on node ID %d\n",
+						     node_id);
+		}
+	} else {
+		/* Only one base node ID allowed to loop. */
+		if (len != 1)
+			return dev_err_probe(ppe_dev->dev, -EINVAL,
+					"Multiple node ID defined to loop for port %d\n",
+					port);
+
+		/* Property qcom,drr-max-priority is optional for loop,
+		 * if not defined, the default value PPE_SP_PRIORITY_NUM
+		 * is used.
+		 */
+		max_pri = PPE_SP_PRIORITY_NUM;
+		of_property_read_u32(group_node, "qcom,drr-max-priority", &max_pri);
+
+		node_id = be32_to_cpup(paddr);
+		if (node_id >= node_max)
+			return dev_err_probe(ppe_dev->dev, -EINVAL,
+					"Invalid node ID %d defined to loop for port %d\n",
+					node_id, port);
+
+		for (i = 0; i < pri_loop; i++) {
+			memset(&qos_cfg, 0, sizeof(qos_cfg));
+
+			qos_cfg.sp_id = tmp_cfg[0] + i / max_pri;
+			qos_cfg.c_pri = tmp_cfg[1] + i % max_pri;
+			qos_cfg.c_drr_id = tmp_cfg[2] + i;
+			qos_cfg.e_pri = tmp_cfg[3] + i % max_pri;
+			qos_cfg.e_drr_id = tmp_cfg[4] + i;
+			qos_cfg.c_drr_wt = 1;
+			qos_cfg.e_drr_wt = 1;
+			ret = ppe_queue_ops->queue_scheduler_set(ppe_dev,
+								 node_id + i,
+								 level,
+								 port,
+								 qos_cfg);
+			if (ret)
+				return dev_err_probe(ppe_dev->dev, ret,
+						     "scheduler set fail on node ID %d\n",
+						     node_id + i);
+		}
+	}
+
+	return 0;
+}
+
+static int of_parse_ppe_scheduler_config(struct ppe_device *ppe_dev,
+					 struct device_node *port_node)
+{
+	struct device_node *scheduler_node, *child;
+	int port, ret;
+
+	if (of_property_read_u32(port_node, "port-id", &port))
+		return dev_err_probe(ppe_dev->dev, -ENODEV,
+				     "Fail to get port-id of l0scheduler\n");
+
+	scheduler_node = of_get_child_by_name(port_node, "l0scheduler");
+	if (!scheduler_node)
+		return dev_err_probe(ppe_dev->dev, -ENODEV,
+				     "Fail to get l0scheduler config\n");
+
+	for_each_available_child_of_node(scheduler_node, child) {
+		ret = of_parse_ppe_scheduler_group_config(ppe_dev, child, port,
+							  "qcom,ucast-queue",
+							  "qcom,ucast-loop-priority");
+		if (ret)
+			return ret;
+
+		ret = of_parse_ppe_scheduler_group_config(ppe_dev, child, port,
+							  "qcom,mcast-queue",
+							  "qcom,mcast-loop-priority");
+		if (ret)
+			return ret;
+	}
+
+	scheduler_node = of_get_child_by_name(port_node, "l1scheduler");
+	if (!scheduler_node)
+		return dev_err_probe(ppe_dev->dev, -ENODEV,
+				     "Fail to get l1scheduler config\n");
+
+	for_each_available_child_of_node(scheduler_node, child) {
+		ret = of_parse_ppe_scheduler_group_config(ppe_dev, child, port,
+							  "qcom,flow",
+							  "qcom,flow-loop-priority");
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
 static int of_parse_ppe_scheduler(struct ppe_device *ppe_dev,
 				  struct device_node *ppe_node)
 {
-	struct device_node *scheduler_node;
+	struct device_node *scheduler_node, *port_node;
+	int ret;
 
 	scheduler_node = of_get_child_by_name(ppe_node, "port-scheduler-resource");
 	if (!scheduler_node)
 		return dev_err_probe(ppe_dev->dev, -ENODEV,
 				     "port-scheduler-resource is not defined\n");
 
-	return of_parse_ppe_scheduler_resource(ppe_dev, scheduler_node);
+	ret = of_parse_ppe_scheduler_resource(ppe_dev, scheduler_node);
+	if (ret)
+		return ret;
+
+	scheduler_node = of_get_child_by_name(ppe_node, "port-scheduler-config");
+	if (!scheduler_node)
+		return dev_err_probe(ppe_dev->dev, -ENODEV,
+				     "port-scheduler-config is not defined\n");
+
+	for_each_available_child_of_node(scheduler_node, port_node) {
+		ret = of_parse_ppe_scheduler_config(ppe_dev, port_node);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
 }
 
 static int of_parse_ppe_config(struct ppe_device *ppe_dev,
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_ops.c b/drivers/net/ethernet/qualcomm/ppe/ppe_ops.c
new file mode 100644
index 000000000000..7853c2fdcc63
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_ops.c
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/* Low level PPE operations made available to higher level network drivers
+ * such as ethernet or QoS drivers.
+ */
+
+#include <linux/soc/qcom/ppe.h>
+#include "ppe_ops.h"
+#include "ppe_regs.h"
+#include "ppe.h"
+
+static int ppe_scheduler_l0_queue_map_set(struct ppe_device *ppe_dev,
+					  int node_id, int port,
+					  struct ppe_qos_scheduler_cfg scheduler_cfg)
+{
+	u32 val, index;
+
+	if (node_id >= PPE_L0_FLOW_MAP_TBL_NUM)
+		return -EINVAL;
+
+	val = FIELD_PREP(PPE_L0_FLOW_MAP_TBL_SP_ID, scheduler_cfg.sp_id) |
+			 FIELD_PREP(PPE_L0_FLOW_MAP_TBL_C_PRI, scheduler_cfg.c_pri) |
+			 FIELD_PREP(PPE_L0_FLOW_MAP_TBL_E_PRI, scheduler_cfg.e_pri) |
+			 FIELD_PREP(PPE_L0_FLOW_MAP_TBL_C_DRR_WT, scheduler_cfg.c_drr_wt) |
+			 FIELD_PREP(PPE_L0_FLOW_MAP_TBL_E_DRR_WT, scheduler_cfg.e_drr_wt);
+	index = PPE_L0_FLOW_MAP_TBL + node_id * PPE_L0_FLOW_MAP_TBL_INC;
+	ppe_write(ppe_dev, index, val);
+
+	val = FIELD_PREP(PPE_L0_C_SP_CFG_TBL_DRR_ID, scheduler_cfg.c_drr_id) |
+			 FIELD_PREP(PPE_L0_C_SP_CFG_TBL_DRR_CREDIT_UNIT, scheduler_cfg.c_drr_unit);
+	index = PPE_L0_C_SP_CFG_TBL +
+		(scheduler_cfg.sp_id * 8 + scheduler_cfg.c_pri) * PPE_L0_C_SP_CFG_TBL_INC;
+	ppe_write(ppe_dev, index, val);
+
+	val = FIELD_PREP(PPE_L0_E_SP_CFG_TBL_DRR_ID, scheduler_cfg.e_drr_id) |
+			 FIELD_PREP(PPE_L0_E_SP_CFG_TBL_DRR_CREDIT_UNIT, scheduler_cfg.e_drr_unit);
+	index = PPE_L0_E_SP_CFG_TBL +
+		(scheduler_cfg.sp_id * 8 + scheduler_cfg.e_pri) * PPE_L0_E_SP_CFG_TBL_INC;
+	ppe_write(ppe_dev, index, val);
+
+	val = FIELD_PREP(PPE_L0_FLOW_PORT_MAP_TBL_PORT_NUM, port);
+	index = PPE_L0_FLOW_PORT_MAP_TBL + node_id * PPE_L0_FLOW_PORT_MAP_TBL_INC;
+	ppe_write(ppe_dev, index, val);
+
+	index = PPE_L0_COMP_CFG_TBL + node_id * PPE_L0_COMP_CFG_TBL_INC;
+	return ppe_mask(ppe_dev, index, PPE_L0_COMP_CFG_TBL_DRR_METER_LEN,
+			FIELD_PREP(PPE_L0_COMP_CFG_TBL_DRR_METER_LEN,
+				   scheduler_cfg.drr_frame_mode));
+}
+
+static int ppe_scheduler_l0_queue_map_get(struct ppe_device *ppe_dev,
+					  int node_id, int *port,
+					  struct ppe_qos_scheduler_cfg *scheduler_cfg)
+{
+	u32 val, index;
+
+	if (node_id >= PPE_L0_FLOW_MAP_TBL_NUM)
+		return -EINVAL;
+
+	index = PPE_L0_FLOW_MAP_TBL + node_id * PPE_L0_FLOW_MAP_TBL_INC;
+	ppe_read(ppe_dev, index, &val);
+	scheduler_cfg->sp_id = FIELD_GET(PPE_L0_FLOW_MAP_TBL_SP_ID, val);
+	scheduler_cfg->c_pri = FIELD_GET(PPE_L0_FLOW_MAP_TBL_C_PRI, val);
+	scheduler_cfg->e_pri = FIELD_GET(PPE_L0_FLOW_MAP_TBL_E_PRI, val);
+	scheduler_cfg->c_drr_wt = FIELD_GET(PPE_L0_FLOW_MAP_TBL_C_DRR_WT, val);
+	scheduler_cfg->e_drr_wt = FIELD_GET(PPE_L0_FLOW_MAP_TBL_E_DRR_WT, val);
+
+	index = PPE_L0_C_SP_CFG_TBL +
+		(scheduler_cfg->sp_id * 8 + scheduler_cfg->c_pri) * PPE_L0_C_SP_CFG_TBL_INC;
+	ppe_read(ppe_dev, index, &val);
+	scheduler_cfg->c_drr_id = FIELD_GET(PPE_L0_C_SP_CFG_TBL_DRR_ID, val);
+	scheduler_cfg->c_drr_unit = FIELD_GET(PPE_L0_C_SP_CFG_TBL_DRR_CREDIT_UNIT, val);
+
+	index = PPE_L0_E_SP_CFG_TBL +
+		(scheduler_cfg->sp_id * 8 + scheduler_cfg->e_pri) * PPE_L0_E_SP_CFG_TBL_INC;
+	ppe_read(ppe_dev, index, &val);
+	scheduler_cfg->e_drr_id = FIELD_GET(PPE_L0_E_SP_CFG_TBL_DRR_ID, val);
+	scheduler_cfg->e_drr_unit = FIELD_GET(PPE_L0_E_SP_CFG_TBL_DRR_CREDIT_UNIT, val);
+
+	index = PPE_L0_FLOW_PORT_MAP_TBL + node_id * PPE_L0_FLOW_PORT_MAP_TBL_INC;
+	ppe_read(ppe_dev, index, &val);
+	*port = FIELD_GET(PPE_L0_FLOW_PORT_MAP_TBL_PORT_NUM, val);
+
+	index = PPE_L0_COMP_CFG_TBL + node_id * PPE_L0_COMP_CFG_TBL_INC;
+	ppe_read(ppe_dev, index, &val);
+	scheduler_cfg->drr_frame_mode = FIELD_GET(PPE_L0_COMP_CFG_TBL_DRR_METER_LEN, val);
+
+	return 0;
+}
+
+static int ppe_scheduler_l1_queue_map_set(struct ppe_device *ppe_dev,
+					  int node_id, int port,
+					  struct ppe_qos_scheduler_cfg scheduler_cfg)
+{
+	u32 val, index;
+
+	if (node_id >= PPE_L1_FLOW_MAP_TBL_NUM)
+		return -EINVAL;
+
+	val = FIELD_PREP(PPE_L1_FLOW_MAP_TBL_SP_ID, scheduler_cfg.sp_id) |
+			 FIELD_PREP(PPE_L1_FLOW_MAP_TBL_C_PRI, scheduler_cfg.c_pri) |
+			 FIELD_PREP(PPE_L1_FLOW_MAP_TBL_E_PRI, scheduler_cfg.e_pri) |
+			 FIELD_PREP(PPE_L1_FLOW_MAP_TBL_C_DRR_WT, scheduler_cfg.c_drr_wt) |
+			 FIELD_PREP(PPE_L1_FLOW_MAP_TBL_E_DRR_WT, scheduler_cfg.e_drr_wt);
+	index = PPE_L1_FLOW_MAP_TBL + node_id * PPE_L1_FLOW_MAP_TBL_INC;
+	ppe_write(ppe_dev, index, val);
+
+	val = FIELD_PREP(PPE_L1_C_SP_CFG_TBL_DRR_ID, scheduler_cfg.c_drr_id) |
+			 FIELD_PREP(PPE_L1_C_SP_CFG_TBL_DRR_CREDIT_UNIT, scheduler_cfg.c_drr_unit);
+	index = PPE_L1_C_SP_CFG_TBL +
+		(scheduler_cfg.sp_id * 8 + scheduler_cfg.c_pri) * PPE_L1_C_SP_CFG_TBL_INC;
+	ppe_write(ppe_dev, index, val);
+
+	val = FIELD_PREP(PPE_L1_E_SP_CFG_TBL_DRR_ID, scheduler_cfg.e_drr_id) |
+		FIELD_PREP(PPE_L1_E_SP_CFG_TBL_DRR_CREDIT_UNIT, scheduler_cfg.e_drr_unit);
+	index = PPE_L1_E_SP_CFG_TBL +
+		(scheduler_cfg.sp_id * 8 + scheduler_cfg.e_pri) * PPE_L1_E_SP_CFG_TBL_INC;
+	ppe_write(ppe_dev, index, val);
+
+	val = FIELD_PREP(PPE_L1_FLOW_PORT_MAP_TBL_PORT_NUM, port);
+	index = PPE_L1_FLOW_PORT_MAP_TBL + node_id * PPE_L1_FLOW_PORT_MAP_TBL_INC;
+	ppe_write(ppe_dev, index, val);
+
+	index = PPE_L1_COMP_CFG_TBL + node_id * PPE_L1_COMP_CFG_TBL_INC;
+	return ppe_mask(ppe_dev, index, PPE_L1_COMP_CFG_TBL_DRR_METER_LEN,
+			FIELD_PREP(PPE_L1_COMP_CFG_TBL_DRR_METER_LEN,
+				   scheduler_cfg.drr_frame_mode));
+}
+
+static int ppe_scheduler_l1_queue_map_get(struct ppe_device *ppe_dev,
+					  int node_id, int *port,
+					  struct ppe_qos_scheduler_cfg *scheduler_cfg)
+{
+	u32 val, index;
+
+	if (node_id >= PPE_L1_FLOW_MAP_TBL_NUM)
+		return -EINVAL;
+
+	index = PPE_L1_FLOW_MAP_TBL + node_id * PPE_L1_FLOW_MAP_TBL_INC;
+	ppe_read(ppe_dev, index, &val);
+	scheduler_cfg->sp_id = FIELD_GET(PPE_L1_FLOW_MAP_TBL_SP_ID, val);
+	scheduler_cfg->c_pri = FIELD_GET(PPE_L1_FLOW_MAP_TBL_C_PRI, val);
+	scheduler_cfg->e_pri = FIELD_GET(PPE_L1_FLOW_MAP_TBL_E_PRI, val);
+	scheduler_cfg->c_drr_wt = FIELD_GET(PPE_L1_FLOW_MAP_TBL_C_DRR_WT, val);
+	scheduler_cfg->e_drr_wt = FIELD_GET(PPE_L1_FLOW_MAP_TBL_E_DRR_WT, val);
+
+	index = PPE_L1_C_SP_CFG_TBL +
+		(scheduler_cfg->sp_id * 8 + scheduler_cfg->c_pri) * PPE_L1_C_SP_CFG_TBL_INC;
+	ppe_read(ppe_dev, index, &val);
+	scheduler_cfg->c_drr_id = FIELD_GET(PPE_L1_C_SP_CFG_TBL_DRR_ID, val);
+	scheduler_cfg->c_drr_unit = FIELD_GET(PPE_L1_C_SP_CFG_TBL_DRR_CREDIT_UNIT, val);
+
+	index = PPE_L1_E_SP_CFG_TBL +
+		(scheduler_cfg->sp_id * 8 + scheduler_cfg->e_pri) * PPE_L1_E_SP_CFG_TBL_INC;
+	ppe_read(ppe_dev, index, &val);
+	scheduler_cfg->e_drr_id = FIELD_GET(PPE_L1_E_SP_CFG_TBL_DRR_ID, val);
+	scheduler_cfg->e_drr_unit = FIELD_GET(PPE_L1_E_SP_CFG_TBL_DRR_CREDIT_UNIT, val);
+
+	index = PPE_L1_FLOW_PORT_MAP_TBL + node_id * PPE_L1_FLOW_PORT_MAP_TBL_INC;
+	ppe_read(ppe_dev, index, &val);
+	*port = FIELD_GET(PPE_L1_FLOW_PORT_MAP_TBL_PORT_NUM, val);
+
+	index = PPE_L1_COMP_CFG_TBL + node_id * PPE_L1_COMP_CFG_TBL_INC;
+	ppe_read(ppe_dev, index, &val);
+	scheduler_cfg->drr_frame_mode = FIELD_GET(PPE_L1_COMP_CFG_TBL_DRR_METER_LEN, val);
+
+	return 0;
+}
+
+static int ppe_queue_scheduler_set(struct ppe_device *ppe_dev,
+				   int node_id, int level, int port,
+				   struct ppe_qos_scheduler_cfg scheduler_cfg)
+{
+	if (level == 0)
+		return ppe_scheduler_l0_queue_map_set(ppe_dev, node_id, port, scheduler_cfg);
+	else if (level == 1)
+		return ppe_scheduler_l1_queue_map_set(ppe_dev, node_id, port, scheduler_cfg);
+	else
+		return -EINVAL;
+}
+
+static int ppe_queue_scheduler_get(struct ppe_device *ppe_dev,
+				   int node_id, int level, int *port,
+				   struct ppe_qos_scheduler_cfg *scheduler_cfg)
+{
+	if (level == 0)
+		return ppe_scheduler_l0_queue_map_get(ppe_dev, node_id, port, scheduler_cfg);
+	else if (level == 1)
+		return ppe_scheduler_l1_queue_map_get(ppe_dev, node_id, port, scheduler_cfg);
+	else
+		return -EINVAL;
+}
+
+static const struct ppe_queue_ops qcom_ppe_queue_config_ops = {
+	.queue_scheduler_set = ppe_queue_scheduler_set,
+	.queue_scheduler_get = ppe_queue_scheduler_get,
+};
+
+const struct ppe_queue_ops *ppe_queue_config_ops_get(void)
+{
+	return &qcom_ppe_queue_config_ops;
+}
+EXPORT_SYMBOL_GPL(ppe_queue_config_ops_get);
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_ops.h b/drivers/net/ethernet/qualcomm/ppe/ppe_ops.h
new file mode 100644
index 000000000000..4980e3fed1c0
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_ops.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/* Low level PPE operations to be used by higher level network drivers
+ * such as ethernet or QoS drivers.
+ */
+
+#ifndef __PPE_OPS_H__
+#define __PPE_OPS_H__
+
+/* PPE hardware QoS configurations used to dispatch the packet passed
+ * through PPE, the scheduler supports DRR(deficit round robin with the
+ * weight) and SP(strict priority).
+ */
+struct ppe_qos_scheduler_cfg {
+	int sp_id;
+	int e_pri;
+	int c_pri;
+	int c_drr_id;
+	int e_drr_id;
+	int e_drr_wt;
+	int c_drr_wt;
+	int c_drr_unit;
+	int e_drr_unit;
+	int drr_frame_mode;
+};
+
+/* The operations are used to configure the PPE queue related resource */
+struct ppe_queue_ops {
+	int (*queue_scheduler_set)(struct ppe_device *ppe_dev,
+				   int node_id,
+				   int level,
+				   int port,
+				   struct ppe_qos_scheduler_cfg scheduler_cfg);
+	int (*queue_scheduler_get)(struct ppe_device *ppe_dev,
+				   int node_id,
+				   int level,
+				   int *port,
+				   struct ppe_qos_scheduler_cfg *scheduler_cfg);
+};
+
+const struct ppe_queue_ops *ppe_queue_config_ops_get(void);
+#endif
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
index 589f92a4f607..10daa70f28e9 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
@@ -31,11 +31,75 @@
 #define PPE_PSCH_TDM_DEPTH_CFG_INC				4
 #define PPE_PSCH_TDM_DEPTH_CFG_TDM_DEPTH			GENMASK(7, 0)
 
+#define PPE_L0_FLOW_MAP_TBL					0x402000
+#define PPE_L0_FLOW_MAP_TBL_NUM					300
+#define PPE_L0_FLOW_MAP_TBL_INC					0x10
+#define PPE_L0_FLOW_MAP_TBL_SP_ID				GENMASK(5, 0)
+#define PPE_L0_FLOW_MAP_TBL_C_PRI				GENMASK(8, 6)
+#define PPE_L0_FLOW_MAP_TBL_E_PRI				GENMASK(11, 9)
+#define PPE_L0_FLOW_MAP_TBL_C_DRR_WT				GENMASK(21, 12)
+#define PPE_L0_FLOW_MAP_TBL_E_DRR_WT				GENMASK(31, 22)
+
+#define PPE_L0_C_SP_CFG_TBL					0x404000
+#define PPE_L0_C_SP_CFG_TBL_NUM					512
+#define PPE_L0_C_SP_CFG_TBL_INC					0x10
+#define PPE_L0_C_SP_CFG_TBL_DRR_ID				GENMASK(7, 0)
+#define PPE_L0_C_SP_CFG_TBL_DRR_CREDIT_UNIT			BIT(8)
+
+#define PPE_L0_E_SP_CFG_TBL					0x406000
+#define PPE_L0_E_SP_CFG_TBL_NUM					512
+#define PPE_L0_E_SP_CFG_TBL_INC					0x10
+#define PPE_L0_E_SP_CFG_TBL_DRR_ID				GENMASK(7, 0)
+#define PPE_L0_E_SP_CFG_TBL_DRR_CREDIT_UNIT			BIT(8)
+
+#define PPE_L0_FLOW_PORT_MAP_TBL				0x408000
+#define PPE_L0_FLOW_PORT_MAP_TBL_NUM				300
+#define PPE_L0_FLOW_PORT_MAP_TBL_INC				0x10
+#define PPE_L0_FLOW_PORT_MAP_TBL_PORT_NUM			GENMASK(3, 0)
+
+#define PPE_L0_COMP_CFG_TBL					0x428000
+#define PPE_L0_COMP_CFG_TBL_NUM					300
+#define PPE_L0_COMP_CFG_TBL_INC					0x10
+#define PPE_L0_COMP_CFG_TBL_SHAPER_METER_LEN			GENMASK(1, 0)
+#define PPE_L0_COMP_CFG_TBL_DRR_METER_LEN			GENMASK(3, 2)
+
 #define PPE_DEQ_OPR_TBL						0x430000
 #define PPE_DEQ_OPR_TBL_NUM					300
 #define PPE_DEQ_OPR_TBL_INC					0x10
 #define PPE_ENQ_OPR_TBL_DEQ_DISABLE				BIT(0)
 
+#define PPE_L1_FLOW_MAP_TBL					0x440000
+#define PPE_L1_FLOW_MAP_TBL_NUM					64
+#define PPE_L1_FLOW_MAP_TBL_INC					0x10
+#define PPE_L1_FLOW_MAP_TBL_SP_ID				GENMASK(3, 0)
+#define PPE_L1_FLOW_MAP_TBL_C_PRI				GENMASK(6, 4)
+#define PPE_L1_FLOW_MAP_TBL_E_PRI				GENMASK(9, 7)
+#define PPE_L1_FLOW_MAP_TBL_C_DRR_WT				GENMASK(19, 10)
+#define PPE_L1_FLOW_MAP_TBL_E_DRR_WT				GENMASK(29, 20)
+
+#define PPE_L1_C_SP_CFG_TBL					0x442000
+#define PPE_L1_C_SP_CFG_TBL_NUM					64
+#define PPE_L1_C_SP_CFG_TBL_INC					0x10
+#define PPE_L1_C_SP_CFG_TBL_DRR_ID				GENMASK(5, 0)
+#define PPE_L1_C_SP_CFG_TBL_DRR_CREDIT_UNIT			BIT(6)
+
+#define PPE_L1_E_SP_CFG_TBL					0x444000
+#define PPE_L1_E_SP_CFG_TBL_NUM					64
+#define PPE_L1_E_SP_CFG_TBL_INC					0x10
+#define PPE_L1_E_SP_CFG_TBL_DRR_ID				GENMASK(5, 0)
+#define PPE_L1_E_SP_CFG_TBL_DRR_CREDIT_UNIT			BIT(6)
+
+#define PPE_L1_FLOW_PORT_MAP_TBL				0x446000
+#define PPE_L1_FLOW_PORT_MAP_TBL_NUM				64
+#define PPE_L1_FLOW_PORT_MAP_TBL_INC				0x10
+#define PPE_L1_FLOW_PORT_MAP_TBL_PORT_NUM			GENMASK(3, 0)
+
+#define PPE_L1_COMP_CFG_TBL					0x46a000
+#define PPE_L1_COMP_CFG_TBL_NUM					64
+#define PPE_L1_COMP_CFG_TBL_INC					0x10
+#define PPE_L1_COMP_CFG_TBL_SHAPER_METER_LEN			GENMASK(1, 0)
+#define PPE_L1_COMP_CFG_TBL_DRR_METER_LEN			GENMASK(3, 2)
+
 #define PPE_PSCH_TDM_CFG_TBL					0x47a000
 #define PPE_PSCH_TDM_CFG_TBL_NUM				128
 #define PPE_PSCH_TDM_CFG_TBL_INC				0x10
-- 
2.42.0


