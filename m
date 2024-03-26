Return-Path: <linux-kernel+bounces-119823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 559BF88CD5A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792281C389D9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA0B13D25D;
	Tue, 26 Mar 2024 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qh7bLcvk"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B73481A3
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711482079; cv=none; b=EOEfZ57wGNBgHE0FFz0gqAiBkHBk2zVdydxLrGcjZeWXlUv50scn+YxdL16BkmkQnQm05oAhmGfAZpRIbHDfh5Oz0gTnK0KtPvm+TaD/m//t5jgjmgKLQDr/2u7EOFFNYdpvDi57WolpsMv+QCocPum0X0kdMgdCzFB2kYTlhPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711482079; c=relaxed/simple;
	bh=k9ihZSdW4sVIG80LGN0KDSsBThh04pd1ppuGet9T+g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxGKrCg4pAyl6+yaQWsonY32mrXB7EfLKuaCsxSywZaif2NDR7eGmSLh3h8AHAE7+3MoLmaRkA9y0gJ8pRmjEh+hSltRUHCLzEHVfJGzKIxhhJOx39SNj+3mC0IoMcWaSc1epGYFgoSIjbsvw2Y5Jhwc60qy387O/qy+mFL1Ewg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Qh7bLcvk; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ea8a0d1a05so108623b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711482077; x=1712086877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ran6TWnpaiTaADpt6skaPDxXzFx/WGCJHW99KUEIIo=;
        b=Qh7bLcvkwofoTDstigh0zK2nQfPKNL56BoC0DZYYNLMrqUpkWLJ6OVyeIvpXpnntrl
         GfQGoYgzO9e3Kq2vF1D2+KtAoz7x2DYHS67/DXJuaonPubElKv8HadZSx8a9cpP97srV
         vDZIYApj3muyYWMz6DePRIRfkJTyrj9sQmL58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711482077; x=1712086877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ran6TWnpaiTaADpt6skaPDxXzFx/WGCJHW99KUEIIo=;
        b=dl+T98cdNsx9glp768VQ1GWMkbaSCELvh2fV6K0CByLQmmvHfHLryHzBV2SLVAeH8Z
         4PNlckFLlmHDdtkPudSqHlmyL0UH6q4T9LFpfG1ZZdUdkw7HgerULfhl6KZX/kyLGZ+Y
         IZSFel0xVfFxloi6yMumjxBjAEK+p5VSvRumTRjoh90s9WgIitC2q1UACuWdDxqdJ/Gw
         iO/GK50llZIuMP72WuwEwaukq/uQJioImsUP33IvsNSP+4nznI8OB3NVFCFeB7e7cAcA
         D0uBK4FAUum0kocGFoa4NlAWLohFwDO0JOK81Aheo46fLVx6D1yvpCrmrRmOWmg+a2WU
         fY/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVw91BVXfjiwcZTOamDRH1AbChE95jdcYybWi+v9dclpDNrP8BPsXytrV3+J5IeULnbQnpGC5N+ty/t07dY4FzjFOLhXqGjAxI7Cbqh
X-Gm-Message-State: AOJu0YxFdJVt8e1qZrATrlFQ2jPb8emXcY3Dm/F9QySAHZCFh92+fjHL
	f17KHWyhfzVAO5aADynFId5Lniv6knw36mDVNoHbGAWVu8RPyccuHPRAKrDIcJKQxyWCeDGVQcE
	=
X-Google-Smtp-Source: AGHT+IFRe2LZU3jx2yt0Q76ADcQvq/WjsF+NrkywBd4rPr7frESxdB3vIvTLVJtwMwVH83sbIoOlKw==
X-Received: by 2002:a05:6a20:840d:b0:1a3:5b82:a88b with SMTP id c13-20020a056a20840d00b001a35b82a88bmr3414875pzd.18.1711482076981;
        Tue, 26 Mar 2024 12:41:16 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b17-20020a63cf51000000b005dc4b562f6csm8041556pgj.3.2024.03.26.12.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 12:41:16 -0700 (PDT)
