Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC48376EFBA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbjHCQkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbjHCQke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:40:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A2730D2;
        Thu,  3 Aug 2023 09:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691080832; x=1722616832;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j22spkz2bATHAhmdv4dTafnFwRCFnQH8T5EBXPqR8gk=;
  b=iZlEc06t4vejqRAUhhfourc2EN+rW/UdzVd98brrPQQmBWTuxqnavJF0
   mfN5J3/mabkv2M1ltr/736CjzI08K7DnEebaVyPtLp5OFfkYAPNzHES4/
   SqlTyF81VNcNlKI2pRSOoQVJv3wmBJZw95CFNUzq9OLU3eXqjIGKDMjkS
   OaqftFwB4n+5TSKep6uy8aQmIZ7d+G6wCpQf/o9ULD/c6caOQlEglt7Iv
   DOmf4tHEw2Pt5XpdeAuq+fdlmNsu/P1oggBnHSkB6nYlAxYmJ40G5DwyT
   HOcClvrXrVo78vZ+eyT0pLr93ESuYN+wL42YbRsEFS594By8d2NwabetT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="350229174"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="350229174"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 09:40:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="723268843"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="723268843"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orsmga007.jf.intel.com with ESMTP; 03 Aug 2023 09:40:28 -0700
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
Subject: [PATCH net-next v2 0/6] page_pool: a couple of assorted optimizations
Date:   Thu,  3 Aug 2023 18:40:08 +0200
Message-ID: <20230803164014.993838-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 include/net/page_pool/helpers.h               | 193 ++++++++++++++++
 .../net/{page_pool.h => page_pool/types.h}    | 209 +-----------------
 include/trace/events/page_pool.h              |   2 +-
 net/bpf/test_run.c                            |   2 +-
 net/core/page_pool.c                          |  43 +---
 net/core/skbuff.c                             |  49 +++-
 net/core/xdp.c                                |   2 +-
 42 files changed, 297 insertions(+), 267 deletions(-)
 create mode 100644 include/net/page_pool/helpers.h
 rename include/net/{page_pool.h => page_pool/types.h} (51%)

---
From v1[2]:
* move the "avoid calling no-op DMA sync ops" piece out of the series --
  will join some other or transform into something else (Jakub et al.);
* #1: restore accidentally removed path in MAINTAINERS (Yunsheng);
* #1: prefer `include/net/page_pool/` over `include/net/page_pool/*` in
  MAINTAINERS (Yunsheng);
* #2: rename page_pool_return_skb_page() to napi_pp_put_page() -- the old
  name seems to not make any sense for some time already (Yunsheng);
* #2: guard napi_pp_put_page() with CONFIG_PAGE_POOL in skbuff.c (to not
  compile it when there are no users) (Yunsheng);

From RFC v2[3]:
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
  use Page Pool with the interrupts disabled or when in TH) (Jakub);

From RFC v1[4]:
* #1: move the entire function to skbuff.c, don't try to split it (Alex);
* #2-4: new;
* #5: use internal flags field added in #4 and don't modify driver-defined
  structure (Alex, Jakub);
* #6: new;
* drop "add new NAPI state" as a redundant complication;
* #7: replace the check for the new NAPI state to just in_softirq(), should
  be fine (Jakub).

[2] https://lore.kernel.org/netdev/20230727144336.1646454-1-aleksander.lobakin@intel.com
[3] https://lore.kernel.org/netdev/20230714170853.866018-1-aleksander.lobakin@intel.com
[4] https://lore.kernel.org/netdev/20230629152305.905962-1-aleksander.lobakin@intel.com
-- 
2.41.0

