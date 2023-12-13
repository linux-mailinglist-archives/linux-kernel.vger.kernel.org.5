Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66578120A5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 22:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442276AbjLMVWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 16:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjLMVWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 16:22:32 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36AFCF;
        Wed, 13 Dec 2023 13:22:38 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BDJxOAU019529;
        Wed, 13 Dec 2023 21:22:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:date:subject:mime-version:content-type
        :content-transfer-encoding:message-id:references:in-reply-to:to
        :cc; s=qcppdkim1; bh=j6xCZibHAVMqjIGH5SPHPzamu0E/s9sxBy14C7E7Cwg
        =; b=iVyvyXjWUfxMCQutY1mY/hJnNxkcB1F1+NetZu6B3hHPdYJjK/14zY2YOp3
        VMnStMwR9rk86fNPyFaSWnYxzAXo9CwHHJx3QpE6wc44Oqlm7Q/XjnaRFuveJ0lw
        yCvU0biXvNRWmEzttChmqmD8+abq0R+WPYHZi7bFNy9UyJD+UGLi02GNMulVJosg
        UB7B4XWC8T1IJouzxX1eaxgQFPlVo5EIWfKWXEOK/gfwGwv1q4+f9A1rACE0O/UC
        TlTrA6cfNxt2teFSbsx8exlxtz/qi4+OOha+m2G9kch6cKgK+tP7xG/bhNVwDGJG
        Ws00wQ9L5TgkuudDYgVy42OUC5A==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uy4kjjdgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 21:22:32 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BDLMV2g014956
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 21:22:31 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 13:22:30 -0800
From:   Jessica Zhang <quic_jesszhan@quicinc.com>
Date:   Wed, 13 Dec 2023 13:22:19 -0800
Subject: [PATCH v3 1/2] drm/msm/dpu: Set input_sel bit for INTF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231213-encoder-fixup-v3-1-b5cd2cda6bf5@quicinc.com>
References: <20231213-encoder-fixup-v3-0-b5cd2cda6bf5@quicinc.com>
In-Reply-To: <20231213-encoder-fixup-v3-0-b5cd2cda6bf5@quicinc.com>
To:     Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>
CC:     <quic_abhinavk@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
X-Mailer: b4 0.13-dev-53db1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702502550; l=3506;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=CsLCbL1u6ShWMUMaw9U+riIDpam1FqMLEUd8Y7LcTZw=;
 b=nmWqfTwGmf4D7eJU/c2zEOJMfgSGI4XqdaaCu3pvOjGRfoezxZ/foacgIcBXKeQeyotLcNUCw
 SxAGGnw6IjEAGF0lprUg+saYqhwsmsJ9ykEN9OjgA4PvwEpm44U1OKR
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: J8iC366BZUJDvrIDquM9fKPJk32tw2Yt
X-Proofpoint-ORIG-GUID: J8iC366BZUJDvrIDquM9fKPJk32tw2Yt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312130150
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the input_sel bit for encoders as it was missed in the initial
implementation.

Reported-by: Rob Clark <robdclark@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/msm/-/issues/39
Fixes: 91143873a05d ("drm/msm/dpu: Add MISR register support for interface")
Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c   |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c | 10 ++++++++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h |  3 ++-
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
index 0b6a0a7dcc39..226133af7840 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
@@ -322,7 +322,7 @@ static u32 dpu_hw_intf_get_line_count(struct dpu_hw_intf *intf)
 
 static void dpu_hw_intf_setup_misr(struct dpu_hw_intf *intf, bool enable, u32 frame_count)
 {
-	dpu_hw_setup_misr(&intf->hw, INTF_MISR_CTRL, enable, frame_count);
+	dpu_hw_setup_misr(&intf->hw, INTF_MISR_CTRL, enable, frame_count, 0x1);
 }
 
 static int dpu_hw_intf_collect_misr(struct dpu_hw_intf *intf, u32 *misr_value)
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
index 25af52ab602f..bbc9756ecde9 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
@@ -85,7 +85,7 @@ static void dpu_hw_lm_setup_border_color(struct dpu_hw_mixer *ctx,
 
 static void dpu_hw_lm_setup_misr(struct dpu_hw_mixer *ctx, bool enable, u32 frame_count)
 {
-	dpu_hw_setup_misr(&ctx->hw, LM_MISR_CTRL, enable, frame_count);
+	dpu_hw_setup_misr(&ctx->hw, LM_MISR_CTRL, enable, frame_count, 0x0);
 }
 
 static int dpu_hw_lm_collect_misr(struct dpu_hw_mixer *ctx, u32 *misr_value)
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c
index 0b05061e3e62..9a882ba2ab17 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c
@@ -477,7 +477,8 @@ void _dpu_hw_setup_qos_lut(struct dpu_hw_blk_reg_map *c, u32 offset,
 
 void dpu_hw_setup_misr(struct dpu_hw_blk_reg_map *c,
 		u32 misr_ctrl_offset,
-		bool enable, u32 frame_count)
+		bool enable, u32 frame_count,
+		u8 input_sel)
 {
 	u32 config = 0;
 
@@ -487,8 +488,13 @@ void dpu_hw_setup_misr(struct dpu_hw_blk_reg_map *c,
 	wmb();
 
 	if (enable) {
+		/*
+		 * note: Aside from encoders, input_sel should be
+		 * set to 0x0 by default
+		 */
 		config = (frame_count & MISR_FRAME_COUNT_MASK) |
-			MISR_CTRL_ENABLE | MISR_CTRL_FREE_RUN_MASK;
+			MISR_CTRL_ENABLE | MISR_CTRL_FREE_RUN_MASK |
+			((input_sel & 0xF) << 24);
 
 		DPU_REG_WRITE(c, misr_ctrl_offset, config);
 	} else {
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h
index fe083b2e5696..cd0fa1d0984e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h
@@ -357,7 +357,8 @@ void _dpu_hw_setup_qos_lut(struct dpu_hw_blk_reg_map *c, u32 offset,
 void dpu_hw_setup_misr(struct dpu_hw_blk_reg_map *c,
 		u32 misr_ctrl_offset,
 		bool enable,
-		u32 frame_count);
+		u32 frame_count,
+		u8 input_sel);
 
 int dpu_hw_collect_misr(struct dpu_hw_blk_reg_map *c,
 		u32 misr_ctrl_offset,

-- 
2.43.0

