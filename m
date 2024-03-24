Return-Path: <linux-kernel+bounces-114527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B33D0889046
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48BD1C2C2C9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D18328FECF;
	Sun, 24 Mar 2024 23:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9P/0/6w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE2215B54B;
	Sun, 24 Mar 2024 23:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322161; cv=none; b=KBre6xeOgIpK1XSCHNfADa05X4oyZxIMQdkhS7nlYNpXcviFJpczDrxvEgjxocnbYBbFG+rUNHrwKkXBQHMKj+SWV6wfGXkWWaGv5+OH4oZuO10JReAE/8TLeO9O/NIhKb4PAzmctRlUrM1I3o615dLfNrU9m5L4V3yDZvPD59g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322161; c=relaxed/simple;
	bh=8KG5Kv9xE8+BSzUzijXLHGU0DSDjDPk4VPFVL8rFUuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YrsCYPtLRFilVxXkroLSleKZ+SUJ9Jwr+XMy2LIpe76KsjXFFjDmQ9t54eZgI/dg49IRDjAQZlXssiGw2v04OewyHwoywN3td3uIyioaMv6b+U0ZD3x72JhscYcfJn5uZEfJlXwlgE7Z3lKOYhacgrywq/Jx4YrDj5mJj0g3oZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9P/0/6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BF3C43394;
	Sun, 24 Mar 2024 23:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322161;
	bh=8KG5Kv9xE8+BSzUzijXLHGU0DSDjDPk4VPFVL8rFUuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q9P/0/6wwhrj7QPYP100FqNnsnE7LS5A5htXRnpgonGZ9agymHxkX8oWeO6M2MUS6
	 w5691TzeBKRi0Nzz66owVkZ7mGTTEcxdadktHYvXA++YSswUOEN5E0bI8levmtO7m9
	 2XkPfxLiYQB7KNwjkQvIADInUV1pn0Lz3MPU2dV4d3zTqRxZnSTiAnzlurLtw2NT65
	 8KEn+VLepRNCMEoA3pIe8xkAgquwF5MwNVP6f2YH5yEsNyTsZgJ8DbUysugkfRxQ3W
	 3UsSDySPgqvD4ouumPR/JVdPJM4VYGko1Y87aHnCNf7+ZObns1Ez+su+IvtTrjJUQ9
	 a/86jOQfZ/2ZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yangtao Li <frank.li@vivo.com>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 239/451] drm/tegra: hdmi: Convert to devm_platform_ioremap_resource()
Date: Sun, 24 Mar 2024 19:08:35 -0400
Message-ID: <20240324231207.1351418-240-sashal@kernel.org>
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

From: Yangtao Li <frank.li@vivo.com>

[ Upstream commit faae5646c13f4697fd2ba29b10e38f9be5aa890a ]

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230710032355.72914-5-frank.li@vivo.com
Stable-dep-of: 643ae131b859 ("drm/tegra: hdmi: Fix some error handling paths in tegra_hdmi_probe()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tegra/hdmi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.c
index bf240767dad9f..f83d9041327f0 100644
--- a/drivers/gpu/drm/tegra/hdmi.c
+++ b/drivers/gpu/drm/tegra/hdmi.c
@@ -1776,7 +1776,6 @@ static irqreturn_t tegra_hdmi_irq(int irq, void *data)
 static int tegra_hdmi_probe(struct platform_device *pdev)
 {
 	struct tegra_hdmi *hdmi;
-	struct resource *regs;
 	int err;
 
 	hdmi = devm_kzalloc(&pdev->dev, sizeof(*hdmi), GFP_KERNEL);
@@ -1838,8 +1837,7 @@ static int tegra_hdmi_probe(struct platform_device *pdev)
 	if (err < 0)
 		return err;
 
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hdmi->regs = devm_ioremap_resource(&pdev->dev, regs);
+	hdmi->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(hdmi->regs))
 		return PTR_ERR(hdmi->regs);
 
-- 
2.43.0


