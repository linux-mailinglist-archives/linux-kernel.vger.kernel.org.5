Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D74770A89
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 23:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjHDVJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 17:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjHDVIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:08:37 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C8F4EE1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 14:07:33 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68706b39c4cso1880833b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 14:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691183252; x=1691788052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DN4Kph2d52NwkUkezdGerL8g/M4NBzXeSqtlHdxPYg=;
        b=c0rxX+Yrg+dyfOnew5Ieiiys+dsK64kVflUDWPMqOLSqOa7AXCAkL9ZLuvhpCcYEwo
         ZC3P/M+gRT+PFUqg5xmhZkOoF7Q5HHhcUenQv7V7LMrtsIzl1fBv8mufuFYamOLuNo9I
         syWN8E49ZMFpB+DcE3YOsvZKlz413yPXfJaGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691183252; x=1691788052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DN4Kph2d52NwkUkezdGerL8g/M4NBzXeSqtlHdxPYg=;
        b=LtFnInrlLxWA9Tz+NtfjBQkY8XkBwKQj1GXO+1rjaYy12zyMXrYjNxqTGgCBvPn9X3
         gtvsrz72ce2On0wUtUBjW6K8qPgXaRcDOav79dHb4zIQC17W4p7yRyOtSis8D0xF3mpo
         yNaQHgdWdEV1bTvdmZ8blDq8U0vo/i5wp+5p6TpdE/e87Zg3nlo1gz2g67MuIEQfAA3T
         687WFauhOBP1LbvZbYqr0eSwe/AhmEyFRKA2ePt+NFtJI+KfVjMU1hVVI7uUFQ+F9XeF
         de7kU0bnMxLYTELkXdcro5WnWS57TiqRJBf1csQXY6aY8WatMPv9t84xuWMYxRIiwBiJ
         6oCA==
X-Gm-Message-State: AOJu0YyCKTRpEOELX7q6h9NvMQM5G6DMXbvAvernoASUvSu+uMnYFUvC
        vae3qNZUHI8ZJ4d8ehsZaa24RA==
X-Google-Smtp-Source: AGHT+IFj/Pm4r4SGNE9coQEi+WSMYBsfkipwkLIG42HxYlnCboyKqNLbhsyPIpW6j5objN61Kcq27Q==
X-Received: by 2002:a05:6a21:7795:b0:13f:2187:c51a with SMTP id bd21-20020a056a21779500b0013f2187c51amr2605066pzc.34.1691183252742;
        Fri, 04 Aug 2023 14:07:32 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:e186:e5d2:e60:bad3])
        by smtp.gmail.com with ESMTPSA id n22-20020aa78a56000000b0068664ace38asm2037584pfa.19.2023.08.04.14.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 14:07:32 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 09/10] drm/panel: sony-acx565akm: Don't double-check enabled state in disable
Date:   Fri,  4 Aug 2023 14:06:12 -0700
Message-ID: <20230804140605.RFC.9.I6a51b36831a5c7b2b82bccf8c550cf0d076aa541@changeid>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
In-Reply-To: <20230804210644.1862287-1-dianders@chromium.org>
References: <20230804210644.1862287-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As talked about in commit d2aacaf07395 ("drm/panel: Check for already
prepared/enabled in drm_panel"), we want to remove needless code from
panel drivers that was storing and double-checking the
prepared/enabled state. Even if someone was relying on the
double-check before, that double-check is now in the core and not
needed in individual drivers.

The acx565akm seems to do some unique stuff with the "enabled"
state. Specifically:
1. It seems to detect the enabled state based on how the bootloader
   left the panel.
2. It uses the enabled state to prevent certain sysfs files from
   accessing a disabled panel.

We'll leave the "enabled" state tracking for this. However, we can at
least get rid of the double-check when trying to disable. In order to
do this we use the new drm_panel_helper_shutdown() from remove() which
double-checks for us.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/panel/panel-sony-acx565akm.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sony-acx565akm.c b/drivers/gpu/drm/panel/panel-sony-acx565akm.c
index 3d6a286056a0..8a8326a94d72 100644
--- a/drivers/gpu/drm/panel/panel-sony-acx565akm.c
+++ b/drivers/gpu/drm/panel/panel-sony-acx565akm.c
@@ -30,6 +30,7 @@
 #include <drm/drm_connector.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_panel.h>
+#include <drm/drm_panel_helper.h>
 
 #define CTRL_DISP_BRIGHTNESS_CTRL_ON		BIT(5)
 #define CTRL_DISP_AMBIENT_LIGHT_CTRL_ON		BIT(4)
@@ -454,9 +455,6 @@ static int acx565akm_power_on(struct acx565akm_panel *lcd)
 
 static void acx565akm_power_off(struct acx565akm_panel *lcd)
 {
-	if (!lcd->enabled)
-		return;
-
 	acx565akm_set_display_state(lcd, 0);
 	acx565akm_set_sleep_mode(lcd, 1);
 	lcd->enabled = false;
@@ -656,8 +654,7 @@ static void acx565akm_remove(struct spi_device *spi)
 	if (lcd->has_bc)
 		acx565akm_backlight_cleanup(lcd);
 
-	drm_panel_disable(&lcd->panel);
-	drm_panel_unprepare(&lcd->panel);
+	drm_panel_helper_shutdown(&lcd->panel);
 }
 
 static const struct of_device_id acx565akm_of_match[] = {
-- 
2.41.0.585.gd2178a4bd4-goog

