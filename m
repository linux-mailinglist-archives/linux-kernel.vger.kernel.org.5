Return-Path: <linux-kernel+bounces-113807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 598ED8886B5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B3C51C25CE3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377AF1FC0FA;
	Sun, 24 Mar 2024 23:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ih4GAvVM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C6E1E5852;
	Sun, 24 Mar 2024 22:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320827; cv=none; b=jyganh9YmD13F/3KISpnQLr9HZDquRzBO58H+bU91BLv/p9QSes8YFVxJ/LsMQ242oCQaYJN+OvH/x63vrZSuPXPrOOFI3J0nY42x8Tg0Eg9eNK/fAtH1anji3q65F1744+tFXHl5bmT8ZWTsOOf1xc3+zMYvMLzv5PnjxZH418=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320827; c=relaxed/simple;
	bh=6PYzZwYgCOek78YwuwPl9iW6KBnvVCcfXpsYYRC/mW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GhDaPIK3yW/fmYSuAPZnzm6iuPivZ5LGFbg+PQgyft3zjLpQJlDLLX/uZaM8HwEUSGA8MBqvPX/OfOonHD8e5KFDDwuuxYO33njMpSLIE+HDBiFphKJkW6bESYKyik5O5jeOrhd5THe13IBv1HXISJsmSzeBEbBW+I4Ss4zbPmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ih4GAvVM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 003D6C433F1;
	Sun, 24 Mar 2024 22:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320825;
	bh=6PYzZwYgCOek78YwuwPl9iW6KBnvVCcfXpsYYRC/mW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ih4GAvVMtto0K/gSGPcZH3PrDJi6flsWmUjF+TnBuXaqxvcGrpjeBpltMRYX+5O5p
	 vh5Y/uTPvoQrWF3vLac5NsfVyV4m5mTQr9/1sZx/RKNOhdLkXOM7ZxlvjfSpSVq/Mj
	 ehLUHt0c1deXItG0l9qe8uXsXvq5cm5YG90ozXXdGk+3HTj45KfB/p/VnlBQBVwHaT
	 Aht4aQ3JDLoiLgsY6/ZvKPSJ3OD2sg2X+v6XG1+LCCaA6AHB7PZD9D3JoeIs7F751l
	 Mc5mnaYvMUJ3C7A80C2oov3z3sbzkahzlqWO7jnv0qN/vazlUv7eiUFysCpp6S1SBe
	 l5GJ8XmTrSILQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Shurong <zhang_shurong@foxmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 390/713] drm/tegra: dpaux: Fix PM disable depth imbalance in tegra_dpaux_probe
Date: Sun, 24 Mar 2024 18:41:56 -0400
Message-ID: <20240324224720.1345309-391-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Zhang Shurong <zhang_shurong@foxmail.com>

[ Upstream commit 0800880f4eb789b7d299db40f2e86e056bd33a4e ]

The pm_runtime_enable function increases the power disable depth,
which means that we must perform a matching decrement on the error
handling path to maintain balance within the given context.
Additionally, we need to address the same issue for pm_runtime_get_sync.
We fix this by invoking pm_runtime_disable and pm_runtime_put_sync
when error returns.

Fixes: 82b81b3ec1a7 ("drm/tegra: dpaux: Implement runtime PM")
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://patchwork.freedesktop.org/patch/msgid/tencent_B13DB7F6C0023C46157250A524966F326A09@qq.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tegra/dpaux.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dpaux.c b/drivers/gpu/drm/tegra/dpaux.c
index ef02d530f78d7..ae12d001a04bf 100644
--- a/drivers/gpu/drm/tegra/dpaux.c
+++ b/drivers/gpu/drm/tegra/dpaux.c
@@ -522,7 +522,7 @@ static int tegra_dpaux_probe(struct platform_device *pdev)
 	if (err < 0) {
 		dev_err(dpaux->dev, "failed to request IRQ#%u: %d\n",
 			dpaux->irq, err);
-		return err;
+		goto err_pm_disable;
 	}
 
 	disable_irq(dpaux->irq);
@@ -542,7 +542,7 @@ static int tegra_dpaux_probe(struct platform_device *pdev)
 	 */
 	err = tegra_dpaux_pad_config(dpaux, DPAUX_PADCTL_FUNC_I2C);
 	if (err < 0)
-		return err;
+		goto err_pm_disable;
 
 #ifdef CONFIG_GENERIC_PINCONF
 	dpaux->desc.name = dev_name(&pdev->dev);
@@ -555,7 +555,8 @@ static int tegra_dpaux_probe(struct platform_device *pdev)
 	dpaux->pinctrl = devm_pinctrl_register(&pdev->dev, &dpaux->desc, dpaux);
 	if (IS_ERR(dpaux->pinctrl)) {
 		dev_err(&pdev->dev, "failed to register pincontrol\n");
-		return PTR_ERR(dpaux->pinctrl);
+		err = PTR_ERR(dpaux->pinctrl);
+		goto err_pm_disable;
 	}
 #endif
 	/* enable and clear all interrupts */
@@ -571,10 +572,15 @@ static int tegra_dpaux_probe(struct platform_device *pdev)
 	err = devm_of_dp_aux_populate_ep_devices(&dpaux->aux);
 	if (err < 0) {
 		dev_err(dpaux->dev, "failed to populate AUX bus: %d\n", err);
-		return err;
+		goto err_pm_disable;
 	}
 
 	return 0;
+
+err_pm_disable:
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	return err;
 }
 
 static void tegra_dpaux_remove(struct platform_device *pdev)
-- 
2.43.0


