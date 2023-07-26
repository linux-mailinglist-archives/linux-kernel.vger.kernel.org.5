Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F01762FFB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbjGZIhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbjGZIhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:37:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C86C4EDD
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690359932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aeQuLi++SQHFpVVi2gTFekFdVrx5XJGUiFscGV8s7L8=;
        b=X/dldOHxbevdZD9fSssoANqjyf8kIxDQY6OwFsW0WGzY5zMoAVg0yrZIFrlmRLA0+tu4bY
        TvLSHHVOu+d2z8c9eVJ7kMeupERJsQbiSuEqrYDZPedSLEjPa5yvn0LXEOTu5irRoUBsvp
        uoolRmJDJgDnJWTpI/0KxWt7e7Oeh1I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-180-hJ7vv31jNuqszxCiSc-tUw-1; Wed, 26 Jul 2023 04:25:27 -0400
X-MC-Unique: hJ7vv31jNuqszxCiSc-tUw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 881B0894EDA;
        Wed, 26 Jul 2023 08:25:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.242])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC98C492CA6;
        Wed, 26 Jul 2023 08:25:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <yt9d8rb44cbe.fsf@linux.ibm.com>
References: <yt9d8rb44cbe.fsf@linux.ibm.com> <000000000000273d0105ff97bf56@google.com>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     dhowells@redhat.com,
        syzbot <syzbot+9b82859567f2e50c123e@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: Re: [syzbot] [mm?] WARNING in try_grab_page
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <125070.1690359924.1@warthog.procyon.org.uk>
Date:   Wed, 26 Jul 2023 09:25:24 +0100
Message-ID: <125071.1690359924@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Schnelle <svens@linux.ibm.com> wrote:

> However, hash_sendmsg() also unpins via af_alg_free_sg() in the error
> path. From an API perspective, i would prefer if extract_user_to_sg()
> does the unpinning on error. Any thoughts?

In the event of an error, extract_user_to_sg() unpins only the pages it added
to the scatterlist; it doesn't unpin any pages that were already there and
doesn't free the scatterlist; it also decrements sgtable->nents so that the
caller doesn't see the pages it attempted to add, so calling af_alg_free_sg()
shouldn't hurt.

Note that the error path also frees the result, so we do need to do at least
part of it.

David

