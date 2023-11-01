Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6DD7DE765
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344387AbjKAVWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 17:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbjKAVWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 17:22:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC93C132
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 14:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698873695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zI2a2SBcara9W2yx9Xt+g9jp848TbmpBRFi3kqUNer4=;
        b=acn3gmVy3rWElDGj5tPf/lqO/dbTdkMHR3Wj2Pg1zBTCKK7diLQEaIJWY9dteI8MnC7WxI
        vpnwgdkYuQE1NrghKbjP5soDiqDyXbWurgiJl2Wj3nhtnjn5r4MDp2oip5iCPqR4scY9yX
        l0fpR1ZPBzcPEuOlLVKl4/TgNRjxCPA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-6-W6HPB8N8WVZlc0NbtdZw-1; Wed, 01 Nov 2023 17:20:12 -0400
X-MC-Unique: 6-W6HPB8N8WVZlc0NbtdZw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C63E811E7D;
        Wed,  1 Nov 2023 21:20:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8832E2166B26;
        Wed,  1 Nov 2023 21:20:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20231101202302.GB32034@redhat.com>
References: <20231101202302.GB32034@redhat.com> <20231027095842.GA30868@redhat.com> <1952182.1698853516@warthog.procyon.org.uk>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-afs@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rxrpc_find_service_conn_rcu: use read_seqbegin() rather than read_seqbegin_or_lock()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1959031.1698873608.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 01 Nov 2023 21:20:08 +0000
Message-ID: <1959032.1698873608@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> wrote:

> > 	1	0	need_seqretry() [seq=3Deven; sequence!=3Dseq: retry]
>
> Yes, if CPU_1 races with write_seqlock() need_seqretry() returns true,
>
> > 	1	1	read_seqbegin_or_lock() [exclusive]
>
> No. "seq" is still even, so read_seqbegin_or_lock() won't do read_seqloc=
k_excl(),
> it will do

Yeah, you're right.  I missed the fact that I got in the second example th=
at
read_seqbegin_or_lock() spins until it sees a positive seq.

However, I think just changing all of these to always-lockless isn't
necessarily the most optimal way.  Yes, it will work... eventually.  But t=
he
point is to limit the number of iterations.

So I have the following:

 (1) rxrpc_find_service_conn_rcu().

     I want to move the first part of the reaper to the I/O thread at some
     point, then the locking here can go away entirely.  However, this is
     drivable by external events, so I would prefer to limit the number of
     passes to just two and take a lock on the second pass.  Holding up th=
e
     reaper thread for the moment is fine; holding up the I/O thread is no=
t.

 (2) afs_lookup_volume_rcu().

     There can be a lot of volumes known by a system.  A thousand would
     require a 10-step walk and this is drivable by remote operation, so I
     think this should probably take a lock on the second pass too.

 (3) afs_check_validity().
 (4) afs_get_attr().

     These are both pretty short, so your solution is probably good for th=
em.
     That said, afs_vnode_commit_status() can spend a long time under the
     write lock - and pretty much every file RPC op returns a status updat=
e.

 (5) afs_find_server().

     There could be a lot of servers in the list and each server can have
     multiple addresses, so I think this would be better with an exclusive
     second pass.

     The server list isn't likely to change all that often, but when it do=
es
     change, there's a good chance several servers are going to be
     added/removed one after the other.  Further, this is only going to be
     used for incoming cache management/callback requests from the server,
     which hopefully aren't going to happen too often - but it is remotely
     drivable.

 (6) afs_find_server_by_uuid().

     Similarly to (5), there could be a lot of servers to search through, =
but
     they are in a tree not a flat list, so it should be faster to process=
.
     Again, it's not likely to change that often and, again, when it does
     change it's likely to involve multiple changes.  This can be driven
     remotely by an incoming cache management request but is mostly going =
to
     be driven by setting up or reconfiguring a volume's server list -
     something that also isn't likely to happen often.

I wonder if struct seqlock would make more sense with an rwlock rather tha=
n a
spinlock.  As it is, it does an exclusive spinlock for the readpath which =
is
kind of overkill.

David

