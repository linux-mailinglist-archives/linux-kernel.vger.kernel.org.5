Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896157C00BC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbjJJPuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbjJJPuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:50:18 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE090AF;
        Tue, 10 Oct 2023 08:50:16 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39AF86wX001486;
        Tue, 10 Oct 2023 15:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=8uOsaw3IKUcHLttXo2XH4wYYqFxynnEheIIeRAfRGwo=;
 b=Uw5jzNSrjz3qJLJI3xoBHJxBTKLqB2jfUhwOqZpyfzY45ycPh0toJwYW0ddvsRYpAZXi
 DjelfVCRRti3SsvcFCQVbka349dSQxBzI3g8OaALANcmkzKVoRBFtn6MAn4CE7UQ3Y5s
 QC6OnTIjRt5TP+VbAdwJgipxHJx/aztwHPOPoLlSrS6M2pMLr1vVb7XHOD2uMNkLHEQ4
 SJ75S3kO8KRLK7HE4sUmLJN0dRP3Mccen/H6P1QjU3wZe7LizqHlZK4ruLxZFdXsCkre
 P3X1zuk0pFNJExre7+1AHBt7qMKGzCfjhnmEmh9qf6tBwajyCXN4jOl57h4pnaChP5P4 LQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tmt709qsy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 15:50:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39AFo1qj025505
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 15:50:01 GMT
Received: from hu-mnaresh-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 10 Oct 2023 08:49:55 -0700
From:   Maramaina Naresh <quic_mnaresh@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_cang@quicinc.com>, <quic_nguyenb@quicinc.com>
Subject: [PATCH V1 2/4] ufs: ufs-qcom: Add per-cpu PM QoS support for ufs
Date:   Tue, 10 Oct 2023 21:19:05 +0530
Message-ID: <1696952947-18062-3-git-send-email-quic_mnaresh@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1696952947-18062-1-git-send-email-quic_mnaresh@quicinc.com>
References: <1696952947-18062-1-git-send-email-quic_mnaresh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: R4-d40Jr-BajqmWieMaeg-zzkSaKTCE3
X-Proofpoint-ORIG-GUID: R4-d40Jr-BajqmWieMaeg-zzkSaKTCE3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_10,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310100117
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qcom SoCs requires registering ufs driver to PM QoS for random io
performance improvement.

PM QoS initialization will parse all QoS CPU group device tree
entries, allocate memory for each individual PM QoS groups and
initiates DEV_PM_QOS_RESUME_LATENCY type of PM QoS request for
new dev_pm_qos_request handle for each CPU. Voting for maximum
latency S32_MAX during driver init.

tiotest benchmark tool io performance results on sm8550 platform:

1. Without PM QoS support
	Type (Speed in)    | Average of 6 iterations
	Random Write(IPOS) | 32201
	Random Read(IPOS)  | 32201

2. With PM QoS support
	Type (Speed in)    | Average of 6 iterations
	Random Write(IPOS) | 40833.5
	Random Read(IPOS)  | 40833.5
(Improvement % with PM QoS = ~20%).

Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Signed-off-by: Maramaina Naresh <quic_mnaresh@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 152 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/ufs/host/ufs-qcom.h |  29 +++++++++
 2 files changed, 181 insertions(+)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 2128db0..f3e1e81 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2013-2016, Linux Foundation. All rights reserved.
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/acpi.h>
@@ -15,6 +16,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/reset-controller.h>
 #include <linux/devfreq.h>
+#include <linux/cpu.h>
 
 #include <soc/qcom/ice.h>
 
@@ -736,6 +738,53 @@ static void ufs_qcom_device_reset_ctrl(struct ufs_hba *hba, bool asserted)
 	gpiod_set_value_cansleep(host->device_reset, asserted);
 }
 
