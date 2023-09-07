Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E2B7979FA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243370AbjIGR0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjIGR0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:26:43 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFA21BF1;
        Thu,  7 Sep 2023 10:26:14 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3874sXB3031786;
        Thu, 7 Sep 2023 06:51:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=yG6mFWXl4fcuCqhaaHC5VY7Wo03vDdwMjZCoZHw51FE=;
 b=W+5XXg21ht5M9HfmjL+pBxfxkHQAeqfOTNNWgVX1fQrd8rgEakk+uP/b1bQ+zDV14emm
 tp8Y0qHSPUnlJbg/s5oTat68pNRwPinZgG7H8OoDgyn071qVY3SrgrtiF3pjkVAP0In8
 +c7HG4FtCDrcTqOTo2wvrMXyS8XIRem5Nn+zV+/ZDObAx8Mm8ZNAMH9lxupX2vIAWSUu
 OiEvAIlkvMpDLooWx6JFyMx9jc01sPQdXcUZlg1hnyk+3+nhM1wKe2TyeL87zkoF+r84
 AmEHpBS1JZRiKbDxEM3akr0UVJl39BgTYsk6BM2dnSPf+JH7LfxJjbCrZGXth29lYTmS Wg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sxgsquduf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 06:51:22 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3876p4oN014435
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Sep 2023 06:51:04 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 6 Sep 2023 23:51:00 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <quic_varada@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] phy: qcom: m31: Remove unwanted qphy->vreg is NULL check
Date:   Thu, 7 Sep 2023 12:20:52 +0530
Message-ID: <1694069452-3794-1-git-send-email-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qRv52u4dAgZquABNiNR-X3J_Kpb4MxUV
X-Proofpoint-ORIG-GUID: qRv52u4dAgZquABNiNR-X3J_Kpb4MxUV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309070059
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following Smatch complaint:
	drivers/phy/qualcomm/phy-qcom-m31.c:175 m31usb_phy_init()
	warn: variable dereferenced before check 'qphy->vreg' (see line 167)

drivers/phy/qualcomm/phy-qcom-m31.c
   166
   167		ret = regulator_enable(qphy->vreg);
                                       ^^^^^^^^^^
Unchecked dereference

   168		if (ret) {
   169			dev_err(&phy->dev, "failed to enable regulator, %d\n", ret);
   170			return ret;
   171		}
   172
   173		ret = clk_prepare_enable(qphy->clk);
   174		if (ret) {
   175			if (qphy->vreg)
                            ^^^^^^^^^^
Checked too late

   176				regulator_disable(qphy->vreg);
   177			dev_err(&phy->dev, "failed to enable cfg ahb clock, %d\n", ret);

Since the phy will not get registered if qphy->vreg is NULL,
this check is not needed.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-phy/cbd26132-c624-44b7-a073-73222b287338@moroto.mountain/T/#u
Fixes: 08e49af50701 ("phy: qcom: Introduce M31 USB PHY driver")
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 drivers/phy/qualcomm/phy-qcom-m31.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-m31.c b/drivers/phy/qualcomm/phy-qcom-m31.c
index 1875fe3..5e8f657 100644
--- a/drivers/phy/qualcomm/phy-qcom-m31.c
+++ b/drivers/phy/qualcomm/phy-qcom-m31.c
@@ -172,8 +172,7 @@ static int m31usb_phy_init(struct phy *phy)
 
 	ret = clk_prepare_enable(qphy->clk);
 	if (ret) {
-		if (qphy->vreg)
-			regulator_disable(qphy->vreg);
+		regulator_disable(qphy->vreg);
 		dev_err(&phy->dev, "failed to enable cfg ahb clock, %d\n", ret);
 		return ret;
 	}
-- 
2.7.4

