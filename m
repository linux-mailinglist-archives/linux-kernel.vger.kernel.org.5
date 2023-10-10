Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27A27C00C1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbjJJPuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbjJJPuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:50:32 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B50EC9;
        Tue, 10 Oct 2023 08:50:25 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39AEKYiC023864;
        Tue, 10 Oct 2023 15:50:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=HNT/T5OczMa41UhLCO2rAloksDtU7rqJOiLETgmFOM0=;
 b=os+F3tv57o6X4MNUTHx0rGOGU6ZQ1hUyLCHjeuPcinqT5g0EeBSaGT8VoCewHcPNG6TR
 p4PxkTThMnGKVrRUl6TDfq/qL2wVeJ7559wKI/azWNN9QopuGM/Q8+o/PKb+2TxLl1ZP
 YVl9i+FDcqTSCgOGgjpkhO1ov/JL8MEn6z65xj7aEWZTWm6aqZxCwMQiTZuvYhT3TNIn
 03sQ6nAMlyhk1k7hQ203XgRL7crr90hZXlG2RaFhUFstXV3ekBzryaht53KBu2WxMFua
 r40TBh9i/pqm76d6SXLxpDmYpxt9DSi9lnFWg6DpGv1pUvOQKi+BJoGe5jdGrHnGXHZR Gw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tmyma993k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 15:50:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39AFo8Ms031233
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 15:50:08 GMT
Received: from hu-mnaresh-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 10 Oct 2023 08:50:01 -0700
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
Subject: [PATCH V1 3/4] ufs: ufs-qcom: Add per-cpu PM QoS vote support for ufs
Date:   Tue, 10 Oct 2023 21:19:06 +0530
Message-ID: <1696952947-18062-4-git-send-email-quic_mnaresh@quicinc.com>
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
X-Proofpoint-ORIG-GUID: zoCba7IM8mX8MusTIugiOs7X7R9IR2ri
X-Proofpoint-GUID: zoCba7IM8mX8MusTIugiOs7X7R9IR2ri
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_11,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 spamscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310100117
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PM QoS per-cpu framework provides performance requirements for each cpu.

The per-cpu PM QoS framework will provide the corresponding interface to
collect the resume_latency request of the specified device and provide
it to the runtime PM. When suspending the device, it will consider this
requirement and decide whether to suspend the device.

Voting will follow below sequence.
1. Vote for maximum latency S32_MAX in driver init.
2. Schedule a vote of PERF when a transfer request is received.
3. Update the vote to S32_MAX during clock gating.

Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Signed-off-by: Maramaina Naresh <quic_mnaresh@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 188 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/ufs/host/ufs-qcom.h |   8 ++
 2 files changed, 195 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index f3e1e81..2123e8e 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -17,6 +17,7 @@
 #include <linux/reset-controller.h>
 #include <linux/devfreq.h>
 #include <linux/cpu.h>
+#include <linux/blk-mq.h>
 
 #include <soc/qcom/ice.h>
 
@@ -27,6 +28,8 @@
 #include <ufs/ufshci.h>
 #include <ufs/ufs_quirks.h>
 
+#include <scsi/scsi_cmnd.h>
+
 #define MCQ_QCFGPTR_MASK	GENMASK(7, 0)
 #define MCQ_QCFGPTR_UNIT	0x200
 #define MCQ_SQATTR_OFFSET(c) \
@@ -96,6 +99,9 @@ static struct ufs_qcom_host *ufs_qcom_hosts[MAX_UFS_QCOM_HOSTS];
 
 static void ufs_qcom_get_default_testbus_cfg(struct ufs_qcom_host *host);
 static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba, bool is_scale_up);
+static int ufs_qcom_update_qos_constraints(struct ufs_qcom_qcg *qcg,
+					   enum constraint type);
+static int ufs_qcom_qos_unvote_all(struct ufs_qcom_host *host);
 
 static struct ufs_qcom_host *rcdev_to_ufs_host(struct reset_controller_dev *rcd)
 {
@@ -790,6 +796,7 @@ static int ufs_qcom_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op,
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
 	struct phy *phy = host->generic_phy;
+	int ret;
 
 	if (status == PRE_CHANGE)
 		return 0;
@@ -810,7 +817,11 @@ static int ufs_qcom_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op,
 		ufs_qcom_disable_lane_clks(host);
 	}
 
-	return ufs_qcom_ice_suspend(host);
+	ret = ufs_qcom_ice_suspend(host);
+	if (ret)
+		return ret;
+
+	return ufs_qcom_qos_unvote_all(host);
 }
 
 static int ufs_qcom_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
