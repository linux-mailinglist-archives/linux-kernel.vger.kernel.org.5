Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D51C80370E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345355AbjLDOia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236099AbjLDOiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:38:18 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A076A3C16;
        Mon,  4 Dec 2023 06:31:55 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4ERbqY018068;
        Mon, 4 Dec 2023 14:31:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=QUCFZf71Zi8Tixij1h1jdelRie3GQ/DKnvw4qTvIlcA=;
 b=cCtihzaf+/UNKnNlHyNy/PXbdiBBc63EwsdbE9pWg917o9kkSpVOm8epgufsWQalEmks
 HaglxFJWpTF3x7KUl9bCYoKM0J7eSIsn1oeXSqIjlYN/JmAsS3BAHNec2cUJ7qiDXjKL
 a5boltzDVxs3Nmo6C/k8rkcHF5ErmgLUuk0j0jnRNUAjt1YQmlgF0i4/ol72BpovYJ4K
 H9jCDuod1jlk13HuCG10YaEjtVnSDwpmiZ8e34R4syGsW6Uk/A25OP3aqhWI1ue3vNrZ
 mGW2XFMm3LViuhTR01loq77GYv9EEFGskFaU+caBE/pfxBfrHLiRAFqFFzy0DBfep+ss Dg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3usghcr0cd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 14:31:36 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B4EVZGe019554
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Dec 2023 14:31:35 GMT
Received: from hu-mnaresh-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 4 Dec 2023 06:31:29 -0800
From:   Maramaina Naresh <quic_mnaresh@quicinc.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Peter Wang <peter.wang@mediatek.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <chu.stanley@gmail.com>
CC:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_cang@quicinc.com>,
        <quic_nguyenb@quicinc.com>, Nitin Rawat <quic_nitirawa@quicinc.com>
Subject: [PATCH V2 1/3] ufs: core: Add CPU latency QoS support for ufs driver
Date:   Mon, 4 Dec 2023 20:00:59 +0530
Message-ID: <20231204143101.64163-2-quic_mnaresh@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204143101.64163-1-quic_mnaresh@quicinc.com>
References: <20231204143101.64163-1-quic_mnaresh@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4g6kFdhW0GWU1fjn6cZ0aserfFbkSVQq
X-Proofpoint-GUID: 4g6kFdhW0GWU1fjn6cZ0aserfFbkSVQq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_13,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2312040108
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register ufs driver to CPU latency PM QoS framework can improves
ufs device random io performance.

PM QoS initialization will insert new QoS request into the CPU
latency QoS list with the maximum latency PM_QOS_DEFAULT_VALUE
value.

UFS driver will vote for performance mode on scale up and power
save mode for scale down.

If clock scaling feature is not enabled then voting will be based
on clock on or off condition.

tiotest benchmark tool io performance results on sm8550 platform:

1. Without PM QoS support
	Type (Speed in)    | Average of 18 iterations
	Random Write(IPOS) | 41065.13
	Random Read(IPOS)  | 37101.3

2. With PM QoS support
	Type (Speed in)    | Average of 18 iterations
	Random Write(IPOS) | 46784.9
	Random Read(IPOS)  | 42943.4
(Improvement % with PM QoS = ~15%).

Co-developed-by: Nitin Rawat <quic_nitirawa@quicinc.com>
Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Signed-off-by: Maramaina Naresh <quic_mnaresh@quicinc.com>
---
 drivers/ufs/core/ufshcd-priv.h |  8 +++++
 drivers/ufs/core/ufshcd.c      | 62 ++++++++++++++++++++++++++++++++++
 include/ufs/ufshcd.h           | 16 +++++++++
 3 files changed, 86 insertions(+)

diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index f42d99ce5bf1..536805f6c4e1 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -241,6 +241,14 @@ static inline void ufshcd_vops_config_scaling_param(struct ufs_hba *hba,
 		hba->vops->config_scaling_param(hba, p, data);
 }
 
