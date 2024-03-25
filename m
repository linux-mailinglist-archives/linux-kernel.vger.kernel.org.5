Return-Path: <linux-kernel+bounces-116456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33349889F1A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E19AD2C4FD7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB21315AAA2;
	Mon, 25 Mar 2024 07:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TOkzjnL6"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0661311AA
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711336960; cv=none; b=iJhcF5rMPVVq8OVsc9T0Zg/3EvMJph0b9EGrG8MxVm8lKh6YgLHCSze3tlytbFENscfVeGOxuyNi5fUXc+K5Y4G3ctKhupLtTevvYhnMtCl/y2FH7MIwaqW3IgwLAXD5P78j/3/mLASfqJu0c6lKHXbiSRgKSNPitGmoAFcJxqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711336960; c=relaxed/simple;
	bh=i80VoZMqBoYXLl9VuHTIymeFBZ6nqwDeIFzNjjVljJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZTTmgxEFyv7FXsobNBvtmeCbFae2g733muSS1MpUvdjYiRmjrTYFGdtZLY6gZRE3fZkkavwTdXoIFbkM8M/aDk6L8rmfwU1QCGKutgrQvJ3V+v1tv7462wIptEYRxNT7XHUfDbRGareZIHj2J9e2UxzOSZvVCXWcIxwkUwfYhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TOkzjnL6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iqc52fNCJobqUzERbW40WnlDTkGcB7WwGc1zVlyZKvQ=; b=TOkzjnL6BUv7T92lJO5XntAlUY
	KsDq4bgdcc08zQCTrImHMntACEY4Wg1uzkw4ZyBude71X+tFe9pNWd5tIewIriDl/MPkVDG9FQ8KF
	kEwc42NZDXGkM+Yizn5h6IZ87AIt61Y9lNeSJ7IvwF83GoGrNK4UL10MSISSo0hl2k9M6U3WcMaKD
	pi+cF81QoD63cqjDpj5x3KC5YVi343PdsYXlSlbObk1SSnOIlM21k4OzDtCrmTxxLS1+1jlZZa0CR
	3u4JcxK8uA5e6qPgVIA39JEAVlsHNHgdSn6PGQENQRSi5b4hlC289YznYRMQcjWtueOjqB8f5VnRy
	SHA6Dccg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roaut-0000000FYNr-0Ljl;
	Mon, 25 Mar 2024 03:22:31 +0000
Date: Mon, 25 Mar 2024 03:22:30 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: =?utf-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?= <zhaoyang.huang@unisoc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?5bq357qq5ruoIChTdGV2ZSBLYW5nKQ==?= <Steve.Kang@unisoc.com>
Subject: Re: summarize all information again at bottom//reply: reply: [PATCH]
 mm: fix a race scenario in folio_isolate_lru
Message-ID: <ZgDt9mwN-Py5Y-xr@casper.infradead.org>
References: <be75859d7e4245939d825da5e881902c@BJMBX01.spreadtrum.com>
 <Zfg0WLrcOmCtdn_M@casper.infradead.org>
 <CAGWkznGhiuzkqfeewNq-ykKehvFTBjH2v_==xAS2_7iFqsFk5A@mail.gmail.com>
 <Zfj_-LbiIsAVWcPX@casper.infradead.org>
 <CAGWkznHOWVPpKHOuvvDF2zppkTT0_x4WyJ5S75j+EghhZmEDdg@mail.gmail.com>
 <ZfwpuRjAZV07_lc3@casper.infradead.org>
 <CAGWkznFtez1fj2L2CtFnA5k-Tn4WtxmDOw=fjOWPg-ZGJX=VWw@mail.gmail.com>
 <Zfz4_GJAHRInB8ul@casper.infradead.org>
 <CAGWkznEzpcWi4oXVn_WFahnQj3dHcwc_4VW6m1Ss-KJ8mD3F3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznEzpcWi4oXVn_WFahnQj3dHcwc_4VW6m1Ss-KJ8mD3F3Q@mail.gmail.com>

On Sun, Mar 24, 2024 at 07:14:27PM +0800, Zhaoyang Huang wrote:
> ok. It seems like madvise is robust enough to leave no BUGs. I presume
> another two scenarios which call folio_isloate_lru by any other ways
> but PTE. Besides, scenario 2 reminds me of a previous bug reported by
> me as find_get_entry entered in a livelock where the folio's refcnt ==
> 0 but remains at xarray which causes the reset->retry loops forever. I
> would like to reply in that thread for more details.
> 
> Scenario 1:
> 0. Thread_bad gets the folio by find_get_entry and preempted before
> folio_lock (could be the second round scan of
> truncate_inode_pages_range)
>     refcnt == 2(page_cache, fbatch_bad), PG_lru == true, PG_lock == false
>         folio = find_get_entry
>         folio_try_get_rcu
>         <preempted>
>         folio_try_lock
> 
> 1. Thread_truncate get the folio via
> truncate_inode_pages_range->find_lock_entries
>     refcnt == 3(page_cache, fbatch_bad, fbatch_truncate), PG_lru ==
> true, PG_lock == true

Hang on, you can't have two threads in truncate_inode_pages_range()
at the same time.  I appreciate that we don't have any documentation
of that, but if it were possible, we'd see other crashes.  Removing
the folio from the page cache sets folio->mapping to NULL.  And
__filemap_remove_folio() uses folio->mapping in
filemap_unaccount_folio() and page_cache_delete(), so we'd get NULL
pointer dereferences.

I see a hint in the DAX code that it's an fs-dependent lock:

        /*
         * This gets called from truncate / punch_hole path. As such, the caller
         * must hold locks protecting against concurrent modifications of the
         * page cache (usually fs-private i_mmap_sem for writing). Since the
         * caller has seen a DAX entry for this index, we better find it
         * at that index as well...
         */

so maybe that's why there's no lockdep_assert() in
truncate_inode_pages_range(), but there should be a comment.

> Scenario 2:
> 0. Thread_bad gets the folio by find_get_entry and preempted before
> folio_lock (could be the second round scan of
> truncate_inode_pages_range)
>     refcnt == 2(page_cache, fbatch_bad), PG_lru == true, PG_lock == false
>         folio = find_get_entry
>         folio_try_get_rcu
>         <preempted>
>         folio_try_lock
> 
> 1. Thread_readahead remove the folio from page cache and drop one
> refcnt by filemap_remove_folio(get rid of the folios which failed to
> launch IO during readahead)
>     refcnt == 1(fbatch_bad), PG_lru == true, PG_lock == true

So readaahead inserts the folio locked, and then calls
filemap_remove_folio() without having unlocked it.
filemap_remove_folio() sets folio->mapping to NULL in
page_cache_delete().  When "Thread_bad" wakes up, it gets the
folio lock, calls truncate_inode_folio() and sees that
folio->mapping != mapping, so it doesn't call filemap_remove_folio().

> 4. Thread_bad schedule back from step 0 and clear one refcnt wrongly
> when doing truncate_inode_folio->filemap_remove_folio as it take this
> refcnt as the page cache one
>     refcnt == 1'(thread_isolate), PG_lru == false, PG_lock == false
>         find_get_entries
>             folio = find_get_entry
>             folio_try_get_rcu
>         folio_lock
>         <no check as folio->mapping != mapping as folio_lock_entries does>
>         truncate_inode_folio
>             filemap_remove_folio
>             <preempted>

