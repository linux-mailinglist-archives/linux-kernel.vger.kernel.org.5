Return-Path: <linux-kernel+bounces-3439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B984816C3F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 570AE1F2387D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882021BDFC;
	Mon, 18 Dec 2023 11:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L1ZCkcZ+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1922F1A714;
	Mon, 18 Dec 2023 11:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIAscO4000368;
	Mon, 18 Dec 2023 11:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=bQdmZd+idGctlHl2svbf9r/7EV7zOUrFdIGTxbDrfGw=; b=L1
	ZCkcZ+FADLcg9PK5YrH7PTFfzrjtQFTS0kPCHxnZeZzQEdPVI3Ag0cbfYKL2iN5X
	za8ydKYd9/c3ap0GkXNr7/YQm9Q92jTL5SXY+909LBhrOtrGRqdfBSJKLMoJm72m
	/l3JM8lljqOhwPgV6LoHG95065UBmdZGFJJsGRBNcMeJufgq2P8Y6Ner7EG/iKG5
	AVfswmbtXcCequIUJPvhamvvCAnW6bt+iFNj6iXosu5w3ZxJFIorMUi0hwsy8785
	YoThpU2R8KRXu3lmIfvlK3hbg3jUm8X64SaP9x6hFNqORcC+VJkLmnFWkPJlv6ge
	CAuufTZVq/eBWo755Lwg==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v14xy443w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 11:33:09 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX5Xe029942;
	Mon, 18 Dec 2023 11:33:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3v14ykyyg6-1;
	Mon, 18 Dec 2023 11:33:05 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX50h029913;
	Mon, 18 Dec 2023 11:33:05 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3BIBX530029906;
	Mon, 18 Dec 2023 11:33:05 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 23B6722BC; Mon, 18 Dec 2023 17:03:04 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2 02/34] media: introduce common helpers for queues handling
Date: Mon, 18 Dec 2023 17:01:57 +0530
Message-Id: <1702899149-21321-3-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4G0iKqfqT_8ZcAehWwbFf1zCDz1xgW1F
X-Proofpoint-ORIG-GUID: 4G0iKqfqT_8ZcAehWwbFf1zCDz1xgW1F
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

Introduce common helpers for shared queues init, deinit
and read/write queue operations and use them in venus driver.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 drivers/media/platform/qcom/vcodec/hfi_queue.c     | 258 +++++++++++
 drivers/media/platform/qcom/vcodec/hfi_queue.h     | 129 ++++++
 drivers/media/platform/qcom/vcodec/venus/Makefile  |   3 +-
 .../media/platform/qcom/vcodec/venus/hfi_venus.c   | 500 ++++-----------------
 4 files changed, 465 insertions(+), 425 deletions(-)
 create mode 100644 drivers/media/platform/qcom/vcodec/hfi_queue.c
 create mode 100644 drivers/media/platform/qcom/vcodec/hfi_queue.h

