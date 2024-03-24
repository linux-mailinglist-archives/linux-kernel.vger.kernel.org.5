Return-Path: <linux-kernel+bounces-115209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7FD888DBD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD9422967A0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A0A1CBBB8;
	Mon, 25 Mar 2024 01:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8fxdZDH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A7318433C;
	Sun, 24 Mar 2024 23:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324291; cv=none; b=CJe46xXL+dXaDuR/KiIfPBHGqfiL+lV7Sspn1n1Ps8sUWLiCrnFP+0hBf9Ffw9G+SQj9NbgcKP0HAPIMlPol2JJL2ICLfNq/ZqbjVRpnEkGUQ90cKxujokYNbg7VYAKpMHTValEBXbYXcgiF1iOvf6v9DRMtS+6eUrEFatEHky4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324291; c=relaxed/simple;
	bh=FQx08IgEuuG/JJmoSLZ6AkS4KoSw8v8dVldMzdTD5Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GeFjgZ24ARbg8k0ZuA2BI2VUy3n8l4yhDGDfxoBy1hSrwVolXwultexSWF8RBhCscIvNNMpJP+cxqcA5am7AFjIDd7iRk2cBhOsbbxNQa0zSVlWwI5hkn8lD73i6xm4jgzalm08BmLE3XzsG5aQJOI/ZHgh7v6RiOdWGwnRYoE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8fxdZDH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F38AC43399;
	Sun, 24 Mar 2024 23:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324290;
	bh=FQx08IgEuuG/JJmoSLZ6AkS4KoSw8v8dVldMzdTD5Tw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N8fxdZDH+gHuKf7j5jJRKwHjdFyre9pnQZwDtIexZ9bCfJWTUQXzQl64Dp5R3Q1jZ
	 Y9LdtCtAvSPSzxhzmm9fYTK/a6KO857HMvCMgN8jDulgHHHCHRWIWcZOOzoSVkZYA7
	 lr7sLWsHquJ7e/WKIXkp06i4y6PuHSK6u6bxkJavyioaGIo23FmUFd/Q+ioS9FPw8l
	 5pqK1mgHqJNVBQ+uzuWyFrMGu+KvsiWuj8+jPZTxIHFNsp6i6KaGzcKtFycwYRqUqE
	 HmRFjSww0oBnPtg38Eur5KTSV4Xj2MhfoAbGbXEgRyZBRD/k+rqimxguZXrFUX/E5B
	 jAuJGJGv/CDVg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 066/148] drm/tegra: dsi: Add missing check for of_find_device_by_node
Date: Sun, 24 Mar 2024 19:48:50 -0400
Message-ID: <20240324235012.1356413-67-sashal@kernel.org>
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
index e2903bf7821b1..70cc960d3ff58 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -1452,9 +1452,11 @@ static int tegra_dsi_ganged_probe(struct tegra_dsi *dsi)
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


