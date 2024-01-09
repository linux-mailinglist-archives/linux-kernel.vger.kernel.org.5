Return-Path: <linux-kernel+bounces-21077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE3782896B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DAD7B25562
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640FE3C485;
	Tue,  9 Jan 2024 15:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZCdZWWKB"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0B13C464;
	Tue,  9 Jan 2024 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409FDnQ7018236;
	Tue, 9 Jan 2024 15:49:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=vjk2Urixu2/24Wsx4Wue00+ZuZNr9bHOHHjk7+a7zW4=; b=ZC
	dZWWKBAUQB66a5T0lVHq2MGWHEs/abSry1VZJk6xYyBiRpwhG8eoS2QmWE71+4e0
	iUiUbXuNNut+anKJyJLsX0BuNbhb86Bikb3WLEV9TvC31Szd6xpymclLWcCUYU2u
	RhDJR1REY+2xgLOe1A9dipnXNEM7T4S9w+xFHKeJ92NFDiptqo97JsaG0QdCg1ly
	4Vn+tbCDIaErP84aGTeRY/XGlt3woZKw5aVVW8vRBVCNHp2mEbzL2TI0CXl0MmLh
	LTDJrWa1mpUF+V25cbojnwMxoS1uxoXfQblK+rMygcNXvEKxdqetd8CbaiRiFx54
	SqifK1dJTCrDFrTLFqvQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgw1k1e9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 15:49:34 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 409FnXfW027104
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 15:49:33 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 07:49:28 -0800
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
Subject: [PATCH v7 10/12] soc: qcom: register ramoops region with APSS minidump
Date: Tue, 9 Jan 2024 21:01:58 +0530
Message-ID: <20240109153200.12848-11-quic_mojha@quicinc.com>
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
X-Proofpoint-GUID: h4HEgvBOae1pmWhu9AhKKUv83a4KTTzS
X-Proofpoint-ORIG-GUID: h4HEgvBOae1pmWhu9AhKKUv83a4KTTzS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 impostorscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090128

Register ramoops region with APSS minidump so that
these region gets captured on system crash.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/soc/qcom/qcom_minidump.c | 75 ++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/soc/qcom/qcom_minidump.c b/drivers/soc/qcom/qcom_minidump.c
index c0f76a51d0e8..c847cca1d999 100644
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
 
+static int register_ramoops_region(const char *name, int id, void *vaddr,
+				   phys_addr_t paddr, size_t size)
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
+static void register_ramoops_minidump_cb(struct work_struct *work)
+{
+	register_ramoops_info_notifier(register_ramoops_region);
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
@@ -575,6 +631,22 @@ static int qcom_apss_minidump_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, md);
 
+	/*
+	 * Use separate context for registering ramoops region via workqueue
+	 * as minidump probe can get called in same context of platform device
+	 * register call from smem driver and further call to qcom_smem_minidump_ready()
+	 * can return -EPROBE_DEFER as __smem->minidump is not yet initialised because
+	 * of same context.
+	 *
+	 * qcom_apss_minidump_probe()
+	 *   register_ramoops_minidump_cb()
+	 *     register_ramoops_region()
+	 *       qcom_minidump_region_register()
+	 *         qcom_smem_minidump_ready()
+	 */
+	INIT_WORK(&md->work, register_ramoops_minidump_cb);
+	schedule_work(&md->work);
+
 	return ret;
 }
 
@@ -582,6 +654,9 @@ static void qcom_apss_minidump_remove(struct platform_device *pdev)
 {
 	struct minidump *md = platform_get_drvdata(pdev);
 
+	flush_work(&md->work);
+	qcom_ramoops_minidump_unregister();
+	unregister_ramoops_info_notifier(register_ramoops_minidump_cb);
 	qcom_apss_md_table_exit(md->apss_data);
 }
 
-- 
2.43.0.254.ga26002b62827


