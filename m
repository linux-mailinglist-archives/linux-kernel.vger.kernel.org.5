Return-Path: <linux-kernel+bounces-87723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A055F86D839
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA41285222
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933C03C29;
	Fri,  1 Mar 2024 00:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Oe4pTP9H"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BD363C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 00:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709251967; cv=none; b=o3TzFVIOTYV7mHGYmT9NzVtdjrhR+BJM42lJcvNKNlQGW3QMhTA/ip69ucA56eFB/tmjjWqPiak6XjWhOWhmMgbq5xZbee10UCFccCyYScfj6SXlaGBCaf9vbxZTTduFEz8AlSUu1vCyIxKPv8ylghpjIGSjmP/aEFcP1JSN8g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709251967; c=relaxed/simple;
	bh=USSgCDP9hS4bs7tJCyGn4h6s80NL6hl+B96SysSOP2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dTNF2AtYBqlIVAaKgjmyXC3Q3i54DSaQusIdKELHgoPoxyL/AbBbJsyo5omPT+naJS1Ep/XsyFc5MiPFkiJuA7GFM1r+8KrUhMxQEc5S+hPtVr0+9IQExrqmyqK+6ywB/V0KdXqng8MNIAyCyfB4RfBiUu4DzDDkhzrcBivPrYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Oe4pTP9H; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709251964;
	bh=USSgCDP9hS4bs7tJCyGn4h6s80NL6hl+B96SysSOP2Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Oe4pTP9HkQIUhqP7j+3FqMmZmdGnO2r3byoKDxh6zJe1fAoftVHZrxeVbPtsb9yrI
	 sRAxGkyEfKav4ZWFDQ6FCq40DNstMDbt7ZYt9d1HxPcJjhhr+Vhsm43df5zMC+E1XU
	 RfLxK8wIhCYLV1vQVFNUNTRHiLyEeu+uM70wOskQO+OPK55SWmxWqlqWs0EIaV2STL
	 jeNSAT0O/IQk79pXb4Y01x78p8hs8WLpRwTFvImMOEMa8aekp/ssl4ond2ULq5ZhMH
	 VoO7a6MDbi0ATB8uHe3fuP1xyTav7pzpPN4fNIU3q47i6O5oCxaUw2uxS1cj/eMcJ0
	 s7Us4BWoXqpjw==
Received: from [192.168.1.205] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1CA4337820EC;
	Fri,  1 Mar 2024 00:12:38 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Thu, 29 Feb 2024 19:12:11 -0500
Subject: [PATCH v2 5/9] drm/bridge: lt9611uxc: Don't log an error when DSI
 host can't be found
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240229-anx7625-defer-log-no-dsi-host-v2-5-00506941049a@collabora.com>
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

Fixes: 0cbbd5b1a012 ("drm: bridge: add support for lontium LT9611UXC bridge")
Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index e971b75e90ad..b803899126d5 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -265,10 +265,8 @@ static struct mipi_dsi_device *lt9611uxc_attach_dsi(struct lt9611uxc *lt9611uxc,
 	int ret;
 
 	host = of_find_mipi_dsi_host_by_node(dsi_node);
-	if (!host) {
-		dev_err(dev, "failed to find dsi host\n");
-		return ERR_PTR(-EPROBE_DEFER);
-	}
+	if (!host)
+		return ERR_PTR(dev_err_probe(dev, -EPROBE_DEFER, "failed to find dsi host\n"));
 
 	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
 	if (IS_ERR(dsi)) {

-- 
2.44.0


