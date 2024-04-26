Return-Path: <linux-kernel+bounces-160681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C2F8B40FE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 23:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 533FA1F22A38
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9DE2C6A3;
	Fri, 26 Apr 2024 21:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="SjI72gDX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RhPtZ06q"
Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD0C1EEE9
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 21:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714165213; cv=none; b=IiZX2jibT4p8ONH0MVoBA3iSAqf5UFDaOVu0CJD/pZQiNkCs5bvJU/UaTZ7s8YQ9wH/RCAWuuFfoP8ZtGrerXN2WMNGoGcz8sxPOYMfJ0me/S9QZGiPTZ5IT6XmAWcJRY7ReRTRXKvwbSyC3wlca1y4ontayGZrtdQwzLi42FVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714165213; c=relaxed/simple;
	bh=q3JvMA1nPOmLA3UYli+lGM/Qg6kfPS0fU9C9B+kI1no=;
	h=MIME-Version:Message-Id:Date:From:To:Cc:Subject:Content-Type; b=cdn8X1oyaE2Xb9cDc6rxhwndcgnHYDIsE/nHPW1YyQbaiiKE9GSv4F95JDWqroX3hheNbO+QutyiU9PpkarKQZ5V1KoVq/EHnQcDHdo5U2tKvm4i+FJL3Xf/RMogPHjQdOTNtfQVJQzNhZXbj3BPwpQLy3VnPQ6+NazqS0JdRYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=SjI72gDX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RhPtZ06q; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 47C471800120;
	Fri, 26 Apr 2024 17:00:09 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 26 Apr 2024 17:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1714165208; x=1714251608; bh=wU
	eBumuqW80PHkTO1zxi85ytjonMfDKXQVUCCUbe5fE=; b=SjI72gDXIT6ZHNnmiw
	fZTFyC5OIgnESNmoIVh9J3ZFMKs41Jca6I2TYwNGkzZKvYTSPmGqdVZG/37GT9u5
	Amhl1PkkupQT0kAS09TkKXKABfNE8cF3zX1RXjnk28i/QYu5Ht97XsZBeFQ3e6Ym
	T6enhCKIsAcjYCCXp4fGYQX2woXmxPCEW2V/Jw18GFSVl9lu+5ZCJWC9EckTL6US
	cjmRs/fSoJ1yyvLNk2GWKr4AIbiMJBDSwkuqNxpRebcpnEDd+RbA7qKvBVhO3IFD
	fWWUxQR0O7FuOoIzOZbbufOh4VS/E6khdFVipJTxqhHx6VyLGKnb1Z1nv53xf1CY
	LF2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1714165208; x=1714251608; bh=wUeBumuqW80PH
	kTO1zxi85ytjonMfDKXQVUCCUbe5fE=; b=RhPtZ06qfH+3QKY7/WlJJ7ac3fsjS
	snINWcm68tkRiSbuCpjrqMV36ROPgV9yAXlzSQ4J2E3+DBIjVArKafOifJq5tZye
	Ro3g6eket3gyvipjZZIvZ79xMSdObdPRnaGcQiIPUXlPI3T/OTydNOkTVBTN3KCp
	FjF2wQFqPJr1twteKs2fiR2TOcuJbGnqUGbEiO34cxiF1zpcpGkMYXKY5WqrvflN
	DS1hIY7h5f9UbSBzJyWFXY9HUGoVwPoLJN/WSliHd99Of/0j8Th30eD3T2y84xKE
	hXME9KWAiFddVx+rMUhtQB6jyWmxn1lIEzrKweBcx+du9ShKGo0GOtVhQ==
