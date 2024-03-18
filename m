Return-Path: <linux-kernel+bounces-106116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE8987E95A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C25A2811FB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4701E208CA;
	Mon, 18 Mar 2024 12:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XEm+Wdrx"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B381E49E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 12:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710765160; cv=none; b=S+r28NLSRBs0KNJtL6GuXqy6uJwTcAaDe4C0GQVGWm+DMXCY8APDoWpgB+vfMB14NMISJHKaNniy0PmomPBpagiYEUPO5Gt/f1nyWU5S/qN4oPKxfqIKJswvqrlAwDeRqo1eCJ2vijc8kJu7bzV4pGBsuqABHfdZtyjKssw1xc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710765160; c=relaxed/simple;
	bh=efnVPpmb2teYRxdgVuvr53GXPaEARKO2oJiZDPTgVSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMRW907IUYoYSOPOOjWXvBGFNu60OXI20CGrFR9RVtl49N3P0oio9gO3ISYL1cLgPfunzO8eFeri5h6G0BboLLXEiTUmYpgV3HSROQg46ffzbnuDa0mjvArm4mMv7C0klMg53epo5pgnwAeM2HwMR6q62bt5Fo+q2BYW/kY+bZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XEm+Wdrx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=HSPhwXSCxS++lB8cW7HjxSToUp/DCPeVhcBtHho/j3E=; b=XEm+WdrxFnpkahFybnf2FrA+2/
	rw1XzkwVssLBE54wENkAoZC8nJIs/MbYgaGfgGfxS12nOe5T+nND8XrN9cBOt0W3TfZx1NvE1oOWU
	HFevprZ7dWzFtOFYcLSMCvABeljS5xnpTCzBV3OGCeA3RRk28Rh8X3/ijDv785eu6/dnqRbCSOI+a
	YcsB95n1tMjF0A+SWYwN5OtsaP2CJ/dJHjeWfVhlmjrGXbjg7iB14GUT2mijIQYh99nD/1wTnHzqp
	7BE4J7lKnVCgkaN6T4VCUcHwuyzIrtPt3dauNribIu8tiXLoxuARtDB/aK/H1yMrTjWQO2XDys2ds
	7lBlZfVg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmCAC-0000000H9S1-2Xle;
	Mon, 18 Mar 2024 12:32:24 +0000
Date: Mon, 18 Mar 2024 12:32:24 +0000
From: Matthew Wilcox <willy@infradead.org>
To: =?utf-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?= <zhaoyang.huang@unisoc.com>
Cc: Zhaoyang Huang <huangzhaoyang@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?5bq357qq5ruoIChTdGV2ZSBLYW5nKQ==?= <Steve.Kang@unisoc.com>
Subject: Re: summarize all information again at bottom//reply: reply: [PATCH]
 mm: fix a race scenario in folio_isolate_lru
Message-ID: <Zfg0WLrcOmCtdn_M@casper.infradead.org>
References: <be75859d7e4245939d825da5e881902c@BJMBX01.spreadtrum.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be75859d7e4245939d825da5e881902c@BJMBX01.spreadtrum.com>


Stop creating new threads.  You're really annoying.

On Mon, Mar 18, 2024 at 09:32:32AM +0000, 黄朝阳 (Zhaoyang Huang) wrote:
> Summarize all information below to make it more clear(remove thread2 which is not mandatory and make the scenario complex)

You've gone back to over-indenting.  STOP IT.

> #thread 0(madivise_cold_and_pageout)        #thread1(truncate_inode_pages_range) 

This is still an impossible race, and it's the third time I've told you
this.  And madivise_cold_and_pageout does not exist, it's
madvise_cold_or_pageout_pte_range().  I'm going to stop responding to
your emails if you keep on uselessly repeating the same mistakes.

So, once again,

For madvise_cold_or_pageout_pte_range() to find a page, it must have
a PTE pointing to the page.  That means there's a mapcount on the page.
That means there's a refcount on the page.

truncate_inode_pages_range() will indeed attempt to remove a page from
the page cache.  BUT before it does that, it has to shoot down TLB
entries that refer to the affected folios.  That happens like this:

                for (i = 0; i < folio_batch_count(&fbatch); i++)
                        truncate_cleanup_folio(fbatch.folios[i]);
truncate_cleanup_folio() -> unmap_mapping_folio ->
unmap_mapping_range_tree() -> unmap_mapping_range_vma() ->
zap_page_range_single() -> unmap_single_vma -> unmap_page_range ->
zap_p4d_range -> zap_pud_range -> zap_pmd_range -> zap_pte_range ->
pte_offset_map_lock()

> pte_offset_map_lock						 takes NO lock
> 										 truncate_inode_folio(refcnt == 2)
> 										 <decrease the refcnt of page cache>
> folio_isolate_lru(refcnt == 1)	                 
> 										 release_pages(refcnt == 1)
> folio_test_clear_lru 
> <remove folio's PG_lru>
> 										folio_put_testzero == true
> folio_get(refer to isolation)
> 										folio_test_lru == false
> 									  	<No lruvec_del_folio>
> 										list_add(folio->lru, pages_to_free)
> 										****current folio will break LRU's integrity since it has not been deleted****
> 
> 0. Folio's refcnt decrease from 2 to 1 by filemap_remove_folio
> 1. thread 0 calls folio_isolate_lru with refcnt == 1. Folio comes from vm's pte
> 2. thread 1 calls release_pages with refcnt == 1. Folio comes from address_space
> (refcnt == 1 make sense for both of folio_isolate_lru and release_pages)
> 3. thread0 clear folio's PG_lru by folio_test_clear_lru
> 4. thread1 decrease folio's refcnt from 1 to 0 and get permission to proceed
> 5. thread1 failed in folio_test_lru and do no list_del(folio)
> 6. thread1 add folio to pages_to_free wrongly which break the LRU's->list 
> 7. next folio after current one within thread1 experiences list_del_invalid when calling lruvec_del_folio

