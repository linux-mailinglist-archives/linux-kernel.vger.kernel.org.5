Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F46D7EFB0E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 22:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjKQVvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 16:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjKQVvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 16:51:06 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F03120
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 13:51:02 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5c184b3bbc4so1865015a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 13:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700257862; x=1700862662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5wbvoHrw5gghSmYXqYsGypau9Ymfce8CXWliYyG7ds=;
        b=ZbocSEbcPlefV57I+X8efa9kGoeh+19x5Vft2Hj3p98Q19Y4Mw09XVe0wqaGyVPJ1j
         6HB3m81jpcwymK560uYgmAHgL6gGG80un2qIW/kMjQW4Vp+PnJGX0eUYD23Gnx/qOUJ0
         /y2Tw+vQQB8bKIQfY96Rv9bllHtEjYehQt/sM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700257862; x=1700862662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5wbvoHrw5gghSmYXqYsGypau9Ymfce8CXWliYyG7ds=;
        b=BB/0S4LEKd4JTb2PKpsKQznl/d0zaRXEGHw+8MlGfsOr2o6CsK49nXgOv3fF+YeVzA
         mNdmNQ0fG+UWYOnyMLFy46Toc1ha/agxxQ5DG05EhAenKW0VRyhGefbdp3X4+X3tG8G/
         wWMOAjDJmi6/NT52HCY2StHDDhKx67lMD2s3EyTmN/urvVj9tXbhIRZErr1FemrrT4pU
         eujs+4+yh1e9wUM2axgnIszMovdJqXtvVpbintKgZ+EiXrd4EXpTozI4AbVUmVppvJ16
         fy5paDPhPAvCjPom0gHUmZU9u8mgk4h5dah4jT5k/eEMtPT3F5WSVsqEO5y/kbx+D3Pt
         tR1Q==
X-Gm-Message-State: AOJu0YzjNlWv4KIvzpVrMFRvxKBpBOnOl/m5fecuThJI9HJoelNgXNjh
        +rH0cNJ+qm1WUtNvUJnk54JA9g==
X-Google-Smtp-Source: AGHT+IFXa1O0px5rjy5mHaMT7yi0PRLUE2h8oNXonzeJMHXBMP048pYW3pu5gGFgpRYyO3sJvO9lqw==
X-Received: by 2002:a05:6a21:398d:b0:188:aea:2138 with SMTP id ad13-20020a056a21398d00b001880aea2138mr625516pzc.19.1700257862324;
        Fri, 17 Nov 2023 13:51:02 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:7ed:b095:f0ba:5801])
        by smtp.gmail.com with ESMTPSA id x7-20020a17090aca0700b00256b67208b1sm3639587pjt.56.2023.11.17.13.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 13:51:01 -0800 (PST)
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
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v7 1/3] drm/panel-edp: Add override_edid_mode quirk for generic edp
Date:   Fri, 17 Nov 2023 13:46:32 -0800
Message-ID: <20231117215056.1883314-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231117215056.1883314-1-hsinyi@chromium.org>
References: <20231117215056.1883314-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generic edp gets mode from edid. However, some panels report incorrect
mode in this way, resulting in glitches on panel. Introduce a new quirk
additional_mode to the generic edid to pick a correct hardcoded mode.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
v6->v7: split usecase to another patch.
---
 drivers/gpu/drm/panel/panel-edp.c | 48 +++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index f22677373171..33535f6de343 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -203,6 +203,9 @@ struct edp_panel_entry {
 
 	/** @name: Name of this panel (for printing to logs). */
 	const char *name;
+
+	/** @override_edid_mode: Override the mode obtained by edid. */
+	const struct drm_display_mode *override_edid_mode;
 };
 
 struct panel_edp {
@@ -301,6 +304,24 @@ static unsigned int panel_edp_get_display_modes(struct panel_edp *panel,
 	return num;
 }
 
+static int panel_edp_override_edid_mode(struct panel_edp *panel,
+					struct drm_connector *connector,
+					const struct drm_display_mode *override_mode)
+{
+	struct drm_display_mode *mode;
+
+	mode = drm_mode_duplicate(connector->dev, override_mode);
+	if (!mode) {
+		dev_err(panel->base.dev, "failed to add additional mode\n");
+		return 0;
+	}
+
+	mode->type |= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
+	drm_mode_set_name(mode);
+	drm_mode_probed_add(connector, mode);
+	return 1;
+}
+
 static int panel_edp_get_non_edid_modes(struct panel_edp *panel,
 					struct drm_connector *connector)
 {
@@ -568,6 +589,9 @@ static int panel_edp_get_modes(struct drm_panel *panel,
 {
 	struct panel_edp *p = to_panel_edp(panel);
 	int num = 0;
+	bool has_override_edid_mode = p->detected_panel &&
+				      p->detected_panel != ERR_PTR(-EINVAL) &&
+				      p->detected_panel->override_edid_mode;
 
 	/* probe EDID if a DDC bus is available */
 	if (p->ddc) {
@@ -575,9 +599,18 @@ static int panel_edp_get_modes(struct drm_panel *panel,
 
 		if (!p->edid)
 			p->edid = drm_get_edid(connector, p->ddc);
-
-		if (p->edid)
-			num += drm_add_edid_modes(connector, p->edid);
+		if (p->edid) {
+			if (has_override_edid_mode) {
+				/*
+				 * override_edid_mode is specified. Use
+				 * override_edid_mode instead of from edid.
+				 */
+				num += panel_edp_override_edid_mode(p, connector,
+						p->detected_panel->override_edid_mode);
+			} else {
+				num += drm_add_edid_modes(connector, p->edid);
+			}
+		}
 
 		pm_runtime_mark_last_busy(panel->dev);
 		pm_runtime_put_autosuspend(panel->dev);
@@ -1849,6 +1882,15 @@ static const struct panel_delay delay_200_150_e200 = {
 	.delay = _delay \
 }
 
+#define EDP_PANEL_ENTRY2(vend_chr_0, vend_chr_1, vend_chr_2, product_id, _delay, _name, _mode) \
+{ \
+	.name = _name, \
+	.panel_id = drm_edid_encode_panel_id(vend_chr_0, vend_chr_1, vend_chr_2, \
+					     product_id), \
+	.delay = _delay, \
+	.override_edid_mode = _mode \
+}
+
 /*
  * This table is used to figure out power sequencing delays for panels that
  * are detected by EDID. Entries here may point to entries in the
-- 
2.43.0.rc0.421.g78406f8d94-goog

