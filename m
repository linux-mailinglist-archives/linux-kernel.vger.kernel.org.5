Return-Path: <linux-kernel+bounces-78769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FFF861898
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFF0F28303E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E30129A87;
	Fri, 23 Feb 2024 17:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="wEoQu2iU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B+cdBu87"
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF1C387
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708707612; cv=none; b=BfYyVnfes9pt+C7sUzayk/EpMSOQ0F61HE1HnJk4Zb2S473TV0/F9BoiyZsxV+0U8nsFo1ZqezewHS+18o2A7KbvYQgJVO549TEkefU+31CZkCqNQrWyLkaRxDFCpn3TjlN5U2MyorMefB1dCB6lgF6LBFGTsGZ9T96xTCIqQMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708707612; c=relaxed/simple;
	bh=zy7ZFXnj3B/m0SnHa5TxLl9bafJao7GXT3kqsZzMuak=;
	h=MIME-Version:Message-Id:Date:From:To:Cc:Subject:Content-Type; b=oOtMKczUtSNn/bfiEyukQNGjxXn0svCE4La7zTlQ4y6O8dfbKmtUjVLsDJoOu6XsfikRL4/2EaabuDKB2xOOl0lmcSnsza/AwVkHfKhdf3zVcYWUXFjOkCBHedcuU9DAcyVJ155DpxmjDy87+/bmUsNoosRfzDRNpaby1nUHBiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=wEoQu2iU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B+cdBu87; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2E8B813800B2;
	Fri, 23 Feb 2024 12:00:09 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 23 Feb 2024 12:00:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1708707609; x=1708794009; bh=sx
	FgYtoxgT2bQBcDpE9gSyojFxMWis2wO/V1q9tR25w=; b=wEoQu2iU0m2Xlf02pu
	J2X2gcPfSr1NpfnlKrYc4jpCXRJQ4CuZWioYJdtTbhe3Q9gULt2FyKFKTHufZjIF
	OXinWnFzpZ2MP40iesNF5mTNT5XAEcASBqtwDK1i4DxWIS5/TH5L0tAMclAUHSV+
	5y6gzmAFB9OW1CW4XIeq9BnbWUNQZelIypLc6fBKpEcx/iMRkyKtX/8E37LBuYQr
	187zyrHGuwRj2tLg+J2qpXwYP+jZz+c/GtIgJ/4TSlyUSAxNMWtuZiSRyBQ7s/7/
	wGrQ60lxQCBe8C3HR2FSDlYBNq/ThWaS+8Keqa5zQwMuIbVlHoRDkrIi/upq1wSo
	UDpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1708707609; x=1708794009; bh=sxFgYtoxgT2bQ
	BcDpE9gSyojFxMWis2wO/V1q9tR25w=; b=B+cdBu879Ga59q1mwWf2jA7rUnl5D
	c44/6ef+DRKnRed6AMsaCTo78HP3kBjdJLfHxy1FeTyTz5Reeaan+69PA/HYRadm
	v+MxTqUawtZHaCcnl775d2f2fV3oOisRXLvmJdNjRHgfC8kvdEFxFR52ybyJ/J3G
	MHXZxIe9uTjliW0QOrmxZRO0ajf0GVXOX9Gx9X1lB8iFuE4TR0EVz1hvUj4xwxV6
	i1sk3QVpmk0s/lvNlHd4x+5yhuDvHTE0NHB6tOzL7pZi1aYdW9FufjgpGd6xRxW3
	6jpplKFObWt3SguP0ArrL1nixuFuEHXyVmBNLNz3z0/PFH3WoJLKFmAgg==
X-ME-Sender: <xms:GM_YZYYn0gyTZv5Hnv6jXf_54xG7DkAk_hJQY_Yp6SFXEABUGUhvqA>
    <xme:GM_YZTZUezAMVSbyy_Iwgfl8m4I0TFplIDgV1sYNG-MiQdXCKAsE2P7rH_X6xmQ6r
    5oUJV-0APuGohezMnE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeigdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepgfffvedutdeltdfhudeitddvvddtleefkefhgefgveevlefgiedtieelfeefgfei
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:GM_YZS-3U998HM8t-OknEfkKmYdoGOFt-kny34NfTKcA-UuBcio_-g>
    <xmx:GM_YZSqlcDPK2wMCvi6sOPRX_WtZHA6P9xr6Hykqw31ZdCsuNCalSg>
    <xmx:GM_YZTrTVQbljH2hABmS1Ej9etqgxyoxsg3MI8emIu3rgquzWcZN-g>
    <xmx:Gc_YZSWKO67I1MRZsV2WBFc_cJlUZjgzSSZ0xLY2eeUQNdEMjlmdCw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 9AA1AB6008F; Fri, 23 Feb 2024 12:00:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <04be5855-9b18-4ff0-8554-8b9d626a7845@app.fastmail.com>
