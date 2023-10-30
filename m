Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257827DB3B1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 07:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjJ3G4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 02:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjJ3G4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 02:56:30 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A84C4;
        Sun, 29 Oct 2023 23:56:27 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39U66mpC030237;
        Mon, 30 Oct 2023 06:56:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=vyQecuOeIjnpfvPPigrXzUOcLJ/f+FhVUGhffoBskJg=;
 b=bqIVytd/Ixaw0TB08JL0HZLzZ6vP16coBAQruBTyfs9zzSt/z+A4dnWtbL9cUMqhhrhC
 zmRW+/g7w9Jz20aeYA09ADxjlp6lq6wdvq3E6JpGZ4DQFl6UMRa5LFvOegtgx0CA2TpC
 lwOI0YKpO4kDvYtnBr5POEBEZmB7tUvZUg0+6+YHVFak9JUHwN5Fg8ialnW1qI4CWAJl
 xTgfkWW+uI6YJ/fDB0jKnYoHCj7m1n0hFNWL/v8YdQlkSSdpHsXnrdgEfkUR+vcVtC5N
 LNO/UTeR++1kN5g+Rumzb4Ly2UdnNTFRNYC4SBHkhASJj+GHhC6/Z3e86EAOhzJnRLT3 0Q== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u0sw7u550-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 06:56:23 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39U6uMZx001182
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 06:56:22 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Sun, 29 Oct 2023 23:56:19 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linus.walleij@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mukesh Ojha" <quic_mojha@quicinc.com>
Subject: [PATCH v9 1/3] firmware: qcom_scm: provide a read-modify-write function
Date:   Mon, 30 Oct 2023 12:26:05 +0530
Message-ID: <1698648967-974-2-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1698648967-974-1-git-send-email-quic_mojha@quicinc.com>
References: <1698648967-974-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: iHXsZ8CtCfSm120ZjUcSlXYQRKecTBVp
X-Proofpoint-GUID: iHXsZ8CtCfSm120ZjUcSlXYQRKecTBVp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_05,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=849 clxscore=1015
 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300051
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

