Return-Path: <linux-kernel+bounces-113809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DB18886B0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4CD71F2513E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4168614EC45;
	Sun, 24 Mar 2024 23:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNva8bYp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2CD1E5860;
	Sun, 24 Mar 2024 22:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320828; cv=none; b=pmwm52FnIrC5aYE/v96DTBdP3mTsU9zjgZ7M0ofDvURveCNiEKyYgChRGkZiYjajCECNNdDI4NmddKV14kg+64EFae+0rq/VE7QBB63kZXGevCvnH7fVvCDdLU64iVSzDsppp4192gnUcW6VQKdL3TQvLuA+plVbGIK+sNWi3Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320828; c=relaxed/simple;
	bh=H3YOOhBig6iwhtefRcb2o7O5wuSRi1oZdbrtIM+94i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vDVZsfSH6DxyHyabEov1pIk2h8Qct6Wqq8GaFCwHRomeuuBJ+e5OynCaMbTDma2KkIc+d7nkD2orjVKLGglQXh9FQ6GhQKMF/TQGV5m6nmgxDibJ67io3L6yRakQokip48p5Chf15m2HUn09X0L5Z806LPPMj87IpuSVvjWf/pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNva8bYp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5D3C433C7;
	Sun, 24 Mar 2024 22:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320827;
	bh=H3YOOhBig6iwhtefRcb2o7O5wuSRi1oZdbrtIM+94i4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iNva8bYpWhJ9o+6s+vs2FYuGwAGwlRDjFdRcyALaiLOQ0cza54Jk/SKS86rdLqEW0
	 F6eOshZ/Inc6aZykHoC6nAyX27wYm8lqmUp1fV6dWn9dr0i25IJLssKYKm9ZozgBss
	 qv6eAoGSdz+ttgKI6IbzCSDnBlWBUVe0dyJqGYHq9kJ8pNtCzJix0cDJJDU+C6Umgu
	 mBJhoqDAP+YQAZWSBo5iFOL7BFG75youOPfrg+QF60Sq3fBC+MXSw93R+xN+SxX5TU
	 AL0iG6j71plm2nITgAU8Owsd13IFE6XKmspXyHuKsz0/Kfm2zKeynDg5G3gmRC6KeI
	 72+xaiHSva2hg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 392/713] drm/tegra: dsi: Fix missing pm_runtime_disable() in the error handling path of tegra_dsi_probe()
Date: Sun, 24 Mar 2024 18:41:58 -0400
Message-ID: <20240324224720.1345309-393-sashal@kernel.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 5286a9fc280c45b6b307ee1b07f7a997e042252c ]

If an error occurs after calling pm_runtime_enable(), pm_runtime_disable()
should be called as already done in the remove function.

Fixes: ef8187d75265 ("drm/tegra: dsi: Implement runtime PM")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://patchwork.freedesktop.org/patch/msgid/ee4a15c9cd4b574a55cd67c30d2411239ba2cee9.1693667005.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tegra/dsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
index 0c8ad8ee5009a..db606e151afc8 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -1675,6 +1675,7 @@ static int tegra_dsi_probe(struct platform_device *pdev)
 	return 0;
 
 unregister:
+	pm_runtime_disable(&pdev->dev);
 	mipi_dsi_host_unregister(&dsi->host);
 mipi_free:
 	tegra_mipi_free(dsi->mipi);
-- 
2.43.0


