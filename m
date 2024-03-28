Return-Path: <linux-kernel+bounces-122969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 454E3890085
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 017D029319E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7AB8174E;
	Thu, 28 Mar 2024 13:40:44 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ED739FC5;
	Thu, 28 Mar 2024 13:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711633243; cv=none; b=Qe/CxG35pRmglu3wDyCVbNpzFKklU5p3/ocWKSCU3d6NjSVW4VqeRb79kx/zyP2iMbiTIZgNLWu9ckf+ow1MzY0KgqauruvYnnEtpbP8JUSgBH/ETfOaGMRmAbfvF3mHNsyqxm1qJiRbQvHaSqeGkwPG2fn9UEiVgAzl2f0sD+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711633243; c=relaxed/simple;
	bh=y/oraJ5CGRMf0aDMagJKBOG+7nPO1Z4eZNfOqBzfZ8w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GlLbzqMjfKbRNaIdHAKZ5D9M1yQagQjOIJwDOXW73kOJGrtfcI0SRnJrxR6eKywCI4jaV9iKYNfSUOYssDUlGk1po/US95/LWxMH3ob3hA0Cx0erptXHYP2sPT0lHw/KJokGgmxoa7WRYiFV3SR7ve5viO2NV8t3AVDIYBnaShk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4V54Ng4jTvz1R88n;
	Thu, 28 Mar 2024 21:37:55 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 83CC11402CA;
	Thu, 28 Mar 2024 21:40:36 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 21:40:36 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<bpf@vger.kernel.org>
Subject: [PATCH RFC 00/10] First try to replace page_frag with page_frag_cache
Date: Thu, 28 Mar 2024 21:38:29 +0800
Message-ID: <20240328133839.13620-1-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)

After [1], Only there are two implementations for page frag:

1. mm/page_alloc.c: net stack seems to be using it in the
   rx part with 'struct page_frag_cache' and the main API
   being page_frag_alloc_align().
2. net/core/sock.c: net stack seems to be using it in the
   tx part with 'struct page_frag' and the main API being
   skb_page_frag_refill().

This patchset tries to unfiy the page frag implementation
by replacing page_frag with page_frag_cache for sk_page_frag()
first. And will try to replace the rest of page_frag in the
follow patchset.

After this patchset, we are not only able to unify the page
frag implementation a little, but seems able to have about
0.5% performance boost testing by using the vhost_net_test
introduced in [1] too.

Before this patch:
Performance counter stats for './vhost_net_test' (10 runs):

         603027.29 msec task-clock                       #    1.756 CPUs utilized               ( +-  0.04% )
           2097713      context-switches                 #    3.479 K/sec                       ( +-  0.00% )
               212      cpu-migrations                   #    0.352 /sec                        ( +-  4.72% )
                40      page-faults                      #    0.066 /sec                        ( +-  1.18% )
      467215266413      cycles                           #    0.775 GHz                         ( +-  0.12% )  (66.02%)
      131736729037      stalled-cycles-frontend          #   28.20% frontend cycles idle        ( +-  2.38% )  (64.34%)
       77728393294      stalled-cycles-backend           #   16.64% backend cycles idle         ( +-  3.98% )  (65.42%)
      345874254764      instructions                     #    0.74  insn per cycle
                                                  #    0.38  stalled cycles per insn     ( +-  0.75% )  (70.28%)
      105166217892      branches                         #  174.397 M/sec                       ( +-  0.65% )  (68.56%)
        9649321070      branch-misses                    #    9.18% of all branches             ( +-  0.69% )  (65.38%)

           343.376 +- 0.147 seconds time elapsed  ( +-  0.04% )


