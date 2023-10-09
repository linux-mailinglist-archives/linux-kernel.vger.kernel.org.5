Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749757BE697
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376996AbjJIQgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377269AbjJIQg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:36:29 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF73B9
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 09:36:26 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3296a998234so2868777f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 09:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696869385; x=1697474185; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5bqf+WARuWFIA4cLkesNXyhn8snKrlk6QVCk7crkS0E=;
        b=UbQ9n8ghbXBCMlbferGlur8/tD15JeU6+Uzom7e0ojaLDLoZs/Q3pOamwAXknQ6fj5
         H9Sva+aOrVqFiWCILEnanHm+QzeaH80KFzoQDDnOndnbAyeq5uT08DyoWnh8Ea2Hq7N+
         CWQXpi2sm9BSMFEjlcJVoFIDJZV3RvFUUUoqzk9jCOg6iMKuZ9NL7TcxRZBWo4MMrRgI
         yor6JsAPF/ITIPBzQAzCbPPRP1ZmA3IA6wdlMaZux5X+BsJa5pbTAS2khpmNACcJKHku
         1nQd1bC5QF0lSYF9RGy9dd7mqsICS8uf9e6limYqRTAPt4BVdlMWBJIH0Pqx0C1pJV3F
         KWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696869385; x=1697474185;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5bqf+WARuWFIA4cLkesNXyhn8snKrlk6QVCk7crkS0E=;
        b=c3rZZbX9kYzpcOahHmRAL4YjDLbeqiKL58CE47ViVhWz56Hu8oHliUIEJt6K6AYFmq
         GH61E0UFkG8tOdH9NLh0fvUXS9RPLi0ppLcr3XXFC3ShvDOKcBnNSZnmJ4ETHrwen68t
         FAOsFIXMStKt4auETlFVZnGsSqwqMuKNo2zWhLmSnuFd0KPxDkMDU6d877kQ8EpiULaI
         99zNyeaYL67fnLVO/dW12slQEFQaR89MvhqKP9RFH+oFkuVhX8S8s7jQAktH8ABo8C7e
         +ByHCF9WFTKyRmIaBAS06M3ANZQh4EIeS4ZTimIWM8QoJEzkvWUUUiiemB8bCmJXJIIR
         I6OA==
X-Gm-Message-State: AOJu0Yy8l8RopH7t99BcPsl+3e+gnzXSzwCfEmZnURINchZ9M/b2aaDP
        UyqwlnglTUPg9E5l8Pz+wA22GA==
X-Google-Smtp-Source: AGHT+IFg3B6zOAypc0V3bLi8aDL9QfkLaIcbajwx5o42aw09GyvdhGnGg00L9X2l4a9L/OwG0dTD1Q==
X-Received: by 2002:adf:e406:0:b0:31a:e6c2:7705 with SMTP id g6-20020adfe406000000b0031ae6c27705mr13989202wrm.50.1696869384968;
        Mon, 09 Oct 2023 09:36:24 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id f11-20020a5d50cb000000b00325c7295450sm10141046wrt.3.2023.10.09.09.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:36:24 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 09 Oct 2023 18:36:13 +0200
Subject: [PATCH RFC 2/5] drm/msm: dpu1: add setup_clk_force_ctrl() op to
 sspp & wb
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231009-topic-sm8550-graphics-sspp-split-clk-v1-2-806c0dee4e43@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5800;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=UsctRRYNLStBxhKJjI99xX/Y38klI1PkyKSLSWf9Lsw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlJCwDCKoeqKUe5V6gK+tjjQ2Avfv8PC7K30/OsjKN
 iJ5UI+CJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZSQsAwAKCRB33NvayMhJ0fWwEA
 CEYAfQ35d59sGS5jfqQ/zg5p+2VXakbSGsiwxWf8/TnZNLJhVE64gKqPfNxJvaF2h7NQlJefN8mm0C
 D5Fb1jsh+O9iCtRaUG8ZlXSxj0b0CGqaGYe+/SG4TJhTgT1iyF5i7xk4VyGoRJcaUn29szsVQD2aJr
 x5w3pssyzpRkVPkw/48Hd2DTQPst4KnSekukvv/jUzbrJTQqXF7UrORQ1NbrJeCV8m1EyNbdwj3Gtl
 AS54U+9QGFJO4TgIBE5YLTNyievU1vJAkl7DL64rhtLT7R7hAZpoLMHDoQlFilNutraNBZHzKTxHWL
 3eDTP6iWnR/e5+LgJ4QZi6aK6w3OL3OcUY78cQg8xI6Kn6B/LwciI6e9Pwi9xtGY+KgOGimz5WTDZz
 tadDCmcVHhd7FoSzarFAtT4fjlNYpM8NMj5+OwTHdWEV93M1Br022BIbWwvwCIztaT1qggd533a/d8
 R89O4EfnxhPCo346Fc0xQXrZ8cLlaehM68+ty7duCfNHBZtDryQO9oBoFLHNMH5RqvWbol8mOzQfDe
 issW6kn08uoDXwo4RK+/4A/RCK289EjOussDoYeM0z6ConmiVBNoCT+xd8tPnjWXrfJ2/SaIQAFOQ5
 LN/zbIjdzYuZr+ZGiejPzY9VfR89u+qSX5st4jkANf0eRSWXhxNUrYkwttGg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting from SM8550, the SSPP & WB clock controls are moved
the SSPP and WB register range, as it's called "VBIF_CLK_SPLIT"
downstream.

