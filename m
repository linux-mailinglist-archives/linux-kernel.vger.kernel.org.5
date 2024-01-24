Return-Path: <linux-kernel+bounces-37676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D277D83B379
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 112D71C23578
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6CA13541A;
	Wed, 24 Jan 2024 20:59:32 +0000 (UTC)
Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E96C1350C2;
	Wed, 24 Jan 2024 20:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706129972; cv=none; b=bcQlyEdkIdP6NKGM2EJ4NBAukRIosW+/QWg90xcyyJwv0cNn5b1mWAiuk//Cmh8akxXZS1pni/U0KFUVNPU2FJasXnBFIMKGCw2UodWPySqvVdWxDtYrEU/4CLwOh8OKKjwqEzadtFwTIIuoPUFxitlhAEQdTjI7h0x0UjVWF9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706129972; c=relaxed/simple;
	bh=/NoEDdgiF+kL2fzCo6z1NN1l8skcdUdnTPJuvRjd2NA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uJP26QgFajeW5/Rna6NFHAwxaOLLcoz6uMrvIilgOs6nlh3mTNuvzKxTMq6fr7mMYAS+u9M7gruqpDFIbJoeQpJ22idh1og1eLeRAVt1SXpRd7xiYziv8dqTXwoxnjzrFa/7POBKVL5i3urbqoRgbWmQlHA5XZbrX/CyAoUradk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from dslb-188-097-042-032.188.097.pools.vodafone-ip.de ([188.97.42.32] helo=martin-debian-2.paytec.ch)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@kaiser.cx>)
	id 1rSkL1-000SPR-0Q;
	Wed, 24 Jan 2024 21:59:11 +0100
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
Subject: [PATCH v4 1/4] gpio: vf610: allow disabling the vf610 driver
Date: Wed, 24 Jan 2024 21:58:57 +0100
Message-Id: <20240124205900.14791-2-martin@kaiser.cx>
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

The vf610 gpio driver is enabled by default for all i.MX machines,
without any option to disable it in a board-specific config file.

Most i.MX chipsets have no hardware for this driver. Change the default
to enable GPIO_VF610 for SOC_VF610 and disable it otherwise.

Add a text description after the bool type, this makes the driver
selectable by make config etc.

Fixes: 30a35c07d9e9 ("gpio: vf610: drop the SOC_VF610 dependency for GPIO_VF610")
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v4:
 - add a new patch to enable COMPILE_TEST

v3:
 - split the changes into three patches

v2:
 - enable the vf610 gpio driver in the defconfig files for arm_v7
   (i.MX7ULP) and arm64 (i.MX8QM, DXL, ULP and i.MX93)

 drivers/gpio/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 1301cec94f12..353af1a4d0ac 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -711,7 +711,8 @@ config GPIO_UNIPHIER
 	  Say yes here to support UniPhier GPIOs.
 
 config GPIO_VF610
-	def_bool y
+	bool "VF610 GPIO support"
+	default y if SOC_VF610
 	depends on ARCH_MXC
 	select GPIOLIB_IRQCHIP
 	help
-- 
2.39.2


