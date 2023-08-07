Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEDC7723CE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbjHGMYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjHGMYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:24:07 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69C5126
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:23:43 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bbbbb77b38so26457045ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 05:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691411023; x=1692015823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foBrBXdOwtDKCq/cydfflnj4IbGd0R2nKQL39Yldago=;
        b=GnmYBiNpOf2ZKoNDZSeQ7wUkAcu+xKnDmwbHrK34Y7Ua2erUZDLoT8JJxk5fl8TGiB
         OoHuCCiTUoQ2wtEX7kztN7VB5MCCVQGv/wy5MNOVhivYLoAGl9+OeQx/Kw/+jDyh+IZk
         Xf34XG9jJ7w+QASgtv2fyUxkkyrMGyP6/I0vtcn4k1nIAQ0LStSdIMZUtZi7KPcerJJm
         ttyh2eo2Mr2IAudL5/+IPgdfq3sDTaPtRnlakn9I6901GtcSgiHbI4JxFOOvxNdmgD/v
         L3YtslWMidkywD9iDeTKaE3PmiyYyUFd8OWljozaVGFRKrWaaUvz+k4RQubOkOeKf9I2
         XGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691411023; x=1692015823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=foBrBXdOwtDKCq/cydfflnj4IbGd0R2nKQL39Yldago=;
        b=Dgb70wZRDcJSthp8EnCw4zhUIY8EyLKZSKA72cKhgoizC439D9ucyS8NB91wYdH+ps
         FCn19XdK0NuhnaRkqlrZK/xIS5wbYKraWrHcYLnTiQluefInD822zl3RA/IIbxMs/EQW
         Szyc9cqvRUoXZurj8YQNXmjH5KDaKjFvMlxYBzBvFptM+F8mjsEdUgTzdcF6ZxWF35wx
         XiByd9v877pZG2D/Xpy/dTUTM+CVuD4raw127V5kf3P0ePOARH228MHMYsnLdXqKjZvx
         4TJmE/+2jxHhfMbUu7xsZtWkNfQSViflgSAJ6stG+SczTWH93/D0WdOalAVINZQpIW8s
         h1Vg==
X-Gm-Message-State: AOJu0Yw/jTembmJUNG4KmyUlBqOh9R2CFLPtCxtuEoaimRHfRxSYd3Wa
        75EdeynOP8GRveOUJwb7VoY0QQ==
X-Google-Smtp-Source: AGHT+IHC5uCrys4OzS5COe5Y4fFinKxUPnbKTC2Fp/O9uWUOctQ/U/MnuwwTmOi5qU48U+ui/3Lqbg==
X-Received: by 2002:a17:903:18d:b0:1bc:5d0:e8e8 with SMTP id z13-20020a170903018d00b001bc05d0e8e8mr8191638plg.20.1691411023337;
        Mon, 07 Aug 2023 05:23:43 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2408:8656:30f8:e020::b])
        by smtp.gmail.com with ESMTPSA id u16-20020a170902e81000b001ab2b4105ddsm6766864plg.60.2023.08.07.05.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 05:23:42 -0700 (PDT)
From:   Albert Huang <huangjie.albert@bytedance.com>
Cc:     Albert Huang <huangjie.albert@bytedance.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org (open list:XDP SOCKETS (AF_XDP)),
        bpf@vger.kernel.org (open list:XDP SOCKETS (AF_XDP)),
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC v2 Optimizing veth xsk performance 4/9] xsk: add xsk_tx_completed_addr function
Date:   Mon,  7 Aug 2023 20:23:32 +0800
Message-Id: <20230807122332.85628-1-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230807120434.83644-1-huangjie.albert@bytedance.com>
References: <20230807120434.83644-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return desc to the cq by using the descriptor address.

Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
---
 include/net/xdp_sock_drv.h |  1 +
 net/xdp/xsk.c              |  6 ++++++
 net/xdp/xsk_queue.h        | 10 ++++++++++
 3 files changed, 17 insertions(+)

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

