Return-Path: <linux-kernel+bounces-159089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3F98B292F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CB431C214D2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDCA152536;
	Thu, 25 Apr 2024 19:55:20 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7BE15252B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 19:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714074920; cv=none; b=E5Um92V5TJrPQIpUQsyvRgxK/eNfjfgS301w+TG0VOMF5kFWpEWNGx7dK1opgZ5e4djaVAzVP6u3cp7oOTqZMdSlbzgYvHkeVopoIesqE9OVs+eek2twzXiv5m7MLP+e3hb+on89TqODqyAgbH7HnfGRxfKHz6NxC4U7WU+nWFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714074920; c=relaxed/simple;
	bh=dxy1KX4GUlQJ1bd/0sTBKFC5lh0bMqAEeERz/HhOghc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I+REgDk0inC0mtRIcs3kKobyOar2YrW4BqY+ouMsqZzjLGX2pRZZjC9alG5kai+vumhYejXb9wjcTBUs2mdhTGRTxvCBXsIe8mpWJD/ktEbwjUMtqZdx1futkHmxDh+XYwF1iRSSF+tnnek2E24N8X1TabEifTAOMto1F7DHeZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b01.versanet.de ([83.135.91.1] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1s05BX-0005vK-6p; Thu, 25 Apr 2024 21:55:11 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@theobroma-systems.com,
	hjc@rock-chips.com,
	andy.yan@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] drm/rockchip: vop2: two fixes from working on DSI enablement
Date: Thu, 25 Apr 2024 21:55:04 +0200
Message-Id: <20240425195506.2935955-1-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While working on enabling DSI support on rk3588 I stumbled across the issue
of the display staying black while both the vop2 and dsi drivers were
claiming to be running just fine.

After a bit of checking I found that I got DSI output on VP3 when HDMI
on VP0 was at least associated in the DTS, but not without.

Andy's patch [0] helped and is definitly necessary, but did not fix the
problem completely. The missing thing was that VP3 is rk3588-specific
(rk3568 only has 3 video-ports, not 4 like rk3588) and the layers of
VP3 never got configured.

Patch2 fixes this.


[0] https://lore.kernel.org/dri-devel/20240422101905.32703-2-andyshrk@163.com/

Heiko Stuebner (2):
  drm/rockchip: vop2: fix rk3588 dp+dsi maxclk verification
  drm/rockchip: vop2: configure layers for vp3 on rk3588

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 16 ++++++++++++++--
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h |  1 +
 2 files changed, 15 insertions(+), 2 deletions(-)

-- 
2.39.2