X-ME-Sender: <xms:2BUsZizFHyT4r21FMZh0xkpsvXbT-FupArvjouzNFb4NG4MB7OXDBg>
    <xme:2BUsZuSXMiED59H7M8DvAi_014BB7onW1hqzTHRcUjJ_9wOfnD0p_EchIaDqqApQd
    lZWC6HN1LXHLv6Qjvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelledgudehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgfffvedutdeltdfhudeitddvvddtleefkefhgefgveevlefgiedtieelfeef
    gfeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:2BUsZkXckUwXJBjPmZOozRl3CtrKfOI1x80COFLBgVIxwvU5cAc-dQ>
    <xmx:2BUsZogzgNDbtMe-Hf1s2xyQ9raIFOTxduOkYhOWGfZOJdJlL-DeZA>
    <xmx:2BUsZkDlhaKDdSOvdJN3dYSCHutGQBoFmCso93FMeF4Nok_J8ATR_g>
    <xmx:2BUsZpK44NYofO7RflFPYqMhIza7ba4jqomptvii7o1g9bqyv2g2KA>
    <xmx:2BUsZnPeXIa2v5v4Z1xjuyyZOP37QYdjEc6EoU3NoraP7zIu579_moLF>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 460CFB6008D; Fri, 26 Apr 2024 17:00:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-386-g4cb8e397f9-fm-20240415.001-g4cb8e397
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <beaae28d-c6c9-4117-adbc-e8ee614c16aa@app.fastmail.com>
Date: Fri, 26 Apr 2024 23:00:07 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: soc@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM SoC fixes for 6.9, part 2
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 0bbac3facb5d6cc0171c45c9873a2dc96bea9=
680:

  Linux 6.9-rc4 (2024-04-14 13:38:39 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-f=
ixes-6.9-2

for you to fetch changes up to 9f26bc71b1fd895e22151e63934588e5ddb11b05:

  Merge tag 'mtk-soc-fixes-for-v6.9' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/mediatek/linux into for-next (2024-04-26 19:45:10 +0200)

----------------------------------------------------------------
ARM SoC fixes for 6.9, part 2

There are a lot of minor DT fixes for Mediatek, Rockchip, Qualcomm and
Microchip and NXP, addressing both build-time warnings and bugs found du=
ring
runtime testing. Most of these changes are machine specific fixups, but
there are a few notable regressions that affect an entire SoC:

 - The Qualcomm MSI support that was improved for 6.9 ended up being
   wrong on some chips and now gets fixed.

 - The i.MX8MP camera interface broke due to a typo and gets
   updated again.

The main driver fix is also for Qualcomm platofrms, rewriting an interfa=
ce
in the QSEECOM firmware support that could lead to crashing the kernel
from a trusted application. The only other code changes are minor fixes
for Mediatek SoC drivers.

----------------------------------------------------------------
Andrei Simion (2):
      ARM: dts: microchip: at91-sama7g5ek: Replace regulator-suspend-vol=
tage with the valid property
      ARM: dts: microchip: at91-sama7g54_curiosity: Replace regulator-su=
spend-voltage with the valid property

Andy Yan (1):
      arm64: dts: rockchip: Fix the i2c address of es8316 on Cool Pi CM5

AngeloGioacchino Del Regno (1):
      soc: mediatek: mtk-svs: Append "-thermal" to thermal zone names

Arnd Bergmann (7):
      Merge branch 'v6.9-armsoc/dtsfixes' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/mmind/linux-rockchip into for-next
      Merge tag 'qcom-arm64-fixes-for-6.9' of https://git.kernel.org/pub=
/scm/linux/kernel/git/qcom/linux into for-next
      Merge tag 'at91-fixes-6.9' of https://git.kernel.org/pub/scm/linux=
/kernel/git/at91/linux into for-next
      Merge tag 'mtk-dts64-fixes-for-v6.9' of https://git.kernel.org/pub=
/scm/linux/kernel/git/mediatek/linux into for-next
      Merge tag 'imx-fixes-6.9-2' of git://git.kernel.org/pub/scm/linux/=
kernel/git/shawnguo/linux into for-next
      Merge tag 'qcom-drivers-fixes-for-6.9' of https://git.kernel.org/p=
ub/scm/linux/kernel/git/qcom/linux into for-next
      Merge tag 'mtk-soc-fixes-for-v6.9' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/mediatek/linux into for-next

Ar=C4=B1n=C3=A7 =C3=9CNAL (1):
      arm64: dts: rockchip: set PHY address of MT7531 switch to 0x1f

Daniel Golle (1):
      soc: mediatek: mtk-socinfo: depends on CONFIG_SOC_BUS

Dragan Simic (2):
      arm64: dts: rockchip: Remove unsupported node from the Pinebook Pr=
o dts
      arm64: dts: rockchip: Designate the system power controller on Qua=
rtzPro64

Ikjoon Jang (1):
      arm64: dts: mediatek: mt8183: Add power-domains properity to mfgcfg

Iskander Amara (2):
      arm64: dts: rockchip: enable internal pull-up for Q7_THRM# on RK33=
99 Puma
      arm64: dts: rockchip: fix alphabetical ordering RK3399 puma

Johan Hovold (1):
      arm64: dts: qcom: sc8280xp: add missing PCIe minimum OPP

Jose Ignacio Tornos Martinez (1):
      arm64: dts: rockchip: regulator for sd needs to be always on for B=
PI-R2Pro

Krzysztof Kozlowski (4):
      arm64: dts: rockchip: drop panel port unit address in GRU Scarlet
      arm64: dts: rockchip: drop redundant pcie-reset-suspend in Scarlet=
 Dumo
      arm64: dts: rockchip: drop redundant disable-gpios in Lubancat 1
      arm64: dts: rockchip: drop redundant disable-gpios in Lubancat 2

Luca Weiss (1):
      arm64: dts: qcom: Fix type of "wdog" IRQs for remoteprocs

Manivannan Sadhasivam (3):
      arm64: dts: qcom: sm8450: Fix the msi-map entries
      arm64: dts: qcom: sm8550: Fix the msi-map entries
      arm64: dts: qcom: sm8650: Fix the msi-map entries

Marek Vasut (1):
      arm64: dts: imx8mp: Fix assigned-clocks for second CSI2

Maximilian Luz (2):
      firmware: qcom: uefisecapp: Fix memory related IO errors and crash=
es
      arm64: dts: qcom: sc8180x: Fix ss_phy_irq for secondary USB contro=
ller

Michael Heimpold (1):
      ARM: dts: imx6ull-tarragon: fix USB over-current polarity

Muhammed Efe Cetin (1):
      arm64: dts: rockchip: mark system power controller and fix typo on=
 orangepi-5-plus

N=C3=ADcolas F. R. A. Prado (5):
      arm64: dts: mediatek: mt8192: Add missing gce-client-reg to mutex
      arm64: dts: mediatek: mt8195: Add missing gce-client-reg to vpp/vd=
osys
      arm64: dts: mediatek: mt8195: Add missing gce-client-reg to mutex
      arm64: dts: mediatek: mt8195: Add missing gce-client-reg to mutex1
      arm64: dts: mediatek: cherry: Describe CPU supplies

Pin-yen Lin (4):
      arm64: dts: mediatek: mt8192-asurada: Update min voltage constrain=
t for MT6315
      arm64: dts: mediatek: mt8195-cherry: Update min voltage constraint=
 for MT6315
      arm64: dts: mediatek: mt8183-kukui: Use default min voltage for MT=
6358
      arm64: dts: mediatek: mt8186-corsola: Update min voltage constrain=
t for Vgpu

Quentin Schulz (3):
      arm64: dts: rockchip: enable internal pull-up on Q7_USB_ID for RK3=
399 Puma
      arm64: dts: rockchip: enable internal pull-up on PCIE_WAKE# for RK=
3399 Puma
      arm64: dts: rockchip: add regulators for PCIe on RK3399 Puma Haikou

Rafa=C5=82 Mi=C5=82ecki (9):
      arm64: dts: mediatek: mt7622: fix clock controllers
      arm64: dts: mediatek: mt7622: fix IR nodename
      arm64: dts: mediatek: mt7622: fix ethernet controller "compatible"
      arm64: dts: mediatek: mt7622: drop "reset-names" from thermal block
      arm64: dts: mediatek: mt7986: drop invalid properties from ethsys
      arm64: dts: mediatek: mt7986: drop "#reset-cells" from Ethernet co=
ntroller
      arm64: dts: mediatek: mt7986: drop invalid thermal block clock
      arm64: dts: mediatek: mt7986: prefix BPI-R3 cooling maps with "map=
-"
      arm64: dts: mediatek: mt2712: fix validation errors

Rajendra Nayak (1):
      arm64: dts: qcom: x1e80100: Fix the compatible for cluster idle st=
ates

Rob Herring (2):
      dt-bindings: rockchip: grf: Add missing type to 'pcie-phy' node
      arm64: dts: rockchip: Fix USB interface compatible string on kobol=
-helios64

 .../devicetree/bindings/soc/rockchip/grf.yaml      |   1 +
 .../boot/dts/microchip/at91-sama7g54_curiosity.dts |   8 +-
 arch/arm/boot/dts/microchip/at91-sama7g5ek.dts     |   8 +-
 .../boot/dts/nxp/imx/imx6ull-tarragon-common.dtsi  |   1 +
 arch/arm64/boot/dts/freescale/imx8mp.dtsi          |   2 +-
 arch/arm64/boot/dts/mediatek/mt2712-evb.dts        |   8 +-
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi          |   3 +-
 arch/arm64/boot/dts/mediatek/mt7622.dtsi           |  34 +++--
 .../boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts  |   6 +-
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi          |   8 +-
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi     |   1 -
 arch/arm64/boot/dts/mediatek/mt8183.dtsi           |   1 +
 arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi   |   2 +-
 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi   |   6 +-
 arch/arm64/boot/dts/mediatek/mt8192.dtsi           |   1 +
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi    |  36 +++++-
 arch/arm64/boot/dts/mediatek/mt8195.dtsi           |   5 +
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |   4 +-
 arch/arm64/boot/dts/qcom/sc8180x.dtsi              |   2 +-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi             |  11 +-
 arch/arm64/boot/dts/qcom/sm6350.dtsi               |   4 +-
 arch/arm64/boot/dts/qcom/sm6375.dtsi               |   2 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi               |   6 +-
 arch/arm64/boot/dts/qcom/sm8450.dtsi               |  16 +--
 arch/arm64/boot/dts/qcom/sm8550.dtsi               |  10 +-
 arch/arm64/boot/dts/qcom/sm8650.dtsi               |  10 +-
 arch/arm64/boot/dts/qcom/x1e80100.dtsi             |   4 +-
 .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi      |   3 +-
 .../boot/dts/rockchip/rk3399-kobol-helios64.dts    |   2 +-
 .../boot/dts/rockchip/rk3399-pinebook-pro.dts      |   1 -
 .../arm64/boot/dts/rockchip/rk3399-puma-haikou.dts |   2 +
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      |  53 +++++++-
 arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts |   1 -
 arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts |   6 +-
 arch/arm64/boot/dts/rockchip/rk3568-lubancat-2.dts |   1 -
 .../arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi |   4 +-
 .../boot/dts/rockchip/rk3588-orangepi-5-plus.dts   |   3 +-
 .../arm64/boot/dts/rockchip/rk3588-quartzpro64.dts |   1 +
 drivers/firmware/qcom/qcom_qseecom_uefisecapp.c    | 137 ++++++++++++++=
-------
 drivers/firmware/qcom/qcom_scm.c                   |  37 +-----
 drivers/soc/mediatek/Kconfig                       |   1 +
 drivers/soc/mediatek/mtk-svs.c                     |   7 +-
 include/linux/firmware/qcom/qcom_qseecom.h         |  55 ++++++++-
 include/linux/firmware/qcom/qcom_scm.h             |  10 +-
 44 files changed, 331 insertions(+), 193 deletions(-)

