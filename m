Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAB280E02F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 01:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345686AbjLLAXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 19:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345651AbjLLAXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 19:23:32 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B151BD67;
        Mon, 11 Dec 2023 16:23:25 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BC0GdpQ014886;
        Tue, 12 Dec 2023 00:23:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        qcppdkim1; bh=tp7bW7uRaJP9uiszDXWjtYgMkFxCn9QEwv6nE2pfZQA=; b=WU
        t60GzmBI8yWQGFJlVot9VJGIBAdRUFQuo1NbAnPpPXWDG/m5+aq1J2syZvF4r7hS
        tcIHkZEdE7mHeLmavIITmYMr2zoNPOmdWZdN7BEhhAw/JP9aQ+frESQdEPDEpV/L
        l0DN6wSrBIh4g4KEEfr8p46UR6MH/Rcn0lFbOhjucUzCKOt44KGGLmGkVa14mJaS
        36jRYXXBuBtUjs0QaRT15aBZzCzrd53j+oTO/p8jLjV5hdcyjgmsIF6+CHhgssj9
        HGs0lPIJGmrtzOulLL3tDTktKktVKbuPz9BiihIBGYPFF+G15dqAJv7uMpVCRdaM
        4TZEe7X7oRsGS9uK34Dw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uxa900a5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 00:23:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BC0NIDV007424
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 00:23:18 GMT
Received: from abhinavk-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 16:23:17 -0800
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
To:     <freedreno@lists.freedesktop.org>, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <seanpaul@chromium.org>,
        <quic_jesszhan@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 12/15] drm/msm/dpu: plug-in the cdm related bits to writeback setup
Date:   Mon, 11 Dec 2023 16:22:42 -0800
Message-ID: <20231212002245.23715-13-quic_abhinavk@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212002245.23715-1-quic_abhinavk@quicinc.com>
References: <20231212002245.23715-1-quic_abhinavk@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Nn4ehJDCH2nKVLe5fLwJ_vWdELy-FUK2
X-Proofpoint-ORIG-GUID: Nn4ehJDCH2nKVLe5fLwJ_vWdELy-FUK2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312120001
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To setup and enable CDM block for the writeback pipeline, lets
add the pieces together to set the active bits and the flush
bits for the CDM block.

changes in v2:
	- passed the cdm idx to update_pending_flush_cdm()
	  (have retained the R-b as its a minor change)

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
index 85cb8596737d..0a28198886d5 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
@@ -214,6 +214,7 @@ static void dpu_encoder_phys_wb_setup_ctl(struct dpu_encoder_phys *phys_enc)
 {
 	struct dpu_hw_wb *hw_wb;
 	struct dpu_hw_ctl *ctl;
+	struct dpu_hw_cdm *hw_cdm;
 
 	if (!phys_enc) {
 		DPU_ERROR("invalid encoder\n");
@@ -222,6 +223,7 @@ static void dpu_encoder_phys_wb_setup_ctl(struct dpu_encoder_phys *phys_enc)
 
 	hw_wb = phys_enc->hw_wb;
 	ctl = phys_enc->hw_ctl;
+	hw_cdm = phys_enc->hw_cdm;
 
 	if (test_bit(DPU_CTL_ACTIVE_CFG, &ctl->caps->features) &&
 		(phys_enc->hw_ctl &&
@@ -238,6 +240,9 @@ static void dpu_encoder_phys_wb_setup_ctl(struct dpu_encoder_phys *phys_enc)
 		if (mode_3d && hw_pp && hw_pp->merge_3d)
 			intf_cfg.merge_3d = hw_pp->merge_3d->idx;
 
+		if (hw_cdm)
+			intf_cfg.cdm = hw_cdm->idx;
+
 		if (phys_enc->hw_pp->merge_3d && phys_enc->hw_pp->merge_3d->ops.setup_3d_mode)
 			phys_enc->hw_pp->merge_3d->ops.setup_3d_mode(phys_enc->hw_pp->merge_3d,
 					mode_3d);
@@ -418,6 +423,7 @@ static void _dpu_encoder_phys_wb_update_flush(struct dpu_encoder_phys *phys_enc)
 	struct dpu_hw_wb *hw_wb;
 	struct dpu_hw_ctl *hw_ctl;
 	struct dpu_hw_pingpong *hw_pp;
+	struct dpu_hw_cdm *hw_cdm;
 	u32 pending_flush = 0;
 
 	if (!phys_enc)
@@ -426,6 +432,7 @@ static void _dpu_encoder_phys_wb_update_flush(struct dpu_encoder_phys *phys_enc)
 	hw_wb = phys_enc->hw_wb;
 	hw_pp = phys_enc->hw_pp;
 	hw_ctl = phys_enc->hw_ctl;
+	hw_cdm = phys_enc->hw_cdm;
 
 	DPU_DEBUG("[wb:%d]\n", hw_wb->idx - WB_0);
 
@@ -441,6 +448,9 @@ static void _dpu_encoder_phys_wb_update_flush(struct dpu_encoder_phys *phys_enc)
 		hw_ctl->ops.update_pending_flush_merge_3d(hw_ctl,
 				hw_pp->merge_3d->idx);
 
+	if (hw_cdm && hw_ctl->ops.update_pending_flush_cdm)
+		hw_ctl->ops.update_pending_flush_cdm(hw_ctl, hw_cdm->idx);
+
 	if (hw_ctl->ops.get_pending_flush)
 		pending_flush = hw_ctl->ops.get_pending_flush(hw_ctl);
 
-- 
2.40.1

