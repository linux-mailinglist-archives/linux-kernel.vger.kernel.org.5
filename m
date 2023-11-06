Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8BA7E2E2A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjKFU1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbjKFU1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:27:30 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D4AD71
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 12:27:27 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b2ea7cca04so3176153b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 12:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699302446; x=1699907246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJlE6HDvd5TvSMidl1UF4V7GiD3TUKDPHWop4ycck10=;
        b=j49zgON+ginlYUWH6XsufPn1jVyMvo600PjaME66lFJwZttshjNnmWiaBalYFNf7lJ
         oCUAtI+CT/k3fWB2HZpTGlxvXzM4OsJPgN8n1/i3rI1840uyeu4DS8ly1pOtEgwKQ1FP
         hgrnCnqEE67gt9q9F2D3nz7z+/PJJpAAVstOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699302446; x=1699907246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJlE6HDvd5TvSMidl1UF4V7GiD3TUKDPHWop4ycck10=;
        b=jvS5mvyXstBBy2yXm0QNpx8qS4LWJKXKE96/yUb2Adj+z4aUhi6eZXC0AkHll9YgOZ
         BiSnj3VKfT4b2uy9aLB0hGeNvsiu2jPoZIVnPfMbxuUbq3UP2pj3XyWX5ed8edWCMfnT
         CS9dM78qc+hhkUfQHXSXlgbi+H3VvBHll9TldQd71prJf2hbx+htt+ZF45L0oA5gQWZy
         cwNn1h0QqFFDpNB5jkeHlKaYtcguYGGQm1DaoKrxoAJKcst4QIeOb7DplmFL1ENNcfn2
         R0s1EiCar3zmJDLGedoLfAttO7g16D1xCgMX+vmiv9CqEyHnNCMJx8LZdDfxxSIabA+j
         t84Q==
X-Gm-Message-State: AOJu0YxNx5Zad9QxlTsp7STk754fSo3+1nwq3YOrf0Ea2z4jlBSodMlI
        2eEBUXmW+C4Mezln5Aau+B2xpA==
X-Google-Smtp-Source: AGHT+IHORZrZsA5dLANY/D81cJ/P7A/DV77m6AkT39LNl3opooSdqvw4XiSBztpduAKqkYdXSfyXgA==
X-Received: by 2002:a05:6808:1b14:b0:3a7:2390:3583 with SMTP id bx20-20020a0568081b1400b003a723903583mr38346779oib.38.1699302446477;
        Mon, 06 Nov 2023 12:27:26 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:3374:ff6c:474e:a78])
        by smtp.gmail.com with ESMTPSA id fj36-20020a056a003a2400b00689f5940061sm6144150pfb.17.2023.11.06.12.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 12:27:26 -0800 (PST)
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
Subject: [PATCH v3 3/3] drm/panel-edp: Avoid adding multiple preferred modes
Date:   Mon,  6 Nov 2023 12:22:50 -0800
Message-ID: <20231106202718.2770821-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231106202718.2770821-1-hsinyi@chromium.org>
References: <20231106202718.2770821-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a non generic edp-panel is under aux-bus, the mode read from edid would
still be selected as preferred and results in multiple preferred modes,
which is ambiguous.

If both hard-coded mode and edid exists, only add mode from hard-coded.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
v2->v3: if hard-coded mode presents, don't add edid mode.
---
 drivers/gpu/drm/panel/panel-edp.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 0fb439b5efb1..54dbbdf62ec0 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -594,8 +594,20 @@ static int panel_edp_get_modes(struct drm_panel *panel,
 				      p->detected_panel != ERR_PTR(-EINVAL) &&
 				      p->detected_panel->override_edid_mode;
 
-	/* probe EDID if a DDC bus is available */
-	if (p->ddc) {
+	/*
+	 * If both edid and hard-coded modes exists, only add hard-coded modes
+	 * to avoid multiple preferred modes.
+	 */
+	if (p->desc->num_timings || p->desc->num_modes) {
+		/*
+		 * Add hard-coded panel modes. Don't call this if there are no
+		 * timings and no modes (the generic edp-panel case) because it
+		 * will clobber the display_info that was already set by
+		 * drm_add_edid_modes().
+		 */
+		num += panel_edp_get_non_edid_modes(p, connector);
+	} else if (p->ddc) {
+		/* probe EDID if a DDC bus is available */
 		pm_runtime_get_sync(panel->dev);
 
 		if (!p->edid)
@@ -617,14 +629,7 @@ static int panel_edp_get_modes(struct drm_panel *panel,
 		pm_runtime_put_autosuspend(panel->dev);
 	}
 
-	/*
-	 * Add hard-coded panel modes. Don't call this if there are no timings
-	 * and no modes (the generic edp-panel case) because it will clobber
-	 * the display_info that was already set by drm_add_edid_modes().
-	 */
-	if (p->desc->num_timings || p->desc->num_modes)
-		num += panel_edp_get_non_edid_modes(p, connector);
-	else if (!num)
+	if (!num)
 		dev_warn(p->base.dev, "No display modes\n");
 
 	/*
-- 
2.42.0.869.gea05f2083d-goog

