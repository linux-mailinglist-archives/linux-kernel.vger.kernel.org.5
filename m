Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752417C9DA9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 05:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjJPDRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 23:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJPDRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 23:17:33 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D926DA
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 20:17:08 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c8a1541232so35263655ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 20:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697426228; x=1698031028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+gcDF6obS9msoNGbrvp8VjI3eEmOOKndQkCumFLGk4Q=;
        b=efevaxTDxwJGJGS0dUk31db53gixwaHeSqy55hTLRJd/aVWej4JZAd7FjlCe78XrUu
         KFbc9UKoSoKfH/+rgsc/4sg5jS2BqBL1boHp5L9b7SnrNH/K8bUJ25R+5y2BKQjW2Mmu
         5N83kD9Qxp5KzbvznX55REYGDQxRJKTzs28+EeGxqixG5yduhCmnGEZELYmhFoWpaUKJ
         IXWjyDEqI9Umt/4MWUSK2muG/M4v3WDI3HvB4lQiLoqvNC67LXsQ3RM0pEbQSzAY3kyh
         Q8rT53qDVNo/+HCx/me0NiOgSMGEib+ma27B9KxYXRC3wCrHT/+6liqO/WiPcH9JFex/
         Ue4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697426228; x=1698031028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+gcDF6obS9msoNGbrvp8VjI3eEmOOKndQkCumFLGk4Q=;
        b=onFnQCnATUMbNtUIQ+zzY7rgas3WGwTexQwsTWyFrYh7O6ZfvpGzbK0cUur96mUsZY
         gXrGiyA63iDm6ud4g7/rvvrX3t1QV05mwbpL3OZ8FFh1rq7lGbmeIpsvcyoUjgpsqjbm
         Bp4qujhYdAeiaANCoXW5w7mBK386juDog7dh+CDXDhoJ18VnL20w+KJrCfyoFfi3nAN+
         acUzAsDpyX0JDQyuZzcCLY4k/ccYPMEBkIBgBdiHUNFAjfGx+dIhXw4qTiOdN3bfjgTN
         AS008Chz57g6VU2jMxnqCLyghRpd9F5DLzdiPGoOurNw1TWDnnhJ2X6epAtlG+SYgKBY
         rMNw==
X-Gm-Message-State: AOJu0YzblCRrsQZK95K2wB4Wkwv0GTfDOxPMZrtJnCIeaccW+dUYixWi
        GLIy1Z8s7HrjZZXQPkdq1q+i9g==
X-Google-Smtp-Source: AGHT+IG/AkDpyZ/tVSGq9dCcSfxYTyeru3TiqUeRhv2rK+sA9A8t/AMd1s2NWxUK8WU13xEjJOxsmw==
X-Received: by 2002:a17:902:f14c:b0:1c9:e0f9:a668 with SMTP id d12-20020a170902f14c00b001c9e0f9a668mr8430661plb.18.1697426227817;
        Sun, 15 Oct 2023 20:17:07 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([203.208.189.8])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902934c00b001b9da42cd7dsm7320172plp.279.2023.10.15.20.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 20:17:07 -0700 (PDT)
From:   Albert Huang <huangjie.albert@bytedance.com>
To:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>
Cc:     Albert Huang <huangjie.albert@bytedance.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
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
Subject: [PATCH v2 net-next] xsk: Avoid starving xsk at the end of the list
Date:   Mon, 16 Oct 2023 11:16:48 +0800
Message-Id: <20231016031649.35088-1-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
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
a maximum of MAX_XSK_TX_BUDGET tx descriptors. This allocation ensures
equitable opportunities for subsequent xsk sockets to send tx descriptors.
The value of MAX_XSK_TX_BUDGET is temporarily set to 16.

Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
---
 include/net/xdp_sock.h |  6 ++++++
 net/xdp/xsk.c          | 18 ++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 69b472604b86..f617ff54e38c 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -44,6 +44,7 @@ struct xsk_map {
 	struct xdp_sock __rcu *xsk_map[];
 };
 
+#define MAX_XSK_TX_BUDGET 16
 struct xdp_sock {
 	/* struct sock must be the first member of struct xdp_sock */
 	struct sock sk;
@@ -63,6 +64,11 @@ struct xdp_sock {
 
 	struct xsk_queue *tx ____cacheline_aligned_in_smp;
 	struct list_head tx_list;
+	/* Record the actual number of times xsk has transmitted a tx
+	 * descriptor, with a maximum limit not exceeding MAX_XSK_TX_BUDGET
+	 */
+	u32 tx_budget_cache;
+
 	/* Protects generic receive. */
 	spinlock_t rx_lock;
 
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f5e96e0d6e01..087f2675333c 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -413,16 +413,25 @@ EXPORT_SYMBOL(xsk_tx_release);
 
 bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc)
 {
+	u32 xsk_full_count = 0;
 	struct xdp_sock *xs;
 
 	rcu_read_lock();
+again:
 	list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
+		if (xs->tx_budget_cache >= MAX_XSK_TX_BUDGET) {
+			xsk_full_count++;
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
@@ -436,6 +445,14 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc)
 		return true;
 	}
 
+	if (unlikely(xsk_full_count > 0)) {
+		list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
+			xs->tx_budget_cache = 0;
+		}
+		xsk_full_count = 0;
+		goto again;
+	}
+
 out:
 	rcu_read_unlock();
 	return false;
@@ -1230,6 +1247,7 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 	xs->zc = xs->umem->zc;
 	xs->sg = !!(xs->umem->flags & XDP_UMEM_SG_FLAG);
 	xs->queue_id = qid;
+	xs->tx_budget_cache = 0;
 	xp_add_xsk(xs->pool, xs);
 
 out_unlock:
-- 
2.20.1

