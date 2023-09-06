Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C3B7942E2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 20:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243849AbjIFSMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 14:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243775AbjIFSMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 14:12:42 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694CBE6A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 11:12:32 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-56b0c5a140dso151304a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 11:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694023952; x=1694628752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gX80LwLt7yqAMwtFkIm6jGbzuAJp27nwGBhP1SlyP8=;
        b=f4woGn1zE5uwGzmKG60Y9VVvu32AdYW0WsAOCizG/M3JVfvQu6eMd6r3tS4fSrSYGP
         7tuSKH/ufQJ3a+dmyXkflYValS6wjeQ+/tRgt85ee+ZnRLIaHyP5aVMFtVCCClkCep8d
         3R92PDQa96hEZBZplBsE5CZJJxgv/w7HrUiAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694023952; x=1694628752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3gX80LwLt7yqAMwtFkIm6jGbzuAJp27nwGBhP1SlyP8=;
        b=j8KoVy6xX9pdT4Ha9DQgl5/cRKIWWJCve9FmM00b3zpcDL9xLOuoJybelWUdOA8feI
         nvnSLag2lzIUNUOua71Cp9SOaUDut7ucOOr7C1zS/GTXKAHCyJJzELP+GIimAdkuGnD/
         +g8oylJz+iNp/6V36bkqDD4cAvNhSl7xMrMFboe3TcR2j/OPwaU1q1Vk2mj4xd5HzDnJ
         OO1qMsH5/RkXKEX43ReIL7yoh3GVOM+i34t7s3Vmzf3+Udpnt0v9sq0FfIv8EhXggvO2
         dowG2q6oaKQagi0dQ99gM3MwrJuH6Cpm9pGXEYMc+H4nSiL+0N6NCOwQW0K0x/TQbalq
         SBuQ==
X-Gm-Message-State: AOJu0Yw1jckl0NoiGG3I0zo1oIC8qnnQgZOGvZIe1gIoCL1aNwsj39D0
        uSkW2x0ayB0aMk81thOYSOxQRA==
X-Google-Smtp-Source: AGHT+IHYryhBVKMRFl+PLP7r/f1UH6A77UNtFPyGP0NNScxozW3TWUyTHquM31nYS+ZjqN4OBSdKsw==
X-Received: by 2002:a05:6a20:6a04:b0:14d:f087:c0cc with SMTP id p4-20020a056a206a0400b0014df087c0ccmr21393765pzk.48.1694023951909;
        Wed, 06 Sep 2023 11:12:31 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:11a:201:a404:ed4a:5a1e:3b4a])
        by smtp.gmail.com with ESMTPSA id c10-20020a62e80a000000b0064fde7ae1ffsm11080552pfi.38.2023.09.06.11.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 11:12:31 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Subject: [PATCH 2/2] drm/msm/dp: Remove error message when downstream port not connected
Date:   Wed,  6 Sep 2023 11:12:26 -0700
Message-ID: <20230906181226.2198441-3-swboyd@chromium.org>
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

Plugging in an Apple dongle without the HDMI cable attached prints out
an error message in the kernel logs when nothing is actually wrong.

   no downstream ports connected

This is because the downstream port for the HDMI connector is not
connected, so the Apple dongle reports that as a zero sink count device.

Cc: Vinod Polimera <quic_vpolimer@quicinc.com>
Cc: Kuogee Hsieh <quic_khsieh@quicinc.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/msm/dp/dp_panel.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index 97ba41593820..ae778e1a6fd0 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -156,7 +156,6 @@ int dp_panel_read_sink_caps(struct dp_panel *dp_panel,
 	if (drm_dp_is_branch(dp_panel->dpcd)) {
 		count = drm_dp_read_sink_count(panel->aux);
 		if (!count) {
-			DRM_ERROR("no downstream ports connected\n");
 			panel->link->sink_count = 0;
 			return -ENOTCONN;
 		}
-- 
https://chromeos.dev

