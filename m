Return-Path: <linux-kernel+bounces-1110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 287A1814A9E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BD441C235A2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D57358A3;
	Fri, 15 Dec 2023 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ug3ZjL5M"
X-Original-To: linux-kernel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AC835884;
	Fri, 15 Dec 2023 14:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Y5+Oppl7Eai1Gazn1zCuzXFdRsqsodfM2YwuFgSvpsg=; b=Ug3ZjL5M6NrwtZt79VjTUklG89
	p324KBMNXDZ9PyVJL5d9VJQzrpkhVQVjDoPYuBg84iNi5li9ab/Jf8uWuHlKXLSDtNHPWW/61eSe4
	AG+ddXJDIiYlF83agu24wcF3axsI/tntMA5yMIeT6sJDqV6nLltFlbDLEEfVcQNFPmCIMl1r+Iatd
	+PnlFxsBbjFN2RzA03CMPm2e/kelhrTuQuFv3wV/5uX5EFXpF2iq3p6UIV30xzQexsNBGx8tcahNa
	sZE7TnlMcn8x5rc2Z31SeqL7s3LcXHeVHSg/fUmeRdmWC/ytc/ioSHvv/I0y0fkTEsrgZNc2G9MPZ
	sBCHaH5Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rE9Ib-000I0J-Tu; Fri, 15 Dec 2023 14:36:22 +0000
Date: Fri, 15 Dec 2023 14:36:21 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Kim Phillips <kim.phillips@amd.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/mm: Describe folios in physical_memory.rst
Message-ID: <ZXxkZcq4rzlzsiZh@casper.infradead.org>
References: <20231215120022.2010667-1-fabio.maria.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215120022.2010667-1-fabio.maria.de.francesco@linux.intel.com>

On Fri, Dec 15, 2023 at 01:00:12PM +0100, Fabio M. De Francesco wrote:
> +A folio is a physically, virtually and logically contiguous set of bytes.
> +It is a power-of-two in size, and it is aligned to that same power-of-two.
> +It is at least as large as %PAGE_SIZE. If it is in the page cache, it is
> +at a file offset which is a multiple of that power-of-two. It may be
> +mapped into userspace at an address which is at an arbitrary page offset,
> +but its kernel virtual address is aligned to its size.

This text is verbatim from include/linux/mm_types.h.  It seems sad
to have kernel-doc and then replicate it in an rst file.

> +As Matthew Wilcox explains in his introduction to folios, the need for

oof, no, don't mention my name.

> +`struct folio` arises mostly to address issues with the use of compound
> +pages. It is often unclear whether a function operates on an individual
> +page, or an entire compound page.
> +
> +"A function which has a `struct page` pointer argument might be
> +expecting a head or base page and will BUG if given a tail page. It might
> +work with any kind of page and operate on %PAGE_SIZE bytes. It might work
> +with any kind of page and operate on page_size() bytes if given a head
> +page but %PAGE_SIZE bytes if given a base or tail page. It might operate
> +on page_size() bytes if passed a head or tail page. We have examples of
> +all of these today.".
> +
> +A pointer to folio points to a page that is never a tail page. It
> +represents an entire compound page. Therefore, there is no need to call
> +compound_head() to get a pointer to the head. Folios has eliminted the
> +need to unnecessary calls and has avoided bugs related to the misuse of
> +pages passed to functions. Furthermore, the inline compound_head() makes
> +the kernel bigger and slows things down.
> +
> +The folio APIs are described in the "Memory Management APIs" document.

This was exactly the kind of documentation I was hoping you wouldn't
write ;-(  It's documentation that makes sense today, but won't in five
years time.

We want to say something like,

A folio represents a single memory allocation.  It may be composed of
several pages ...

