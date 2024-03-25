Return-Path: <linux-kernel+bounces-117824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E75288B005
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 853553478E3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB9F1B969;
	Mon, 25 Mar 2024 19:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tt9y8gqe"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6B014AB8
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 19:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711395144; cv=none; b=T/Ic3TFmAkrW7bwz3sneSMd03eWFMynxDSnuIFR7Q69bMmW1yWZtjiPsGL7143NKv9KWTuD2SoWZ8tilYwxY3oL6gP7BUm2hl4RH/2sGaqd2J6HZfcZek1M1wn/yjxRlBigIWVtO7G5Lw391ICV4UIl5rFmN0bvtHULEfqiIAVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711395144; c=relaxed/simple;
	bh=wBbTvs8a684vKOnj8w74k+eidd++ilzlw0L2ptoiWDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyms9GcGJV1CnfX1GiGafXNG+2fJLSY1K+JdnX1AVyX0nwGlRoicN+oThHCcb4J1z1meFgkS1OR7j6yhKQyMsLplnCQbYdoTU8h83tz+cMm6xz+poMYx/84Mw8kz0ODirSUCzEgfQ83FzIyuChi4jcnZCrlOEEOSoeHH0mVVAGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tt9y8gqe; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 25 Mar 2024 15:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711395138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1gryeiILn0m+T/+WOsFBV2kucx78V+7dn4UI+UGeudY=;
	b=Tt9y8gqecpCFTIL+y/osjlhWrpo1KQtb/1UXfmFeze654xW6zkDcEyie11UoFjNjp4BXp9
	oZP1t2r17ya36MzSoPE3/EfxxXiNsLPXf7EoIbhni7lnDr7tntgBdh7Yphl73XODtkfzFy
	eoEKO/4ji3L41u98P86ayEAcTjMOSPo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <keescook@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, "GONG, Ruiqi" <gongruiqi@huaweicloud.com>, 
	Xiu Jianfeng <xiujianfeng@huawei.com>, Suren Baghdasaryan <surenb@google.com>, 
	Jann Horn <jannh@google.com>, Matteo Rizzo <matteorizzo@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	jvoisin <julien.voisin@dustri.org>
Subject: Re: [PATCH v2 0/9] slab: Introduce dedicated bucket allocator
Message-ID: <24vn56fs7oohqgw3rhssiwglmviruqnt44y6oeajzvskostcrr@7jzhmxjbhcha>
References: <20240305100933.it.923-kees@kernel.org>
 <5e1571de-2c5a-4be4-93f4-01582094ee96@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e1571de-2c5a-4be4-93f4-01582094ee96@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 25, 2024 at 10:03:23AM +0100, Vlastimil Babka wrote:
> On 3/5/24 11:10 AM, Kees Cook wrote:
> > Hi,
> > 
> > Repeating the commit logs for patch 4 here:
> > 
> >     Dedicated caches are available For fixed size allocations via
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
> >     defense for dynamically sized allocations.
> > 
> >     In order to isolate user-controllable sized allocations from system
> >     allocations, introduce kmem_buckets_create(), which behaves like
> >     kmem_cache_create(). (The next patch will introduce kmem_buckets_alloc(),
> >     which behaves like kmem_cache_alloc().)
> > 
> >     Allows for confining allocations to a dedicated set of sized caches
> >     (which have the same layout as the kmalloc caches).
> > 
> >     This can also be used in the future once codetag allocation annotations
> >     exist to implement per-caller allocation cache isolation[0] even for
> >     dynamic allocations.
> > 
> >     Link: https://lore.kernel.org/lkml/202402211449.401382D2AF@keescook [0]
> > 
> > After the implemetation are 2 example patches of how this could be used
> > for some repeat "offenders" that get used in exploits. There are more to
> > be isolated beyond just these. Repeating the commit log for patch 8 here:
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
> 
> Hi Kees,
> 
> after reading [1] I think the points should be addressed, mainly about the
> feasibility of converting users manually. On a related technical note I
> worry what will become of /proc/slabinfo when we convert non-trivial amounts
> of users.

There shouldn't be any need to convert users to this interface - just
leverage the alloc_hooks() macro.

