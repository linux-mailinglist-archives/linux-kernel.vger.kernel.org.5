Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C3978CC6E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238274AbjH2SsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 14:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238275AbjH2Srq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:47:46 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499CA1A2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 11:47:44 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bf3a2f4528so37325225ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 11:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693334864; x=1693939664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V46+9RLRUs4jn3oMfUKtRDAEvgB49sGBWfYkBPv0+7o=;
        b=V/nm6vszO+uvEgAFcBm6ctl27mmYNTIbrvxYVif2P7XV8O9SZ4LQwXasF6coGjMn/T
         PKadI4pkh9xKzUC4CF1RfTbzxH/u80SEUUHcmsx2hmBOVqzX+ILpLP93898uIus/iEL3
         OjamnOk5JD6kmxjUiibEJFzjti2YpMem+i4X4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693334864; x=1693939664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V46+9RLRUs4jn3oMfUKtRDAEvgB49sGBWfYkBPv0+7o=;
        b=Ir/cBJRKSmGUhF8YS7wlR+ACRT8XCSlVL+qmZc/SQ8lD8RgAOy0OfTBUX0jR7Rc3PN
         eUOw6QwBWLm5xr+HMXs9JBEkDersuP2a4G24omx+maGbmZKsaJDw+yowi2U8YEpxzWyP
         vwGuKSb66UUDnpq9Hp1sbruqYFYvqhpfWiSskadUJa0fMipcglD8rhXtI+Pu2VAuZfrj
         phaZAZJ/Ufe6QL/0qv9WZXxBVhGEkXjqKgLPw9gPkQ27MNip9r1PxkxRE//X4M9/p47N
         8amHfuaxwSWLTmFPfzO42iG5Onu8Vwtoonm0KxoOMjmB7dVcW536++bLLNURW7GPkIB+
         T0xA==
X-Gm-Message-State: AOJu0Yw7S0vyeFeRF/RXZjpoGoOMKVwMm3mOaSTrOx96KtHj7VEFziM/
        OMunbYf0Xyjxocf7vBga8za8EQ==
X-Google-Smtp-Source: AGHT+IFQ+sayvRTbFlB/yJwtr4beqBjEBFE4xO6oxnY7iGPiTXaDK/H6T4fPE7QuZzDpNy7Vg0mguQ==
X-Received: by 2002:a17:902:db0e:b0:1bf:a41:371e with SMTP id m14-20020a170902db0e00b001bf0a41371emr38019313plx.56.1693334863827;
        Tue, 29 Aug 2023 11:47:43 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:11a:201:d603:22a7:5e5e:d239])
        by smtp.gmail.com with ESMTPSA id o15-20020a170902d4cf00b001b9e86e05b7sm9697953plg.0.2023.08.29.11.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 11:47:43 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Subject: [PATCH 3/7] drm/msm/dp: Remove dead code related to downstream cap info
Date:   Tue, 29 Aug 2023 11:47:28 -0700
Message-ID: <20230829184735.2841739-4-swboyd@chromium.org>
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

We read the downstream port count and capability info but never use it
anywhere. Remove 'ds_port_cnt' and 'ds_cap_info' and any associated code
from this driver. Fold the check for 'dfp_present' into a call to
drm_dp_is_branch() at the one place it is used to get rid of any member
storage related to downstream ports.

Cc: Vinod Polimera <quic_vpolimer@quicinc.com>
Cc: Kuogee Hsieh <quic_khsieh@quicinc.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/msm/dp/dp_panel.c | 25 +++----------------------
 drivers/gpu/drm/msm/dp/dp_panel.h |  6 ------
 2 files changed, 3 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index a0523b18b9e9..9fb4e963fefb 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -43,9 +43,7 @@ static void dp_panel_read_psr_cap(struct dp_panel_private *panel)
 
 static int dp_panel_read_dpcd(struct dp_panel *dp_panel)
 {
-	int rc = 0;
-	size_t len;
-	ssize_t rlen;
+	int rc;
 	struct dp_panel_private *panel;
 	struct dp_link_info *link_info;
 	u8 *dpcd, major, minor;
@@ -79,25 +77,8 @@ static int dp_panel_read_dpcd(struct dp_panel *dp_panel)
 	if (drm_dp_enhanced_frame_cap(dpcd))
 		link_info->capabilities |= DP_LINK_CAP_ENHANCED_FRAMING;
 
-	dp_panel->dfp_present = dpcd[DP_DOWNSTREAMPORT_PRESENT];
-	dp_panel->dfp_present &= DP_DWN_STRM_PORT_PRESENT;
-
-	if (dp_panel->dfp_present && (dpcd[DP_DPCD_REV] > 0x10)) {
-		dp_panel->ds_port_cnt = dpcd[DP_DOWN_STREAM_PORT_COUNT];
-		dp_panel->ds_port_cnt &= DP_PORT_COUNT_MASK;
-		len = DP_DOWNSTREAM_PORTS * DP_DOWNSTREAM_CAP_SIZE;
-
-		rlen = drm_dp_dpcd_read(panel->aux,
-			DP_DOWNSTREAM_PORT_0, dp_panel->ds_cap_info, len);
-		if (rlen < len) {
-			DRM_ERROR("ds port status failed, rlen=%zd\n", rlen);
-			rc = -EINVAL;
-			goto end;
-		}
-	}
-
 	dp_panel_read_psr_cap(panel);
-end:
+
 	return rc;
 }
 
@@ -173,7 +154,7 @@ int dp_panel_read_sink_caps(struct dp_panel *dp_panel,
 		return -EINVAL;
 	}
 
-	if (dp_panel->dfp_present) {
+	if (drm_dp_is_branch(dp_panel->dpcd)) {
 		count = drm_dp_read_sink_count(panel->aux);
 		if (!count) {
 			DRM_ERROR("no downstream ports connected\n");
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
index 6d733480a62d..3cb1f8dcfd3b 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.h
+++ b/drivers/gpu/drm/msm/dp/dp_panel.h
@@ -13,9 +13,6 @@
 
 struct edid;
 
-#define DP_DOWNSTREAM_PORTS		4
-#define DP_DOWNSTREAM_CAP_SIZE		4
-
 struct dp_display_mode {
 	struct drm_display_mode drm_mode;
 	u32 capabilities;
@@ -39,9 +36,6 @@ struct dp_panel_psr {
 struct dp_panel {
 	/* dpcd raw data */
 	u8 dpcd[DP_RECEIVER_CAP_SIZE];
-	u8 ds_cap_info[DP_DOWNSTREAM_PORTS * DP_DOWNSTREAM_CAP_SIZE];
-	u32 ds_port_cnt;
-	u32 dfp_present;
 
 	struct dp_link_info link_info;
 	struct drm_dp_desc desc;
-- 
https://chromeos.dev

