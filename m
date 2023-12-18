Return-Path: <linux-kernel+bounces-3449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2C9816C74
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5789AB2308E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588221B27A;
	Mon, 18 Dec 2023 11:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZFmnun9K"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE1A199DB;
	Mon, 18 Dec 2023 11:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIAsCGw032638;
	Mon, 18 Dec 2023 11:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=LX6X6WF6b2DnvVb0x9SqnHVvPQHNfSxl8FB6K8HP6sw=; b=ZF
	mnun9KydsAw/asYajUI0JUh42vUrjSf+0MHeYm6RTwMPXdlHC4x7gaVHerzb1KP4
	fPSnnQ5cYhW3siUfRYddUSOwSP7IarEXLy4wsgqKKGKpxfuzt2j9JZdyRHnJjV2C
	qy1ZRRNWIRcwp6i7MFf9vL83N8fCyFhA4RATSx1hYTuNH4k1Oa42dkveDKsMwWzO
	zU0dHaNWvvYv6NYSQyW/xk0dWaKumFmo375ZtyfV7QLfZ0Uzq/+Wv8QUMNDNfUlx
	Q+Dr6aBVETfgFzEhbOdZjfyB7ktxnJkh+0oALHkWZaMVH77IA8CtpqcMKczhklt5
	ngjdByKMM1+jYQDX89gQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v14xy44cs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 11:36:10 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BIBVmpM028250;
	Mon, 18 Dec 2023 11:36:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3v14ykyyhc-1;
	Mon, 18 Dec 2023 11:33:07 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX7XZ029998;
	Mon, 18 Dec 2023 11:33:07 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3BIBX62X029968;
	Mon, 18 Dec 2023 11:33:07 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 2E22822C6; Mon, 18 Dec 2023 17:03:04 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2 06/34] media: iris: register video device to platform driver
Date: Mon, 18 Dec 2023 17:02:01 +0530
Message-Id: <1702899149-21321-7-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aYFzfkEloCRmcSdpA9dm31aQYrFM9uqY
X-Proofpoint-ORIG-GUID: aYFzfkEloCRmcSdpA9dm31aQYrFM9uqY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312180083
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Iris is a multi pipe based video acceleration hardware
block that offloads video stream encoding and decoding
from the application processor (AP). It supports H.264
and H.265 encoding and decoding, as well as VP9 decoding.
The AP communicates with hardware through a well defined
protocol which provides fine-grained and asynchronous
control over individual hardware features.

This patch introduces basic probe and remove functions.
It handles setting up a video device as well as registering
it with the V4L2 subsystem.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 drivers/media/platform/qcom/Kconfig                |   1 +
 drivers/media/platform/qcom/Makefile               |   1 +
 drivers/media/platform/qcom/vcodec/iris/Kconfig    |  13 +++
 drivers/media/platform/qcom/vcodec/iris/Makefile   |   3 +
 .../media/platform/qcom/vcodec/iris/iris_core.h    |  34 +++++++
 .../media/platform/qcom/vcodec/iris/iris_probe.c   | 111 +++++++++++++++++++++
 6 files changed, 163 insertions(+)
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/Kconfig
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/Makefile
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_core.h
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_probe.c

diff --git a/drivers/media/platform/qcom/Kconfig b/drivers/media/platform/qcom/Kconfig
index e94142f..7c88837 100644
--- a/drivers/media/platform/qcom/Kconfig
+++ b/drivers/media/platform/qcom/Kconfig
@@ -4,3 +4,4 @@ comment "Qualcomm media platform drivers"
 
 source "drivers/media/platform/qcom/camss/Kconfig"
 source "drivers/media/platform/qcom/vcodec/venus/Kconfig"
+source "drivers/media/platform/qcom/vcodec/iris/Kconfig"
diff --git a/drivers/media/platform/qcom/Makefile b/drivers/media/platform/qcom/Makefile
index 3d2d82b..3c76969 100644
--- a/drivers/media/platform/qcom/Makefile
+++ b/drivers/media/platform/qcom/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y += camss/
 obj-y += vcodec/venus/
