Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E46D7A3F4D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 03:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237066AbjIRBrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 21:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236526AbjIRBqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 21:46:55 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3728A11C;
        Sun, 17 Sep 2023 18:46:47 -0700 (PDT)
X-UUID: 0d32ae22f4e74d71922d09c55c7932d4-20230918
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:82219cff-e942-401e-94f1-c94b93bedad2,IP:-5,
        URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:11
X-CID-INFO: VERSION:1.1.31,REQID:82219cff-e942-401e-94f1-c94b93bedad2,IP:-5,UR
        L:0,TC:0,Content:0,EDM:25,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:11
X-CID-META: VersionHash:0ad78a4,CLOUDID:09a2f1be-14cc-44ca-b657-2d2783296e72,B
        ulkID:2309180946397W7A7FSK,BulkQuantity:0,Recheck:0,SF:17|19|43|38|24|102,
        TC:nil,Content:0,EDM:5,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 0d32ae22f4e74d71922d09c55c7932d4-20230918
X-User: guodongtai@kylinos.cn
Received: from localhost.localdomain [(39.156.73.14)] by mailgw
        (envelope-from <guodongtai@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1701327177; Mon, 18 Sep 2023 09:46:37 +0800
From:   George Guo <guodongtai@kylinos.cn>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, dsahern@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] tcp: enhancing timestamps random algo to address issues arising from NAT mapping
Date:   Mon, 18 Sep 2023 09:47:52 +0800
Message-Id: <20230918014752.1791518-1-guodongtai@kylinos.cn>
X-Mailer: git-send-email 2.34.1
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

Tsval=tsoffset+local_clock, here tsoffset is randomized with saddr and daddr parameters in func
secure_tcp_ts_off. Most of time it is OK except for NAT mapping to the same port and daddr.
Consider the following scenario:
	ns1:                ns2:
	+-----------+        +-----------+
	|           |        |           |
	|           |        |           |
	|           |        |           |
	| veth1     |        | vethb     |
	|192.168.1.1|        |192.168.1.2|
	+----+------+        +-----+-----+
	     |                     |
	     |                     |
	     | br0:192.168.1.254   |
	     +----------+----------+
	 veth0          |     vetha
	 192.168.1.3    |    192.168.1.4
	                |
	               nat(192.168.1.x -->172.30.60.199)
	                |
	                V
	               eth0
	         172.30.60.199
	               |
	               |
	               +----> ... ...    ---->server: 172.30.60.191

Let's say ns1 (192.168.1.1) generates a timestamp ts1, and ns2 (192.168.1.2) generates a timestamp
ts2, with ts1 > ts2.

If ns1 initiates a connection to a server, and then the server actively closes the connection,
entering the TIME_WAIT state, and ns2 attempts to connect to the server while port reuse is in
progress, due to the presence of NAT, the server sees both connections as originating from the
same IP address (e.g., 172.30.60.199) and port. However, since ts2 is smaller than ts1, the server
will respond with the acknowledgment (ACK) for the fourth handshake.

       SERVER                                               	CLIENT

   1.  ESTABLISHED                                          	ESTABLISHED

       (Close)
   2.  FIN-WAIT-1  --> <SEQ=100><ACK=300><TSval=20><CTL=FIN,ACK>  --> CLOSE-WAIT

   3.  FIN-WAIT-2  <-- <SEQ=300><ACK=101><TSval=40><CTL=ACK>      <-- CLOSE-WAIT

                                                            (Close)
   4.  TIME-WAIT   <-- <SEQ=300><ACK=101><TSval=41><CTL=FIN,ACK>  <-- LAST-ACK

   5.  TIME-WAIT   --> <SEQ=101><ACK=301><TSval=25><CTL=ACK>      --> CLOSED

  - - - - - - - - - - - - - port reused - - - - - - - - - - - - - - -

   5.1. TIME-WAIT   <-- <SEQ=255><TSval=30><CTL=SYN>             <-- SYN-SENT

   5.2. TIME-WAIT   --> <SEQ=101><ACK=301><TSval=35><CTL=ACK>    --> SYN-SENT

   5.3. CLOSED      <-- <SEQ=301><CTL=RST>             		 <-- SYN-SENT

   6.  SYN-RECV    <-- <SEQ=255><TSval=34><CTL=SYN>              <-- SYN-SENT

   7.  SYN-RECV    --> <SEQ=400><ACK=301><TSval=40><CTL=SYN,ACK> --> ESTABLISHED

   1.  ESTABLISH   <-- <SEQ=301><ACK=401><TSval=55><CTL=ACK>     <-- ESTABLISHED