diff --git a/drivers/media/platform/qcom/vcodec/hfi_queue.c b/drivers/media/platform/qcom/vcodec/hfi_queue.c
new file mode 100644
index 0000000..e3e470b
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/hfi_queue.c
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "hfi_queue.h"
+
+int write_queue(struct iface_q_info *qinfo, void *packet,
+		u32 packet_size, u32 *rx_req)
+{
+	u32 empty_space, read_idx, write_idx, new_write_idx;
+	struct hfi_queue_header *queue;
+	u32 *write_ptr, residue;
+
+	queue = qinfo->qhdr;
+	if (!queue)
+		return -EINVAL;
+
+	if (!packet_size || packet_size > qinfo->q_array.size)
+		return -EINVAL;
+
+	read_idx = queue->qhdr_read_idx * sizeof(u32);
+	write_idx = queue->qhdr_write_idx * sizeof(u32);
+
+	empty_space = (write_idx >=  read_idx) ?
+		(qinfo->q_array.size - (write_idx -  read_idx)) :
+		(read_idx - write_idx);
+	if (empty_space <= packet_size) {
+		queue->qhdr_tx_req = 1;
+		return -ENOSPC;
+	}
+
+	queue->qhdr_tx_req =  0;
+
+	new_write_idx = write_idx + packet_size;
+	write_ptr = (u32 *)((u8 *)qinfo->q_array.kernel_vaddr + write_idx);
+
+	if (write_ptr < (u32 *)qinfo->q_array.kernel_vaddr ||
+	    write_ptr > (u32 *)(qinfo->q_array.kernel_vaddr +
+	    qinfo->q_array.size))
+		return -EINVAL;
+
+	if (new_write_idx < qinfo->q_array.size) {
+		memcpy(write_ptr, packet, packet_size);
+	} else {
+		residue = new_write_idx - qinfo->q_array.size;
+		memcpy(write_ptr, packet, (packet_size - residue));
+		memcpy(qinfo->q_array.kernel_vaddr,
+		       packet + (packet_size - residue), residue);
+		new_write_idx = residue;
+	}
+
+	/* Make sure packet is written before updating the write index */
+	mb();
+	queue->qhdr_write_idx = new_write_idx / sizeof(u32);
+	*rx_req = queue->qhdr_rx_req ? 1 : 0;
+
+	/* Make sure write index is updated before an interrupt is raised */
+	mb();
+
+	return 0;
+}
+
+int read_queue(struct iface_q_info *qinfo, void *packet, u32 *tx_req)
+{
+	u32 read_idx, write_idx, new_read_idx;
+	struct hfi_queue_header *queue;
+	u32 receive_request = 0;
+	u32 packet_size, residue;
+	u32 *read_ptr;
+	int ret = 0;
+
+	/* Make sure data is valid before reading it */
+	mb();
+	queue = qinfo->qhdr;
+	if (!queue)
+		return -EINVAL;
+
+	if (queue->qhdr_type & IFACEQ_MSGQ_ID)
+		receive_request = 1;
+
+	read_idx = queue->qhdr_read_idx * sizeof(u32);
+	write_idx = queue->qhdr_write_idx * sizeof(u32);
+
+	if (read_idx == write_idx) {
+		queue->qhdr_rx_req = receive_request;
+		/* Ensure qhdr is updated in main memory */
+		mb();
+		return -ENODATA;
+	}
+
+	read_ptr = (u32 *)(qinfo->q_array.kernel_vaddr + read_idx);
+	if (read_ptr < (u32 *)qinfo->q_array.kernel_vaddr ||
+	    read_ptr > (u32 *)(qinfo->q_array.kernel_vaddr +
+	    qinfo->q_array.size - sizeof(*read_ptr)))
+		return -ENODATA;
+
+	packet_size = *read_ptr;
+	if (!packet_size)
+		return -EINVAL;
+
+	new_read_idx = read_idx + packet_size;
+	if (packet_size <= IFACEQ_CORE_PKT_SIZE &&
+	    read_idx <= qinfo->q_array.size) {
+		if (new_read_idx < qinfo->q_array.size) {
+			memcpy(packet, read_ptr, packet_size);
+		} else {
+			residue = new_read_idx - qinfo->q_array.size;
+			memcpy(packet, read_ptr, (packet_size - residue));
+			memcpy((packet + (packet_size - residue)),
+			       qinfo->q_array.kernel_vaddr, residue);
+			new_read_idx = residue;
+		}
+	} else {
+		new_read_idx = write_idx;
+		ret = -EBADMSG;
+	}
+
+	queue->qhdr_rx_req = receive_request;
+
+	queue->qhdr_read_idx = new_read_idx / sizeof(u32);
+
+	*tx_req = queue->qhdr_tx_req ? 1 : 0;
+	/* Ensure qhdr is updated in main memory */
+	mb();
+
+	return ret;
+}
+
+static void __set_queue_hdr_defaults(struct hfi_queue_header *q_hdr)
+{
+	q_hdr->qhdr_status = 0x1;
+	q_hdr->qhdr_type = IFACEQ_DFLT_QHDR;
+	q_hdr->qhdr_q_size = IFACEQ_QUEUE_SIZE / 4;
+	q_hdr->qhdr_pkt_size = 0;
+	q_hdr->qhdr_rx_wm = 0x1;
+	q_hdr->qhdr_tx_wm = 0x1;
+	q_hdr->qhdr_rx_req = 0x1;
+	q_hdr->qhdr_tx_req = 0x0;
+	q_hdr->qhdr_rx_irq_status = 0x0;
+	q_hdr->qhdr_tx_irq_status = 0x0;
+	q_hdr->qhdr_read_idx = 0x0;
+	q_hdr->qhdr_write_idx = 0x0;
+}
+
+static void hfi_set_queue_header(u32 queue_id, struct iface_q_info *iface_q)
+{
+	__set_queue_hdr_defaults(iface_q->qhdr);
+	iface_q->qhdr->qhdr_start_addr = iface_q->q_array.device_addr;
+	iface_q->qhdr->qhdr_type |= queue_id;
+
+	/*
+	 * Set receive request to zero on debug queue as there is no
+	 * need of interrupt from video hardware for debug messages
+	 */
+	if (queue_id == IFACEQ_DBGQ_ID)
+		iface_q->qhdr->qhdr_rx_req = 0;
+}
+
+static void __queue_init(struct mem_desc *q_table, u32 queue_id, struct iface_q_info *iface_q)
+{
+	unsigned int offset = 0;
+
+	offset = q_table->size + (queue_id * IFACEQ_QUEUE_SIZE);
+	iface_q->q_array.device_addr = q_table->device_addr + offset;
+	iface_q->q_array.kernel_vaddr =
+			(void *)((char *)q_table->kernel_vaddr + offset);
+	iface_q->q_array.size = IFACEQ_QUEUE_SIZE;
+	iface_q->qhdr =
+		IFACEQ_GET_QHDR_START_ADDR(q_table->kernel_vaddr, queue_id);
+
+	memset(iface_q->qhdr, 0, sizeof(struct hfi_queue_header));
+
+	hfi_set_queue_header(queue_id, iface_q);
+}
+
+int hfi_queue_init(struct device *dev, struct mem_desc *q_table, struct mem_desc *sfr,
+		   struct iface_q_info *cmd_q, struct iface_q_info *msg_q,
+		   struct iface_q_info *dbg_q, void *daddr)
+{
+	struct hfi_queue_table_header *q_tbl_hdr;
+
+	if (q_table->kernel_vaddr) {
+		hfi_set_queue_header(IFACEQ_CMDQ_ID, cmd_q);
+		hfi_set_queue_header(IFACEQ_MSGQ_ID, msg_q);
+		hfi_set_queue_header(IFACEQ_DBGQ_ID, dbg_q);
+		return 0;
+	}
+
+	q_table->kernel_vaddr = dma_alloc_attrs(dev, ALIGNED_QUEUE_SIZE,
+						&q_table->device_addr,
+						GFP_KERNEL, DMA_ATTR_WRITE_COMBINE);
+	if (!q_table->kernel_vaddr) {
+		dev_err(dev, "%s: queues alloc and map failed\n", __func__);
+		return -ENOMEM;
+	}
+
+	sfr->kernel_vaddr = dma_alloc_attrs(dev, ALIGNED_SFR_SIZE,
+					    &sfr->device_addr,
+					    GFP_KERNEL, DMA_ATTR_WRITE_COMBINE);
+	if (!sfr->kernel_vaddr) {
+		dev_err(dev, "%s: sfr alloc and map failed\n", __func__);
+		return -ENOMEM;
+	}
+
+	q_table->size = IFACEQ_TABLE_SIZE;
+
+	__queue_init(q_table, IFACEQ_CMDQ_ID, cmd_q);
+	__queue_init(q_table, IFACEQ_MSGQ_ID, msg_q);
+	__queue_init(q_table, IFACEQ_DBGQ_ID, dbg_q);
+
+	q_tbl_hdr = (struct hfi_queue_table_header *)q_table->kernel_vaddr;
+	q_tbl_hdr->qtbl_version = 0;
+	q_tbl_hdr->device_addr = (void *)daddr;
+	strscpy(q_tbl_hdr->name, "hfi-queues", sizeof(q_tbl_hdr->name));
+	q_tbl_hdr->qtbl_size = IFACEQ_TABLE_SIZE;
+	q_tbl_hdr->qtbl_qhdr0_offset = sizeof(*q_tbl_hdr);
+	q_tbl_hdr->qtbl_qhdr_size = sizeof(struct hfi_queue_header);
+	q_tbl_hdr->qtbl_num_q = IFACEQ_NUMQ;
+	q_tbl_hdr->qtbl_num_active_q = IFACEQ_NUMQ;
+
+	sfr->size = ALIGNED_SFR_SIZE;
+	/* Write sfr size in first word to be used by firmware */
+	*((u32 *)sfr->kernel_vaddr) = sfr->size;
+
+	return 0;
+}
+
+static void __queue_deinit(struct iface_q_info *iface_q)
+{
+	iface_q->qhdr = NULL;
+	iface_q->q_array.kernel_vaddr = NULL;
+	iface_q->q_array.device_addr = 0;
+}
+
+void hfi_queue_deinit(struct device *dev, struct mem_desc *q_table, struct mem_desc *sfr,
+		      struct iface_q_info *cmd_q, struct iface_q_info *msg_q,
+		      struct iface_q_info *dbg_q)
+{
+	if (!q_table->kernel_vaddr)
+		return;
+
+	dma_free_attrs(dev, q_table->size, q_table->kernel_vaddr,
+		       q_table->device_addr, q_table->attrs);
+
+	dma_free_attrs(dev, sfr->size, sfr->kernel_vaddr,
+		       sfr->device_addr, sfr->attrs);
+
+	__queue_deinit(cmd_q);
+	__queue_deinit(msg_q);
+	__queue_deinit(dbg_q);
+
+	q_table->kernel_vaddr = NULL;
+	q_table->device_addr = 0;
+
+	sfr->kernel_vaddr = NULL;
+	sfr->device_addr = 0;
+}
diff --git a/drivers/media/platform/qcom/vcodec/hfi_queue.h b/drivers/media/platform/qcom/vcodec/hfi_queue.h
new file mode 100644
index 0000000..8cc9491
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/hfi_queue.h
@@ -0,0 +1,129 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _HFI_QUEUE_H_
+#define _HFI_QUEUE_H_
+
+#include <linux/types.h>
+#include <media/v4l2-device.h>
+
+/*
+ * Shared queues are used for communication between driver and firmware.
+ * There are 3 types of queues:
+ * Command queue - driver to write any command to firmware.
+ * Message queue - firmware to send any response to driver.
+ * Debug queue - firmware to write debug message.
+ */
+
+/* Host-firmware shared queue ids */
+enum iris_iface_queue {
+	IFACEQ_CMDQ_ID	= 0,
+	IFACEQ_MSGQ_ID,
+	IFACEQ_DBGQ_ID,
+	IFACEQ_NUMQ, /* not an index */
+};
+
+#define IFACEQ_MAX_BUF_COUNT		50
+/*
+ * Max session supported are 16.
+ * this value is used to calculate the size of
+ * individual shared queue.
+ */
+#define IFACE_MAX_PARALLEL_CLNTS	16
+#define IFACEQ_DFLT_QHDR		0x01010000
+
+#define IFACEQ_MAX_PKT_SIZE		1024
+#define IFACEQ_CORE_PKT_SIZE	(1024 * 4)
+
+#define IFACEQ_TABLE_SIZE	(sizeof(struct hfi_queue_table_header) + \
+			sizeof(struct hfi_queue_header) * IFACEQ_NUMQ)
+
+#define IFACEQ_QUEUE_SIZE	(IFACEQ_MAX_PKT_SIZE *  \
+	IFACEQ_MAX_BUF_COUNT * IFACE_MAX_PARALLEL_CLNTS)
+
+#define IFACEQ_GET_QHDR_START_ADDR(ptr, i)     \
+	((void *)(((ptr) + sizeof(struct hfi_queue_table_header)) + \
+		((i) * sizeof(struct hfi_queue_header))))
+
+#define SFR_SIZE	SZ_4K
+#define QUEUE_SIZE	(IFACEQ_TABLE_SIZE + \
+			(IFACEQ_QUEUE_SIZE * IFACEQ_NUMQ))
+
+#define ALIGNED_SFR_SIZE	ALIGN(SFR_SIZE, SZ_4K)
+#define ALIGNED_QUEUE_SIZE	ALIGN(QUEUE_SIZE, SZ_4K)
+#define SHARED_QSIZE		ALIGN(ALIGNED_SFR_SIZE + ALIGNED_QUEUE_SIZE, SZ_1M)
+
+struct mem_desc {
+	dma_addr_t		device_addr;
+	void			*kernel_vaddr;
+	u32			size;
+	unsigned long		attrs;
+};
+
+struct hfi_queue_table_header {
+	u32 qtbl_version;
+	u32 qtbl_size;
+	u32 qtbl_qhdr0_offset;
+	u32 qtbl_qhdr_size;
+	u32 qtbl_num_q;
+	u32 qtbl_num_active_q;
+	void *device_addr;
+	char name[256];
+};
+
+/**
+ * struct hfi_queue_header - queue header definition
+ *
+ * @qhdr_status: bits (7:0) 0x1 - active  0x0 - inactive
+ * @qhdr_start_addr: queue start addr.
+ * @qhdr_type: queue type.
+ * @qhdr_q_size: size in number of HFI_QUEUE_PACKET_TYPE packets it can hold.
+ * @qhdr_pkt_size: size of the Queue packet entries, in bytes.
+ * @qhdr_rx_wm: the receiver watermark in number of queue packets.
+ * @qhdr_tx_wm: the transmitter watermark in number of queue packets.
+ * @qhdr_rx_req: set to request an interrupt from transmitter if qhdr_tx_wm is reached.
+ * @qhdr_tx_req: set to request an interrupt from receiver if qhdr_rx_wm is reached.
+ * @qhdr_rx_irq_status: status of receiver irq.
+ * @qhdr_tx_irq_status: status of transmitter irq.
+ * @qhdr_read_idx: read index, which starts with a value of 0 and wraps around after
+ *                 (QHDR_Q_SIZE - 1).
+ * @qhdr_write_idx: write index, which starts with a value of 0 and wraps around after
+ *                  (QHDR_Q_SIZE - 1).
+ */
+
+struct hfi_queue_header {
+	u32 qhdr_status;
+	u32 qhdr_start_addr;
+	u32 qhdr_type;
+	u32 qhdr_q_size;
+	u32 qhdr_pkt_size;
+	u32 qhdr_pkt_drop_cnt;
+	u32 qhdr_rx_wm;
+	u32 qhdr_tx_wm;
+	u32 qhdr_rx_req;
+	u32 qhdr_tx_req;
+	u32 qhdr_rx_irq_status;
+	u32 qhdr_tx_irq_status;
+	u32 qhdr_read_idx;
+	u32 qhdr_write_idx;
+};
+
+struct iface_q_info {
+	struct hfi_queue_header *qhdr;
+	struct mem_desc q_array;
+};
+
+int write_queue(struct iface_q_info *qinfo, void *packet,
+		u32 packet_size, u32 *rx_req);
+int read_queue(struct iface_q_info *qinfo, void *packet, u32 *tx_req);
+int hfi_queue_init(struct device *dev, struct mem_desc *q_table, struct mem_desc *sfr,
+		   struct iface_q_info *cmd_q, struct iface_q_info *msg_q,
+		   struct iface_q_info *dbg_q, void *daddr);
+
+void hfi_queue_deinit(struct device *dev, struct mem_desc *q_table, struct mem_desc *sfr,
+		      struct iface_q_info *cmd_q, struct iface_q_info *msg_q,
+		      struct iface_q_info *dbg_q);
+
+#endif
diff --git a/drivers/media/platform/qcom/vcodec/venus/Makefile b/drivers/media/platform/qcom/vcodec/venus/Makefile
index f6f3a88..1941ef4 100644
--- a/drivers/media/platform/qcom/vcodec/venus/Makefile
+++ b/drivers/media/platform/qcom/vcodec/venus/Makefile
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for Qualcomm Venus driver
 
