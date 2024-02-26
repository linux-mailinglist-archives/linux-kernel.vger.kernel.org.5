Return-Path: <linux-kernel+bounces-82341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C100868308
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A190A1F24A3D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A85131E53;
	Mon, 26 Feb 2024 21:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTueOrf7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025CA13173B;
	Mon, 26 Feb 2024 21:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708982866; cv=none; b=kI0+jafdMnMsonsFOvA6PzWJfxDU5Ag2LVDv5ZwSHlYEh2XAFir6G7iIqU9HMaYEQhn7YM+2uxrZjq/YYCO8UauOOQaDbadRh1OUSX4sj4Wu0xvJ8BvlO8mLAK4kcOZzGKYDGnmVuKq7UjQzxw3r53+fF62xmEMnn75r5803ekg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708982866; c=relaxed/simple;
	bh=grAv2UX9w5//0+lqXh40HuhHnzKW6J9sNOgymXTHUsI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ja6N6LMvyiYWm2VqEGbOueE2eH2b0qozSGW5z7F3iMy4fr+LIh8IAffJEZU2HT0vEvjR6wqojzrfAhRmGLj5pWDTKXyvh8kXnqwVI3dFIZIGjUNM6y+knKWz5kxwAmqtiopph9ojwgASNcNP3/rsh1nnZoTpu+v5gjR2m7kRI4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTueOrf7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3084FC43394;
	Mon, 26 Feb 2024 21:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708982865;
	bh=grAv2UX9w5//0+lqXh40HuhHnzKW6J9sNOgymXTHUsI=;
	h=From:To:Cc:Subject:Date:From;
	b=fTueOrf7H0r1t9Wsr2bFQgWujJs3YsO9rmcLDgOqqgi8Z/zNJOwmeIGcRUDWpU1qZ
	 7qeKm8Dx4AIufgZ3kLf68RCjd/tDfy1DbhIPTiZ0+exBgJwBGtPaayJ/j8uhbdZR8v
	 b5uOwERbHorkC4uYVDLJ9rerLLJNEkRrQbV676HJYVvSfwMX5NRDv/TEOHd8qi71W2
	 qQT/87ccjxlkvkIMtrwgpCjVSM4bF9MdK+SQRgyMKisjW7WDqpuq7qj8lkdp3KVyYn
	 +kBMZyxbDE6DCw+Wdy7BItXexurtPw0d0B5A78qY9bG3QdW5sLGWlkTONoObcS7lvj
	 ALfB3fp9x21Sw==
Received: by mercury (Postfix, from userid 1000)
	id A1FF21060D83; Mon, 26 Feb 2024 22:27:41 +0100 (CET)
From: Sebastian Reichel <sre@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	imx@lists.linux.dev
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v5 0/6] UNI-T UTi260B support
Date: Mon, 26 Feb 2024 22:26:22 +0100
Message-ID: <20240226212740.2019837-1-sre@kernel.org>
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

This adds adds support for the UNI-T UTi260B thermal camera, which is based
on i.MX6ULL. The series first updates DT bindings, so that CHECK_DTBS no
longer reports any errors for i.MX6ULL (i.e. for an empty board). They are
not specific to the UTi260B and in fact that machine has most of the IP
handled by these patches marked as disabled. The last patch adds the actual
thermal camera DT.

The DT is based on reverse engineered information. More information about
the device can be found in this presentation from Embedded Recipes 2023:

 * https://embedded-recipes.org/2023/wp-content/uploads/2023/10/Running-FOSS-on-a-Thermal-Camera-Sebastian-Reichel-compressed.pdf
 * https://www.youtube.com/watch?v=uvObsCG-Cqo

I also prepared a branch with these patches (and a minimal kernel config)
and published it here:

https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-misc.git/log/?h=uti260b-v5

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

Sebastian Reichel (6):
  dt-bindings: pinctrl: fsl,imx6ul-pinctrl: convert to YAML
  dt-bindings: input: touchscreen: fsl,imx6ul-tsc convert to YAML
  dt-bindings: soc: imx: fsl,imx-anatop: add binding
  dt-bindings: soc: imx: fsl,imx-iomuxc-gpr: add imx6
  dt-bindings: fsl-imx-sdma: fix HDMI audio index
  ARM: dts: imx: Add UNI-T UTi260B thermal camera board

 .../devicetree/bindings/dma/fsl,imx-sdma.yaml |   3 +-
 .../input/touchscreen/fsl,imx6ul-tsc.yaml     |  97 +++
 .../bindings/input/touchscreen/imx6ul_tsc.txt |  38 --
 .../bindings/pinctrl/fsl,imx6ul-pinctrl.txt   |  37 --
 .../bindings/pinctrl/fsl,imx6ul-pinctrl.yaml  | 116 ++++
 .../bindings/soc/imx/fsl,imx-anatop.yaml      | 128 ++++
 .../bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml  |  18 +-
 arch/arm/boot/dts/nxp/imx/Makefile            |   1 +
 arch/arm/boot/dts/nxp/imx/imx6ull-uti260b.dts | 566 ++++++++++++++++++
 9 files changed, 927 insertions(+), 77 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx6ul-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx6ul-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx-anatop.yaml
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-uti260b.dts

-- 
2.43.0


