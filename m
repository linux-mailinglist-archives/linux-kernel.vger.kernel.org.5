Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C622E7DE400
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343887AbjKAPqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbjKAPqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:46:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70662115
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 08:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698853523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sZfmnba+tHGz8pqoH154foHS+YLTOXshRrCAdJjTAkk=;
        b=fyYXbe5WhIy7TlCvLlDqCHtj1qr1uTDdUoAEMpr4cShCVYqLq+JR6aPXaTIlqGnqfJoUt+
        sWXFp9f+Dp5QiCMw80TPWbdf9KEJu/d2DxLUXzb9d/atOZNfWUeeWvfTxElBKOlEVDx7iC
        LXjnPU/pGEGfHAemGyo6PmRoCuhr8+Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-rUr5MMA-OZqMoERtx8pLZQ-1; Wed, 01 Nov 2023 11:45:20 -0400
X-MC-Unique: rUr5MMA-OZqMoERtx8pLZQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 69EB1811E88;
        Wed,  1 Nov 2023 15:45:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BCFC1C1290F;
        Wed,  1 Nov 2023 15:45:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20231027095842.GA30868@redhat.com>
References: <20231027095842.GA30868@redhat.com>
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
Content-ID: <1952181.1698853516.1@warthog.procyon.org.uk>
Date:   Wed, 01 Nov 2023 15:45:16 +0000
Message-ID: <1952182.1698853516@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
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

> read_seqbegin_or_lock() makes no sense unless you make "seq" odd
> after the lockless access failed.

I think you're wrong.

write_seqlock() turns it odd.  For instance, if the read lock is taken first:

	sequence seq	CPU 1				CPU 2
	======= =======	===============================	===============
	0
	0	0	seq = 0 // MUST BE EVEN ACCORDING TO DOC
	0	0	read_seqbegin_or_lock() [lockless]
			...
	1	0					write_seqlock()
	1	0	need_seqretry() [seq=even; sequence!=seq: retry]
	1	1	read_seqbegin_or_lock() [exclusive]
			-->spin_lock(lock);
	2	1					write_sequnlock()
			<--locked
			...
	2	1	need_seqretry()

However, if the write lock is taken first:

	sequence seq	CPU 1				CPU 2
	======= =======	===============================	===============
	0
	1						write_seqlock()
	1	0	seq = 0 // MUST BE EVEN ACCORDING TO DOC
	1	0	read_seqbegin_or_lock() [lockless]
	1	0	    __read_seqcount_begin()
				while (lock.sequence is odd)
				    cpu_relax();
	2	0					write_sequnlock()
	2	2		[loop end]
			...
	2	2	need_seqretry() [seq=even; sequence==seq; done]

Note that it spins in __read_seqcount_begin() until we get an even seq,
indicating that no write is currently in progress - at which point we can
perform a lockless pass.

> See thread_group_cputime() as an example, note that it does nextseq = 1 for
> the 2nd round.

That's not especially convincing.

David

