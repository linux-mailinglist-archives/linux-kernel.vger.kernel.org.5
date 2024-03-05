Return-Path: <linux-kernel+bounces-92273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A36EC871DBD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50DC81F29B42
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343375A4D3;
	Tue,  5 Mar 2024 11:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kMzrVlij"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E01758211
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 11:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709638056; cv=none; b=OSVd1L+9wuX/a9/Ti3/CaowMaJDii4CeF2hn43+JDKgZdArhRW5zrOTEjGjJPJkfrihdOzQfP36wgO9/4ACY5lSqdDNqYdwutuivIdgWrbgRlOLZmJFNQk7ftRy0gsnlRnorIvZoFVgaZ7OZNdGkRcIRy34/dujdcif8AKkqaWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709638056; c=relaxed/simple;
	bh=2WNnHztTUqQdcN20V9bA8+EOJpwgYApihwe/DDOcQus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ofL69WY9QylLVaW3fy0wmAFlbVxFPDHpVa+WGKmb4lQQfL69flZu7+HWPPmDlD1oULmeugps01ZDZOA5za2WWxiB4MPuXSiuB821mY0pNeFF8Yur+z4MlZ/knPgeFvdZVwG0Dg50FYAiZPZqEpxcgh08vBJRXx2iKYDT5xhKi+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kMzrVlij; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dbae7b8ff2so25779355ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 03:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709638054; x=1710242854; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S6lk2VSf0du4ELFj1o53K00Oxr2xrvdHE8vh0vkwTlg=;
        b=kMzrVlij1We+pFIw0M4/sKXtVppfpVCMzAvHPBo6pW4aiRmSTXsz3hNEDRYvf4QT7/
         S5q2IY4WVfop3XnT5BEGoDB4BPEPvUIgcXJOHVk03eNETFCeeCQhgySj2QLY3A3cZ4zg
         PCGvFSY+fZrx9xqj9U2MZVp2dfn89+sXQcJDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709638054; x=1710242854;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S6lk2VSf0du4ELFj1o53K00Oxr2xrvdHE8vh0vkwTlg=;
        b=haZDGhdVYAOUsXryD8JqpHNjqLAKaqFL0JWP4FkKlGXxyX5bjZtwG8KHjRgjfnDtqS
         xHcZ3fgov2wQkYjJZOYEwFwa9L1G7MlHbqgJoU08ZHxwQcheIXfuRIQjyuaRXPnBcIpZ
         24HcmMVjb4S1eDPPlRrJ30djRNtkEgFlfyA4w9bz+UpslX22PRkpJoBWu3W2b/0VXzzC
         5r/uw1eZaqYLg+3MoqoIEOl0rgvADyeVfc5VXeVIWWbpmsKMGbyV5C3Q/uXnPn5GZGAW
         gehPVRc8QVVyBxVLlhitDF4mcVu3Wn7ww6ZwzxJycuswpFRLETTtSaM8Hn9sHddH/ROq
         Vl7w==
X-Forwarded-Encrypted: i=1; AJvYcCVOSzLu7I/+DuUuyC929z+DJk2kCwOHYwcBj81Lfm3Nacy897tPW2Y7uCHUzME3uVGDfprMa2wwXbNASsF8rqQMQasO4ZzxrI+xbrCP
X-Gm-Message-State: AOJu0YzcBXed/wkRetPf6GpSqsuZeEKYnx/0iN8ngWR/WlHZpGMMkoZm
	CKzzUuim1jiJtcwxYOUNDXanEU/W/di9zaxfgtQyXZq0UVVWfyPGSyHB3VHWEw==
X-Google-Smtp-Source: AGHT+IF+WI48qE7GkIClJ44xeG82/z0EBNUVoILGmHKbKaq3pKcJ4kmhGj+wfJpEJ6EhEvErdgTBoA==
X-Received: by 2002:a17:902:e88b:b0:1db:d811:732a with SMTP id w11-20020a170902e88b00b001dbd811732amr1481426plg.37.1709638054295;
        Tue, 05 Mar 2024 03:27:34 -0800 (PST)
Received: from yuanhsinte1.c.googlers.com (36.157.124.34.bc.googleusercontent.com. [34.124.157.36])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902d48500b001db9cb62f7bsm10344720plg.153.2024.03.05.03.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 03:27:33 -0800 (PST)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Tue, 05 Mar 2024 11:27:26 +0000
Subject: [PATCH] drm/bridge:anx7625:Update audio status while detecting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-anx7625-v1-1-83ed3ccfa64c@chromium.org>
X-B4-Tracking: v=1; b=H4sIAJ0B52UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYwNT3cS8CnMzI1PdtFRDsxTjRMsUY/MUJaDqgqLUtMwKsEnRsbW1AGE
 vZz5ZAAAA
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

Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
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


