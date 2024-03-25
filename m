Return-Path: <linux-kernel+bounces-117953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEC288B1BF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 574B7323122
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D5A59B6C;
	Mon, 25 Mar 2024 20:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nPSoA2x1"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0C659B61
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399237; cv=none; b=PhKxyatVB1Twgal2kJuCfpMl9vEpoQbQd5qIkYXzYt7+c70XgtWZkB0+egCBwCfvvSKdtGoJErcqTRp0aw2F4MDG6TvHRSI5dV4ySa1E7tmQlIANvzVCxTz6I7PRPuIQzBimUM5BjWQRbsqh8sa84OHvgOZOu+UwTcsVwCYWrO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399237; c=relaxed/simple;
	bh=ZfAL7t4zOUSppTGC73cNDX4tJCQR3S0Iky3Z0Kvvwik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfL1b7jsDAxCvuEz8dJFNDaw24eWd9dlZPnVGPVljotGtx0mJ7FGw70WxRo55MPJbfXMq1r76l+uNTJtCpEu9YaHFnnCyWloe1LR0yMFJc5dFAVJsEtw/B5cs4udxpQqeeNNWz4cpvcH82GybmUG3CWb0Kvt54FLlc/jVuVWaq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nPSoA2x1; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e6f4ad4c57so3600064b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711399235; x=1712004035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ej6YX3fEHGl+77MEXxCPV4obwrkrSQqnkopyC7I1h4A=;
        b=nPSoA2x1vkO3voH1ZtPV4a90RxLLwr6fkAPBi9eMXvhMg3SXWMiQlHEsFAgqZMQP/B
         KA2ARqjtAiOviQYZSRLscLHEc14yecaT8WmxWMzUn8KLXeOpAhcVroloZRyQuLz/UKWT
         0u0ZwLCV1Zczob7mNH8n2QffoOkGENlMcIPn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711399235; x=1712004035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ej6YX3fEHGl+77MEXxCPV4obwrkrSQqnkopyC7I1h4A=;
        b=EtUzAnyxZDQptHhCZCzUkdTrYjBCK9sdnV5HVnSK/DuKQwciCV0inTAkCsotblaQca
         +SGt4yKO0GQL1hj1/PsrB2ldWsEJsenVPAmaHg/YBoRALk84WPVyyCIAavEuVONadyA5
         6XHUkxt+yzmqkWd7f3lHcFvBH2xjBDpuQaR6fV2hpM859d8DriYR4D/wbR/OLkJZFhoS
         lFQbMXBAmaN0KMzBMDSqYyDkFXwPsZaiWs/NGzdN58MBXPB0U3E8XOL84EItRVkYxaLd
         4POtJGuSz5lBua9bd8k2udDXdULuEb8riuj4YtuZ88BnV7CXgk+79Ugvmbk6FlqtvkUA
         x5vg==
X-Forwarded-Encrypted: i=1; AJvYcCVO7PX6zJqyKc1POjREeK8ueLSHPlQ8xNHjkRnM8Zw0LYAV1OR57q9FAn/40Uuj6yObpL62+Ao9DNzdcM3M8frcNrwhcYuq1BtStOxw
X-Gm-Message-State: AOJu0Ywbx14b4jXfaiwC6BRDAkPFUuQ7tGf6WamHmJ81MuewS5rcsNM6
	fS9rItSpog2SB8MXXNJpfvMKcwhgdkTQEONLtraCoNqXNzf2j1mFrxlHVmRJBA==
X-Google-Smtp-Source: AGHT+IHN6rGpnqSQi7c440LUs4dG4GTM/YjcMp1vk9CNuNpKUMJvkXuJRV/il9IOPfw/5cGqBuim/w==
X-Received: by 2002:a05:6a21:2d88:b0:1a3:bb8b:de7a with SMTP id ty8-20020a056a212d8800b001a3bb8bde7amr9222423pzb.54.1711399235550;
        Mon, 25 Mar 2024 13:40:35 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y9-20020a63de49000000b005dcc8a3b26esm6193652pgi.16.2024.03.25.13.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 13:40:35 -0700 (PDT)
Date: Mon, 25 Mar 2024 13:40:34 -0700
From: Kees Cook <keescook@chromium.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jann Horn <jannh@google.com>, Matteo Rizzo <matteorizzo@google.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 4/9] slab: Introduce kmem_buckets_create()
Message-ID: <202403251327.C15C1E61A@keescook>
References: <20240305100933.it.923-kees@kernel.org>
 <20240305101026.694758-4-keescook@chromium.org>
 <eppzf5gil6izcn6nnvzgzukagdikqnfxdvziga7ipnpl5eeern@i7jfzslklsu6>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eppzf5gil6izcn6nnvzgzukagdikqnfxdvziga7ipnpl5eeern@i7jfzslklsu6>

