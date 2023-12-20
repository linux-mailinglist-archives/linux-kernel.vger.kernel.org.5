Return-Path: <linux-kernel+bounces-7440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0202681A7F0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99622B24BCC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 21:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76F448CF6;
	Wed, 20 Dec 2023 21:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pc5FCFsO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472F94B5A4;
	Wed, 20 Dec 2023 21:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703107072;
	bh=LToB9O1kzplrx0ArQIKTk3jeG9kcJyhV6Az+MBs4+P4=;
	h=From:To:Cc:Subject:Date:From;
	b=pc5FCFsO5gyBiQjQHGODZnZxvmbSnGUeAvv/QPvQNafZpqWm4yw0w7Pzrce5jdlsz
	 FzEvRVi8uYngZnkSuj6CDcQvVbQz42gh/tD1UT+TAtnwxqu78QqftFsGfn6HvAusVi
	 h8D94spDbe8M1y+Fx9lkKsVmU0kNo6D8NNpi7qRZVPb18hsoM5e/Y4OB43gxqmnzfV
	 83uvJPgpkGxomNALy3kLobv2JAG8i6mG+48zs18gRGHwOSvIYUlchAdCAYPiTCEBOX
	 LDMvX7A+7Dqawpr7CNB/TsuMgYqxPZVI8kG7Wtkjn/Csc1ayMWvxjORIH3DVO4B7FO
	 4npAppxo4v6HA==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D335F3781F8C;
	Wed, 20 Dec 2023 21:17:51 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Emil Renner Berthing <kernel@esmil.dk>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH v6 0/4] Enable networking support for StarFive JH7100 SoC
Date: Wed, 20 Dec 2023 23:17:38 +0200
Message-ID: <20231220211743.2490518-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds ethernet support for the StarFive JH7100 SoC and
makes it available for the StarFive VisionFive V1 and BeagleV Starlight
boards, although I could only validate on the former SBC.  Thank you Emil
and Geert for helping with tests on BeagleV!

The work is heavily based on the reference implementation [1] and depends
on the SiFive Composable Cache controller and non-coherent DMA support
provided by Emil via [2] and [3].

*Update 1*: As of next-20231214, dependencies [2] & [3] have been merged.

*Update 2*: Since v5, the dwmac patches will be handled via [4], while the
            clock patches subset via [5].

[1] https://github.com/starfive-tech/linux/commits/visionfive
[2] https://lore.kernel.org/all/CAJM55Z_pdoGxRXbmBgJ5GbVWyeM1N6+LHihbNdT26Oo_qA5VYA@mail.gmail.com/
[3] https://lore.kernel.org/all/20231130151932.729708-1-emil.renner.berthing@canonical.com/
[4] https://lore.kernel.org/lkml/20231220002824.2462655-1-cristian.ciocaltea@collabora.com/
[5] https://lore.kernel.org/lkml/20231219232442.2460166-1-cristian.ciocaltea@collabora.com/

Changes in v6:
 - Applied alphabetical ordering in PATCH 3 and 4 (Emil)

Changes in v5:
 - Collected R-b tags from Jacob and Andrew
 - Squashed PATCH 2 into PATCH 1 per Krzysztof's review
 - Drop unsupported snps,no-pbl-x8 property from gmac DT node
 - Split series into patch sets per subsystem, as described in "Update 2"
   section above (per Andrew's review)
 - v4:
   https://lore.kernel.org/lkml/20231218214451.2345691-1-cristian.ciocaltea@collabora.com/

Changes in v4:
 - Restricted double usage of 'ahb' reset name in PATCH 2 (Jessica, Samuel)
 - Moved phy reference from PATCH 5 to both PATCH 6 & 7 where the node is
   actually defined (Emil, Conor)
 - Drop unnecessary gpio include in PATCH 6; also added a DTS comment
   describing the rational behind RX internal delay adjustment (Andrew)
 - v3:
   https://lore.kernel.org/lkml/20231215204050.2296404-1-cristian.ciocaltea@collabora.com/

Changes in v3:
 - Rebased series onto next-20231214 and dropped the ccache & DMA coherency
   related patches (v2 06-08/12) handled by Emil via [3]
 - Squashed PATCH v2 01/12 into PATCH v3 2/9, per Krzysztof's review
 - Dropped incorrect PATCH v2 02/12
 - Incorporated Emil's feedback; also added his Co-developed-by on all dts
   patches
 - Documented the need of adjusting RX internal delay in PATCH v3 8/9, per
   Andrew's request
 - Added clock fixes from Emil (PATCH v3 8-9/9) required to support
   10/100Mb link speeds
 - v2:
   https://lore.kernel.org/lkml/20231029042712.520010-1-cristian.ciocaltea@collabora.com/

Changes in v2:
 - Dropped ccache PATCH 01-05 reworked by Emil via [2]
 - Dropped already applied PATCH 06/12
 - Added PATCH v2 01 to prepare snps-dwmac binding for JH7100 support
 - Added PATCH v2 02-03 to provide some jh7110-dwmac binding optimizations
 - Handled JH7110 conflicting work in PATCH 07 via PATCH v2 04
 - Reworked PATCH 8 via PATCH v2 05, adding JH7100 quirk and dropped
   starfive,gtxclk-dlychain DT property; also fixed register naming
 - Added PATCH v2 08 providing DMA coherency related DT changes
 - Updated PATCH 9 commit msg:
   s/OF_DMA_DEFAULT_COHERENT/ARCH_DMA_DEFAULT_COHERENT/
 - Replaced 'uncached-offset' property with 'sifive,cache-ops' in PATCH
   10/12 and dropped 'sideband' reg
 - Add new patch providing coherent DMA memory pool (PATCH v2 10)
 - Updated PATCH 11/12 according to the stmmac glue layer changes in
   upstream
 - Split PATCH 12/12 into PATCH v2 10-12 to handle individual gmac setup of
   VisionFive v1 and BeagleV boards as they use different PHYs; also
   switched phy-mode from "rgmii-tx" to "rgmii-id" (requires a reduction of
   rx-internal-delay-ps by ~50%)
 - Rebased series onto next-20231024
 - v1:
   https://lore.kernel.org/lkml/20230211031821.976408-1-cristian.ciocaltea@collabora.com/

Cristian Ciocaltea (4):
  riscv: dts: starfive: jh7100: Add sysmain and gmac DT nodes
  riscv: dts: starfive: jh7100-common: Setup pinmux and enable gmac
  riscv: dts: starfive: visionfive-v1: Setup ethernet phy
  riscv: dts: starfive: beaglev-starlight: Setup phy reset gpio

 .../dts/starfive/jh7100-beaglev-starlight.dts | 11 +++
 .../boot/dts/starfive/jh7100-common.dtsi      | 84 +++++++++++++++++++
 .../jh7100-starfive-visionfive-v1.dts         | 22 ++++-
 arch/riscv/boot/dts/starfive/jh7100.dtsi      | 36 ++++++++
 4 files changed, 152 insertions(+), 1 deletion(-)

-- 
2.43.0


