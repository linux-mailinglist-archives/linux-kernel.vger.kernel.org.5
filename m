Return-Path: <linux-kernel+bounces-139553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3E88A044E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEFBBB24EA3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B99C3FB3B;
	Wed, 10 Apr 2024 23:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AJFmOhDy"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F4FEAE5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 23:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712793563; cv=none; b=m4u5nkiIMZT0qbh+BnyaV2W/QyKC1JLbLT11/Q8L3BjfA0DXZb9LBqwU8cJKKrXuc4O5csJXm/vU4KZtnWsT3cwgzUkJ8TmXd9GHdTgbsE3zDxrzWZkwGsVDg9XR4e/NaMF15n6Zvhm3RkmATRFwlA5V9pNEYAyfo56sVWwGWIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712793563; c=relaxed/simple;
	bh=oEZirylTvXWz1CmEJ8DBxu0TbNj1+ae9oUvgLTlYpJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAiUCwiQ4+WPBsWWiOGUpu0/FNjFJKsOEkMnnjCX94uADOr4l+stq1kzLjaye2bnfeuWQTPScAcrvt293r+Nlborqm/FsCTmIguxqjhTj1fgT1vsOxLKQBBjGbwEL20aCa84N5632YjkF+hhHBD8K90y6UlRaTozoBIok0YnZVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AJFmOhDy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Oh9geONnOFhFyrtxPHhIzWGAqO2nRJc8KgJoEh6Vr7s=; b=AJFmOhDy4PdkswkZTKs462wEa1
	Lu/ukDoNsEN6T3i0HFlxvk+AyFJ3r3n1a64GSJMrzX0Mzezv8ckgCw/vUSh3V/p3SYDn2c0WQKT/0
	Db/z0S7hN/t8uycwVygZhkj/LB/X5iWRhOfI8B4JjTayb6rG1cAUH+atl89UphV+zjfJXfrA65xlW
	+78Ih01QSBDUCn43vyJz7CANzkdsyYINaiiPMmCEP5s8LKmCEdCeoWN54vmb7OZBQM2D0dVKeLmGR
	nO0v++oO/wBcNZIFaBGPke6ujFNnuhZwUqCdmJWs1YP9KPljmKUJlJAid//kcZa9/T+h6wx7Mg9r5
	m7HRuUfQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruhqP-00000005a1j-23rB;
	Wed, 10 Apr 2024 23:59:09 +0000
Date: Thu, 11 Apr 2024 00:59:09 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Lokesh Gidra <lokeshgidra@google.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH] mm: Always sanity check anon_vma first for per-vma locks
Message-ID: <ZhcnzS1S6zOMJwSL@casper.infradead.org>
References: <20240410170621.2011171-1-peterx@redhat.com>
 <Zhb2BWntckP3ZhDc@casper.infradead.org>
 <Zhb6B8UsidEEbFu3@x1n>
 <ZhcAVYVFSdX5Binc@casper.infradead.org>
 <ZhcDRmyYkMGPgs4F@x1n>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhcDRmyYkMGPgs4F@x1n>

On Wed, Apr 10, 2024 at 05:23:18PM -0400, Peter Xu wrote:
> On Wed, Apr 10, 2024 at 10:10:45PM +0100, Matthew Wilcox wrote:
> > > I can do some tests later today or tomorrow. Any suggestion you have on
> > > amplifying such effect that you have concern with?
> > 
> > 8 socket NUMA system, 800MB text segment, 10,000 threads.  No, I'm not
> > joking, that's a real customer workload.
> 
> Well, I believe you, but even with this, that's a total of 800MB memory on
> a giant moster system... probably just to fault in once.
> 
> And even before we talk about that into details.. we're talking about such
> giant program running acorss hundreds of cores with hundreds of MB text,
> then... hasn't the program developer already considered mlockall() at the
> entry of the program?  Wouldn't that greatly beneficial already with
> whatever granule of locks that a future fault would take?

I don't care what your theory is, or even what your benchmarking shows.
I had basically the inverse of this patch, and my customer's workload
showed significant improvement as a result.  Data talks, bullshit walks.
Your patch is NAKed and will remain NAKed.

