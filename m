Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE917568F0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjGQQSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjGQQSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:18:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B7510D9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:18:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1B116114F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:18:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456CCC433C7;
        Mon, 17 Jul 2023 16:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689610684;
        bh=2JnoWmK4iiKhwvm4zZER4WLqRTh1WYZ3pksnmGmNMF0=;
        h=From:To:Cc:Subject:Date:From;
        b=JEd/NWkpgNyU1zp8QYb+T90jg3gHO5xywy6EXUiluLzC3z3JEpGFFvW03J6OifvvH
         ckFdGvk6CnHo/egSHVgu4wdfuvg8aksVpFMOBEL/BRsEeJjOozRk5eETmUDrYVKgdB
         c2JZezHUa/HkSrAOtKWckhLCa6kTj7qANsfMwBdMY/gaYJ2Sjt4UbkCJFs68nySI9f
         x9RgXh790tAp8K7l8p3HGYJGvnZyo7N0ip7sc1gq9xw+PY1VlN5ndTCiRc0wsJqG5z
         xAtk51Q6KksvJp/WBf7cZcqTKW8Omr5KMjguZESqxgtmpkQoBUbi23cd+7qMGDiED2
         J4VBeQuwBWleA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH net-next v5 0/2] net: stmmac: improve driver statistics
Date:   Tue, 18 Jul 2023 00:06:28 +0800
Message-Id: <20230717160630.1892-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

improve the stmmac driver statistics:

1. don't clear network driver statistics in .ndo_close() and
.ndo_open() cycle
2. avoid some network driver statistics overflow on 32 bit platforms
3. use per-queue statistics where necessary to remove frequent
cacheline ping pongs.

NOTE: v1 and v2 are back ported from an internal LTS tree, I made
some mistakes when backporting and squashing. Now, net-next + v3
has been well tested with 'ethtool -s' and 'ip -s link show'.

Since v4:
  - rebased on the latest net-next

Since v3:
  - coding style pointed out by Simon, I.E reverse xmas tree for local
    variable declarations and so on.
  - put the counters in queue structs, I.E per-queue rather than per-cpu
  - use _irqsave() variant where necessary.

Since v2:
  - fix ethtool .get_sset_count, .get_strings and per queue stats
    couting.
  - fix .ndo_get_stats64 only counts the last cpu's pcpu stats.
  - fix typo: s/iff/if in commit msg.
  - remove unnecessary if statement brackets since we have removed
    one LoC.

Since v1:
  - rebase on net-next
  - fold two original patches into one patch
  - fix issues found by lkp
  - update commit msg


Jisheng Zhang (2):
  net: stmmac: don't clear network statistics in .ndo_open()
  net: stmmac: use per-queue 64 bit statistics where necessary

 drivers/net/ethernet/stmicro/stmmac/common.h  |  39 ++--
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  12 +-
 .../ethernet/stmicro/stmmac/dwmac100_dma.c    |   7 +-
 .../ethernet/stmicro/stmmac/dwmac4_descs.c    |  16 +-
 .../net/ethernet/stmicro/stmmac/dwmac4_lib.c  |  15 +-
 .../net/ethernet/stmicro/stmmac/dwmac_lib.c   |  12 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_descs.c  |   6 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |  14 +-
 .../net/ethernet/stmicro/stmmac/enh_desc.c    |  20 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  12 +-
 .../net/ethernet/stmicro/stmmac/norm_desc.c   |  15 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |   2 +
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  | 123 ++++++++---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 206 ++++++++++++++----
 14 files changed, 337 insertions(+), 162 deletions(-)

-- 
2.40.0

