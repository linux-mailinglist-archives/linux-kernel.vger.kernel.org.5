Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CAC7727C3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbjHGOaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbjHGOaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:30:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAA7F0;
        Mon,  7 Aug 2023 07:30:07 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 377Cdb0t021960;
        Mon, 7 Aug 2023 14:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=1SexRd3xlFPruhYV9RcOM8lB8ZoFnhXy4eJIe3MFfPY=;
 b=fci8X06AIxGq6qlIHbTmMaezJn4bXSkJiOBwi3HOIK6PUXX7WwVzzoKC1EAq45kIsDdV
 /9Hzdb2zQLrO7XwGfvg23tHFg77OITdSMCbJF9WWUTue3fmVKFnTQXRtQCF/uOLPBGWd
 pfshUhJ7lxYDFu9/MCar+WElCGNV/7UgddwyXHgRFAKoSCjr9kJsecFDyEM4EzHYUSuC
 wd8WgxRmsEzcb2ds81gD7/1F2oXt+Y8R83dPpIceRzZz++I+5fMerZ8ofjklNBqjmcwd
 671EmfHNGL9WF21nmcoDBEaKMXyXKXfveWckrYgCR7EFzvPUfMkgWIB4Q2gHpACBe+HL bA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3saxbbrghj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 14:29:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 377ETtgR016619
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 7 Aug 2023 14:29:55 GMT
Received: from hu-mdtipton-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 7 Aug 2023 07:29:55 -0700
From:   Mike Tipton <quic_mdtipton@quicinc.com>
To:     <djakov@kernel.org>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <corbet@lwn.net>
CC:     <linux-pm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_okukatla@quicinc.com>, <quic_viveka@quicinc.com>,
        <peterz@infradead.org>, <quic_pkondeti@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>
Subject: [PATCH v3 1/3] debugfs: Add write support to debugfs_create_str()
Date:   Mon, 7 Aug 2023 07:29:12 -0700
Message-ID: <20230807142914.12480-2-quic_mdtipton@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230807142914.12480-1-quic_mdtipton@quicinc.com>
References: <20230807142914.12480-1-quic_mdtipton@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WM5_ce7_ggorvHKcaly49Gy-DDjSXgnc
X-Proofpoint-GUID: WM5_ce7_ggorvHKcaly49Gy-DDjSXgnc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_15,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=657 bulkscore=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070134
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, debugfs_create_str() only supports reading strings from
debugfs. Add support for writing them as well.

Based on original implementation by Peter Zijlstra [0]. Write support
was present in the initial patch version, but dropped in v2 due to lack
of users. We have a user now, so reintroduce it.

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