-venus-core-objs += ../firmware.o
+venus-core-objs += ../firmware.o \
+		   ../hfi_queue.o
 
 venus-core-objs += core.o helpers.o firmware_no_tz.o \
 		   hfi_venus.o hfi_msgs.o hfi_cmds.o hfi.o \
diff --git a/drivers/media/platform/qcom/vcodec/venus/hfi_venus.c b/drivers/media/platform/qcom/vcodec/venus/hfi_venus.c
index 5a68db9..41e3f27 100644
--- a/drivers/media/platform/qcom/vcodec/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/vcodec/venus/hfi_venus.c
@@ -16,6 +16,7 @@
 #include "../firmware.h"
 #include "hfi_cmds.h"
 #include "hfi_msgs.h"
+#include "../hfi_queue.h"
 #include "hfi_venus.h"
 #include "hfi_venus_io.h"
 #include "firmware_no_tz.h"
@@ -34,79 +35,13 @@
 #define IFACEQ_CMD_IDX			0
 #define IFACEQ_MSG_IDX			1
 #define IFACEQ_DBG_IDX			2
-#define IFACEQ_MAX_BUF_COUNT		50
-#define IFACEQ_MAX_PARALLEL_CLNTS	16
-#define IFACEQ_DFLT_QHDR		0x01010000
 
 #define POLL_INTERVAL_US		50
 