After this patch:
Performance counter stats for './vhost_net_test' (10 runs):

         598081.02 msec task-clock                       #    1.752 CPUs utilized               ( +-  0.11% )
           2097738      context-switches                 #    3.507 K/sec                       ( +-  0.00% )
               220      cpu-migrations                   #    0.368 /sec                        ( +-  6.58% )
                40      page-faults                      #    0.067 /sec                        ( +-  0.92% )
      469788205101      cycles                           #    0.785 GHz                         ( +-  0.27% )  (64.86%)
      137108509582      stalled-cycles-frontend          #   29.19% frontend cycles idle        ( +-  0.96% )  (63.62%)
       75499065401      stalled-cycles-backend           #   16.07% backend cycles idle         ( +-  1.04% )  (65.86%)
      345469451681      instructions                     #    0.74  insn per cycle
                                                  #    0.40  stalled cycles per insn     ( +-  0.37% )  (70.16%)
      102782224964      branches                         #  171.853 M/sec                       ( +-  0.62% )  (69.28%)
        9295357532      branch-misses                    #    9.04% of all branches             ( +-  1.08% )  (66.21%)

           341.466 +- 0.305 seconds time elapsed  ( +-  0.09% )

CC: Alexander Duyck <alexander.duyck@gmail.com>

1. https://lore.kernel.org/all/20240228093013.8263-1-linyunsheng@huawei.com/

Yunsheng Lin (10):
  mm: Move the page fragment allocator from page_alloc into its own file
  mm: page_frag: use initial zero offset for page_frag_alloc_align()
  mm: page_frag: change page_frag_alloc_* API to accept align param
  mm: page_frag: add '_va' suffix to page_frag API
  mm: page_frag: add two inline helper for page_frag API
  mm: page_frag: reuse MSB of 'size' field for pfmemalloc
  mm: page_frag: reuse existing bit field of 'va' for pagecnt_bias
  net: introduce the skb_copy_to_va_nocache() helper
  mm: page_frag: introduce prepare/commit API for page_frag
  net: replace page_frag with page_frag_cache

 drivers/net/ethernet/google/gve/gve_rx.c      |   4 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     |   2 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h     |   2 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |   2 +-
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |   4 +-
 .../marvell/octeontx2/nic/otx2_common.c       |   2 +-
 drivers/net/ethernet/mediatek/mtk_wed_wo.c    |   4 +-
 drivers/net/tun.c                             |  36 ++---
 drivers/nvme/host/tcp.c                       |   8 +-
 drivers/nvme/target/tcp.c                     |  22 +--
 drivers/vhost/net.c                           |   6 +-
 include/linux/gfp.h                           |  22 ---
 include/linux/mm_types.h                      |  18 ---
 include/linux/page_frag_cache.h               | 142 ++++++++++++++++
 include/linux/sched.h                         |   5 +-
 include/linux/skbuff.h                        |  15 +-
 include/net/sock.h                            |  22 ++-
 kernel/bpf/cpumap.c                           |   2 +-
 kernel/exit.c                                 |   3 +-
 kernel/fork.c                                 |   2 +-
 mm/Makefile                                   |   1 +
 mm/page_alloc.c                               | 136 ----------------
 mm/page_frag_alloc.c                          | 152 ++++++++++++++++++
 net/core/skbuff.c                             |  54 ++++---
 net/core/skmsg.c                              |  24 +--
 net/core/sock.c                               |  24 +--
 net/core/xdp.c                                |   2 +-
 net/ipv4/ip_output.c                          |  37 +++--
 net/ipv4/tcp.c                                |  33 ++--
 net/ipv4/tcp_output.c                         |  30 ++--
 net/ipv6/ip6_output.c                         |  37 +++--
 net/kcm/kcmsock.c                             |  28 ++--
 net/mptcp/protocol.c                          |  72 ++++++---
 net/rxrpc/txbuf.c                             |  16 +-
 net/sunrpc/svcsock.c                          |   4 +-
 net/tls/tls_device.c                          | 139 +++++++++-------
 36 files changed, 661 insertions(+), 451 deletions(-)
 create mode 100644 include/linux/page_frag_cache.h
 create mode 100644 mm/page_frag_alloc.c

-- 
2.33.0


