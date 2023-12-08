Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801978097D8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 01:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444211AbjLHAx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 19:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235655AbjLHAxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 19:53:07 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70362198B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 16:53:10 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db084a0a2e9so1907667276.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 16:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701996789; x=1702601589; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SdsQlA52rmqBL7OXbh7npWQi67Syf8S/UwksNo2UDhs=;
        b=q95z+wyk4H31xzCDd2pjmnTHHhFDhyJRKmdJ59urvQwlbJlWHRMLKw1kdiGNp8Dplp
         pdgZF2KZZf1mSoDEH9v+iSK7zkalHdgB7c8SDCI3LvY3RZP6jzvSnmteLY4DXOXGU4h+
         uMyyFz1mwB8H05lV/zqEauumoXhvaEWLEkVmsdICX7e2oHFSHySbsvXO3Z3pNjD5Uww3
         mYpRE2V/fkzJ/hnfYi2oWBnnPHNIfkGa8HxPhaJGbvFYZO5L8Dfc8O75E6yc+6yqwdH7
         iHGapPKuvH2M8YrXT9T/WA9TGGkxNvM7UFnIEwLgeEV1Ir4o1bpsh+nKq9geSemdJ/rz
         UR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701996789; x=1702601589;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SdsQlA52rmqBL7OXbh7npWQi67Syf8S/UwksNo2UDhs=;
        b=X+PZlSN2Nw0pyIRtOKuOse8oSyxxCBT51t4BCt8Kx/4isMPBZo75nCbsOIR23rB716
         5Op/pbgCUgddhG6y2v9YoPguW3Jg10R1MypYa/eNBHT9hmZPGP46HKSJ7HPqcueVimUG
         IHuLrQnD3aQaDE1DcTwJcakto9uems0DF2eSwi4QHWZnkP3waGzlcy/NhaE/TDU6fdY8
         5mZqQdFoVL8w17O+mWqGAvSLiEFsXXkYMNBxxvmFuJJ59m/VGM1xAPLxbjN4xOs/fXZS
         LGUOS50IcdtqitmvAk1WFjdf+BduvfHvkFRqPRXTndrSvZaQnnMUVd0VpK5STlt9j58q
         9ZNQ==
X-Gm-Message-State: AOJu0YxGw8UtIeFxiaDgoj4WUH/0IU8RNH16eaceLHadhNnohriZemTT
        OdrLcPFvubTbtnF8grOCXQyyTJS6jMddQENOZg==
X-Google-Smtp-Source: AGHT+IH/gfYr5EUfMzd/NX+8vXC/GoT0BalxzSTTls31g4lmQqKZy/8eIFEENuQk1BoM56tiXZ2me83KTuMQvZ3iJQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:f1cf:c733:235b:9fff])
 (user=almasrymina job=sendgmr) by 2002:a25:7690:0:b0:db4:6936:48b7 with SMTP
 id r138-20020a257690000000b00db4693648b7mr52142ybc.2.1701996789635; Thu, 07
 Dec 2023 16:53:09 -0800 (PST)
Date:   Thu,  7 Dec 2023 16:52:38 -0800
In-Reply-To: <20231208005250.2910004-1-almasrymina@google.com>
Mime-Version: 1.0
References: <20231208005250.2910004-1-almasrymina@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231208005250.2910004-8-almasrymina@google.com>
Subject: [net-next v1 07/16] netdev: netdevice devmem allocator
From:   Mina Almasry <almasrymina@google.com>
To:     Shailend Chand <shailend@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        bpf@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     Mina Almasry <almasrymina@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Harshitha Ramamurthy <hramamurthy@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement netdev devmem allocator. The allocator takes a given struct
netdev_dmabuf_binding as input and allocates page_pool_iov from that
binding.

The allocation simply delegates to the binding's genpool for the
allocation logic and wraps the returned memory region in a page_pool_iov
struct.

page_pool_iov are refcounted and are freed back to the binding when the
refcount drops to 0.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v1:
- Rename devmem -> dmabuf (David).

---
 include/net/devmem.h            | 13 ++++++++++++
 include/net/page_pool/helpers.h | 28 +++++++++++++++++++++++++
 net/core/dev.c                  | 37 ++++++++++++++++++++++++++++++++-
 3 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/include/net/devmem.h b/include/net/devmem.h
index 29ff125f9815..29bc337c7743 100644
--- a/include/net/devmem.h
+++ b/include/net/devmem.h
@@ -48,6 +48,9 @@ struct netdev_dmabuf_binding {
 };
 
 #ifdef CONFIG_DMA_SHARED_BUFFER