This enhancement uses sport and daddr rather than saddr and daddr, which keep the timestamp
monotonically increasing in the situation described above. Then the port reuse is like this:

       SERVER                                               	CLIENT

   1.  ESTABLISHED                                          	ESTABLISHED

       (Close)
   2.  FIN-WAIT-1  --> <SEQ=100><ACK=300><TSval=20><CTL=FIN,ACK>  --> CLOSE-WAIT

   3.  FIN-WAIT-2  <-- <SEQ=300><ACK=101><TSval=40><CTL=ACK>      <-- CLOSE-WAIT

                                                            (Close)
   4.  TIME-WAIT   <-- <SEQ=300><ACK=101><TSval=41><CTL=FIN,ACK>  <-- LAST-ACK

   5.  TIME-WAIT   --> <SEQ=101><ACK=301><TSval=25><CTL=ACK>      --> CLOSED

  - - - - - - - - - - - - - port reused - - - - - - - - - - - - - - -

   5.1. TIME-WAIT  <-- <SEQ=300><TSval=50><CTL=SYN>               <-- SYN-SENT

   6.  SYN-RECV    --> <SEQ=400><ACK=301><TSval=40><CTL=SYN,ACK>  --> ESTABLISHED

   1.  ESTABLISH   <-- <SEQ=301><ACK=401><TSval=55><CTL=ACK>      <-- ESTABLISHED

The enhancement lets port reused more efficiently.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 include/net/secure_seq.h | 2 +-
 net/core/secure_seq.c    | 4 ++--
 net/ipv4/syncookies.c    | 4 ++--
 net/ipv4/tcp_ipv4.c      | 6 ++++--
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/net/secure_seq.h b/include/net/secure_seq.h
index 21e7fa2a1813..40fb53520aa4 100644
--- a/include/net/secure_seq.h
+++ b/include/net/secure_seq.h
@@ -11,7 +11,7 @@ u64 secure_ipv6_port_ephemeral(const __be32 *saddr, const __be32 *daddr,
 			       __be16 dport);
 u32 secure_tcp_seq(__be32 saddr, __be32 daddr,
 		   __be16 sport, __be16 dport);
-u32 secure_tcp_ts_off(const struct net *net, __be32 saddr, __be32 daddr);
+u32 secure_tcp_ts_off(const struct net *net, __be16 sport, __be32 daddr);
 u32 secure_tcpv6_seq(const __be32 *saddr, const __be32 *daddr,
 		     __be16 sport, __be16 dport);
 u32 secure_tcpv6_ts_off(const struct net *net,
diff --git a/net/core/secure_seq.c b/net/core/secure_seq.c
index b0ff6153be62..575b6afe39a4 100644
--- a/net/core/secure_seq.c
+++ b/net/core/secure_seq.c
@@ -118,13 +118,13 @@ EXPORT_SYMBOL(secure_ipv6_port_ephemeral);
 #endif
 
 #ifdef CONFIG_INET
-u32 secure_tcp_ts_off(const struct net *net, __be32 saddr, __be32 daddr)
+u32 secure_tcp_ts_off(const struct net *net, __be16 sport, __be32 daddr)
 {
 	if (READ_ONCE(net->ipv4.sysctl_tcp_timestamps) != 1)
 		return 0;
 
 	ts_secret_init();
-	return siphash_2u32((__force u32)saddr, (__force u32)daddr,
+	return siphash_2u32((__force u32)sport, (__force u32)daddr,
 			    &ts_secret);
 }
 
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index dc478a0574cb..df1757ff5956 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -360,8 +360,8 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 
 	if (tcp_opt.saw_tstamp && tcp_opt.rcv_tsecr) {
 		tsoff = secure_tcp_ts_off(sock_net(sk),
-					  ip_hdr(skb)->daddr,
-					  ip_hdr(skb)->saddr);
+					  th->source,
+					  ip_hdr(skb)->daddr);
 		tcp_opt.rcv_tsecr -= tsoff;
 	}
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 27140e5cdc06..acad4b14ecf7 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -104,7 +104,9 @@ static u32 tcp_v4_init_seq(const struct sk_buff *skb)
 
 static u32 tcp_v4_init_ts_off(const struct net *net, const struct sk_buff *skb)
 {
-	return secure_tcp_ts_off(net, ip_hdr(skb)->daddr, ip_hdr(skb)->saddr);
+	const struct tcphdr *th = tcp_hdr(skb);
+
+	return secure_tcp_ts_off(net, th->source, ip_hdr(skb)->daddr);
 }
 
 int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
@@ -309,7 +311,7 @@ int tcp_v4_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 						  inet->inet_sport,
 						  usin->sin_port));
 		WRITE_ONCE(tp->tsoffset,
-			   secure_tcp_ts_off(net, inet->inet_saddr,
+			   secure_tcp_ts_off(net, inet->inet_sport,
 					     inet->inet_daddr));
 	}
 
-- 
2.34.1

