Return-Path: <linux-kernel+bounces-168274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E69828BB61F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E8CB286639
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF3A12C53A;
	Fri,  3 May 2024 21:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MopmZgKD"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F8E1292D9
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772212; cv=none; b=hHnDqnEMIVQbUe71w8x2/P7Z0wE/xq4xMN9wKNcxeidoKyeowA6lKZnJBdyioKEacU7pbg/TgpiNS/ErqIJxENV2gBfEIfGIVtU3P5XTKH4tKZILL8Zbfa6SZ35RISFkCuZOh+e7xrghXy9sISp7DkNtSRCdS78Tom3E/p9ko5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772212; c=relaxed/simple;
	bh=jVDqOKx90k4h/+SwWWujMqQkYI4MUrhH4WSXfqMYo30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhV2KITB+5LuWqnExlestYsNo/GBs857pjWfXhHLPGBGuc4t3oR5YY99ZIcWaqzQ+1laeq5hHQ3qKObLwSftmjol7lvJz5GVy5uCGDQC2HYmcU1N3izJm5OIkAfUA70y7zcgezTctQHb3N2Q/saqt6rLD/JKGvIPi9bHdbFV45M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MopmZgKD; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ec92e355bfso1187005ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772211; x=1715377011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpAqyGRZ35mrxRmKBHfboZzq/mHfdewzPnwv0OdchAs=;
        b=MopmZgKDn51Oop8MoOAajyfXr//Bxc+7I1NqJEpkDzFVI5XjEQA/EW8TycmtRn/kSu
         LXKtTe/3MkUBroPvATeOh6SrIqOylNTOb4MqphsCTypfJp1GVIInTa+zkZByHV9lBzyQ
         Mv8qICNYaI1xKMKH1BZ77c9EWIeydoZqX1O/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772211; x=1715377011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xpAqyGRZ35mrxRmKBHfboZzq/mHfdewzPnwv0OdchAs=;
        b=KcbXaglinnM5jAwkuJT3sXieCHEwHO6GHW/VqF6ODCmgxRO59hnTbBn3T+8I6qIY4j
         2YkZCg8jT7QKncYoxskolNOlUbK/pId0RFeD4o+t0CqRHXzyr1yCsJCRw6R4LS/ITSfL
         oLnnQJRePTPrrJ+NAtMDLxFabWS+QVpiJZr+5WSiAF5oeMlJRWJTp1+PmO9XmW4hTTGf
         EKzoHuA2jyyHxCljEtA738wG5PFsKtvkaA+WuZRjllO/Y3kMunD+86VKdqnHBvm62X/U
         RYtERrAm40Gke4R1XQKaUuOzNotse5Wo1fuE7+7eQLctyeK0RzEUP8ilCpkwY+HIptOA
         LCFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBoQ1jpJ/6n0GLFwNsJ+fRPJ9ghjdjLXu/aFarLgYH30ik1u7sZhNUgc0iuhDZkOgfGs+Y0wGp5b2/qIbzDGSzx6NGmvFXnm8qOW7y
X-Gm-Message-State: AOJu0Yyhh+pkQd5XB3o/I3wQ8bdZ2eePrjZpTQCLNowXlMhQMOgfDUkR
	IKHJLsGNeI01jeteZijQZcPGT+5Js3x/fp0ihi/JqBJ0NYO166ksC+5F62GLvw==
X-Google-Smtp-Source: AGHT+IHPgak4KhT/VY1k6i6WU80Ppl8jX085UmJogG4vsMPYn1oTd7Du1ToJIYk6Efeso5tSI4Y1lg==
X-Received: by 2002:a17:902:ce87:b0:1e0:983c:d686 with SMTP id f7-20020a170902ce8700b001e0983cd686mr5162135plg.20.1714772210940;
        Fri, 03 May 2024 14:36:50 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:36:50 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Jacobe Zang <jacobe.zang@wesion.com>,
	Nicolas Belin <nbelin@baylibre.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 11/48] drm/panel: khadas-ts050: Don't call unprepare+disable at shutdown/remove
Date: Fri,  3 May 2024 14:32:52 -0700
Message-ID: <20240503143327.RFT.v2.11.I1ee65e7905bf5bf46a0e6c5126ac3c7aa25cb80b@changeid>
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

Cc: Jacobe Zang <jacobe.zang@wesion.com>
Cc: Nicolas Belin <nbelin@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-khadas-ts050.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-khadas-ts050.c b/drivers/gpu/drm/panel/panel-khadas-ts050.c
index e35762ebdbd1..14932cb3defc 100644
--- a/drivers/gpu/drm/panel/panel-khadas-ts050.c
+++ b/drivers/gpu/drm/panel/panel-khadas-ts050.c
@@ -880,16 +880,6 @@ static void khadas_ts050_panel_remove(struct mipi_dsi_device *dsi)
 		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", err);
 
 	drm_panel_remove(&khadas_ts050->base);
-	drm_panel_disable(&khadas_ts050->base);
-	drm_panel_unprepare(&khadas_ts050->base);
-}
-
-static void khadas_ts050_panel_shutdown(struct mipi_dsi_device *dsi)
-{
-	struct khadas_ts050_panel *khadas_ts050 = mipi_dsi_get_drvdata(dsi);
-
-	drm_panel_disable(&khadas_ts050->base);
-	drm_panel_unprepare(&khadas_ts050->base);
 }
 
 static struct mipi_dsi_driver khadas_ts050_panel_driver = {
@@ -899,7 +889,6 @@ static struct mipi_dsi_driver khadas_ts050_panel_driver = {
 	},
 	.probe = khadas_ts050_panel_probe,
 	.remove = khadas_ts050_panel_remove,
-	.shutdown = khadas_ts050_panel_shutdown,
 };
 module_mipi_dsi_driver(khadas_ts050_panel_driver);
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


