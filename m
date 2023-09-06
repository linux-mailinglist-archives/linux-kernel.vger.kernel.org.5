Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872127942E1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 20:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243769AbjIFSMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 14:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242902AbjIFSMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 14:12:40 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C11A19BE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 11:12:31 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68a41031768so107208b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 11:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694023950; x=1694628750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Edgvbmd5y4jUc7RB+Rf63E6o4J7BSjl9P5UimGRUsdQ=;
        b=K1itKlLwhIQC+3jTyDnoYNOqCbTUZ6cBx8+EP/iBOTyqkurGOhGPseuNwtChDuhMY8
         +vxFbnpgkJplq7alOHyTcOXYIEgW2XoTZUPf5gzMdig2qzlnstRKXRivCIkPHO0gB+YV
         VGJ7HovbBwXDrb/f3trs02ZEgjEhfKrzJkJLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694023950; x=1694628750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Edgvbmd5y4jUc7RB+Rf63E6o4J7BSjl9P5UimGRUsdQ=;
        b=UrDVoX02Jfc6RPxfQDoQ9+AevjNzCT9udgz9AWzAvQRRf3HHWFMr14jlhccvnTp4tZ
         gSd/s6EnmuHQtPxl7SDu93cN9SfDHlowrFqL21pGUgiiUMel4DBX7Ahq+Ejj9zWEBQOG
         PkKJgkhzkPx4kxsf8A/fnQpQQ+X5FQ33Ks28U+cWGQJickSVNyjCjkQi74vHh7a/OgLt
         HnCRCU3ok1gg2daZ9xIjPVVSN/6pX6u4CNPNIkmOxe14fWNbSCXBcEUdg829Vc2JdFZU
         347CkLNPmMqJ1FYht7H3uX/ysKqXTy6sL9pO5L+vQO+1Xo27jQk9IaPq8FMD4hOVCjSK
         zTLA==
X-Gm-Message-State: AOJu0YwMDT3q9qw6Zxd3VU5Y43B/gpOHI/uxjH9jd7Y3ZiDL/cyWypBt
        8YgoJw+ki6LItQjOOiaQzi1W+A==
X-Google-Smtp-Source: AGHT+IH6kSrFTL9eIlfDr/vwL8Fsw7IYLh/XA+8fJSBKdMHvlaTDr5JYbfbs2SSDKsWyskvF1jKHrg==
X-Received: by 2002:a05:6a00:1786:b0:68a:3e68:f8ab with SMTP id s6-20020a056a00178600b0068a3e68f8abmr16812291pfg.14.1694023950511;
        Wed, 06 Sep 2023 11:12:30 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:11a:201:a404:ed4a:5a1e:3b4a])
        by smtp.gmail.com with ESMTPSA id c10-20020a62e80a000000b0064fde7ae1ffsm11080552pfi.38.2023.09.06.11.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 11:12:30 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Subject: [PATCH 1/2] drm/msm/dp: Inline dp_display_is_sink_count_zero()
Date:   Wed,  6 Sep 2023 11:12:25 -0700
Message-ID: <20230906181226.2198441-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230906181226.2198441-1-swboyd@chromium.org>
References: <20230906181226.2198441-1-swboyd@chromium.org>
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

This function is basically a one-liner when you ignore the debug
logging. Just inline the function and drop the log to simplify the code.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Vinod Polimera <quic_vpolimer@quicinc.com>
Cc: Kuogee Hsieh <quic_khsieh@quicinc.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 96bbf6fec2f1..2a5f1ab9a65b 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -341,14 +341,6 @@ static const struct component_ops dp_display_comp_ops = {
 	.unbind = dp_display_unbind,
 };
 
-static bool dp_display_is_sink_count_zero(struct dp_display_private *dp)
-{
-	drm_dbg_dp(dp->drm_dev, "present=%#x sink_count=%d\n",
-			dp->panel->dpcd[DP_DOWNSTREAMPORT_PRESENT],
-		dp->link->sink_count);
-	return drm_dp_is_branch(dp->panel->dpcd) && dp->link->sink_count == 0;
-}
-
 static void dp_display_send_hpd_event(struct msm_dp *dp_display)
 {
 	struct dp_display_private *dp;
@@ -507,7 +499,7 @@ static int dp_display_handle_port_ststus_changed(struct dp_display_private *dp)
 {
 	int rc = 0;
 
-	if (dp_display_is_sink_count_zero(dp)) {
+	if (drm_dp_is_branch(dp->panel->dpcd) && dp->link->sink_count == 0) {
 		drm_dbg_dp(dp->drm_dev, "sink count is zero, nothing to do\n");
 		if (dp->hpd_state != ST_DISCONNECTED) {
 			dp->hpd_state = ST_DISCONNECT_PENDING;
-- 
https://chromeos.dev

