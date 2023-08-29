Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B92978CC6C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238254AbjH2SsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 14:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238247AbjH2Sro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:47:44 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FB8C5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 11:47:41 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bdf4752c3cso29074705ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 11:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693334861; x=1693939661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zy1QTPwLj2+EWnTOjoPoVz867Fu7gzyOgxl1+3H6Nnc=;
        b=fdXiyQd+R3qGm5Nphv+8j5xKo14D3w9yIQArlsiouC4hZls3koS/DnWkpoXCL/18I6
         fttfwSMZPVXcZ4Qctb7Xe7vRYvQbK+BVK2z+fX3JeqH7glikDw+cg81t/UDclLVVpMuM
         ynZ7Trrudlfu8n4mGrQEaO1hbAOb0Y4HUDpKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693334861; x=1693939661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zy1QTPwLj2+EWnTOjoPoVz867Fu7gzyOgxl1+3H6Nnc=;
        b=ZU9mDsYXt9eCocobEF74+S5zLr+G1jY58U7Q0WcXnIIBjeb58Z92KsGGWeswFeO9ek
         x9hPc4CrjLqzXNqFc17m8jMddzUGHxy/050dQJgOrdY76/9RvUIH8jX+vde18IjXMOzr
         CAwr7/virTsAamu6jcofnboNutBGRv9MXjdMY/PiXb5hqtaZH63b2V97j12fmzHKpzg7
         JwDFORIsXqIItelHu5rUlc/HvbOsPTnOlkBdM+aPpqR685f5pbDVA+bT0zPl6Uh2YHbR
         N2xDAgITbNpuJn5iHqn4Akdh3X1GJj/7qbPpLgEXz44gAOgp/pb4HmGoBgqqUDpKbLkL
         uLwA==
X-Gm-Message-State: AOJu0Yz1fdLL8X7BadLDKtGo/YgdJopf+oLpPLDXSYT1qj+5wbghgCl+
        HCa68hXy41gkcvP+2C/4uca8gpzYUdplzXYg+d4=
X-Google-Smtp-Source: AGHT+IHOR7LHxCdUXoZltRyEuyQ9vz2U+mpOg+PlnYRlpoqnQkJZmp/tPsmE6qYU14e9a+3nTx5+mg==
X-Received: by 2002:a17:902:eacc:b0:1bc:6dd9:82c3 with SMTP id p12-20020a170902eacc00b001bc6dd982c3mr24966758pld.37.1693334860713;
        Tue, 29 Aug 2023 11:47:40 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:11a:201:d603:22a7:5e5e:d239])
        by smtp.gmail.com with ESMTPSA id o15-20020a170902d4cf00b001b9e86e05b7sm9697953plg.0.2023.08.29.11.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 11:47:40 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Subject: [PATCH 1/7] drm/msm/dp: Replace open-coded drm_dp_read_dpcd_caps()
Date:   Tue, 29 Aug 2023 11:47:26 -0700
Message-ID: <20230829184735.2841739-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230829184735.2841739-1-swboyd@chromium.org>
References: <20230829184735.2841739-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function duplicates the common function drm_dp_read_dpcd_caps().
The array of DPCD registers filled in is one size larger than the
function takes, but from what I can tell that extra byte was never used.
Resize the array and use the common function to reduce the code here.

Cc: Vinod Polimera <quic_vpolimer@quicinc.com>
Cc: Kuogee Hsieh <quic_khsieh@quicinc.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/msm/dp/dp_panel.c | 42 ++++---------------------------
 drivers/gpu/drm/msm/dp/dp_panel.h |  4 +--
 2 files changed, 6 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index 42d52510ffd4..09d4f6c38ef8 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -48,47 +48,15 @@ static int dp_panel_read_dpcd(struct dp_panel *dp_panel)
 	ssize_t rlen;
 	struct dp_panel_private *panel;
 	struct dp_link_info *link_info;
-	u8 *dpcd, major = 0, minor = 0, temp;
-	u32 offset = DP_DPCD_REV;
+	u8 *dpcd, major, minor;
 
+	panel = container_of(dp_panel, struct dp_panel_private, dp_panel);
 	dpcd = dp_panel->dpcd;
+	rc = drm_dp_read_dpcd_caps(panel->aux, dpcd);
+	if (rc)
+		return rc;
 
-	panel = container_of(dp_panel, struct dp_panel_private, dp_panel);
 	link_info = &dp_panel->link_info;
-
-	rlen = drm_dp_dpcd_read(panel->aux, offset,
-			dpcd, (DP_RECEIVER_CAP_SIZE + 1));
-	if (rlen < (DP_RECEIVER_CAP_SIZE + 1)) {
-		DRM_ERROR("dpcd read failed, rlen=%zd\n", rlen);
-		if (rlen == -ETIMEDOUT)
-			rc = rlen;
-		else
-			rc = -EINVAL;
-
-		goto end;
-	}
-
-	temp = dpcd[DP_TRAINING_AUX_RD_INTERVAL];
-
-	/* check for EXTENDED_RECEIVER_CAPABILITY_FIELD_PRESENT */
-	if (temp & BIT(7)) {
-		drm_dbg_dp(panel->drm_dev,
-				"using EXTENDED_RECEIVER_CAPABILITY_FIELD\n");
-		offset = DPRX_EXTENDED_DPCD_FIELD;
-	}
-
-	rlen = drm_dp_dpcd_read(panel->aux, offset,
-		dpcd, (DP_RECEIVER_CAP_SIZE + 1));
-	if (rlen < (DP_RECEIVER_CAP_SIZE + 1)) {
-		DRM_ERROR("dpcd read failed, rlen=%zd\n", rlen);
-		if (rlen == -ETIMEDOUT)
-			rc = rlen;
-		else
-			rc = -EINVAL;
-
-		goto end;
-	}
-
 	link_info->revision = dpcd[DP_DPCD_REV];
 	major = (link_info->revision >> 4) & 0x0f;
 	minor = link_info->revision & 0x0f;
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
index ed1030e17e1b..6d733480a62d 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.h
+++ b/drivers/gpu/drm/msm/dp/dp_panel.h
@@ -13,8 +13,6 @@
 
 struct edid;
 
-#define DPRX_EXTENDED_DPCD_FIELD	0x2200
-
 #define DP_DOWNSTREAM_PORTS		4
 #define DP_DOWNSTREAM_CAP_SIZE		4
 
@@ -40,7 +38,7 @@ struct dp_panel_psr {
 
 struct dp_panel {
 	/* dpcd raw data */
-	u8 dpcd[DP_RECEIVER_CAP_SIZE + 1];
+	u8 dpcd[DP_RECEIVER_CAP_SIZE];
 	u8 ds_cap_info[DP_DOWNSTREAM_PORTS * DP_DOWNSTREAM_CAP_SIZE];
 	u32 ds_port_cnt;
 	u32 dfp_present;
-- 
https://chromeos.dev