-#define IFACEQ_MAX_PKT_SIZE		1024
-#define IFACEQ_MED_PKT_SIZE		768
-#define IFACEQ_MIN_PKT_SIZE		8
 #define IFACEQ_VAR_SMALL_PKT_SIZE	100
 #define IFACEQ_VAR_LARGE_PKT_SIZE	512
 #define IFACEQ_VAR_HUGE_PKT_SIZE	(1024 * 12)
 
-struct hfi_queue_table_header {
-	u32 version;
-	u32 size;
-	u32 qhdr0_offset;
-	u32 qhdr_size;
-	u32 num_q;
-	u32 num_active_q;
-};
-
-struct hfi_queue_header {
-	u32 status;
-	u32 start_addr;
-	u32 type;
-	u32 q_size;
-	u32 pkt_size;
-	u32 pkt_drop_cnt;
-	u32 rx_wm;
-	u32 tx_wm;
-	u32 rx_req;
-	u32 tx_req;
-	u32 rx_irq_status;
-	u32 tx_irq_status;
-	u32 read_idx;
-	u32 write_idx;
-};
-
-#define IFACEQ_TABLE_SIZE	\
-	(sizeof(struct hfi_queue_table_header) +	\
-	 sizeof(struct hfi_queue_header) * IFACEQ_NUM)
-
-#define IFACEQ_QUEUE_SIZE	(IFACEQ_MAX_PKT_SIZE *	\
-	IFACEQ_MAX_BUF_COUNT * IFACEQ_MAX_PARALLEL_CLNTS)
-
-#define IFACEQ_GET_QHDR_START_ADDR(ptr, i)	\
-	(void *)(((ptr) + sizeof(struct hfi_queue_table_header)) +	\
-		((i) * sizeof(struct hfi_queue_header)))
-
-#define QDSS_SIZE		SZ_4K
-#define SFR_SIZE		SZ_4K
-#define QUEUE_SIZE		\
-	(IFACEQ_TABLE_SIZE + (IFACEQ_QUEUE_SIZE * IFACEQ_NUM))
-
-#define ALIGNED_QDSS_SIZE	ALIGN(QDSS_SIZE, SZ_4K)
-#define ALIGNED_SFR_SIZE	ALIGN(SFR_SIZE, SZ_4K)
-#define ALIGNED_QUEUE_SIZE	ALIGN(QUEUE_SIZE, SZ_4K)
-#define SHARED_QSIZE		ALIGN(ALIGNED_SFR_SIZE + ALIGNED_QUEUE_SIZE + \
-				      ALIGNED_QDSS_SIZE, SZ_1M)
-
-struct mem_desc {
-	dma_addr_t da;	/* device address */
-	void *kva;	/* kernel virtual address */
-	u32 size;
-	unsigned long attrs;
-};
-
-struct iface_queue {
-	struct hfi_queue_header *qhdr;
-	struct mem_desc qmem;
-};
-
 enum venus_state {
 	VENUS_STATE_DEINIT = 1,
 	VENUS_STATE_INIT,
@@ -125,12 +60,11 @@ struct venus_hfi_device {
 	struct completion release_resource;
 	struct mem_desc ifaceq_table;
 	struct mem_desc sfr;
-	struct iface_queue queues[IFACEQ_NUM];
+	struct iface_q_info queues[IFACEQ_NUM];
 	u8 pkt_buf[IFACEQ_VAR_HUGE_PKT_SIZE];
 	u8 dbg_buf[IFACEQ_VAR_HUGE_PKT_SIZE];
 };
 
-static bool venus_pkt_debug;
 int venus_fw_debug = HFI_DEBUG_MSG_ERROR | HFI_DEBUG_MSG_FATAL;
 static bool venus_fw_low_power_mode = true;
 static int venus_hw_rsp_timeout = 1000;
@@ -149,212 +83,6 @@ static bool venus_is_valid_state(struct venus_hfi_device *hdev)
 	return hdev->state != VENUS_STATE_DEINIT;
 }
 
