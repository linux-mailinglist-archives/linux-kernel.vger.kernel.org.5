Return-Path: <linux-kernel+bounces-161513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A08E28B4D06
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 19:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5521A281819
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 17:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E4F74402;
	Sun, 28 Apr 2024 17:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OE65phJ7"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDCB73514
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 17:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714323781; cv=none; b=PE14HtYM0WLqULbE+GnxRFG+8WpTByww2z6TTu8FK1TtMr1B34iHWx5P313wJXhvgW1bVrA3Jp0k7yZOOmEBT7L+5c+BrOevSWKRGXZdBFDbzmS11QE5amwJYFV+N/EyONztk3ThfbIMVLHRn9LoHTdV736hL7JE++hfxgna6K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714323781; c=relaxed/simple;
	bh=MmeFR06x7fh+/qtTYyu9q36cOU2EyiK1+9pSQ5Art7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Phlbpw8LqaV8kMG+hzZMNaAwYNuS6xUbJrqhbwpuGR36OkE1mxdaESwqdrafhFY3isQpz3msIvylh6weHrrO8gWoMAiy2g2xHNRkth1OQAf5a3Mwj+aWGZpXdZncu+qnAAFa4+u9q4nL50hOQ1ySpXnfgzYkNlEWxRi1FNSQqbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OE65phJ7; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ee0642f718so3529357b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 10:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714323779; x=1714928579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2qJzM1aoYHicoc68EH18vvTtbMF+7vJm0oFHLDSG8g=;
        b=OE65phJ7/jHPdgqTX3dyQk9bm0HT5aJP+q5+9aVktI4oSaaSR01dgJkeKRQXdTHJTa
         MYNkfvsxGREuODPw8f3kZgwKjWcMi13L9yC+ld/hlhKrtsX+teyGbtGFt8iE1ymeFnRx
         1xtmJ40ciZ3Ec3ToZkkeC/xiGPNbsK7W9EEoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714323779; x=1714928579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2qJzM1aoYHicoc68EH18vvTtbMF+7vJm0oFHLDSG8g=;
        b=UNgyU8sEilN3QmQ/qthoN8TWTLopdJC7HbVjj+xcpSIg2N84sjumon8hzUig04pPKB
         zCAbTCSybX7uYylCcxs/rUdGuYwivdWyXy9edPhqYZ9fgyLjd4YLorwDQZiWiInQHuFJ
         mglOJRlH8/iYq0qIbUOFbS9ShsftJirUsYib76NLrKOfJWwKSpvE72iPF2g71pUk/t5N
         DpBXIJPL/xd67+JILFd1P4zO/jfWhBBCl5MfMqrj7h8hARzpqp4+uaUKETKcH65EFnlP
         Pg0tz8gsygC96eGYF5bfJJ+45oN08N6ORmex5NVMUbEfAiUK5+Vpl4X//2Ed++K8F0ai
         HyLA==
X-Forwarded-Encrypted: i=1; AJvYcCWc2IrC4S5qpNmnyXDZEd9q/X4hA63zTpQ+qSUXdKatGv59f01jFljLGoagSyoF8OqqmL1ZYdSiBz1JdHzrJM/D1bn2iIDqvQ42r532
X-Gm-Message-State: AOJu0Yyqcd7F92Eh7s98ARhApXv4v3Nu7lQJFcKDyCHsSi9DzvlVSsld
	E+derPQIZrbjKsv0KJ4o4zEbeoLEg8R6EX/8CB90HiM1Hud27Z5ZcZu+qn+ps3jUhn5DgN9nJiI
	=
X-Google-Smtp-Source: AGHT+IHWWLQe2VynRuCx9igwEYpj8htea8REIW4foTlkiwAx1Ts/UbQSNMIiZJhRd0vlw2foXOGzlw==
X-Received: by 2002:a17:902:e88a:b0:1e2:bdef:3973 with SMTP id w10-20020a170902e88a00b001e2bdef3973mr10803402plg.33.1714323778924;
        Sun, 28 Apr 2024 10:02:58 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u9-20020a170903124900b001e3f4f1a2aasm18663059plh.23.2024.04.28.10.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 10:02:57 -0700 (PDT)
Date: Sun, 28 Apr 2024 10:02:56 -0700
From: Kees Cook <keescook@chromium.org>
To: jvoisin <julien.voisin@dustri.org>,
	Matteo Rizzo <matteorizzo@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
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
	Jann Horn <jannh@google.com>, Thomas Graf <tgraf@suug.ch>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 0/6] slab: Introduce dedicated bucket allocator