@@ -840,6 +851,33 @@ static int ufs_qcom_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 	return ufs_qcom_ice_resume(host);
 }
 
+/**
+ * ufs_qcom_qos_unvote_all - unvote QoS for all cpu groups
+ * @host: qcom host controller instance
+ */
+static int ufs_qcom_qos_unvote_all(struct ufs_qcom_host *host)
+{
+	struct list_head *head = &host->qos_list_head;
+	struct ufs_qcom_qcg *qcg;
+	int ret = 0;
+
+	if (list_empty(head))
+		return ret;
+
+	list_for_each_entry(qcg, head, list) {
+		flush_work(&qcg->vwork);
+		if (!qcg->voted)
+			continue;
+
+		ret = ufs_qcom_update_qos_constraints(qcg, QOS_POWER);
+		if (ret)
+			dev_err(host->hba->dev, "Failed to update qos constraints, %d\n",
+				ret);
+	}
+
+	return ret;
+}
+
 static void ufs_qcom_dev_ref_clk_ctrl(struct ufs_qcom_host *host, bool enable)
 {
 	if (host->dev_ref_clk_ctrl_mmio &&
@@ -1157,6 +1195,7 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
 		} else {
 			ufs_qcom_icc_set_bw(host, ufs_qcom_bw_table[MODE_MIN][0][0].mem_bw,
 					    ufs_qcom_bw_table[MODE_MIN][0][0].cfg_bw);
+			ufs_qcom_qos_unvote_all(host);
 		}
 		break;
 	}
@@ -1224,6 +1263,144 @@ static int ufs_qcom_icc_init(struct ufs_qcom_host *host)
 }
 
 /**
+ * ufs_qcom_tag_to_cpu - get CPU number for given request tag
+ * @hba: host controller instance
+ * @tag: defines block request id
+ *
+ * Returns 0 or posstive value for success and negative value
+ * for failure.
+ */
+static int ufs_qcom_tag_to_cpu(struct ufs_hba *hba, unsigned int tag)
+{
+	struct ufshcd_lrb *lrbp = &hba->lrb[tag];
+
+	if (lrbp && lrbp->cmd && scsi_cmd_to_rq(lrbp->cmd))
+		return blk_mq_rq_cpu(scsi_cmd_to_rq(lrbp->cmd));
+
+	return -EINVAL;
+}
+
+/**
+ * ufs_qcom_cpu_to_qos_group - returns QoS group address for given CPU number
+ * @host: qcom host controller instance
+ * @cpu: stores CPU number
+ *
+ * Returns ufs_qcom_qcg address for success and NULL for failure.
+ */
+static struct ufs_qcom_qcg *ufs_qcom_cpu_to_qos_group(struct ufs_qcom_host *host,
+						      unsigned int cpu)
+{
+	struct list_head *head = &host->qos_list_head;
+	struct ufs_qcom_qcg *qcg;
+
+	if (cpu > num_possible_cpus())
+		return NULL;
+
+	list_for_each_entry(qcg, head, list) {
+		if (cpumask_test_cpu(cpu, &qcg->mask))
+			return qcg;
+	}
+
+	return NULL;
+}
+
+/**
+ * ufs_qcom_update_qos_constraints - update constraints for QoS group
+ * @qcg: pointer to QoS CPU group
+ * @type: defines the qos request
+ *
+ * Returns 0 for success and non-zero for failure.
+ */
+static int ufs_qcom_update_qos_constraints(struct ufs_qcom_qcg *qcg,
+					   enum constraint type)
+{
+	struct dev_pm_qos_request *qos_req = qcg->qos_req;
+	struct device *dev = qcg->host->hba->dev;
+	unsigned int vote;
+	int cpu;
+	int ret;
+
+	if (type == QOS_POWER)
+		vote = S32_MAX;
+	else
+		vote = qcg->vote;
+
+	if (qcg->curr_vote == vote)
+		return 0;
+
+	for_each_cpu(cpu, &qcg->mask) {
+		dev_dbg(dev, "%s: vote: %d | cpu: %d | qos_req: 0x%p\n",
+			__func__, vote, cpu, qos_req);
+		ret = dev_pm_qos_update_request(qos_req, vote);
+		if (ret < 0)
+			return ret;
+
+		++qos_req;
+	}
+
+	if (type == QOS_POWER)
+		qcg->voted = false;
+	else
+		qcg->voted = true;
+	qcg->curr_vote = vote;
+
+	return 0;
+}
+
+/**
+ * ufs_qcom_setup_xfer_req - setup QoS before transfer request is issued
+ *			and initiates QoS vote process for given tag
+ * @hba: host controller instance
+ * @tag: defines block request id
+ * @is_scsi_cmd: tells scsi cmd or not
+ *
+ * Returns 0 for success and non-zero for failure.
+ */
+static void ufs_qcom_setup_xfer_req(struct ufs_hba *hba, int tag, bool is_scsi_cmd)
+{
+	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+	struct list_head *head = &host->qos_list_head;
+	struct ufs_qcom_qcg *qcg;
+	int cpu;
+
+	if (list_empty(head))
+		return;
+
+	cpu = ufs_qcom_tag_to_cpu(hba, tag);
+	if (cpu < 0)
+		return;
+
+	qcg = ufs_qcom_cpu_to_qos_group(host, cpu);
+	if (!qcg)
+		return;
+
+	if (qcg->voted) {
+		dev_dbg(hba->dev, "%s: qcg: 0x%p | cpu: %d\n",
+			__func__, qcg, cpu);
+		return;
+	}
+
+	queue_work(host->qos_workq, &qcg->vwork);
+	dev_dbg(hba->dev, "Queued QoS work- cpu: %d\n", cpu);
+}
+
+/**
+ * ufs_qcom_qos_vote_work - starts QoS perf mode vote work
+ * @work: pointer to QoS work
+ */
+static void ufs_qcom_qos_vote_work(struct work_struct *work)
+{
+	struct ufs_qcom_qcg *qcg = container_of(work, struct ufs_qcom_qcg,
+						 vwork);
+	int ret;
+
+	ret = ufs_qcom_update_qos_constraints(qcg, QOS_PERF);
+	if (ret)
+		dev_err(qcg->host->hba->dev, "%s: update qos - failed: %d\n",
+			__func__, ret);
+}
+
+/**
  * ufs_qcom_qos_exit - de-allocate QoS instances
  * @hba: per adapter instance
  */
