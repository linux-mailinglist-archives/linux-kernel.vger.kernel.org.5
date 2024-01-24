Return-Path: <linux-kernel+bounces-36823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A4283A765
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDE03B226A5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15571AAD2;
	Wed, 24 Jan 2024 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kdcDCVuP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9B9107B6;
	Wed, 24 Jan 2024 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706094029; cv=none; b=hHTaA7AkWxdwkxu4/cxUob9WLnELgZbJj4KZ4zQ1JtZ51GVdUpZFy2Jp2fu2nJ8hSo6y0HpIrUQemCy2wHsgyxbRYBOK2tDETVbM4cmi9t6Iw4M1D3x8cnetKM0jtP5ESSX/XerV5M1fI7UCt9K/3n7tPNof4StoxGyqSzIhaSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706094029; c=relaxed/simple;
	bh=iOU5X2itoyZXD5wlMjCe2idu1N4HYMdwpC/WV3EBbkc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VilZbcvS+AycA4jluSDteXW0jHQMla1I+KBYNQ0g5Oc1YNbhaOy1nk7bRHzzCNOJEwLP9qlNjXYs27RH2E850Ooi5f+N3HJMLUAeyupU0nJa+S8jwGnYw2yTFD1ubELcRg9bCdGPPS1idj2VeyVFWfp7JC91PHr8RFIU3JcNI6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kdcDCVuP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40O9fD86003238;
	Wed, 24 Jan 2024 11:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=TcIwPwxB4omd16Xqf16m06q4Ijkx4xVaRUKgW5goPS8=; b=kd
	cDCVuP2i0gDdLnWibR3iGokEfW3aofZ+m1DkulJFNgVJh0ROf1yNSRsVwsFHHve7
	QzXxpV5S5vASVTciF9CAAebUwRMyNvg03n03pcRl3aErbippm3fhCMqhphTRSzuZ
	ssNzpYJbyuVqZQkdrAwFeGLbS7Nh3H4EQEDDKBZwju2vRBK/jYEDOGebA5MYJBrv
	6c8/7TltKN3Oop5c44gbafdHrO/YQw4SPs8pFH+qiD51mTlnUecP1lin1AtT870+
	ifk7GdC9/pYOJGz6HhPr+gglkAaicAXqlf+iae3oydzND8R8iNapK5BsMuU3u35G
	us6dtIfoVUA66zEiHT/w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vtmgxhhpa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 11:00:07 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40OB06c9015292
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 11:00:06 GMT
Received: from hu-priyjain-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 24 Jan 2024 03:00:01 -0800
From: Priyansh Jain <quic_priyjain@quicinc.com>
To: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath
	<thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad
 Dybcio" <konrad.dybcio@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <quic_manafm@quicinc.com>, <quic_priyjain@quicinc.com>
Subject: [PATCH v2] thermal/drivers/tsens: Add suspend to RAM support for tsens
Date: Wed, 24 Jan 2024 16:29:45 +0530
Message-ID: <20240124105945.5902-1-quic_priyjain@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uMKelpuAyV19RNDaOmbFoyY-qzHfVqEO
X-Proofpoint-GUID: uMKelpuAyV19RNDaOmbFoyY-qzHfVqEO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_05,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401240078

As part of suspend to RAM, system doesn't want to abort suspend
to RAM due to tsens interrupts since system is already going
into lowest power state. Hence disable tsens interrupt during
suspend to RAM callback.

Once it enters to suspend to RAM, tsens hardware will be turned off.
While resume, re-initialize tsens hardware and re-enable tsens
interrupts back.

