Return-Path: <linux-kernel+bounces-105312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEAF87DC1C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 01:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C3271F21265
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 00:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18A41FBA;
	Sun, 17 Mar 2024 00:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r9SxkOpx"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE64173
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 00:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710636109; cv=none; b=X2bkLiHe48hOhjzcpXMoXbjJeSFzjHTmvLLhk9TnTUggcYed3emn5MkU9kYvdIyBkMi22kf8LT7+h19LwnFaYV1Tg40S0eKNevGUtNtBiU1h3wB7/j8j1I9z9CbCXLd6tThJaCHmHAAH4iY+gTcoQwXnQFZ4QyBb4y9tfoj6mq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710636109; c=relaxed/simple;
	bh=swL5pSZGofZVCvafPRaSq1d18g1PPcmvWeKOt9Qqmts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdJrhFp3MgPL7vs3owB2mCOLXd2VVWHPYWbi7CKfTnSB5uHSQVP0SHD5DKfrl8bwP9NASXfFdg/aKpgLE0S8eWlh631bcd5DLfLKK7qqePLSehWRKc7Hb9z3RUy0kPLP7AXk5jwZescywfzMm9H8F3XrC5zkFVmKlSHOcXt7nBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=r9SxkOpx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=861eAApZXU3vRWwZN8NtN/fYtVMSBl0R3WWZ/C06Z0Q=; b=r9SxkOpx8uSxPEXiP+T4k4YbNJ
	S3eEb2b5Vpi8f6A8oMByvAXoYB3SXV6n+MW35TNtZ7/qEhUzgzNoSUcmcbWPLYOFco0/m3wpt0CQj
	iCFUMsRj8nv73rZCeRdj72QGjSpko+mUlLVALjH7fNEoDhCu9RvOf6LarDDMbRN9vigskiOWlsC5j
	ebFn0EAeFzGeOflSwEf+ArT0jpvN76o2U8aCtX1/usKVBkF1kjzsQMrHT37Nc1Oo3JYnbL8Np5Pfu
	MEeOQbTPrhoWVACzqbRyPrXaJxxaWBzc/xBakX1Xk5LKF2GA9+wYvYv7Y3Ou/I4gnkz+WK8Rv6wwK
	ZsMXA7XA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rleaj-0000000Dbuk-2kaT;
	Sun, 17 Mar 2024 00:41:33 +0000
Date: Sun, 17 Mar 2024 00:41:33 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, x86@kernel.org, bp@alien8.de,
	brauner@kernel.org, bristot@redhat.com, bsegall@google.com,
	dave.hansen@linux.intel.com, dianders@chromium.org,
	dietmar.eggemann@arm.com, eric.devolder@oracle.com,
	hca@linux.ibm.com, hch@infradead.org, jacob.jun.pan@linux.intel.com,
	jgg@ziepe.ca, jpoimboe@kernel.org, jroedel@suse.de,
	juri.lelli@redhat.com, kinseyho@google.com,
	kirill.shutemov@linux.intel.com, lstoakes@gmail.com,
	luto@kernel.org, mgorman@suse.de, mic@digikod.net,
	michael.christie@oracle.com, mingo@redhat.com, mjguzik@gmail.com,
	mst@redhat.com, npiggin@gmail.com, peterz@infradead.org,
	pmladek@suse.com, rick.p.edgecombe@intel.com, rostedt@goodmis.org,
	surenb@google.com, tglx@linutronix.de, urezki@gmail.com,
	vincent.guittot@linaro.org, vschneid@redhat.com
Subject: Re: [RFC 00/14] Dynamic Kernel Stacks
Message-ID: <ZfY8PSnsLtkHBBZF@casper.infradead.org>
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <2cb8f02d-f21e-45d2-afe2-d1c6225240f3@zytor.com>
 <ZfNTSjfE_w50Otnz@casper.infradead.org>
 <2qp4uegb4kqkryihqyo6v3fzoc2nysuhltc535kxnh6ozpo5ni@isilzw7nth42>
 <ZfNWojLB7qjjB0Zw@casper.infradead.org>
 <CA+CK2bAmOj2J10szVijNikexFZ1gmA913vvxnqW4DJKWQikwqQ@mail.gmail.com>
 <39F17EC4-7844-4111-BF7D-FFC97B05D9FA@zytor.com>
 <CA+CK2bDothmwdJ86K1LiKWDKdWdYDjg5WCwdbapL9c3Y_Sf+kg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bDothmwdJ86K1LiKWDKdWdYDjg5WCwdbapL9c3Y_Sf+kg@mail.gmail.com>

On Sat, Mar 16, 2024 at 03:17:57PM -0400, Pasha Tatashin wrote:
> Expanding on Mathew's idea of an interface for dynamic kernel stack
> sizes, here's what I'm thinking:
> 
> - Kernel Threads: Create all kernel threads with a fully populated
> THREAD_SIZE stack.  (i.e. 16K)
> - User Threads: Create all user threads with THREAD_SIZE kernel stack
> but only the top page mapped. (i.e. 4K)
> - In enter_from_user_mode(): Expand the thread stack to 16K by mapping
> three additional pages from the per-CPU stack cache. This function is
> called early in kernel entry points.
> - exit_to_user_mode(): Unmap the extra three pages and return them to
> the per-CPU cache. This function is called late in the kernel exit
> path.
> 
> Both of the above hooks are called with IRQ disabled on all kernel
> entries whether through interrupts and syscalls, and they are called
> early/late enough that 4K is enough to handle the rest of entry/exit.

At what point do we replenish the per-CPU stash of pages?  If we're
12kB deep in the stack and call mutex_lock(), we can be scheduled out,
and then the new thread can make a syscall.  Do we just assume that
get_free_page() can sleep at kernel entry (seems reasonable)?  I don't
think this is an infeasible problem, I'd just like it to be described.

