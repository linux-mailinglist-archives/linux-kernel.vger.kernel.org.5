Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073B07DAAB8
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 05:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjJ2E1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 00:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ2E1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 00:27:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FE7AD;
        Sat, 28 Oct 2023 21:27:20 -0700 (PDT)
Received: from localhost (unknown [188.24.143.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 93BFF6607332;
        Sun, 29 Oct 2023 04:27:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698553637;
        bh=n+ZdkLjYx7BCTMug2pHsJcPM5JrGsyJS0p5MK5HHjEE=;
        h=From:To:Cc:Subject:Date:From;
        b=YGCEXx3lfRjWUCbd2vc4CJYDoWcmz0cympjiLksceK9GI1HYaUyW7t//lstBik5s1
         HpGJgn6kj7XZdunSkpVWEYWhptEkIxwtHKlAPrhrD3KEvlGxqO7lJeODc0FhbK/3P3
         mLFj9qNWGjdjUT2MQJkDFEr0gd4pnhPKasLldg9T9ADjHwxO98Vk9+AnKOeGPoz2qj
         r8SnXUwYhVkRDwD+5ONz2jF8yXsI8JWcnxbgP9NDIr7KYXv6OYL986X2M8hHsgNTUs
         O0rDkHC89XRAH4oY15VddESeIjQYD1sFgNbCS+IUJoWIKu2xVd2iG7UjfX/Jn/smIT
         o7v1ijfzkKb1Q==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     "David S. Miller" <davem@davemloft.net>,
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
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: [PATCH v2 00/12] Enable networking support for StarFive JH7100 SoC
Date:   Sun, 29 Oct 2023 06:27:00 +0200
Message-ID: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds ethernet support for the StarFive JH7100 SoC and 
makes it available for the StarFive VisionFive V1 and BeagleV Starlight 
boards, although I could only validate on the former SBC.

The work is heavily based on the reference implementation [1] and depends 
the non-coherent DMA support provided by Emil via the SiFive Composable 
Cache controller [2].

[1] https://github.com/starfive-tech/linux/commits/visionfive
[2] https://lore.kernel.org/all/CAJM55Z_pdoGxRXbmBgJ5GbVWyeM1N6+LHihbNdT26Oo_qA5VYA@mail.gmail.com/

Changes in v2:
 - Dropped ccache PATCH 01-05 reworked by Emil via [2]
 - Dropped already applied PATCH 06/12
 - Added PATCH v2 01 to prepare snps-dwmac binding for JH7100 support
 - Added PATCH v2 02-03 to provide some jh7110-dwmac binding optimizations
 - Handled JH7110 conflicting work in PATCH 07 via PATCH v2 04
 - Reworked PATCH 8 via PATCH v2 05, adding JH7100 quirk and dropped
 - starfive,gtxclk-dlychain DT property, also fixed register naming
 - Added PATCH v2 08 providing DMA coherency related DT changes
 - Updated PATCH 9 commit msg:
   s/OF_DMA_DEFAULT_COHERENT/ARCH_DMA_DEFAULT_COHERENT/
 - Replaced 'uncached-offset' property with 'sifive,cache-ops' 
   in PATCH 10/12 and dropped 'sideband' reg
 - Add new patch providing coherent DMA memory pool (PATCH v2 10)
 - Updated PATCH 11/12 according to the stmmac glue layer changes in
   upstream
 - Split PATCH 12/12 into PATCH v2 10-12 to handle individual gmac setup of
   VisionFive v1 and BeagleV boards as they use different PHYs; also
   switched phy-mode from "rgmii-tx" to "rgmii-id" (requires a reduction of
   rx-internal-delay-ps by ~50%)
 - Rebased series onto next-20231024
 - v1: https://lore.kernel.org/lkml/20230211031821.976408-1-cristian.ciocaltea@collabora.com/

Cristian Ciocaltea (11):
  dt-bindings: net: snps,dwmac: Allow exclusive usage of ahb reset
  dt-bindings: net: starfive,jh7110-dwmac: Drop superfluous select
  dt-bindings: net: starfive,jh7110-dwmac: Drop redundant reset
    description
  dt-bindings: net: starfive,jh7110-dwmac: Add JH7100 SoC compatible
  net: stmmac: dwmac-starfive: Add support for JH7100 SoC
  riscv: dts: starfive: jh7100: Add dma-noncoherent property
  riscv: dts: starfive: jh7100: Add ccache DT node
  riscv: dts: starfive: jh7100: Add sysmain and gmac DT nodes
  riscv: dts: starfive: jh7100-common: Setup gmac pinmux
  riscv: dts: starfive: visionfive-v1: Enable gmac and setup phy
  [UNTESTED] riscv: dts: starfive: beaglev-starlight: Enable gmac

Emil Renner Berthing (1):
  riscv: dts: starfive: Add pool for coherent DMA memory on JH7100
    boards

 .../devicetree/bindings/net/snps,dwmac.yaml   |   3 +-
 .../bindings/net/starfive,jh7110-dwmac.yaml   |  84 +++++++++------
 .../dts/starfive/jh7100-beaglev-starlight.dts |   5 +
 .../boot/dts/starfive/jh7100-common.dtsi      | 100 ++++++++++++++++++
 .../jh7100-starfive-visionfive-v1.dts         |  17 +++
 arch/riscv/boot/dts/starfive/jh7100.dtsi      |  51 +++++++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |   6 +-
 .../ethernet/stmicro/stmmac/dwmac-starfive.c  |  32 +++++-
 8 files changed, 259 insertions(+), 39 deletions(-)

-- 
2.42.0

