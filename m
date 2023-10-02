Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D487B4F9D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbjJBJze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236112AbjJBJz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:55:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFEBA7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 02:55:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B90F82185A;
        Mon,  2 Oct 2023 09:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696240523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a5qSHb2HY4O8xrSTCIffNnESicw2f6a/GZiMI+Le440=;
        b=BwyfoNRWkaue7UlzJq8yzWf5se6SWP9HRooAzqRkIdEmCRyV+PDH5v/Y3Gxib+XuSJzGwt
        N8qAAlg6ZvoYeec2zurYZzNcsY0tY4K6NeG4jsWXkGSGcWDAVXi8L77it3P2fyq+xsvqPA
        mI+cvpcEbLP3Ktx8QLSOUmW0zNfPqK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696240523;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a5qSHb2HY4O8xrSTCIffNnESicw2f6a/GZiMI+Le440=;
        b=FPv/6jZ7LK9Jbe325/Ith2a3jrIj4f1jDpacojNccVHQKwc5wQBlJPuQYC+hRPZ5wO72Wt
        kHZ2Q9GLb48tCkBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ABF5813434;
        Mon,  2 Oct 2023 09:55:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZJPoKYuTGmUXUgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 02 Oct 2023 09:55:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 48D3FA07C9; Mon,  2 Oct 2023 11:55:23 +0200 (CEST)
Date:   Mon, 2 Oct 2023 11:55:23 +0200
From:   Jan Kara <jack@suse.cz>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] mm/filemap: clarify filemap_fault() comments for not
 uptodate case
Message-ID: <20231002095523.6gttx365tvfaeexb@quack3>
References: <20230930231029.88196-1-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230930231029.88196-1-lstoakes@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 01-10-23 00:10:29, Lorenzo Stoakes wrote:
> The existing comments in filemap_fault() suggest that, after either a minor
> fault has occurred and filemap_get_folio() found a folio in the page cache,
> or a major fault arose and __filemap_get_folio(FGP_CREATE...) did the job
> (having relied on do_sync_mmap_readahead() or filemap_read_folio() to read
> in the folio), the only possible reason it could not be uptodate is because
> of an error.
> 
> This is not so, as if, for instance, the fault occurred within a VMA which
> had the VM_RAND_READ flag set (via madvise() with the MADV_RANDOM flag
> specified), this would cause even synchronous readahead to fail to read in
> the folio.
> 
> I confirmed this by dropping page caches and faulting in memory madvise()'d
> this way, observing that this code path was reached on each occasion.
> 
> Clarify the comments to include this case, and additionally update the
> comment recently added around the invalidate lock logic to make it clear
> the comment explicitly refers to the minor fault case.
> 
> In addition, while we're here, refer to folios rather than pages.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

After the alignment fixup the patch looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/filemap.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index d285ec5f9162..959694a2ade7 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3308,21 +3308,28 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  	VM_BUG_ON_FOLIO(!folio_contains(folio, index), folio);
>  
>  	/*
> -	 * We have a locked page in the page cache, now we need to check
> -	 * that it's up-to-date. If not, it is going to be due to an error.
> +	 * We have a locked folio in the page cache, now we need to check
> +	 * that it's up-to-date. If not, it is going to be due to an error,
> +	 * or because readahead was otherwise unable to retrieve it.
>  	 */
>  	if (unlikely(!folio_test_uptodate(folio))) {
>  		/*
> -		 * The page was in cache and uptodate and now it is not.
> -		 * Strange but possible since we didn't hold the page lock all
> -		 * the time. Let's drop everything get the invalidate lock and
> -		 * try again.
> +		 * If the invalidate lock is not held, the folio was in cache and
> +		 * uptodate and now it is not. Strange but possible since we
> +		 * didn't hold the page lock all the time. Let's drop everything,
> +		 * get the invalidate lock and try again.
>  		 */
>  		if (!mapping_locked) {
>  			folio_unlock(folio);
>  			folio_put(folio);
>  			goto retry_find;
>  		}
> +
> +		/*
> +		 * OK, the folio is really not uptodate. This can be because the
> +		 * VMA has the VM_RAND_READ flag set, or because an error
> +		 * arose. Let's read it in directly.
> +		 */
>  		goto page_not_uptodate;
>  	}
>  
> -- 
> 2.42.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
