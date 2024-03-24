Return-Path: <linux-kernel+bounces-114537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB52888AF2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C1321F271EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06911291B66;
	Sun, 24 Mar 2024 23:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezkxc+Tf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2BF22BBE4;
	Sun, 24 Mar 2024 23:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322170; cv=none; b=LjtKlc020cAEdGyGfQgbZcIz805l8Q8srP1qN1ZBKyaNEoS/7gOC9PxXj+J37Gi4hiD/9wdqyAk4mljeyW+OFk/NRYBIU0S787Nw08Y3GbSGVZJaAqEgbAaP1T0BE4S7wVlmXycd/gnrlMw04ND+sXb4iawNNkMpORpvEKvmdQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322170; c=relaxed/simple;
	bh=4aNxRsQip9VxH0hLR7pozAeJ63vcgxQPhA9hbcz95Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=klMSZ5qi5X3eorahvzQY1dedN5WksS3WRvIlgxURd457tkzU8Np9rjYctqLF+H17Ic1w2Do5hMuN+ekapDukoRJwxC7kbi+U6zuHxwKT6o/6AMH45g17oNFMmaoxMSyB8khN0vPYEUUslO8kFCN9rx13uAzOw5qVK1dOZeqNDI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezkxc+Tf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22511C433F1;
	Sun, 24 Mar 2024 23:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322168;
	bh=4aNxRsQip9VxH0hLR7pozAeJ63vcgxQPhA9hbcz95Lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ezkxc+Tfh9y8bnXL+8wrKmvj1okWca6IcZR0fFfydRz5dwsfFDVGQbQBZtqYHWroP
	 TF0lbUmSGNc6AIjoe/QyFlXoT6LnvBhVYn0YnfU+kyLKueHLXflGUXMqGoxIbitYnc
	 FZh5aQhqZHeIHxIhtPY9ix6la6GHDNiZV6rtJS0NI2nNsedtQqfwpuslRW8R1527yD
	 og8JT644PcFez8PQslcC8t5LYS/yHiZWkoc86P92BNdm9wUXg1WTCRZDxEeGeuNAHl
	 tEgC5AE/GNx2X1ojGBPNF/4hr+ERdHuzeQcnWC/FQYDccjws0qVuLjznc9Jbv6KkS4
	 oKWlAwrsPNRwg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
	Quentin Schulz <foss+kernel@0leil.net>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 247/451] drm/rockchip: lvds: do not overwrite error code
Date: Sun, 24 Mar 2024 19:08:43 -0400
Message-ID: <20240324231207.1351418-248-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 68f6ebb33460b..1fde888cdd827 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -578,7 +578,6 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 		goto err_put_port;
 	} else if (ret) {
 		DRM_DEV_ERROR(dev, "failed to find panel and bridge node\n");
-		ret = -EPROBE_DEFER;
 		goto err_put_port;
 	}
 	if (lvds->panel)
-- 
2.43.0


