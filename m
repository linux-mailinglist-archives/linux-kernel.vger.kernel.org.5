Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0312677FCAC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353856AbjHQRKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353872AbjHQRJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:09:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D31930D4;
        Thu, 17 Aug 2023 10:09:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9BF8675A7;
        Thu, 17 Aug 2023 17:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D18C433C8;
        Thu, 17 Aug 2023 17:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692292174;
        bh=/IF04sHkLLuYwZg5UDGG+9COl2K4c5dV5hCvL3rgYGo=;
        h=From:To:Cc:Subject:Date:From;
        b=jGCwjPthnd6uH4tJfKVWBnQmxaCK2g/kXtyb2msrBxtoW25nEs7w1Ajj/BW+fpY6p
         ItcloqGHp1tbzAHwf4QfunNDFPfY7UB2kiKfKvAkHdYjt+pHMEWCAnaS9nmhH+m+UE
         AvW4HFjtvK0lKfL35Mniy6hFbixtI9oMmTXRTqaUQsroGbbvE5Vhk2KHNcvv9WZ3Jt
         Zat6t4/CaGZykYor1fD6Jm7h7kGHsLKEVbAKRIQ7xc53TTEnl0O1eJmmcwZG3T2Jkn
         zbIErRgMecOnIu7Y45iR/vX7Ke8LrJy7n9fHjsa9uoqKp6DBsRnKQG69QAWu9GDFOl
         nPipyytJQzJJQ==
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
Subject: [PATCH net-next v5 0/9] net: stmmac: add new features to xgmac
Date:   Fri, 18 Aug 2023 00:57:40 +0800
Message-Id: <20230817165749.672-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Since v4:
 - move "additionalItems" and "maxItems" a bit earlier to patch5 to
   fix "interrupt-names... is too long"

Since v3:
 - collect Acked-by tag
 - remove patch which enlarges the max XGMAC C22 ADDR to 31 since it's
   merged
 - s/stmmac_request_irq_multi/stmmac_request_irq_multi_channel
 - update the dt-binding to refelct the optional per-channel irq:
     - use enum
     - add additionalItems and maxItems to fix the "interrupt-names ..
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