Date: Tue, 26 Mar 2024 12:41:15 -0700
From: Kees Cook <keescook@chromium.org>
To: julien.voisin@dustri.org
Cc: Vlastimil Babka <vbabka@suse.cz>, Julien Voisin <jvoisin@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jann Horn <jannh@google.com>, Matteo Rizzo <matteorizzo@google.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 0/9] slab: Introduce dedicated bucket allocator
Message-ID: <202403261229.0ADF2637C@keescook>
References: <20240305100933.it.923-kees@kernel.org>
 <5e1571de-2c5a-4be4-93f4-01582094ee96@suse.cz>
 <202403250958.DAFA70CC@keescook>
 <a88362316fb00494b78859625cabe0820ca26a15@dustri.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a88362316fb00494b78859625cabe0820ca26a15@dustri.org>

On Tue, Mar 26, 2024 at 06:07:07PM +0000, julien.voisin@dustri.org wrote:
> 25 March 2024 at 19:24, "Kees Cook" <keescook@chromium.org> wrote:
> > On Mon, Mar 25, 2024 at 10:03:23AM +0100, Vlastimil Babka wrote:
> > > On 3/5/24 11:10 AM, Kees Cook wrote:
> > >  Hi,
> > >  
> > >  Repeating the commit logs for patch 4 here:
> > >  
> > >  Dedicated caches are available For fixed size allocations via
> > >  kmem_cache_alloc(), but for dynamically sized allocations there is only
> > >  the global kmalloc API's set of buckets available. This means it isn't
> > >  possible to separate specific sets of dynamically sized allocations into
> > >  a separate collection of caches.
> > >  
> > >  This leads to a use-after-free exploitation weakness in the Linux
> > >  kernel since many heap memory spraying/grooming attacks depend on using
> > >  userspace-controllable dynamically sized allocations to collide with
> > >  fixed size allocations that end up in same cache.
> > >  
> > >  While CONFIG_RANDOM_KMALLOC_CACHES provides a probabilistic defense
> > >  against these kinds of "type confusion" attacks, including for fixed
> > >  same-size heap objects, we can create a complementary deterministic
> > >  defense for dynamically sized allocations.
> > >  
> > >  In order to isolate user-controllable sized allocations from system
> > >  allocations, introduce kmem_buckets_create(), which behaves like
> > >  kmem_cache_create(). (The next patch will introduce kmem_buckets_alloc(),
> > >  which behaves like kmem_cache_alloc().)
> > >  
> > >  Allows for confining allocations to a dedicated set of sized caches
> > >  (which have the same layout as the kmalloc caches).
> > >  
> > >  This can also be used in the future once codetag allocation annotations
> > >  exist to implement per-caller allocation cache isolation[0] even for
> > >  dynamic allocations.
> > >  
> > >  Link: https://lore.kernel.org/lkml/202402211449.401382D2AF@keescook [0]
> > >  
> > >  After the implemetation are 2 example patches of how this could be used
> > >  for some repeat "offenders" that get used in exploits. There are more to
> > >  be isolated beyond just these. Repeating the commit log for patch 8 here:
> > >  
> > >  The msg subsystem is a common target for exploiting[1][2][3][4][5][6]
> > >  use-after-free type confusion flaws in the kernel for both read and
> > >  write primitives. Avoid having a user-controlled size cache share the
> > >  global kmalloc allocator by using a separate set of kmalloc buckets.
> > >  
> > >  Link: https://blog.hacktivesecurity.com/index.php/2022/06/13/linux-kernel-exploit-development-1day-case-study/ [1]
> > >  Link: https://hardenedvault.net/blog/2022-11-13-msg_msg-recon-mitigation-ved/ [2]
> > >  Link: https://www.willsroot.io/2021/08/corctf-2021-fire-of-salvation-writeup.html [3]
> > >  Link: https://a13xp0p0v.github.io/2021/02/09/CVE-2021-26708.html [4]
> > >  Link: https://google.github.io/security-research/pocs/linux/cve-2021-22555/writeup.html [5]
> > >  Link: https://zplin.me/papers/ELOISE.pdf [6]
> > >  
> > >  Hi Kees,
> > >  
> > >  after reading [1] I think the points should be addressed, mainly about the
> > >  feasibility of converting users manually.
> >
> > Sure, I can do that.
> > Adding Julien to this thread... Julien can you please respond to LKML
> > patches in email? It's much easier to keep things in a single thread. :)
> >
> > ] This is playing wack-a-mole
> > Kind of, but not really. These patches provide a mechanism for having
> > dedicated dynamically-sized slab caches (to match kmem_cache_create(),
> > which only works for fixed-size allocations). This is needed to expand
> > the codetag work into doing per-call-site allocations, as I detailed
> > here[1].
> >
> > Also, adding uses manually isn't very difficult, as can be seen in the
> > examples I included. In fact, my examples between v1 and v2 collapsed
> > from 3 to 2, because covering memdup_user() actually covered 2 known
> > allocation paths (attrs and vma names), and given its usage pattern,
> > will cover more in the future without changes.
> 
> It's not about difficulty, it's about scale. There are hundreds of interesting structures: I'm worried that no one will take the time to add a separate bucket for each of them, chase their call-sites down, and monitor every single newly added structures to check if they are "interesting" and should benefit from their own bucket as well.

