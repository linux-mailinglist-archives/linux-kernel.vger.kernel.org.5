Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9F87604B3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 03:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjGYBaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 21:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjGYBaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 21:30:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27891720;
        Mon, 24 Jul 2023 18:30:00 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P0x0TA009424;
        Tue, 25 Jul 2023 01:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=ptZZGhAGI6uTXo3/oImB7hvn/wJVEldt8PhILI6q6A4=;
 b=OrV/DBxEvuv5dFXS8+lV01D5xkqezhw3FRnuiRrDMKwgHIMmwwC8h3Zrj1gqOF6CkSCv
 rD/as016x+m29j9O+Uh4jmzXkee8xkVsnWYnKILVThpjIVlYNsuVqCrVVymLbDHjTPbe
 78/xdGZXCJCWhWjDN9pCkGhGwhQyjAGMRrLgfq32iHDLibigHxgO3no/pK7kybhEJz/r
 58rTEuIoFQv0s+8D4CEq1d/yxBSzWYSPalDhnW9Nib/VnGayYG2EWPM0l4X1RZf6eE9K
 S+f21j4bu7IYTAQyW7mPcNhRB8esbMhuEjKAwmGZ5uDZ0kPwVSOP2JDz/QMCGwfJcHOG 0w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1vh8h1m6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 01:29:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36P1Ts46020885
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
Subject: [PATCH 2/3] interconnect: Reintroduce icc_get()
Date:   Mon, 24 Jul 2023 18:28:58 -0700
Message-ID: <20230725012859.18474-3-quic_mdtipton@quicinc.com>
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
X-Proofpoint-ORIG-GUID: GOWQUXzWtzhcu8x-V_ewkb-m0tlmngNC
X-Proofpoint-GUID: GOWQUXzWtzhcu8x-V_ewkb-m0tlmngNC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_18,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 impostorscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

The original icc_get() that took integer node IDs was removed due to
lack of users. Reintroduce a new version that takes string node names,
which is needed for the debugfs client.

Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>
---
 drivers/interconnect/core.c  | 64 ++++++++++++++++++++++++++++++++++++
 include/linux/interconnect.h |  6 ++++
 2 files changed, 70 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 5fac448c28fd..511152398790 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -147,6 +147,21 @@ static struct icc_node *node_find(const int id)
 	return idr_find(&icc_idr, id);
 }
 
+static struct icc_node *node_find_by_name(const char *name)
+{
+	struct icc_provider *provider;
+	struct icc_node *n;
+
+	list_for_each_entry(provider, &icc_providers, provider_list) {
+		list_for_each_entry(n, &provider->nodes, node_list) {
+			if (!strcmp(n->name, name))
+				return n;
+		}
+	}
+
+	return NULL;
+}
+
 static struct icc_path *path_init(struct device *dev, struct icc_node *dst,
 				  ssize_t num_nodes)
 {
@@ -561,6 +576,55 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
 }
 EXPORT_SYMBOL_GPL(of_icc_get);
 
+/**
+ * icc_get() - get a path handle between two endpoints
+ * @dev: device pointer for the consumer device
+ * @src: source node name
+ * @dst: destination node name
+ *
+ * This function will search for a path between two endpoints and return an
+ * icc_path handle on success. Use icc_put() to release constraints when they
+ * are not needed anymore.
+ *
+ * Return: icc_path pointer on success or ERR_PTR() on error. NULL is returned
+ * when the API is disabled.
+ */
+struct icc_path *icc_get(struct device *dev, const char *src, const char *dst)
+{
+	struct icc_node *src_node, *dst_node;
+	struct icc_path *path = ERR_PTR(-EPROBE_DEFER);
+
+	mutex_lock(&icc_lock);
+
+	src_node = node_find_by_name(src);
+	if (!src_node) {
+		dev_err(dev, "%s: invalid src=%s\n", __func__, src);
+		goto out;
+	}
+
+	dst_node = node_find_by_name(dst);
+	if (!dst_node) {
+		dev_err(dev, "%s: invalid dst=%s\n", __func__, dst);
+		goto out;
+	}
+
+	path = path_find(dev, src_node, dst_node);
+	if (IS_ERR(path)) {
+		dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
+		goto out;
+	}
+
+	path->name = kasprintf(GFP_KERNEL, "%s-%s", src_node->name, dst_node->name);
+	if (!path->name) {
+		kfree(path);
+		path = ERR_PTR(-ENOMEM);
+	}
+out:
+	mutex_unlock(&icc_lock);
+	return path;
+}
+EXPORT_SYMBOL_GPL(icc_get);
+
 /**
  * icc_set_tag() - set an optional tag on a path
  * @path: the path we want to tag
diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
index 97ac253df62c..39a98ddfdfd4 100644
--- a/include/linux/interconnect.h
+++ b/include/linux/interconnect.h
@@ -40,6 +40,7 @@ struct icc_bulk_data {
 
 #if IS_ENABLED(CONFIG_INTERCONNECT)
 
+struct icc_path *icc_get(struct device *dev, const char *src, const char *dst);
 struct icc_path *of_icc_get(struct device *dev, const char *name);
 struct icc_path *devm_of_icc_get(struct device *dev, const char *name);
 int devm_of_icc_bulk_get(struct device *dev, int num_paths, struct icc_bulk_data *paths);
@@ -59,6 +60,11 @@ void icc_bulk_disable(int num_paths, const struct icc_bulk_data *paths);
 
 #else
 
+struct icc_path *icc_get(struct device *dev, const char *src, const char *dst)
+{
+	return NULL;
+}
+
 static inline struct icc_path *of_icc_get(struct device *dev,
 					  const char *name)
 {
-- 
2.17.1

