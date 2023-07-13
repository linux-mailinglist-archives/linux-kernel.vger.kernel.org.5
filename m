Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED84D7519AE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbjGMHVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjGMHVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:21:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2476E68;
        Thu, 13 Jul 2023 00:21:50 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AA7636606FD8;
        Thu, 13 Jul 2023 08:21:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689232908;
        bh=zMZb8z3Quqx4Yg1JIfaRJ/qy2+8osqR3i/M/mk5GdyQ=;
        h=From:To:Cc:Subject:Date:From;
        b=on9reJewTonDQado0D0YcBUcsSR3WJYomX+k56gZ2dmscc1b1F0jXrD49uWoYejz5
         qjLVIXIEljjhEiXQMNWPPVS170fSWxpeFnYXV2Tzk+ozUn/XXtYmrVHynGE/S1OIf4
         b7KDL0Ys8hxABgXAwlL/Kn8poqfYFhQwdrCVxT7E0qRAGZPNBuzH88z/SCU9xjzCDL
         E13/LYbfgykH+54YVu7BfQKWQufxEr1US/Fi3BzUY0AnMHgYXORTym3Oykk/6kOh/r
         3K8YBFlaguevlGtINYDmEZS+ic90HwtXhk2INdtUMtS/keB2tNAbD6rqWKlXKToftm
         43O9OcwSknJvQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sboyd@kernel.org
Cc:     mturquette@baylibre.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        msp@baylibre.com, amergnat@baylibre.com, yangyingliang@huawei.com,
        u.kleine-koenig@pengutronix.de, miles.chen@mediatek.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: [PATCH 0/2] MediaTek clocks: Support mux indices list and 8195 DP
Date:   Thu, 13 Jul 2023 09:21:36 +0200
Message-Id: <20230713072138.84117-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
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

AngeloGioacchino Del Regno (2):
  clk: mediatek: clk-mux: Support custom parent indices for muxes
  clk: mediatek: mt8195-topckgen: Refactor parents for top_dp/edp muxes

 drivers/clk/mediatek/clk-mt8195-topckgen.c | 22 +++++++----
 drivers/clk/mediatek/clk-mux.c             | 14 +++++++
 drivers/clk/mediatek/clk-mux.h             | 43 ++++++++++++++++++++--
 3 files changed, 67 insertions(+), 12 deletions(-)

-- 
2.40.1

