Return-Path: <linux-kernel+bounces-113253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 056C18882AA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE9091F22360
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9C218765E;
	Sun, 24 Mar 2024 22:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxNEynHH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D029187642;
	Sun, 24 Mar 2024 22:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320053; cv=none; b=nlq+pVVCSQYvhtlA5tU67we14UF0xwUIP7Zb+qohIvsCiVRgoMcLGc2dYQyZNJ0nHeSiKL+8T8frr+5hpKXRA3YuGuxqpzcaZQY1Q+N3mKJkVkVm3XD94dY1bL6L3UAydH2ctaQJohMRHZzQf1AvytaUzsK6OqNleNG+lxNixs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320053; c=relaxed/simple;
	bh=2dsSi5JtAsBqm4Skku4k42Ycxqzvl16liEF0hci/lEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f32+RSJMWw0tuQhZ6mZJZXl4z2zdEwneceVYJyefk/u8dhGbJ675D9GO8X6WHe1GmkMT0dLVqFX1jtUqYCOuvjgIEfeNGPGGvWwGtzwrjAohj6jCdF5WjaxxPbQUTbjugVPnlKy42j5RHbRrL7tHI1DN2oBUIclTdURhPVjDBt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxNEynHH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5649FC43390;
	Sun, 24 Mar 2024 22:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320053;
	bh=2dsSi5JtAsBqm4Skku4k42Ycxqzvl16liEF0hci/lEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TxNEynHHhwk9Sw1EPg9IDq4nVLdOoZ7RkfDsntaCBO40Llw1E6blHTvLYhvCsxPJ4
	 gmz+sW4YfV/0RP8s4cgULilYDMr47myMSZz7oJzb3cHnDBi2m7taEXiK0b6Hf3zZfM
	 JfaTakFKMKJvKaviGMUMKJgFXNbALO/6ubRzah3tN+DPIcqrsnVzV299l79A2cZiMb
	 xbV1z2SPhjemnBVjxG8vd/imdXQXUtMGgDiSERwISefdDH/ulTFzCKEFW16sHvjExD
	 WE+61uGmGKXFyltKRZO3fopOt96ZfHB+R9e6/uIsPLBUsAyqs8jvmOw+7k3d6XVj2l
	 jTJaF29cRQTFA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
	Quentin Schulz <foss+kernel@0leil.net>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 362/715] drm/rockchip: lvds: do not overwrite error code
Date: Sun, 24 Mar 2024 18:29:01 -0400
Message-ID: <20240324223455.1342824-363-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 59341654ec32b..6ecb6b8a1dcde 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -577,7 +577,6 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 		goto err_put_port;
 	} else if (ret) {
 		DRM_DEV_ERROR(dev, "failed to find panel and bridge node\n");
-		ret = -EPROBE_DEFER;
 		goto err_put_port;
 	}
 	if (lvds->panel)
-- 
2.43.0


