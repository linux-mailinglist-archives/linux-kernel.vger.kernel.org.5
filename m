Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C96679E8FE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240845AbjIMNTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbjIMNTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:19:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AF619B1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 06:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6nGpWo3Q0M9n1VL0YnuUHxLpBAtmFVM3ERwQKnOYKJg=; b=ZX95fT91yQNbdlEZ1OMrxkavx7
        oXDMmKyXS+Ku4RIssOZwnhTuyXFf3+bhedcyDkrXMlS4aqpD5VWo5a2EDibcDlfoiARHqPXM5Zn0T
        5sZSD5uM7JUgcDJZ2EXrdGgh/oPeZDp9uXGon4Dthk7cRZbl0JOjLaIg8vFo8bQYudukkQYvpLkvi
        Bh8WskiCrIW2lDFX034axxjgWRGH/Zm3DX1ki65izxihwTcz4wuxje3KlsVEV7wk2POmYTSaLFDqR
        JiRcqEd2PuB6KHC/zlexWPK+ScJuM5WFEkiW+pjXX+RqImoVztdyUPqzT2JdqoIuNfTyGPpDmrr0Q
        ne9c/Ovw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qgPlj-00E381-LS; Wed, 13 Sep 2023 13:18:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 11662300348; Wed, 13 Sep 2023 15:18:59 +0200 (CEST)
