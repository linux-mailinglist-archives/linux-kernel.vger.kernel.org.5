Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9217A68A7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 18:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjISQN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 12:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjISQNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 12:13:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2254BAB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 09:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695139979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7DinXRW8uYhcdYnKxZEOd/0XsHigGWMaEQ5KwkB8lL0=;
        b=GfUck5DGo1+7ir4tnX8Dd67uKi5l6nZk3oBr0/bgYbeSaQX6fVriu2u+DOJ/SeRyJ1K8DM
        RF35XqByuschLkCW63hYVeyvLW2s4DlIxTToWpKHyH/ZMVrgFdJd8JrtVR0hnMjh7K0gKB
        0kUpgoSdnXGDJ9MGk+PuvRY3c7k0XpE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-682-DRLT1Ma4NdKf3JKiGG0BYg-1; Tue, 19 Sep 2023 12:12:56 -0400
X-MC-Unique: DRLT1Ma4NdKf3JKiGG0BYg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50DE08039D1;
        Tue, 19 Sep 2023 16:12:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 931D6492B16;
        Tue, 19 Sep 2023 16:12:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
cc:     dhowells@redhat.com,
        syzbot+62cbf263225ae13ff153@syzkaller.appspotmail.com,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH net] ipv4, ipv6: Fix handling of transhdrlen in __ip{,6}_append_data()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <75314.1695139973.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 19 Sep 2023 17:12:53 +0100
Message-ID: <75315.1695139973@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    =

Including the transhdrlen in length is a problem when the packet is
partially filled (e.g. something like send(MSG_MORE) happened previously)
when appending to an IPv4 or IPv6 packet as we don't want to repeat the
transport header or account for it twice.  This can happen under some
circumstances, such as splicing into an L2TP socket.

The symptom observed is a warning in __ip6_append_data():

    WARNING: CPU: 1 PID: 5042 at net/ipv6/ip6_output.c:1800 __ip6_append_d=
ata.isra.0+0x1be8/0x47f0 net/ipv6/ip6_output.c:1800

that occurs when MSG_SPLICE_PAGES is used to append more data to an alread=
y
partially occupied skbuff.  The warning occurs when 'copy' is larger than
the amount of data in the message iterator.  This is because the requested
length includes the transport header length when it shouldn't.  This can b=
e
triggered by, for example:

        sfd =3D socket(AF_INET6, SOCK_DGRAM, IPPROTO_L2TP);
        bind(sfd, ...); // ::1
        connect(sfd, ...); // ::1 port 7
        send(sfd, buffer, 4100, MSG_MORE);
        sendfile(sfd, dfd, NULL, 1024);

Fix this by pushing the addition of transhdrlen into length down into
__ip_append_data() and __ip6_append_data(), making it conditional on the
write queue being empty (otherwise we just clear transhdrlen).

Notes:

 (1) The length supplied by userspace in ping_*_sendmsg() includes the
     transport header len in the size, so we need to subtract it as the
     iterator has been advanced to copy out the header - however we still
     have to return the fact that we use it from sys_sendmsg(), so we can'=
t
     just preemptively decrease len at the beginning of the function.

 (2) Raw sockets include the transport header in the payload and pass down
     a zero transhdrlen, which I just leave as is.

 (3) A smaller fix could be to make ip{,6}_append_data() subtract
     transhdrlen from length if it is going to set transhdrlen to 0 - but
     it would seem better just not to include it in the first place.