+obj-y += vcodec/iris/
diff --git a/drivers/media/platform/qcom/vcodec/iris/Kconfig b/drivers/media/platform/qcom/vcodec/iris/Kconfig
new file mode 100644
index 0000000..850a5b4
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/Kconfig
@@ -0,0 +1,13 @@
+config VIDEO_QCOM_IRIS
+        tristate "Qualcomm Iris V4L2 encoder/decoder driver"
+        depends on VIDEO_DEV
+        depends on ARCH_QCOM
+        select QCOM_MDT_LOADER if ARCH_QCOM
+        select QCOM_SCM
+        select DMABUF_HEAPS
+	select DMABUF_HEAPS_SYSTEM
+        help
+          This is a V4L2 driver for Qualcomm Iris video accelerator
+          hardware. It accelerates encoding and decoding operations
+          on various Qualcomm SoCs.
+          To compile this driver as a module choose m here.
diff --git a/drivers/media/platform/qcom/vcodec/iris/Makefile b/drivers/media/platform/qcom/vcodec/iris/Makefile
new file mode 100644
index 0000000..5536ae0
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/Makefile
@@ -0,0 +1,3 @@
+iris-objs += iris_probe.o
+
+obj-$(CONFIG_VIDEO_QCOM_IRIS) += iris.o
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_core.h b/drivers/media/platform/qcom/vcodec/iris/iris_core.h
new file mode 100644
index 0000000..ab7fcee
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_core.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _IRIS_CORE_H_
+#define _IRIS_CORE_H_
+
+#include <linux/types.h>
+#include <media/v4l2-device.h>
+
+/**
+ * struct iris_core - holds core parameters valid for all instances
+ *
+ * @dev: reference to device structure
+ * @reg_base: IO memory base address
+ * @irq: iris irq
+ * @v4l2_dev: a holder for v4l2 device structure
+ * @vdev_dec: iris video device structure for decoder
+ * @v4l2_file_ops: iris v4l2 file ops
+ * @v4l2_ioctl_ops: iris v4l2 ioctl ops
+ */
+
+struct iris_core {
+	struct device				*dev;
+	void __iomem				*reg_base;
+	int					irq;
+	struct v4l2_device			v4l2_dev;
+	struct video_device			*vdev_dec;
+	const struct v4l2_file_operations	*v4l2_file_ops;
+	const struct v4l2_ioctl_ops		*v4l2_ioctl_ops;
+};
+
+#endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_probe.c b/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
new file mode 100644
index 0000000..2e93118
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "iris_core.h"
+
+static int iris_register_video_device(struct iris_core *core)
+{
+	struct video_device *vdev;
+	int ret;
+
+	vdev = video_device_alloc();
+	if (!vdev)
+		return -ENOMEM;
+
+	strscpy(vdev->name, "qcom-iris-decoder", sizeof(vdev->name));
+	vdev->release = video_device_release;
+	vdev->fops = core->v4l2_file_ops;
+	vdev->ioctl_ops = core->v4l2_ioctl_ops;
+	vdev->vfl_dir = VFL_DIR_M2M;
+	vdev->v4l2_dev = &core->v4l2_dev;
+	vdev->device_caps = V4L2_CAP_VIDEO_M2M_MPLANE | V4L2_CAP_STREAMING;
+
+	ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
+	if (ret)
+		goto err_vdev_release;
+
+	core->vdev_dec = vdev;
+	video_set_drvdata(vdev, core);
+
+	return ret;
+
+err_vdev_release:
+	video_device_release(vdev);
+
+	return ret;
+}
+
+static void iris_remove(struct platform_device *pdev)
+{
+	struct iris_core *core;
+
+	core = platform_get_drvdata(pdev);
+	if (!core)
+		return;
+
+	video_unregister_device(core->vdev_dec);
+
+	v4l2_device_unregister(&core->v4l2_dev);
+}
+
+static int iris_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct iris_core *core;
+	int ret;
+
+	core = devm_kzalloc(&pdev->dev, sizeof(*core), GFP_KERNEL);
+	if (!core)
+		return -ENOMEM;
+	core->dev = dev;
+
+	core->reg_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(core->reg_base))
+		return PTR_ERR(core->reg_base);
+
+	core->irq = platform_get_irq(pdev, 0);
+	if (core->irq < 0)
+		return core->irq;
+
+	ret = v4l2_device_register(dev, &core->v4l2_dev);
+	if (ret)
+		return ret;
+
+	ret = iris_register_video_device(core);
+	if (ret)
+		goto err_v4l2_unreg;
+
+	platform_set_drvdata(pdev, core);
+
+	return ret;
+
+err_v4l2_unreg:
+	v4l2_device_unregister(&core->v4l2_dev);
+
+	return ret;
+}
+
+static const struct of_device_id iris_dt_match[] = {
+	{ .compatible = "qcom,sm8550-iris", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, iris_dt_match);
+
+static struct platform_driver qcom_iris_driver = {
+	.probe = iris_probe,
+	.remove_new = iris_remove,
+	.driver = {
+		.name = "qcom-iris",
+		.of_match_table = iris_dt_match,
+	},
+};
+
+module_platform_driver(qcom_iris_driver);
+MODULE_DESCRIPTION("Qualcomm Iris video driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4


