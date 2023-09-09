Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9B2799B13
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 22:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344266AbjIIUVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 16:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjIIUVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 16:21:49 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486A4CE1;
        Sat,  9 Sep 2023 13:21:14 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 389KJ9Tl011062;
        Sat, 9 Sep 2023 20:19:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=TbC0LgVICx7ntFXMFzve49qiK3DqPitLLA1eYCd6sfs=;
 b=MV1rksJMLDRhJ1t647YOpjUroJagrP5pNFqXlnMrKBKSwBTNSti76oULO4sISEm5RfsU
 WLS1csdm20mN9RKDtWyaqfW8NUJ44xVj1TEuKcG3aI+K/4AXFXKcXwHYAawQFb3NS6Ql
 3IJaksZ1BqPfcMQKgLWA+s5Dd2qt2LR7UDJz/bI2TUw3dFILOXZ/rOlSbYqzlHF8s1Hl
 VISdQab7bPae/bjmOcAbygFX7Wt0jcHSE/GW/V/d7fVi8xFY2kRVT5hyJTuItUCD5OQZ
 WwWS3/ykdW2jUKsLwZXLZsFufV0Ex/SToNZ6kWeVJwDBimDmpHh5sA70HlOnADegzaIj ug== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t0gt18xdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 09 Sep 2023 20:19:09 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 389KJ8Qp008344
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 9 Sep 2023 20:19:08 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Sat, 9 Sep 2023 13:18:57 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <corbet@lwn.net>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>,
        <vigneshr@ti.com>, <nm@ti.com>, <matthias.bgg@gmail.com>,
        <kgene@kernel.org>, <alim.akhtar@samsung.com>,
        <bmasney@redhat.com>, <quic_tsoni@quicinc.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_mojha@quicinc.com>
Subject: [PATCH v5 16/17] firmware: qcom_scm: Refactor code to support multiple download mode
Date:   Sun, 10 Sep 2023 01:46:17 +0530
Message-ID: <1694290578-17733-17-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1694290578-17733-1-git-send-email-quic_mojha@quicinc.com>
References: <1694290578-17733-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 93kG5iSdQhjyDyETPR2lGeBzK75TYnJE
X-Proofpoint-GUID: 93kG5iSdQhjyDyETPR2lGeBzK75TYnJE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-09_19,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309090187
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently on Qualcomm SoC, download_mode is enabled if
CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT is selected.

Refactor the code such that it supports multiple download
modes and drop CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT config
instead, give interface to set the download mode from
module parameter.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/firmware/Kconfig    | 11 ---------
 drivers/firmware/qcom_scm.c | 56 +++++++++++++++++++++++++++++++++++++++------
 2 files changed, 49 insertions(+), 18 deletions(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index b59e3041fd62..ff7e9f330559 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -215,17 +215,6 @@ config MTK_ADSP_IPC
 config QCOM_SCM
 	tristate
 
-config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
-	bool "Qualcomm download mode enabled by default"
-	depends on QCOM_SCM
-	help
-	  A device with "download mode" enabled will upon an unexpected
-	  warm-restart enter a special debug mode that allows the user to
-	  "download" memory content over USB for offline postmortem analysis.
-	  The feature can be enabled/disabled on the kernel command line.
-
-	  Say Y here to enable "download mode" by default.
-
 config SYSFB
 	bool
 	select BOOT_VESA_SUPPORT
diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index eda92f713019..689bf882cb69 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -20,13 +20,13 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/clk.h>
+#include <linux/kstrtox.h>
 #include <linux/reset-controller.h>
 #include <linux/arm-smccc.h>
 
 #include "qcom_scm.h"
 
-static bool download_mode = IS_ENABLED(CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT);
-module_param(download_mode, bool, 0);
+static u32 download_mode;
 
 #define SCM_HAS_CORE_CLK	BIT(0)
 #define SCM_HAS_IFACE_CLK	BIT(1)
@@ -83,6 +83,11 @@ static const char * const qcom_scm_convention_names[] = {
 	[SMC_CONVENTION_LEGACY] = "smc legacy",
 };
 
+static const char * const download_mode_name[] = {
+	[QCOM_DLOAD_NODUMP]	= "off",
+	[QCOM_DLOAD_FULLDUMP]	= "full",
+};
+
 static struct qcom_scm *__scm;
 static DEFINE_SPINLOCK(lock);
 
@@ -448,9 +453,10 @@ static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
 	return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
 }
 
-static void qcom_scm_set_download_mode(bool enable)
+static void qcom_scm_set_download_mode(u32 download_mode)
 {
-	u32 val = enable ? QCOM_DLOAD_FULLDUMP : QCOM_DLOAD_NODUMP;
+	bool enable = !!download_mode;
+	u32 val = download_mode;
 	bool avail;
 	int ret = 0;
 
@@ -1430,6 +1436,42 @@ static irqreturn_t qcom_scm_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static int get_download_mode(char *buffer, const struct kernel_param *kp)
+{
+	if (download_mode >= ARRAY_SIZE(download_mode_name))
+		return sysfs_emit(buffer, "unknown mode\n");
+
+	return sysfs_emit(buffer, "%s\n", download_mode_name[download_mode]);
+}
+
+static int set_download_mode(const char *val, const struct kernel_param *kp)
+{
+	u32 old = download_mode;
+	int ret;
+
+	ret = sysfs_match_string(download_mode_name, val);
+	if (ret < 0) {
+		download_mode = old;
+		pr_err("qcom_scm: unknown download mode: %s\n", val);
+		return -EINVAL;
+	}
+
+	download_mode = ret;
+	if (__scm)
+		qcom_scm_set_download_mode(download_mode);
+
+	return 0;
+}
+
+static const struct kernel_param_ops download_mode_param_ops = {
+	.get = get_download_mode,
+	.set = set_download_mode,
+};
+
+module_param_cb(download_mode, &download_mode_param_ops, NULL, 0644);
+MODULE_PARM_DESC(download_mode,
+		"download mode: off/full are acceptable values");
+
 static int qcom_scm_probe(struct platform_device *pdev)
 {
 	struct qcom_scm *scm;
@@ -1523,12 +1565,12 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	__get_convention();
 
 	/*
-	 * If requested enable "download mode", from this point on warmboot
+	 * If "download mode" is requested, from this point on warmboot
 	 * will cause the boot stages to enter download mode, unless
 	 * disabled below by a clean shutdown/reboot.
 	 */
 	if (download_mode)
-		qcom_scm_set_download_mode(true);
+		qcom_scm_set_download_mode(download_mode);
 
 	return 0;
 }
@@ -1536,7 +1578,7 @@ static int qcom_scm_probe(struct platform_device *pdev)
 static void qcom_scm_shutdown(struct platform_device *pdev)
 {
 	/* Clean shutdown, disable download mode to allow normal restart */
-	qcom_scm_set_download_mode(false);
+	qcom_scm_set_download_mode(QCOM_DLOAD_NODUMP);
 }
 
 static const struct of_device_id qcom_scm_dt_match[] = {
-- 
2.7.4

