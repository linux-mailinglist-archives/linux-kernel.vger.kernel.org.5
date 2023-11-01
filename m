Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1110A7DE767
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344864AbjKAVX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 17:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbjKAVX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 17:23:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1088E121
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 14:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698873757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j4Q5+IwvvLZciE9qd6dWmjNxBjBLvEzq9VGta2vDxk4=;
        b=DfPUQ2NcDCxE0extyQGpHKWkgsxsL95Et5Xe2YVJO2CGvdLxAvCi9nb13xFoBEOurLkW6g
        FkyYY+Kv7k7N/V/vY8EunmqYGb8u2Q3/1dbEsveHseEKcVMbpZDvEWTSeTO/JqZ9fLfitx
        0m0Pme8188J1Kqrkw0dMHn6f+mXWRJE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-0sCK311YMxGieL5ndhB_xg-1; Wed, 01 Nov 2023 17:22:33 -0400
X-MC-Unique: 0sCK311YMxGieL5ndhB_xg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55D8C101A529;
        Wed,  1 Nov 2023 21:22:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E7CC91C060BA;
        Wed,  1 Nov 2023 21:22:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20231101204023.GC32034@redhat.com>
References: <20231101204023.GC32034@redhat.com> <20231027095842.GA30868@redhat.com> <1952182.1698853516@warthog.procyon.org.uk> <20231101202302.GB32034@redhat.com>
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
Content-ID: <1959104.1698873750.1@warthog.procyon.org.uk>
Date:   Wed, 01 Nov 2023 21:22:30 +0000
Message-ID: <1959105.1698873750@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> wrote:

> Just none of read_seqbegin_or_lock/need_seqretry/done_seqretry
> helpers make any sense in this code.

I disagree.  I think in at least a couple of cases I do want a locked second
path - ideally locked shared if seqlock can be made to use an rwlock instead
of a spinlock.

David

