Return-Path: <linux-kernel+bounces-118061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BA688B64D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1C44B38AA3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007166FE35;
	Mon, 25 Mar 2024 21:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TXKaT/UJ"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FE05EE64
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 21:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711403399; cv=none; b=rdVbTYnzNhR92NuMrn+8lPQUODVZiu8Y9rOt3iv+8O3zwUxCqce6lcKNi2j3fi4k/JV6zDVjxg0Td3RAUZ6/w3nq+uCI/3KtB5MFxAp7WHBSZvG2A+LhRwurz5hm7rzkBcIfMy4v+4orpf6OBpnOJMz317rTkmp2HOfQADs8cDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711403399; c=relaxed/simple;
	bh=UpqckpAk54pZmRHfWjS7HGz0GsiFSkJvYvd7uR6cPrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IO4nij6grgMzqbNGITXTiHxxX1Hw7A0PhbUOuzA/EfVP8YGZgtRspInMj/empj5Qz/M0/FQeu/vQaR6/vyRRHfVDj0z1uXD/CnC9frPwcizznKc/sxEnOqARIFG4zLJORYP6U7FSpInEWAqTMhPmin1lv4fC2ciLWhAcPmhbGRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TXKaT/UJ; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 25 Mar 2024 17:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711403394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jnty0Hl4Z2lmYarICJkRG5Td4HWGlYS6TikUtT7dCz0=;
	b=TXKaT/UJgOrUg8TgyxlfyzzkC1ZYQInuPHBt5aIQsdda3H8THBSSduvIFLEFUQudD2VKRw
	MkhcOpPdNonvHFVXaIZoG5U13nOjNSCXY4/MjZsehnaDQNS/rFoouZfgEoCrM/DKa/21Ts
	pKauDEaTSdUdbr0XudtTw+a1rQAcRlE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kees Cook <keescook@chromium.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>, Xiu Jianfeng <xiujianfeng@huawei.com>, 
	Suren Baghdasaryan <surenb@google.com>, Jann Horn <jannh@google.com>, 
	Matteo Rizzo <matteorizzo@google.com>, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 4/9] slab: Introduce kmem_buckets_create()
Message-ID: <67tgebii42rwneeyqekmxxqo2bzgyysdqggciuew27bc3gbrkg@5ceqjmiaxvyu>
References: <20240305100933.it.923-kees@kernel.org>
 <20240305101026.694758-4-keescook@chromium.org>
 <eppzf5gil6izcn6nnvzgzukagdikqnfxdvziga7ipnpl5eeern@i7jfzslklsu6>
 <202403251327.C15C1E61A@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202403251327.C15C1E61A@keescook>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 25, 2024 at 01:40:34PM -0700, Kees Cook wrote:
