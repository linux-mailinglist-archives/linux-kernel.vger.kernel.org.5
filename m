Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE817A75FC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 10:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbjITIgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 04:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbjITIgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:36:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFCA90
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 01:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695198964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fyO783HFK2K9KUO8v9jboxC20XyrMbrsezvU6yX9E9k=;
        b=BUuIogEUFPDjGR2kSjBoCYc5+xKLQ8h7AkEgkI0O816rVFMtA9gcvL57NorH5lqYy6i13w
        llFEzj0W41Kr7uJ2GvAVcFFga2P9KH+ht3p2oC/+VRQ2F/HkqMFKHf35Mvv6nkwK2nM8Se
        Ji2ebRyM58X+9UtUkEIkwXcgp31wA1M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-185-W7EXuqRtMya6E5jYoYDVdw-1; Wed, 20 Sep 2023 04:35:59 -0400
X-MC-Unique: W7EXuqRtMya6E5jYoYDVdw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07DAE811E7B;
        Wed, 20 Sep 2023 08:35:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9792640C6EBF;
        Wed, 20 Sep 2023 08:35:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAF=yD-+kRXmwuKHVrUUL6oBPhWiPKucm_5-Y+YM==9Bp3DQiGQ@mail.gmail.com>
References: <CAF=yD-+kRXmwuKHVrUUL6oBPhWiPKucm_5-Y+YM==9Bp3DQiGQ@mail.gmail.com> <75315.1695139973@warthog.procyon.org.uk>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     dhowells@redhat.com, netdev@vger.kernel.org,
        syzbot+62cbf263225ae13ff153@syzkaller.appspotmail.com,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipv4, ipv6: Fix handling of transhdrlen in __ip{,6}_append_data()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <108653.1695198956.1@warthog.procyon.org.uk>
Date:   Wed, 20 Sep 2023 09:35:56 +0100
Message-ID: <108654.1695198956@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:

> The proposed fix is non-trivial, and changes not just the new path
> that observes the issue (MSG_SPLICE_PAGES), but also the other more
> common paths that exercise __ip6_append_data.

I realise that.  I broke ping/ping6 briefly, but I corrected that (I
subtracted the ICMP header len from length after copying it out, but forgot
that it needed adding back on for the return value of sendmsg()).  But I don't
think there are that many callers - however, you might be right that this is
too big for a fix.

> There is significant risk to introduce an unintended side effect
> requiring a follow-up fix. Because this function is notoriously
> complex, multiplexing a lot of behavior: with and without transport
> headers, edge cases like fragmentation, MSG_MORE, absence of
> scatter-gather, ....

The problem is that the bug isn't in __ip{,6}_append_data(), I think, it's
actually higher up in ip{,6}_append_data().  I think I see *why* length has
transhdrlen handed into it: because ping and raw sockets come with that
pre-added-in by userspace.

I would actually like to eliminate the length argument entirely and use the
length in the iterator - but that doesn't work in all cases as sometimes there
isn't a msghdr struct.  (And, besides, that's too big a change for a fix).

I think the simplest fix, then, is just to make ip{,6}_append_data() subtract
transhdrlen from length before clearing transhdrlen when there's already a
packet in the queue from MSG_MORE/cork that will be appended to.

> Does the issue discovered only affect MSG_SPLICE_PAGES or can it
> affect other paths too? If the first, it possible to create a more
> targeted fix that can trivially be seen to not affect code prior to
> introduction of splice pages?

It may also affect MSG_ZEROCOPY in interesting ways.  msg_zerocopy_realloc()
looks suspicious as it does things with 'size' bytes from the buffer that
doesn't have 'size' bytes of data in it (because size (aka length) includes
transhdrlen).

I would guess that we don't notice issues with ping sockets because people
don't often use MSG_MORE/corking with them.

Raw sockets shouldn't exhibit this bug as they set transhdrlen to 0 up front,
but I can't help but wonder what the consequences are as some bits of
__ip*_append_data() change behaviour if they see transhdrlen==0 :-/

David

