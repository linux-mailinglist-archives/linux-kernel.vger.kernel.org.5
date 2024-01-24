Return-Path: <linux-kernel+bounces-37673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D163183B370
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F1181F23B89
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551401350F1;
	Wed, 24 Jan 2024 20:59:31 +0000 (UTC)
Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E92A13473B;
	Wed, 24 Jan 2024 20:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706129970; cv=none; b=fhpieJbLZXqMy4M374qXIj26Aoh/TxMKqSIm4g0MnWTsHUUIHTipollWBu99ZY3JRHikTq4e5FSQmXsi/D23iHp3PbD/OcerGRhRkSW36HuptdBp5nKAd2OK1ykIB9g7k8l6zAg3zzcCrzkwjGGkZ7HeEPESRKMIkiAqyrQUkZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706129970; c=relaxed/simple;
	bh=8YaJyzOQmUBaeoCtjtFLEBmHtDVBAuPIQ/aBmfHjTD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sLLQlGnjRzx3te3Fvx4hsXaMLJ40F7l0+/Q6D1Ce8kAgREaHzKKev7RZ2cJSBJ5KQmOMG7eGzHxePg1/iVSr0DipLT9eZIy7cmbrFj0TJzuBXrtlEB3aZRnHe4QDweWCaOtwxDOGLKKncPU8tgmpt5DLYh8BOekoT6Taz1EAGd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from dslb-188-097-042-032.188.097.pools.vodafone-ip.de ([188.97.42.32] helo=martin-debian-2.paytec.ch)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@kaiser.cx>)
	id 1rSkL2-000SPR-0G;
	Wed, 24 Jan 2024 21:59:12 +0100
From: Martin Kaiser <martin@kaiser.cx>
To: Shawn Guo <shawnguo@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Peng Fan <peng.fan@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v4 2/4] gpio: vf610: enable COMPILE_TEST
Date: Wed, 24 Jan 2024 21:58:58 +0100
Message-Id: <20240124205900.14791-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124205900.14791-1-martin@kaiser.cx>
References: <20240124205900.14791-1-martin@kaiser.cx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable COMPILE_TEST for the vf610 gpio driver to support test builds on
systems without this hardware.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v4:
 - add a new patch to enable COMPILE_TEST

 drivers/gpio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 353af1a4d0ac..3081406ff57a 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -713,7 +713,7 @@ config GPIO_UNIPHIER
 config GPIO_VF610
 	bool "VF610 GPIO support"
 	default y if SOC_VF610
-	depends on ARCH_MXC
+	depends on ARCH_MXC || COMPILE_TEST
 	select GPIOLIB_IRQCHIP
 	help
 	  Say yes here to support i.MX or Vybrid vf610 GPIOs.
-- 
2.39.2


