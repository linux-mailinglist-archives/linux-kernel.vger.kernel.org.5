Return-Path: <linux-kernel+bounces-114258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 353F7888971
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 668F51C27F56
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B8025999C;
	Sun, 24 Mar 2024 23:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6TpWP+r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD521386D4;
	Sun, 24 Mar 2024 23:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321618; cv=none; b=WxFbO3p7ZxL2fTfBnFkDme22wQyd9fk6AzfWgaSkbBKGFiSUWq9jtzYfxp/r/9l9SvwuKGdlLmbnSLyOBRwoBwtSYy5Hny0nQSu8eHtFULyHs2XSr+KkkfTFvBJm1ear9UjZkgJo6jlzoTgP4sivwwRX06eZpwitDYf2FzUfF90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321618; c=relaxed/simple;
	bh=6vNVaI39IZK+aSzy951/QxKLTuPpdBE8AQvbGcKncCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vAZKM/bpYGMRj7O6NV/MXebyNNrj4MJlbeF/pXrafNti9TAg6C+QsqlAWUSaFgTDwnncQZaM+4yqNNSA9UgcK89/6ZH1ARD9X1crWdnlFabp7F1eurIejIEwEAvajK2cdOmQNCtrrm4Sbr+vGfJJpaAtsAOaKkb8djyXp4EZO4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6TpWP+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBECC43390;
	Sun, 24 Mar 2024 23:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321617;
	bh=6vNVaI39IZK+aSzy951/QxKLTuPpdBE8AQvbGcKncCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j6TpWP+ros9ylQvzswfldaoynOXZYv7EAtK7LMrGavjzmzWSQnoncRPRfER9NALtJ
	 33cWGy/6F/QPXU49r1+GR9BLISBJc/rwvTqaizAuX6NeGYD3ycyVNPa+gY40a1wxwQ
	 DvyPv8UvDUHJ/lqSQcgzJQRXmOXzRd4d4HGxL6yO7S2DhdC6UOSkhJFhbitr7T4Brt
	 ZWIo0mAoD10fJjV/y5ENOg6ElAR9Z1Bl/1Y3q04JA9/tRdpwFxwbrM2nulW+pAtx2e
	 HNGaf+ojZ0HckTwpbBbGdw7/t+NYcEXot9stKzPGVQn80rSKrjoeYJnY8Inh5+y6/s
	 XuXJhhRpkNW4g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 347/638] drm/tegra: hdmi: Fix some error handling paths in tegra_hdmi_probe()
Date: Sun, 24 Mar 2024 18:56:24 -0400
Message-ID: <20240324230116.1348576-348-sashal@kernel.org>
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

[ Upstream commit 643ae131b8598fb2940c92c7d23fe62823a119c8 ]

If an error occurs after calling tegra_output_probe(),
tegra_output_remove() should be called as already done in the remove
function.

Fixes: 59d29c0ec93f ("drm/tegra: Allocate resources at probe time")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://patchwork.freedesktop.org/patch/msgid/9b7c564eb71977678b20abd73ee52001a51cf327.1693667005.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tegra/hdmi.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.c
index 80c760986d9e9..58c2ba94e7dd6 100644
--- a/drivers/gpu/drm/tegra/hdmi.c
+++ b/drivers/gpu/drm/tegra/hdmi.c
@@ -1854,12 +1854,14 @@ static int tegra_hdmi_probe(struct platform_device *pdev)
 		return err;
 
 	hdmi->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(hdmi->regs))
-		return PTR_ERR(hdmi->regs);
+	if (IS_ERR(hdmi->regs)) {
+		err = PTR_ERR(hdmi->regs);
+		goto remove;
+	}
 
 	err = platform_get_irq(pdev, 0);
 	if (err < 0)
-		return err;
+		goto remove;
 
 	hdmi->irq = err;
 
@@ -1868,18 +1870,18 @@ static int tegra_hdmi_probe(struct platform_device *pdev)
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to request IRQ#%u: %d\n",
 			hdmi->irq, err);
-		return err;
+		goto remove;
 	}
 
 	platform_set_drvdata(pdev, hdmi);
 
 	err = devm_pm_runtime_enable(&pdev->dev);
 	if (err)
-		return err;
+		goto remove;
 
 	err = devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
 	if (err)
-		return err;
+		goto remove;
 
 	INIT_LIST_HEAD(&hdmi->client.list);
 	hdmi->client.ops = &hdmi_client_ops;
@@ -1889,10 +1891,14 @@ static int tegra_hdmi_probe(struct platform_device *pdev)
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to register host1x client: %d\n",
 			err);
-		return err;
+		goto remove;
 	}
 
 	return 0;
+
+remove:
+	tegra_output_remove(&hdmi->output);
+	return err;
 }
 
 static void tegra_hdmi_remove(struct platform_device *pdev)
-- 
2.43.0


