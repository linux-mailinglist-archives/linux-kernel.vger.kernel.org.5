Return-Path: <linux-kernel+bounces-114816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A3B88916A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FE60293A83
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277D41B9DB6;
	Mon, 25 Mar 2024 00:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8xxxeIn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB75176FA7;
	Sun, 24 Mar 2024 23:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323462; cv=none; b=e6XrlPXvBqWh+OqNl84DUmjELh7YrV1i8dx/WsBmcQ7GP6cXUVS0BJxcp1uzquz/Qputj6rk8PoqBYmgi7fAYAyfUe+rHnybmEJeFJJGdCaU7Y7CC9VyxbVP3ukF03gvmDyVVJDD6e4bVs0e7owc8twGvXdQrMHO5/vqEo2E6fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323462; c=relaxed/simple;
	bh=RZNVU4IURpxBQT1ORogNbGIWkBlDKgL0aWdcsIXGZEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PX/L898r5uQGrqUu0CMIjDyb0Im0e7VyYHkpOpGHvbgRGgM2jpM/8NZsaNi1e7BZvN8edhGDdpUyjEdlS6Uf8uK/fUlASqGl+FGbKmKhaR53uKfnA84Q/htqk/NmFkY3d93+Z3A7x07w8XCfFTijQgK+Tk5o+COy0rypl8dxt3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8xxxeIn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E490C433F1;
	Sun, 24 Mar 2024 23:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323460;
	bh=RZNVU4IURpxBQT1ORogNbGIWkBlDKgL0aWdcsIXGZEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i8xxxeInDtwe73YRfTrq2Z2sNRJGkU3mOCd9a2qQTKs1LcjmDU2rLpLHrd2dgNQXv
	 hX8XVXS8eTaxZ7F1IYQ6DvVeLYLMe3rNGKF0X2vh8bS3W2bQn/V2+LmSRmyQrlYYlj
	 e8hqg9WUmhh5meqPJ/WxWR9zdnrUTmAK8I06g4cHb489xMK7Zk8vtaWbjivI6T+fpE
	 vKtxEZuJSsMWtpx/zthkdCelGTF8zNGBP9fVBvF6E322yCxbWkAQ+xG/Pa9GJbdpNi
	 lIizmadKQPqx4X8semnR4u22hBco0/ZYPq7d5uDMCXtijYphx8jOW0O7zxL422yXPz
	 /43bQkmI/DDrA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 165/317] drm/tegra: output: Fix missing i2c_put_adapter() in the error handling paths of tegra_output_probe()
Date: Sun, 24 Mar 2024 19:32:25 -0400
Message-ID: <20240324233458.1352854-166-sashal@kernel.org>
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


