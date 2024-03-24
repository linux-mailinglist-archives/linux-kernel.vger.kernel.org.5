Return-Path: <linux-kernel+bounces-116056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E77E889538
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2571F311E2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439B627988E;
	Mon, 25 Mar 2024 03:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFQ/jdkc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69872789AC;
	Sun, 24 Mar 2024 23:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323455; cv=none; b=AD5/oex80QsAvOIMgtI9rm4RGJXY8mY4s40p11UO/Bk//unYgNMk08QScTlQWMTVTbmSZORMWPtYNHvHbE855TmvgHlPQHQ5SM0nq33ULG7f9A3alcg/hNx99b9r3dvrgi5+ySEmHC9yXCfq4H8TgNRALqg2tECmp9bVDN6YJcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323455; c=relaxed/simple;
	bh=ipIZkzQCi6dIh+wctaoINwH7cDx3OX72mWoTklLuTJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UYTbsJjLT0sO4/Nnsin/l0RP39Lw5EbMe2C5k1G8c4N+UkPrhP+WjmahznjHsXoGSBgBTtgCJ+T7bJQnY/sl4xrBwDciOFga6widGJMklMSvQvS+hauV7lr04eB6H8Ax/IRUvZL88Nl0zAlL4lovj8iMONy6FtzqL/R0m8yJ2gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFQ/jdkc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0117EC4166A;
	Sun, 24 Mar 2024 23:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323454;
	bh=ipIZkzQCi6dIh+wctaoINwH7cDx3OX72mWoTklLuTJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EFQ/jdkckKWb1F4nP8ILLbo0kPZY2BpIBv5hgFgS2Mgyr8YYRnLpBu0PBY9POMI33
	 bU7531NCd9LqnmHUq35Zav4LY1p3Rrtg4MvgWKOtIPBarSHTRxBpsaNNTlNAygr9za
	 UaA2J4or2ivZW61z150LAmxdjpuWtTHnnAwgYkRR4eYRUCr56QYx5upukRyKdGyeJS
	 jUsgEEEthYTlALmb/iT0+vVDpb5Txadm6Gvr4UBG9e42ceFsU4YwCpeGoAsVoRh3O7
	 oEbnb1HPNJuhvKzysX4Sj9efIuAi+avY7+nVmkXiOywGkaE/N0KPgIamRuMiA4dLOq
	 kTrGQAMJRIlGQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Shurong <zhang_shurong@foxmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 158/317] drm/tegra: dpaux: Fix PM disable depth imbalance in tegra_dpaux_probe
Date: Sun, 24 Mar 2024 19:32:18 -0400
Message-ID: <20240324233458.1352854-159-sashal@kernel.org>
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
index 12a92d09ac909..a99f82dc7e6f7 100644
--- a/drivers/gpu/drm/tegra/dpaux.c
+++ b/drivers/gpu/drm/tegra/dpaux.c
@@ -525,7 +525,7 @@ static int tegra_dpaux_probe(struct platform_device *pdev)
 	if (err < 0) {
 		dev_err(dpaux->dev, "failed to request IRQ#%u: %d\n",
 			dpaux->irq, err);
-		return err;
+		goto err_pm_disable;
 	}
 
 	disable_irq(dpaux->irq);
@@ -545,7 +545,7 @@ static int tegra_dpaux_probe(struct platform_device *pdev)
 	 */
 	err = tegra_dpaux_pad_config(dpaux, DPAUX_PADCTL_FUNC_I2C);
 	if (err < 0)
-		return err;
+		goto err_pm_disable;
 
 #ifdef CONFIG_GENERIC_PINCONF
 	dpaux->desc.name = dev_name(&pdev->dev);
@@ -558,7 +558,8 @@ static int tegra_dpaux_probe(struct platform_device *pdev)
 	dpaux->pinctrl = devm_pinctrl_register(&pdev->dev, &dpaux->desc, dpaux);
 	if (IS_ERR(dpaux->pinctrl)) {
 		dev_err(&pdev->dev, "failed to register pincontrol\n");
-		return PTR_ERR(dpaux->pinctrl);
+		err = PTR_ERR(dpaux->pinctrl);
+		goto err_pm_disable;
 	}
 #endif
 	/* enable and clear all interrupts */
@@ -574,10 +575,15 @@ static int tegra_dpaux_probe(struct platform_device *pdev)
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


