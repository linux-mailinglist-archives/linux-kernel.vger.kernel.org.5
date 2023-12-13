Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6F6810EBC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbjLMKnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235390AbjLMKnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:43:25 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1677512A;
        Wed, 13 Dec 2023 02:43:22 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BD4grmg018311;
        Wed, 13 Dec 2023 10:37:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type; s=qcppdkim1; bh=7RPZo/oaHnx2L0e/63ak
        ahSDAT3QJyL4vzFDZgVPJi0=; b=JitczVhhJszYaizHQsRzH74jl9ASTLg0red5
        naRFvk3+3t+e9GvSoNpsWpuYyj/+d6gtR8OTrj05yUFr5Hf1FXbqIUpjZZ8xYEj8
        Aj56Hi/Xz7UA90IbtM0VrztgOTguGIYUqVael2RCI+/s2TClZ1K0rHa0OkNizXWd
        kzvsb43OalQjfry2dO/M8blWk++mK1vx67tmwgUPbHNllXMgtxJQxFaSiCw5PBj1
        OYbvy3vVDMsJwt5uh95ZBohwBvNhJg2mrDrmr2h/2lXaFflDnx5/8qSl952NQzf1
        4WF+cGmoWfgbla8N0uPZxTNEYn7scVwtrzun6dcwy9ioeHvOVQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uy5tvgsys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 10:37:50 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BDAbnxW008730
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 10:37:49 GMT
Received: from hu-mnaresh-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 02:37:44 -0800
From:   Maramaina Naresh <quic_mnaresh@quicinc.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Peter Wang <peter.wang@mediatek.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <stanley.chu@mediatek.com>
CC:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Stanley Jhu <chu.stanley@gmail.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_cang@quicinc.com>,
        <quic_nguyenb@quicinc.com>
Subject: [PATCH V4 1/2] ufs: core: Add CPU latency QoS support for ufs driver
Date:   Wed, 13 Dec 2023 16:06:41 +0530
Message-ID: <20231213103642.15320-2-quic_mnaresh@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231213103642.15320-1-quic_mnaresh@quicinc.com>
References: <20231213103642.15320-1-quic_mnaresh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JsH8iaGtjzl3rdc7Eds5kOfh0gxKMC_E
X-Proofpoint-GUID: JsH8iaGtjzl3rdc7Eds5kOfh0gxKMC_E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312130077
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register ufs driver to CPU latency PM QoS framework to improve
ufs device random io performance.

PM QoS initialization will insert new QoS request into the CPU
latency QoS list with the maximum latency PM_QOS_DEFAULT_VALUE
value.

UFS driver will vote for performance mode on scale up and power
save mode for scale down.

If clock scaling feature is not enabled then voting will be based
on clock on or off condition.

Provided sysfs interface to enable/disable PM QoS feature.

tiotest benchmark tool io performance results on sm8550 platform:

1. Without PM QoS support
	Type (Speed in)    | Average of 18 iterations
	Random Write(IPOS) | 41065.13
	Random Read(IPOS)  | 37101.3

2. With PM QoS support
	Type (Speed in)    | Average of 18 iterations
	Random Write(IPOS) | 46784.9
	Random Read(IPOS)  | 42943.4
(Improvement with PM QoS = ~15%).

Co-developed-by: Nitin Rawat <quic_nitirawa@quicinc.com>
Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Signed-off-by: Maramaina Naresh <quic_mnaresh@quicinc.com>
---
 drivers/ufs/core/ufshcd.c | 127 ++++++++++++++++++++++++++++++++++++++
 include/ufs/ufshcd.h      |   6 ++
 2 files changed, 133 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index ae9936fc6ffb..7318fa480706 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -1001,6 +1001,20 @@ static bool ufshcd_is_unipro_pa_params_tuning_req(struct ufs_hba *hba)
 	return ufshcd_get_local_unipro_ver(hba) < UFS_UNIPRO_VER_1_6;
 }
 
