Return-Path: <linux-kernel+bounces-3470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B64816CC7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 337CDB23380
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A964381CD;
	Mon, 18 Dec 2023 11:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Iow/hLS0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB14200C7;
	Mon, 18 Dec 2023 11:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIBDuCL018171;
	Mon, 18 Dec 2023 11:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=U89F2RsbUBam7okcX4qquI23KYt3c/bBrBXYoIhu7nc=; b=Io
	w/hLS0iYU+2wA536pvvoU0BPIdStACjIV8AU/h+87eQsegFLHRhM6Hxqxh8Lmk3B
	SSFddYPVaBBwJ0cxjOS84ggBpae47gPxsAQ2qQWADmiKqyDuUAje1ccXKEz1f6Gn
	uifQHzkc7MRQJAhUKCWtcTB00nJ6dYqB1XVE7evRhqKmkD0RLFLX86S6PkAQltAO
	M5TFvN1uezVsptxx+7JZem5mEJjSLJVboayoPe9qTT+seWeTBEbrPxd35dND7KPF
	D0eYtfrnDmEQNvERMLgnQdxpSN4z1yuKdgUR90vkfHQyuHSQnHnJXjlX+6MDa2KM
	AaFvGrcc/izLM855ieWQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2n1781tu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 11:40:03 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BIBe0wx004854;
	Mon, 18 Dec 2023 11:40:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3v14ym00ag-3;
	Mon, 18 Dec 2023 11:40:00 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX8Ya030075;
	Mon, 18 Dec 2023 11:33:08 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3BIBX8hq030062;
	Mon, 18 Dec 2023 11:33:08 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 4C494230A; Mon, 18 Dec 2023 17:03:04 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2 18/34] media: iris: introduce and implement iris vb2 mem ops
Date: Mon, 18 Dec 2023 17:02:13 +0530
Message-Id: <1702899149-21321-19-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: X0VFrL2CzS5cfywwCIMg4PGknbvtbMVt
X-Proofpoint-GUID: X0VFrL2CzS5cfywwCIMg4PGknbvtbMVt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=985 mlxscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312180084
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Vikash Garodia <quic_vgarodia@quicinc.com>

Implement the iris vb2 mem ops for buffer management for
DMABUF streaming mode. Update video driver buffer
with dma buf information.

Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 .../media/platform/qcom/vcodec/iris/iris_probe.c   |   1 +
 drivers/media/platform/qcom/vcodec/iris/iris_vb2.c | 147 +++++++++++++++++++++
 drivers/media/platform/qcom/vcodec/iris/iris_vb2.h |  10 ++
 .../media/platform/qcom/vcodec/iris/iris_vidc.c    |  11 ++
 4 files changed, 169 insertions(+)

diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_probe.c b/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
index 50fb93e..bf484a3 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
@@ -233,5 +233,6 @@ static struct platform_driver qcom_iris_driver = {
 };
 
 module_platform_driver(qcom_iris_driver);
