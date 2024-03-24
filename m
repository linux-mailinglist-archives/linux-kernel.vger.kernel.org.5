Return-Path: <linux-kernel+bounces-113245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED4388829C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2082B2108B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5114F186367;
	Sun, 24 Mar 2024 22:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RojH6K0U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8862C13C9CC;
	Sun, 24 Mar 2024 22:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320046; cv=none; b=t29xjpjkJ0UuKvCGVCqNcYstFFF5Qv5ntwbFs69LCg4hl6iwBPhAKQyubSHYu+s+xdsYgw1O7l+87R9ywCxTRSN9NCBOFT+psIPpJ7Bp/00lNn9xg7mB2SB8RGXrKyrL3yExrVr1SRx/sDaJCEpxdB/fjdByaNxXczpMX38uwO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320046; c=relaxed/simple;
	bh=E4/QfkdetyAy347aC7SD1ktF+sQbA0mQj8jR4J/AD9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fdCRa+pkY2/eM5oHCPQdPunJxMaESZK5nkqFnofZC9Sxg6ESsUEl0j9owWgwQOc52LiF1KtuDDiVazDAf+LTuU5zEj29H92lQw/fH42Ot+Z11yubQDAxWHDikjL2nDVyy7CsvlqnqntIsK2eTI1WJdM54zTLU429wFEfnrfctcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RojH6K0U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C657DC43394;
	Sun, 24 Mar 2024 22:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320045;
	bh=E4/QfkdetyAy347aC7SD1ktF+sQbA0mQj8jR4J/AD9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RojH6K0UkIXF38rV/t31ydmhWsebt9sjGSqoWMZe6ZCIbeHWJ2wsInXH+Tfrp7EWj
	 fPrdE3+K9gQtl988tiEkI0gRS1AF3ZExAWqEmUlReI3XFtl9iOx8B78FEtSoXEkMV3
	 b5hf6Wkq7EuBBapY0DhXNTEBfQWqFfurC7NpWNQzvjdfRsCxIdQDKAHfjgrC0alvqd
	 y4pqEYRB9vcJYpqD8VhjuQNyv6kgDI4NEfVZlkMAWkYVc1KzjBOKQdcgwhP6DLx0Sf
	 /5WGhLbuq75xc1N0mQJnKCsYGoH7E8gOADDhQFeX0YP3iw1/p5p6HQ8rA+MgG5nG+w
	 lQuaA6U0H+YlQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 354/715] drm/tegra: hdmi: Fix some error handling paths in tegra_hdmi_probe()
Date: Sun, 24 Mar 2024 18:28:53 -0400
Message-ID: <20240324223455.1342824-355-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index a1fcee665023b..417fb884240a6 100644
--- a/drivers/gpu/drm/tegra/hdmi.c
+++ b/drivers/gpu/drm/tegra/hdmi.c
@@ -1856,12 +1856,14 @@ static int tegra_hdmi_probe(struct platform_device *pdev)
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
 
@@ -1870,18 +1872,18 @@ static int tegra_hdmi_probe(struct platform_device *pdev)
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
@@ -1891,10 +1893,14 @@ static int tegra_hdmi_probe(struct platform_device *pdev)
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