@@ -1312,12 +1489,20 @@ static void ufs_qcom_qos_init(struct ufs_hba *hba)
 		ret = ufs_qcom_qos_add_cpu_group(qcg, S32_MAX);
 		if (ret < 0)
 			goto out_err;
+
+		INIT_WORK(&qcg->vwork, ufs_qcom_qos_vote_work);
 	}
 
 	if (list_empty(&host->qos_list_head)) {
 		dev_info(dev, "QoS groups undefined\n");
 		return;
 	}
+
+	host->qos_workq = create_singlethread_workqueue("qc_ufs_qos_swq");
+	if (!host->qos_workq) {
+		dev_err(dev, "Failed to create qos workqueue\n");
+		goto out_err;
+	}
 	return;
 
 out_err:
@@ -2148,6 +2333,7 @@ static const struct ufs_hba_variant_ops ufs_hba_qcom_vops = {
 	.dbg_register_dump	= ufs_qcom_dump_dbg_regs,
 	.device_reset		= ufs_qcom_device_reset,
 	.config_scaling_param = ufs_qcom_config_scaling_param,
+	.setup_xfer_req         = ufs_qcom_setup_xfer_req,
 	.program_key		= ufs_qcom_ice_program_key,
 	.reinit_notify		= ufs_qcom_reinit_notify,
 	.mcq_config_resource	= ufs_qcom_mcq_config_resource,
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index e975a5e..4ad2b3e 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -141,16 +141,22 @@ enum {
  * struct ufs_qcom_qcg - context of QoS cpu group
  * @qos_req:	pointer to per cpu pm qos request
  * @host:	pointer to QCOM host controller instance
+ * @vwork:	qos vote work handle
  * @list:	helper for linked list
  * @mask:	parsed cpumask value from device tree
+ * @curr_vote:	current vote value for group
  * @vote:	parsed vote value from device tree
+ * @voted:	vote status
  */
 struct ufs_qcom_qcg {
 	struct dev_pm_qos_request *qos_req;
 	struct ufs_qcom_host *host;
+	struct work_struct vwork;
 	struct list_head list;
 	cpumask_t mask;
+	u32 curr_vote;
 	u32 vote;
+	bool voted;
 };
 
 /**
@@ -268,6 +274,8 @@ struct ufs_qcom_host {
 	struct gpio_desc *device_reset;
 	/* QoS list head */
 	struct list_head qos_list_head;
+	/* QoS workqueue */
+	struct workqueue_struct *qos_workq;
 
 	u32 phy_gear;
 
-- 
2.7.4

