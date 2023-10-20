Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4EA07D19A8
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 01:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjJTXlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 19:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjJTXlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 19:41:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FEBD51;
        Fri, 20 Oct 2023 16:41:08 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39KLZUkP018479;
        Fri, 20 Oct 2023 23:41:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=bKFZg/LBpXWZUAVfLFf4lWiUNapQ7Gl7Xv4yj0bgCu4=;
 b=wpWTTgpCHWQmuFke7ehdHYwwbIGEEV+vloZwin7o6xyre/7+L7dBa4Hz8FREDi4/fm9S
 7doWa5mYErpYPW3SF2ObUbt/wYlGqaMFqEjFMLGTPgYuE2ho+kaGnyrigTwVFNn6AeQD
 DV0V3S01/PQPzD+RZX5rRGDuvmEtbpKnNBJkEKOoy9nwLh8qs68KHmdeCoT5tQNRV9CB
 b9om/PkdcDb3s0F8Gw17gpthqeaqCTtkra0wgDDxIo70frod0+/aj5SiglSL8ES/Vuex
 +A4nTqT5FlUFhHBjLegM8ZWuRFnuZKVnPDjKnRI5KYtbCMk+i4FxUCO6WvoU0qSe2kCZ ug== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tubw82vgv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Oct 2023 23:41:01 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39KLWMsq014110;
        Fri, 20 Oct 2023 23:41:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tubwfw1gu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Oct 2023 23:41:00 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39KNf06m002147;
        Fri, 20 Oct 2023 23:41:00 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3tubwfw1gd-1;
        Fri, 20 Oct 2023 23:40:59 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, Liam.Howlett@oracle.com,
        netdev@vger.kernel.org, oliver.sang@intel.com, kuba@kernel.org,
        horms@kernel.org, anjali.k.kulkarni@oracle.com
Subject: [PATCH v2] Fix NULL pointer dereference in cn_filter()
Date:   Fri, 20 Oct 2023 16:40:58 -0700
Message-ID: <20231020234058.2232347-1-anjali.k.kulkarni@oracle.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310200202
X-Proofpoint-GUID: CFmDnzAWFB6owU8ti8ggAm50QlMlrWJi
X-Proofpoint-ORIG-GUID: CFmDnzAWFB6owU8ti8ggAm50QlMlrWJi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check that sk_user_data is not NULL, else return from cn_filter().
Could not reproduce this issue, but Oliver Sang verified it has fixed
the "Closes" problem below.

Fixes: 2aa1f7a1f47c ("connector/cn_proc: Add filtering to fix some bugs")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202309201456.84c19e27-oliver.sang@intel.com/
Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
---
 drivers/connector/cn_proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
index 05d562e9c8b1..44b19e696176 100644
--- a/drivers/connector/cn_proc.c
+++ b/drivers/connector/cn_proc.c
@@ -54,7 +54,7 @@ static int cn_filter(struct sock *dsk, struct sk_buff *skb, void *data)
 	enum proc_cn_mcast_op mc_op;
 	uintptr_t val;
 
-	if (!dsk || !data)
+	if (!dsk || !dsk->sk_user_data || !data)
 		return 0;
 
 	ptr = (__u32 *)data;
-- 
2.42.0

