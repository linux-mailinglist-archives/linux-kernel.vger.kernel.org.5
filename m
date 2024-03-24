Return-Path: <linux-kernel+bounces-115452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A07B889BA4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 935931C2868E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC13217E15;
	Mon, 25 Mar 2024 02:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDF3OCcu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A4E1E585F;
	Sun, 24 Mar 2024 22:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320828; cv=none; b=XWJoHj5CzFscTuyfS/Bed6M6hLjxTHHCAvtffvlJBIPnhKcNK0Ux0u7cap9Uew1WFLvFktLvKPr0OoftxEp3MNvLJXjz6CER81Js7rI5bndIfN8z8TYfcwISPRKCtW3jcjCG65I+ZiR2eMaC2M8RoiQvSSs0jemAL3oCuNUP5G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320828; c=relaxed/simple;
	bh=VyV1cnc9jGDxSW0bzW4txA0kjgRhbvRB1LY5GK/lI7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYyoPl3R3IihqrzMz5WX7/I00wQnTFfMFjrTQ/dGbNUnrZjWHVIw1GaLBv4d3S8o4aHxePO4OFPwX45vlNWbOYXRumClML8llk/rvRJr6LF4+2vy16hwmrdvcmn5WR7OwM6iBdss1ggYxpo95H72FjcM8ELV6edTTuqhnm5kxTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDF3OCcu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5615C433F1;
	Sun, 24 Mar 2024 22:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320828;
	bh=VyV1cnc9jGDxSW0bzW4txA0kjgRhbvRB1LY5GK/lI7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qDF3OCcuZCf2fAXOAig61v6uvW9Isb6EsJ5PaIykjrtt5980iLTop7LxUDXiudGw+
	 +S/Wgko5376aPvR6ji8uC+mwOErs8KaWJQCnGpt/kGyNe+jFQhmLKUMwUvyzQDhVha
	 aWwPP0MBkixO5OMkFUqxgUG2d9p4blsEjXwsJJIDvaVx4k8JrMHy8gSbBD7Ty2Ql6Z
	 6WJ3/s8khSfgIj9u/MXs9rByNopgby34LEd3dgxD4lQ0mDzb3BTxpTPqS68izaCR5n
	 nexWj6C8p/94Ao8f1itkOu65OOhMy7S1cu3YXyX7ylnnbS94cOcQt0pUmY1d/4DdCL
	 5uEz5yJsFRe/Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 393/713] drm/tegra: hdmi: Fix some error handling paths in tegra_hdmi_probe()
Date: Sun, 24 Mar 2024 18:41:59 -0400
Message-ID: <20240324224720.1345309-394-sashal@kernel.org>
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
index 0ba3ca3ac509d..4cfa4df2141cf 100644
--- a/drivers/gpu/drm/tegra/hdmi.c
+++ b/drivers/gpu/drm/tegra/hdmi.c
@@ -1855,12 +1855,14 @@ static int tegra_hdmi_probe(struct platform_device *pdev)
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
 
@@ -1869,18 +1871,18 @@ static int tegra_hdmi_probe(struct platform_device *pdev)
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
@@ -1890,10 +1892,14 @@ static int tegra_hdmi_probe(struct platform_device *pdev)
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


