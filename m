Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83DA799B1A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 22:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344562AbjIIUV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 16:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjIIUVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 16:21:55 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09058CF8;
        Sat,  9 Sep 2023 13:21:21 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 389KGuCQ005668;
        Sat, 9 Sep 2023 20:19:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=3JWMLPTJbjLRcx5p0jk8GvPTqA1zsJkaIySdfwFynTU=;
 b=Y6bNhA4bFceETlryS6NeID8zpEqXjCWw2UXEokGzdrcKqgC1af0OnmTsbwcRlOPz8SZb
 cRfbqKX6otc16pLC9CYJxKON+NMaXQM25IWcDLK+IDOCm0wMrm/FvCxxnA3amCPwLRPv
 sXFrdRl3ZLXLpjCVEDD37f0M7mPxqhJLh9GJ6X0j7Ub6P1/rIPow1ZLpceqD2wlYMHQe
 yqNn6XLBxsRuQpNT48idkobluWja6Pkcp/yK2M5XoQc0t5OeoUP+La6ObjHtVwj6JVuJ
 /Igs58q60rghBLwrc6c5KdGQHvqYHc/bSAER3t49IB+Vq+SGecbsUkSc4YV3ZFy5zXq/ Hw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t0fqjh08b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 09 Sep 2023 20:19:18 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 389KJHiE008405
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 9 Sep 2023 20:19:17 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Sat, 9 Sep 2023 13:19:06 -0700
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
Subject: [PATCH v5 17/17] firmware: qcom_scm: Add multiple download mode support
Date:   Sun, 10 Sep 2023 01:46:18 +0530
Message-ID: <1694290578-17733-18-git-send-email-quic_mojha@quicinc.com>
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
X-Proofpoint-GUID: 5XJZ5p6iudJkReF4dHFFDUj6Rvc95F_c
X-Proofpoint-ORIG-GUID: 5XJZ5p6iudJkReF4dHFFDUj6Rvc95F_c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-09_19,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 mlxscore=0
 suspectscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309090187
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, scm driver only supports full dump when download
mode is selected. Add support to enable minidump as well as
enable it along with fulldump.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/firmware/qcom_scm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 689bf882cb69..9faf0431d47a 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -34,6 +34,8 @@ static u32 download_mode;
 
 #define QCOM_DLOAD_MASK		GENMASK(5, 4)
 #define QCOM_DLOAD_FULLDUMP	0x1
+#define QCOM_DLOAD_MINIDUMP	0x2
+#define QCOM_DLOAD_BOTHDUMP	(QCOM_DLOAD_FULLDUMP | QCOM_DLOAD_MINIDUMP)
 #define QCOM_DLOAD_NODUMP	0x0
 
 struct qcom_scm {
@@ -86,6 +88,8 @@ static const char * const qcom_scm_convention_names[] = {
 static const char * const download_mode_name[] = {
 	[QCOM_DLOAD_NODUMP]	= "off",
 	[QCOM_DLOAD_FULLDUMP]	= "full",
+	[QCOM_DLOAD_MINIDUMP]	= "mini",
+	[QCOM_DLOAD_BOTHDUMP]	= "full,mini",
 };
 
 static struct qcom_scm *__scm;
@@ -1470,7 +1474,7 @@ static const struct kernel_param_ops download_mode_param_ops = {
 
 module_param_cb(download_mode, &download_mode_param_ops, NULL, 0644);
 MODULE_PARM_DESC(download_mode,
-		"download mode: off/full are acceptable values");
+		"download mode: off/full/mini/full,mini are acceptable values");
 
 static int qcom_scm_probe(struct platform_device *pdev)
 {
-- 
2.7.4

