Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD14177E55C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344243AbjHPPlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239046AbjHPPlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:41:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F2D26A6;
        Wed, 16 Aug 2023 08:41:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11BB861777;
        Wed, 16 Aug 2023 15:41:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F1EC433C8;
        Wed, 16 Aug 2023 15:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692200471;
        bh=E/IKYTzpQNaTIjxwmCo0tbwLoswgeWU73USgeaiUoRc=;
        h=From:To:Cc:Subject:Date:From;
        b=TljYul4JFTwRzGTmjIOHRlZZQr9Fi9g0zZjcfNrIgEaDromvz+slL8+dX/zmWBAbI
         liD/G1qoAvyIkn53it76Hw0PmJkqFRrtMOtrQc/ycA1ASxULJ8sh4bZsR1hD7FvFt5
         4AA6M5BtKrOiW9LYqwxtBoRmxy2zDt4GqgHJvVnGZkc+RlvNpqcrs4iEGQe1z3sgHA
         FCVW1bRlTvptubJLDdptiyTeqWfUE4mNhM7gOrInUMgOQVvj/quI70mQFRWMUkR9La
         2gd/NF65Ytfv2d0O94APf5/LTJpMT/4EUHePJ9UbGDsVM7K753pvLh/KaA0s2LZTwl
         KEcd+ZEsSIPMw==
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
Subject: [PATCH net-next v4 0/9] net: stmmac: add new features to xgmac
Date:   Wed, 16 Aug 2023 23:29:17 +0800
Message-Id: <20230816152926.4093-1-jszhang@kernel.org>
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

Since v3:
 - collect Acked-by tag
 - remove patch which enlarges the max XGMAC C22 ADDR to 31 since it's
   merged
 - s/stmmac_request_irq_multi/stmmac_request_irq_multi_channel
 - update the dt-binding to refelct the optional per-channel irq:
     - use enum
     - add additionalItems and maxItems to fix the "interupt-names ..
       is too long"

Since v2:
 - check per channel irq by (res->rx_irq[0] > 0 && res->tx_irq[0] > 0)
   rather than (res->rx_irq[0] && res->tx_irq[0])
 - bypass if (irq <= 0) when request rx/tx irq

Since v1:
 - remove "_irq" suffix from safety irqs dt binding
 - remove "snps,per-channel-interrupt" dt binding, check the channel irq
   instead.
 - more renaming about "msi" to reflect per channel irq isn't MSI
   specific


Jisheng Zhang (9):
  net: stmmac: correct RX COE parsing for xgmac
  net: stmmac: xgmac: add more feature parsing from hw cap
  net: stmmac: enlarge max rx/tx queues and channels to 16
  net: stmmac: reflect multi irqs for tx/rx channels and mac and safety
  net: stmmac: xgmac: support per-channel irq
  dt-bindings: net: snps,dwmac: add safety irq support
  net: stmmac: platform: support parsing safety irqs from DT
  dt-bindings: net: snps,dwmac: add per channel irq support
  net: stmmac: platform: support parsing per channel irq from DT

 .../devicetree/bindings/net/snps,dwmac.yaml   | 77 ++++++++++++++++++-
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c |  4 +-
 .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |  2 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  2 +
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  5 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    | 34 ++++----
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 56 +++++++-------
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 35 +++++++++
 include/linux/stmmac.h                        | 10 +--
 9 files changed, 172 insertions(+), 53 deletions(-)

-- 
2.40.1

