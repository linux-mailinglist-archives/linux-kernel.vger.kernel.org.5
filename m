Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090B07AB2F4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 15:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbjIVNqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 09:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234195AbjIVNql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 09:46:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222161A5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 06:46:33 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38MCgNED013479;
        Fri, 22 Sep 2023 13:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=db39VYakgmUfFpH05krLx+JmYMalIx2yb9gyi4YFUno=;
 b=L83C84q7t2I+3I9gMW3yE1n/3s5vMoeik4XVYhrqH6kvE1vyUFlJqPW+juDk/a3wa31d
 gjz5hbV2/zKG1KudjcG0WwQDa7GBc5s/exjDJjYU9nFwDkuT5WCXDLOuPEj1ekiCeJk4
 2PplHVzYXjFdGgvUvavWsGtIh4mLS1Bhir4iuAe3LO58uP7c6Bvqv5ke7toBoas1iqQH
 Lv3AjADO5/Nk/BDf3jd4qEsWpMyBW68BmvAGUZ0AbTWCP0isaa4n9iQ6sBT06h9noTb0
 rP+ln21Uezm29NwfqHfeL3dVLvcgLHYTbZ7fALJS0EKW7faETso0A7biPp5UNOjJqc11 7w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t8uf2hvj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 13:46:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38MDkAIK014602
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 13:46:10 GMT
Received: from hu-mdtipton-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 22 Sep 2023 06:46:10 -0700
From:   Mike Tipton <quic_mdtipton@quicinc.com>
To:     <gregkh@linuxfoundation.org>
CC:     <rafael@kernel.org>, <djakov@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>
Subject: [PATCH] debugfs: Fix __rcu type comparison warning
Date:   Fri, 22 Sep 2023 06:45:12 -0700
Message-ID: <20230922134512.5126-1-quic_mdtipton@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aOJ8eVImVMzroRHC-32FlmSZ24QpqqZt
X-Proofpoint-ORIG-GUID: aOJ8eVImVMzroRHC-32FlmSZ24QpqqZt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_11,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 mlxlogscore=584 mlxscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309220118
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports the following:

fs/debugfs/file.c:942:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
fs/debugfs/file.c:942:9: sparse:    char [noderef] __rcu *
fs/debugfs/file.c:942:9: sparse:    char *

rcu_assign_pointer() expects that it's assigning to pointers annotated
with __rcu. We can't annotate the generic struct file::private_data, so
cast it instead.

Fixes: 86b5488121db ("debugfs: Add write support to debugfs_create_str()")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309091933.BRWlSnCq-lkp@intel.com/
Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>
---
 fs/debugfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 87b3753aa4b1..c45e8c2d62e1 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -939,7 +939,7 @@ static ssize_t debugfs_write_file_str(struct file *file, const char __user *user
 	new[pos + count] = '\0';
 	strim(new);
 
-	rcu_assign_pointer(*(char **)file->private_data, new);
+	rcu_assign_pointer(*(char __rcu **)file->private_data, new);
 	synchronize_rcu();
 	kfree(old);
 
-- 
2.17.1

