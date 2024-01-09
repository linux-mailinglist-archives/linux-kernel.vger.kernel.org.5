Return-Path: <linux-kernel+bounces-21075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FCE828966
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CE7BB259B2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408313BB33;
	Tue,  9 Jan 2024 15:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="I6o3oXq+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA63C3BB2E;
	Tue,  9 Jan 2024 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409DBsxI018744;
	Tue, 9 Jan 2024 15:49:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=MTcfyMqknt6++95kJjKTMmtXngwvVsrJUhfP77MXY0I=; b=I6
	o3oXq+Bi0U4uQZRPeTJt1iOecUBDZyEaGyf/5cZJFHC8REXIQdrzjaomvfquUvnA
	DzfjVrBNWfaJyritv2yZB72kqD9NG6503EhJU4gLSeaVCTaX4oPsZzugxeyPrafJ
	uLJ53qfbvRTvtRn5exAeSS09SD99E+yWmBBKdi6dCSxk96lxFnxP6vv22ZPHTC/2
	h1IsTA2UTbh6bEqKpx5MzCJV0yci2rsWIwcz7Tg8Y7LopGHFpL3nSLJmbHGPi4KX
	mlHd76i1+5O13iFyz4MFgIFheh3hLwI0nBJrs2fkzr458cCogELktff7Y2J2cvVC
	j2YHgo2qANAqyX3v2RSQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh3g68pys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 15:49:29 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 409FnR1p015521
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 15:49:28 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 07:49:22 -0800
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <corbet@lwn.net>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>, <vigneshr@ti.com>,
        <nm@ti.com>, <matthias.bgg@gmail.com>, <kgene@kernel.org>,
        <alim.akhtar@samsung.com>, <bmasney@redhat.com>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mukesh Ojha
	<quic_mojha@quicinc.com>
Subject: [PATCH v7 09/12] pstore/ram: Add ramoops information notifier support
Date: Tue, 9 Jan 2024 21:01:57 +0530
Message-ID: <20240109153200.12848-10-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.43.0.254.ga26002b62827
In-Reply-To: <20240109153200.12848-1-quic_mojha@quicinc.com>
References: <20240109153200.12848-1-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YjPBnxDZ1Jix9De12XW_FBmhIQSklWiX
X-Proofpoint-ORIG-GUID: YjPBnxDZ1Jix9De12XW_FBmhIQSklWiX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090128

Client like minidump is interested in knowing ramoops
individual zone addresses and their size so that it
could register them with its table.

Let's introduce a info notifier in ramoops which
gets called when ramoops driver probes successfully
and it passes the ramoops region information to the
passed callback by the client and If the call for
ramoops ready register comes after ramoops probe
than call the callback directly.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 fs/pstore/ram.c            | 115 +++++++++++++++++++++++++++++++++++++
 include/linux/pstore_ram.h |  12 ++++
 2 files changed, 127 insertions(+)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 795a8300631e..c0f8bf90219f 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -22,6 +22,8 @@
 #include <linux/of_address.h>
 #include <linux/memblock.h>
 #include <linux/mm.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
 
 #include "internal.h"
 #include "ram_internal.h"
@@ -101,6 +103,19 @@ struct ramoops_context {
 	unsigned int ftrace_read_cnt;
 	unsigned int pmsg_read_cnt;
 	struct pstore_info pstore;
+	struct blocking_notifier_head ramoops_notifiers;
+	bool ramoops_ready;
+	/*
+	 * Lock to serialize access to ramoops_ready and to not
+	 * miss any ongoing notifier registration while ramoops
+	 * probe is in progress.
+	 */
+	struct mutex lock;
+};
+
+struct ramoops_backend {
+	struct	notifier_block nb;
+	int	(*fn)(const char *, int, void *, phys_addr_t paddr, size_t size);
 };
 
 static struct platform_device *dummy;
@@ -501,6 +516,8 @@ static struct ramoops_context oops_cxt = {
 		.write_user	= ramoops_pstore_write_user,
 		.erase	= ramoops_pstore_erase,
 	},
+	.ramoops_notifiers = BLOCKING_NOTIFIER_INIT(oops_cxt.ramoops_notifiers),
+	.lock   = __MUTEX_INITIALIZER(oops_cxt.lock),
 };
 
 static void ramoops_free_przs(struct ramoops_context *cxt)
@@ -666,6 +683,99 @@ static int ramoops_init_prz(const char *name,
 	return 0;
 }
 
