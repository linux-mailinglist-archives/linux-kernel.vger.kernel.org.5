Return-Path: <linux-kernel+bounces-115099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E1188930A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D6E31F32C0F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E19D2F9F53;
	Mon, 25 Mar 2024 01:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hh02hAWi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A268128BD52;
	Sun, 24 Mar 2024 23:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324086; cv=none; b=K5MvRAJZ7ocIL5d8DhVHyezuAcXorPZ4K1YvYWWwEQ5cTtrOu3bwsxdcw13rGN0PvfjP+Fg8rP25QYr85oGYZSl+kmnq1gYLFDCqK+Zq/yu6cNjKdO1gyKycj1iMyCBlsTXVlqkCp87Cd4Eid4CKz6XMLhSq2MnkFssS8To1ORY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324086; c=relaxed/simple;
	bh=W2auDHnhzdN2Q152if/0LfzHE3Jc54mGrChBtG4p+mE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sAojt5GHUXPbkSOCz92eDUrL9yb1qwoCF8Pjg9qJS6txOC4FZEzrvLeGNGP0CIneZUpLo5ZoJ0Zg7VHaEg5m0g17hld2TcJGHe7W9n3VcngF6N+NJktVZ0UwNyF6+NoF05DcN0OOBWpK0cc9aMUucp8BaN1YFIdoNHZPMwzzlSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hh02hAWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E11C433C7;
	Sun, 24 Mar 2024 23:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324086;
	bh=W2auDHnhzdN2Q152if/0LfzHE3Jc54mGrChBtG4p+mE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hh02hAWiiMfZTGjcTOVx9IlFXJ83NL8sYqknp+JSxwe+8ecIVlqn/RnobNsf+EpIF
	 pE9TjqD+2ihnVBtud0gg4BQHzNPpl3tQYHclKb+mhIhwFsnh4osMN85FTig8d7oNqD
	 GgTX1cSrq8Mj0aIJ5RCpMoSf6jCL+ofvI7YMtDEtLLNsgukh6jA4uJuvFrkLeuiIES
	 iUTzF4mG6+/Iyr019Bc6SS/hFCsXVBxxA+kEF5X5tNJgdO89+eSdIe71XixN80xje2
	 PS65yQO+E2lA9yvuANx8atNJWH5Kuc9283Dafv9nZDJWV3R/TWS8FvApMSLkZKjZvh
	 NHJmrdD+wNbXA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sowjanya Komatineni <skomatineni@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 086/183] gpu: host1x: mipi: Update tegra_mipi_request() to be node based
Date: Sun, 24 Mar 2024 19:44:59 -0400
Message-ID: <20240324234638.1355609-87-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Sowjanya Komatineni <skomatineni@nvidia.com>

[ Upstream commit 767598d447aa46411289c5808b0e45e20a1823b4 ]

Tegra CSI driver need a separate MIPI device for each channel as
calibration of corresponding MIPI pads for each channel should
happen independently.

So, this patch updates tegra_mipi_request() API to add a device_node
pointer argument to allow creating mipi device for specific device
node rather than a device.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Stable-dep-of: 830c1ded3563 ("drm/tegra: dsi: Fix some error handling paths in tegra_dsi_probe()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tegra/dsi.c | 2 +-
 drivers/gpu/host1x/mipi.c   | 4 ++--
 include/linux/host1x.h      | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
index 4e454479ff157..1cc6dc6167771 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -1542,7 +1542,7 @@ static int tegra_dsi_probe(struct platform_device *pdev)
 	if (IS_ERR(dsi->regs))
 		return PTR_ERR(dsi->regs);
 
-	dsi->mipi = tegra_mipi_request(&pdev->dev);
+	dsi->mipi = tegra_mipi_request(&pdev->dev, pdev->dev.of_node);
 	if (IS_ERR(dsi->mipi))
 		return PTR_ERR(dsi->mipi);
 
diff --git a/drivers/gpu/host1x/mipi.c b/drivers/gpu/host1x/mipi.c
index e00809d996a29..762d349ad00f1 100644
--- a/drivers/gpu/host1x/mipi.c
+++ b/drivers/gpu/host1x/mipi.c
@@ -206,9 +206,9 @@ static int tegra_mipi_power_down(struct tegra_mipi *mipi)
 	return 0;
 }
 
-struct tegra_mipi_device *tegra_mipi_request(struct device *device)
+struct tegra_mipi_device *tegra_mipi_request(struct device *device,
+					     struct device_node *np)
 {
-	struct device_node *np = device->of_node;
 	struct tegra_mipi_device *dev;
 	struct of_phandle_args args;
 	int err;
diff --git a/include/linux/host1x.h b/include/linux/host1x.h
index e6eea45e11549..0b9d59807e5e2 100644
--- a/include/linux/host1x.h
+++ b/include/linux/host1x.h
@@ -314,7 +314,8 @@ int host1x_client_unregister(struct host1x_client *client);
 
 struct tegra_mipi_device;
 
-struct tegra_mipi_device *tegra_mipi_request(struct device *device);
+struct tegra_mipi_device *tegra_mipi_request(struct device *device,
+					     struct device_node *np);
 void tegra_mipi_free(struct tegra_mipi_device *device);
 int tegra_mipi_enable(struct tegra_mipi_device *device);
 int tegra_mipi_disable(struct tegra_mipi_device *device);
-- 
2.43.0


