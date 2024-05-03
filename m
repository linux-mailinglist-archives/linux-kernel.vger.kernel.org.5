Return-Path: <linux-kernel+bounces-167914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C3C8BB104
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C68282A88
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC9815687B;
	Fri,  3 May 2024 16:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EeAisheX"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66006156874
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 16:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714754483; cv=none; b=TwoLoSR0+x+wnDrWK2XH+69hNWc9YAnlz+ekrxFqpKHwp3lDx/xmyOWhyhXTtkA1v8ii2dEa0P5jNr93BfYyFes1+OvASApJ756kzvL48GZ8TEy8DlrqzccmFKFxaZMOTsianlLg96Zs4l6ulEqyPNhCKUk3mmjwGYr9RsKN2AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714754483; c=relaxed/simple;
	bh=xxXzab/h5WngKPhp8rlMUcre5HXMxpT+2FWsYt5O6ow=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V2C++wfrx99X4gSEVj/LBSClp+pKkIDpntZLxKwYv3EmeRDhsnc3DdR0BnM9rq8Dh/fwkJJcp3d6B+JfgErH7NMvIxmi3J8ErlUYNreZ1+Kosx1RIY4Sis6UR5gBP4sTLurhwTvjBgh670ZwSZSsTHMOhpZPXUqZpqxfjX7hGIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EeAisheX; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714754479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v/sfvCbsExxR+80Czjk0cax2wbMTf4eS83WNGKM8GpY=;
	b=EeAisheXkb40MSY0xLwm1raY+tGiU3GikmftKAiCst/fXFaiY/FNr51n9FB9macOr0HV3P
	OKTQCq4qrCswtQldOHHTkV1BN21B4/NQYKYEiCcG7qoCZYO7T6BK0czEcZM7QqZTPPgJec
	hsUvLi1AbTHJeZRUQ81+MZ3opH4DA/Q=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH v5 00/10] drm/bridge: Allow using fwnode API to get the next bridge
Date: Sat,  4 May 2024 00:40:56 +0800
Message-Id: <20240503164106.1172650-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently, the various display bridge drivers rely on OF infrastructures
to works very well, yet there are platforms and/or devices absence of 'OF'
support. Such as virtual display drivers, USB display apapters and ACPI
based systems etc.

Add fwnode based helpers to fill the niche, this allows part of the display
bridge drivers to work across systems. As the fwnode API has wider coverage
than DT counterpart and the fwnode graphs are compatible with the OF graph,
so the provided helpers can be used on all systems in theory. Assumed that
the system has valid fwnode graphs established before drm bridge drivers
are probed, and there has fwnode assigned to involved drm bridge instance.

Tested on TI BeaglePlay board.

v1 -> v2:
	 * Modify it66121 to switch togather
	 * Drop the 'side-by-side' implement
	 * Add drm_bridge_find_next_bridge_by_fwnode() helper
	 * Add drm_bridge_set_node() helper

v2 -> v3:
	 * Read kernel-doc and improve function comments (Dmitry)
	 * Drop the 'port' argument of it66121_read_bus_width() (Dmitry)
	 * drm-bridge: sii902x get nuked

v3 -> v4:
	 * drm-bridge: tfp410 get nuked
	 * Add platform module alias
	 * Rebase and improve commit message and function comments

v4 -> v5:
	 * Modify sii9234, ch7033 and ANX7688
	 * Trivial fixes

Sui Jingfeng (10):
  drm/bridge: Allow using fwnode APIs to get the next bridge
  drm/bridge: Add a helper to setup both the of_node and fwnode of drm
    bridge
  drm/bridge: simple-bridge: Use fwnode APIs to acquire device
    properties
  drm/bridge: display-connector: Use fwnode APIs to acquire device
    properties
  drm/bridge: sii902x: Switch to use fwnode APIs to acquire device
    properties
  drm-bridge: it66121: Use fwnode APIs to acquire device properties
  drm/bridge: tfp410: Use fwnode APIs to acquire device properties
  drm/bridge: sii9234: Use fwnode APIs to abstract DT dependent API away
  drm/bridge: ch7033: Switch to use fwnode based APIs
  drm/bridge: anx7688: Switch to use drm_bridge_set_node() helper

 drivers/gpu/drm/bridge/chrontel-ch7033.c   | 14 ++--
 drivers/gpu/drm/bridge/cros-ec-anx7688.c   |  3 +-
 drivers/gpu/drm/bridge/display-connector.c | 25 ++++----
 drivers/gpu/drm/bridge/ite-it66121.c       | 57 ++++++++++-------
 drivers/gpu/drm/bridge/sii902x.c           | 45 +++++--------
 drivers/gpu/drm/bridge/sii9234.c           |  8 ++-
 drivers/gpu/drm/bridge/simple-bridge.c     | 23 +++----
 drivers/gpu/drm/bridge/ti-tfp410.c         | 41 ++++++------
 drivers/gpu/drm/drm_bridge.c               | 74 ++++++++++++++++++++++
 include/drm/drm_bridge.h                   | 18 +++++-
 10 files changed, 201 insertions(+), 107 deletions(-)

-- 
2.34.1