Date: Fri, 23 Feb 2024 18:00:07 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: soc@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] Arm and RISC-V SoC fixes for 6.8, part 2
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 841c35169323cd833294798e58b9bf63fa4fa=
1de:

  Linux 6.8-rc4 (2024-02-11 12:18:13 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git arm-fixes-=
6.8-2

for you to fetch changes up to dcb8e53e339e534eecfd86fb21674d7eef7380eb:

  Merge tag 'renesas-fixes-for-v6.8-tag1' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/geert/renesas-devel into arm/fixes (2024-02-23 13:54:=
37 +0100)

----------------------------------------------------------------
Arm and RISC-V SoC fixes for 6.8, part 2

The Rockchip and IMX8 platforms get a number of fixes for dts files in
order to address some misconfigurations, including a regression for
USB-C support on some boards.

The other dts fixes are part of a series by Rob Herring to clean up
another class of dtc compiler warnings across all platforms, with
a few others helping out as well. With this, we can enable the warning
for the coming merge window without introducing regressions.

Conor Dooley has collected fixes for RISC-V platforms, both for the
dts files and for platofrm specific drivers.

The ep93xx platform gets a regression for for its gpio descriptors.

----------------------------------------------------------------
Alexander Stein (1):
      arm64: dts: tqma8mpql: fix audio codec iov-supply

Andy Yan (4):
      arm64: dts: rockchip: aliase sdmmc as mmc1 for Cool Pi 4B
      arm64: dts: rockchip: aliase sdmmc as mmc1 for Cool Pi CM5 EVB
      arm64: dts: rockchip: rename vcc5v0_usb30_host regulator for Cool =
Pi CM5 EVB
      arm64: dts: rockchip: Fix the num-lanes of pcie3x4 on Cool Pi CM5 =
EVB

Arnd Bergmann (7):
      Merge tag 'imx-fixes-6.8' of git://git.kernel.org/pub/scm/linux/ke=
rnel/git/shawnguo/linux into arm/fixes
      Merge tag 'v6.8-rockchip-dtsfixes1' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/mmind/linux-rockchip into arm/fixes
      Merge tag 'riscv-cache-fixes-for-v6.8-rc6' of https://git.kernel.o=
rg/pub/scm/linux/kernel/git/conor/linux into arm/fixes
      Merge tag 'riscv-firmware-fixes-for-v6.8-rc6' of https://git.kerne=
l.org/pub/scm/linux/kernel/git/conor/linux into arm/fixes
      Merge tag 'riscv-soc-drivers-fixes-for-v6.8-rc6' of https://git.ke=
rnel.org/pub/scm/linux/kernel/git/conor/linux into arm/fixes
      Merge tag 'riscv-dt-fixes-for-v6.8-rc6' of https://git.kernel.org/=
pub/scm/linux/kernel/git/conor/linux into arm/fixes
      Merge tag 'renesas-fixes-for-v6.8-tag1' of git://git.kernel.org/pu=
b/scm/linux/kernel/git/geert/renesas-devel into arm/fixes

Chris Morgan (1):
      arm64: dts: rockchip: Correct Indiedroid Nova GPIO Names

Conor Dooley (1):
      riscv: dts: sifive: add missing #interrupt-cells to pmic

Fabio Estevam (2):
      Revert "arm64: dts: imx8mp-dhcom-pdk3: Describe the USB-C connecto=
r"
      Revert "arm64: dts: imx8mn-var-som-symphony: Describe the USB-C co=
nnector"

Geert Uytterhoeven (2):
      soc: microchip: Fix POLARFIRE_SOC_SYS_CTRL input prompt
      ARM: dts: renesas: rcar-gen2: Add missing #interrupt-cells to DA90=
63 nodes

Heiko Stuebner (2):
      arm64: dts: rockchip: drop unneeded status from rk3588-jaguar gpio=
-leds
      arm64: dts: rockchip: set num-cs property for spi on px30

Johan Jonker (1):
      arm64: dts: rockchip: Drop interrupts property from rk3328 pwm-roc=
kchip node

Krzysztof Kozlowski (2):
      riscv: dts: starfive: replace underscores in node names
      arm64: dts: rockchip: minor rk3588 whitespace cleanup

Lad Prabhakar (1):
      cache: ax45mp_cache: Align end size to cache boundary in ax45mp_dm=
a_cache_wback()

Lucas Stach (1):
      bus: imx-weim: fix valid range check

Marek Vasut (1):
      arm64: dts: imx8mp: Disable UART4 by default on Data Modul i.MX8M =
Plus eDM SBC

Nikita Shubin (1):
      ARM: ep93xx: Add terminator to gpiod_lookup_table

Rob Herring (5):
      arm64: dts: freescale: Disable interrupt_map check
      arm: dts: Fix dtc interrupt_provider warnings
      arm64: dts: Fix dtc interrupt_provider warnings
      arm: dts: Fix dtc interrupt_map warnings
      arm64: dts: qcom: Fix interrupt-map cell sizes

Samasth Norway Ananda (1):
      firmware: microchip: fix wrong sizeof argument

Sebastian Reichel (1):
      arm64: dts: rockchip: mark system power controller on rk3588-evb1

Uwe Kleine-K=C3=B6nig (1):
      ARM: dts: rockchip: Drop interrupts property from pwm-rockchip nod=
es

 arch/arm/boot/dts/amazon/alpine.dtsi                  |  1 -
 arch/arm/boot/dts/aspeed/aspeed-g4.dtsi               | 14 ------------=
--
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi               | 15 +-----------=
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi               | 18 ++----------=
------
 arch/arm/boot/dts/broadcom/bcm-cygnus.dtsi            |  3 +++
 arch/arm/boot/dts/broadcom/bcm-hr2.dtsi               |  1 +
 arch/arm/boot/dts/broadcom/bcm-nsp.dtsi               |  2 ++
 .../boot/dts/intel/ixp/intel-ixp42x-gateway-7001.dts  |  2 ++
 .../dts/intel/ixp/intel-ixp42x-goramo-multilink.dts   |  2 ++
 arch/arm/boot/dts/marvell/kirkwood-l-50.dts           |  2 ++
 arch/arm/boot/dts/nuvoton/nuvoton-wpcm450.dtsi        |  2 ++
 arch/arm/boot/dts/nvidia/tegra30-apalis-v1.1.dtsi     |  1 -
 arch/arm/boot/dts/nvidia/tegra30-apalis.dtsi          |  1 -
 arch/arm/boot/dts/nvidia/tegra30-colibri.dtsi         |  1 -
 arch/arm/boot/dts/nxp/imx/imx6q-b850v3.dts            |  3 ---
 arch/arm/boot/dts/nxp/imx/imx6q-bx50v3.dtsi           |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi         |  1 -
 arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi        |  1 -
 arch/arm/boot/dts/nxp/imx/imx6qdl-emcon.dtsi          |  1 -
 arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-pfla02.dtsi  |  1 +
 .../boot/dts/nxp/imx/imx6qdl-phytec-phycore-som.dtsi  |  1 +
 arch/arm/boot/dts/nxp/imx/imx7d-pico-dwarf.dts        |  1 +
 arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-b.dts      |  1 +
 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi                |  8 ++++----
 arch/arm/boot/dts/renesas/r8a7790-lager.dts           |  1 +
 arch/arm/boot/dts/renesas/r8a7790-stout.dts           |  1 +
 arch/arm/boot/dts/renesas/r8a7791-koelsch.dts         |  1 +
 arch/arm/boot/dts/renesas/r8a7791-porter.dts          |  1 +
 arch/arm/boot/dts/renesas/r8a7792-blanche.dts         |  1 +
 arch/arm/boot/dts/renesas/r8a7793-gose.dts            |  1 +
 arch/arm/boot/dts/renesas/r8a7794-alt.dts             |  1 +
 arch/arm/boot/dts/renesas/r8a7794-silk.dts            |  1 +
 arch/arm/boot/dts/rockchip/rv1108.dtsi                |  8 --------
 arch/arm/boot/dts/st/stm32429i-eval.dts               |  1 -
 arch/arm/boot/dts/st/stm32mp157c-dk2.dts              |  1 -
 arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts     |  1 -
 arch/arm/mach-ep93xx/core.c                           |  1 +
 arch/arm64/boot/dts/amazon/alpine-v2.dtsi             |  1 -
 arch/arm64/boot/dts/amazon/alpine-v3.dtsi             |  1 -
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi      |  1 +
 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi   |  1 +
 arch/arm64/boot/dts/freescale/Makefile                | 19 ++++++++++++=
+++++++
 .../boot/dts/freescale/imx8mn-var-som-symphony.dts    | 11 +++--------
 .../boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts  |  2 +-
 arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk3.dts   | 12 ++++--------
 .../boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts  |  9 ++++++++-
 arch/arm64/boot/dts/lg/lg1312.dtsi                    |  1 -
 arch/arm64/boot/dts/lg/lg1313.dtsi                    |  1 -
 arch/arm64/boot/dts/marvell/armada-ap80x.dtsi         |  1 -
 arch/arm64/boot/dts/mediatek/mt8195-demo.dts          |  1 +
 arch/arm64/boot/dts/qcom/ipq6018.dtsi                 |  8 ++++----
 arch/arm64/boot/dts/qcom/ipq8074.dtsi                 | 16 ++++++++----=
----
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi              |  4 ++++
 arch/arm64/boot/dts/rockchip/px30.dtsi                |  2 ++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi              |  1 -
 .../arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts |  8 +++++---
 arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi   |  4 ++--
 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts      |  1 +
 arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts        |  1 -
 arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts     |  8 ++++----
 arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts    |  4 ++--
 .../boot/dts/rockchip/rk3588s-indiedroid-nova.dts     | 10 +++++-----
 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts   |  1 +
 arch/riscv/boot/dts/starfive/jh7100.dtsi              | 12 ++++++------
 arch/riscv/boot/dts/starfive/jh7110.dtsi              |  4 ++--
 drivers/bus/imx-weim.c                                |  2 +-
 drivers/cache/ax45mp_cache.c                          |  4 ++++
 drivers/firmware/microchip/mpfs-auto-update.c         |  2 +-
 drivers/soc/microchip/Kconfig                         |  2 +-
 69 files changed, 126 insertions(+), 134 deletions(-)

