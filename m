Return-Path: <linux-kernel+bounces-116170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B22889A05
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0DA71F36DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFE72904DE;
	Mon, 25 Mar 2024 03:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNJjU9A/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67BD179FC5;
	Sun, 24 Mar 2024 23:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323747; cv=none; b=OJD/uNAnJLWlzgF8w+KgfD1hrvwTr+DyiuA34hTLToInxrh6Mw5WupcFTsmeDH3Ga89DSpP8nvLkABYEyd0i+2iUJT3xtNOHhLTDu2DP8reFQBvGsTExyaUXUZrhZys0GZCCXFQvP5e7yiakiu+SoAw8jSiL2qJQn1Bmn7BnFsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323747; c=relaxed/simple;
	bh=AoArj+1hGuzNCr+nrz58oSeri64XTy1+7yEFmRMZjmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HTnOGijOlME7cKwNQtNN4FoP9lQAJ4/2nTFM8pVEOEPZpN4n3D/f78Qrv30gl2EYqS7aq6KobhoXrYzed9IfkNVmxJ608y/C4XZGmAMEUwtLTPQX/kKouNV1iYhL6+0mVSER9Z7EQme4sGwv+bBnKLqmeJLk7o1ewpl88UwW5D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNJjU9A/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D212EC43399;
	Sun, 24 Mar 2024 23:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323746;
	bh=AoArj+1hGuzNCr+nrz58oSeri64XTy1+7yEFmRMZjmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rNJjU9A/luGNUq6C5mOZPwiyvdNZ9Bte47HTu0zjIWPScX6QLKCsVTYdIHkMi/T6A
	 R6+ExjoWMPOuNeUepBOP1Amop5joW7KjFK989VRP48RVL7rxwnVRkjDlJ9FlFeitk/
	 H4Ic4LZV2+GnLTIt65Hp26upwkf9CdxVzQAZ9jAFCj3/9Fi9jXLSQmH3c98JBTgQ/f
	 njJB7iN99oWsQZiwri+bMbXCOZdhRSIfwCMfObCADpQCibEwtk3M5VotVA1SUi05CK
	 ka0X3XP3JcPnq1NYTMhSXcLCu92MWYk7ItymQbwiUp/2sVkMwPinAqODJ2237PXEf6
	 l0S5aHAv4OFCQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
	Quentin Schulz <foss+kernel@0leil.net>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 121/238] drm/rockchip: lvds: do not print scary message when probing defer
Date: Sun, 24 Mar 2024 19:38:29 -0400
Message-ID: <20240324234027.1354210-122-sashal@kernel.org>
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
index 1ffb2f710e4bd..96c13c182809e 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -572,7 +572,7 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
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


