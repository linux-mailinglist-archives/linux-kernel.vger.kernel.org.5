Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F277E9C9F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjKMNAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjKMNAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:00:41 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C515719B1;
        Mon, 13 Nov 2023 05:00:32 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4STTvQ5hHZzPnmK;
        Mon, 13 Nov 2023 20:56:18 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 13 Nov 2023 21:00:30 +0800
From:   Yunsheng Lin <linyunsheng@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH RFC 0/8] A possible proposal for intergating dmabuf to page pool
Date:   Mon, 13 Nov 2023 21:00:32 +0800
Message-ID: <20231113130041.58124-1-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is based on the [1] and [2], it is similar to
what patch [2] is doing in essence, the main differences is:
1. It reuses the 'struct page' to have more unified handling
   between normal page and devmem page for net stack.
2. It relies on the page->pp_frag_count to do reference counting
   instead of page->_refcount, in order to decouple the devmem
   page from mm subsystem.

As this patch is using normal memory page as devmem page as
prototyping, it is tested using simple iperf with some hack in
hns3 driver and in __skb_datagram_iter().

1. https://lkml.kernel.org/netdev/20230105214631.3939268-2-willy@infradead.org/
2. https://lore.kernel.org/all/20231106024413.2801438-1-almasrymina@google.com/

Jakub Kicinski (2):
  net: page_pool: factor out releasing DMA from releasing the page
  net: page_pool: create hooks for custom page providers

Mina Almasry (1):
  memory-provider: dmabuf devmem memory provider

Yunsheng Lin (5):
  skbuff: explicitize the semantics of skb_frag_fill_page_desc()
  skbuff: remove compound_head() related function calling
  skbuff: always try to do page pool frag reference counting
  net: hns3: temp hack for hns3 to use dmabuf memory provider
  net: temp hack for dmabuf page in __skb_datagram_iter()

 .../chelsio/inline_crypto/ch_ktls/chcr_ktls.c |   2 +-
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |   9 +-
 drivers/net/ethernet/sun/cassini.c            |   4 +-
 drivers/net/veth.c                            |   2 +-
 include/linux/skbuff.h                        |  26 ++-
 include/net/page_pool/types.h                 |  60 ++++++
 net/core/datagram.c                           |  10 +-
 net/core/page_pool.c                          | 197 ++++++++++++++++--
 net/core/skbuff.c                             |  10 +-
 net/tls/tls_device_fallback.c                 |   2 +-
 10 files changed, 282 insertions(+), 40 deletions(-)

-- 
2.33.0

