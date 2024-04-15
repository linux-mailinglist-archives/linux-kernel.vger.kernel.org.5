Return-Path: <linux-kernel+bounces-145952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55A68A5D34
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1ECB1C21C2F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279CF158875;
	Mon, 15 Apr 2024 21:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="P77vgAGx"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A85515990C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 21:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713217816; cv=none; b=pNAE2J6k5ow+Jy38bHlWntLwkXeroGC2sZep3948E4duF57fA8bOXw5NClOcD/IfsL35y0uOmtJ4HDYDIrFXAglu3ZgwD2tVBKncdTCSyJDliQudp/QZOSKxq7aVIG/6IHuxsy2Ti8IPV/jeVYpN0t4G4TxPXNUxFCzNcp40lPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713217816; c=relaxed/simple;
	bh=N/M9yKO5a2ZphLLyAy/Z2CW/R1G8K3gXCs5SBps2WyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dYrNPwL3b65Nj247GPvSay/K/SCMghuBB9BDjAa7BqCi3NotHhNtdMP1pbuXqGrpKIaxRy3L1OO9SC6qNPUFSHSHJUsYHak3WBf003MnMRTqCwmpKnlw2PvVBn8J+o6QMUS600qJa2nvwy0rPYOiIXkMcQxBOTdCTvkn6+LQEdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=P77vgAGx; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713217813;
	bh=N/M9yKO5a2ZphLLyAy/Z2CW/R1G8K3gXCs5SBps2WyI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P77vgAGx9i3RwRH1kZNvzJR5vzEXHwUTkxSItIP82jN65NvFVHdzf7ZVrBakD7m2r
	 AyjLLv4tQIay92qhI83Htsd38mddhskEpxq/L5cUgoBUf5qpPjWIsfXm/mBDdMMihZ
	 uG2H/Xcqkojk2jITaysW1Febp4hsPNdn+OeFg9x7nzwgcivcW0q7wFsaAx0+1tOttU
	 htCiJWrmOwTzH8dFKC2dtdfV28YleYL/q6vdcC0/gL+TVLP6ibELtsHHF2O944dY9v
	 giV++EA75TVLf7ABImB21EUvzgsKAG2IqrPTfqbmXhN057u6JQPtprTx0WqvddftFg
	 qJwmGLsAC9Ikw==
Received: from [192.168.42.226] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A1CA037811CD;
	Mon, 15 Apr 2024 21:50:09 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Mon, 15 Apr 2024 17:49:35 -0400
Subject: [PATCH v3 7/9] drm/bridge: dpc3433: Don't log an error when DSI
 host can't be found
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240415-anx7625-defer-log-no-dsi-host-v3-7-619a28148e5c@collabora.com>
References: <20240415-anx7625-defer-log-no-dsi-host-v3-0-619a28148e5c@collabora.com>
In-Reply-To: <20240415-anx7625-defer-log-no-dsi-host-v3-0-619a28148e5c@collabora.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 owen <qwt9588@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Vasut <marex@denx.de>, Adrien Grassein <adrien.grassein@gmail.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Sam Ravnborg <sam@ravnborg.org>, Bjorn Andersson <andersson@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Vinay Simha BN <simhavcs@gmail.com>, 
 Christopher Vollo <chris@renewoutreach.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.13.0

Given that failing to find a DSI host causes the driver to defer probe,
make use of dev_err_probe() to log the reason. This makes the defer
probe reason available and avoids alerting userspace about something
that is not necessarily an error.

Also move the "failed to attach" error message so that it's only printed
when the devm_mipi_dsi_attach() call fails.

Fixes: 6352cd451ddb ("drm: bridge: Add TI DLPC3433 DSI to DMD bridge")
Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/gpu/drm/bridge/ti-dlpc3433.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-dlpc3433.c b/drivers/gpu/drm/bridge/ti-dlpc3433.c
index ca3348109bcd..6b559e071301 100644
--- a/drivers/gpu/drm/bridge/ti-dlpc3433.c
+++ b/drivers/gpu/drm/bridge/ti-dlpc3433.c
@@ -319,12 +319,11 @@ static int dlpc_host_attach(struct dlpc *dlpc)
 		.channel = 0,
 		.node = NULL,
 	};
+	int ret;
 
 	host = of_find_mipi_dsi_host_by_node(dlpc->host_node);
-	if (!host) {
-		DRM_DEV_ERROR(dev, "failed to find dsi host\n");
-		return -EPROBE_DEFER;
-	}
+	if (!host)
+		return dev_err_probe(dev, -EPROBE_DEFER, "failed to find dsi host\n");
 
 	dlpc->dsi = mipi_dsi_device_register_full(host, &info);
 	if (IS_ERR(dlpc->dsi)) {
@@ -336,7 +335,11 @@ static int dlpc_host_attach(struct dlpc *dlpc)
 	dlpc->dsi->format = MIPI_DSI_FMT_RGB565;
 	dlpc->dsi->lanes = dlpc->dsi_lanes;
 
-	return devm_mipi_dsi_attach(dev, dlpc->dsi);
+	ret = devm_mipi_dsi_attach(dev, dlpc->dsi);
+	if (ret)
+		DRM_DEV_ERROR(dev, "failed to attach dsi host\n");
+
+	return ret;
 }
 
 static int dlpc3433_probe(struct i2c_client *client)
@@ -367,10 +370,8 @@ static int dlpc3433_probe(struct i2c_client *client)
 	drm_bridge_add(&dlpc->bridge);
 
 	ret = dlpc_host_attach(dlpc);
-	if (ret) {
-		DRM_DEV_ERROR(dev, "failed to attach dsi host\n");
+	if (ret)
 		goto err_remove_bridge;
-	}
 
 	return 0;
 

-- 
2.44.0


