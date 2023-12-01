Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6ED8011F1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378999AbjLARnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjLARnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:43:11 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F09FE
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:43:16 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-67a9febb2bfso3073406d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1701452596; x=1702057396; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pbX2X80nmyjZX82rv/r7YFYgyku+kUEoXFmQeyn/H7Y=;
        b=X8ZvwL7BMXHp9Sbo9kVdeGBTJAMfweMWYRyy9FPtSowLQwQ0dT+mYADrFdkYorLI6e
         mXX1y8ECbcv3/lEe2G8XH7VvfuuGMQjS4N097L8Oy8Ebpeyoy+Cmcc0fHhb0qWT2G6Yf
         ilmbJfUB8XDwXADTFFx9SucMHsm/1HnXectlx2LfEK0/ltqr4FBYYpm1Shd7ic6jbwyy
         861/Mfcw6V8ylUptlqUsXVsae/ge6oQGn1TrnUwfUdV+w82MaX5R/csvtF0+43vgDa0B
         QXPZCp83ByN9PU6lG+/qKHoSQ3sv8lmwPSSoluShw5VoLlCxXcOIMcoYccey6LkRuXzw
         9pXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701452596; x=1702057396;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pbX2X80nmyjZX82rv/r7YFYgyku+kUEoXFmQeyn/H7Y=;
        b=idT2zGgc+RA6qCx6tDKyv+ClzENL3Qmy82rtFsRYARZhsu8MdcbzvRujmverNYhs4H
         cAmpj9Xeg1uQVzPJhS/5X0JuH1h1IBMacX+Kij+fBDfinfOg+1u4CUxpGiAOMPBfPhey
         EhUy8TMl991adB6ZQVc02AdPMIMAvvw49sdZSOnGujI/tEcD4/P31X2gvfMUGH3sg8Zh
         m/EMn75ICkN6k3A+dn2A9Ba+s8DbHlZWKMWiCB+rOSQJKowjmenyFu+aJ3mbiaYwCNEB
         gt88Kn2HRHWuEFCq+lg72VMWfgjUO4DihJeqGochAdaQ7pzyti3lQ47r2tZvjr/ni7WV
         hk7A==
X-Gm-Message-State: AOJu0Yx0QJwNHlY6gOQgMFkA4sc4lM0Cz5qf4zsYaJvTKcK3MNN+iuXg
        9hWdhl7veDO0D7TM7AJM4JBAu4OW+qCkH24RY5XDWQ==
X-Google-Smtp-Source: AGHT+IGu4Er+xeVXSE1h8is2v9BrjwsKZ9cQMUM1k6ZT00jp5F62wWeWZY8MJe82t7LpGeQcJ8Hm+Q==
X-Received: by 2002:a05:6214:518a:b0:67a:9895:3aeb with SMTP id kl10-20020a056214518a00b0067a98953aebmr3093893qvb.53.1701452595831;
        Fri, 01 Dec 2023 09:43:15 -0800 (PST)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id k7-20020a0cabc7000000b0067a3e703e3asm1702786qvb.37.2023.12.01.09.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 09:43:15 -0800 (PST)
Date:   Fri, 1 Dec 2023 09:43:13 -0800
From:   Yan Zhai <yan@cloudflare.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Weongyo Jeong <weongyo.linux@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Jesper Brouer <jesper@cloudflare.com>
Subject: [PATCH v2 net-next] packet: add a generic drop reason for receive
Message-ID: <ZWobMUp22oTpP3FW@debian.debian>
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
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 include/net/dropreason-core.h |  6 ++++++
 net/packet/af_packet.c        | 22 +++++++++++++---------
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 3c70ad53a49c..278e4c7d465c 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -86,6 +86,7 @@
 	FN(IPV6_NDISC_NS_OTHERHOST)	\
 	FN(QUEUE_PURGE)			\
 	FN(TC_ERROR)			\
+	FN(PACKET_SOCK_ERROR)		\
 	FNe(MAX)
 
 /**
@@ -378,6 +379,11 @@ enum skb_drop_reason {
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
index a84e00b5904b..0a7c05d8fe9f 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2128,6 +2128,7 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
 	int skb_len = skb->len;
 	unsigned int snaplen, res;
 	bool is_drop_n_account = false;
+	enum skb_drop_reason drop_reason = SKB_CONSUMED;
 
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
 
@@ -2227,10 +2232,7 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
 		skb->len = skb_len;
 	}
 drop:
-	if (!is_drop_n_account)
-		consume_skb(skb);
-	else
-		kfree_skb(skb);
+	kfree_skb_reason(skb, drop_reason);
 	return 0;
 }
 
@@ -2253,6 +2255,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	bool is_drop_n_account = false;
 	unsigned int slot_id = 0;
 	int vnet_hdr_sz = 0;
+	enum skb_drop_reason drop_reason = SKB_CONSUMED;
 
 	/* struct tpacket{2,3}_hdr is aligned to a multiple of TPACKET_ALIGNMENT.
 	 * We may add members to them until current aligned size without forcing
@@ -2355,6 +2358,10 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
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
@@ -2498,10 +2505,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 		skb->len = skb_len;
 	}
 drop:
-	if (!is_drop_n_account)
-		consume_skb(skb);
-	else
-		kfree_skb(skb);
+	kfree_skb_reason(skb, drop_reason);
 	return 0;
 
 drop_n_account:
@@ -2510,7 +2514,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	is_drop_n_account = true;
 
 	sk->sk_data_ready(sk);
-	kfree_skb(copy_skb);
+	kfree_skb_reason(copy_skb, drop_reason);
 	goto drop_n_restore;
 }
 
-- 
2.30.2

