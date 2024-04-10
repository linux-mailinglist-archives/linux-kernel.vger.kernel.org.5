Return-Path: <linux-kernel+bounces-139315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA8F8A014A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DECB1C2483B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F2A181CFF;
	Wed, 10 Apr 2024 20:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dy1zGKif"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00446181BBC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 20:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712780812; cv=none; b=DT/3bUijKBboGKd8JLjYPyy4DiGuxo0hY5LQwEO/H1CCX0zWTvHsfGth/IWKrUGEovn5VOrxk8dBQ+l6m6X7NeZj7v5baHjtHsl9ybtbt/tul5rgS+qkuvEG7XBqw0e9Q8DbanDp8TWtnbUrem1LfMqt2Bp5H/tzE0D3e/4ZGRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712780812; c=relaxed/simple;
	bh=EmDgPObmoDkjXwBXrq0jXN4csrGyff4XxnWPltEW//Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSu9eN7jqM24be4APdtnQDuiey4ll3VdtcA8MnZOWZYRNgSkzOJzBWKDNB8WWOGYzWUw2FGdQ/WjxEhYf9oW/r3RaZ7sXMbKyuev0JbLPqmqd3RZJVYCDoHQZ5nENM5rv4m074VJER9iOlOpysCigd+05zGQhDuigGh6nXGvPIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dy1zGKif; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SPofphAnbknGoSZqWt9l8ENx3Bo5uSTSZafIxk+CniA=; b=dy1zGKifcnV5nMAYXVfwD7f/58
	iIYrRekhUvN5IcfR1mWVSam60xyFwuxMarGdYKLS3LWt573W3IjU7RyS+3ec9ZDVVK9bzx/eqhJ/J
	9GSHm4eMIFfSIyeGgHMBm1j25UI+NMh7HwqqiTFG0Fxh1GIVX3rg73XSQLFGpCGV+osoBPekERVL0
	nkf1Js1wxC9TFB0E9CAQNgH9gNk/vp6cy/qL0RPi1aHdE3dZr7OsSZ6qkfCKrnlhQ7xRUqxDc9d3y
	d8j0UbL1VSRTg+JjYEAKJekKPLTE+v/Tt6AqjNoTcpdP5DDzYU6ldn4EQ8a/ajzRVaJE8ZWFlsIiN
	dWbTeqaQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rueWr-00000005EGj-1bfT;
	Wed, 10 Apr 2024 20:26:45 +0000
Date: Wed, 10 Apr 2024 21:26:45 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Lokesh Gidra <lokeshgidra@google.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH] mm: Always sanity check anon_vma first for per-vma locks
Message-ID: <Zhb2BWntckP3ZhDc@casper.infradead.org>
References: <20240410170621.2011171-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410170621.2011171-1-peterx@redhat.com>

On Wed, Apr 10, 2024 at 01:06:21PM -0400, Peter Xu wrote:
> anon_vma is a tricky object in the context of per-vma lock, because it's
> racy to modify it in that context and mmap lock is needed if it's not
> stable yet.

I object to this commit message.  First, it's not a "sanity check".  It's
a check to see if we already have an anon VMA.  Second, it's not "racy
to modify it" at all.  The problem is that we need to look at other
VMAs, for which we do not hold the lock.

> So the trivial side effect of such patch is:
> 
>   - We may do slightly better on the first WRITE of a private file mapping,
>   because we can retry earlier (in lock_vma_under_rcu(), rather than
>   vmf_anon_prepare() later).
> 
>   - We may always use mmap lock for the initial READs on a private file
>   mappings, while before this patch it _can_ (only when no WRITE ever
>   happened... but it doesn't make much sense for a MAP_PRIVATE..) do the
>   read fault with per-vma lock.

But that's a super common path!  Look at 'cat /proc/self/maps'.  All
your program text (including libraries) is mapped PRIVATE, and never
written to (except by ptrace, I guess).

NAK this patch.


