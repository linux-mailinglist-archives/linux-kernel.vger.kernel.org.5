Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02BF7F85EF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 23:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjKXWV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 17:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjKXWVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 17:21:19 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854AB198D;
        Fri, 24 Nov 2023 14:21:25 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AOLkw7H012282;
        Fri, 24 Nov 2023 22:21:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=6mwvu7xKz6N9G240sW8qG833kZvQJY4H+Sm3Z0bePUs=;
 b=NlZsgL6QYKbKWXjTsdUl2Oe7JUrw0shRmfN4Y6PdyTQI0tKRN3sC2FuacBbaHAW2f9j7
 a7f8HZfSfIvixqb0E4IdgCQWkjtyNR6dh3ES519Sq6850XiDT+dGG95F0vKx82ywjr81
 STPGTADz03RwZBgy+JKlVWAGaIza+5dqSaBJlPX6K/ecpcBYJYZ97frx+pSqO/ZkoOk4
 JQ9Fn2sHZ7soHTlKdRbJazIWrWa+xSdACqo1Y+dszKG3r7lia/wIFWlHXEzf0RMQgMdU
 +A2QvitpjIZ54KrCw80hoH/EY202/1ATaAXI0DEYpahNYnMFK9DUlKeD4foCp9ev+QRN kQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uj4hwm10e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 22:21:04 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AOMKfch015479
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 22:20:41 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 24 Nov 2023 14:20:31 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <corbet@lwn.net>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <vigneshr@ti.com>, <nm@ti.com>, <matthias.bgg@gmail.com>,
        <kgene@kernel.org>, <alim.akhtar@samsung.com>, <bmasney@redhat.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <kernel@quicinc.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [Patch v6 02/12] firmware/qcom: qcom_scm: Add multiple download mode support
Date:   Sat, 25 Nov 2023 03:49:45 +0530
Message-ID: <1700864395-1479-3-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1700864395-1479-1-git-send-email-quic_mojha@quicinc.com>
References: <1700864395-1479-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PhexFHj7k_YiyTvntEHtlLIbg_Sf52Hi
X-Proofpoint-ORIG-GUID: PhexFHj7k_YiyTvntEHtlLIbg_Sf52Hi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-24_09,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311240174
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/firmware/qcom/qcom_scm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index c5878c38f378..70bb59992fb9 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -123,6 +123,8 @@ static const u8 qcom_scm_cpu_warm_bits[QCOM_SCM_BOOT_MAX_CPUS] = {
 enum qcom_dload_mode {
 	QCOM_DLOAD_NODUMP	= 0,
 	QCOM_DLOAD_FULLDUMP	= 1,
+	QCOM_DLOAD_MINIDUMP	= 2,
+	QCOM_DLOAD_BOTHDUMP	= 3,
 };
 
 static const char * const qcom_scm_convention_names[] = {
@@ -135,6 +137,8 @@ static const char * const qcom_scm_convention_names[] = {
 static const char * const download_mode_name[] = {
 	[QCOM_DLOAD_NODUMP]	= "off",
 	[QCOM_DLOAD_FULLDUMP]	= "full",
+	[QCOM_DLOAD_MINIDUMP]	= "mini",
+	[QCOM_DLOAD_BOTHDUMP]	= "full,mini",
 };
 
 static struct qcom_scm *__scm;
@@ -1881,7 +1885,7 @@ static const struct kernel_param_ops download_mode_param_ops = {
 
 module_param_cb(download_mode, &download_mode_param_ops, NULL, 0644);
 MODULE_PARM_DESC(download_mode,
-		"download mode: off/full are acceptable values");
+		"download mode: off/full/mini/full,mini are acceptable values");
 
 static int qcom_scm_probe(struct platform_device *pdev)
 {
-- 
2.7.4

