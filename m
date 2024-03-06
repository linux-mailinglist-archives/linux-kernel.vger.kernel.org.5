Return-Path: <linux-kernel+bounces-93844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 917FD873580
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A76491C21F65
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08F777F33;
	Wed,  6 Mar 2024 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="dgf8cHdz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hECTcVSN"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E2A77A0C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 11:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709723984; cv=none; b=b4nlF3i76CqWCtsyziSP39t+Lpi5WYMElkT/CgA/N2akiL4bo9BDL2P4BEBAIvZGcMjHihYWQu0c/j3EgyoIsc1ae3HYwyKf4o2LBWv4lGAd3FInifpzZwZbRKsyXFJC0w4d4K6W4a3MmSIsgyvpO0qr/ZyDwCSwULpk3k/WGnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709723984; c=relaxed/simple;
	bh=6R4aRTn9QLNqVLb6d5UbC+I9L3lSQrlAEv8M2chqMho=;
	h=MIME-Version:Message-Id:Date:From:To:Cc:Subject:Content-Type; b=lWNCgtAHIchbUT7zInpBw44MrDXounhfhYaV0NkiZE6z9Swz1jZeGTu3O58eNDTl/9WywBYfxe3CKvwFS4KOV8BZponLIGH6fqCPJmWsVHmlrhvhsagH5WfmdAgxJGDGL7SjX3vYRB87ERejGlJRpAQbdNYvWSNJF7Ibjs0nJyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=dgf8cHdz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hECTcVSN; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4507D1140102;
	Wed,  6 Mar 2024 06:19:41 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 06 Mar 2024 06:19:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1709723981; x=1709810381; bh=hJt21iC66mwZgb/RqWxSy56hrJkCDQ4B
	OHr/Y6ujLmY=; b=dgf8cHdz/tTuKwpjwfccTg8C/R+ZKtQbh0l1T4mgigcYotLL
	7AUQmhmgYGvrK7X4DCelUAqkq7w81Lkr7nm28/BB1l7DgSLBy8osXxP/DKdxb7Or
	Sv4KaRcsX1EXRBdL/z5+EPxcknLOQyucb3029zH1BSob8m1Q65uStE3fESWFizRr
	O9sl7Q87aBjzwrwBdtQtoss4kTUX6i8RPiJrsWb/e68RCnho6HFLnvJwSxcVMNkX
	0YOkRrZZUbiC9IvGOiChUGHqoET30vZTWkLJ3VjIcjQlmzi6QKgBp7ErD7rUvJDF
	SCRaE2jcH/9ztcAwY92vlLUfUERROgH0MoVyZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1709723981; x=1709810381; bh=hJt21iC66mwZgb/RqWxSy56hrJkCDQ4BOHr
	/Y6ujLmY=; b=hECTcVSNVGn1AcNpKAwcw28wCcwtnyykWBsXBIYSMrQiXKEu41e
	sbANM5sVRJor2UHfvEj4uMV46nsNyqZh8H2uorxKG/T+Ce6Gjenpwxc/Uj7XdNNI
	EnWjTroa9yaKdYKUSoRAvr39fd9Emjoz9Dfwkx61rA6oPW8N/WqrjVhC3DrHgJC/
	+Cvng2xn2//Ut+4VZEhvzEsS/Eid6i6j5S5H99GQ3+y6nG/AbJLnZycd7hAAjF8E
	dix6M1jwGpRGGvACZrrkCEqB8AGvM4iU3R714GjfiU8mIjMpzO9TPm4W6B3YaGuT
	SapyEAlVWcrMLExnV1GcAKqtmm27dShd34A==
X-ME-Sender: <xms:TFHoZT4CS-nQz9ptkzBCgJKgnEnfIQwDqqwTJzZKV7TRQ98s7ybXWg>
    <xme:TFHoZY7EEdbItS9Zq6HeFIKJ12kw5FIOiKOTSYqUDAYAL8eMHeW81jwatzuNxonX1
    aPfPOXyNweYLuPYTw0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedugddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedtlefhkedvvdethfeuteekheettddvveeltdffhfejudffheelieelheevjeejkeen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhlihhnrghrohdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgu
    sgdruggv
X-ME-Proxy: <xmx:TFHoZaeccGrrOmeBKxTohhQbxfaJtJN9m5MSPsxNafz1cw8b8RwKVg>
    <xmx:TFHoZUIpiP_Siw5oEzBkc_nUQnJn0j00DzgzPyvl2sdyg4Mkpr4y6A>
    <xmx:TFHoZXKhJqPTTJr3BPZRTjb1Ah6pRSe0AvEyPbHZoi2tX5yaeDpi7g>
    <xmx:TVHoZf2Kjm52q-R7_QDRCHdp2XgmM9g4etPhPMBgNC7n4KVzlNSwpQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id B8EE3B6008D; Wed,  6 Mar 2024 06:19:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-208-g3f1d79aedb-fm-20240301.002-g3f1d79ae
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c3d1b525-7295-4da9-acc9-763f6b884163@app.fastmail.com>
Date: Wed, 06 Mar 2024 12:19:15 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: soc@kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] Arm SoC fixes for 6.8, part 3
Content-Type: text/plain