+/**
+ * ufs_qcom_qos_add_cpu_group - inserts QoS CPU group requests into the QoS list
+ * @qcg: pointer to QoS CPU group
+ * @type: defines the qos request
+ *
+ * Returns 0 for success and non-zero for failure.
+ */
+static int ufs_qcom_qos_add_cpu_group(struct ufs_qcom_qcg *qcg,
+				      enum constraint type)
+{
+	struct dev_pm_qos_request *qos_req = qcg->qos_req;
+	struct device *dev = qcg->host->hba->dev;
+	int cpu;
+	int ret;
+
+	for_each_cpu(cpu, &qcg->mask) {
+		dev_dbg(dev, "cpu: %d | assoc-qos-req: 0x%p\n",
+			cpu, qos_req);
+		ret = dev_pm_qos_add_request(get_cpu_device(cpu),
+					     qos_req,
+					     DEV_PM_QOS_RESUME_LATENCY,
+					     type);
+		if (ret < 0) {
+			dev_err(dev, "Add qos request has failed %d\n",
+				ret);
+			return ret;
+		}
+
+		qos_req++;
+	}
+
+	return 0;
+}
+
+/**
+ * ufs_qcom_qos_remove_cpu_group - removes QoS CPU group requests in QoS list
+ * @qcg: pointer to QoS CPU group
+ */
+static void ufs_qcom_qos_remove_cpu_group(struct ufs_qcom_qcg *qcg)
+{
+	struct dev_pm_qos_request *qos_req = qcg->qos_req;
+	int cpu;
+
+	for_each_cpu(cpu, &qcg->mask)
+		dev_pm_qos_remove_request(qos_req++);
+}
+
 static int ufs_qcom_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op,
 	enum ufs_notify_change_status status)
 {
@@ -1175,6 +1224,107 @@ static int ufs_qcom_icc_init(struct ufs_qcom_host *host)
 }
 
 /**
+ * ufs_qcom_qos_exit - de-allocate QoS instances
+ * @hba: per adapter instance
+ */
+static void ufs_qcom_qos_exit(struct ufs_hba *hba)
+{
+	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+	struct list_head *head = &host->qos_list_head;
+	struct ufs_qcom_qcg *qcg;
+	struct ufs_qcom_qcg *tmp;
+
+	if (list_empty(head))
+		return;
+
+	list_for_each_entry_safe(qcg, tmp, head, list) {
+		if (qcg->qos_req) {
+			ufs_qcom_qos_remove_cpu_group(qcg);
+			kfree(qcg->qos_req);
+		}
+
+		list_del(&qcg->list);
+		kfree(qcg);
+	}
+}
+
+/**
+ * ufs_qcom_qos_init - initialize QoS instances
+ * @hba: host controller instance
+ *
+ * This function parses all QoS CPU group dt entries, allocates memory for
+ * each individual groups and initiates a qos request for each bit of CPU
+ * mask. As part of init all qos requests are initialized with the maximum
+ * delay aggregated constraint value.
+ */
+static void ufs_qcom_qos_init(struct ufs_hba *hba)
+{
+	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+	struct device *dev = hba->dev;
+	struct device_node *np = dev->of_node;
+	struct device_node *group_node;
+	struct ufs_qcom_qcg *qcg;
+	cpumask_t mask;
+	char buf[10];
+	u32 cpumask = 0;
+	u32 vote = 0;
+	int ret;
+
+	INIT_LIST_HEAD(&host->qos_list_head);
+
+	for_each_available_child_of_node(np, group_node) {
+		if (!strstr(group_node->name, "qos"))
+			continue;
+
+		of_property_read_u32(group_node, "cpumask", &cpumask);
+		sprintf(buf, "%x", cpumask);
+		cpumask_parse(buf, &mask);
+		if (!cpumask || !cpumask_subset(&mask, cpu_possible_mask)) {
+			dev_err(dev, "Invalid group mask\n");
+			goto out_err;
+		}
+
+		of_property_read_u32(group_node, "vote", &vote);
+		if (!vote) {
+			dev_err(dev, "1 vote is needed, bailing out: %u\n",
+				vote);
+			goto out_err;
+		}
+
+		qcg = kzalloc(sizeof(*qcg), GFP_KERNEL);
+		if (!qcg)
+			goto out_err;
+
+		list_add_tail(&qcg->list, &host->qos_list_head);
+		cpumask_copy(&qcg->mask, &mask);
+		qcg->vote = vote;
+		qcg->host = host;
+		qcg->qos_req = kcalloc(cpumask_weight(&qcg->mask),
+				       sizeof(struct dev_pm_qos_request),
+				       GFP_KERNEL);
+		if (!qcg->qos_req)
+			goto out_err;
+
+		dev_dbg(dev, "qcg: 0x%p | mask-wt: %u | qos_req: 0x%p | vote: %u\n",
+			qcg, cpumask_weight(&qcg->mask),
+			qcg->qos_req, qcg->vote);
+
+		ret = ufs_qcom_qos_add_cpu_group(qcg, S32_MAX);
+		if (ret < 0)
+			goto out_err;
+	}
+
+	if (list_empty(&host->qos_list_head)) {
+		dev_info(dev, "QoS groups undefined\n");
+		return;
+	}
+	return;
+
+out_err:
+	ufs_qcom_qos_exit(hba);
+}
+
+/**
  * ufs_qcom_init - bind phy with controller
  * @hba: host controller instance
  *
@@ -1298,6 +1448,7 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 	 */
 	host->phy_gear = UFS_HS_G2;
 
