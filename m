Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581167F8616
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 23:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345536AbjKXWWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 17:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjKXWW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 17:22:27 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2FA1FD7;
        Fri, 24 Nov 2023 14:22:07 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AOMD7Vp010830;
        Fri, 24 Nov 2023 22:21:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=4990baIAlfmVS/cuHV5ll4dJd4q948H/yj67VkxMl0o=;
 b=a8s4b0SpiRAl5E8ln5Cb26pe+rXlFHCURefuDuMQ3SIiNW5Ac8h2m5cu6XoJX9WQZSPP
 wLKJDNucJscGH3O9BIgf111O8m2VuWcOADzhTZxDkfx812U8+GMGKSQyX/RSOkiSI/jA
 ss4w3DTJyYJj/eRperxj4Xj2+Ps7VLD0SQzxBc0hzY2OsY1NynFcvt2jXSpJ0cRgMFAG
 6OKsMd2tPgaq885i5S5/CSV2eqaLICIMkZDFNYj+5SG6co/geXjpwlu9eun8LSiIwoP9
 eBjhLgPFFfFnWIyToc+U8SNWzjauUeiGQFtRjXiWFSjAPSRCuONed7YgqDFbYXQ3d2Cy FQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ujtd8hc5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 22:21:47 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AOMLlQa018649
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 22:21:47 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 24 Nov 2023 14:21:37 -0800
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
Subject: [Patch v6 11/12] pstore/ram: Add ramoops ready notifier support
Date:   Sat, 25 Nov 2023 03:49:54 +0530
Message-ID: <1700864395-1479-12-git-send-email-quic_mojha@quicinc.com>
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
X-Proofpoint-ORIG-GUID: lqkUmmB8IS1KaL6dqzOsIkviN8gd4TWl
X-Proofpoint-GUID: lqkUmmB8IS1KaL6dqzOsIkviN8gd4TWl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-24_09,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311240174
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Client like minidump, is only interested in ramoops
region addresses/size so that it could register them
with its table and also it is only deals with ram
backend and does not use pstorefs to read the records.
Let's introduce a client notifier in ramoops which
gets called when ramoops driver probes successfully
and it passes the ramoops region information to the
passed callback by the client and If the call for
ramoops ready register comes after ramoops probe
than call the callback directly.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 fs/pstore/ram.c            | 77 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pstore_ram.h |  6 ++++
 2 files changed, 83 insertions(+)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index a6c0da8cfdd4..72341fd21aec 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -22,6 +22,7 @@
 #include <linux/of_address.h>
 #include <linux/memblock.h>
 #include <linux/mm.h>
+#include <linux/mutex.h>
 
 #include "internal.h"
 #include "ram_internal.h"
@@ -101,6 +102,14 @@ struct ramoops_context {
 	unsigned int ftrace_read_cnt;
 	unsigned int pmsg_read_cnt;
 	struct pstore_info pstore;
+	/*
+	 * Lock to serialize calls to register_ramoops_ready_notifier,
+	 * ramoops_ready_notifier and read/modification of 'ramoops_ready'.
+	 */
+	struct mutex lock;
+	bool ramoops_ready;
+	int (*callback)(const char *name, int id, void *vaddr,
+			phys_addr_t paddr, size_t size);
 };
 
 static struct platform_device *dummy;
@@ -488,6 +497,7 @@ static int ramoops_pstore_erase(struct pstore_record *record)
 }
 
 static struct ramoops_context oops_cxt = {
+	.lock   = __MUTEX_INITIALIZER(oops_cxt.lock),
 	.pstore = {
 		.owner	= THIS_MODULE,
 		.name	= "ramoops",
@@ -662,6 +672,68 @@ static int ramoops_init_prz(const char *name,
 	return 0;
 }
 
+void ramoops_ready_notifier(struct ramoops_context *cxt)
+{
+	struct persistent_ram_zone *prz;
+	int i;
+
+	if (!cxt->callback)
+		return;
+
+	for (i = 0; i < cxt->max_dump_cnt; i++) {
+		prz = cxt->dprzs[i];
+		cxt->callback("dmesg", i, prz->vaddr, prz->paddr, prz->size);
+	}
+
+	if (cxt->console_size) {
+		prz = cxt->cprz;
+		cxt->callback("console", 0, prz->vaddr, prz->paddr, prz->size);
+	}
+
+	for (i = 0; i < cxt->max_ftrace_cnt; i++) {
+		prz = cxt->fprzs[i];
+		cxt->callback("ftrace", i, prz->vaddr, prz->paddr, prz->size);
+	}
+
+	if (cxt->pmsg_size) {
+		prz = cxt->mprz;
+		cxt->callback("pmsg", 0, prz->vaddr, prz->paddr, prz->size);
+	}
+}
+
+int register_ramoops_ready_notifier(int (*fn)(const char *, int,
+				   void *, phys_addr_t, size_t))
+{
+	struct ramoops_context *cxt = &oops_cxt;
+
+	mutex_lock(&cxt->lock);
+	if (cxt->callback) {
+		mutex_unlock(&cxt->lock);
+		return -EEXIST;
+	}
+
+	cxt->callback = fn;
+	if (cxt->ramoops_ready)
+		ramoops_ready_notifier(cxt);
+
+	mutex_unlock(&cxt->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(register_ramoops_ready_notifier);
+
+void unregister_ramoops_ready_notifier(int (*fn)(const char *, int,
+				     void *, phys_addr_t, size_t))
+{
+	struct ramoops_context *cxt = &oops_cxt;
+
+	mutex_lock(&cxt->lock);
+	WARN_ON_ONCE(cxt->callback != fn);
+	cxt->callback = NULL;
+	mutex_unlock(&cxt->lock);
+}
+EXPORT_SYMBOL_GPL(unregister_ramoops_ready_notifier);
+
 /* Read a u32 from a dt property and make sure it's safe for an int. */
 static int ramoops_parse_dt_u32(struct platform_device *pdev,
 				const char *propname,
@@ -911,6 +983,11 @@ static int ramoops_probe(struct platform_device *pdev)
 	ramoops_pmsg_size = pdata->pmsg_size;
 	ramoops_ftrace_size = pdata->ftrace_size;
 
+	mutex_lock(&cxt->lock);
+	ramoops_ready_notifier(cxt);
+	cxt->ramoops_ready = true;
+	mutex_unlock(&cxt->lock);
+
 	pr_info("using 0x%lx@0x%llx, ecc: %d\n",
 		cxt->size, (unsigned long long)cxt->phys_addr,
 		cxt->ecc_info.ecc_size);
diff --git a/include/linux/pstore_ram.h b/include/linux/pstore_ram.h
index b3537336c4e1..9745d48ba59e 100644
--- a/include/linux/pstore_ram.h
+++ b/include/linux/pstore_ram.h
@@ -39,6 +39,12 @@ struct ramoops_platform_data {
 	struct persistent_ram_ecc_info ecc_info;
 };
 
+int register_ramoops_ready_notifier(int (*fn)(const char *name, int id,
+				    void *vaddr, phys_addr_t paddr,
+				    size_t size));
+void unregister_ramoops_ready_notifier(int (*fn)(const char *name, int id,
+				       void *vaddr, phys_addr_t paddr,
+				       size_t size));
 #ifdef CONFIG_PSTORE_DYNAMIC_RAMOOPS_REGION_RESERVATION
 void __init setup_dynamic_ramoops(void);
 #else
-- 
2.7.4

