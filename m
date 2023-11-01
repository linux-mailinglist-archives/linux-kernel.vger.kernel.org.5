Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8190B7DE760
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345228AbjKAV0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 17:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345309AbjKAV0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 17:26:18 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C2B110
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 14:26:12 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-28098ebd5aeso309673a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 14:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698873972; x=1699478772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=keM6xgaqk4y5F5Fy9cbvhHzonhRhCtU3xaG8qjxRs74=;
        b=UQVeKcZvDQWa0yPd7HLezvQmUCotcGHpxJA/Yc1N33qiJYBEQHfmenzJu8tANw7FBM
         UHFFQLwlOJFmd6aUCQSyh8ifrj0NFwtniTT+Ttt9GrnpfAo9DYGyeW/Sg/jFZ5svOTeC
         PrU1mecB07k1V3sVnnuYIWk0T2Xb19o1xPBnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698873972; x=1699478772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=keM6xgaqk4y5F5Fy9cbvhHzonhRhCtU3xaG8qjxRs74=;
        b=szg4ZH7lGjtpJ1zX14Yrlmwo4XPMjXvGY+ibWq/714WSmL9AWsV01Cn0MWX4N2jcIh
         Ms4auJaS2GpKYivgxyuuk6K4QGYQw4Fv0SgnEsm4g7IOXvpiCCnhhMRS08EXTJ3jiOtV
         R5hy6w6EMHvYId57vPUKBXz0fUTtAN5ok5zOCXJLVtaH8LuDJWHGUGsCQIp7q7pY1ZdZ
         ArwhyBQY49Qsja6bFf04JG2g4ZkWuO+zIDShdlyisBks3AWaJifaWXTwP9czlMcBYhMW
         +POqugcz7j5mkKvUdYU/RhU24nx3/pVb230Pc9dHUZE/BEfZVOCVtJynToU4F2CrITdc
         enyQ==
X-Gm-Message-State: AOJu0YyemBoZBKbhx7PRu6M9dIB7m2dAhcNcc8Ony03SuG6IKt8ia0kK
        nERcq8TlUEJiOYTpwvPOm5s3bw==
X-Google-Smtp-Source: AGHT+IFJslIGJU7A2/YPceX8PHGElxQ1whLtbPlYdX+GrlOIjg+IOa63DnZoHTC5pBxg7dwe30PYSQ==
X-Received: by 2002:a17:90a:fc88:b0:280:18bd:ffe7 with SMTP id ci8-20020a17090afc8800b0028018bdffe7mr11725904pjb.48.1698873971885;
        Wed, 01 Nov 2023 14:26:11 -0700 (PDT)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:b410:473c:2b92:2e2e])
        by smtp.gmail.com with ESMTPSA id ds21-20020a17090b08d500b00274262bcf8dsm1212976pjb.41.2023.11.01.14.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 14:26:11 -0700 (PDT)
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
Subject: [PATCH 3/3] drm/panel-edp: Choose correct preferred mode
Date:   Wed,  1 Nov 2023 14:20:11 -0700
Message-ID: <20231101212604.1636517-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231101212604.1636517-1-hsinyi@chromium.org>
References: <20231101212604.1636517-1-hsinyi@chromium.org>
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
 drivers/gpu/drm/drm_modes.c       | 16 ++++++++++++++++
 drivers/gpu/drm/panel/panel-edp.c |  7 +++++--
 include/drm/drm_modes.h           |  1 +
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index ac9a406250c5..35927467f4b0 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -1933,6 +1933,22 @@ void drm_connector_list_update(struct drm_connector *connector)
 }
 EXPORT_SYMBOL(drm_connector_list_update);
 
+/**
+ * drm_mode_unset_preferred - clear the preferred status on existing modes.
+ * @connector: the connector to update
+ *
+ * Walk the mode list for connector, clearing the preferred status on existing
+ * modes.
+ */
+void drm_mode_unset_preferred_modes(struct drm_connector *connector)
+{
+	struct drm_display_mode *cur_mode;
+
+	list_for_each_entry(cur_mode, &connector->probed_modes, head)
+		cur_mode->type &= ~DRM_MODE_TYPE_PREFERRED;
+}
+EXPORT_SYMBOL_GPL(drm_mode_unset_preferred_modes);
+
 static int drm_mode_parse_cmdline_bpp(const char *str, char **end_ptr,
 				      struct drm_cmdline_mode *mode)
 {
diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 0883ff312eba..b3ac473b2554 100644
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
diff --git a/include/drm/drm_modes.h b/include/drm/drm_modes.h
index c613f0abe9dc..301817e00a15 100644
--- a/include/drm/drm_modes.h
+++ b/include/drm/drm_modes.h
@@ -560,6 +560,7 @@ void drm_mode_prune_invalid(struct drm_device *dev,
 			    struct list_head *mode_list, bool verbose);
 void drm_mode_sort(struct list_head *mode_list);
 void drm_connector_list_update(struct drm_connector *connector);
+void drm_mode_unset_preferred_modes(struct drm_connector *connector);
 
 /* parsing cmdline modes */
 bool
-- 
2.42.0.869.gea05f2083d-goog

