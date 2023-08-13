Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8941977A74B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjHMPNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 11:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjHMPNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:13:39 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC1F10E2;
        Sun, 13 Aug 2023 08:13:40 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37DFDK9i030334;
        Sun, 13 Aug 2023 15:13:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=kFUiEoEoZ1Vs4dE+vROiuMoI1HpIWm3S7XB97gOzDuc=;
 b=eP++6vuNwUwvCVkq/sFgvG0kUkjGwBqpGW4bCJI/N/0aqfHqnCL4W4LXilzk+sI8w+GP
 ot13nruaQnvoenVW0AVWNt3Buu+wz/q0kLKvas607XcPQ6ClSs/yrhvm6HSfVwbAtBmN
 L62jXHjiVBJnVhkvzgj0bdQLg95hPbOhRI5yFhaOxgzrRP0NzyzR9+9tVXMYFpVucwEl
 PURP3Iakd/mukv8Vdy7gjNrwoj77q8bzh6QkEi+E/Cpfhg0i33UO8XAcsBzc6AGb1I8V
 qT2RLrGWsNOpzGT1GoVZm+HGCcqn6y1uiwKcuWsQ7k9GLIEYp2o8IplaE2qIzClAG/8J Sw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3se3hssuqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Aug 2023 15:13:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37DFDJNP032396
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Aug 2023 15:13:19 GMT
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sun, 13 Aug 2023 08:13:14 -0700
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        "Tao Zhang" <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
Subject: [PATCH v2 1/3] Coresight: Add driver to support for CSR
Date:   Sun, 13 Aug 2023 23:12:51 +0800
Message-ID: <20230813151253.38128-2-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230813151253.38128-1-quic_jinlmao@quicinc.com>
References: <20230813151253.38128-1-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0CRzqVvXJnvQUTgkHWoD9LmfobEtKIf_
X-Proofpoint-ORIG-GUID: 0CRzqVvXJnvQUTgkHWoD9LmfobEtKIf_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-13_14,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308130143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver provides support for CoreSight Slave Register block
that hosts miscellaneous configuration registers. Those
configuration registers can be used to control, various coresight
configurations.

Signed-off-by: Hao Zhang <quic_hazha@quicinc.com>
Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 drivers/hwtracing/coresight/Kconfig           |  12 ++
 drivers/hwtracing/coresight/Makefile          |   2 +
 .../hwtracing/coresight/coresight-csr-core.c  | 104 ++++++++++++++++++
 drivers/hwtracing/coresight/coresight-csr.h   |  32 ++++++
 4 files changed, 150 insertions(+)
 create mode 100644 drivers/hwtracing/coresight/coresight-csr-core.c
 create mode 100644 drivers/hwtracing/coresight/coresight-csr.h

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index 06f0a7594169..ddabab1e2516 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -247,4 +247,16 @@ config CORESIGHT_DUMMY
 
 	  To compile this driver as a module, choose M here: the module will be
 	  called coresight-dummy.
+
+config CORESIGHT_CSR
+	tristate "CoreSight Slave Register driver"
+	help
+	  This driver provides support for CoreSight Slave Register block
+	  that hosts miscellaneous configuration registers.
+	  Those configuration registers can be used to control, various
+	  coresight configurations.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called coresight-csr.
+
 endif
diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index 995d3b2c76df..6f8d17003ff7 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -31,3 +31,5 @@ coresight-cti-y := coresight-cti-core.o	coresight-cti-platform.o \
 		   coresight-cti-sysfs.o
 obj-$(CONFIG_ULTRASOC_SMB) += ultrasoc-smb.o
 obj-$(CONFIG_CORESIGHT_DUMMY) += coresight-dummy.o
+obj-$(CONFIG_CORESIGHT_CSR) += coresight-csr.o
+coresight-csr-y := coresight-csr-core.o
diff --git a/drivers/hwtracing/coresight/coresight-csr-core.c b/drivers/hwtracing/coresight/coresight-csr-core.c
new file mode 100644
index 000000000000..e07070b650d3
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-csr-core.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+
+#include "coresight-priv.h"
+#include "coresight-csr.h"
+
+DEFINE_CORESIGHT_DEVLIST(csr_devs, "csr");
+
+static int csr_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct coresight_platform_data *pdata;
+	struct csr_drvdata *drvdata;
+	struct resource *res;
+	struct coresight_desc desc = { 0 };
+
+	desc.name = coresight_alloc_device_name(&csr_devs, dev);
+	if (!desc.name)
+		return -ENOMEM;
+	pdata = coresight_get_platform_data(dev);
+	if (IS_ERR(pdata))
+		return PTR_ERR(pdata);
+	pdev->dev.platform_data = pdata;
+
+	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+	drvdata->dev = &pdev->dev;
+	platform_set_drvdata(pdev, drvdata);
+
+	drvdata->clk = devm_clk_get(dev, "apb_pclk");
+	if (IS_ERR(drvdata->clk))
+		dev_dbg(dev, "csr not config clk\n");
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "csr-base");
+	if (!res)
+		return -ENODEV;
+	drvdata->pbase = res->start;
+
+	drvdata->base = devm_ioremap(dev, res->start, resource_size(res));
+	if (!drvdata->base)
+		return -ENOMEM;
+
+	desc.type = CORESIGHT_DEV_TYPE_HELPER;
+	desc.pdata = pdev->dev.platform_data;
+	desc.dev = &pdev->dev;
+
+	drvdata->csdev = coresight_register(&desc);
+	if (IS_ERR(drvdata->csdev))
+		return PTR_ERR(drvdata->csdev);
+
+	spin_lock_init(&drvdata->spin_lock);
+
+	dev_dbg(dev, "CSR initialized: %s\n", dev_name(dev));
+	return 0;
+}
+
+static int csr_remove(struct platform_device *pdev)
+{
+	struct csr_drvdata *drvdata = platform_get_drvdata(pdev);
+
+	coresight_unregister(drvdata->csdev);
+	return 0;
+}
+
+static const struct of_device_id csr_match[] = {
+	{.compatible = "qcom,coresight-csr"},
+	{}
+};
+
+static struct platform_driver csr_driver = {
+	.probe          = csr_probe,
+	.remove         = csr_remove,
+	.driver         = {
+		.name   = "coresight-csr",
+		.of_match_table = csr_match,
+		.suppress_bind_attrs = true,
+	},
+};
+
+static int __init csr_init(void)
+{
+	return platform_driver_register(&csr_driver);
+}
+module_init(csr_init);
+
+static void __exit csr_exit(void)
+{
+	platform_driver_unregister(&csr_driver);
+}
+module_exit(csr_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("CoreSight CSR driver");
diff --git a/drivers/hwtracing/coresight/coresight-csr.h b/drivers/hwtracing/coresight/coresight-csr.h
new file mode 100644
index 000000000000..b4fb947fe23b
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-csr.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _CORESIGHT_CSR_H
+#define _CORESIGHT_CSR_H
+#include <linux/clk.h>
+#include <linux/coresight.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+
+/**
+ * struct csr_drvdata - specifics for the CSR device.
+ * @base:	Memory mapped base address for this component.
+ * @pbase:	Physical address base.
+ * @dev:	The device entity associated to this component.
+ * @csdev:	Data struct for coresight device.
+ * @clk:	Clock of this component.
+ * @spin_lock:	Spin lock for the data.
+ */
+struct csr_drvdata {
+	void __iomem		*base;
+	phys_addr_t		pbase;
+	struct device		*dev;
+	struct coresight_device	*csdev;
+	struct clk		*clk;
+	spinlock_t		spin_lock;
+};
+
+#endif
+
-- 
2.17.1

