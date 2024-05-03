Return-Path: <linux-kernel+bounces-168306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6E68BB644
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC1A8287188
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34F884DE3;
	Fri,  3 May 2024 21:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jqb2USmW"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987481369AE
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772281; cv=none; b=l/z6rMONbMJBEoKxKQq8L8S8FICJeK5wSH/SXumQm0PGD+BwMAx68by0QYqrcEn/0nL934HZDoZWEpN13E4wKxIsThZrfbMNMymYxT/f5pZ3To7Q4RYZIrRjGx4vl2fD9uX3mnizZWPRghUI45bkIk0UwHfeeY5CNUT+LENy07I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772281; c=relaxed/simple;
	bh=0gjF3n43Y5wOexAtiOvGFTLJ9QIRsnvOFeO64QgZYsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXrSVpAItMq9ulZYW/3pxQjWdWjtyb8i3g5l6C1qLScWUihlcuz0TvuuSJif9uL7yfZTYzq0yxwpl4Edu/DsR7r+VlINRpSp+18SrlHHpAPtOPYLa24fGKx8j2K8p6Va41Y3h5nb0SC/QerKCesEuMaWff3OL373KKw/bhluUAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jqb2USmW; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ec5387aed9so1023035ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772279; x=1715377079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dXwPdbkXokcaTdukxLAHZJBTCR2jkjSjRsL5uHOD/8=;
        b=jqb2USmWu1MT7/Ts1XN17RIGNuQ8R72KFF2em3/PvbfSIOH6Hsz5T5N6dZtKF8Doav
         1gOuNs0zM2HDxl/5hayme3kr5ILAQHWuYAio88E2SnU6B9QxhuNyFu+67kTxOKJwo9M/
         OTqUey8IbtzPj/0An5Q9mUNYYly+PsJO9NgBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772279; x=1715377079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dXwPdbkXokcaTdukxLAHZJBTCR2jkjSjRsL5uHOD/8=;
        b=Xoknzu5hdxXqdCpLWo86jJvo5/R95SPHODrrcxpKfBWO8Y/q6XN3cKUj8+PbLS5Iv4
         vjMsPkFeQ5D0xh/xL5b1Zh2/J12HNsnL77r7GJUqkueofoKXy708g0OcANCkZ08K8nix
         qzzo32aMhOWEKl4rNLoaKeFYSfSgjrsG87u7i4OEubt9Znp7Mjk0qUOZP/Rnil87Y237
         6oNuyiD7SLamcrzEyh+Oi8A2Y8QArgQE6q0fS1gRqYBkkNs6W/mg3D4+2wPNFCvHfAf4
         JvV3dIRkq9gDhkNPB0O0c5ePYQbVIt1wVlZiDvyFqJA+H/LfVaDfud6a1T95bal1rs69
         XNXA==
X-Forwarded-Encrypted: i=1; AJvYcCXewbtKrKBzlsONqGH15Nk4Va1Td7NqU3jBtPY7nGng3EGIWP4WI6Wg+Qmc3z3ndfH4kx/cYWbU82cyHnIQTCR47kH36XXVah08ikBx
X-Gm-Message-State: AOJu0YyJBlv6iAUK0n3cqqCnSbeT/fWRKiyZdtPf2FeIyTvSyHAc/3b7
	X1//VButiE5WF7vhsN/QFVwMtML4SSzNITmgT/WhVKZQENNf+D/5cOndLlQKkA==
X-Google-Smtp-Source: AGHT+IE/1VVEigXJzCYmydTc9NCW51n7kNBmzsc64scd/SOgSmiWWb87c07CAccSkm9G8TiEnbdUIA==
X-Received: by 2002:a17:902:8f96:b0:1e2:6d57:c1bb with SMTP id z22-20020a1709028f9600b001e26d57c1bbmr3584215plo.21.1714772279072;
        Fri, 03 May 2024 14:37:59 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:37:58 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Werner Johansson <werner.johansson@sonymobile.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 41/48] drm/panel: sharp-ls043t1le01: Don't call disable at shutdown/remove
Date: Fri,  3 May 2024 14:33:22 -0700
Message-ID: <20240503143327.RFT.v2.41.I89ee53f7fc2f0806cab318128e5fa927990d830f@changeid>
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
indicates that it is used by Qualcomm boards. The Qualcomm driver
appears to be correctly calling drm_atomic_helper_shutdown() so we can
remove the calls.

[1] https://lore.kernel.org/r/20230901234015.566018-1-dianders@chromium.org
[2] https://lore.kernel.org/r/20230901234202.566951-1-dianders@chromium.org
[3] https://lore.kernel.org/r/20230921192749.1542462-1-dianders@chromium.org

Cc: Werner Johansson <werner.johansson@sonymobile.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
index c86337954ad7..729cbb0d8403 100644
--- a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
+++ b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
@@ -267,10 +267,6 @@ static void sharp_nt_panel_remove(struct mipi_dsi_device *dsi)
 	struct sharp_nt_panel *sharp_nt = mipi_dsi_get_drvdata(dsi);
 	int ret;
 
-	ret = drm_panel_disable(&sharp_nt->base);
-	if (ret < 0)
-		dev_err(&dsi->dev, "failed to disable panel: %d\n", ret);
-
 	ret = mipi_dsi_detach(dsi);
 	if (ret < 0)
 		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
@@ -278,13 +274,6 @@ static void sharp_nt_panel_remove(struct mipi_dsi_device *dsi)
 	sharp_nt_panel_del(sharp_nt);
 }
 
-static void sharp_nt_panel_shutdown(struct mipi_dsi_device *dsi)
-{
-	struct sharp_nt_panel *sharp_nt = mipi_dsi_get_drvdata(dsi);
-
-	drm_panel_disable(&sharp_nt->base);
-}
-
 static const struct of_device_id sharp_nt_of_match[] = {
 	{ .compatible = "sharp,ls043t1le01-qhd", },
 	{ }
@@ -298,7 +287,6 @@ static struct mipi_dsi_driver sharp_nt_panel_driver = {
 	},
 	.probe = sharp_nt_panel_probe,
 	.remove = sharp_nt_panel_remove,
-	.shutdown = sharp_nt_panel_shutdown,
 };
 module_mipi_dsi_driver(sharp_nt_panel_driver);
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


