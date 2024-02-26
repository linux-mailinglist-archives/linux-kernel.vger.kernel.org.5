Return-Path: <linux-kernel+bounces-82332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BC28682EE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DB5128EF6B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36990131739;
	Mon, 26 Feb 2024 21:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="z/tTiTfH"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056CB1CA91
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 21:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708982491; cv=none; b=oL8OJNLoFvJLteAqRlY54m/VKHRMho1hthjW0dYexTm2h3D56XosqGoV3flScYoIlSzFOUlPHDARESoduD7FjomSloCuNsK6OMOFS3Z6qYR2N5Vrj9Qc2g4gDagcYGqJM7QP0DLEfvXpmLGxlOt871wUQ1FXAj0abkelARItfA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708982491; c=relaxed/simple;
	bh=w3le3Y2EYxbOx/Q57ccXOJbKsiJ/mZk+9wNEJ7K0FVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dywa7HbWlKX8psbFDqqqCay2KZcWDizFNG+HeeZn4DgyhO8aorPiKCZiRQDOie//14J57qrgJm6auzWWDqGgZ4EBu2lwcbWqud9NrJ71nPOzcaSDIT1oElqUadslNT6TYN2KrVsQgs4js6muTTIRjJ7wTnKbRSHslJzIYoDbAA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=z/tTiTfH; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708982488;
	bh=w3le3Y2EYxbOx/Q57ccXOJbKsiJ/mZk+9wNEJ7K0FVs=;
	h=From:Date:Subject:To:Cc:From;
	b=z/tTiTfH7Oqezmj3gH/H/IANV/MOcJi/Yb8EIZz2oCKQ/V1zOYo25xeuSIJdRoQ/9
	 Ij1kPRdJlaSvE+MAHqcAWNuCcGyeyzR9UbWD1+mHsiYLIfB22ZimzTkgl25ezmRR4z
	 4TD6dj6tlyigSvvH0DvCuTMNhu8wb3NzAXcgg7ZCOP/h0GV/8SAy4mgLc3HbpJ9FxM
	 z9T91Y6pf9tkV+garuHKcb9upsWSFizf7Yh8twiuEWmpZYRNNq1BmM97VHD8w5hexe
	 fEcdke5uee2IKciDk6kWMTNgTYr77qRWlUY3c0R4r4cJhF+As/9Hc0bC/cIc2+BdIz
	 XPV0d/b5rDTxQ==
Received: from [192.168.1.151] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 53229378111A;
	Mon, 26 Feb 2024 21:21:25 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Mon, 26 Feb 2024 16:20:58 -0500
Subject: [PATCH] drm/bridge: anx7625: Don't log an error when DSI host
 can't be found
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240226-anx7625-defer-log-no-dsi-host-v1-1-242b1af31884@collabora.com>
X-B4-Tracking: v=1; b=H4sIALkA3WUC/x3MwQqDMAwA0F+RnBfQ6NTtV2QHTVMNjHY0Mgriv
 1s8vss7wCSpGLyrA5L81TSGguZRAW9zWAXVFQPV1NVEPc4hDz090YmXhN+4YojoTHGLtiO3/sW
 88ELjAOX4JfGa73/6nOcFC4XP6G8AAAA=
To: Robert Foss <rfoss@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 owen <qwt9588@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@kernel.org>, 
 kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.13.0

Given that failing to find a DSI host causes the driver to defer probe,
make use of dev_err_probe() to log the reason. This makes the defer
probe reason available and avoids alerting userspace about something
that is not necessarily an error.

Fixes: 269332997a16 ("drm/bridge: anx7625: Return -EPROBE_DEFER if the dsi host was not found")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 29d91493b101..4ee5614a2623 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -2076,10 +2076,8 @@ static int anx7625_setup_dsi_device(struct anx7625_data *ctx)
 	};
 
 	host = of_find_mipi_dsi_host_by_node(ctx->pdata.mipi_host_node);
-	if (!host) {
-		DRM_DEV_ERROR(dev, "fail to find dsi host.\n");
-		return -EPROBE_DEFER;
-	}
+	if (!host)
+		return dev_err_probe(dev, -EPROBE_DEFER, "fail to find dsi host.\n");
 
 	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
 	if (IS_ERR(dsi)) {

---
base-commit: 2ae0a045e6814c8c1d676d6153c605a65746aa29
change-id: 20240226-anx7625-defer-log-no-dsi-host-c3f9ccbcb287

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


