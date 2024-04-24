Return-Path: <linux-kernel+bounces-156597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 041928B055D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 875BE28AD47
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CFB158D70;
	Wed, 24 Apr 2024 09:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UNPCHPP3"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F28157468;
	Wed, 24 Apr 2024 09:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713949550; cv=none; b=uEqILq4txd/p5oEZkIz5LRmNKD2H+NwzvWkqFW8Z/FPL0QfLW1tcJ2Ztm5ZkD3qdsGgnlxKAK15Ru8zYgEMKO8avTSdLWfnfLaf82qrOnloIrdGWTfHS91+FZCXi83DgtE+XLtySdEucCutsxS8AHacxKsJ5z0l1D5Yfy+199Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713949550; c=relaxed/simple;
	bh=bogBlq3GioMSWRlEADNLKDYWix5sTG1UKLb00fGvlk8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kGOv6bbvggYq7uXserEAk1hp+DcTdJ4YFiwyX8SAJ2+K2yzLFIv3ZX32sNydGaaht4KxP6AQszVJRp+nJfyFJGdJfq4Jsv7DKpwa45u6OCXsHf2QhCu4proqR4lXoOXvc9FU2ZJalJNTHqgcom7PerHVQOt/psmjA2LDbaICB2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UNPCHPP3; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6B16620011;
	Wed, 24 Apr 2024 09:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713949544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zvGO6wU6nfYU3CkBpCdWWvYmaCRqlnSLXYCRyUMQSHk=;
	b=UNPCHPP3Y0cB0c0DMvt6fosro3QkCwIgQAj1fSJrI8V9T/1B7gT2LfZ5Qu+SZdKiQ6Ky1q
	GTYCqb9aCIeDI4YkLXEY//Rayxy9ROkV2BnZUz2dAD6koRfYdA7Lk2hMml4v8LNNg6410w
	nm0tcKWKft5xD3DW2amnqxy43S10uLE3vEZgX5ck0Zc/eK9fkIrfS6QpDdS9cH5RduhVT/
	B+WvICl8pCyTMSAU2EkAGkJXDUDldrMul1x7iW6UQsIeqk+7dzEQn16pBaknwe6vGYZGz2
	pbQzVA+ja2DG9FekX1vWMl+J+EiVApMsJPUl4ScDR2OV4S+7jXZnDhyVMcOlqA==
From: Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH net-next v4 0/5] net: stmmac: Add support for RZN1 GMAC
 devices
Date: Wed, 24 Apr 2024 11:06:18 +0200
Message-Id: <20240424-rzn1-gmac1-v4-0-852a5f2ce0c0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIrLKGYC/23NQQ6DIBQE0KsY1qWBL1TpqvdoulD4KEmFBoyxN
 d69xJWmXU4mb2YhCaPDRK7FQiJOLrngcxCngui+8R1SZ3ImwEAwwYDGj+e0GxrN6aWW2taVKg1
 DksEronXzNnYnHkfqcR7JIze9S2OI7+1l4lv/b3DilFHZIrRQK2FqfWtDGJ/On3UYtqEJ9lgdM
 GRcKd0IacHqSv3icoe5POAy46blYEELwbg54nVdv1gmcb0qAQAA
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>, 
 Serge Semin <fancer.lancer@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: romain.gantois@bootlin.com

Hello everyone,

This is version four of my series that adds support for a Gigabit Ethernet
controller featured in the Renesas r9a06g032 SoC, of the RZ/N1 family. This
GMAC device is based on a Synopsys IP and is compatible with the stmmac driver.

My former colleague Clément Léger originally sent a series for this driver,
but an issue in bringing up the PCS clock had blocked the upstreaming
process. This issue has since been resolved by the following series:

https://lore.kernel.org/all/20240326-rxc_bugfix-v6-0-24a74e5c761f@bootlin.com/

This series consists of a devicetree binding describing the RZN1 GMAC
controller IP, a node for the GMAC1 device in the r9a06g032 SoC device
tree, and the GMAC driver itself which is a glue layer in stmmac.

There are also two patches by Russell that improve pcs initialization handling
in stmmac.

Best Regards,

Romain Gantois

---
Changes in v4:
- Removed the second parameters of the new pcs_init/exit() callbacks
- Removed unnecessary interrupt-parent reference in gmac1 device node
- Link to v3: https://lore.kernel.org/r/20240415-rzn1-gmac1-v3-0-ab12f2c4401d@bootlin.com

Changes in v3:
- Fixed a typo in the socfpga patch
- Link to v2: https://lore.kernel.org/r/20240409-rzn1-gmac1-v2-0-79ca45f2fc79@bootlin.com

Changes in v2:
- Add pcs_init/exit callbacks in stmmac to solve race condition
- Use pcs_init/exit callbacks in dwmac_socfpga glue layer
- Miscellaneous device tree binding corrections
- Link to v1: https://lore.kernel.org/r/20240402-rzn1-gmac1-v1-0-5be2b2894d8c@bootlin.com

---
Clément Léger (3):
      dt-bindings: net: renesas,rzn1-gmac: Document RZ/N1 GMAC support
      net: stmmac: add support for RZ/N1 GMAC
      ARM: dts: r9a06g032: describe GMAC1

Russell King (Oracle) (2):
      net: stmmac: introduce pcs_init/pcs_exit stmmac operations
      net: stmmac: dwmac-socfpga: use pcs_init/pcs_exit

 .../devicetree/bindings/net/renesas,rzn1-gmac.yaml |  66 +++++++++++++
 MAINTAINERS                                        |   6 ++
 arch/arm/boot/dts/renesas/r9a06g032.dtsi           |  18 ++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |  12 +++
 drivers/net/ethernet/stmicro/stmmac/Makefile       |   1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-rzn1.c   |  86 +++++++++++++++++
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    | 107 ++++++++++-----------
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  14 +++
 include/linux/stmmac.h                             |   2 +
 9 files changed, 258 insertions(+), 54 deletions(-)
---
base-commit: 1c04b46cbdddc7882eeb671521035ea884245b9f
change-id: 20240402-rzn1-gmac1-685cf8793d0e

Best regards,
-- 
Romain Gantois <romain.gantois@bootlin.com>