+	ufs_qcom_qos_init(hba);
 	return 0;
 
 out_variant_clear:
@@ -2036,6 +2187,7 @@ static void ufs_qcom_remove(struct platform_device *pdev)
 	struct ufs_hba *hba =  platform_get_drvdata(pdev);
 
 	pm_runtime_get_sync(&(pdev)->dev);
+	ufs_qcom_qos_exit(hba);
 	ufshcd_remove(hba);
 	platform_msi_domain_free_irqs(hba->dev);
 }
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 9950a00..e975a5e 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /* Copyright (c) 2013-2015, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef UFS_QCOM_H_
@@ -7,6 +8,7 @@
 
 #include <linux/reset-controller.h>
 #include <linux/reset.h>
+#include <linux/pm_qos.h>
 #include <soc/qcom/ice.h>
 #include <ufs/ufshcd.h>
 
@@ -135,6 +137,31 @@ enum {
 #define PA_VS_CORE_CLK_40NS_CYCLES			0x9007
 #define PA_VS_CORE_CLK_40NS_CYCLES_MASK			GENMASK(6, 0)
 
+/**
+ * struct ufs_qcom_qcg - context of QoS cpu group
+ * @qos_req:	pointer to per cpu pm qos request
+ * @host:	pointer to QCOM host controller instance
+ * @list:	helper for linked list
+ * @mask:	parsed cpumask value from device tree
+ * @vote:	parsed vote value from device tree
+ */
+struct ufs_qcom_qcg {
+	struct dev_pm_qos_request *qos_req;
+	struct ufs_qcom_host *host;
+	struct list_head list;
+	cpumask_t mask;
+	u32 vote;
+};
+
+/**
+ * enum constraint - defines QoS constraint type
+ * @QOS_PERF:	QoS performance mode
+ * @QOS_POWER:	QoS power save mode
+ */
+enum constraint {
+	QOS_PERF,
+	QOS_POWER,
+};
 
 /* QCOM UFS host controller core clk frequencies */
 #define UNIPRO_CORE_CLK_FREQ_37_5_MHZ          38
@@ -239,6 +266,8 @@ struct ufs_qcom_host {
 	struct reset_controller_dev rcdev;
 
 	struct gpio_desc *device_reset;
+	/* QoS list head */
+	struct list_head qos_list_head;
 
 	u32 phy_gear;
 
-- 
2.7.4

