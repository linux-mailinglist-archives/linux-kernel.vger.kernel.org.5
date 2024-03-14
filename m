Return-Path: <linux-kernel+bounces-103745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B80C87C3E2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE5191F22E64
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CCA7602C;
	Thu, 14 Mar 2024 19:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="shkAhrn4"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0360F74BE8
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 19:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710446296; cv=none; b=agembbyKMRkLXwV7ssbhq6aIYgqintTp9G02aFIi7NIZYXP5rZO9dO42rQNrCA3laROvU8WlYYmlMIG62Ooy0DuD9441np2pXb3nVF9viA0FDvDhMAenIkiS5g5XnPCO60hrgB1nhk7XWv5jUVD/lIHeQI5nCVggFB5gxcCl3ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710446296; c=relaxed/simple;
	bh=ugj0vHZKjR6F1bjQ9vhOfG0FkNHs9CzAqkH2ydkQokM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJQeYqNCZ/GXsGPb8JjcmEUFXuKx3mL5R5mH6ezk/kG5XCRWvBDdAY/nnJzQ8fdO2RmYMAP+i4c204Lb/NBYD07a9/KCkHMIZVj50sG2R8s2RYC5/5u+T+NcqOq3RaiCA7EZTD8g6wVphDiZOUZfgGKymYi51wcxBiiV8G5NEi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=shkAhrn4; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 14 Mar 2024 15:58:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710446292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0bOLhFjMAf0PlBTMvDVYA/bwx6DlzT/WdrltAs6p8IE=;
	b=shkAhrn4sqSQ4emlsGGQjXl6L4IV7dKfTie67wpSZvJ0iZsoIDMbQKsIvrMqEu9/1S91ts
	wsWfCG9OHLAACjaTkpJJ3s1U/ez6ohf3Imo0FL49eQ3T/hlMpFK3yXiQYmcd84F/Y+CUtm
	89tjlDc5nTNYPgC5KnZXw1zB5kk71YM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, x86@kernel.org, bp@alien8.de, brauner@kernel.org, 
	bristot@redhat.com, bsegall@google.com, dave.hansen@linux.intel.com, 
	dianders@chromium.org, dietmar.eggemann@arm.com, eric.devolder@oracle.com, 
	hca@linux.ibm.com, hch@infradead.org, jacob.jun.pan@linux.intel.com, jgg@ziepe.ca, 
	jpoimboe@kernel.org, jroedel@suse.de, juri.lelli@redhat.com, kinseyho@google.com, 
	kirill.shutemov@linux.intel.com, lstoakes@gmail.com, luto@kernel.org, mgorman@suse.de, 
	mic@digikod.net, michael.christie@oracle.com, mingo@redhat.com, mjguzik@gmail.com, 
	mst@redhat.com, npiggin@gmail.com, peterz@infradead.org, pmladek@suse.com, 
	rick.p.edgecombe@intel.com, rostedt@goodmis.org, surenb@google.com, tglx@linutronix.de, 
	urezki@gmail.com, vincent.guittot@linaro.org, vschneid@redhat.com
Subject: Re: [RFC 00/14] Dynamic Kernel Stacks
Message-ID: <lkf36cacg2fyy2et424jghci3irtz55gzytt56bcwzbmw372ju@acpa7mtfihfb>
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <2cb8f02d-f21e-45d2-afe2-d1c6225240f3@zytor.com>
 <ZfNTSjfE_w50Otnz@casper.infradead.org>
 <2qp4uegb4kqkryihqyo6v3fzoc2nysuhltc535kxnh6ozpo5ni@isilzw7nth42>
 <ZfNWojLB7qjjB0Zw@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfNWojLB7qjjB0Zw@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 14, 2024 at 07:57:22PM +0000, Matthew Wilcox wrote:
> On Thu, Mar 14, 2024 at 03:53:39PM -0400, Kent Overstreet wrote:
> > On Thu, Mar 14, 2024 at 07:43:06PM +0000, Matthew Wilcox wrote:
> > > On Tue, Mar 12, 2024 at 10:18:10AM -0700, H. Peter Anvin wrote:
> > > > Second, non-dynamic kernel memory is one of the core design decisions in
> > > > Linux from early on. This means there are lot of deeply embedded assumptions
> > > > which would have to be untangled.
> > > 
> > > I think there are other ways of getting the benefit that Pasha is seeking
> > > without moving to dynamically allocated kernel memory.  One icky thing
> > > that XFS does is punt work over to a kernel thread in order to use more
> > > stack!  That breaks a number of things including lockdep (because the
> > > kernel thread doesn't own the lock, the thread waiting for the kernel
> > > thread owns the lock).
> > > 
> > > If we had segmented stacks, XFS could say "I need at least 6kB of stack",
> > > and if less than that was available, we could allocate a temporary
> > > stack and switch to it.  I suspect Google would also be able to use this
> > > API for their rare cases when they need more than 8kB of kernel stack.
> > > Who knows, we might all be able to use such a thing.
> > > 
> > > I'd been thinking about this from the point of view of allocating more
> > > stack elsewhere in kernel space, but combining what Pasha has done here
> > > with this idea might lead to a hybrid approach that works better; allocate
> > > 32kB of vmap space per kernel thread, put 12kB of memory at the top of it,
> > > rely on people using this "I need more stack" API correctly, and free the
> > > excess pages on return to userspace.  No complicated "switch stacks" API
> > > needed, just an "ensure we have at least N bytes of stack remaining" API.
> > 
> > Why would we need an "I need more stack" API? Pasha's approach seems
> > like everything we need for what you're talking about.
> 
> Because double faults are hard, possibly impossible, and the FRED approach
> Peter described has extra overhead?  This was all described up-thread.

*nod*

