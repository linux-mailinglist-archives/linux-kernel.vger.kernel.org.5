Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDBB763019
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbjGZIl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjGZIl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:41:29 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDE77A9C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:31:39 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3a44fae8668so13387859b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690360298; x=1690965098;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=slflnYARMxwAnq+FavnIYKl6DmQW8tiUJPb2+/rDk3A=;
        b=PL3tMIpWzoSbDvQ9gck3+mWLGmcfHJ5CUN+ZSsxHlnlofNV7RvWDuUI0dAodf20SBR
         tYE6RyrZsqRY147vufs5cV+DgkjxzbQQbBFGEXBhLiTeROmqiGBy3Jw1l7C3zkeOlxRb
         bWErttS2/N7wxf0f+5pi9dN1qJh8930BiDJAB9EkQXIb4MpgftYFa0CHwzOQjI8hV4dE
         1CS75Y+w0qk/DV6daCFloh9zNaCZ6+KPwkbUssHjIhyTC1LEiLfgnX5FffCZvbBIctwB
         cCfiQdfUWgK3Pr9DJ2Ew/5PLZI+wWMl+L1YxGyM7JLXPiAxjqCvHk/VE7RCm3rgdvXp3
         3P6A==
X-Gm-Message-State: ABy/qLajgM5x7BURiKnFpvfxzmNlb2Lw83OAVPBV6BSqulgusI4Q/5xP
        vYtTnQEGse9aR/Pd1gUQ7TPkZibhM34vkONu4TXoAsc48nwk
X-Google-Smtp-Source: APBJJlFYUBuOQF/tuNkWITjCD1yJ9cdtmXwBYAYkcPJa00a06PIjacYQ7Jtab9Img4k/etHtHTOMz3d4B9BuQjK4FAObANzpcvWg
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3008:b0:3a4:3bab:3d3 with SMTP id
 ay8-20020a056808300800b003a43bab03d3mr3383392oib.10.1690360298320; Wed, 26
 Jul 2023 01:31:38 -0700 (PDT)
Date:   Wed, 26 Jul 2023 01:31:38 -0700
In-Reply-To: <125377.1690360290@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001fb79e06015fad1f@google.com>
Subject: Re: [syzbot] [mm?] WARNING in try_grab_page
From:   syzbot <syzbot+9b82859567f2e50c123e@syzkaller.appspotmail.com>
To:     dhowells@redhat.com
Cc:     akpm@linux-foundation.org, davem@davemloft.net,
        dhowells@redhat.com, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, svens@linux.ibm.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

This crash does not have a reproducer. I cannot test it.

