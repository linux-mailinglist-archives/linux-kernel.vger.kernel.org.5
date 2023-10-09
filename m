Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42FE7BE69A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377639AbjJIQgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377625AbjJIQgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:36:31 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B384C5
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 09:36:29 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3231df054c4so4417538f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 09:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696869388; x=1697474188; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eo67TNhMGxEpsJXZTV7WocEXuldcPW1ccOBH3SYFfCo=;
        b=QUWHFevtpI27PQLJLbqCQoax2ZFBggd2v2vCqV57Orh9vpXIU78JWM7e4pmKqvz7kf
         s/kyDuX33Y9rz39x+BqAOOXSrTYPxrNJWUdT6k7939M1twdorZV4CscX8SUFDYjCBRoF
         Mkm5tdYrEMcg1B8NKUkX0vbrJmnyP6w77ryoDh24xNOI+/nm2or5NzLY155psfIrqM1i
         oP9ImN1i7JMIGXl9nRoezIaiLrJ7i+arufosy+x79Qj/+MtpO0Ms72UHQ9UE1NDJxDUU
         pJ52V1WuR/CkBX/nnLB75WYp7xtfELAcNOpvs5eE4l8xFH6FF1JEQysMlz5PPUMUiqqj
         s88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696869388; x=1697474188;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eo67TNhMGxEpsJXZTV7WocEXuldcPW1ccOBH3SYFfCo=;
        b=IxdkSSYoDWitEOfUPY3U90RWvyeDD6ybv5KgSCV4RMfqjHiXZesD2zGnJqSGEs/u32
         KHiPe9veIneQuH0PGD0lVafHduId1Ypyx5cDPEuzHJbrB0w0DulLDkWHIRO7CvjzLuXq
         KVRqQ3B4evFrVIAdH071EYXwnQwilQzMGeJUgofwjTLRdxvF14BSuYFp7mp6XS0h3ETj
         7wD158o9uJ0CM65dq7eaI3OGior3u2DDn1gEz2XhDjAcmVEqX9143itgcw9ihNiF+0/j
         gfDekNuRNO1UeXQUD04YHAlQYL6pI8ikjShBRYAGf5hrxtYN2LY1cQZgen4bw0fML5Wa
         gV6w==
X-Gm-Message-State: AOJu0YxwbdxdziLyQKp7qjUFGNw9H44h2KjewtaCblxxgC4sGHwe+/sL
        wsYbKQEfkQ5CUlz/IfS44Qk9aw==
X-Google-Smtp-Source: AGHT+IGhwRNyCGj+Ar9gNga2RqmPIZTGhHzBhueR8p+ti6QVCDaRkjxYk74mb2hTjyViObL6rJCYgw==
X-Received: by 2002:a5d:6a08:0:b0:320:896:5ea8 with SMTP id m8-20020a5d6a08000000b0032008965ea8mr13646712wru.19.1696869387725;
        Mon, 09 Oct 2023 09:36:27 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id f11-20020a5d50cb000000b00325c7295450sm10141046wrt.3.2023.10.09.09.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:36:27 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 09 Oct 2023 18:36:16 +0200
Subject: [PATCH RFC 5/5] drm/msm: dpu1: sm8550: move split clock controls
 to sspp entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231009-topic-sm8550-graphics-sspp-split-clk-v1-5-806c0dee4e43@linaro.org>
