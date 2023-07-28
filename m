Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2556766E57
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbjG1N21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236855AbjG1N15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:27:57 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF0049C6;
        Fri, 28 Jul 2023 06:27:19 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SBlxh7031964;
        Fri, 28 Jul 2023 13:26:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=OROrDqAOeFlRsGHCmUoiaxjpGzXBXnPfK8kqvpOf1V4=;
 b=Q0Oc8Z1d4jPRcrzCQodm3Pj0BsgySfJ3yLm5X+9EZE/6R7P4Ys8LwCcSnx2HnM443XSv
 yKIgqeWzytl7cB5cvu/f+G57qSGNEcW+7gTlxS6JSaAsozBDSSPWP26gVRwCP/+STHZY
 /V4/sxdojCU1p6qQl3NNm7QZJY3KVdve3hfF06sI8ZxKyp4RKyiQJ8qiTysuvDFrp5Gc
 OcsiMpsmIiC1xdr1aovn9hL6CNl2NEDrXMC8nwumUJR/cEdybTZJS+VJekcU5NYYIqda
 3wdTryhaDr+dDfX0cfyCLJPzYkHw7usGv+RrrNrAL0Qfu3Be6Ez/11GsqOxHUO3AaMH7 Qw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s46ttgyy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 13:26:20 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36SDQJnx014335
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 13:26:19 GMT
Received: from hu-vgarodia-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 28 Jul 2023 06:26:16 -0700
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
To:     <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <hans.verkuil@cisco.com>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
CC:     <quic_dikshita@quicinc.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
Subject: [PATCH 20/33] iris: vidc: hfi: add helpers for handling shared queues
Date:   Fri, 28 Jul 2023 18:53:31 +0530
Message-ID: <1690550624-14642-21-git-send-email-quic_vgarodia@quicinc.com>
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
X-Proofpoint-ORIG-GUID: QhbggkF2COfDPmBV7Wj2EvGJ9XJIBmXi
X-Proofpoint-GUID: QhbggkF2COfDPmBV7Wj2EvGJ9XJIBmXi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=713
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

This implements functions to allocate and update the shared memory
used for sending commands to firmware and receiving messages from
firmware.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
---
 .../platform/qcom/iris/vidc/inc/venus_hfi_queue.h  |  89 ++++
 .../platform/qcom/iris/vidc/src/venus_hfi_queue.c  | 537 +++++++++++++++++++++
 2 files changed, 626 insertions(+)
 create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/venus_hfi_queue.h
 create mode 100644 drivers/media/platform/qcom/iris/vidc/src/venus_hfi_queue.c

