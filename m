Return-Path: <linux-kernel+bounces-168286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCF08BB62D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CABD1C21909
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C38E131184;
	Fri,  3 May 2024 21:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M3XiLvl/"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0215D57333
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772235; cv=none; b=MEqppiF72M7t+gwDhQr1gbjEp9sd81LsLQuzjWsXR9m31tFz55pL43DfwoloboWLsblDEtLFYn57/vsJ5mf0cEI+i/nK2Kbq9rckV/PFa8Mtl6C1OMebfq8jSQTP0wzXkzAbaH7Fye3+Xb6Er1WEtRes6z2Dx8nnxiS8bMds9nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772235; c=relaxed/simple;
	bh=SkP3AZxms+mqo4x1ENWm/qqAh/eG6ZxVE44b9/q+cLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCs+co+55XuaW2RJokzKQylTESzzAVG24cYnTOn8t/329ejaxCPrQrsA1SojHJCpwYvxDsDxS3vTiBHNdCO7XmxTRS8YV5y7FP0WSHmQS3LXvQp1cwrRjknAqkkG5g7lDZ5OmlfHEWhaDfxRZPfV5ioY7H28pI56ociUF1DBfOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M3XiLvl/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e3ca546d40so1026125ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772233; x=1715377033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTn5MbULQaeKHbflLx1nU+BRyKgxWcgq1caqQZJZ4uA=;
        b=M3XiLvl/+M7pTJZd2D/ykj4+Hkr+yyY26vBscOY5gEgEvsX3koNMQ1i7jDoY/y26l4
         vSVWXcb2HBfUL6ZFNcSvBCXhcWHq3vf+a9nX8arBkDNL0Po+aZbhwycXkkagAG1hSVdl
         if3W8VWjaDOkGJt/T/tLKWyWrAIXyvZnhyBmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772233; x=1715377033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTn5MbULQaeKHbflLx1nU+BRyKgxWcgq1caqQZJZ4uA=;
        b=WcNOMrc/KXvkBnXTe0oZC6KpIW3P78c/eMoDObbCt2eOk9eDMZijCx8C3bF4l9iqf7
         rqLQE9ORob9L9V+YzxoAs68mPVlhLHbVyYKvKsFNcNPVcWMQL8xwuHxmrJoY9Mxal9KN
         btLkTy8OcXLUAcNRQ/EPPQQwB5lnVJ96c+Q8IhRJX/YawYJIdSDwkYvgZqEcx5WpRYl1
         ipgfAzuBsxJgSrSlaGyxZ1EELtlTg6iiu/JgkeZvhE/TG2xMh7YcJDwwolgub1njRZHq
         wQlhnRIn3DA2dMVeCEjZnMIrcY6Xqs6L0QSwlgGysjsSSLQ4CKiH5nLuIyM/RajVDKT4
         XHlQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+W13MiTyQsVX5TO6c0k6HHjCscWd4DGq9FS2v1eVBLDDA3a3XF3w4C6f2+ysR3cepa40GGOWBl48JwjjnWSr9r2dVB995oFHjPR8K
X-Gm-Message-State: AOJu0YyWsb69ycboxeiZuLsOH6+QrKDFCm0GYc2hRzYtxfhflOLT1yBN
	K5oeyp0UvvmEndSM01A/A6QB+yisT8wMGQj9sRVrirkIYAPWIFFhusDevc4emw==
X-Google-Smtp-Source: AGHT+IEj6p7S/rBweU0qKixBlNVALPCuJKnvCSE6LujqLm3S0J98P3JUSBEGZTwGCVPY2YIYmiJT9w==
X-Received: by 2002:a17:902:da87:b0:1e2:1915:2479 with SMTP id j7-20020a170902da8700b001e219152479mr4889534plx.12.1714772233439;
        Fri, 03 May 2024 14:37:13 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:37:12 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Stefan Mavrodiev <stefan@olimex.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 21/48] drm/panel: olimex-lcd-olinuxino: Don't call unprepare+disable at remove
Date: Fri,  3 May 2024 14:33:02 -0700
Message-ID: <20240503143327.RFT.v2.21.I4c79deffb7551ecfb0378302f8dee1275fd1c060@changeid>
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

Cc: Stefan Mavrodiev <stefan@olimex.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c b/drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c
index 8a687d3ba236..94ae8c8270b8 100644
--- a/drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c
+++ b/drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c
@@ -251,9 +251,6 @@ static void lcd_olinuxino_remove(struct i2c_client *client)
 	struct lcd_olinuxino *panel = i2c_get_clientdata(client);
 
 	drm_panel_remove(&panel->panel);
-
-	drm_panel_disable(&panel->panel);
-	drm_panel_unprepare(&panel->panel);
 }
 
 static const struct of_device_id lcd_olinuxino_of_ids[] = {
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


