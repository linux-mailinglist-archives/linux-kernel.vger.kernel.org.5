Return-Path: <linux-kernel+bounces-98561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ECE877C01
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E8A81F21173
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 08:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA3712E59;
	Mon, 11 Mar 2024 08:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ELkA1rAv"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE111118B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 08:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710147495; cv=none; b=B0hbKTQOS8XhZHc9+OikEg1c05w7PayN59GdGCQluTWyy1q5biTVxI7gJ1m+fc7Q/Xx4AsVZB7IuU8UMFpzTOOQXYKq1J+DjfeIKAfNB6LMAoHJH7K5azoihGbj5k11HfAeej9IlP6okcVrAch8cl1C0sx1Lf4+7jcWN/DahGg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710147495; c=relaxed/simple;
	bh=kxvb1tdP7nfGStb8b1yMELo+9+ELVU80EZYYWaRZGx4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AcV9+LanVwBbwlZgiVWJ9KYeRIDDJpWFuiosRSjxlo0UIMpCfDI02slTKNKyEWSkRgLN6BR7xo6gDhw7YDt96fyQ1272fOHptaYV67Zsh612u6JwiQmR6E+o01B66WCVRcKL2Llkqj6CdbJMP8QSemSG22m8fP8HVMyMZu2ub9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ELkA1rAv; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710147490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xbTltqoLlmFssK6yUo+EQC4DqOFHNmiIvuznM++ubag=;
	b=ELkA1rAvL8X3fhBwm/BggL/K/gCJmwY/bRxMmagZI8Q/f2bxox3Ki7/+UXRyHWXDCzmpaw
	7r33pZoipgUM/mx8Rz45cc60eNt8nr5zbjvamrB6ESw2932aEIQ0TSo23IkuVsZR1qPh8A
	/8pL3PYukDW+tfc5iKKVCEb8geXxaAA=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Phong LE <ple@baylibre.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH v3 0/5] drm/bridge: Allow using fwnode API to get the next bridge
Date: Mon, 11 Mar 2024 16:56:54 +0800
Message-Id: <20240311085659.244043-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently, the various drm bridge drivers relay on OF infrastructures to
works very well. Yet there are platforms and/or devices absence of OF
support. Such as virtual display drivers, USB display apapters and ACPI
based systems etc.

Add fwnode based helpers to fill the niche, this allows part of the drm
display bridge drivers to work across systems. As the fwnode based API
has wider coverage than DT and the fwnode graphs are compatible with
the OF graph, so the provided helpers can be used on all systems in theory.
Assumed that the system has valid fwnode graphs established before the
drm bridge driver is probed, and there is a fwnode assigned to the instance
of specific drm bridge driver.

Tested on TI BeaglePlay board and other platforms.

v1 -> v2:
	 * Modify it66121 to switch togather
	 * Drop the 'side-by-side' implement
	 * Add drm_bridge_find_next_bridge_by_fwnode() helper
	 * Add drm_bridge_set_node() helper

v2 -> v3:
	 * Read kernel-doc and improve function comments
	 * Drop the 'port' argument of it66121_read_bus_width() (Dmitry)
	 * Do more by covertering the sii902x drm bridge drviers

Sui Jingfeng (5):
  drm/bridge: Add fwnode based helpers to get the next bridge
  drm/bridge: simple-bridge: Use fwnode API to acquire device properties
  drm-bridge: display-connector: Use fwnode API to acquire device
    properties
  drm-bridge: it66121: Use fwnode API to acquire device properties
  drm-bridge: sii902x: Use fwnode API to acquire device properties

 drivers/gpu/drm/bridge/display-connector.c | 24 ++++----
 drivers/gpu/drm/bridge/ite-it66121.c       | 63 ++++++++++---------
 drivers/gpu/drm/bridge/sii902x.c           | 43 +++++--------
 drivers/gpu/drm/bridge/simple-bridge.c     | 22 +++----
 drivers/gpu/drm/drm_bridge.c               | 72 ++++++++++++++++++++++
 include/drm/drm_bridge.h                   | 16 +++++
 6 files changed, 159 insertions(+), 81 deletions(-)


base-commit: 3fde6df89bac97416ce1c82b14237a1a67ce3285
-- 
2.34.1