Message-ID: <202404280921.A7683D511@keescook>
References: <20240424213019.make.366-kees@kernel.org>
 <d0a65407-d3ae-46d5-800f-415ce7efcf22@dustri.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0a65407-d3ae-46d5-800f-415ce7efcf22@dustri.org>

On Sun, Apr 28, 2024 at 01:02:36PM +0200, jvoisin wrote:
> On 4/24/24 23:40, Kees Cook wrote:
> > Hi,
> > 
> > Series change history:
> > 
> >  v3:
> >   - clarify rationale and purpose in commit log
> >   - rebase to -next (CONFIG_CODE_TAGGING)
> >   - simplify calling styles and split out bucket plumbing more cleanly
> >   - consolidate kmem_buckets_*() family introduction patches
> >  v2: https://lore.kernel.org/lkml/20240305100933.it.923-kees@kernel.org/
> >  v1: https://lore.kernel.org/lkml/20240304184252.work.496-kees@kernel.org/
> > 
> > For the cover letter, I'm repeating commit log for patch 4 here, which has
> > additional clarifications and rationale since v2:
> > 
> >     Dedicated caches are available for fixed size allocations via
> >     kmem_cache_alloc(), but for dynamically sized allocations there is only
> >     the global kmalloc API's set of buckets available. This means it isn't
> >     possible to separate specific sets of dynamically sized allocations into
> >     a separate collection of caches.
> >     
> >     This leads to a use-after-free exploitation weakness in the Linux
> >     kernel since many heap memory spraying/grooming attacks depend on using
> >     userspace-controllable dynamically sized allocations to collide with
> >     fixed size allocations that end up in same cache.
> >     
> >     While CONFIG_RANDOM_KMALLOC_CACHES provides a probabilistic defense
> >     against these kinds of "type confusion" attacks, including for fixed
> >     same-size heap objects, we can create a complementary deterministic
> >     defense for dynamically sized allocations that are directly user
> >     controlled. Addressing these cases is limited in scope, so isolation these
> >     kinds of interfaces will not become an unbounded game of whack-a-mole. For
> >     example, pass through memdup_user(), making isolation there very
> >     effective.
> 
> What does "Addressing these cases is limited in scope, so isolation
> these kinds of interfaces will not become an unbounded game of
> whack-a-mole." mean exactly?

The number of cases where there is a user/kernel API for size-controlled
allocations is limited. They don't get added very often, and most are
(correctly) using kmemdup_user() as the basis of their allocations. This
means we have a relatively well defined set of criteria for finding
places where this is needed, and most newly added interfaces will use
the existing (kmemdup_user()) infrastructure that will already be covered.

> >     In order to isolate user-controllable sized allocations from system
> >     allocations, introduce kmem_buckets_create(), which behaves like
> >     kmem_cache_create(). Introduce kmem_buckets_alloc(), which behaves like
> >     kmem_cache_alloc(). Introduce kmem_buckets_alloc_track_caller() for
> >     where caller tracking is needed. Introduce kmem_buckets_valloc() for
> >     cases where vmalloc callback is needed.
> >     
> >     Allows for confining allocations to a dedicated set of sized caches
> >     (which have the same layout as the kmalloc caches).
> >     
> >     This can also be used in the future to extend codetag allocation
> >     annotations to implement per-caller allocation cache isolation[1] even
> >     for dynamic allocations.
> Having per-caller allocation cache isolation looks like something that
> has already been done in
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3c6152940584290668b35fa0800026f6a1ae05fe
> albeit in a randomized way. Why not piggy-back on the infra added by
> this patch, instead of adding a new API?

It's not sufficient because it is a static set of buckets. It cannot be
adjusted dynamically (which is not a problem kmem_buckets_create() has).
I had asked[1], in an earlier version of CONFIG_RANDOM_KMALLOC_CACHES, for
exactly the API that is provided in this series, because that would be
much more flexible.

And for systems that use allocation profiling, the next step
would be to provide per-call-site isolation (which would supersede
CONFIG_RANDOM_KMALLOC_CACHES, which we'd keep for the non-alloc-prof
cases).

