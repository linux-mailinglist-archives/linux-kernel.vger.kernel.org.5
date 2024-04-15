Return-Path: <linux-kernel+bounces-145955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0D98A5D38
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A87A1F22727
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A6A15AABB;
	Mon, 15 Apr 2024 21:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="4vAkfOSk"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8128E15AAAC
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 21:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713217824; cv=none; b=MD9QsC4dKgY+R9HJrZJQbOCyXAR7Pa3xRKC3oCFUByyjDZvYt0ZSe39GxwVQdOy3IVZY0GRi0um74ciH7djA9NQT0jGouw2Y7ZCqlP4vCU9jvWdUavpLajoH5OnJLfxvA1HVowCvxLif/KoWhh3MocwelI5ZExVVcFdl+LVHyo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713217824; c=relaxed/simple;
	bh=Jrt7Z0J7fCt4+JVJZqqS5FDIaFBkB4pyTTZI0XtPT8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F3yrjCXY4Bl0QiPSlVISOQM8kJ6GdMUwHvLY+sT/wocdQmmi2g/TaWYWTV3olpFCz68tBknsFzDRIwc1G1mWS3uuuEFATg9pBdG4bOr470P+4k/quwEHbnQbn4lJ5NpRG1PYj0MDOY/v0wQyg2+XBhZk9QfxldEkECVQuGQq7vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=4vAkfOSk; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713217821;
	bh=Jrt7Z0J7fCt4+JVJZqqS5FDIaFBkB4pyTTZI0XtPT8s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=4vAkfOSkdyhBWA227C3yqkMkbVT2ZMxx6JcxKmlpgmPibs5ty7NSxL7/7PeldCPQb
	 +qyZZLNRjrFx8oon6MZbFU0h2UmAShr9c7nAlazYRTU5sESnGFOypozpnaX3GFX1fg
	 beNK7na4B0NsQNmsUdnoiNJRfJdES5iHbulhtqtvugfxDJF5mpsp66RIr0+PSVEL2j
	 8cFvRo/TjSbT22ImYkgz5xKLNrbxGCa543cXC9L/85MfM9lPWgdstW7URUCaaTdIFc
	 TUAll+jgNm3UgNlp4A3oQ3y8M6GM7fLMfnY5sodnlSpPIBGtNgXap6dli2hOfEfpEj
	 FXEDYT1xZLWzw==
Received: from [192.168.42.226] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EC12F37811CD;
	Mon, 15 Apr 2024 21:50:17 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Mon, 15 Apr 2024 17:49:37 -0400
Subject: [PATCH v3 9/9] drm/panel: truly-nt35597: Don't log an error when
 DSI host can't be found
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240415-anx7625-defer-log-no-dsi-host-v3-9-619a28148e5c@collabora.com>
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
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.13.0

Given that failing to find a DSI host causes the driver to defer probe,
make use of dev_err_probe() to log the reason. This makes the defer
probe reason available and avoids alerting userspace about something
that is not necessarily an error.

Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/gpu/drm/panel/panel-truly-nt35597.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-truly-nt35597.c b/drivers/gpu/drm/panel/panel-truly-nt35597.c
index b73448cf349d..d447db912a61 100644
--- a/drivers/gpu/drm/panel/panel-truly-nt35597.c
+++ b/drivers/gpu/drm/panel/panel-truly-nt35597.c
@@ -550,10 +550,8 @@ static int truly_nt35597_probe(struct mipi_dsi_device *dsi)
 
 	dsi1_host = of_find_mipi_dsi_host_by_node(dsi1);
 	of_node_put(dsi1);
-	if (!dsi1_host) {
-		dev_err(dev, "failed to find dsi host\n");
-		return -EPROBE_DEFER;
-	}
+	if (!dsi1_host)
+		return dev_err_probe(dev, -EPROBE_DEFER, "failed to find dsi host\n");
 
 	/* register the second DSI device */
 	dsi1_device = mipi_dsi_device_register_full(dsi1_host, &info);

-- 
2.44.0