diff --git a/drivers/media/platform/qcom/iris/vidc/inc/venus_hfi_queue.h b/drivers/media/platform/qcom/iris/vidc/inc/venus_hfi_queue.h
new file mode 100644
index 0000000..f533811
--- /dev/null
+++ b/drivers/media/platform/qcom/iris/vidc/inc/venus_hfi_queue.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020-2022, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _VENUS_HFI_QUEUE_H_
+#define _VENUS_HFI_QUEUE_H_
+
+#include <linux/types.h>
+
+#include "msm_vidc_internal.h"
+
+#define HFI_MASK_QHDR_TX_TYPE			0xff000000
+#define HFI_MASK_QHDR_RX_TYPE			0x00ff0000
+#define HFI_MASK_QHDR_PRI_TYPE			0x0000ff00
+#define HFI_MASK_QHDR_Q_ID_TYPE			0x000000ff
+#define HFI_Q_ID_HOST_TO_CTRL_CMD_Q		0
+#define HFI_Q_ID_CTRL_TO_HOST_MSG_Q		1
+#define HFI_Q_ID_CTRL_TO_HOST_DEBUG_Q		2
+#define HFI_MASK_QHDR_STATUS			0x000000ff
+
+#define VIDC_IFACEQ_NUMQ                3
+#define VIDC_IFACEQ_CMDQ_IDX            0
+#define VIDC_IFACEQ_MSGQ_IDX            1
+#define VIDC_IFACEQ_DBGQ_IDX            2
+#define VIDC_IFACEQ_MAX_BUF_COUNT       50
+#define VIDC_IFACE_MAX_PARALLEL_CLNTS   16
+#define VIDC_IFACEQ_DFLT_QHDR           0x01010000
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
+#define VIDC_IFACEQ_TABLE_SIZE	(sizeof(struct hfi_queue_table_header) + \
+			sizeof(struct hfi_queue_header) * VIDC_IFACEQ_NUMQ)
+
+#define VIDC_IFACEQ_QUEUE_SIZE	(VIDC_IFACEQ_MAX_PKT_SIZE *  \
+	VIDC_IFACEQ_MAX_BUF_COUNT * VIDC_IFACE_MAX_PARALLEL_CLNTS)
+
+#define VIDC_IFACEQ_GET_QHDR_START_ADDR(ptr, i)     \
+	((void *)(((ptr) + sizeof(struct hfi_queue_table_header)) + \
+		((i) * sizeof(struct hfi_queue_header))))
+
+#define QDSS_SIZE	4096
+#define SFR_SIZE	4096
+
+#define QUEUE_SIZE	(VIDC_IFACEQ_TABLE_SIZE + \
+			(VIDC_IFACEQ_QUEUE_SIZE * VIDC_IFACEQ_NUMQ))
+
+#define ALIGNED_QDSS_SIZE	ALIGN(QDSS_SIZE, SZ_4K)
+#define ALIGNED_SFR_SIZE	ALIGN(SFR_SIZE, SZ_4K)
+#define ALIGNED_QUEUE_SIZE	ALIGN(QUEUE_SIZE, SZ_4K)
+#define SHARED_QSIZE		ALIGN(ALIGNED_SFR_SIZE + ALIGNED_QUEUE_SIZE + \
+				      ALIGNED_QDSS_SIZE, SZ_1M)
+#define TOTAL_QSIZE	(SHARED_QSIZE - ALIGNED_SFR_SIZE - ALIGNED_QDSS_SIZE)
+
+int venus_hfi_queue_cmd_write(struct msm_vidc_core *core, void *pkt);
+int venus_hfi_queue_msg_read(struct msm_vidc_core *core, void *pkt);
+int venus_hfi_queue_dbg_read(struct msm_vidc_core *core, void *pkt);
+void venus_hfi_queue_deinit(struct msm_vidc_core *core);
+int venus_hfi_queue_init(struct msm_vidc_core *core);
+int venus_hfi_reset_queue_header(struct msm_vidc_core *core);
+
+#endif
diff --git a/drivers/media/platform/qcom/iris/vidc/src/venus_hfi_queue.c b/drivers/media/platform/qcom/iris/vidc/src/venus_hfi_queue.c
new file mode 100644
index 0000000..8e038ba
--- /dev/null
+++ b/drivers/media/platform/qcom/iris/vidc/src/venus_hfi_queue.c
@@ -0,0 +1,537 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "msm_vidc_core.h"
+#include "msm_vidc_debug.h"
+#include "msm_vidc_memory.h"
+#include "msm_vidc_platform.h"
+#include "venus_hfi.h"
+#include "venus_hfi_queue.h"
+
+static void __set_queue_hdr_defaults(struct hfi_queue_header *q_hdr)
+{
+	q_hdr->qhdr_status = 0x1;
+	q_hdr->qhdr_type = VIDC_IFACEQ_DFLT_QHDR;
+	q_hdr->qhdr_q_size = VIDC_IFACEQ_QUEUE_SIZE / 4;
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
+static void __dump_packet(u8 *packet, const char *function, void *qinfo)
+{
+	u32 c = 0, session_id, packet_size = *(u32 *)packet;
+	const int row_size = 32;
+	/*
+	 * row must contain enough for 0xdeadbaad * 8 to be converted into
+	 * "de ad ba ab " * 8 + '\0'
+	 */
+	char row[3 * 32];
+
+	session_id = *((u32 *)packet + 1);
+
+	d_vpr_t("%08x: %s: %pK\n", session_id, function, qinfo);
+
+	for (c = 0; c * row_size < packet_size; ++c) {
+		int bytes_to_read = ((c + 1) * row_size > packet_size) ?
+			packet_size % row_size : row_size;
+		hex_dump_to_buffer(packet + c * row_size, bytes_to_read,
+				   row_size, 4, row, sizeof(row), false);
+		d_vpr_t("%08x: %s\n", session_id, row);
+	}
+}
+
+static int __write_queue(struct msm_vidc_iface_q_info *qinfo, u8 *packet,
+			 bool *rx_req_is_set)
+{
+	struct hfi_queue_header *queue;
+	u32 packet_size_in_words, new_write_idx;
+	u32 empty_space, read_idx, write_idx;
+	u32 *write_ptr;
+
+	if (!qinfo || !packet) {
+		d_vpr_e("%s: invalid params %pK %pK\n",
+			__func__, qinfo, packet);
+		return -EINVAL;
+	} else if (!qinfo->q_array.align_virtual_addr) {
+		d_vpr_e("Queues have already been freed\n");
+		return -EINVAL;
+	}
+
+	queue = (struct hfi_queue_header *)qinfo->q_hdr;
+	if (!queue) {
+		d_vpr_e("queue not present\n");
+		return -ENOENT;
+	}
+
+	if (msm_vidc_debug & VIDC_PKT)
+		__dump_packet(packet, __func__, qinfo);
+
+	packet_size_in_words = (*(u32 *)packet) >> 2;
+	if (!packet_size_in_words || packet_size_in_words >
+		qinfo->q_array.mem_size >> 2) {
+		d_vpr_e("Invalid packet size\n");
+		return -ENODATA;
+	}
+
+	read_idx = queue->qhdr_read_idx;
+	write_idx = queue->qhdr_write_idx;
+
+	empty_space = (write_idx >=  read_idx) ?
+		((qinfo->q_array.mem_size >> 2) - (write_idx -  read_idx)) :
+		(read_idx - write_idx);
+	if (empty_space <= packet_size_in_words) {
+		queue->qhdr_tx_req =  1;
+		d_vpr_e("Insufficient size (%d) to write (%d)\n",
+			empty_space, packet_size_in_words);
+		return -ENOTEMPTY;
+	}
+
+	queue->qhdr_tx_req =  0;
+
+	new_write_idx = write_idx + packet_size_in_words;
+	write_ptr = (u32 *)((qinfo->q_array.align_virtual_addr) +
+			(write_idx << 2));
+	if (write_ptr < (u32 *)qinfo->q_array.align_virtual_addr ||
+	    write_ptr > (u32 *)(qinfo->q_array.align_virtual_addr +
+	    qinfo->q_array.mem_size)) {
+		d_vpr_e("Invalid write index\n");
+		return -ENODATA;
+	}
+
+	if (new_write_idx < (qinfo->q_array.mem_size >> 2)) {
+		memcpy(write_ptr, packet, packet_size_in_words << 2);
+	} else {
+		new_write_idx -= qinfo->q_array.mem_size >> 2;
+		memcpy(write_ptr, packet, (packet_size_in_words -
+		       new_write_idx) << 2);
+		memcpy((void *)qinfo->q_array.align_virtual_addr,
+		       packet + ((packet_size_in_words - new_write_idx) << 2),
+		       new_write_idx  << 2);
+	}
+
+	/*
+	 * Memory barrier to make sure packet is written before updating the
+	 * write index
+	 */
+	mb();
+	queue->qhdr_write_idx = new_write_idx;
+	if (rx_req_is_set)
+		*rx_req_is_set = true;
+	/*
+	 * Memory barrier to make sure write index is updated before an
+	 * interrupt is raised on venus.
+	 */
+	mb();
+	return 0;
+}
+
+static int __read_queue(struct msm_vidc_iface_q_info *qinfo, u8 *packet,
+			u32 *pb_tx_req_is_set)
+{
+	struct hfi_queue_header *queue;
+	u32 packet_size_in_words, new_read_idx;
+	u32 *read_ptr;
+	u32 receive_request = 0;
+	u32 read_idx, write_idx;
+	int rc = 0;
+
+	if (!qinfo || !packet || !pb_tx_req_is_set) {
+		d_vpr_e("%s: invalid params %pK %pK %pK\n",
+			__func__, qinfo, packet, pb_tx_req_is_set);
+		return -EINVAL;
+	} else if (!qinfo->q_array.align_virtual_addr) {
+		d_vpr_e("Queues have already been freed\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Memory barrier to make sure data is valid before
+	 *reading it
+	 */
+	mb();
+	queue = (struct hfi_queue_header *)qinfo->q_hdr;
+
+	if (!queue) {
+		d_vpr_e("Queue memory is not allocated\n");
+		return -ENOMEM;
+	}
+
+	/*
+	 * Do not set receive request for debug queue, if set,
+	 * Venus generates interrupt for debug messages even
+	 * when there is no response message available.
+	 * In general debug queue will not become full as it
+	 * is being emptied out for every interrupt from Venus.
+	 * Venus will anyway generates interrupt if it is full.
+	 */
+	if (queue->qhdr_type & HFI_Q_ID_CTRL_TO_HOST_MSG_Q)
+		receive_request = 1;
+
+	read_idx = queue->qhdr_read_idx;
+	write_idx = queue->qhdr_write_idx;
+
+	if (read_idx == write_idx) {
+		queue->qhdr_rx_req = receive_request;
+		/*
+		 * mb() to ensure qhdr is updated in main memory
+		 * so that venus reads the updated header values
+		 */
+		mb();
+		*pb_tx_req_is_set = 0;
+		d_vpr_l("%s queue is empty, rx_req = %u, tx_req = %u, read_idx = %u\n",
+			receive_request ? "message" : "debug",
+			queue->qhdr_rx_req, queue->qhdr_tx_req,
+			queue->qhdr_read_idx);
+		return -ENODATA;
+	}
+
+	read_ptr = (u32 *)((qinfo->q_array.align_virtual_addr) +
+				(read_idx << 2));
+	if (read_ptr < (u32 *)qinfo->q_array.align_virtual_addr ||
+	    read_ptr > (u32 *)(qinfo->q_array.align_virtual_addr +
+	    qinfo->q_array.mem_size - sizeof(*read_ptr))) {
+		d_vpr_e("Invalid read index\n");
+		return -ENODATA;
+	}
+
+	packet_size_in_words = (*read_ptr) >> 2;
+	if (!packet_size_in_words) {
+		d_vpr_e("Zero packet size\n");
+		return -ENODATA;
+	}
+
+	new_read_idx = read_idx + packet_size_in_words;
+	if (((packet_size_in_words << 2) <= VIDC_IFACEQ_VAR_HUGE_PKT_SIZE) &&
+	    read_idx <= (qinfo->q_array.mem_size >> 2)) {
+		if (new_read_idx < (qinfo->q_array.mem_size >> 2)) {
+			memcpy(packet, read_ptr,
+			       packet_size_in_words << 2);
+		} else {
+			new_read_idx -= (qinfo->q_array.mem_size >> 2);
+			memcpy(packet, read_ptr,
+			       (packet_size_in_words - new_read_idx) << 2);
+			memcpy(packet + ((packet_size_in_words -
+					new_read_idx) << 2),
+					(u8 *)qinfo->q_array.align_virtual_addr,
+					new_read_idx << 2);
+		}
+	} else {
+		d_vpr_e("BAD packet received, read_idx: %#x, pkt_size: %d\n",
+			read_idx, packet_size_in_words << 2);
+		d_vpr_e("Dropping this packet\n");
+		new_read_idx = write_idx;
+		rc = -ENODATA;
+	}
+
+	queue->qhdr_rx_req = receive_request;
+
+	queue->qhdr_read_idx = new_read_idx;
+	/*
+	 * mb() to ensure qhdr is updated in main memory
+	 * so that venus reads the updated header values
+	 */
+	mb();
+
+	*pb_tx_req_is_set = (queue->qhdr_tx_req == 1) ? 1 : 0;
+
+	if ((msm_vidc_debug & VIDC_PKT) &&
+	    !(queue->qhdr_type & HFI_Q_ID_CTRL_TO_HOST_DEBUG_Q)) {
+		__dump_packet(packet, __func__, qinfo);
+	}
+
+	return rc;
+}
+
+/* Writes into cmdq without raising an interrupt */
+static int __iface_cmdq_write_relaxed(struct msm_vidc_core *core,
+				      void *pkt, bool *requires_interrupt)
+{
+	struct msm_vidc_iface_q_info *q_info;
+	int rc = -E2BIG;
+
+	rc = __strict_check(core, __func__);
+	if (rc)
+		return rc;
+
+	if (!core_in_valid_state(core)) {
+		d_vpr_e("%s: fw not in init state\n", __func__);
+		rc = -EINVAL;
+		goto err_q_null;
+	}
+
+	q_info = &core->iface_queues[VIDC_IFACEQ_CMDQ_IDX];
+	if (!q_info) {
+		d_vpr_e("cannot write to shared Q's\n");
+		goto err_q_null;
+	}
+
+	if (!q_info->q_array.align_virtual_addr) {
+		d_vpr_e("cannot write to shared CMD Q's\n");
+		rc = -ENODATA;
+		goto err_q_null;
+	}
+
+	if (!__write_queue(q_info, (u8 *)pkt, requires_interrupt))
+		rc = 0;
+	else
+		d_vpr_e("queue full\n");
+
+err_q_null:
+	return rc;
+}
+
+int venus_hfi_queue_cmd_write(struct msm_vidc_core *core, void *pkt)
+{
+	bool needs_interrupt = false;
+	int rc = __iface_cmdq_write_relaxed(core, pkt, &needs_interrupt);
+
+	if (!rc && needs_interrupt)
+		call_iris_op(core, raise_interrupt, core);
+
+	return rc;
+}
+
+int venus_hfi_queue_msg_read(struct msm_vidc_core *core, void *pkt)
+{
+	u32 tx_req_is_set = 0;
+	int rc = 0;
+	struct msm_vidc_iface_q_info *q_info;
+
+	if (!pkt) {
+		d_vpr_e("%s: invalid params\n", __func__);
+		return -EINVAL;
+	}
+
+	if (!core_in_valid_state(core)) {
+		d_vpr_e("%s: fw not in init state\n", __func__);
+		rc = -EINVAL;
+		goto read_error_null;
+	}
+
+	q_info = &core->iface_queues[VIDC_IFACEQ_MSGQ_IDX];
+	if (!q_info->q_array.align_virtual_addr) {
+		d_vpr_e("cannot read from shared MSG Q's\n");
+		rc = -ENODATA;
+		goto read_error_null;
+	}
+
+	if (!__read_queue(q_info, (u8 *)pkt, &tx_req_is_set)) {
+		if (tx_req_is_set) {
+			//call_iris_op(core, raise_interrupt, core);
+			d_vpr_e("%s: queue is full\n", __func__);
+			rc = -EINVAL;
+			goto read_error_null;
+		}
+		rc = 0;
+	} else {
+		rc = -ENODATA;
+	}
+
+read_error_null:
+	return rc;
+}
+
+int venus_hfi_queue_dbg_read(struct msm_vidc_core *core, void *pkt)
+{
+	u32 tx_req_is_set = 0;
+	int rc = 0;
+	struct msm_vidc_iface_q_info *q_info;
+
+	if (!pkt) {
+		d_vpr_e("%s: invalid params\n", __func__);
+		return -EINVAL;
+	}
+
+	q_info = &core->iface_queues[VIDC_IFACEQ_DBGQ_IDX];
+	if (!q_info->q_array.align_virtual_addr) {
+		d_vpr_e("cannot read from shared DBG Q's\n");
+		rc = -ENODATA;
+		goto dbg_error_null;
+	}
+
+	if (!__read_queue(q_info, (u8 *)pkt, &tx_req_is_set)) {
+		if (tx_req_is_set) {
+			d_vpr_e("%s: queue is full\n", __func__);
+			//call_iris_op(core, raise_interrupt, core);
+			rc = -EINVAL;
+			goto dbg_error_null;
+		}
+		rc = 0;
+	} else {
+		rc = -ENODATA;
+	}
+
+dbg_error_null:
+	return rc;
+}
+
+void venus_hfi_queue_deinit(struct msm_vidc_core *core)
+{
+	int i;
+
+	if (!core->iface_q_table.align_virtual_addr) {
+		d_vpr_h("%s: queues already deallocated\n", __func__);
+		return;
+	}
+
+	call_mem_op(core, memory_unmap_free, core, &core->iface_q_table.mem);
+	call_mem_op(core, memory_unmap_free, core, &core->sfr.mem);
+
+	for (i = 0; i < VIDC_IFACEQ_NUMQ; i++) {
+		core->iface_queues[i].q_hdr = NULL;
+		core->iface_queues[i].q_array.align_virtual_addr = NULL;
+		core->iface_queues[i].q_array.align_device_addr = 0;
+	}
+
+	core->iface_q_table.align_virtual_addr = NULL;
+	core->iface_q_table.align_device_addr = 0;
+
+	core->sfr.align_virtual_addr = NULL;
+	core->sfr.align_device_addr = 0;
+}
+
+int venus_hfi_reset_queue_header(struct msm_vidc_core *core)
+{
+	struct msm_vidc_iface_q_info *iface_q;
+	struct hfi_queue_header *q_hdr;
+	int i;
+
+	for (i = 0; i < VIDC_IFACEQ_NUMQ; i++) {
+		iface_q = &core->iface_queues[i];
+		__set_queue_hdr_defaults(iface_q->q_hdr);
+	}
+
+	iface_q = &core->iface_queues[VIDC_IFACEQ_CMDQ_IDX];
+	q_hdr = iface_q->q_hdr;
+	q_hdr->qhdr_start_addr = iface_q->q_array.align_device_addr;
+	q_hdr->qhdr_type |= HFI_Q_ID_HOST_TO_CTRL_CMD_Q;
+
+	iface_q = &core->iface_queues[VIDC_IFACEQ_MSGQ_IDX];
+	q_hdr = iface_q->q_hdr;
+	q_hdr->qhdr_start_addr = iface_q->q_array.align_device_addr;
+	q_hdr->qhdr_type |= HFI_Q_ID_CTRL_TO_HOST_MSG_Q;
+
+	iface_q = &core->iface_queues[VIDC_IFACEQ_DBGQ_IDX];
+	q_hdr = iface_q->q_hdr;
+	q_hdr->qhdr_start_addr = iface_q->q_array.align_device_addr;
+	q_hdr->qhdr_type |= HFI_Q_ID_CTRL_TO_HOST_DEBUG_Q;
+	/*
+	 * Set receive request to zero on debug queue as there is no
+	 * need of interrupt from video hardware for debug messages
+	 */
+	q_hdr->qhdr_rx_req = 0;
+
+	return 0;
+}
+
+int venus_hfi_queue_init(struct msm_vidc_core *core)
+{
+	int rc = 0;
+	struct hfi_queue_table_header *q_tbl_hdr;
+	struct hfi_queue_header *q_hdr;
+	struct msm_vidc_iface_q_info *iface_q;
+	struct msm_vidc_mem mem;
+	int offset = 0;
+	u32 i;
+
+	if (core->iface_q_table.align_virtual_addr) {
+		d_vpr_h("%s: queues already allocated\n", __func__);
+		venus_hfi_reset_queue_header(core);
+		return 0;
+	}
+
+	memset(&mem, 0, sizeof(mem));
+	mem.type = MSM_VIDC_BUF_INTERFACE_QUEUE;
+	mem.region = MSM_VIDC_NON_SECURE;
+	mem.size = TOTAL_QSIZE;
+	mem.secure = false;
+	mem.map_kernel = true;
+	rc = call_mem_op(core, memory_alloc_map, core, &mem);
+	if (rc) {
+		d_vpr_e("%s: alloc and map failed\n", __func__);
+		goto fail_alloc_queue;
+	}
+	core->iface_q_table.align_virtual_addr = mem.kvaddr;
+	core->iface_q_table.align_device_addr = mem.device_addr;
+	core->iface_q_table.mem = mem;
+
+	core->iface_q_table.mem_size = VIDC_IFACEQ_TABLE_SIZE;
+	offset += core->iface_q_table.mem_size;
+
+	for (i = 0; i < VIDC_IFACEQ_NUMQ; i++) {
+		iface_q = &core->iface_queues[i];
+		iface_q->q_array.align_device_addr = mem.device_addr + offset;
+		iface_q->q_array.align_virtual_addr = (void *)((char *)mem.kvaddr + offset);
+		iface_q->q_array.mem_size = VIDC_IFACEQ_QUEUE_SIZE;
+		offset += iface_q->q_array.mem_size;
+		iface_q->q_hdr =
+			VIDC_IFACEQ_GET_QHDR_START_ADDR(core->iface_q_table.align_virtual_addr, i);
+		__set_queue_hdr_defaults(iface_q->q_hdr);
+	}
+
+	q_tbl_hdr = (struct hfi_queue_table_header *)
+			core->iface_q_table.align_virtual_addr;
+	q_tbl_hdr->qtbl_version = 0;
+	q_tbl_hdr->device_addr = (void *)core;
+	strscpy(q_tbl_hdr->name, "msm_v4l2_vidc", sizeof(q_tbl_hdr->name));
+	q_tbl_hdr->qtbl_size = VIDC_IFACEQ_TABLE_SIZE;
+	q_tbl_hdr->qtbl_qhdr0_offset = sizeof(struct hfi_queue_table_header);
+	q_tbl_hdr->qtbl_qhdr_size = sizeof(struct hfi_queue_header);
+	q_tbl_hdr->qtbl_num_q = VIDC_IFACEQ_NUMQ;
+	q_tbl_hdr->qtbl_num_active_q = VIDC_IFACEQ_NUMQ;
+
+	iface_q = &core->iface_queues[VIDC_IFACEQ_CMDQ_IDX];
+	q_hdr = iface_q->q_hdr;
+	q_hdr->qhdr_start_addr = iface_q->q_array.align_device_addr;
+	q_hdr->qhdr_type |= HFI_Q_ID_HOST_TO_CTRL_CMD_Q;
+
+	iface_q = &core->iface_queues[VIDC_IFACEQ_MSGQ_IDX];
+	q_hdr = iface_q->q_hdr;
+	q_hdr->qhdr_start_addr = iface_q->q_array.align_device_addr;
+	q_hdr->qhdr_type |= HFI_Q_ID_CTRL_TO_HOST_MSG_Q;
+
+	iface_q = &core->iface_queues[VIDC_IFACEQ_DBGQ_IDX];
+	q_hdr = iface_q->q_hdr;
+	q_hdr->qhdr_start_addr = iface_q->q_array.align_device_addr;
+	q_hdr->qhdr_type |= HFI_Q_ID_CTRL_TO_HOST_DEBUG_Q;
+	/*
+	 * Set receive request to zero on debug queue as there is no
+	 * need of interrupt from video hardware for debug messages
+	 */
+	q_hdr->qhdr_rx_req = 0;
+
+	/* sfr buffer */
+	memset(&mem, 0, sizeof(mem));
+	mem.type = MSM_VIDC_BUF_INTERFACE_QUEUE;
+	mem.region = MSM_VIDC_NON_SECURE;
+	mem.size = ALIGNED_SFR_SIZE;
+	mem.secure = false;
+	mem.map_kernel = true;
+	rc = call_mem_op(core, memory_alloc_map, core, &mem);
+	if (rc) {
+		d_vpr_e("%s: sfr alloc and map failed\n", __func__);
+		goto fail_alloc_queue;
+	}
+	core->sfr.align_virtual_addr = mem.kvaddr;
+	core->sfr.align_device_addr = mem.device_addr;
+	core->sfr.mem = mem;
+
+	core->sfr.mem_size = ALIGNED_SFR_SIZE;
+	/* write sfr buffer size in first word */
+	*((u32 *)core->sfr.align_virtual_addr) = core->sfr.mem_size;
+
+	return 0;
+
+fail_alloc_queue:
+	return -ENOMEM;
+}
-- 
2.7.4

