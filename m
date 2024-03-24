Return-Path: <linux-kernel+bounces-115687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A2C889708
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C0D91F35F8C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3997920C810;
	Mon, 25 Mar 2024 02:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHGVo9XC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20F320C033;
	Sun, 24 Mar 2024 23:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321626; cv=none; b=E0xOHUebXroP3MIBujjsHXiFj6LvYMas+pU/T7Tec/ji28NYdYsrE1LoMpxiWq+h2N3fwVW25fB6FenKUCrHjnb5Er++3RMtk1hY4yvYUzDD/8/hB2qcIAbW5tV/c3X2kaoh7w5srH37zclfo8n6Gi2aznkrzCfI2QeZ11VehEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321626; c=relaxed/simple;
	bh=phtozzL6Xq1os3vEllHWK/G7UWJMmmpflz3kUIYTM2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aGwXLG3t23WipDWteuspG6ekCTPyUUCN6NUubWZfcW/IqfALtztHQuKzLwbue+S9Ag+rIE5GmdyYVILxLlLLBHZg/bdR0qXSs2O4xtSmIIpId8pzsZDRuDyAUdg4T2PGJfFFTdzvKqU8pmC8mcmfbZNu4Z+NmHNuBfxSxEW4oEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHGVo9XC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 145E0C43390;
	Sun, 24 Mar 2024 23:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321625;
	bh=phtozzL6Xq1os3vEllHWK/G7UWJMmmpflz3kUIYTM2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KHGVo9XCdTvK0ITDHPrIYFXYF3BW8gNl1nI6MzuyznUPX1lCybrX6mCJJIUVmX8Qp
	 5EVF1d8QaQCbAGk9xjoxh6L6VNEmDXTCze6fRO0tTvqjU5T+LKH8MQo9LkQzUv4g9f
	 Ds0vxaEY8mi5c6pgsSOLQOHLn3v14pgWnHisjqptbVCWL4/MfJUrSGFqQjyQxC1mv4
	 O2g8y9o9VFRryaLtMsBwrF+SpWOJnqAS/FxPBMj25mB1/3aYsVJyW5mshDoWXCX/RG
	 9m1SveAxPzBUmkWTbv93iKFXQK5N5XSVZGxXfndUr555ZcMt0DXADtwh1/YS7NyRJ5
	 7DNLlH3Iff3Zw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
	Quentin Schulz <foss+kernel@0leil.net>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 356/638] drm/rockchip: lvds: do not print scary message when probing defer
Date: Sun, 24 Mar 2024 18:56:33 -0400
Message-ID: <20240324230116.1348576-357-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 27ef812ebc600..1b6e0b210aa53 100644
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


