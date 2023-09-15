Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497FC7A2895
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237584AbjIOUta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237618AbjIOUtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:49:10 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2164A2D44;
        Fri, 15 Sep 2023 13:48:36 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FD74hh012544;
        Fri, 15 Sep 2023 20:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=BeFcXcVJvqgyMTZkn2xQz54cGCM/fTWTEX1W3WZMa0k=;
 b=AnuUF6wbO4ZTX2gu7WB7YiVfPHfRTtK+A9aIRqk3293Rpgk5yxRs5O+5H9KDXneQS14f
 kCYqMoIEyyS/IvHOc9HKgnXrr3xnj1vkTUp+u0qxHUEqFr/PCPbVnOGu0gmG/Y6CqYy2
 9Se6W+qZpgzFJTXrYntnctMggXbcg4oivuyaUGSycNPxKq2X4rnZacyfMY9EFmsQKKez
 AoOQkZ7PWXVuJEJ6tHQTMt4wTjDOeBiAWtQzXvI544ggkBIUOj4RkKSQ1CUadfP3lrhw
 OZBlIHMDaGoqSxOHGum4zc6+v9FgaQXipJn6KjoQxGQdRor08r0gAaLTqT+JsC+IiR/D 1w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t4g5tj39e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 20:48:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38FKmMeO016838
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 20:48:22 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 15 Sep 2023 13:48:22 -0700
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
Subject: [PATCH v2 0/7] incorporate pm runtime framework and eDP clean up
Date:   Fri, 15 Sep 2023 13:48:01 -0700
Message-ID: <1694810888-24461-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: t-PhqwBEAtdrJz3ScJ41hhjknOb-_hIS
X-Proofpoint-GUID: t-PhqwBEAtdrJz3ScJ41hhjknOb-_hIS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_17,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 mlxlogscore=935 priorityscore=1501 adultscore=0 mlxscore=0 spamscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150186
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Incorporate pm runtime framework into DP driver and clean up eDP
by moving of_dp_aux_populate_bus() to probe()

Kuogee Hsieh (7):
  drm/msm/dp: tie dp_display_irq_handler() with dp driver
  drm/msm/dp: replace is_connected with link_ready
  drm/msm/dp: use drm_bridge_hpd_notify() to report HPD status changes
  drm/msm/dp: incorporate pm_runtime framework into DP driver
  drm/msm/dp: delete EV_HPD_INIT_SETUP
  drm/msm/dp: add pm_runtime_force_suspend()/resume()
  drm/msm/dp: move of_dp_aux_populate_bus() to eDP probe()

 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c |   4 -
 drivers/gpu/drm/msm/dp/dp_aux.c         |  30 +++
 drivers/gpu/drm/msm/dp/dp_display.c     | 348 ++++++++++++++------------------
 drivers/gpu/drm/msm/dp/dp_display.h     |   3 +-
 drivers/gpu/drm/msm/dp/dp_drm.c         |  14 +-
 drivers/gpu/drm/msm/dp/dp_power.c       |   9 -
 drivers/gpu/drm/msm/msm_drv.h           |   5 -
 7 files changed, 185 insertions(+), 228 deletions(-)

-- 
2.7.4

