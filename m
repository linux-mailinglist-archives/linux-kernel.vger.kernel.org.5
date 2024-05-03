Return-Path: <linux-kernel+bounces-168269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0CF8BB610
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A404B28324C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EEE85270;
	Fri,  3 May 2024 21:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RKuf7WuA"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897DE84A57
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772202; cv=none; b=BJw3IfBy1RH7wLrpGz5oU8U2eh2ZguUDwAJJ1Z1WX99t5bHnVtfdKKpHtkALCzlku3ZeEzMP+v2wMYPeRkrGm6RhZaJbnODBFzznts11/b/sb60W1ghrMUTB3W4arfAaYx1giGTyxzPFDl2LBfCtQlnJV6ukZqNHNTQXzt564fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772202; c=relaxed/simple;
	bh=Xl9OtOjknJgxbPeTWau1v9EcTyLAEVp1zRV24ZssokE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7zJTStZIZcMgNorjrQLYkRIUNdjfQhz5nMK8j+bjE4FHGLncfiwlMcDe8yBnCKJkMGOm449R/XLN6xwlYsilEdXx8b34GTMimn2rI93JKJxBMvdlxOBp2zhHuHHR3N1U8vmZWE+AabIj6/3AkBHEtkE8NgEjaUwooatSKwWpaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RKuf7WuA; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ecddf96313so1021655ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772197; x=1715376997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kta59gfQkdmQ0TL4kfPKXK/PL72P/0YD8zIuorS00AE=;
        b=RKuf7WuASvpstKfIfW3yhShTNOQuEveO6/fLm1OPufay7VnTcsCAE0JdmZ/2Hu0E4v
         dFtZePu/kZf2y0jem3OaeKKzxgu44HaOj9TPLbaJ0jQbvVzO3cvln0bvHxZqYKKbjvMx
         KnFEXgkCML1RQOAzVdK21JrcoKKDbCaQp0ag0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772197; x=1715376997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kta59gfQkdmQ0TL4kfPKXK/PL72P/0YD8zIuorS00AE=;
        b=scScBsroathzlQYfaLp0KAIfHdABABSB0sMCmrleekcYpteyxUmSzSKrPd1nVIMDpc
         Pgz5iTz0Pr27Yg9jIsEOQSKmNfyysWxNZMW0Yojtr7X5QHlYXK7HYJFah9AkipkiUfnM
         n447A1pznqovWTRotbBIB8GqjqF8fbkaFWLDXQmRrZ0iymwBDGt9RA5inRopCqnpPM9P
         j9eYHFEmdo9BUKCNxQU4DgihYWJIcY6JZxHIfg3J5ec7Q7DKbbmA07NXDTjgytqn1cL8
         pBpx7oFk0nr/7ynL7A32okcGtTkh9JfekE1w1mnuekG0RJV6xu4gN1NTtzAPjPqoJqDf
         Ysng==
X-Forwarded-Encrypted: i=1; AJvYcCWs/c6hlfcD0hVxyVS+BAhWUAFfj6JM+fyFCVcyzFs42pqeod4ghrPTFYIgbUAY5GtQod7Qk/XSG61BbbAnpWHpRoSTCu0i0jh4f6n/
X-Gm-Message-State: AOJu0Ywv72mQGoNKYcymmdjT3ediqYhFPYXjPrJSVkZQrXTyKV7DGQnb
	4KN+V+TnCuOMqV+q6QEfDbytnD/WtCB69/lCpdoORnnkcYA6i8PZdIlSOCf9Fw==
X-Google-Smtp-Source: AGHT+IHVhWhn4/nQtVyQZZLqUsnywWTqYGnhPIFneTo2Pek/30GOWy84nbyfus1Fy+LIRhpR3w7cFQ==
X-Received: by 2002:a17:902:d4c7:b0:1e5:4f5:7fa7 with SMTP id o7-20020a170902d4c700b001e504f57fa7mr5769734plg.21.1714772197003;
        Fri, 03 May 2024 14:36:37 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:36:36 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Jitao Shi <jitao.shi@mediatek.com>,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [RFT PATCH v2 05/48] drm/panel: boe-tv101wum-nl6: Don't call unprepare+disable at shutdown/remove
Date: Fri,  3 May 2024 14:32:46 -0700
Message-ID: <20240503143327.RFT.v2.5.I5bd120aa0b7d17a1149ea43cc4852492834058c0@changeid>
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
indicates that it is used by Mediatek and Qualcomm boards. Both of
those drivers appear to be correctly calling
drm_atomic_helper_shutdown() so we can remove the calls.

[1] https://lore.kernel.org/r/20230901234015.566018-1-dianders@chromium.org
[2] https://lore.kernel.org/r/20230901234202.566951-1-dianders@chromium.org
[3] https://lore.kernel.org/r/20230921192749.1542462-1-dianders@chromium.org

Cc: Jitao Shi <jitao.shi@mediatek.com>
Cc: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index 667e1bb4a58b..77b20e24cac7 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -1910,21 +1910,11 @@ static int boe_panel_probe(struct mipi_dsi_device *dsi)
 	return ret;
 }
 
-static void boe_panel_shutdown(struct mipi_dsi_device *dsi)
-{
-	struct boe_panel *boe = mipi_dsi_get_drvdata(dsi);
-
-	drm_panel_disable(&boe->base);
-	drm_panel_unprepare(&boe->base);
-}
-
 static void boe_panel_remove(struct mipi_dsi_device *dsi)
 {
 	struct boe_panel *boe = mipi_dsi_get_drvdata(dsi);
 	int ret;
 
-	boe_panel_shutdown(dsi);
-
 	ret = mipi_dsi_detach(dsi);
 	if (ret < 0)
 		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
@@ -1972,7 +1962,6 @@ static struct mipi_dsi_driver boe_panel_driver = {
 	},
 	.probe = boe_panel_probe,
 	.remove = boe_panel_remove,
-	.shutdown = boe_panel_shutdown,
 };
 module_mipi_dsi_driver(boe_panel_driver);
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


