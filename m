Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5394A7A29B3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 23:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237888AbjIOVj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 17:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237778AbjIOVjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 17:39:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE55193;
        Fri, 15 Sep 2023 14:38:55 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FLV5Im020956;
        Fri, 15 Sep 2023 21:38:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=bTin8ICIQq+L+P/4iilsv+GOSQtbD973pC4K61+EGDI=;
 b=cw3yVw3HbfSsdjEuvdRLNB0gXwUJ0WmmD6/9kVzot2prlIja98O3X7Sh6jkT3FgfjIQC
 a0/rSCRyPVkN67jwaB7czwopDinrJXT+c1qLXHFF9eHIrfPYI+W5KIap0GbAAUIIkwvB
 9ud5M0E642X3ZvuN2VEJRj61NUcZzUuczzHexfemdkGmmhmp+CDxFznfASMWJWBfrI08
 zMkiCNXVqxwW7NEmHgJUfm1VHaWh/ogwTtI+VmqOa+uA+lPra/rFUDqnsaRoY7jJ/VCv
 mxyMFhc6uCJNtmB6m4hUzplNGupsMTI79tM6Eb0AOi/rZP0O4NOJdGChZVTQbogE7OkM xQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t4dvqtk1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 21:38:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38FLcY2t015942
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 21:38:34 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 15 Sep 2023 14:38:34 -0700
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
Subject: [PATCH v3 0/7] incorporate pm runtime framework and eDP clean up
Date:   Fri, 15 Sep 2023 14:38:14 -0700
Message-ID: <1694813901-26952-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pJN8zWHYdFVhwqXsbWGoMd7e5gOkUcjr
X-Proofpoint-ORIG-GUID: pJN8zWHYdFVhwqXsbWGoMd7e5gOkUcjr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_18,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=935 phishscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150194
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Incorporate pm runtime framework into DP driver and clean up eDP
by moving of_dp_aux_populate_bus() to probe().

-- add v3 changes log

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