References: <20231009-topic-sm8550-graphics-sspp-split-clk-v1-0-806c0dee4e43@linaro.org>
In-Reply-To: <20231009-topic-sm8550-graphics-sspp-split-clk-v1-0-806c0dee4e43@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4767;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=rXNZZh0U0CRAs1SezapHV4WxBUWrXsKmahG1hZ3zZNk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlJCwFnTWJsAER2yIeZLeIaUwvwtPF1lWZA63oFT6P
 DsY8haGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZSQsBQAKCRB33NvayMhJ0booEA
 C52PH6JsPH69GimG9O/TqLJm6uLT1CP6O3DeHBomQYq0jcGdx8SsMpd9yab6ud4JwRN2oZGrgx2TS+
 RBP0cyFrJMkcgA4gV8Afp0f2Slm93eHOuY42noW3SMZbQPR9kHJK69Ge6rHTta68xSkht/nBK+VHUj
 w8MWu/F0nrfeqg84un8/49Dgfvhabsd8y1z9NiLkDP3LiLb5FVT/cvFeNJp9Jaxml4voxVYiOPhC2o
 w2cKb5WD0hWsZxfhydbAEstT13Yhol8gS4xiFw0kZxok3WbCLyVNYZwawhOr5VIMRFlORGB3RcxTcT
 REZYAmnpEHbhxYahqRkINTxO6VW3OXiCwjZ58j5hnLoUJIY2ANWNm6pqIWMOTU2xUPOaLak4P62TYI
 M0T8Aks+0wDo6oSJaMlRMpoCTMOhuy81LEt/6WKJkHLVi3+l7MNAhL2bjOoB3yI1ZGbG4XW+oei90O
 EwsqSKtkfl3xudznsZAi2zZ+0/hS7vS942SPpAuQPRib9V8O1krzhBsVUsgAwETcTGT9qas+6FxRPT
 1qg6kHR4+dKtsHnCO/k5sSswGqcqAGVINqQ5jooKdODzKTee6rs0fGMOsMdM4UkXDLZkgw2FaOCx8G
 aMxyCKlvisLiLQGFC50u5k/dYk9Zus3NUQb6G80WKB58J5PhX/LGm/Pzm9kA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SM8550 has the SSPP clk_ctrl in the SSPP registers, move them
out of the MDP top.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h | 35 ++++++++++------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
index 7bed819dfc39..527ec020fba4 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
@@ -24,16 +24,6 @@ static const struct dpu_mdp_cfg sm8550_mdp = {
 	.base = 0, .len = 0x494,
 	.features = BIT(DPU_MDP_PERIPH_0_REMOVED),
 	.clk_ctrls = {
-		[DPU_CLK_CTRL_VIG0] = { .reg_off = 0x4330, .bit_off = 0 },
-		[DPU_CLK_CTRL_VIG1] = { .reg_off = 0x6330, .bit_off = 0 },
-		[DPU_CLK_CTRL_VIG2] = { .reg_off = 0x8330, .bit_off = 0 },
-		[DPU_CLK_CTRL_VIG3] = { .reg_off = 0xa330, .bit_off = 0 },
-		[DPU_CLK_CTRL_DMA0] = { .reg_off = 0x24330, .bit_off = 0 },
-		[DPU_CLK_CTRL_DMA1] = { .reg_off = 0x26330, .bit_off = 0 },
-		[DPU_CLK_CTRL_DMA2] = { .reg_off = 0x28330, .bit_off = 0 },
-		[DPU_CLK_CTRL_DMA3] = { .reg_off = 0x2a330, .bit_off = 0 },
-		[DPU_CLK_CTRL_DMA4] = { .reg_off = 0x2c330, .bit_off = 0 },
-		[DPU_CLK_CTRL_DMA5] = { .reg_off = 0x2e330, .bit_off = 0 },
 		[DPU_CLK_CTRL_REG_DMA] = { .reg_off = 0x2bc, .bit_off = 20 },
 	},
 };
@@ -73,6 +63,11 @@ static const struct dpu_ctl_cfg sm8550_ctl[] = {
 	},
 };
 
