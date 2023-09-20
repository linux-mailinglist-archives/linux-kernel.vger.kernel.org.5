Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6120B7A7220
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 07:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbjITFeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 01:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjITFeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 01:34:06 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC26F9;
        Tue, 19 Sep 2023 22:33:59 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38K5FrRB019545;
        Wed, 20 Sep 2023 05:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=FBgh+dJFYguUNefiP9rXZmscBiqcyLxcjTUSXBdu1rc=;
 b=WOAe+h9EVmdGQeY6otYYCJc9NbVlYR5VLdhUVc2B//UNZY3c/607FBvFx4U+NFZWYofi
 WYZ9nXbzOVvbSG1YPkiE3IvfcbWBsDp6+yq6wYkY4hWRbJVEsYuVXhUsQuzmty3qeujh
 UlsPeVmYQNsEuK3L9hYbag20A6ZKLtS1id8D9OddJDXOuu8mIxrFGFub6lZsISDKz1Yn
 vMeFKRrVEhDmZhxfbd2Rooy9D6skUiuXqvQxfIdy6ZZ280GL6Bi0JZ4BAcQULq3YeEhz
 31872RWD+FbNbPsCnJm9oUfi+GTDi1+TJI4olCSl1wQwBepbyrRY0Kutg2v008E16hEY NA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t7s2r04un-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 05:33:52 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38K5XpS1031641
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 05:33:51 GMT
Received: from win-platform-upstream01.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 19 Sep 2023 22:33:46 -0700
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
To:     <mani@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <quic_viswanat@quicinc.com>,
        <quic_clew@quicinc.com>, <quic_srichara@quicinc.com>,
        <horms@kernel.org>
Subject: [PATCH V2 net-next 2/2] net: qrtr: Add support for processing DEL_PROC type control message
Date:   Wed, 20 Sep 2023 11:03:17 +0530
Message-ID: <20230920053317.2165867-3-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920053317.2165867-1-quic_srichara@quicinc.com>
References: <20230920053317.2165867-1-quic_srichara@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KolGVwauzFZ8bna057osGtk0ttPMwoQC
X-Proofpoint-ORIG-GUID: KolGVwauzFZ8bna057osGtk0ttPMwoQC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_02,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 mlxscore=0 adultscore=0 mlxlogscore=740 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309200044
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For certain rproc's like modem, when it goes down and endpoint gets
un-registered, DEL_PROC control message gets forwarded to other
remote nodes. So remote nodes should listen on the message,
wakeup all local waiters waiting for tx_resume notifications
(which will never come) and also forward the message to all
local qrtr sockets like QMI etc. Adding the support here.

Introduced a new rx worker here, because endpoint_post can get called in
atomic contexts, but processing of DEL_PROC needs to acquire node
qrtr_tx mutex.

Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
---
  [v2] Fixed a sparse warning.

 include/uapi/linux/qrtr.h |  1 +
 net/qrtr/af_qrtr.c        | 65 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/include/uapi/linux/qrtr.h b/include/uapi/linux/qrtr.h
