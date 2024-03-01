Return-Path: <linux-kernel+bounces-87719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E27D086D82F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89AD5282AC7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A0D816;
	Fri,  1 Mar 2024 00:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="D7Km4Ojv"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFE8193
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 00:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709251945; cv=none; b=TbFYLB64S1pR/5sJ0PkdlBux6Q/Rw0UjdXyLsIbPXq2J5s8AS/L/9imVJL3mqdBNLbQsqjel11hAbxn1tQKygHlNlRf9oFDmiNGd+/j2B/lGg5adeOCN2W0A9llqcnphOBJZizfVy5rx3c+mTVSVPkiFndOLEgmcD++Uzn+WNiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709251945; c=relaxed/simple;
	bh=ddNDXXuct86kt9fa1yOGg6EFSRsJaqUkVKYspL0iIzM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ttjzWlFM0kPUbfL09Df2ukv5nykhVXeY7evjLtcyAx30qCEKGdoL2NSiSGTce8Vhh5PgBAN7qagfZtCPnNL9MmjD/PemdXzaZc80A64bh9XxXWb9ch9n/s4xlyLcBN1JAQOSKp1EDl9epEVXDEQ6Fif66DYHLLBVrv3Q+bsowIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=D7Km4Ojv; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709251935;
	bh=ddNDXXuct86kt9fa1yOGg6EFSRsJaqUkVKYspL0iIzM=;
	h=From:Subject:Date:To:Cc:From;
	b=D7Km4Ojv9tZIrYtyn+iT03V9mKDPM3/jf96hLHKZ2I7VHIJlrFZ2LNgA5CgKz+J0D
	 8JfN9NZDqnwudR/RkCWIAgWbCKmO8G2GKznUx3fXrtw8F1cDLviJmnMz5APg6BYUrv
	 VGbqPYn4i3VgW/IWXZtltgImXg4QX90KUosiMqBMqg3qp0Zj1aQx0VoulGbmfmwSW1
	 N67HKyN6WTLX8imZP2NXsfDjmjXETOvgB/9Yz0Lts76bH5kq6nyiYOba0VfFStWSkL
	 Xw/1FmRAFWmiV8FY9ZRAjCqXum9BhKGUivMyMovnjEdlAx54OfL+6IvykySSMEiKpj
	 M815uNpg3QwaA==
Received: from [192.168.1.205] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 49B4A378000E;
	Fri,  1 Mar 2024 00:12:09 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Subject: [PATCH v2 0/9] drm: Switch from dev_err to dev_err_probe for
 missing DSI host error path
Date: Thu, 29 Feb 2024 19:12:06 -0500
Message-Id: <20240229-anx7625-defer-log-no-dsi-host-v2-0-00506941049a@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFYd4WUC/43NQQ6CMBCF4auYrh1DBwR05T0Mi3aYQhPsmJYQD
 OHuVk7g8nuL/20qcfSc1P20qciLT15CBp5PikYTBgbfZysssCoQazBhbWq8Qs+OI0wyQBDok4d
 R0gxUuhuRJYtto3LjHdn59eg/u+zRp1ni57hb9G/9t7xo0IAVWm1cqdu2epBMk7ESzYXkpbp93
 79ZrL/tzgAAAA==
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

This series changes every occurence of the following pattern: 

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
base-commit: 2ae0a045e6814c8c1d676d6153c605a65746aa29
change-id: 20240226-anx7625-defer-log-no-dsi-host-c3f9ccbcb287

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


