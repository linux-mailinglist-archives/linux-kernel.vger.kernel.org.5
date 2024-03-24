Return-Path: <linux-kernel+bounces-113244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 965CE888298
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D1D283542
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BAE13C9B5;
	Sun, 24 Mar 2024 22:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgLKdurT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33705DF05;
	Sun, 24 Mar 2024 22:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320044; cv=none; b=HQO3e/J5F2T0Bfb6mk9dMnARmXp1QGLf6GZLeymRMuw5U1wzORZJCO+O8Vd4hxbBc7Knnmk0kuje7TAOuxQpFpFunGVFTz7RLRe7mZjJegOqaK4cv8gJUdX0rLBzrOct6itnfjf/T1gH1Je3Yz1ep5Xb660t7xO/7Tz6Suw0QH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320044; c=relaxed/simple;
	bh=H3YOOhBig6iwhtefRcb2o7O5wuSRi1oZdbrtIM+94i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sNX0DehHUhSmCqWxrNth4F687rwW5Glt+Qj9uINpagYwHPcme9qeKfqkPjYWdt5J85bBrSok6qQs4pLu7/nTsxPeQp246uyf7ndXuXaKY1O4/pN0fUTcAqaI7MsHCpjoPKqmK6YhQ82VFBa5/42YbwmdPFAfjb55tgqErIkW8Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgLKdurT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E356BC433C7;
	Sun, 24 Mar 2024 22:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320044;
	bh=H3YOOhBig6iwhtefRcb2o7O5wuSRi1oZdbrtIM+94i4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GgLKdurTB13tB3j2bJV1Yqyr1eu+rdwf6QegniUoxhQ7yTPgP+st6e8d6zOC7ByW0
	 dBmLggDruqNs/A2C0/s5tGAjB4E0IiIHKUcG+JW0jD7OtDbLhsDVvlJ1+y4bDYTHFg
	 8iXsY0M5MNk454+6i6b1UYocDrDIPBjGqo7H9WhcqaECWC6fiWTWvw9mTeWjTH650g
	 RWqYPuJZzgZ8vgK9JLpKtLLZH+yp/UDih3JSMgTyv5PHB3UHXLh4ssgHMTrcuhiw8S
	 Jrf+Lnv7XsPoP27kCaKZv/5rmjVgnwJSv958C4+lMnLoLjQsi2pJtFQ+TllCJEHFIS
	 1BmtP6DHPY1fQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 353/715] drm/tegra: dsi: Fix missing pm_runtime_disable() in the error handling path of tegra_dsi_probe()
Date: Sun, 24 Mar 2024 18:28:52 -0400
Message-ID: <20240324223455.1342824-354-sashal@kernel.org>
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