Very few are both: 1) dynamically sized, and 2) coming from userspace,
so I think the scale is fine.

> > ] something like AUTOSLAB would be better
> > Yes, that's the goal of [1]. This is a prerequisite for that, as
> > mentioned in the cover letter.
> 
> This series looks unrelated to [1] to me: the former adds a mechanism to add buckets and expects developers to manually make use of them, while the latter is about adding infrastructure to automate call-site-based segregation.

Right -- but for call-site-based separation, there is currently no way
to separate _dynamically_ sized allocations; only fixed size (via
kmem_cache_create()). This series adds the ability for call-site-based
separation to also use kmem_bucket_create(). Call-site-based
separation isn't possible without this series.

> 
> > ] The slabs needs to be pinned
> > Yes, and this is a general problem[2] with all kmalloc allocations, though.
> > This isn't unique to to this patch series. SLAB_VIRTUAL solves it, and
> > is under development.
> 
> Then it would be nice to mention it in the serie, as an acknowledged limitation.

Sure, I can update the cover letter.

> 
> > ] Lacks guard pages
> > Yes, and again, this is a general problem with all kmalloc allocations.
> > Solving it, like SLAB_VIRTUAL, would be a complementary hardening
> > improvement to the allocator generally.
> 
> Then it would also be nice to mention it, because currently it's unclear that those limitations are both known and will be properly addressed.

Sure. For both this and pinning, the issues are orthogonal, so it didn't
seem useful to distract from what the series was doing, but I can
explicitly mention them going forward.

> 
> > ] PAX_USERCOPY has been marking these sites since 2012
> > Either it's whack-a-mole or it's not. :) 
> 
> This annotation was added 12 years ago in PaX, and while it was state of the art back then, I think that in 2024 we can do better than this.

Agreed. Here's my series to start that. :)

> > PAX_USERCOPY shows that it _is_ possible to mark all sites.
> 
> It shows that it's possible to annotate some sites (17 in grsecurity-3.1-4.9.9-201702122044.patch), and while it has a similar approach to your series, its annotations aren't conveying the same meaning.

Sure, GFP_USERCOPY is separate.

> > Regardless, like AUTOSLAB, PAX_USERCOPY isn't
> > upstream, and its current implementation is an unpublished modification
> > to a GPL project. I look forward to someone proposing it for inclusion
> > in Linux, but for now we can work with the patches where an effort _has_
> > been made to upstream them for the benefit of the entire ecosystem.
> > ] What about CONFIG_KMALLOC_SPLIT_VARSIZE
> > This proposed improvement is hampered by not having dedicated
> > _dynamically_ sized kmem caches, which this series provides. And with
> > codetag-split allocations[1], the goals of CONFIG_KMALLOC_SPLIT_VARSIZE
> > are more fully realized, providing much more complete coverage.
> 
> CONFIG_KMALLOC_SPLIT_VARSIZE has been bypassed dozen of times in various ways as part of Google's kernelCTF.
> Your series is, to my understanding, a weaker form of it. So I'm not super-convinced that it's the right approach to mitigate UAF.

This series doesn't do anything that CONFIG_KMALLOC_SPLIT_VARSIZE does.
The call-site-separation series (which would depend on this series)
would do that work.

> Do you think it would be possible for Google to add this series to its kernelCTF, so gather empirical data on how feasible/easy it is to bypass it?

Sure, feel free to make that happen. :) But again, I'm less interested
in this series as a _standalone_ solution. It's a prerequisite for
call-site-based allocation separation. As part of it, though, we can
plug the blatant exploitation methods that currently exist.

-Kees

-- 
Kees Cook

