Return-Path: <linux-kernel+bounces-84308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B5986A4CB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EBA6B24EC2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93ADA1BC27;
	Wed, 28 Feb 2024 01:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JdYfd3We"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DFE524A
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 01:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709082702; cv=none; b=b7ZnDVgMn9B1djPLwXEEsQ/TB2hd9X3oGfGLzKH5Wz7ttrgXcBMkbv0zvlRyUDX+ol46n+7ADwenuGPbDe0jwK9eHWuCL68ksQDVjmzaYUOoK05YoPR4ehpfgW26KB+dv8wWe5yXdRJsU045UaECDync67qkKowKREPEkZN1rJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709082702; c=relaxed/simple;
	bh=vZThvoMpdMVB0bR3QX6Z7AfXdGCXxCbTtC+Qsih/PaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5xRfhp3rcCHtWU5p+cx6q3652hutRzi7P43BXUoQXdVyLK8LGDsdu7BDGB9JXKXMku6CpL916YiNZa5Qx8dBzMxuF1SJ7y3HGouDECugofUgQW1keF25qwLiZM+1zChFk+us4oAWW1Xl+rBEqisddf+40O0l7wnJ5l2jtXT7eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JdYfd3We; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dbae7b8ff2so26218855ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709082701; x=1709687501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUDXeYcrvidwDBcA1WOXXMMQ4eSI9QRabZdiDLCy8AY=;
        b=JdYfd3WeVZxkIyt+ITeBN+60LEyPfRqjNA6y+gtQ/NmTNn1Vb4uyKs1tfAnhQ0PA6T
         0nxXdvhGA5JJTs/zJDsSHz/b1DGpEx/kaQdiPxbOkHJzKyn5z8c3rVQVDS0GTs05BFSE
         jsgibS45mE5otCPzWR8uVDipvHuIk6QByW+5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709082701; x=1709687501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUDXeYcrvidwDBcA1WOXXMMQ4eSI9QRabZdiDLCy8AY=;
        b=pq25gqSEMS9ShSxKeZzf6FmRHitwn7MMyMsWNjAIC1bWLxIfCMIPj55Cf0R2n917tk
         xYYlvUnBGowDy3MsKKkgtb41pCmI5iaVvJGr9WU0/cSsKJHOaGUA/tPya3feAIfw8QpI
         sgLZ9fQSGqg/EEa5FuMDxYcQbFX+cjlTqQCu286h9p6XuQKQWyCe0HXcWp3xdeDVNS7K
         2ldEqdS5CbNXMYZT7fWdZrwOQIjfUlEnX11amXEEMUsWeuFWe8MUUT4dK37a6e85/rgy
         K3wuco0R2R7HSZe4jFrLKMEzwfQZ0Zb9UOC4inis40wV0VEOKe7Hs2kr8BuSr35ZA3PL
         M9mw==
X-Forwarded-Encrypted: i=1; AJvYcCVy3gSHsBOTVyilDw5eCToDQA06nPCDr9nTCUpZH9uVzktN1MXJN3ZIlj/rXWetRWeH0StkkVFvcuigJAVAwqa4bxJ8z3QoDrxU1FHc
X-Gm-Message-State: AOJu0YxOMY8WQ8LV2C7A0th6r+qAYTKYSPuSWSb4Zs8pkQuTiMeJ9v9R
	ykHfdot9znLvmu+bIUZ4p9ZxpTdOX4cM+yAgz/1fBelSEiIOxJJVyLCTLcsy0A==
X-Google-Smtp-Source: AGHT+IE0Z6fIVeriFN1uMUOqrW9/ukSipbQ+YPExtZ1nyKsCKZYK1PuQscgD1Vwgs+5BAfFvhvuBsg==
X-Received: by 2002:a17:903:985:b0:1db:c6ff:6648 with SMTP id mb5-20020a170903098500b001dbc6ff6648mr13245620plb.10.1709082700718;
        Tue, 27 Feb 2024 17:11:40 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:87d1:e95d:b670:4783])
        by smtp.gmail.com with ESMTPSA id kl14-20020a170903074e00b001db4b3769f6sm2131529plb.280.2024.02.27.17.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 17:11:40 -0800 (PST)
From: Hsin-Yi Wang <hsinyi@chromium.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] drm/panel: panel-edp: Fix AUO 0x405c panel naming and add a variant
Date: Tue, 27 Feb 2024 17:06:00 -0800
Message-ID: <20240228011133.1238439-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
In-Reply-To: <20240228011133.1238439-1-hsinyi@chromium.org>
References: <20240228011133.1238439-1-hsinyi@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are 2 different AUO panels using the same panel id. One of the
variants requires using overridden modes to resolve glitching issue as
described in commit 70e0d5550f5c ("drm/panel-edp: Add auo_b116xa3_mode").
Other variants should use the modes parsed from EDID.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
v2: new
---
 drivers/gpu/drm/panel/panel-edp.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 72ad552bff24..e39af92342e8 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1013,6 +1013,19 @@ static const struct panel_desc auo_b101ean01 = {
 	},
 };
 
+static const struct drm_display_mode auo_b116xa3_mode = {
+	.clock = 70589,
+	.hdisplay = 1366,
+	.hsync_start = 1366 + 40,
+	.hsync_end = 1366 + 40 + 40,
+	.htotal = 1366 + 40 + 40 + 32,
+	.vdisplay = 768,
+	.vsync_start = 768 + 10,
+	.vsync_end = 768 + 10 + 12,
+	.vtotal = 768 + 10 + 12 + 6,
+	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
+};
+
 static const struct drm_display_mode auo_b116xak01_mode = {
 	.clock = 69300,
 	.hdisplay = 1366,
@@ -1990,7 +2003,9 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x239b, &delay_200_500_e50, "B116XAN06.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x255c, &delay_200_500_e50, "B116XTN02.5"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x403d, &delay_200_500_e50, "B140HAN04.0"),
-	EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAK01.0"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAN04.0 "),
+	EDP_PANEL_ENTRY2('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAK01.0 ",
+			 &auo_b116xa3_mode),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x435c, &delay_200_500_e50, "Unknown"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x582d, &delay_200_500_e50, "B133UAN01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x615c, &delay_200_500_e50, "B116XAN06.1"),
-- 
2.44.0.rc1.240.g4c46232300-goog


