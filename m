Return-Path: <linux-kernel+bounces-65538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD64854E6E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32A8D28739F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B87360DE5;
	Wed, 14 Feb 2024 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DwTKqPcC"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DD060261;
	Wed, 14 Feb 2024 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928079; cv=none; b=Y4J1gPHhjGuEbxD0y9py6uBXIawFRfYC8pavDiNX4GZ8FswDdfY2B5OhVdBnTXD20Rq3hFC+bsUoiv4sEcFXB5FE8cDDVsqTGjYgapDVvhzCSaSVgc/TP8wFo/O7Olv1807Oq63tbeqekO6/eRXRoIDwFbB2Db4W72fPCb4PSss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928079; c=relaxed/simple;
	bh=MssyRsKrJRRAkkJJGN6qgNf78K+Hb3T00EQE6Vl581o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sgKjhF4lFlDNvHBwhU7Tnu5LRKv2y3VrSff+I4DujRKdX1Tw3p1Oh8mxmA/qVY4Gl0syeCptUH+Pe05BUQOzefLBlnComctkdyz+ECRw3HA7pMZSN0bFyiMTzTtO2TnChePynuuX4WDCNxr4WxIjmwbqRQOnBixgAjimmp4lPZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DwTKqPcC; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay3-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::223])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id F3FC7C12D0;
	Wed, 14 Feb 2024 16:24:51 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4EC5A60005;
	Wed, 14 Feb 2024 16:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707927884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1yZvka761LxwcjsXeq77kW67boXyJRbXbzQuSUTAikw=;
	b=DwTKqPcCrCFZsN6NsHcT/7rxGWfeCjdNnnI9PR0jdxKUMT0TO+WIQvhxXsoIHmOUKXnEWI
	S+q1zlSwPidwJEQQhAIeatmHflRqgb0lEEkG/7BxEHsAaa2e/jL4nwFTUzOKg4epii17Yz
	odGBoS+04/n3WaiKDAJ671W8wB+89ORCC2hHLq3PmLVufRbCLO48u+MUKcFTiVS2Xdpbtd
	w7I5ry3xelUlIYCO6igxHmrLrgdSdDnmsZa54lg+4yJxN7jMxteASlaah/vjpXOiI/Cc3Q
	KqYnY9tCRnv9H8K7NFwLgtL4Vqg6CDwkPi4BJa+zECtDIuDvMgM0dEzpmrFSfA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH 00/23] Rework Nomadik GPIO to add Mobileye EyeQ5 support
Date: Wed, 14 Feb 2024 17:23:53 +0100
Message-Id: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABnpzGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDINbNTcqp1E0vyMzXTTQ2MDU3TE02NrIwVgKqLyhKTcusAJsVHVtbCwB
 ftdvwWwAAAA==
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mips@vger.kernel.org, Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com

Hi,

This patch series reworks the Nomadik GPIO driver to bring it up to date
to current kernel standards. We then add Mobileye EyeQ5 support that
uses the same IP block but with limited functionality. We also add
features required by our newly supported platform:

 - Dynamic GPIO ID allocation;
 - Make clock optional;
 - Shared IRQ (usecase: EyeQ5 has two banks using the same IRQ);
 - Handle variadic GPIO counts (usecase: EyeQ5 has <32 GPIOs per bank);
 - Grab optional reset at probe (usecase: EyeQ5 has a reset available).

This GPIO platform driver was previously declared & registered inside
drivers/pinctrl/nomadik/pinctrl-nomadik.c, side-by-side with the
pinctrl driver. Both are tightly integrated, mostly for muxing reasons.
Now that gpio-nomadik is used for another platform, we loosen the
relationship. The behavior should not change on already supported
hardware but I do not have Nomadik hardware to test for that.

We have some dependencies, kept neatly to the end. Those are:
- The base platform support series from Grégory [1]. This relates to the
  last four patches (20 thru 23), ie defconfig and devicetree.
- The OLB syscon support series [0]. It provides reset and pinctrl nodes
  inside the devicetree. This relates to the last two patches (22 and
  23), ie resets and gpio-ranges DT props. GPIO works fine without it
  if patches 22 and 23 are dropped.

This has been tested on the EyeQ5 hardware, with the two parent series
applied. It also works fine without the OLB syscon series when our last
two patches are removed. It has been built on both Arm defconfigs that
rely on pinctrl-nomadik: nhk8815_defconfig and u8500_defconfig. I don't
have any Nomadik hardware to test though.

Have a nice day,
Théo

[0]: https://lore.kernel.org/lkml/20240212-mbly-clk-v6-0-c46fa1f93839@bootlin.com/
[1]: https://lore.kernel.org/lkml/20240205153503.574468-1-gregory.clement@bootlin.com/

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Théo Lebrun (23):
      dt-bindings: gpio: nomadik: convert into yaml format
      dt-bindings: gpio: nomadik: add optional ngpios property
      dt-bindings: gpio: nomadik: add mobileye,eyeq5-gpio compatible
      dt-bindings: gpio: nomadik: add optional reset property
      gpio: nomadik: extract GPIO platform driver from drivers/pinctrl/nomadik/
      pinctrl: nomadik: fix build warning (-Wformat)
      pinctrl: nomadik: fix build warning (-Wpointer-to-int-cast)
      pinctrl: nomadik: minimise indentation in probe
      pinctrl: nomadik: follow type-system kernel coding conventions
      pinctrl: nomadik: follow whitespace kernel coding conventions
      pinctrl: nomadik: follow conditional kernel coding conventions
      gpio: nomadik: request dynamic ID allocation
      gpio: nomadik: fix offset bug in nmk_pmx_set()
      gpio: nomadik: make clock optional
      gpio: nomadik: change driver name from gpio to gpio-nomadik
      gpio: nomadik: support shared GPIO IRQs
      gpio: nomadik: handle variadic GPIO count
      gpio: nomadik: support mobileye,eyeq5-gpio
      gpio: nomadik: grab optional reset control and deassert it at probe
      MIPS: eyeq5_defconfig: enable GPIO by default
      MIPS: mobileye: eyeq5: add two GPIO bank nodes
      MIPS: mobileye: eyeq5: add resets to GPIO banks
      MIPS: mobileye: eyeq5: map GPIOs to pins using gpio-ranges

 .../devicetree/bindings/gpio/gpio-nmk.txt          |  31 -
 .../devicetree/bindings/gpio/st,nomadik-gpio.yaml  |  96 +++
 MAINTAINERS                                        |   2 +
 arch/mips/boot/dts/mobileye/eyeq5.dtsi             |  30 +
 arch/mips/configs/eyeq5_defconfig                  |   2 +
 drivers/gpio/Kconfig                               |  13 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-nomadik.c                        | 725 ++++++++++++++++
 drivers/pinctrl/nomadik/Kconfig                    |   5 +-
 drivers/pinctrl/nomadik/pinctrl-nomadik-db8500.c   |   3 +-
 drivers/pinctrl/nomadik/pinctrl-nomadik-stn8815.c  |   3 +-
 drivers/pinctrl/nomadik/pinctrl-nomadik.c          | 938 +++------------------
 .../linux/gpio/gpio-nomadik.h                      | 124 ++-
 13 files changed, 1118 insertions(+), 855 deletions(-)
---
base-commit: d55aa725e32849f709b61eab3b7a50b810a71a84
change-id: 20231023-mbly-gpio-a30571ec3283

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