index f7e2fb3d752b..1c920159d610 100644
--- a/include/uapi/linux/qrtr.h
+++ b/include/uapi/linux/qrtr.h
@@ -26,6 +26,7 @@ enum qrtr_pkt_type {
 	QRTR_TYPE_PING          = 9,
 	QRTR_TYPE_NEW_LOOKUP	= 10,
 	QRTR_TYPE_DEL_LOOKUP	= 11,
+	QRTR_TYPE_DEL_PROC	= 13,
 };
 
 struct qrtr_ctrl_pkt {
diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index e5cf4245c3dc..016b946f308b 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2015, Sony Mobile Communications Inc.
  * Copyright (c) 2013, The Linux Foundation. All rights reserved.
  */
+#include <linux/kthread.h>
 #include <linux/module.h>
 #include <linux/netlink.h>
 #include <linux/qrtr.h>
@@ -122,6 +123,9 @@ static DEFINE_XARRAY_ALLOC(qrtr_ports);
  * @qrtr_tx_lock: lock for qrtr_tx_flow inserts
  * @rx_queue: receive queue
  * @item: list item for broadcast list
+ * @kworker: worker thread for recv work
+ * @task: task to run the worker thread
+ * @read_data: scheduled work for recv work
  */
 struct qrtr_node {
 	struct mutex ep_lock;
@@ -134,6 +138,9 @@ struct qrtr_node {
 
 	struct sk_buff_head rx_queue;
 	struct list_head item;
+	struct kthread_worker kworker;
+	struct task_struct *task;
+	struct kthread_work read_data;
 };
 
 /**
@@ -186,6 +193,9 @@ static void __qrtr_node_release(struct kref *kref)
 	list_del(&node->item);
 	mutex_unlock(&qrtr_node_lock);
 
+	kthread_flush_worker(&node->kworker);
+	kthread_stop(node->task);
+
 	skb_queue_purge(&node->rx_queue);
 
 	/* Free tx flow counters */
@@ -526,6 +536,9 @@ int qrtr_endpoint_post(struct qrtr_endpoint *ep, const void *data, size_t len)
 
 	if (cb->type == QRTR_TYPE_RESUME_TX) {
 		qrtr_tx_resume(node, skb);
+	} else if (cb->type == QRTR_TYPE_DEL_PROC) {
+		skb_queue_tail(&node->rx_queue, skb);
+		kthread_queue_work(&node->kworker, &node->read_data);
 	} else {
 		ipc = qrtr_port_lookup(cb->dst_port);
 		if (!ipc)
@@ -574,6 +587,50 @@ static struct sk_buff *qrtr_alloc_ctrl_packet(struct qrtr_ctrl_pkt **pkt,
 	return skb;
 }
 
+/* Handle DEL_PROC control message */
+static void qrtr_node_rx_work(struct kthread_work *work)
+{
+	struct qrtr_node *node = container_of(work, struct qrtr_node,
+					      read_data);
+	struct radix_tree_iter iter;
+	struct qrtr_tx_flow *flow;
+	struct qrtr_ctrl_pkt *pkt;
+	struct qrtr_sock *ipc;
+	struct sk_buff *skb;
+	void __rcu **slot;
+
+	while ((skb = skb_dequeue(&node->rx_queue)) != NULL) {
+		struct qrtr_cb *cb = (struct qrtr_cb *)skb->cb;
+
+		ipc = qrtr_port_lookup(cb->dst_port);
+		if (!ipc) {
+			kfree_skb(skb);
+			continue;
+		}
+
+		if (cb->type == QRTR_TYPE_DEL_PROC) {
+			/* Free tx flow counters */
+			mutex_lock(&node->qrtr_tx_lock);
+			radix_tree_for_each_slot(slot, &node->qrtr_tx_flow, &iter, 0) {
+				flow = rcu_dereference_raw(*slot);
+				wake_up_interruptible_all(&flow->resume_tx);
+			}
+			mutex_unlock(&node->qrtr_tx_lock);
+
+			/* Translate DEL_PROC to BYE for local enqueue */
+			cb->type = QRTR_TYPE_BYE;
+			pkt = (struct qrtr_ctrl_pkt *)skb->data;
+			memset(pkt, 0, sizeof(*pkt));
+			pkt->cmd = cpu_to_le32(QRTR_TYPE_BYE);
+
+			if (sock_queue_rcv_skb(&ipc->sk, skb))
+				kfree_skb(skb);
+
+			qrtr_port_put(ipc);
+		}
+	}
+}
+
 /**
  * qrtr_endpoint_register() - register a new endpoint
  * @ep: endpoint to register
@@ -599,6 +656,14 @@ int qrtr_endpoint_register(struct qrtr_endpoint *ep, unsigned int nid)
 	node->nid = QRTR_EP_NID_AUTO;
 	node->ep = ep;
 
+	kthread_init_work(&node->read_data, qrtr_node_rx_work);
+	kthread_init_worker(&node->kworker);
+	node->task = kthread_run(kthread_worker_fn, &node->kworker, "qrtr_rx");
+	if (IS_ERR(node->task)) {
+		kfree(node);
+		return -ENOMEM;
+	}
+
 	INIT_RADIX_TREE(&node->qrtr_tx_flow, GFP_KERNEL);
 	mutex_init(&node->qrtr_tx_lock);
 
-- 
2.34.1

