Return-Path: <linux-kernel+bounces-113248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 428B88882A0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CABFB285DD7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1F61869C3;
	Sun, 24 Mar 2024 22:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUCzykO8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3617518638C;
	Sun, 24 Mar 2024 22:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320048; cv=none; b=qw31kFzBM+m7le0AjqXYoMJGJ3uh/q79zhp6IXgXK2WTRZQYnWcTXieFWDKhx8PRCUR4WyaN4dba6QR5vDzFkGpoOYCQnfr1hl6Ad8zedMUahN0coZprWbn9PfZiMgxf9lZ41jlAVtn7HtqWDx+QiIOb/N1vESDW/L8AqBn83cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320048; c=relaxed/simple;
	bh=HiFTlZ3SKcc4YSHufcREYcJE8gSsUS12Vn56iUfMUs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K3yoHyvnDwRIwJcEnCNDxgK7NcjrGwFLT6ZkZfFSdEQ6SkKgX9y4f37YFIXLQ8DwlqlRqDYYDRNqN2YW2eB5pdMoswqBWSj++uu8Brt6w8ou3wcZlUMugeYmPgAJG1LG43qwc5NJYynFHVUE252Sor75BuqegP7DnidWKlzADPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUCzykO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E2FC433C7;
	Sun, 24 Mar 2024 22:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320048;
	bh=HiFTlZ3SKcc4YSHufcREYcJE8gSsUS12Vn56iUfMUs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SUCzykO8QO3y3Vd3LKq2FkZ8xRb3zNvwa+LlIT5kHISwA0xmnmbdlMhiqNAT0ZANX
	 3mRmWF9DSU8KAQVlDUkS6KIuggmc49P2KgObzkFzEFOF1RouxIY3NozRBuMBt2ZYRM
	 LabISNei/YEtNlQ4TZ6/PlCQHU3Irs+jJImsTjxWsyr9qRcWoXUD/YmTU7XGw+vtYp
	 +qjf8/wfeQ0siKUMa6hKazRYxIE0vZDP59pH2ASB1EraGa8knRybhrL/68A907G85Q
	 s/wIT/DR2+emFP8HZCi5hmzCWG6mgQsbvwJaePeICgsdpiQeQksWCaHsF2qi6YkJUd
	 7a5PIQzg8u5vQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 357/715] drm/tegra: output: Fix missing i2c_put_adapter() in the error handling paths of tegra_output_probe()
Date: Sun, 24 Mar 2024 18:28:56 -0400
Message-ID: <20240324223455.1342824-358-sashal@kernel.org>
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
index dc2dcb5ca1c89..d7d2389ac2f5a 100644
--- a/drivers/gpu/drm/tegra/output.c
+++ b/drivers/gpu/drm/tegra/output.c
@@ -142,8 +142,10 @@ int tegra_output_probe(struct tegra_output *output)
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
@@ -152,7 +154,7 @@ int tegra_output_probe(struct tegra_output *output)
 		err = gpiod_to_irq(output->hpd_gpio);
 		if (err < 0) {
 			dev_err(output->dev, "gpiod_to_irq(): %d\n", err);
-			return err;
+			goto put_i2c;
 		}
 
 		output->hpd_irq = err;
@@ -165,7 +167,7 @@ int tegra_output_probe(struct tegra_output *output)
 		if (err < 0) {
 			dev_err(output->dev, "failed to request IRQ#%u: %d\n",
 				output->hpd_irq, err);
-			return err;
+			goto put_i2c;
 		}
 
 		output->connector.polled = DRM_CONNECTOR_POLL_HPD;
@@ -179,6 +181,12 @@ int tegra_output_probe(struct tegra_output *output)
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


