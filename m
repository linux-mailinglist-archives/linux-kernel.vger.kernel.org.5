Return-Path: <linux-kernel+bounces-114993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCAC888CC9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 538AEB2D980
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFA22E4411;
	Mon, 25 Mar 2024 00:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNCjVQkZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBC8282A72;
	Sun, 24 Mar 2024 23:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323739; cv=none; b=GYPorMD5LQeVWeueTgfUE1CzLj67gzqo659UzV27i0gXz1eu/okbpAT5h0Zyp3jP0uWnnhx8LEeNzlIY5EicP+CR5mBlZLwlj2frE1wfK7valmyl0DWXKk9cYYaE4oOoG59uVtjUGSVyaaEvGjYLGUx+jdq2mcXNR/7D0WyGMvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323739; c=relaxed/simple;
	bh=V+QTxs8ZNX2e9Unfo7ANnUqWpeXj6vfwQlIB3jSMCBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oCmtJ2TcdYwdcMRoGYDuH4RAeF+sR4kxhvTnlw8bjcSkw+trohxs7YNnu2Frud80pdoRIVfD7OYlPgnx20mKGBsbrVdlw19qMAMUIfACIcu/LG2ACQAVaV3S7oVCJ/PbfNaZ3gqvGk0dELirk2IB8LPgEvDES3CS2TAkrywfxrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNCjVQkZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDA2C43390;
	Sun, 24 Mar 2024 23:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323739;
	bh=V+QTxs8ZNX2e9Unfo7ANnUqWpeXj6vfwQlIB3jSMCBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dNCjVQkZCSwggc6cmb6mc8vIZRdglo3DV7XTjv6fOMt+6ccjZHxUJ2UYFS1NFiUgs
	 Mj0gM93dLgCaDcOXSV3jn+0iG9YI9gDQI1P7TrgicOgeajhZx6MEAdFYta3pHGGplW
	 VgCUFbBIRlvF+KzYR1qRzVaVjG52Behm35iR9HctYIgFSp01i3h6td0VajhsjvYu/B
	 oNZt/3qGxmeCzk5fcoIwbWYYAPhqzu6st1f55phHsOgixdi2GifRPUsxQKxYERvZ4q
	 fRcPdiDbrVMHUEVe0eYqr8aNN6K3c3HZAkliLkLh2L/SqARFLg07UTBJDs3vrLDoLE
	 Wbei3ZjFfz29w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 113/238] drm/tegra: dsi: Add missing check for of_find_device_by_node
Date: Sun, 24 Mar 2024 19:38:21 -0400
Message-ID: <20240324234027.1354210-114-sashal@kernel.org>
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


