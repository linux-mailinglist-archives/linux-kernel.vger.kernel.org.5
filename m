Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE9C75F592
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 14:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjGXMAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 08:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjGXMAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 08:00:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D3DFA
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 05:00:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBEBE610F4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 12:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BF7C433C9;
        Mon, 24 Jul 2023 12:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690200019;
        bh=tepsi5dNQgg9zr7r19uxSgYo1Xl6I8FiXX1BYmkjSWE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ME7kBWQ3xDEO1dRvrJSaunAq7BVvpRMsFdPg11Yk008DEp6Qc00X0XNc3k7wY7W3X
         JdWWYkq9Y8HCMwxU2Hjz0RYjVnNgiw/MtGoK9umv2RaHGpMypBvfX48SgnGd1ZWti6
         NSPQAjjloeTcloESxfsaMjDQV4CWs+QRTdFKEGWzzdVjqsdiOzqbqlHgYU9PlWv5jO
         WdtQmvkxcE0IStNWLUjEo8AjkZmjWgGbUmGQyBh4sCmUz0KwYo/qz6CRbH53Mex8u6
         pVN424X/WfqyyBc3EQoEHxl2t9Pera0yOIU01Mc1nuCXYOMm9XQfVWADuysw0J2tRN
         Zll1qyD5BWBsg==
Date:   Mon, 24 Jul 2023 14:00:14 +0200
From:   Carlos Maiolino <cem@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Carlos Maiolino <cmaiolino@redhat.com>,
        syzbot <syzbot+38ca19393fb3344f57e6@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, jack@suse.cz,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] possible deadlock in shmem_uncharge (2)
Message-ID: <20230724120014.k3agnopb76ngdcab@andromeda>
References: <0000000000008e62f40600bfe080@google.com>
 <f37e93d7-4313-b4b8-9c59-d0b129e6ac49@google.com>
 <20230718192920.qmktf3vnt67bb6rq@andromeda>
 <GTWC4XsZWCau8puyvF3Ah5x8rqPFDIxplGuJVuP179QFZnSKbP7ip42Qa-o1nQzX7FQ_Wgss_zYLlOeIOVEipg==@protonmail.internalid>
 <6d29786a-ebc3-591-d3eb-bd7b125a33f1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d29786a-ebc3-591-d3eb-bd7b125a33f1@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugh.

