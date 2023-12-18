Return-Path: <linux-kernel+bounces-4133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A95B817845
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE4952835D1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FDC5BFAE;
	Mon, 18 Dec 2023 17:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PiouGzl+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A6B4FF6D;
	Mon, 18 Dec 2023 17:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8B6F21BF20A;
	Mon, 18 Dec 2023 17:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702919664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Lyt0fUA8qXAG186dpljc51Fb9nMcLd2wX7HB0Boh4IU=;
	b=PiouGzl+MlgeZJG+Yp04/ynO3QZiEcefHG1cCb7Sy+fmU3VIBZgzYLBlJTf+rcA2PF0M1E
	XmAgnL9Oq7v4a1GdTzLycAyg+sycBOHCAkhgzVWsAOyRi0T5FGlc/W//k8wqYKgoyF0RUt
	SEz1ev8RaHhBnfzVkm7tD49rxO6oQUiyHq6ecOjbBgeDjwG9Pm/lm4PC8LH+zi6hRuohyH
	PBlO1o/to+3ABoboosI+ed2UYAw4pSoIkLogbVMR+so4n8oZ55jkp9yoEWOYhngWSemPId
	5q/PQmomsstB+AW8ZtxQUNjACkL69IiS31G2WmgF/QE0WkGJiwQDNCuJfIx87A==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH 0/5] Add support for Mobileye EyeQ5 clock controller
Date: Mon, 18 Dec 2023 18:14:15 +0100
Message-Id: <20231218-mbly-clk-v1-0-44ce54108f06@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOh9gGUC/3WMQQ6CMBREr0K6tqafChRW3sOwoO1HfgRqWkIkh
 LtbcGFcuJjFm8y8lQX0hIFVyco8zhTIjRHglDDTNeMdOdnILBWphBg+6H7hpn9wVRjMTHqBVig
 W50+PLb0O1a2O3FGYnF8O8wx7+5GAFF/JDFxwlesWoCwsSLxq56aexrNxw279c9ESRWZzXWpsf
 i71tm1vTkSGx9UAAAA=
To: Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 linux-mips@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com

Hi,

We replace fixed clocks as declared in the initial platform support
series [1] by read-only clocks exposed by the clock driver implemented
here. Write-ability is supported by the hardware but not implemented,
it could be added later-on if the need appears.

We expose ten PLLs that derive directly from the main crystal. Also, a divider
clock is exposed as a child clock of one of the PLLs.

The platform devicetree has many more clock nodes but those are
fixed-factors that are not hardware controllable; we therefore do not
deal with them.

This series starts with a fix for a fixed-rate clock registering macro that is
broken. We are the first upstream users which explains why we found the typo.

We end our patch series by adding the clock controller node to the
platform devicetree & by replacing hardcoded devicetree clocks by the
ones exposed by this driver. The controller driver addition is split in
two commits to simplify reviewing.

[1]: https://lore.kernel.org/lkml/20231212163459.1923041-1-gregory.clement@bootlin.com/

Have a nice day,
Théo Lebrun

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Théo Lebrun (5):
      clk: fixed-rate: fix clk_hw_register_fixed_rate_with_accuracy_parent_hw
      dt-bindings: clock: mobileye,eyeq5-clk: add bindings
      clk: eyeq5: add controller
      clk: eyeq5: add OSPI table-based divider clock
      MIPS: mobileye: eyeq5: add OLB clocks controller node & pinmux nodes

 .../bindings/clock/mobileye,eyeq5-clk.yaml         |  83 +++++
 MAINTAINERS                                        |   3 +
 .../{eyeq5-fixed-clocks.dtsi => eyeq5-clocks.dtsi} |  56 +---
 arch/mips/boot/dts/mobileye/eyeq5.dtsi             |   9 +-
 drivers/clk/Kconfig                                |  11 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-eyeq5.c                            | 346 +++++++++++++++++++++
 include/dt-bindings/clock/mobileye,eyeq5-clk.h     |  22 ++
 include/linux/clk-provider.h                       |   4 +-
 9 files changed, 493 insertions(+), 42 deletions(-)
---
base-commit: 0bb6b85cadabf93a754df740bd1b6c56ef41ac2c
change-id: 20231023-mbly-clk-87ce5c241f08

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


