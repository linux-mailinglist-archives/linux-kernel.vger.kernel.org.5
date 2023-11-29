Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7727FDEB3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 18:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjK2RrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 12:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjK2RrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 12:47:14 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BC8DD;
        Wed, 29 Nov 2023 09:47:20 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATFOAMT003110;
        Wed, 29 Nov 2023 17:47:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=ymhBRT7/PHM2X6Yq0+I0Rb57e52jxs3aZmtcZKaTwjI=;
 b=ZPYD1uZhC9+vJ39ODnRpF1smjgML3Rr4OEUJj6ToJ7cmgEzcQyGqBBEuap4i0Jwqgi3q
 l5aGu0tjD2LGSpsXBLxJ6y3T0Hzj1t7epgk4aawhXD/rVfhQjLPlfqndnyZLS/yU7nJN
 48GFp604FxHpllNzc1wZB5zbkPDnXYot3S1d9J9bTvChkC0upCqNCeuX4Oyk6M1ZQgo8
 ZKIyNheFWC9lyLoSRjxx6ShW7XxWU/JcnCoB5G0cylp6iME7w0rpEXvW3XGbKZAOyF04
 XIWxUW7DM4Gy1MvC8fE9HcW2UgRkCTmOgwkvYS79p4vZ1h/BgtvpNiePMrq8c3LUPirK 0Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3unvett9xy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 17:47:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ATHl9S3001399
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 17:47:09 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 29 Nov 2023 09:47:09 -0800
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@gmail.com>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <andersson@kernel.org>
CC:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <quic_jesszhan@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <marijn.suijten@somainline.org>,
        <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 1/7] drm/msm/dp: tie dp_display_irq_handler() with dp driver
Date:   Wed, 29 Nov 2023 09:46:44 -0800
Message-ID: <1701280010-32476-2-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1701280010-32476-1-git-send-email-quic_khsieh@quicinc.com>
References: <1701280010-32476-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Z8TqplQfWWG3Ad8YIkxvyhfaX6erkDx3
X-Proofpoint-ORIG-GUID: Z8TqplQfWWG3Ad8YIkxvyhfaX6erkDx3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_15,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290135
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the dp_display_request_irq() is executed at
msm_dp_modeset_init() which ties irq registering to the DPU device's
life cycle, while depending on resources that are released as the DP
device is torn down. Move register DP driver irq handler to
dp_display_probe() to have dp_display_irq_handler() IRQ tied with DP
device. In addition, use platform_get_irq() to retrieve irq number
from platform device directly.

Changes in v5:
-- reworded commit text as review comments at change #4
-- tear down component if failed at dp_display_request_irq()

Changes in v4:
-- delete dp->irq check at dp_display_request_irq()

Changes in v3:
-- move calling dp_display_irq_handler() to probe

Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 32 +++++++++++++-------------------
 drivers/gpu/drm/msm/dp/dp_display.h |  1 -
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index e329e03..2110862 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1184,26 +1184,18 @@ static irqreturn_t dp_display_irq_handler(int irq, void *dev_id)
 	return ret;
 }
 
-int dp_display_request_irq(struct msm_dp *dp_display)
+static int dp_display_request_irq(struct dp_display_private *dp)
 {
 	int rc = 0;
-	struct dp_display_private *dp;
-
-	if (!dp_display) {
-		DRM_ERROR("invalid input\n");
-		return -EINVAL;
-	}
-
-	dp = container_of(dp_display, struct dp_display_private, dp_display);
+	struct platform_device *pdev = dp->dp_display.pdev;
 
-	dp->irq = irq_of_parse_and_map(dp->dp_display.pdev->dev.of_node, 0);
+	dp->irq = platform_get_irq(pdev, 0);
 	if (!dp->irq) {
 		DRM_ERROR("failed to get irq\n");
 		return -EINVAL;
 	}
 
-	rc = devm_request_irq(dp_display->drm_dev->dev, dp->irq,
-			dp_display_irq_handler,
+	rc = devm_request_irq(&pdev->dev, dp->irq, dp_display_irq_handler,
 			IRQF_TRIGGER_HIGH, "dp_display_isr", dp);
 	if (rc < 0) {
 		DRM_ERROR("failed to request IRQ%u: %d\n",
@@ -1278,13 +1270,21 @@ static int dp_display_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, &dp->dp_display);
 
+	rc = dp_display_request_irq(dp);
+	if (rc)
+		goto err;
+
 	rc = component_add(&pdev->dev, &dp_display_comp_ops);
 	if (rc) {
 		DRM_ERROR("component add failed, rc=%d\n", rc);
-		dp_display_deinit_sub_modules(dp);
+		goto err;
 	}
 
 	return rc;
+
+err:
+	dp_display_deinit_sub_modules(dp);
+	return rc;
 }
 
 static void dp_display_remove(struct platform_device *pdev)
@@ -1537,12 +1537,6 @@ int msm_dp_modeset_init(struct msm_dp *dp_display, struct drm_device *dev,
 
 	dp_priv = container_of(dp_display, struct dp_display_private, dp_display);
 
-	ret = dp_display_request_irq(dp_display);
-	if (ret) {
-		DRM_ERROR("request_irq failed, ret=%d\n", ret);
-		return ret;
-	}
-
 	ret = dp_display_get_next_bridge(dp_display);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index f66cdbc..15dbd2f 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -36,7 +36,6 @@ struct msm_dp {
 int dp_display_set_plugged_cb(struct msm_dp *dp_display,
 		hdmi_codec_plugged_cb fn, struct device *codec_dev);
 int dp_display_get_modes(struct msm_dp *dp_display);
-int dp_display_request_irq(struct msm_dp *dp_display);
 bool dp_display_check_video_test(struct msm_dp *dp_display);
 int dp_display_get_test_bpp(struct msm_dp *dp_display);
 void dp_display_signal_audio_start(struct msm_dp *dp_display);
-- 
2.7.4

