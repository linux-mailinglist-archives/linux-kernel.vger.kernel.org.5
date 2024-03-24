Return-Path: <linux-kernel+bounces-114519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE17888AD4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FF841C291BD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3E05D47E;
	Sun, 24 Mar 2024 23:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/OhtsVN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB153149E1E;
	Sun, 24 Mar 2024 23:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322159; cv=none; b=mqHSJGY7IrEPHMcjot3Qt1HDYSLHS57jBX5RjveA+WIZa+3JCZfDhAbCTTIevHRPOdYT/UqWi5QGZhGuMg5Zqqq+E+2yJHrhqYm3IV0ZxKgGxhIFMLfB44JOIfpTMrFS/engefOOvRdKHP9Sm2DD5YuAaQ/R8OTDa75+bpnE5tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322159; c=relaxed/simple;
	bh=gLvrobefHih3m36oqL0RUatkLn6qrzrvGHRqDvv4vu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ObRljyIevOLF6BRHXZu4LBGj6eOneBS/LSzkR1Sd1xJ2EKYBAs88m241QKbJi+gmYxEHvpSREwynAVoeMJYbtGeubOEsxf8Utq59DHXJ6RpVFF6V84xnP/dsHB1jFQQ/LcDsQhszWxMUTGC6gR8rg1EK8zUlvH38TVjtsz8YCUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/OhtsVN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3517CC433F1;
	Sun, 24 Mar 2024 23:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322157;
	bh=gLvrobefHih3m36oqL0RUatkLn6qrzrvGHRqDvv4vu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L/OhtsVNlKA6vLNxcVMotAyRMO2CqgHGUc8gmKMltMCl5FyvypfzlbwSzgMmFKZj2
	 UnXIzDcqYgFSRtkc4jxiDpqWVc9YSVsfr/br6hC12KBy2yFTloCuyibtZKvelocjLs
	 uhtT6LjoJhBvr5t+jq7yfx/y2qfg61c7KaljOw7HTdTz7+I1Tb+78rtwqG+nA3oFBZ
	 0WFUTI5bB2KXNUNgZla3DfmJfhr8bSi0h/XY5FY8baBZ8zl1d6XKafCX0Bo6LQNLtL
	 dDWnycBEH0sB+4zOr/c+DPaVAwICp8Q6K5W/n83tXNgVIClA4782oIp+oss//Azv81
	 AXLCyHctYhkVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Shurong <zhang_shurong@foxmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 235/451] drm/tegra: dpaux: Fix PM disable depth imbalance in tegra_dpaux_probe
Date: Sun, 24 Mar 2024 19:08:31 -0400
Message-ID: <20240324231207.1351418-236-sashal@kernel.org>
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
index d773ef4854188..b563988fb6848 100644
--- a/drivers/gpu/drm/tegra/dpaux.c
+++ b/drivers/gpu/drm/tegra/dpaux.c
@@ -524,7 +524,7 @@ static int tegra_dpaux_probe(struct platform_device *pdev)
 	if (err < 0) {
 		dev_err(dpaux->dev, "failed to request IRQ#%u: %d\n",
 			dpaux->irq, err);
-		return err;
+		goto err_pm_disable;
 	}
 
 	disable_irq(dpaux->irq);
@@ -544,7 +544,7 @@ static int tegra_dpaux_probe(struct platform_device *pdev)
 	 */
 	err = tegra_dpaux_pad_config(dpaux, DPAUX_PADCTL_FUNC_I2C);
 	if (err < 0)
-		return err;
+		goto err_pm_disable;
 
 #ifdef CONFIG_GENERIC_PINCONF
 	dpaux->desc.name = dev_name(&pdev->dev);
@@ -557,7 +557,8 @@ static int tegra_dpaux_probe(struct platform_device *pdev)
 	dpaux->pinctrl = devm_pinctrl_register(&pdev->dev, &dpaux->desc, dpaux);
 	if (IS_ERR(dpaux->pinctrl)) {
 		dev_err(&pdev->dev, "failed to register pincontrol\n");
-		return PTR_ERR(dpaux->pinctrl);
+		err = PTR_ERR(dpaux->pinctrl);
+		goto err_pm_disable;
 	}
 #endif
 	/* enable and clear all interrupts */
@@ -573,10 +574,15 @@ static int tegra_dpaux_probe(struct platform_device *pdev)
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
 
 static int tegra_dpaux_remove(struct platform_device *pdev)
-- 
2.43.0


