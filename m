Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FAF7BC66D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 11:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343734AbjJGJ2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 05:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjJGJ2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 05:28:34 -0400
X-Greylist: delayed 376 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 07 Oct 2023 02:28:32 PDT
Received: from out-196.mta0.migadu.com (out-196.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C56BC
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 02:28:32 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696670531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=S5S6Bq/7hDO06XukKZO/A8hT6aAJLIcw9FkCCFsFcrU=;
        b=OfKuyt06uvla2JwmSaRP6rudbR3SVvhlLJS3/RFt0oaL6UFITpEI7c7wxH1VGk48Jug7PV
        ZRRM7b1W9+PJHRo2D5CJSKYEBGklbiR4pM05SxfFbYcN6IbzL48q+qW9671+bMC83p7KyU
        8cR2jNKbHq8RnPM8N7CpJ4i2gTLAwdw=
From:   George Guo <dongtai.guo@linux.dev>
To:     edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
        kuba@kernel.org, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        George Guo <guodongtai@kylinos.cn>
Subject: [PATCH] tcp: fix secure_{tcp, tcpv6}_ts_off call parameter order mistake
Date:   Sat,  7 Oct 2023 17:23:37 +0800
Message-Id: <20231007092337.1540036-1-dongtai.guo@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: George Guo <guodongtai@kylinos.cn>

Fix secure_tcp_ts_off and secure_tcpv6_ts_off call parameter order mistake

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 net/ipv4/syncookies.c | 4 ++--
 net/ipv4/tcp_ipv4.c   | 2 +-
 net/ipv6/syncookies.c | 4 ++--
 net/ipv6/tcp_ipv6.c   | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index dc478a0574cb..537f368a0b66 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -360,8 +360,8 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 
 	if (tcp_opt.saw_tstamp && tcp_opt.rcv_tsecr) {
 		tsoff = secure_tcp_ts_off(sock_net(sk),
-					  ip_hdr(skb)->daddr,
-					  ip_hdr(skb)->saddr);
+					  ip_hdr(skb)->saddr,
+					  ip_hdr(skb)->daddr);
 		tcp_opt.rcv_tsecr -= tsoff;
 	}
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 27140e5cdc06..3d6c9b286b5a 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -104,7 +104,7 @@ static u32 tcp_v4_init_seq(const struct sk_buff *skb)
 
 static u32 tcp_v4_init_ts_off(const struct net *net, const struct sk_buff *skb)
 {
-	return secure_tcp_ts_off(net, ip_hdr(skb)->daddr, ip_hdr(skb)->saddr);
+	return secure_tcp_ts_off(net, ip_hdr(skb)->saddr, ip_hdr(skb)->daddr);
 }
 
 int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 5014aa663452..9af484a4d518 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -162,8 +162,8 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 
 	if (tcp_opt.saw_tstamp && tcp_opt.rcv_tsecr) {
 		tsoff = secure_tcpv6_ts_off(sock_net(sk),
-					    ipv6_hdr(skb)->daddr.s6_addr32,
-					    ipv6_hdr(skb)->saddr.s6_addr32);
+					    ipv6_hdr(skb)->saddr.s6_addr32,
+					    ipv6_hdr(skb)->daddr.s6_addr32);
 		tcp_opt.rcv_tsecr -= tsoff;
 	}
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 3a88545a265d..ce9cc4c43cf2 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -119,8 +119,8 @@ static u32 tcp_v6_init_seq(const struct sk_buff *skb)
 
 static u32 tcp_v6_init_ts_off(const struct net *net, const struct sk_buff *skb)
 {
-	return secure_tcpv6_ts_off(net, ipv6_hdr(skb)->daddr.s6_addr32,
-				   ipv6_hdr(skb)->saddr.s6_addr32);
+	return secure_tcpv6_ts_off(net, ipv6_hdr(skb)->saddr.s6_addr32,
+				   ipv6_hdr(skb)->daddr.s6_addr32);
 }
 
 static int tcp_v6_pre_connect(struct sock *sk, struct sockaddr *uaddr,
-- 
2.34.1

