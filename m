Return-Path: <linux-kernel+bounces-60219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB61985018E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 02:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D44028AFB1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE922567A;
	Sat, 10 Feb 2024 01:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVuqAgss"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2814C210D;
	Sat, 10 Feb 2024 01:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707528079; cv=none; b=ksmsN4EgNE3yDrMFXcs34EbRAqOnddOq3Mt7SvDJsYqcStb8QADsMiBOrpv2fKW29NqkSowvmnPb+JEWbz9SF6e7SqdbGB9WqlCqd3f2tEdbEjMznPr5MFPP7RpFkeaRcxCFUcxjeSZu5tDOyeDn5wnhwyvhs/fpWrLy523gRzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707528079; c=relaxed/simple;
	bh=dWxu+A0eskxCxCyAgj4qP+QeMpzGHP95MeA7XhDzexc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ubV8squbsguX1BVGJkl9cHfRJfED+PXVF9s9358jDcjl+3eGdL/3gdJuizRGblqCANCY5dk4UBY54YRagqVQ38phssbAsAsKSOgbZ98j786lmvaIHdmcOgsVQ2xAjdQ40wETj8kWL1K5VFocyOSCZkGmIGxeB95NkDSOrPraM3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVuqAgss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E554C433B1;
	Sat, 10 Feb 2024 01:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707528078;
	bh=dWxu+A0eskxCxCyAgj4qP+QeMpzGHP95MeA7XhDzexc=;
	h=From:To:Cc:Subject:Date:From;
	b=KVuqAgssv1L9slpliqUn+iqTKKjUAGY1dC6CaT53dMvhw69xqA/0twJaEmQfYnF1v
	 iFiSabfXsv7xi8SuXugRfHdfPNsYc5paMJuXQ3L2WxKjJyRUb8217dN2SP9ENGaDPG
	 g5t3aiUeSiypQaxDtEMA3H94Sb2mt0hAZP/W3NnSrMrmP6KcIlXGPCtb1Wg/5gVVBZ
	 OuI/imin8KFEu5YBjyOQ/iJ74Mq/d0CYE+azGCHlyfc1M91vb8ybHz3XYG2bQ7RDsh
	 N53Od5PKR4u2kXComHMdjyujI5p+2RzyJUFWUvtcqoRmFKQUB2qPGO0qLLSJ8W28zR
	 dgJkVN5BGon/Q==
Received: by mercury (Postfix, from userid 1000)
	id D288210608D6; Sat, 10 Feb 2024 02:21:15 +0100 (CET)
From: Sebastian Reichel <sre@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v1 00/14] UNI-T UTi260B support
Date: Sat, 10 Feb 2024 02:18:04 +0100
Message-ID: <20240210012114.489102-1-sre@kernel.org>
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

This adds adds support for the UNI-T UTi260B thermal camera, which is
based on i.MX6ULL. Patches 1-11 clean up all warnings reported by
CHECK_DTBS for i.MX6ULL (i.e. for an empty board). They are not specific
to the UTi260B and in fact that machine has most of the IP handled by
these patches marked as disabled. Then patches 12+13 introduce the vendor
and board compatible DT bindings. Finally the last patches adds support
for the thermal camera itself.

The DT is based on reverse engineered information. More information about
the device can be found in this presentation from Embedded Recipes 2023:

 * https://embedded-recipes.org/2023/wp-content/uploads/2023/10/Running-FOSS-on-a-Thermal-Camera-Sebastian-Reichel-compressed.pdf
 * https://www.youtube.com/watch?v=uvObsCG-Cqo

I also prepared a branch with these patches (and a minimal kernel config)
and published it here:

https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-misc.git/log/?h=uti260b

Greetings,

-- Sebastian

Sebastian Reichel (14):
  dt-bindings: pinctrl: fsl,imx6ul-pinctrl: convert to YAML
  dt-bindings: bus: imx-weim: convert to YAML
  dt-bindings: sound: fsl,imx-asrc: convert to YAML
  dt-bindings: input: touchscreen: fsl,imx6ul-tsc convert to YAML
  dt-bindings: soc: imx: fsl,imx-anatop: add binding
  dt-bindings: soc: imx: fsl,imx-iomuxc-gpr: add imx6
  dt-bindings: lcdif: Do not require power-domains for i.MX6ULL
  dt-bindings: fsl-imx-sdma: fix HDMI audio index
  ARM: dts: imx6ull: fix pinctrl node name
  ARM: dts: imx6ul: Remove fsl,anatop from usbotg1
  ARM: dts: imx6ul: add missing #thermal-sensor-cells
  dt-bindings: vendor-prefixes: add UNI-T
  dt-bindings: arm: add UNI-T UTi260b
  ARM: dts: imx6ull-uti260b: Add board

 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 .../devicetree/bindings/bus/fsl,imx-weim.yaml | 225 +++++++
 .../devicetree/bindings/bus/imx-weim.txt      | 117 ----
 .../bindings/display/fsl,lcdif.yaml           |   8 +-
 .../devicetree/bindings/dma/fsl,imx-sdma.yaml |   3 +-
 .../input/touchscreen/fsl,imx6ul-tsc.yaml     |  92 +++
 .../bindings/input/touchscreen/imx6ul_tsc.txt |  38 --
 .../bindings/pinctrl/fsl,imx6ul-pinctrl.txt   |  37 --
 .../bindings/pinctrl/fsl,imx6ul-pinctrl.yaml  | 116 ++++
 .../bindings/soc/imx/fsl,imx-anatop.yaml      | 125 ++++
 .../bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml  |  18 +
 .../devicetree/bindings/sound/fsl,asrc.txt    |  80 ---
 .../bindings/sound/fsl,imx-asrc.yaml          | 159 +++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/nxp/imx/Makefile            |   1 +
 arch/arm/boot/dts/nxp/imx/imx6ul.dtsi         |   2 +-
 arch/arm/boot/dts/nxp/imx/imx6ull-uti260b.dts | 564 ++++++++++++++++++
 arch/arm/boot/dts/nxp/imx/imx6ull.dtsi        |   2 +-
 18 files changed, 1314 insertions(+), 276 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/fsl,imx-weim.yaml
 delete mode 100644 Documentation/devicetree/bindings/bus/imx-weim.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx6ul-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx6ul-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx-anatop.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/fsl,asrc.txt
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-uti260b.dts

-- 
2.43.0


