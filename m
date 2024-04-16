Return-Path: <linux-kernel+bounces-146415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DC28A64F3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6037283ABF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B6F7F486;
	Tue, 16 Apr 2024 07:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S4ACNGQG"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E007C3BBD5
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 07:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713252102; cv=none; b=npbEfzoea1UDWvMV3VlAthJGa/3sYnF92ZYuV5MDH4wRYDq/LdF1mBGCFj4lok1BtsK/1tbaNwo7W3cSgc+ehqP46+qRJMhfEyHQ0MQAWw4J5QZfhH8djUz57DZC/vYBsR88O2G7lCxQmGy/aLNECuWVmcivdNi074H6j/ci444=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713252102; c=relaxed/simple;
	bh=SLCPj/7F2BL7ZTrop3RmKKifmAw4+m++fdAnYSbkqjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iQMLfa6GvTaSjwu3CtYhscpol4A2dm3fQMQjz+HX4qvx+QpbniQFiJGwY7JXDPDTjfp0GW2BgXck5EJYyPJuxoAzXtel2hogCAL7yW/e0DlX+bPzk8YAMQzaPQUj+Tl3pDFGYnBh7uucFBAhIsYItt9p8HFpWxcXa59/l0vlkmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S4ACNGQG; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ed01c63657so3633741b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 00:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713252100; x=1713856900; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KfZXB2BpFfIoHxhagie2lEibr4RlvT9R7XTtuJHOq8g=;
        b=S4ACNGQGdxcSbMvny3VTIvmT2XWmaGCM52OqjpcAfPNtihycQOUV7Cn31t3opODFhS
         7TegWWnP2NVy26tYouY+a36uerSkYCy0UJHXqubGmlHzEO2feuIXY0m6m5Os4VtLjWHB
         GwZZrojpoIU4PPv+/ORpae4xdDlVNHABz49Og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713252100; x=1713856900;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KfZXB2BpFfIoHxhagie2lEibr4RlvT9R7XTtuJHOq8g=;
        b=HF7T4BLWzxFNemkowzPCvWSurlnJLoBqQ/V3MhjcvY+fxCK/ccs9YyRMbeY2MX2G4D
         R9q5OR4ZQ1C0HfpVE23ntaGDtVGM2z5YTSdukzTkdmmbymemvVeRrRIgcmbJwxghfW3M
         2klo3UvII0ZkqyzZccmSBvSSzGih0Rg6qkxmktO/AOO5H+HrBV/H49fnYwCUKioLfaqA
         ANiYsGBo/Zulx0bhbloB4pMjshYDA7FKnq9HlTGINAs3YMqKT2hdaZzOCtsDhGtK/fWb
         iyxc7H38bJ02/OFYLWChGl98hml/x3yGMBXGvz3bQQYxSuht4RCeX2Jt8pbZVxJKeokM
         FbPg==
X-Forwarded-Encrypted: i=1; AJvYcCWxReDtfoPHFNVlqv5Ba2BQt6hJ6k2J3jDIOXph47TKc7EosJxvNGs9pqkqNpY99qL9Aptn1VIBgLf1pJd9kVJqMPuUi6sUK6vOQGOD
X-Gm-Message-State: AOJu0YzMF4wp1UF34KV2pEOMU4D9KGbh0zmHfbEcsYeKbSMd8mttNTSK
	k8MZABDv08iejdEjqtuuiVjO+1LXTDYc/uKylZ/WJH3y+CSqCfde4WNepiJDcQ==
X-Google-Smtp-Source: AGHT+IE7afWFhGfCo8YNIeMgjqQi06GV4Qk3C+gWZbRMgAZZl4K/rVD0mwLMuSGHZpf8I9hBZPpmJg==
X-Received: by 2002:a05:6a20:2d08:b0:1a9:ab88:f938 with SMTP id g8-20020a056a202d0800b001a9ab88f938mr10966169pzl.19.1713252100098;
        Tue, 16 Apr 2024 00:21:40 -0700 (PDT)
Received: from yuanhsinte1.c.googlers.com (88.216.124.34.bc.googleusercontent.com. [34.124.216.88])
        by smtp.gmail.com with ESMTPSA id j4-20020a056a00234400b006ead47a65d1sm8323679pfj.109.2024.04.16.00.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 00:21:39 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Tue, 16 Apr 2024 07:21:35 +0000
Subject: [PATCH RESEND v3] drm/bridge: anx7625: Update audio status while
 detecting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-anx7625-v3-1-f916ae31bdd7@chromium.org>
X-B4-Tracking: v=1; b=H4sIAP4mHmYC/3XNPQ+CMBAG4L9COlvT9qCgk4OsDjoah9IP6ACYV
 hsM4b/bdNH4Mb5397w3I6+d1R5tsxk5Hay34xADrDIkOzG0GlsVM2KE5QRIgcUwlZwV2GjKFYi
 NglKheH112tgpNZ3RsT7Vhz26xHln/W10j/Qg0LT96goUU1yBViClETyXO9m5sbf3fj26NtUE9
 k75i7JISwqVJqRhRWN+UPhDIdINgZxxaEwB5IMuy/IE9nwxMh8BAAA=
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Xin Ji <xji@analogixsemi.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.12.4

Previously, the audio status was not updated during detection, leading
to a persistent audio despite hot plugging events. To resolve this
issue, update the audio status during detection.

Fixes: 566fef1226c1 ("drm/bridge: anx7625: add HDMI audio function")
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---


Change-Id: I0b36c27d426b2988886db98452700cb7227d868c
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


