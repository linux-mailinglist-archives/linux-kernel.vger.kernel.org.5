Return-Path: <linux-kernel+bounces-4139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D69181785A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 241171C22AD9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6865A859;
	Mon, 18 Dec 2023 17:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KbGWiY8a"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C2F5A860;
	Mon, 18 Dec 2023 17:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 203A2E0008;
	Mon, 18 Dec 2023 17:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702919781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qb1u2O9czF/pV9JY/Vd4086ByihGPpQecreGfsOHX9Q=;
	b=KbGWiY8agXq4fkpHWfUWupxZOgh5F8mocUZl5JekDa2S69PyCkPXlNBcIX053YyB31eNzS
	TMGdv9Nin8m5XaxPjs8SP7i7OkmRdEJTc25tvK6X62I2JAF2hF+AZpCCHEx47W+MzfvNgZ
	fR3ddH9JhRjiXI9xgaGFsfgSh3+dMaCVo9xeRe6p7+57fkWUamgR77+bZN7LQNxpRyDpIi
	SThMDWahvy7gzoXB6WibNY2t5skvpDjuj3uTRVULuonnOHC/X8oSmGx/i3vUFBoOhhjOeo
	jZN1tFlO3Mrq8NOgvDW/xGCy1z8G6aZdFJVaieanYFlwl6tYqkyZktTFCxFkNg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH 0/4] Add support for Mobileye EyeQ5 reset controller
Date: Mon, 18 Dec 2023 18:16:11 +0100
Message-Id: <20231218-mbly-reset-v1-0-b4688b916213@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFt+gGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDINbNTcqp1C1KLU4t0U0ytTBPSUw2s0gxSFICaigoSk3LrAAbFh1bWws
 AL/k4QFwAAAA=
To: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com

Hi,

We follow-up the platform support series for Mobileye EyeQ5 [1] with
this reset controller patch series.

The registers are located in a shared register region called OLB
("Other Logic Block"). A single driver instance handles the three
existing reset domains, each with their custom logic:
 - We busy-wait on the first two for hardware LBIST reasons (logic
   built-in self-test).
 - Domains 0 & 2 work in a bit-per-reset fashion while domain 1 works in
   a register-per-reset fashion.

We end the series by adding the node to the platform devicetree and
reset handles to the three UARTs.

[1]: https://lore.kernel.org/lkml/20231212163459.1923041-1-gregory.clement@bootlin.com/

Have a nice day,
Théo Lebrun

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Théo Lebrun (4):
      dt-bindings: reset: mobileye,eyeq5-reset: add bindings
      reset: eyeq5: add driver
      MIPS: mobileye: eyeq5: add OLB reset controller node
      MIPS: mobileye: eyeq5: add reset properties to uarts

 .../bindings/reset/mobileye,eyeq5-reset.yaml       |  69 +++++
 MAINTAINERS                                        |   3 +
 arch/mips/boot/dts/mobileye/eyeq5.dtsi             |   9 +
 drivers/reset/Kconfig                              |  13 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-eyeq5.c                        | 323 +++++++++++++++++++++
 include/dt-bindings/reset/mobileye,eyeq5-reset.h   |  80 +++++
 7 files changed, 498 insertions(+)
---
base-commit: 0bb6b85cadabf93a754df740bd1b6c56ef41ac2c
change-id: 20231023-mbly-reset-b587dac68d0b

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


