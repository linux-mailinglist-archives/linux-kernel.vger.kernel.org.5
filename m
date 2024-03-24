Return-Path: <linux-kernel+bounces-115210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C2F888DBC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71E2B2967D7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308FF1CBBB7;
	Mon, 25 Mar 2024 01:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzlHvUHU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464B922C66B;
	Sun, 24 Mar 2024 23:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324292; cv=none; b=puw8+IgLeLloLSn7OebjhtgK35p1zGNhz+v97PWYy4k2Qc8/YXFM5WhLJmB05xFQxFq8SpOV9+t4B7I83rYApcAkbrskUw+/y28I+dmGqtI60pADHTUM4FCuj1H4crPfmol6pHDPiiJwV6+j4TErSuykGanl7xNWW175TSG5U5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324292; c=relaxed/simple;
	bh=G0c+udVpKFOi8AWsLyHdaHk+W6Sar4vDtf+9xm8Am3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQK6jU8w/f6Waxbdo+W22YuHeqPXJNT+bq+1X6TnsaRVIc31LRdVPe3hF5+iZpNdSv1uFt+qMEBcItDcmi8jNvs1KGuwM5D4fWMuP15ww0xr//Ce+Gd7BOAYvaEs7/V2NW68HfpjrdzXwNt2j/09J9Jy4EWJwB80b7px+Z0IYk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzlHvUHU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871DEC433B2;
	Sun, 24 Mar 2024 23:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324291;
	bh=G0c+udVpKFOi8AWsLyHdaHk+W6Sar4vDtf+9xm8Am3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VzlHvUHU4dKSgWpp/6v5CHvqJM4OXUV8ebiMb63ua1ApddmN9tN0OeS3JZxHPDb7+
	 ft12kJW0Z7trBfpQ3TsKtsYwmJ9ja8GL6LrRAF00ueRTrYKZGhF9gI6vre7e0R+CaE
	 vJCxFfV79RCX5vRpuz92QL9WI/izdqxedm3mYUfG45qywe7VE0xyNyExMyl6UHWh2+
	 sl0nBW7qzxXMQV7Lk8rg9bwU1f6TwIJgwpY3yZngQHjotwg15MA6EkH0pYkmOJ/T2c
	 rXuP/jUc351CH0Kyeo4kHf4I0AaY3v4jYXl+wOY7ACoNNVwoYKR0JRn5Xu18E/6b/x
	 quKmteOK+KLEQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sowjanya Komatineni <skomatineni@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 067/148] gpu: host1x: mipi: Update tegra_mipi_request() to be node based
Date: Sun, 24 Mar 2024 19:48:51 -0400
Message-ID: <20240324235012.1356413-68-sashal@kernel.org>
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
index 70cc960d3ff58..7033ab28f7716 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -1543,7 +1543,7 @@ static int tegra_dsi_probe(struct platform_device *pdev)
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
index aef6e2f738027..903c0ec204442 100644
--- a/include/linux/host1x.h
+++ b/include/linux/host1x.h
@@ -327,7 +327,8 @@ int host1x_client_unregister(struct host1x_client *client);
 
 struct tegra_mipi_device;
 
-struct tegra_mipi_device *tegra_mipi_request(struct device *device);
+struct tegra_mipi_device *tegra_mipi_request(struct device *device,
+					     struct device_node *np);
 void tegra_mipi_free(struct tegra_mipi_device *device);
 int tegra_mipi_enable(struct tegra_mipi_device *device);
 int tegra_mipi_disable(struct tegra_mipi_device *device);
-- 
2.43.0


