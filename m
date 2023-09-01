Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF9378FBB6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 12:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347208AbjIAKUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 06:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235699AbjIAKUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 06:20:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DFFCEB;
        Fri,  1 Sep 2023 03:20:47 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3818fUdJ014161;
        Fri, 1 Sep 2023 10:20:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=U3Bs5H8kuV22n1PoDOTXN0RH6BI8p/9Akk7DWMSG2E8=;
 b=Pm9uqO1inUUF7koJVyeTsNp+zHsGzcxtW84+joLQ7YVc+po9zLvMJvn1odz4wUREZQvh
 iZZioRq1bMJLsVnd2EDYsWv9z3Z/GtcpPeHdAErtRoyPSrilSaEsCL5Uh6mRSL7DSpE4
 p0jt+8gYl3k6bKahjaJ3vLIB8MPiGDHU4rFwSqrso0vzR7pI+wKrt5rtnAaC0dpd+iIZ
 UHorvBjWN80Jw3NsEET02EH+Q1hJRpRWZB5T14Iow1+SEY0AUYjo94icc8RZyT7KWQ9S
 jAfBqBeDJPFsj3R6Qu6rpvRrU8RCJWidt8H+yINLaZSAGHA90rJmIoyaB4ltioii7xpk rQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3stxru1xsd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 10:20:37 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 381AKb0O007671
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Sep 2023 10:20:37 GMT
Received: from srichara-linux.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 1 Sep 2023 03:20:33 -0700
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
To:     <mani@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <quic_viswanat@quicinc.com>,
        <quic_srichara@quicinc.com>
Subject: [PATCH net-next 1/2] net: qrtr: Prevent stale ports from sending
Date:   Fri, 1 Sep 2023 15:50:20 +0530
Message-ID: <1693563621-1920-2-git-send-email-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1693563621-1920-1-git-send-email-quic_srichara@quicinc.com>
References: <1693563621-1920-1-git-send-email-quic_srichara@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TJPJRHlKPvpdYKqIFJ-a-UYCd8-KIVFw
X-Proofpoint-ORIG-GUID: TJPJRHlKPvpdYKqIFJ-a-UYCd8-KIVFw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_07,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 mlxlogscore=630 mlxscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309010096
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vignesh Viswanathan <quic_viswanat@quicinc.com>

If qrtr and some other process try to bind to the QMI Control port at
the same time, NEW_SERVER might come before ENETRESET is given to the
socket. This might cause a socket down/up when ENETRESET is received as
per the protocol and this triggers a DEL_SERVER and a second NEW_SERVER.

In order to prevent such messages from stale sockets being sent, check
if ENETRESET has been set on the socket and drop the packet.

Signed-off-by: Chris Lew <quic_clew@quicinc.com>
Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>
---
 net/qrtr/af_qrtr.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index 41ece61..26197a0 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -851,6 +851,7 @@ static int qrtr_local_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 {
 	struct qrtr_sock *ipc;
 	struct qrtr_cb *cb;
+	struct sock *sk = skb->sk;
 
 	ipc = qrtr_port_lookup(to->sq_port);
 	if (!ipc || &ipc->sk == skb->sk) { /* do not send to self */
@@ -860,6 +861,15 @@ static int qrtr_local_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 		return -ENODEV;
 	}
 
+	/* Keep resetting NETRESET until socket is closed */
+	if (sk && sk->sk_err == ENETRESET) {
+		sk->sk_err = ENETRESET;
+		sk_error_report(sk);
+		qrtr_port_put(ipc);
+		kfree_skb(skb);
+		return 0;
+	}
+
 	cb = (struct qrtr_cb *)skb->cb;
 	cb->src_node = from->sq_node;
 	cb->src_port = from->sq_port;
-- 
2.7.4

