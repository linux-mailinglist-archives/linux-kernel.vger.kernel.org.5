Return-Path: <linux-kernel+bounces-118030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C9488B2A8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04A6C304CD9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED2C6E5FD;
	Mon, 25 Mar 2024 21:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKCBNgJQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8B26BFC5;
	Mon, 25 Mar 2024 21:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711401848; cv=none; b=gsN2/O0c1U9PeHYz71AXoHZUECjPXZRn9VLrkhqIj8gda0kaJ/ewQKCzdyqJ4l2eBmZZ+wGN3AHcIbAmL5r1sufJLpL5OI0xNLd0W5KSx52pvUzqxG3NeLswI7r3x9jF6v2ia23Z09+B15VdNUEJlm91d0fAZLHfzF6/3Mzzncs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711401848; c=relaxed/simple;
	bh=2LGOLBNCx7l5fGnLnJy2dGw8TkN9T7q+Oy/fWlM/3bY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AS/GIR+OJk0Chv05bUuGCip1TK6rkxc5AY09kGWi6p7B0Scbea55TqpyAD2WmTPXtY2jRU/Y56naP6ciXmqv8snj8G/MT73SCxSmRLZKT6d4Qp+YCmrOmVCwTBVBRd/SccNJdttoOcOLNoYi3YZI05ZQdRfh7YR4Om8Hc7s+2Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKCBNgJQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50E5C433C7;
	Mon, 25 Mar 2024 21:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711401847;
	bh=2LGOLBNCx7l5fGnLnJy2dGw8TkN9T7q+Oy/fWlM/3bY=;
	h=From:To:Cc:Subject:Date:From;
	b=GKCBNgJQzb3AwbOviieh4Yfmx7Ji/Wz5feZEaEAmK8zeGqL+8EKZ9erhxUHZtvUlN
	 VoIwMRslNCcK+IgfN/qNT2o3C8Pz4Q/NGM2FoR1VLLFKIuSxAm0kZZlKZktxRXZM67
	 qYFzUF97SH7LtBRufTlUf9MMdxbvKAz0ah9/B1FvWbZQxXz1d+VxKFZzOygNLUTDjG
	 A1nvEcYYPa8LZqn2wa8McPfxAbeZbRDJm0MIEJvwMooxqndgORU72pLAq3Da7V0AfU
	 yJI3Wa7fEPh0R3AJSW1PQAifdA4gzAmx13Q/ea557ox67ddrm/4TwcTpWOpZ+Eytlv
	 XZaT1XTW2f+Fg==
Received: by mercury (Postfix, from userid 1000)
	id BE877106074E; Mon, 25 Mar 2024 22:24:04 +0100 (CET)
From: Sebastian Reichel <sre@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v6 0/1] UNI-T UTi260B support
Date: Mon, 25 Mar 2024 22:19:53 +0100
Message-ID: <20240325212402.150906-1-sre@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sebastian Reichel <sebastian.reichel@collabora.com>

Hi,

This adds adds support for the i.MX6ULL based UNI-T UTi260B thermal camera.
The DT is based on reverse engineered information. More information about
the device can be found in this presentation from Embedded Recipes 2023:

 * https://embedded-recipes.org/2023/wp-content/uploads/2023/10/Running-FOSS-on-a-Thermal-Camera-Sebastian-Reichel-compressed.pdf
 * https://www.youtube.com/watch?v=uvObsCG-Cqo

make -j4 CHECK_DTBS=y nxp/imx/imx6ull-uti260b.dtb reports no issues.

I also prepared a branch with these patches (and a minimal kernel config)
and published it here:

https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-misc.git/log/?h=uti260b

Changes since PATCHv5:
 * https://lore.kernel.org/all/20240226212740.2019837-1-sre@kernel.org/
  - rebase to v6.9-rc1
  - drop merged patches (all but DTS)

Changes since PATCHv4:
 * https://lore.kernel.org/all/20240224213240.1854709-1-sre@kernel.org/
  - drop merged patches
  - use new NXP mailing list
  - UTi260B board DT: change patch title
  - UTi260B board DT: fix node order

Changes since PATCHv3:
 * https://lore.kernel.org/all/20240216223654.1312880-1-sre@kernel.org/
  - weim binding: use " instead of '
  - weim binding: use "if: not: required: - foo" instead of "if: properties: foo: false"
  - imx6ull-uti260b.dts: merge ecspi3_csgrp into ecspi3grp
  - collect Reviewed-by from Krzysztof Kozlowski

Changes since PATCHv2:
 * https://lore.kernel.org/all/20240213010347.1075251-1-sre@kernel.org/
  - drop fsl,imx-asrc YAML binding conversion (merged)
  - collect a bunch of Reviewed-by/Acked-by tags
  - weim DT binding: fix issue with requirements
  - xnur-gpio -> xnur-gpios change: Improve patch long description

Changes since PATCHv1:
 * https://lore.kernel.org/all/20240210012114.489102-1-sre@kernel.org/
  - uni-t,imx6ull-uti260b -> uni-t,uti260b
  - add Acked-by for uni-t vendor prefix
  - add Acked-by for HDMI audio index fix
  - add Acked-by for LCDIF power-domain requirement drop
  - anatop DT binding: Fixed indentation in example
  - anatop DT binding: Described IRQs
  - touchscreen DT binding: change tsc@ to touchscreen@ in example
  - touchscreen DT binding: change xnur-gpio to xnur-gpios
  - weim DT binding: drop acme,whatever example
  - weim DT binding: use flash@ instead of nor@
  - weim DT binding: update weim.txt reference in arcx,anybus-controller.txt
  - weim DT binding: switch to memory-controller binding
  - fsl,imx-asrc DT binding: fix ASoC patch subject prefix
  - fsl,imx-asrc DT binding: add constraints
  - add new patch fixing xnur-gpio(s) in all i.MX6UL board DT files
  - add new patch fixing touchscreen nodename in i.MX6UL SoC DT file
  - add new patch fixing weim nodename in all i.MX SoC DT files
  - device DTS: use color/functions for the led
  - device DTS: increase SPI speed
  - device DTS: add comment for SD / eMMC node

Unadressed feedback from PATCHv1:
  - anatop phandle vs parent: technically it makes sense to just use the
    parent, but this driver is only used by i.MX6. The current code makes
	use of the phandle, so we cannot drop it because of backwards
	compatibility. So I don't see a point in deprecating this property.
  - touchscreen binding: I kept measure-delay-time and pre-charge-time
    values in hex, since that is being used everywhere and the unit
	is unknown. The values are directly written into HW registers and
	the i.MX6UL TRM does not provide any hints about the unit. I do not
	have an i.MX6UL device with a touchsreen, so I cannot test either.
  - regulator name in DT: I did not rename the regulators to just
    "regulator", since the nodename must be unique.

Greetings,

-- Sebastian

Sebastian Reichel (1):
  ARM: dts: imx: Add UNI-T UTi260B thermal camera board

 arch/arm/boot/dts/nxp/imx/Makefile            |   1 +
 arch/arm/boot/dts/nxp/imx/imx6ull-uti260b.dts | 566 ++++++++++++++++++
 2 files changed, 567 insertions(+)
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-uti260b.dts

-- 
2.43.0