+static const struct dpu_clk_ctrl_reg sm8550_sspp_clk_ctrl = {
+	.reg_off = 0x330,
+	.bit_off = 0
+};
+
 static const struct dpu_sspp_cfg sm8550_sspp[] = {
 	{
 		.name = "sspp_0", .id = SSPP_VIG0,
@@ -81,7 +76,7 @@ static const struct dpu_sspp_cfg sm8550_sspp[] = {
 		.sblk = &sm8550_vig_sblk_0,
 		.xin_id = 0,
 		.type = SSPP_TYPE_VIG,
-		.clk_ctrl = DPU_CLK_CTRL_VIG0,
+		.clk_ctrl_reg = &sm8550_sspp_clk_ctrl,
 	}, {
 		.name = "sspp_1", .id = SSPP_VIG1,
 		.base = 0x6000, .len = 0x344,
@@ -89,7 +84,7 @@ static const struct dpu_sspp_cfg sm8550_sspp[] = {
 		.sblk = &sm8550_vig_sblk_1,
 		.xin_id = 4,
 		.type = SSPP_TYPE_VIG,
-		.clk_ctrl = DPU_CLK_CTRL_VIG1,
+		.clk_ctrl_reg = &sm8550_sspp_clk_ctrl,
 	}, {
 		.name = "sspp_2", .id = SSPP_VIG2,
 		.base = 0x8000, .len = 0x344,
@@ -97,7 +92,7 @@ static const struct dpu_sspp_cfg sm8550_sspp[] = {
 		.sblk = &sm8550_vig_sblk_2,
 		.xin_id = 8,
 		.type = SSPP_TYPE_VIG,
-		.clk_ctrl = DPU_CLK_CTRL_VIG2,
+		.clk_ctrl_reg = &sm8550_sspp_clk_ctrl,
 	}, {
 		.name = "sspp_3", .id = SSPP_VIG3,
 		.base = 0xa000, .len = 0x344,
@@ -105,7 +100,7 @@ static const struct dpu_sspp_cfg sm8550_sspp[] = {
 		.sblk = &sm8550_vig_sblk_3,
 		.xin_id = 12,
 		.type = SSPP_TYPE_VIG,
-		.clk_ctrl = DPU_CLK_CTRL_VIG3,
+		.clk_ctrl_reg = &sm8550_sspp_clk_ctrl,
 	}, {
 		.name = "sspp_8", .id = SSPP_DMA0,
 		.base = 0x24000, .len = 0x344,
@@ -113,7 +108,7 @@ static const struct dpu_sspp_cfg sm8550_sspp[] = {
 		.sblk = &sdm845_dma_sblk_0,
 		.xin_id = 1,
 		.type = SSPP_TYPE_DMA,
-		.clk_ctrl = DPU_CLK_CTRL_DMA0,
+		.clk_ctrl_reg = &sm8550_sspp_clk_ctrl,
 	}, {
 		.name = "sspp_9", .id = SSPP_DMA1,
 		.base = 0x26000, .len = 0x344,
@@ -121,7 +116,7 @@ static const struct dpu_sspp_cfg sm8550_sspp[] = {
 		.sblk = &sdm845_dma_sblk_1,
 		.xin_id = 5,
 		.type = SSPP_TYPE_DMA,
-		.clk_ctrl = DPU_CLK_CTRL_DMA1,
+		.clk_ctrl_reg = &sm8550_sspp_clk_ctrl,
 	}, {
 		.name = "sspp_10", .id = SSPP_DMA2,
 		.base = 0x28000, .len = 0x344,
@@ -129,7 +124,7 @@ static const struct dpu_sspp_cfg sm8550_sspp[] = {
 		.sblk = &sdm845_dma_sblk_2,
 		.xin_id = 9,
 		.type = SSPP_TYPE_DMA,
-		.clk_ctrl = DPU_CLK_CTRL_DMA2,
+		.clk_ctrl_reg = &sm8550_sspp_clk_ctrl,
 	}, {
 		.name = "sspp_11", .id = SSPP_DMA3,
 		.base = 0x2a000, .len = 0x344,
@@ -137,7 +132,7 @@ static const struct dpu_sspp_cfg sm8550_sspp[] = {
 		.sblk = &sdm845_dma_sblk_3,
 		.xin_id = 13,
 		.type = SSPP_TYPE_DMA,
-		.clk_ctrl = DPU_CLK_CTRL_DMA3,
+		.clk_ctrl_reg = &sm8550_sspp_clk_ctrl,
 	}, {
 		.name = "sspp_12", .id = SSPP_DMA4,
 		.base = 0x2c000, .len = 0x344,
@@ -145,7 +140,7 @@ static const struct dpu_sspp_cfg sm8550_sspp[] = {
 		.sblk = &sm8550_dma_sblk_4,
 		.xin_id = 14,
 		.type = SSPP_TYPE_DMA,
-		.clk_ctrl = DPU_CLK_CTRL_DMA4,
+		.clk_ctrl_reg = &sm8550_sspp_clk_ctrl,
 	}, {
 		.name = "sspp_13", .id = SSPP_DMA5,
 		.base = 0x2e000, .len = 0x344,
@@ -153,7 +148,7 @@ static const struct dpu_sspp_cfg sm8550_sspp[] = {
 		.sblk = &sm8550_dma_sblk_5,
 		.xin_id = 15,
 		.type = SSPP_TYPE_DMA,
-		.clk_ctrl = DPU_CLK_CTRL_DMA5,
+		.clk_ctrl_reg = &sm8550_sspp_clk_ctrl,
 	},
 };
 

-- 
2.34.1

