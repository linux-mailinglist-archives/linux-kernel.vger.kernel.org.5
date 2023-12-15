Return-Path: <linux-kernel+bounces-1296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE27B814D0A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C5451C23924
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606603EA6B;
	Fri, 15 Dec 2023 16:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bpAT68hY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1863EA82;
	Fri, 15 Dec 2023 16:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702657778; x=1734193778;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BOKVON2nPzCUQ+5yB/RhFkliuaM48sv6AgfSyuqqRlM=;
  b=bpAT68hYY6H7EmOjN0j1smE0ghZzyOEGugNygkky4FPHa8CAWJFSlpSs
   LyiFgCegN/cYnCiiQ1ExCd7wlIVPuxjHZsMz/naVtQt1lJVULKEjnBi6h
   t/V24NxDMrCqoyx8hhL1CptqHZ4hu7OZuY7xsaNNQYmPFrN2qwXs3rk3a
   x80HqzWxSrHHdsYY5I2ZA02olhLeP76KvPed8v6Nx4+Al9PdF5DOYc3KQ
   LcSS7DF/bRlMuDYqC/qJnBh8nT/AJE8XgQLLLHiLOAqidAlNsr4Mzk6nU
   LHtcHK0qOU/esRzdJ0ckVvW9bGUi6GycswSf5ilI31fY1pWhW+ltuFjdh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="8717587"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="8717587"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 08:29:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="845175327"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="845175327"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.213.8.163])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 08:29:33 -0800
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Bagas Sanjaya <bagasdotme@gmail.com>, Lorenzo Stoakes <lstoakes@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Kim Phillips <kim.phillips@amd.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/mm: Describe folios in physical_memory.rst
Date: Fri, 15 Dec 2023 17:29:30 +0100
Message-ID: <25243171.6Emhk5qWAg@fdefranc-mobl3>
Organization: intel
In-Reply-To: <ZXxkZcq4rzlzsiZh@casper.infradead.org>
References:
 <20231215120022.2010667-1-fabio.maria.de.francesco@linux.intel.com>
 <ZXxkZcq4rzlzsiZh@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, 15 December 2023 15:36:21 CET Matthew Wilcox wrote:
> On Fri, Dec 15, 2023 at 01:00:12PM +0100, Fabio M. De Francesco wrote:
> > +A folio is a physically, virtually and logically contiguous set of bytes.
> > +It is a power-of-two in size, and it is aligned to that same
> > power-of-two.
> > +It is at least as large as %PAGE_SIZE. If it is in the page cache, it is
> > +at a file offset which is a multiple of that power-of-two. It may be
> > +mapped into userspace at an address which is at an arbitrary page offset,
> > +but its kernel virtual address is aligned to its size.
> 
> This text is verbatim from include/linux/mm_types.h.  It seems sad
> to have kernel-doc and then replicate it in an rst file.

Actually, I took this text from the private email you sent me. I thought you 
were asking to use exactly this words. And so I acted accordingly to what it 
seemed to me you had suggested. 

Furthermore I had forgotten that these words are in kernel-doc exactly because 
I copy-pasted from your email.

OK. I can explain what a folio is by using different words and elaborating a 
bit.

> > +As Matthew Wilcox explains in his introduction to folios, the need for
> 
> oof, no, don't mention my name.
> 
> > +`struct folio` arises mostly to address issues with the use of compound
> > +pages. It is often unclear whether a function operates on an individual
> > +page, or an entire compound page.
> > +
> > +"A function which has a `struct page` pointer argument might be
> > +expecting a head or base page and will BUG if given a tail page. It might
> > +work with any kind of page and operate on %PAGE_SIZE bytes. It might work
> > +with any kind of page and operate on page_size() bytes if given a head
> > +page but %PAGE_SIZE bytes if given a base or tail page. It might operate
> > +on page_size() bytes if passed a head or tail page. We have examples of
> > +all of these today.".
> > +
> > +A pointer to folio points to a page that is never a tail page. It
> > +represents an entire compound page. Therefore, there is no need to call
> > +compound_head() to get a pointer to the head. Folios has eliminted the
> > +need to unnecessary calls and has avoided bugs related to the misuse of
> > +pages passed to functions. Furthermore, the inline compound_head() makes
> > +the kernel bigger and slows things down.
> > +
> > +The folio APIs are described in the "Memory Management APIs" document.
> 
> This was exactly the kind of documentation I was hoping you wouldn't
> write ;-(  It's documentation that makes sense today, but won't in five
> years time.

I wanted to explain why you introduced folios. If you think that the 
historical perspective is not what future developers will need in the next 5 
years, I can think of something else. 

> We want to say something like,
> 
> A folio represents a single memory allocation.  It may be composed of
> several pages ...

Ah, OK. I think I got it.

Thanks for your comments.

Fabio



