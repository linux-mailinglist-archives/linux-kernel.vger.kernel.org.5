Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5D77B0DBB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 22:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjI0Uyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 16:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjI0Uy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 16:54:26 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49E9121;
        Wed, 27 Sep 2023 13:54:23 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RKPVqb032498;
        Wed, 27 Sep 2023 20:54:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=WTg+9lTMc1X3RN5Yj3LsS3L3BV8FY3R7FJIzxGTsBCA=;
 b=W4Kq7Nl6yK0EsHNwz3UnT9Y/yl4HTpkN8hVc52SnTnH+B0AIt3qp/Tyb4ds8NcPL3a7k
 HqOa2gazTBLBNvifcpsIpVBaxRZK/nmJIS20j0NteNJ1YcxKXAuey+mB3VLGNqeJKbyZ
 yGk3C3fyUtLXz8XjchbHKZGIFCnDviQUwqVnaJ6YpUagZZLBzCCwDrCLvTf15c/cPt2q
 dlMi7JlgzpGYpkWGbQzaq9ijC2yiZymYsQSvscg1hY3qz0xLHb5hZuvwO5kKKHD0C7Ls
 HHOfzB8Uwv+z6JfNnSJtzC7jMlJL1x4Ii5cuqOaemHJQ0aNIQ8ppLb/v/mwciU6iJtc8 Dw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tct5gr6aw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 20:54:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38RKs4aS028807
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 20:54:04 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 27 Sep 2023 13:54:03 -0700
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
Subject: [PATCH v4 3/8] drm/msm/dp: use drm_bridge_hpd_notify() to report HPD status changes
Date:   Wed, 27 Sep 2023 13:53:43 -0700
Message-ID: <1695848028-18023-4-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1695848028-18023-1-git-send-email-quic_khsieh@quicinc.com>
References: <1695848028-18023-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xdW2RS5ru-1YuAxEvHb7mVSAtnCi9erH
X-Proofpoint-GUID: xdW2RS5ru-1YuAxEvHb7mVSAtnCi9erH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_13,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 phishscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270178
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently DP driver use drm_helper_hpd_irq_event(), bypassing drm bridge
framework, to report HPD status changes to user space frame work.
Replace it with drm_bridge_hpd_notify() since DP driver is part of drm
bridge.

Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 9cb5a5b..7ae3b8b 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -356,26 +356,10 @@ static bool dp_display_is_sink_count_zero(struct dp_display_private *dp)
 		(dp->link->sink_count == 0);
 }
 
-static void dp_display_send_hpd_event(struct msm_dp *dp_display)
-{
-	struct dp_display_private *dp;
-	struct drm_connector *connector;
-
-	dp = container_of(dp_display, struct dp_display_private, dp_display);
-
-	connector = dp->dp_display.connector;
-	drm_helper_hpd_irq_event(connector->dev);
-}
-
 static int dp_display_send_hpd_notification(struct dp_display_private *dp,
 					    bool hpd)
 {
-	if ((hpd && dp->dp_display.link_ready) ||
-			(!hpd && !dp->dp_display.link_ready)) {
-		drm_dbg_dp(dp->drm_dev, "HPD already %s\n",
-				(hpd ? "on" : "off"));
-		return 0;
-	}
+	struct drm_bridge *bridge = dp->dp_display.bridge;
 
 	/* reset video pattern flag on disconnect */
 	if (!hpd)
@@ -385,7 +369,7 @@ static int dp_display_send_hpd_notification(struct dp_display_private *dp,
 
 	drm_dbg_dp(dp->drm_dev, "type=%d hpd=%d\n",
 			dp->dp_display.connector_type, hpd);
-	dp_display_send_hpd_event(&dp->dp_display);
+	drm_bridge_hpd_notify(bridge, dp->dp_display.link_ready);
 
 	return 0;
 }
-- 
2.7.4

