Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BE978C29C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 12:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjH2Kwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 06:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjH2Kwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 06:52:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0C11A6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 03:52:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B61D3653CF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:52:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF61AC433C7;
        Tue, 29 Aug 2023 10:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693306349;
        bh=XgXvx9AusPDy9935nVeLpmXF27doYX4REOLpkMaY//Y=;
        h=From:To:Cc:Subject:Date:From;
        b=SxwJb5LNdnNl1fReRuhH1I77UDnX+PsIlqKEDxhbVW4UJgkHOT8DwdhggArZaq838
         o4MOdj+KArn3wBefSQIQnyugd0xZJ6ngCOMXbnwRTKmBRks1KoMjUHetzjncvqoM/p
         Tsfi4sLvSALXVZi/414iGBUJbhxvS0SsG5RLt6R9ueebnspDrKCi8bITTdkO1DW04H
         x09xbL6T97dzOj7SyEEYc8re2PNXfXohBSItr+kANY7DrU7v8+ipxKWuv0eQhfsyiw
         Kl3Zi49NBn0rjfJh0WU1YrXbK8ospWOnzt3cQoIqDj8Os1X3lv7EMxBuO/XBvRqqCv
         L5g0e01PImVDg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Samin Guo <samin.guo@starfivetech.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Russell King <linux@armlinux.org.uk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 00/22] convert to devm_stmmac_probe_config_dt
Date:   Tue, 29 Aug 2023 18:40:11 +0800
Message-Id: <20230829104033.955-1-jszhang@kernel.org>
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

Russell pointed out there's a new devm_stmmac_probe_config_dt()
helper now when reviewing my starfive gmac error handling patch[1].
After greping the code, this nice helper was introduced by Bartosz in
[2], I think it's time to convert all dwmac users to this helper and
finally complete the TODO in [2] "but once all users of the old
stmmac_pltfr_remove() are converted to the devres helper, it will be
renamed back to stmmac_pltfr_remove() and the no_dt function removed."

Link: https://lore.kernel.org/netdev/ZOtWmedBsa6wQQ6+@shell.armlinux.org.uk/ [1]
Link: https://lore.kernel.org/all/20230623100417.93592-1-brgl@bgdev.pl/  [2]

Jisheng Zhang (22):
  net: stmmac: dwmac-anarion: use devm_stmmac_probe_config_dt()
  net: stmmac: dwmac-dwc-qos-eth: use devm_stmmac_probe_config_dt()
  net: stmmac: dwmac-generic: use devm_stmmac_probe_config_dt()
  net: stmmac: dwmac-generic: use devm_stmmac_pltfr_probe()
  net: stmmac: dwmac-imx: use devm_stmmac_probe_config_dt()
  net: stmmac: dwmac-ingenic: use devm_stmmac_probe_config_dt()
  net: stmmac: dwmac-intel-plat: use devm_stmmac_probe_config_dt()
  net: stmmac: dwmac-ipq806x: use devm_stmmac_probe_config_dt()
  net: stmmac: dwmac-lpc18xx: use devm_stmmac_probe_config_dt()
  net: stmmac: dwmac-mediatek: use devm_stmmac_probe_config_dt()
  net: stmmac: dwmac-meson: use devm_stmmac_probe_config_dt()
  net: stmmac: dwmac-meson8b: use devm_stmmac_probe_config_dt()
  net: stmmac: dwmac-rk: use devm_stmmac_probe_config_dt()
  net: stmmac: dwmac-socfpga: use devm_stmmac_probe_config_dt()
  net: stmmac: dwmac-starfive: use devm_stmmac_probe_config_dt()
  net: stmmac: dwmac-sti: use devm_stmmac_probe_config_dt()
  net: stmmac: dwmac-stm32: use devm_stmmac_probe_config_dt()
  net: stmmac: dwmac-sun8i: use devm_stmmac_probe_config_dt()
  net: stmmac: dwmac-sunxi: use devm_stmmac_probe_config_dt()
  net: stmmac: dwmac-tegra: use devm_stmmac_probe_config_dt()
  net: stmmac: dwmac-visconti: use devm_stmmac_probe_config_dt()
  net: stmmac: rename stmmac_pltfr_remove_no_dt to stmmac_pltfr_remove

 .../ethernet/stmicro/stmmac/dwmac-anarion.c   | 10 +---
 .../stmicro/stmmac/dwmac-dwc-qos-eth.c        | 15 ++----
 .../ethernet/stmicro/stmmac/dwmac-generic.c   | 15 +-----
 .../net/ethernet/stmicro/stmmac/dwmac-imx.c   | 13 ++---
 .../ethernet/stmicro/stmmac/dwmac-ingenic.c   | 33 ++++--------
 .../stmicro/stmmac/dwmac-intel-plat.c         | 25 +++------
 .../ethernet/stmicro/stmmac/dwmac-ipq806x.c   | 27 +++-------
 .../ethernet/stmicro/stmmac/dwmac-lpc18xx.c   | 19 ++-----
 .../ethernet/stmicro/stmmac/dwmac-mediatek.c  |  6 +--
 .../net/ethernet/stmicro/stmmac/dwmac-meson.c | 25 +++------
 .../ethernet/stmicro/stmmac/dwmac-meson8b.c   | 53 ++++++-------------
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 14 ++---
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   | 16 +++---
 .../ethernet/stmicro/stmmac/dwmac-starfive.c  | 10 +---
 .../net/ethernet/stmicro/stmmac/dwmac-sti.c   | 14 ++---
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 17 +++---
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  6 +--
 .../net/ethernet/stmicro/stmmac/dwmac-sunxi.c | 23 +++-----
 .../net/ethernet/stmicro/stmmac/dwmac-tegra.c | 10 ++--
 .../ethernet/stmicro/stmmac/dwmac-visconti.c  | 12 ++---
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 23 ++------
 .../ethernet/stmicro/stmmac/stmmac_platform.h |  1 -
 22 files changed, 110 insertions(+), 277 deletions(-)

-- 
2.40.1

