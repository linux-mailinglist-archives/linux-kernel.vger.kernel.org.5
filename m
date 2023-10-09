Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A857BE68B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377271AbjJIQga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377206AbjJIQg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:36:27 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBA8B7
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 09:36:25 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32483535e51so4724008f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 09:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696869384; x=1697474184; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D05Lo/nbBOabodso2ZTFF+A5WDtwFnSg45QKqcMzRio=;
        b=UYv/9DLRLB8dIy/ZOiFSGxW8jVLkEitZ3p9Xbcw6QQFKz0cBh9mzaMXWZmV3+tDidf
         MIU5OrfIzN3ZBFMNg2Aof/d8Yqb+vgaM6VuMRxNECtAAJIH1O3gwWdabicGOJIwRdCcQ
         rXrqZOtowJqeUhLfvN7/9UB41L0v/OIFV9MTUKeyHkFSDdNhmGj3U0XL4cZfzT1SsmYP
         ecDAAJ11SXMGGUNgB+1HKE5FnTc381sz4pTUezbj/Yk44aoA1Wz1XxIBz+gpCP+eu1A8
         j9k1dfWNeVKCGECiqaxJy5RGIjSSUL1C1xfBgx6yP8262ivWcOrAQ0HBaZrYZQzNEAmp
         AlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696869384; x=1697474184;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D05Lo/nbBOabodso2ZTFF+A5WDtwFnSg45QKqcMzRio=;
        b=ujo8Tb94r5xMIw1HkSPqTA1hoDDqWxzCp1thIchpVx1dhuLLkxXNN1cP3xUWJNyglc
         2hj4WyBHNDfzUGHzK40f9QsNE0LZ2Q4EuN81+0zJJXmfW04ziEPc7BIoH+GVzgYzaCav
         ViFCXf8H8r1pktVH7hY1a0oodseF1M2fZXjBKoOiRZa/u2lAv0ejSNlK73vZtktk6D54
         UUf4125Dssw2THNRBXUQfDZVG1gn0YYsPu3brM7oovbT95c/m2JZqhW5ET/IghvKFvpv
         HN7Vea0Kd7WL68lc69fYpM/jFFNVEke4ex2mpH1p2BsQx4nJ9t/4hy0klXt0xXQyLwbd
         EGHw==
X-Gm-Message-State: AOJu0YyHjvZLqu4Yop/WjSin6EMZQ8fmnOL0ON9NQ8NMzaFWbOQg2noI
        Kr5uDj1YhlPk4yFioa/VgR8qlg==
X-Google-Smtp-Source: AGHT+IGMs2jcxJbCcNU6v5VJXQwrcwjGVaZP9fsvilLN+hG/oeUiQjzXxd23nT/n0khpS6mG8NoYUw==
X-Received: by 2002:a05:6000:369:b0:313:f0d7:a43 with SMTP id f9-20020a056000036900b00313f0d70a43mr13201614wrf.23.1696869384028;
        Mon, 09 Oct 2023 09:36:24 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id f11-20020a5d50cb000000b00325c7295450sm10141046wrt.3.2023.10.09.09.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:36:23 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 09 Oct 2023 18:36:12 +0200
Subject: [PATCH RFC 1/5] drm/msm: dpu1: create a dpu_hw_clk_force_ctrl()
 helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231009-topic-sm8550-graphics-sspp-split-clk-v1-1-806c0dee4e43@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3039;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=w8QME6lb06IRAEWeDjQtCgtkQ3dhfhOIl/dNSswSn2o=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlJCwCAQuQy1VWK0/WhgBRAJVbFRibDoMXSMpWzXim
 cBf/7YWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZSQsAgAKCRB33NvayMhJ0WjhEA
 CbQwbXhMPPOmRTXsYonJvpnUUTqPvv9n7RGwyqEuwY2qU/dUky51NODywDGI7UOcME5BzAPa0EuMlx
 z5GNDLIgkhMd2P268F84m9CVL2GwYZBVs12p5zBHEoCGpLTS7a8VWkRrVXzAjUzIcw9XexYBsm9iJC
 0x9Zrd1e/Lferxn2YjBE23PD4jR+MArSlUjL3daeHBMFS196dGe2UOJBT+BrSUchnX1ECcQXogsAHM
 aJ9eW5EtwGZOvlVUtXSyAscFVU44EGRsvINVDzLQPF/8eMObmMf0En6lu5B2/MEh+oRrKY/4J3zvum
 IMppi5Wf6YVIu9I4iMcHmQERWklO+L52WgSEzA/lR7+Dn47O00gncIX0rEGkvAObYyxl4DhfnXl8/q
 43Sk69KAhN3FJ6HlHiU/fjuxgsxKs8kxURF2AyLEu2w0+FhPv1Q1ursEkLNr1rwvo58x23Z3r13XLJ
 7tz7h+DWAJIZ+a22ORMnWrWGLEDIYJ+FW9sTumm5GYwhKSz8XaOU/m980NorLexz+L0lxsvGt4BCe7
 hyL4GVo2VHsGZMgqLri+jok9x5MFRZkOk3OsLjes4N0oIAkXFtUCi9Q3c92B7jjO8tbjqOGHw8C5/B
 DIuYJYX7WmGCgWETDP5TBYussopEROqoJf1FMTYsqWXa1pu4MPTtwFxC8lCg==
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

