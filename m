Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072197A5D12
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjISIyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjISIyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:54:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4AF1FE4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 01:52:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E24421FE39;
        Tue, 19 Sep 2023 08:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695113577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MAE/ORI96UNcZCy9nD+5Kv3FH7y5O9zbGLIgTktz+G8=;
        b=siGFRRKWVi99Szw+lvvhO2kvgTV+hFfPuVd9w12MtY+OehkIiJL0w5SixQa1n/DIlzBaLa
        H50OUF9DIHnwiiGCUkv1lmcZddYcd618rmdrZJ3r8PCb3rsxL8Pxoj40y8CZXiWkG0CjLe
        82KB4FY8CHO3mQh2wJBbaE6I5maF9w8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B5F8C134F3;
        Tue, 19 Sep 2023 08:52:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sUmWKWlhCWUJGgAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 19 Sep 2023 08:52:57 +0000
Date:   Tue, 19 Sep 2023 10:52:56 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hughd@google.com,
        shy828301@gmail.com, vbabka@suse.cz,
        syzkaller-bugs@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/1] mm: lock VMAs skipped by a failed queue_pages_range()
Message-ID: <ZQlhaO1C5kf8zGjf@dhcp22.suse.cz>
References: <20230918211608.3580629-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918211608.3580629-1-surenb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 18-09-23 14:16:08, Suren Baghdasaryan wrote:
> When queue_pages_range() encounters an unmovable page, it terminates
> its page walk. This walk, among other things, locks the VMAs in the range.
> This termination might result in some VMAs being left unlock after
> queue_pages_range() completes. Since do_mbind() continues to operate on
> these VMAs despite the failure from queue_pages_range(), it will encounter
> an unlocked VMA.
> This mbind() behavior has been modified several times before and might
> need some changes to either finish the page walk even in the presence
> of unmovable pages or to error out immediately after the failure to
> queue_pages_range(). However that requires more discussions, so to
> fix the immediate issue, explicitly lock the VMAs in the range if
> queue_pages_range() failed. The added condition does not save much
> but is added for documentation purposes to understand when this extra
> locking is needed.

The semantic of the walk in this case is really clear as mud. I was
trying to reconstruct the whole picture and it really hurts... Then I
found http://lkml.kernel.org/r/CAHbLzkrmTaqBRmHVdE2kyW57Uoghqd_E+jAXC9cB5ofkhL-uvw@mail.gmail.com
and that helped a lot. Let's keep it a reference at least in the email
thread here for future.

> Fixes: 49b0638502da ("mm: enable page walking API to lock vmas during the walk")
> Reported-by: syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/000000000000f392a60604a65085@google.com/
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

I cannot say I like the patch (it looks like a potential double locking
unless you realize this lock is special) but considering this might be just
temporal I do not mind. 

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/mempolicy.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 42b5567e3773..cbc584e9b6ca 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1342,6 +1342,9 @@ static long do_mbind(unsigned long start, unsigned long len,
>  	vma_iter_init(&vmi, mm, start);
>  	prev = vma_prev(&vmi);
>  	for_each_vma_range(vmi, vma, end) {
> +		/* If queue_pages_range failed then not all VMAs might be locked */
> +		if (ret)
> +			vma_start_write(vma);
>  		err = mbind_range(&vmi, vma, &prev, start, end, new);
>  		if (err)
>  			break;
> -- 
> 2.42.0.459.ge4e396fd5e-goog

-- 
Michal Hocko
SUSE Labs
