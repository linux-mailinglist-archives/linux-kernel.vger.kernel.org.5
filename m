Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DA9808621
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378683AbjLGJ3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbjLGJ2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:28:43 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E081D1706;
        Thu,  7 Dec 2023 01:28:49 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B75KTK4029124;
        Thu, 7 Dec 2023 09:28:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=sy/1Uo+b7qVWM+Dtv27OmoLVYjhudFcpCG7Sli9Wq5o=;
 b=kw2lMNnxLk+oWhznosoLBsTt0nuB1OcLAxqEmNlGel/WLGV/zi1ceKg0M4yNynzzENnG
 qtqlXSAaSWvOkoaLK/k3qwUr9moVK2jK1OUWIagISFB9pQAczz+QNPngNjHiCERWZ7vc
 OtiuTB0Aeh/8hKJbwaJZBeCxof6wSQ5G7cpckpzi1yr94q/vyolIIl5II76lPrOlWsFm
 xbx23zkcbQ4sgybzxKCTKaiNVfehXKH7k52Es/N6MJTC9CI6bU5vtQvXoZJTjXjyc7VQ
 m/KSPI5BZSmPInTBIhWD+Yt9P+r18LKB8YmbANdKP0cM3J2Q7lkv3GgOaRcRV4b2yE7+ Hg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uu6qr0k1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 09:28:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B79SkDr001448
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Dec 2023 09:28:46 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Dec 2023 01:28:40 -0800
From:   Tengfei Fan <quic_tengfan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH v2 5/7] soc: qcom: socinfo: add SoC Info support for the QCS8550 platform
Date:   Thu, 7 Dec 2023 17:27:59 +0800
Message-ID: <20231207092801.7506-6-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231207092801.7506-1-quic_tengfan@quicinc.com>
References: <20231207092801.7506-1-quic_tengfan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vyqNFGSjUzsBZGGUACCLbYP81_WVKR0X
X-Proofpoint-ORIG-GUID: vyqNFGSjUzsBZGGUACCLbYP81_WVKR0X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_07,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 bulkscore=0 mlxlogscore=918
 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312070076
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SoC Info support for the QCS8550 platform.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 drivers/soc/qcom/socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 51e05bec5bfc..c8d216cce41f 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -426,6 +426,7 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(IPQ5322) },
 	{ qcom_board_id(IPQ5312) },
 	{ qcom_board_id(IPQ5302) },
+	{ qcom_board_id(QCS8550) },
 	{ qcom_board_id(IPQ5300) },
 };
 
-- 
2.17.1

