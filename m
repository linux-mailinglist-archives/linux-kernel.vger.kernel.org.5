Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9CD75319D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 07:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbjGNF7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 01:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbjGNF7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:59:30 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746FC2D4B;
        Thu, 13 Jul 2023 22:59:29 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36E4hiFq010162;
        Fri, 14 Jul 2023 05:59:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=4V6PabsTD743AVM7/i0irVzfSDXf6+mOjdWKUlKl+sE=;
 b=hbZFrnZfTyqAVCB2NqLhPEBMr0gyyt0aOvJokmRfBOPfc2VWwrvCh0T6rEmBgfmT2YDs
 9DfQnTKn+c59y4jfdVnosrKLoNh7ahomi7Er580/gSVs3GJHdxiR1+tMneNiyLY636mw
 RWndDjR6aa/1CyScVpMqUzBSke3T32XeCofiSLUIB9vwrjcyKfbDkzt86uq7ogW+Q0rX
 bMXKyo5juonMnff6tK8Fi3ZHEHJQnlqNNqkQJAtBnJcwHrOzs9KTMq1Z6a/O3BxDFf87
 mQQ4q7uKfGEndevh+uQqORzlrXAAXqvqYoCajGeC8H16tymucKT7yGLm4WQnN8HfPmtW Iw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtptxh0bv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 05:59:21 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36E5xLR5027059
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 05:59:21 GMT
Received: from hu-viswanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 13 Jul 2023 22:59:15 -0700
From:   Vignesh Viswanathan <quic_viswanat@quicinc.com>
To:     <mani@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>,
        <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_clew@quicinc.com>,
        Vignesh Viswanathan <quic_viswanat@quicinc.com>,
        Simon Horman <simon.horman@corigine.com>
Subject: [PATCH V2 net-next 2/3] net: qrtr: ns: Change nodes radix tree to xarray
Date:   Fri, 14 Jul 2023 11:28:45 +0530
Message-ID: <20230714055846.1481015-3-quic_viswanat@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714055846.1481015-1-quic_viswanat@quicinc.com>
References: <20230714055846.1481015-1-quic_viswanat@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: I6C_sCFiXEixFJr6H4mJsprZ0uaebvzL
X-Proofpoint-ORIG-GUID: I6C_sCFiXEixFJr6H4mJsprZ0uaebvzL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_02,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=784
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140055
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a use after free scenario while iterating through the nodes
radix tree despite the ns being a single threaded process. This can
happen when the radix tree APIs are not synchronized with the
rcu_read_lock() APIs.

Convert the radix tree for nodes to xarray to take advantage of the
built in rcu lock usage provided by xarray.

Signed-off-by: Chris Lew <quic_clew@quicinc.com>
Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
---
 net/qrtr/ns.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index af28d9e6b53f..b1db0b519179 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -16,7 +16,7 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/qrtr.h>
 
-static RADIX_TREE(nodes, GFP_KERNEL);
+static DEFINE_XARRAY(nodes);
 
 static struct {
 	struct socket *sock;
@@ -73,7 +73,7 @@ static struct qrtr_node *node_get(unsigned int node_id)
 {
 	struct qrtr_node *node;
 
-	node = radix_tree_lookup(&nodes, node_id);
+	node = xa_load(&nodes, node_id);
 	if (node)
 		return node;
 
@@ -85,7 +85,7 @@ static struct qrtr_node *node_get(unsigned int node_id)
 	node->id = node_id;
 	xa_init(&node->servers);
 
-	if (radix_tree_insert(&nodes, node_id, node)) {
+	if (xa_store(&nodes, node_id, node, GFP_KERNEL)) {
 		kfree(node);
 		return NULL;
 	}
-- 
2.41.0

