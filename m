Return-Path: <linux-kernel+bounces-140696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 420458A17D6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F012D283C21
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7A4DF43;
	Thu, 11 Apr 2024 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="htssSxQm"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2D0D529
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712847060; cv=none; b=FzFcpXvr+Q9lLWZEUT3vJ2F0y8nG7tWODqixkT5WVfZDQ2HiWbJrVwrZG+Mbkk6gocQh1uIZk5KnGtncRxBuqTEC/pKoSXkK8e+3pnzNBztfSZ8SbXK/JoiklDcrOGn3tjvZkmGchHNmi4BIUaXW16yQLmG5zGGfJYrojBcVqF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712847060; c=relaxed/simple;
	bh=qXdCCV1v8e6fpliMFxRQyRTWp6UPLWYt8+kWc5XMEow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/OI9A0mzZhOcH3+vB8XbXs6phpjxtIkSSPx9u4C2lk8FDP6IrHwt9CSg77+dFypdL98Jf04Bjq6HPpICV1nXRv2GV8rgfg6N6Kk25KJ12ikyx7+Fmzf2Q1Pa6KMeEm/5rBPLB9D6zPzNPLwcT+VgrjWkeQXqdr0cFfvJuTqzrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=htssSxQm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ySKvrwPo8uea30YwZAfejWfUzP0Mp1IBm6Q6ft0K7Zk=; b=htssSxQmNkaN/RBmRfuL8kT7KL
	zs5tNDETd96x1RY31+TkcVRnN6WV94kOkQkEK4fcKec1UMYpM2QD3LGlrhz6yHPMrZHI3eKyjZ7n0
	nm1kYHZR5oOyXbkQ22iBzIcaUg7mpCKhDKOzrCqQhM3x1uw/qHxMYuq6bkiARJ8S3B42KzWgspH1E
	2qFdTTYsuLf6aiDQCTPNlBhwA8LuvWARsfrz3lvGDzySjZozO6TpwpjVyUzomU14+EcJxVcgsQJo2
	W5hsYOjHgpl6clMZIPdtJNryOvYPBq8Ee4bA4oRpK9sG+Rxgt6KVBvzsFamoa/xK/eVmbY5ji/0hg
	C29DVCRQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruvlO-000000079zO-3dqQ;
	Thu, 11 Apr 2024 14:50:54 +0000
Date: Thu, 11 Apr 2024 15:50:54 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Lokesh Gidra <lokeshgidra@google.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH] mm: Always sanity check anon_vma first for per-vma locks
Message-ID: <Zhf4zqsfkz1XCwBN@casper.infradead.org>
References: <20240410170621.2011171-1-peterx@redhat.com>
 <Zhb2BWntckP3ZhDc@casper.infradead.org>
 <Zhb6B8UsidEEbFu3@x1n>
 <ZhcAVYVFSdX5Binc@casper.infradead.org>
 <ZhcDRmyYkMGPgs4F@x1n>
 <ZhcnzS1S6zOMJwSL@casper.infradead.org>
 <ZhcstFcjOuOmr0wx@x1n>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhcstFcjOuOmr0wx@x1n>

On Wed, Apr 10, 2024 at 08:20:04PM -0400, Peter Xu wrote:
> On Thu, Apr 11, 2024 at 12:59:09AM +0100, Matthew Wilcox wrote:
> > On Wed, Apr 10, 2024 at 05:23:18PM -0400, Peter Xu wrote:
> > > On Wed, Apr 10, 2024 at 10:10:45PM +0100, Matthew Wilcox wrote:
> > > > > I can do some tests later today or tomorrow. Any suggestion you have on
> > > > > amplifying such effect that you have concern with?
> > > > 
> > > > 8 socket NUMA system, 800MB text segment, 10,000 threads.  No, I'm not
> > > > joking, that's a real customer workload.
> > > 
> > > Well, I believe you, but even with this, that's a total of 800MB memory on
> > > a giant moster system... probably just to fault in once.
> > > 
> > > And even before we talk about that into details.. we're talking about such
> > > giant program running acorss hundreds of cores with hundreds of MB text,
> > > then... hasn't the program developer already considered mlockall() at the
> > > entry of the program?  Wouldn't that greatly beneficial already with
> > > whatever granule of locks that a future fault would take?
> > 
> > I don't care what your theory is, or even what your benchmarking shows.
> > I had basically the inverse of this patch, and my customer's workload
> > showed significant improvement as a result.  Data talks, bullshit walks.
> > Your patch is NAKed and will remain NAKed.
> 
> Either would you tell me your workload, I may try it.
> 
> Or, please explain why it helps?  If such huge library is in a single VMA,
> I don't see why per-vma lock is better than mmap lock.  If the text is
> combined with multiple vmas, it should only help when each core faults at
> least on different vmas, not the same.

Oh, you really don't understand.  The mmap_lock is catastrophically
overloaded.  Before the per-VMA lock, every page fault took it for read,
and every call to mmap() took it for write.  Because our rwsems are
fair, once one thread has called mmap() it waits for all existing page
faults to complete _and_ blocks all page faults from starting until
it has completed.  That's a huge source of unexpected latency for any
multithreaded application.

Anything we can do to avoid taking the mmap_sem, even for read, helps any
multithreaded workload.  Your suggestion that "this is rare, it doesn't
matter" shows that you don't get it.  That you haven't found a workload
where you can measure it shows that your testing is inadequate.

Yes, there's added complexity with the per-VMA locks.  But we need it for
good performance.  Throwing away performance on a very small reduction
in complexity is a terrible trade-off.