-static void venus_dump_packet(struct venus_hfi_device *hdev, const void *packet)
-{
-	size_t pkt_size = *(u32 *)packet;
-
-	if (!venus_pkt_debug)
-		return;
-
-	print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_OFFSET, 16, 1, packet,
-		       pkt_size, true);
-}
-
-static int venus_write_queue(struct venus_hfi_device *hdev,
-			     struct iface_queue *queue,
-			     void *packet, u32 *rx_req)
-{
-	struct hfi_queue_header *qhdr;
-	u32 dwords, new_wr_idx;
-	u32 empty_space, rd_idx, wr_idx, qsize;
-	u32 *wr_ptr;
-
-	if (!queue->qmem.kva)
-		return -EINVAL;
-
-	qhdr = queue->qhdr;
-	if (!qhdr)
-		return -EINVAL;
-
-	venus_dump_packet(hdev, packet);
-
-	dwords = (*(u32 *)packet) >> 2;
-	if (!dwords)
-		return -EINVAL;
-
-	rd_idx = qhdr->read_idx;
-	wr_idx = qhdr->write_idx;
-	qsize = qhdr->q_size;
-	/* ensure rd/wr indices's are read from memory */
-	rmb();
-
-	if (wr_idx >= rd_idx)
-		empty_space = qsize - (wr_idx - rd_idx);
-	else
-		empty_space = rd_idx - wr_idx;
-
-	if (empty_space <= dwords) {
-		qhdr->tx_req = 1;
-		/* ensure tx_req is updated in memory */
-		wmb();
-		return -ENOSPC;
-	}
-
-	qhdr->tx_req = 0;
-	/* ensure tx_req is updated in memory */
-	wmb();
-
-	new_wr_idx = wr_idx + dwords;
-	wr_ptr = (u32 *)(queue->qmem.kva + (wr_idx << 2));
-
-	if (wr_ptr < (u32 *)queue->qmem.kva ||
-	    wr_ptr > (u32 *)(queue->qmem.kva + queue->qmem.size - sizeof(*wr_ptr)))
-		return -EINVAL;
-
-	if (new_wr_idx < qsize) {
-		memcpy(wr_ptr, packet, dwords << 2);
-	} else {
-		size_t len;
-
-		new_wr_idx -= qsize;
-		len = (dwords - new_wr_idx) << 2;
-		memcpy(wr_ptr, packet, len);
-		memcpy(queue->qmem.kva, packet + len, new_wr_idx << 2);
-	}
-
-	/* make sure packet is written before updating the write index */
-	wmb();
-
-	qhdr->write_idx = new_wr_idx;
-	*rx_req = qhdr->rx_req ? 1 : 0;
-
-	/* make sure write index is updated before an interrupt is raised */
-	mb();
-
-	return 0;
-}
-
-static int venus_read_queue(struct venus_hfi_device *hdev,
-			    struct iface_queue *queue, void *pkt, u32 *tx_req)
-{
-	struct hfi_queue_header *qhdr;
-	u32 dwords, new_rd_idx;
-	u32 rd_idx, wr_idx, type, qsize;
-	u32 *rd_ptr;
-	u32 recv_request = 0;
-	int ret = 0;
-
-	if (!queue->qmem.kva)
-		return -EINVAL;
-
-	qhdr = queue->qhdr;
-	if (!qhdr)
-		return -EINVAL;
-
-	type = qhdr->type;
-	rd_idx = qhdr->read_idx;
-	wr_idx = qhdr->write_idx;
-	qsize = qhdr->q_size;
-
-	/* make sure data is valid before using it */
-	rmb();
-
-	/*
-	 * Do not set receive request for debug queue, if set, Venus generates
-	 * interrupt for debug messages even when there is no response message
-	 * available. In general debug queue will not become full as it is being
-	 * emptied out for every interrupt from Venus. Venus will anyway
-	 * generates interrupt if it is full.
-	 */
-	if (type & HFI_CTRL_TO_HOST_MSG_Q)
-		recv_request = 1;
-
-	if (rd_idx == wr_idx) {
-		qhdr->rx_req = recv_request;
-		*tx_req = 0;
-		/* update rx_req field in memory */
-		wmb();
-		return -ENODATA;
-	}
-
-	rd_ptr = (u32 *)(queue->qmem.kva + (rd_idx << 2));
-
-	if (rd_ptr < (u32 *)queue->qmem.kva ||
-	    rd_ptr > (u32 *)(queue->qmem.kva + queue->qmem.size - sizeof(*rd_ptr)))
-		return -EINVAL;
-
-	dwords = *rd_ptr >> 2;
-	if (!dwords)
-		return -EINVAL;
-
-	new_rd_idx = rd_idx + dwords;
-	if (((dwords << 2) <= IFACEQ_VAR_HUGE_PKT_SIZE) && rd_idx <= qsize) {
-		if (new_rd_idx < qsize) {
-			memcpy(pkt, rd_ptr, dwords << 2);
-		} else {
-			size_t len;
-
-			new_rd_idx -= qsize;
-			len = (dwords - new_rd_idx) << 2;
-			memcpy(pkt, rd_ptr, len);
-			memcpy(pkt + len, queue->qmem.kva, new_rd_idx << 2);
-		}
-	} else {
-		/* bad packet received, dropping */
-		new_rd_idx = qhdr->write_idx;
-		ret = -EBADMSG;
-	}
-
-	/* ensure the packet is read before updating read index */
-	rmb();
-
-	qhdr->read_idx = new_rd_idx;
-	/* ensure updating read index */
-	wmb();
-
-	rd_idx = qhdr->read_idx;
-	wr_idx = qhdr->write_idx;
-	/* ensure rd/wr indices are read from memory */
-	rmb();
-
-	if (rd_idx != wr_idx)
-		qhdr->rx_req = 0;
-	else
-		qhdr->rx_req = recv_request;
-
-	*tx_req = qhdr->tx_req ? 1 : 0;
-
-	/* ensure rx_req is stored to memory and tx_req is loaded from memory */
-	mb();
-
-	venus_dump_packet(hdev, pkt);
-
-	return ret;
-}
-
-static int venus_alloc(struct venus_hfi_device *hdev, struct mem_desc *desc,
-		       u32 size)
-{
-	struct device *dev = hdev->core->dev;
-
-	desc->attrs = DMA_ATTR_WRITE_COMBINE;
-	desc->size = ALIGN(size, SZ_4K);
-
-	desc->kva = dma_alloc_attrs(dev, desc->size, &desc->da, GFP_KERNEL,
-				    desc->attrs);
-	if (!desc->kva)
-		return -ENOMEM;
-
-	return 0;
-}
-
-static void venus_free(struct venus_hfi_device *hdev, struct mem_desc *mem)
-{
-	struct device *dev = hdev->core->dev;
-
-	dma_free_attrs(dev, mem->size, mem->kva, mem->da, mem->attrs);
-}
-
 static void venus_set_registers(struct venus_hfi_device *hdev)
 {
 	const struct venus_resources *res = hdev->core->res;
@@ -380,11 +108,11 @@ static void venus_soft_int(struct venus_hfi_device *hdev)
 }
 
 static int venus_iface_cmdq_write_nolock(struct venus_hfi_device *hdev,
-					 void *pkt, bool sync)
+					 void *pkt, u32 pkt_size, bool sync)
 {
 	struct device *dev = hdev->core->dev;
 	struct hfi_pkt_hdr *cmd_packet;
-	struct iface_queue *queue;
+	struct iface_q_info *queue;
 	u32 rx_req;
 	int ret;
 
@@ -396,7 +124,7 @@ static int venus_iface_cmdq_write_nolock(struct venus_hfi_device *hdev,
 
 	queue = &hdev->queues[IFACEQ_CMD_IDX];
 
-	ret = venus_write_queue(hdev, queue, pkt, &rx_req);
+	ret = write_queue(queue, pkt, pkt_size, &rx_req);
 	if (ret) {
 		dev_err(dev, "write to iface cmd queue failed (%d)\n", ret);
 		return ret;
@@ -408,7 +136,7 @@ static int venus_iface_cmdq_write_nolock(struct venus_hfi_device *hdev,
 		 * commands
 		 */
 		queue = &hdev->queues[IFACEQ_MSG_IDX];
-		queue->qhdr->rx_req = 1;
+		queue->qhdr->qhdr_rx_req = 1;
 		/* ensure rx_req is updated in memory */
 		wmb();
 	}
@@ -419,12 +147,12 @@ static int venus_iface_cmdq_write_nolock(struct venus_hfi_device *hdev,
 	return 0;
 }
 
-static int venus_iface_cmdq_write(struct venus_hfi_device *hdev, void *pkt, bool sync)
+static int venus_iface_cmdq_write(struct venus_hfi_device *hdev, void *pkt, u32 pkt_size, bool sync)
 {
 	int ret;
 
 	mutex_lock(&hdev->lock);
-	ret = venus_iface_cmdq_write_nolock(hdev, pkt, sync);
+	ret = venus_iface_cmdq_write_nolock(hdev, pkt, pkt_size, sync);
 	mutex_unlock(&hdev->lock);
 
 	return ret;
@@ -447,7 +175,7 @@ static int venus_hfi_core_set_resource(struct venus_core *core, u32 id,
 	if (ret)
 		return ret;
 
-	ret = venus_iface_cmdq_write(hdev, pkt, false);
+	ret = venus_iface_cmdq_write(hdev, pkt, pkt->hdr.size, false);
 	if (ret)
 		return ret;
 
@@ -531,12 +259,12 @@ static int venus_run(struct venus_hfi_device *hdev)
 	 */
 	venus_set_registers(hdev);
 
-	writel(hdev->ifaceq_table.da, cpu_cs_base + UC_REGION_ADDR);
+	writel(hdev->ifaceq_table.device_addr, cpu_cs_base + UC_REGION_ADDR);
 	writel(SHARED_QSIZE, cpu_cs_base + UC_REGION_SIZE);
-	writel(hdev->ifaceq_table.da, cpu_cs_base + CPU_CS_SCIACMDARG2);
+	writel(hdev->ifaceq_table.device_addr, cpu_cs_base + CPU_CS_SCIACMDARG2);
 	writel(0x01, cpu_cs_base + CPU_CS_SCIACMDARG1);
-	if (hdev->sfr.da)
-		writel(hdev->sfr.da, cpu_cs_base + SFR_ADDR);
+	if (hdev->sfr.device_addr)
+		writel(hdev->sfr.device_addr, cpu_cs_base + SFR_ADDR);
 
 	ret = venus_boot_core(hdev);
 	if (ret) {
@@ -690,7 +418,7 @@ static int venus_power_on(struct venus_hfi_device *hdev)
 static int venus_iface_msgq_read_nolock(struct venus_hfi_device *hdev,
 					void *pkt)
 {
-	struct iface_queue *queue;
+	struct iface_q_info *queue;
 	u32 tx_req;
 	int ret;
 
@@ -699,7 +427,7 @@ static int venus_iface_msgq_read_nolock(struct venus_hfi_device *hdev,
 
 	queue = &hdev->queues[IFACEQ_MSG_IDX];
 
-	ret = venus_read_queue(hdev, queue, pkt, &tx_req);
+	ret = read_queue(queue, pkt, &tx_req);
 	if (ret)
 		return ret;
 
@@ -723,7 +451,7 @@ static int venus_iface_msgq_read(struct venus_hfi_device *hdev, void *pkt)
 static int venus_iface_dbgq_read_nolock(struct venus_hfi_device *hdev,
 					void *pkt)
 {
-	struct iface_queue *queue;
+	struct iface_q_info *queue;
 	u32 tx_req;
 	int ret;
 
@@ -733,7 +461,7 @@ static int venus_iface_dbgq_read_nolock(struct venus_hfi_device *hdev,
 
 	queue = &hdev->queues[IFACEQ_DBG_IDX];
 
-	ret = venus_read_queue(hdev, queue, pkt, &tx_req);
+	ret = read_queue(queue, pkt, &tx_req);
 	if (ret)
 		return ret;
 
@@ -759,100 +487,18 @@ static int venus_iface_dbgq_read(struct venus_hfi_device *hdev, void *pkt)
 
 static void venus_set_qhdr_defaults(struct hfi_queue_header *qhdr)
 {
-	qhdr->status = 1;
-	qhdr->type = IFACEQ_DFLT_QHDR;
-	qhdr->q_size = IFACEQ_QUEUE_SIZE / 4;
-	qhdr->pkt_size = 0;
-	qhdr->rx_wm = 1;
-	qhdr->tx_wm = 1;
-	qhdr->rx_req = 1;
-	qhdr->tx_req = 0;
-	qhdr->rx_irq_status = 0;
-	qhdr->tx_irq_status = 0;
-	qhdr->read_idx = 0;
-	qhdr->write_idx = 0;
-}
-
-static void venus_interface_queues_release(struct venus_hfi_device *hdev)
-{
-	mutex_lock(&hdev->lock);
-
-	venus_free(hdev, &hdev->ifaceq_table);
-	venus_free(hdev, &hdev->sfr);
-
-	memset(hdev->queues, 0, sizeof(hdev->queues));
-	memset(&hdev->ifaceq_table, 0, sizeof(hdev->ifaceq_table));
-	memset(&hdev->sfr, 0, sizeof(hdev->sfr));
-
-	mutex_unlock(&hdev->lock);
-}
-
-static int venus_interface_queues_init(struct venus_hfi_device *hdev)
-{
-	struct hfi_queue_table_header *tbl_hdr;
-	struct iface_queue *queue;
-	struct hfi_sfr *sfr;
-	struct mem_desc desc = {0};
-	unsigned int offset;
-	unsigned int i;
-	int ret;
-
-	ret = venus_alloc(hdev, &desc, ALIGNED_QUEUE_SIZE);
-	if (ret)
-		return ret;
-
-	hdev->ifaceq_table = desc;
-	offset = IFACEQ_TABLE_SIZE;
-
-	for (i = 0; i < IFACEQ_NUM; i++) {
-		queue = &hdev->queues[i];
-		queue->qmem.da = desc.da + offset;
-		queue->qmem.kva = desc.kva + offset;
-		queue->qmem.size = IFACEQ_QUEUE_SIZE;
-		offset += queue->qmem.size;
-		queue->qhdr =
-			IFACEQ_GET_QHDR_START_ADDR(hdev->ifaceq_table.kva, i);
-
-		venus_set_qhdr_defaults(queue->qhdr);
-
-		queue->qhdr->start_addr = queue->qmem.da;
-
-		if (i == IFACEQ_CMD_IDX)
-			queue->qhdr->type |= HFI_HOST_TO_CTRL_CMD_Q;
-		else if (i == IFACEQ_MSG_IDX)
-			queue->qhdr->type |= HFI_CTRL_TO_HOST_MSG_Q;
-		else if (i == IFACEQ_DBG_IDX)
-			queue->qhdr->type |= HFI_CTRL_TO_HOST_DBG_Q;
-	}
-
-	tbl_hdr = hdev->ifaceq_table.kva;
-	tbl_hdr->version = 0;
-	tbl_hdr->size = IFACEQ_TABLE_SIZE;
-	tbl_hdr->qhdr0_offset = sizeof(struct hfi_queue_table_header);
-	tbl_hdr->qhdr_size = sizeof(struct hfi_queue_header);
-	tbl_hdr->num_q = IFACEQ_NUM;
-	tbl_hdr->num_active_q = IFACEQ_NUM;
-
-	/*
-	 * Set receive request to zero on debug queue as there is no
-	 * need of interrupt from video hardware for debug messages
-	 */
-	queue = &hdev->queues[IFACEQ_DBG_IDX];
-	queue->qhdr->rx_req = 0;
-
-	ret = venus_alloc(hdev, &desc, ALIGNED_SFR_SIZE);
-	if (ret) {
-		hdev->sfr.da = 0;
-	} else {
-		hdev->sfr = desc;
-		sfr = hdev->sfr.kva;
-		sfr->buf_size = ALIGNED_SFR_SIZE;
-	}
-
-	/* ensure table and queue header structs are settled in memory */
-	wmb();
-
-	return 0;
+	qhdr->qhdr_status = 1;
+	qhdr->qhdr_type = IFACEQ_DFLT_QHDR;
+	qhdr->qhdr_q_size = IFACEQ_QUEUE_SIZE / 4;
+	qhdr->qhdr_pkt_size = 0;
+	qhdr->qhdr_rx_wm = 1;
+	qhdr->qhdr_tx_wm = 1;
+	qhdr->qhdr_rx_req = 1;
+	qhdr->qhdr_tx_req = 0;
+	qhdr->qhdr_rx_irq_status = 0;
+	qhdr->qhdr_tx_irq_status = 0;
+	qhdr->qhdr_read_idx = 0;
+	qhdr->qhdr_write_idx = 0;
 }
 
 static int venus_sys_set_debug(struct venus_hfi_device *hdev, u32 debug)
@@ -864,7 +510,7 @@ static int venus_sys_set_debug(struct venus_hfi_device *hdev, u32 debug)
 
 	pkt_sys_debug_config(pkt, HFI_DEBUG_MODE_QUEUE, debug);
 
-	return venus_iface_cmdq_write(hdev, pkt, false);
+	return venus_iface_cmdq_write(hdev, pkt, pkt->hdr.size, false);
 }
 
 static int venus_sys_set_coverage(struct venus_hfi_device *hdev, u32 mode)
@@ -876,7 +522,7 @@ static int venus_sys_set_coverage(struct venus_hfi_device *hdev, u32 mode)
 
 	pkt_sys_coverage_config(pkt, mode);
 
-	return venus_iface_cmdq_write(hdev, pkt, false);
+	return venus_iface_cmdq_write(hdev, pkt, pkt->hdr.size, false);
 }
 
 static int venus_sys_set_idle_message(struct venus_hfi_device *hdev,
@@ -892,7 +538,7 @@ static int venus_sys_set_idle_message(struct venus_hfi_device *hdev,
 
 	pkt_sys_idle_indicator(pkt, enable);
 
-	return venus_iface_cmdq_write(hdev, pkt, false);
+	return venus_iface_cmdq_write(hdev, pkt, pkt->hdr.size, false);
 }
 
 static int venus_sys_set_power_control(struct venus_hfi_device *hdev,
@@ -905,7 +551,7 @@ static int venus_sys_set_power_control(struct venus_hfi_device *hdev,
 
 	pkt_sys_power_control(pkt, enable);
 
-	return venus_iface_cmdq_write(hdev, pkt, false);
+	return venus_iface_cmdq_write(hdev, pkt, pkt->hdr.size, false);
 }
 
 static int venus_sys_set_ubwc_config(struct venus_hfi_device *hdev)
@@ -919,7 +565,7 @@ static int venus_sys_set_ubwc_config(struct venus_hfi_device *hdev)
 
 	pkt_sys_ubwc_config(pkt, res->ubwc_conf);
 
-	ret = venus_iface_cmdq_write(hdev, pkt, false);
+	ret = venus_iface_cmdq_write(hdev, pkt, pkt->hdr.size, false);
 	if (ret)
 		return ret;
 
@@ -938,7 +584,7 @@ static int venus_get_queue_size(struct venus_hfi_device *hdev,
 	if (!qhdr)
 		return -EINVAL;
 
-	return abs(qhdr->read_idx - qhdr->write_idx);
+	return abs(qhdr->qhdr_read_idx - qhdr->qhdr_write_idx);
 }
 
 static int venus_sys_set_default_properties(struct venus_hfi_device *hdev)
@@ -980,7 +626,7 @@ static int venus_session_cmd(struct venus_inst *inst, u32 pkt_type, bool sync)
 
 	pkt_session_cmd(&pkt, pkt_type, inst);
 
-	return venus_iface_cmdq_write(hdev, &pkt, sync);
+	return venus_iface_cmdq_write(hdev, &pkt, pkt.shdr.hdr.size, sync);
 }
 
 static void venus_flush_debug_queue(struct venus_hfi_device *hdev)
@@ -1010,7 +656,7 @@ static int venus_prepare_power_collapse(struct venus_hfi_device *hdev,
 
 	pkt_sys_pc_prep(&pkt);
 
-	ret = venus_iface_cmdq_write(hdev, &pkt, false);
+	ret = venus_iface_cmdq_write(hdev, &pkt, pkt.hdr.size, false);
 	if (ret)
 		return ret;
 
@@ -1047,7 +693,7 @@ static int venus_are_queues_empty(struct venus_hfi_device *hdev)
 static void venus_sfr_print(struct venus_hfi_device *hdev)
 {
 	struct device *dev = hdev->core->dev;
-	struct hfi_sfr *sfr = hdev->sfr.kva;
+	struct hfi_sfr *sfr = hdev->sfr.kernel_vaddr;
 	void *p;
 
 	if (!sfr)
@@ -1163,13 +809,13 @@ static int venus_core_init(struct venus_core *core)
 
 	venus_set_state(hdev, VENUS_STATE_INIT);
 
-	ret = venus_iface_cmdq_write(hdev, &pkt, false);
+	ret = venus_iface_cmdq_write(hdev, &pkt, pkt.hdr.size, false);
 	if (ret)
 		return ret;
 
 	pkt_sys_image_version(&version_pkt);
 
-	ret = venus_iface_cmdq_write(hdev, &version_pkt, false);
+	ret = venus_iface_cmdq_write(hdev, &version_pkt, version_pkt.hdr.size, false);
 	if (ret)
 		dev_warn(dev, "failed to send image version pkt to fw\n");
 
@@ -1198,7 +844,7 @@ static int venus_core_ping(struct venus_core *core, u32 cookie)
 
 	pkt_sys_ping(&pkt, cookie);
 
-	return venus_iface_cmdq_write(hdev, &pkt, false);
+	return venus_iface_cmdq_write(hdev, &pkt, pkt.hdr.size, false);
 }
 
 static int venus_core_trigger_ssr(struct venus_core *core, u32 trigger_type)
@@ -1211,7 +857,7 @@ static int venus_core_trigger_ssr(struct venus_core *core, u32 trigger_type)
 	if (ret)
 		return ret;
 
-	return venus_iface_cmdq_write(hdev, &pkt, false);
+	return venus_iface_cmdq_write(hdev, &pkt, pkt.hdr.size, false);
 }
 
 static int venus_session_init(struct venus_inst *inst, u32 session_type,
@@ -1229,7 +875,7 @@ static int venus_session_init(struct venus_inst *inst, u32 session_type,
 	if (ret)
 		goto err;
 
-	ret = venus_iface_cmdq_write(hdev, &pkt, true);
+	ret = venus_iface_cmdq_write(hdev, &pkt, pkt.shdr.hdr.size, true);
 	if (ret)
 		goto err;
 
@@ -1272,7 +918,7 @@ static int venus_session_flush(struct venus_inst *inst, u32 flush_mode)
 	if (ret)
 		return ret;
 
-	return venus_iface_cmdq_write(hdev, &pkt, true);
+	return venus_iface_cmdq_write(hdev, &pkt, pkt.shdr.hdr.size, true);
 }
 
 static int venus_session_start(struct venus_inst *inst)
@@ -1304,7 +950,7 @@ static int venus_session_etb(struct venus_inst *inst,
 		if (ret)
 			return ret;
 
-		ret = venus_iface_cmdq_write(hdev, &pkt, false);
+		ret = venus_iface_cmdq_write(hdev, &pkt, pkt.shdr.hdr.size, false);
 	} else if (session_type == VIDC_SESSION_TYPE_ENC) {
 		struct hfi_session_empty_buffer_uncompressed_plane0_pkt pkt;
 
@@ -1312,7 +958,7 @@ static int venus_session_etb(struct venus_inst *inst,
 		if (ret)
 			return ret;
 
-		ret = venus_iface_cmdq_write(hdev, &pkt, false);
+		ret = venus_iface_cmdq_write(hdev, &pkt, pkt.shdr.hdr.size, false);
 	} else {
 		ret = -EINVAL;
 	}
@@ -1331,7 +977,7 @@ static int venus_session_ftb(struct venus_inst *inst,
 	if (ret)
 		return ret;
 
-	return venus_iface_cmdq_write(hdev, &pkt, false);
+	return venus_iface_cmdq_write(hdev, &pkt, pkt.shdr.hdr.size, false);
 }
 
 static int venus_session_set_buffers(struct venus_inst *inst,
@@ -1351,7 +997,7 @@ static int venus_session_set_buffers(struct venus_inst *inst,
 	if (ret)
 		return ret;
 
-	return venus_iface_cmdq_write(hdev, pkt, false);
+	return venus_iface_cmdq_write(hdev, pkt, pkt->shdr.hdr.size, false);
 }
 
 static int venus_session_unset_buffers(struct venus_inst *inst,
@@ -1371,7 +1017,7 @@ static int venus_session_unset_buffers(struct venus_inst *inst,
 	if (ret)
 		return ret;
 
-	return venus_iface_cmdq_write(hdev, pkt, true);
+	return venus_iface_cmdq_write(hdev, pkt, pkt->shdr.hdr.size, true);
 }
 
 static int venus_session_load_res(struct venus_inst *inst)
@@ -1398,7 +1044,7 @@ static int venus_session_parse_seq_hdr(struct venus_inst *inst, u32 seq_hdr,
 	if (ret)
 		return ret;
 
-	ret = venus_iface_cmdq_write(hdev, pkt, false);
+	ret = venus_iface_cmdq_write(hdev, pkt, pkt->shdr.hdr.size, false);
 	if (ret)
 		return ret;
 
@@ -1419,7 +1065,7 @@ static int venus_session_get_seq_hdr(struct venus_inst *inst, u32 seq_hdr,
 	if (ret)
 		return ret;
 
-	return venus_iface_cmdq_write(hdev, pkt, false);
+	return venus_iface_cmdq_write(hdev, pkt, pkt->shdr.hdr.size, false);
 }
 
 static int venus_session_set_property(struct venus_inst *inst, u32 ptype,
@@ -1438,7 +1084,7 @@ static int venus_session_set_property(struct venus_inst *inst, u32 ptype,
 	if (ret)
 		return ret;
 
-	return venus_iface_cmdq_write(hdev, pkt, false);
+	return venus_iface_cmdq_write(hdev, pkt, pkt->shdr.hdr.size, false);
 }
 
 static int venus_session_get_property(struct venus_inst *inst, u32 ptype)
@@ -1451,7 +1097,7 @@ static int venus_session_get_property(struct venus_inst *inst, u32 ptype)
 	if (ret)
 		return ret;
 
-	return venus_iface_cmdq_write(hdev, &pkt, true);
+	return venus_iface_cmdq_write(hdev, &pkt, pkt.shdr.hdr.size, true);
 }
 
 static int venus_resume(struct venus_core *core)
@@ -1685,7 +1331,11 @@ void venus_hfi_destroy(struct venus_core *core)
 	struct venus_hfi_device *hdev = to_hfi_priv(core);
 
 	core->priv = NULL;
-	venus_interface_queues_release(hdev);
+	mutex_lock(&hdev->lock);
+	hfi_queue_deinit(hdev->core->dev, &hdev->ifaceq_table, &hdev->sfr,
+			 &hdev->queues[0], &hdev->queues[1],
+			 &hdev->queues[2]);
+	mutex_unlock(&hdev->lock);
 	mutex_destroy(&hdev->lock);
 	kfree(hdev);
 	core->ops = NULL;
@@ -1707,7 +1357,9 @@ int venus_hfi_create(struct venus_core *core)
 	core->priv = hdev;
 	core->ops = &venus_hfi_ops;
 
-	ret = venus_interface_queues_init(hdev);
+	ret = hfi_queue_init(hdev->core->dev, &hdev->ifaceq_table, &hdev->sfr,
+			     &hdev->queues[0], &hdev->queues[1],
+			     &hdev->queues[2], &hdev->core);
 	if (ret)
 		goto err_kfree;
 
@@ -1724,7 +1376,7 @@ void venus_hfi_queues_reinit(struct venus_core *core)
 {
 	struct venus_hfi_device *hdev = to_hfi_priv(core);
 	struct hfi_queue_table_header *tbl_hdr;
-	struct iface_queue *queue;
+	struct iface_q_info *queue;
 	struct hfi_sfr *sfr;
 	unsigned int i;
 
@@ -1733,36 +1385,36 @@ void venus_hfi_queues_reinit(struct venus_core *core)
 	for (i = 0; i < IFACEQ_NUM; i++) {
 		queue = &hdev->queues[i];
 		queue->qhdr =
-			IFACEQ_GET_QHDR_START_ADDR(hdev->ifaceq_table.kva, i);
+			IFACEQ_GET_QHDR_START_ADDR(hdev->ifaceq_table.kernel_vaddr, i);
 
 		venus_set_qhdr_defaults(queue->qhdr);
 
-		queue->qhdr->start_addr = queue->qmem.da;
+		queue->qhdr->qhdr_start_addr = queue->q_array.device_addr;
 
 		if (i == IFACEQ_CMD_IDX)
-			queue->qhdr->type |= HFI_HOST_TO_CTRL_CMD_Q;
+			queue->qhdr->qhdr_type |= HFI_HOST_TO_CTRL_CMD_Q;
 		else if (i == IFACEQ_MSG_IDX)
-			queue->qhdr->type |= HFI_CTRL_TO_HOST_MSG_Q;
+			queue->qhdr->qhdr_type |= HFI_CTRL_TO_HOST_MSG_Q;
 		else if (i == IFACEQ_DBG_IDX)
-			queue->qhdr->type |= HFI_CTRL_TO_HOST_DBG_Q;
+			queue->qhdr->qhdr_type |= HFI_CTRL_TO_HOST_DBG_Q;
 	}
 
-	tbl_hdr = hdev->ifaceq_table.kva;
-	tbl_hdr->version = 0;
-	tbl_hdr->size = IFACEQ_TABLE_SIZE;
-	tbl_hdr->qhdr0_offset = sizeof(struct hfi_queue_table_header);
-	tbl_hdr->qhdr_size = sizeof(struct hfi_queue_header);
-	tbl_hdr->num_q = IFACEQ_NUM;
-	tbl_hdr->num_active_q = IFACEQ_NUM;
+	tbl_hdr = hdev->ifaceq_table.kernel_vaddr;
+	tbl_hdr->qtbl_version = 0;
+	tbl_hdr->qtbl_size = IFACEQ_TABLE_SIZE;
+	tbl_hdr->qtbl_qhdr0_offset = sizeof(struct hfi_queue_table_header);
+	tbl_hdr->qtbl_qhdr_size = sizeof(struct hfi_queue_header);
+	tbl_hdr->qtbl_num_q = IFACEQ_NUM;
+	tbl_hdr->qtbl_num_active_q = IFACEQ_NUM;
 
 	/*
 	 * Set receive request to zero on debug queue as there is no
 	 * need of interrupt from video hardware for debug messages
 	 */
 	queue = &hdev->queues[IFACEQ_DBG_IDX];
-	queue->qhdr->rx_req = 0;
+	queue->qhdr->qhdr_rx_req = 0;
 
-	sfr = hdev->sfr.kva;
+	sfr = hdev->sfr.kernel_vaddr;
 	sfr->buf_size = ALIGNED_SFR_SIZE;
 
 	/* ensure table and queue header structs are settled in memory */
-- 
2.7.4


