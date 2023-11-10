Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A787D7E832E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345168AbjKJTw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346618AbjKJTwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:52:13 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F393959FF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 22:16:16 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6be1bc5aa1cso1746843b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 22:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1699596976; x=1700201776; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/UY2V4KB781XJBY0gcAuxuyVl/cjuGIjQ/iARGJ/tjI=;
        b=WB9W4QtN24qKq6I6EQamSBCq/cmDFN9aSGBJJjEiNO6o5/qSU7PGJ/K/TXJW+RxYz5
         fx7MdjB17tbvPKdXYgPM1t4fBWuMrjvWa18+w9iscQMKJiU+kwsrYO1gDl04UKdUhi+s
         Kr58ljBmQCAeLZZ/iv1RHMkoQbrr6ln7VAP3zTGQPZxGFnRNutEL1pT6sACwVLaghD1g
         6u/nyRBb2SsFJWi8WcW+hBoh/5FMKi8Nu0yuf55z43V/Xr3KU9Qe8MiQ7BvVO+Mvkvg7
         P0ewV90uBk3WMcc/pzOH4MJPIc5PmK5SN1dkluYQr8w6UYjymoZL1UMNheYfMhaQDi+5
         qrww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699596976; x=1700201776;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/UY2V4KB781XJBY0gcAuxuyVl/cjuGIjQ/iARGJ/tjI=;
        b=QzLkaBb/TPES1SNy+fXONCNekacgF7fMMld3YtOBP3R9FyKikwudWf2Gniqm1tL8Ou
         DoUxuMnGvkN5rIvFHt4g0ug8EldaQM4FmlXGOdHig5wKAHbOMR5eNH+GASjlEJmXHqEw
         MloX3Vu//DwYdquXwdIp2gp1mLTfVjZZuHgpkt+6o/AVXeccwy6TWIWoaeq74kyy8Pyv
         IKlWz8YbU0Ydo3sQUQVpe/BPDnx7v2i6lYWhnwBCEwcoZu29c2xQhNfsDYwZKX6Ph0u0
         gYTW3k1nUxAyHmEyTdGewiDVTxRBxu0clyEDUHfL1Ikp8hHq6iPVgcxczDPCeOh3I7z+
         N16A==
X-Gm-Message-State: AOJu0YzLCcklZGV58DywAHSgFtMLKSBcaDLHbK0C5i7l+DAAzWyfd2PE
        8fLo8CwEG1i31RW/4A/AvTHOqFXx27hd9ZU1czBWCg==
X-Google-Smtp-Source: AGHT+IGWU16myJ7R/xYuGXrXNuN5gAZCZelV+4O+aHR2KdVzrrm6cHrsV5Oc9A6wX98LyUQch0USsw==
X-Received: by 2002:ad4:4ea1:0:b0:66d:6af7:4571 with SMTP id ed1-20020ad44ea1000000b0066d6af74571mr8513666qvb.17.1699595366906;
        Thu, 09 Nov 2023 21:49:26 -0800 (PST)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id w9-20020ae9e509000000b00765ab6d3e81sm468753qkf.122.2023.11.09.21.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 21:49:26 -0800 (PST)
Date:   Thu, 9 Nov 2023 21:49:24 -0800
From:   Yan Zhai <yan@cloudflare.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Weongyo Jeong <weongyo.linux@gmail.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        David Ahern <dsahern@kernel.org>,
        Jesper Brouer <jesper@cloudflare.com>,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: [PATCH net-next] packet: add a generic drop reason for receive
Message-ID: <ZU3EZKQ3dyLE6T8z@debian.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit da37845fdce2 ("packet: uses kfree_skb() for errors.") switches
from consume_skb to kfree_skb to improve error handling. However, this
could bring a lot of noises when we monitor real packet drops in
kfree_skb[1], because in tpacket_rcv or packet_rcv only packet clones
can be freed, not actual packets.

Adding a generic drop reason to allow distinguish these "clone drops".

[1]: https://lore.kernel.org/netdev/CABWYdi00L+O30Q=Zah28QwZ_5RU-xcxLFUK2Zj08A8MrLk9jzg@mail.gmail.com/
Fixes: da37845fdce2 ("packet: uses kfree_skb() for errors.")
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 include/net/dropreason-core.h |  6 ++++++
 net/packet/af_packet.c        | 16 +++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 845dce805de7..6ff543fe8a8b 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -81,6 +81,7 @@
 	FN(IPV6_NDISC_NS_OTHERHOST)	\
 	FN(QUEUE_PURGE)			\
 	FN(TC_ERROR)			\
+	FN(PACKET_SOCK_ERROR)		\
 	FNe(MAX)
 
 /**
@@ -348,6 +349,11 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_QUEUE_PURGE,
 	/** @SKB_DROP_REASON_TC_ERROR: generic internal tc error. */
 	SKB_DROP_REASON_TC_ERROR,
+	/**
+	 * @SKB_DROP_REASON_PACKET_SOCK_ERROR: generic packet socket errors
+	 * after its filter matches an incoming packet.
+	 */
+	SKB_DROP_REASON_PACKET_SOCK_ERROR,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index a84e00b5904b..94b8a9d8e038 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2128,6 +2128,7 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
 	int skb_len = skb->len;
 	unsigned int snaplen, res;
 	bool is_drop_n_account = false;
+	enum skb_drop_reason drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 
 	if (skb->pkt_type == PACKET_LOOPBACK)
 		goto drop;
@@ -2161,6 +2162,10 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
 	res = run_filter(skb, sk, snaplen);
 	if (!res)
 		goto drop_n_restore;
+
+	/* skb will only be "consumed" not "dropped" before this */
+	drop_reason = SKB_DROP_REASON_PACKET_SOCK_ERROR;
+
 	if (snaplen > res)
 		snaplen = res;
 
@@ -2230,7 +2235,7 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
 	if (!is_drop_n_account)
 		consume_skb(skb);
 	else
-		kfree_skb(skb);
+		kfree_skb_reason(skb, drop_reason);
 	return 0;
 }
 
@@ -2253,6 +2258,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	bool is_drop_n_account = false;
 	unsigned int slot_id = 0;
 	int vnet_hdr_sz = 0;
+	enum skb_drop_reason drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 
 	/* struct tpacket{2,3}_hdr is aligned to a multiple of TPACKET_ALIGNMENT.
 	 * We may add members to them until current aligned size without forcing
@@ -2355,6 +2361,10 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 			vnet_hdr_sz = 0;
 		}
 	}
+
+	/* skb will only be "consumed" not "dropped" before this */
+	drop_reason = SKB_DROP_REASON_PACKET_SOCK_ERROR;
+
 	spin_lock(&sk->sk_receive_queue.lock);
 	h.raw = packet_current_rx_frame(po, skb,
 					TP_STATUS_KERNEL, (macoff+snaplen));
@@ -2501,7 +2511,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	if (!is_drop_n_account)
 		consume_skb(skb);
 	else
-		kfree_skb(skb);
+		kfree_skb_reason(skb, drop_reason);
 	return 0;
 
 drop_n_account:
@@ -2510,7 +2520,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	is_drop_n_account = true;
 
 	sk->sk_data_ready(sk);
-	kfree_skb(copy_skb);
+	kfree_skb_reason(copy_skb, drop_reason);
 	goto drop_n_restore;
 }
 
-- 
2.30.2