On Mon, Mar 25, 2024 at 03:40:51PM -0400, Kent Overstreet wrote:
> On Tue, Mar 05, 2024 at 02:10:20AM -0800, Kees Cook wrote:
> > Dedicated caches are available For fixed size allocations via
> > kmem_cache_alloc(), but for dynamically sized allocations there is only
> > the global kmalloc API's set of buckets available. This means it isn't
> > possible to separate specific sets of dynamically sized allocations into
> > a separate collection of caches.
> > 
> > This leads to a use-after-free exploitation weakness in the Linux
> > kernel since many heap memory spraying/grooming attacks depend on using
> > userspace-controllable dynamically sized allocations to collide with
> > fixed size allocations that end up in same cache.
> > 
> > While CONFIG_RANDOM_KMALLOC_CACHES provides a probabilistic defense
> > against these kinds of "type confusion" attacks, including for fixed
> > same-size heap objects, we can create a complementary deterministic
> > defense for dynamically sized allocations.
> > 
> > In order to isolate user-controllable sized allocations from system
> > allocations, introduce kmem_buckets_create(), which behaves like
> > kmem_cache_create(). (The next patch will introduce kmem_buckets_alloc(),
> > which behaves like kmem_cache_alloc().)
> > 
> > Allows for confining allocations to a dedicated set of sized caches
> > (which have the same layout as the kmalloc caches).
> > 
> > This can also be used in the future once codetag allocation annotations
> > exist to implement per-caller allocation cache isolation[1] even for
> > dynamic allocations.
> > 
> > Link: https://lore.kernel.org/lkml/202402211449.401382D2AF@keescook [1]
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Christoph Lameter <cl@linux.com>
> > Cc: Pekka Enberg <penberg@kernel.org>
> > Cc: David Rientjes <rientjes@google.com>
> > Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Roman Gushchin <roman.gushchin@linux.dev>
> > Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > Cc: linux-mm@kvack.org
> > ---
> >  include/linux/slab.h |  5 +++
> >  mm/slab_common.c     | 72 ++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 77 insertions(+)
> > 
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index f26ac9a6ef9f..058d0e3cd181 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -493,6 +493,11 @@ void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
> >  			   gfp_t gfpflags) __assume_slab_alignment __malloc;
> >  void kmem_cache_free(struct kmem_cache *s, void *objp);
> >  
> > +kmem_buckets *kmem_buckets_create(const char *name, unsigned int align,
> > +				  slab_flags_t flags,
> > +				  unsigned int useroffset, unsigned int usersize,
> > +				  void (*ctor)(void *));
> 
> I'd prefer an API that initialized an object over one that allocates it
> - that is, prefer
> 
> kmem_buckets_init(kmem_buckets *bucekts, ...)

Sure, that can work. kmem_cache_init() would need to exist for the same
reason though.

> 
> by forcing it to be separately allocated, you're adding a pointer deref
> to every access.

I don't understand what you mean here. "every access"? I take a guess
below...

> That would also allow for kmem_buckets to be lazily initialized, which
> would play nicely declaring the kmem_buckets in the alloc_hooks() macro.

Sure, I think it'll depend on how the per-site allocations got wired up.
I think you're meaning to include a full copy of the kmem cache/bucket
struct with the codetag instead of just a pointer? I don't think that'll
work well to make it runtime selectable, and I don't see it using an
extra deref -- allocations already get the struct from somewhere and
deref it. The only change is where to find the struct.

> I'm curious what all the arguments to kmem_buckets_create() are needed
> for, if this is supposed to be a replacement for kmalloc() users.

Are you confusing kmem_buckets_create() with kmem_buckets_alloc()? These
args are needed to initialize the per-bucket caches, just like is
already done for the global kmalloc per-bucket caches. This mirrors
kmem_cache_create(). (Or more specifically, calls kmem_cache_create()
for each bucket size, so the args need to be passed through.)

If you mean "why expose these arguments because they can just use the
existing defaults already used by the global kmalloc caches" then I
would say, it's to gain the benefit here of narrowing the scope of the
usercopy offsets. Right now kmalloc is forced to allow the full usercopy
window into an allocation, but we don't have to do this any more. For
example, see patch 8, where struct msg_msg doesn't need to expose the
header to userspace:

	msg_buckets = kmem_buckets_create("msg_msg", 0, SLAB_ACCOUNT,
					  sizeof(struct msg_msg),
					  DATALEN_MSG, NULL);

Only DATALEN_MSG many bytes, starting at sizeof(struct msg_msg), will be
allowed to be copied in/out of userspace. Before, it was unbounded.

-Kees

-- 
Kees Cook

