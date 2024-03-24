Return-Path: <linux-kernel+bounces-115213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD2F888DC1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07C901C2A729
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936FA30EF02;
	Mon, 25 Mar 2024 01:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpqjwLpb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC3422E7E6;
	Sun, 24 Mar 2024 23:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324302; cv=none; b=RSpBImAslAMk/jStax10anGeeeY0/m0MCc00Rh9cebkbHVVIVSbVwb+cYe4z9Eugm2LMkBjSdKoTSSaOIapyj3Ga654jVQYY78+unpMH0TqpJGjD7rwPb3NxcYXq6XrJ9MYVeMPOK1sL3ZfjxR7yebFlHkiKXv0EKZO4EcZrits=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324302; c=relaxed/simple;
	bh=b1ImpgjqeU3iPayTihEvHsUtn/HigkooHHkmMme9Wzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJi9eLsCAr6UvqWZ6Op/5gCPgMC8EmponONlGk6HEpB/uEjnHSh8uZwqRGcMEcOToOB/udRynIG7HGl/Ji73fu2c0cc+kAgfNOzFKmXccNGAkHbpWHq+OKy0+uoAwAOBkb7Lq3qJ2zVYo9wBH9CbTExKy3MLkIVUm8QWcTUykd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpqjwLpb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61AFC43390;
	Sun, 24 Mar 2024 23:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324300;
	bh=b1ImpgjqeU3iPayTihEvHsUtn/HigkooHHkmMme9Wzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qpqjwLpbsMnOQ0YugrrqOB1AfQjeRgTzrT6+/OX3VltmhqoDb0NmCfs+tnqPQk+Vz
	 gJ73BUJpaig5BvjpWrMqtlMMqFKN363lwi7teND5e9tzfW2f6mFGDsZalZJzQ89ScM
	 cxwsSm9jUB1NviF9EismtybaJIwQpdN2mE5C0ueEJaxdhcR2kciNumeY3Kdj2dVNO7
	 i+2+BC91ZkEpbhwXIEC56NrQPH4w3v5SPdNtuSUYaFDjiiRKySwCJCXEOTBCUHAa9O
	 O7jqTr/LneenG6/VHJSbdIVFrzc7lEPUu3/KzoCTUZc0rI/0eCC6w/l+EeCsaKXsbY
	 00IEGLP3eG3bQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
	Quentin Schulz <foss+kernel@0leil.net>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 074/148] drm/rockchip: lvds: do not print scary message when probing defer
Date: Sun, 24 Mar 2024 19:48:58 -0400
Message-ID: <20240324235012.1356413-75-sashal@kernel.org>
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
index 215885c780759..39a17c46dbf11 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -373,7 +373,7 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
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


