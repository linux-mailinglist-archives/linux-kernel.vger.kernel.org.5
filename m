Return-Path: <linux-kernel+bounces-133203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C95989A076
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E78FA284DE3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7946216F85E;
	Fri,  5 Apr 2024 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JxRT5eL3"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576FA16F29F;
	Fri,  5 Apr 2024 15:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712329339; cv=none; b=qdvIi7+/hp79ME86rJnR2xkDJhkJxgg8U39fGo0wWpAY3b1EY2rph6eXQBBhmIxWCvz4YBjA+8kdJxKSiVn9Lart9Y4yWwUFmBxEi49xFYvKHw8WwAcmIPgyiioLiyQeluszeJtebqPoWMX7mzyWvKF7FuIEcWYaxt8G71FbTlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712329339; c=relaxed/simple;
	bh=Qd6G5maD/2bB1FBCGYcJGy50moLaCDUjrKAdzbS6uh4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EulqVlXik8Oa3nXXhqA5hcpWnF0cZ4gVlVy4pYzs/Qw5O73sv8X0sWkoh0Ire2Srhz0912zZ6UUkecJrZBHo8zh6A8xusrzw8P2x5j+RY6BLWkWHFq3/2Zt8iBcE5+qdKxlP7m2Iv/8vc3TJ0EG01AY5HHWzDCuoBZ98eh6g5OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JxRT5eL3; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8FB601BF20F;
	Fri,  5 Apr 2024 15:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712329335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jePpTY9wJhZN+709Nb4n6FZ8IJ1Mh7MLk4EHKC+eTMg=;
	b=JxRT5eL3R3EXBHm0arUs8v088hDO1F4xaZiNcL62n2ehvtBnR0V0tB9pc1S1FoC2CIEYV6
	M73Slz1iGfdqETMbMYi1hgjb6EB2YsXyqZjckQBrb85TpNqxr0utviSLgFEMskUoYuUGEl
	+Yw23A3rvlWlejGs0ahEcjSd4JxtEHRHhbCUYnBqzXrZETwpkRc4bOm3PKIcjL+cOr9CoY
	Bh9MuesdboX5aFzgkZwSbU4h87qMfJog7ZzVzYvqsLEAcyBYIwCVNLefLyq7rdzO5iv5ww
	4QlMBCspCiuNwOUdqdLkJC3W65E7Y3Ey8YNPXHEwMkAUGNUmrpkNghvQ+vmXzg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH v2 00/11] spi: cadence-qspi: add Mobileye EyeQ5 support
Date: Fri, 05 Apr 2024 17:02:10 +0200
Message-Id: <20240405-cdns-qspi-mbly-v2-0-956679866d6d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHISEGYC/13MQQ6CMBCF4auQWTtmKK1BV97DsChtlUmghZYQC
 eHuVty5/F/yvg2Si+wS3IoNols4cfA5xKkA02n/csg2NwgSkgRd0VifcEoj49D2K1onBCktpW4
 ryKcxuie/D/DR5O44zSGuh7+U3/VHVVT/U0uJhFpRVauLtVm9tyHMPfuzCQM0+75/AOuSe1+uA
 AAA
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Rob Herring <robh@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Hi all,

V2 of this series adding octal SPI-NOR support to Mobileye EyeQ5
platform. It has been tested on EyeQ5 hardware successfully.
V1 cover letter [5] contains a brief summary of what gets added.

There is no dependency except if you want zero errors in devicetree:
system-controller series [3] for <&clocks> phandle.

Have a nice day,
Théo

[0]: https://lore.kernel.org/lkml/20240216174227.409400-1-gregory.clement@bootlin.com/
[1]: https://lore.kernel.org/linux-mips/20240209-regname-v1-0-2125efa016ef@flygoat.com/
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/log/
[3]: https://lore.kernel.org/lkml/20240301-mbly-clk-v9-0-cbf06eb88708@bootlin.com/
[4]: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/log/
[5]: https://lore.kernel.org/lkml/20240308-cdns-qspi-mbly-v1-0-a503856dd205@bootlin.com/

To: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Vaishnav Achath <vaishnav.a@ti.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Rob Herring <robh@kernel.org>
Cc: linux-spi@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

Changes in v2:
- Rebase upon v6.9-rc2.
- Fix dt-bindings commit subject tags.
- Take Reviewed-by: Krzysztof Kozlowski on dt-bindings commit.
- Add dt-bindings commit to order compatibles alphabetically.
  adding EyeQ5 compatible can be taken alone easily.
- Drop patch taken upstream:
- Add To: Rob Herring, following get_maintainer.pl recommendation.
- Link to v1: https://lore.kernel.org/r/20240308-cdns-qspi-mbly-v1-0-a503856dd205@bootlin.com

Krzysztof: unsure if you want this. It is second so that commit
spi: cadence-qspi: switch from legacy names to modern ones
---
Théo Lebrun (11):
      spi: dt-bindings: cdns,qspi-nor: add mobileye,eyeq5-ospi compatible
      spi: dt-bindings: cdns,qspi-nor: sort compatibles alphabetically
      spi: cadence-qspi: allow building for MIPS
      spi: cadence-qspi: store device data pointer in private struct
      spi: cadence-qspi: add FIFO depth detection quirk
      spi: cadence-qspi: minimise register accesses on each op if !DTR
      spi: cadence-qspi: add no-IRQ mode to indirect reads
      spi: cadence-qspi: add early busywait to cqspi_wait_for_bit()
      spi: cadence-qspi: add mobileye,eyeq5-ospi compatible
      MIPS: mobileye: eyeq5: Add SPI-NOR controller node
      MIPS: mobileye: eyeq5: add octal flash node to eval board DTS

 .../devicetree/bindings/spi/cdns,qspi-nor.yaml     |  19 +++-
 arch/mips/boot/dts/mobileye/eyeq5-epm5.dts         |  15 +++
 arch/mips/boot/dts/mobileye/eyeq5.dtsi             |  15 +++
 drivers/spi/Kconfig                                |   2 +-
 drivers/spi/spi-cadence-quadspi.c                  | 114 ++++++++++++++++-----
 5 files changed, 132 insertions(+), 33 deletions(-)
---
base-commit: afccf1991d034a11ce0a1c21d90feba510838e34
change-id: 20240209-cdns-qspi-mbly-de2205a44ab3

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


