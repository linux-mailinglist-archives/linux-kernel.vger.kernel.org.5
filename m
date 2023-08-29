Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C2478CC72
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238362AbjH2SsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 14:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238411AbjH2Srt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:47:49 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E101A4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 11:47:47 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68a42d06d02so3308980b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 11:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693334867; x=1693939667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buOYirvM4LTz9UY1JGw3dQAfNg4ODZnJm46kyV7UDeA=;
        b=Xxh3Q8SCgpfoxsg1ZF3jrtLtAsdg/veTKayWHOfoB64sgg/pNfM+PEzYvOcRHsM8E/
         bWeR/GIWYbsvZWqJXrH4seNSOO2T/+H1OeDZuWSDo+G+lq1aERCgtFxlI5deb1zTmnsf
         3j+OBKAZpWQp3X3GnHWan09VsCrpLyHbUTQOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693334867; x=1693939667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=buOYirvM4LTz9UY1JGw3dQAfNg4ODZnJm46kyV7UDeA=;
        b=dNbR51RbRIyc7+Umvb6v2hSvL5XzwYHtFJP3swBf8LveiyLIH5QrS11qmtFw9Hz7Py
         zXBbibbpbatu5D8k3L3Z2R1+WoLilvkGaaD+bZJ9ZdJZx9H9g6gP3ziqiIMVIcpU8vtT
         uUgJXX04RiJfc2Qz5koz4lPwG6QjE/8Z56cCB2RXyZRLaudTaPi4HjJfzoZnQvLcijOF
         ppry9OwufedgWZKdIcSgOFQ5uXrQEIlghDGSdB4opaomgBpDcxG6JnN9tyTUOLzNTKyk
         Ytqu1dT4rjJp9vhgZoj7FJ8nNZHeKQUHQ91wSHmJii5kGPZL+TQpT1YkRj65BHAgahGG
         bobg==
X-Gm-Message-State: AOJu0Yz835/MrOQ5W4mSn7KWhHIVZndNJNPSwuGUCBR4fxmSshb+U+Tf
        jjW6KKe3WW7tNQsNo8zB3ItU7g==
X-Google-Smtp-Source: AGHT+IGoA9R8jy+DLGU8vBrurRLkpQ3/Zg84i8rJk8UcpO+wc/82SKC/x3KJjnmNJ9rfBhL040LnrA==
X-Received: by 2002:a05:6a20:729d:b0:140:4563:2243 with SMTP id o29-20020a056a20729d00b0014045632243mr138196pzk.50.1693334866790;
        Tue, 29 Aug 2023 11:47:46 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:11a:201:d603:22a7:5e5e:d239])
        by smtp.gmail.com with ESMTPSA id o15-20020a170902d4cf00b001b9e86e05b7sm9697953plg.0.2023.08.29.11.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 11:47:46 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Subject: [PATCH 5/7] drm/msm/dp: Simplify with drm_dp_{max_link_rate,max_lane_count}()
Date:   Tue, 29 Aug 2023 11:47:30 -0700
Message-ID: <20230829184735.2841739-6-swboyd@chromium.org>
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

These are open-coded versions of common functions. Replace them with the
common code to improve readability.

Cc: Vinod Polimera <quic_vpolimer@quicinc.com>
Cc: Kuogee Hsieh <quic_khsieh@quicinc.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/msm/dp/dp_panel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index 0893522ae158..97ba41593820 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -58,8 +58,8 @@ static int dp_panel_read_dpcd(struct dp_panel *dp_panel)
 	major = (link_info->revision >> 4) & 0x0f;
 	minor = link_info->revision & 0x0f;
 
-	link_info->rate = drm_dp_bw_code_to_link_rate(dpcd[DP_MAX_LINK_RATE]);
-	link_info->num_lanes = dpcd[DP_MAX_LANE_COUNT] & DP_MAX_LANE_COUNT_MASK;
+	link_info->rate = drm_dp_max_link_rate(dpcd);
+	link_info->num_lanes = drm_dp_max_lane_count(dpcd);
 
 	/* Limit data lanes from data-lanes of endpoint property of dtsi */
 	if (link_info->num_lanes > dp_panel->max_dp_lanes)
-- 
https://chromeos.dev

