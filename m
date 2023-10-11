Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96CC7C4916
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 07:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjJKFMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 01:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjJKFMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 01:12:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380BA8E;
        Tue, 10 Oct 2023 22:12:34 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39AJiKqY011857;
        Wed, 11 Oct 2023 05:12:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=mF3Vt9Zpfj/YFdxqizp/kX/D6C+yZJy3bxN+IekzmK0=;
 b=Q95GMkXIwn3yewwnbhg2g6SnMk/3/uMPa52ZBZJkyiLMD12znZqqNpewycSWDIFrlupe
 hojB18K7HLe9FHaGd8sdMDF7Uj6LSYTrfWY88/JO/VCxt83LkBpg/Cmwgwv41AOdhH0i
 KTIYql7YJHa8DkhRksuOGRl9Wu6diV8gCLezX+harqtssGiqjWZ3tdkyNbgAZ7qgHjDl
 HT2DiRM+B/YlkUeZXYQv36gaq5qteejPNSch8xoZFwzfIoRJ59+62VMjpoHa6V1JVoSb
 ckFP03EoN60wDlhEeABLH4zxP6d9ejMfTCXyBBy1QMonO7qQpjc1V8pOvuo6o0YebR4J Cw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjwx26ypm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Oct 2023 05:12:32 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39B2Kllh013616;
        Wed, 11 Oct 2023 05:12:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws7rqyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Oct 2023 05:12:31 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39B586FM037251;
        Wed, 11 Oct 2023 05:12:30 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3tjws7rqw7-1;
        Wed, 11 Oct 2023 05:12:30 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, Liam.Howlett@oracle.com,
        netdev@vger.kernel.org, oliver.sang@intel.com,
        anjali.k.kulkarni@oracle.com
Subject: [PATCH v2] Fix NULL pointer deref due to filtering on fork
Date:   Tue, 10 Oct 2023 22:12:25 -0700
Message-ID: <20231011051225.3674436-1-anjali.k.kulkarni@oracle.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_02,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110046
X-Proofpoint-GUID: OT-Co-kg_-3ysWNwYZ1uMVenEajsw74U
X-Proofpoint-ORIG-GUID: OT-Co-kg_-3ysWNwYZ1uMVenEajsw74U
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cn_netlink_send_mult() should be called with filter & filter_data only
for EXIT case. For all other events, filter & filter_data should be
NULL.

Fixes: 2aa1f7a1f47c ("connector/cn_proc: Add filtering to fix some bugs")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://urldefense.com/v3/__https://lore.kernel.org/oe-lkp/202309201456.84c19e27-oliver.sang@intel.com__;!!ACWV5N9M2RV99hQ!PgqlHq_nOe_KlyKkB9Mm_S8QstTJvicjuENwskatuuQK05KPuFw-KvRZeOH8iuEAMjRhkxEMPKJJnLcaT8zrPf9aqNs$

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

