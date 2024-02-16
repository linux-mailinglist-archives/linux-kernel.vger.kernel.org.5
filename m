Return-Path: <linux-kernel+bounces-69224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A04B8585F1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBF2B1C20AF3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6590A137C4E;
	Fri, 16 Feb 2024 19:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="z3mvE0kH"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF941136678
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 19:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708110279; cv=none; b=Y9e9Npmv594I2HXX/3raWbgihnSSIq7o4h04l7207AzQ5JAOSPOA7uIsrK8STl90I6EcjZiXRTtFF7xnlOjfxCuGT8E0A5F7muD5COsMns/NxtTIXHDi8/H9IkAjuif4mG/SiiO3XP9IVUKVg4w6wUrhbRmZqpsw3hiR+yWhc6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708110279; c=relaxed/simple;
	bh=sRk5vgWXV6TN/MIXrm4lDllEkl5I4mq5NJ+73eNz0L4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hq+qwUoSdOQCgM3UyKrBktjk4qXqXfAdeLGL/danARwMu6Jk6uWuPxo7j7qVnl969BFzCQgjLAieOu3FGorF0LeH3rIz7ONHvhT5QL2U/xiFxrXZX+uCtglwPZ9rXO7ckSWF+FSNz7mO0XSTGhphBQCFzK6i1Kd7oQ5fCUPgsSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=z3mvE0kH; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1708110272; bh=sRk5vgWXV6TN/MIXrm4lDllEkl5I4mq5NJ+73eNz0L4=;
	h=From:To:Cc:Subject:Date:From;
	b=z3mvE0kHkdjI+3haAogAZtgaLooSLbHIzpB1TsKN+hul18rP6xfYei3GFGva5RCQC
	 /NlLC2CoMXvzJW2BFZknPblJXo+AX93t81Roc/5diNNnQLg9Gub6jAsxjnJ9CsbW81
	 dP5U4mCnh/+4yZ1ijwbwKsbSJHVfyxHUxy8iMoYg=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: Maxime Ripard <mripard@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Ondrej Jirman <megi@xff.cz>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Move blender setup from individual planes to crtc commit in sun4i-drm
Date: Fri, 16 Feb 2024 20:04:23 +0100
Message-ID: <20240216190430.1374132-1-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ondrej Jirman <megi@xff.cz>

This series refactors blender setup from individual planes to a common
place where it can be performed at once and is easier to reason about.

In the process this fixes a few bugs that allowed blender pipes to be
disabled while corresponding DRM planes were requested to be enabled.

Please take a look. :)

Thank you very much,
	Ondřej Jirman

Ondrej Jirman (3):
  drm/sun4i: Unify sun8i_*_layer structs
  drm/sun4i: Add more parameters to sunxi_engine commit callback
  drm/sun4i: Fix layer zpos change/atomic modesetting

 drivers/gpu/drm/sun4i/sun4i_backend.c  |  4 +-
 drivers/gpu/drm/sun4i/sun4i_crtc.c     |  2 +-
 drivers/gpu/drm/sun4i/sun8i_mixer.c    | 82 +++++++++++++++++++++++-
 drivers/gpu/drm/sun4i/sun8i_mixer.h    | 20 ++++++
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 85 +++----------------------
 drivers/gpu/drm/sun4i/sun8i_ui_layer.h | 20 ++----
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 86 +++-----------------------
 drivers/gpu/drm/sun4i/sun8i_vi_layer.h | 20 ++----
 drivers/gpu/drm/sun4i/sunxi_engine.h   | 13 +++-
 9 files changed, 137 insertions(+), 195 deletions(-)

-- 
2.43.0


