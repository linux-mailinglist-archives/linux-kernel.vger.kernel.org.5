Return-Path: <linux-kernel+bounces-138265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E97289EEFA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6146A1C2172A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C818B15A480;
	Wed, 10 Apr 2024 09:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lq3OFtjb"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C64E1598EA;
	Wed, 10 Apr 2024 09:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712741588; cv=none; b=FoXAiMl872YVVzsDioZDzZOS2tcL9OdMXn5wccSluF7iOl6gkw26cWBduhC3aQAolLPDlj71OExZIBxkHECpjMFlZHbVXcH202mCCU+/AxFhFdUXrCTTgxfyZP8RRc3oGVUJaXDKp0l5teGGbF+w+PsIfoBmTPVcf1FnurC8DLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712741588; c=relaxed/simple;
	bh=3vWRWxGstffzqNLW5/6mKLAWNYHCv7iLTBpmewWgXE8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ebrr+mS2gA5iIP/j/H8WzMheeF52ZpCx4Jw28Fgkqu1m5pp1IoSJGGApvuJeQhnE2cmAmtgYyZ5cg+6ex08hzNg4tppngJxrjjASKpOaSCAsCHXSZNJo6Z6d8drO6CXAhnFlwt7womcl22kbwTWzjsYfRjt9kbqWP7PkFTNQPIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lq3OFtjb; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay6-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::226])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 9D294C5F26;
	Wed, 10 Apr 2024 09:29:11 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 54410C0003;
	Wed, 10 Apr 2024 09:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712741349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Tg+gZ2Bg6yVJahNX0kkZdYlh/opG4Qc066zEoNLOrlo=;
	b=lq3OFtjbylpQEyw4abJL9bQ2DdKZznZLPoHR4hWZTcQvvCldz63SG6Wd1Rxxa5wyPaHTmg
	cx/0fnMdh4cmVg5/21ZXzo5aW9PmXmpIo/y0NXH9yqpW4vHEChruKw17IevfjB9bWzexjv
	kcPKQZnCVBAEKwBgFW1WhEtmJcvdF6VB4eRnsYNPXqqnjBVRs72wk8d6/jOFfDW9KvJ4wt
	rHKDOvTat1XYcHmK7iryU43mOty9iSFnpXWV7aU4Mr4mJ61U1QEkSBGiY7v3PdD2r/JC+q
	rDf4UAMZeY8WFli4Hx3bU5yqv9IqrFQzYIAjrh9M01C0EjY3VHDHk5+osSZ3tg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH v3 0/9] spi: cadence-qspi: add Mobileye EyeQ5 support
Date: Wed, 10 Apr 2024 11:29:03 +0200
Message-Id: <20240410-cdns-qspi-mbly-v3-0-7b7053449cf7@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAN9bFmYC/2XMSw6CMBSF4a2Qjq259iU4ch/GQaFVbgIttqSRE
 PZuwYFRh/9JzjeTaAPaSE7FTIJNGNG7HHxXkKbV7m4pmtyEARPAoKKNcZE+4oC0r7uJGssYSC2
 ErjnJpyHYGz438HLN3WIcfZg2Px3W9U1xKH+pdKBAtQReSmVMVs+192OHbt/4nqxYYh9AgPwDW
 AYqqdSxKpUyynwDy7K8AEalhPHvAAAA
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

V3 of this series adding octal SPI-NOR support to Mobileye EyeQ5
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
[6]: https://lore.kernel.org/lkml/171259906078.120310.15397790336440498713.b4-ty@kernel.org/

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
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
Théo Lebrun (9):
      spi: dt-bindings: cdns,qspi-nor: sort compatibles alphabetically
      spi: dt-bindings: cdns,qspi-nor: add mobileye,eyeq5-ospi compatible
      spi: dt-bindings: cdns,qspi-nor: make cdns,fifo-depth optional
      spi: cadence-qspi: allow FIFO depth detection
      spi: cadence-qspi: add no-IRQ mode to indirect reads
      spi: cadence-qspi: add early busywait to cqspi_wait_for_bit()
      spi: cadence-qspi: add mobileye,eyeq5-ospi compatible
      MIPS: mobileye: eyeq5: Add SPI-NOR controller node
      MIPS: mobileye: eyeq5: add octal flash node to eval board DTS

 .../devicetree/bindings/spi/cdns,qspi-nor.yaml     |  8 +-
 arch/mips/boot/dts/mobileye/eyeq5-epm5.dts         | 15 ++++
 arch/mips/boot/dts/mobileye/eyeq5.dtsi             | 15 ++++
 drivers/spi/spi-cadence-quadspi.c                  | 93 +++++++++++++++++-----
 4 files changed, 108 insertions(+), 23 deletions(-)
---
base-commit: d442072c067c86787dcee22c5d30d36b14edbba7
change-id: 20240209-cdns-qspi-mbly-de2205a44ab3

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


