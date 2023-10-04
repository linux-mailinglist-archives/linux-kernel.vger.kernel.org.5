Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCA17B8670
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 19:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjJDR0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 13:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbjJDR0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 13:26:09 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297B6A7;
        Wed,  4 Oct 2023 10:26:06 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 394FBGFH029355;
        Wed, 4 Oct 2023 17:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=udksEDtj6tpSf6VcBThoP4ijMd42NX2dUjB/b8ZB+3U=;
 b=bT9gFztC/etdrNP7x5WY7Z3jtk58nChNaueaYBm699Rh5mwm7cokmk1DrB0K5FuxaHJ+
 UFXmvsewPRe6YzJUDnWLXj4+E/2xGYKRADnWb1NH0hcTubC5yQWNZIyH+MIG8lDPmKXR
 LButcrwlwGZ9YkGijE5dN0+ZHiJPabEjBxKCawQYlEa7JqneNJ+My8EBtppLQOtLvP1o
 GbPjlC6Qa2ILKbfWzkIt1lZ4jxOb4XQAHkYSmVfQ2NQ5Sb0DCC/kSTtnZQXKGK4o3Qga
 DVJRwbND5eS6CMnMmIAZEu38DSaXcEnBUVQY+xZvlRuqlWnqo0iSlAaQOFX0IrG234TK Sg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3th18jhpxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 17:25:58 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 394HPvBu003442
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Oct 2023 17:25:57 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 4 Oct 2023 10:25:54 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <p.zabel@pengutronix.de>,
        <linus.walleij@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH v7 1/3] firmware: qcom_scm: provide a read-modify-write function
Date:   Wed, 4 Oct 2023 22:55:36 +0530
Message-ID: <1696440338-12561-2-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1696440338-12561-1-git-send-email-quic_mojha@quicinc.com>
References: <1696440338-12561-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Wd_RnHT76n3u-0IoKo-fPi1uxm4gCooJ
X-Proofpoint-ORIG-GUID: Wd_RnHT76n3u-0IoKo-fPi1uxm4gCooJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_08,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=769 bulkscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040125
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was realized by Srinivas K. that there is a need of
read-modify-write scm exported function so that it can
be used by multiple clients.

Let's introduce qcom_scm_io_update_field() which masks
out the bits and write the passed value to that bit-offset.

Suggested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
Tested-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com> # IPQ9574 and IPQ5332
---
 drivers/firmware/qcom_scm.c            | 20 ++++++++++++++++++++
 include/linux/firmware/qcom/qcom_scm.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 520de9b5633a..084e4782b88d 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -122,6 +122,7 @@ static const char * const qcom_scm_convention_names[] = {
 };
 
 static struct qcom_scm *__scm;
+static DEFINE_SPINLOCK(lock);
 
 static int qcom_scm_clk_enable(void)
 {
@@ -481,6 +482,25 @@ static int qcom_scm_disable_sdi(void)
 	return ret ? : res.result[0];
 }
 
+int qcom_scm_io_update_field(phys_addr_t addr, unsigned int mask, unsigned int val)
+{
+	unsigned int old, new;
+	int ret;
+
+	spin_lock(&lock);
+	ret = qcom_scm_io_readl(addr, &old);
+	if (ret)
+		goto unlock;
+
+	new = (old & ~mask) | (val & mask);
+
+	ret = qcom_scm_io_writel(addr, new);
+unlock:
+	spin_unlock(&lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_scm_io_update_field);
+
 static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
 {
 	struct qcom_scm_desc desc = {
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index ccaf28846054..5497eaf9c7b5 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -82,6 +82,8 @@ bool qcom_scm_pas_supported(u32 peripheral);
 
 int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val);
 int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);
+int qcom_scm_io_update_field(phys_addr_t addr, unsigned int mask,
+			     unsigned int val);
 
 bool qcom_scm_restore_sec_cfg_available(void);
 int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare);
-- 
2.7.4

