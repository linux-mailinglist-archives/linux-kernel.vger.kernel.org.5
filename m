Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9B57F8618
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 23:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbjKXWWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 17:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjKXWW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 17:22:29 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75AF1FF6;
        Fri, 24 Nov 2023 14:22:13 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AOMJOVA032368;
        Fri, 24 Nov 2023 22:21:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=b5eTBZeeW3B0oIKYsibzqp9oXL4xrHRnjIPMFNhgnF0=;
 b=mxK/2EdjjVnrmjFpyttUkIAzFH6685VIp//oIOpM3MTuQV/vi4ldmtkBhd19UMXOOF8Q
 6g5ORooFeJCNSKZa0PbA2h7XWG8pT2JRMWfLWP9Qr4nssAIOrSyliKcoIgO2NzUNpuu1
 86cK5qj+YepaN+nyGspdarozNzE+Tn8Bh0lIsyBy0qMu/+VU5xROmBdXn9bKnbzRuvRR
 BHwr8hc2LJPAB9BoaSVWLnUvAGsY7Ei1rssFeW0v7SK8cbO5TN0EA3nkcyYdR06mBQ0d
 MHI736zOdlAfumZxsLpeyzL3SgWhmw1KpTrumHvtGlqt4IlDIjnRYQes05j3MIqzqJ9w dg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uj6emusg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 22:21:55 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AOMLsMQ016882
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 22:21:54 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 24 Nov 2023 14:21:45 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <corbet@lwn.net>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <vigneshr@ti.com>, <nm@ti.com>, <matthias.bgg@gmail.com>,
        <kgene@kernel.org>, <alim.akhtar@samsung.com>, <bmasney@redhat.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <kernel@quicinc.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [Patch v6 12/12] soc: qcom: register ramoops region with APSS minidump
Date:   Sat, 25 Nov 2023 03:49:55 +0530
Message-ID: <1700864395-1479-13-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1700864395-1479-1-git-send-email-quic_mojha@quicinc.com>
References: <1700864395-1479-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XhP7UB1QriAxNqtp8DRhI6TdM9sUSISM
X-Proofpoint-GUID: XhP7UB1QriAxNqtp8DRhI6TdM9sUSISM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-24_09,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311240174
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register ramoops region with APSS minidump so that
these region gets captured on system crash.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/soc/qcom/qcom_minidump.c | 62 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/soc/qcom/qcom_minidump.c b/drivers/soc/qcom/qcom_minidump.c
index c0f76a51d0e8..9a39b68903fb 100644
--- a/drivers/soc/qcom/qcom_minidump.c
+++ b/drivers/soc/qcom/qcom_minidump.c
@@ -18,8 +18,10 @@
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/printk.h>
+#include <linux/pstore_ram.h>
 #include <linux/soc/qcom/smem.h>
 #include <linux/string.h>
+#include <linux/workqueue.h>
 #include <soc/qcom/qcom_minidump.h>
 
 #include "qcom_minidump_internal.h"
@@ -56,12 +58,20 @@ struct minidump_elfhdr {
  * @dev: Minidump backend device
  * @apss_data: APSS driver data
  * @md_lock: Lock to protect access to APSS minidump table
+ * @work: Minidump work for any required execution in process context.
  */
 struct minidump {
 	struct minidump_elfhdr	 elf;
 	struct device		 *dev;
 	struct minidump_ss_data	 *apss_data;
 	struct mutex		 md_lock;
+	struct work_struct	 work;
+};
+
+static LIST_HEAD(apss_md_rlist);
+struct md_region_list {
+	struct qcom_minidump_region md_region;
+	struct list_head list;
 };
 
 /*
@@ -530,6 +540,52 @@ static int qcom_apss_md_table_init(struct minidump *md,
 	return 0;
 }
 
+static int ramoops_region_md_register(const char *name, int id, void *vaddr,
+				      phys_addr_t paddr, size_t size)
+{
+	struct qcom_minidump_region *md_region;
+	struct md_region_list *mdr_list;
+	int ret;
+
+	mdr_list = kzalloc(sizeof(*mdr_list), GFP_KERNEL);
+	if (!mdr_list)
+		return -ENOMEM;
+
+	md_region = &mdr_list->md_region;
+	scnprintf(md_region->name, sizeof(md_region->name), "K%s%d", name, id);
+	md_region->virt_addr = vaddr;
+	md_region->phys_addr = paddr;
+	md_region->size = size;
+	ret = qcom_minidump_region_register(md_region);
+	if (ret < 0) {
+		pr_err("failed to register region in minidump: err: %d\n", ret);
+		return ret;
+	}
+
+	list_add(&mdr_list->list, &apss_md_rlist);
+
+	return 0;
+}
+
+static void ramoops_register_md_callback(struct work_struct *work)
+{
+	register_ramoops_ready_notifier(ramoops_region_md_register);
+}
+
+static void qcom_ramoops_minidump_unregister(void)
+{
+	struct md_region_list *mdr_list;
+	struct md_region_list *tmp;
+
+	list_for_each_entry_safe(mdr_list, tmp, &apss_md_rlist, list) {
+		struct qcom_minidump_region *region;
+
+		region = &mdr_list->md_region;
+		qcom_minidump_region_unregister(region);
+		list_del(&mdr_list->list);
+	}
+}
+
 static void qcom_apss_md_table_exit(struct minidump_ss_data *mdss_data)
 {
 	memset(mdss_data->md_ss_toc, cpu_to_le32(0), sizeof(*mdss_data->md_ss_toc));
@@ -575,6 +631,9 @@ static int qcom_apss_minidump_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, md);
 
+	INIT_WORK(&md->work, ramoops_register_md_callback);
+	schedule_work(&md->work);
+
 	return ret;
 }
 
@@ -582,6 +641,9 @@ static void qcom_apss_minidump_remove(struct platform_device *pdev)
 {
 	struct minidump *md = platform_get_drvdata(pdev);
 
+	flush_work(&md->work);
+	qcom_ramoops_minidump_unregister();
+	unregister_ramoops_ready_notifier(ramoops_region_md_register);
 	qcom_apss_md_table_exit(md->apss_data);
 }
 
-- 
2.7.4