> >     Memory allocation pinning[2] is still needed to plug the Use-After-Free
> >     cross-allocator weakness, but that is an existing and separate issue
> >     which is complementary to this improvement. Development continues for
> >     that feature via the SLAB_VIRTUAL[3] series (which could also provide
> >     guard pages -- another complementary improvement).
> >     
> >     Link: https://lore.kernel.org/lkml/202402211449.401382D2AF@keescook [1]
> >     Link: https://googleprojectzero.blogspot.com/2021/10/how-simple-linux-kernel-memory.html [2]
> >     Link: https://lore.kernel.org/lkml/20230915105933.495735-1-matteorizzo@google.com/ [3]
> 
> To be honest, I think this series is close to useless without allocation
> pinning. And even with pinning, it's still routinely bypassed in the
> KernelCTF
> (https://github.com/google/security-research/tree/master/pocs/linux/kernelctf).

Sure, I can understand why you might think that, but I disagree. This
adds the building blocks we need for better allocation isolation
control, and stops existing (and similar) attacks today.

But yes, given attackers with sufficient control over the entire system,
all mitigations get weaker. We can't fall into the trap of "perfect
security"; real-world experience shows that incremental improvements
like this can strongly impact the difficulty of mounting attacks. Not
all flaws are created equal; not everything is exploitable to the same
degree.

> Do you have some particular exploits in mind that would be completely
> mitigated by your series?

I link to like a dozen in the last two patches. :P

This series immediately closes 3 well used exploit methodologies.
Attackers exploiting new flaws that could have used the killed methods
must now choose methods that have greater complexity, and this drives
them towards cross-allocator attacks. Robust exploits there are more
costly to develop as we narrow the scope of methods.

Bad analogy: we're locking the doors of a house. Yes, some windows may
still be unlocked, but now they'll need a ladder. And it doesn't make
sense to lock the windows if we didn't lock the doors first. This is
what I mean by complementary defenses, and comes back to what I mentioned
earlier: "perfect security" is a myth, but incremental security works.

> Moreover, I'm not aware of any ongoing development of the SLAB_VIRTUAL
> series: the last sign of life on its thread is from 7 months ago.

Yeah, I know, but sometimes other things get in the way. Matteo assures
me it's still coming.

Since you're interested in seeing SLAB_VIRTUAL land, please join the
development efforts. Reach out to Matteo (you, he, and I all work for
the same company) and see where you can assist. Surely this can be
something you can contribute to while "on the clock"?

> > After the core implementation are 2 patches that cover the most heavily
> > abused "repeat offenders" used in exploits. Repeating those details here:
> > 
> >     The msg subsystem is a common target for exploiting[1][2][3][4][5][6]
> >     use-after-free type confusion flaws in the kernel for both read and
> >     write primitives. Avoid having a user-controlled size cache share the
> >     global kmalloc allocator by using a separate set of kmalloc buckets.
> >     
> >     Link: https://blog.hacktivesecurity.com/index.php/2022/06/13/linux-kernel-exploit-development-1day-case-study/ [1]
> >     Link: https://hardenedvault.net/blog/2022-11-13-msg_msg-recon-mitigation-ved/ [2]
> >     Link: https://www.willsroot.io/2021/08/corctf-2021-fire-of-salvation-writeup.html [3]
> >     Link: https://a13xp0p0v.github.io/2021/02/09/CVE-2021-26708.html [4]
> >     Link: https://google.github.io/security-research/pocs/linux/cve-2021-22555/writeup.html [5]
> >     Link: https://zplin.me/papers/ELOISE.pdf [6]
> >     Link: https://syst3mfailure.io/wall-of-perdition/ [7]
> > 
> >     Both memdup_user() and vmemdup_user() handle allocations that are
> >     regularly used for exploiting use-after-free type confusion flaws in
> >     the kernel (e.g. prctl() PR_SET_VMA_ANON_NAME[1] and setxattr[2][3][4]
> >     respectively).
> >     
> >     Since both are designed for contents coming from userspace, it allows
> >     for userspace-controlled allocation sizes. Use a dedicated set of kmalloc
> >     buckets so these allocations do not share caches with the global kmalloc
> >     buckets.
> >     
> >     Link: https://starlabs.sg/blog/2023/07-prctl-anon_vma_name-an-amusing-heap-spray/ [1]
> >     Link: https://duasynt.com/blog/linux-kernel-heap-spray [2]
> >     Link: https://etenal.me/archives/1336 [3]
> >     Link: https://github.com/a13xp0p0v/kernel-hack-drill/blob/master/drill_exploit_uaf.c [4]
> 
> What's the performance impact of this series? Did you run some benchmarks?

I wasn't able to measure any performance impact at all. It does add a
small bit of memory overhead, but it's on the order of a dozen pages
used for the 2 extra sets of buckets. (E.g. it's well below the overhead
introduced by CONFIG_RANDOM_KMALLOC_CACHES, which adds 16 extra sets
of buckets.)

-Kees

[1] https://lore.kernel.org/lkml/202305161204.CB4A87C13@keescook/

-- 
Kees Cook

