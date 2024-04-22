Return-Path: <linux-kernel+bounces-153903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1B18AD4B4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1426C1F22650
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE5F155325;
	Mon, 22 Apr 2024 19:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y3anQZO7"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE2B2EB11
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 19:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713813560; cv=none; b=YTgxBO+7UR6Muhv8Kd0Dm1VpqGTZ7EWdBq2jSii2/c76KnidkY5/kpfsA9TjjgG6PG72KC+MObkt5SF6oifdXQ3BdOWERc113IdGeJleGqTaL39ry+0t6aYDOBb7H6l4uBJcjXek5afkwIloblaTpRzTdWvTUTPYdta5ltYLp8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713813560; c=relaxed/simple;
	bh=ALqKhQgzHPsfeffEbf7w8mqFeaMogKGIg746ZV/B0IA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UUjz25P1NSPIQ2weyjRamAuTemQ++7iVWVSdWWCBRhnGXDQqBMV9RAMEGVpIL5lJHQ4BAG7zmxqbK9tr+aPYh4owG5L58CCcwHDonjit+RJ+w3cbq9Ck09vfK/Hd2zc0EIsO6b70vM8GA4bFFHswxyBoqig5Him4pvYOHu9UxgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y3anQZO7; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713813557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fGsjHAbYUFtiS1u1KaAmxhWdCq3KEXLTWvKx+cfURAU=;
	b=Y3anQZO7sdEhrz4psncVP8rNbsfXyEDVRF0idXP8S2tF4kNTCG9oQ7zMG2e5TaHBQ3oz0P
	welkurB8yGQXAbyxtQfKoSYHXcetBeWenWL3etbtJYysQRInyi73fYvRfoAkjEf84AYONj
	WzD2BuNJILqNZoLfnAnjKr/eB3HV/DI=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Phong LE <ple@baylibre.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH v4 0/9] drm/bridge: Allow using fwnode API to get the next bridge
Date: Tue, 23 Apr 2024 03:18:54 +0800
Message-Id: <20240422191903.255642-1-sui.jingfeng@linux.dev>
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

Sui Jingfeng (9):
  drm/bridge: Allow using fwnode API to get the next bridge
  drm/bridge: simple-bridge: Use fwnode API to acquire device properties
  drm/bridge: simple-bridge: Add platform module alias
  drm-bridge: display-connector: Use fwnode API to acquire device
    properties
  drm/bridge: display-connector: Add platform module alias
  drm-bridge: sii902x: Use fwnode API to acquire device properties
  drm-bridge: it66121: Use fwnode API to acquire device properties
  drm/bridge: tfp410: Use fwnode API to acquire device properties
  drm/bridge: tfp410: Add platform module alias

 drivers/gpu/drm/bridge/display-connector.c | 25 ++++----
 drivers/gpu/drm/bridge/ite-it66121.c       | 57 ++++++++++-------
 drivers/gpu/drm/bridge/sii902x.c           | 43 ++++---------
 drivers/gpu/drm/bridge/simple-bridge.c     | 23 ++++---
 drivers/gpu/drm/bridge/ti-tfp410.c         | 42 ++++++------
 drivers/gpu/drm/drm_bridge.c               | 74 ++++++++++++++++++++++
 include/drm/drm_bridge.h                   | 16 +++++
 7 files changed, 185 insertions(+), 95 deletions(-)

-- 
2.34.1


