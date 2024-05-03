Return-Path: <linux-kernel+bounces-167714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6011A8BADDD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEFAC1F23423
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE6515383E;
	Fri,  3 May 2024 13:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dustri.org header.i=@dustri.org header.b="mCNUcPGK"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7FA153BF3
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 13:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714743577; cv=none; b=kw2l0SNL9/HDdjLVslBpWiqJU3bxeEhtm32DlpNyIoC5W8jaN10p9g00QxtBEeN8yT2pH7uXwDFEXaze6B5oOjnbkjC7Cgvoie5bHA740VFKrInVsdx7orq+6qfjJc72SnD2+rN0gG9Rp4EdkafL+YMqX5dIHv35Yg/WN9pXA/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714743577; c=relaxed/simple;
	bh=o9kuPRNBUsiK7kvOAHTHUDbtqai27CIo7oIJxq7DCjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EkHGpUsc2PBXX32zTp+CnjTxm+v8MehQDeeRcDEakvtbkWg/lZGbDlCkOOXQRlLyynXwo/2GFL9Vi7pIQCkNBu2nwkkrfrJiCcghzF81B8RXrMtwcX94dtk6g/sc28zqbBGU7ZZqmmM0AyAbRyYhFopPsXebr27s/1P7muA/sto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dustri.org; spf=pass smtp.mailfrom=dustri.org; dkim=pass (2048-bit key) header.d=dustri.org header.i=@dustri.org header.b=mCNUcPGK; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dustri.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dustri.org
Message-ID: <28478de8-3028-48f2-b887-56149b6e324a@dustri.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dustri.org; s=key1;
	t=1714743573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+RwTdEzW/FB2ApzZxuuCNuwAx1O+uSLKzF1SQsO0uE8=;
	b=mCNUcPGKoh9tQSDW19snBXOgRCBUIw4ATq52+/dYMeqf6z6MwYKeFaBMNQffZiNuqCe9wW
	ycq754rqQCUB2MdFlAXWflQyB7TmoiUh1rfulR+de//9XAeKQrsVvUIoe+u4Hn0MiBs8PR
	zn+FC/PsB893kexCoiOSx6/Ihk4/8h92BtuElX7XEp3S4TbtmGRcODawD63986cel8cPuA
	gjdcYOSLptoz1cNvgqgmt7A6UqjBaL5s+7/1x1y9iiKMXzfFmECDJ2m7WZjHl9Ne4jXUVb
	bQiQV2JD6Cdy5fYCxbGJFtF7hQsuLv7Za7NLFc7XLXgDHMnxQVTHYiMbMQJKrQ==
Date: Fri, 3 May 2024 15:39:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/6] slab: Introduce dedicated bucket allocator
To: Kees Cook <keescook@chromium.org>, Matteo Rizzo <matteorizzo@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, "GONG, Ruiqi"
 <gongruiqi@huaweicloud.com>, Xiu Jianfeng <xiujianfeng@huawei.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, Jann Horn <jannh@google.com>,
 Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-hardening@vger.kernel.org
References: <20240424213019.make.366-kees@kernel.org>
 <d0a65407-d3ae-46d5-800f-415ce7efcf22@dustri.org>
 <202404280921.A7683D511@keescook>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: jvoisin <julien.voisin@dustri.org>
Autocrypt: addr=julien.voisin@dustri.org; keydata=
 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
 766VTOg4l2PTPCnIdNFy1Os=
