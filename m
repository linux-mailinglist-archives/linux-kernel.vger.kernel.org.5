Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853C07F7823
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345893AbjKXPt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345891AbjKXPtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:49:55 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143131B5;
        Fri, 24 Nov 2023 07:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700841002; x=1732377002;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QbtcaO740tBPAPpBK4rvmbroWz1PJY6JofPTWopFM0w=;
  b=dAUdFUGdA7WeYmHQwLQi9dR6HM4WGKGIZ2g95z20PiXP4c08x56kEl3p
   v61pD6WY/CHh5rjwN+jPHnJVLac+nHEQrvOQ5Moxd0OemOOiv9gIrVEr8
   S4PY6ivQWK27LeLa/BTfs5NX4OSpWc0xq16Ni5osGS7AvvnFdr9ZuhxrU
   C13v/iFBEltEEhofLOl6pEgtl1k/gTZopo5HDMo7iWhnXB47wmaKEumkS
   kF8dIkRqWQS8zFDvwSVcrX+ouKKNWerzhc7wlz5GQ8FGKPf7ifwIKLYkq
   Ce9JdCm6+HJo2vJJIPpYyc4I9qYFiF0ghBvcDVRHM6YzozspN3AUgOw9U
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="389592417"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="389592417"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 07:50:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="15659739"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa001.jf.intel.com with ESMTP; 24 Nov 2023 07:49:57 -0800
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        David Christensen <drc@linux.vnet.ibm.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 00/14] net: intel: start The Great Code Dedup + Page Pool for iavf
Date:   Fri, 24 Nov 2023 16:47:18 +0100
Message-ID: <20231124154732.1623518-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a two-shot: introduce Intel Ethernet common library (libie) and
switch iavf to Page Pool. Details are in the commit messages; here's
a summary:

Not a secret there's a ton of code duplication between two and more Intel
ethernet modules. Before introducing new changes, which would need to be
copied over again, start decoupling the already existing duplicate
functionality into a new module, which will be shared between several
Intel Ethernet drivers. The first name that came to my mind was
"libie" -- "Intel Ethernet common library". Also this sounds like
"lovelie" (-> one word, no "lib I E" pls) and can be expanded as
"lib Internet Explorer" :P
The series is only the beginning. From now on, adding every new feature
or doing any good driver refactoring will remove much more lines than add
for quite some time. There's a basic roadmap with some deduplications
planned already, not speaking of that touching every line now asks:
"can I share this?". The final destination is very ambitious: have only
one unified driver for at least i40e, ice, iavf, and idpf with a struct
ops for each generation. That's never gonna happen, right? But you still
can at least try.
PP conversion for iavf lands within the same series as these two are tied
closely. libie will support Page Pool model only, so that a driver can't
use much of the lib until it's converted. iavf is only the example, the
rest will eventually be converted soon on a per-driver basis. That is
when it gets really interesting. Stay tech.

