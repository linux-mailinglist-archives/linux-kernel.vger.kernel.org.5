Return-Path: <linux-kernel+bounces-87726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1753C86D83C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ECAF286A04
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FE71FBF;
	Fri,  1 Mar 2024 00:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="M1YLZif1"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF2E6AA2
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 00:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709251983; cv=none; b=PjNoqHezDXdCJt5aEEWDnbZzu+bTcJxTAJrtcptndmq2HZZitKR3/Dcsw36zpPOkwBIpnoWcVypCPUnY3+3H39jM/F2SP92OFBb+L2zioasvsS+RFTMQAHlOWmC14ZciTyZXW5NQKpxX4UiZ1zoHNH8H/fPqeC89FYGPsJGc4EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709251983; c=relaxed/simple;
	bh=MYKBxuR+aJph7D9FYI37RGyFCJkN1zgdY0Ybz9nXzqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ahWqfKuZiMbQWqWcdOqD3w5Eg3MDMiyD/gnjyBTD1Hl/tfNTea5hGIl4Xs/7VmtRlX2WM4v4tOR+Ea9kfP57NwdegbeI5fUAi/3MUsklLXKq2OSfQd4KhU+7U30dGaJQbjvzMikA0IlxmV6gX86BWxRwEhPzXTOeFuMO1XvLDxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=M1YLZif1; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709251980;
	bh=MYKBxuR+aJph7D9FYI37RGyFCJkN1zgdY0Ybz9nXzqY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=M1YLZif1WED+vvuhoA+scIcRTPnw98+XmpYskhv7KfiRTZHliAuL/NFFZwRaikprw
	 5/kPyPgu+FNAttkzLubD2cCK2Y9EseyttFZrq32z3e+tH4VM4XT1a8lzAl+2JJTiY2
	 a3MYMdMeHRYcS+hzq0bi5oKBS832zjV9QIzM0svssSolLEF/cgs6mIzRhzPuPcgVXq
	 3/HWsNnvmiEj4DMlbMpsd7mbO5Cv9QFxBslrY99kO2YhDnq9/EhRKsxC8Cxo5qbeeK
	 CRlZvaITDZW6gdhNvOyuXjmGggHb+LlsoZzZqLWGkPpyW8/lxG0s3JjW4kM+Vq37a/
	 mdGKQOqTVEt5A==
Received: from [192.168.1.205] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 31A22378000E;
	Fri,  1 Mar 2024 00:12:56 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Thu, 29 Feb 2024 19:12:14 -0500
Subject: [PATCH v2 8/9] drm/panel: novatek-nt35950: Don't log an error when
 DSI host can't be found
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240229-anx7625-defer-log-no-dsi-host-v2-8-00506941049a@collabora.com>
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

Fixes: 623a3531e9cf ("drm/panel: Add driver for Novatek NT35950 DSI DriverIC panels")
Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/gpu/drm/panel/panel-novatek-nt35950.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35950.c b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
index 648ce9201426..028fdac293f7 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35950.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
@@ -556,10 +556,8 @@ static int nt35950_probe(struct mipi_dsi_device *dsi)
 		}
 		dsi_r_host = of_find_mipi_dsi_host_by_node(dsi_r);
 		of_node_put(dsi_r);
-		if (!dsi_r_host) {
-			dev_err(dev, "Cannot get secondary DSI host\n");
-			return -EPROBE_DEFER;
-		}
+		if (!dsi_r_host)
+			return dev_err_probe(dev, -EPROBE_DEFER, "Cannot get secondary DSI host\n");
 
 		nt->dsi[1] = mipi_dsi_device_register_full(dsi_r_host, info);
 		if (!nt->dsi[1]) {

-- 
2.44.0


