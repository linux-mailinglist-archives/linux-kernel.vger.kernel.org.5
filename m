Return-Path: <linux-kernel+bounces-29661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D1583116D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 03:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFC0D286EB7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155FB5686;
	Thu, 18 Jan 2024 02:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pE1yfG+i"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60D15390;
	Thu, 18 Jan 2024 02:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705545123; cv=none; b=LcjLQRie7AxfU2ngUJUPPmyRFDK3rpayYZ7s6qYzznOAQcD0wteHjo/lRMGP7NtMHEOHTRxxTisfIAjN851SwKt52dmPdNZUipIQwvVa+43C/i8kCEANDF8pJbSLVGw7xZ096fRAbveU8qhUKFpx3T4I3g3wB4G12XYLBTMlQRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705545123; c=relaxed/simple;
	bh=2AFiLHPjv11J5wgd2yLlbYm0jjajl8MOIi/30DgAQas=;
	h=Received:DKIM-Signature:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:X-B4-Tracking:To:CC:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=b7aPWnOW7mjl221n616CvUbCwi2s+2xhaAFQPgjrSBNASt3I0RmgdB4VUcLZb05Khjl/cR4JbCXKMQbtbykIoXDZbvqgxQrENqfCIDRAooPTxJE+tL3f94crvPRMqhbpxa7eMBSmuKmjXq/pD9zfbow2WHjAIHSKQDWnH/p1mpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pE1yfG+i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40I1agoa020450;
	Thu, 18 Jan 2024 02:31:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=Zjs
	RlO7mwwosIWBApz90emwsBH9/yq4Qw4oMJBEg/FY=; b=pE1yfG+iit1gpzRNT9b
	N/koBbgJlJQ5FxBmPBVHKuYVa2Nx4IKeAae51nAnFxWbsyYGQ/5MmUXPaMnEwcra
	hSkBfPb3v6IUZhzVWEHvODxuFa4+dpdpD5+jYjhneLFWYjuuq8L01lyFbM9XAWiD
	+B3coNZS1Ye5bB9PThHt/k9PSDjSrMU1R4vBmGQUWtRy9qENvO11ZF7Rd0AbANaR
	AP5px97zG4RPzcoOWNgLjKwPhv2WXHYqlcMO9HLlKLUjnSY5Jgk2l22roXKtk+s5
	jKk+QH8rNrXd9SQ9YSOHvzp0HRyhQVySwuyWbZCuX99QeZag5z6ajoQPyoTPmzCh
	ObA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vpkjrgytq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 02:31:54 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40I2Vrsb022862
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 02:31:53 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 17 Jan
 2024 18:31:52 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Wed, 17 Jan 2024 18:31:52 -0800
Subject: [PATCH v3] soc: qcom: aoss: Add debugfs interface for sending
 messages
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240117-qcom-aoss-debugfs-v2-v3-1-1aa779124822@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAJeNqGUC/zXNyw6CMBCF4Vchs3ZIL5CCK9/DGFPKAGNiC60QE
 8K7W01cfov/nB0SRaYE52KHSBsnDj5Dnwpwk/UjIffZoISqhJQGFxeeaENK2FO3jkPCTWFNqu5
 kqyuSLeR0jjTw+zd7vWUPMUevKZL9j2nRSKlE3ei2NMpoo1HjsrK7d48Qre/p8hV7V+ZDOI4P/
 zYpXKoAAAA=
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andrew
 Lunn" <andrew@lunn.ch>,
        Stephen Hemminger <stephen@networkplumber.org>,
        "Bjorn Andersson" <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705545112; l=4990;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=2AFiLHPjv11J5wgd2yLlbYm0jjajl8MOIi/30DgAQas=;
 b=m07jczbIJNa+DgqN8D2Jq8F/8p/Hrf5M8BRGa/9F9IMqKgYEBdP09laSEDIRna4rp7IlhO2Bq
 OwKvsSZhU8mDuyX7/Kjg3Yai05oeECVqIweMLzkHCJoYmWqziWN8JeK
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BlxtklgZSl4ljmdi-wkohFquv5gfiuyx
X-Proofpoint-GUID: BlxtklgZSl4ljmdi-wkohFquv5gfiuyx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_14,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 mlxlogscore=999 clxscore=1011 malwarescore=0 priorityscore=1501
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401180015

In addition to the normal runtime commands, the Always On Processor
(AOP) provides a number of debug commands which can be used during
system debugging for things such as preventing power collapse or placing
floor votes for certain resources. Some of these are documented in the
Robotics RB5 "Debug AOP ADB" linked below.

Provide a debugfs interface for the developer/tester to send some of
these commands to the AOP, which allow the user to override the DDR
frequency, preventing power collapse of cx and ddr, and prevent AOSS
from going to sleep.

Link: https://docs.qualcomm.com/bundle/publicresource/topics/80-88500-3/85_Debugging_AOP_ADB.html
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
Changes in v3:
- Stop passing command string straight from userspace to the firmware
- Format the commands in the driver instead
- Provide a few useful commands
- Link to v2: https://lore.kernel.org/linux-arm-msm/20230811205839.727373-3-quic_bjorande@quicinc.com/
---
 drivers/soc/qcom/qcom_aoss.c | 94 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
