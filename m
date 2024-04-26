Return-Path: <linux-kernel+bounces-159381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 399918B2DEC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7A4A282F11
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD54187F;
	Fri, 26 Apr 2024 00:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eGmBUanR"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D7E184D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 00:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714090766; cv=none; b=KSBRc4n1o3vipet+nk+BoP8Qf9A+bNK3v5MOoMUyGnhNnUWLMV+9EaT4T0BcHqN4fXItSCdVTX8BXirUWUAM82RQuNtWi/e9FaqCYobxBKkl8Ta6p63BcMFyWcc8qkoj8JOVTtJpmA/k/1TM8K7h6SY/ALf1Sbtr0/8gG/3emMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714090766; c=relaxed/simple;
	bh=lpFw9Tuezlw7TiZh8cPbb/MJFtFxTaytrUCYtOu7NNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJuZHhdj2StmPguPZJpUj7/QoV5o8rfZ67HPA5mof4imn0jRXUWOL7SFM1G4FbLo8r6WHZU35HyIqan31uSakUgSVGDyDwenH8lhUMBNChYduT6wjPzwlx0Ed4meVzVCbS+Tl7CcP/PdOHOJfqdDXUswzubH9Mu5GDLxzvH4Mtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eGmBUanR; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 25 Apr 2024 20:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714090761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iiDAAU9IAxaCzWX8x+M+Xfi0SfQX0lRBqlfJeEKcIHM=;
	b=eGmBUanRBVu9815GoHdTQzhhKjtSIv7vsZocN0F2fjdwhao6XUsWARO7DUVb6l/vLmgho0
	dTFzMuJmCtFMNOvy9aX5WReuYxeInKldHxRcCDCCw7UfeQZkBXa8Ka37yk3Ua9ve01Hdup
	7QXmk4RSshVM8ZfnPC9hkf4YvSuqH7I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Kees Cook <keescook@chromium.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
	David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mm/slub: Avoid recursive loop with kmemleak
Message-ID: <t6iykbzqfwt3d7j537shnvebwqy4u5fmzw2gwyeb6a7cosp3hu@eugiwl3t6zfn>
References: <20240425205516.work.220-kees@kernel.org>
 <ebc6pcoq4cle3ge526ch6q5hz2vvphmgwu2yqdveypjm24pa3b@cwsggjnoepaq>
 <CAJuCfpEMK-6+1CUDfiiKLGLfTEomJGjaeHOfsWZZBdaJ6DcvFQ@mail.gmail.com>
 <20240425164917.8c9603387b4cce11121024a8@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425164917.8c9603387b4cce11121024a8@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 25, 2024 at 04:49:17PM -0700, Andrew Morton wrote:
> On Thu, 25 Apr 2024 14:30:55 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
> 
> > > > --- a/mm/kmemleak.c
> > > > +++ b/mm/kmemleak.c
> > > > @@ -463,7 +463,7 @@ static struct kmemleak_object *mem_pool_alloc(gfp_t gfp)
> > > >
> > > >       /* try the slab allocator first */
> > > >       if (object_cache) {
> > > > -             object = kmem_cache_alloc(object_cache, gfp_kmemleak_mask(gfp));
> > > > +             object = kmem_cache_alloc_noprof(object_cache, gfp_kmemleak_mask(gfp));
> > >
> > > What do these get accounted to, or does this now pop a warning with
> > > CONFIG_MEM_ALLOC_PROFILING_DEBUG?
> > 
> > Thanks for the fix, Kees!
> > I'll look into this recursion more closely to see if there is a better
> > way to break it. As a stopgap measure seems ok to me. I also think
> > it's unlikely that one would use both tracking mechanisms on the same
> > system.
> 
> I'd really like to start building mm-stable without having to route
> around memprofiling.  How about I include Kees's patch in that for now?

Agreed

