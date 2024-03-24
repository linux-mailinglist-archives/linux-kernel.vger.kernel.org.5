Return-Path: <linux-kernel+bounces-116054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A97F889535
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DE021F31027
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B772779DD;
	Mon, 25 Mar 2024 03:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSDHZ4+H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F14627899B;
	Sun, 24 Mar 2024 23:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323453; cv=none; b=ND+n9rrhnz6N0HM0bOF986NJKMlbI76f2X3xw/pKxgTpD3gQByZgJzZ4sjcqRLUzuTy3+Qv518foejIRhk5VgTVPXHmmE6FfKgFrFHItBPBlsuqip5i8+9+t0v6NCJThbTGkFUhQS+k5v7AeiLZh5SfPDXSInRQReZOtSVK4zT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323453; c=relaxed/simple;
	bh=V+QTxs8ZNX2e9Unfo7ANnUqWpeXj6vfwQlIB3jSMCBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDJqPDaz6L2qZrETR/cPcTtSycszxSKeL8odm4BVRk5KaaawkxH+ia84TX5skKGJnm/+BFKr1c3nQEe46RBcOQytlWyIfuLXR/UjgunSE/XYu102W96C9u235LmYfF2Pn2YGyYDcthPZ0qkYsxLnWM5xlojD+pZywut5Zv0aw7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSDHZ4+H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E50C43394;
	Sun, 24 Mar 2024 23:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323452;
	bh=V+QTxs8ZNX2e9Unfo7ANnUqWpeXj6vfwQlIB3jSMCBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QSDHZ4+Hcjn05x7qKjJC0Fl4mTZZ2KdXYwgtWZgVQ0BbpoG7EHSFyfN8OduIVWAw/
	 WjWKPBux3T8xfe8e5Em8w7jKJ3WKv2sZVsCpBdGBneQd/OZE82tbUMVJ/opTv8/SdH
	 riDWS39cWYxEGP1Eh8OHUaumYQVvavC93r8jn4ED2dWipP6C4zPErpa210avZVFePF
	 ZB84PjW8TK3o1/NNR/aEb9M9CbqmyWDEEimVPZVgTNtkALCr03HNojITqrfAV0UgFx
	 KC7QJy7xja12cxrU3pEkVJXbytPfc2EXJnmWOM862PyN1pGn1gNeO2bbd8SBbWPphS
	 kqPNxGOtqRVow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 156/317] drm/tegra: dsi: Add missing check for of_find_device_by_node
Date: Sun, 24 Mar 2024 19:32:16 -0400
Message-ID: <20240324233458.1352854-157-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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


