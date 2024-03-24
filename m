Return-Path: <linux-kernel+bounces-116272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 388AB889DE4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB9B62C3E99
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9C03C9541;
	Mon, 25 Mar 2024 03:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYisw6EJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC0F18180D;
	Sun, 24 Mar 2024 23:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324093; cv=none; b=WLXoDB76GETgX094qU5BRT1bsP5Uv1dJ1s+hAX3dJQCQuRGndvf9SzgN4wGe5XkfKth5TAKYChlUDdqF0viark8gENfHpDqnqS53/mWHHqnw4rjajoLJ3PuNEIYUSHdN7K4oQCxslQygYyCy94gVOYpJPGMfIz4YMM7acSedM7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324093; c=relaxed/simple;
	bh=mUZJ4M1ThCoqEaA1I5K1dx6M2ULcYfgoaPkKU0j4/SI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bl5lzCuYs47he2ur+MS9czNhbtUF1YoLCAadTAAJWhkSz4xK9XCImHuYq1taszf/Y7JTKIbn5Owh1O5vxqEyBQDtRgvnwKXMZghyKmApuCdfloIjcls6Bg0jIgMWtHPB7bCao/6rPVcRO+mGSXoSLnVoZ8kCyiXtzdg4UmmvD9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYisw6EJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655CFC433C7;
	Sun, 24 Mar 2024 23:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324093;
	bh=mUZJ4M1ThCoqEaA1I5K1dx6M2ULcYfgoaPkKU0j4/SI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kYisw6EJ34YyuabQL4F3XSkiIpjglgUp8E4sLkCVuI6EhFL2fULZO7FtpjC8m6UBK
	 qj9Wj1awmZel1HkyRfd5sMZkGHcB3sWDYPexEoP4uUzHsha8xwdaZEuuo2Srehe3W0
	 n7Ou0VRPQwfGL+wxu2em/fbzNB4v/nIG0yZnE6QomwYsSKLmmq0phKmzABW7bJ7xDt
	 M5eU3+iP2IPrlLFWtgEcuCt3/5V1LmdtcIFt6tlnX9NW/M7x0jopiANlDn1PmtBcr4
	 C8WpqlAmQXdKoaTTu4Ra0wfn1bItS0ZpBRWi+5l2fX2eK/7jMXxi48LiIR4HVEUtjW
	 Yr830ksnlmiJg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
	Quentin Schulz <foss+kernel@0leil.net>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 093/183] drm/rockchip: lvds: do not overwrite error code
Date: Sun, 24 Mar 2024 19:45:06 -0400
Message-ID: <20240324234638.1355609-94-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index 64aefa8568963..aa8212c721b10 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -366,7 +366,6 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 		goto err_put_port;
 	} else if (ret) {
 		DRM_DEV_ERROR(dev, "failed to find panel and bridge node\n");
-		ret = -EPROBE_DEFER;
 		goto err_put_port;
 	}
 	if (lvds->panel)
-- 
2.43.0


