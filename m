Return-Path: <linux-kernel+bounces-115200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E656888DB1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30891F2C72E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB8B1CADC6;
	Mon, 25 Mar 2024 01:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dg0lzkn3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AA0294E3A;
	Sun, 24 Mar 2024 23:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324300; cv=none; b=NXn+4q3yqUH2CYbhS9ypzLGbIRXVzGQXRuXxTr15nrbrrOPco2tZt08dXfAmTBJIuObb4jpAwhkzgSLegDQeHlTmh+1+svussXoimsADP8+fowMtKzIdYGP3qCnEGUgcwr6coMXkLsYNsQTcuSkTft7IzQOa2XdJ3QDwSQOS/F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324300; c=relaxed/simple;
	bh=qHUqDEVnUyC8jvQK3TsQQlVfLcutvmYMKDDZVZDmIdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQ0Q4bEoz5T3lWKvHtI7GNWN9uSPpl9eIFy9/M7g0JeAhHjdVENpdFEo2iIeNz16SgNgPfP3BMoCqXfRutx5XUC73fEqX0SlrfK8BwJ6cWcN4qiLWtdPl28sQWYHtNMp9rLlYTzbmmcvVmUD13sBDMjB7RmTn5DH1Hd57d4giuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dg0lzkn3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873A2C433F1;
	Sun, 24 Mar 2024 23:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324299;
	bh=qHUqDEVnUyC8jvQK3TsQQlVfLcutvmYMKDDZVZDmIdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dg0lzkn3CRvy1E3MOrUkWdu//083Rj4HvR5UQxp56c6oBQGzeenvGW5+GDWJKrZXG
	 U4eqSZJeayvXQ02HZLCtb+CLGFA0AEDKs/p+pIEipUW9qDO645MdWlXBWcR5hrNjrx
	 MICRK/Acf07B9T/Z9CFw3NMCe4X/1GcIK5yYRAXI/7LRIV4Tv7c/wfp5mlWmnFe/Yd
	 k6fh1O8Q0Jmj2yTVUdzAcnReASr7CECeAgYnZ+lJRxuFvio583XlLoYhWd4lXjI42m
	 MK4iKO4vvm1/qxIQPgWfKveKN08Vtv9f+E+yEPv90oot5qo4rvL6ilaACglb1tTlVl
	 pCntXFdGFgGiw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
	Quentin Schulz <foss+kernel@0leil.net>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 073/148] drm/rockchip: lvds: do not overwrite error code
Date: Sun, 24 Mar 2024 19:48:57 -0400
Message-ID: <20240324235012.1356413-74-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index 456bd9f13baef..215885c780759 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -374,7 +374,6 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 		goto err_put_port;
 	} else if (ret) {
 		DRM_DEV_ERROR(dev, "failed to find panel and bridge node\n");
-		ret = -EPROBE_DEFER;
 		goto err_put_port;
 	}
 	if (lvds->panel)
-- 
2.43.0


