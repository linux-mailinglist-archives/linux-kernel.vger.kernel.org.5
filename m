Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDC87A46B6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbjIRKMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240944AbjIRKLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:11:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27011AA
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 03:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695031867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TBj38+uZQNDDW4zck8GIvLmvlPHljO+yQXzrJXiozp0=;
        b=cBkgOD9dJWGaMf4NOE6G1sz1/fvv8qh+DBgln2n1BR9djdyoi3mjA3d2OGhP57Av4RxZsw
        p2nf5Blflpy/pZ3IfsT5/QQ/EM/GnL3N8x/xCCIYIszrLaDfUhVrPS9nIpthcBGj9DxTKM
        a0yHJx145A9MX7LAoJuTtTLme4c2ZbU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-q5s-R_rSPeWchfPIfhZ8Kw-1; Mon, 18 Sep 2023 06:11:04 -0400
X-MC-Unique: q5s-R_rSPeWchfPIfhZ8Kw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F28885A5A8;
        Mon, 18 Sep 2023 10:11:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 479F3492C37;
        Mon, 18 Sep 2023 10:11:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CANn89iLwMhOnrmQTZJ+BqZJSbJZ+Q4W6xRknAAr+uSrk5TX-EQ@mail.gmail.com>
References: <CANn89iLwMhOnrmQTZJ+BqZJSbJZ+Q4W6xRknAAr+uSrk5TX-EQ@mail.gmail.com> <0000000000001c12b30605378ce8@google.com>
To:     syzbot+62cbf263225ae13ff153@syzkaller.appspotmail.com
Cc:     dhowells@redhat.com, Eric Dumazet <edumazet@google.com>,
        bpf@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in __ip6_append_data
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3905312.1695031861.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 18 Sep 2023 11:11:01 +0100
Message-ID: <3905313.1695031861@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t 65d6e954e378

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 0665e8b09968..7978335c1fc4 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1517,8 +1517,10 @@ static int __ip6_append_data(struct sock *sk,
 		     rt->rt6i_nfheader_len;
 =

 	if (mtu <=3D fragheaderlen ||
-	    ((mtu - fragheaderlen) & ~7) + fragheaderlen <=3D sizeof(struct frag=
_hdr))
+	    ((mtu - fragheaderlen) & ~7) + fragheaderlen <=3D sizeof(struct frag=
_hdr)) {
+		printk("__%u__: EMSGSIZE\n", __LINE__);
 		goto emsgsize;
+	}
 =

 	maxfraglen =3D ((mtu - fragheaderlen) & ~7) + fragheaderlen -
 		     sizeof(struct frag_hdr);
@@ -1526,8 +1528,10 @@ static int __ip6_append_data(struct sock *sk,
 	/* as per RFC 7112 section 5, the entire IPv6 Header Chain must fit
 	 * the first fragment
 	 */
-	if (headersize + transhdrlen > mtu)
+	if (headersize + transhdrlen > mtu) {
+		printk("__%u__: EMSGSIZE\n", __LINE__);
 		goto emsgsize;
+	}
 =

 	if (cork->length + length > mtu - headersize && ipc6->dontfrag &&
 	    (sk->sk_protocol =3D=3D IPPROTO_UDP ||
@@ -1535,15 +1539,23 @@ static int __ip6_append_data(struct sock *sk,
 	     sk->sk_protocol =3D=3D IPPROTO_RAW)) {
 		ipv6_local_rxpmtu(sk, fl6, mtu - headersize +
 				sizeof(struct ipv6hdr));
+		printk("__%u__: EMSGSIZE\n", __LINE__);
 		goto emsgsize;
 	}
 =

-	if (ip6_sk_ignore_df(sk))
+	if (ip6_sk_ignore_df(sk)) {
 		maxnonfragsize =3D sizeof(struct ipv6hdr) + IPV6_MAXPLEN;
-	else
+		printk("MAXPLEN\n");
+	} else {
 		maxnonfragsize =3D mtu;
+		printk("mtu\n");
+	}
 =

+	printk("check %d %zd %d %d, %d %d\n",
+	       cork->length, length, maxnonfragsize, headersize,
+	       transhdrlen, mtu);
 	if (cork->length + length > maxnonfragsize - headersize) {
+		printk("__%u__: EMSGSIZE\n", __LINE__);
 emsgsize:
 		pmtu =3D max_t(int, mtu - headersize + sizeof(struct ipv6hdr), 0);
 		ipv6_local_error(sk, EMSGSIZE, fl6, pmtu);
@@ -1817,8 +1829,10 @@ static int __ip6_append_data(struct sock *sk,
 			if (!skb_can_coalesce(skb, i, pfrag->page,
 					      pfrag->offset)) {
 				err =3D -EMSGSIZE;
-				if (i =3D=3D MAX_SKB_FRAGS)
+				if (i =3D=3D MAX_SKB_FRAGS) {
+					printk("__%u__: EMSGSIZE\n", __LINE__);
 					goto error;
+				}
 =

 				__skb_fill_page_desc(skb, i, pfrag->page,
 						     pfrag->offset, 0);
diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index ed8ebb6f5909..daaaf60dce01 100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -502,6 +502,8 @@ static int l2tp_ip6_sendmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len)
 	int ulen;
 	int err;
 =

+	printk("%s()\n", __func__);
+
 	/* Rough check on arithmetic overflow,
 	 * better check is made in ip6_append_data().
 	 */

