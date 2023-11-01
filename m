Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDA27DE7B2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjKAVyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 17:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjKAVyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 17:54:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3027110
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 14:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698875604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nVOrNNEvEeNpHZhIU0FeOrFYxSmUjF+L9aGYQKszoBM=;
        b=YGSgh/vjlTeO8VRbDemRtCqVjmx+kAOLMEIkvarTCphR8+sAXLXgr2Q2MV7StyiTK4phBL
        iSik0sJT7LqbE/BfVS7NZy3/RT34Vh9PI9wL3Ea7b0PEeTRmWwJuA9RHJiM/xPMTp+1djD
        MwcrsAJKIOKnFKr4O7UzM/Mg5/Tmeoc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-HQtPyiL5MASzO23C9z4MFQ-1; Wed,
 01 Nov 2023 17:53:20 -0400
X-MC-Unique: HQtPyiL5MASzO23C9z4MFQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3FC3299E74C;
        Wed,  1 Nov 2023 21:53:19 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.94])
        by smtp.corp.redhat.com (Postfix) with SMTP id 67D5F25C0;
        Wed,  1 Nov 2023 21:53:17 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed,  1 Nov 2023 22:52:18 +0100 (CET)
Date:   Wed, 1 Nov 2023 22:52:15 +0100
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
Message-ID: <20231101215214.GD32034@redhat.com>
References: <20231027095842.GA30868@redhat.com>
 <1952182.1698853516@warthog.procyon.org.uk>
 <20231101202302.GB32034@redhat.com>
 <20231101205238.GI1957730@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101205238.GI1957730@ZenIV>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01, Al Viro wrote:
>
> On Wed, Nov 01, 2023 at 09:23:03PM +0100, Oleg Nesterov wrote:
>
> > Yes this is confusing. Again, even the documentation is wrong! That is why
> > I am trying to remove the misuse of read_seqbegin_or_lock(), then I am going
> > to change the semantics of need_seqretry() to enforce the locking on the 2nd
> > pass.
>
> What for?  Sure, documentation needs to be fixed,

So do you agree that the current usage of read_seqbegin_or_lock() in
rxrpc_find_service_conn_rcu() is misleading ? Do you agree it can use
read_seqbegin/read_seqretry without changing the current behaviour?

> but *not* in direction you
> suggested in that patch.

Hmm. then how do you think the doc should be changed? To describe the
current behaviour.

> Why would you want to force that "switch to locked on the second pass" policy
> on every possible caller?

Because this is what (I think) read_seqbegin_or_lock() is supposed to do.
It should take the lock for writing if the lockless access failed. At least
according to the documentation.

This needs another discussion and perhaps this makes no sense. But I'd
like to turn need_seqretry(seq) into something like

	static inline int need_seqretry(seqlock_t *lock, int *seq)
	{
		int ret = !(*seq & 1) && read_seqretry(lock, *seq);

		if (ret)
			*seq = 1; /* make this counter odd */

		return ret;
	}

and update the users which actually want read_seqlock_excl() on the 2nd pass.
thread_group_cputime(), fs/d_path.c and fs/dcache.c.

For example, __dentry_path()

	--- a/fs/d_path.c
	+++ b/fs/d_path.c
	@@ -349,10 +349,9 @@ static char *__dentry_path(const struct dentry *d, struct prepend_buffer *p)
		}
		if (!(seq & 1))
			rcu_read_unlock();
	-	if (need_seqretry(&rename_lock, seq)) {
	-		seq = 1;
	+	if (need_seqretry(&rename_lock, &seq))
			goto restart;
	-	}
	+
		done_seqretry(&rename_lock, seq);
		if (b.len == p->len)
			prepend_char(&b, '/');


but again, this need another discussion.

Oleg.

