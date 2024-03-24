Return-Path: <linux-kernel+bounces-114243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BB4888F72
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53AFC1F220A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CB9255F09;
	Sun, 24 Mar 2024 23:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jESuOoYc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9524D152527;
	Sun, 24 Mar 2024 23:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321614; cv=none; b=J7WnsFQaHxpOaXzxptfrqMNJZFOPprMyHf7nFCGFJxl37Q0VOe99p1RMi4uMMpQW3Q51k0B06rHtm9ApriRJPuUnSqlzIJQvUbmS299xs21sHXLurWQbd5GpkHXqCIvxf4eStB6ZXjSKCJLrAEOunY7nn1YMKXF/F/BKcfq8SGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321614; c=relaxed/simple;
	bh=RwRlzPzxBsXC/idl0YVK+0djdxlWFSHYU/Oc9ReOMuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FaqUwWXb9zvwjGp6/og3lgMx0ft3TeV0HTP5TxxArtOvIWsl8kulMkXeGgg4S5+Ga4R1/rLBFVfXWrr5n0mPvS+mTU1TEG3Y6Jpm2SKzUdB9CclJbMykUQJxAbI0g4wtD+IIbFZD+1gzMnjqcrrXRaP7ri4mx184d1y8G3J3UkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jESuOoYc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB17C43390;
	Sun, 24 Mar 2024 23:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321613;
	bh=RwRlzPzxBsXC/idl0YVK+0djdxlWFSHYU/Oc9ReOMuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jESuOoYcwaUj3G/h3aDqKH8viwjIM0VwbuIAx5jjemkp7XcGRtZpnXGXK1MzuP1Tx
	 7TIOv1pNZ79Cs3zj1mI5fDXKsFjMgdgCfjKZQN+jr9p4tkQxM+JhYizjVFXPokT8+e
	 ioZHFX1HWfsa/DG0QTEMsJ+IHSDRZHEOpzoRFJdmo90zQM6eToLiDaw26qiHoYjnlJ
	 Lmf+TlHLCNdjgL2UGZ74pg3Opow6gHTMPaWkbYQfiQYA9/rJ6BZXYk0qjAcRIYwrnH
	 BhP2sauM4vmji8z1ZM3xzh3sm6/fR8E4SVBMxL0OKt69/fbEdLgCTvmR7pk6BzYQGK
	 ecAic+c1NdBHg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 343/638] drm/tegra: dsi: Add missing check for of_find_device_by_node
Date: Sun, 24 Mar 2024 18:56:20 -0400
Message-ID: <20240324230116.1348576-344-sashal@kernel.org>
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
index a9870c8283749..4101b2e012118 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -1543,9 +1543,11 @@ static int tegra_dsi_ganged_probe(struct tegra_dsi *dsi)
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


