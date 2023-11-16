Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6747EE2A1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345279AbjKPOVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjKPOVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:21:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5B098
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700144462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pxIHMy1jStSlXKk4rbe3EcR1OULcVtQOqDxTS1hZNME=;
        b=Me+uTHYCgxFhpFueKUIfISAFFGnvLJTXvOH9Wwfm8LkuoVISf3xIuzSD9Z+bc/HUtBxHBP
        IfsKxIlh2TjV3tzSFhddRtEuedDnT/dOLyXcSprXwdShb4P3+vxJ1F+bCfmdeAFNStVY+n
        Ohvl6jku6jqV06VW6LBNQw5Y4eWErIM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-DhZgHQikMbqcUie3tF82xw-1; Thu, 16 Nov 2023 09:20:59 -0500
X-MC-Unique: DhZgHQikMbqcUie3tF82xw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 828F1185A788;
        Thu, 16 Nov 2023 14:20:58 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.23])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3AC2BC15881;
        Thu, 16 Nov 2023 14:20:56 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 16 Nov 2023 15:19:54 +0100 (CET)
Date:   Thu, 16 Nov 2023 15:19:51 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-afs@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rxrpc_find_service_conn_rcu: use read_seqbegin() rather
 than read_seqbegin_or_lock()
Message-ID: <20231116141951.GE18748@redhat.com>
References: <20231116131849.GA27763@redhat.com>
 <20231027095842.GA30868@redhat.com>
 <104932.1700142106@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <104932.1700142106@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16, David Howells wrote:
>
> Oleg Nesterov <oleg@redhat.com> wrote:
>
> > So do you agree that
> >
> > 	- the usage of read_seqbegin_or_lock/need_seqretry in
> > 	  this code makes no sense because read_seqlock_excl()
> > 	  is not possible
>
> Not exactly.  I think it should take a lock on the second pass.

OK, then how about the patch below?

Again, I'd prefer to change the semantics/prototype of need_seqretry()
to enforce the locking on the 2nd pass "automatically", but a) this
needs more discussion and b) I can't do this before I update the users
which use read_seqbegin_or_lock/need_seqretry incorrectly. So lets
discuss this later.

Oleg.

--- a/net/rxrpc/conn_service.c
+++ b/net/rxrpc/conn_service.c
@@ -25,7 +25,7 @@ struct rxrpc_connection *rxrpc_find_service_conn_rcu(struct rxrpc_peer *peer,
 	struct rxrpc_conn_proto k;
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	struct rb_node *p;
-	unsigned int seq = 0;
+	unsigned int seq = 1;
 
 	k.epoch	= sp->hdr.epoch;
 	k.cid	= sp->hdr.cid & RXRPC_CIDMASK;
@@ -35,6 +35,7 @@ struct rxrpc_connection *rxrpc_find_service_conn_rcu(struct rxrpc_peer *peer,
 		 * under just the RCU read lock, so we have to check for
 		 * changes.
 		 */
+		seq++; /* 2 on the 1st/lockless path, otherwise odd */
 		read_seqbegin_or_lock(&peer->service_conn_lock, &seq);
 
 		p = rcu_dereference_raw(peer->service_conns.rb_node);

