Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A5377379C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 05:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjHHDVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 23:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjHHDVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 23:21:14 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7DB10D2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 20:20:50 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bc63ef9959so19864395ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 20:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691464850; x=1692069650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhqzuKs8acODjWqieOr60TzQPrln+0aaO9utMxKEwXY=;
        b=OJL9LrbSgQt70QJMij8iZC+JU41pG03VeJ0y7Nl922F2ZaU7U87A5B753UGGc0Yzx1
         /bOWzzKWiz5MHCq3MgepwcOP88c3QaVKgVkTsFPHfIKsB1CIEy7ISR3PzFTQvfTVch3s
         WnjevnnH9SsiyAEF6GrygCCohR3vtxY6qtYmJVOnIJAzQC5P3SlBXIP0HPbiUcyU/Tpg
         WzO3Noh9RFrUXrGlfzBi0PbKEYMSibgslfmMf83UoYgMOmjvVh7T/nHKLh9NspmzZ0bp
         ZmzvtRNd6WNniQsh/hzTpgIkY/Il5uuKqN/T/P4pQ1UI1p7bI63YzkuOWTSh/Dn//l3M
         qjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691464850; x=1692069650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhqzuKs8acODjWqieOr60TzQPrln+0aaO9utMxKEwXY=;
        b=LtgxD1WjbXT1PaQt5uGg7O1Psggg9QbDwI8fZNx08fjEiggSK5l40v5uXaw5ZVHdzV
         i9nRv6HApq5kFj4fmk5mjLzSaYid4RYerLLVZDW2bE8uJ9+uV9KRvfCoFfErlpgsDPRI
         jHqznJmtLyG9BiPW0w7ansVbUeyP89dVVY+kUw/hW2JN1ETMM+zDuC4MjirR577wHJUh
         tNTP73suKGK9keKx5aGYGy5cZLOS+Rl0nrWmBqsyiCtNZoe6NcIirnD7WjJSjZRN1rMJ
         PxpDv2+w8n0uuRdxKrxNd8QcdfesJXattDnIQoSCHvftZn01s1hJhG8UB6Hj5LbOs+TC
         MLGA==
X-Gm-Message-State: AOJu0YzNzLuIzdseg3Twzz8qe3hkn5WparVl0jv0h12A178TIqdje2aE
        e5jb7jnr1JWMxt3IuAuXqWz5qA==
X-Google-Smtp-Source: AGHT+IFJntj41Gt0ECRGUl7vLwT94BPvXtio+ZQROoGCzVRtLpUoICA2rzvmhhrD1xkeCfFkMSjNtw==
X-Received: by 2002:a17:902:eccc:b0:1b8:1335:b775 with SMTP id a12-20020a170902eccc00b001b81335b775mr13965313plh.0.1691464850307;
        Mon, 07 Aug 2023 20:20:50 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2408:8656:30f8:e020::b])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c10d00b001b896686c78sm7675800pli.66.2023.08.07.20.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 20:20:49 -0700 (PDT)
From:   Albert Huang <huangjie.albert@bytedance.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     Albert Huang <huangjie.albert@bytedance.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Kees Cook <keescook@chromium.org>,
        Richard Gobert <richardbgobert@gmail.com>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Subject: [RFC v3 Optimizing veth xsk performance 4/9] xsk: add xsk_tx_completed_addr function
Date:   Tue,  8 Aug 2023 11:19:08 +0800
Message-Id: <20230808031913.46965-5-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230808031913.46965-1-huangjie.albert@bytedance.com>
References: <20230808031913.46965-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return desc to the cq by using the descriptor address.

Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
---
 include/net/xdp_sock_drv.h |  5 +++++
 net/xdp/xsk.c              |  6 ++++++
 net/xdp/xsk_queue.h        | 10 ++++++++++
 3 files changed, 21 insertions(+)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 1f6fc8c7a84c..de82c596e48f 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -15,6 +15,7 @@
 #ifdef CONFIG_XDP_SOCKETS
 
 void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries);
+void xsk_tx_completed_addr(struct xsk_buff_pool *pool, u64 addr);
 bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc);
 u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 max);
 void xsk_tx_release(struct xsk_buff_pool *pool);
@@ -188,6 +189,10 @@ static inline void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries)
 {
 }
 
+static inline void xsk_tx_completed_addr(struct xsk_buff_pool *pool, u64 addr)
+{
+}
+
 static inline bool xsk_tx_peek_desc(struct xsk_buff_pool *pool,
 				    struct xdp_desc *desc)
 {
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 4f1e0599146e..b2b8aa7b0bcf 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -396,6 +396,12 @@ void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries)
 }
 EXPORT_SYMBOL(xsk_tx_completed);
 
+void xsk_tx_completed_addr(struct xsk_buff_pool *pool, u64 addr)
+{
+	xskq_prod_submit_addr(pool->cq, addr);
+}
+EXPORT_SYMBOL(xsk_tx_completed_addr);
+
 void xsk_tx_release(struct xsk_buff_pool *pool)
 {
 	struct xdp_sock *xs;
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 13354a1e4280..3a5e26a81dc2 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -428,6 +428,16 @@ static inline void __xskq_prod_submit(struct xsk_queue *q, u32 idx)
 	smp_store_release(&q->ring->producer, idx); /* B, matches C */
 }
 
+static inline void xskq_prod_submit_addr(struct xsk_queue *q, u64 addr)
+{
+	struct xdp_umem_ring *ring = (struct xdp_umem_ring *)q->ring;
+	u32 idx = q->ring->producer;
+
+	ring->desc[idx++ & q->ring_mask] = addr;
+
+	__xskq_prod_submit(q, idx);
+}
+
 static inline void xskq_prod_submit(struct xsk_queue *q)
 {
 	__xskq_prod_submit(q, q->cached_prod);
-- 
2.20.1

