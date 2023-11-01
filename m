Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B997DE8D1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 00:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346285AbjKAXS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 19:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjKAXSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 19:18:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14A5A6
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 16:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698880689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K5Z5/0jEKUR78SsGzTEQP0lgV6IDugZghhgxYociaAs=;
        b=FQY6aLGDDR2yPwztk1aQ9xHKRAluSd4ZvqqoxjD12A6zcb+7CUV0OBkzBxfnzTVnURzOxk
        zsccJ7uG+PBNA481cxFLVDuyx4qTbELoZVgN4hx04WIxV2OJjSJ8FnCOl4TpGfRdf6ZUxh
        FxMJ64X4qDXGTL3qs7Xh17dIQ8YKpHI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-eNuOVGxUOSWptyh3OQndMQ-1; Wed,
 01 Nov 2023 19:18:07 -0400
X-MC-Unique: eNuOVGxUOSWptyh3OQndMQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3C494381AE47;
        Wed,  1 Nov 2023 23:18:07 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.94])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8A4F62026D4C;
        Wed,  1 Nov 2023 23:18:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  2 Nov 2023 00:17:05 +0100 (CET)
Date:   Thu, 2 Nov 2023 00:17:02 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-afs@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rxrpc_find_service_conn_rcu: use read_seqbegin() rather
 than read_seqbegin_or_lock()
Message-ID: <20231101231701.GH32034@redhat.com>
References: <20231027095842.GA30868@redhat.com>
 <1952182.1698853516@warthog.procyon.org.uk>
 <20231101202302.GB32034@redhat.com>
 <20231101205238.GI1957730@ZenIV>
 <20231101215214.GD32034@redhat.com>
 <20231101224855.GJ1957730@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101224855.GJ1957730@ZenIV>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01, Al Viro wrote:
>
> On Wed, Nov 01, 2023 at 10:52:15PM +0100, Oleg Nesterov wrote:
>
> > > Why would you want to force that "switch to locked on the second pass" policy
> > > on every possible caller?
> >
> > Because this is what (I think) read_seqbegin_or_lock() is supposed to do.
> > It should take the lock for writing if the lockless access failed. At least
> > according to the documentation.
>
> Not really - it's literally seqbegin or lock, depending upon what the caller
> tells it...

OK, I won't argue right now. But again, this patch doesn't change the current
behaviour. Exactly because the caller does NOT tell read_seqbegin_or_lock() that
it wants "or lock" on the 2nd pass.

> Take a look at d_walk() and try to shoehorn that into your variant.  Especially
> the D_WALK_NORETRY handling...

I am already sleeping, quite possibly I am wrong. But it seems that if we change
done_seqretry() then d_walk() needs something like

	--- a/fs/dcache.c
	+++ b/fs/dcache.c
	@@ -1420,7 +1420,7 @@ static void d_walk(struct dentry *parent, void *data,
			spin_lock(&this_parent->d_lock);
	 
			/* might go back up the wrong parent if we have had a rename. */
	-		if (need_seqretry(&rename_lock, seq))
	+		if (need_seqretry(&rename_lock, &seq))
				goto rename_retry;
			/* go into the first sibling still alive */
			do {
	@@ -1432,22 +1432,20 @@ static void d_walk(struct dentry *parent, void *data,
			rcu_read_unlock();
			goto resume;
		}
	-	if (need_seqretry(&rename_lock, seq))
	+	if (need_seqretry(&rename_lock, &seq))
			goto rename_retry;
		rcu_read_unlock();
	 
	 out_unlock:
		spin_unlock(&this_parent->d_lock);
	-	done_seqretry(&rename_lock, seq);
	+	done_seqretry(&rename_lock, &seq);
		return;
	 
	 rename_retry:
		spin_unlock(&this_parent->d_lock);
		rcu_read_unlock();
	-	BUG_ON(seq & 1);
		if (!retry)
			return;
	-	seq = 1;
		goto again;
	 }


But again, again, this is off-topic and needs another discussion. Right now I am just
trying to audit the users of read_seqbegin_or_lock/need_seqretry and change those who
use them incorrectly.

Oleg.

