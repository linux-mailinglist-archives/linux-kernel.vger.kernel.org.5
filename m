Return-Path: <linux-kernel+bounces-141658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DF38A218B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 526FBB22854
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1D03D548;
	Thu, 11 Apr 2024 22:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X+pN7o0A"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2743D3A5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 22:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712872958; cv=none; b=Oo8k+O4XIJ57jtsL/ROspnr6G2/3mPmP2SQKJAmZDSBF+R0b2l74dX2x/7G7eLhQoxdxpYnxQUywQTw2f1K1if/+3naxrtiQ1uxCtX/8xia25Vb8kl/uh8z+DoF/acblug1ujxKq8e2w/LwXMENjQUEzBdPWJS0V6iJfm5wuqio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712872958; c=relaxed/simple;
	bh=o5FDv92MiSVG1UPFwO1anEEKKTbsvVw0Myr38bi2xUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzLrsTRHiKqfAZGHgutkZP227Be0t+EO0A1rFlLnSzGUW2BGEHH3bBXjme+Bw/vyd29De54UKzxzoqNx4WRDpEUA3lqAx3q2FfSuTzNkZyZE0Dr/T0AUqfTbdUm/+CVfqoslOWZH4/VimZDgQf6d+pzWuVhihxWDvh401EExfqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X+pN7o0A; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qyhuPp9+PLD3/FaKDQyfJcp3bUMLi0OXXMTjXjpObkI=; b=X+pN7o0ASwJvbb8sZjisqvHc9U
	S1oDtJiTROq5HjdUKHRfkWVJ1cmt3HZZvlrEQ8elY3jXUbfRBWMDPY0XU63wlxzK0Go37Ph0Dvum2
	MLmMIDHcvXg9td6JZodWRiXKQstQgypz+aa340w0Hcrj0QxN2N07TuZ92855ZggESqb3+d135qLQJ
	lUQR/ODGdTgnKb4/CW1XW5QeTpH5gX+Cp0peOKqSlpmZRjPF5j10vwWhFVCQnuuv4N4lwzvLZg0gD
	1I1FDim+JToPqknbIKzovH712PVd2xoVkWuhsR8lK4aqIIgMK7JaZ73ES8CzZsckSgNDK6nZ3okNI
	plNROAVA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rv2V6-00000007ozr-3wjA;
	Thu, 11 Apr 2024 22:02:33 +0000
Date: Thu, 11 Apr 2024 23:02:32 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Peter Xu <peterx@redhat.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Lokesh Gidra <lokeshgidra@google.com>,
	Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH] mm: Always sanity check anon_vma first for per-vma locks
Message-ID: <Zhhd-A7w1A8JUadM@casper.infradead.org>
References: <20240410170621.2011171-1-peterx@redhat.com>
 <20240411171319.almhz23xulg4f7op@revolver>
 <ZhhSItiyLYBEdAX3@x1n>
 <ZhhV3PKgEX9d7_vA@casper.infradead.org>
 <ZhhaRXHKk7w_hKgi@x1n>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhhaRXHKk7w_hKgi@x1n>

On Thu, Apr 11, 2024 at 05:46:45PM -0400, Peter Xu wrote:
> On Thu, Apr 11, 2024 at 10:27:56PM +0100, Matthew Wilcox wrote:
> > On Thu, Apr 11, 2024 at 05:12:02PM -0400, Peter Xu wrote:
> > > The question is whether that's intended to make it as complicated.  For
> > > example, why don't we check anon_vma for anonymous too later when prepare
> > > anon_vma, however we do it late for file memory.  AFAICT there's nothing
> > > special with file memory in this case.
> > 
> > Yes, it's absolutely intended.  If anything, anon memory is the special
> > case that checks up-front.
> > 
> > Congratulations on adding additional instructions to the common case.
> > I don't understand why you persist with your nonsense.  Please stop.
> 
> How many instructions it takes for a late RETRY for WRITEs to private file
> mappings, fallback to mmap_sem?

Doesn't matter.  That happens _once_ per VMA, and it's dwarfed by the
cost of allocating and initialising the COWed page.  You're adding
instructions to every single page fault.  I'm not happy that we had to
add extra instructions to the fault path for single-threaded programs,
but we at least had the justification that we were improving scalability
on large systems.  Your excuse is "it makes the code cleaner".  And
honestly, I don't think it even does that.

> Did you even finish reading the patch at all?

Yes, I read the whole thing.  It's garbage.