In-Reply-To: <202404280921.A7683D511@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 4/28/24 19:02, Kees Cook wrote:
> On Sun, Apr 28, 2024 at 01:02:36PM +0200, jvoisin wrote:
>> On 4/24/24 23:40, Kees Cook wrote:
>>> Hi,
>>>
>>> Series change history:
>>>
>>>  v3:
>>>   - clarify rationale and purpose in commit log
>>>   - rebase to -next (CONFIG_CODE_TAGGING)
>>>   - simplify calling styles and split out bucket plumbing more cleanly
>>>   - consolidate kmem_buckets_*() family introduction patches
>>>  v2: https://lore.kernel.org/lkml/20240305100933.it.923-kees@kernel.org/
>>>  v1: https://lore.kernel.org/lkml/20240304184252.work.496-kees@kernel.org/
>>>
>>> For the cover letter, I'm repeating commit log for patch 4 here, which has
>>> additional clarifications and rationale since v2:
>>>
>>>     Dedicated caches are available for fixed size allocations via
>>>     kmem_cache_alloc(), but for dynamically sized allocations there is only
>>>     the global kmalloc API's set of buckets available. This means it isn't
>>>     possible to separate specific sets of dynamically sized allocations into
>>>     a separate collection of caches.
>>>     
>>>     This leads to a use-after-free exploitation weakness in the Linux
>>>     kernel since many heap memory spraying/grooming attacks depend on using
>>>     userspace-controllable dynamically sized allocations to collide with
>>>     fixed size allocations that end up in same cache.
>>>     
>>>     While CONFIG_RANDOM_KMALLOC_CACHES provides a probabilistic defense
>>>     against these kinds of "type confusion" attacks, including for fixed
>>>     same-size heap objects, we can create a complementary deterministic
>>>     defense for dynamically sized allocations that are directly user
>>>     controlled. Addressing these cases is limited in scope, so isolation these
>>>     kinds of interfaces will not become an unbounded game of whack-a-mole. For
>>>     example, pass through memdup_user(), making isolation there very
>>>     effective.
>>
>> What does "Addressing these cases is limited in scope, so isolation
>> these kinds of interfaces will not become an unbounded game of
>> whack-a-mole." mean exactly?
> 
> The number of cases where there is a user/kernel API for size-controlled
> allocations is limited. They don't get added very often, and most are
> (correctly) using kmemdup_user() as the basis of their allocations. This
> means we have a relatively well defined set of criteria for finding
> places where this is needed, and most newly added interfaces will use
> the existing (kmemdup_user()) infrastructure that will already be covered.

A simple CodeQL query returns 266 of them:
https://lookerstudio.google.com/reporting/68b02863-4f5c-4d85-b3c1-992af89c855c/page/n92nD?params=%7B%22df3%22:%22include%25EE%2580%25803%25EE%2580%2580T%22%7D

Is this number realistic and coherent with your results/own analysis?

