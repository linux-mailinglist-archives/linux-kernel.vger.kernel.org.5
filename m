Return-Path: <linux-kernel+bounces-160566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 511AF8B3F36
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E5EF1C232F6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9186516DEDC;
	Fri, 26 Apr 2024 18:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bOJEGkvT"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E9F16DEA7
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714156049; cv=none; b=UMtZjKjyvAlH9byO5CAH+A5UOhCFSndx2mcm+uzXs6zYmL/l3GbjucTSi+ftQBdqlgnfIMWMxfQDZoN9cVPLG1/AsMBJkkUN7DrB+MHeU/f07wkA6bflfOVzylwsW7FgrYsio1e2Mj2isCK6enaUZ/OwvF/DSW9xmojA9Cb8ewc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714156049; c=relaxed/simple;
	bh=be8/Rc72FM8q9y81D+DEZB2rDuXPsnt1ZArWZv6w6OU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdyVO0wXIgm8TZ8p4Em+wLo+PHXE+orTW2HyP17PpLiBvNNbJVQLXa/n/pj01jMfKGtXPTYxZiAbdbnvPjcmnnM3mrNzuV5GgWAJRCWWFTp7fbMKwLnESyurOIhyiGReSeTwO58ovIrznqS1uWr4Ll5Dv6waIQDB9MS2WKXknAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bOJEGkvT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=s+DGkSM+maNgMoPLnCW4gErb3+do/Z2NXGma0NpyOgg=; b=bOJEGkvTvQsYiIERA14CzGyMW1
	hqWSc1P0nwZAPbdefKRM5Ofv0x4XFO31V9r7Pc1Kim2caV4NgjZPutrBmcQwNzXqQsZP8+LuUIoo+
	zAe87FXjtdmuyzKvJVMwzwMREm56b4oy8nA+VousVkoVVlYZWNoIzr6wlkKTzNLp+kF61wcaFSdWQ
	KrcczRzrTc6sduRJCT7ao9Wc6UVahwlCONug85sxB1Y73B8Fr8Z8zAhpKMNqPBYW/akFZmNpmwwOd
	gdQX/tJj81D5B1aLDDYbJWMezJ0E9qDVkcF9aXSpU2s8Ncokd1nu1ODFX6ZqaqMtYvkXl43sov5+j
	44S/ZXXA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0QI7-00000005lnM-1Tr2;
	Fri, 26 Apr 2024 18:27:23 +0000
Date: Fri, 26 Apr 2024 19:27:23 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, linmiaohe@huawei.com,
	jane.chu@oracle.com, nao.horiguchi@gmail.com, osalvador@suse.de
Subject: Re: [PATCH] mm/memory-failure: remove shake_page()
Message-ID: <ZivyC3vqa2BIBoMj@casper.infradead.org>
References: <20240426171511.122887-1-sidhartha.kumar@oracle.com>
 <ZivlrMAwRI6xJhc-@casper.infradead.org>
 <d05cbf22-f3e8-414a-a2e3-03e0b857eaca@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d05cbf22-f3e8-414a-a2e3-03e0b857eaca@oracle.com>

On Fri, Apr 26, 2024 at 10:57:31AM -0700, Sidhartha Kumar wrote:
> On 4/26/24 10:34 AM, Matthew Wilcox wrote:
> > On Fri, Apr 26, 2024 at 10:15:11AM -0700, Sidhartha Kumar wrote:
> > > Use a folio in get_any_page() to save 5 calls to compound head and
> > > convert the last user of shake_page() to shake_folio(). This allows us
> > > to remove the shake_page() definition.
> > 
> > So I didn't do this before because I wasn't convinced it was safe.
> > We don't have a refcount on the folio, so the page might no longer
> > be part of this folio by the time we get the refcount on the folio.
> > 
> > I'd really like to see some argumentation for why this is safe.
> 
> If I moved down the folio = page_folio() line to after we verify
> __get_hwpoison_page() has returned 1, which indicates the reference count
> was successfully incremented via foliO_try_get(), that means the folio
> conversion would happen after we have a refcount. In the case we don't call
> __get_hwpoison_page(), that means the MF_COUNT_INCREASED flag is set. This
> means the page has existing users so that path would be safe as well. So I
> think this is safe after moving page_folio() after __get_hwpoison_page().

See if you can find a hole in this chain of reasoning ...

memory_failure()
        p = pfn_to_online_page(pfn);
        res = try_memory_failure_hugetlb(pfn, flags, &hugetlb);
(not a hugetlb)
        if (TestSetPageHWPoison(p)) {
(not already poisoned)
        if (!(flags & MF_COUNT_INCREASED)) {
                res = get_hwpoison_page(p, flags);

get_hwpoison_page()
                ret = get_any_page(p, flags);

get_any_page()
	folio = page_folio(page)

Because we don't have a reference on the folio at this point (how could
we?), the folio might be split, and now we have a pointer to a folio
which no longer contains the page (assuming we had a hwerror in what
was a tail page at this time).

