Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96E17DA39D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 00:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346685AbjJ0Whm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 18:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346645AbjJ0Whh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 18:37:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3F610CC;
        Fri, 27 Oct 2023 15:37:29 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RLAsCT025520;
        Fri, 27 Oct 2023 22:37:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : to : cc; s=qcppdkim1;
 bh=NCUz9b0iLJo3KMc94SNgX60olJEN+JVhP2GDvDALu+Y=;
 b=eg9AOA4ueeVVQEs+Qf2DTgz+U2jurzpnTlqrHc7CT7r/vz/0VKdC/rPP6jOgIl3yV+/+
 6dL2FO/8tCNBiMyUIKHqag51mJOTf07sxULXv5nzhoEDAVAF1Dd1xAAk77OX7F0eCDBA
 0ZNvwiASfJfamIs29Gcm0shhbdAcmNg2SE8fSwLu+u8WyCD09dh0nHuNg8rDdy44GP7U
 DDVXSgT/gXrm75Ri3oTW2hNoxPd9sefJW3qhsxvfZaV+fLgLIh8wQARRZ97ntOoNmG6F
 IHuhMOFhNrwVfI4qzWBRtgD99Py7w8BUZoZFXLCLFm3Q+Ah1RsRgreAu8pGtiQituZdH cw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tywvtb906-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 22:37:26 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39RMbPfm002402
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 22:37:25 GMT
Received: from hu-gurus-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 27 Oct 2023 15:37:22 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
Date:   Fri, 27 Oct 2023 15:37:21 -0700
Subject: [PATCH] firmware: qcom-scm: Support multiple waitq contexts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231027-multi-wqs-v1-1-d47cd7f3590f@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAKA7PGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDAyNz3dzSnJJM3fLCYl2LJAvztGSDFOMkU2MloPqCotS0zAqwWdGxtbU
 AMja7r1sAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, Guru Das Srinagesh <quic_gurus@quicinc.com>
X-Mailer: b4 0.12.3
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wR6iWLX86-h-FkZ7ALV2wssWloxWZ1Or
X-Proofpoint-ORIG-GUID: wR6iWLX86-h-FkZ7ALV2wssWloxWZ1Or
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_21,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310270193
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, only a single waitqueue context is supported (zero). Firmware
now supports multiple waitqueue contexts, so add support to dynamically
create and support as many unique waitqueue contexts as firmware returns
to the driver.

This is done by using the idr framework to create a hash table for
associating a unique wq_ctx with a struct completion variable for easy
lookup.

Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
---
This series is based on the tip of linux-next because a couple of SCM
driver-related patches are still in-flight in Bjorn's tree.
---
 drivers/firmware/qcom/qcom_scm-smc.c |  7 ++-
 drivers/firmware/qcom/qcom_scm.c     | 90 +++++++++++++++++++++++++++---------
 drivers/firmware/qcom/qcom_scm.h     |  3 +-
 3 files changed, 77 insertions(+), 23 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm-smc.c b/drivers/firmware/qcom/qcom_scm-smc.c
