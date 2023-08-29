Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA88A78CC71
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238485AbjH2SsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 14:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238449AbjH2Srw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:47:52 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13776FC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 11:47:50 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68c576d35feso1904410b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 11:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693334869; x=1693939669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDFi+t2HGk6Ez2m1E1bDJmYF5dLdXGiplCl4kzCCGIw=;
        b=oJz2sD2C3Cvjxf2FVvMIRUzL397azxk6BUKu5biuSbwp6dD4XVebY3fok88O1Q727T
         z9qRCc9e+2/Xq7HodYU9n7GkoRyQHiC4wOmOE37hnZ4d9Bdxv3QOQhAphMRMRxGWAluZ
         YZgonyITYkZXrrUm7/50OiBepbxYVb5KkROjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693334869; x=1693939669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDFi+t2HGk6Ez2m1E1bDJmYF5dLdXGiplCl4kzCCGIw=;
        b=IxR8v3bKZqvyEim/2O91f+saGKNrBX6cXpoch0MJbDq3EEnQ/WHUGhYoy73jdD10lc
         2Wfocgezm95lx2im2FwFPgntRo/+MAz4hPM0Cf45HRpoiGH00yJ5OzvpA62BPyGr4YRo
         RCoeO/3kXyJX//hM+OahQy9Q8Z8AuZmwKcje+md+EKtrssHUJr1q5QVUqhPdiXH3O8fX
         UTPW53IWuwtYt+V5wI0GPICmFi/qeBiwWg00g2GKJMNcZSKJra5SaqklnQ3h9hQssxnc
         aydSrc2BYRZ7wS+1k/ky2XtiyWxifMncf1zT2hza1ylXcS9x0ifsNbrjrTUni3c5IFaz
         xJlQ==
X-Gm-Message-State: AOJu0Ywl15AUTX31Dh66aCuA5zq01/KbmO9eN4KcCFisirKjG4Y7dytf
        qnR3UK5W/oEDpLWXrj48ce1Pyw==
X-Google-Smtp-Source: AGHT+IG58CNBx1V/eqpVdTw/QvBwIlAZBBILyaosLO9zrBbi7Cn4JE3QPxGI+6zG/AqLakLHAjK+GQ==
X-Received: by 2002:a05:6a21:66cb:b0:138:2fb8:6b42 with SMTP id ze11-20020a056a2166cb00b001382fb86b42mr180543pzb.14.1693334869676;
        Tue, 29 Aug 2023 11:47:49 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:11a:201:d603:22a7:5e5e:d239])
        by smtp.gmail.com with ESMTPSA id o15-20020a170902d4cf00b001b9e86e05b7sm9697953plg.0.2023.08.29.11.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 11:47:49 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Subject: [PATCH 7/7] drm/msm/dp: Remove dp_display_is_ds_bridge()
Date:   Tue, 29 Aug 2023 11:47:32 -0700
Message-ID: <20230829184735.2841739-8-swboyd@chromium.org>
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

This function is simply drm_dp_is_branch() so use that instead of
open-coding it.

Cc: Vinod Polimera <quic_vpolimer@quicinc.com>
Cc: Kuogee Hsieh <quic_khsieh@quicinc.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 76f13954015b..96bbf6fec2f1 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -341,19 +341,12 @@ static const struct component_ops dp_display_comp_ops = {
 	.unbind = dp_display_unbind,
 };
 
-static bool dp_display_is_ds_bridge(struct dp_panel *panel)
-{
-	return (panel->dpcd[DP_DOWNSTREAMPORT_PRESENT] &
-		DP_DWN_STRM_PORT_PRESENT);
-}
-
 static bool dp_display_is_sink_count_zero(struct dp_display_private *dp)
 {
 	drm_dbg_dp(dp->drm_dev, "present=%#x sink_count=%d\n",
 			dp->panel->dpcd[DP_DOWNSTREAMPORT_PRESENT],
 		dp->link->sink_count);
-	return dp_display_is_ds_bridge(dp->panel) &&
-		(dp->link->sink_count == 0);
+	return drm_dp_is_branch(dp->panel->dpcd) && dp->link->sink_count == 0;
 }
 
 static void dp_display_send_hpd_event(struct msm_dp *dp_display)
-- 
https://chromeos.dev