An optional clk_ctrl struct is added to the SSPP & WB caps,
which can be used by the setup_clk_force_ctrl() op.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h | 4 ++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c    | 9 +++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h    | 9 +++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c      | 9 +++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h      | 4 ++++
 5 files changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index 6c9634209e9f..d9e8673e46f7 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -505,6 +505,7 @@ struct dpu_ctl_cfg {
  * @sblk:              SSPP sub-blocks information
  * @xin_id:            bus client identifier
  * @clk_ctrl           clock control identifier
+ * @clk_ctrl_reg       local sspp clock control register
  * @type               sspp type identifier
  */
 struct dpu_sspp_cfg {
@@ -512,6 +513,7 @@ struct dpu_sspp_cfg {
 	const struct dpu_sspp_sub_blks *sblk;
 	u32 xin_id;
 	enum dpu_clk_ctrl_type clk_ctrl;
+	const struct dpu_clk_ctrl_reg *clk_ctrl_reg;
 	u32 type;
 };
 
@@ -620,6 +622,7 @@ struct dpu_intf_cfg  {
  * @format_list:	    list of formats supported by this writeback block
  * @num_formats:	    number of formats supported by this writeback block
  * @clk_ctrl:	        clock control identifier
+ * @clk_ctrl_reg        local wb clock control register
  */
 struct dpu_wb_cfg {
 	DPU_HW_BLK_INFO;
@@ -630,6 +633,7 @@ struct dpu_wb_cfg {
 	const u32 *format_list;
 	u32 num_formats;
 	enum dpu_clk_ctrl_type clk_ctrl;
+	const struct dpu_clk_ctrl_reg *clk_ctrl_reg;
 };
 
 /**
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
index f2192de93713..cc4c7141791f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
@@ -581,6 +581,14 @@ static void dpu_hw_sspp_setup_cdp(struct dpu_sw_pipe *pipe,
 	dpu_setup_cdp(&ctx->hw, cdp_cntl_offset, fmt, enable);
 }
 
+static bool dpu_hw_sspp_setup_clk_force_ctrl(struct dpu_hw_sspp *ctx, bool enable)
+{
+	if (!ctx->cap->clk_ctrl_reg)
+		return false;
+
+	return dpu_hw_clk_force_ctrl(&ctx->hw, ctx->cap->clk_ctrl_reg, enable);
+}
+
 static void _setup_layer_ops(struct dpu_hw_sspp *c,
 		unsigned long features)
 {
@@ -589,6 +597,7 @@ static void _setup_layer_ops(struct dpu_hw_sspp *c,
 	c->ops.setup_sourceaddress = dpu_hw_sspp_setup_sourceaddress;
 	c->ops.setup_solidfill = dpu_hw_sspp_setup_solidfill;
 	c->ops.setup_pe = dpu_hw_sspp_setup_pe_config;
+	c->ops.setup_clk_force_ctrl = dpu_hw_sspp_setup_clk_force_ctrl;
 
 	if (test_bit(DPU_SSPP_QOS, &features)) {
 		c->ops.setup_qos_lut = dpu_hw_sspp_setup_qos_lut;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
index cbf4f95ff0fd..4a77734e83a7 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
@@ -11,6 +11,7 @@
 #include "dpu_formats.h"
 
 struct dpu_hw_sspp;
+struct dpu_hw_mdp;
 
 /**
  * Flags
@@ -271,6 +272,14 @@ struct dpu_hw_sspp_ops {
 	void (*setup_qos_ctrl)(struct dpu_hw_sspp *ctx,
 			       bool danger_safe_en);
 
+	/**
+	 * setup_clk_force_ctrl - setup clock force control
+	 * @ctx: Pointer to pipe context
+	 * @enable: enable clock force if true
+	 */
+	bool (*setup_clk_force_ctrl)(struct dpu_hw_sspp *ctx,
+				     bool enable);
+
 	/**
 	 * setup_histogram - setup histograms
 	 * @ctx: Pointer to pipe context
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c
index ebc416400382..045a4545a8c5 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c
@@ -175,11 +175,20 @@ static void dpu_hw_wb_bind_pingpong_blk(
 	DPU_REG_WRITE(c, WB_MUX, mux_cfg);
 }
 
+static bool dpu_hw_wb_setup_clk_force_ctrl(struct dpu_hw_wb *ctx, bool enable)
+{
+	if (!ctx->caps->clk_ctrl_reg)
+		return false;
+
+	return dpu_hw_clk_force_ctrl(&ctx->hw, ctx->caps->clk_ctrl_reg, enable);
+}
+
 static void _setup_wb_ops(struct dpu_hw_wb_ops *ops,
 		unsigned long features)
 {
 	ops->setup_outaddress = dpu_hw_wb_setup_outaddress;
 	ops->setup_outformat = dpu_hw_wb_setup_format;
+	ops->setup_clk_force_ctrl = dpu_hw_wb_setup_clk_force_ctrl;
 
 	if (test_bit(DPU_WB_XY_ROI_OFFSET, &features))
 		ops->setup_roi = dpu_hw_wb_roi;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h
index 2d7db2efa3d0..3734ca435e01 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h
@@ -29,6 +29,7 @@ struct dpu_hw_wb_cfg {
  *  @setup_outformat: setup output format of writeback block from writeback job
  *  @setup_qos_lut:   setup qos LUT for writeback block based on input
  *  @setup_cdp:       setup chroma down prefetch block for writeback block
+ *  @setup_clk_force_ctrl: setup clock force control
  *  @bind_pingpong_blk: enable/disable the connection with ping-pong block
  */
 struct dpu_hw_wb_ops {
@@ -48,6 +49,9 @@ struct dpu_hw_wb_ops {
 			  const struct dpu_format *fmt,
 			  bool enable);
 
+	bool (*setup_clk_force_ctrl)(struct dpu_hw_wb *ctx,
+				     bool enable);
+
 	void (*bind_pingpong_blk)(struct dpu_hw_wb *ctx,
 				  const enum dpu_pingpong pp);
 };

-- 
2.34.1

