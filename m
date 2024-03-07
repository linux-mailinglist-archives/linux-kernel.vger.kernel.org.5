Return-Path: <linux-kernel+bounces-95693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A82E2875154
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 487961F232CF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A677D12DDAF;
	Thu,  7 Mar 2024 14:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvhF20uQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E815612D779;
	Thu,  7 Mar 2024 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709820455; cv=none; b=pgkKHNJr118RYPpxcDTtp8H0Y+xePfJ3nN4y24e4dCYsRs2nvjzD0BJBlmgch0RpaMllY6dGzkHPmqvYNWRlepPejCQE3FGoU42CrzKP5pRX24X5PaWhP2K4TEPwqgNmCgro8X3Au41jv4yWR0JfWb8eKmhcQMp5xW5RM0GgByc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709820455; c=relaxed/simple;
	bh=wVfBUfFXr/Mm3SfDtTgqpjDmUiqQ3rkkVC81aOHU33Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A/5NshibocKMXyP7kwQNZyY8NCnBu6nLWKemlrKqYCOiyvff/cfx9sPKFBTfbt0eCkZ+Jx9HRKMGgHC5Z4rL98XycdxsnGPpnvpxjO6e6ahuNGeFqHarqZ+lr95cv+0o6q4srXt9f58K7ZjjRrvmBV/YRQD7i2eM3ZVrNsfvqOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvhF20uQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3FBC433C7;
	Thu,  7 Mar 2024 14:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709820454;
	bh=wVfBUfFXr/Mm3SfDtTgqpjDmUiqQ3rkkVC81aOHU33Y=;
	h=From:To:Cc:Subject:Date:From;
	b=pvhF20uQKIprQ8g8U/7M+MLaoYkIfpYKq5KoxXHM58n7V1dwUgIyg+gnJien9dwwo
	 Xvp2ZAb/TDFgOGvltF+0ffIxAnq9tgzIRfruQPbn2TGF8LNH+BviRdxx3lv9jvxe5G
	 LChwX/rwCnMXptEwhY3BVrWG0qbXfvdQ9d5WWQTFKAWtjpCslMwY+giWY2V5PIUTGU
	 zUqSNLpUr0c6XRY3eSxv/v+k24PVKak3onvVpVjvLrc7HBCMgwiUlzzKUS8MvPeYYj
	 0aGU8GZ6rFjeDbRDedCXlkPRjcEVKka4Wxy2X6H6gLOE2Rfy4c92RRxwQSFwUR4ncT
	 i2GJExz8bLQcQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	David Bauer <mail@david-bauer.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: aw9523: allow building as loadable module
Date: Thu,  7 Mar 2024 15:06:44 +0100
Message-Id: <20240307140729.2278907-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_I2C is set to =m, the new aw9523 driver fails to link:

arm-linux-gnueabi-ld: drivers/pinctrl/pinctrl-aw9523.o: in function `aw9523_probe':
pinctrl-aw9523.c:(.text+0x9f8): undefined reference to `__devm_regmap_init_i2c'
arm-linux-gnueabi-ld: drivers/pinctrl/pinctrl-aw9523.o: in function `aw9523_driver_init':
pinctrl-aw9523.c:(.init.text+0x4): undefined reference to `i2c_register_driver'
arm-linux-gnueabi-ld: drivers/pinctrl/pinctrl-aw9523.o: in function `aw9523_driver_exit':
pinctrl-aw9523.c:(.exit.text+0x2): undefined reference to `i2c_del_driver'

Make it a tristate symbol so the dependency is correctly honored.

Fixes: bfa5aa367a82 ("pinctrl: Add driver for Awinic AW9523/B I2C GPIO Expander")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pinctrl/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 21d38bf2d1ca..d45657aa986a 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -128,7 +128,7 @@ config PINCTRL_AXP209
 	  Say Y to enable pinctrl and GPIO support for the AXP209 PMIC.
 
 config PINCTRL_AW9523
-	bool "Awinic AW9523/AW9523B I2C GPIO expander pinctrl driver"
+	tristate "Awinic AW9523/AW9523B I2C GPIO expander pinctrl driver"
 	depends on OF && I2C
 	select PINMUX
 	select PINCONF
-- 
2.39.2


