Return-Path: <linux-kernel+bounces-116326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23834889E49
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54DEB1C35943
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F71186366;
	Mon, 25 Mar 2024 03:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pankwxRA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D0C294E07;
	Sun, 24 Mar 2024 23:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324295; cv=none; b=EMORG7CZamd+3v8lAJSJ9L7yMnD5e2INQ7ik0BPsUitbNgqJ/nd/7870dz23LTd+4ws5colaL/3SUqHtl2Qh0briVapFQmv44dBm7aPVzm+aRUwDX9Y8bpXA24W0nhRwC/OoUBw3K/l/gaCtXd18Bt9X8hkwngOlrr3nGUblrA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324295; c=relaxed/simple;
	bh=nwY4BXfYiszV2ZimaeSXexafpBAW7FnAPleR3Q3aaCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QcZ0OC2pZXVPxx7d5Y3wEZpD7XjtqPxNuDgKbREmBRjKiFgt6C3f5VGitTfXlupRYHUU5sS21q+XOuRQDWD/6lLiWc2U3k/EZzVbJ2jy6og1yhEjjvZcFj8jJ8P4aejNGB3kwG/Lwv+obsFoSCBtMziNSu+M+kOZs1JPsEVQwjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pankwxRA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4DFC43390;
	Sun, 24 Mar 2024 23:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324295;
	bh=nwY4BXfYiszV2ZimaeSXexafpBAW7FnAPleR3Q3aaCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pankwxRAYKDlypBOZn7Gr+wl1DcIzOETU8pb+AKNbJlhv9gtwEiSBZYExr2eunBCP
	 tKNrYct9WAunuawMjLeAloOTb9RLA2Ex7aXN/SDdWzlNalfsI3D9n1fV2NqikMTzWN
	 E5pFzVwG3vek1BfHfQNkotBocODHgGZBQXKFLS08HjN39q+KxgAKMrt/EeZndxDkjA
	 deuScqlfTNKcQ5iGgdRREq/7YJikFkqRKW+175RZAR/qfiezBCXifEOQNF5fJWaiYg
	 Y7fkQIlwxH3VotzshPX+GTRTtZvsqNWX8I5uhcWV5yeBZunoTgEhXc/Q9lfULyggxF
	 /vft3rJbgzzOQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 070/148] drm/tegra: dsi: Fix missing pm_runtime_disable() in the error handling path of tegra_dsi_probe()
Date: Sun, 24 Mar 2024 19:48:54 -0400
Message-ID: <20240324235012.1356413-71-sashal@kernel.org>
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
index 44bf5a731ba72..fb7b000d4d341 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -1583,6 +1583,7 @@ static int tegra_dsi_probe(struct platform_device *pdev)
 	return 0;
 
 unregister:
+	pm_runtime_disable(&pdev->dev);
 	mipi_dsi_host_unregister(&dsi->host);
 mipi_free:
 	tegra_mipi_free(dsi->mipi);
-- 
2.43.0


