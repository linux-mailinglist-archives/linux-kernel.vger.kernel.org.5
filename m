Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B617D374F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 14:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjJWM6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 08:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjJWM6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 08:58:11 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5942310B
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 05:57:47 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6b5e6301a19so3099849b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 05:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698065867; x=1698670667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yCAXAY3fgSa7Kb0MKqcgqBNDm1vRIcXYYGEzF/D8jjI=;
        b=cn5eYQgoZwYoVrloc6pgtjiTXhKXt/b4gJTG6YWyaYjCPEW3JeXcGuvbt084Jxeb8h
         M+fOAzw6Am89vWd0VishxaqzzqqQYCtSWHOWE9JwE6dow6D0jDl/cKXdIFyf1YY2Lz24
         btW++4KfL4GQEAfrzygkr95BTn5LC3DRnxeUiJMPYkRUvjvC8wnMwMFSX1COCuK871Ph
         s5LV2/rBbujfR63tRGVEI945BKdm9foz4/4671cI1mkaYN2I34wUBTDUNVpl887O2Ss8
         bEcVZnyVRr0ST7K84/FtplkgNkqceuDMlL/2mTwgfsCKzdmWBD2AZqxpEN9Ptpb2Y8dW
         nYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698065867; x=1698670667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yCAXAY3fgSa7Kb0MKqcgqBNDm1vRIcXYYGEzF/D8jjI=;
        b=xM9usIiEYyWQQJw7Wq63KN4Biy0hiZ33hBrWMjbKANpzaFBj8rRQzgbfHBvCUOjdLT
         MJRNvjWEBauva+6nv07lbTNjTHhFFwF1aEdzOhnZesSaxg3GPQgu2wgbqhfukwNPv3Pz
         3IiQd9ACjmvJt7QlLV/hWA37QSBDQAuqd42LAKvB9USZAhasy5/mTh90Xvm35Q3Hi7Q0
         Vxqq5/spZcfS9V181SCvUXzshWVVtp+F2kx+LqHICJkWssjIWb1aqPqrtd3+YTMTbYhK
         GqxkFhwWSwgQNJNJ+QIvTC4VmpkMVHysm0EK+QVRYKcCeB7qCkV6ghevgsPdwC5x7Is/
         J/uQ==
X-Gm-Message-State: AOJu0Yyjinmb+p2IszHC7Rw4sc0FkW7pZxgJkCzoskGJ4/BdjPzASBDH
        jCUHdBYBue6xyeAifs6vMWGGcw==
X-Google-Smtp-Source: AGHT+IFf6zV09p7t/ZyPlfIP759xrLQulyHUf1/ol6SF33PPdLltGWgp7s08x8wNXn7uL1UWu0qZGQ==
X-Received: by 2002:a05:6a20:6a06:b0:17e:87c1:7971 with SMTP id p6-20020a056a206a0600b0017e87c17971mr434493pzk.46.1698065866765;
        Mon, 23 Oct 2023 05:57:46 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([240e:6b1:c0:120::2:3])
        by smtp.gmail.com with ESMTPSA id k28-20020aa79d1c000000b006bde2480806sm6056588pfp.47.2023.10.23.05.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 05:57:46 -0700 (PDT)
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
Subject: [PATCH v4 net-next] xsk: avoid starving the xsk further down the list
Date:   Mon, 23 Oct 2023 20:57:31 +0800
Message-Id: <20231023125732.82261-1-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
increased latency, and jitter. To address this problem, we introduce
a new variable called tx_budget_spent, which limits each xsk to transmit
a maximum of MAX_PER_SOCKET_BUDGET tx descriptors. This allocation ensures
equitable opportunities for subsequent xsk sockets to send tx descriptors.
The value of MAX_PER_SOCKET_BUDGET is set to 32.

Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
---
 include/net/xdp_sock.h |  7 +++++++
 net/xdp/xsk.c          | 18 ++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 69b472604b86..de6819e50d54 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -63,6 +63,13 @@ struct xdp_sock {
 
 	struct xsk_queue *tx ____cacheline_aligned_in_smp;
 	struct list_head tx_list;
+	/* record the number of tx descriptors sent by this xsk and
+	 * when it exceeds MAX_PER_SOCKET_BUDGET, an opportunity needs
+	 * to be given to other xsks for sending tx descriptors, thereby
+	 * preventing other XSKs from being starved.
+	 */
+	u32 tx_budget_spent;
+
 	/* Protects generic receive. */
 	spinlock_t rx_lock;
 
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f5e96e0d6e01..65c32b85c326 100644
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
+	bool budget_exhausted = false;
 	struct xdp_sock *xs;
 
 	rcu_read_lock();
+again:
 	list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
+		if (xs->tx_budget_spent >= MAX_PER_SOCKET_BUDGET) {
+			budget_exhausted = true;
+			continue;
+		}
+
 		if (!xskq_cons_peek_desc(xs->tx, desc, pool)) {
 			if (xskq_has_descs(xs->tx))
 				xskq_cons_release(xs->tx);
 			continue;
 		}
 
+		xs->tx_budget_spent++;
+
 		/* This is the backpressure mechanism for the Tx path.
 		 * Reserve space in the completion queue and only proceed
 		 * if there is space in it. This avoids having to implement
@@ -436,6 +446,14 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc)
 		return true;
 	}
 
+	if (budget_exhausted) {
+		list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list)
+			xs->tx_budget_spent = 0;
+
+		budget_exhausted = false;
+		goto again;
+	}
+
 out:
 	rcu_read_unlock();
 	return false;
-- 
2.20.1

