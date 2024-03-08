Return-Path: <linux-kernel+bounces-97366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD713876985
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C1281C20FEE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9488E3C08E;
	Fri,  8 Mar 2024 17:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oFUgdZhv"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F5E288DF;
	Fri,  8 Mar 2024 17:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709918307; cv=none; b=Og8MIBmiit880lY0w1BtFmFZ8QvWHvGvkZvuoQLJHZ5Cg9ri9lWGVZMih0NJMPeWfkoucb4OKnAoMRAbM0q4SJ2PP5a7FvHq6pmpnpZZb8ZkE0m387yT7BKXzGDqAIfnnXlr1JwjP0x1Gk5njlgD8YJZMzGnLIHDTsJIrS9GieM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709918307; c=relaxed/simple;
	bh=E9zIsvVNRn8j4lhi50pwwgBFUNkIhRKOyHxnyO71DhM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UsQiKs2rLSKccVnaFxEcfegVL625IvBnb9iwYvcLnDcki4m4vwnEm7s9DROm88AbssiuVIbIw/TnoUzQsWXUFlZl3ZXgf/WKMpTc07XFknOR06uI5NI5N0t5x/xUL5vIutJ+xFJWO/sXoSQTtED8jEU0xDpHsVPXom69ogXzLAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oFUgdZhv; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1A7D4C0004;
	Fri,  8 Mar 2024 17:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709918297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=etEfqzz8TOqTFJ75eijfjqT82zhkln77NmZ5u7BdmUU=;
	b=oFUgdZhvNKKb4KFTUgyP1N9FJqGTP23MtFum4hwewtoqDF66h04/rW23qwmYftCihi1n/2
	I1Ev7PzlnpCYtr4Y9n67hx1fbKdoXMppEDVrZiHbdG9v+UrpX7pcY0MjbT4O/4rRtfsajO
	CyxhJsNnmxpxTsFQBNU7Pg864EJdKvUiEPgWG7WMMBBn+/KNTFsueWlcpu92e418SAK1MU
	UcLe+Azh/5loljbHvqV4TAvKsU7U/321eMNvrq2syioMQYmDxbD7KfsK+6ZfIYoovcO0En
	FjLvOr54XzZWwliC6cQlroL/qlX/wlN+wsXH74vVJYmf8Iu3QG4/ZkttY+i4Yg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH 00/11] spi: cadence-qspi: add Mobileye EyeQ5 support
Date: Fri, 08 Mar 2024 18:18:15 +0100
Message-Id: <20240308-cdns-qspi-mbly-v1-0-a503856dd205@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFdI62UC/x3MQQ5AMBBA0avIrE1SoxZcRSxKB5NQdBIh4u4ay
 7f4/wHlKKzQZA9EPkVlCwlFnsEwuzAxik8GMmQNmRoHHxQP3QXXfrnRM5GpnLWuLyFFe+RRrn/
 Ydu/7AdZccshgAAAA
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Hi all,

This series adds support for the embedded Cadence Quad SPI controller on
Mobileye EyeQ5. In our case "quad" is inappropriate as we support
octal. Most patches aim to improve performance and avoid interrupts.
Stuff to talk about:

 - Both IRQ handler and read operation callbacks called
   of_device_get_match_data(). This has a cost which we avoid.

 - Add a flag to detect FIFO depth at runtime. The SRAMPARTITION
   register is partially read-only: writel() then readl() to get the
   depth.

   This implies cdns,fifo-depth devicetree property is unused on this
   platform.

 - Add a flag to avoid IRQs for indirect reads. Hardware is way too fast
   for sleeping to make sense.

 - Add a flag to busywait in read operations. We avoid many hrtimer
   interrupts this way. Fallback to sleeping, which shouldn't happen.

 - End this by adding the compatible to the driver, add the controller
   to the SoC devicetree and add an octal flash to the eval board
   devicetree.

Dependencies:
 - Devicetree:
    - Patches [0][1] adding platform DTS, found in mips-next [2].
    - System-controller series [3] for <&clocks> phandle.
 - Driver: patches that fix this driver's runtime PM, see spi-next [4].

Have a nice day,
Théo

[0]: https://lore.kernel.org/lkml/20240216174227.409400-1-gregory.clement@bootlin.com/
[1]: https://lore.kernel.org/linux-mips/20240209-regname-v1-0-2125efa016ef@flygoat.com/
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/log/
[3]: https://lore.kernel.org/lkml/20240301-mbly-clk-v9-0-cbf06eb88708@bootlin.com/
[4]: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/log/

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Théo Lebrun (11):
      dt-bindings: qspi: cdns,qspi-nor: add mobileye,eyeq5-ospi compatible
      spi: cadence-qspi: switch from legacy names to modern ones
      spi: cadence-qspi: allow building for MIPS
      spi: cadence-qspi: store device data pointer in private struct
      spi: cadence-qspi: add FIFO depth detection quirk
      spi: cadence-qspi: minimise register accesses on each op if !DTR
      spi: cadence-qspi: add no-IRQ mode to indirect reads
      spi: cadence-qspi: add early busywait to cqspi_wait_for_bit()
      spi: cadence-qspi: add mobileye,eyeq5-ospi compatible
      MIPS: mobileye: eyeq5: Add SPI-NOR controller node
      MIPS: mobileye: eyeq5: add octal flash node to eval board DTS

 .../devicetree/bindings/spi/cdns,qspi-nor.yaml     |  13 ++-
 arch/mips/boot/dts/mobileye/eyeq5-epm5.dts         |  15 +++
 arch/mips/boot/dts/mobileye/eyeq5.dtsi             |  15 +++
 drivers/spi/Kconfig                                |   2 +-
 drivers/spi/spi-cadence-quadspi.c                  | 116 +++++++++++++++------
 5 files changed, 130 insertions(+), 31 deletions(-)
---
base-commit: ecd5ff483c763ca368f815fafc954f6db9788143
change-id: 20240209-cdns-qspi-mbly-de2205a44ab3

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