+static int __ramoops_info_notifier(struct ramoops_context *cxt,
+				    int (*fn)(const char *, int,
+				    void *, phys_addr_t, size_t))
+{
+	struct persistent_ram_zone *prz;
+	int ret;
+	int i;
+
+	for (i = 0; i < cxt->max_dump_cnt; i++) {
+		prz = cxt->dprzs[i];
+		ret = fn("dmesg", i, prz->vaddr, prz->paddr, prz->size);
+		if (ret < 0)
+			goto err;
+	}
+
+	if (cxt->console_size) {
+		prz = cxt->cprz;
+		ret = fn("console", 0, prz->vaddr, prz->paddr, prz->size);
+		if (ret < 0)
+			goto err;
+	}
+
+	for (i = 0; i < cxt->max_ftrace_cnt; i++) {
+		prz = cxt->fprzs[i];
+		ret = fn("ftrace", i, prz->vaddr, prz->paddr, prz->size);
+		if (ret < 0)
+			goto err;
+	}
+
+	if (cxt->pmsg_size) {
+		prz = cxt->mprz;
+		ret = fn("pmsg", 0, prz->vaddr, prz->paddr, prz->size);
+		if (ret < 0)
+			goto err;
+	}
+
+err:
+	return ret;
+}
+
+static int ramoops_info_notifier(struct notifier_block *nb,
+				   unsigned long event, void *data)
+{
+	struct ramoops_backend *b_info = container_of(nb, struct ramoops_backend, nb);
+	struct ramoops_context *cxt = data;
+
+	return __ramoops_info_notifier(cxt, b_info->fn);
+}
+
+void *register_ramoops_info_notifier(int (*fn)(const char *, int,
+				     void *, phys_addr_t, size_t))
+{
+	struct ramoops_context *cxt = &oops_cxt;
+	struct ramoops_backend *b_info;
+
+	mutex_lock(&cxt->lock);
+	/*
+	 * There is no need to register callback if ramoops probe
+	 * is already done instead, call the callback directly
+	 */
+	if (cxt->ramoops_ready) {
+		mutex_unlock(&cxt->lock);
+		__ramoops_info_notifier(cxt, fn);
+		return NULL;
+	}
+
+	b_info = kzalloc(sizeof(*b_info), GFP_KERNEL);
+	if (!b_info) {
+		b_info = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+
+	b_info->fn = fn;
+	b_info->nb.notifier_call = ramoops_info_notifier;
+	blocking_notifier_chain_register(&cxt->ramoops_notifiers, &b_info->nb);
+
+out:
+	mutex_unlock(&cxt->lock);
+	return b_info;
+}
+EXPORT_SYMBOL_GPL(register_ramoops_info_notifier);
+
+void unregister_ramoops_info_notifier(void *b_info)
+{
+	struct ramoops_context *cxt = &oops_cxt;
+	struct ramoops_backend *tmp = b_info;
+
+	mutex_lock(&cxt->lock);
+	blocking_notifier_chain_unregister(&cxt->ramoops_notifiers, &tmp->nb);
+	mutex_unlock(&cxt->lock);
+}
+EXPORT_SYMBOL_GPL(unregister_ramoops_info_notifier);
+
 /* Read a u32 from a dt property and make sure it's safe for an int. */
 static int ramoops_parse_dt_u32(struct platform_device *pdev,
 				const char *propname,
@@ -915,6 +1025,11 @@ static int ramoops_probe(struct platform_device *pdev)
 	ramoops_pmsg_size = pdata->pmsg_size;
 	ramoops_ftrace_size = pdata->ftrace_size;
 
+	mutex_lock(&cxt->lock);
+	cxt->ramoops_ready = true;
+	mutex_unlock(&cxt->lock);
+	blocking_notifier_call_chain(&cxt->ramoops_notifiers, 0, cxt);
+
 	pr_info("using 0x%lx@0x%llx, ecc: %d\n",
 		cxt->size, (unsigned long long)cxt->phys_addr,
 		cxt->ecc_info.ecc_size);
diff --git a/include/linux/pstore_ram.h b/include/linux/pstore_ram.h
index 1efff7a38333..5e472a132d33 100644
--- a/include/linux/pstore_ram.h
+++ b/include/linux/pstore_ram.h
@@ -39,6 +39,18 @@ struct ramoops_platform_data {
 	struct persistent_ram_ecc_info ecc_info;
 };
 
+#if IS_ENABLED(CONFIG_PSTORE_RAM)
+void *register_ramoops_info_notifier(int (*fn)(const char *name, int id,
+				     void *vaddr, phys_addr_t paddr,
+				     size_t size));
+void unregister_ramoops_info_notifier(void *);
+#else
+void *register_ramoops_info_notifier(int (*fn)(const char *name, int id,
+				     void *vaddr, phys_addr_t paddr,
+				     size_t size)) { }
+void unregister_ramoops_info_notifier(void *) { }
+#endif
+
 #ifdef CONFIG_PSTORE_DYNAMIC_RAMOOPS
 void __init setup_dynamic_ramoops(void);
 #else
-- 
2.43.0.254.ga26002b62827


