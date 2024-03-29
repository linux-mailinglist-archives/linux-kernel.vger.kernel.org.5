Return-Path: <linux-kernel+bounces-124472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3826289188F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0F88285866
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C9C85631;
	Fri, 29 Mar 2024 12:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GA83YCFC"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166F969E1E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 12:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711714796; cv=none; b=Qcm8q+uatTgJ5sSsISJZbMCq/HATC+g4DCDfIe0ejiOFL7mbd5MXsvWDCx2FdelYKoZ/yn+Ab0HMGDQIV1MBeTDmZd5OjRhiLJ5J9LfSKWtFMIT+5tXMUcZvZxnAXQSfH5UX3B1qQ9u/ozj/U5Bjn7b2vJ10MaFFZa2nghxDxoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711714796; c=relaxed/simple;
	bh=tORNmA0pcr5kmfPGn86vAvHUqiKTcOTMsK8JNl9m2yE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/uK3Y1aQzS/tXHv6g5SaRT9oJNPokWNObOUEKBOgpQcPZMta15GgX5hhYjMUboeMx/dMeS1C2b0g41lcg6vevClLHT7106jXWYNmrtk5r5RxtFJix7hWPdHpwxdaaXd7rYrgBhn5QOpMZ2RtRdZfTD1mED/q/I0LfDzF0qGXfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GA83YCFC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=MrTY9njKVMkKTePqZ/9p2zVzye3piYo5llqsJ8WWYhM=; b=GA83YCFCLDvB8oIpV8GkCXMHG7
	L2DMDsP3NONzY46zE1idx2BzwKua0tdu5BCoLWAI8CSofxTCOB/XF7M4Swb0ZpShQ1Me2r7E4RVjg
	dR7KL2SPkg5nK/HwwRilvPC7buX4UysUSW2NWQy813gnylO3D8kHtjrLkfLycopf7gU+YrMDCyKV0
	Ko7Qif287kdeMDm6Q6jvxh7v4TH1fG+/Uu6xSHC2JoVWCMJYTPmthprfUs6RTSYLTJR6btg4W+CsN
	OxXAWLArSdNAOtzjgpKoxiDi8mJoQ/aR/H8WqEeYIYaaG8Q+duomq/ehv7ubjGK6gIvR4MaaoAzRC
	qPjwC22g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqBCu-000000098jD-3qYS;
	Fri, 29 Mar 2024 12:19:40 +0000
Date: Fri, 29 Mar 2024 12:19:40 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: =?utf-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?= <zhaoyang.huang@unisoc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?5bq357qq5ruoIChTdGV2ZSBLYW5nKQ==?= <Steve.Kang@unisoc.com>
Subject: Re: summarize all information again at bottom//reply: reply: [PATCH]
 mm: fix a race scenario in folio_isolate_lru
Message-ID: <Zgax3EQUiWx4DpC7@casper.infradead.org>
References: <ZgDt9mwN-Py5Y-xr@casper.infradead.org>
 <CAGWkznHO27EpVVpFyKnv-SX-JTYCXQxb0MG+EW07gaupocR4RQ@mail.gmail.com>
 <ZgK91II_eSYY6D2F@casper.infradead.org>
 <CAGWkznGLySzLE17+rCe=UoA26vx=iM375o2zkruKM9ssG05QzA@mail.gmail.com>
 <ZgQRtQ60mrvOUKXo@casper.infradead.org>
 <CAGWkznF3GfCs8odhR-Hue5H8MZ=eXb82V20ZoCCjeoSjAPQ9cw@mail.gmail.com>
 <ZgThg-pzQzRl3ckF@casper.infradead.org>
 <CAGWkznEMCXQSe10E-pbdxk2uFgQO038wH6g=iojtSU6-N+GJdg@mail.gmail.com>
 <ZgV65ercduTnVWCA@casper.infradead.org>
 <CAGWkznG7oyh9D-ozN7zQrpJz3s+N_ra1P=Yw3Nd3B0X=thCAxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGWkznG7oyh9D-ozN7zQrpJz3s+N_ra1P=Yw3Nd3B0X=thCAxg@mail.gmail.com>

On Fri, Mar 29, 2024 at 01:49:05PM +0800, Zhaoyang Huang wrote:
> On Thu, Mar 28, 2024 at 10:12 PM Matthew Wilcox <willy@infradead.org> wrote:
> key steps in brief:
> Thread_truncate get folio to its local fbatch by find_get_entry in step 2
> The refcnt is deducted to 1 which is not as expect as from alloc_pages
> but from thread_truncate's local fbatch in step 7
> Thread_reclaim succeed to isolate the folio by the wrong refcnt(not
> the value but meaning) in step 8
> Thread_truncate hit the VM_BUG_ON in step 9
> 
> all steps:
> Thread_readahead:
> 0. folio = filemap_alloc_folio(gfp_mask, 0);
>        (folio has refcount 1)
> 1. ret = filemap_add_folio(mapping, folio, index + i, gfp_mask);
>        (folio has refcount 2)
> 2. thread_truncate hold one refcnt and add this folio to fbatch_truncate
>        (folio has refcount 3(alloc, page cache, fbatch_truncate), PG_lru)
> 3. Then we call read_pages()
>        First we call ->readahead() which for some reason stops early.
> 4. Then we call readahead_folio() which calls folio_put()
>        (folio has refcount 2)
> 5. Then we call folio_get()
>        (folio has refcount 3)
> 6. Then we call filemap_remove_folio()
>        (folio has refcount 2)
> 7. Then we call folio_unlock()
>        Then we call folio_put()
>        (folio has refcount 1(fbatch_truncate))
> 8. thread_reclaim call shrink_inactive_list->isolate_lru_folios
>         shrink_inactive_list
>             isolate_lru_folios
>                if (!folio_test_lru(folio))
>                if (!folio_try_get(folio))
>                if (!folio_test_clear_lru(folio))
>                list_move(folio, dst)
>        (folio has refcount 2)
> 
> 8.1. thread_reclaim call shrink_folio_list->__remove_mapping
>     shrink_folio_list()
>         __remove_mapping()
>              (refcount = 2)
>             if (!folio_ref_freeze(2)) //true
>          list_add(folio, free_folios);
>        (folio has refcount 0)
> 
> 9. thread_truncate will hit the refcnt VM_BUG_ON(refcnt == 0) in
> folio_put_testzero

But now you're talking about something _entirely different_ that isn't
the bug you hit.  isolate_lru_folios is not isolate_lru_folio.

I am disinclined to pick through this example to find out why you're
wrong again.  I'm also disinclined to continue this correspondance.
We're not making any progress here.