> On Mon, Mar 25, 2024 at 03:40:51PM -0400, Kent Overstreet wrote:
> > On Tue, Mar 05, 2024 at 02:10:20AM -0800, Kees Cook wrote:
> > > Dedicated caches are available For fixed size allocations via
> > > kmem_cache_alloc(), but for dynamically sized allocations there is only
> > > the global kmalloc API's set of buckets available. This means it isn't
> > > possible to separate specific sets of dynamically sized allocations into
> > > a separate collection of caches.
> > > 
> > > This leads to a use-after-free exploitation weakness in the Linux
> > > kernel since many heap memory spraying/grooming attacks depend on using
> > > userspace-controllable dynamically sized allocations to collide with
> > > fixed size allocations that end up in same cache.
> > > 
> > > While CONFIG_RANDOM_KMALLOC_CACHES provides a probabilistic defense
> > > against these kinds of "type confusion" attacks, including for fixed
> > > same-size heap objects, we can create a complementary deterministic
> > > defense for dynamically sized allocations.
> > > 
> > > In order to isolate user-controllable sized allocations from system
> > > allocations, introduce kmem_buckets_create(), which behaves like
> > > kmem_cache_create(). (The next patch will introduce kmem_buckets_alloc(),
> > > which behaves like kmem_cache_alloc().)
> > > 
> > > Allows for confining allocations to a dedicated set of sized caches
> > > (which have the same layout as the kmalloc caches).
> > > 
> > > This can also be used in the future once codetag allocation annotations
> > > exist to implement per-caller allocation cache isolation[1] even for
> > > dynamic allocations.
> > > 
> > > Link: https://lore.kernel.org/lkml/202402211449.401382D2AF@keescook [1]
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > > Cc: Vlastimil Babka <vbabka@suse.cz>
> > > Cc: Christoph Lameter <cl@linux.com>
> > > Cc: Pekka Enberg <penberg@kernel.org>
> > > Cc: David Rientjes <rientjes@google.com>
> > > Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Roman Gushchin <roman.gushchin@linux.dev>
> > > Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > > Cc: linux-mm@kvack.org
> > > ---
> > >  include/linux/slab.h |  5 +++
> > >  mm/slab_common.c     | 72 ++++++++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 77 insertions(+)
> > > 
> > > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > > index f26ac9a6ef9f..058d0e3cd181 100644
> > > --- a/include/linux/slab.h
> > > +++ b/include/linux/slab.h
> > > @@ -493,6 +493,11 @@ void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
> > >  			   gfp_t gfpflags) __assume_slab_alignment __malloc;
> > >  void kmem_cache_free(struct kmem_cache *s, void *objp);
> > >  
> > > +kmem_buckets *kmem_buckets_create(const char *name, unsigned int align,
> > > +				  slab_flags_t flags,
> > > +				  unsigned int useroffset, unsigned int usersize,
> > > +				  void (*ctor)(void *));
> > 
> > I'd prefer an API that initialized an object over one that allocates it
> > - that is, prefer
> > 
> > kmem_buckets_init(kmem_buckets *bucekts, ...)
> 
> Sure, that can work. kmem_cache_init() would need to exist for the same
> reason though.

That'll be a very worthwhile addition too; IPC running kernel code
is always crap and dependent loads is a big part of that.

I did mempool_init() and bioset_init() awhile back, so it's someone
else's turn for this one :)

> Sure, I think it'll depend on how the per-site allocations got wired up.
> I think you're meaning to include a full copy of the kmem cache/bucket
> struct with the codetag instead of just a pointer? I don't think that'll
> work well to make it runtime selectable, and I don't see it using an
> extra deref -- allocations already get the struct from somewhere and
> deref it. The only change is where to find the struct.

The codetags are in their own dedicated elf sections already, so if you
put the kmem_buckets in the codetag the entire elf section can be
discarded if it's not in use.

Also, the issue isn't derefs - it's dependent loads and locality. Taking
the address of the kmem_buckets to pass it is fine; the data referred to
will still get pulled into cache when we touch the codetag. If it's
behind a pointer we have to pull the codetag into cache, wait for that
so we can get the kmme_buckets pointer - then start to pull in the
kmem_buckets itself.

If it's a cache miss you just slowed the entire allocation down by
around 30 ns.

> > I'm curious what all the arguments to kmem_buckets_create() are needed
> > for, if this is supposed to be a replacement for kmalloc() users.
> 
> Are you confusing kmem_buckets_create() with kmem_buckets_alloc()? These
> args are needed to initialize the per-bucket caches, just like is
> already done for the global kmalloc per-bucket caches. This mirrors
> kmem_cache_create(). (Or more specifically, calls kmem_cache_create()
> for each bucket size, so the args need to be passed through.)
> 
> If you mean "why expose these arguments because they can just use the
> existing defaults already used by the global kmalloc caches" then I
> would say, it's to gain the benefit here of narrowing the scope of the
> usercopy offsets. Right now kmalloc is forced to allow the full usercopy
> window into an allocation, but we don't have to do this any more. For
> example, see patch 8, where struct msg_msg doesn't need to expose the
> header to userspace:

"usercopy window"? You're now annotating which data can be copied to
userspace?

I'm skeptical, this looks like defensive programming gone amuck to me.
 
> 	msg_buckets = kmem_buckets_create("msg_msg", 0, SLAB_ACCOUNT,
> 					  sizeof(struct msg_msg),
> 					  DATALEN_MSG, NULL);

