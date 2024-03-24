Return-Path: <linux-kernel+bounces-114516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3F7888AC8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C7381C2911F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CE7181D1E;
	Sun, 24 Mar 2024 23:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czW1NO2l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA98149E05;
	Sun, 24 Mar 2024 23:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322158; cv=none; b=AyBVodA8RNfDBSmXq6tomYCmLl/qWvvmayO+ortt3xZ3/vb8Gf3CkwGKm7MYRtlMQ/ILbORiWDAoF2tFUm64WRjwU+/B5KzF6br2ryEjz5P0zWHfqBCEw3eRdLMghns+aIl/V2l4XTJOwshcXr6xfJCB5YL5ZhmuEoBa0k/bDOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322158; c=relaxed/simple;
	bh=V+QTxs8ZNX2e9Unfo7ANnUqWpeXj6vfwQlIB3jSMCBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhZhrXSR2F48UaRa0ISeaIIGTZiNvuU6wlVCLDb3VJLgYhiuSpbjVbabeic5ylhS4BcZamp4kdIXbQG2CSFueGg2ERC9XswvQcWT25hu8yxdvGW0+ST+rrfN5QsvqkCl8TamBfYGeD3+M4IQIIsLBuLPGotLgJCjf+b34Uee9Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czW1NO2l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B912C43394;
	Sun, 24 Mar 2024 23:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322156;
	bh=V+QTxs8ZNX2e9Unfo7ANnUqWpeXj6vfwQlIB3jSMCBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=czW1NO2lJ9Hlq4BgwGj988gfqzYAwENlCWnOssi45yP8hXQErQXDQak0SwqFQsXZz
	 gU2lU092n+HBW8KfgHJceT8VtQSR4iLUdKbOfajBnujFG5HFF5YKqAGuBmxRfbUzSl
	 F/1yOATnjwk0xolRw90URp6G5Clm2Zvcnq7ODfJeAsoucXpMU0tRPF6KXk36+nP2SH
	 YiALN2kXF1rGy01vRZfQAC0oWABvf15k5E78Wu2QyZl+5WVrUxa6H5SUY8QB4J5TR6
	 yfEGGirEyA5pcoq8cPbkXIqLEavYm/SanHG296ePcRAtl2oyBkhUzdoL0B3slhxEVO
	 kU4J/fvQYpOHw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 234/451] drm/tegra: dsi: Add missing check for of_find_device_by_node
Date: Sun, 24 Mar 2024 19:08:30 -0400
Message-ID: <20240324231207.1351418-235-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit afe6fcb9775882230cd29b529203eabd5d2a638d ]

Add check for the return value of of_find_device_by_node() and return
the error if it fails in order to avoid NULL pointer dereference.

Fixes: e94236cde4d5 ("drm/tegra: dsi: Add ganged mode support")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231024080738.825553-1-nichen@iscas.ac.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tegra/dsi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
index de1333dc0d867..0adce882f157b 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -1534,9 +1534,11 @@ static int tegra_dsi_ganged_probe(struct tegra_dsi *dsi)
 	np = of_parse_phandle(dsi->dev->of_node, "nvidia,ganged-mode", 0);
 	if (np) {
 		struct platform_device *gangster = of_find_device_by_node(np);
+		of_node_put(np);
+		if (!gangster)
+			return -EPROBE_DEFER;
 
 		dsi->slave = platform_get_drvdata(gangster);
-		of_node_put(np);
 
 		if (!dsi->slave) {
 			put_device(&gangster->dev);
-- 
2.43.0


