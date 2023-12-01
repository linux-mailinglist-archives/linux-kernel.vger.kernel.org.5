Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97E4801777
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 00:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441900AbjLAXUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 18:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441892AbjLAXUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 18:20:17 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797CBD54;
        Fri,  1 Dec 2023 15:20:23 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1IGitq000734;
        Fri, 1 Dec 2023 23:20:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=eDIQEnWChwnYjGIPd4gCsvQ7mXaKi02IMRM0vKfaFec=;
 b=Gk13o4lsUpg5LTlo0mBUnQ2fm6SDxYOsyn0vf4k4CEyJo5Xupxh4DddJH2PvEtcLdrly
 nhoh66ffA5cYBPkxo3D+oPxq9aDyVJS1Xg1ks0veAcy3CWxq6CnhaDb7UnahHJZXmCK5
 +fYE5NdHj3mUIQUDgqd/4mB56xmQ4QndNgUPsw+N5yMnu8D5HToDweSwnJa2cG2F8EaP
 B9ue1w31sDa6HAhYhwdekoY2NoKhWqGVona8OLoAyKKME++aE41UN1OiEaDq8r9kQTTB
 RnN4NHWWnYQhjGmPVU1ziFMKXJa+L67VEpQqps34mWAxMJ4HwUs4uQYpjSio/Ii+Xduu vA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uqcm6a318-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Dec 2023 23:20:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B1NK7en005251
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Dec 2023 23:20:07 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 1 Dec 2023 15:20:07 -0800
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
Subject: [PATCH v9 4/7] drm/msm/dp: move parser->parse() and dp_power_client_init() to probe
Date:   Fri, 1 Dec 2023 15:19:46 -0800
Message-ID: <1701472789-25951-5-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1701472789-25951-1-git-send-email-quic_khsieh@quicinc.com>
References: <1701472789-25951-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0nhRQ0odv3XMyVO6ReC4_e2NqQ50PblF
X-Proofpoint-ORIG-GUID: 0nhRQ0odv3XMyVO6ReC4_e2NqQ50PblF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_22,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015
 suspectscore=0 spamscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312010144
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Original both parser->parse() and dp_power_client_init() are done at
dp_display_bind() since eDP population is done at binding time.
In the preparation of having eDP population done at probe() time,
move both function from dp_display_bind() to dp_display_probe().

Changes in v6:
-- move dp_power_client_deinit() to remove()

Changes in v5:
-- explain why parser->parse() and dp_power_client_init() are moved to
   probe time
-- tear down sub modules if failed

Changes in v4:
-- split this patch out of "incorporate pm_runtime framework into DP
   driver" patch

Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index c2e3247..a99a786 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -275,11 +275,6 @@ static int dp_display_bind(struct device *dev, struct device *master,
 	dp->dp_display.drm_dev = drm;
 	priv->dp[dp->id] = &dp->dp_display;
 
-	rc = dp->parser->parse(dp->parser);
-	if (rc) {
-		DRM_ERROR("device tree parsing failed\n");
-		goto end;
-	}
 
 
 	dp->drm_dev = drm;
@@ -290,11 +285,6 @@ static int dp_display_bind(struct device *dev, struct device *master,
 		goto end;
 	}
 
-	rc = dp_power_client_init(dp->power);
-	if (rc) {
-		DRM_ERROR("Power client create failed\n");
-		goto end;
-	}
 
 	rc = dp_register_audio_driver(dev, dp->audio);
 	if (rc) {
@@ -327,7 +317,6 @@ static void dp_display_unbind(struct device *dev, struct device *master,
 
 	of_dp_aux_depopulate_bus(dp->aux);
 
-	dp_power_client_deinit(dp->power);
 	dp_unregister_audio_driver(dev, dp->audio);
 	dp_aux_unregister(dp->aux);
 	dp->drm_dev = NULL;
@@ -1241,6 +1230,18 @@ static int dp_display_probe(struct platform_device *pdev)
 		return -EPROBE_DEFER;
 	}
 
+	rc = dp->parser->parse(dp->parser);
+	if (rc) {
+		DRM_ERROR("device tree parsing failed\n");
+		goto err;
+	}
+
+	rc = dp_power_client_init(dp->power);
+	if (rc) {
+		DRM_ERROR("Power client create failed\n");
+		goto err;
+	}
+
 	/* setup event q */
 	mutex_init(&dp->event_mutex);
 	init_waitqueue_head(&dp->event_q);
@@ -1275,6 +1276,7 @@ static void dp_display_remove(struct platform_device *pdev)
 	struct dp_display_private *dp = dev_get_dp_display_private(&pdev->dev);
 
 	component_del(&pdev->dev, &dp_display_comp_ops);
+	dp_power_client_deinit(dp->power);
 	dp_display_deinit_sub_modules(dp);
 
 	platform_set_drvdata(pdev, NULL);
-- 
2.7.4

