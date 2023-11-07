Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7413C7E3DB5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbjKGMaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbjKGM3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:29:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F66D4C3F;
        Tue,  7 Nov 2023 04:13:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E2EC433C9;
        Tue,  7 Nov 2023 12:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359189;
        bh=wYqQ/g7P5oblTakKY84QJvuC5vKp9a9P74NqFJyA0KM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LjdEXwnvJQ22ACmuPQSe3OMC6nc0OZq4l7r6Y26jUBT9AsY5YUvanPR/5s/AK0w5o
         o2pljV5Ac/LBaxS7JN9WrTJ7ogx9MbFZ1VcZa2lkRrcLGpnwcNtBczz7JvAEYZITzJ
         a2fK0lo+kYJYeerKXjh0cuEkSEuPcJMYavJ8NvdzsohIxqxpICnH5YKhzxU75mTImM
         hUAS9xbsqX9OXuvpazbRSlXicsAhKNLvVe/AP/Ad0afYnqG6tUjbj3zUf6Ywni6CnY
         aIYPq6mF9tc7EC/sbgNVvTHyjM7qIwTZZGMm4WXUFC9XiUGJmfi8/AtE2E0tYSIZqo
         tU6JggiaSy1kg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, kuba@kernel.org,
        pabeni@redhat.com, dsahern@kernel.org, kuniyu@amazon.com,
        wuyun.abel@bytedance.com, leitao@debian.org,
        alexander@mihalicyn.com, dhowells@redhat.com,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 6/9] net: annotate data-races around sk->sk_dst_pending_confirm
Date:   Tue,  7 Nov 2023 07:12:49 -0500
Message-ID: <20231107121256.3758858-6-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107121256.3758858-1-sashal@kernel.org>
References: <20231107121256.3758858-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.259
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit eb44ad4e635132754bfbcb18103f1dcb7058aedd ]

This field can be read or written without socket lock being held.

Add annotations to avoid load-store tearing.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/sock.h    | 6 +++---
 net/core/sock.c       | 2 +-
 net/ipv4/tcp_output.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index b021c8912e2cf..5293f2b65fb55 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1941,7 +1941,7 @@ static inline void dst_negative_advice(struct sock *sk)
 		if (ndst != dst) {
 			rcu_assign_pointer(sk->sk_dst_cache, ndst);
 			sk_tx_queue_clear(sk);
-			sk->sk_dst_pending_confirm = 0;
+			WRITE_ONCE(sk->sk_dst_pending_confirm, 0);
 		}
 	}
 }
@@ -1952,7 +1952,7 @@ __sk_dst_set(struct sock *sk, struct dst_entry *dst)
 	struct dst_entry *old_dst;
 
 	sk_tx_queue_clear(sk);
-	sk->sk_dst_pending_confirm = 0;
+	WRITE_ONCE(sk->sk_dst_pending_confirm, 0);
 	old_dst = rcu_dereference_protected(sk->sk_dst_cache,
 					    lockdep_sock_is_held(sk));
 	rcu_assign_pointer(sk->sk_dst_cache, dst);
@@ -1965,7 +1965,7 @@ sk_dst_set(struct sock *sk, struct dst_entry *dst)
 	struct dst_entry *old_dst;
 
 	sk_tx_queue_clear(sk);
-	sk->sk_dst_pending_confirm = 0;
+	WRITE_ONCE(sk->sk_dst_pending_confirm, 0);
 	old_dst = xchg((__force struct dst_entry **)&sk->sk_dst_cache, dst);
 	dst_release(old_dst);
 }
diff --git a/net/core/sock.c b/net/core/sock.c
index 9979cd602dfac..2c3c5df139345 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -545,7 +545,7 @@ struct dst_entry *__sk_dst_check(struct sock *sk, u32 cookie)
 
 	if (dst && dst->obsolete && dst->ops->check(dst, cookie) == NULL) {
 		sk_tx_queue_clear(sk);
-		sk->sk_dst_pending_confirm = 0;
+		WRITE_ONCE(sk->sk_dst_pending_confirm, 0);
 		RCU_INIT_POINTER(sk->sk_dst_cache, NULL);
 		dst_release(dst);
 		return NULL;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 16e0249b11f6c..97bee820799ee 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1103,7 +1103,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 	skb_set_hash_from_sk(skb, sk);
 	refcount_add(skb->truesize, &sk->sk_wmem_alloc);
 
-	skb_set_dst_pending_confirm(skb, sk->sk_dst_pending_confirm);
+	skb_set_dst_pending_confirm(skb, READ_ONCE(sk->sk_dst_pending_confirm));
 
 	/* Build TCP header and checksum it. */
 	th = (struct tcphdr *)skb->data;
-- 
2.42.0

