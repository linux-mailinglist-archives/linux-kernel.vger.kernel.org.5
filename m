Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366797604AF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 03:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjGYBaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 21:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjGYBaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 21:30:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529F0170E;
        Mon, 24 Jul 2023 18:30:00 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P1R3M9024405;
        Tue, 25 Jul 2023 01:29:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Ik3HKh+Kru5gM57JiciWemSCJFTdi1XMiHqM9Rjrv5g=;
 b=BjNf1NvxaCq0scz5iAtd2C4fkQxFz/Ij8TAnks33HW8aDMTrdm4cEbRL7ilnwJacAfTU
 EC2CPcbB/v5H3tmbIAi5P4pPBfLH75YBP+BwPcdhsniCUsClcNW9aJnIyDakfNyaKK3R
 gJWbYlnMsLIl8hyEyOEmgg6vEVdWlKlM10ss0QK6r7wy4R576NxN6JxcWjrhp9YuNzx5
 xFuMsXEp6ZScXxZpxKmJopCSBFoQx5ruk5j3SC0q73UNaAY6VVm+fMAOLqRS3dIjg3LJ
 7jGXl337rsX3dJTkVvQX0pppC/aX6dgasQHweCMy4njhXYFB8biqeA60GcpZ9Ul7a+g6 Jg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1qasst3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 01:29:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36P1TsSR020192
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 01:29:54 GMT
Received: from hu-mdtipton-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 24 Jul 2023 18:29:54 -0700
From:   Mike Tipton <quic_mdtipton@quicinc.com>
To:     <djakov@kernel.org>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_okukatla@quicinc.com>, <quic_viveka@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>
Subject: [PATCH 1/3] debugfs: Add write support to debugfs_create_str()
Date:   Mon, 24 Jul 2023 18:28:57 -0700
Message-ID: <20230725012859.18474-2-quic_mdtipton@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230725012859.18474-1-quic_mdtipton@quicinc.com>
References: <20230725012859.18474-1-quic_mdtipton@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1hVtMj2GUYVL2vPs0yLNVPjjYOq6T_PD
X-Proofpoint-GUID: 1hVtMj2GUYVL2vPs0yLNVPjjYOq6T_PD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_18,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=671 adultscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307250010
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implementation taken from original patch series that added
debugfs_create_str() [0]. Write support was present in the initial patch
revisions, but was later removed due to lack of users. We have a user
now, so reintroduce it.

[0] https://lore.kernel.org/all/YF3Hv5zXb%2F6lauzs@hirez.programming.kicks-ass.net/

Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>
---
 fs/debugfs/file.c | 48 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index b7711888dd17..87b3753aa4b1 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -904,8 +904,52 @@ EXPORT_SYMBOL_GPL(debugfs_create_str);
 static ssize_t debugfs_write_file_str(struct file *file, const char __user *user_buf,
 				      size_t count, loff_t *ppos)
 {
-	/* This is really only for read-only strings */
-	return -EINVAL;
+	struct dentry *dentry = F_DENTRY(file);
+	char *old, *new = NULL;
+	int pos = *ppos;
+	int r;
+
+	r = debugfs_file_get(dentry);
+	if (unlikely(r))
+		return r;
+
+	old = *(char **)file->private_data;
+
+	/* only allow strict concatenation */
+	r = -EINVAL;
+	if (pos && pos != strlen(old))
+		goto error;
+
+	r = -E2BIG;
+	if (pos + count + 1 > PAGE_SIZE)
+		goto error;
+
+	r = -ENOMEM;
+	new = kmalloc(pos + count + 1, GFP_KERNEL);
+	if (!new)
+		goto error;
+
+	if (pos)
+		memcpy(new, old, pos);
+
+	r = -EFAULT;
+	if (copy_from_user(new + pos, user_buf, count))
+		goto error;
+
+	new[pos + count] = '\0';
+	strim(new);
+
+	rcu_assign_pointer(*(char **)file->private_data, new);
+	synchronize_rcu();
+	kfree(old);
+
+	debugfs_file_put(dentry);
+	return count;
+
+error:
+	kfree(new);
+	debugfs_file_put(dentry);
+	return r;
 }
 
 static const struct file_operations fops_str = {
-- 
2.17.1

