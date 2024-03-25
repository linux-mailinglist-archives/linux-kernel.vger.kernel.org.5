Return-Path: <linux-kernel+bounces-116618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CB588A140
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC60E1C38035
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B818274E0A;
	Mon, 25 Mar 2024 09:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CaBJfUbn"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A85574E3A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 07:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711351519; cv=none; b=jBSCFP1wThdZbFFns732cDx7tl/AJZor7j00/19fjjeiSAWYBC+6/z8tOagO7LvjzzwOKRPNDDKjH++B/p/51CglNF3aFIg45ic1lQBa6Qw5jzj22A0MUpE0zHjMh55s2Y/PjaKokJLdp1+DoIJ2jK/X0ypW/aguLzQcL/wiOlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711351519; c=relaxed/simple;
	bh=QfnYLsuBb+1its7JeTsyKZhLngkcliTLsAPLfZt0TRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XptvtJaEtJFh9sXwLTuHa/Vnl39E/oZ+iV7hPJ6jI7ai1nBrd3Bg1u7ofjlEPXzi80VXCW9ORD+VCvv/1t4YjAvlw1Vwyz4SJCxjOAu0gb+et7NhmoiYCfPed8KYoGA2TpwXit63Zj30hSRO3vvOyi9PxszMhNlGf4PA8vFwE9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CaBJfUbn; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e740fff1d8so2747543b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 00:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711351517; x=1711956317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X+MjbtDBOKGPD9jVghLidV+HqVDg672gc0v95BdsAEo=;
        b=CaBJfUbnRwvSvCDuw/9P1kBr/nrPqVy1JS7jyUmqC4raolhu9DZUr3IjHwSeJQehk1
         BEOIt+rxqCfe2MtP+TD5WWJbBW56TYdufl0RnrzZAWpttcgdEBRPHajQIUgBa6iZgkls
         Bv+xfq3CyyHKPwm4M3pWxM74kDB5rkp7myNF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711351517; x=1711956317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X+MjbtDBOKGPD9jVghLidV+HqVDg672gc0v95BdsAEo=;
        b=n9LOvveYgqvuwCJZoecK/AA67mJ64if4VqdAoRBH5FSFSheo+1S1j0gG0d/1QO2us2
         xQ04ufDSUFxCq5SAsulwNfryPSQSHr6OrYGe9UAO/pi+an2SJ8FxLi/aiRJdeG0NQive
         ijFmyBrmN2ZhUHzD1sL3P3ketXyhJqJtOSyB2MvpnnyXqCmG4CSMZnCIdfH7ryqlCQTo
         8mM5C8bERn3xsSfypB5NCkPpmaYOisUxeQg3KqIVFII5CpWKnZyBESYM75nRnt538dSp
         y4U0agNxd9PTl4TiIjQEbBVeU/+LHB5tcc6JKoYFhcBqFT0e79tHRf77aXwunf6GvSPl
         EMKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXF9gzRjuNhnoEf1pTjoqU+CY4IMvCY4fCbfx5vIO1snH1bG+7yBQZBssFseLlYbB0YlngbW7napt69gcKcOKyAggpAvKGZuOkHH/c8
X-Gm-Message-State: AOJu0Yx8ikHbkoo4Y50oOAiMU1ZRX7CRzJRy2P9NmyyIdubfta1+4oPv
	gNABWf8ur1qA4ooozWaFxmq5xQx10YwWYLtQ0CH6yNVcC6nDyJJk/ggega1a7A==
X-Google-Smtp-Source: AGHT+IHxupfZP61/dL8Pe/rmSqXGAZIOKra49157wwAJjtT1t+dgbt+8Az+2w4zZx+qc2GdM6EKybw==
X-Received: by 2002:a05:6a00:21d0:b0:6e6:d018:4a91 with SMTP id t16-20020a056a0021d000b006e6d0184a91mr6760277pfj.29.1711351516764;
        Mon, 25 Mar 2024 00:25:16 -0700 (PDT)
Received: from yuanhsinte1.c.googlers.com.com (36.157.124.34.bc.googleusercontent.com. [34.124.157.36])
        by smtp.gmail.com with ESMTPSA id w188-20020a6262c5000000b006e6c0080466sm3901148pfb.176.2024.03.25.00.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 00:25:16 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Xin Ji <xji@analogixsemi.com>
Cc: Hsin-Te Yuan <yuanhsinte@chromium.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v3] drm/bridge: anx7625: Update audio status while
 detecting
Date: Mon, 25 Mar 2024 07:24:21 +0000
Message-ID: <20240325-anx7625-v3-1-056a52f66791@chromium.org>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: quoted-printable

Previously, the audio status was not updated during detection, leading=0D
to a persistent audio despite hot plugging events. To resolve this=0D
issue, update the audio status during detection.=0D
=0D
Fixes: 566fef1226c1 ("drm/bridge: anx7625: add HDMI audio function")=0D
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>=0D
---=0D
Changes in v3:=0D
- Add Fixes tag.=0D
- Link to v2: https://lore.kernel.org/r/20240306-anx7625-v2-1-7138e00b25bf@=
chromium.org=0D
=0D
Changes in v2:=0D
- Add a space after the colons in the subject line.=0D
- Link to v1: https://lore.kernel.org/r/20240305-anx7625-v1-1-83ed3ccfa64c@=
chromium.org=0D
---=0D
 drivers/gpu/drm/bridge/analogix/anx7625.c | 9 ++++++++-=0D
 1 file changed, 8 insertions(+), 1 deletion(-)=0D
=0D
diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/br=
idge/analogix/anx7625.c=0D
index 29d91493b101a..9f0d0c5b8ebf5 100644=0D
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c=0D
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c=0D
@@ -2481,15 +2481,22 @@ static void anx7625_bridge_atomic_disable(struct dr=
m_bridge *bridge,=0D
 	mutex_unlock(&ctx->aux_lock);=0D
 }=0D
 =0D
+static void=0D
+anx7625_audio_update_connector_status(struct anx7625_data *ctx,=0D
+				      enum drm_connector_status status);=0D
+=0D
 static enum drm_connector_status=0D
 anx7625_bridge_detect(struct drm_bridge *bridge)=0D
 {=0D
 	struct anx7625_data *ctx =3D bridge_to_anx7625(bridge);=0D
 	struct device *dev =3D ctx->dev;=0D
+	enum drm_connector_status status;=0D
 =0D
 	DRM_DEV_DEBUG_DRIVER(dev, "drm bridge detect\n");=0D
 =0D
-	return anx7625_sink_detect(ctx);=0D
+	status =3D anx7625_sink_detect(ctx);=0D
+	anx7625_audio_update_connector_status(ctx, status);=0D
+	return status;=0D
 }=0D
 =0D
 static struct edid *anx7625_bridge_get_edid(struct drm_bridge *bridge,=0D
=0D
---=0D
base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72=0D
change-id: 20240305-anx7625-fe16d3a9d37d=0D
=0D
Best regards,=0D
-- =0D
Hsin-Te Yuan <yuanhsinte@chromium.org>=0D
=0D