>
> lib/scatterlist: Fix error handling in extract_iter_to_sg()
>
> Fix the error handling in extract_iter_to_sg().  Pages need to be unpinned,
> not put, and only if they actually got pinned (which is the case in
> extract_user_to_sg()).
>
> The bug may result in a warning like the following:
>
>   WARNING: CPU: 1 PID: 20384 at mm/gup.c:229 __lse_atomic_add arch/arm64/include/asm/atomic_lse.h:27 [inline]
>   WARNING: CPU: 1 PID: 20384 at mm/gup.c:229 arch_atomic_add arch/arm64/include/asm/atomic.h:28 [inline]
>   WARNING: CPU: 1 PID: 20384 at mm/gup.c:229 raw_atomic_add include/linux/atomic/atomic-arch-fallback.h:537 [inline]
>   WARNING: CPU: 1 PID: 20384 at mm/gup.c:229 atomic_add include/linux/atomic/atomic-instrumented.h:105 [inline]
>   WARNING: CPU: 1 PID: 20384 at mm/gup.c:229 try_grab_page+0x108/0x160 mm/gup.c:252
>   ...
>   pc : try_grab_page+0x108/0x160 mm/gup.c:229
>   lr : follow_page_pte+0x174/0x3e4 mm/gup.c:651
>   ...
>   Call trace:
>    __lse_atomic_add arch/arm64/include/asm/atomic_lse.h:27 [inline]
>    arch_atomic_add arch/arm64/include/asm/atomic.h:28 [inline]
>    raw_atomic_add include/linux/atomic/atomic-arch-fallback.h:537 [inline]
>    atomic_add include/linux/atomic/atomic-instrumented.h:105 [inline]
>    try_grab_page+0x108/0x160 mm/gup.c:252
>    follow_pmd_mask mm/gup.c:734 [inline]
>    follow_pud_mask mm/gup.c:765 [inline]
>    follow_p4d_mask mm/gup.c:782 [inline]
>    follow_page_mask+0x12c/0x2e4 mm/gup.c:839
>    __get_user_pages+0x174/0x30c mm/gup.c:1217
>    __get_user_pages_locked mm/gup.c:1448 [inline]
>    __gup_longterm_locked+0x94/0x8f4 mm/gup.c:2142
>    internal_get_user_pages_fast+0x970/0xb60 mm/gup.c:3140
>    pin_user_pages_fast+0x4c/0x60 mm/gup.c:3246
>    iov_iter_extract_user_pages lib/iov_iter.c:1768 [inline]
>    iov_iter_extract_pages+0xc8/0x54c lib/iov_iter.c:1831
>    extract_user_to_sg lib/scatterlist.c:1123 [inline]
>    extract_iter_to_sg lib/scatterlist.c:1349 [inline]
>    extract_iter_to_sg+0x26c/0x6fc lib/scatterlist.c:1339
>    hash_sendmsg+0xc0/0x43c crypto/algif_hash.c:117
>    sock_sendmsg_nosec net/socket.c:725 [inline]
>    sock_sendmsg+0x54/0x60 net/socket.c:748
>    ____sys_sendmsg+0x270/0x2ac net/socket.c:2494
>    ___sys_sendmsg+0x80/0xdc net/socket.c:2548
>    __sys_sendmsg+0x68/0xc4 net/socket.c:2577
>    __do_sys_sendmsg net/socket.c:2586 [inline]
>    __se_sys_sendmsg net/socket.c:2584 [inline]
>    __arm64_sys_sendmsg+0x24/0x30 net/socket.c:2584
>    __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
>    invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
>    el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
>    do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
>    el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
>    el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
>    el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
>
> Fixes: 018584697533 ("netfs: Add a function to extract an iterator into a scatterlist")
> Reported-by: syzbot+9b82859567f2e50c123e@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-mm/000000000000273d0105ff97bf56@google.com/
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Sven Schnelle <svens@linux.ibm.com>
> cc: akpm@linux-foundation.org
> cc: Herbert Xu <herbert@gondor.apana.org.au>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: Steve French <sfrench@samba.org>
> cc: Shyam Prasad N <nspmangalore@gmail.com>
> cc: Rohith Surabattula <rohiths.msft@gmail.com>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Herbert Xu <herbert@gondor.apana.org.au>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Eric Dumazet <edumazet@google.com>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: linux-mm@kvack.org
> cc: linux-crypto@vger.kernel.org
> cc: linux-cachefs@redhat.com
> cc: linux-cifs@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> cc: netdev@vger.kernel.org
> ---
>  lib/scatterlist.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/scatterlist.c b/lib/scatterlist.c
> index e86231a44c3d..c65566b4dc66 100644
> --- a/lib/scatterlist.c
> +++ b/lib/scatterlist.c
> @@ -1148,7 +1148,7 @@ static ssize_t extract_user_to_sg(struct iov_iter *iter,
>  
>  failed:
>  	while (sgtable->nents > sgtable->orig_nents)
> -		put_page(sg_page(&sgtable->sgl[--sgtable->nents]));
> +		unpin_user_page(sg_page(&sgtable->sgl[--sgtable->nents]));
>  	return res;
>  }
>  
