Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026C2770776
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 20:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjHDSGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 14:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjHDSGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 14:06:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E60146A8;
        Fri,  4 Aug 2023 11:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691172365; x=1722708365;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZZ1ynOM1qw59AhWSKo38/7Q9WKopGYLFnnfOdgzgvX8=;
  b=IISiYXzkVZrQf0SRKmbCspt1nUwSyZ3Y7GMam9iMxY0TyglNwojudEss
   AGrf3KHNqgjwru0ZuzULK5AmT9U6sMRKl/wkTcqMY3egWQnztaP3pzdZ6
   ORa0W2Xud0Qn1SHSXk22vDmyd2+9O99iFgh7X4OgijDsA1G8LCqd3hKiv
   jHuEzXn26gkQ8+sy2jp6ifiSvBbbaGdc3Dbi+6eOK/KAoRALRlrE0k3P9
   CMG9MYHVPydLUhNS5/ff+PL4MQeqoh6eMl+C2zQHpnwVuG6ocJLHtNudj
   +8Sk+yEDkgaoFlHdK7/9YYBNwyfhV5I6atxTxcRk3R8x9MO6giPiH016I
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="434061579"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="434061579"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 11:06:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="759673568"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="759673568"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orsmga008.jf.intel.com with ESMTP; 04 Aug 2023 11:06:01 -0700
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 0/6] page_pool: a couple of assorted optimizations
Date:   Fri,  4 Aug 2023 20:05:23 +0200
Message-ID: <20230804180529.2483231-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That initially was a spin-off of the IAVF PP series[0], but has grown
(and shrunk) since then a bunch. In fact, it consists of three
semi-independent blocks:

* #1-2: Compile-time optimization. Split page_pool.h into 2 headers to
  not overbloat the consumers not needing complex inline helpers and
  then stop including it in skbuff.h at all. The first patch is also
  prereq for the whole series.
* #3: Improve cacheline locality for users of the Page Pool frag API.
* #4-6: Use direct cache recycling more aggressively, when it is safe
  obviously. In addition, make sure nobody wants to use Page Pool API
  with disabled interrupts.

Patches #1 and #5 are authored by Yunsheng and Jakub respectively, with
small modifications from my side as per ML discussions.
For the perf numbers for #3-6, please see individual commit messages.

Also available on my GH with many more Page Pool goodies[1].

[0] https://lore.kernel.org/netdev/20230530150035.1943669-1-aleksander.lobakin@intel.com
[1] https://github.com/alobakin/linux/commits/iavf-pp-frag

Alexander Lobakin (4):
  net: skbuff: don't include <net/page_pool/types.h> to <linux/skbuff.h>
  page_pool: place frag_* fields in one cacheline
  net: skbuff: avoid accessing page_pool if !napi_safe when returning
    page
  net: skbuff: always try to recycle PP pages directly when in softirq

Jakub Kicinski (1):
  page_pool: add a lockdep check for recycling in hardirq

