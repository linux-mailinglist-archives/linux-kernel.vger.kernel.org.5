Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88F77604B4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 03:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjGYBaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 21:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjGYBaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 21:30:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4940E1725;
        Mon, 24 Jul 2023 18:30:01 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P1Euif016206;
        Tue, 25 Jul 2023 01:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Xkozn2CWJhEy32yQtsQoejY27zxVajpqWvHl4aCy/+o=;
 b=DFQastABxnxaHEICLrzSRwH3aqX8UxKxb8ZsfkO4qXsEGWnDkZGUx9csdLXgVQJ1dC05
 7TvHy6ckUvHj1KAvtMUXQKgCyOb/S2CcFvYCD+CUUiWTEqiamoNXFfXeZ9iwQ7rPVE9Q
 mvl1OG7NsaD4Bohk7Fc60iTkKyYyNuF2kpZKQiipdvba2ppeTeLY6gFQzXubMxr5Gttn
 lJWOqseWhmdcj3lYeDr1zdmnh3iy35V3HqL68gn3yTHbzT+hGZYEfJ95YgDnaxfcFzHs
 MWEZkJwfTQi6oADptDV4F2VrvYBkxecvmE8+nCyQUuWIDGmKpFLYOngXZr2HxBmksxX9 1Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1qa3srep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 01:29:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36P1Ttfc024726
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 01:29:55 GMT
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
Subject: [PATCH 3/3] interconnect: Add debugfs test client
Date:   Mon, 24 Jul 2023 18:28:59 -0700
Message-ID: <20230725012859.18474-4-quic_mdtipton@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 0DZS3F8_j3lUwe7t1w8YSs-jFnZi_09C
X-Proofpoint-GUID: 0DZS3F8_j3lUwe7t1w8YSs-jFnZi_09C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_18,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250010
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's often useful during test, debug, and development to issue path
votes from shell. Add a debugfs client for this purpose.

Example usage:
	cd /sys/kernel/debug/interconnect/test-client/

	# Configure node endpoints for the path from CPU to DDR on
	# qcom/sm8550.
	echo chm_apps > src_node
	echo ebi > dst_node

	# Get path between src_node and dst_node. This is only
	# necessary after updating the node endpoints.
	echo 1 > get

	# Set desired BW to 1GBps avg and 2GBps peak.
	echo 1000000 > avg_bw
	echo 2000000 > peak_bw

	# Vote for avg_bw and peak_bw on the latest path from "get".
	# Voting for multiple paths is possible by repeating this
	# process for different nodes endpoints.
	echo 1 > commit

Allowing userspace to directly enable and set bus rates can be dangerous
So, following in the footsteps of the regmap [0] and clk [1] frameworks,
keep these userspace controls compile-time disabled without Kconfig
options to enable them. Enabling this will require code changes to
define INTERCONNECT_ALLOW_WRITE_DEBUGFS.

[0] commit 09c6ecd39410 ("regmap: Add support for writing to regmap registers via debugfs")
[1] commit 37215da5553e ("clk: Add support for setting clk_rate via debugfs")

Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>
---
 drivers/interconnect/Makefile         |   2 +-
 drivers/interconnect/core.c           |   3 +
 drivers/interconnect/debugfs-client.c | 156 ++++++++++++++++++++++++++
 drivers/interconnect/internal.h       |   2 +
 4 files changed, 162 insertions(+), 1 deletion(-)
 create mode 100644 drivers/interconnect/debugfs-client.c

diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
index 5604ce351a9f..d0888babb9a1 100644
--- a/drivers/interconnect/Makefile
+++ b/drivers/interconnect/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 CFLAGS_core.o				:= -I$(src)
-icc-core-objs				:= core.o bulk.o
+icc-core-objs				:= core.o bulk.o debugfs-client.o
 
 obj-$(CONFIG_INTERCONNECT)		+= icc-core.o
 obj-$(CONFIG_INTERCONNECT_IMX)		+= imx/
diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 511152398790..bc82571ff2a8 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -1117,6 +1117,9 @@ static int __init icc_init(void)
 			    icc_debugfs_dir, NULL, &icc_summary_fops);
 	debugfs_create_file("interconnect_graph", 0444,
 			    icc_debugfs_dir, NULL, &icc_graph_fops);
+
+	icc_debugfs_client_init(icc_debugfs_dir);
+
 	return 0;
 }
 
