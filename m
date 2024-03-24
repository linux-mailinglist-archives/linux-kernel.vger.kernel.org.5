Return-Path: <linux-kernel+bounces-113254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 272398882AC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3C9428313A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517E06024A;
	Sun, 24 Mar 2024 22:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9iyN3o5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA0B18766B;
	Sun, 24 Mar 2024 22:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320054; cv=none; b=bPgtK1CROSRsZOqCTLKK847PlXdL7yI+m9GWnqtj+m9Pglv3ABtZ6/35XDDH6dnnTYSHjoBGtrZL7ba3gtxgkhAMo/oJ9Sjqb7EdAeAWD6D23dbdfF4i3vCktioqjg/z0Ne32k0CjBhMhoS3YNskA6Qe5GNZ8nfZUR1NSu6zIXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320054; c=relaxed/simple;
	bh=+m8PgEc4m1hDp00DWZW3ySf403TlbRokQ8MybhoqIVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NUURVzsk9EiOllPkSZqbkoVl47rXAK+Ki37aYVyPaBEDSQkDBeo15h6q9Z3KGp7vce9nmG8tBP7PXogyxsJe7Jn2nF2NN9NH3ZkM5QOncWjCviWloAh4Un2PMS1ntfX7SFPnzkSEODpb2TAI4Sp10ILuxYbZ57kIREBYU28xouc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9iyN3o5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52575C433F1;
	Sun, 24 Mar 2024 22:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320054;
	bh=+m8PgEc4m1hDp00DWZW3ySf403TlbRokQ8MybhoqIVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S9iyN3o5UAqlA6DrqKX4Kmc7ZMx+2lSn64BU6ne2ReV/Pda4BCg0jsNKtY0fQLJdQ
	 718/bDtNreH1h/ZXhzltSklmWDjN0wvixgL3I16uZWPHrAj3JoGNp1e+gDWsFdJIIu
	 lmksAFMYSecOwEFoqilHoDB4+ez7GnhQ923a+acvMN8g7Gcb9iRts0eSFgeP7xWhXn
	 OVBKYH1qaNlbbY+kzb+rccjCXJ05P4q1w8XM4lb5WVoq84haPeo9D1IX3eVUUak3Ad
	 LtDSjl8Av8nhhd8VB18c9o3nXtAPctBbm/B94H3Vng7uyvzwdSgcCphFqmuwgzIYi+
	 qVIzfAXaECDOQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
	Quentin Schulz <foss+kernel@0leil.net>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 363/715] drm/rockchip: lvds: do not print scary message when probing defer
Date: Sun, 24 Mar 2024 18:29:02 -0400
Message-ID: <20240324223455.1342824-364-sashal@kernel.org>
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
index 6ecb6b8a1dcde..77b76cff1adb9 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -576,7 +576,7 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
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