Yunsheng Lin (1):
  page_pool: split types and declarations from page_pool.h

 MAINTAINERS                                   |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |   2 +-
 drivers/net/ethernet/engleder/tsnep_main.c    |   1 +
 drivers/net/ethernet/freescale/fec_main.c     |   1 +
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |   1 +
 .../net/ethernet/hisilicon/hns3/hns3_enet.h   |   2 +-
 drivers/net/ethernet/marvell/mvneta.c         |   2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h    |   2 +-
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |   1 +
 .../marvell/octeontx2/nic/otx2_common.c       |   1 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   1 +
 drivers/net/ethernet/mediatek/mtk_eth_soc.c   |   1 +
 drivers/net/ethernet/mediatek/mtk_eth_soc.h   |   2 +-
 .../ethernet/mellanox/mlx5/core/en/params.c   |   1 +
 .../net/ethernet/mellanox/mlx5/core/en/trap.c |   1 -
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |   1 +
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |   2 +-
 .../ethernet/mellanox/mlx5/core/en_stats.c    |   2 +-
 .../ethernet/microchip/lan966x/lan966x_fdma.c |   1 +
 .../ethernet/microchip/lan966x/lan966x_main.h |   2 +-
 drivers/net/ethernet/socionext/netsec.c       |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |   2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |   1 +
 drivers/net/ethernet/ti/cpsw.c                |   2 +-
 drivers/net/ethernet/ti/cpsw_new.c            |   2 +-
 drivers/net/ethernet/ti/cpsw_priv.c           |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |   2 +-
 drivers/net/veth.c                            |   2 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c |   1 -
 drivers/net/wireless/mediatek/mt76/mt76.h     |   1 +
 drivers/net/xen-netfront.c                    |   2 +-
 include/linux/lockdep.h                       |   7 +
 include/linux/skbuff.h                        |   5 +-
 .../net/{page_pool.h => page_pool/helpers.h}  | 242 +-----------------
 include/net/page_pool/types.h                 | 236 +++++++++++++++++
 include/trace/events/page_pool.h              |   2 +-
 net/bpf/test_run.c                            |   2 +-
 net/core/page_pool.c                          |  43 +---
 net/core/skbuff.c                             |  49 +++-
 net/core/xdp.c                                |   2 +-
 42 files changed, 335 insertions(+), 305 deletions(-)
 rename include/net/{page_pool.h => page_pool/helpers.h} (51%)
 create mode 100644 include/net/page_pool/types.h

---
From v3[2]:
* rebase again after the bpf-next merge ._.;
* #5: pick the Acked-by from Jesper.

From v2[3]:
* just rebase on top of Jakub's kdoc changes landed last minute.

From v1[4]:
* move the "avoid calling no-op DMA sync ops" piece out of the series --
  will join some other or transform into something else (Jakub et al.);
* #1: restore accidentally removed path in MAINTAINERS (Yunsheng);
* #1: prefer `include/net/page_pool/` over `include/net/page_pool/*` in
  MAINTAINERS (Yunsheng);
* #2: rename page_pool_return_skb_page() to napi_pp_put_page() -- the old
  name seems to not make any sense for some time already (Yunsheng);
* #2: guard napi_pp_put_page() with CONFIG_PAGE_POOL in skbuff.c (to not
  compile it when there are no users) (Yunsheng).

From RFC v2[5]:
* drop the dependency on the hybrid allocation series (and thus the
  "RFC" prefix) -- it wasn't a strict dep and it's not in the trees yet;
* add [slightly reworked] Yunsheng's patch which splits page_pool.h into
  2 headers -- merge conflict hell otherwise.
  Also fix a typo while nobody looks (Simon);
* #3 (former #2): word the commitmsg a bit better, mention the main
  reason for the change more clearly (Ilias);
* add Jakub's hardirq assertion as a prereq for the last patch;
* #9 (former #7): add comment mentioning that the hardirq case is not
  checked due to the assertion checking it later (yes, it is illegal to
  use Page Pool with the interrupts disabled or when in TH) (Jakub).

From RFC v1[6]:
* #1: move the entire function to skbuff.c, don't try to split it (Alex);
* #2-4: new;
* #5: use internal flags field added in #4 and don't modify driver-defined
  structure (Alex, Jakub);
* #6: new;
* drop "add new NAPI state" as a redundant complication;
* #7: replace the check for the new NAPI state to just in_softirq(), should
  be fine (Jakub).

[2] https://lore.kernel.org/netdev/20230803182038.2646541-1-aleksander.lobakin@intel.com
[3] https://lore.kernel.org/netdev/20230803164014.993838-1-aleksander.lobakin@intel.com
[4] https://lore.kernel.org/netdev/20230727144336.1646454-1-aleksander.lobakin@intel.com
[5] https://lore.kernel.org/netdev/20230714170853.866018-1-aleksander.lobakin@intel.com
[6] https://lore.kernel.org/netdev/20230629152305.905962-1-aleksander.lobakin@intel.com
-- 
2.41.0