Alexander Lobakin (14):
  page_pool: make sure frag API fields don't span between cachelines
  page_pool: don't use driver-set flags field directly
  page_pool: avoid calling no-op externals when possible
  net: intel: introduce Intel Ethernet common library
  iavf: kill "legacy-rx" for good
  iavf: drop page splitting and recycling
  page_pool: constify some read-only function arguments
  page_pool: add DMA-sync-for-CPU inline helpers
  libie: add Rx buffer management (via Page Pool)
  iavf: pack iavf_ring more efficiently
  iavf: switch to Page Pool
  libie: add common queue stats
  libie: add per-queue Page Pool stats
  iavf: switch queue stats to libie

 MAINTAINERS                                   |   3 +-
 drivers/net/ethernet/intel/Kconfig            |   6 +
 drivers/net/ethernet/intel/Makefile           |   1 +
 drivers/net/ethernet/intel/i40e/i40e_common.c | 253 -------
 drivers/net/ethernet/intel/i40e/i40e_main.c   |   1 +
 .../net/ethernet/intel/i40e/i40e_prototype.h  |   7 -
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  72 +-
 drivers/net/ethernet/intel/i40e/i40e_type.h   |  88 ---
 drivers/net/ethernet/intel/iavf/iavf.h        |   2 +-
 drivers/net/ethernet/intel/iavf/iavf_common.c | 253 -------
 .../net/ethernet/intel/iavf/iavf_ethtool.c    | 241 +------
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  42 +-
 .../net/ethernet/intel/iavf/iavf_prototype.h  |   7 -
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   | 626 ++++--------------
 drivers/net/ethernet/intel/iavf/iavf_txrx.h   | 174 +----
 drivers/net/ethernet/intel/iavf/iavf_type.h   |  90 ---
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  17 +-
 .../net/ethernet/intel/ice/ice_lan_tx_rx.h    | 316 ---------
 drivers/net/ethernet/intel/ice/ice_main.c     |   1 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  74 +--
 drivers/net/ethernet/intel/libie/Kconfig      |   9 +
 drivers/net/ethernet/intel/libie/Makefile     |   7 +
 drivers/net/ethernet/intel/libie/internal.h   |  20 +
 drivers/net/ethernet/intel/libie/rx.c         | 188 ++++++
 drivers/net/ethernet/intel/libie/stats.c      | 190 ++++++
 include/linux/net/intel/libie/rx.h            | 263 ++++++++
 include/linux/net/intel/libie/stats.h         | 213 ++++++
 include/net/page_pool/helpers.h               | 115 +++-
 include/net/page_pool/types.h                 |  10 +-
 net/core/page_pool.c                          |  50 +-
 30 files changed, 1270 insertions(+), 2069 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/libie/Kconfig
 create mode 100644 drivers/net/ethernet/intel/libie/Makefile
 create mode 100644 drivers/net/ethernet/intel/libie/internal.h
 create mode 100644 drivers/net/ethernet/intel/libie/rx.c
 create mode 100644 drivers/net/ethernet/intel/libie/stats.c
 create mode 100644 include/linux/net/intel/libie/rx.h
 create mode 100644 include/linux/net/intel/libie/stats.h

---
Directly to net-next, has non-Intel code changes :p

From v4[0]:
* make use of Jakub's &page_pool_params split;
* #01: prevent frag fields from spanning into 2 cachelines after
  splitting &page_pool_params into fast and slow;
* #02-03: bring back the DMA sync shortcut, now as a per-page flag
  (me, Yunsheng);
* #04: let libie have its own Kconfig to stop further bloating of poor
  intel/Kconfig;
* #06: merge page split-reuse-recycle drop into one commit (Alex);
* #07: decouple constifying of several Page Pool function arguments
  into a separate commit, constify some more;
* #09: stop abusing internal PP fields in the driver code (Yunsheng);
* #09: calculate DMA sync size (::max_len) correctly: within one page,
  not one buffer (Yunsheng);
* #10: decouple rearranging &iavf_ring into separate commit, optimize
  it even more;
* #11: let the driver get back to the last descriptor to process after
  an skb allocation fail, don't drop it (Alex);
* #11: stop touching unrelated stuff like watchdog timeout etc. (Alex);
* fix "Return:" in the kdoc (now `W=12 C=1` is clean), misc typos.

From v3[1]:
* base on the latest net-next, update bloat-o-meter and perf stats;
* split generic PP optimizations into a separate series;
* drop "optimize hotpath a bunch" commit: a lot of [controversial]
  changes in one place, worth own series (Alex);
* 02: pick Rev-by (Alex);
* 03: move in-place recycling removal here from the dropped patch;
* 05: new, add libie Rx buffer API separatelly from IAVF changes;
* 05-06: use new "hybrid" allocation API from[2] to reduce memory usage
  when a page can fit more than 1 truesize (also asked by David);
* 06: merge with "always use order-0 page" commit to reduce diffs and
  simplify things (Alex);
* 09: fix page_alloc_fail counter.

From v2[3]:
* 0006: fix page_pool.h include in OcteonTX2 files (Jakub, Patchwork);
* no functional changes.

From v1[4]:
* 0006: new (me, Jakub);
* 0008: give the helpers more intuitive names (Jakub, Ilias);
*  -^-: also expand their kdoc a bit for the same reason;
*  -^-: fix kdoc copy-paste issue (Patchwork, Jakub);
* 0011: drop `inline` from C file (Patchwork, Jakub).

[0] https://lore.kernel.org/netdev/20230705155551.1317583-1-aleksander.lobakin@intel.com
[1] https://lore.kernel.org/netdev/20230530150035.1943669-1-aleksander.lobakin@intel.com
[2] https://lore.kernel.org/netdev/20230629120226.14854-1-linyunsheng@huawei.com
[3] https://lore.kernel.org/netdev/20230525125746.553874-1-aleksander.lobakin@intel.com
[4] https://lore.kernel.org/netdev/20230516161841.37138-1-aleksander.lobakin@intel.com

-- 
2.42.0

