Return-Path: <linux-kernel+bounces-155019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D667E8AE46E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28E16B25C9C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6D8134CD2;
	Tue, 23 Apr 2024 11:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEO0KSXc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C775B13473D;
	Tue, 23 Apr 2024 11:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872418; cv=none; b=Fchsxc5zlyHDA17xRnRR3Fpg+sWvWmyUdhTm1V09kAFPUBsXS2PndrG95F+EaPkk+ImEcTtYCoUbQL1uRNiDvX22lNg6Jh5xROD94kiDWNNGh9O1Q5bSohD1yz87mFE0rFjNPI3jja1FlthshzPCJ5rOo8pwA910h6Ha4HAD+2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872418; c=relaxed/simple;
	bh=BwvQ1kTjR5m/f9b/fp7fyCJyC1W8r0R2gmIYCYSD9vE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qrPNC8uZXLj4+Bjo3NijHNwOFAd/ryrhurMyefOdDoU6e9d4Q0aVH/At6WTREV8sy8MeM3hvKV6e8rgDlsWJWI7eDi3okEtv1EOmRRbYuVxfIGR+eKdANAGTc6Aj0fmm9LK7UpYkztVKcFDyhs1TyrWYjoe1nycL4bdEwQOO2ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEO0KSXc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 968B1C3277B;
	Tue, 23 Apr 2024 11:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872418;
	bh=BwvQ1kTjR5m/f9b/fp7fyCJyC1W8r0R2gmIYCYSD9vE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FEO0KSXcRyuOa8wtyF/UbTTHJhJyjSN9ytjG9diA7THXDAjP2zl+E+dPIYIO3Pihz
	 OBzrf2NNHTbbIoPykOzAQDkOsPmANqw+zG92cm9DikfgaRPcrgZsqyQMSvUM5A8RfB
	 8ueaqrsdLdNCEU6ForqC1+F3XrD5dxl3W9ETGf7CpR7Oz8py6EQ6cgKaj/1Ox6INeh
	 AeaCiyDEZMuiUsI4QLF8isjElDIQSj1tcHQxIk2f9VQyGBRpzsmzbfHMV8IxMBp2we
	 IqYy7fg07r53fWJuukRJh4pbEnb60fZtZ1MP2CG3M4VFczA7e99fOtlDsUWtrF1vSV
	 zd8HsUe49rOfw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	vz@mleia.com,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.8 11/18] gpio: lpc32xx: fix module autoloading
Date: Tue, 23 Apr 2024 07:01:07 -0400
Message-ID: <20240423110118.1652940-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110118.1652940-1-sashal@kernel.org>
References: <20240423110118.1652940-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.7
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzk@kernel.org>

[ Upstream commit 11baa36d317321f5d54059f07d243c5a1dbbfbb2 ]

Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-lpc32xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-lpc32xx.c b/drivers/gpio/gpio-lpc32xx.c
index 5ef8af8249806..c097e310c9e84 100644
--- a/drivers/gpio/gpio-lpc32xx.c
+++ b/drivers/gpio/gpio-lpc32xx.c
@@ -529,6 +529,7 @@ static const struct of_device_id lpc32xx_gpio_of_match[] = {
 	{ .compatible = "nxp,lpc3220-gpio", },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, lpc32xx_gpio_of_match);
 
 static struct platform_driver lpc32xx_gpio_driver = {
 	.driver		= {
-- 
2.43.0


