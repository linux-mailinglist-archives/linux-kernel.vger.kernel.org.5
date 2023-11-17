Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0997EFB0F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 22:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbjKQVvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 16:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbjKQVvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 16:51:07 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E90D68
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 13:51:04 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-280109daaaaso1954439a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 13:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700257863; x=1700862663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDebfVAoPELKTEL528lJwzdi4eZAa8eNlalDXzxQ6JQ=;
        b=M+D1eLbEzpNzwx/DifKMhq7xbCdmSl9iBOydYDCcei+7VtTuBKvIk0C9BbJ7FtinH/
         HiuOgufWFg3YyQPZTCPCu25cR3GKg1IdhtujifAJ77Ge8In93sT84dFVMcHmUs7wEcsV
         FO/JF2xFoMqHz+98dUoIrb59UU7gXzeoJXG04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700257863; x=1700862663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MDebfVAoPELKTEL528lJwzdi4eZAa8eNlalDXzxQ6JQ=;
        b=f9+r0K53/BRzP1lx8ha//2+Pj3R3h14Cw1Ox0QheEMG1T3qBGUEUa2fapsoOfJxPDX
         EQL4/zgfp2x9UJCUT+gE8w7khSHjBZdHEu47Goc6gTlToVUcEt8OUFMZNKJOh+/fWWnb
         EJ/RnLmL0RyAj7kFMsrGuQ3SICESBNzhlzTsgy/kZgHntOINgeDtuHauz38DQ/5YojOO
         TctBDw3TF5g8Kih1TukhGHjEE2QtJ55jHXSDmyUvVETDANipNfo3MdnyhMeAqYpbdYkg
         OvWlzScAYcvFj+KBghkpdzZYnDvkVd6S+G1EBqSTRco1ATKYIHTZBSfl5sntFYr06XpT
         XCKw==
X-Gm-Message-State: AOJu0Yzg5+q+N7pVrJEqCa9lluovGCfjwyB36fxACQj2TWK29MYd3dDt
        nurKa6tLymL8bgr1JXA6AEP5Og==
X-Google-Smtp-Source: AGHT+IFCO9OAi3+Qkz1XY3PYPDHiJLGt2Jkv4PHzp1qsbAme5ecpdXxOYr8cOAbRQwIJ7CNVwWUjOw==
X-Received: by 2002:a17:90b:1e0f:b0:281:691:e58c with SMTP id pg15-20020a17090b1e0f00b002810691e58cmr831673pjb.37.1700257863532;
        Fri, 17 Nov 2023 13:51:03 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:7ed:b095:f0ba:5801])
        by smtp.gmail.com with ESMTPSA id x7-20020a17090aca0700b00256b67208b1sm3639587pjt.56.2023.11.17.13.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 13:51:03 -0800 (PST)
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
Subject: [PATCH v7 2/3] drm/panel-edp: Add auo_b116xa3_mode
Date:   Fri, 17 Nov 2023 13:46:33 -0800
Message-ID: <20231117215056.1883314-3-hsinyi@chromium.org>
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

Add auo_b116xa3_mode to override the original modes parsed from edid
of the panels 0x405c B116XAK01.0 and 0x615c B116XAN06.1 which result
in glitches on panel.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
v6->v7: split usecase to another patch.
---
 drivers/gpu/drm/panel/panel-edp.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 33535f6de343..3e144145a6bd 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -983,6 +983,19 @@ static const struct panel_desc auo_b101ean01 = {
 	},
 };
 
+static const struct drm_display_mode auo_b116xa3_mode = {
+	.clock = 70589,
+	.hdisplay = 1366,
+	.hsync_start = 1366 + 40,
+	.hsync_end = 1366 + 40 + 40,
+	.htotal = 1366 + 40 + 40 + 32,
+	.vdisplay = 768,
+	.vsync_start = 768 + 10,
+	.vsync_end = 768 + 10 + 12,
+	.vtotal = 768 + 10 + 12 + 6,
+	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
+};
+
 static const struct drm_display_mode auo_b116xak01_mode = {
 	.clock = 69300,
 	.hdisplay = 1366,
@@ -1908,9 +1921,11 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x239b, &delay_200_500_e50, "B116XAN06.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x255c, &delay_200_500_e50, "B116XTN02.5"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x403d, &delay_200_500_e50, "B140HAN04.0"),
-	EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAK01.0"),
+	EDP_PANEL_ENTRY2('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAK01.0",
+			 &auo_b116xa3_mode),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x582d, &delay_200_500_e50, "B133UAN01.0"),
-	EDP_PANEL_ENTRY('A', 'U', 'O', 0x615c, &delay_200_500_e50, "B116XAN06.1"),
+	EDP_PANEL_ENTRY2('A', 'U', 'O', 0x615c, &delay_200_500_e50, "B116XAN06.1",
+			 &auo_b116xa3_mode),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x635c, &delay_200_500_e50, "B116XAN06.3"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x639c, &delay_200_500_e50, "B140HAK02.7"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x8594, &delay_200_500_e50, "B133UAN01.0"),
-- 
2.43.0.rc0.421.g78406f8d94-goog