Date:   Wed, 13 Sep 2023 15:18:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] futex: Use a folio instead of a page
Message-ID: <20230913131858.GD22758@noisy.programming.kicks-ass.net>
References: <20230821142207.2537124-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821142207.2537124-1-willy@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 03:22:07PM +0100, Matthew Wilcox (Oracle) wrote:
> The futex code already handles compound pages correctly, but using a
> folio lets us tell the compiler that we already have the head page and
> it doesn't need to call compound_head() again.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by; Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  kernel/futex/core.c | 67 ++++++++++++++++++++++-----------------------
>  1 file changed, 33 insertions(+), 34 deletions(-)
> 
> diff --git a/kernel/futex/core.c b/kernel/futex/core.c
> index f10587d1d481..d1d7b3c175a4 100644
> --- a/kernel/futex/core.c
> +++ b/kernel/futex/core.c
> @@ -222,7 +222,8 @@ int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
>  {
>  	unsigned long address = (unsigned long)uaddr;
>  	struct mm_struct *mm = current->mm;
> -	struct page *page, *tail;
> +	struct page *page;
> +	struct folio *folio;
>  	struct address_space *mapping;
>  	int err, ro = 0;
>  
> @@ -273,54 +274,52 @@ int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
>  		err = 0;
>  
>  	/*
> -	 * The treatment of mapping from this point on is critical. The page
> -	 * lock protects many things but in this context the page lock
> +	 * The treatment of mapping from this point on is critical. The folio
> +	 * lock protects many things but in this context the folio lock
>  	 * stabilizes mapping, prevents inode freeing in the shared
>  	 * file-backed region case and guards against movement to swap cache.
>  	 *
> -	 * Strictly speaking the page lock is not needed in all cases being
> -	 * considered here and page lock forces unnecessarily serialization
> +	 * Strictly speaking the folio lock is not needed in all cases being
> +	 * considered here and folio lock forces unnecessarily serialization.
>  	 * From this point on, mapping will be re-verified if necessary and
> -	 * page lock will be acquired only if it is unavoidable
> +	 * folio lock will be acquired only if it is unavoidable
>  	 *
> -	 * Mapping checks require the head page for any compound page so the
> -	 * head page and mapping is looked up now. For anonymous pages, it
> -	 * does not matter if the page splits in the future as the key is
> -	 * based on the address. For filesystem-backed pages, the tail is
> -	 * required as the index of the page determines the key. For
> -	 * base pages, there is no tail page and tail == page.
> +	 * Mapping checks require the folio so it is looked up now. For
> +	 * anonymous pages, it does not matter if the folio is split
> +	 * in the future as the key is based on the address. For
> +	 * filesystem-backed pages, the precise page is required as the
> +	 * index of the page determines the key.
>  	 */
> -	tail = page;
> -	page = compound_head(page);
> -	mapping = READ_ONCE(page->mapping);
> +	folio = page_folio(page);
> +	mapping = READ_ONCE(folio->mapping);
>  
>  	/*
> -	 * If page->mapping is NULL, then it cannot be a PageAnon
> +	 * If folio->mapping is NULL, then it cannot be an anonymous
>  	 * page; but it might be the ZERO_PAGE or in the gate area or
>  	 * in a special mapping (all cases which we are happy to fail);
>  	 * or it may have been a good file page when get_user_pages_fast
>  	 * found it, but truncated or holepunched or subjected to
> -	 * invalidate_complete_page2 before we got the page lock (also
> +	 * invalidate_complete_page2 before we got the folio lock (also
>  	 * cases which we are happy to fail).  And we hold a reference,
>  	 * so refcount care in invalidate_inode_page's remove_mapping
>  	 * prevents drop_caches from setting mapping to NULL beneath us.
>  	 *
>  	 * The case we do have to guard against is when memory pressure made
>  	 * shmem_writepage move it from filecache to swapcache beneath us:
> -	 * an unlikely race, but we do need to retry for page->mapping.
> +	 * an unlikely race, but we do need to retry for folio->mapping.
>  	 */
>  	if (unlikely(!mapping)) {
>  		int shmem_swizzled;
>  
>  		/*
> -		 * Page lock is required to identify which special case above
> -		 * applies. If this is really a shmem page then the page lock
> +		 * Folio lock is required to identify which special case above
> +		 * applies. If this is really a shmem page then the folio lock
>  		 * will prevent unexpected transitions.
>  		 */
> -		lock_page(page);
> -		shmem_swizzled = PageSwapCache(page) || page->mapping;
> -		unlock_page(page);
> -		put_page(page);
> +		folio_lock(folio);
> +		shmem_swizzled = folio_test_swapcache(folio) || folio->mapping;
> +		folio_unlock(folio);
> +		folio_put(folio);
>  
>  		if (shmem_swizzled)
>  			goto again;
> @@ -331,14 +330,14 @@ int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
>  	/*
>  	 * Private mappings are handled in a simple way.
>  	 *
> -	 * If the futex key is stored on an anonymous page, then the associated
> +	 * If the futex key is stored in anonymous memory, then the associated
>  	 * object is the mm which is implicitly pinned by the calling process.
>  	 *
>  	 * NOTE: When userspace waits on a MAP_SHARED mapping, even if
>  	 * it's a read-only handle, it's expected that futexes attach to
>  	 * the object not the particular process.
>  	 */
> -	if (PageAnon(page)) {
> +	if (folio_test_anon(folio)) {
>  		/*
>  		 * A RO anonymous page will never change and thus doesn't make
>  		 * sense for futex operations.
> @@ -357,10 +356,10 @@ int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
>  
>  		/*
>  		 * The associated futex object in this case is the inode and
> -		 * the page->mapping must be traversed. Ordinarily this should
> -		 * be stabilised under page lock but it's not strictly
> +		 * the folio->mapping must be traversed. Ordinarily this should
> +		 * be stabilised under folio lock but it's not strictly
>  		 * necessary in this case as we just want to pin the inode, not
> -		 * update the radix tree or anything like that.
> +		 * update i_pages or anything like that.
>  		 *
>  		 * The RCU read lock is taken as the inode is finally freed
>  		 * under RCU. If the mapping still matches expectations then the
> @@ -368,9 +367,9 @@ int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
>  		 */
>  		rcu_read_lock();
>  
> -		if (READ_ONCE(page->mapping) != mapping) {
> +		if (READ_ONCE(folio->mapping) != mapping) {
>  			rcu_read_unlock();
> -			put_page(page);
> +			folio_put(folio);
>  
>  			goto again;
>  		}
> @@ -378,19 +377,19 @@ int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
>  		inode = READ_ONCE(mapping->host);
>  		if (!inode) {
>  			rcu_read_unlock();
> -			put_page(page);
> +			folio_put(folio);
>  
>  			goto again;
>  		}
>  
>  		key->both.offset |= FUT_OFF_INODE; /* inode-based key */
>  		key->shared.i_seq = get_inode_sequence_number(inode);
> -		key->shared.pgoff = page_to_pgoff(tail);
> +		key->shared.pgoff = folio->index + folio_page_idx(folio, page);
>  		rcu_read_unlock();
>  	}
>  
>  out:
> -	put_page(page);
> +	folio_put(folio);
>  	return err;
>  }
>  
> -- 
> 2.40.1
> 
