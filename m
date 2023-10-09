Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB1B7BE694
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377663AbjJIQgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377255AbjJIQg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:36:29 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE06F9E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 09:36:27 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-317c3ac7339so4327315f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 09:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696869386; x=1697474186; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5PCLKpDplxEi6g+GHgYMxjppZKKeUtHeWR9UsKPnFr0=;
        b=b53gXm8dLtOO0gVrdLjGAK1xIk2JrDlh3lijYQVmm9kdT2UbjRC1/PGPNCRyLM6Z+4
         9BzncVjOrCtkhUPVH4eF/Jh0zrq5Yqyp16j5ZBHXHXVWWEwWWSmZ3vD4g9GT2pQy7QXB
         06N+HJMckNGcDS5Dm7pZNoO0N6NbtoYe0NveyIImYXwz2qp1TEEz+5R/CIVWBKWAdkeF
         H7wTp7GeGsgqcfgEs1AXXUDIr24szq9X97Jql2Cg6dzWCvUZnSyR8zLYcPgMK9+Hgi3W
         6ROSwmM0KBtBtV2SgflKtXfwqNcJi/cDkL9Vb7K4IeK84Pcvqwd5veDGP8vte4TdMOJ4
         m4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696869386; x=1697474186;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5PCLKpDplxEi6g+GHgYMxjppZKKeUtHeWR9UsKPnFr0=;
        b=hY6vQB+U3NtX7EWla1hLjOYdWbhDYRgS5EGhFRR73chGrQYDZoJSntjaYf8ihcReij
         X/3BmonDKSor4g+2mkh3x13lcl9iPDryNqkyMHPEfH9q5URCriNxvWM53jvWAYwJzkOp
         iASdUK8kydtsqC3LxXsVeMPZolXKI81OMCpm4PRAhfQzrl9gMO69t3NSLLujtIriLRoH
         1OJ4ulxfjxxtsveq60J6pRvRjgFqSHTjt0TxS3TuLktygPhi1IMwUz8W7ijgqU65vnsu
         NjoOXtN715NM4EH4SJBPSXdkJQjtZfdy/fM0MJ4AeSWS6ZhXggCbG+yfQo1pqYXednOR
         iZ/g==
X-Gm-Message-State: AOJu0YwN1fk/FsXomFpmPlbQv1bSivAC+0+kx5fdpUOhsGBTnMfa+Iiw
        NxPqzuBCnf5ydU67OfMnpLh1ug==
X-Google-Smtp-Source: AGHT+IEzbTMAE5w16hwu+51q9w39EXdZmjD15W3quhSWcZGUvRZuHo6gtNEIO7U9AW7rzLim8rJ0jw==
X-Received: by 2002:adf:e606:0:b0:317:6314:96e2 with SMTP id p6-20020adfe606000000b00317631496e2mr13142379wrm.14.1696869385860;
        Mon, 09 Oct 2023 09:36:25 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id f11-20020a5d50cb000000b00325c7295450sm10141046wrt.3.2023.10.09.09.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:36:25 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 09 Oct 2023 18:36:14 +0200
