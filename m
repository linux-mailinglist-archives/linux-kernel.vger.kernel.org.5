Return-Path: <linux-kernel+bounces-114261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A24DF888F7B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41C0D1F24BA2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280B015B980;
	Sun, 24 Mar 2024 23:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hI64oaEr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BE020C03A;
	Sun, 24 Mar 2024 23:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321625; cv=none; b=mf53+aJj+ESm7qQuVws+BL6K3qDVa6RtnVgljeV3mCo1LeVmC+BD6bI34cFo9j7OfhOXf4n8cO9Yg/8kUu5cNUUbKNCH5HfctooLcsn7iYcTlCqfG+sEA/bnGtyejOoRNDc9eIRKViXswvS/hvOohYQ/Peu+hU2C1S54KumocM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321625; c=relaxed/simple;
	bh=N321SsALO94SeiSHRq0mWFeBWWQddhzmHDlaHmCj6kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yorpm+DPxEUZxibhIJllSQc0EJ9MqKi4E6hum5oqYRmCft16QohiBFgy+byKGplJwI5WoB4hoL9Y/+7/Dekqw3qlSbf2tX1T98VneGBIXMg2mJE1uXunX9XK+UZwtjyOegqVPBssdhah0gbt5PE0KlVPmc3nvqu0R17mdOFmDEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hI64oaEr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F43C433F1;
	Sun, 24 Mar 2024 23:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321624;
	bh=N321SsALO94SeiSHRq0mWFeBWWQddhzmHDlaHmCj6kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hI64oaErC0N5oGNGujE9Cg/X+29Mm3kmGK669zhsXhgWJJ18i4diO2wFIKNHnIhUJ
	 Qr+G8b+q51KHJ2mfXKP68ICo5KnizniPtTWrWu9jWIKogDOm2up4PJtkLH77ZnHpvU
	 Lnb2Vc/BQ+6jhfeOn5SbwnLdR092N+QEp5xGVwzQdQaI+B+UuxASllDkCsFcL9uI15
	 Um67VvBZ0BryD7OzBLPYxerK8EGNUVh+Crx+kBSkLs4fSMl3qW+aIYREOaCd5D7Ehq
	 1VgvVtP5m/poPnK5h7BdSVZj/a0MrxhxSSiHSYVOxxUP+Mc1Ek0HxYG5FPhutyo0Oz
	 YGRJJSiUmNY8w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
	Quentin Schulz <foss+kernel@0leil.net>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 355/638] drm/rockchip: lvds: do not overwrite error code
Date: Sun, 24 Mar 2024 18:56:32 -0400
Message-ID: <20240324230116.1348576-356-sashal@kernel.org>
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
index 5828593877923..27ef812ebc600 100644
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


