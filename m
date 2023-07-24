Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADE17600EC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjGXVNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjGXVNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:13:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CF0139
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690233164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O8sFspJ6yj+eCxeZqAHjPla/aQR+z7WDcRwKjnIXzQ4=;
        b=OviwhOf/093xyq4hG6z4lwaie2YUj8m3grzgQ3PCDnQvE5e3xiC0yyG3/I0TIyzTuuEntd
        955bc3OfP2p11UNXsqVqMrWAHxXQUuWV5bGUtLmNLqQJbjtv+TaMu6XtoANxsHNBDdcCs9
        X+YEJCjfRTlke39OLQgvG6znSd+LkyY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-mDvfChxTP5yqX4wvw44WDQ-1; Mon, 24 Jul 2023 17:12:41 -0400
X-MC-Unique: mDvfChxTP5yqX4wvw44WDQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A1609800B35;
        Mon, 24 Jul 2023 21:12:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5548A201F11C;
        Mon, 24 Jul 2023 21:12:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <000000000000836b2805fffd6d7e@google.com>
References: <000000000000836b2805fffd6d7e@google.com>
To:     syzbot <syzbot+6f66f3e78821b0fff882@syzkaller.appspotmail.com>
Cc:     dhowells@redhat.com, akpm@linux-foundation.org, axboe@kernel.dk,
        herbert@gondor.apana.org.au, kuba@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] KASAN: slab-out-of-bounds Read in bio_split_rw
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19654.1690233158.1@warthog.procyon.org.uk>
Date:   Mon, 24 Jul 2023 22:12:38 +0100
Message-ID: <19655.1690233158@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz dup: [syzbot] [ext4?] general protection fault in ext4_finish_bio

