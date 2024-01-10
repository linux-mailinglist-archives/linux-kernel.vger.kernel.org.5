Return-Path: <linux-kernel+bounces-22121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD11829999
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4FC61C21435
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2534BAAD;
	Wed, 10 Jan 2024 11:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Z20P94F4"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14ED4879B;
	Wed, 10 Jan 2024 11:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40ABe0Nw026234;
	Wed, 10 Jan 2024 11:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=JND3/LNjzReWO7D3+6yRtPc7s1nMiTrhCyJRg5lEo4k=; b=Z2
	0P94F48UvZ9KXy9Ff0Q273Ngxl9YUL+aayJs9ILgtFYHyt7IyqWhYAVhzWcAzsTC
	jJbKUVgoGYepNgquTNQpnL1O/0h3K1O/JAr8oaIAyGwN+bdu3BlsR8D+ISj0uBnm
	SZcH+zha680wkpX6Ty7BplqSAqDECUNAi2lrfwukHE6gvL4lHv5nbGjM0BCzbE/2
	5aXak9l7yHJow7t5nm/5/G1ZruOvlDwxqmnQ41qzL4f4mAz89YeLwOLFiUAAVlcu
	KLoo1n821A89TBNyoV1WA21Y+pemYXLyf6sh7hCGnb42x1gusVzr0omeePUBAi3v
	BZ9CnLgcGQZJ1BUey3cQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh9vfj62p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:43:17 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40ABhGuH008239
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:43:16 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 03:43:06 -0800
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
Subject: [PATCH net-next 13/20] net: ethernet: qualcomm: Export PPE function set_maxframe
Date: Wed, 10 Jan 2024 19:40:25 +0800
Message-ID: <20240110114033.32575-14-quic_luoj@quicinc.com>
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
X-Proofpoint-GUID: n1QmJNn7dlqT7gHPUt13wc-Q_2D6pHOs
X-Proofpoint-ORIG-GUID: n1QmJNn7dlqT7gHPUt13wc-Q_2D6pHOs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100096

set_maxframe is called when the MTU of interface is configured, which
limits the size of packet passed through PPE.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/ethernet/qualcomm/ppe/ppe.c | 41 +++++++++++++++++++++++++
 include/linux/soc/qcom/ppe.h            | 12 ++++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.c b/drivers/net/ethernet/qualcomm/ppe/ppe.c
index 746ef42fea5d..d0e0fa9d5609 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe.c
@@ -12,6 +12,7 @@
 #include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/platform_device.h>
+#include <linux/if_ether.h>
 #include <linux/soc/qcom/ppe.h>
 #include "ppe.h"
 #include "ppe_regs.h"
@@ -293,6 +294,45 @@ struct ppe_device *ppe_dev_get(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(ppe_dev_get);
 
+struct ppe_device_ops *ppe_ops_get(struct platform_device *pdev)
+{
+	struct ppe_device *ppe_dev = platform_get_drvdata(pdev);
+
+	if (!ppe_dev)
+		return NULL;
+
+	return ppe_dev->ppe_ops;
+}
+EXPORT_SYMBOL_GPL(ppe_ops_get);
+
+static int ppe_port_maxframe_set(struct ppe_device *ppe_dev,
+				 int port, int maxframe_size)
+{
+	union ppe_mru_mtu_ctrl_cfg_u mru_mtu_cfg;
+
+	/* The max frame size should be MTU added by ETH_HLEN in PPE */
+	maxframe_size += ETH_HLEN;
+
+	if (port < PPE_MC_MTU_CTRL_TBL_NUM)
+		ppe_mask(ppe_dev, PPE_MC_MTU_CTRL_TBL + PPE_MC_MTU_CTRL_TBL_INC * port,
+			 PPE_MC_MTU_CTRL_TBL_MTU,
+			 FIELD_PREP(PPE_MC_MTU_CTRL_TBL_MTU, maxframe_size));
+
+	memset(&mru_mtu_cfg, 0, sizeof(mru_mtu_cfg));
+	ppe_read_tbl(ppe_dev, PPE_MRU_MTU_CTRL_TBL + PPE_MRU_MTU_CTRL_TBL_INC * port,
+		     mru_mtu_cfg.val, sizeof(mru_mtu_cfg.val));
+
+	mru_mtu_cfg.bf.mru = maxframe_size;
+	mru_mtu_cfg.bf.mtu = maxframe_size;
+
+	return ppe_write_tbl(ppe_dev, PPE_MRU_MTU_CTRL_TBL + PPE_MRU_MTU_CTRL_TBL_INC * port,
+			     mru_mtu_cfg.val, sizeof(mru_mtu_cfg.val));
+}
+
+static struct ppe_device_ops qcom_ppe_ops = {
+	.set_maxframe = ppe_port_maxframe_set,
+};
+
 static const struct regmap_range ppe_readable_ranges[] = {
 	regmap_reg_range(0x0, 0x1FF), /* GLB */
 	regmap_reg_range(0x400, 0x5FF), /* LPI CSR */
@@ -1286,6 +1326,7 @@ static int qcom_ppe_probe(struct platform_device *pdev)
 				     ret,
 				     "ppe device hw init failed\n");
 
+	ppe_dev->ppe_ops = &qcom_ppe_ops;
 	ppe_dev->is_ppe_probed = true;
 	return 0;
 }
diff --git a/include/linux/soc/qcom/ppe.h b/include/linux/soc/qcom/ppe.h
index 90566a8841b4..70ee192d9ef0 100644
--- a/include/linux/soc/qcom/ppe.h
+++ b/include/linux/soc/qcom/ppe.h
@@ -16,13 +16,25 @@
 struct ppe_device {
 	struct device *dev;
 	struct regmap *regmap;
+	struct ppe_device_ops *ppe_ops;
 	bool is_ppe_probed;
 	void *ppe_priv;
 };
 
+/* PPE operations, which is used by the external driver like Ethernet
+ * DMA driver to configure PPE.
+ */
+struct ppe_device_ops {
+	int	(*set_maxframe)(struct ppe_device *ppe_dev, int port,
+				int maxframe_size);
+};
+
 /* Function used to check PPE platform dirver is registered correctly or not. */
 bool ppe_is_probed(struct platform_device *pdev);
 
 /* Function used to get the PPE device */
 struct ppe_device *ppe_dev_get(struct platform_device *pdev);
+
+/* Function used to get the operations of PPE device */
+struct ppe_device_ops *ppe_ops_get(struct platform_device *pdev);
 #endif
-- 
2.42.0


