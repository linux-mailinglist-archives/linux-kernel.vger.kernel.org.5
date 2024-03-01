Return-Path: <linux-kernel+bounces-87724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0424C86D83A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87CA51F22C52
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9FC17E1;
	Fri,  1 Mar 2024 00:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="U5WNUS2Y"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620254A20
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 00:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709251972; cv=none; b=IS6IAaxyizhB+9ZvTEQe531nDI7H3agOBIABoqBtu061iMBIjSWlTKKJqU+k5S1f6SntKaP75yoDyB1zB6rF+5xfBOInAM6hkpiMPREJ4NQza4jwrfyLVKFB9uAhZwEizzab1C1nWWiaw+0Wf3HfVraqnkgFSCSqu2v6rxRdihY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709251972; c=relaxed/simple;
	bh=x6U7HBr2+APn5ZpeLNHOIRw/a7yOuDvPI1HGkDefAI0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JTySUHP/yviT1/sTxVsKIFhnOrhKnhID2z9m8H/g2udHE3e0X2yKcbdiGINoumSC2vO2fXPYcc/4ioxIyHomQb7H8N039ii9nDulXf1gKKRgPJv66FB5HlqAobFMzyKRnvGh8UktLyeY4Duw6BF0TCPSM7iM2IOoDN76qozMVQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=U5WNUS2Y; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709251970;
	bh=x6U7HBr2+APn5ZpeLNHOIRw/a7yOuDvPI1HGkDefAI0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U5WNUS2YRX2M9Wm9IoWrVZ9o3oKmM9fqRzZeP0ZusgHofuUBWc5bPR92cN0XGwmQa
	 4Q6qDeRML0MCbRFxg/De9Cqf14L73Un6+fokUNKcPQi5YZfQvziUHwyds+ZQSI1bpo
	 WtPkOKmL4d4CU7WUXN9A1Buz7yG4SaVEAotkZgTBtCVUbNAK+w191RJpbZsiVM+9ca
	 TyEhsr3xRMYGNWkbK+1yQk2EKjCtJqqHCzMbilHW9/HiEPBS0aq23OtuW4NN9J1q6E
	 QbN/bzaOQv17U+DNmzWWOgnW74ciL1YZ6s/KMPHGQ2i3HIBORWIXqPZE0oGgUAUuJM
	 twcOyHfO9wmuw==
Received: from [192.168.1.205] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 09E8D378000E;
	Fri,  1 Mar 2024 00:12:44 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Thu, 29 Feb 2024 19:12:12 -0500
Subject: [PATCH v2 6/9] drm/bridge: tc358775: Don't log an error when DSI
 host can't be found
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240229-anx7625-defer-log-no-dsi-host-v2-6-00506941049a@collabora.com>
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

Fixes: b26975593b17 ("display/drm/bridge: TC358775 DSI/LVDS driver")
Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/gpu/drm/bridge/tc358775.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
index 90a89d70d832..fea4f00a20f8 100644
--- a/drivers/gpu/drm/bridge/tc358775.c
+++ b/drivers/gpu/drm/bridge/tc358775.c
@@ -610,10 +610,8 @@ static int tc_attach_host(struct tc_data *tc)
 						};
 
 	host = of_find_mipi_dsi_host_by_node(tc->host_node);
-	if (!host) {
-		dev_err(dev, "failed to find dsi host\n");
-		return -EPROBE_DEFER;
-	}
+	if (!host)
+		return dev_err_probe(dev, -EPROBE_DEFER, "failed to find dsi host\n");
 
 	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
 	if (IS_ERR(dsi)) {

-- 
2.44.0


