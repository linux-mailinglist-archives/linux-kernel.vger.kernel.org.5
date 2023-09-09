Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D238799B00
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 22:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244634AbjIIUVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 16:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjIIUVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 16:21:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087D9171C;
        Sat,  9 Sep 2023 13:20:32 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 389KCDEu023777;
        Sat, 9 Sep 2023 20:18:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Pu21/RzSQCP1BqGc9YFU81Va/bJ5Vvnil8MlVsGEBiU=;
 b=WPwdHTtoSDBmHkOu4Zwb5XyKsjtewDJZU8FefQjYLQW0NNrddz1LwKj4UDA8xRjJm1+L
 mSNSlDzU4o5Q05/38eVxDAd5SjbcnZefVz6pKUkGvGrqEpog+W0kpjc5nQa7mUugCVCC
 kNdK8Exi0Qgh4w+wyXX8pjVMH8Y0AxKQILYLZ/QcQxSLmGVbvj7VqB+3sK4dzdIXRn7P
 9uY2HciTQHmfUqTQHCY0zDnfY0ABbrdgyWYKCWJz76f83rVWxU2cISApp6ocmiH99A5E
 qM8uvxCALTrUDAAWktjXJQRkVXn62IWtMB5hShdTY1OnneDvc3g/B2FhmiOS/PKq5O4p Qg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t0h3drwmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 09 Sep 2023 20:18:51 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 389KIoAK016131
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 9 Sep 2023 20:18:50 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Sat, 9 Sep 2023 13:18:39 -0700
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
Subject: [PATCH v5 14/17] pinctrl: qcom: Use qcom_scm_io_update_field()
Date:   Sun, 10 Sep 2023 01:46:15 +0530
Message-ID: <1694290578-17733-15-git-send-email-quic_mojha@quicinc.com>
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
X-Proofpoint-GUID: 8VcFWusVAZdIaXDGDmXxhi-Yx61euFSS
X-Proofpoint-ORIG-GUID: 8VcFWusVAZdIaXDGDmXxhi-Yx61euFSS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-09_19,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 phishscore=0 mlxlogscore=879 adultscore=0 spamscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309090187
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use qcom_scm_io_update_field() exported function in
pinctrl-msm driver.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 115b83e2d8e6..2b9182375702 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -1078,22 +1078,20 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	if (g->intr_target_width)
 		intr_target_mask = GENMASK(g->intr_target_width - 1, 0);
 
+	intr_target_mask <<= g->intr_target_bit;
 	if (pctrl->intr_target_use_scm) {
 		u32 addr = pctrl->phys_base[0] + g->intr_target_reg;
 		int ret;
 
-		qcom_scm_io_readl(addr, &val);
-		val &= ~(intr_target_mask << g->intr_target_bit);
-		val |= g->intr_target_kpss_val << g->intr_target_bit;
-
-		ret = qcom_scm_io_writel(addr, val);
+		val = g->intr_target_kpss_val << g->intr_target_bit;
+		ret = qcom_scm_io_update_field(addr, intr_target_mask, val);
 		if (ret)
 			dev_err(pctrl->dev,
 				"Failed routing %lu interrupt to Apps proc",
 				d->hwirq);
 	} else {
 		val = msm_readl_intr_target(pctrl, g);
-		val &= ~(intr_target_mask << g->intr_target_bit);
+		val &= ~intr_target_mask;
 		val |= g->intr_target_kpss_val << g->intr_target_bit;
 		msm_writel_intr_target(val, pctrl, g);
 	}
-- 
2.7.4