> 
>>>     In order to isolate user-controllable sized allocations from system
>>>     allocations, introduce kmem_buckets_create(), which behaves like
>>>     kmem_cache_create(). Introduce kmem_buckets_alloc(), which behaves like
>>>     kmem_cache_alloc(). Introduce kmem_buckets_alloc_track_caller() for
>>>     where caller tracking is needed. Introduce kmem_buckets_valloc() for
>>>     cases where vmalloc callback is needed.
>>>     
>>>     Allows for confining allocations to a dedicated set of sized caches
>>>     (which have the same layout as the kmalloc caches).
>>>     
>>>     This can also be used in the future to extend codetag allocation
>>>     annotations to implement per-caller allocation cache isolation[1] even
>>>     for dynamic allocations.
>> Having per-caller allocation cache isolation looks like something that
>> has already been done in
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3c6152940584290668b35fa0800026f6a1ae05fe
>> albeit in a randomized way. Why not piggy-back on the infra added by
>> this patch, instead of adding a new API?
> 
> It's not sufficient because it is a static set of buckets. It cannot be
> adjusted dynamically (which is not a problem kmem_buckets_create() has).
> I had asked[1], in an earlier version of CONFIG_RANDOM_KMALLOC_CACHES, for
> exactly the API that is provided in this series, because that would be
> much more flexible.
> 
> And for systems that use allocation profiling, the next step
> would be to provide per-call-site isolation (which would supersede
> CONFIG_RANDOM_KMALLOC_CACHES, which we'd keep for the non-alloc-prof
> cases).
> 
>>>     Memory allocation pinning[2] is still needed to plug the Use-After-Free
>>>     cross-allocator weakness, but that is an existing and separate issue
>>>     which is complementary to this improvement. Development continues for
>>>     that feature via the SLAB_VIRTUAL[3] series (which could also provide
>>>     guard pages -- another complementary improvement).
>>>     
>>>     Link: https://lore.kernel.org/lkml/202402211449.401382D2AF@keescook [1]
>>>     Link: https://googleprojectzero.blogspot.com/2021/10/how-simple-linux-kernel-memory.html [2]
>>>     Link: https://lore.kernel.org/lkml/20230915105933.495735-1-matteorizzo@google.com/ [3]
>>
>> To be honest, I think this series is close to useless without allocation
>> pinning. And even with pinning, it's still routinely bypassed in the
>> KernelCTF
>> (https://github.com/google/security-research/tree/master/pocs/linux/kernelctf).
> 
> Sure, I can understand why you might think that, but I disagree. This
> adds the building blocks we need for better allocation isolation
> control, and stops existing (and similar) attacks toda>
> But yes, given attackers with sufficient control over the entire system,
> all mitigations get weaker. We can't fall into the trap of "perfect
> security"; real-world experience shows that incremental improvements
> like this can strongly impact the difficulty of mounting attacks. Not
> all flaws are created equal; not everything is exploitable to the same
> degree.

It's not about "perfect security", but about wisely spending the
complexity/review/performance/churn/… budgets in my opinion.

>> Do you have some particular exploits in mind that would be completely
>> mitigated by your series?
> 
> I link to like a dozen in the last two patches. :P
> 
> This series immediately closes 3 well used exploit methodologies.
> Attackers exploiting new flaws that could have used the killed methods
> must now choose methods that have greater complexity, and this drives
> them towards cross-allocator attacks. Robust exploits there are more
> costly to develop as we narrow the scope of methods.

You linked exploits that were making use of the two structures that you
isolated; making them use different structures would likely mean a
couple of hours.

I was more interested in exploits that are effectively killed; as I'm
still not convinced that elastic structures are rare, and that manually
isolating them one by one is attainable/sustainable/…

But if you have some proper analysis in this direction, then yes, I
completely agrees that isolating all of them is a great idea.

> 
> Bad analogy: we're locking the doors of a house. Yes, some windows may
> still be unlocked, but now they'll need a ladder. And it doesn't make
> sense to lock the windows if we didn't lock the doors first. This is
> what I mean by complementary defenses, and comes back to what I mentioned
> earlier: "perfect security" is a myth, but incremental security works.
> 
>> Moreover, I'm not aware of any ongoing development of the SLAB_VIRTUAL
>> series: the last sign of life on its thread is from 7 months ago.
> 
> Yeah, I know, but sometimes other things get in the way. Matteo assures
> me it's still coming.
> 
> Since you're interested in seeing SLAB_VIRTUAL land, please join the
> development efforts. Reach out to Matteo (you, he, and I all work for
> the same company) and see where you can assist. Surely this can be
> something you can contribute to while "on the clock"?

I left Google a couple of weeks ago unfortunately, and I won't touch
anything with email-based development for less than a Google salary :D

> 
>>> After the core implementation are 2 patches that cover the most heavily
>>> abused "repeat offenders" used in exploits. Repeating those details here:
>>>
>>>     The msg subsystem is a common target for exploiting[1][2][3][4][5][6]
>>>     use-after-free type confusion flaws in the kernel for both read and
>>>     write primitives. Avoid having a user-controlled size cache share the
>>>     global kmalloc allocator by using a separate set of kmalloc buckets.
>>>     
>>>     Link: https://blog.hacktivesecurity.com/index.php/2022/06/13/linux-kernel-exploit-development-1day-case-study/ [1]
>>>     Link: https://hardenedvault.net/blog/2022-11-13-msg_msg-recon-mitigation-ved/ [2]
>>>     Link: https://www.willsroot.io/2021/08/corctf-2021-fire-of-salvation-writeup.html [3]
>>>     Link: https://a13xp0p0v.github.io/2021/02/09/CVE-2021-26708.html [4]
>>>     Link: https://google.github.io/security-research/pocs/linux/cve-2021-22555/writeup.html [5]
>>>     Link: https://zplin.me/papers/ELOISE.pdf [6]
>>>     Link: https://syst3mfailure.io/wall-of-perdition/ [7]
>>>
>>>     Both memdup_user() and vmemdup_user() handle allocations that are
>>>     regularly used for exploiting use-after-free type confusion flaws in
>>>     the kernel (e.g. prctl() PR_SET_VMA_ANON_NAME[1] and setxattr[2][3][4]
>>>     respectively).
>>>     
>>>     Since both are designed for contents coming from userspace, it allows
>>>     for userspace-controlled allocation sizes. Use a dedicated set of kmalloc
>>>     buckets so these allocations do not share caches with the global kmalloc
>>>     buckets.
>>>     
>>>     Link: https://starlabs.sg/blog/2023/07-prctl-anon_vma_name-an-amusing-heap-spray/ [1]
>>>     Link: https://duasynt.com/blog/linux-kernel-heap-spray [2]
>>>     Link: https://etenal.me/archives/1336 [3]
>>>     Link: https://github.com/a13xp0p0v/kernel-hack-drill/blob/master/drill_exploit_uaf.c [4]
>>
>> What's the performance impact of this series? Did you run some benchmarks?
> 
> I wasn't able to measure any performance impact at all. It does add a
> small bit of memory overhead, but it's on the order of a dozen pages
> used for the 2 extra sets of buckets. (E.g. it's well below the overhead
> introduced by CONFIG_RANDOM_KMALLOC_CACHES, which adds 16 extra sets
> of buckets.)

Nice!

