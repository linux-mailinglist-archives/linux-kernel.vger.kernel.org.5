Return-Path: <linux-kernel+bounces-114256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E11088896D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB788288B1B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5762A259960;
	Sun, 24 Mar 2024 23:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpjTNrKc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4977C1386CF;
	Sun, 24 Mar 2024 23:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321617; cv=none; b=rmwfUtECQJGpw+77HNNSeTWJIgqufpU/QcPBeI/afakjyMHVVebVhUGDldiZc0p7lYYR+6C+0zZCGHNaCEzsuEVa3VI6XuSv2QcTaTrPt6A5cqmpuWbiqOyOmt1DGGc71HIO9GSBaTrGFnkcl4i7BjkIarpyCkgLHLjjJGFxtnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321617; c=relaxed/simple;
	bh=DMNzpI+LwpwXyzzvcvodwe0NA+LM42bdDJQQwwfvX6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pkGd1weKxadmkBDX/M8Hk+UT8HLihtApEufjD/GGNMSumESb4cWdqO2Oya7tF4BeBi9FxMQzx9ibAH2EZ9pnDPLHCy4tDh8FvIDXX8JSUb8e4B+1v8Bj6URUU/BaS1XGJ5EyMaScyLI4KSYgjS1UG7q19solByJyydC5+WJWFo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpjTNrKc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B48C433C7;
	Sun, 24 Mar 2024 23:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321616;
	bh=DMNzpI+LwpwXyzzvcvodwe0NA+LM42bdDJQQwwfvX6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LpjTNrKcaBY0ql6STfTY+uNf5uwZ/+EOUT+4XZ2V8SJvGHf/fbCN7F+tmtw+DBuhC
	 wAkpGMrLZ0tfjg/QCr0OJz19OH6NvHJzeweDQt0WWpfJG3CgrssdG70gYwRci0dIE5
	 HtYWqL7DyNQEEK5rvEHbsMTBRnkfP+1mSktKedALNmOUWd4V2zvslipocmptBxkJk8
	 6BE5Gihi6dwfOGt6lnSt7bhiAr1rjZdFjX0bynvj/yzO40n9yxfyoj8zSG5o73mUwx
	 7DB9IjLvOSI6FA4F2/a5g0zcmgUFyZi1QwjVMDGVy4NR5ISj2vt1xZTF+ahWfSlb9b
	 dFb1ltpMqI1yg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 346/638] drm/tegra: dsi: Fix missing pm_runtime_disable() in the error handling path of tegra_dsi_probe()
Date: Sun, 24 Mar 2024 18:56:23 -0400
Message-ID: <20240324230116.1348576-347-sashal@kernel.org>
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
index b76b9b0232250..839dbad9bc483 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -1674,6 +1674,7 @@ static int tegra_dsi_probe(struct platform_device *pdev)
 	return 0;
 
 unregister:
+	pm_runtime_disable(&pdev->dev);
 	mipi_dsi_host_unregister(&dsi->host);
 mipi_free:
 	tegra_mipi_free(dsi->mipi);
-- 
2.43.0


