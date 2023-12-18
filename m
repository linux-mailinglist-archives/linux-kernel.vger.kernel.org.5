Return-Path: <linux-kernel+bounces-4414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB463817CC9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 22:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368631F2510F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0100D74E35;
	Mon, 18 Dec 2023 21:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="p+aImHeE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F7474E26;
	Mon, 18 Dec 2023 21:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702935893;
	bh=NQEqY143VYksNlhopFxm06zXb51908qalsqGZ+XLVDk=;
	h=From:To:Cc:Subject:Date:From;
	b=p+aImHeEY5V+Cbui7K8BYs+kBMnVl/sTXwGrZhOyJw/mgNK5ZiNtbwSu+qD7D9UAh
	 px9Kcdbgbf8dJYAsr7m7zd2EVGz7SkIDQ9ybOoXUwBRApdhZcgzMNhKe3BXV9t8Wck
	 QqbQy0EMV5SQqjcxyDSp99ThORRlsJvCSTMhDwAx92Wb/AJT0cmOznPYxc950ka3MC
	 zyGHQO/MgXYP2X8Mu2jeVUDYwAPwBrgf0Yp8Ow81JwXD3REjenpYlk+Rh7g3SKTMNp
	 h4Ayn9b3uNQyWrOtll2uO/5kXeLBkiOZVNBMjmKfb6I97vNeKnsi+9D64R7594USvT
	 SRXDoE83XhsFA==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2F6A8378146E;
	Mon, 18 Dec 2023 21:44:53 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Samin Guo <samin.guo@starfivetech.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Hal Feng <hal.feng@starfivetech.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v4 0/9] Enable networking support for StarFive JH7100 SoC
Date: Mon, 18 Dec 2023 23:44:40 +0200
Message-ID: <20231218214451.2345691-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds ethernet support for the StarFive JH7100 SoC and makes it
available for the StarFive VisionFive V1 and BeagleV Starlight boards, although
I could only validate on the former SBC.  Thank you Emil and Geert for helping
with tests on BeagleV!

The work is heavily based on the reference implementation [1] and depends on the
SiFive Composable Cache controller and non-coherent DMA support provided by Emil
via [2] and [3].

*Update*: as of next-20231214, all dependencies have been merged.

[1] https://github.com/starfive-tech/linux/commits/visionfive
[2] https://lore.kernel.org/all/CAJM55Z_pdoGxRXbmBgJ5GbVWyeM1N6+LHihbNdT26Oo_qA5VYA@mail.gmail.com/
[3] https://lore.kernel.org/all/20231130151932.729708-1-emil.renner.berthing@canonical.com/

Changes in v4:
 - Restricted double usage of 'ahb' reset name in PATCH 2 (Jessica, Samuel)
 - Moved phy reference from PATCH 5 to both PATCH 6 & 7 where the node is
   actually defined (Emil, Conor)
 - Drop unnecessary gpio include in PATCH 6; also added a DTS comment describing
   the rational behind RX internal delay adjustment (Andrew)
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
 - Added clock fixes from Emil (PATCH v3 8-9/9) required to support 10/100Mb
   link speeds
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
 - Replaced 'uncached-offset' property with 'sifive,cache-ops' in PATCH 10/12
   and dropped 'sideband' reg
 - Add new patch providing coherent DMA memory pool (PATCH v2 10)
 - Updated PATCH 11/12 according to the stmmac glue layer changes in upstream
 - Split PATCH 12/12 into PATCH v2 10-12 to handle individual gmac setup of
   VisionFive v1 and BeagleV boards as they use different PHYs; also switched
   phy-mode from "rgmii-tx" to "rgmii-id" (requires a reduction of
   rx-internal-delay-ps by ~50%)
 - Rebased series onto next-20231024
 - v1:
   https://lore.kernel.org/lkml/20230211031821.976408-1-cristian.ciocaltea@collabora.com/

Cristian Ciocaltea (7):
  dt-bindings: net: starfive,jh7110-dwmac: Drop redundant reset
    description
  dt-bindings: net: starfive,jh7110-dwmac: Add JH7100 SoC compatible
  net: stmmac: dwmac-starfive: Add support for JH7100 SoC
  riscv: dts: starfive: jh7100: Add sysmain and gmac DT nodes
  riscv: dts: starfive: jh7100-common: Setup pinmux and enable gmac
  riscv: dts: starfive: visionfive-v1: Setup ethernet phy
  riscv: dts: starfive: beaglev-starlight: Setup phy reset gpio

Emil Renner Berthing (2):
  clk: starfive: Add flags argument to JH71X0__MUX macro
  clk: starfive: jh7100: Add CLK_SET_RATE_PARENT to gmac_tx

 .../devicetree/bindings/net/snps,dwmac.yaml   | 11 ++-
 .../bindings/net/starfive,jh7110-dwmac.yaml   | 75 ++++++++++++-----
 .../dts/starfive/jh7100-beaglev-starlight.dts | 11 +++
 .../boot/dts/starfive/jh7100-common.dtsi      | 84 +++++++++++++++++++
 .../jh7100-starfive-visionfive-v1.dts         | 22 ++++-
 arch/riscv/boot/dts/starfive/jh7100.dtsi      | 36 ++++++++
 .../clk/starfive/clk-starfive-jh7100-audio.c  |  2 +-
 drivers/clk/starfive/clk-starfive-jh7100.c    | 32 +++----
 .../clk/starfive/clk-starfive-jh7110-aon.c    |  6 +-
 .../clk/starfive/clk-starfive-jh7110-isp.c    |  2 +-
 .../clk/starfive/clk-starfive-jh7110-sys.c    | 26 +++---
 drivers/clk/starfive/clk-starfive-jh71x0.h    |  4 +-
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  6 +-
 .../ethernet/stmicro/stmmac/dwmac-starfive.c  | 32 ++++++-
 14 files changed, 280 insertions(+), 69 deletions(-)

-- 
2.43.0


