Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9698976A44A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 00:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjGaWn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 18:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjGaWnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 18:43:16 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AC619AF;
        Mon, 31 Jul 2023 15:43:14 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VMgiwl011895;
        Mon, 31 Jul 2023 22:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=YQaob9C8fOQbAR+CFXkRhipAxk2RWvQMSKS6UDVx/vs=;
 b=LEoZl2JnmX/0+zpkAX+cdfnmbLsDORnZguvjBoXicpoChCDv32ns6agM3da5suTbhKuc
 EPpevqOuFAgm3yGIJnpWbhlv20V7eojP4GTkrGnC8Snqu6nqQUBa0Ofsnk8cT6Ek9YfC
 /RBilNRYTPurXbeHBPL11gLrvQ8lXpu6AvVeNyPCxLqMlvs2iegnAoYDK5NzpWV3L7UR
 Dz8qfpQGgsgkt6EaLPtaPR+dCtSLbM5xmvG4CVBHSVjaAGhAyY+tXd2AcRiMoM4fnTlc
 BnEyTiBNOfcYiGxf8V0ynoUWpJnLs2EulqVp5ib1vE1psFn0tMm/+S6Sx7MZEry9RIuD Fw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6gs7gk5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 22:43:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36VMh1kT020176
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 22:43:01 GMT
Received: from hu-mdtipton-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 31 Jul 2023 15:43:01 -0700
From:   Mike Tipton <quic_mdtipton@quicinc.com>
To:     <djakov@kernel.org>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <corbet@lwn.net>
CC:     <linux-pm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_okukatla@quicinc.com>,
        <quic_viveka@quicinc.com>, <peterz@infradead.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>
Subject: [PATCH v2 3/3] interconnect: Add debugfs test client
Date:   Mon, 31 Jul 2023 15:42:47 -0700
Message-ID: <20230731224247.10846-4-quic_mdtipton@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230731224247.10846-1-quic_mdtipton@quicinc.com>
References: <20230731224247.10846-1-quic_mdtipton@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5bZh8_gippCLykqPuFm3fcFthvgHwXXm
X-Proofpoint-ORIG-GUID: 5bZh8_gippCLykqPuFm3fcFthvgHwXXm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_15,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310206
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 Documentation/driver-api/interconnect.rst |  25 ++++
 drivers/interconnect/Makefile             |   2 +-
 drivers/interconnect/core.c               |   3 +
 drivers/interconnect/debugfs-client.c     | 168 ++++++++++++++++++++++
 drivers/interconnect/internal.h           |   1 +
 5 files changed, 198 insertions(+), 1 deletion(-)
 create mode 100644 drivers/interconnect/debugfs-client.c

diff --git a/Documentation/driver-api/interconnect.rst b/Documentation/driver-api/interconnect.rst
index 5ed4f57a6bac..a92d0f277a1f 100644
--- a/Documentation/driver-api/interconnect.rst
+++ b/Documentation/driver-api/interconnect.rst
@@ -113,3 +113,28 @@ through dot to generate diagrams in many graphical formats::
 
         $ cat /sys/kernel/debug/interconnect/interconnect_graph | \
                 dot -Tsvg > interconnect_graph.svg
+
+The ``test-client`` directory provides interfaces for issuing BW requests to
+any arbitrary path. Note that for safety reasons, this feature is disabled by
+default without a Kconfig to enable it. Enabling it requires code changes to
+``#define INTERCONNECT_ALLOW_WRITE_DEBUGFS``. Example usage::
+
+        cd /sys/kernel/debug/interconnect/test-client/
+
+        # Configure node endpoints for the path from CPU to DDR on
+        # qcom/sm8550.
+        echo chm_apps > src_node
+        echo ebi > dst_node
+
+        # Get path between src_node and dst_node. This is only
+        # necessary after updating the node endpoints.
+        echo 1 > get
+
+        # Set desired BW to 1GBps avg and 2GBps peak.
+        echo 1000000 > avg_bw
+        echo 2000000 > peak_bw
+
+        # Vote for avg_bw and peak_bw on the latest path from "get".
+        # Voting for multiple paths is possible by repeating this
+        # process for different nodes endpoints.
+        echo 1 > commit
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
index fc1461dfc61b..9e12bb5e523d 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -1116,6 +1116,9 @@ static int __init icc_init(void)
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
index 000000000000..c41255cc44ca
--- /dev/null
+++ b/drivers/interconnect/debugfs-client.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#include <linux/debugfs.h>
+#include <linux/interconnect.h>
+#include <linux/platform_device.h>
+
+#include "internal.h"
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
+	char *src, *dst;
+	int ret = 0;
+
+	mutex_lock(&debugfs_lock);
+
+	rcu_read_lock();
+	src = rcu_dereference(src_node);
+	dst = rcu_dereference(dst_node);
+
+	/*
+	 * If we've already looked up a path, then use the existing one instead
+	 * of calling icc_get() again. This allows for updating previous BW
+	 * votes when "get" is written to multiple times for multiple paths.
+	 */
+	cur_path = get_path(src, dst);
+	if (cur_path) {
+		rcu_read_unlock();
+		goto out;
+	}
+
+	src = kstrdup(src, GFP_KERNEL);
+	dst = kstrdup(dst, GFP_KERNEL);
+	rcu_read_unlock();
+
+	if (!src || !dst) {
+		ret = -ENOMEM;
+		goto err_free;
+	}
+
+	cur_path = icc_get(&pdev->dev, src, dst);
+	if (IS_ERR(cur_path)) {
+		ret = PTR_ERR(cur_path);
+		goto err_free;
+	}
+
+	debugfs_path = kzalloc(sizeof(*debugfs_path), GFP_KERNEL);
+	if (!debugfs_path) {
+		ret = -ENOMEM;
+		goto err_put;
+	}
+
+	debugfs_path->path = cur_path;
+	debugfs_path->src = src;
+	debugfs_path->dst = dst;
+	list_add_tail(&debugfs_path->list, &debugfs_paths);
+
+	goto out;
+
+err_put:
+	icc_put(cur_path);
+err_free:
+	kfree(src);
+	kfree(dst);
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
+	pdev = platform_device_alloc("icc-debugfs-client", PLATFORM_DEVID_NONE);
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
index 95d6ba27bf78..3b2cfd32e449 100644
--- a/drivers/interconnect/internal.h
+++ b/drivers/interconnect/internal.h
@@ -42,5 +42,6 @@ struct icc_path {
 };
 
 struct icc_path *icc_get(struct device *dev, const char *src, const char *dst);
+int icc_debugfs_client_init(struct dentry *icc_dir);
 
 #endif
-- 
2.17.1

