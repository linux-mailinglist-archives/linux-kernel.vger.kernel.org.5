Return-Path: <linux-kernel+bounces-131553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A99E4898983
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62505288E1B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD7D129E7A;
	Thu,  4 Apr 2024 14:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iDEQ9byq"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359921292D7;
	Thu,  4 Apr 2024 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712239590; cv=none; b=ekexysTKENfRhJbDXX5C52h12iJcPJPvQV7vD2YVUjP8RbWi7eKSRtM+jJS6ZlvDZoC9cf0Uy3mu1Hu8JOmMGwipgu8palt9uxxrEXdKjsg3+qFDAJ0QhgJ92lv9NzL9iqwUO69vaDkBmOUixBVBbJ5rNMU6soLORVXyjglY3mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712239590; c=relaxed/simple;
	bh=MbY25kFZkVxbZu7ufPpiDQkctinsqlipZvgNEaQGk/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSgrpTzLkuRE55e+c5gcirXLnklPi5clRLDQmYodIgN8YVoKmAYSN9VbPNA2vntx0a775yKPGM0JKI0snadkp6/Ezd5x/0vMVmRg+bOfhNYy/GGiPSxQYwo/MJH+ycNEqJ2/jC5LdWumESJxre6Gcu4HaeTbaAuliE0Gci86U1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iDEQ9byq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sVJ002JHdkLNVhuos8JSEWKr9RAprOh6aTEVsWZAYDA=; b=iDEQ9byqBGmCHW//1SL2Od/+ch
	6mxZ1jsEjhNVNL75sNOFwsASFH5YqKtz411s4ZeBeMyINg0MeJoO4IgCx22+IHMYedIitICT+aGpy
	seGTx0eTzb+dR5FWcCMyawwoRVpkXHEH1B3A4uWv5MdObQGhFMUb7XcMOsCO2BJT/2sVtQNGuEgCb
	MYF8Zs7+irbsazzHnXGQ8L0LgImDGgwTT1AF82aATaW6Vdh9bVNZOfROFIsqnV458DeF5ogs07DgE
	z2Lfw7pwwftG3FPk/jft60jNuc68yO5T5UchmMDis6DVMrl1wi4mR5J1mxg8o0bcaDOVUYh79+MpT
	I0VtV83Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsNjV-00000008BlB-1hxh;
	Thu, 04 Apr 2024 14:06:25 +0000
Date: Thu, 4 Apr 2024 15:06:25 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Peter Xu <peterx@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Ryan Roberts <ryan.roberts@arm.com>, loongarch@lists.linux.dev
Subject: Re: [PATCH 1/3] mm: Allow anon exclusive check over hugetlb tail
 pages
Message-ID: <Zg6z4ZEt7rbILgl8@casper.infradead.org>
References: <20240403013249.1418299-1-peterx@redhat.com>
 <20240403013249.1418299-2-peterx@redhat.com>
 <Zg3u5Sh9EbbYPhaI@casper.infradead.org>
 <Zg6vFtciZAl4SQHW@x1n>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zg6vFtciZAl4SQHW@x1n>

On Thu, Apr 04, 2024 at 09:45:58AM -0400, Peter Xu wrote:
> On Thu, Apr 04, 2024 at 01:05:57AM +0100, Matthew Wilcox wrote:
> > 	if (PageHuge(page))
> > 		page = compound_head(page);
> 
> I would think PageHead() check would help us to avoid compound_head() on
> heads, which should still be the majority cases iiuc (assuming page->flags
> is already around in the cache anyway).  I've no strong opinion though, as
> I can hardly tell a difference in reality.

compound_head() includes a check for PageHead().  Adding the check just
makes things slower.