+struct page_pool_iov *
+netdev_alloc_dmabuf(struct netdev_dmabuf_binding *binding);
+void netdev_free_dmabuf(struct page_pool_iov *ppiov);
 void __netdev_dmabuf_binding_free(struct netdev_dmabuf_binding *binding);
 int netdev_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 		       struct netdev_dmabuf_binding **out);
@@ -55,6 +58,16 @@ void netdev_unbind_dmabuf(struct netdev_dmabuf_binding *binding);
 int netdev_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 				struct netdev_dmabuf_binding *binding);
 #else
+static inline struct page_pool_iov *
+netdev_alloc_dmabuf(struct netdev_dmabuf_binding *binding)
+{
+	return NULL;
+}
+
+static inline void netdev_free_dmabuf(struct page_pool_iov *ppiov)
+{
+}
+
 static inline void
 __netdev_dmabuf_binding_free(struct netdev_dmabuf_binding *binding)
 {
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 7dc65774cde5..8bfc2d43efd4 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -79,6 +79,34 @@ static inline u64 *page_pool_ethtool_stats_get(u64 *data, void *stats)
 }
 #endif
 
+/* page_pool_iov support */
+
+static inline struct dmabuf_genpool_chunk_owner *
+page_pool_iov_owner(const struct page_pool_iov *ppiov)
+{
+	return ppiov->owner;
+}
+
+static inline unsigned int page_pool_iov_idx(const struct page_pool_iov *ppiov)
+{
+	return ppiov - page_pool_iov_owner(ppiov)->ppiovs;
+}
+
+static inline dma_addr_t
+page_pool_iov_dma_addr(const struct page_pool_iov *ppiov)
+{
+	struct dmabuf_genpool_chunk_owner *owner = page_pool_iov_owner(ppiov);
+
+	return owner->base_dma_addr +
+	       ((dma_addr_t)page_pool_iov_idx(ppiov) << PAGE_SHIFT);
+}
+
+static inline struct netdev_dmabuf_binding *
+page_pool_iov_binding(const struct page_pool_iov *ppiov)
+{
+	return page_pool_iov_owner(ppiov)->binding;
+}
+
 /**
  * page_pool_dev_alloc_pages() - allocate a page.
  * @pool:	pool from which to allocate
diff --git a/net/core/dev.c b/net/core/dev.c
index b8c8be5a912e..30667e4c3b95 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -155,8 +155,8 @@
 #include <net/netdev_rx_queue.h>
 #include <linux/genalloc.h>
 #include <linux/dma-buf.h>
-#include <net/page_pool/types.h>
 #include <net/devmem.h>
+#include <net/page_pool/helpers.h>
 
 #include "dev.h"
 #include "net-sysfs.h"
@@ -2120,6 +2120,41 @@ static int netdev_restart_rx_queue(struct net_device *dev, int rxq_idx)
 	return err;
 }
 
+struct page_pool_iov *netdev_alloc_dmabuf(struct netdev_dmabuf_binding *binding)
+{
+	struct dmabuf_genpool_chunk_owner *owner;
+	struct page_pool_iov *ppiov;
+	unsigned long dma_addr;
+	ssize_t offset;
+	ssize_t index;
+
+	dma_addr = gen_pool_alloc_owner(binding->chunk_pool, PAGE_SIZE,
+					(void **)&owner);
+	if (!dma_addr)
+		return NULL;
+
+	offset = dma_addr - owner->base_dma_addr;
+	index = offset / PAGE_SIZE;
+	ppiov = &owner->ppiovs[index];
+
+	netdev_dmabuf_binding_get(binding);
+
+	return ppiov;
+}
+
+void netdev_free_dmabuf(struct page_pool_iov *ppiov)
+{
+	struct netdev_dmabuf_binding *binding = page_pool_iov_binding(ppiov);
+	unsigned long dma_addr = page_pool_iov_dma_addr(ppiov);
+
+	refcount_set(&ppiov->refcount, 1);
+
+	if (gen_pool_has_addr(binding->chunk_pool, dma_addr, PAGE_SIZE))
+		gen_pool_free(binding->chunk_pool, dma_addr, PAGE_SIZE);
+
+	netdev_dmabuf_binding_put(binding);
+}
+
 /* Protected by rtnl_lock() */
 static DEFINE_XARRAY_FLAGS(netdev_dmabuf_bindings, XA_FLAGS_ALLOC1);
 
-- 
2.43.0.472.g3155946c3a-goog