Reported-by: syzbot+62cbf263225ae13ff153@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/0000000000001c12b30605378ce8@google.com/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Eric Dumazet <edumazet@google.com>
cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: David Ahern <dsahern@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: netdev@vger.kernel.org
cc: bpf@vger.kernel.org
cc: syzkaller-bugs@googlegroups.com
---
 net/ipv4/icmp.c       |    3 +--
 net/ipv4/ip_output.c  |    7 +++++--
 net/ipv4/ping.c       |    3 ++-
 net/ipv4/udp.c        |    8 +++-----
 net/ipv6/icmp.c       |    6 ++----
 net/ipv6/ip6_output.c |   16 +++++++++-------
 net/ipv6/ping.c       |    3 ++-
 net/ipv6/udp.c        |    8 +++-----
 net/l2tp/l2tp_ip6.c   |    4 +---
 9 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index b8607763d113..e1140597e971 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -368,8 +368,7 @@ static void icmp_push_reply(struct sock *sk,
 	struct sk_buff *skb;
 =

 	if (ip_append_data(sk, fl4, icmp_glue_bits, icmp_param,
-			   icmp_param->data_len+icmp_param->head_len,
-			   icmp_param->head_len,
+			   icmp_param->data_len, icmp_param->head_len,
 			   ipc, rt, MSG_DONTWAIT) < 0) {
 		__ICMP_INC_STATS(sock_net(sk), ICMP_MIB_OUTERRORS);
 		ip_flush_pending_frames(sk);
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 4ab877cf6d35..80735bb34a73 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -974,6 +974,11 @@ static int __ip_append_data(struct sock *sk,
 	bool paged, extra_uref =3D false;
 	u32 tskey =3D 0;
 =

+	if (skb_queue_empty(&sk->sk_write_queue))
+		length +=3D transhdrlen;
+	else
+		transhdrlen =3D 0;
+
 	skb =3D skb_peek_tail(queue);
 =

 	exthdrlen =3D !skb ? rt->dst.header_len : 0;
@@ -1353,8 +1358,6 @@ int ip_append_data(struct sock *sk, struct flowi4 *f=
l4,
 		err =3D ip_setup_cork(sk, &inet->cork.base, ipc, rtp);
 		if (err)
 			return err;
-	} else {
-		transhdrlen =3D 0;
 	}
 =

 	return __ip_append_data(sk, fl4, &sk->sk_write_queue, &inet->cork.base,
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 75e0aee35eb7..237f25a015f7 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -819,7 +819,8 @@ static int ping_v4_sendmsg(struct sock *sk, struct msg=
hdr *msg, size_t len)
 	pfh.wcheck =3D 0;
 	pfh.family =3D AF_INET;
 =

-	err =3D ip_append_data(sk, &fl4, ping_getfrag, &pfh, len,
+	err =3D ip_append_data(sk, &fl4, ping_getfrag, &pfh,
+			     len - sizeof(struct icmphdr),
 			     sizeof(struct icmphdr), &ipc, &rt,
 			     msg->msg_flags);
 	if (err)
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index f39b9c844580..b16da49a8478 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1042,7 +1042,6 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg,=
 size_t len)
 	DECLARE_SOCKADDR(struct sockaddr_in *, usin, msg->msg_name);
 	struct flowi4 fl4_stack;
 	struct flowi4 *fl4;
-	int ulen =3D len;
 	struct ipcm_cookie ipc;
 	struct rtable *rt =3D NULL;
 	int free =3D 0;
@@ -1084,7 +1083,6 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg,=
 size_t len)
 		}
 		release_sock(sk);
 	}
-	ulen +=3D sizeof(struct udphdr);
 =

 	/*
 	 *	Get and verify the address.
@@ -1238,7 +1236,7 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg,=
 size_t len)
 	if (!corkreq) {
 		struct inet_cork cork;
 =

-		skb =3D ip_make_skb(sk, fl4, getfrag, msg, ulen,
+		skb =3D ip_make_skb(sk, fl4, getfrag, msg, len,
 				  sizeof(struct udphdr), &ipc, &rt,
 				  &cork, msg->msg_flags);
 		err =3D PTR_ERR(skb);
@@ -1268,8 +1266,8 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg,=
 size_t len)
 	up->pending =3D AF_INET;
 =

 do_append_data:
-	up->len +=3D ulen;
-	err =3D ip_append_data(sk, fl4, getfrag, msg, ulen,
+	up->len +=3D sizeof(struct udphdr) + len;
+	err =3D ip_append_data(sk, fl4, getfrag, msg, len,
 			     sizeof(struct udphdr), &ipc, &rt,
 			     corkreq ? msg->msg_flags|MSG_MORE : msg->msg_flags);
 	if (err)
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 93a594a901d1..55ae1966fa75 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -614,8 +614,7 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code,=
 __u32 info,
 	idev =3D __in6_dev_get(skb->dev);
 =

 	if (ip6_append_data(sk, icmpv6_getfrag, &msg,
-			    len + sizeof(struct icmp6hdr),
-			    sizeof(struct icmp6hdr),
+			    len, sizeof(struct icmp6hdr),
 			    &ipc6, &fl6, (struct rt6_info *)dst,
 			    MSG_DONTWAIT)) {
 		ICMP6_INC_STATS(net, idev, ICMP6_MIB_OUTERRORS);
@@ -801,8 +800,7 @@ static enum skb_drop_reason icmpv6_echo_reply(struct s=
k_buff *skb)
 			goto out_dst_release;
 =

 	if (ip6_append_data(sk, icmpv6_getfrag, &msg,
-			    skb->len + sizeof(struct icmp6hdr),
-			    sizeof(struct icmp6hdr), &ipc6, &fl6,
+			    skb->len, sizeof(struct icmp6hdr), &ipc6, &fl6,
 			    (struct rt6_info *)dst, MSG_DONTWAIT)) {
 		__ICMP6_INC_STATS(net, idev, ICMP6_MIB_OUTERRORS);
 		ip6_flush_pending_frames(sk);
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 54fc4c711f2c..21bae77489c9 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1490,6 +1490,11 @@ static int __ip6_append_data(struct sock *sk,
 	unsigned int wmem_alloc_delta =3D 0;
 	bool paged, extra_uref =3D false;
 =

+	if (skb_queue_empty(&sk->sk_write_queue))
+		length +=3D transhdrlen;
+	else
+		transhdrlen =3D 0;
+
 	skb =3D skb_peek_tail(queue);
 	if (!skb) {
 		exthdrlen =3D opt ? opt->opt_flen : 0;
@@ -1868,7 +1873,6 @@ int ip6_append_data(struct sock *sk,
 {
 	struct inet_sock *inet =3D inet_sk(sk);
 	struct ipv6_pinfo *np =3D inet6_sk(sk);
-	int exthdrlen;
 	int err;
 =

 	if (flags&MSG_PROBE)
@@ -1884,13 +1888,11 @@ int ip6_append_data(struct sock *sk,
 			return err;
 =

 		inet->cork.fl.u.ip6 =3D *fl6;
-		exthdrlen =3D (ipc6->opt ? ipc6->opt->opt_flen : 0);
-		length +=3D exthdrlen;
-		transhdrlen +=3D exthdrlen;
-	} else {
-		transhdrlen =3D 0;
 	}
 =

+	/* Add space for extensions */
+	transhdrlen +=3D (ipc6->opt ? ipc6->opt->opt_flen : 0);
+
 	return __ip6_append_data(sk, &sk->sk_write_queue, &inet->cork,
 				 &np->cork, sk_page_frag(sk), getfrag,
 				 from, length, transhdrlen, flags, ipc6);
@@ -2095,7 +2097,7 @@ struct sk_buff *ip6_make_skb(struct sock *sk,
 =

 	err =3D __ip6_append_data(sk, &queue, cork, &v6_cork,
 				&current->task_frag, getfrag, from,
-				length + exthdrlen, transhdrlen + exthdrlen,
+				length, transhdrlen + exthdrlen,
 				flags, ipc6);
 	if (err) {
 		__ip6_flush_pending_frames(sk, &queue, cork, &v6_cork);
diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
index 5831aaa53d75..fa2701241724 100644
--- a/net/ipv6/ping.c
+++ b/net/ipv6/ping.c
@@ -174,7 +174,8 @@ static int ping_v6_sendmsg(struct sock *sk, struct msg=
hdr *msg, size_t len)
 		ipc6.hlimit =3D ip6_sk_dst_hoplimit(np, &fl6, dst);
 =

 	lock_sock(sk);
-	err =3D ip6_append_data(sk, ping_getfrag, &pfh, len,
+	err =3D ip6_append_data(sk, ping_getfrag, &pfh,
+			      len - sizeof(struct icmp6hdr),
 			      sizeof(struct icmp6hdr), &ipc6, &fl6, rt,
 			      MSG_DONTWAIT);
 =

diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 86b5d509a468..9dd71f542c9f 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1331,7 +1331,6 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *ms=
g, size_t len)
 	struct ipcm6_cookie ipc6;
 	int addr_len =3D msg->msg_namelen;
 	bool connected =3D false;
-	int ulen =3D len;
 	int corkreq =3D READ_ONCE(up->corkflag) || msg->msg_flags&MSG_MORE;
 	int err;
 	int is_udplite =3D IS_UDPLITE(sk);
@@ -1416,7 +1415,6 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *ms=
g, size_t len)
 		}
 		release_sock(sk);
 	}
