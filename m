Return-Path: <linux-kernel+bounces-93395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0DF872F2C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CDB81C217CA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7CE5BAFD;
	Wed,  6 Mar 2024 07:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g2zpbi4l"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EDF5B5D8
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 07:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709708534; cv=none; b=qiSOhuOJoY2kvR4ShSXnSd+uKqU6uXjFz7vtvYq2oTLU42yVRcOMf/oEv8cZDaP2au9EnwAt4lJv8cS4ndEfpOKMOVZqCNhyAkBsKHm/BCRNFJLUeSGVu0iDBEDPBxfg4P/rTix03HRRuwa7aUIW6AscIMlPg6Y9xk2/hrNvxN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709708534; c=relaxed/simple;
	bh=IaX/Uoi3bKDTtIJHwrhHQGkRlOrgQk0HnDxHsmjcBPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uaNJhEIzdn3Vfbh26bHV1/q439MH0lMtXbSRKaSf5EEpEte55bzClcU6XZ+B2qqTfHFqomNjebTiDaRt9nNA7SrO/5OI+wMaKZg6A5RdNcBPIm4GzZz5QAtfZraFkFrublpotCwRqtKAqpdhSDN8We97IzJ/I94NeReYntwsmvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=g2zpbi4l; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e617b39877so2830680b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 23:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709708532; x=1710313332; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VK485e0Io4FQkZBiTpzl/C3wrcGvcoGSSd6OtH3yQ7I=;
        b=g2zpbi4lOR+avt016dKanQwmvULPxIlPgHQIKGBX2+KOWS6qLb1LtAj+jexP1RHXOL
         JufeNNDShVuj0NgNLzM/PiM18gzHT49OZe6JmE2A+Cdpc4s4W7oCqWzBnXrJxYA0Hs5w
         pdjzn/2IzSDxdJptevOw1GbGT53VHraqQobrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709708532; x=1710313332;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VK485e0Io4FQkZBiTpzl/C3wrcGvcoGSSd6OtH3yQ7I=;
        b=fS5UVZTyB3OROZ8lZWpQ8SH4Fy0sYXDT1/RVEP44d8MQBx9W9JalqlQ+JsmK/Fr9M3
         izelOJfbKiqoOmzygpJfAQNzEZ8YpC5St6bgGJsd/WsDNus0o/QWj3fnZTtWRmL8wny9
         46cJbwtq3JRbgd5NanFdzRoFgWjARnSUeC6StnWrW+3QzGfdnHoOX4GyQ0VneUtcpZr1
         iGOCkYZQJRnIESX283Wq7i2Yqj9nwu5SaAMud37xTSaRyxnTsjmXf9B1FpJQ0w5zbICO
         BQnrHTtEUqM+xJ7SU1xgtd0IZbQUeqzViSKsIfjiXZCZsqmutwCGz9mtfushKBP3G1fV
         wPjw==
X-Forwarded-Encrypted: i=1; AJvYcCVw/6II1dZWcf+WBCBSBvimMKRd/ceBWERfIgRkFvJcZFVKXFlCQ2U6WQHoSMn4eVz0h3GAV2KLf0w/ncjR4q1YEsyW8btDOzqWsZxD
X-Gm-Message-State: AOJu0Yw1bEblHxHhiJiluzKY2kwOG51pQ+2AgMeVHnyr32t2T7WZrI/N
	P0gN7uWfHwpvgO+jrMXzEMZLTAGb8uitLvaZQ0l9Lr5Thev+fthIQhJ2/4o7Cw==
X-Google-Smtp-Source: AGHT+IFbWNFYlMqMc3R+n0gCpcHOYtxNikqGOqeuD3hgYH40fY8Xzs7SDFPWH+N4evPaxjDKsrCeVA==
X-Received: by 2002:a62:6203:0:b0:6e5:e7f5:856 with SMTP id w3-20020a626203000000b006e5e7f50856mr9491049pfb.19.1709708532552;
        Tue, 05 Mar 2024 23:02:12 -0800 (PST)
Received: from yuanhsinte1.c.googlers.com (36.157.124.34.bc.googleusercontent.com. [34.124.157.36])
        by smtp.gmail.com with ESMTPSA id ei24-20020a056a0080d800b006e57247f4e5sm10014654pfb.8.2024.03.05.23.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 23:02:12 -0800 (PST)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Wed, 06 Mar 2024 07:02:02 +0000
Subject: [PATCH v2] drm/bridge: anx7625: Update audio status while
 detecting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-anx7625-v2-1-7138e00b25bf@chromium.org>
X-B4-Tracking: v=1; b=H4sIAOkU6GUC/2XMSw7CIBSF4a00dyyGR0vVkfswHRC4lDtoMaCkp
 mHvYqcO/5OTb4eMiTDDrdshYaFMcW0hTx3YYNYZGbnWILnsueIDM+s2ajkwj0I7Za5OjQ7a+5n
 Q03ZIj6l1oPyK6XPARfzWf6MIJthFoVPWeqN7e7chxYXeyzmmGaZa6xe+fCEGoQAAAA==
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


