Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DD27F7857
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345895AbjKXPxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjKXPxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:53:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC0319A2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700841234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p6KID36QJgaLKX8qd4kBeMGTdnpd7Zl3i2+K28yL5TI=;
        b=Yi04LtMk7ba/gXI8nPPqxxAApyIB+WGEZSxebpi44sgeRXesGiVMcVUQOtz31NTCpTzWKS
        FoXiL9XeIKq0fd/G/fpipxi6W20Ur3tpzZQcKg3LbYZFmAfAS25IcBhTSInoQKJOnAw2bW
        nRrFmYFQwLdbRmhUNCYnIy1+0RQZrgc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-16V90mzhNPKi9sxTe4Uqvw-1; Fri, 24 Nov 2023 10:53:50 -0500
X-MC-Unique: 16V90mzhNPKi9sxTe4Uqvw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4E6A821938;
        Fri, 24 Nov 2023 15:53:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 85D5340C6EBB;
        Fri, 24 Nov 2023 15:53:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20231124150822.2121798-1-jannh@google.com>
References: <20231124150822.2121798-1-jannh@google.com>
To:     Jann Horn <jannh@google.com>
Cc:     dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] fs/pipe: Fix lockdep false-positive in watchqueue pipe_write()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1210482.1700841227.1@warthog.procyon.org.uk>
Date:   Fri, 24 Nov 2023 15:53:47 +0000
Message-ID: <1210483.1700841227@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jann Horn <jannh@google.com> wrote:

> +	/*
> +	 * Reject writing to watch queue pipes before the point where we lock
> +	 * the pipe.
> +	 * Otherwise, lockdep would be unhappy if the caller already has another
> +	 * pipe locked.
> +	 * If we had to support locking a normal pipe and a notification pipe at
> +	 * the same time, we could set up lockdep annotations for that, but
> +	 * since we don't actually need that, it's simpler to just bail here.
> +	 */
> +	if (pipe_has_watch_queue(pipe))
> +		return -EXDEV;
> +

Linus wanted it to be possible for the user to write to a notificaiton pipe.

David

