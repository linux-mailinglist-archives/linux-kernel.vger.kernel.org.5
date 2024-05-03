Return-Path: <linux-kernel+bounces-168288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF9E8BB62F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F4D286E5B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219C013248B;
	Fri,  3 May 2024 21:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mpS3iNhL"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B34E131E2E
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772240; cv=none; b=hbhIQmZfWJ8jV9AaJBWKtW/QCDxLJAqU/++bkGjmX74AvegFmIE9aFul4Nv05ME+5OMXDxfnyFO+BGRQXa/i0IfyID4cYQEWzIfKovDZFFFdLVbxcMYNB2veDygim1EHhD7e27VrUDJwONCqLgtVsOPHy+g/+2axNZFTXnkNgNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772240; c=relaxed/simple;
	bh=GrL0PMxUJn2slEGcQnWTrRQLBVOUBqd7SqM84iVHzxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qn/Eyw86+Gdy1KGgTAa+n23ZFg2UNwav4UwFglFhU2rTXxdl4M6CXg+7mERO6MfbRyyz1YttSUgDt00RFbAEb9avcDObPgqs67MN5bohJVoGvWjVzk6284L2zhX7JHfbJS9LxMLKveiVfwFX2oDJxlwxNbt3kng0wh4oLHpOdWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mpS3iNhL; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e834159f40so687015ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772238; x=1715377038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjHl+DB7wvFQ0erRTiSGp5Vkb60hgkc17VF3W8JYnEQ=;
        b=mpS3iNhLmQQjTSAr7syrIrGVgxA57QiefiW8s8Cpc4KMVjU78lEoaRbJ8R7AouGUw6
         21rhprAfoJ8CbEQspF6psjAMGK3vGNMNY2Osxp8giyYagWCUWxgCB4kyLR7zeNpYgLa7
         Hy+OTqN9CDYC8mH5lhsQyvO4ARsQZ24p3gkz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772238; x=1715377038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YjHl+DB7wvFQ0erRTiSGp5Vkb60hgkc17VF3W8JYnEQ=;
        b=FEkKD4d+a7bY3K3gskOT/ysNW3TFVufVlYQRv1F7VoBCmC4dYkiUgUSWu18lMPGvIb
         he3htlYzX6ONaOkZ/e+jMMe/tqOH+VdvakijQqlAw6dM03hlltPiSPFOFr8soscHcBxY
         R4IB31KPYXgkDUUIEI048KOEum3lXhmi/iZoP3TAkkYG/aSd8q5k7qy1F5qHpCG9yZqy
         PL52vvFUZ2E/xKBzDB3oK+1d5RL9TTD5KqaLYzhCt3fqMvNqdi2dNuIFwCTvTQDGsf4x
         ErStfZaxn6qaDrzTi079q7DitRTCIdVhdmhm4SuFne8YAAdJzfasGVrCYn5QThi/v6hR
         kO6A==
X-Forwarded-Encrypted: i=1; AJvYcCUM0cl4rmEU65C541TE8fxHpjXqbkuY15UyKEMns9fLSBGxBnpYYzay9HDgEdfHLty+slt081ofFfXgYF1CvE+WYPDHHEySBpCnFOqq
X-Gm-Message-State: AOJu0YwBahbL9VT298Cmam/lL5VShgKXevaix2jYH16+5DcE7EicM1nU
	gFotpOw9JoYXGGf71gQ0+quaKEe1XtIZrvggkUVGXFXx29YBIjFqB5hQMZZNjw==
X-Google-Smtp-Source: AGHT+IHGkmJTrA+QEdoj0aZR/Y9uwm9CMi5KsoludQGf1jksEPkLR67IdZOHw27LEYo4LBKbqkaXGw==
X-Received: by 2002:a17:902:e807:b0:1e5:556:60e2 with SMTP id u7-20020a170902e80700b001e5055660e2mr4570462plg.5.1714772238405;
        Fri, 03 May 2024 14:37:18 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:37:17 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 23/48] drm/panel: osd-osd101t2587-53ts: Don't call unprepare+disable at shutdown/remove
Date: Fri,  3 May 2024 14:33:04 -0700
Message-ID: <20240503143327.RFT.v2.23.Ic533ce1323b94230d4155f9364c2b7c1bc47e798@changeid>
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

A grep through mainline for compatible strings used by this driver
indicates that it is used by TI OMAP boards. The OMAP driver appears
to be correctly calling drm_atomic_helper_shutdown() so we can remove
the calls.

[1] https://lore.kernel.org/r/20230901234015.566018-1-dianders@chromium.org
[2] https://lore.kernel.org/r/20230901234202.566951-1-dianders@chromium.org
[3] https://lore.kernel.org/r/20230921192749.1542462-1-dianders@chromium.org

Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c b/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
index c0da7d9512e8..dbea84f51514 100644
--- a/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
+++ b/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
@@ -186,11 +186,6 @@ static void osd101t2587_panel_remove(struct mipi_dsi_device *dsi)
 	struct osd101t2587_panel *osd101t2587 = mipi_dsi_get_drvdata(dsi);
 	int ret;
 
-	ret = drm_panel_disable(&osd101t2587->base);
-	if (ret < 0)
-		dev_warn(&dsi->dev, "failed to disable panel: %d\n", ret);
-
-	drm_panel_unprepare(&osd101t2587->base);
 	drm_panel_remove(&osd101t2587->base);
 
 	ret = mipi_dsi_detach(dsi);
@@ -198,14 +193,6 @@ static void osd101t2587_panel_remove(struct mipi_dsi_device *dsi)
 		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
 }
 
-static void osd101t2587_panel_shutdown(struct mipi_dsi_device *dsi)
-{
-	struct osd101t2587_panel *osd101t2587 = mipi_dsi_get_drvdata(dsi);
-
-	drm_panel_disable(&osd101t2587->base);
-	drm_panel_unprepare(&osd101t2587->base);
-}
-
 static struct mipi_dsi_driver osd101t2587_panel_driver = {
 	.driver = {
 		.name = "panel-osd-osd101t2587-53ts",
@@ -213,7 +200,6 @@ static struct mipi_dsi_driver osd101t2587_panel_driver = {
 	},
 	.probe = osd101t2587_panel_probe,
 	.remove = osd101t2587_panel_remove,
-	.shutdown = osd101t2587_panel_shutdown,
 };
 module_mipi_dsi_driver(osd101t2587_panel_driver);
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


