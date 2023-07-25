Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA66760F40
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbjGYJch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbjGYJcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:32:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AE149D9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 02:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690277320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sEazEufWpuKqGd34fMKGXo4/JvPtrORfhv+OR2dpzwM=;
        b=JcoCjXC+b9D7Kk+/BrRo63OAcgTqmlLBp3rz81xCQdmJ0tSH3uLAyrUiTfScaEfOIZIYqV
        9pTYQ3M6aiDbY0Z21au1T6s2y3Rhuo0+1xMmJ79pNokX2nuSd1Urd490ZvNATFp4gvWWOM
        EJHqnRhBl3NpHRuAWfbkINiTqqpMOGw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-323-8P4AcTE3Pu-gWY6rNBdgIw-1; Tue, 25 Jul 2023 05:28:35 -0400
X-MC-Unique: 8P4AcTE3Pu-gWY6rNBdgIw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4DA1F8910F6;
        Tue, 25 Jul 2023 09:28:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1A6BD2166B25;
        Tue, 25 Jul 2023 09:28:31 +0000 (UTC)
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
Content-ID: <35255.1690277311.1@warthog.procyon.org.uk>
Date:   Tue, 25 Jul 2023 10:28:31 +0100
Message-ID: <35256.1690277311@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

> 
> I looked into this issue. What syzkaller is doing is opening an AF_ALG
> socket, and sending a large message which will eventually end in -EFAULT.
> Looking at the code in crypto/algif_hash.c i see that hash_sendmsg is
> calling extract_iter_to_sg() -> extract_user_to_sg(). In the -EFAULT
> case, this function is calling put_page(), which looks like a leftover
> from the old pinning interface. I think this should be a
> unpin_user_page() call now.
> 
> However, hash_sendmsg() also unpins via af_alg_free_sg() in the error
> path. From an API perspective, i would prefer if extract_user_to_sg()
> does the unpinning on error. Any thoughts?

Good catch, thanks.  I'll whip up a patch or two for it.

David

