Return-Path: <linux-kernel+bounces-50384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C53C184784C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 722CC28794D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB05135DB5;
	Fri,  2 Feb 2024 18:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhX0SRoZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CED153BF2;
	Fri,  2 Feb 2024 18:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899241; cv=none; b=SZmi7uGK4Q1WicTTNf/DVNb4n1cq8UpaVeMN1pOZXRfzKPO51qd0gLFx1C43F02/QloivT9lsOUoJgGd6CE+95n2luDlDKGf/MjDy4DgHvyw6BJm+Zz00dmPt4qSuC4fjEnlAyxjrFTQ7J8mzi4As/FuQorRLKbgx/CW1RMXPPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899241; c=relaxed/simple;
	bh=MAtB2ChwFF1exhEfUKrF79D5jxW1fp8BGXZSzKt5ZVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=haCjM0/mUxWeuAOVRoyiyBlIlRJ/Bv2zX/aFbSeraA9SAa0yGWhgYeSnH+ExEVKE5pD6HO/JmYCItRETIDqZmJj3VHG7wepSHW98IptDmbZiDX0TQOSGUv0g3gYBwlUaRa/IgOAQ9clYhse8YJmMV7LWdKZGZ5Yr5jGqHccrpgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhX0SRoZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4834C433F1;
	Fri,  2 Feb 2024 18:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899240;
	bh=MAtB2ChwFF1exhEfUKrF79D5jxW1fp8BGXZSzKt5ZVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EhX0SRoZrAEPk9SP6uEk2AtaIuXHtQ5r6POkIp57CPHzxwigN4VraEnhaodTIespw
	 RRsN1F9kk0/obwmkwQQuu46fR7fbm2yGFBLdFlOPBnBFL5OxUd9SXdHqavjI9L9EPf
	 DmSsrU3VFgjDDXrpYQIOM5qKTV5TJkmfGLrGOdXuAROBTmbgcWhf68fiyifYaEtnlf
	 YRSP6tRTnU2kruNwgDp2iEjx2fqKQ5rpt6KiNHhnGDCVFiEES8gvQrjDcVvuFs0cXy
	 oirZOQ38spCtEA1ewAJuARG41ITGgXHaMeDNb2o/RGKmJigon8oXHZmIriWZzdiLsQ
	 9Qb0Lc25iloAQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.schulman@cirrus.com,
	david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 16/21] spi: cs42l43: Handle error from devm_pm_runtime_enable
Date: Fri,  2 Feb 2024 13:40:03 -0500
Message-ID: <20240202184015.540966-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184015.540966-1-sashal@kernel.org>
References: <20240202184015.540966-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.15
Content-Transfer-Encoding: 8bit

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit f9f4b0c6425eb9ffd9bf62b8b8143e786b6ba695 ]

As it devm_pm_runtime_enable can fail due to memory allocations, it is
best to handle the error.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://msgid.link/r/20240124174101.2270249-1-ckeepax@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-cs42l43.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index d239fc5a49cc..c1556b652909 100644
--- a/drivers/spi/spi-cs42l43.c
+++ b/drivers/spi/spi-cs42l43.c
@@ -244,7 +244,10 @@ static int cs42l43_spi_probe(struct platform_device *pdev)
 	priv->ctlr->use_gpio_descriptors = true;
 	priv->ctlr->auto_runtime_pm = true;
 
-	devm_pm_runtime_enable(priv->dev);
+	ret = devm_pm_runtime_enable(priv->dev);
+	if (ret)
+		return ret;
+
 	pm_runtime_idle(priv->dev);
 
 	regmap_write(priv->regmap, CS42L43_TRAN_CONFIG6, CS42L43_FIFO_SIZE - 1);
-- 
2.43.0


