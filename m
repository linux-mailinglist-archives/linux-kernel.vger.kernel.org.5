Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7268B7CD95A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbjJRKf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjJRKf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:35:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502C2B0;
        Wed, 18 Oct 2023 03:35:55 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EABEF66072F7;
        Wed, 18 Oct 2023 11:35:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697625353;
        bh=rgrq6lFblmtQKHs08zZJsf2wZX+fKwB97omH3vm95yg=;
        h=From:To:Cc:Subject:Date:From;
        b=oKMwVkZ5wT5CfuEMV6sfTfD0+oi3EnHYshpFpCaToMLS3rca1dLqMpXMCrQJz9wYD
         MSZ3HWEVfw38wjWdlAUJX83CLG3nu58zC7ph5JIlW0k9kS0mYd5CnCpBE8tNBiFAaS
         oXoJvLK7d9oJciv22j4ch9+T1ubcQnN6tZirvNRRMYf1iXEQExRdQHgpjLv/sH+csz
         8iFMeF5lEh6K2Mc/V2gA6bmc6LtHWlzUc1ev38keShuwJNFTADaJI9ye6GsA41XMUC
         0GGPLuNmXw66dlGMbgMqY5qYMxP3uLRtxzm+DmKs6lPGzlWBY6a/enf0fh17li1aXQ
         b6MXtFLQiqxUA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sboyd@kernel.org
Cc:     mturquette@baylibre.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        msp@baylibre.com, amergnat@baylibre.com, yangyingliang@huawei.com,
        u.kleine-koenig@pengutronix.de, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: [PATCH v2 0/2] MediaTek clocks: Support mux indices list and 8195 DP
Date:   Wed, 18 Oct 2023 12:35:44 +0200
Message-ID: <20231018103546.48174-1-angelogioacchino.delregno@collabora.com>
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

AngeloGioacchino Del Regno (2):
  clk: mediatek: clk-mux: Support custom parent indices for muxes
  clk: mediatek: mt8195-topckgen: Refactor parents for top_dp/edp muxes

 drivers/clk/mediatek/clk-mt8195-topckgen.c | 22 +++++++----
 drivers/clk/mediatek/clk-mux.c             | 14 +++++++
 drivers/clk/mediatek/clk-mux.h             | 43 ++++++++++++++++++++--
 3 files changed, 67 insertions(+), 12 deletions(-)

-- 
2.42.0

