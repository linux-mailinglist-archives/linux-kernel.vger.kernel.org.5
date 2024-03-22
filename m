Return-Path: <linux-kernel+bounces-110898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E17C886569
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 04:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B07792858EE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 03:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5142F4C85;
	Fri, 22 Mar 2024 03:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iNwNe5am"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608913FEF
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 03:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711077639; cv=none; b=We3W0FU0opIxZZaSlM3k4KVA6DCwWQEqxQRh2tbhCLEOrmH2m2Nk/eKovf2UjkZlXc5cDeY8IJOn1NrEIRV/C0GqT4xQwB46x2eq4Lju9s/1mbeX3DYLvcZ6vqgcSrU/+kZsEBFs57VUbJaXfr5YlvBJM3Qd+LVjZ2+w8FONxzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711077639; c=relaxed/simple;
	bh=i5qaunpn5UH9AVEitb0VvH3K72sLHi95zxIr1E5BpeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDB+qBSXSJAXwQpWUztwDXDzjfmIEcPm7knyTrc1a1G/JqTYJM8gXyGMsH6xVbed+2Y3+RSMs3kMnoYSHwj5wxYeTqVy9VKdq16A4FGASqrhJqvdpdBf/lfa9Q9s/BAqAB/2+o1MTpHDxVmFcb36zPvc7UVerLSmIEFtyy47I40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iNwNe5am; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jwTne3Hx/T83kHemCjc89IPiXMo/TYVA2FmO1gawVJ4=; b=iNwNe5am11LTo6ck59SeFnUGL1
	HD+nWOQ3pVN8jmOZxDAu+Ncpib5Fb16eRXv5w+DbvWJwQaFsP23UNf2rmWdk+upzS6U2IS7YZKAZa
	Hg5KJNEDUAjZ7XFTXmsKRU4e3oXHPhaPUJJqCf0JBtwlSIKPFVoFiqs6iewF7kOUmVIfp7rTewrWk
	9k0DVnQI6uZj0K/QAyMcJnSxuDK79CN139+cEyskKg9vPpFoQxUr9nUr6MJkeAp6FNkI/lyM87xcs
	oDmZbGlSrqWg/1y7Kt491l+xXjmkr5QMVcsjAHH8KELIeE4uRp3bcI9zHeuizUXYFMuJN94h8gLnL
	xXnl7Adg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnVSG-00000008Kc7-3Ret;
	Fri, 22 Mar 2024 03:20:28 +0000
Date: Fri, 22 Mar 2024 03:20:28 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: =?utf-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?= <zhaoyang.huang@unisoc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?5bq357qq5ruoIChTdGV2ZSBLYW5nKQ==?= <Steve.Kang@unisoc.com>
Subject: Re: summarize all information again at bottom//reply: reply: [PATCH]
 mm: fix a race scenario in folio_isolate_lru
Message-ID: <Zfz4_GJAHRInB8ul@casper.infradead.org>
References: <be75859d7e4245939d825da5e881902c@BJMBX01.spreadtrum.com>
 <Zfg0WLrcOmCtdn_M@casper.infradead.org>
 <CAGWkznGhiuzkqfeewNq-ykKehvFTBjH2v_==xAS2_7iFqsFk5A@mail.gmail.com>
 <Zfj_-LbiIsAVWcPX@casper.infradead.org>
 <CAGWkznHOWVPpKHOuvvDF2zppkTT0_x4WyJ5S75j+EghhZmEDdg@mail.gmail.com>
 <ZfwpuRjAZV07_lc3@casper.infradead.org>
 <CAGWkznFtez1fj2L2CtFnA5k-Tn4WtxmDOw=fjOWPg-ZGJX=VWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznFtez1fj2L2CtFnA5k-Tn4WtxmDOw=fjOWPg-ZGJX=VWw@mail.gmail.com>

On Fri, Mar 22, 2024 at 09:52:36AM +0800, Zhaoyang Huang wrote:
> Thanks for the comments. fix the typo and update the timing sequence
> by amending possible preempt points to have the refcnt make sense.
> 
> 0. Thread_bad gets the folio by find_get_entry and preempted before
> take refcnt(could be the second round scan of
> truncate_inode_pages_range)
>     refcnt == 1(page_cache), PG_lru == true, PG_lock == false
>     find_get_entry
>         folio = xas_find
>         <preempted>
>         folio_try_get_rcu
> 
> 1. Thread_filemap get the folio via
> filemap_map_pages->next_uptodate_folio->xas_next_entry and gets preempted
>     refcnt == 1(page_cache), PG_lru == true, PG_lock == false
>     filemap_map_pages
>         next_uptodate_folio
>            xas_next_entry
>            <preempted>
>            folio_try_get_rcu
> 
> 2. Thread_truncate get the folio via
> truncate_inode_pages_range->find_lock_entries
>     refcnt == 2(page_cache, fbatch_truncate), PG_lru == true, PG_lock == true
> 
> 3. Thread_truncate proceed to truncate_cleanup_folio
>     refcnt == 2(page_cache, fbatch_truncate), PG_lru == true, PG_lock == true
> 
> 4. Thread_truncate proceed to delete_from_page_cache_batch
>     refcnt == 1(fbatch_truncate), PG_lru == true, PG_lock == true
> 
> 4.1 folio_unlock
>     refcnt == 1(fbatch_truncate), PG_lru == true, PG_lock == false

OK, so by the time we get to folio_unlock(), the folio has been removed
from the i_pages xarray.

> 5. Thread_filemap schedule back from '1' and proceed to setup a pte
> and have folio->_mapcnt = 0 & folio->refcnt += 1
>     refcnt == 1->2(+fbatch_filemap)->3->2(pte, fbatch_truncate),
> PG_lru == true, PG_lock == true->false

This line succeeds (in next_uptodate_folio):
                if (!folio_try_get_rcu(folio))
                        continue;
but then this fails:

                if (unlikely(folio != xas_reload(xas)))
                        goto skip;
skip:
                folio_put(folio);

because xas_reload() will return NULL due to the folio being deleted
in step 4.  So we never get to the point where we set up a PTE.

There should be no way to create a new PTE for a folio which has been
removed from the page cache.  Bugs happen, of course, but I don't see
one yet.

> 6. Thread_madv clear folio's PG_lru by
> madvise_xxx_pte_range->folio_isolate_lru->folio_test_clear_lru
>     refcnt == 2(pte,fbatch_truncate), PG_lru == false, PG_lock == false
> 
> 7. Thread_truncate call folio_fbatch_release and failed in freeing
> folio as refcnt not reach 0
>     refcnt == 1(pte), PG_lru == false, PG_lock == false
> ********folio becomes an orphan here which is not on the page cache
> but on the task's VM**********
> 
> 8. Thread_bad scheduled back from '0' to be collected in fbatch_bad
>     refcnt == 2(pte, fbatch_bad), PG_lru == false, PG_lock == true
> 
> 9. Thread_bad clear one refcnt wrongly when doing filemap_remove_folio
> as it take this refcnt as the page cache one
>     refcnt == 1(fbatch_bad), PG_lru == false, PG_lock == true->false
>     truncate_inode_folio
>         filemap_remove_folio
>              filemap_free_folio
> ******refcnt decreased wrongly here by being taken as the page cache one ******
> 
> 10. Thread_bad calls release_pages(fbatch_bad) and has the folio
> introduce the bug.
>     release_pages
>         folio_put_testzero == true
>         folio_test_lru == false
>         list_add(folio->lru, pages_to_free)