index 16cf88acfa8e..80083e3615b1 100644
--- a/drivers/firmware/qcom/qcom_scm-smc.c
+++ b/drivers/firmware/qcom/qcom_scm-smc.c
@@ -103,7 +103,12 @@ static int __scm_smc_do_quirk_handle_waitq(struct device *dev, struct arm_smccc_
 			wq_ctx = res->a1;
 			smc_call_ctx = res->a2;
 
-			ret = qcom_scm_wait_for_wq_completion(wq_ctx);
+			if (!dev) {
+				/* Protect the dev_get_drvdata() call that follows */
+				return -EPROBE_DEFER;
+			}
+
+			ret = qcom_scm_wait_for_wq_completion(dev_get_drvdata(dev), wq_ctx);
 			if (ret)
 				return ret;
 
diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 520de9b5633a..70f0c35beb16 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -10,6 +10,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/export.h>
 #include <linux/firmware/qcom/qcom_scm.h>
+#include <linux/idr.h>
 #include <linux/init.h>
 #include <linux/interconnect.h>
 #include <linux/interrupt.h>
@@ -27,13 +28,18 @@
 static bool download_mode = IS_ENABLED(CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT);
 module_param(download_mode, bool, 0);
 
+struct qcom_scm_waitq {
+	struct idr idr;
+	spinlock_t idr_lock;
+};
+
 struct qcom_scm {
 	struct device *dev;
 	struct clk *core_clk;
 	struct clk *iface_clk;
 	struct clk *bus_clk;
 	struct icc_path *path;
-	struct completion waitq_comp;
+	struct qcom_scm_waitq waitq;
 	struct reset_controller_dev reset;
 
 	/* control access to the interconnect path */
@@ -1742,42 +1748,76 @@ bool qcom_scm_is_available(void)
 }
 EXPORT_SYMBOL_GPL(qcom_scm_is_available);
 
-static int qcom_scm_assert_valid_wq_ctx(u32 wq_ctx)
+static struct completion *qcom_scm_get_completion(struct qcom_scm *scm, u32 wq_ctx)
 {
-	/* FW currently only supports a single wq_ctx (zero).
-	 * TODO: Update this logic to include dynamic allocation and lookup of
-	 * completion structs when FW supports more wq_ctx values.
+	struct completion *wq;
+	unsigned long flags;
+	int err;
+
+	spin_lock_irqsave(&scm->waitq.idr_lock, flags);
+	wq = idr_find(&scm->waitq.idr, wq_ctx);
+	if (wq) {
+		/*
+		 * Valid struct completion *wq found corresponding to
+		 * given wq_ctx. We're done here.
+		 */
+		goto out;
+	}
+
+	/*
+	 * If a struct completion *wq does not exist for wq_ctx, create it. FW
+	 * only uses a finite number of wq_ctx values, so we will be reaching
+	 * here only a few times right at the beginning of the device's uptime
+	 * and then early-exit from idr_find() above subsequently.
 	 */
-	if (wq_ctx != 0) {
-		dev_err(__scm->dev, "Firmware unexpectedly passed non-zero wq_ctx\n");
-		return -EINVAL;
+	wq = devm_kzalloc(scm->dev, sizeof(*wq), GFP_ATOMIC);
+	if (!wq) {
+		wq = ERR_PTR(-ENOMEM);
+		goto out;
 	}
 
-	return 0;
+	init_completion(wq);
+
+	err = idr_alloc_u32(&scm->waitq.idr, wq, &wq_ctx, wq_ctx, GFP_ATOMIC);
+	if (err < 0) {
+		/* Don't wait for driver to be unloaded to free wq */
+		devm_kfree(scm->dev, wq);
+		wq = ERR_PTR(err);
+	}
+
+out:
+	spin_unlock_irqrestore(&scm->waitq.idr_lock, flags);
+	return wq;
 }
 
-int qcom_scm_wait_for_wq_completion(u32 wq_ctx)
+int qcom_scm_wait_for_wq_completion(struct qcom_scm *scm, u32 wq_ctx)
 {
-	int ret;
+	struct completion *wq;
 
-	ret = qcom_scm_assert_valid_wq_ctx(wq_ctx);
-	if (ret)
-		return ret;
+	wq = qcom_scm_get_completion(scm, wq_ctx);
+	if (IS_ERR(wq)) {
+		pr_err("Unable to wait on invalid waitqueue for wq_ctx %d: %ld\n",
+				wq_ctx, PTR_ERR(wq));
+		return PTR_ERR(wq);
+	}
 
-	wait_for_completion(&__scm->waitq_comp);
+	wait_for_completion(wq);
 
 	return 0;
 }
 
 static int qcom_scm_waitq_wakeup(struct qcom_scm *scm, unsigned int wq_ctx)
 {
-	int ret;
+	struct completion *wq;
 
-	ret = qcom_scm_assert_valid_wq_ctx(wq_ctx);
-	if (ret)
-		return ret;
+	wq = qcom_scm_get_completion(scm, wq_ctx);
+	if (IS_ERR(wq)) {
+		pr_err("Unable to wake up invalid waitqueue for wq_ctx %d: %ld\n",
+				wq_ctx, PTR_ERR(wq));
+		return PTR_ERR(wq);
+	}
 
-	complete(&__scm->waitq_comp);
+	complete(wq);
 
 	return 0;
 }
@@ -1854,10 +1894,13 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	platform_set_drvdata(pdev, scm);
+
 	__scm = scm;
 	__scm->dev = &pdev->dev;
 
-	init_completion(&__scm->waitq_comp);
+	spin_lock_init(&__scm->waitq.idr_lock);
+	idr_init(&__scm->waitq.idr);
 
 	irq = platform_get_irq_optional(pdev, 0);
 	if (irq < 0) {
@@ -1905,8 +1948,13 @@ static int qcom_scm_probe(struct platform_device *pdev)
 
 static void qcom_scm_shutdown(struct platform_device *pdev)
 {
+	struct qcom_scm *scm;
+
+	scm = platform_get_drvdata(pdev);
+
 	/* Clean shutdown, disable download mode to allow normal restart */
 	qcom_scm_set_download_mode(false);
+	idr_destroy(&scm->waitq.idr);
 }
 
 static const struct of_device_id qcom_scm_dt_match[] = {
diff --git a/drivers/firmware/qcom/qcom_scm.h b/drivers/firmware/qcom/qcom_scm.h
index 4532907e8489..d54df5a2b690 100644
--- a/drivers/firmware/qcom/qcom_scm.h
+++ b/drivers/firmware/qcom/qcom_scm.h
@@ -62,7 +62,8 @@ struct qcom_scm_res {
 	u64 result[MAX_QCOM_SCM_RETS];
 };
 
-int qcom_scm_wait_for_wq_completion(u32 wq_ctx);
+struct qcom_scm;
+int qcom_scm_wait_for_wq_completion(struct qcom_scm *scm, u32 wq_ctx);
 int scm_get_wq_ctx(u32 *wq_ctx, u32 *flags, u32 *more_pending);
 
 #define SCM_SMC_FNID(s, c)	((((s) & 0xFF) << 8) | ((c) & 0xFF))

---
base-commit: 2ef7141596eed0b4b45ef18b3626f428a6b0a822
change-id: 20231027-multi-wqs-8b87fc0d3b53

Best regards,
-- 
Guru Das Srinagesh <quic_gurus@quicinc.com>

