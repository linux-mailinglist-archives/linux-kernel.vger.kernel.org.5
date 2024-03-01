Return-Path: <linux-kernel+bounces-87946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 056D086DB5A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B33E1287914
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53CF52F6F;
	Fri,  1 Mar 2024 06:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="gm2QzpXq"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7667C2E407
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 06:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709273510; cv=none; b=Aic0sW8VCK6CnyB6yBJQGKDacdny4pQgnoUfQdAt9EpdUrsaCGI3rkkk8t3t7xYPeyQhwWAJ+NTFRWlIw9z/o35rA+0XsUK1934TPOQcsFRDreFQNlc0t7jbc6dfYKVETFBrIR7uwczzqFgeuvNOHlHEVeiYN9dAe1+pgawvQ1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709273510; c=relaxed/simple;
	bh=x5o68pxwUx6CqC7Sl7YKBE8/nlcIu+tEl4G+DHJyrJs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LHHG8K2Da3pAJulJ2BKu8e2oV8TvssjvK8vD9cm0fMH6E2ZlAvuOygV64rnJe7KlJzd+9mIg/jIQat7ugLTaRm2q2LEACPv4NUltsdEW3K6eJQAl/jWsSItOrtQMoERRINFRLaQFf/b6xkzhZa5dd2MLa9MgVFpf2gmVGab3JYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=gm2QzpXq; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29a6dcfdd30so1351847a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 22:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1709273508; x=1709878308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rr3q7FsdLCaRHkXKKCZsUMF6OYrj2cJelo1MSVgbjk0=;
        b=gm2QzpXqUZS1dL6jybLBHmAhFWlUZ7PZwuNt2fzYF3jZ9DurNqB78tbS8HpX9T3745
         si8CZVE+DlphammHrAxFg2M6eyFVQ2AbtjAfGk19Q2yRvOb8yf2JJk/f+K+Ml7E/SIS6
         8dcaXBlihsMp/OR9C9j7Si+SFDY3R/8cohfey3AFwytg395KLBU+xYIHBD28FPJc+56V
         rtoceRvkkAu9vjBWczBeHavUFxzvQ4fPSSEkdMbPQBAMxabMBGlSddeFADOMEh9/V5su
         nSrnGJhGoQ/seFZh0JpYe+hND7Oj7bQG13ruQKmOn7DL0TH7Ts3JTvkIfE8kQ4KpiRrw
         TBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709273508; x=1709878308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rr3q7FsdLCaRHkXKKCZsUMF6OYrj2cJelo1MSVgbjk0=;
        b=PMGsgiiCia6rF6deM/ygmXpM2RgD9RexC0Dl2TiymeW2KHvQYyTvQ7MMqdxSBTldJK
         2dr1LCqYg0g9CORQT8I053tNQ0I3ZIvTSxVZjeMZYmnAeo7wp8BkU/RswQH39Q0t0TT0
         pfvxBxzPFCmd+bTshmRYtAYEvrmfXUZlrpsVM2FZz0gyNo3ayVhPJ5LM9+c/C2y53jSG
         1wA+yW6OSWMQGlqr58dP5h1bvnFqrQOPNkiyr6jvfFusaU/2+WstHai5kPsPlp61mrop
         fvG4qLpzFlu5PUyTur93ab4ZUf9ZtAk21YUnpQ6WAwBMTmCU1GorlNStCAh1cvHGR5iZ
         4QJA==
X-Forwarded-Encrypted: i=1; AJvYcCV5mSz8inPsaiMjspHNbSFLUCh85JF6yTHgAUsq8Uh2T6cdHAuK+Ze4+kqvdHYTDmKnpAvzK47txRAlR6R85l/VB49PvVLApInULM32
X-Gm-Message-State: AOJu0YzeeqAWHE403rEoM/etTYUK7L/1/197gfJXY+deDk2UbHMnODwJ
	gb1pS/S0l9A0XHVAF5BazL5pnklkCylVRAdy6BQXTRTHCUCg797LiGK5ay/zAio=
X-Google-Smtp-Source: AGHT+IHauwRo1CPioT0EvuRk51QDIG/BoMYAzEg0M4YzOYJ0ErvD9wXy45DaO7v4Ou0TWGDQ6KMw9w==
X-Received: by 2002:a17:90a:fa98:b0:29a:8b5a:892a with SMTP id cu24-20020a17090afa9800b0029a8b5a892amr760942pjb.39.1709273507844;
        Thu, 29 Feb 2024 22:11:47 -0800 (PST)
Received: from localhost.localdomain ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id n7-20020a170903110700b001dc9893b03bsm2543965plh.272.2024.02.29.22.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 22:11:47 -0800 (PST)
From: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To: sam@ravnborg.org,
	neil.armstrong@linaro.org,
	daniel@ffwll.ch,
	dianders@chromium.org,
	hsinyi@chromium.org,
	swboyd@chromium.org,
	airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH] drm/panel: boe-tv101wum-nl6: Fine tune Himax83102-j02 panel HFP and HBP
Date: Fri,  1 Mar 2024 14:11:28 +0800
Message-Id: <20240301061128.3145982-1-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current measured frame rate is 59.95Hz, which does not meet the
requirements of touch-stylus and stylus cannot work normally. After
adjustment, the actual measurement is 60.001Hz. Now this panel looks
like it's only used by me on the MTK platform, so let's change this
set of parameters.

Fixes: cea7008190ad ("drm/panel: Fine tune Himax83102-j02 panel HFP and HBP")
Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index bc08814954f9..0ffe8f8c01de 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -1768,11 +1768,11 @@ static const struct panel_desc starry_qfh032011_53g_desc = {
 };
 
 static const struct drm_display_mode starry_himax83102_j02_default_mode = {
-	.clock = 162850,
+	.clock = 162680,
 	.hdisplay = 1200,
-	.hsync_start = 1200 + 50,
-	.hsync_end = 1200 + 50 + 20,
-	.htotal = 1200 + 50 + 20 + 50,
+	.hsync_start = 1200 + 60,
+	.hsync_end = 1200 + 60 + 20,
+	.htotal = 1200 + 60 + 20 + 40,
 	.vdisplay = 1920,
 	.vsync_start = 1920 + 116,
 	.vsync_end = 1920 + 116 + 8,
-- 
2.25.1