+/**
+ * ufshcd_pm_qos_update - update PM QoS request
+ * @hba: per adapter instance
+ * @on: If True, vote for perf PM QoS mode otherwise power save mode
+ */
+static void ufshcd_pm_qos_update(struct ufs_hba *hba, bool on)
+{
+	if (!hba->pm_qos_enabled)
+		return;
+
+	cpu_latency_qos_update_request(&hba->pm_qos_req, on ? 0
+							: PM_QOS_DEFAULT_VALUE);
+}
+
 /**
  * ufshcd_set_clk_freq - set UFS controller clock frequencies
  * @hba: per adapter instance
@@ -1147,8 +1161,11 @@ static int ufshcd_scale_clks(struct ufs_hba *hba, unsigned long freq,
 					    hba->devfreq->previous_freq);
 		else
 			ufshcd_set_clk_freq(hba, !scale_up);
+		goto out;
 	}
 
+	ufshcd_pm_qos_update(hba, scale_up);
+
 out:
 	trace_ufshcd_profile_clk_scaling(dev_name(hba->dev),
 			(scale_up ? "up" : "down"),
@@ -8615,6 +8632,109 @@ static void ufshcd_set_timestamp_attr(struct ufs_hba *hba)
 	ufshcd_release(hba);
 }
 
+/**
+ * ufshcd_pm_qos_init - initialize PM QoS request
+ * @hba: per adapter instance
+ */
+static void ufshcd_pm_qos_init(struct ufs_hba *hba)
+{
+
+	if (hba->pm_qos_enabled)
+		return;
+
+	cpu_latency_qos_add_request(&hba->pm_qos_req,
+					PM_QOS_DEFAULT_VALUE);
+
+	if (cpu_latency_qos_request_active(&hba->pm_qos_req))
+		hba->pm_qos_enabled = true;
+}
+
+/**
+ * ufshcd_pm_qos_exit - remove request from PM QoS
+ * @hba: per adapter instance
+ */
+static void ufshcd_pm_qos_exit(struct ufs_hba *hba)
+{
+	if (!hba->pm_qos_enabled)
+		return;
+
+	cpu_latency_qos_remove_request(&hba->pm_qos_req);
+	hba->pm_qos_enabled = false;
+}
+
+/**
+ * ufshcd_pm_qos_enable_show - sysfs handler to show pm qos enable value
+ * @dev: device associated with the UFS controller
+ * @attr: sysfs attribute handle
+ * @buf: buffer for sysfs file
+ *
+ * Print 1 if PM QoS feature is enabled, 0 if disabled.
+ *
+ * Returns number of characters written to @buf.
+ */
+static ssize_t ufshcd_pm_qos_enable_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", hba->pm_qos_enabled);
+}
+
+/**
+ * ufshcd_pm_qos_enable_store - sysfs handler to store value
+ * @dev: device associated with the UFS controller
+ * @attr: sysfs attribute handle
+ * @buf: buffer for sysfs file
+ * @count: stores buffer characters count
+ *
+ * Input 0 to disable PM QoS and any non-zero positive value to enable.
+ * Default state: 1
+ *
+ * Return: number of characters written to @buf on success, < 0 upon failure.
+ */
+static ssize_t ufshcd_pm_qos_enable_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+	u32 value;
+
+	if (kstrtou32(buf, 0, &value))
+		return -EINVAL;
+
+	value = !!value;
+	if (value)
+		ufshcd_pm_qos_init(hba);
+	else
+		ufshcd_pm_qos_exit(hba);
+
+	return count;
+}
+
+/**
+ * ufshcd_init_pm_qos_sysfs - initialize PM QoS sysfs entry
+ * @hba: per adapter instance
+ */
+static void ufshcd_init_pm_qos_sysfs(struct ufs_hba *hba)
+{
+	hba->pm_qos_enable_attr.show = ufshcd_pm_qos_enable_show;
+	hba->pm_qos_enable_attr.store = ufshcd_pm_qos_enable_store;
+	sysfs_attr_init(&hba->pm_qos_enable_attr.attr);
+	hba->pm_qos_enable_attr.attr.name = "pm_qos_enable";
+	hba->pm_qos_enable_attr.attr.mode = 0644;
+	if (device_create_file(hba->dev, &hba->pm_qos_enable_attr))
+		dev_err(hba->dev, "Failed to create sysfs for pm_qos_enable\n");
+}
+
+/**
+ * ufshcd_remove_pm_qos_sysfs - remove PM QoS sysfs entry
+ * @hba: per adapter instance
+ */
+static void ufshcd_remove_pm_qos_sysfs(struct ufs_hba *hba)
+{
+	if (hba->pm_qos_enable_attr.attr.name)
+		device_remove_file(hba->dev, &hba->pm_qos_enable_attr);
+}
+
 /**
  * ufshcd_add_lus - probe and add UFS logical units
  * @hba: per-adapter instance
@@ -9204,6 +9324,8 @@ static int ufshcd_setup_clocks(struct ufs_hba *hba, bool on)
 	if (ret)
 		return ret;
 
+	if (!ufshcd_is_clkscaling_supported(hba))
+		ufshcd_pm_qos_update(hba, on);
 out:
 	if (ret) {
 		list_for_each_entry(clki, head, list) {
@@ -9381,6 +9503,8 @@ static int ufshcd_hba_init(struct ufs_hba *hba)
 static void ufshcd_hba_exit(struct ufs_hba *hba)
 {
 	if (hba->is_powered) {
+		ufshcd_remove_pm_qos_sysfs(hba);
+		ufshcd_pm_qos_exit(hba);
 		ufshcd_exit_clk_scaling(hba);
 		ufshcd_exit_clk_gating(hba);
 		if (hba->eh_wq)
@@ -10030,6 +10154,7 @@ static int ufshcd_suspend(struct ufs_hba *hba)
 	ufshcd_vreg_set_lpm(hba);
 	/* Put the host controller in low power mode if possible */
 	ufshcd_hba_vreg_set_lpm(hba);
+	ufshcd_pm_qos_update(hba, false);
 	return ret;
 }
 
@@ -10576,6 +10701,8 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 	ufs_sysfs_add_nodes(hba->dev);
 
 	device_enable_async_suspend(dev);
+	ufshcd_pm_qos_init(hba);
+	ufshcd_init_pm_qos_sysfs(hba);
 	return 0;
 
 free_tmf_queue:
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index d862c8ddce03..fa7434a9073d 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -912,6 +912,9 @@ enum ufshcd_mcq_opr {
  * @mcq_base: Multi circular queue registers base address
  * @uhq: array of supported hardware queues
  * @dev_cmd_queue: Queue for issuing device management commands
+ * @pm_qos_enable_attr: sysfs attribute to enable/disable  pm qos
+ * @pm_qos_req: PM QoS request handle
+ * @pm_qos_enabled: flag to check if pm qos is enabled
  */
 struct ufs_hba {
 	void __iomem *mmio_base;
@@ -1076,6 +1079,9 @@ struct ufs_hba {
 	struct ufs_hw_queue *uhq;
 	struct ufs_hw_queue *dev_cmd_queue;
 	struct ufshcd_mcq_opr_info_t mcq_opr[OPR_MAX];
+	struct device_attribute pm_qos_enable_attr;
+	struct pm_qos_request pm_qos_req;
+	bool pm_qos_enabled;
 };
 
 /**
-- 
2.17.1

