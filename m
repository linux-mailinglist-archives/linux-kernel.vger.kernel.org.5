Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C90754028
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbjGNRKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbjGNRKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:10:23 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C941BC9;
        Fri, 14 Jul 2023 10:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689354622; x=1720890622;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XZpRhN5m0OTZtOWoFL5SLkIK4oZaLvIX3WG/f+ZAB9U=;
  b=P7kdJD9NuM6vsZBo2AT64xduUkNiQBFt9zQ9OD+C+qj2bX8BLYDl8mKl
   8DUPvI7QP6GwNua4VbJRgi01NTaS0rSOvf0+48Y8a2qa95lLaZ+1ffA33
   ZYVRX3ajNi/W+mBMsMNvGDp2byCq0FMvmaUYHVBSWJ6LFsnisiIz5rUKC
   XF2M4RgrJie0cTxlSdUwexEadoyr7GuSUNAQ0P3JizK5FxhE7Dtdoadnt
   /ier4t25O0Ai8ZENWnc+bWhAt30rXvQpUXl+dBT/K4FTBkLg5DfZwpRJh
   DFRop6VQ5fRW8e4JQR37G9VeMGbYgA1eeVny5t5LMQwVTmMH9xq1iBDoZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="451891815"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="451891815"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 10:10:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="787906972"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="787906972"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jul 2023 10:10:18 -0700
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
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC net-next v2 0/7] net: page_pool: a couple of assorted optimizations
Date:   Fri, 14 Jul 2023 19:08:43 +0200
Message-ID: <20230714170853.866018-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's spin-off of the IAVF PP series[0], with 1 compile-time and several
runtime (hotpath) optimizations. They're based and tested on top of the
hybrid PP allocation series[1], but don't require it to work and are
in general independent of it and each other.

Per-patch breakdown:
 #1:   Already was on the lists, but this time it's done the other way,
       the one that Alex Duyck proposed during the review of the previous
       series. Slightly reduce the amount of C preprocessing by stopping
       including <net/page_pool.h> to <linux/skbuff.h> (which is included
       in half of the kernel sources). Especially useful with the
       abovementioned series applied, as it makes page_pool.h heavier;
 #2:   New. Group frag_* fields of &page_pool together to reduce cache
       misses;
 #3-4: New, prereqs to #5. Free 4 bytes in &page_pool_params and combine it
       with the already existing hole to get a free slot in the same CL
       where the params are inside &page_pool. Use it to store the internal
       PP flags in opposite to the driver-set ones;
 #5:   Don't call to DMA sync externals when they won't do anything anyway
       by doing some heuristics a bit earlier (when allocating a new page).
       Also was on the lists;
 #6-7: New. In addition to recycling skb PP pages directly when @napi_safe
       is set, check for the context we're in and always try to recycle
       directly when in softirq (on the same CPU where the consumer runs).
       This allows us to use direct recycling anytime we're inside a NAPI
       polling loop or GRO stuff going right after it, covering way more
       cases than it does right now.

(complete tree with [1] + this + [0] is available here: [2])

[0] https://lore.kernel.org/netdev/20230530150035.1943669-1-aleksander.lobakin@intel.com
[1] https://lore.kernel.org/netdev/20230629120226.14854-1-linyunsheng@huawei.com
[2] https://github.com/alobakin/linux/commits/iavf-pp-frag

Alexander Lobakin (7):
  net: skbuff: don't include <net/page_pool.h> to <linux/skbuff.h>
  net: page_pool: place frag_* fields in one cacheline
  net: page_pool: shrink &page_pool_params a tiny bit
  net: page_pool: don't use driver-set flags field directly
  net: page_pool: avoid calling no-op externals when possible
  net: skbuff: avoid accessing page_pool if !napi_safe when returning
    page
  net: skbuff: always try to recycle PP pages directly when in softirq

 drivers/net/ethernet/engleder/tsnep_main.c    |  1 +
 drivers/net/ethernet/freescale/fec_main.c     |  1 +
 .../marvell/octeontx2/nic/otx2_common.c       |  1 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  1 +
 .../ethernet/mellanox/mlx5/core/en/params.c   |  1 +
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  1 +
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 include/linux/skbuff.h                        |  3 +-
 include/net/page_pool.h                       | 23 +++---
 net/core/page_pool.c                          | 70 +++++--------------
 net/core/skbuff.c                             | 41 +++++++++++
 11 files changed, 83 insertions(+), 61 deletions(-)

---
From RFC v1[3]:
* #1: move the entire function to skbuff.c, don't try to split it (Alex);
* #2-4: new;
* #5: use internal flags field added in #4 and don't modify driver-defined
  structure (Alex, Jakub);
* #6: new;
* drop "add new NAPI state" as a redundant complication;
* #7: replace the check for the new NAPI state to just in_softirq(), should
  be fine (Jakub).

[3] https://lore.kernel.org/netdev/20230629152305.905962-1-aleksander.lobakin@intel.com
-- 
2.41.0