Signed-off-by: Priyansh Jain <quic_priyjain@quicinc.com>
---
 drivers/thermal/qcom/tsens-v2.c |  2 +
 drivers/thermal/qcom/tsens.c    | 93 +++++++++++++++++++++++++++++++--
 drivers/thermal/qcom/tsens.h    |  7 +++
 3 files changed, 98 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 29a61d2d6ca3..1b74db6299c4 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -107,6 +107,8 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
 static const struct tsens_ops ops_generic_v2 = {
 	.init		= init_common,
 	.get_temp	= get_temp_tsens_valid,
+	.suspend	= tsens_suspend_common,
+	.resume		= tsens_resume_common,
 };
 
 struct tsens_plat_data data_tsens_v2 = {
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 6d7c16ccb44d..603ccb91009d 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -17,6 +17,7 @@
 #include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/suspend.h>
 #include <linux/thermal.h>
 #include "../thermal_hwmon.h"
 #include "tsens.h"
@@ -1153,7 +1154,7 @@ static const struct thermal_zone_device_ops tsens_of_ops = {
 };
 
 static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
-			      irq_handler_t thread_fn)
+			      irq_handler_t thread_fn, int *irq_num)
 {
 	struct platform_device *pdev;
 	int ret, irq;
@@ -1169,6 +1170,7 @@ static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
 		if (irq == -ENXIO)
 			ret = 0;
 	} else {
+		*irq_num = irq;
 		/* VER_0 interrupt is TRIGGER_RISING, VER_0_1 and up is ONESHOT */
 		if (tsens_version(priv) == VER_0)
 			ret = devm_request_threaded_irq(&pdev->dev, irq,
@@ -1193,6 +1195,85 @@ static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
 	return ret;
 }
 
+static int tsens_reinit(struct tsens_priv *priv)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->ul_lock, flags);
+
+	/* in VER_0 TSENS need to be explicitly enabled */
+	if (tsens_version(priv) == VER_0)
+		regmap_field_write(priv->rf[TSENS_EN], 1);
+
+	/*
+	 * Re-enable the watchdog, unmask the bark.
+	 * Disable cycle completion monitoring
+	 */
+	if (priv->feat->has_watchdog) {
+		regmap_field_write(priv->rf[WDOG_BARK_MASK], 0);
+		regmap_field_write(priv->rf[CC_MON_MASK], 1);
+	}
+
+	/* Re-enable interrupts */
+	if (tsens_version(priv) >= VER_0_1)
+		tsens_enable_irq(priv);
+
+	spin_unlock_irqrestore(&priv->ul_lock, flags);
+
+	return 0;
+}
+
+int tsens_suspend_common(struct tsens_priv *priv)
+{
+	switch (pm_suspend_target_state) {
+	case PM_SUSPEND_MEM:
+		if (priv->combo_irq > 0) {
+			disable_irq_nosync(priv->combo_irq);
+			disable_irq_wake(priv->combo_irq);
+		}
+
+		if (priv->uplow_irq > 0) {
+			disable_irq_nosync(priv->uplow_irq);
+			disable_irq_wake(priv->uplow_irq);
+		}
+
+		if (priv->crit_irq > 0) {
+			disable_irq_nosync(priv->crit_irq);
+			disable_irq_wake(priv->crit_irq);
+		}
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+int tsens_resume_common(struct tsens_priv *priv)
+{
+	switch (pm_suspend_target_state) {
+	case PM_SUSPEND_MEM:
+		tsens_reinit(priv);
+		if (priv->combo_irq > 0) {
+			enable_irq(priv->combo_irq);
+			enable_irq_wake(priv->combo_irq);
+		}
+
+		if (priv->uplow_irq > 0) {
+			enable_irq(priv->uplow_irq);
+			enable_irq_wake(priv->uplow_irq);
+		}
+
+		if (priv->crit_irq > 0) {
+			enable_irq(priv->crit_irq);
+			enable_irq_wake(priv->crit_irq);
+		}
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
 static int tsens_register(struct tsens_priv *priv)
 {
 	int i, ret;
@@ -1227,15 +1308,19 @@ static int tsens_register(struct tsens_priv *priv)
 
 	if (priv->feat->combo_int) {
 		ret = tsens_register_irq(priv, "combined",
-					 tsens_combined_irq_thread);
+					 tsens_combined_irq_thread,
+					 &priv->combo_irq);
 	} else {
-		ret = tsens_register_irq(priv, "uplow", tsens_irq_thread);
+		ret = tsens_register_irq(priv, "uplow",
+					 tsens_irq_thread,
+					 &priv->uplow_irq);
 		if (ret < 0)
 			return ret;
 
 		if (priv->feat->crit_int)
 			ret = tsens_register_irq(priv, "critical",
-						 tsens_critical_irq_thread);
+						 tsens_critical_irq_thread,
+						 &priv->crit_irq);
 	}
 
 	return ret;
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index cb637fa289ca..268bf56105be 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -582,6 +582,11 @@ struct tsens_priv {
 	const struct reg_field		*fields;
 	const struct tsens_ops		*ops;
 
+	/* For saving irq number to re-use later */
+	int				uplow_irq;
+	int				crit_irq;
+	int				combo_irq;
+
 	struct dentry			*debug_root;
 	struct dentry			*debug;
 
@@ -634,6 +639,8 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *pt1, u32 *pt2, u32 mo
 int init_common(struct tsens_priv *priv);
 int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp);
 int get_temp_common(const struct tsens_sensor *s, int *temp);
+int tsens_suspend_common(struct tsens_priv *priv);
+int tsens_resume_common(struct tsens_priv *priv);
 
 /* TSENS target */
 extern struct tsens_plat_data data_8960;
-- 
2.17.1


