Return-Path: <linux-kernel+bounces-168294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258638BB637
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7D2284C9C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C98FC0C;
	Fri,  3 May 2024 21:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PlEPWiBn"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B86D1332BD
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772255; cv=none; b=o54tkPMAHwySmP8wNe2B6dl5Jk/ewi2iqmY5Sn0RZqKrP+LxsEAzg1dryiH6k8wkSfdEoEfuqjPsNKsH2+BHE9D1ldCHiuZz8IKL1lIVNZA9o/JwHKT/M/fjAR5VMiIMk5+oNr/lG2eibSIDtMrp9b2TjWOfUYRhharUxGg005s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772255; c=relaxed/simple;
	bh=B87t9irMwa1Woziqob9gKqOueiGVlqkiYIMNBao3tAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9tX9D3LPEB92WSxH9g/3tkl5Wz5u+yNVEJxV784Zfi0cWV3l7fJkXOmvAvE+zTTcGPfjqQXekdPSYX0P6auaH4Zq2rIm6IZRY0kOiFpRgqZEZkVnd6fvFafPszk2ME42dQEK4/QdX9PMW6U76UYFBxq53QgAGd4muHEoBFCerw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PlEPWiBn; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ec5387aed9so1020455ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772253; x=1715377053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0ij9ytrBMTlh/tBwBQfGeyqwsUC3qnXNREpsQEX2pQ=;
        b=PlEPWiBnBDTDORmTMHlrEDOnDreTNMCRIcrBp/ThpsczWdBGDFsCfyRdYl7Gxyp9yC
         OAPYwYQy/bfGoChRuCbUQHdjcDefUW1KNJsUlMVXeL6tOwiI2z80DAep5yY9o6xpoLOg
         GHp/9TBDqT1hzha7HLN8vXSJ/u4vRZubi/6ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772253; x=1715377053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0ij9ytrBMTlh/tBwBQfGeyqwsUC3qnXNREpsQEX2pQ=;
        b=Ob3t2PQHDFK5+reNwSkRz6FH+YeTrCXdTo8DSpQXsDtQ3XGbyabtUfPdtJVUwo4pow
         +Yat7g1rtlyp447rU5cXkxMeWUZyo7kvT6QWHjh2tOCOj7IBJCdBa96NCl7US4J85w1u
         lzwaW64lk/zEU7MsrYcl6YKonSxmKhjAGQwRqupHpmNIjjxhRGmVKZHwK/PjszGfmAuK
         H++X2DWEFXILQ5f9nBJ+hJbMCvrnGtF5s1PygqILlfZcrHj06XP3kavTkArwNJCktGrL
         STmVYAVNru6gRaK7U4zX4TR3pkdlVGb0WP4MMWBcwz1CSu7kXb8JY3wbQSCn9pB88NsG
         vfoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuCFgMrU4q/JdFvcnfWmErLKOEoc+IJL1ZG65oEkxUJDZODMl1JGrJJPg3SWEhkgFS1ksNVFOKZYpcg2BxMac7eyDS/TR7JyKUP1ap
X-Gm-Message-State: AOJu0YwH+R5w6ciRV1TDqL8cCtVe9S3sT72sef9p5MsUoX5bukWnD6IB
	MREaf7cDbZOUvzv4QTSFsSakZZalBmuQ4mTf4KlkethBqYYNCKYa1bgjUuJhnw==
X-Google-Smtp-Source: AGHT+IGZhFFrirxel2mH4hhJVW+YPU9/55QLc4j01+5DJlTA0WMSbmDxlLpFOw990mv8yfllPRRAHg==
X-Received: by 2002:a17:902:ef8b:b0:1e2:c554:a93c with SMTP id iz11-20020a170902ef8b00b001e2c554a93cmr2868203plb.29.1714772253398;
        Fri, 03 May 2024 14:37:33 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:37:32 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 29/48] drm/panel: tdo-tl070wsh30: Don't call unprepare+disable at shutdown/remove
Date: Fri,  3 May 2024 14:33:10 -0700
Message-ID: <20240503143327.RFT.v2.29.I46ff4e28c260bcd8e81205debd0994e76fd8aeac@changeid>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240503213441.177109-1-dianders@chromium.org>
References: <20240503213441.177109-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's the responsibility of a correctly written DRM modeset driver to
call drm_atomic_helper_shutdown() at shutdown time and that should be
disabling / unpreparing the panel if needed. Panel drivers shouldn't
be calling these functions themselves.

A recent effort was made to fix as many DRM modeset drivers as
possible [1] [2] [3] and most drivers are fixed now.

Unfortunately, grepping mainline for this panel's compatible string
shows no hits, so we can't be 100% sure if the DRM modeset driver used
with this panel has been fixed. If it is found that the DRM modeset
driver hasn't been fixed then this patch could be temporarily reverted
until it is.

[1] https://lore.kernel.org/r/20230901234015.566018-1-dianders@chromium.org
[2] https://lore.kernel.org/r/20230901234202.566951-1-dianders@chromium.org
[3] https://lore.kernel.org/r/20230921192749.1542462-1-dianders@chromium.org

Cc: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
index 36f27c664b69..227f97f9b136 100644
--- a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
+++ b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
@@ -208,16 +208,6 @@ static void tdo_tl070wsh30_panel_remove(struct mipi_dsi_device *dsi)
 		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", err);
 
 	drm_panel_remove(&tdo_tl070wsh30->base);
-	drm_panel_disable(&tdo_tl070wsh30->base);
-	drm_panel_unprepare(&tdo_tl070wsh30->base);
-}
-
-static void tdo_tl070wsh30_panel_shutdown(struct mipi_dsi_device *dsi)
-{
-	struct tdo_tl070wsh30_panel *tdo_tl070wsh30 = mipi_dsi_get_drvdata(dsi);
-
-	drm_panel_disable(&tdo_tl070wsh30->base);
-	drm_panel_unprepare(&tdo_tl070wsh30->base);
 }
 
 static struct mipi_dsi_driver tdo_tl070wsh30_panel_driver = {
@@ -227,7 +217,6 @@ static struct mipi_dsi_driver tdo_tl070wsh30_panel_driver = {
 	},
 	.probe = tdo_tl070wsh30_panel_probe,
 	.remove = tdo_tl070wsh30_panel_remove,
-	.shutdown = tdo_tl070wsh30_panel_shutdown,
 };
 module_mipi_dsi_driver(tdo_tl070wsh30_panel_driver);
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


