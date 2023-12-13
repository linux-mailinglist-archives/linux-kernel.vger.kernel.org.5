Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E12811F66
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442151AbjLMTvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbjLMTvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:51:23 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6407ECF;
        Wed, 13 Dec 2023 11:51:30 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c2c65e6aaso76177655e9.2;
        Wed, 13 Dec 2023 11:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702497089; x=1703101889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MfDHxrabIf+gmAYTXlhPOQXkHPRDrfLTxd0p36e6Hg=;
        b=dTDxRp595qKXYuA9Zogr4UM0eHnKgV9JbcxQPkMxrl2Whq2OJPf0SWdV7BcBhZ9tfN
         LlQ79JKe8XL4VdfKW/xPpvgKk4pok93lZdJ6KhvqH83gla9qN10aPz6+0GOkqB5XDlEo
         UbACHYirTU+pu39XU9/8QlarmBjIoa3ohsnPM9DYyoAgNE4JITpgnGS38mON6/QJhuYX
         wHhdPDSgeuhyb0O5NVIZkoLEK1GrMBqPxozxqj6AleDytKBf/Iqk2tZDoQnzlAdv+0bn
         hjibvn3rRSQe/rT+2IoAH17JZ2k2i6SLcDunj4dLnY5n9r8oL0PKb7aXZAHECPBCxhmr
         zggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702497089; x=1703101889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MfDHxrabIf+gmAYTXlhPOQXkHPRDrfLTxd0p36e6Hg=;
        b=Rr/nH0e2yowMyMwhHkenX0ViimtFc6QHKOnC7Qgk2VtJ/uPkVSpsf8/E71hDOj4bcP
         Sbqkp6Q0x0LRWMN6eeQxOoXYQGKc47DCz+TBFBI68N9IeksTwFjrv3UW7s5wAibaDh0v
         PY/rWLOeH60pCYxsOIeJppvHoH5VGZELu/OEwmvBKAzUqO8G7mcGhorJ93/pGl2lwAMK
         lttXuEKp+Zbn6UxP9dcpyzW1SLsCECXSw4AJT8LOAm02KzvW9QTqQCic/JDOePX2gUDd
         vdR8B4deEdbgKdwtefDYoxLuiF8QnAaJDVzFMCVHS3hP7w4aMOU6k4ZK0OCRsMxk7Agb
         glIA==
X-Gm-Message-State: AOJu0Yyl1A7ekK1lmAuBPEUKo2UWyTTAtc8o7DNrelF9kamy96RgEcdE
        QmJ/izzt6I8VPyMFG2Ps3A==
X-Google-Smtp-Source: AGHT+IGCytkAX3KBkCK2F8am/Dv9NsvC2yoOVaxaCHwDt9Jkj58Vtpb8hmL72hqJrd7flNDEA8saag==
X-Received: by 2002:a7b:c4d0:0:b0:40c:3272:1fea with SMTP id g16-20020a7bc4d0000000b0040c32721feamr4145598wmk.87.1702497088887;
        Wed, 13 Dec 2023 11:51:28 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:92dc:8b1c:e01c:b93c])
        by smtp.gmail.com with ESMTPSA id fm14-20020a05600c0c0e00b00407b93d8085sm24050698wmb.27.2023.12.13.11.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 11:51:28 -0800 (PST)
From:   Alex Bee <knaerzche@gmail.com>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Andy Yan <andyshrk@163.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>,
        Zheng Yang <zhengyang@rock-chips.com>
Subject: [PATCH 03/11] drm/rockchip: inno_hdmi: Fix video timing
Date:   Wed, 13 Dec 2023 20:51:17 +0100
Message-ID: <20231213195125.212923-4-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213195125.212923-1-knaerzche@gmail.com>
References: <20231213195125.212923-1-knaerzche@gmail.com>
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

The controller wants the difference between *total and *sync_start in
the HDMI_VIDEO_EXT_*DELAY registers. Otherwise the signal is very
unstable for certain non-VIC modes.
See downstream commit [0]

[0] https://github.com/rockchip-linux/kernel/commit/8eb559f2502c

Fixes: 412d4ae6b7a5 ("drm/rockchip: hdmi: add Innosilicon HDMI support")
Co-developed-by: Zheng Yang <zhengyang@rock-chips.com>
Signed-off-by: Zheng Yang <zhengyang@rock-chips.com>
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 drivers/gpu/drm/rockchip/inno_hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 6e5b922a121e..345253e033c5 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -412,7 +412,7 @@ static int inno_hdmi_config_video_timing(struct inno_hdmi *hdmi,
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_HBLANK_L, value & 0xFF);
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_HBLANK_H, (value >> 8) & 0xFF);
 
-	value = mode->hsync_start - mode->hdisplay;
+	value = mode->htotal - mode->hsync_start;
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_HDELAY_L, value & 0xFF);
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_HDELAY_H, (value >> 8) & 0xFF);
 
@@ -427,7 +427,7 @@ static int inno_hdmi_config_video_timing(struct inno_hdmi *hdmi,
 	value = mode->vtotal - mode->vdisplay;
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_VBLANK, value & 0xFF);
 
-	value = mode->vsync_start - mode->vdisplay;
+	value = mode->vtotal - mode->vsync_start;
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_VDELAY, value & 0xFF);
 
 	value = mode->vsync_end - mode->vsync_start;
-- 
2.43.0

