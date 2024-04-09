Return-Path: <linux-kernel+bounces-136538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E8289D557
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C319282C30
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0312B7FBC2;
	Tue,  9 Apr 2024 09:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CJaUxvWu"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41E17E798;
	Tue,  9 Apr 2024 09:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654481; cv=none; b=qir1HSKB2vDlXf7gdvZBuAr9zbL4g42pzb7HBwMckQ1haU9XTOeVkvm3uktKayKm7L/CvzPIM+VxxmHFBRupPdbP2OZS/xToS22nJ+9GTaq8s4+RLnLpIrauMIwyAFU0ECKhemKdiuUHbv8DlWBjW57JT31sTy+bOdpO733y/HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654481; c=relaxed/simple;
	bh=L55iLpsbIZ+5RYaT9LyDbQhxY6Gq3oW3OyLMYDl+CcE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WcrNxabkEYiEmPjNp4NwVTMGne7VsJkL8u66UZ12l4KKDO3FIrqr5ZGtKzMZN8UY9gW46Y9X3ADMtlNg9U8tw0NRnF5qGNiDanbWzJ36mNO4WpgLnAq6JaQHwJtk/0EggwFVlaBuW/4jDq6J++sNA75KU1Fg5KOhsXqZ5H0pc8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CJaUxvWu; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 806581BF208;
	Tue,  9 Apr 2024 09:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712654471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WpIo0b1UVsh1fxNr1ZZUxhvbWy3Yo7lP2Ma4USOQd64=;
	b=CJaUxvWuQ9VDKqKT3pQ+nyvMW7jY+Uu5yxmuLr+CmqaAdjPnS1vynele/n4HfYG2L1nUq0
	SNMzzr1sFIrEBUXddWM9bvDZrURAMxb7lSVEiUdvE8JsUS/gNyW1Ds5HRccPvITxREPBXv
	0QHdUCsgFVLUSIAc5IPKjkDezC2+0mqNprgvUZXaCz8VMudfSnrcVjZ4OVEMbvYHnfYq5E
	nl2UklAtQNLQbtY3TZvn1/4v0PMO8Mz6abSN/F1OULIJsibGLzeI/lBx1oVsgQ/StaUlUG
	iYhTlB2I4XhBhX7X3FmNV17L0nsHm/VOl+jm0LxDVQgpqW1/SjZGsGd7MpJF2g==
From: Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH net-next v2 0/5] net: stmmac: Add support for RZN1 GMAC
 devices
Date: Tue, 09 Apr 2024 11:21:43 +0200
Message-Id: <20240409-rzn1-gmac1-v2-0-79ca45f2fc79@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKgIFWYC/22NQQ6CMBBFr0Jm7Zi2ghZX3sOwgHaASaQ1bUNQw
 t1tunb58vLf3yFSYIpwr3YItHJk7zKoUwVm7t1EyDYzKKFqUQuF4eskTktvJF51Y0Z9ay9WEOT
 BO9DIW4k9wVFCR1uCLpuZY/LhU15WWfy/4CpRYDOQGpRua6vNY/A+vdidjV+gO47jB8GCFH+wA
 AAA
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

This is version two of my series that adds support for a Gigabit Ethernet
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
base-commit: 87c33315af380ca12a2e59ac94edad4fe0481b4c
change-id: 20240402-rzn1-gmac1-685cf8793d0e

Best regards,
-- 
Romain Gantois <romain.gantois@bootlin.com>


