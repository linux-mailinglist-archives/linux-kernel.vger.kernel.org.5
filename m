Return-Path: <linux-kernel+bounces-114531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFFC888AE5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14401F270CD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552E91836C3;
	Sun, 24 Mar 2024 23:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltu4Ve8D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6684315B55F;
	Sun, 24 Mar 2024 23:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322163; cv=none; b=a2pfV3718tWFjiOhYQGvBl/gk9MhSMhJHTXte/wqmWr+gvY2Zhwy9KSWqsJusdwRQuz+6LMwdcazhJDtjW22mjIeKPUZb6tcNLy5YoUeshavJFlQnTbFSkWjKzna/RlQHSmlXakHZQRoW2hA105mmrPhj1E4ahhk88fbZHL/lCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322163; c=relaxed/simple;
	bh=v247/Hb3yhEX1HNbDArwsiEY4dTdkSbhRPLRkNWVN98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMKhxlQsrkjknyfMFEK1QG4FZM1oWIdbjy61db2LldgKc3duo9PmlnCUCnRZncuc1IeY/8IiWw6FBHsxAFmVrahPXnUsGze+ihD6FmrslrzRhdHqe6zKMbqcMeEL6QGrR1sgNxcFwPVdWKZnjqL4R3cvgqOF0+uhHiPdISmu9PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltu4Ve8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6310C433C7;
	Sun, 24 Mar 2024 23:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322162;
	bh=v247/Hb3yhEX1HNbDArwsiEY4dTdkSbhRPLRkNWVN98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ltu4Ve8DzDUXvUZQpIH8J/5U4enyzESPUa4gL412Uqd1G6alUiL6ubl8F2qJ4Q5eG
	 DZgerSuQNpjrME2P8t/SD5hLdkaDAZnc0JWtfY2PAmfOFOXfHispkX4mNqE+g3J3LX
	 Wrk8Rrj5T81MgVdOejhHznF7M8jiFBii9fJGB8xguLi9fOvgVAIMb/8ksZqXEPBflh
	 5Fwo3FISH0S/0L2KlJxyqd5b01HbOx+z2py4HGv8Noib4ZklA6DLzjcDpEaL/xrJT5
	 g2aLHL8qoybXSiWvKE3DJR7Zzk63cLjmzxGORpkFRv4tTxlmYboMbYp7UiK30TGFfW
	 /4bAszAJIf7qQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 240/451] drm/tegra: hdmi: Fix some error handling paths in tegra_hdmi_probe()
Date: Sun, 24 Mar 2024 19:08:36 -0400
Message-ID: <20240324231207.1351418-241-sashal@kernel.org>
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
index f83d9041327f0..c66764c0bd250 100644
--- a/drivers/gpu/drm/tegra/hdmi.c
+++ b/drivers/gpu/drm/tegra/hdmi.c
@@ -1838,12 +1838,14 @@ static int tegra_hdmi_probe(struct platform_device *pdev)
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
 
@@ -1852,18 +1854,18 @@ static int tegra_hdmi_probe(struct platform_device *pdev)
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
@@ -1873,10 +1875,14 @@ static int tegra_hdmi_probe(struct platform_device *pdev)
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
 
 static int tegra_hdmi_remove(struct platform_device *pdev)
-- 
2.43.0