diff --git a/drivers/interconnect/debugfs-client.c b/drivers/interconnect/debugfs-client.c
new file mode 100644
index 000000000000..990dd2ff6df7
--- /dev/null
+++ b/drivers/interconnect/debugfs-client.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#include <linux/debugfs.h>
+#include <linux/interconnect.h>
+#include <linux/platform_device.h>
+#include <linux/uaccess.h>
+
+/*
+ * This can be dangerous, therefore don't provide any real compile time
+ * configuration option for this feature.
+ * People who want to use this will need to modify the source code directly.
+ */
+#undef INTERCONNECT_ALLOW_WRITE_DEBUGFS
+
+#if defined(INTERCONNECT_ALLOW_WRITE_DEBUGFS) && defined(CONFIG_DEBUG_FS)
+
+static LIST_HEAD(debugfs_paths);
+static DEFINE_MUTEX(debugfs_lock);
+
+static struct platform_device *pdev;
+static struct icc_path *cur_path;
+
+static char *src_node;
+static char *dst_node;
+static u32 avg_bw;
+static u32 peak_bw;
+static u32 tag;
+
+struct debugfs_path {
+	const char *src;
+	const char *dst;
+	struct icc_path *path;
+	struct list_head list;
+};
+
+static struct icc_path *get_path(const char *src, const char *dst)
+{
+	struct debugfs_path *path;
+
+	list_for_each_entry(path, &debugfs_paths, list) {
+		if (!strcmp(path->src, src) && !strcmp(path->dst, dst))
+			return path->path;
+	}
+
+	return NULL;
+}
+
+static int icc_get_set(void *data, u64 val)
+{
+	struct debugfs_path *debugfs_path;
+	int ret = 0;
+
+	mutex_lock(&debugfs_lock);
+
+	/*
+	 * If we've already looked up a path, then use the existing one instead
+	 * of calling icc_get() again. This allows for updating previous BW
+	 * votes when "get" is written to multiple times for multiple paths.
+	 */
+	cur_path = get_path(src_node, dst_node);
+	if (cur_path)
+		goto out;
+
+	cur_path = icc_get(&pdev->dev, src_node, dst_node);
+	if (IS_ERR(cur_path)) {
+		ret = PTR_ERR(cur_path);
+		goto out;
+	}
+
+	debugfs_path = kzalloc(sizeof(*debugfs_path), GFP_KERNEL);
+	if (!debugfs_path) {
+		ret = -ENOMEM;
+		goto err_put;
+	}
+
+	debugfs_path->path = cur_path;
+	debugfs_path->src = kstrdup(src_node, GFP_KERNEL);
+	debugfs_path->dst = kstrdup(dst_node, GFP_KERNEL);
+	if (!debugfs_path->src || !debugfs_path->dst) {
+		ret = -ENOMEM;
+		goto err_free;
+	}
+
+	list_add_tail(&debugfs_path->list, &debugfs_paths);
+	goto out;
+
+err_free:
+	kfree(debugfs_path->src);
+	kfree(debugfs_path->dst);
+	kfree(debugfs_path);
+err_put:
+	icc_put(cur_path);
+out:
+	mutex_unlock(&debugfs_lock);
+	return ret;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(icc_get_fops, NULL, icc_get_set, "%llu\n");
+
+static int icc_commit_set(void *data, u64 val)
+{
+	int ret;
+
+	mutex_lock(&debugfs_lock);
+
+	if (IS_ERR_OR_NULL(cur_path)) {
+		ret = PTR_ERR(cur_path);
+		goto out;
+	}
+
+	icc_set_tag(cur_path, tag);
+	ret = icc_set_bw(cur_path, avg_bw, peak_bw);
+out:
+	mutex_unlock(&debugfs_lock);
+	return ret;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(icc_commit_fops, NULL, icc_commit_set, "%llu\n");
+
+int icc_debugfs_client_init(struct dentry *icc_dir)
+{
+	struct dentry *client_dir;
+	int ret;
+
+	pdev = platform_device_alloc("icc-debugfs-client", PLATFORM_DEVID_AUTO);
+
+	ret = platform_device_add(pdev);
+	if (ret) {
+		pr_err("%s: failed to add platform device: %d\n", __func__, ret);
+		platform_device_put(pdev);
+		return ret;
+	}
+
+	client_dir = debugfs_create_dir("test_client", icc_dir);
+
+	debugfs_create_str("src_node", 0600, client_dir, &src_node);
+	debugfs_create_str("dst_node", 0600, client_dir, &dst_node);
+	debugfs_create_file("get", 0200, client_dir, NULL, &icc_get_fops);
+	debugfs_create_u32("avg_bw", 0600, client_dir, &avg_bw);
+	debugfs_create_u32("peak_bw", 0600, client_dir, &peak_bw);
+	debugfs_create_u32("tag", 0600, client_dir, &tag);
+	debugfs_create_file("commit", 0200, client_dir, NULL, &icc_commit_fops);
+
+	return 0;
+}
+
+#else
+
+int icc_debugfs_client_init(struct dentry *icc_dir)
+{
+	return 0;
+}
+
+#endif
diff --git a/drivers/interconnect/internal.h b/drivers/interconnect/internal.h
index f5f82a5c939e..87152e70a99b 100644
--- a/drivers/interconnect/internal.h
+++ b/drivers/interconnect/internal.h
@@ -41,4 +41,6 @@ struct icc_path {
 	struct icc_req reqs[];
 };
 
+int icc_debugfs_client_init(struct dentry *icc_dir);
+
 #endif
-- 
2.17.1

