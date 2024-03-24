Return-Path: <linux-kernel+bounces-114831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D9C889196
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92AD0294CA3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DAD1BAA3D;
	Mon, 25 Mar 2024 00:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsQjhDj5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C7C1769F5;
	Sun, 24 Mar 2024 23:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323458; cv=none; b=GMyKmbSJmaOoxczU9pJHvMSjjf96m+KxQM4xSsBLNu1gdrM+26XvnWL/539xMQ+KOaxnxiSto05sbBkfv49ywQGmOzq4yX++PZ8xmmWZt85kT3VJTeo51o62YqYO3J1faFKEcHe5BwbJEsHrtfxL422nSbbMOVgwp64XdDgKOwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323458; c=relaxed/simple;
	bh=+ZUl4XWyX2TC41ftSNhfrfsALGaw+PtYVx7wA53zQtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ufXX54Z+grb9Lh0S9MnAsQqZ+tG78hW7Un+a4BlZZPIp86xIY+MkL4jz35Xrv3uwVlUkK+8mSn/GEQDNIJQprv6IPXy5pWtoL3Bg0Yd7wlYHSbRYMLEcfmTZyqaycRy2GC49Ty9H15uFb3GSKK6OVEi/iu4pDd9ph2sKnXEbMws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rsQjhDj5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A04C43399;
	Sun, 24 Mar 2024 23:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323457;
	bh=+ZUl4XWyX2TC41ftSNhfrfsALGaw+PtYVx7wA53zQtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rsQjhDj51xWPsuTzbKmxTtkheeRKwsYCfxPG+HDh8Do4/vdgvepFWNPwYYZnamxEr
	 taaDugUCIecLwXIVJab+y8tTktKAcn/YqA8RxyNYXAACwsL1ZyI3f8BbKmVAzDPP1P
	 zHk2R6W3vkO1ikXwi/J71qrqOUFrqJ12EHQob8CkWcFDkVKraUfZHCWuilLkg8gv1S
	 Lg4FPtoUmtqd5VMSI3FkN4Yc3LC/PK+lq3YzqG4KscKHD3Ajtpht5IrnWaaRlFJdcc
	 PevjAf2pzwdzraGskKsiIlbsuK23XrVDpIYgQAtUGtHI9fuv3zIB1shZIGlMqesTzg
	 d3HkvXgwZ10BA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 161/317] drm/tegra: dsi: Fix missing pm_runtime_disable() in the error handling path of tegra_dsi_probe()
Date: Sun, 24 Mar 2024 19:32:21 -0400
Message-ID: <20240324233458.1352854-162-sashal@kernel.org>
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
index 815e32e05f600..7bb26655cb3cc 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -1665,6 +1665,7 @@ static int tegra_dsi_probe(struct platform_device *pdev)
 	return 0;
 
 unregister:
+	pm_runtime_disable(&pdev->dev);
 	mipi_dsi_host_unregister(&dsi->host);
 mipi_free:
 	tegra_mipi_free(dsi->mipi);
-- 
2.43.0


