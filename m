Return-Path: <linux-kernel+bounces-116270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB1F8895D7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 807901C2E2DA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4A41327E7;
	Mon, 25 Mar 2024 03:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oc34BKFn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4820B181806;
	Sun, 24 Mar 2024 23:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324091; cv=none; b=c5J7Q1z5hoWkyz+hwq6SmRBaLziBXVC5v3fxbP8Zmn5cA6JgV0gcjx+9EbPJxY2Ky0w5DefvkJ3KHuRiMa7EEbHy0D2JbJydKoHKOL/bPrDsLFtVa0SHyO5sMqFZN/UvJ8RlOe1xu9hrYkTRiYZKV9cPBlKCB/qlOvOxAuxFa6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324091; c=relaxed/simple;
	bh=fQ4pDnoEGS24uK7PN4tSU8hDTyazw65f8yIfQ9B9TyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMXPNAWj5U/ydpFBzlk+M16ZpFZKFyIvsQXxisMcuzrbcMZJGHrh+d6DsPXah5JmoeToIxhd3vHJ9r3zAJgnc8gFKDhvDIgfYV934mI8gnatRzaSuQZ4CX2m5txwp3Jlj8Qm8dhsjmSj4Nq6lb2wyiso+X/sd58DWv3bO4aoSRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oc34BKFn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29729C433F1;
	Sun, 24 Mar 2024 23:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324089;
	bh=fQ4pDnoEGS24uK7PN4tSU8hDTyazw65f8yIfQ9B9TyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oc34BKFnSNHz0Rmm0Bte+KA3S6ZXU9VzpXtpupiJFCgyLX6hwe72Mk0MYyU4r2Pdv
	 O78z0zvfvFZeFqltF70VEtf6i5F9wUtjezTsqHtxx2+5QyygjGt5I4gTjEUxLySSdf
	 mTYPTV4S60CB4No8Flq1vxZ+Vo7VfGJIAJDh2o/gGXaDc/s7kx+IXwbbkoC6jtXVJ0
	 8McHQKLSB3914naaVwFKrNLpfd9+1QPmdGBuXDUBQloEfLDgm4QucRnQoWHhLdBMA8
	 xlK2Yr3c1Ysd1IMZ452Nm4ZO5Y38AUnigEuVcwVzUQ99v7SlVcIDoVToEVZkI8bIja
	 gGj5ndD9gU63w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 090/183] drm/tegra: output: Fix missing i2c_put_adapter() in the error handling paths of tegra_output_probe()
Date: Sun, 24 Mar 2024 19:45:03 -0400
Message-ID: <20240324234638.1355609-91-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index bdcaa4c7168cf..806249c0b7e85 100644
--- a/drivers/gpu/drm/tegra/output.c
+++ b/drivers/gpu/drm/tegra/output.c
@@ -127,8 +127,10 @@ int tegra_output_probe(struct tegra_output *output)
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
@@ -137,7 +139,7 @@ int tegra_output_probe(struct tegra_output *output)
 		err = gpiod_to_irq(output->hpd_gpio);
 		if (err < 0) {
 			dev_err(output->dev, "gpiod_to_irq(): %d\n", err);
-			return err;
+			goto put_i2c;
 		}
 
 		output->hpd_irq = err;
@@ -150,7 +152,7 @@ int tegra_output_probe(struct tegra_output *output)
 		if (err < 0) {
 			dev_err(output->dev, "failed to request IRQ#%u: %d\n",
 				output->hpd_irq, err);
-			return err;
+			goto put_i2c;
 		}
 
 		output->connector.polled = DRM_CONNECTOR_POLL_HPD;
@@ -168,6 +170,12 @@ int tegra_output_probe(struct tegra_output *output)
 		return -ENOMEM;
 
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


