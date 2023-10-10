Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76447C42AA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343883AbjJJVgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343936AbjJJVgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:36:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A014294;
        Tue, 10 Oct 2023 14:35:58 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39AJiDtW025689;
        Tue, 10 Oct 2023 21:35:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=dICtayujaDLXxBVyN4pCkVIs4d2R84yHSjMED1WJ9Yk=;
 b=cL5d3HTU5aUQabgA7jlvyhz1NmTyr3h4gUoGq5lcNIB+gU/+gcN+eglkyEY5Mqh+oUCz
 8rgOITE+FxRdOiLErAAzjBTgguhljVUNx9AISK/R8MMKNXivI5nJ3EZM9IC16b3hhGE+
 bZ1dO5cH9bW4cbeEv8Sgpa1xfueR/+EQsuurgX5TxCKqLCmwCvmPLg5TUE9sdcNIN0zs
 kZnP7G77ECeZT4erwzc3MUtCYNdFFR30ad/Jw24rqhU8N3rWPNNBRtO8tmytHkMkXZyY
 Cu5bQ/Np2/hv8EKqI8ZxIimDaUv3q5bfrW3jUy7KGVWZg7SoapBN0TbVuNDhszGJ6lBB YQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tmh89uvms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 21:35:51 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39AKGrDu016249;
        Tue, 10 Oct 2023 21:35:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws7hxhv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 21:35:50 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39ALZoqA036182;
        Tue, 10 Oct 2023 21:35:50 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3tjws7hxhd-1;
        Tue, 10 Oct 2023 21:35:50 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, Liam.Howlett@oracle.com,
        netdev@vger.kernel.org, oliver.sang@intel.com, kuba@kernel.org,
        anjali.k.kulkarni@oracle.com
Subject: [PATCH v1] Bug fix for issue found by kernel test robot
Date:   Tue, 10 Oct 2023 14:35:49 -0700
Message-ID: <20231010213549.3662003-1-anjali.k.kulkarni@oracle.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_17,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310100167
X-Proofpoint-GUID: Z8fvfdgWeJ36H0ZF6NyiWuTcW8dUc4VO
X-Proofpoint-ORIG-GUID: Z8fvfdgWeJ36H0ZF6NyiWuTcW8dUc4VO
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cn_netlink_send_mult() should be called with filter & filter_data only
for EXIT case. For all other events, filter & filter_data should be
NULL.

Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
---
 drivers/connector/cn_proc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
index 05d562e9c8b1..01e17f18d187 100644
--- a/drivers/connector/cn_proc.c
+++ b/drivers/connector/cn_proc.c
@@ -104,13 +104,13 @@ static inline void send_msg(struct cn_msg *msg)
 	if (filter_data[0] == PROC_EVENT_EXIT) {
 		filter_data[1] =
 		((struct proc_event *)msg->data)->event_data.exit.exit_code;
+		cn_netlink_send_mult(msg, msg->len, 0, CN_IDX_PROC, GFP_NOWAIT,
+				     cn_filter, (void *)filter_data);
 	} else {
-		filter_data[1] = 0;
+		cn_netlink_send_mult(msg, msg->len, 0, CN_IDX_PROC, GFP_NOWAIT,
+				     NULL, NULL);
 	}
 
-	cn_netlink_send_mult(msg, msg->len, 0, CN_IDX_PROC, GFP_NOWAIT,
-			     cn_filter, (void *)filter_data);
-
 	local_unlock(&local_event.lock);
 }
 
-- 
2.42.0

