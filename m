Return-Path: <linux-kernel+bounces-12118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A7181F045
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5BC3282680
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CEA4643F;
	Wed, 27 Dec 2023 16:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="P+g8MeCj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EAD46420;
	Wed, 27 Dec 2023 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F184DFF812;
	Wed, 27 Dec 2023 16:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703694244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ez0pbpdiJcFmloOhz2QpvcxjF2T6EB87V9C6wGzmJm8=;
	b=P+g8MeCjZsDHxr7svBYTlxSZqen7NafmP862OWo5RRPSzTBYzEBLZS9oQ9JObibdf8UkC0
	we1v1j7ntez0pf+D7eSL5v69jeRIIdMtAkuKDy7KyDjDm8PC67mqiVHPsQf5M6vj+iwz6a
	TWqLlFHlNaTIJh1p8hhmMStB0TB/f3FWfM/B5IBUOGDMN9gNcBy4GHsnQPOUjHTtq+q7Fo
	0BxlST2Vc4Oetq/LHBh5aqVeOJVQ+pTLSjSAhTjzykk+UggoL69G4JfjfJMufDKgPVjtLH
	onp4wW6eP3gCyUMEnv9dIIAMaknqVhrT+Ue5XQ0UAtlZXqKENTlx93S71zipWA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH v2 0/6] Add support for Mobileye EyeQ5 clock controller
Date: Wed, 27 Dec 2023 17:23:50 +0100
Message-Id: <20231227-mbly-clk-v2-0-a05db63c380f@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJZPjGUC/3WOSw6CMBBAr0K6tqbT8imuvIdhQctUGoGalhAJ4
 e4WXBiNLmbxJvNeZiEBvcVATslCPE42WDdE4IeE6LYerkhtE5lwxgXEob3qZqq7G5WFxkzzFAy
 TJJ7fPRr72FOXKnJrw+j8vJcn2LavCAj2jkxAGZW5MgBl0YDAs3Ju7Oxw1K7fqn8UJZBlTa5Kh
 fVPhYP8UtI0/psCk4blH0q1rusTffPRAAgBAAA=
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

We expose ten PLLs that derive directly from the main crystal. Also, a
divider clock is exposed as a child clock of one of the PLLs.

The platform devicetree has many more clock nodes but those are
fixed-factors that are not hardware controllable; we therefore do not
deal with them.

This is V2. Full changelog below. Major changes are:

 - Switch to a platform driver.
 - Switch to declaring PLLs as fixed-factor.
 - Point to the parent clk using the fw_name field in clk_parent_data.
 - The above two points means we add support in fixed-factor to (1) allow
   fixed accuracy rather than parent accuracy and (2) add new register
   prototypes to point to the parent clk using fw_name.

[1]: https://lore.kernel.org/lkml/20231212163459.1923041-1-gregory.clement@bootlin.com/

Have a nice day,
Théo Lebrun

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Changes in v2:
- Drop [PATCH 1/5] that was taken by Stephen for clk-next.
- Add accuracy support to fixed-factor that is enabled with a flag.
  Register prototypes were added to exploit this feature.
- Add fw_name support to fixed-factor. This allows pointing to parent
  clocks using the value in `clock-names` in the DT. Register
  prototypes were added for that.
- Bindings were modified to be less dumb: a binding was added for OLB
  and the clock-controller is a child property of it. Removed the
  possibility of pointing to OLB using a phandle. $nodename is the
  generic `clock-controller` and not custom `clocks`. Fix dt-bindings
  examples.
- Fix commit message for the driver patch. Add details, remove useless
  fluff.
- Squash both driver commits together.
- Declare a platform_driver instead of using CLK_OF_DECLARE_DRIVER. This
  also means using `dev_*` for logging, removing `pr_fmt`. We add a
  pointer to device in the private structure.
- Use fixed-factor instead of fixed-rate for PLLs. We don't grab a
  reference to the parent clk, instead using newly added fixed-factor
  register prototypes and fwname.
- NULL is not an error when registering PLLs anymore.
- Now checking the return value of of_clk_add_hw_provider for errors.
- Fix includes.
- Remove defensive conditional at start of eq5c_pll_parse_registers.
- Rename clk_hw_to_ospi_priv to clk_to_priv to avoid confusion: it is
  not part of the clk_hw_* family of symbols.
- Fix negative returns in eq5c_ospi_div_set_rate. It was a typo
  highlighted by Stephen Boyd.
- Declare eq5c_ospi_div_ops as static.
- In devicetree, move the OLB node prior to the UARTs, as platform
  device probe scheduling is dependent on devicetree ordering. This is
  required to declare the driver as a platform driver, else it
  CLK_OF_DECLARE_DRIVER is required.
- In device, create a core0-timer-clk fixed clock to feed to the GIC
  timer. It requires a clock earlier than platform bus type init.
- Link to v1: https://lore.kernel.org/r/20231218-mbly-clk-v1-0-44ce54108f06@bootlin.com

---
Théo Lebrun (6):
      clk: fixed-factor: add optional accuracy support
      clk: fixed-factor: add fwname-based constructor functions
      dt-bindings: soc: mobileye: add EyeQ5 OLB system controller
      dt-bindings: clock: mobileye,eyeq5-clk: add bindings
      clk: eyeq5: add platform driver
      MIPS: mobileye: eyeq5: use OLB clocks controller

 .../bindings/clock/mobileye,eyeq5-clk.yaml         |  50 +++
 .../bindings/soc/mobileye/mobileye,eyeq5-olb.yaml  |  48 +++
 MAINTAINERS                                        |   4 +
 .../{eyeq5-fixed-clocks.dtsi => eyeq5-clocks.dtsi} |  54 ++--
 arch/mips/boot/dts/mobileye/eyeq5.dtsi             |  23 +-
 drivers/clk/Kconfig                                |  11 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-eyeq5.c                            | 348 +++++++++++++++++++++
 drivers/clk/clk-fixed-factor.c                     |  94 +++++-
 include/dt-bindings/clock/mobileye,eyeq5-clk.h     |  22 ++
 include/linux/clk-provider.h                       |  26 +-
 11 files changed, 621 insertions(+), 60 deletions(-)
---
base-commit: daf471f1ce94536da77948fac81d5c85ae12dbfa
change-id: 20231023-mbly-clk-87ce5c241f08

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


