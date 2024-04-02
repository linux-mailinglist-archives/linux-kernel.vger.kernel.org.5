Return-Path: <linux-kernel+bounces-127949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41ED0895332
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A29E9B263B5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863A47F7ED;
	Tue,  2 Apr 2024 12:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Qr4KMBLU"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDD078B63;
	Tue,  2 Apr 2024 12:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712061402; cv=none; b=pbtBhMSCNPbe1QufSSiYTreASXchZCQd1Um5ziA3v3YgrpNblQ0q3nGwztF1Zr8lB7YZcBHHdnWDr0tt6Lpm7qSSodfNaiaTtllocyrAGdVNrZuvyT0tGv9Gw8biVJxsaaaGiwSL6fZiQQHmCrWSxuGEgoLALDCbwUM+gGPxtLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712061402; c=relaxed/simple;
	bh=CqoAkQqjHL6tWHYJw4f9BhF7XnKfqr4ur0BOKMnjGwY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=I1s3pNNcPeeiU0/hlpa3rZTo70XHNvpwajxzo89Pkdkt5OJY0x9yW3eajrtStE5yE10+AHO1j25iOftocYViCepVHp+DNKsBzZHiOphaISTw1WcDy/GMmkArfJROIDjAAt6x9BtKwvFWxNZXLHJVswSk8GSh6BdVKYqENEDSCYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Qr4KMBLU; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CE393FF810;
	Tue,  2 Apr 2024 12:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712061393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vbMj3lx6/AbEHxFwUiXuMUpd+hrzcJ437vem59DVMVE=;
	b=Qr4KMBLUPrDOshUpxPGyYmIyAe9REwoFnf81l5s5Cd1aYPEMEXbC+uiezz1MyirfLQTVf3
	vCk0KCQ83dECqHCONREOe8nt1qvvH4vmMBj7yYMsIe7amQhH3LBNeq+VwyF2t+Yt4LrpSj
	V5vKw5RCsHmSEy32P22ST58gflprLoHFN+LZh2F0HX+uo77UllaXMsWX1pRysGV4358GzU
	z0bbqwEWWRV8WmNZHf5/8CKhDVj+ptKpibvGH26mixv3g2EHfNQanpfrmUGznMmf6m/k0B
	kqUWlviZzGnsI4Ers/NzAvje4jkr3bzhahVCwMA+f57PclaNazf5H7XCkIOJyQ==
From: Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH net-next 0/3] net: stmmac: Add support for RZN1 GMAC
 devices
Date: Tue, 02 Apr 2024 14:36:59 +0200
Message-Id: <20240402-rzn1-gmac1-v1-0-5be2b2894d8c@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOz7C2YC/x3MPQqAMAxA4atIZgNt/fcq4iBtqhmM0oqI4t0tj
 t/w3gORAlOEPnsg0MmRN0nQeQZ2mWQmZJcMRplSlcpguEXjvE5WY91W1rdNVzhFkII9kOfrnw0
 gdKDQdcD4vh9T22SNZgAAAA==
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
 Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: romain.gantois@bootlin.com

Hello everyone,

This is version one of my series that adds support for a Gigabit Ethernet
controller featured in the Renesas r9a06g032 SoC, of the RZ/N1 family. This
GMAC device is based on a Synopsys IP and is compatible with the stmmac driver.

My former colleague Clément Léger originally sent a series for this driver,
but an issue in bringing up the PCS clock had blocked the upstreaming
process. This issue has since been resolved by the following series:

https://lore.kernel.org/all/20240326-rxc_bugfix-v6-0-24a74e5c761f@bootlin.com/

This series consists of a devicetree binding describing the RZN1 GMAC
controller IP, a node for the GMAC1 device in the r9a06g032 SoC device
tree, and the GMAC driver itself which is a glue layer in stmmac.

Best Regards,

Romain Gantois

---
Clément Léger (3):
      dt-bindings: net: renesas,rzn1-gmac: Document RZ/N1 GMAC support
      net: stmmac: add support for RZ/N1 GMAC
      ARM: dts: r9a06g032: describe GMAC1

 .../devicetree/bindings/net/renesas,rzn1-gmac.yaml | 66 ++++++++++++++++
 MAINTAINERS                                        |  6 ++
 arch/arm/boot/dts/renesas/r9a06g032.dtsi           | 19 +++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig        | 12 +++
 drivers/net/ethernet/stmicro/stmmac/Makefile       |  1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-rzn1.c   | 87 ++++++++++++++++++++++
 6 files changed, 191 insertions(+)
---
base-commit: 5fc68320c1fb3c7d456ddcae0b4757326a043e6f
change-id: 20240402-rzn1-gmac1-685cf8793d0e

Best regards,
-- 
Romain Gantois <romain.gantois@bootlin.com>