The following changes since commit 90d35da658da8cff0d4ecbb5113f5fac9d00eb72:

  Linux 6.8-rc7 (2024-03-03 13:02:52 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-fixes-6.8-3

for you to fetch changes up to 1c7cfb6158f6678374ed42393b013b379b4c3964:

  Merge tag 'riscv-firmware-for-v6.9' of https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux into arm/fixes (2024-03-06 07:42:08 +0100)

----------------------------------------------------------------
Arm SoC fixes for 6.8, part 3

These should be the final fixes for the soc tree for 6.8, as usual
they mostly deal wtih dts files:

 - Qualcomm fixes for pcie4 on sc8280xp, a revert of msm8996 mpm support,
   sm6115 interconnect and sm8650 gpio.

 - Two fixes for Tegra234 ethernet

 - A Makefile fix to actually build the allwinner based orange pi zero 2w
   device tree

 - Fixes for clocks and reset on imx8mp and a DSI display regression
   on imx7.

The non-DT fixes are:

 - Firmware fixes addressing a kernel panic in op-tee and a minor regression
   in microchip/riscv.

 - A defconfig change to bring back backlight support after a Kconfig change

----------------------------------------------------------------
Arnd Bergmann (7):
      Merge tag 'sunxi-fixes-for-6.8-1' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into arm/fixes
      Merge tag 'qcom-arm64-fixes-for-6.8' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/fixes
      Merge tag 'imx-fixes-6.8-2' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/fixes
      Merge tag 'tegra-for-6.8-arm64-dt' of git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into arm/fixes
      Merge tag 'optee-fix-for-v6.8' of https://git.linaro.org/people/jens.wiklander/linux-tee into arm/fixes
      Merge tag 'qcom-arm64-fixes-for-6.8-2' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/fixes
      Merge tag 'riscv-firmware-for-v6.9' of https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux into arm/fixes

Daniel Baluta (1):
      MAINTAINERS: Use a proper mailinglist for NXP i.MX development

Dawei Li (1):
      firmware: microchip: Fix over-requested allocation size

Dmitry Baryshkov (1):
      Revert "arm64: dts: qcom: msm8996: Hook up MPM"

Fabio Estevam (1):
      ARM: imx_v6_v7_defconfig: Restore CONFIG_BACKLIGHT_CLASS_DEVICE

Francesco Dolcini (1):
      ARM: dts: imx7: remove DSI port endpoints

Jernej Skrabec (1):
      arm64: dts: allwinner: h616: Add Orange Pi Zero 2W to Makefile

Johan Hovold (2):
      arm64: dts: qcom: sc8280xp-crd: limit pcie4 link speed
      arm64: dts: qcom: sc8280xp-x13s: limit pcie4 link speed

Jon Hunter (1):
      arm64: tegra: Fix Tegra234 MGBE power-domains

Konrad Dybcio (1):
      arm64: dts: qcom: sm6115: Fix missing interconnect-names

Liu Ying (1):
      arm64: dts: imx8mp: Fix LDB clocks property

Marek Vasut (1):
      arm64: dts: imx8mp: Fix TC9595 reset GPIO on DH i.MX8M Plus DHCOM SoM

Neil Armstrong (2):
      arm64: dts: qcom: sm8650-qrd: add gpio74 as reserved gpio
      arm64: dts: qcom: sm8650-mtp: add gpio74 as reserved gpio

Sumit Garg (1):
      tee: optee: Fix kernel panic caused by incorrect error handling

Thierry Reding (1):
      arm64: tegra: Set the correct PHY mode for MGBE

 MAINTAINERS                                        | 16 ++++-----
 arch/arm/boot/dts/nxp/imx/imx7s.dtsi               | 26 ---------------
 arch/arm/configs/imx_v6_v7_defconfig               |  1 +
 arch/arm64/boot/dts/allwinner/Makefile             |  1 +
 .../arm64/boot/dts/freescale/imx8mp-dhcom-som.dtsi |  2 +-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi          |  2 +-
 .../dts/nvidia/tegra234-p3737-0000+p3701-0000.dts  |  2 +-
 arch/arm64/boot/dts/nvidia/tegra234.dtsi           |  6 ++--
 arch/arm64/boot/dts/qcom/msm8996.dtsi              | 39 ++++------------------
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts          |  2 ++
 .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts     |  2 ++
 arch/arm64/boot/dts/qcom/sm6115.dtsi               |  3 ++
 arch/arm64/boot/dts/qcom/sm8650-mtp.dts            |  2 +-
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts            |  2 +-
 drivers/firmware/microchip/mpfs-auto-update.c      |  3 +-
 drivers/tee/optee/device.c                         |  3 +-
 16 files changed, 35 insertions(+), 77 deletions(-)

