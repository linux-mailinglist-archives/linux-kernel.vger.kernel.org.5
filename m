Return-Path: <linux-kernel+bounces-110039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01440885934
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 943921F2435E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983ED83CAA;
	Thu, 21 Mar 2024 12:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I3CZK9S+"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835E51CA98
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 12:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711024578; cv=none; b=qo9OOMwvcI1JJt9mBeuwvw86Qs9Kfjqj4WEgvIlLATFV6F+qycVLtl9WwBy4UZolGDiPO6Sfx8ILQGl1bo78d50QJifIiRt9Rs3GhgusuSJsK7SKyU1Fi6Jm/du8mDkZyQyKKEorSQiuVYo5Fuh9u+6eIE4Nc5+1zVij9HcHrB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711024578; c=relaxed/simple;
	bh=xzWeLsPkYxdX/aZFv4V6kVlUnEU81ZiTAYh3+I2p0xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVt731j/TVNvEzNISVpBCThFkbps3EM0M75G3nJPfqWMq00eATHlIsfBH9RxZ64SERIwbOcG1DfvM4M2gX3UxCmmqBehmhCrs84QuQHOEIAlPqYV05ozVQ+2P4m7px6j5eoNL+oGmJncfdNEbOy48fl9Hlog9qJmTGkpgb9EedA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=I3CZK9S+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=J4v4xirv+alWZBlX1A2mLEAEUfB1AfURODTs/cKQ8J0=; b=I3CZK9S+8W08hz7sUGmxiBQpuz
	myBzWd9z3pRPoqiy4FxS+j59C1f626HLaO3HKDdmcYVuc4qTxZdYxCdu+s4gOckUkCzflMRuQxgy2
	pB6wmo6531q7rsdgmtxMVDL+lPzHsBbWGcVNTASGeKXMazAByUJOe4AbLiAoGpfm0U9Xvnw9LICdl
	6m3vunIU4E4jR4Y1rgFErFjNvOilkNG+6lax9JbIX0OvE0KjIBBL7/OdHnvyIenNWCbz8fX2JhuXH
	mkE/w98nC+Ur67s2KdobYxmqB7ucVEfZb6dYHjtXlCGGlIVANtFg1MNKu7gnWb3xU/6p05o9XchsD
	J4/8y1QA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnHeU-00000006j1S-0J5h;
	Thu, 21 Mar 2024 12:36:10 +0000
Date: Thu, 21 Mar 2024 12:36:09 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: =?utf-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?= <zhaoyang.huang@unisoc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?5bq357qq5ruoIChTdGV2ZSBLYW5nKQ==?= <Steve.Kang@unisoc.com>
Subject: Re: summarize all information again at bottom//reply: reply: [PATCH]
 mm: fix a race scenario in folio_isolate_lru
Message-ID: <ZfwpuRjAZV07_lc3@casper.infradead.org>
References: <be75859d7e4245939d825da5e881902c@BJMBX01.spreadtrum.com>
 <Zfg0WLrcOmCtdn_M@casper.infradead.org>
 <CAGWkznGhiuzkqfeewNq-ykKehvFTBjH2v_==xAS2_7iFqsFk5A@mail.gmail.com>
 <Zfj_-LbiIsAVWcPX@casper.infradead.org>
 <CAGWkznHOWVPpKHOuvvDF2zppkTT0_x4WyJ5S75j+EghhZmEDdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznHOWVPpKHOuvvDF2zppkTT0_x4WyJ5S75j+EghhZmEDdg@mail.gmail.com>

On Thu, Mar 21, 2024 at 04:25:07PM +0800, Zhaoyang Huang wrote:
> ok. Could the scenario below be suspicious on leaving an orphan folio
> in step 7 and introduce the bug in step 8. In the scenario,
> Thread_filemap behaves as a backdoor for Thread_madv by creating the
> pte after Thread_truncate finishes cleaning all page tables.
> 
> 0. Thread_bad gets the folio by folio_get_entry and stores it in its
> local fbatch_bad and go to sleep

There's no function called folio_get_entry(), but clearly thread_bad
should have a refcount on it at this point.

> 1. Thread_filemap get the folio via
> filemap_map_pages->next_uptodate_folio->xas_next_entry and gets
> preempted
>     refcnt == 1(page_cache), PG_lru == true

so the refcount should be 2 here.

> 2. Thread_truncate get the folio via
> truncate_inode_pages_range->find_lock_entries
>     refcnt == 2(fbatch_trunc, page_cache), PG_lru == true
> 
> 3. Thread_truncate proceed to truncate_cleanup_folio
>     refcnt == 2(fbatch_trunc, page_cache), PG_lru == true
> 
> 4. Thread_truncate proceed to delete_from_page_cache_batch
>     refcnt == 1(fbatch_trunc), PG_lru == true
> 
> 5. Thread_filemap schedule back and proceed to setup a pte and have
> folio->_mapcnt = 0 & folio->refcnt += 1
>     refcnt == 2(pte, fbatch_temp), PG_lru == true
> 
> 6. Thread_madv clear folio's PG_lru by
> madvise_xxx_pte_range->folio_isolate_lru->folio_test_clear_lru
>     refcnt == 2(pte,fbatch_temp), PG_lru == false
> 
> 7. Thread_truncate call folio_fbatch_release and failed in freeing
> folio as refcnt not reach 0
>     refcnt == 1(pte), PG_lru == false
> ********folio becomes an orphan here which is not on the page cache
> but on the task's VM**********
> 
> 8. Thread_xxx scheduled back from 0 to do release_pages(fbatch_bad)
> and have the folio introduce the bug.

.. because if these steps happen as 7, 8, 6, you hit the BUG in
folio_isolate_lru().

