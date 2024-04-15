Return-Path: <linux-kernel+bounces-145945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 431538A5D24
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A3B41C2182C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA548157482;
	Mon, 15 Apr 2024 21:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ih11+7oN"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A371EF1A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 21:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713217788; cv=none; b=Qq2XaZSKPqUZ2CDZaT9krj5xU0JONpikvpB15q4yDTNPFvv5KRH8UC6WINksQPcP4ybWP6wn6hAl6tiX0oAiXmUYbUGgUNYclK/SpZrThDA1Dtizpn03QTxSJHYOTQm+o6gROPXwiAxYHppE5D7zr61VIHod8NGs9mEMqtNostY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713217788; c=relaxed/simple;
	bh=45acX4xwosl5WBJBU7nS1iX68G88AicLYKqxcAO7qpA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IND7FhBMFpKFcsWXbPKCMaL+toxM0jPlRZf32YwRKaFvz+CBiIQ+M4EFjHVZLuifHNdy2dRGlfGoFtDj7xnYDoDBMAJeoXWcff/jfv6K6PtxBV0U8UeJpyvtuJ8qAg3V1mnVSefuIEbvzD0R+RNccQz+qE4tEdqe8lhB1sV5ZF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ih11+7oN; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713217784;
	bh=45acX4xwosl5WBJBU7nS1iX68G88AicLYKqxcAO7qpA=;
	h=From:Subject:Date:To:Cc:From;
	b=Ih11+7oNfQtYkZOk5taWHezfn/TioUO4lE/potESxOcziZ3FENfkC2ALkjxpVrSpW
	 qQ21ctGAss7knP37rKb+fhhBgckrxiGIyJy4Pln0csiLGcCinicoyA4Y4P7E3aeepU
	 yXCvNbH5nZlTnO4v2doKM8+1R7jAFJT0AxjrDJlSSpISJj51LfSKCn9HIXO5RRFuno
	 xvYteTFOx4wT7topD1KsA0U0zkqowgKf0lU6bUiW1JkJDY8xxIwSkebFAVp+Bd7vDj
	 lEaaKTP+3AofilMRApqVxkBqMswzU057pTzbobidHPV0IuLjxZry0nTOqe7iTaceRT
	 EAXgYgqIrivvQ==
Received: from [192.168.42.226] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 693CB3780016;
	Mon, 15 Apr 2024 21:49:40 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Subject: [PATCH v3 0/9] drm: Switch from dev_err to dev_err_probe for
 missing DSI host error path
Date: Mon, 15 Apr 2024 17:49:28 -0400
Message-Id: <20240415-anx7625-defer-log-no-dsi-host-v3-0-619a28148e5c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOigHWYC/43NvQ6DIBiF4VsxzP0a+MQfOvU+mg6AoCRWGjDEx
 njvRaemSzu+Z3jOSqIJzkRyKVYSTHLR+SlHeSqIHuTUG3BdboIUOUWsQU5LU2MFnbEmwOh7mDx
 00cHg4wy6tEJrpRW2DcnGMxjrlsO/3XMPLs4+vI67xPb1XzkxYIAcFZO2ZG3Lr9qPo1Q+yLP2D
 7LrCT9F8UtEoEBpRWvBGeVCfovbtr0BuQ3geyABAAA=
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
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.13.0

This series changes every occurrence of the following pattern: 

	dsi_host = of_find_mipi_dsi_host_by_node(dsi);
	if (!dsi_host) {
		dev_err(dev, "failed to find dsi host\n");
		return -EPROBE_DEFER;
	}

into

	dsi_host = of_find_mipi_dsi_host_by_node(dsi);
	if (!dsi_host)
		return dev_err_probe(dev, -EPROBE_DEFER, "failed to find dsi host\n");

This registers the defer probe reason (so it can later be printed by the
driver core or checked on demand through the devices_deferred file in
debugfs) and prevents errors to be spammed in the kernel log every time
the driver retries to probe, unnecessarily alerting userspace about
something that is a normal part of the boot process.

I have omitted a Fixes: tag in the last patch, for the truly-nt35597
panel, because it predates the dev_err_probe() helper.

Changes in v3:
- Added trailers
- Rebased on next-20240415
- Link to v2: https://lore.kernel.org/r/20240229-anx7625-defer-log-no-dsi-host-v2-0-00506941049a@collabora.com

Changes in v2:
- Added patches 2 onwards to fix all occurences of this pattern instead
  of just for the anx7625 driver
- Link to v1: https://lore.kernel.org/r/20240226-anx7625-defer-log-no-dsi-host-v1-1-242b1af31884@collabora.com

---
Nícolas F. R. A. Prado (9):
      drm/bridge: anx7625: Don't log an error when DSI host can't be found
      drm/bridge: icn6211: Don't log an error when DSI host can't be found
      drm/bridge: lt8912b: Don't log an error when DSI host can't be found
      drm/bridge: lt9611: Don't log an error when DSI host can't be found
      drm/bridge: lt9611uxc: Don't log an error when DSI host can't be found
      drm/bridge: tc358775: Don't log an error when DSI host can't be found
      drm/bridge: dpc3433: Don't log an error when DSI host can't be found
      drm/panel: novatek-nt35950: Don't log an error when DSI host can't be found
      drm/panel: truly-nt35597: Don't log an error when DSI host can't be found

 drivers/gpu/drm/bridge/analogix/anx7625.c     |  6 ++----
 drivers/gpu/drm/bridge/chipone-icn6211.c      |  6 ++----
 drivers/gpu/drm/bridge/lontium-lt8912b.c      |  6 ++----
 drivers/gpu/drm/bridge/lontium-lt9611.c       |  6 ++----
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c    |  6 ++----
 drivers/gpu/drm/bridge/tc358775.c             |  6 ++----
 drivers/gpu/drm/bridge/ti-dlpc3433.c          | 17 +++++++++--------
 drivers/gpu/drm/panel/panel-novatek-nt35950.c |  6 ++----
 drivers/gpu/drm/panel/panel-truly-nt35597.c   |  6 ++----
 9 files changed, 25 insertions(+), 40 deletions(-)
---
base-commit: 6bd343537461b57f3efe5dfc5fc193a232dfef1e
change-id: 20240226-anx7625-defer-log-no-dsi-host-c3f9ccbcb287

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


