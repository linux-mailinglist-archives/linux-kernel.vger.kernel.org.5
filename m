Return-Path: <linux-kernel+bounces-87725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9390386D83B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A42811C213B8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094183C3F;
	Fri,  1 Mar 2024 00:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="sqzDMqcq"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83D817E
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 00:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709251979; cv=none; b=JHKYJvknHdLr5lZJpNufUygi+RzQ3jrxVzfA1j6HBHA3j/Kbkj0BR8kV+bg8RPbvS3woR67gjQMfK0yRk+ZTBqiJTlh328kQAHuNf/5zidZZohxxMX6SOSrU77sWtWtuXUT4Nc6LqZnun2Q8/Akzfx4o5/2e+CubHpcoFIK5Em8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709251979; c=relaxed/simple;
	bh=+CKVPsOP7VaA2gwBWrP4ZLU4toVT2KatRN6rysdk1vs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rTpEv62EyJzl2oJIgKCvOVD0GWK36sEPRXMFjy/+N/bNM95Hj+ETTQg1omF/f/8oQq/y01s6ICKL17l2lniZ15blQ8Bgn39zR5WaB1OYcOUeOhhW5A6LUQi5m/B2R0b7aYfR5B3PoYH436nHN0pwTMzNNo8mQV2p2YrBV23MnDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=sqzDMqcq; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709251975;
	bh=+CKVPsOP7VaA2gwBWrP4ZLU4toVT2KatRN6rysdk1vs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sqzDMqcqvD5UoN64HHW3ZFjlCUvz3hvCdeFOV7qiY/TA6mxT6jFofmQOe+9wpnpC2
	 qSQmKmDrFaMnCq6HWcGMoKcZWWl+nZGmELERlI2jXHRBgMt0ZdsHVRYglcwhIqciV5
	 pIaHj/AMt9oBdFNsItzChDdshlRhwaUznS4xcx+xi2rO76sNGk6i8QBhWTryMyfckY
	 /sF9/hRXyJmHNkxzyFcOL4HshTOenSegh/A5CrV40SiV0auGJRBtxq0oY/tY5zIOJL
	 Se+bbt7fSzbcSJToyRyC7BXxbvCB/8V2wYaSPs+vGR2dDISGzAhi5xh+qPvM/Ku/LQ
	 BrhfJcPqdEteQ==
Received: from [192.168.1.205] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5987537820D8;
	Fri,  1 Mar 2024 00:12:50 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Thu, 29 Feb 2024 19:12:13 -0500
Subject: [PATCH v2 7/9] drm/bridge: dpc3433: Don't log an error when DSI
 host can't be found
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240229-anx7625-defer-log-no-dsi-host-v2-7-00506941049a@collabora.com>
References: <20240229-anx7625-defer-log-no-dsi-host-v2-0-00506941049a@collabora.com>
In-Reply-To: <20240229-anx7625-defer-log-no-dsi-host-v2-0-00506941049a@collabora.com>
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


