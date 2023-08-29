Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0AA78CC6F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238240AbjH2SsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 14:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238262AbjH2Srp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:47:45 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0725C2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 11:47:42 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bc0d39b52cso29103175ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 11:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693334862; x=1693939662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SP05QRX0ffgV9H75PNnPPPNwlPJBgrXfqON4q+7zQd8=;
        b=iR7CMZ2TOMm2oug+fW6PozLCKDS/FtBtnyhISmwLaudI+OQt4JkFh/4nfXqVS5T+x0
         gc6XOEmfRRN6xM1lORZsVM7CD7pKalI9P9/iQA5HtQp5fiKBNFKY3340x/G8AX0+B02N
         KIsQX062xJPxzh2NKMuJVFoQ08gASaFeSb6N4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693334862; x=1693939662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SP05QRX0ffgV9H75PNnPPPNwlPJBgrXfqON4q+7zQd8=;
        b=edxWKRF8wMewl+0zPzYaU0Mn+8OGcelbb+bLzOljV9FexfrXwhAghuj+6d9FA002Cd
         PFH5fO5jhfVg1HYGbDRrhLyGGJUPLSgMO/YIYfY7yD6Wuw09ifadxPKjoNH9nH4T6JN0
         Y6w3YZLSryep7UU52q3WTxZAvfAW29a2jn/HtSS96CeC8KeOKY0XbKx3vAtcxqda/8VB
         H2mcAGSu4nkk6sF0W51xKOMrXOPkJvxigmZUMcrwYjBIoylBlLClUVgwEzCCVc/vaS5K
         PqmjpUsO7qeE1c4QQopic+KDUaA8vsLjzWcgPhLl8rzXdB9OEHTuz4fOyY8qy5ezbi+V
         LLpA==
X-Gm-Message-State: AOJu0Yx5s9VFzXU0tZp1szlY1MyUrPhWADGpE7uFXomHB7fqXbBAh7Fh
        w7FqK5yKfs3PzQzVVHqX+OZpwA==
X-Google-Smtp-Source: AGHT+IHGUmCHB6AjaXPnbvPgZPbqs96iezZg8UGYC+YUja3aAojoTLyujv9/gnvDjuZGMy/H54oFrA==
X-Received: by 2002:a17:903:1212:b0:1b0:3df7:5992 with SMTP id l18-20020a170903121200b001b03df75992mr28283828plh.32.1693334862256;
        Tue, 29 Aug 2023 11:47:42 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:11a:201:d603:22a7:5e5e:d239])
        by smtp.gmail.com with ESMTPSA id o15-20020a170902d4cf00b001b9e86e05b7sm9697953plg.0.2023.08.29.11.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 11:47:41 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Subject: [PATCH 2/7] drm/msm/dp: Use drm_dp_read_sink_count() helper
Date:   Tue, 29 Aug 2023 11:47:27 -0700
Message-ID: <20230829184735.2841739-3-swboyd@chromium.org>
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

Use the common function drm_dp_read_sink_count() instead of open-coding
it. This shrinks the kernel text a tiny bit.

Cc: Vinod Polimera <quic_vpolimer@quicinc.com>
Cc: Kuogee Hsieh <quic_khsieh@quicinc.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/msm/dp/dp_panel.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index 09d4f6c38ef8..a0523b18b9e9 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -147,8 +147,8 @@ static int dp_panel_update_modes(struct drm_connector *connector,
 int dp_panel_read_sink_caps(struct dp_panel *dp_panel,
 	struct drm_connector *connector)
 {
-	int rc = 0, bw_code;
-	int rlen, count;
+	int rc, bw_code;
+	int count;
 	struct dp_panel_private *panel;
 
 	if (!dp_panel || !connector) {
@@ -174,16 +174,11 @@ int dp_panel_read_sink_caps(struct dp_panel *dp_panel,
 	}
 
 	if (dp_panel->dfp_present) {
-		rlen = drm_dp_dpcd_read(panel->aux, DP_SINK_COUNT,
-				&count, 1);
-		if (rlen == 1) {
-			count = DP_GET_SINK_COUNT(count);
-			if (!count) {
-				DRM_ERROR("no downstream ports connected\n");
-				panel->link->sink_count = 0;
-				rc = -ENOTCONN;
-				goto end;
-			}
+		count = drm_dp_read_sink_count(panel->aux);
+		if (!count) {
+			DRM_ERROR("no downstream ports connected\n");
+			panel->link->sink_count = 0;
+			return -ENOTCONN;
 		}
 	}
 
-- 
https://chromeos.dev

