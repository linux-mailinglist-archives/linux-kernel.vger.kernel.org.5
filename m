Return-Path: <linux-kernel+bounces-3472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D48F6816CCD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5057AB21103
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF8938FBE;
	Mon, 18 Dec 2023 11:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XzZN8sHB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4373F374D7;
	Mon, 18 Dec 2023 11:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIAtAkP007257;
	Mon, 18 Dec 2023 11:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=iNKyHQ8h/NpFc83aGl2oTQT1CzgFzngR8xdKmuX4b8k=; b=Xz
	ZN8sHB0XNgIBi+6EaRknJe5/ifxN/X18P7MLOR9wqWuvk+VHC+rdpEIO54oDc6K5
	s+vyKYjiJuzIHYPRurOG0b2QnA6tZzkMLCqj8D1UUnpTh8UOEgCmPjzK0QzT5JLl
	x/NqJ3GtzTjmDyfmk+7iGcA4vUFa4wFchllFswl6lguhKiRVwCQZCPYqUsnFaW7t
	07BUa5QuNuMIcYvrw82zL0dOpmvV6eydmB599ed54WXSDqhHq9jsJQiq4oVPOssJ
	JxQTRGrViXMYBBL9KfzsDzTgC7jhGfGkzcITRImwNmGthXUXgCD9y6D3hxGWSQDX
	nFEi6Xx/unmTCH3eSKQg==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2mb9g4y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 11:40:04 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BIBe0FQ004875;
	Mon, 18 Dec 2023 11:40:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3v14ym00ac-3;
	Mon, 18 Dec 2023 11:40:01 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BIBa9rY000378;
	Mon, 18 Dec 2023 11:36:09 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3BIBX8rd030068;
	Mon, 18 Dec 2023 11:36:09 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 698372389; Mon, 18 Dec 2023 17:03:04 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2 30/34] media: iris: register video encoder device to platform driver
Date: Mon, 18 Dec 2023 17:02:25 +0530
Message-Id: <1702899149-21321-31-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BM17vDS2em8D_fMU0u92xI97O_1Ahvlb
X-Proofpoint-GUID: BM17vDS2em8D_fMU0u92xI97O_1Ahvlb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 impostorscore=0 adultscore=0 mlxscore=0 clxscore=1015
 spamscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180084
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Register/unregister video Encoder device.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 .../media/platform/qcom/vcodec/iris/iris_common.h  |  5 +++
 .../media/platform/qcom/vcodec/iris/iris_core.h    |  2 ++
 .../media/platform/qcom/vcodec/iris/iris_probe.c   | 42 ++++++++++++++++------
 3 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_common.h b/drivers/media/platform/qcom/vcodec/iris/iris_common.h
index 3ab4767..b1273d0 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_common.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_common.h
@@ -30,6 +30,11 @@
 
 #define INPUT_TIMER_LIST_SIZE 30
 