-	ulen +=3D sizeof(struct udphdr);
 =

 	memset(fl6, 0, sizeof(*fl6));
 =

@@ -1567,7 +1565,7 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *ms=
g, size_t len)
 	if (!corkreq) {
 		struct sk_buff *skb;
 =

-		skb =3D ip6_make_skb(sk, getfrag, msg, ulen,
+		skb =3D ip6_make_skb(sk, getfrag, msg, len,
 				   sizeof(struct udphdr), &ipc6,
 				   (struct rt6_info *)dst,
 				   msg->msg_flags, &cork);
@@ -1594,8 +1592,8 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *ms=
g, size_t len)
 do_append_data:
 	if (ipc6.dontfrag < 0)
 		ipc6.dontfrag =3D np->dontfrag;
-	up->len +=3D ulen;
-	err =3D ip6_append_data(sk, getfrag, msg, ulen, sizeof(struct udphdr),
+	up->len +=3D sizeof(struct udphdr) + len;
+	err =3D ip6_append_data(sk, getfrag, msg, len, sizeof(struct udphdr),
 			      &ipc6, fl6, (struct rt6_info *)dst,
 			      corkreq ? msg->msg_flags|MSG_MORE : msg->msg_flags);
 	if (err)
diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index ed8ebb6f5909..d5d1c3b68200 100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -499,7 +499,6 @@ static int l2tp_ip6_sendmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len)
 	struct ipcm6_cookie ipc6;
 	int addr_len =3D msg->msg_namelen;
 	int transhdrlen =3D 4; /* zero session-id */
-	int ulen;
 	int err;
 =

 	/* Rough check on arithmetic overflow,
@@ -507,7 +506,6 @@ static int l2tp_ip6_sendmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len)
 	 */
 	if (len > INT_MAX - transhdrlen)
 		return -EMSGSIZE;
-	ulen =3D len + transhdrlen;
 =

 	/* Mirror BSD error message compatibility */
 	if (msg->msg_flags & MSG_OOB)
@@ -629,7 +627,7 @@ static int l2tp_ip6_sendmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len)
 back_from_confirm:
 	lock_sock(sk);
 	err =3D ip6_append_data(sk, ip_generic_getfrag, msg,
-			      ulen, transhdrlen, &ipc6,
+			      len, transhdrlen, &ipc6,
 			      &fl6, (struct rt6_info *)dst,
 			      msg->msg_flags);
 	if (err)

