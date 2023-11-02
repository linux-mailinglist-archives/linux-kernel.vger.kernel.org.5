Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008237DFC3D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 23:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377480AbjKBWNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 18:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377461AbjKBWNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 18:13:25 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEBB192
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 15:13:20 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6be1bc5aa1cso1544760b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 15:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698963199; x=1699567999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6k2Y92G/jCAECpt6DbXki9hGcN+8cUNHTMZGe3U3vro=;
        b=aKqUivh5S/VJZ0lA80BpArfupAJsYeS2Fa6R3yY+TXp363R2zVQpE6njvepBQftM51
         TCmgtiskthuaiThXiMd0YoCenLOCMOgADx/t/WM5bqxLrV6xMoBPgvXO34WscwSsaan6
         UO4OJoQd1dFRuWNdlcERfM8UZg73Jv0p51ID0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698963199; x=1699567999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6k2Y92G/jCAECpt6DbXki9hGcN+8cUNHTMZGe3U3vro=;
        b=vlF3VhWtZizOY2iYphY1SPw39YTP3UGEqjDaMIs7pmK7P/WopDAP4YVhRZ0FqPn4Xs
         wxspjE/lw/3IqTdukKZGTAgQmD8IwjM2+SwUs+uDBVoFcz6Zh/mwuFuJuNf6xqn4bBCF
         pzOOsONhGBtCJiU/Ua9E1CpcHpJUALqci7voYQpcu7aHvvoza7Lq0VSgzXIFCRue14uC
         kSpLXRYdcQ3O5TnwLpwPiAW4boDzVNcnWqOV/gx4GUiEUaIbWIEBFNLdN7+U8msILcpw
         nEKjgPmipTz9XcRT7FphTBxvPRcsZbDOmyoW4iy4CMsh3biB7gm4DWQ76gQtTMXSQ1Jj
         v+Hg==
X-Gm-Message-State: AOJu0YwfLWcCPMAqifUo4ZzR+ZwOGkk1jSKjTtxwJwJum07HYbxMj7yd
        Dr9u9CD6OZJJrz1eDkKVhtaN2w==
X-Google-Smtp-Source: AGHT+IFcKkkz7brh/0hN1MoCPTTUpKInqIB/9LI0IuW8BCu1m1IuUn6xzc+uTlndeCutONBDxOEn2A==
X-Received: by 2002:a05:6a00:2d09:b0:6b6:5ed4:dd42 with SMTP id fa9-20020a056a002d0900b006b65ed4dd42mr23406858pfb.31.1698963199539;
        Thu, 02 Nov 2023 15:13:19 -0700 (PDT)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:6ec1:79de:6e50:d6fa])
        by smtp.gmail.com with ESMTPSA id y6-20020a63ce06000000b00565e96d9874sm196057pgf.89.2023.11.02.15.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 15:13:19 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] drm/panel-edp: Choose correct preferred mode
Date:   Thu,  2 Nov 2023 14:47:50 -0700
Message-ID: <20231102221309.1971910-5-hsinyi@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231102221309.1971910-1-hsinyi@chromium.org>
References: <20231102221309.1971910-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a non generic edp-panel is under aux-bus, the mode read from edid would
still be selected as preferred and results in multiple preferred modes,
which is ambiguous.

If a hard-coded mode is present, unset the preferred bit of the modes read
from edid.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
v1->v2: split patches from drm_modes.
---
 drivers/gpu/drm/panel/panel-edp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 0fb439b5efb1..021322ff9f65 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -622,10 +622,13 @@ static int panel_edp_get_modes(struct drm_panel *panel,
 	 * and no modes (the generic edp-panel case) because it will clobber
 	 * the display_info that was already set by drm_add_edid_modes().
 	 */
-	if (p->desc->num_timings || p->desc->num_modes)
+	if (p->desc->num_timings || p->desc->num_modes) {
+		/* hard-coded modes present, unset preferred modes from edid. */
+		drm_mode_unset_preferred_modes(connector);
 		num += panel_edp_get_non_edid_modes(p, connector);
-	else if (!num)
+	} else if (!num) {
 		dev_warn(p->base.dev, "No display modes\n");
+	}
 
 	/*
 	 * TODO: Remove once all drm drivers call
-- 
2.42.0.869.gea05f2083d-goog

