Return-Path: <linux-kernel+bounces-163470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 749F18B6BB0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA12FB21D30
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8604501C;
	Tue, 30 Apr 2024 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IjzVdc4P"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A145738396;
	Tue, 30 Apr 2024 07:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714462151; cv=none; b=pd2RjY5PqxBLapYorjLp+uwgF4IXG7K0yBKK6y5fWnXjxEwT0K9lIQHksz4dWdQL+jVi11W1Mp5+5S4BgvJFRUbH3byo9QldPZsYX1Xhl3yAY87/nAIEkq8co88oYPt2hvZ3L9XwyBUGfZxyiE5Fh6ZCurnBhZCxpARL4MR6JyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714462151; c=relaxed/simple;
	bh=GL8N92QAeMgFt4XkyNeVeTu8Ol0R9O7pT2ilKco2X2o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=B/0gcGO6a2cTSwWq419n2mWAk0csxMVE3yr7W1Mrgx67ZJoUdudbHB8yVG9o95pjt2gyTdyh1M3HSdD9iP8EZWHRtqureMLv2b7GItZgTY+bJAkavBjQ5neQLt/i5aNZ+FOrxy7DfmdedJJRlpHGPVGlzujJASLSHaKxV+2pb9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IjzVdc4P; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 267F4240005;
	Tue, 30 Apr 2024 07:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714462144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fQD1CJTNwkZwiLmvdXIT1s+F6Ra4eUNZk70fwrI5wTU=;
	b=IjzVdc4PuCxZ+uSFw5LswCv0DEOq/AyAdyVaqT4ZupNdm6A6jlGx9Gq0D08uKlR2kn9Kgy
	fZ83fXhMV08UcaKRPWPmHDaDgeb7Aok7KTMXVGD0L7s3yIoqY4wG3K+59xvRoPxjQ5Rzfb
	887jjJH7gROIDxb1YplcAuyWmyh4Q6ZTQFrIoxneGxCXkg++0eMAnxG2EL76eq+SiDMbz2
	4JqdCkOlgFHSyJUGuLdlLoFNk8hfEdTfiSf/7ORVMZeqEvs3BBZ+YrxRHtFYUSIzx5buwc
	K0a74n9zsjVFwxJ9eTY+rQ+YjD60BECTq7wjhAVB5DXmkKXMe7Cu2+nd5r3A/g==
From: Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH net-next v5 0/7] net: stmmac: Add support for RZN1 GMAC
 devices
Date: Tue, 30 Apr 2024 09:29:40 +0200
Message-Id: <20240430-rzn1-gmac1-v5-0-62f65a84f418@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOWdMGYC/23NzW7DIBAE4FeJOJcK1ksNPfU9ohzwenGQGoiwZ
 eVHfvcin2y5x9Hom3mLkUvkUXyf3qLwHMeYUw3m4yTo6tPAMvY1C1CAChXI8kpaDjdPWn5ZQ8G
 2rukViwruhUN8rGNnkXiSiR+TuNTmGscpl+f6Muu1/29w1lJJ0zF0YB32ln66nKffmD4p39ahG
 bbY7TBU3DryaAIEat0RNxuszQ43FftOQwBCVLo/YtxgwB3Giq0BX4+JFak9XpblD8vZmUpnAQA
 A
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

This is version five of my series that adds support for a Gigabit Ethernet
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
Changes in v5:
- Refactored the stmmac_xpcs_setup() function to group together XPCS and PCS
  setup logic.
- Added a stmmac_pcs_clean() function as a counterpart to stmmac_pcs_setup()
- Link to v4: https://lore.kernel.org/r/20240424-rzn1-gmac1-v4-0-852a5f2ce0c0@bootlin.com

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

Serge Semin (2):
      net: stmmac: Add dedicated XPCS cleanup method
      net: stmmac: Make stmmac_xpcs_setup() generic to all PCS devices

 .../devicetree/bindings/net/renesas,rzn1-gmac.yaml |  66 +++++++++++++
 MAINTAINERS                                        |   6 ++
 arch/arm/boot/dts/renesas/r9a06g032.dtsi           |  18 ++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |  12 +++
 drivers/net/ethernet/stmicro/stmmac/Makefile       |   1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-rzn1.c   |  86 +++++++++++++++++
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    | 107 ++++++++++-----------
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   3 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  14 +--
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  |  48 ++++++---
 include/linux/stmmac.h                             |   2 +
 11 files changed, 287 insertions(+), 76 deletions(-)
---
base-commit: dd1941f801bc958d2ee13f5be8b38db6b034b806
change-id: 20240402-rzn1-gmac1-685cf8793d0e

Best regards,
-- 
Romain Gantois <romain.gantois@bootlin.com>


