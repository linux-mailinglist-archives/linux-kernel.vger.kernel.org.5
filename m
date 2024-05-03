Return-Path: <linux-kernel+bounces-168283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8B98BB629
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43DC2281A82
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2B7131185;
	Fri,  3 May 2024 21:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y1Dj/Fdc"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9FE131184
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772232; cv=none; b=Vf6d4p4bobTChIEARUwOFn9P6XM1nqtjuFEcJoKlvPn9KcTZ1U579wdmtZCwyBlBeFGcwLQ0G+EkuwZSqWpva6ODUMGf5/Wzm/Fsg8FWdjL96VAcZTowUesfnuDPzclGi+2n9H87PapMZAtcKraaTVeRQ8inG7CcCzAv41NJFwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772232; c=relaxed/simple;
	bh=fBAyG8ZF/YZRA5320CSXCbxyFfF3cr2FGMyGleTMfpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXSRZPRh3k2Ev2nPq+nfuqRHZSxncM5iCyGc5z32HiYztPp8JbF3JVJElopWV/6PC6qBg5N3mRAGhiX/PKXXbMRWa+jh3x444ZBkFOD0u9Dl1qOnKf6505y8OwS0K+qsB22vuqFeMJqOlo+R10F9Hi3OTAfOiVYZNVUswZDUpew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Y1Dj/Fdc; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ed41eb3382so1029675ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772229; x=1715377029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCEzmsJkNVqJjLKEek1G559OvdmwxBqijlKTr/wX13A=;
        b=Y1Dj/Fdcrt28zdpemderW4vfG5nQpv7mSO1+ItxkOZ3HcvBsR6gXIuduHB5OARerfv
         PiXygsxbhrS/AHoAlSUKjgPq9WBr5RA0UdIgWSsOUIBurJQi+FtCoAJbE4aKFc5aljK4
         eUYjzpaMmbiXyg5Yoky7KdwNsRyCsRnUURfD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772229; x=1715377029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCEzmsJkNVqJjLKEek1G559OvdmwxBqijlKTr/wX13A=;
        b=oMEOucyma9O9seRpJlhGVzmlwdr7mcWxIuuukBqKtAam2ke9Pj4ppiwWWoGFSmSJBt
         mAKDJNoJ6g8fu4taVElRF77QxG/naN4NjRRtWdO7T9p4YtIh+avArGi4FGiaV4lb9yQp
         yzzaq/ABv0dv8XfBp+Zd8mFFuN4o+Fz6Tt9N/ZeCeR/K6mjLIzTD4ntXvY1GAzqsLQ6R
         0ANoz9qDMFzhwalMQ3IjeE6qzhXjGEgLyxheWf+tTTbzdQnqe8JZsMLTCmQ83NXkT8fV
         ZcQevV8FYEvecmeGlPCPNUquyHl1cr5PpJFnEvrAe6LvFCJMzcyYcnmsXkDFGxdhIBUm
         2SVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1Piu9I9m0er2t2DZ1vA4D/X0delcMiUmpYsJN+/WfLSiA7Wj7oxAzLSEFq+Qx8nx23r+q7yaw/dhEW65fj8B9zFMuqFECouXj3d5t
X-Gm-Message-State: AOJu0YzXcC22ETvFZsV/OZ1TcHNp+1hiOoLBK3SSbftbrDaJLHMkO6Wx
	5OQHk6kKrGtXfP1OQrtPLX05j76mztopzI/lwwyJZ/8W1CoeebMvolVaH1lqWQ==
X-Google-Smtp-Source: AGHT+IF/zJruBSwTUZM1XWyjeIBA3vGsxjzRfWQyTdUJXMgAkw1voDP5oQ1EzE0p/oXqEfQ5DM+Pdw==
X-Received: by 2002:a17:902:bb17:b0:1ec:7b0d:9eb9 with SMTP id im23-20020a170902bb1700b001ec7b0d9eb9mr3415331plb.64.1714772229039;
        Fri, 03 May 2024 14:37:09 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:37:08 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Benni Steini <bennisteinir@gmail.com>,
	Joel Selvaraj <jo@jsfamily.in>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 19/48] drm/panel: novatek-nt36672a: Don't call unprepare+disable at shutdown/remove
Date: Fri,  3 May 2024 14:33:00 -0700
Message-ID: <20240503143327.RFT.v2.19.I67819ba5513d4ef85f254a68b22a3402b4cdf30f@changeid>
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

Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Benni Steini <bennisteinir@gmail.com>
Cc: Joel Selvaraj <jo@jsfamily.in>
Cc: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-novatek-nt36672a.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
index 35aace79613a..c2abd20e0734 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
@@ -656,14 +656,6 @@ static void nt36672a_panel_remove(struct mipi_dsi_device *dsi)
 	struct nt36672a_panel *pinfo = mipi_dsi_get_drvdata(dsi);
 	int err;
 
-	err = drm_panel_unprepare(&pinfo->base);
-	if (err < 0)
-		dev_err(&dsi->dev, "failed to unprepare panel: %d\n", err);
-
-	err = drm_panel_disable(&pinfo->base);
-	if (err < 0)
-		dev_err(&dsi->dev, "failed to disable panel: %d\n", err);
-
 	err = mipi_dsi_detach(dsi);
 	if (err < 0)
 		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", err);
@@ -671,14 +663,6 @@ static void nt36672a_panel_remove(struct mipi_dsi_device *dsi)
 	drm_panel_remove(&pinfo->base);
 }
 
-static void nt36672a_panel_shutdown(struct mipi_dsi_device *dsi)
-{
-	struct nt36672a_panel *pinfo = mipi_dsi_get_drvdata(dsi);
-
-	drm_panel_disable(&pinfo->base);
-	drm_panel_unprepare(&pinfo->base);
-}
-
 static const struct of_device_id tianma_fhd_video_of_match[] = {
 	{ .compatible = "tianma,fhd-video", .data = &tianma_fhd_video_panel_desc },
 	{ },
@@ -692,7 +676,6 @@ static struct mipi_dsi_driver nt36672a_panel_driver = {
 	},
 	.probe = nt36672a_panel_probe,
 	.remove = nt36672a_panel_remove,
-	.shutdown = nt36672a_panel_shutdown,
 };
 module_mipi_dsi_driver(nt36672a_panel_driver);
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


