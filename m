Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FEA766E37
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236736AbjG1N0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbjG1N0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:26:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A0544BE;
        Fri, 28 Jul 2023 06:25:58 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SAwYtg016027;
        Fri, 28 Jul 2023 13:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=NcpVwYAYWvyLubX5f4uViQg1+53y1qmun0CSgg3fc/M=;
 b=DoSoL2GUDKa1DnnN8NHeB+HlT5xAJHk/NIyBGeeDjK1i7r+8wH6OgXZeG7mwsWFf/e3l
 msg6OU8UsIc3FUqRdMxKulezkN0jKmMnrtQlp4pJoAY83C7rp78Rc9jdKOTrUQQIKbT6
 q0Zn5T10XCykOXgeQdt5Qa7AeW00MNbPrD9UTK3sk6JA8zMI+bhbj+D3lXx5jNaembSD
 jloxR3Ye/ZP+WagQpoSX7A31w30upRgsO3NHS9GHuGhXMB8zojl2xY2LBIW12HPmt2DM
 NwdGC+eEYNX0rFaaNAXl2VpJeW1dvax7u284joWrU8ZrrhL2j5aP/Vq4yjnugca3j/75 zQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s448hh7h9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 13:25:49 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36SDPnWA013610
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 13:25:49 GMT
Received: from hu-vgarodia-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 28 Jul 2023 06:25:45 -0700
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
To:     <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <hans.verkuil@cisco.com>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
CC:     <quic_dikshita@quicinc.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
Subject: [PATCH 11/33] iris: vidc: add helpers for memory management
Date:   Fri, 28 Jul 2023 18:53:22 +0530
Message-ID: <1690550624-14642-12-git-send-email-quic_vgarodia@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nFoIX4ORq1G0wP8kDvqtB-J-vyPJ3cLK
X-Proofpoint-ORIG-GUID: nFoIX4ORq1G0wP8kDvqtB-J-vyPJ3cLK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=958 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280124
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dikshita Agarwal <quic_dikshita@quicinc.com>

This implements helper functions for allocating, freeing,
mapping and unmapping memory.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
---
 .../platform/qcom/iris/vidc/inc/msm_vidc_memory.h  |  83 ++++
 .../platform/qcom/iris/vidc/src/msm_vidc_memory.c  | 448 +++++++++++++++++++++
 2 files changed, 531 insertions(+)
 create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_memory.h
 create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc_memory.c