+MODULE_IMPORT_NS(DMA_BUF);
 MODULE_DESCRIPTION("Qualcomm Iris video driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vb2.c b/drivers/media/platform/qcom/vcodec/iris/iris_vb2.c
index b040d27..a57b5fb 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_vb2.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vb2.c
@@ -69,3 +69,150 @@ int iris_vb2_queue_setup(struct vb2_queue *q,
 
 	return ret;
 }
+
+void *iris_vb2_attach_dmabuf(struct vb2_buffer *vb, struct device *dev,
+			     struct dma_buf *dbuf, unsigned long size)
+{
+	enum iris_buffer_type buf_type;
+	struct iris_buffers *buffers;
+	struct iris_buffer *iter;
+	struct iris_buffer *buf;
+	struct iris_inst *inst;
+	bool found = false;
+
+	if (!vb || !dev || !dbuf || !vb->vb2_queue)
+		return ERR_PTR(-EINVAL);
+
+	inst = vb->vb2_queue->drv_priv;
+
+	buf_type = v4l2_type_to_driver(vb->type);
+
+	buffers = iris_get_buffer_list(inst, buf_type);
+	if (!buffers)
+		return NULL;
+
+	list_for_each_entry(iter, &buffers->list, list) {
+		if (iter->index == vb->index) {
+			found = true;
+			buf = iter;
+			break;
+		}
+	}
+
+	if (!found)
+		return NULL;
+
+	buf->inst = inst;
+	buf->dmabuf = dbuf;
+
+	buf->attach = dma_buf_attach(dbuf, dev);
+	if (IS_ERR(buf->attach)) {
+		buf->attach = NULL;
+		return NULL;
+	}
+
+	return buf;
+}
+
+int iris_vb2_map_dmabuf(void *buf_priv)
+{
+	struct iris_buffer *buf = buf_priv;
+	struct iris_core *core;
+	struct iris_inst *inst;
+
+	if (!buf || !buf->inst)
+		return -EINVAL;
+
+	inst = buf->inst;
+	core = inst->core;
+
+	if (!buf->attach) {
+		dev_err(core->dev, "trying to map a non attached buffer\n");
+		return -EINVAL;
+	}
+
+	buf->sg_table = dma_buf_map_attachment(buf->attach, DMA_BIDIRECTIONAL);
+	if (IS_ERR(buf->sg_table))
+		return -EINVAL;
+
+	if (!buf->sg_table->sgl) {
+		dma_buf_unmap_attachment(buf->attach, buf->sg_table, DMA_BIDIRECTIONAL);
+		buf->sg_table = NULL;
+		return -EINVAL;
+	}
+
+	buf->device_addr = sg_dma_address(buf->sg_table->sgl);
+
+	return 0;
+}
+
+void iris_vb2_unmap_dmabuf(void *buf_priv)
+{
+	struct iris_buffer *buf = buf_priv;
+	struct iris_core *core;
+	struct iris_inst *inst;
+
+	if (!buf || !buf->inst)
+		return;
+
+	inst = buf->inst;
+	core = inst->core;
+
+	if (!buf->attach) {
+		dev_err(core->dev, "trying to unmap a non attached buffer\n");
+		return;
+	}
+
+	if (!buf->sg_table) {
+		dev_err(core->dev, "dmabuf buffer is already unmapped\n");
+		return;
+	}
+
+	if (buf->attach && buf->sg_table) {
+		dma_buf_unmap_attachment(buf->attach, buf->sg_table, DMA_BIDIRECTIONAL);
+		buf->sg_table = NULL;
+		buf->device_addr = 0x0;
+	}
+}
+
+void iris_vb2_detach_dmabuf(void *buf_priv)
+{
+	struct iris_buffer *buf = buf_priv;
+	struct iris_core *core;
+	struct iris_inst *inst;
+
+	if (!buf || !buf->inst)
+		return;
+
+	inst = buf->inst;
+	core = inst->core;
+
+	if (buf->sg_table) {
+		dev_err(core->dev, "trying to detach an unmapped buffer\n");
+		dma_buf_unmap_attachment(buf->attach, buf->sg_table, DMA_BIDIRECTIONAL);
+		buf->sg_table = NULL;
+	}
+
+	if (buf->attach && buf->dmabuf) {
+		dma_buf_detach(buf->dmabuf, buf->attach);
+		buf->attach = NULL;
+	}
+
+	buf->dmabuf = NULL;
+	buf->inst = NULL;
+}
+
+void *iris_vb2_alloc(struct vb2_buffer *vb, struct device *dev,
+		     unsigned long size)
+{
+	return (void *)0xdeadbeef;
+}
+
+void iris_vb2_put(void *buf_priv)
+{
+}
+
+int iris_vb2_mmap(void *buf_priv, struct vm_area_struct *vma)
+{
+	return 0;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vb2.h b/drivers/media/platform/qcom/vcodec/iris/iris_vb2.h
index 8a8e1039..4342034 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_vb2.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vb2.h
@@ -12,4 +12,14 @@ int iris_vb2_queue_setup(struct vb2_queue *q,
 			 unsigned int *num_buffers, unsigned int *num_planes,
 			 unsigned int sizes[], struct device *alloc_devs[]);
 
+/* vb2_mem_ops */
+void *iris_vb2_alloc(struct vb2_buffer *vb, struct device *dev, unsigned long size);
+void *iris_vb2_attach_dmabuf(struct vb2_buffer *vb, struct device *dev, struct dma_buf *dbuf,
+			     unsigned long size);
+void iris_vb2_put(void *buf_priv);
+int iris_vb2_mmap(void *buf_priv, struct vm_area_struct *vma);
+void iris_vb2_detach_dmabuf(void *buf_priv);
+int iris_vb2_map_dmabuf(void *buf_priv);
+void iris_vb2_unmap_dmabuf(void *buf_priv);
+
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c b/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c
index 410de720..124333a 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c
@@ -320,10 +320,21 @@ static const struct vb2_ops iris_vb2_ops = {
 	.queue_setup                    = iris_vb2_queue_setup,
 };
 
+static struct vb2_mem_ops iris_vb2_mem_ops = {
+	.alloc                          = iris_vb2_alloc,
+	.put                            = iris_vb2_put,
+	.mmap                           = iris_vb2_mmap,
+	.attach_dmabuf                  = iris_vb2_attach_dmabuf,
+	.detach_dmabuf                  = iris_vb2_detach_dmabuf,
+	.map_dmabuf                     = iris_vb2_map_dmabuf,
+	.unmap_dmabuf                   = iris_vb2_unmap_dmabuf,
+};
+
 int init_ops(struct iris_core *core)
 {
 	core->v4l2_file_ops = &v4l2_file_ops;
 	core->vb2_ops = &iris_vb2_ops;
+	core->vb2_mem_ops = &iris_vb2_mem_ops;
 
 	return 0;
 }
-- 
2.7.4


