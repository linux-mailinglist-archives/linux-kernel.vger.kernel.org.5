Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C95A7DE831
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 23:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346000AbjKAWkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 18:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345464AbjKAWkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 18:40:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E3E10F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 15:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698878373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ABjpd7eCaubuoIcAkCypOQuyi+R5D9nKjFaDL8m4KlI=;
        b=anpTaFnNyQ+THdliC5gFnwW2/RVDMmgbb89T+j8vVHk79Y0XlemXe7jmua7hbkibdSzDcz
        wUDhjy4ABIrSzZCNW7IqsvStgeRCXCjPo4D6lTczCaQldJ8lZRO+R4+5sTUXOi/oUGGiTs
        wTn949JMtrwdcv6zFEnPCCSLSZmkoUw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-WkyWT0aEOriCjiNgzwuYEg-1; Wed, 01 Nov 2023 18:39:30 -0400
X-MC-Unique: WkyWT0aEOriCjiNgzwuYEg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 82BB3101A529;
        Wed,  1 Nov 2023 22:39:29 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.94])
        by smtp.corp.redhat.com (Postfix) with SMTP id E73D3492BFA;
        Wed,  1 Nov 2023 22:39:26 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed,  1 Nov 2023 23:38:28 +0100 (CET)
Date:   Wed, 1 Nov 2023 23:38:24 +0100
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
Message-ID: <20231101223824.GG32034@redhat.com>
References: <20231101204023.GC32034@redhat.com>
 <20231027095842.GA30868@redhat.com>
 <1952182.1698853516@warthog.procyon.org.uk>
 <20231101202302.GB32034@redhat.com>
 <1959105.1698873750@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1959105.1698873750@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01, David Howells wrote:
>
> Oleg Nesterov <oleg@redhat.com> wrote:
>
> > Just none of read_seqbegin_or_lock/need_seqretry/done_seqretry
> > helpers make any sense in this code.
>
> I disagree.  I think in at least a couple of cases I do want a locked second
> path

Sorry for confusion. I never said that the 2nd locked pass makes no sense.

My only point is that rxrpc_find_service_conn_rcu() (and more) use
read_seqbegin_or_lock() incorrectly. They can use read_seqbegin() and this
won't change the current behaviour.

So lets change these users first? Then we can discuss the possible changes
in include/linux/seqlock.h and (perhaps) update the users which actually
want the locking on the 2nd pass.

Oleg.

