Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24077EAF7B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 12:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjKNLr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 06:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKNLry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 06:47:54 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F2BE8;
        Tue, 14 Nov 2023 03:47:51 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32da7ac5c4fso3489296f8f.1;
        Tue, 14 Nov 2023 03:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699962470; x=1700567270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hu5vq24I9HjUM0WRdZZtyBTXIAl9KFFFfWHDwaNX2E=;
        b=knMJs3MZ+BgvY8+6q0WeLfmi7uUaDZNTjuxdXbDHc7bIc4xgMGbwEjuxnC7NB2DjFu
         2YiBjEg+pcZLcnXJbkGbO+o3Ql84ASfNgE4SpIi0TGj6kZfU1A+z9vU6j9YYECrNWEWO
         QMzHcrRorJHLxU2pXztMOvG2S2Y8UWY0V+lJTYQNHPi67DRbl1/I/qNX/y1h+qH/czns
         WAqQaV1SEuxHO9GQHu4ilFdgI/Lp2ZJTZ5K6YvHD58A5iCCWeQnpk6Ev9/UZ0Sg8p5wC
         BdUfFK2E5R0gKpJLNycC0+Fj78Sumx8ZApIyQOj/J36Bz/fTqrRT48bSdM4hSBuuuGIW
         nOQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699962470; x=1700567270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0hu5vq24I9HjUM0WRdZZtyBTXIAl9KFFFfWHDwaNX2E=;
        b=VfDwIGHUUrcuNZrmE6oKWkFr+ACh8xeE3bo1nKE6aCEYXWHrKHWXT42owIkwQC6n4E
         pU3RIrPfB9I06kgnr8t7W15ghPxb/ao/s91fdfDbmlOGwFme27Ozqk0JidUjRK8NNw/u
         YSB2vCjMJHPBZ2u/4GjIjutLiX4gtOw2K8WqRad2FGKwzPwiKnBeopPUQowwFbEP8SZt
         JEJZk1OWri5jWNvbjR4T352hCUJ+WWLAOp0CskgEhuwiUURgWTDy22o2YCQN9fK32YG/
         VL26L1HZgwe1aWrD/tyzguCHOtkS5FUczjXsFDFrxwPNFWd1AGIVaiJPbm+UsCyaE610
         j3gA==
X-Gm-Message-State: AOJu0Yx5Fb4Pii2am/FTF2zr2b4s4hB5lr2Ccj4vQu2UWV4HQodvW1yt
        Opb5w328iZFs6h5/Oal0VnYH2iSfAXcQBg==
X-Google-Smtp-Source: AGHT+IHEXwCzVTnk45oIZFh5O1og+XH+srcD5DBeMWWurI7hJDH2hur7wR+yXMTvjmt9Ge8duCv7gg==
X-Received: by 2002:a5d:6d82:0:b0:331:34c1:771 with SMTP id l2-20020a5d6d82000000b0033134c10771mr8300212wrs.50.1699962469636;
        Tue, 14 Nov 2023 03:47:49 -0800 (PST)
Received: from localhost.localdomain ([109.175.193.89])
        by smtp.gmail.com with ESMTPSA id t16-20020adfe450000000b0032dbf6bf7a2sm7628958wrm.97.2023.11.14.03.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 03:47:49 -0800 (PST)
From:   Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Gross <markgross@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ike Panhc <ike.pan@canonical.com>, stable@vger.kernel.org
Subject: [PATCH v2] platform/x86: ideapad-laptop: Set max_brightness before using it
Date:   Tue, 14 Nov 2023 11:38:08 +0000
Message-ID: <20231114114055.6220-2-stuart.a.hayhurst@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <9f46c613-63c2-4bc7-b938-7c9ea862a55e@linux.intel.com>
References: <9f46c613-63c2-4bc7-b938-7c9ea862a55e@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

max_brightness is used in ideapad_kbd_bl_brightness_get() before it's set,
causing ideapad_kbd_bl_brightness_get() to return -EINVAL sometimes

Fixes: ecaa1867b524 ("platform/x86: ideapad-laptop: Add support for keyboard backlights using KBLC ACPI symbol")
Signed-off-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
Cc: stable@vger.kernel.org
---

Sorry if I messed up the stable cc bit, I have no idea how that process works

v1 -> v2:
 - Fix commit message
 - Add missing tags

---
 drivers/platform/x86/ideapad-laptop.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index ac037540acfc..88eefccb6ed2 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1425,18 +1425,17 @@ static int ideapad_kbd_bl_init(struct ideapad_private *priv)
 	if (WARN_ON(priv->kbd_bl.initialized))
 		return -EEXIST;
 
-	brightness = ideapad_kbd_bl_brightness_get(priv);
-	if (brightness < 0)
-		return brightness;
-
-	priv->kbd_bl.last_brightness = brightness;
-
 	if (ideapad_kbd_bl_check_tristate(priv->kbd_bl.type)) {
 		priv->kbd_bl.led.max_brightness = 2;
 	} else {
 		priv->kbd_bl.led.max_brightness = 1;
 	}
 
+	brightness = ideapad_kbd_bl_brightness_get(priv);
+	if (brightness < 0)
+		return brightness;
+
+	priv->kbd_bl.last_brightness = brightness;
 	priv->kbd_bl.led.name                    = "platform::" LED_FUNCTION_KBD_BACKLIGHT;
 	priv->kbd_bl.led.brightness_get          = ideapad_kbd_bl_led_cdev_brightness_get;
 	priv->kbd_bl.led.brightness_set_blocking = ideapad_kbd_bl_led_cdev_brightness_set;
-- 
2.42.0