+static inline u32 ufshcd_vops_config_qos_vote(struct ufs_hba *hba)
+{
+	if (hba->vops && hba->vops->config_qos_vote)
+		return hba->vops->config_qos_vote(hba);
+
+	return UFSHCD_QOS_DEFAULT_VOTE;
+}
+
 static inline void ufshcd_vops_reinit_notify(struct ufs_hba *hba)
 {
 	if (hba->vops && hba->vops->reinit_notify)
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index ae9936fc6ffb..13370febd2b5 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -1001,6 +1001,20 @@ static bool ufshcd_is_unipro_pa_params_tuning_req(struct ufs_hba *hba)
 	return ufshcd_get_local_unipro_ver(hba) < UFS_UNIPRO_VER_1_6;
 }
 
+/**
+ * ufshcd_pm_qos_perf - vote for PM QoS performance or power save mode
+ * @hba: per adapter instance
+ * @on: If True, vote for perf PM QoS mode otherwise power save mode
+ */
+static void ufshcd_pm_qos_perf(struct ufs_hba *hba, bool on)
+{
+	if (!hba->pm_qos_init)
+		return;
+
+	cpu_latency_qos_update_request(&hba->pm_qos_req, on ? hba->qos_vote
+							: PM_QOS_DEFAULT_VALUE);
+}
+
 /**
  * ufshcd_set_clk_freq - set UFS controller clock frequencies
  * @hba: per adapter instance
@@ -1153,6 +1167,10 @@ static int ufshcd_scale_clks(struct ufs_hba *hba, unsigned long freq,
 	trace_ufshcd_profile_clk_scaling(dev_name(hba->dev),
 			(scale_up ? "up" : "down"),
 			ktime_to_us(ktime_sub(ktime_get(), start)), ret);
+
+	if (!ret)
+		ufshcd_pm_qos_perf(hba, scale_up);
+
 	return ret;
 }
 
@@ -9204,6 +9222,8 @@ static int ufshcd_setup_clocks(struct ufs_hba *hba, bool on)
 	if (ret)
 		return ret;
 
+	if (!ufshcd_is_clkscaling_supported(hba))
+		ufshcd_pm_qos_perf(hba, on);
 out:
 	if (ret) {
 		list_for_each_entry(clki, head, list) {
@@ -9296,6 +9316,45 @@ static int ufshcd_init_clocks(struct ufs_hba *hba)
 	return ret;
 }
 
+/**
+ * ufshcd_pm_qos_init - initialize PM QoS instance
+ * @hba: per adapter instance
+ */
+static void ufshcd_pm_qos_init(struct ufs_hba *hba)
+{
+	if (!(hba->caps & UFSHCD_CAP_PM_QOS))
+		return;
+
+	/*
+	 * called to configure PM QoS vote value for UFS host,
+	 * expecting qos vote return value from caller else
+	 * default vote value will be return.
+	 */
+	hba->qos_vote = ufshcd_vops_config_qos_vote(hba);
+	cpu_latency_qos_add_request(&hba->pm_qos_req,
+					PM_QOS_DEFAULT_VALUE);
+
+	if (cpu_latency_qos_request_active(&hba->pm_qos_req))
+		hba->pm_qos_init = true;
+
+	dev_dbg(hba->dev, "%s: QoS %s, qos_vote: %u\n", __func__,
+		hba->pm_qos_init ? "initialized" : "uninitialized",
+		hba->qos_vote);
+}
+
+/**
+ * ufshcd_pm_qos_exit - remove instance from PM QoS
+ * @hba: per adapter instance
+ */
+static void ufshcd_pm_qos_exit(struct ufs_hba *hba)
+{
+	if (!hba->pm_qos_init)
+		return;
+
+	cpu_latency_qos_remove_request(&hba->pm_qos_req);
+	hba->pm_qos_init = false;
+}
+
 static int ufshcd_variant_hba_init(struct ufs_hba *hba)
 {
 	int err = 0;
@@ -9381,6 +9440,7 @@ static int ufshcd_hba_init(struct ufs_hba *hba)
 static void ufshcd_hba_exit(struct ufs_hba *hba)
 {
 	if (hba->is_powered) {
+		ufshcd_pm_qos_exit(hba);
 		ufshcd_exit_clk_scaling(hba);
 		ufshcd_exit_clk_gating(hba);
 		if (hba->eh_wq)
@@ -10030,6 +10090,7 @@ static int ufshcd_suspend(struct ufs_hba *hba)
 	ufshcd_vreg_set_lpm(hba);
 	/* Put the host controller in low power mode if possible */
 	ufshcd_hba_vreg_set_lpm(hba);
+	ufshcd_pm_qos_perf(hba, false);
 	return ret;
 }
 
@@ -10576,6 +10637,7 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 	ufs_sysfs_add_nodes(hba->dev);
 
 	device_enable_async_suspend(dev);
+	ufshcd_pm_qos_init(hba);
 	return 0;
 
 free_tmf_queue:
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index d862c8ddce03..e9f2bad8934e 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -320,6 +320,9 @@ struct ufs_pwr_mode_info {
  * @phy_initialization: used to initialize phys
  * @device_reset: called to issue a reset pulse on the UFS device
  * @config_scaling_param: called to configure clock scaling parameters
+ * @config_qos_vote: called to configure PM QoS vote value for UFS host,
+ *		     expecting qos vote return value from caller else
+		     default vote value will be return
  * @program_key: program or evict an inline encryption key
  * @event_notify: called to notify important events
  * @reinit_notify: called to notify reinit of UFSHCD during max gear switch
@@ -362,6 +365,7 @@ struct ufs_hba_variant_ops {
 	void	(*config_scaling_param)(struct ufs_hba *hba,
 				struct devfreq_dev_profile *profile,
 				struct devfreq_simple_ondemand_data *data);
+	u32	(*config_qos_vote)(struct ufs_hba *hba);
 	int	(*program_key)(struct ufs_hba *hba,
 			       const union ufs_crypto_cfg_entry *cfg, int slot);
 	void	(*event_notify)(struct ufs_hba *hba,
@@ -720,6 +724,11 @@ enum ufshcd_caps {
 	 * WriteBooster when scaling the clock down.
 	 */
 	UFSHCD_CAP_WB_WITH_CLK_SCALING			= 1 << 12,
+
+	/* This capability allows the host controller driver to use the PM QoS
+	 * feature.
+	 */
+	UFSHCD_CAP_PM_QOS				= 1 << 13,
 };
 
 struct ufs_hba_variant_params {
@@ -793,6 +802,8 @@ enum ufshcd_mcq_opr {
 	OPR_MAX,
 };
 
+#define UFSHCD_QOS_DEFAULT_VOTE 0
+
 /**
  * struct ufs_hba - per adapter private structure
  * @mmio_base: UFSHCI base register address
@@ -912,6 +923,8 @@ enum ufshcd_mcq_opr {
  * @mcq_base: Multi circular queue registers base address
  * @uhq: array of supported hardware queues
  * @dev_cmd_queue: Queue for issuing device management commands
+ * @pm_qos_req: PM QoS request handle
+ * @pm_qos_init: flag to check if pm qos init completed
  */
 struct ufs_hba {
 	void __iomem *mmio_base;
@@ -1076,6 +1089,9 @@ struct ufs_hba {
 	struct ufs_hw_queue *uhq;
 	struct ufs_hw_queue *dev_cmd_queue;
 	struct ufshcd_mcq_opr_info_t mcq_opr[OPR_MAX];
+	struct pm_qos_request pm_qos_req;
+	bool pm_qos_init;
+	u32 qos_vote;
 };
 
 /**
-- 
2.34.1

