Return-Path: <linux-kernel+bounces-103744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B7287C3E0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DB2F1C225DB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6788475812;
	Thu, 14 Mar 2024 19:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gbtwdjqn"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C581E745C2
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 19:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710446250; cv=none; b=hF2HeWZiOeTPpnGU/N8YnCNsVDoRRxYzDy9fJhxeEZxjPZpyMT/2H1D9qCJx5FpwVqeCiwCVcXuKZFyWcrG77WjFdnsfvp0vWy1pcEDkVjiPCnyZKxEK+gL0bOaRHXLkzqafFNl0QcpOalFhWEp1Vx+rkPuBzGraltOMlGmI4CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710446250; c=relaxed/simple;
	bh=TwZEOGcOM032rwBQtH93JANabCGKM+RvXP0Nqx5Ous0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZIGWN19YcgqlKdfN58eashgufaP9HEKxLJvQ7qQmjCUP5MnjwglADWQHO6D/m6PgzsYUx7xS2pklBJV8InZbW5oho0D3dDvUwvbQnvEWIwzkC6yd2v5R4D0PscrlROt1h3PiHzpPqUmu9Qs4AxdFpY1MxV7lnasOKVFzGFuB14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Gbtwdjqn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dlngYo+VSnclef4VOZhdqljtbFfFaVONfLZGwaKrv+E=; b=GbtwdjqnLBzaCLa97mN0tIYapt
	jN504bjb2WWVxM0pxPKK7bCP/++OdQZzcqGnNtJW5m+auFeMeCltw812aoQHTG87y7qXgEm/TPyjY
	cs0hWlXYoaYVYp3oY5MMflk4TeehJidlMS46KNez+5Dttc6+muQeGgtsNv4P/ubSVS6oJaFrMW7PV
	xua560O/7pLBegf1hC+gofn6oK2zXCmlc9tmjEx2V+w2H0/E96E3nPezuSVcK4tRu350cs5+t1f00
	C3U72wqh/sKrhmsj8+IlusbyyxahSnHj4PKTOs8VR0GvME4blEC7DT/D6mYJf/4IZkgg8MtkDGmJR
	BlnBAaXA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkrCc-00000008ZW4-3t4d;
	Thu, 14 Mar 2024 19:57:22 +0000
Date: Thu, 14 Mar 2024 19:57:22 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
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
Message-ID: <ZfNWojLB7qjjB0Zw@casper.infradead.org>
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <2cb8f02d-f21e-45d2-afe2-d1c6225240f3@zytor.com>
 <ZfNTSjfE_w50Otnz@casper.infradead.org>
 <2qp4uegb4kqkryihqyo6v3fzoc2nysuhltc535kxnh6ozpo5ni@isilzw7nth42>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2qp4uegb4kqkryihqyo6v3fzoc2nysuhltc535kxnh6ozpo5ni@isilzw7nth42>

On Thu, Mar 14, 2024 at 03:53:39PM -0400, Kent Overstreet wrote:
> On Thu, Mar 14, 2024 at 07:43:06PM +0000, Matthew Wilcox wrote:
> > On Tue, Mar 12, 2024 at 10:18:10AM -0700, H. Peter Anvin wrote:
> > > Second, non-dynamic kernel memory is one of the core design decisions in
> > > Linux from early on. This means there are lot of deeply embedded assumptions
> > > which would have to be untangled.
> > 
> > I think there are other ways of getting the benefit that Pasha is seeking
> > without moving to dynamically allocated kernel memory.  One icky thing
> > that XFS does is punt work over to a kernel thread in order to use more
> > stack!  That breaks a number of things including lockdep (because the
> > kernel thread doesn't own the lock, the thread waiting for the kernel
> > thread owns the lock).
> > 
> > If we had segmented stacks, XFS could say "I need at least 6kB of stack",
> > and if less than that was available, we could allocate a temporary
> > stack and switch to it.  I suspect Google would also be able to use this
> > API for their rare cases when they need more than 8kB of kernel stack.
> > Who knows, we might all be able to use such a thing.
> > 
> > I'd been thinking about this from the point of view of allocating more
> > stack elsewhere in kernel space, but combining what Pasha has done here
> > with this idea might lead to a hybrid approach that works better; allocate
> > 32kB of vmap space per kernel thread, put 12kB of memory at the top of it,
> > rely on people using this "I need more stack" API correctly, and free the
> > excess pages on return to userspace.  No complicated "switch stacks" API
> > needed, just an "ensure we have at least N bytes of stack remaining" API.
> 
> Why would we need an "I need more stack" API? Pasha's approach seems
> like everything we need for what you're talking about.

Because double faults are hard, possibly impossible, and the FRED approach
Peter described has extra overhead?  This was all described up-thread.