Subject: [PATCH RFC 3/5] drm/msm: dpu1: vbif: add
 dpu_vbif_setup_clk_force_ctrl() helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231009-topic-sm8550-graphics-sspp-split-clk-v1-3-806c0dee4e43@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2343;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=GDPgpk2/mayRlWQFJdU3lhxk3/qUCU3a1fQFXnOYaXM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlJCwD7DTIAti95TB7gGnRUdufNBcLE7Oe7bz9Ds5N
 2qIjpH+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZSQsAwAKCRB33NvayMhJ0XWrD/
 9GJDeVqlUCf+IWQm556T1txr5P26ZJ3XsF2gHrhlARuBcI0Pmv6kO6kOhZsET5Vz7GqkdZetlINGqi
 7bTaYkj3GnFXOuFcegAhSqX2D8jmuFaUyXCcuKzzfo2WM+O/Hv1ZCW2BmbgixO5i+3SvQbAJzpRL2x
 4LKcy5nvNemvrjBFN9Fo4RQ+27iSvyTulBeFPKw/yWB2H9mnLr3UZ16wQ9pYjXSOAOwzFFxFISlF7j
 G4QGFDhPiM4W08CoVCnpQjw0ImDbJGFRUkMl1q7xrd/ajfezQEW6NVxgYLMC9n1XC5BrnYht2lLcU/
 QBg2Yp7Awza9WtVN4b/NDZ48ywrgFH5NUdUoQdDUKYsabAA+zDceaeqvITse/GDzXec5bJPkdvaiZ7
 POYNw6V6rwWaUbkLi4MLO4oUhit+ZeBC0JCMVep5/cMQZ2AKKS8oogRsAgYaPDf2gHoQLk5m0Uh8MB
 a9u6rIPC+SI3X2t2IjDeJgTP2pD0zLN/5rDt5SK0FVWcNdHjetgyJVgHUGOsdflccx1AjqjtLM3L4H
 3WMCDRoHJ4UcMEs4JvWRYQnatK8R5NXuhE82C+bdFHFuhQ8QOkHIyOP531D7xbjlEficlyRAo76SIV
 2i0Mv2rc1e2WpjpHfpcYdGWmhkggqjxQZxtsnH76xD+MGgM9rluyM1rvla7Q==
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

Move the actual call to the MDP setup_clk_force_ctrl() op to
an helper which will call the correct op depending on the caps.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c
index 1305e250b71e..2ae5cba1848b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c
@@ -158,6 +158,13 @@ static u32 _dpu_vbif_get_ot_limit(struct dpu_hw_vbif *vbif,
 	return ot_lim;
 }
 
+static bool dpu_vbif_setup_clk_force_ctrl(struct dpu_hw_mdp *mdp,
+					  unsigned int clk_ctrl,
+					  bool enable)
+{
+	return mdp->ops.setup_clk_force_ctrl(mdp, clk_ctrl, enable);
+}
+
 /**
  * dpu_vbif_set_ot_limit - set OT based on usecase & configuration parameters
  * @dpu_kms:	DPU handler
@@ -200,7 +207,7 @@ void dpu_vbif_set_ot_limit(struct dpu_kms *dpu_kms,
 	trace_dpu_perf_set_ot(params->num, params->xin_id, ot_lim,
 		params->vbif_idx);
 
-	forced_on = mdp->ops.setup_clk_force_ctrl(mdp, params->clk_ctrl, true);
+	forced_on = dpu_vbif_setup_clk_force_ctrl(mdp, params->clk_ctrl, true);
 
 	vbif->ops.set_limit_conf(vbif, params->xin_id, params->rd, ot_lim);
 
@@ -213,7 +220,7 @@ void dpu_vbif_set_ot_limit(struct dpu_kms *dpu_kms,
 	vbif->ops.set_halt_ctrl(vbif, params->xin_id, false);
 
 	if (forced_on)
-		mdp->ops.setup_clk_force_ctrl(mdp, params->clk_ctrl, false);
+		dpu_vbif_setup_clk_force_ctrl(mdp,  params->clk_ctrl, false);
 }
 
 void dpu_vbif_set_qos_remap(struct dpu_kms *dpu_kms,
@@ -251,7 +258,7 @@ void dpu_vbif_set_qos_remap(struct dpu_kms *dpu_kms,
 		return;
 	}
 
-	forced_on = mdp->ops.setup_clk_force_ctrl(mdp, params->clk_ctrl, true);
+	forced_on = dpu_vbif_setup_clk_force_ctrl(mdp, params->clk_ctrl, true);
 
 	for (i = 0; i < qos_tbl->npriority_lvl; i++) {
 		DRM_DEBUG_ATOMIC("%s xin:%d lvl:%d/%d\n",
@@ -262,7 +269,7 @@ void dpu_vbif_set_qos_remap(struct dpu_kms *dpu_kms,
 	}
 
 	if (forced_on)
-		mdp->ops.setup_clk_force_ctrl(mdp, params->clk_ctrl, false);
+		dpu_vbif_setup_clk_force_ctrl(mdp, params->clk_ctrl, false);
 }
 
 void dpu_vbif_clear_errors(struct dpu_kms *dpu_kms)

-- 
2.34.1

