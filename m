Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D6E7727CC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbjHGOaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbjHGOaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:30:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC36EF0;
        Mon,  7 Aug 2023 07:30:09 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 377Dge7O018630;
        Mon, 7 Aug 2023 14:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=fBx6wXCdVZN4Tj2uR5yWntWgXsoRGX1U3sGwd9xI88Y=;
 b=K33fDnDYRUr7bozA5fbcqekk7W1R5u3iV4spcxjG5yREOHRgA+5np0BPc3m11Uk39ZW0
 2uP7m9SiwxPTn87WKYv+G7uLjeOve3EbtzVqquSu9Hh6Q9xfuwfZ5c4THCJSvDi7DIS4
 RnKgWq50MQpOh/8fJcPV3K7QfAVh8buWWhpvwvoI/LJW3qDblqBBq3Nw5zzW8Lhm/UkE
 XS5jzMoFFxSo704oz8Z0NzdZDP25kqXZk7WxBLSFe78MDeyHwj/UpmdNvs9xwifkpfDh
 cqrYRb0O7zPSGZfKa+sg7B0sLF7pnxL2huH2Z67MGrtcTlqWDZBiUjLu69zbqfIsCnFn 7Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3saxbbrghk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 14:29:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 377ETuVZ017999
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 7 Aug 2023 14:29:56 GMT
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
Subject: [PATCH v3 2/3] interconnect: Reintroduce icc_get()
Date:   Mon, 7 Aug 2023 07:29:13 -0700
Message-ID: <20230807142914.12480-3-quic_mdtipton@quicinc.com>
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
X-Proofpoint-ORIG-GUID: IurxlUxx0swkuoQfTgUx2y3bi7Stkc8s
X-Proofpoint-GUID: IurxlUxx0swkuoQfTgUx2y3bi7Stkc8s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_15,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
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

The original icc_get() that took integer node IDs was removed due to
lack of users. Reintroduce a new version that takes string node names,
which is needed for the debugfs client.

Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>
---
 drivers/interconnect/core.c     | 63 +++++++++++++++++++++++++++++++++
 drivers/interconnect/internal.h |  2 ++
 2 files changed, 65 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 5fac448c28fd..fc1461dfc61b 100644
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
@@ -561,6 +576,54 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
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
+
 /**
  * icc_set_tag() - set an optional tag on a path
  * @path: the path we want to tag
diff --git a/drivers/interconnect/internal.h b/drivers/interconnect/internal.h
index f5f82a5c939e..95d6ba27bf78 100644
--- a/drivers/interconnect/internal.h
+++ b/drivers/interconnect/internal.h
@@ -41,4 +41,6 @@ struct icc_path {
 	struct icc_req reqs[];
 };
 
+struct icc_path *icc_get(struct device *dev, const char *src, const char *dst);
+
 #endif
-- 
2.17.1

