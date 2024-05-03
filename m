Return-Path: <linux-kernel+bounces-168281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E288BB627
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEE52284A26
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F182C130E27;
	Fri,  3 May 2024 21:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oD8zRC2H"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CA5130AE6
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772227; cv=none; b=C6blJSRu/4PQEICdKuzrYhXBsUHgLAcKav5yZTyxFKq51Ne9f03NmQ4g9YAEdKye27NCCqENvYhiz/KCJGTK2s8MWcyBe82LDk44FpMSzC5K7CTMLbpOMLTNhJIS3jM2DFMSbRhs6VfWgl6xzFP2NQ6mLaUfVdbu2bMgaoItsb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772227; c=relaxed/simple;
	bh=lFIz7Wv/Gno+bqsodv/erUwQ6imEDad+1TPMruFsDME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r8D3Kyeo8gt4+HRjAQYcU/x11j81EnX4fIaCN83ZOUSR97LZcYUCb7QPXOT9NMja03ZdZaycWBoEQokpzk3Y36keXrJaFIxCroTfKffHDBQXk7v2Byvn088sEBllLRWKg7B3N+VT2o2kmE0pBUofz86q2Cg3Dvf9iJlp8WuQPhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oD8zRC2H; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e5715a9ebdso1040875ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772225; x=1715377025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OurSfwTANRkudP5WoG3OHb0cRgGIUvtMPN3apL/0E6k=;
        b=oD8zRC2HIgKGEYYzfybZydwxjjkN+5mGDxSJ3gPX+N9zKMc/pgUZ/eYQM4Ow1yQ3rc
         eBvhiC1MulWD4JBOd0R77PNEhGB25pN7gBkl+f4jQal+4pqZBAJ5wkKIP/tLPQMuFq1J
         SPHJ2gloin1gX1RkABJV1U3fx5kTrWZgcwjWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772225; x=1715377025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OurSfwTANRkudP5WoG3OHb0cRgGIUvtMPN3apL/0E6k=;
        b=W+xvr+ZaF84C6PsgRPJ+vQWiI0PSW6Ew7aHZw9L3xR8ioclxErXCjddL8bH5hJtH55
         QC2hNMmoxeBJi0Zl04eT36q+c0uu3a0trd9ufxqrqJkfz9r7xthQuQQbvwc6E/ueIm5J
         nxX0XherxiCvsytOSm8s9CdM28fBLpDedqh2VkXDpSyM3IYmfvq+C2A2oOy7X4Eb5ZoB
         qx1s8M3SrbZzoywtWFyCuWx1dg7rDcCKr+AO6wTecx0HQKvoHtF/wR/UcT3I++wDSjmK
         xp7Y8ENf6VzpLTE5MQFK5BbQ+S4MSI2smovrXbxF2jfdsoba+CAvJ8mUZ/3/OEHr7Ziy
         OdWg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ1EWyrmmrYjxHLFkuEquMLpfhTDPHQBAaInhBhvt2ZCmmiL6ZGGiMwBP680MbyfyNx+uyc3WOZ91+ehvRDXn12yN3Bmyu/Lq69ZJ4
X-Gm-Message-State: AOJu0YyOSYPrOgbHSIc7vbZ+SuSmmTJ9QTiayDySIMqQSQrzoMg28DtC
	Q9vj6TZw7ZIotP0w2vAgyYaStS9ZyQHh9FcCF83VwKqLlhTLdpPl2QGvqopjqQ==
X-Google-Smtp-Source: AGHT+IH9vby0Or/VZX1bepw3qRTBDCpHhFvXpQCEjgbtETO8XlYEb0zz4N/sIP1EkhPbEGMjNfnqIA==
X-Received: by 2002:a17:902:e802:b0:1e6:40f1:9357 with SMTP id u2-20020a170902e80200b001e640f19357mr4411172plg.8.1714772225244;
        Fri, 03 May 2024 14:37:05 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:37:04 -0700 (PDT)
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
Subject: [RFT PATCH v2 17/48] drm/panel: ltk500hd1829: Don't call unprepare+disable at shutdown/remove
Date: Fri,  3 May 2024 14:32:58 -0700
Message-ID: <20240503143327.RFT.v2.17.If3edcf846f754b425959980039372a9fd1599ecc@changeid>
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

Unfortunately, grepping mainline for this panel's compatible string
shows no hits, so we can't be 100% sure if the DRM modeset driver used
with this panel has been fixed. If it is found that the DRM modeset
driver hasn't been fixed then this patch could be temporarily reverted
until it is.

[1] https://lore.kernel.org/r/20230901234015.566018-1-dianders@chromium.org
[2] https://lore.kernel.org/r/20230901234202.566951-1-dianders@chromium.org
[3] https://lore.kernel.org/r/20230921192749.1542462-1-dianders@chromium.org

Cc: "Heiko Stübner" <heiko@sntech.de>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 .../gpu/drm/panel/panel-leadtek-ltk500hd1829.c  | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c b/drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c
index ef27cab08f1d..6b18cf00fd4a 100644
--- a/drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c
+++ b/drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c
@@ -662,27 +662,11 @@ static int ltk500hd1829_probe(struct mipi_dsi_device *dsi)
 	return 0;
 }
 
-static void ltk500hd1829_shutdown(struct mipi_dsi_device *dsi)
-{
-	struct ltk500hd1829 *ctx = mipi_dsi_get_drvdata(dsi);
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
 static void ltk500hd1829_remove(struct mipi_dsi_device *dsi)
 {
 	struct ltk500hd1829 *ctx = mipi_dsi_get_drvdata(dsi);
 	int ret;
 
-	ltk500hd1829_shutdown(dsi);
-
 	ret = mipi_dsi_detach(dsi);
 	if (ret < 0)
 		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
@@ -710,7 +694,6 @@ static struct mipi_dsi_driver ltk500hd1829_driver = {
 	},
 	.probe = ltk500hd1829_probe,
 	.remove = ltk500hd1829_remove,
-	.shutdown = ltk500hd1829_shutdown,
 };
 module_mipi_dsi_driver(ltk500hd1829_driver);
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