On Sat, Jul 22, 2023 at 09:37:35PM -0700, Hugh Dickins wrote:
> On Tue, 18 Jul 2023, Carlos Maiolino wrote:
> > On Tue, Jul 18, 2023 at 11:22:59AM -0700, Hugh Dickins wrote:
> > > On Tue, 18 Jul 2023, syzbot wrote:
> > >
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > >
> > > Yes, this doesn't require any syzbot trickery, it showed up as soon as
> > > I tried a shmem quota linux-next with lockdep and shmem huge last week.
> > >
> > > There's some other things wrong with the accounting there (in the non-
> > > quota case anyway): I have been working up a patch to fix them, but need
> > > to consider what must go in quickly, and what should wait until later.
> > >
> > > Carlos, in brief: don't worry about this syzbot report, I'm on it (but
> > > there's a risk that any patch I send may turn out to break your quotas).
> >
> > Ok, thanks Hugh, I have the next version ready to go when I saw those syzkaller
> > reports.
> >
> > I will send the new series tomorrow morning then.
> > Could you please keep me in the loop, I'm interested to see what's going on
> > there.
> 
> I never saw a new series on Wednesday, just a new series on Monday which
> I had ignored, knowing that another was coming.  I was waiting for your
> new series before sending my patch to that, but perhaps you were waiting
> for my patch before sending your new series?

TL;DR, I spoke with Andrew past week, and we agreed it would be better to wait
for you to submit the patches before I send the new version, I thought I had
cc'ed in the email thread, but seems like I didn't, my apologies.

> 
> Then when I went to check my patch on next-20230721, found that your
> series has been dropped from mm-unstable meanwhile.  Maybe Andrew
> dropped it because of the lockdep reports (I see now there was another),
> or maybe he dropped it because of new series coming too thick and fast,
> or maybe he dropped it because of the awkward merge commit which Stephen
> Rothwell had to write, to reconcile the vfs and mm trees.  (But I was
> surprised not to have seen any mm-commits mail on the dropping.)
> 
> So the patch below is against next-20230714, and will hopefully still
> apply in your next posting: please include it there (since it modifies
> THP source, I think it's best kept as a separate patch in your series).
> 
> But when you repost, if you are still going for the next release, the
> more you can do to minimize that merge commit the better.  In particular,
> the reindentations of shmem_get_inode() and other functions in
> "shmem: make shmem_get_inode() return ERR_PTR instead of NULL"
> don't help review, and could well be left until some later cleanup -
> but I don't know how much that would actually eliminate the clashes.

I'm not @work today, so I can't take a deep look into it by now, but,
I plan to rebase the series on top of linux-next and I'll include your patch in
my series, if that's what I understood from a quick read on your email.

I'll try to work on it tomorrow first thing, thanks!

Carlos


> 
> (And "Add default quota limit mount options" needs to say "shmem: ...";
> I'd have preferred "tmpfs: ...", but the others say shmem, so okay.)
> 
> [PATCH] shmem: fix quota lock nesting in huge hole handling
> 
> i_pages lock nests inside i_lock, but shmem_charge() and shmem_uncharge()
> were being called from THP splitting or collapsing while i_pages lock was
> held, and now go on to call dquot_alloc_block_nodirty() which takes
> i_lock to update i_blocks.
> 
> We may well want to take i_lock out of this path later, in the non-quota
> case even if it's left in the quota case (or perhaps use i_lock instead
> of shmem's info->lock throughout); but don't get into that at this time.
> 
> Move the shmem_charge() and shmem_uncharge() calls out from under i_pages
> lock, accounting the full batch of holes in a single call.
> 
> Still pass the pages argument to shmem_uncharge(), but it happens now to
> be unused: shmem_recalc_inode() is designed to account for clean pages
> freed behind shmem's back, so it gets the accounting right by itself;
> then the later call to shmem_inode_unacct_blocks() led to imbalance
> (that WARN_ON(inode->i_blocks) in shmem_evict_inode()).
> 
> Reported-by: syzbot+38ca19393fb3344f57e6@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/0000000000008e62f40600bfe080@google.com/
> Reported-by: syzbot+440ff8cca06ee7a1d4db@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/00000000000076a7840600bfb6e8@google.com/
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  mm/huge_memory.c |  6 ++++--
>  mm/khugepaged.c  | 13 +++++++------
>  mm/shmem.c       | 19 +++++++++----------
>  3 files changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 762be2f4244c..01f6838329a1 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2521,7 +2521,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  	struct address_space *swap_cache = NULL;
>  	unsigned long offset = 0;
>  	unsigned int nr = thp_nr_pages(head);
> -	int i;
> +	int i, nr_dropped = 0;
> 
>  	/* complete memcg works before add pages to LRU */
>  	split_page_memcg(head, nr);
> @@ -2546,7 +2546,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  			struct folio *tail = page_folio(head + i);
> 
>  			if (shmem_mapping(head->mapping))
> -				shmem_uncharge(head->mapping->host, 1);
> +				nr_dropped++;
>  			else if (folio_test_clear_dirty(tail))
>  				folio_account_cleaned(tail,
>  					inode_to_wb(folio->mapping->host));
> @@ -2583,6 +2583,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  	}
>  	local_irq_enable();
> 
> +	if (nr_dropped)
> +		shmem_uncharge(head->mapping->host, nr_dropped);
>  	remap_page(folio, nr);
> 
>  	if (PageSwapCache(head)) {
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 6bad69c0e4bd..366ee467fb83 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1828,10 +1828,6 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  						goto xa_locked;
>  					}
>  				}
> -				if (!shmem_charge(mapping->host, 1)) {
> -					result = SCAN_FAIL;
> -					goto xa_locked;
> -				}
>  				nr_none++;
>  				continue;
>  			}
> @@ -2017,8 +2013,13 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  	 */
>  	try_to_unmap_flush();
> 
> -	if (result != SCAN_SUCCEED)
> +	if (result == SCAN_SUCCEED && nr_none &&
> +	    !shmem_charge(mapping->host, nr_none))
> +		result = SCAN_FAIL;
> +	if (result != SCAN_SUCCEED) {
> +		nr_none = 0;
>  		goto rollback;
> +	}
> 
>  	/*
>  	 * The old pages are locked, so they won't change anymore.
> @@ -2157,8 +2158,8 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  	if (nr_none) {
>  		xas_lock_irq(&xas);
>  		mapping->nrpages -= nr_none;
> -		shmem_uncharge(mapping->host, nr_none);
>  		xas_unlock_irq(&xas);
> +		shmem_uncharge(mapping->host, nr_none);
>  	}
> 
>  	list_for_each_entry_safe(page, tmp, &pagelist, lru) {
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 161592a8d3fe..521a6302dc37 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -424,18 +424,20 @@ static void shmem_recalc_inode(struct inode *inode)
>  bool shmem_charge(struct inode *inode, long pages)
>  {
>  	struct shmem_inode_info *info = SHMEM_I(inode);
> -	unsigned long flags;
> +	struct address_space *mapping = inode->i_mapping;
> 
>  	if (shmem_inode_acct_block(inode, pages))
>  		return false;
> 
>  	/* nrpages adjustment first, then shmem_recalc_inode() when balanced */
> -	inode->i_mapping->nrpages += pages;
> +	xa_lock_irq(&mapping->i_pages);
> +	mapping->nrpages += pages;
> +	xa_unlock_irq(&mapping->i_pages);
> 
> -	spin_lock_irqsave(&info->lock, flags);
> +	spin_lock_irq(&info->lock);
>  	info->alloced += pages;
>  	shmem_recalc_inode(inode);
> -	spin_unlock_irqrestore(&info->lock, flags);
> +	spin_unlock_irq(&info->lock);
> 
>  	return true;
>  }
> @@ -443,16 +445,13 @@ bool shmem_charge(struct inode *inode, long pages)
>  void shmem_uncharge(struct inode *inode, long pages)
>  {
>  	struct shmem_inode_info *info = SHMEM_I(inode);
> -	unsigned long flags;
> 
>  	/* nrpages adjustment done by __filemap_remove_folio() or caller */
> 
> -	spin_lock_irqsave(&info->lock, flags);
> -	info->alloced -= pages;
> +	spin_lock_irq(&info->lock);
>  	shmem_recalc_inode(inode);
> -	spin_unlock_irqrestore(&info->lock, flags);
> -
> -	shmem_inode_unacct_blocks(inode, pages);
> +	/* which has called shmem_inode_unacct_blocks() if necessary */
> +	spin_unlock_irq(&info->lock);
>  }
> 
>  /*
> --
> 2.35.3
> 
