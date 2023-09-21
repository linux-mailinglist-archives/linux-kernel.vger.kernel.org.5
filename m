Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D725F7AA140
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjIUU76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjIUU7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:59:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54617B05A8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695319716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=R9gyNPaV4zuqNuZuo/vx9UBWKean5gdHBlkkwmtG0SQ=;
        b=XOT1ZkquHLDF5KYxecldIkAlvz1YAy9XUOfXoxfhBbLGEdCHnCqL6d0ANRy24G6Iz695TE
        y2EdXZsBVzp4Y5PQLRAB8P6iZyEcBQ1dsT9h2GrpBXxjgS1UomGJgdYDVxT+2ErLeoQuuV
        b5CT83oWz75Gxo23TbMyR8WycKrz0jU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-0ruNuvMkOS6GtcLt8Ah2FA-1; Thu, 21 Sep 2023 06:41:22 -0400
X-MC-Unique: 0ruNuvMkOS6GtcLt8Ah2FA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BBA57101A529;
        Thu, 21 Sep 2023 10:41:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A0D751E3;
        Thu, 21 Sep 2023 10:41:20 +0000 (UTC)
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
Subject: [PATCH net v3] ipv4, ipv6: Fix handling of transhdrlen in __ip{,6}_append_data()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <730407.1695292879.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 21 Sep 2023 11:41:19 +0100
Message-ID: <730408.1695292879@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
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

Fix this by only adding transhdrlen into the length if the write queue is
empty in l2tp_ip6_sendmsg(), analogously to how UDP does things.

l2tp_ip_sendmsg() looks like it won't suffer from this problem as it build=
s
the UDP packet itself.

Fixes: a32e0eec7042 ("l2tp: introduce L2TPv3 IP encapsulation support for =
IPv6")
Reported-by: syzbot+62cbf263225ae13ff153@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/0000000000001c12b30605378ce8@google.com/
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
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
 net/l2tp/l2tp_ip6.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index ed8ebb6f5909..11f3d375cec0 100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -507,7 +507,6 @@ static int l2tp_ip6_sendmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len)
 	 */
 	if (len > INT_MAX - transhdrlen)
 		return -EMSGSIZE;
-	ulen =3D len + transhdrlen;
 =

 	/* Mirror BSD error message compatibility */
 	if (msg->msg_flags & MSG_OOB)
@@ -628,6 +627,7 @@ static int l2tp_ip6_sendmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len)
 =

 back_from_confirm:
 	lock_sock(sk);
+	ulen =3D len + skb_queue_empty(&sk->sk_write_queue) ? transhdrlen : 0;
 	err =3D ip6_append_data(sk, ip_generic_getfrag, msg,
 			      ulen, transhdrlen, &ipc6,
 			      &fl6, (struct rt6_info *)dst,

