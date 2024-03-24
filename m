Return-Path: <linux-kernel+bounces-115105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8F5888D20
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 578AB28C2E6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1E32FB0DB;
	Mon, 25 Mar 2024 01:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gpa/sAv2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B29181470;
	Sun, 24 Mar 2024 23:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324090; cv=none; b=QJ/Sg7WpARbc828R0xJUMwaourH+3gkOAuvpX1MLLpdLAmbjBsX4M1JcFT4bg5047HTcdmSbZ5fuopCQYhyCpOsLDFIqxYIxYrG6rWKZBxrKf8c9QCObuJoPayT38vFrPBGxw5oKHYH/0357pb0ccNAsLd7pM7uo+VvsBQwq19Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324090; c=relaxed/simple;
	bh=+X/wB7FFU9/O/mKVEwyniykC9TrsoAe0oE0bRh21QVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=swL87xcf+/N8X/Ba2OVcrGGtn37uPOSjtF7u5qlhL17689hFzMQyZ6eZnEjcHnwB6o0eFF5EB16I8HcGn5Ktx7AXMU7ZHK3B+lW8EiIrGqUwf8BbfvWUXz5PfoWtetQR1O9kr5UF8IrfBK/bRPUJa7ri7ZW9o91Ob9kwjx5lKv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gpa/sAv2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4951DC43394;
	Sun, 24 Mar 2024 23:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324088;
	bh=+X/wB7FFU9/O/mKVEwyniykC9TrsoAe0oE0bRh21QVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gpa/sAv2sDuHDUIvUeCAAp+FYCp0oUlelaCUhVHftQHTuvLhFDEI/kcHulwMKXCcb
	 203luG0oHxXOlCnXDl8wKFZE6pjZyZaHqZuPa3Psssw8QwEnq+DEa9CI27hV5wlMlC
	 IeIYLLiK+SV9G6b0jVxGxU58Vb/67a2ugPmGRHqYhmWKf/VFhab5JvfrnKX74iOMu0
	 dqYXTy/DX8qDFNk+y4J9F/uW9y01GQZ0D3ixlJrahyjYvq8RU//HGpkcQYM1VOUKax
	 AJHwZu94cHPuxoQmNge51/xYGQJq9ne8HRt1cv3tiQyMbAYxG4cGDpg3pid6Alucci
	 DHEso72jDFNNA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 089/183] drm/tegra: dsi: Fix missing pm_runtime_disable() in the error handling path of tegra_dsi_probe()
Date: Sun, 24 Mar 2024 19:45:02 -0400
Message-ID: <20240324234638.1355609-90-sashal@kernel.org>
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
index 072a4c1d8eff4..03ccfb6ce8a89 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -1582,6 +1582,7 @@ static int tegra_dsi_probe(struct platform_device *pdev)
 	return 0;
 
 unregister:
+	pm_runtime_disable(&pdev->dev);
 	mipi_dsi_host_unregister(&dsi->host);
 mipi_free:
 	tegra_mipi_free(dsi->mipi);
-- 
2.43.0


