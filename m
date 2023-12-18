Return-Path: <linux-kernel+bounces-4148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF56817876
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF8771F24B41
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D115D734;
	Mon, 18 Dec 2023 17:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CmTZp2PG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747EE5A85A;
	Mon, 18 Dec 2023 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 30F2B20004;
	Mon, 18 Dec 2023 17:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702920007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ti36AdyiFQvN3/eY4vcX7OOVTVxOSw0U3/0TkVosSso=;
	b=CmTZp2PGXgK4u4XpIXG7p/+mZ69OemtMncx3up09ozpyP4QhtvKSzx5kQgZO8Pl61ZcpDb
	uj9rLR5Iz4LEhjsuxnkK8qpwtyVT+gzLUziclCy25VqYnrhfWB3yHRQOjIdZlV5KcnGbXb
	ZlDyTYi4nMZ9D8jdHZkJC0rPXc6AZdHSyfAkGsPgOwPt0CeYKhJUBgGzLQkKamNjtrr1cz
	nOffJZr7CuED37AFBFrAGgtx5U7vQoBJbr8SPPcJi+c5NBjQ9i6CvLVwQazjlqYrDBbIj5
	JzDj8Sga+F+ZzHFxJowhcq0jFTPkJC22+JXNvlYXtfZYnphhnBb5TKFjCHfZlg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH 0/4] Add support for Mobileye EyeQ5 pin controller
Date: Mon, 18 Dec 2023 18:19:45 +0100
Message-Id: <20231218-mbly-pinctrl-v1-0-2f7d366c2051@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADF/gGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDINbNTcqp1C3IzEsuKcrRNU9MS7VMNje2sDQ2UwJqKShKTcusABsXHVt
 bCwBMJ+pmXgAAAA==
To: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com

Hi,

This series adds pinctrl support to the Mobileye EyeQ5 platform,
following up on the platform support series by Grégory Clement [1].

All registers involved live in a shared register region called OLB
("Other Logic Block"). We have control over bias, drive strength and
muxing. The latter allows two functions per pin; the first function is
always GPIO while the second one is pin-dependent. Functions are
statically declared in the driver, associated to compatibles. Two
compatibles exist, one for each bank.

The pin controller's functionality is not limited so each pin maps to
one group. That makes pin & group indexes the same, simplifying logic.
Having two instances, one per bank, also is done to simplify the
driver's logic.

The series ends by adding the two banks as devicetree nodes and
declaring a pin-mux node for each function. We also add pinctrl
references to the existing UART nodes. We are based on the reset
series [2] for the sole reason of avoiding merge conflicts in the
devicetree.

[1]: https://lore.kernel.org/lkml/20231212163459.1923041-1-gregory.clement@bootlin.com/
[2]: https://lore.kernel.org/lkml/20231218-mbly-reset-v1-0-b4688b916213@bootlin.com/

Have a nice day,
Théo Lebrun

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Théo Lebrun (4):
      dt-bindings: pinctrl: mobileye,eyeq5-pinctrl: add bindings
      pinctrl: eyeq5: add driver
      MIPS: mobileye: eyeq5: add pinctrl nodes & pinmux function nodes
      MIPS: mobileye: eyeq5: add pinctrl properties to uarts

 .../bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml   | 125 +++++
 MAINTAINERS                                        |   2 +
 arch/mips/boot/dts/mobileye/eyeq5-pins.dtsi        | 128 +++++
 arch/mips/boot/dts/mobileye/eyeq5.dtsi             |  17 +
 drivers/pinctrl/Kconfig                            |  15 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-eyeq5.c                    | 593 +++++++++++++++++++++
 7 files changed, 881 insertions(+)
---
base-commit: cfa954ebcdc3504dbf38ff5ba1589ed0cdfc8313
change-id: 20231023-mbly-pinctrl-7afe9c738936

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