+enum domain_type {
+	ENCODER	= BIT(0),
+	DECODER	= BIT(1),
+};
+
 enum codec_type {
 	H264	= BIT(0),
 	HEVC	= BIT(1),
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_core.h b/drivers/media/platform/qcom/vcodec/iris/iris_core.h
index 50553d2..c56eb24 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_core.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_core.h
@@ -23,6 +23,7 @@
  * @irq: iris irq
  * @v4l2_dev: a holder for v4l2 device structure
  * @vdev_dec: iris video device structure for decoder
+ * @vdev_enc: iris video device structure for encoder
  * @v4l2_file_ops: iris v4l2 file ops
  * @v4l2_ioctl_ops: iris v4l2 ioctl ops
  * @bus_tbl: table of iris buses
@@ -66,6 +67,7 @@ struct iris_core {
 	int					irq;
 	struct v4l2_device			v4l2_dev;
 	struct video_device			*vdev_dec;
+	struct video_device			*vdev_enc;
 	const struct v4l2_file_operations	*v4l2_file_ops;
 	const struct v4l2_ioctl_ops		*v4l2_ioctl_ops;
 	struct bus_info				*bus_tbl;
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_probe.c b/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
index 2571e27..b487e83 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
@@ -31,16 +31,15 @@ static int init_iris_isr(struct iris_core *core)
 	return ret;
 }
 
-static int iris_register_video_device(struct iris_core *core)
+static int iris_register_video_device(struct iris_core *core, enum domain_type type)
 {
 	struct video_device *vdev;
-	int ret;
+	int ret = 0;
 
 	vdev = video_device_alloc();
 	if (!vdev)
 		return -ENOMEM;
 
-	strscpy(vdev->name, "qcom-iris-decoder", sizeof(vdev->name));
 	vdev->release = video_device_release;
 	vdev->fops = core->v4l2_file_ops;
 	vdev->ioctl_ops = core->v4l2_ioctl_ops;
@@ -48,11 +47,24 @@ static int iris_register_video_device(struct iris_core *core)
 	vdev->v4l2_dev = &core->v4l2_dev;
 	vdev->device_caps = V4L2_CAP_VIDEO_M2M_MPLANE | V4L2_CAP_STREAMING;
 
-	ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
-	if (ret)
-		goto err_vdev_release;
+	if (type == DECODER) {
+		strscpy(vdev->name, "qcom-iris-decoder", sizeof(vdev->name));
+
+		ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
+		if (ret)
+			goto err_vdev_release;
+
+		core->vdev_dec = vdev;
+	} else if (type == ENCODER) {
+		strscpy(vdev->name, "qcom-iris-encoder", sizeof(vdev->name));
+
+		ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
+		if (ret)
+			goto err_vdev_release;
+
+		core->vdev_enc = vdev;
+	}
 
-	core->vdev_dec = vdev;
 	video_set_drvdata(vdev, core);
 
 	return ret;
@@ -80,6 +92,8 @@ static void iris_remove(struct platform_device *pdev)
 
 	video_unregister_device(core->vdev_dec);
 
+	video_unregister_device(core->vdev_enc);
+
 	v4l2_device_unregister(&core->v4l2_dev);
 
 	iris_pm_put(core, false);
@@ -185,17 +199,21 @@ static int iris_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_runtime_disable;
 
-	ret = iris_register_video_device(core);
+	ret = iris_register_video_device(core, DECODER);
 	if (ret)
 		goto err_v4l2_unreg;
 
+	ret = iris_register_video_device(core, ENCODER);
+	if (ret)
+		goto err_vdev_unreg_dec;
+
 	platform_set_drvdata(pdev, core);
 
 	dma_mask = core->cap[DMA_MASK].value;
 
 	ret = dma_set_mask_and_coherent(dev, dma_mask);
 	if (ret)
-		goto err_vdev_unreg;
+		goto err_vdev_unreg_enc;
 
 	dma_set_max_seg_size(&pdev->dev, (unsigned int)DMA_BIT_MASK(32));
 	dma_set_seg_boundary(&pdev->dev, (unsigned long)DMA_BIT_MASK(64));
@@ -206,7 +224,7 @@ static int iris_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err_probe(core->dev, ret,
 			      "%s: interface queues init failed\n", __func__);
-		goto err_vdev_unreg;
+		goto err_vdev_unreg_enc;
 	}
 
 	ret = iris_pm_get(core);
@@ -236,7 +254,9 @@ static int iris_probe(struct platform_device *pdev)
 	hfi_queue_deinit(core->dev, &core->iface_q_table, &core->sfr,
 			 &core->command_queue, &core->message_queue,
 			 &core->debug_queue);
-err_vdev_unreg:
+err_vdev_unreg_enc:
+	video_unregister_device(core->vdev_enc);
+err_vdev_unreg_dec:
 	video_unregister_device(core->vdev_dec);
 err_v4l2_unreg:
 	v4l2_device_unregister(&core->v4l2_dev);
-- 
2.7.4


