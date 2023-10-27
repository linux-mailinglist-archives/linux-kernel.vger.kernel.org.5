Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCB67D9497
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbjJ0KCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjJ0KCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:02:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C5010E
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 03:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698400915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DTM6upIN3CjY9ys9ca+ckF+e8jrYVgwJYWZX7kJnPgo=;
        b=CtQRm/zY7cqXbyCC67qJDryKpUG9kMrlSVm/yhLimGExSLxm5Be1grXAgqxLelYaMAZt4e
        Z4rgziY/XzHhVNqRhHLK2PJjcUqim0PIR719JEWQqdCvFFYubw7jr0AvDhTIxO9zUlsIfG
        YGhyJSLgXUUbVKvtHkMPfTHyyyMJa7o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-gc3zwK0dMquWndlNB0j-Lw-1; Fri, 27 Oct 2023 06:01:52 -0400
X-MC-Unique: gc3zwK0dMquWndlNB0j-Lw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E711811E7B;
        Fri, 27 Oct 2023 10:01:51 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.76])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3CD8E492BE0;
        Fri, 27 Oct 2023 10:01:49 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 27 Oct 2023 12:00:50 +0200 (CEST)
Date:   Fri, 27 Oct 2023 12:00:47 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        linux-afs@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rxrpc_find_service_conn_rcu: use read_seqbegin() rather
 than read_seqbegin_or_lock()
Message-ID: <20231027100047.GA30884@redhat.com>
References: <20231027095842.GA30868@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027095842.GA30868@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27, Oleg Nesterov wrote:
>
> read_seqbegin_or_lock() makes no sense unless you make "seq" odd
> after the lockless access failed. See thread_group_cputime() as
> an example, note that it does nextseq = 1 for the 2nd round.

See also

	[PATCH 1/2] seqlock: fix the wrong read_seqbegin_or_lock/need_seqretry documentation
	https://lore.kernel.org/all/20231024120808.GA15382@redhat.com/

> So this code can use read_seqbegin() without changing the current
> behaviour.

I am trying to remove the misuse of read_seqbegin_or_lock(),
then I am going to turn need_seqretry() into

	static inline int need_seqretry(seqlock_t *lock, int *seq)
	{
		int ret = !(*seq & 1) && read_seqretry(lock, *seq);

		if (ret)
			*seq = 1; /* make this counter odd */

		return ret;
	}

Oleg.

