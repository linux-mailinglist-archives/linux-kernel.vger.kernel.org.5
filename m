Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A60C781DC2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 14:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjHTMSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 08:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjHTMSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 08:18:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D56CA1;
        Sun, 20 Aug 2023 05:14:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97B6661337;
        Sun, 20 Aug 2023 12:14:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7B3C433C7;
        Sun, 20 Aug 2023 12:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692533643;
        bh=IC8w578EAIZuY+94RdibA09oC+PtDBo0QtdFqUh+Eoc=;
        h=From:To:Cc:Subject:Date:From;
        b=e9ZZcIuUApBk3/DB9NX5MF3p32ExThYZkvRMnbluFlAdY1aeeaEuz1pLo9GSKmVDh
         UUqiuVscsmqZqCwmK3KTZ9GEaZJ3/Pz7iepdYs0MoEjyq/ffILkkYcke7fdf2/tMDO
         FZ/Xfw5h8SOsIoLRXITYJQ1kjR4fwy8GQLT8ce1BfZwuvMOOPG6kjn1T+Scz9gVSPJ
         xjDzHwGnEqmYnPqAoe8D0O+5g04ZF977wMRCp+zLL7J6hthruWXb1wOlh5AmeeI46D
         oeaHTaHfYc9qmcMAF8VPkQ16Ahm1qyNNgGvS4KBnIj30ev7qILkdeshYhyOm+TqmqL
         hbWS/d9APZiyw==
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
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH net-next 0/3] add the dwmac driver for T-HEAD TH1520 SoC
Date:   Sun, 20 Aug 2023 20:02:10 +0800
Message-Id: <20230820120213.2054-1-jszhang@kernel.org>
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

Jisheng Zhang (3):
  dt-bindings: net: snps,dwmac: allow dwmac-3.70a to set pbl properties
  dt-bindings: net: add T-HEAD dwmac support
  net: stmmac: add glue layer for T-HEAD TH1520 SoC

 .../devicetree/bindings/net/snps,dwmac.yaml   |   2 +
 .../devicetree/bindings/net/thead,dwmac.yaml  |  87 +++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac-thead.c | 304 ++++++++++++++++++
 5 files changed, 405 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/thead,dwmac.yaml
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c

-- 
2.40.1

