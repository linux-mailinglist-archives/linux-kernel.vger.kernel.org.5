Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C882789CA6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 11:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjH0J3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 05:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjH0J3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 05:29:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897B0E1;
        Sun, 27 Aug 2023 02:29:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EC23614EA;
        Sun, 27 Aug 2023 09:29:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062BDC433C8;
        Sun, 27 Aug 2023 09:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693128540;
        bh=2eeq+7FRTyNfKeldAGasRv6sGX46OUHFmY+FSc4kENM=;
        h=From:To:Cc:Subject:Date:From;
        b=rX4IAGxD/LlIE/VrRxKItRZANI9+BMo5JoQ76E40dvbNge7TqlAp6AYk0OWg7w/z4
         6WDtsPb7+ThXUVk0Tv198kiRMI1UyfZOJyqMd+s0P6hHO+G01RgZowgDd9sfL3lZL2
         x4CkPFs+zdmHL7gVz/qlWxJTDgt8wcag23/aIHhqs1tQyb2a48oE4sydFd8OxyKFYS
         mQvkkTnsEkhHqpNX9G2gHRtWTzxv0im8M9yzzrYp5hhEYibeaKpOa6ooxMR8MfqIc9
         t9p6cLbYIIshVGUPAYWZm/5BNpfspq00ZU5Nl46pXWDGUyZ2OxQRBW6ScwQvlbZ1qE
         y/ke+YhkqSXxg==
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
        Jose Abreu <joabreu@synopsys.com>, Maxime@vger.kernel.org,
        Coquelin@vger.kernel.org, Simon Horman <simon.horman@corigine.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH net-next v2 0/3] add the dwmac driver for T-HEAD TH1520 SoC
Date:   Sun, 27 Aug 2023 17:17:07 +0800
Message-Id: <20230827091710.1483-1-jszhang@kernel.org>
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

Add the dwmac driver support for T-HEAD TH1520 SoC.

Since the clk part isn't mainlined, so SoC dts(i) changes are not
included in this series. However, it can be tested by using fixed-clock.

Since v1:
  - rebase on the lastest net-next
  - collect Reviewed-by tag
  - address Krzysztof's comment of the dt binding
  - fix "div is not initialised" issue pointed out by Simon

Jisheng Zhang (3):
  dt-bindings: net: snps,dwmac: allow dwmac-3.70a to set pbl properties
  dt-bindings: net: add T-HEAD dwmac support
  net: stmmac: add glue layer for T-HEAD TH1520 SoC

 .../devicetree/bindings/net/snps,dwmac.yaml   |   2 +
 .../devicetree/bindings/net/thead,dwmac.yaml  |  77 +++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac-thead.c | 302 ++++++++++++++++++
 5 files changed, 393 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/thead,dwmac.yaml
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c

-- 
2.40.1

