Return-Path: <linux-kernel+bounces-139353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FA58A01C2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C8B6285C09
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8371836CD;
	Wed, 10 Apr 2024 21:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VYrWhooe"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6714A1836C5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 21:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712783451; cv=none; b=GgYXP08VZFU2jgkvyOIW6tr41J6F+yiMollCmSVciSkiXQB6R8cvtzfYdisGLnk3vvKDHvbv5KxIHpBpU/jtP0OC34AEy8teckWEdF2K9HmMCeftWjF7XxKLi7HrFjViULmGn9nqKXweP4eJq7pfUoR125hKp7oyK1FIoRi6eh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712783451; c=relaxed/simple;
	bh=Afe8rHJGBCIQX5habp6xX3mo3aJ5LLG1+VSKVqxsxcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awEkpqMj20qJhhj9/wNJM/8T44Ct2EWAGH+PvzcSGhxwVmK5pf/5v/e6dCeM++xO5rBX5wJcSzqlZTYY9SYLoCj8cy4E6y66K3eLturuFm6hCuGTXi5vVWf7LJ/gwxtfP6mm615Aw/pmhKdMXA0SogzprAwh8subOSr7cAEJaUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VYrWhooe; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=K5CZYxkjuGJg+PSt6On95bWBmLHLx24aqSz3YCRWDIc=; b=VYrWhooeUJjHf7e187qLfGnb1O
	ve/3a+51OIbesVbgKSCgAQ/z7Qqb6oMwgFwI1Tlhb12X63SDG549nY7P3hENkbJJNFA+jjN/iYYi/
	J+KQ8MdM3ycdqdvzzIW6NkVAFu0f58qFZQoazza3i715Nb0Bp2Jm3d+O+j7wG8qw/Frb5y84KFpAt
	d7VQ4xHVT4m5cM9E83asAWhn6vgrigiIiUdzUb7XSAx1I/SzRWwb5oapebqaSpu/HKWFh54UbBgfX
	1RoHGq58pzV+cIutmFqOEM6zEkLPQGHVwf14/8GnaWShYybUjljmkWKXSkmxQolr09ha07zKWByA+
	SDN7HFYw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rufDR-00000005IWD-0qAf;
	Wed, 10 Apr 2024 21:10:45 +0000
Date: Wed, 10 Apr 2024 22:10:45 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Lokesh Gidra <lokeshgidra@google.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH] mm: Always sanity check anon_vma first for per-vma locks
Message-ID: <ZhcAVYVFSdX5Binc@casper.infradead.org>
References: <20240410170621.2011171-1-peterx@redhat.com>
 <Zhb2BWntckP3ZhDc@casper.infradead.org>
 <Zhb6B8UsidEEbFu3@x1n>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zhb6B8UsidEEbFu3@x1n>

On Wed, Apr 10, 2024 at 04:43:51PM -0400, Peter Xu wrote:
> On Wed, Apr 10, 2024 at 09:26:45PM +0100, Matthew Wilcox wrote:
> > On Wed, Apr 10, 2024 at 01:06:21PM -0400, Peter Xu wrote:
> > > anon_vma is a tricky object in the context of per-vma lock, because it's
> > > racy to modify it in that context and mmap lock is needed if it's not
> > > stable yet.
> > 
> > I object to this commit message.  First, it's not a "sanity check".  It's
> > a check to see if we already have an anon VMA.  Second, it's not "racy
> > to modify it" at all.  The problem is that we need to look at other
> > VMAs, for which we do not hold the lock.
> 
> For that "do not hold locks" part, isn't that "racy"?

No.

> > >   - We may always use mmap lock for the initial READs on a private file
> > >   mappings, while before this patch it _can_ (only when no WRITE ever
> > >   happened... but it doesn't make much sense for a MAP_PRIVATE..) do the
> > >   read fault with per-vma lock.
> > 
> > But that's a super common path!  Look at 'cat /proc/self/maps'.  All
> > your program text (including libraries) is mapped PRIVATE, and never
> > written to (except by ptrace, I guess).
> > 
> > NAK this patch.
> 
> We're talking about any vma that will first benefit from a per-vma lock
> here, right?
> 
> I think it should be only relevant to some major VMA or bunch of VMAs that
> an userspace maps explicitly, then iiuc the goal is we want to reduce the
> cache bouncing of the lock when it used to be per-mm, by replacing it with
> a finer lock.  It doesn't sound right that these libraries even fall into
> this category as they should just get loaded soon enough when the program
> starts.
> 
> IOW, my understanding is that per-vma lock doesn't benefit from such normal
> vmas or simple programs that much; we take either per-vma read lock, or
> mmap read lock, and I would expect similar performance when such cache
> bouncing isn't heavy.
> 
> I can do some tests later today or tomorrow. Any suggestion you have on
> amplifying such effect that you have concern with?

8 socket NUMA system, 800MB text segment, 10,000 threads.  No, I'm not
joking, that's a real customer workload.

