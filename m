Return-Path: <linux-kernel+bounces-115455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD76889BA5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A6D2A7166
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EA52197AF;
	Mon, 25 Mar 2024 02:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Su5kOIGj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211D11E61E6;
	Sun, 24 Mar 2024 22:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320836; cv=none; b=j151zVkc30AalDqkAhQDb7BLIduuFwqv00clbwRwsCJKrUTSSyJ8sIrLn9zXtJLhV9hHhobyO3ya6ISrnkrvA0XH5wJMTui/46AQODiiU3VdWzRxPofGxire8GH3vf4deNWQtYuhj/gQuvHXkrBMkjYr1aFq2eIj0YRG1UPr6ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320836; c=relaxed/simple;
	bh=m30wCZoV79dMVizD2Gw9W9KU/gugpO1FkI8VgtWsYKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=THjkqX1bpWEr9hTl2OFecX/MXBIsZgAb4dSuHrck8WsC622tpGWKvnBdy6L4TN+OPLTcjLBw/VwnTDeoEcSzLO7kjXzW6/a4EVT9L2+qYS71QuxivUwQ8aEj7S6dWrvA929zg2RxHreyGOPEq+eoS+xwb0dHdUL9cfelsDNZu4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Su5kOIGj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A18AC43394;
	Sun, 24 Mar 2024 22:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320836;
	bh=m30wCZoV79dMVizD2Gw9W9KU/gugpO1FkI8VgtWsYKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Su5kOIGj/4DHtUq3oH5jmLYesX3+nGmsOcmm/u5uvTyH/NNHoqxov2oELEjH593KQ
	 UiZuogk+4THLVnobxeSSrxVHK6ArDkPnwh4+oPudl9Xn2u0jC+VUtnTSHRELTajUEs
	 2PaPedbcg8pxyAJcHKP3Ig2r0OE6SxteZSXhbXINKS5vmewAz2oJCPKHuvUQXTYQyi
	 dZoPpfmj7o62EQnUOXuMer69KyMIclpYusdWvm22DysUGnvljf720pU9Q/UmLeQwQF
	 XlmQCv7Y7nKjnwdtQw4oDIT3GFv/eFXg/eEYZc99ACXh4UsTSHnIvarJq3ruw2iI9C
	 1oWZXznws6cQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
	Quentin Schulz <foss+kernel@0leil.net>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 401/713] drm/rockchip: lvds: do not overwrite error code
Date: Sun, 24 Mar 2024 18:42:07 -0400
Message-ID: <20240324224720.1345309-402-sashal@kernel.org>
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
index f0f47e9abf5aa..17d8fc797151a 100644
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


