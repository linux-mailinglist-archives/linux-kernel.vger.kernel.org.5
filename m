Return-Path: <linux-kernel+bounces-115943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 930998898D3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF49F1C27B52
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB5C39003E;
	Mon, 25 Mar 2024 03:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SytYU7oR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143A115B56D;
	Sun, 24 Mar 2024 23:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322165; cv=none; b=RYC/mmPhKDvp3GYXOap1moPJPKkERYsvzEDpMO2j1HpSuFfC6ANd9tni9mL7dYezdA0Xj5Ye27ZPJfjKPYbLy8ZRaQgspHiVQOVAtSBX+oxzsAykaPJdwBHU+CqisybhyHn1dWde9OxOndThGDDnpNGFwDDdpm2qUKBSroxNg6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322165; c=relaxed/simple;
	bh=RZNVU4IURpxBQT1ORogNbGIWkBlDKgL0aWdcsIXGZEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ShpPZcMqwm6hh1MviGFZNviwv4W9LDiLtKyraMnBiPT/Y/p7Ow2nifnlonPzpPYHaN0Iq4OgF601pM6jrcnalTx4XXUyINblnXB4eVyNRPZK9zH4U9qr1uMeODaneqA0Eft1P+7pdZX2PZS34Y9FfM6mHPeWdMIM0qfPlVg2+Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SytYU7oR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E40C433C7;
	Sun, 24 Mar 2024 23:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322164;
	bh=RZNVU4IURpxBQT1ORogNbGIWkBlDKgL0aWdcsIXGZEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SytYU7oR30Z56Nk3nCvPv8NxKzYNROdJmui4VTEPLuDvMMT/wiJOIV2Ap33b0ZrJK
	 Hbw7icTmT7sQrOLvU2LwSRWDDNM+j9+k/IRMhMDidUG9d8ECLttZn2hMtnqasXJy+s
	 3nQxlmTgHudqu1ALTAoWawXeAWWAm0ryRB0xcJ5Tyod53TQkgQI2ny2w36/nDUJxXv
	 lC1tEUsdsqIqElEbklai2JctSMkYYaEOlwJpw09BnWFr1H+5tQLyMOXmDmhg4HNsLn
	 7qV7uJKYVQB9NJ3jtG1KvMp4NxQysFS7KtFpJucmltw8sLNqoSLN8+SLpg1cOSqnjW
	 U39s+4mrYpsnQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 243/451] drm/tegra: output: Fix missing i2c_put_adapter() in the error handling paths of tegra_output_probe()
Date: Sun, 24 Mar 2024 19:08:39 -0400
Message-ID: <20240324231207.1351418-244-sashal@kernel.org>
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

[ Upstream commit 2db4578ef6ffb2b52115ca0ebf897b60ec559556 ]

If an error occurs after a successful of_get_i2c_adapter_by_node() call, it
should be undone by a corresponding i2c_put_adapter().

Add the missing i2c_put_adapter() call.

Fixes: 9be7d864cf07 ("drm/tegra: Implement panel support")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://patchwork.freedesktop.org/patch/msgid/b38604178991e1f08b2cda219103be266be2d680.1693667005.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tegra/output.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tegra/output.c b/drivers/gpu/drm/tegra/output.c
index 47d26b5d99456..7ccd010a821b7 100644
--- a/drivers/gpu/drm/tegra/output.c
+++ b/drivers/gpu/drm/tegra/output.c
@@ -139,8 +139,10 @@ int tegra_output_probe(struct tegra_output *output)
 						       GPIOD_IN,
 						       "HDMI hotplug detect");
 	if (IS_ERR(output->hpd_gpio)) {
-		if (PTR_ERR(output->hpd_gpio) != -ENOENT)
-			return PTR_ERR(output->hpd_gpio);
+		if (PTR_ERR(output->hpd_gpio) != -ENOENT) {
+			err = PTR_ERR(output->hpd_gpio);
+			goto put_i2c;
+		}
 
 		output->hpd_gpio = NULL;
 	}
@@ -149,7 +151,7 @@ int tegra_output_probe(struct tegra_output *output)
 		err = gpiod_to_irq(output->hpd_gpio);
 		if (err < 0) {
 			dev_err(output->dev, "gpiod_to_irq(): %d\n", err);
-			return err;
+			goto put_i2c;
 		}
 
 		output->hpd_irq = err;
@@ -162,7 +164,7 @@ int tegra_output_probe(struct tegra_output *output)
 		if (err < 0) {
 			dev_err(output->dev, "failed to request IRQ#%u: %d\n",
 				output->hpd_irq, err);
-			return err;
+			goto put_i2c;
 		}
 
 		output->connector.polled = DRM_CONNECTOR_POLL_HPD;
@@ -176,6 +178,12 @@ int tegra_output_probe(struct tegra_output *output)
 	}
 
 	return 0;
+
+put_i2c:
+	if (output->ddc)
+		i2c_put_adapter(output->ddc);
+
+	return err;
 }
 
 void tegra_output_remove(struct tegra_output *output)
-- 
2.43.0


