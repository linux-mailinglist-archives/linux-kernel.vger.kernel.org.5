Return-Path: <linux-kernel+bounces-114978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A66E0888C52
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45DB21F29171
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA617131185;
	Mon, 25 Mar 2024 00:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIHamxpy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0C6282A9A;
	Sun, 24 Mar 2024 23:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323746; cv=none; b=FXqpJ9zC91SfVsbRSHlaEZDm2RPwIrND9F0chsVCHCuKTNQ/p1OI0Lh1VoAw9U5pS/P1Qw6NiYqwKBh1VYzpIJ2phsTewsI3j6tIIcx53d0PvBfNvP4b8VdFEGqIkmV04Wq3NGLiUkGIvz+VovWEvY0Het6RLdvOPfgA+xEq2Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323746; c=relaxed/simple;
	bh=8QbLpn2pUoI0w15mR1Grxi/KK/33Mzhdmp7/SyYx+pE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ske7h9NZzgoTTLh0fGFJa/q9tVBhQhikYFkPul0x/UuTTXb17WpFNkoEgsksZBOQ54+47Ey6L7W91LdBoPH8uQMCqjSb3UjoMDS+YzxMu1bDzWWuTRCCR0P7GZJgr/09thX62ZlDPU+pmW7gohP9zOfi7Fscp71bzkuEQ8yXfP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIHamxpy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7768C433F1;
	Sun, 24 Mar 2024 23:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323745;
	bh=8QbLpn2pUoI0w15mR1Grxi/KK/33Mzhdmp7/SyYx+pE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EIHamxpyIKjf304CzYUt3LhhV3COyR6D/WWzeq/4D5suRtjlgE4dqm0xVU7Rjz8E4
	 z+64F1LgEtO3hLdRuBmzm4dpjR+yi9yXgBOPDijvEzUGQg1PJUL+r2dJEokCUVGA/U
	 3I3NLc437DSv0G5blnBu1covhdwwohIxWBCth0F6g2K8AJ8PRgzCTBV1fnFRjfH2hM
	 o4uby5JEm1lPZumtjm7Z04SdQE9HREBTdj8pxapCexKxU9A7H5iMvdOqkfPD7Rd/rq
	 3OlU2qZIcbOY3eaBkIfOvoUDmhXswkNEKeNaMpOZZTHAQ5ZH1Za8ojCbCl/y5SxRfj
	 nkGllpHSEDOaw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
	Quentin Schulz <foss+kernel@0leil.net>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 120/238] drm/rockchip: lvds: do not overwrite error code
Date: Sun, 24 Mar 2024 19:38:28 -0400
Message-ID: <20240324234027.1354210-121-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

[ Upstream commit 79b09453c4e369ca81cfb670d0136d089e3b92f0 ]

ret variable stores the return value of drm_of_find_panel_or_bridge
which can return error codes different from EPROBE_DEFER. Therefore,
let's just return that error code instead of forcing it to EPROBE_DEFER.

Fixes: 34cc0aa25456 ("drm/rockchip: Add support for Rockchip Soc LVDS")
Cc: Quentin Schulz <foss+kernel@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20231120-rk-lvds-defer-msg-v2-1-9c59a5779cf9@theobroma-systems.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/rockchip/rockchip_lvds.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index e2487937c4e3d..1ffb2f710e4bd 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -573,7 +573,6 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 		goto err_put_port;
 	} else if (ret) {
 		DRM_DEV_ERROR(dev, "failed to find panel and bridge node\n");
-		ret = -EPROBE_DEFER;
 		goto err_put_port;
 	}
 	if (lvds->panel)
-- 
2.43.0


