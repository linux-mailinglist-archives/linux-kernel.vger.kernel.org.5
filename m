Return-Path: <linux-kernel+bounces-87722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9664386D838
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37921B22929
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8DB80B;
	Fri,  1 Mar 2024 00:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QMCvJvfO"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E93F3C04
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 00:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709251962; cv=none; b=WUrqHuWxrKZYwGg779GEUhcdgoCLWePjIe8mUDFMcYtpp0fCcmECNHjmbml+x00QCHlkgc9YEx2Op4CXKaapnfG2hPqiN74VK2y9CDuAHDf5U3zh9yEFvgTfm+e4uoD95agSgyb6c/bF6Xex8hjCvHzEZIQZjnbuRINEPB72XBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709251962; c=relaxed/simple;
	bh=iH06xccM8Cux1F3BhJ2YYDHKnbi65kEA+R8Dz6nQIhU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qZnv7I9FBYyj0YdT2HUJbsNXBMEsd8emFznyFgRLykky1Vii1B5Da0P82vGxKW8bA7z8yvpqfXVvr91jZdVCYCyYxXSv8yY/r7d28KS2dYJgjceuPqsa0nidA+ALcJAYOk0kSzM0yKoNkzyDVXuk3kXys3fLSxfgM9TebFGTNsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QMCvJvfO; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709251958;
	bh=iH06xccM8Cux1F3BhJ2YYDHKnbi65kEA+R8Dz6nQIhU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QMCvJvfOb47s8BTrX0J8KLUOyCSWQFMsBlKURkN5Iw8iy2JCXUPnT1XgpLe5jYetj
	 I7sbsjq8rs2nSsg2sCt1bsy1BfN4ACvsXxEDFAP8nIVgA0JZra/2MuIP/4H3Ats7Ea
	 Nb4XKvZov0gHj3KHnIQO/pA1L7KoQooL8mpZSfzV4QyqpubiltMDDZ9zNuqQkuGGFe
	 b2QjpJD+FN4NStVvM4H0/VFql14kh89WNclXaT8XNe/8z/xx0BNa3Jzz+Kw5IzqPxA
	 xwj9O2qma7BGQ+NMGCLO5tMTd2DvzcNKr/jZ3REDPV+wfyjft3mG4R1fTGSWHNDy8s
	 e21co4cIe/pGQ==
Received: from [192.168.1.205] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8B471378000E;
	Fri,  1 Mar 2024 00:12:33 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Thu, 29 Feb 2024 19:12:10 -0500
Subject: [PATCH v2 4/9] drm/bridge: lt9611: Don't log an error when DSI
 host can't be found
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240229-anx7625-defer-log-no-dsi-host-v2-4-00506941049a@collabora.com>
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

Fixes: 23278bf54afe ("drm/bridge: Introduce LT9611 DSI to HDMI bridge")
Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index 9663601ce098..89bdd938757e 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -760,10 +760,8 @@ static struct mipi_dsi_device *lt9611_attach_dsi(struct lt9611 *lt9611,
 	int ret;
 
 	host = of_find_mipi_dsi_host_by_node(dsi_node);
-	if (!host) {
-		dev_err(lt9611->dev, "failed to find dsi host\n");
-		return ERR_PTR(-EPROBE_DEFER);
-	}
+	if (!host)
+		return ERR_PTR(dev_err_probe(lt9611->dev, -EPROBE_DEFER, "failed to find dsi host\n"));
 
 	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
 	if (IS_ERR(dsi)) {

-- 
2.44.0


