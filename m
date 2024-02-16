Return-Path: <linux-kernel+bounces-69300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDD28586C1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FC821C21596
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D9F12C544;
	Fri, 16 Feb 2024 20:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J2Z2o63U"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0249D1E536
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 20:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115485; cv=none; b=cp67WWEjpsRJgpqeFVB4EFZl+terwhBdGOaQF8rn2arxRZe5IfFnDwLXQZlX/2bF1GuANoxm/RMasXA0ZQlMpcIvPjtw2Gad6xlBXYXNmoUMqxBcQ0KUcHGYgN55/1A6RnaKP790FbF3LP0TXEF+3QfleqcBLI+OlB/6niNM3JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115485; c=relaxed/simple;
	bh=KD/xMlLiNQXo7Q4Kn2WpaaF0KgyaBB77SUJTldTsqws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nnOVkTxQsTj2an7nNHOC8TfRHaqdEP/SxBCUXMxI+MengVb6+p4OyB8Cf7tNpQIUOLQF2JpXWMOty6nxpHykS8+joExBqlmzYLzkxEXmdMyFHvfG5PjcQp4h0PUk6XI1QiF4VS8NP362MeL1F3+8SCZLMp8lbds45ZKpVF8clwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=J2Z2o63U; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d51ba18e1bso25786265ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 12:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708115483; x=1708720283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t1QGMxYLAPKWTt9tAmquOnzICTheF4ZELz33st39yQM=;
        b=J2Z2o63US/5iqJTwJGH0k5PnrmBpu5ZWbOwTZN+SrwhBsMTL1mw3ETFts1+Nhy4Xli
         KWpFyxKyNdhL87LGpy3MqnMp9CfW0YbUVZqZ8M0wh+CaqnuVKcSQm4k6Ogpy7yMNrEy9
         4IxT+PczUBhjQ4Zf24OPy/UogEH66mH8KBiUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708115483; x=1708720283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t1QGMxYLAPKWTt9tAmquOnzICTheF4ZELz33st39yQM=;
        b=q5xxk/JMMdl7lRaliCBE7YfAUMzf3OKKQhfcFydyWkBglHjw75BRq/4kmdDwZrsbuY
         o3fbvCFcyBALv3iZx0gnhEtprS9C3KHpBvBtSUTAAjoL5RtF6dn7wNKpm9mwy3N95SsW
         7oWmOqM0GgTv1RMKDI7GjSkUH+7Pf2IPnMHI42jWznqRGLSNgwCSUgvXwbk56OzOhMw/
         wO0y+H3CK2UEluil15J+LE1uEP2u51MvXTl1aj7T2Jd8eqJged2if0L7h2gUpF4wxEY4
         ECim4EL287CRD0uGT3xJ7XyBra6nHxPOeH9de2BiheqluLYNBsXLSzhwBBL0uphoT6Ws
         HAww==
X-Forwarded-Encrypted: i=1; AJvYcCV8ZX1vZars4TU13edqLw1VipjPLkLlCLIwCYDgaIALvpFwo3sDQ7ESVLthymFNqhu7+k7rT3HhSd3BfwwSzE7qmh+XWgSjHFvAhd5Q
X-Gm-Message-State: AOJu0YxLlKt/w6utGO5sPIBcr5H4tlsh6te52CkkZzlhCt7UL0gbM83G
	0AMePbpVVT7GtnaeeMjPQRlbKCraN9yyaQFvNqrcWzyyj6ac2PcQhLvpcOsOkg==
X-Google-Smtp-Source: AGHT+IGUbn1iYkQLFfxLEFg8HdmzNiQ64QZ+0XQ0PfIFQHFg5DYWMKahwJDc3Zqky4rFFvT6nDE9PQ==
X-Received: by 2002:a17:902:d486:b0:1db:b36c:7165 with SMTP id c6-20020a170902d48600b001dbb36c7165mr2073885plg.14.1708115483260;
        Fri, 16 Feb 2024 12:31:23 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:b6bd:4419:377:da7a])
        by smtp.gmail.com with ESMTPSA id f19-20020a170902e99300b001d944b3c5f1sm256966plb.178.2024.02.16.12.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 12:31:22 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org
Cc: Stephen Boyd <swboyd@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel: boe-tv101wum-nl6: make use of prepare_prev_first
Date: Fri, 16 Feb 2024 12:31:12 -0800
Message-ID: <20240216123111.1.I71c103720909790e1ec5a3f5bd96b18ab7b596fa@changeid>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The panel on sc7180-trogdor-wormdingler and
sc7180-trogdor-quackingstick hasn't been coming up since commit
9e15123eca79 ("drm/msm/dsi: Stop unconditionally powering up DSI hosts
at modeset"). Let's add "prepare_prev_first" as has been done for many
other DSI panels.

Fixes: 9e15123eca79 ("drm/msm/dsi: Stop unconditionally powering up DSI hosts at modeset")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This of course gets into debates about getting a nicer solution that
doesn't involve adding "prepare_prev_first" to every DSI panel out
there, maybe building on Dmitry's work [1]. While it would be nice if
we could get there, getting this landed is easy to backport to stable
trees and gets the panel working again.

[1] https://lore.kernel.org/r/20231016165355.1327217-4-dmitry.baryshkov@linaro.org

 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index c4c0f08e9202..bc08814954f9 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -1871,6 +1871,8 @@ static int boe_panel_add(struct boe_panel *boe)
 
 	gpiod_set_value(boe->enable_gpio, 0);
 
+	boe->base.prepare_prev_first = true;
+
 	drm_panel_init(&boe->base, dev, &boe_panel_funcs,
 		       DRM_MODE_CONNECTOR_DSI);
 	err = of_drm_get_panel_orientation(dev->of_node, &boe->orientation);
-- 
2.44.0.rc0.258.g7320e95886-goog


