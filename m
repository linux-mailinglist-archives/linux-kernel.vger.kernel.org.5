Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F4E76EBCB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbjHCOHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235534AbjHCOHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:07:01 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822751BE4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 07:05:57 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bbc06f830aso7390505ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 07:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691071557; x=1691676357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gL5Z8CGNWAetROxW2z+SYhypMB/ajEP4EJq25cVNZ/U=;
        b=bihjjANSY7lExRM+eNzd60fiHXxilGR3q6QxUzPHDL32kYYtKnJpLWNJk1NXvt6QQf
         1pz3H9+q910ZhOR8HFBpRcNh6COunDjRS0T8nQsdCCUXi2N66puUcGVJzjxIvoznbUzg
         ZjCXnAuf0z/AuAGOW696eb2lF2TDa7J1cKthkrLJXtaZhGUfcWxa618oDyWBfhFuQ9lf
         5ao7kmH4KaZB/dHyeGdbu9iYN+b2r8Ge/Ni/XjQi/VzdgQRyH83sYvUkGstzHgIyd4Ie
         bQlh8M3HEMPgB2jpqkCdeTNqEz1rbRxRaeNHUcqK58QOA8wadmleYL9CtxY2V08NMqCl
         dbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691071557; x=1691676357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gL5Z8CGNWAetROxW2z+SYhypMB/ajEP4EJq25cVNZ/U=;
        b=bTrTfnYa17CtQJd5+VD1GRemlNYRJVsqqq+1FihHpLfQA5Q3Zrq4y3N4hIwXNQnGFV
         4kJZmWriN+P0AyB0OLiFi2BGkhRYCXsKu1ohDPjREwA/xz8OdWCnBAV+BacwVtDkYNmg
         jZMkMNFf4QaLZYAPBp97Ykw8TVwz4bGq+Q46eZYFRqB1JlGLY91vfSuyfffub1Eyw+x2
         0JPMsk4J2aZY9ocBAYWlsYqAj0nt/N0fKudnbjuYqr0/soQ/K5V3kzSBFa0ic1XQhLOE
         17nQa29J4j+TkllkLRaVIjaeSO2x0Fv6d9jvm5cch2C5pqz0N4lEZbGKdF1fyq1DVbrS
         xA6Q==
X-Gm-Message-State: ABy/qLbEGhi3WJBY1eUaaiqtUxMMN+fBU7nY7Qgd3xu+kpoKmUVDiCJd
        Ij2ALJzljHZJf/kzFyHsT1hjzA==
X-Google-Smtp-Source: APBJJlGptWOnvE77XkL4RxuVOdLMENM3+cQfeJs7EjtuzM45C3B60yWS1RRYlzoWtX8oSq45CNynLA==
X-Received: by 2002:a17:902:d506:b0:1b8:c8bc:c81b with SMTP id b6-20020a170902d50600b001b8c8bcc81bmr23436241plg.21.1691071556771;
        Thu, 03 Aug 2023 07:05:56 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2001:c10:ff04:0:1000::8])
        by smtp.gmail.com with ESMTPSA id ji11-20020a170903324b00b001b8a897cd26sm14367485plb.195.2023.08.03.07.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 07:05:56 -0700 (PDT)
From:   "huangjie.albert" <huangjie.albert@bytedance.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     "huangjie.albert" <huangjie.albert@bytedance.com>,
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
        Menglong Dong <imagedong@tencent.com>,
        Richard Gobert <richardbgobert@gmail.com>,
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list),
        bpf@vger.kernel.org (open list:XDP (eXpress Data Path))
Subject: [RFC Optimizing veth xsk performance 04/10] xsk: add xsk_tx_completed_addr function
Date:   Thu,  3 Aug 2023 22:04:30 +0800
Message-Id: <20230803140441.53596-5-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230803140441.53596-1-huangjie.albert@bytedance.com>
References: <20230803140441.53596-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return desc to the cq by using the descriptor address.

Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
---
 include/net/xdp_sock_drv.h |  1 +
 net/xdp/xsk.c              |  6 ++++++
 net/xdp/xsk_queue.h        | 11 +++++++++++
 3 files changed, 18 insertions(+)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 1f6fc8c7a84c..5220454bff5c 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -15,6 +15,7 @@
 #ifdef CONFIG_XDP_SOCKETS
 
 void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries);
+void xsk_tx_completed_addr(struct xsk_buff_pool *pool, u64 addr);
 bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc);
 u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 max);
 void xsk_tx_release(struct xsk_buff_pool *pool);
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
index 13354a1e4280..a494d1dcb1c3 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -428,6 +428,17 @@ static inline void __xskq_prod_submit(struct xsk_queue *q, u32 idx)
 	smp_store_release(&q->ring->producer, idx); /* B, matches C */
 }
 
+
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

