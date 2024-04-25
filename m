Return-Path: <linux-kernel+bounces-159370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7008B2DC3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 01:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582552819A9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC30156988;
	Thu, 25 Apr 2024 23:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eKTJZctI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE4E14E2EF;
	Thu, 25 Apr 2024 23:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714088959; cv=none; b=pd0segRU15R1sGugpITR15DlyJP8GH7cGHqK+aVtA2UON0iS9s9WQPFcRliI1Thy8W56qNXqIvhi34MRiH359kFkVpTPZDepPF+QeUabeLtpL0RbqkqvheTQVF9il9yOr0gjnZine4CpxXzSgX6r70stiMCKBRka5oK+XJF+VrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714088959; c=relaxed/simple;
	bh=xThSuDa7B7/IrHBAvCAlq+cuUm1QUymQXFLtZ01/yBY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WcbUF4XJ0jpyaWvwliutNzGGm72U5enGEp0KWvk3nDV6WMf6O7FWpX995iqooaMNAbBC9NRBMau5KETgwi7k7ShOqU8XMNYYqafy8GulmOx2K8Otu+s2GxJb0hfZ/zY0G57Onzu2t8zLI9BhyN8HsB3qS85EqwyttC02kTW+who=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eKTJZctI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB97C113CC;
	Thu, 25 Apr 2024 23:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1714088958;
	bh=xThSuDa7B7/IrHBAvCAlq+cuUm1QUymQXFLtZ01/yBY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eKTJZctIgAnNhEvYPY2857R1t3FtNk6ED3TJMxHDTM4ggwp1v4bCx0sn76PwQ1tM6
	 a57YFhEymsUHaJEpgUqPEhS82jzBH4j1KLB5q2RRj2NtNf42wkSRgJI4tDt+9jXfhR
	 6T1kjJKoagm96u759c62opUlD5ELcHmMgxoTiv04=
Date: Thu, 25 Apr 2024 16:49:17 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Kees Cook
 <keescook@chromium.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David
 Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin
 <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mm/slub: Avoid recursive loop with kmemleak
Message-Id: <20240425164917.8c9603387b4cce11121024a8@linux-foundation.org>
In-Reply-To: <CAJuCfpEMK-6+1CUDfiiKLGLfTEomJGjaeHOfsWZZBdaJ6DcvFQ@mail.gmail.com>
References: <20240425205516.work.220-kees@kernel.org>
	<ebc6pcoq4cle3ge526ch6q5hz2vvphmgwu2yqdveypjm24pa3b@cwsggjnoepaq>
	<CAJuCfpEMK-6+1CUDfiiKLGLfTEomJGjaeHOfsWZZBdaJ6DcvFQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Apr 2024 14:30:55 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> > > --- a/mm/kmemleak.c
> > > +++ b/mm/kmemleak.c
> > > @@ -463,7 +463,7 @@ static struct kmemleak_object *mem_pool_alloc(gfp_t gfp)
> > >
> > >       /* try the slab allocator first */
> > >       if (object_cache) {
> > > -             object = kmem_cache_alloc(object_cache, gfp_kmemleak_mask(gfp));
> > > +             object = kmem_cache_alloc_noprof(object_cache, gfp_kmemleak_mask(gfp));
> >
> > What do these get accounted to, or does this now pop a warning with
> > CONFIG_MEM_ALLOC_PROFILING_DEBUG?
> 
> Thanks for the fix, Kees!
> I'll look into this recursion more closely to see if there is a better
> way to break it. As a stopgap measure seems ok to me. I also think
> it's unlikely that one would use both tracking mechanisms on the same
> system.

I'd really like to start building mm-stable without having to route
around memprofiling.  How about I include Kees's patch in that for now?


