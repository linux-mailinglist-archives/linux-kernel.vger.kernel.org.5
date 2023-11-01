Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2AF7DE729
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346411AbjKAUZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 16:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjKAUZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 16:25:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8751C2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 13:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698870251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sOSUTYODY3s3dQC+LMM2Wx0F9jbAg04FBi/zoSh47ZA=;
        b=MGAGQBd70qeKAUILdfpNhJ7nJdTkhwNJUZLI8BSmuEwhqdWIPIf7+QbUA+LuKSxQop5IcW
        KW0Lr/a4jqbYoMkAIlH3uLdZdjaCke0wRhlVR+gUsEHxQMIuX6bSoz1M1+ILFSM8xtJSqt
        jkanc1DHI2+CWmBEFPixz7HzfypeF+0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-psFQYNJxPYC0ZuysJrnt1Q-1; Wed, 01 Nov 2023 16:24:08 -0400
X-MC-Unique: psFQYNJxPYC0ZuysJrnt1Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E8588185A780;
        Wed,  1 Nov 2023 20:24:07 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.94])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7436D1121308;
        Wed,  1 Nov 2023 20:24:05 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed,  1 Nov 2023 21:23:06 +0100 (CET)
Date:   Wed, 1 Nov 2023 21:23:03 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-afs@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rxrpc_find_service_conn_rcu: use read_seqbegin() rather
 than read_seqbegin_or_lock()
Message-ID: <20231101202302.GB32034@redhat.com>
References: <20231027095842.GA30868@redhat.com>
 <1952182.1698853516@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1952182.1698853516@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01, David Howells wrote:
>
> Oleg Nesterov <oleg@redhat.com> wrote:
>
> > read_seqbegin_or_lock() makes no sense unless you make "seq" odd
> > after the lockless access failed.
>
> I think you're wrong.

I think you missed the point ;)

> write_seqlock() turns it odd.

It changes seqcount_t->sequence but not "seq" so this doesn't matter.

> For instance, if the read lock is taken first:
>
> 	sequence seq	CPU 1				CPU 2
> 	======= =======	===============================	===============
> 	0
> 	0	0	seq = 0  MUST BE EVEN

This is correct,

> ACCORDING TO DOC

documentation is wrong, please see

	[PATCH 1/2] seqlock: fix the wrong read_seqbegin_or_lock/need_seqretry documentation
	https://lore.kernel.org/all/20231024120808.GA15382@redhat.com/

> 	0	0	read_seqbegin_or_lock() [lockless]
> 			...
> 	1	0					write_seqlock()
> 	1	0	need_seqretry() [seq=even; sequence!=seq: retry]

Yes, if CPU_1 races with write_seqlock() need_seqretry() returns true,

> 	1	1	read_seqbegin_or_lock() [exclusive]

No. "seq" is still even, so read_seqbegin_or_lock() won't do read_seqlock_excl(),
it will do

	seq = read_seqbegin(lock);

again.

> Note that it spins in __read_seqcount_begin() until we get an even seq,
> indicating that no write is currently in progress - at which point we can
> perform a lockless pass.

Exactly. And this means that "seq" is always even.

> > See thread_group_cputime() as an example, note that it does nextseq = 1 for
> > the 2nd round.
>
> That's not especially convincing.

See also the usage of read_seqbegin_or_lock() in fs/dcache.c and fs/d_path.c.
All other users are wrong.

Lets start from the very beginning. This code does

        int seq = 0;
        do {
                read_seqbegin_or_lock(service_conn_lock, &seq);

                do_something();

        } while (need_seqretry(service_conn_lock, seq));

        done_seqretry(service_conn_lock, seq);

Initially seq is even (it is zero), so read_seqbegin_or_lock(&seq) does

	*seq = read_seqbegin(lock);

and returns. Note that "seq" is still even.

Now. If need_seqretry(seq) detects the race with write_seqlock() it returns
true but it does NOT change this "seq", it is still even. So on the next
iteration read_seqbegin_or_lock() will do

	*seq = read_seqbegin(lock);

again, it won't take this lock for writing. And again, seq will be even.
And so on.

And this means that the code above is equivalent to

	do {
		seq = read_seqbegin(service_conn_lock);

		do_something();

	} while (read_seqretry(service_conn_lock, seq));

and this is what this patch does.

Yes this is confusing. Again, even the documentation is wrong! That is why
I am trying to remove the misuse of read_seqbegin_or_lock(), then I am going
to change the semantics of need_seqretry() to enforce the locking on the 2nd
pass.

Oleg.

