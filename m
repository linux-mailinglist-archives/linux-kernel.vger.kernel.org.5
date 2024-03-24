Return-Path: <linux-kernel+bounces-115457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B708893F1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20D77297FA3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56636204FA2;
	Mon, 25 Mar 2024 02:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/H8ud4m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562841E61F8;
	Sun, 24 Mar 2024 22:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320838; cv=none; b=BzkWDkS1cY7ZdwjUG3/aHMnY89sCyj18HgXPoQ/Ol+EJ59dCF8YU166sEmuinBVt+h7QjBsZZuXBPcVNpeeNSTzT7LIEwvO2YXj0SEJTxq00CXt/9URLUX3hakckOG6Uf6s6+TzDZM5mkSqbNq+5/6g/UqqLuc3TXrucoiM6nII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320838; c=relaxed/simple;
	bh=MoV3PrzF8eB1c5ICEbjAs9c9Zmtha4fDS5vYVtWkFGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b4RP/Dj3nk4yzs8APUtvAJNv1gSxEQ9fxUSvPleTiJtGTDDc7dDwjYaapb7uPhG8k6hRfDfQYBBCC4OVxdnaP4ja/MjQDG2+PZVBji/6FWQbYioogVRv5oxB44ot1yrrhFOi+h7YKm1dZ1HjgHLwgugfYE1Hxj5O4zMxeqG1E2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/H8ud4m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E7AC43390;
	Sun, 24 Mar 2024 22:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320837;
	bh=MoV3PrzF8eB1c5ICEbjAs9c9Zmtha4fDS5vYVtWkFGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S/H8ud4mqrnPykiqYk2YgphjjBZntPuHzujlk/NDjEUfTNa+dpGAbs+sUQOsxVSye
	 C9dVD4yrVzguVSmEYz0yx35oLADg54/6UJ8o61/wMRN8f2yXM2ipbHsFmEcCn/5Ayd
	 okmiWs8woZIqU4ab5LghC5NMXlmNcZaeqRCC73yl/FH1i9JcQ7Ry3aE/qhlpOR6uav
	 2wflAwVn16J8N869E5EKKOKCxEB7srtWCIU5XlQpjGoWJJINiy6VARV0mI4dIr65TY
	 9ikeqcHYm3eBoWk5Am+HDp1iUiP1KXJVJCE9eQztf6PSvj9DVKNFmpqFnI6WAv5Yxb
	 +vfNCR8nIxY+w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
	Quentin Schulz <foss+kernel@0leil.net>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 402/713] drm/rockchip: lvds: do not print scary message when probing defer
Date: Sun, 24 Mar 2024 18:42:08 -0400
Message-ID: <20240324224720.1345309-403-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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

[ Upstream commit 52d11c863ac92e36a0365249f7f6d27ac48c78bc ]

This scary message can misled the user into thinking something bad has
happened and needs to be fixed, however it could simply be part of a
normal boot process where EPROBE_DEFER is taken into account. Therefore,
let's use dev_err_probe so that this message doesn't get shown (by
default) when the return code is EPROBE_DEFER.

Fixes: 34cc0aa25456 ("drm/rockchip: Add support for Rockchip Soc LVDS")
Cc: Quentin Schulz <foss+kernel@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20231120-rk-lvds-defer-msg-v2-2-9c59a5779cf9@theobroma-systems.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/rockchip/rockchip_lvds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index 17d8fc797151a..f2831d304e7bd 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -577,7 +577,7 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 		ret = -EINVAL;
 		goto err_put_port;
 	} else if (ret) {
-		DRM_DEV_ERROR(dev, "failed to find panel and bridge node\n");
+		dev_err_probe(dev, ret, "failed to find panel and bridge node\n");
 		goto err_put_port;
 	}
 	if (lvds->panel)
-- 
2.43.0


