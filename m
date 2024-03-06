Return-Path: <linux-kernel+bounces-93687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B10873348
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA91C286B3C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289275EE8E;
	Wed,  6 Mar 2024 09:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BxlAkUm0"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C085C5E9
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 09:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709719161; cv=none; b=RuGi+KGdErvfQLnkMkNDtspXVO4VdWVZnrFz3tVUhkeHpM/avT/8oOORg1Pahj/oojbpTMstTKG5GbwZc4lIfVIfgaf5/ufyRIgOZ8e9qUvmuXYdelZHJs8/lYpsFM3SbNLTV92zbrlzye2TFzd7bifsZZ7AHzhxrb++umqOcA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709719161; c=relaxed/simple;
	bh=B7TTacxP6pMGI9INNttDrL/5uYTC3GlvlL/E/TkMdR4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iT3rOxnRj9nuyyhXOk2Jxr7XcFETMjnG9+Ai2yPR66iWr9OLMAkW3B1u9+205xn9kDqWujr1RCkPRhc/N3evH2bHV8x1X9ABQP0f1qRk6vKhLt3vGMr3GeKxl5HPgUMGHxXWLQOpYuPU4+IGM6zROJob9rUH9GP8Hyylj5YPQUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BxlAkUm0; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5a19de33898so7111eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 01:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709719159; x=1710323959; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=amo+IB69F59PemLpSax75yoEEsP5uNKr7goammFkeSQ=;
        b=BxlAkUm0i2Os40Qr4I9FZTRUwnqz+/8SaLxn6KL5Unpkr30mxvVNmewtOY2NIvnP+n
         kAHGpQBdMYLsNFmqGmFKuFHuSr69PJI9NNkyD+uC6jp3qkq7YsayPgkRtut5ibyhHwAP
         lqT7AVKknndv6jS11PQqrrabcVFNywOfj8H3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709719159; x=1710323959;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=amo+IB69F59PemLpSax75yoEEsP5uNKr7goammFkeSQ=;
        b=gFJisJPQ2Z+NRMKscLHT9qFU7INz9r6pGom9E4XeEBlDsUHxzz49vPA61jpHzwbSDc
         h7a8o4F/fTiCiMcEQFT/y748Wpy0h6UO1TFqzZAuKo0gvoTNrtwEwpJ6UNNOKWqzwyae
         BcG0TDBCWMj0FhWMgY3I8BC6Z88Grv6osUThq5Toh82NZq/tEQNi5tZfYN4wbF5pjFce
         BjsIiKXExyq1LMUGlk2+PAaS0cty9N9Mjy52pjyJxMwazl6YndvbNRP55RbBtkS1mo/Q
         zgT9kQy2yjRygW/f3ORKaiVTHExiXgnnSuzyf/rvTDt4qUoJF5x80fBNsXVh+W9JKSmS
         ptQA==
X-Forwarded-Encrypted: i=1; AJvYcCXxhz/rRYmk7NjQdoqk0Kz71Y6goU84lclJWGRUUFnT1uKt1ukUM9D4fbwRM2XlrcMenSc1jkh1ONpZWg56qdY7+Xad1mixQPY/LmPg
X-Gm-Message-State: AOJu0YyOEEkHVGkR8lM27n53NO93Dedmo1n2cLPCcIfU7HpqHiEWHtKR
	U3geH+jmxclYgH6Uq8zubFnREg3+ZL9bP/mBQZokPGPWPN6itB+Pgt6NiGcZ4w==
X-Google-Smtp-Source: AGHT+IGH3rZ4T25qUkA+cDcFog01f0dyjlG7LgO4XHMFQChVX0e9m0kWX4fa7DjerS1PYX4VYALCoA==
X-Received: by 2002:a05:6358:70f:b0:17b:5c81:839e with SMTP id e15-20020a056358070f00b0017b5c81839emr5343895rwj.7.1709719158860;
        Wed, 06 Mar 2024 01:59:18 -0800 (PST)
Received: from yuanhsinte1.c.googlers.com (36.157.124.34.bc.googleusercontent.com. [34.124.157.36])
        by smtp.gmail.com with ESMTPSA id p8-20020a63e648000000b005d68962e1a7sm10643000pgj.24.2024.03.06.01.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 01:59:18 -0800 (PST)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Wed, 06 Mar 2024 09:59:05 +0000
Subject: [PATCH v3] drm/bridge: anx7625: Update audio status while
 detecting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-anx7625-v3-1-9034263bf530@chromium.org>
X-B4-Tracking: v=1; b=H4sIAGg+6GUC/2WMyw6CMBQFf4V0bU0ftKAr/8O4KO0t3AXUtNpgC
 P9uYaPR5ZycmYUkiAiJnKuFRMiYMEwF5KEidjBTDxRdYSKYqJlkipppbrRQ1APXTpqTk40j5X2
 P4HHeS9db4QHTI8TXHs58W/8bmVNOWwlOWuuNru3FDjGM+ByPIfZky2TxreqPKoracNkCY51Qn
 f9R13V9AxwPhDncAAAA
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.12.4

Previously, the audio status was not updated during detection, leading
to a persistent audio despite hot plugging events. To resolve this
issue, update the audio status during detection.

Fixes: 566fef1226c1 ("drm/bridge: anx7625: add HDMI audio function")
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
Changes in v3:
- Add Fixes tag. 
- Link to v2: https://lore.kernel.org/r/20240306-anx7625-v2-1-7138e00b25bf@chromium.org

Changes in v2:
- Add a space after the colons in the subject line.
- Link to v1: https://lore.kernel.org/r/20240305-anx7625-v1-1-83ed3ccfa64c@chromium.org
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 29d91493b101a..9f0d0c5b8ebf5 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -2481,15 +2481,22 @@ static void anx7625_bridge_atomic_disable(struct drm_bridge *bridge,
 	mutex_unlock(&ctx->aux_lock);
 }
 
+static void
+anx7625_audio_update_connector_status(struct anx7625_data *ctx,
+				      enum drm_connector_status status);
+
 static enum drm_connector_status
 anx7625_bridge_detect(struct drm_bridge *bridge)
 {
 	struct anx7625_data *ctx = bridge_to_anx7625(bridge);
 	struct device *dev = ctx->dev;
+	enum drm_connector_status status;
 
 	DRM_DEV_DEBUG_DRIVER(dev, "drm bridge detect\n");
 
-	return anx7625_sink_detect(ctx);
+	status = anx7625_sink_detect(ctx);
+	anx7625_audio_update_connector_status(ctx, status);
+	return status;
 }
 
 static struct edid *anx7625_bridge_get_edid(struct drm_bridge *bridge,

---
base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
change-id: 20240305-anx7625-fe16d3a9d37d

Best regards,
-- 
Hsin-Te Yuan <yuanhsinte@chromium.org>


