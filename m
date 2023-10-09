Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5880A7BD1E1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 04:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344859AbjJICJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 22:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbjJICJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 22:09:51 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD08A4;
        Sun,  8 Oct 2023 19:09:49 -0700 (PDT)
X-UUID: 28fed6466eed4b1790d911464d79c826-20231009
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:6dfe2cf6-c1da-45e0-bbd1-da03b007062d,IP:-15
        ,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:-24
X-CID-INFO: VERSION:1.1.32,REQID:6dfe2cf6-c1da-45e0-bbd1-da03b007062d,IP:-15,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-24
X-CID-META: VersionHash:5f78ec9,CLOUDID:636fb8bf-14cc-44ca-b657-2d2783296e72,B
        ulkID:2310091009398OGIRJL5,BulkQuantity:0,Recheck:0,SF:24|17|19|43|102,TC:
        nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
        SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 28fed6466eed4b1790d911464d79c826-20231009
X-User: guodongtai@kylinos.cn
Received: from localhost.localdomain [(39.156.73.14)] by mailgw
        (envelope-from <guodongtai@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1526781071; Mon, 09 Oct 2023 10:09:37 +0800
From:   George Guo <guodongtai@kylinos.cn>
To:     fw@strlen.de
Cc:     davem@davemloft.net, dongtai.guo@linux.dev, dsahern@kernel.org,
        edumazet@google.com, guodongtai@kylinos.cn, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com
Subject: [PATCH v2] tcp: cleanup secure_{tcp, tcpv6}_ts_off
Date:   Mon,  9 Oct 2023 10:11:08 +0800
Message-Id: <20231009021108.3203928-1-guodongtai@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231007105019.GA20662@breakpoint.cc>
References: <20231007105019.GA20662@breakpoint.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct secure_tcp_ts_off and secure_tcpv6_ts_off call parameter order

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
index a441740616d7..54717d261693 100644
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
index bfe7d19ff4fd..7e2f924725c6 100644
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

