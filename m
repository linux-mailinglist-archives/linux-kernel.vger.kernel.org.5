Return-Path: <linux-kernel+bounces-139052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF3F89FDE0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AEC71F22BCD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9BB17F371;
	Wed, 10 Apr 2024 17:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AxOGyNET"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A068D17BB05;
	Wed, 10 Apr 2024 17:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769157; cv=none; b=qqZj3XkRY6ird6BJSKcbEAABNVodvHxfXKurZSvOmvMnTupyY/tY+vxo57q4BdKPvAvpgF3PWYcyW1SYxwmbZrJBan/lU9kQMsQmANslS/bmnu1dYlEdFnxM0E/QewZGMXofhWFx3lQDyLx2EHpZXkCcV590+MV5z8sYWU6oNHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769157; c=relaxed/simple;
	bh=UZN6bZ/VOXpFVmBzCZFb4rCBgwKePZT8MRaqGDGNeJc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EZRfgsGpz+2iz1BS4P0uvFo+9VhlZjn4VOVySF61cSGyx9+o7LRo8umVDJ9OhoINVD/WQfGR44IYv+Z+ZZ6A4M9t+SYHXwZTC1/3eapHphnMPpvAAqWDhyY46352+XfQHaG7X4i24hkISenyih6pcNVfqLcVNea71SVg+nnLTNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AxOGyNET; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 316DC1C0007;
	Wed, 10 Apr 2024 17:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712769153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dqccYW4TTVMR245oWOMT2QE+v65GZJhVyqPmQez5YqY=;
	b=AxOGyNET4LG1HW8fSstIXz09u4haS/irmvIXJwE+egN4x7TBc7ozRAEpcDcq+Ho1M4zbdQ
	9ApaXNMtozqImA5//vRRIIfJ9bBnadcfrS6ylMxAFTP7BK92xLEFslIW/VakwDZZBerra7
	9vQ2DEp6kLggGdis0ULzAQJGitGq3Wl8xYIaJPq3syuIcBl9TYFW2lQHfaHfu7VkbTMB+T
	F15GVbK2S2jcX7ZcjC8sAozClZZYmP6E2BFSijilbI2YyLLHPrJZz3xkLAqdDvbiH4KFEG
	X7fal4duV454FlGG14edLIRRkblyevjDN0ERjeB6sQyw9DUW+y7E4qR477aPNg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH 00/11] Add Mobileye EyeQ system controller support (clk,
 reset, pinctrl)
Date: Wed, 10 Apr 2024 19:12:29 +0200
Message-Id: <20240410-mbly-olb-v1-0-335e496d7be3@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAH3IFmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDEwML3dyknErd/JwkXXPTRAvTNNPktJRUYyWg8oKi1LTMCrBR0bG1tQD
 bvinJWgAAAA==
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-gpio@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

This builds on previous EyeQ5 system-controller revisions [0] and adds
EyeQ6L + EyeQ6H support. Pinctrl is not affected because it is not
handled in the same manner on those new platforms; it will be dealt
with with pinctrl-single. Only clk and reset expand to support those
new platform.

Changes in drivers are pretty massive, which explains why I started a
new revision count.

EyeQ6H is particular in that it has not one but seven OLB instances.
All seven host a (different) clock controller. Three host a reset
controller.

Patches are targeting MIPS, clk, reset and pinctrl trees independently.

 - dt-bindings: soc: mobileye: add EyeQ5 OLB system controller
 - MIPS: mobileye: eyeq5: add OLB syscon node
 - MIPS: mobileye: eyeq5: use OLB clocks controller node
 - MIPS: mobileye: eyeq5: add OLB reset controller node
 - MIPS: mobileye: eyeq5: add pinctrl node & pinmux function nodes

   Patches have no dependencies on this series. All required devicetrees
   and bindings got in the last release. Bindings changes below are
   only related to EyeQ6L/EyeQ6H.

 - dt-bindings: clock: mobileye,eyeq5-clk: add EyeQ6L and EyeQ6H
 - clk: divider: Introduce CLK_DIVIDER_EVEN_INTEGERS flag
 - clk: eyeq: add driver

   Clocks on all three platforms are rather similar. We have a bunch of
   PLLs children to the main crystal, some being required early
   (at of_clk_init(), before platform bus init).

   We have a few divider clocks in some instances. A custom clk-divider
   flag is introduced for the divisor because one clk would have a 256
   entries table otherwise.

   Compatible match data stores it all, nothing is declared in DT. Match
   data has three arrays for the three types of clocks: early PLLs,
   standard PLLs and divider clks.

 - dt-bindings: reset: mobileye,eyeq5-reset: add EyeQ6L and EyeQ6H
 - reset: eyeq: add platform driver

   Resets on all three platforms are rather similar. We therefore
   declare reset domain types and assign compatibles to an array of
   domains, with types and valid masks associated. The rest is pretty
   similar to previous code.

   EyeQ6H west and east OLB each host an instance of the same compat.

 - pinctrl: eyeq5: add platform driver

   Not affected by EyeQ6L/EyeQ6H additions. It has not changed.

Have a nice day,
Théo

[0]: https://lore.kernel.org/lkml/20240301-mbly-clk-v9-0-cbf06eb88708@bootlin.com/

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Théo Lebrun (11):
      dt-bindings: soc: mobileye: add EyeQ5 OLB system controller
      dt-bindings: clock: mobileye,eyeq5-clk: add EyeQ6L and EyeQ6H
      dt-bindings: reset: mobileye,eyeq5-reset: add EyeQ6L and EyeQ6H
      clk: divider: Introduce CLK_DIVIDER_EVEN_INTEGERS flag
      clk: eyeq: add driver
      reset: eyeq: add platform driver
      pinctrl: eyeq5: add platform driver
      MIPS: mobileye: eyeq5: add OLB syscon node
      MIPS: mobileye: eyeq5: use OLB clocks controller node
      MIPS: mobileye: eyeq5: add OLB reset controller node
      MIPS: mobileye: eyeq5: add pinctrl node & pinmux function nodes

 .../bindings/clock/mobileye,eyeq5-clk.yaml         | 103 +++-
 .../bindings/reset/mobileye,eyeq5-reset.yaml       |  88 ++-
 .../bindings/soc/mobileye/mobileye,eyeq5-olb.yaml  | 125 ++++
 MAINTAINERS                                        |   8 +
 .../{eyeq5-fixed-clocks.dtsi => eyeq5-clocks.dtsi} |  54 +-
 arch/mips/boot/dts/mobileye/eyeq5-pins.dtsi        | 125 ++++
 arch/mips/boot/dts/mobileye/eyeq5.dtsi             |  42 +-
 drivers/clk/Kconfig                                |  11 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-divider.c                          |  12 +-
 drivers/clk/clk-eyeq.c                             | 644 +++++++++++++++++++++
 drivers/pinctrl/Kconfig                            |  14 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-eyeq5.c                    | 579 ++++++++++++++++++
 drivers/reset/Kconfig                              |  13 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-eyeq.c                         | 543 +++++++++++++++++
 include/dt-bindings/clock/mobileye,eyeq5-clk.h     |  21 +
 include/linux/clk-provider.h                       |  11 +-
 19 files changed, 2322 insertions(+), 74 deletions(-)
---
base-commit: c8e31f416e99bd460f6f8847709bf69c72a3e146
change-id: 20240408-mbly-olb-75a85f5cfde3

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


