Return-Path: <linux-kernel+bounces-154832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7EA8AE1AA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2594328595B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C975FBA6;
	Tue, 23 Apr 2024 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ELCLA7TZ"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81B75FB9B;
	Tue, 23 Apr 2024 10:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713866518; cv=none; b=OCnKz1QNvbktkjq2jH25SPqe+zzqU0C+DALuVc7RRsv8OFn4qvQPpKfru/XiNScItgsMuRbl1d6m7d8x+bbWKjBy84W226HOdTBbgvZGUVtjyMNK5pEUYaZREjVYEuN9+lf+d+PDrv+Sfv6xhIrT+L0AeA5Pi58sByud0H04BpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713866518; c=relaxed/simple;
	bh=eIHtDlpwxsc3XWZW8iA1wFGI7oLW/lPGfnVuHIpBM0k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dF23cm1uHw5/+gqbkFfPQM0EqghJNrZic74MKQWc/YoJaKkHACgWMfR5oeVz0ww8DdVPIdzQ15oSfQGwBijHGWLg/bJHOSnB9VTAPAzEt8ygUdgXJF+qQQL1WAr+mt3bAjEadi+TbJ2mbnFDXIzJMq6XWPmfpw0Z2QnwLta5a64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ELCLA7TZ; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 18E001C0005;
	Tue, 23 Apr 2024 10:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713866508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fTWKNBt1DmdiMdNDDF390iGqtyF7GrI4IgYrHS6Bp6M=;
	b=ELCLA7TZnjfxTyZWJw2v9nMvXs5rfJNPpFqn7E5aHH7jBBqmFhmDJPJUrbcB5t5pknTUvF
	hNtUfXlr/JVLfMCpoGaI4loOUk++YJShnqaspvqmN/IuO32HibjaM1tgg73Cjn1EwTYSK5
	k4A8Ub+kSdBdB+hlFSLOJIt9yIh2EK1CmBORjiHyOV/VHt319Wh3Ovykmi42WHSkquC7yP
	CFqkX0x3EVJI7wCNET/OYvr47VtgUKjHnj8MKQH6Fxavq+Z32n53UKoRyu56l6ndg/6B0O
	PDii3s6BGVANW3sXVFHmwU/yyQHfPHmAukM1MkhxkWelrGo3TUgAJgO0hg0b/Q==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH v4 0/6] spi: cadence-qspi: add Mobileye EyeQ5 support
Date: Tue, 23 Apr 2024 12:01:39 +0200
Message-Id: <20240423-cdns-qspi-mbly-v4-0-3d2a7b535ad0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAOHJ2YC/2XMyQ6CMBSF4VchXVtz6QS48j2Mi05IE6RISSMhv
 LsFFw4s/5Ocb0bBDs4GdMpmNNjogvNdCnbIkG5kd7PYmdSIAGFAoMLadAE/Qu/wXbUTNpYQ4JI
 xqShKp36wtXtu4OWaunFh9MO0+TFf1zdFofynYo4BSw605MKYpJ6V92PruqP2d7RikXwABnwHk
 ARUXIiiKoUwwuwB+gXksANoAgpVAKeMVboufoFlWV4YSIqTMAEAAA==
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
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Hi all,

V4 of this series adding octal SPI-NOR support to Mobileye EyeQ5
platform. It has been tested on EyeQ5 hardware successfully. Patches
have been taken over time, meaning series got smaller over time.

Patches:
 - Make cdns,fifo-depth optional by computing it from hardware.
 - No-IRQ mode for indirect read operations. Behind a quirk flag.
 - Busywait on commands and indirect reads; reduces hrtimeouts load.
 - Add mobileye,eyeq5-ospi compatible.
 - EyeQ5 devicetree:
    - Add octal SPI-NOR node.
    - Add SPI-NOR flash node on eval board.

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
[6]: https://lore.kernel.org/lkml/171259906078.120310.15397790336440498713.b4-ty@kernel.org/

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Changes in v4:
- Fix -Wunused-variable warning on patch "allow FIFO depth detection"
  by dropping two unused local variables.
- Rebase onto spi/for-next, drop three applied patches:
  - spi: dt-bindings: cdns,qspi-nor: sort compatibles alphabetically
  - spi: dt-bindings: cdns,qspi-nor: add mobileye,eyeq5-ospi compatible
  - spi: dt-bindings: cdns,qspi-nor: make cdns,fifo-depth optional
- Link to v3: https://lore.kernel.org/r/20240410-cdns-qspi-mbly-v3-0-7b7053449cf7@bootlin.com

Changes in v3:
- dt-bindings:
  - Patch "sort compatibles alphabetically":
    - Moved first.
    - Take Reviewed-By Krzysztof.
  - Patch "add mobileye,eyeq5-ospi compatible":
  - EyeQ5 no longer implies no cdns,fifo-depth prop. Patch now only adds
    compatible, no more property conditional.
  - New "make cdns,fifo-depth optional" patch, for all compatibles.
- Driver:
  - FIFO depth detection is no longer a quirk. It is for all compatibles
    if no DT property is provided.
  - Rebase onto spi-next [4] to drop three patches. No-IRQ mode patch is
    mentioned in email saying a subset of patches got applied [6].
    However, it is not in spi-next, so it is kept in series.
  - Busywait is no longer behind a quirk; it applies to all compatibles.
  - No-IRQ mode patch got modified to change its quirk index because
    previous quirk got removed.
  - As we removed some quirks, we no longer overflow u8 quirks.
- Link to v2: https://lore.kernel.org/r/20240405-cdns-qspi-mbly-v2-0-956679866d6d@bootlin.com

Changes in v2:
- Rebase upon v6.9-rc2.
- Fix dt-bindings commit subject tags.
- Take Reviewed-by: Krzysztof Kozlowski on dt-bindings commit.
- Add dt-bindings commit to order compatibles alphabetically.
  Krzysztof: unsure if you want this. It is second so that commit
  adding EyeQ5 compatible can be taken alone easily.
- Drop patch taken upstream:
  spi: cadence-qspi: switch from legacy names to modern ones
- Add To: Rob Herring, following get_maintainer.pl recommendation.
- Link to v1: https://lore.kernel.org/r/20240308-cdns-qspi-mbly-v1-0-a503856dd205@bootlin.com

---
Théo Lebrun (6):
      spi: cadence-qspi: allow FIFO depth detection
      spi: cadence-qspi: add no-IRQ mode to indirect reads
      spi: cadence-qspi: add early busywait to cqspi_wait_for_bit()
      spi: cadence-qspi: add mobileye,eyeq5-ospi compatible
      MIPS: mobileye: eyeq5: Add SPI-NOR controller node
      MIPS: mobileye: eyeq5: add octal flash node to eval board DTS

 arch/mips/boot/dts/mobileye/eyeq5-epm5.dts | 15 +++++
 arch/mips/boot/dts/mobileye/eyeq5.dtsi     | 15 +++++
 drivers/spi/spi-cadence-quadspi.c          | 91 +++++++++++++++++++++++-------
 3 files changed, 102 insertions(+), 19 deletions(-)
---
base-commit: 9deae5003d0e89ec6ef15879a70ba6fb43e15029
change-id: 20240209-cdns-qspi-mbly-de2205a44ab3

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


