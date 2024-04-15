Return-Path: <linux-kernel+bounces-144827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FCE8A4B54
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A39D1C21366
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EAE57315;
	Mon, 15 Apr 2024 09:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OQ8hiKdq"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DA83BBF8;
	Mon, 15 Apr 2024 09:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713172696; cv=none; b=ft6gaznxI8a6Kbn2eDQb4yObHgB0tNj8S9CWojsyIEvb5w0gRDe9++Xf/IvVvPqUDAxsJVP7dyqLhOPHajav1Wr4rLdlHi4R3EEMOfb75okP5TRwMSylp4rMbPSnCxHZV8N/MJkS1d8YY1EhjPjBaay9223lfaFd1zpaDzLNxmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713172696; c=relaxed/simple;
	bh=lDThYcOt7vma13MyZay//1zpRu7cNoGhY8q4H2Vz6kM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eR59hPkwhrPxl1hq8VSHN6Sqg6zVF45Q83SqU2JE7Kl9ZQADQ5nq2u55+NLuUyP6OIwdFNnZuIOFpR9TAfnFsAFcPHvXZ5UpUmW/1EYokfi2GFagMfxcYpji6quk+/P85l8pzhO1wPd/N5JpmntgnSquUh7uLEZGqDzhdhqOYJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OQ8hiKdq; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 46EBCC000D;
	Mon, 15 Apr 2024 09:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713172687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eCigKqN4ZXuHAYp92YPMCsXR7qfiMRuuveYHe/CK+2c=;
	b=OQ8hiKdqSSbmmEj6NjpkJX7Vn0on02LMlhLvbW3F4WfEAQTJWElox9WK50sPGuWsIWTyWG
	rqYg+aS5sy4EQgcRiOEPn/VI7rCl/fVImaCeF5MuMFIxHGBEjmYlqKq6Y9LAJHfSOdaEtA
	KCkKEoJbs2nnij2JoGRgAyDIDUff4qkk1PfQi4sWjWqLXqKetM8dCFrDKj91RksZNc/he+
	bj8akanG+yTuO/syaLY0DFlUGo60m++6H7IiaM6Z3E9YzsRX52DZjx0e3RmruVLn37d08A
	F/6ySdW4/ubj1ypWs9yv5XqInqzANk0oUKQbpZBg8jMvXjm6QdZePGbkKMm3PA==
From: Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH net-next v3 0/5] net: stmmac: Add support for RZN1 GMAC
 devices
Date: Mon, 15 Apr 2024 11:18:40 +0200
Message-Id: <20240415-rzn1-gmac1-v3-0-ab12f2c4401d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPHwHGYC/22NQQ6DIBQFr2L+ujSIWKGr3qPpQvGjJBUaIMTWe
 PcSVjXpcvIy8zYI6A0GuFYbeEwmGGczNKcK1NzbCYkZMwOjjFNOGfEfW5Np6VVNLqJVWnSyGSl
 CFl4etVlL7A4WI7G4RnjkZTYhOv8uL6ku+79gqgkl7YBsYELyUajb4Fx8GntWbimhxH5leZBZl
 jupet5qplUnj/K+71/j/dum7QAAAA==
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
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>
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

This is version three of my series that adds support for a Gigabit Ethernet
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
 arch/arm/boot/dts/renesas/r9a06g032.dtsi           |  19 ++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |  12 +++
 drivers/net/ethernet/stmicro/stmmac/Makefile       |   1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-rzn1.c   |  88 +++++++++++++++++
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    | 109 +++++++++++----------
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  14 +++
 include/linux/stmmac.h                             |   2 +
 9 files changed, 263 insertions(+), 54 deletions(-)
---
base-commit: f1e197a665c2148ebc25fe09c53689e60afea195
change-id: 20240402-rzn1-gmac1-685cf8793d0e

Best regards,
-- 
Romain Gantois <romain.gantois@bootlin.com>


