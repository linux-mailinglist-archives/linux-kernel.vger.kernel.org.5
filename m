Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1AE5805308
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442119AbjLELfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347034AbjLELey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:34:54 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E095BA0;
        Tue,  5 Dec 2023 03:34:53 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Skyyv1856zrVD8;
        Tue,  5 Dec 2023 19:31:03 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 19:34:49 +0800
From:   Yunsheng Lin <linyunsheng@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <bpf@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH net-next 0/6] remove page frag implementation in vhost_net
Date:   Tue, 5 Dec 2023 19:34:38 +0800
Message-ID: <20231205113444.63015-1-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there are three implementations for page frag:

1. mm/page_alloc.c: net stack seems to be using it in the
   rx part with 'struct page_frag_cache' and the main API
   being page_frag_alloc_align().
2. net/core/sock.c: net stack seems to be using it in the
   tx part with 'struct page_frag' and the main API being
   skb_page_frag_refill().
3. drivers/vhost/net.c: vhost seems to be using it to build
   xdp frame, and it's implementation seems to be a mix of
   the above two.

This patch tries to unfiy the page frag implementation a
little bit by unifying gfp bit for order 3 page allocation
and replacing page frag implementation in vhost.c with the
one in page_alloc.c.

After this patchset, we are not only able to unify the page
frag implementation a little, but also able to have about
0.5% performance boost testing by using the vhost_net_test
introduced in the last patch.

Before this patchset:
Performance counter stats for './vhost_net_test' (10 runs):

     305325.78 msec task-clock                       #    1.738 CPUs utilized               ( +-  0.12% )
       1048668      context-switches                 #    3.435 K/sec                       ( +-  0.00% )
            11      cpu-migrations                   #    0.036 /sec                        ( +- 17.64% )
            33      page-faults                      #    0.108 /sec                        ( +-  0.49% )
  244651819491      cycles                           #    0.801 GHz                         ( +-  0.43% )  (64)
   64714638024      stalled-cycles-frontend          #   26.45% frontend cycles idle        ( +-  2.19% )  (67)
   30774313491      stalled-cycles-backend           #   12.58% backend cycles idle         ( +-  7.68% )  (70)
  201749748680      instructions                     #    0.82  insn per cycle
                                              #    0.32  stalled cycles per insn     ( +-  0.41% )  (66.76%)
   65494787909      branches                         #  214.508 M/sec                       ( +-  0.35% )  (64)
    4284111313      branch-misses                    #    6.54% of all branches             ( +-  0.45% )  (66)

       175.699 +- 0.189 seconds time elapsed  ( +-  0.11% )


After this patchset:
Performance counter stats for './vhost_net_test' (10 runs):

     303974.38 msec task-clock                       #    1.739 CPUs utilized               ( +-  0.14% )
       1048807      context-switches                 #    3.450 K/sec                       ( +-  0.00% )
            14      cpu-migrations                   #    0.046 /sec                        ( +- 12.86% )
            33      page-faults                      #    0.109 /sec                        ( +-  0.46% )
  251289376347      cycles                           #    0.827 GHz                         ( +-  0.32% )  (60)
   67885175415      stalled-cycles-frontend          #   27.01% frontend cycles idle        ( +-  0.48% )  (63)
   27809282600      stalled-cycles-backend           #   11.07% backend cycles idle         ( +-  0.36% )  (71)
  195543234672      instructions                     #    0.78  insn per cycle
                                              #    0.35  stalled cycles per insn     ( +-  0.29% )  (69.04%)
   62423183552      branches                         #  205.357 M/sec                       ( +-  0.48% )  (67)
    4135666632      branch-misses                    #    6.63% of all branches             ( +-  0.63% )  (67)

       174.764 +- 0.214 seconds time elapsed  ( +-  0.12% )

Changelog:
V1: Fix some typo, drop RFC tag and rebase on latest net-next.

Yunsheng Lin (6):
  mm/page_alloc: modify page_frag_alloc_align() to accept align as an
    argument
  page_frag: unify gfp bit for order 3 page allocation
  mm/page_alloc: use initial zero offset for page_frag_alloc_align()
  vhost/net: remove vhost_net_page_frag_refill()
  net: introduce page_frag_cache_drain()
  tools: virtio: introduce vhost_net_test

 drivers/net/ethernet/google/gve/gve_main.c |  11 +-
 drivers/net/ethernet/mediatek/mtk_wed_wo.c |  17 +-
 drivers/nvme/host/tcp.c                    |   7 +-
 drivers/nvme/target/tcp.c                  |   4 +-
 drivers/vhost/net.c                        |  91 ++---
 include/linux/gfp.h                        |   6 +-
 include/linux/skbuff.h                     |  22 +-
 mm/page_alloc.c                            |  48 ++-
 net/core/skbuff.c                          |  14 +-
 net/core/sock.c                            |   2 +-
 tools/virtio/Makefile                      |   8 +-
 tools/virtio/vhost_net_test.c              | 441 +++++++++++++++++++++
 12 files changed, 524 insertions(+), 147 deletions(-)
 create mode 100644 tools/virtio/vhost_net_test.c

-- 
2.33.0

