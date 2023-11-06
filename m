Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14C27E31D3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 01:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbjKGAAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 19:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbjKGAAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 19:00:36 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E309B6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 16:00:33 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5b9a7357553so3949435a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 16:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699315233; x=1699920033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SxHcJHXQ0Dgu/1LSV/bZ2Cmouuh15UgwvxxZf23/GE=;
        b=Fg8IxiPHgClq5gddwW56nUKr9WjyiaYICR5LmF59h+UY9CE4YKZLzeKY4R3YEanS1Z
         LFdMQYhr4KSfgtU94qHpT22ifIwiASpsaUiOM5+zYMP0f9ornSz60hZvebXEGqsWlwIm
         NwTfSQTQ1QidMmMjuj8FfhACy4mqLeCacxpzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699315233; x=1699920033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9SxHcJHXQ0Dgu/1LSV/bZ2Cmouuh15UgwvxxZf23/GE=;
        b=jDTaQZPvMe1ThaeAfiJ5siIGTuOb2ILoHmNuDF/Mp/PeCh/VIpK1xcEeFsLZr44Abi
         jkjmj75GoAIToBqBy8R8HJXEa1Ov12nhPwtBUqXzg7pHR4rySP95Winzi9k9/yINnGg5
         u63VZxewxMH8Jnl6NdCpPQ1uaJ//2U2Ul2rXj0Fbvdq14vF6C1PFiW2CSv2fGD91NyWZ
         +PdcgSzjYjhjw2VaOdM/hV8AjRiA4zO5lljbHCN1GLqJi26MZloogJmSirvofrbXp3Uk
         SuU3KhXGDvM6oPbCtp9oYxGD3baC1bNsdD0Jm4LBpK2k0sJf+tzVTuFzzuOWeNriJYW/
         08hQ==
X-Gm-Message-State: AOJu0Yx+ESuYKFDX1Ko609t7JBj06vvFQTMYZu8rJNLkA3rl5iKimG5q
        WdLYpGfK5R9orsSd+LyyQhw9OQ==
X-Google-Smtp-Source: AGHT+IFvlKS7Uvykt7O+bbNdoVgvYg4+eR6RPh+t8uzDcjfXFvTO0Lwdmdsd5sV2bYvJc17zl3Giyg==
X-Received: by 2002:a05:6a21:790b:b0:181:125:e85c with SMTP id bg11-20020a056a21790b00b001810125e85cmr23690070pzc.53.1699315232986;
        Mon, 06 Nov 2023 16:00:32 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:586c:80a1:e007:beb9])
        by smtp.gmail.com with ESMTPSA id fw11-20020a17090b128b00b00268b439a0cbsm5852866pjb.23.2023.11.06.16.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 16:00:32 -0800 (PST)
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
Subject: [PATCH v5 4/4] drm/panel-edp: Avoid adding multiple preferred modes
Date:   Mon,  6 Nov 2023 15:51:35 -0800
Message-ID: <20231107000023.2928195-5-hsinyi@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231107000023.2928195-1-hsinyi@chromium.org>
References: <20231107000023.2928195-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
v4->v5: remove inapplicable comments.
---
 drivers/gpu/drm/panel/panel-edp.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index c0c24d94c3a0..006939cc3fee 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -589,6 +589,7 @@ static int panel_edp_get_modes(struct drm_panel *panel,
 {
 	struct panel_edp *p = to_panel_edp(panel);
 	int num = 0;
+	bool has_hard_coded_modes = p->desc->num_timings || p->desc->num_modes;
 	bool has_override_edid_mode = p->detected_panel &&
 				      p->detected_panel != ERR_PTR(-EINVAL) &&
 				      p->detected_panel->override_edid_mode;
@@ -599,7 +600,11 @@ static int panel_edp_get_modes(struct drm_panel *panel,
 
 		if (!p->edid)
 			p->edid = drm_get_edid(connector, p->ddc);
-		if (p->edid) {
+		/*
+		 * If both edid and hard-coded modes exists, skip edid modes to
+		 * avoid multiple preferred modes.
+		 */
+		if (p->edid && !has_hard_coded_modes) {
 			if (has_override_edid_mode) {
 				/*
 				 * override_edid_mode is specified. Use
@@ -616,12 +621,7 @@ static int panel_edp_get_modes(struct drm_panel *panel,
 		pm_runtime_put_autosuspend(panel->dev);
 	}
 
-	/*
-	 * Add hard-coded panel modes. Don't call this if there are no timings
-	 * and no modes (the generic edp-panel case) because it will clobber
-	 * the display_info that was already set by drm_add_edid_modes().
-	 */
-	if (p->desc->num_timings || p->desc->num_modes)
+	if (has_hard_coded_modes)
 		num += panel_edp_get_non_edid_modes(p, connector);
 	else if (!num)
 		dev_warn(p->base.dev, "No display modes\n");
-- 
2.42.0.869.gea05f2083d-goog

