Return-Path: <linux-kernel+bounces-168296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5A38BB63A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C03C72821E8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634FF58ADD;
	Fri,  3 May 2024 21:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dxgRrXyU"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDD413442A
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772260; cv=none; b=qpg1N4uF4JiFjLf/gi/2hJpsDSu4kOJ8ls6lzsZiFeYZYSwUF2ZPl+FmzF634eedWYA9c/x4f9La40a3J2d8UVBDKxHf2D1GUpDZTDBfA9y578oiPagpZIuQ4YjUxiQyXaua3hAcBpvr7ISTmNgRORpiMdCfFJ6NM8QTRm32mws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772260; c=relaxed/simple;
	bh=8AL4/BrmmLegJmpkJf63Gl5oIOD38PWXABHHgefe0OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g2gQ1cnxaZSv+QynpMqaIpqTmCM9p02A3ChRSMgyF0XleTO5NT7HKXzonXpGFDbz9uGsXZJryn+iukLe2QxkLXxzTbCQhihV76RYBa9E2362+zRzFDSKtQfJx4zRfjqdkbZmPjVTG2l98EzBDfOfzNjscekDcU1stmCV65/eoN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dxgRrXyU; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e651a9f3ffso687465ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772258; x=1715377058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OkjbvX0C1irAjMh4DggDyOVbw/aLDxkOK/5mqNSwoE=;
        b=dxgRrXyU4/suDsAuhhvmlmvkUTu/Q9rTBcyrzCFaDZO5/W7WcTm5UStp7gW2i9FjpR
         lVwa4gBB1Nf4jDfap6jRYgt14GY5ktmTgw3pdl+7O7hJuCu5IynumUgYeAS9nzPqyCOg
         cXk5dHM7q3mjwIKtZViYLVzosNzbabPRhwlas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772258; x=1715377058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/OkjbvX0C1irAjMh4DggDyOVbw/aLDxkOK/5mqNSwoE=;
        b=iZlYVhIJoiP3B9qp9F5lTplmqmhFAJgMWsE9xxX/Wlcj4eqz0l/qqQFJ5Y3RsE+1E8
         Jf1b+DrExGf936jCbx9b3HgBN3kaw3ztbdhTlWomDPnWhEG8Gyr1PZMSMdKaM8OGL49Q
         kEI4SefpAwBi51VPJ7u2QvhZS2hP6iKD7+N2JgxqzFRcjzFgkjnJV5n2AM5QLTsZAcUR
         gtx+8InkjvUbuKZwpZe6sYEa2NijUw8FXGVrfsKpqLSvx76xBWxI5vpg2n+fXSvM2yZt
         OGcDYi6fINDT34YAeSX9lzwx4mDOEZohAsQmzHDxJ3gSKFMwsWlqNk9yrs2DAI2TNDNz
         WaAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxe6Ujov8C1/76eYN/Wqx70I6bAjAaYnBIoC/A2MeMAVRiZS4fCr7HVx+X4gk3kYD4w/rIjGKchcL02maiuBaacqFrYPD0eatc3R7x
X-Gm-Message-State: AOJu0YwU32D+vwchROFrKlMQ4ELqaMR4opwbyAFJHf2a2B0NYCDmRqBr
	4U+fd4gTzXhlzJYqgl3hceCB+Z9y4Izrgy8ADjXj4I728jC+Oj4NUjMvFATwrw==
X-Google-Smtp-Source: AGHT+IGYHi4nDiwk/CzlytVTK20zaPGarGSgcOiG/MYrHHmtbd3gAzexe8vp7KqG0wrEiuiufOiKDQ==
X-Received: by 2002:a17:903:1108:b0:1e5:5bd7:e2b7 with SMTP id n8-20020a170903110800b001e55bd7e2b7mr3948148plh.34.1714772258578;
        Fri, 03 May 2024 14:37:38 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:37:38 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 31/48] drm/panel: xinpeng-xpp055c272: Don't call unprepare+disable at shutdown/remove
Date: Fri,  3 May 2024 14:33:12 -0700
Message-ID: <20240503143327.RFT.v2.31.Ib97e67a9877070698afbec4f8ede091b2bf89a1f@changeid>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240503213441.177109-1-dianders@chromium.org>
References: <20240503213441.177109-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It's the responsibility of a correctly written DRM modeset driver to
call drm_atomic_helper_shutdown() at shutdown time and that should be
disabling / unpreparing the panel if needed. Panel drivers shouldn't
be calling these functions themselves.

A recent effort was made to fix as many DRM modeset drivers as
possible [1] [2] [3] and most drivers are fixed now.

A grep through mainline for compatible strings used by this driver
indicates that it is used by Rockchip boards. The Rockchip driver
appears to be correctly calling drm_atomic_helper_shutdown() so we can
remove the calls.

[1] https://lore.kernel.org/r/20230901234015.566018-1-dianders@chromium.org
[2] https://lore.kernel.org/r/20230901234202.566951-1-dianders@chromium.org
[3] https://lore.kernel.org/r/20230921192749.1542462-1-dianders@chromium.org

Cc: "Heiko Stübner" <heiko@sntech.de>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 .../gpu/drm/panel/panel-xinpeng-xpp055c272.c    | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c b/drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c
index 8262c00670cf..22a14006765e 100644
--- a/drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c
+++ b/drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c
@@ -306,27 +306,11 @@ static int xpp055c272_probe(struct mipi_dsi_device *dsi)
 	return 0;
 }
 
-static void xpp055c272_shutdown(struct mipi_dsi_device *dsi)
-{
-	struct xpp055c272 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = drm_panel_unprepare(&ctx->panel);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to unprepare panel: %d\n", ret);
-
-	ret = drm_panel_disable(&ctx->panel);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to disable panel: %d\n", ret);
-}
-
 static void xpp055c272_remove(struct mipi_dsi_device *dsi)
 {
 	struct xpp055c272 *ctx = mipi_dsi_get_drvdata(dsi);
 	int ret;
 
-	xpp055c272_shutdown(dsi);
-
 	ret = mipi_dsi_detach(dsi);
 	if (ret < 0)
 		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
@@ -347,7 +331,6 @@ static struct mipi_dsi_driver xpp055c272_driver = {
 	},
 	.probe	= xpp055c272_probe,
 	.remove = xpp055c272_remove,
-	.shutdown = xpp055c272_shutdown,
 };
 module_mipi_dsi_driver(xpp055c272_driver);
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


