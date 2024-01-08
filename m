Return-Path: <linux-kernel+bounces-19765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E238882730D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90B3228210E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09E651C2C;
	Mon,  8 Jan 2024 15:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jENTObg7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE76251C21;
	Mon,  8 Jan 2024 15:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 408FJcKV022858;
	Mon, 8 Jan 2024 15:28:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=vyQecuOeIjnpfvPPigrX
	zUOcLJ/f+FhVUGhffoBskJg=; b=jENTObg7dATiYgSNooPet5atRKIRhT+OHaae
	IG7DvCpK9kkMRq0swXI7N8u4gGCvmg4U6DldqNFOT7X6P0i5O0u0S1AE4H06YpiW
	cMjcvKUg4z5GEo/vp4wzS708GzL4e7EnANEkEyHPvQrERQy/3a95qINcjwPpUgaf
	R5cdXvKxr8CaZZEK3plDebgXXAPofTM7lXn+0O4Afx5vmPBonQfSTmoWyMvmuS1s
	SXy+uTFca8L/6tUYPZZAJ1YU8G9HXb1vaerrM5ykDXtFDL3z4QpbUh5lmUErovzX
	0vMVwcvNjffdxI9rEf/m+3J8LpFsuSiKtyNqXc7GuOmyNeNkjA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgkkh80fc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 15:28:05 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 408FS3v3012551
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 15:28:03 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 8 Jan 2024 07:28:01 -0800
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH v11 1/4] firmware: qcom: scm: provide a read-modify-write function
Date: Mon, 8 Jan 2024 20:57:31 +0530
Message-ID: <1704727654-13999-2-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1704727654-13999-1-git-send-email-quic_mojha@quicinc.com>
References: <1704727654-13999-1-git-send-email-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ro9j72N-DIA7YedbheuUGC4V-emPj0bO
X-Proofpoint-ORIG-GUID: ro9j72N-DIA7YedbheuUGC4V-emPj0bO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 spamscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=867
 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401080132

It was realized by Srinivas K. that there is a need of
read-modify-write scm exported function so that it can
be used by multiple clients.

Let's introduce qcom_scm_io_rmw() which masks out the bits
and write the passed value to that bit-offset.

Suggested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
Tested-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com> # IPQ9574 and IPQ5332
---
 drivers/firmware/qcom/qcom_scm.c       | 26 ++++++++++++++++++++++++++
 include/linux/firmware/qcom/qcom_scm.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 520de9b5633a..25549178a30f 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -19,6 +19,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/spinlock.h>
 #include <linux/reset-controller.h>
 #include <linux/types.h>
 
@@ -41,6 +42,8 @@ struct qcom_scm {
 	int scm_vote_count;
 
 	u64 dload_mode_addr;
+	/* Atomic context only */
+	spinlock_t lock;
 };
 
 struct qcom_scm_current_perm_info {
@@ -481,6 +484,28 @@ static int qcom_scm_disable_sdi(void)
 	return ret ? : res.result[0];
 }
 
+int qcom_scm_io_rmw(phys_addr_t addr, unsigned int mask, unsigned int val)
+{
+	unsigned int old, new;
+	int ret;
+
+	if (!__scm)
+		return -EINVAL;
+
+	spin_lock(&__scm->lock);
+	ret = qcom_scm_io_readl(addr, &old);
+	if (ret)
+		goto unlock;
+
+	new = (old & ~mask) | (val & mask);
+
+	ret = qcom_scm_io_writel(addr, new);
+unlock:
+	spin_unlock(&__scm->lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_scm_io_rmw);
+
 static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
 {
 	struct qcom_scm_desc desc = {
@@ -1824,6 +1849,7 @@ static int qcom_scm_probe(struct platform_device *pdev)
 		return ret;
 
 	mutex_init(&scm->scm_bw_lock);
+	spin_lock_init(&scm->lock);
 
 	scm->path = devm_of_icc_get(&pdev->dev, NULL);
 	if (IS_ERR(scm->path))
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index ccaf28846054..3a8bb2e603b3 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -82,6 +82,7 @@ bool qcom_scm_pas_supported(u32 peripheral);
 
 int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val);
 int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);
+int qcom_scm_io_rmw(phys_addr_t addr, unsigned int mask, unsigned int val);
 
 bool qcom_scm_restore_sec_cfg_available(void);
 int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare);
-- 
2.7.4


