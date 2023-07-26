Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914C376342D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 12:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbjGZKrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 06:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjGZKra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 06:47:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B54FE63
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 03:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690368403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lvJT1Nrqg3NuKZyozBDgNxTT7my/YGr0ImgVXCIWT+Q=;
        b=IJYVETPWCxzI0TsKUF03iS5J6N/60kYHXAgUCF8Yiv+YPO/nyFz7YlCF1S9G0GDGB93pQ6
        TNNDzF7dmQKPSK3FSPHhDQefUzoJEv/V/oMw53QHDK4cs3wOYZO00a6HivQ75ugmmZ8OsC
        D3XjeOx7P8pHNH8Te2Jdif8lcLcZqPw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-341-FPRlPA5MOl2fS2zC8T9MoQ-1; Wed, 26 Jul 2023 06:46:40 -0400
X-MC-Unique: FPRlPA5MOl2fS2zC8T9MoQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 503CE892240;
        Wed, 26 Jul 2023 10:46:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3FA5240C2063;
        Wed, 26 Jul 2023 10:46:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <0000000000000ced8905fecceeba@google.com>
References: <0000000000000ced8905fecceeba@google.com>
To:     syzbot <syzbot+0bc501b7bf9e1bc09958@syzkaller.appspotmail.com>
Cc:     dhowells@redhat.com, davem@davemloft.net,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [crypto?] general protection fault in shash_async_update
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20271.1690368398.1@warthog.procyon.org.uk>
Date:   Wed, 26 Jul 2023 11:46:38 +0100
Message-ID: <20272.1690368398@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

#syz fix: crypto: af_alg/hash: Fix recvmsg() after sendmsg(MSG_MORE)