Add an helper to setup the force clock control as it will
be used in multiple HW files.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c  | 23 +----------------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c | 21 +++++++++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h |  4 ++++
 3 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c
index cff48763ce25..24e734768a72 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c
@@ -66,34 +66,13 @@ static void dpu_hw_setup_split_pipe(struct dpu_hw_mdp *mdp,
 static bool dpu_hw_setup_clk_force_ctrl(struct dpu_hw_mdp *mdp,
 		enum dpu_clk_ctrl_type clk_ctrl, bool enable)
 {
-	struct dpu_hw_blk_reg_map *c;
-	u32 reg_off, bit_off;
-	u32 reg_val, new_val;
-	bool clk_forced_on;
-
 	if (!mdp)
 		return false;
 
-	c = &mdp->hw;
-
 	if (clk_ctrl <= DPU_CLK_CTRL_NONE || clk_ctrl >= DPU_CLK_CTRL_MAX)
 		return false;
 
-	reg_off = mdp->caps->clk_ctrls[clk_ctrl].reg_off;
-	bit_off = mdp->caps->clk_ctrls[clk_ctrl].bit_off;
-
-	reg_val = DPU_REG_READ(c, reg_off);
-
-	if (enable)
-		new_val = reg_val | BIT(bit_off);
-	else
-		new_val = reg_val & ~BIT(bit_off);
-
-	DPU_REG_WRITE(c, reg_off, new_val);
-
-	clk_forced_on = !(reg_val & BIT(bit_off));
-
-	return clk_forced_on;
+	return dpu_hw_clk_force_ctrl(&mdp->hw, &mdp->caps->clk_ctrls[clk_ctrl], enable);
 }
 
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c
index 9d2273fd2fed..18b16b2d2bf5 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c
@@ -546,3 +546,24 @@ void dpu_setup_cdp(struct dpu_hw_blk_reg_map *c, u32 offset,
 
 	DPU_REG_WRITE(c, offset, cdp_cntl);
 }
+
+bool dpu_hw_clk_force_ctrl(struct dpu_hw_blk_reg_map *c,
+			   const struct dpu_clk_ctrl_reg *clk_ctrl_reg,
+			   bool enable)
+{
+	u32 reg_val, new_val;
+	bool clk_forced_on;
+
+	reg_val = DPU_REG_READ(c, clk_ctrl_reg->reg_off);
+
+	if (enable)
+		new_val = reg_val | BIT(clk_ctrl_reg->bit_off);
+	else
+		new_val = reg_val & ~BIT(clk_ctrl_reg->bit_off);
+
+	DPU_REG_WRITE(c, clk_ctrl_reg->reg_off, new_val);
+
+	clk_forced_on = !(reg_val & BIT(clk_ctrl_reg->bit_off));
+
+	return clk_forced_on;
+}
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h
index 1f6079f47071..4bea139081bc 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h
@@ -367,4 +367,8 @@ int dpu_hw_collect_misr(struct dpu_hw_blk_reg_map *c,
 		u32 misr_signature_offset,
 		u32 *misr_value);
 
+bool dpu_hw_clk_force_ctrl(struct dpu_hw_blk_reg_map *c,
+			   const struct dpu_clk_ctrl_reg *clk_ctrl_reg,
+			   bool enable);
+
 #endif /* _DPU_HW_UTIL_H */

-- 
2.34.1

