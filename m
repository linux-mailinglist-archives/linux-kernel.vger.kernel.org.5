Return-Path: <linux-kernel+bounces-168279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7977B8BB625
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E518F1F21542
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4823130AC8;
	Fri,  3 May 2024 21:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fOEdVGa3"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94C912F382
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772223; cv=none; b=P5CvSxYKpMXywLx6fr0LUmGPMo1NBa5W5ItE5hPTdRFa8a8O4BXLPV65V4tbXvqAME6jDMqOGU433sltcAMV7kvWms5W1xmIdTqQoE7GSn1IZp+WWqtcKi7cy48A7yB9mtuzttEF3cOFm4bBB9/Toi2gUZOIiEFAqA2u/zoj11A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772223; c=relaxed/simple;
	bh=ofQg9FgdPDQqQAShgmMqDyWZORG0+F8zbwQrNcERnsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QMV7fjJ7sQF43N0eqMN5mJhJXwJnkB5jacqUErNQI37iWs6GOEi8hZ3uaUIrJXm4cpBcjf4W+aDjbI39YOljN27u3LWFvk0sTZ8mMNYpK8IeFkXQxlYTljb4DgBVcf3PCCwRA9KMDTolNojmxKNX94xFCFusKsDrETFB5h8AWsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fOEdVGa3; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ecff927a45so1150235ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772221; x=1715377021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Y9nTdENQ7Wsy544i8JrWRgyMyQ3M74fjSP7BIF4QEI=;
        b=fOEdVGa3biIGHT6JfOdgWL+Hzz/c6l+VwGM1SQDQ/PKXzkp1LeTrnJp5glxW8q39De
         c3Bu+V/21JbzD2zSwnib5Fm0z2Mcxg0L4GQWh2PJYZu2L/n1VmOXIVm8EFT/oOQuazgV
         S3QVeiQhO4SkGWlySbYapPo1ud/umx6W+btO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772221; x=1715377021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Y9nTdENQ7Wsy544i8JrWRgyMyQ3M74fjSP7BIF4QEI=;
        b=FbxNPQMN8iNj34JG5OYh7zC9RMVNp7BYbirDF3ybbMxDqy15Mrz4X7RjvANRxdB+Sb
         V3d6vhz9InKr/OkcGO0NJPwpGXXuAGDycIqnpbez7DSpw/NcKyd0wXsrsGfAYy+u1nGD
         Y1a1Cp+z5VQYmwMyq2lVucNIfJX4ht0rgcziQnh7fqrpiQDBzwaR204bufBS7zSMG2jA
         DQriyH+NTUf6UgwqgkPkjsoggDFtWd/pOMOG8UFj67Pm5xssLVFBgxL5VuPfQ9YMGKaW
         eW30D0SgE5/MbWLoGG9YvB+FAO6M3Mehq7p1k55Bu1txHccUiN54auR4u7E5NzHw2+ME
         0XzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDqAtL1GX4KCVtGZ/v93g4jMvsfaVsRtDgGjaR3fgA4FIysON7ykHWsMT4Z2dVc82SeSSsriemD/0743PkNiK7Sr5rq89XEqGVArFp
X-Gm-Message-State: AOJu0YwakG9/2ycBPUNSzEA+LhrkWdUQvCYCCZiDxLrnp4K6pIKcclnf
	FxmUUyZfo0F+7s3+j6Pe/pzh2MSsnWqmzL2wMPDqpAuNhEDMAfrQUCQZ4W02yQ==
X-Google-Smtp-Source: AGHT+IG9ldtVTieXA1Mk9918TqXU0GmNr1vS54kcAamhylLrurY6wy29CnNThSUyMLFqb7DbECdGsQ==
X-Received: by 2002:a17:902:a60c:b0:1e4:6938:6fe3 with SMTP id u12-20020a170902a60c00b001e469386fe3mr3701239plq.58.1714772220922;
        Fri, 03 May 2024 14:37:00 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:37:00 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Quentin Schulz <quentin.schulz@theobroma-systems.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 15/48] drm/panel: ltk050h3146w: Don't call unprepare+disable at shutdown/remove
Date: Fri,  3 May 2024 14:32:56 -0700
Message-ID: <20240503143327.RFT.v2.15.Ibeb2e5692e34b136afe4cf55532f0696ab3f5eed@changeid>
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
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 .../gpu/drm/panel/panel-leadtek-ltk050h3146w.c  | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c b/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
index 5894bf30524a..292aa26a456d 100644
--- a/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
+++ b/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
@@ -673,27 +673,11 @@ static int ltk050h3146w_probe(struct mipi_dsi_device *dsi)
 	return 0;
 }
 
-static void ltk050h3146w_shutdown(struct mipi_dsi_device *dsi)
-{
-	struct ltk050h3146w *ctx = mipi_dsi_get_drvdata(dsi);
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
 static void ltk050h3146w_remove(struct mipi_dsi_device *dsi)
 {
 	struct ltk050h3146w *ctx = mipi_dsi_get_drvdata(dsi);
 	int ret;
 
-	ltk050h3146w_shutdown(dsi);
-
 	ret = mipi_dsi_detach(dsi);
 	if (ret < 0)
 		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
@@ -725,7 +709,6 @@ static struct mipi_dsi_driver ltk050h3146w_driver = {
 	},
 	.probe	= ltk050h3146w_probe,
 	.remove = ltk050h3146w_remove,
-	.shutdown = ltk050h3146w_shutdown,
 };
 module_mipi_dsi_driver(ltk050h3146w_driver);
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


