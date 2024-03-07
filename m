Return-Path: <linux-kernel+bounces-95929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66082875510
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 974221C22B59
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1061D130AE1;
	Thu,  7 Mar 2024 17:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mjk8nk87"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0965E12F5BD
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 17:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709832231; cv=none; b=gjkWkPvZXT74iGisdOSdPKrJexJmicwybhC+epX6s05DNgm2r3KJAIA/ijgsqE7jVUILLvilwwv6YGd79YlH0vO4rXLr6CfbTgpHgE0zK0DxI+rCgQULOZvT8allyEx1inYc11iPx8ZtBTL3Uo02Szr0IMQWBarF2ump9UhEZMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709832231; c=relaxed/simple;
	bh=/yy1i/1t5ibpXTg0AAhp4RrziJoxMwPzOrriRDvC+1A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=neNHuzoyWU/6RdlXu+UCkUIhOONxwI17Go+1YugLBsqtQmJ/yNC8ibyGauRisLdX1n4ycqIMNs7vG1LIxreaK5PHH1BIEqvQ0AgT0lZ5QkcymsoGiAE0/Ol+I0YvR49jVnG9S8pUB4JCpstqSyFQgQVsgVWX0z7UclWv5uv+WaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mjk8nk87; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709832226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6Nm/uDkNQN3qDQ6YQBwJh6NMCjNuXTvF9sGoyipKdK0=;
	b=Mjk8nk87KIWz31gLfjlrhov8j4QOnypvKVjK2CuTQF/7mNO8SBMKpH6PfmpQJGkCgVEFhn
	sUwZnHzKPyRCpoLM3U4S+4EPsERhRFiq1uX0CLS9U3iN7YQknRcZPfaJCoz9lsDQXykbXG
	zY7VPYygSWXHZl3seSwEhcnqM2iIVEc=
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
Subject: [PATCH v2 0/4] drm/bridge: Allow using fwnode API to get the next bridge
Date: Fri,  8 Mar 2024 01:23:30 +0800
Message-Id: <20240307172334.1753343-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently, the various drm bridge drivers relay on OF infrastructures to
works very well. Yet there are platforms and/or don not has OF support.
Such as virtual display drivers, USB display apapters and ACPI based
systems etc. Add fwnode based helpers to fill the niche, this may allows
part of the drm display bridge drivers to work across systems. As the
fwnode based API has wider coverage than DT, it can be used on all systems
in theory. Assumed that the system has valid fwnode graphs established
before drm bridge driver is probed, the fwnode graphs are compatible with
the OF graph.

Tested on TI BeaglePlay board and other platforms.

v1 at https://patchwork.freedesktop.org/series/129040/

v2:
	 * Modify it66121 to switch togather
	 * Drop the 'side-by-side' implement
	 * Add drm_bridge_find_next_bridge_by_fwnode() helper
	 * Add drm_bridge_set_node() helper

Sui Jingfeng (4):
  drm/bridge: Add fwnode based helpers to get the next bridge
  drm/bridge: simple-bridge: Use fwnode API to acquire device properties
  drm-bridge: display-connector: Use fwnode API to acquire device
    properties
  drm-bridge: it66121: Use fwnode API to acquire device properties

 drivers/gpu/drm/bridge/display-connector.c | 24 ++++----
 drivers/gpu/drm/bridge/ite-it66121.c       | 63 +++++++++++---------
 drivers/gpu/drm/bridge/simple-bridge.c     | 22 ++++---
 drivers/gpu/drm/drm_bridge.c               | 68 ++++++++++++++++++++++
 include/drm/drm_bridge.h                   | 16 +++++
 5 files changed, 142 insertions(+), 51 deletions(-)

-- 
2.34.1


