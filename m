Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0568B772B98
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjHGQxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbjHGQxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:53:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E36199D;
        Mon,  7 Aug 2023 09:53:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2237E61FA9;
        Mon,  7 Aug 2023 16:53:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE16C433C9;
        Mon,  7 Aug 2023 16:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691427214;
        bh=Wnt22onGXX5fFsf3cU0FGcECVvk6TAii1a47Y662QXw=;
        h=From:To:Cc:Subject:Date:From;
        b=C7g/EqYDBIt4vKUoQuX2S2+EFe4KDtTh+0uf2AIQN3Jjbo8OfWRiyx0yGAGu3ZESc
         OW0rSRWa+i3zEouGhgyiAOzB0fr1X7jF92eXvC/ath8XynHFCIWK9ZxKauTj6jlYbs
         qzsjMQCWcpuVAmVdcWFD9BpcvuJVykYzZ7DcDWPxVlQjofrsyXJ7l5y0nRPC1+Bx8r
         6OmHQN4LNi+gpGHvZ5Tpa/6rdcyQPN/rHR3kVDzY0x0IeUUv2fWpM0tEgYuWaGivQF
         gvtsHjysyRYfkjMYa+iSNNfuHO3dojL8xhYPeedqfaFCxGMIFq/sPZk0MGuL8ldd1/
         LDyLCCpmptcOg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v2 00/10] net: stmmac: add new features to xgmac
Date:   Tue,  8 Aug 2023 00:41:41 +0800
Message-Id: <20230807164151.1130-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add below new features to xgmac:

correct RX COE parsing
add more feature parsing from hw cap
enlarge C22 ADDR and rx/tx channels
support parse safety ce/ue irq from DT
support per channel irq

Since v1:
 - remove "_irq" suffix from safety irqs dt binding
 - remove "snps,per-channel-interrupt" dt binding, check the channel irq
   instead.
 - more renaming about "msi" to reflect per channel irq isn't MSI
   specific

Jisheng Zhang (10):
  net: stmmac: correct RX COE parsing for xgmac
  net: stmmac: xgmac: add more feature parsing from hw cap
  net: stmmac: mdio: enlarge the max XGMAC C22 ADDR to 31
  net: stmmac: enlarge max rx/tx queues and channels to 16
  net: stmmac: reflect multi irqs for tx/rx channels and mac and safety
  net: stmmac: xgmac: support per-channel irq
  dt-bindings: net: snps,dwmac: add safety irq support
  net: stmmac: platform: support parsing safety irqs from DT
  dt-bindings: net: snps,dwmac: add per channel irq support
  net: stmmac: platform: support parsing per channel irq from DT

 .../devicetree/bindings/net/snps,dwmac.yaml   | 37 +++++++++++++
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c |  4 +-
 .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |  2 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  5 ++
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  5 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    | 37 ++++++++-----
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 54 ++++++++++---------
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c |  2 +-
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 35 ++++++++++++
 include/linux/stmmac.h                        | 10 ++--
 10 files changed, 140 insertions(+), 51 deletions(-)

-- 
2.40.1

