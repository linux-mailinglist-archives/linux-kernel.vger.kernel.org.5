Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E419F7D35D7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 13:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbjJWLxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 07:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjJWLxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 07:53:37 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6077E4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 04:53:12 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c9d922c039so25935465ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 04:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698061992; x=1698666792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5OpOO/ujxo7qV6VnFj/vbc7gRpnZ29/Hl135s51sMGA=;
        b=AgFW9mzkVt5FKvoQ/pxyV5mJZJjs+7GrsRwDsUEtNH4aHIjgwT2TP+eCfbdxkrK3mW
         I1NzBQImL3xztARwgZMBzJi4aiIjN+17FAndZVaDTHMwPvdBcg2M1Nz+N9e9j0gRJZIY
         NMeS8D/HbCjpDJA2jV3e8uk2Q5ZF9TZaxQ5j6ImFga90Bz9fvxdweQ3Zg4OWd6vVwFJV
         kb3OumdXJS5wl+tF5D4aHeSJWyvbjc+uOLBJpj2Sx0+2rscTdrjZArVyzxtiF44Pp54g
         oV3A5H/WoS4eAgmKV3qPzkKhv3pEeMPECvSP2EEZo+d+Qi4u8wIb1n/UbFsBFtC+5WDX
         4ibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698061992; x=1698666792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5OpOO/ujxo7qV6VnFj/vbc7gRpnZ29/Hl135s51sMGA=;
        b=l6fSsWqkmpny8yY2T28xeUrrwHTTQlenfSHP39QbHFiNBzeeLQnkw2qu1awv4sqjyd
         8mGKMfi6f4X7VXD/VttAoG7N8skquhl9qhJysL0ScKTsgipvUCpKd7ZHPH6oGPHIIcVl
         g3E3bURTkIY6jTke3tGuv9045EellfsjbA3FGl5Dy13Yvj3LxBTAozI6Uuo3Qfi3mdmN
         i7j2r0YGhWyDjTa7toZrbfdxXA8d/QAak1VmzhGjogZKlAxGZrm7Unr2uvJskWQp9QhC
         vR0PL30ILOhcsomJSMmFKFwIQ9eVOCBl62ftYUfGqYAG3dd6cp1LOecPhG53Ln9+CuS/
         LSzA==
X-Gm-Message-State: AOJu0YyZuYKbun9znMuhzJr+LKwZTbNZKc9UJLYzk/ftf7nX3I5oPS57
        vE+/uFos5qwtU2NUrkvMndCGYA==
X-Google-Smtp-Source: AGHT+IFSlvp9BLy+fu0YpJY2csGQHLq69ECo5byZ1gpHhXI2w9sJlTLTHPD+Z/0+59+tBVs/MvoO3Q==
X-Received: by 2002:a17:902:d506:b0:1ca:abe:a090 with SMTP id b6-20020a170902d50600b001ca0abea090mr9388853plg.62.1698061992110;
        Mon, 23 Oct 2023 04:53:12 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([240e:6b1:c0:120::2:3])
        by smtp.gmail.com with ESMTPSA id l20-20020a170903005400b001bba7aab822sm5835142pla.5.2023.10.23.04.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 04:53:11 -0700 (PDT)
From:   Albert Huang <huangjie.albert@bytedance.com>
To:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>
Cc:     Albert Huang <huangjie.albert@bytedance.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 net-next] xsk: avoid starving the xsk further down the list
Date:   Mon, 23 Oct 2023 19:52:54 +0800
Message-Id: <20231023115255.76934-1-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the previous implementation, when multiple xsk sockets were
associated with a single xsk_buff_pool, a situation could arise
where the xsk_tx_list maintained data at the front for one xsk
socket while starving the xsk sockets at the back of the list.
This could result in issues such as the inability to transmit packets,
increased latency, and jitter. To address this problem, we introduced
a new variable called tx_budget_cache, which limits each xsk to transmit
a maximum of MAX_PER_SOCKET_BUDGET tx descriptors. This allocation ensures
equitable opportunities for subsequent xsk sockets to send tx descriptors.
The value of MAX_PER_SOCKET_BUDGET is temporarily set to TX_BATCH_SIZE(32).

Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
---
 include/net/xdp_sock.h |  5 +++++
 net/xdp/xsk.c          | 19 +++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 69b472604b86..08cbdf6fca85 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -63,6 +63,11 @@ struct xdp_sock {
 
 	struct xsk_queue *tx ____cacheline_aligned_in_smp;
 	struct list_head tx_list;
+	/* Record the actual number of times xsk has transmitted a tx
+	 * descriptor, with a maximum limit not exceeding MAX_PER_SOCKET_BUDGET
+	 */
+	u32 tx_budget_cache;
+
 	/* Protects generic receive. */
 	spinlock_t rx_lock;
 
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f5e96e0d6e01..fd0d54b7c046 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -33,6 +33,7 @@
 #include "xsk.h"
 
 #define TX_BATCH_SIZE 32
+#define MAX_PER_SOCKET_BUDGET (TX_BATCH_SIZE)
 
 static DEFINE_PER_CPU(struct list_head, xskmap_flush_list);
 
@@ -413,16 +414,25 @@ EXPORT_SYMBOL(xsk_tx_release);
 
 bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc)
 {
+	bool xsk_cache_full = false;
 	struct xdp_sock *xs;
 
 	rcu_read_lock();
+again:
 	list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
+		if (xs->tx_budget_cache >= MAX_PER_SOCKET_BUDGET) {
+			xsk_cache_full = true;
+			continue;
+		}
+
 		if (!xskq_cons_peek_desc(xs->tx, desc, pool)) {
 			if (xskq_has_descs(xs->tx))
 				xskq_cons_release(xs->tx);
 			continue;
 		}
 
+		xs->tx_budget_cache++;
+
 		/* This is the backpressure mechanism for the Tx path.
 		 * Reserve space in the completion queue and only proceed
 		 * if there is space in it. This avoids having to implement
@@ -436,6 +446,14 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc)
 		return true;
 	}
 
+	if (xsk_cache_full) {
+		list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
+			xs->tx_budget_cache = 0;
+		}
+		xsk_cache_full = false;
+		goto again;
+	}
+
 out:
 	rcu_read_unlock();
 	return false;
@@ -1230,6 +1248,7 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 	xs->zc = xs->umem->zc;
 	xs->sg = !!(xs->umem->flags & XDP_UMEM_SG_FLAG);
 	xs->queue_id = qid;
+	xs->tx_budget_cache = 0;
 	xp_add_xsk(xs->pool, xs);
 
 out_unlock:
-- 
2.20.1

