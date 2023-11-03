Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732967E00A1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjKCKZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 06:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjKCKZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 06:25:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F6ED69;
        Fri,  3 Nov 2023 03:25:40 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D8F1D66073DD;
        Fri,  3 Nov 2023 10:25:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699007138;
        bh=t7bVxWTHowbVZgsQgpfEarvJNLmrYsIn0CaEB3pSMdM=;
        h=From:To:Cc:Subject:Date:From;
        b=CHZN2KFUpjDkfC6IPrjt7KsQRoxk8bJY/VPr5xcU6AEm8ggzikFi6+ADOQ7Jze/mE
         dzppBNmE3fPZWukPx8/n6GXc7dCrlxoWDXAf7LmwKKaZfob2Tl/HiTwSs2fYYIyp1S
         PJy2B1+JGLnKZWJE/YeRFNTr4t/5ekX/9fnXWoHjDQ1pN8YT7w96gb8PyaR5fALIsy
         kzxw0QRq1J7x2CsDOO2IPkPZyZqyHaXuMaZ5gIopvaWoBuC2fXFIChuFJNJGqbsmnF
         nRROdTTVHAd+bLrtoDO9aAkshAPIwc2xOBJeFgvPDp0gzQAhHDKChu0sbs/7bFcD9G
         ZZCNc9W/C5X5g==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sboyd@kernel.org
Cc:     mturquette@baylibre.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        msp@baylibre.com, amergnat@baylibre.com, yangyingliang@huawei.com,
        u.kleine-koenig@pengutronix.de, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: [PATCH v3 0/3] MediaTek clocks: Support mux indices list and 8195 DP
Date:   Fri,  3 Nov 2023 11:25:30 +0100
Message-ID: <20231103102533.69280-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v3:
 - Rebased on next-20231025
 - Added comment in the code explaining why the dp/edp parents lists
   are split in one PLL per interface
 - Added a commit performing the same reparenting on MT8188 as well

Changes in v2:
 - Rebased on next-20231018

This series adds support to specify custom parent indices for MediaTek
MUX clocks, necessary to avoid setting the same parent PLL for MT8195's
top_dp and top_edp clocks, solving DP+eDP concurrent output issues.

No fixes tags are provided as the clk-mux commit introduces new logic
and the actual MT8195 fix depends on that.

This commit was tested on the Acer Tomato Chromebook (MT8195) with
dual concurrent display outputs (internal eDP panel and TypeC->DP->HDMI
adapter connected to Samsung UE40JU6400 4k TV); resolution switch on
DP was also tested; eDP output is not paused and internal display keeps
working as expected.


After feedback on v1 of this series (effectively the same as v2, except
for the rebase), I looked for an alternative solution with using
clk_set_rate_exclusive() as proposed. Couldn't find any, as that still
doesn't give any guarantee about selecting the same PLL that the driver
was manipulating before setting the right divider MUX, hence that still
wouldn't work correctly.

For more context, please look at the conversation at [1].

Cheers!

[1] https://lore.kernel.org/linux-arm-kernel/20230713072138.84117-1-angelogioacchino.delregno@collabora.com

AngeloGioacchino Del Regno (3):
  clk: mediatek: clk-mux: Support custom parent indices for muxes
  clk: mediatek: mt8195-topckgen: Refactor parents for top_dp/edp muxes
  clk: mediatek: mt8188-topckgen: Refactor parents for top_dp/edp muxes

 drivers/clk/mediatek/clk-mt8188-topckgen.c | 27 +++++++-------
 drivers/clk/mediatek/clk-mt8195-topckgen.c | 27 ++++++++++----
 drivers/clk/mediatek/clk-mux.c             | 14 +++++++
 drivers/clk/mediatek/clk-mux.h             | 43 ++++++++++++++++++++--
 4 files changed, 86 insertions(+), 25 deletions(-)

-- 
2.42.0