index aff0cfb71482..30c7d59d3424 100644
--- a/drivers/soc/qcom/qcom_aoss.c
+++ b/drivers/soc/qcom/qcom_aoss.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2019, Linaro Ltd
  */
 #include <linux/clk-provider.h>
+#include <linux/debugfs.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/mailbox_client.h>
@@ -44,6 +45,8 @@
 
 #define QMP_NUM_COOLING_RESOURCES	2
 
+#define QMP_DEBUGFS_FILES		4
+
 static bool qmp_cdev_max_state = 1;
 
 struct qmp_cooling_device {
@@ -82,6 +85,8 @@ struct qmp {
 
 	struct clk_hw qdss_clk;
 	struct qmp_cooling_device *cooling_devs;
+	struct dentry *debugfs_root;
+	struct dentry *debugfs_files[QMP_DEBUGFS_FILES];
 };
 
 static void qmp_kick(struct qmp *qmp)
@@ -475,6 +480,91 @@ void qmp_put(struct qmp *qmp)
 }
 EXPORT_SYMBOL_GPL(qmp_put);
 
+struct qmp_debugfs_entry {
+	const char *name;
+	const char *fmt;
+	bool is_bool;
+	const char *true_val;
+	const char *false_val;
+};
+
+static const struct qmp_debugfs_entry qmp_debugfs_entries[QMP_DEBUGFS_FILES] = {
+	{ "ddr_frequency_mhz", "{class: ddr, res: fixed, val: %u}", false },
+	{ "prevent_aoss_sleep", "{class: aoss_slp, res: sleep: %s}", true, "enable", "disable" },
+	{ "prevent_cx_collapse", "{class: cx_mol, res: cx, val: %s}", true, "mol", "off" },
+	{ "prevent_ddr_collapse", "{class: ddr_mol, res: ddr, val: %s}", true, "mol", "off" },
+};
+
+static ssize_t qmp_debugfs_write(struct file *file, const char __user *user_buf,
+				 size_t count, loff_t *pos)
+{
+	const struct qmp_debugfs_entry *entry = NULL;
+	struct qmp *qmp = file->private_data;
+	char buf[QMP_MSG_LEN];
+	unsigned int uint_val;
+	const char *str_val;
+	bool bool_val;
+	int ret;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(qmp->debugfs_files); i++) {
+		if (qmp->debugfs_files[i] == file->f_path.dentry) {
+			entry = &qmp_debugfs_entries[i];
+			break;
+		}
+	}
+	if (WARN_ON(!entry))
+		return -EFAULT;
+
+	if (entry->is_bool) {
+		ret = kstrtobool_from_user(user_buf, count, &bool_val);
+		if (ret)
+			return ret;
+
+		str_val = bool_val ? entry->true_val : entry->false_val;
+
+		ret = snprintf(buf, sizeof(buf), entry->fmt, str_val);
+		if (ret >= sizeof(buf))
+			return -EINVAL;
+	} else {
+		ret = kstrtou32_from_user(user_buf, count, 0, &uint_val);
+		if (ret)
+			return ret;
+
+		ret = snprintf(buf, sizeof(buf), entry->fmt, uint_val);
+		if (ret >= sizeof(buf))
+			return -EINVAL;
+	}
+
+	ret = qmp_send(qmp, buf);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static const struct file_operations qmp_debugfs_fops = {
+	.open = simple_open,
+	.write = qmp_debugfs_write,
+};
+
+static void qmp_debugfs_create(struct qmp *qmp)
+{
+	const struct qmp_debugfs_entry *entry;
+	int i;
+
+	qmp->debugfs_root = debugfs_create_dir("qcom_aoss", NULL);
+
+	for (i = 0; i < ARRAY_SIZE(qmp->debugfs_files); i++) {
+		entry = &qmp_debugfs_entries[i];
+
+		qmp->debugfs_files[i] = debugfs_create_file(entry->name, 0220,
+							    qmp->debugfs_root,
+							    qmp,
+							    &qmp_debugfs_fops);
+	}
+}
+
 static int qmp_probe(struct platform_device *pdev)
 {
 	struct qmp *qmp;
@@ -523,6 +613,8 @@ static int qmp_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, qmp);
 
+	qmp_debugfs_create(qmp);
+
 	return 0;
 
 err_close_qmp:
@@ -537,6 +629,8 @@ static void qmp_remove(struct platform_device *pdev)
 {
 	struct qmp *qmp = platform_get_drvdata(pdev);
 
+	debugfs_remove_recursive(qmp->debugfs_root);
+
 	qmp_qdss_clk_remove(qmp);
 	qmp_cooling_devices_remove(qmp);
 

---
base-commit: 943b9f0ab2cfbaea148dd6ac279957eb08b96904
change-id: 20240117-qcom-aoss-debugfs-v2-5e25b1934e19

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>