diff --git a/drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_memory.h b/drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_memory.h
new file mode 100644
index 0000000..d6d244a
--- /dev/null
+++ b/drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_memory.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _MSM_VIDC_MEMORY_H_
+#define _MSM_VIDC_MEMORY_H_
+
+#include "msm_vidc_internal.h"
+
+struct msm_memory_dmabuf {
+	struct list_head       list;
+	struct dma_buf        *dmabuf;
+	u32                    refcount;
+};
+
+enum msm_memory_pool_type {
+	MSM_MEM_POOL_BUFFER  = 0,
+	MSM_MEM_POOL_ALLOC_MAP,
+	MSM_MEM_POOL_TIMESTAMP,
+	MSM_MEM_POOL_DMABUF,
+	MSM_MEM_POOL_BUF_TIMER,
+	MSM_MEM_POOL_BUF_STATS,
+	MSM_MEM_POOL_MAX,
+};
+
+struct msm_memory_alloc_header {
+	struct list_head       list;
+	u32                    type;
+	bool                   busy;
+	void                  *buf;
+};
+
+struct msm_memory_pool {
+	u32                    size;
+	char                  *name;
+	struct list_head       free_pool; /* list of struct msm_memory_alloc_header */
+	struct list_head       busy_pool; /* list of struct msm_memory_alloc_header */
+};
+
+void *msm_vidc_pool_alloc(struct msm_vidc_inst *inst,
+			  enum msm_memory_pool_type type);
+void msm_vidc_pool_free(struct msm_vidc_inst *inst, void *vidc_buf);
+int msm_vidc_pools_init(struct msm_vidc_inst *inst);
+void msm_vidc_pools_deinit(struct msm_vidc_inst *inst);
+
+#define call_mem_op(c, op, ...)                  \
+	(((c) && (c)->mem_ops && (c)->mem_ops->op) ? \
+	((c)->mem_ops->op(__VA_ARGS__)) : 0)
+
+struct msm_vidc_memory_ops {
+	struct dma_buf *(*dma_buf_get)(struct msm_vidc_inst *inst,
+				       int fd);
+	void (*dma_buf_put)(struct msm_vidc_inst *inst,
+			    struct dma_buf *dmabuf);
+	void (*dma_buf_put_completely)(struct msm_vidc_inst *inst,
+				       struct msm_memory_dmabuf *buf);
+	struct dma_buf_attachment *(*dma_buf_attach)(struct msm_vidc_core *core,
+						     struct dma_buf *dbuf,
+						     struct device *dev);
+	int (*dma_buf_detach)(struct msm_vidc_core *core, struct dma_buf *dbuf,
+			      struct dma_buf_attachment *attach);
+	struct sg_table *(*dma_buf_map_attachment)(struct msm_vidc_core *core,
+						   struct dma_buf_attachment *attach);
+	int (*dma_buf_unmap_attachment)(struct msm_vidc_core *core,
+					struct dma_buf_attachment *attach,
+					struct sg_table *table);
+	int (*memory_alloc_map)(struct msm_vidc_core *core,
+				struct msm_vidc_mem *mem);
+	int (*memory_unmap_free)(struct msm_vidc_core *core,
+				 struct msm_vidc_mem *mem);
+	int (*mem_dma_map_page)(struct msm_vidc_core *core,
+				struct msm_vidc_mem *mem);
+	int (*mem_dma_unmap_page)(struct msm_vidc_core *core,
+				  struct msm_vidc_mem *mem);
+	u32 (*buffer_region)(struct msm_vidc_inst *inst,
+			     enum msm_vidc_buffer_type buffer_type);
+};
+
+const struct msm_vidc_memory_ops *get_mem_ops(void);
+
+#endif // _MSM_VIDC_MEMORY_H_
diff --git a/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_memory.c b/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_memory.c
new file mode 100644
index 0000000..c97d9c7
--- /dev/null
+++ b/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_memory.c
@@ -0,0 +1,448 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/dma-buf.h>
+#include <linux/dma-heap.h>
+#include <linux/dma-mapping.h>
+
+#include "msm_vidc_core.h"
+#include "msm_vidc_debug.h"
+#include "msm_vidc_driver.h"
+#include "msm_vidc_internal.h"
+#include "msm_vidc_memory.h"
+#include "msm_vidc_platform.h"
+#include "venus_hfi.h"
+
+MODULE_IMPORT_NS(DMA_BUF);
+
+struct msm_vidc_type_size_name {
+	enum msm_memory_pool_type type;
+	u32                       size;
+	char                     *name;
+};
+
+static const struct msm_vidc_type_size_name buftype_size_name_arr[] = {
+	{MSM_MEM_POOL_BUFFER,     sizeof(struct msm_vidc_buffer),     "MSM_MEM_POOL_BUFFER"     },
+	{MSM_MEM_POOL_ALLOC_MAP,  sizeof(struct msm_vidc_mem),        "MSM_MEM_POOL_ALLOC_MAP"  },
+	{MSM_MEM_POOL_TIMESTAMP,  sizeof(struct msm_vidc_timestamp),  "MSM_MEM_POOL_TIMESTAMP"  },
+	{MSM_MEM_POOL_DMABUF,     sizeof(struct msm_memory_dmabuf),   "MSM_MEM_POOL_DMABUF"     },
+	{MSM_MEM_POOL_BUF_TIMER,  sizeof(struct msm_vidc_input_timer), "MSM_MEM_POOL_BUF_TIMER" },
+	{MSM_MEM_POOL_BUF_STATS,  sizeof(struct msm_vidc_buffer_stats), "MSM_MEM_POOL_BUF_STATS"},
+};
+
+void *msm_vidc_pool_alloc(struct msm_vidc_inst *inst, enum msm_memory_pool_type type)
+{
+	struct msm_memory_alloc_header *hdr = NULL;
+	struct msm_memory_pool *pool;
+
+	if (type < 0 || type >= MSM_MEM_POOL_MAX) {
+		d_vpr_e("%s: Invalid params\n", __func__);
+		return NULL;
+	}
+	pool = &inst->pool[type];
+
+	if (!list_empty(&pool->free_pool)) {
+		/* get 1st node from free pool */
+		hdr = list_first_entry(&pool->free_pool, struct msm_memory_alloc_header, list);
+
+		/* move node from free pool to busy pool */
+		list_move_tail(&hdr->list, &pool->busy_pool);
+
+		/* reset existing data */
+		memset((char *)hdr->buf, 0, pool->size);
+
+		/* set busy flag to true. This is to catch double free request */
+		hdr->busy = true;
+
+		return hdr->buf;
+	}
+
+	hdr = vzalloc(pool->size + sizeof(struct msm_memory_alloc_header));
+
+	INIT_LIST_HEAD(&hdr->list);
+	hdr->type = type;
+	hdr->busy = true;
+	hdr->buf = (void *)(hdr + 1);
+	list_add_tail(&hdr->list, &pool->busy_pool);
+
+	return hdr->buf;
+}
+
+void msm_vidc_pool_free(struct msm_vidc_inst *inst, void *vidc_buf)
+{
+	struct msm_memory_alloc_header *hdr;
+	struct msm_memory_pool *pool;
+
+	if (!vidc_buf) {
+		d_vpr_e("%s: Invalid params\n", __func__);
+		return;
+	}
+	hdr = (struct msm_memory_alloc_header *)vidc_buf - 1;
+
+	/* sanitize buffer addr */
+	if (hdr->buf != vidc_buf) {
+		i_vpr_e(inst, "%s: invalid buf addr %p\n", __func__, vidc_buf);
+		return;
+	}
+
+	/* sanitize pool type */
+	if (hdr->type < 0 || hdr->type >= MSM_MEM_POOL_MAX) {
+		i_vpr_e(inst, "%s: invalid pool type %#x\n", __func__, hdr->type);
+		return;
+	}
+	pool = &inst->pool[hdr->type];
+
+	/* catch double-free request */
+	if (!hdr->busy) {
+		i_vpr_e(inst, "%s: double free request. type %s, addr %p\n", __func__,
+			pool->name, vidc_buf);
+		return;
+	}
+	hdr->busy = false;
+
+	/* move node from busy pool to free pool */
+	list_move_tail(&hdr->list, &pool->free_pool);
+}
+
+static void msm_vidc_destroy_pool_buffers(struct msm_vidc_inst *inst,
+					  enum msm_memory_pool_type type)
+{
+	struct msm_memory_alloc_header *hdr, *dummy;
+	struct msm_memory_pool *pool;
+	u32 fcount = 0, bcount = 0;
+
+	if (type < 0 || type >= MSM_MEM_POOL_MAX) {
+		d_vpr_e("%s: Invalid params\n", __func__);
+		return;
+	}
+	pool = &inst->pool[type];
+
+	/* detect memleak: busy pool is expected to be empty here */
+	if (!list_empty(&pool->busy_pool))
+		i_vpr_e(inst, "%s: destroy request on active buffer. type %s\n",
+			__func__, pool->name);
+
+	/* destroy all free buffers */
+	list_for_each_entry_safe(hdr, dummy, &pool->free_pool, list) {
+		list_del(&hdr->list);
+		vfree(hdr);
+		fcount++;
+	}
+
+	/* destroy all busy buffers */
+	list_for_each_entry_safe(hdr, dummy, &pool->busy_pool, list) {
+		list_del(&hdr->list);
+		vfree(hdr);
+		bcount++;
+	}
+
+	i_vpr_h(inst, "%s: type: %23s, count: free %2u, busy %2u\n",
+		__func__, pool->name, fcount, bcount);
+}
+
+int msm_vidc_pools_init(struct msm_vidc_inst *inst)
+{
+	u32 i;
+
+	if (ARRAY_SIZE(buftype_size_name_arr) != MSM_MEM_POOL_MAX) {
+		i_vpr_e(inst, "%s: num elements mismatch %lu %u\n", __func__,
+			ARRAY_SIZE(buftype_size_name_arr), MSM_MEM_POOL_MAX);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < MSM_MEM_POOL_MAX; i++) {
+		if (i != buftype_size_name_arr[i].type) {
+			i_vpr_e(inst, "%s: type mismatch %u %u\n", __func__,
+				i, buftype_size_name_arr[i].type);
+			return -EINVAL;
+		}
+		inst->pool[i].size = buftype_size_name_arr[i].size;
+		inst->pool[i].name = buftype_size_name_arr[i].name;
+		INIT_LIST_HEAD(&inst->pool[i].free_pool);
+		INIT_LIST_HEAD(&inst->pool[i].busy_pool);
+	}
+
+	return 0;
+}
+
+void msm_vidc_pools_deinit(struct msm_vidc_inst *inst)
+{
+	u32 i = 0;
+
+	/* destroy all buffers from all pool types */
+	for (i = 0; i < MSM_MEM_POOL_MAX; i++)
+		msm_vidc_destroy_pool_buffers(inst, i);
+}
+
+static struct dma_buf *msm_vidc_dma_buf_get(struct msm_vidc_inst *inst, int fd)
+{
+	struct msm_memory_dmabuf *buf = NULL;
+	struct dma_buf *dmabuf = NULL;
+	bool found = false;
+
+	/* get local dmabuf ref for tracking */
+	dmabuf = dma_buf_get(fd);
+	if (IS_ERR_OR_NULL(dmabuf)) {
+		d_vpr_e("Failed to get dmabuf for %d, error %d\n",
+			fd, PTR_ERR_OR_ZERO(dmabuf));
+		return NULL;
+	}
+
+	/* track dmabuf - inc refcount if already present */
+	list_for_each_entry(buf, &inst->dmabuf_tracker, list) {
+		if (buf->dmabuf == dmabuf) {
+			buf->refcount++;
+			found = true;
+			break;
+		}
+	}
+	if (found) {
+		/* put local dmabuf ref */
+		dma_buf_put(dmabuf);
+		return dmabuf;
+	}
+
+	/* get tracker instance from pool */
+	buf = msm_vidc_pool_alloc(inst, MSM_MEM_POOL_DMABUF);
+	if (!buf) {
+		i_vpr_e(inst, "%s: dmabuf alloc failed\n", __func__);
+		dma_buf_put(dmabuf);
+		return NULL;
+	}
+	/* hold dmabuf strong ref in tracker */
+	buf->dmabuf = dmabuf;
+	buf->refcount = 1;
+	INIT_LIST_HEAD(&buf->list);
+
+	/* add new dmabuf entry to tracker */
+	list_add_tail(&buf->list, &inst->dmabuf_tracker);
+
+	return dmabuf;
+}
+
+static void msm_vidc_dma_buf_put(struct msm_vidc_inst *inst, struct dma_buf *dmabuf)
+{
+	struct msm_memory_dmabuf *buf = NULL;
+	bool found = false;
+
+	if (!dmabuf) {
+		d_vpr_e("%s: invalid params\n", __func__);
+		return;
+	}
+
+	/* track dmabuf - dec refcount if already present */
+	list_for_each_entry(buf, &inst->dmabuf_tracker, list) {
+		if (buf->dmabuf == dmabuf) {
+			buf->refcount--;
+			found = true;
+			break;
+		}
+	}
+	if (!found) {
+		i_vpr_e(inst, "%s: invalid dmabuf %p\n", __func__, dmabuf);
+		return;
+	}
+
+	/* non-zero refcount - do nothing */
+	if (buf->refcount)
+		return;
+
+	/* remove dmabuf entry from tracker */
+	list_del(&buf->list);
+
+	/* release dmabuf strong ref from tracker */
+	dma_buf_put(buf->dmabuf);
+
+	/* put tracker instance back to pool */
+	msm_vidc_pool_free(inst, buf);
+}
+
+static void msm_vidc_dma_buf_put_completely(struct msm_vidc_inst *inst,
+					    struct msm_memory_dmabuf *buf)
+{
+	if (!buf) {
+		d_vpr_e("%s: invalid params\n", __func__);
+		return;
+	}
+
+	while (buf->refcount) {
+		buf->refcount--;
+		if (!buf->refcount) {
+			/* remove dmabuf entry from tracker */
+			list_del(&buf->list);
+
+			/* release dmabuf strong ref from tracker */
+			dma_buf_put(buf->dmabuf);
+
+			/* put tracker instance back to pool */
+			msm_vidc_pool_free(inst, buf);
+			break;
+		}
+	}
+}
+
+static struct dma_buf_attachment *msm_vidc_dma_buf_attach(struct msm_vidc_core *core,
+							  struct dma_buf *dbuf,
+							  struct device *dev)
+{
+	int rc = 0;
+	struct dma_buf_attachment *attach = NULL;
+
+	if (!dbuf || !dev) {
+		d_vpr_e("%s: invalid params\n", __func__);
+		return NULL;
+	}
+
+	attach = dma_buf_attach(dbuf, dev);
+	if (IS_ERR_OR_NULL(attach)) {
+		rc = PTR_ERR_OR_ZERO(attach) ? PTR_ERR_OR_ZERO(attach) : -1;
+		d_vpr_e("Failed to attach dmabuf, error %d\n", rc);
+		return NULL;
+	}
+
+	return attach;
+}
+
+static int msm_vidc_dma_buf_detach(struct msm_vidc_core *core, struct dma_buf *dbuf,
+				   struct dma_buf_attachment *attach)
+{
+	int rc = 0;
+
+	if (!dbuf || !attach) {
+		d_vpr_e("%s: invalid params\n", __func__);
+		return -EINVAL;
+	}
+
+	dma_buf_detach(dbuf, attach);
+
+	return rc;
+}
+
+static int msm_vidc_dma_buf_unmap_attachment(struct msm_vidc_core *core,
+					     struct dma_buf_attachment *attach,
+					     struct sg_table *table)
+{
+	int rc = 0;
+
+	if (!attach || !table) {
+		d_vpr_e("%s: invalid params\n", __func__);
+		return -EINVAL;
+	}
+
+	dma_buf_unmap_attachment(attach, table, DMA_BIDIRECTIONAL);
+
+	return rc;
+}
+
+static struct sg_table *msm_vidc_dma_buf_map_attachment(struct msm_vidc_core *core,
+							struct dma_buf_attachment *attach)
+{
+	int rc = 0;
+	struct sg_table *table = NULL;
+
+	if (!attach) {
+		d_vpr_e("%s: invalid params\n", __func__);
+		return NULL;
+	}
+
+	table = dma_buf_map_attachment(attach, DMA_BIDIRECTIONAL);
+	if (IS_ERR_OR_NULL(table)) {
+		rc = PTR_ERR_OR_ZERO(table) ? PTR_ERR_OR_ZERO(table) : -1;
+		d_vpr_e("Failed to map table, error %d\n", rc);
+		return NULL;
+	}
+	if (!table->sgl) {
+		d_vpr_e("%s: sgl is NULL\n", __func__);
+		msm_vidc_dma_buf_unmap_attachment(core, attach, table);
+		return NULL;
+	}
+
+	return table;
+}
+
+static int msm_vidc_memory_alloc_map(struct msm_vidc_core *core, struct msm_vidc_mem *mem)
+{
+	int size = 0;
+	struct context_bank_info *cb = NULL;
+
+	if (!mem) {
+		d_vpr_e("%s: invalid params\n", __func__);
+		return -EINVAL;
+	}
+
+	size = ALIGN(mem->size, SZ_4K);
+	mem->attrs = DMA_ATTR_WRITE_COMBINE;
+
+	cb = msm_vidc_get_context_bank_for_region(core, mem->region);
+	if (!cb) {
+		d_vpr_e("%s: failed to get context bank device\n", __func__);
+		return -EIO;
+	}
+
+	mem->kvaddr = dma_alloc_attrs(cb->dev, size, &mem->device_addr, GFP_KERNEL,
+				      mem->attrs);
+	if (!mem->kvaddr) {
+		d_vpr_e("%s: dma_alloc_attrs returned NULL\n", __func__);
+		return -ENOMEM;
+	}
+
+	d_vpr_h("%s: dmabuf %pK, size %d, buffer_type %s, secure %d, region %d\n",
+		__func__, mem->kvaddr, mem->size, buf_name(mem->type),
+		mem->secure, mem->region);
+
+	return 0;
+}
+
+static int msm_vidc_memory_unmap_free(struct msm_vidc_core *core, struct msm_vidc_mem *mem)
+{
+	int rc = 0;
+	struct context_bank_info *cb = NULL;
+
+	if (!mem || !mem->device_addr || !mem->kvaddr) {
+		d_vpr_e("%s: invalid params\n", __func__);
+		return -EINVAL;
+	}
+
+	d_vpr_h("%s: dmabuf %pK, size %d, kvaddr %pK, buffer_type %s, secure %d, region %d\n",
+		__func__, (void *)mem->device_addr, mem->size, mem->kvaddr,
+		buf_name(mem->type), mem->secure, mem->region);
+
+	cb = msm_vidc_get_context_bank_for_region(core, mem->region);
+	if (!cb) {
+		d_vpr_e("%s: failed to get context bank device\n", __func__);
+		return -EIO;
+	}
+
+	dma_free_attrs(cb->dev, mem->size, mem->kvaddr, mem->device_addr, mem->attrs);
+
+	mem->kvaddr = NULL;
+	mem->device_addr = 0;
+
+	return rc;
+}
+
+static u32 msm_vidc_buffer_region(struct msm_vidc_inst *inst, enum msm_vidc_buffer_type buffer_type)
+{
+	return MSM_VIDC_NON_SECURE;
+}
+
+static const struct msm_vidc_memory_ops msm_mem_ops = {
+	.dma_buf_get                    = msm_vidc_dma_buf_get,
+	.dma_buf_put                    = msm_vidc_dma_buf_put,
+	.dma_buf_put_completely         = msm_vidc_dma_buf_put_completely,
+	.dma_buf_attach                 = msm_vidc_dma_buf_attach,
+	.dma_buf_detach                 = msm_vidc_dma_buf_detach,
+	.dma_buf_map_attachment         = msm_vidc_dma_buf_map_attachment,
+	.dma_buf_unmap_attachment       = msm_vidc_dma_buf_unmap_attachment,
+	.memory_alloc_map               = msm_vidc_memory_alloc_map,
+	.memory_unmap_free              = msm_vidc_memory_unmap_free,
+	.buffer_region                  = msm_vidc_buffer_region,
+};
+
+const struct msm_vidc_memory_ops *get_mem_ops(void)
+{
+	return &msm_mem_ops;
+}
-- 
2.7.4

