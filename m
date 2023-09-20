Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9397A721E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 07:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbjITFeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 01:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjITFd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 01:33:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8137B90;
        Tue, 19 Sep 2023 22:33:53 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38K5NPjN025085;
        Wed, 20 Sep 2023 05:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=3/6AWyd9D4BQks9/JB6+hpqykfLei1uUUZywWvNoP54=;
 b=oVPNR5CHUZFEqyCA+Xm+Y7vKK6jTF9sF5yw6T8S7PtqqgqKTf8sBCN64ObgzH4Zn0Vbd
 Qk590fbbgEG3eUtRKSiszCb1BKdGH5evwkYQ60jbqoXkFDAbHbUT6dzibSbWbzAOa7Q0
 AAa1JODNG4wgH0bOd19woyCPIQdIgFChF3iG5neTqYAKR8l2dz/JULZHNZLxaA+FSTND
 g3cLGvD1B97U8wdr/dLwQXB8IY/XJHWzL12kDYRaG/4jpq34VfVLubA5TE8Kwc9MJz/b
 AHSXcfAC6xK4TS1IDA4ASdbNaNAI7kfSfMoc3vQx4GvaHXAy4qrmTfWouLNTMNOcTknE TA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t746g2k1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 05:33:46 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38K5XjPR030182
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 05:33:45 GMT
Received: from win-platform-upstream01.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 19 Sep 2023 22:33:41 -0700
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
To:     <mani@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <quic_viswanat@quicinc.com>,
        <quic_clew@quicinc.com>, <quic_srichara@quicinc.com>,
        <horms@kernel.org>
Subject: [PATCH V2 net-next 1/2] net: qrtr: Prevent stale ports from sending
Date:   Wed, 20 Sep 2023 11:03:16 +0530
Message-ID: <20230920053317.2165867-2-quic_srichara@quicinc.com>
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
X-Proofpoint-ORIG-GUID: tfuVV2sKRcB5dtVPV02vko5dpcSzoi0V
X-Proofpoint-GUID: tfuVV2sKRcB5dtVPV02vko5dpcSzoi0V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_02,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 spamscore=0 mlxlogscore=999 impostorscore=0 adultscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309200044
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Lew <quic_clew@quicinc.com>

If some client tries to initialize a QRTR socket during QRTR
init, the socket will become stale after the ns(namespace server)
binds to the QRTR control port. The client should close and reopen
the QRTR socket once ENETRESET is posted to the stale socket.

There is a possibility that a client tries to send to the NS before
processing the ENETRESET. In the case of a NEW_SERVER control message,
the control message will reach the NS and be forwarded to the firmware.
The client will then process the ENETRESET closing and re-opening the
socket which triggers a DEL_SERVER and then a second NEW_SERVER.
This scenario will give an unnecessary disconnect to the clients on the
firmware who were able to initialize on the first NEW_SERVER.

This was seen when qrtr-ns was a separate application, but there is
still a potential gap between AF_QIPCRTR socket register and when
qrtr_ns_init binds to the socket where this issue can still occur.

Signed-off-by: Chris Lew <quic_clew@quicinc.com>
Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
---
 [v2]  Added more appropriate commit text,
       Removed a redundant check and fixed local variables
       in reverse-christmas tree order.
       Added 'Chris Lew' Signed-off tag.

 net/qrtr/af_qrtr.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index 41ece61eb57a..e5cf4245c3dc 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -849,6 +849,7 @@ static int qrtr_local_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 			      int type, struct sockaddr_qrtr *from,
 			      struct sockaddr_qrtr *to)
 {
+	struct sock *sk = skb->sk;
 	struct qrtr_sock *ipc;
 	struct qrtr_cb *cb;
 
@@ -860,6 +861,14 @@ static int qrtr_local_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 		return -ENODEV;
 	}
 
+	/* Keep resetting NETRESET until socket is closed */
+	if (sk && sk->sk_err == ENETRESET) {
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
2.34.1

