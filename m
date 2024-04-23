Return-Path: <linux-kernel+bounces-155036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6938AE49D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC2BB287150
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3138680028;
	Tue, 23 Apr 2024 11:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Il2Lwf2h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689FB13CA88;
	Tue, 23 Apr 2024 11:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872447; cv=none; b=q3ZiLVWYSi135cBX/LQJy8eTnD4owGMDaGoAmb12JFPQ5WS/3/d2nigPah8zSG6NyjSPvU31NQ67ht+P2Q5t7ASptfEZIxTiolzBzXhwHQTFkukbiq1ULoj/QcHASYQwWLjcZcvVy9HXmKwLNYw2ItQ4FqgB4zmGOUa5wWDYytw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872447; c=relaxed/simple;
	bh=BwvQ1kTjR5m/f9b/fp7fyCJyC1W8r0R2gmIYCYSD9vE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=olbHMj/2C27EOGuemJWqf0eEpwXv/M4amtzanFv/NVdCfSdONz0qIeC5Par2AoQIXzokk2Ft4p5UoEcowIa/AsFlbkDB4ilIAXmCOhdBSHGz3nVrg+rQzapzXLBM/0WD7OMTztyyTEMBH83YuWHV8edyCBWaOeQcju80CWS7BEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Il2Lwf2h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38BCFC4AF07;
	Tue, 23 Apr 2024 11:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872447;
	bh=BwvQ1kTjR5m/f9b/fp7fyCJyC1W8r0R2gmIYCYSD9vE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Il2Lwf2hKHghBU0o87BNob9rmt3/KDA+txF8rLaCEZqZCgfWO1At/LtoLYdAA2QUM
	 d8OSk/xa/r5mtjsKzzh38+SMiJhhLKut/Vae04QggH1oYxJT/WuhF9mQBDhMz0Qlj3
	 ChEcuUtAM29aCM7zEfwITsaKI/rHjMElHB7iXaLIVjx5whRvPz7CjvIZ+nxV15FNyA
	 k07qjS2rz9LWX4K3iBCgP7Mr6SHgKjsstEunPe1BlgTluQMOnbGZVtqz7k6a86LNai
	 5CkRRDRXoV0MPXjqsd7ZU2CsOLJ7Yvn4fRNXYPxSHQA2faNqhGATnnEX2R/4tm6u+O
	 ksL83szcirrLQ==
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
Subject: [PATCH AUTOSEL 6.6 10/16] gpio: lpc32xx: fix module autoloading
Date: Tue, 23 Apr 2024 07:01:43 -0400
Message-ID: <20240423110151.1658546-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110151.1658546-1-sashal@kernel.org>
References: <20240423110151.1658546-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.28
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


