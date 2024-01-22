Return-Path: <linux-kernel+bounces-33696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B0F836E6B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B20CB33A90
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90A756450;
	Mon, 22 Jan 2024 16:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OwoFS+Tv"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE943DB8A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705941151; cv=none; b=ipVRLkLCfaZXOqRDtDDVy94VwiLbR+P2MsfK1YGrhk0qeyr7x3tipBNDFfgqOV4/oQZQy8caeKEeuVQn2DfcIgpwLWdfIPKZm30wEotViDzL/eXXLmNw0qN2lLeByNhk1vnvyYANoNgkiwXG1l19ICYiuMnJ/e5Qs6n1HhDiaOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705941151; c=relaxed/simple;
	bh=DoM57EGrrlGao7XqVeEDmPwOKT4k1YN8rbXMIMdNt7c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ULKVuIk55/fisWGo6cNwEBjj+iGON4iAhLmUp099gXa/WGCl4ukdu3wH4xixd8klLrEKtYdIlDNu+15McrDGdJFixn0YaRC/1HWBNcokDe6IcxCqS7byBeY6n1RJheGUQYMYjdUnptz7ifG5vj+rmzjuTjBySCt+8a96ouj/lT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OwoFS+Tv; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705941147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=55MO4bPOLn4/UwKC6DUmQGXwkP8oJde1RTnFz7waoW0=;
	b=OwoFS+Tv+QnDTE88hzBMy10Sa2dIpGUtwE1YWdITuK3CNzjJHDgU/GzZ7injIechmLQABF
	Yn87xa9HI8FduHUtyySYrIOZlaq4rCBOiIACBtCbATM77lW2GuLybKY/qef3x6YrHxqj4l
	vuzv2ZCgaZyuJ5+4s1KZs56wGBWuvbw=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: David Airlie <airlied@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Daniel Vetter <daniel@ffwll.ch>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH 0/5] drm/bridge: Allow using fwnode API to get the next bridge
Date: Tue, 23 Jan 2024 00:32:15 +0800
Message-Id: <20240122163220.110788-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Make it possible to use drm-bridge drivers on non-DT based systems.

Sui Jingfeng (5):
  drm/bridge: Add drm_bridge_find_by_fwnode() helper
  drm/bridge: simple-bridge: Extend match support for non-DT based
    systems
  drm/bridge: simple-bridge: Allow acquiring the next bridge with fwnode
    API
  drm/bridge: display-connector: Extend match support for non-DT based
    systems
  drm-bridge: display-connector: Switch to use fwnode API

 drivers/gpu/drm/bridge/display-connector.c | 46 +++++++++----
 drivers/gpu/drm/bridge/simple-bridge.c     | 75 +++++++++++++++++++---
 drivers/gpu/drm/drm_bridge.c               | 33 ++++++++++
 include/drm/drm_bridge.h                   |  4 ++
 4 files changed, 139 insertions(+), 19 deletions(-)

-- 
2.25.1


