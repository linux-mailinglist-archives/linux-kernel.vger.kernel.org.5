Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E1A7C9111
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 00:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjJMW4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 18:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJMW42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 18:56:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D538AB7;
        Fri, 13 Oct 2023 15:56:26 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39DLJNgG017941;
        Fri, 13 Oct 2023 22:56:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=tIv8PKWqTNvf7LEb9nHTdGBuAH32pLXCPsbisyTQ9h8=;
 b=FGC7gDXDIKQOgVqzozCMJCCPtZCS+Aq+iBD/z/VAiIDqyOOI9t+QVu6yI95XR3Zx8ZMy
 YovccVIDVSQyY/UVNEQ9nbwQkz0PDzp/z/j+0108StqdtwQzNSSRQ0NAi1V64f4bDn0e
 Y0ZH8f8lQrGNP6ZsXKdWZji5UfLyf84NLc7sC4TShdQ/MMYPheq9D9TsPm7WRdnuPLpA
 N/vOeAHz6L7r5Om09xUlvVIV3xoPl1zLpeVO7Awywg17AJDtKGZXv8NOG11+jRzBrbV/
 kvMU8w7ylZW5+UQIjfPcXDLZ9P4BXnoPRwAFthXhSsUDbLWQCM1DHWn1dXv1gIyWPQ7P DA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjyvux1mj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 22:56:22 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39DL8isA006017;
        Fri, 13 Oct 2023 22:56:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tptct2ukk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 22:56:22 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39DMuL2a028304;
        Fri, 13 Oct 2023 22:56:21 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3tptct2uk4-1;
        Fri, 13 Oct 2023 22:56:21 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, Liam.Howlett@oracle.com,
        netdev@vger.kernel.org, oliver.sang@intel.com, kuba@kernel.org,
        horms@kernel.org, anjali.k.kulkarni@oracle.com
Subject: [PATCH v1] Fix NULL pointer dereference in cn_filter()
Date:   Fri, 13 Oct 2023 15:56:19 -0700
Message-ID: <20231013225619.987912-1-anjali.k.kulkarni@oracle.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_12,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130199
X-Proofpoint-ORIG-GUID: hT7UL-RIcTeRO0UK7AxwyczkJvQ660aN
X-Proofpoint-GUID: hT7UL-RIcTeRO0UK7AxwyczkJvQ660aN
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

Fixes: 2aa1f7a1f47c ("connector/cn_proc: Add filtering to fix some bugs")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202309201456.84c19e27-oliver.sang@intel.com/
Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
---
 drivers/connector/cn_proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
index 05d562e9c8b1..a8e55569e4f5 100644
--- a/drivers/connector/cn_proc.c
+++ b/drivers/connector/cn_proc.c
@@ -54,7 +54,7 @@ static int cn_filter(struct sock *dsk, struct sk_buff *skb, void *data)
 	enum proc_cn_mcast_op mc_op;
 	uintptr_t val;
 
-	if (!dsk || !data)
+	if (!dsk || !data || !dsk->sk_user_data)
 		return 0;
 
 	ptr = (__u32 *)data;
-- 
2.42.0

