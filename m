Return-Path: <linux-kernel+bounces-161391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E17E8B4B71
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 13:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A66C28173D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 11:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA69056462;
	Sun, 28 Apr 2024 11:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dustri.org header.i=@dustri.org header.b="LJ0ZG0CV"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD59D524A2
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 11:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714302177; cv=none; b=aap0oB/KPGf/MkVg6ElX0q38ncC3mAxLnRjkqIyu5+ZKz1EoenggZ52Tros7+JVXl37dDwgoZDfC7SObQ41h2kPYI7lQHA4od0vVw0rxrlDRfieosttgCr+jvhip//cJav+yi7+7JEwSbTVyUCDq/QTgoTJcmmHEENJbXV69EYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714302177; c=relaxed/simple;
	bh=2b6gYCoJF9gtM5xiJ8Jd3+6VlpnCIEJEXN4AknJPzHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=efi8UxD+9kXpAchmPbjmTDVh72Xbqqn8lyC/c2pOj5BOxdJRyjkw8nSueenLPeRwK+5bPIlFzHswfATB9syQhrUDpAQLFB02k704qX6mCA1Ga3PWf7g/fO5Bc8C0NbBmgHLGi4cTD655zb2CMmc1UbZJzrmWQ9I/iCm0SPG+M98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dustri.org; spf=pass smtp.mailfrom=dustri.org; dkim=pass (2048-bit key) header.d=dustri.org header.i=@dustri.org header.b=LJ0ZG0CV; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dustri.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dustri.org
Message-ID: <d0a65407-d3ae-46d5-800f-415ce7efcf22@dustri.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dustri.org; s=key1;
	t=1714302171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pVVFme9IGZxZcwcArhmhbXXpkSUt5435Tn6KlathRfY=;
	b=LJ0ZG0CVcsv9NBeC7oXAVzCp8DNIyDjzDzpmJwgI+ywplahcnxaBpn6DOV4eAcdYC803TS
	6ctEcHggsNJkFsxrmE5eu64AmZ3nLKIJw+j0pv1hHuEKlLiDww4vPfXxFcUiSDv75SXONE
	6vLeQEjumyb6fpYAZ6b96TTa1c04BazYBfIcUkKEUoJiYKSAd5NJWLBHvT2HSaAfwEQaSB
	+lfODkoOzH0jfX/Vu8glrcTLMn1mT5upZel7u3B7iqMd6PJGU1WxlRn1SkXfMKrp/YdXsD
	7cSjyKQcAd338B5vRoSE8fJhRocVcVH7CE2+fPrpiZA4uAkYhWeC79hXJcOhmQ==
Date: Sun, 28 Apr 2024 13:02:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/6] slab: Introduce dedicated bucket allocator
To: Kees Cook <keescook@chromium.org>, Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, "GONG, Ruiqi"
 <gongruiqi@huaweicloud.com>, Xiu Jianfeng <xiujianfeng@huawei.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, Jann Horn <jannh@google.com>,
 Matteo Rizzo <matteorizzo@google.com>, Thomas Graf <tgraf@suug.ch>,
 Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-hardening@vger.kernel.org
References: <20240424213019.make.366-kees@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: jvoisin <julien.voisin@dustri.org>
Autocrypt: addr=julien.voisin@dustri.org; keydata=
 xsFNBFWzxaABEACu3G1fwzHtrhHuotgvZ69zA4YqF9vYfx7hoYrjnKzP5pTiOZ2US6AJj1qE
 W1WlN6cHnqzzqoXotVu/MPuPrbadL21jRnJWurrkktpcqK4BaCZ5S0lOQ3ck40LysidexhI6
 ZZi6jhBZzuzxs2Mi9aIPIxDekXAWQBybs4m27E4MNmJkIshVnDTMQ4ToGQxzwPj+VurpQVPh
 WGMCPwlUbVkN/w6N/lLC088ePpESh5E0vFE+BQc66ZpRn+cXTlaqjQnwRtWuEBoqJSn2MXAn
 wODEj4H5HvQjgFyRfmOHHMTEHOg4yyc84SmIv8YJlTbVX7VnMGUJF43SA4PFtXFypBkQ481u
 w10XdBPYwD/i0q3QnzzRiIsrlQJUCkGFxyIpcDNRnf3ApjT4+QuEaw98tKvgRzCozFx2D94w
 sSFz858vZrdYj4pt/VYw8JeoPDiWwuzPVvgpJmQlL8aCRnAhLIv9O+fySvXcGh1WEvtUgkNn
 1WjU2M00BYnPNFBEeGMRWkxuVwV1o+WKNJfwg2UcDghSkJGBCPCAiC2fDlfyk3njjLjxZHP/
 mYNwUkxTlQolzknJZ5wg7vbE6r4rfQX4gTi3mNzYtqUAb17GIczOARZK7qdSapObrXPFGgX3
 Bd4FZJEaIq3p5xWcWS8fcMveoYO7m9cyaSkSQxAPrPZE3hDF1QARAQABzTJKdWxpZW4gKGp2
 b2lzaW4pIFZvaXNpbiA8anVsaWVuLnZvaXNpbkBkdXN0cmkub3JnPsLBlwQTAQoAQQIbAwUL
 CQgHAwUVCgkICwUWAgMBAAIeAQIXgAIZARYhBJ/N7p4aOB8xHqYqdATQQegXGQHMBQJfDWXp
 BQkSV5eAAAoJEATQQegXGQHMKrwQAI8gOcx3qRk7T5qBgg9rlk3WDaJWcmw1Dq2VnjKrEVLh
 vxvwK/CjiaH4g6oUiGNeDVBoozjzKM/umHL7SoBjhHiayEu33ziAjLWxiVGbHVmHmfXkZdQz
 CEBSI1ZR8HF88tFCCOCtK7Nc+1yohmTnfnrIIEXMpSvAgdFilwnjYbaNe+aQ9MJMo+k7J144
 h+BzN5EW19zVwOidUdD0HxKpCYz6D34etnYIpv8Qa0KBzOPTtO1QYr6A7MfQPiRVlIOA543g
 h9bi9SQhCBsOZU1NOVQUZ3/ktj8qlUTVlOhGKYaPvJJ0X9va02rzL7zxYcVZgQic2dTLGYW/
 GGHVseegnxWB/7V49Yf4ZljQvjK2B1COmahZ2UYN+fzqXO0NhpSLX4SDKDnvM/3X2TYWx1MS
 fY8x4IURA633TTW9QZzflqIYk4aO44/8MDiuaxLwt+e6d8EN8ECaAoVFPCq1dWTjCJ4XhSlb
 6eV8trCpLZfkVviuRD7xPtZU1sViVSj/O9naQ2HuUq0+LuYBmI25BEpq2rkgVKS++sYgUtxO
 IP5WoQJeNNnS+8e15VRdb77WxRe6+05JNu48wZI2OcW/MiyFs+cGtoDC5mSpVuJTmpPumP7A
 hjlxy4e5YlQn6coqQcuNL1DC/vUFwO1/cnh5dqk0x5JfHL1/XFWYjsVNjuJj/vIQzsFNBFWz
 xaABEAC/p5ESSIlC6qVJnxfhtIpappjkHmFjMHWmFrB05KnmtGB/InGH0e5y2OVaKz0RErLd
 f2CAzU5zb9cyLPnqHpE7SaqtPBmahTBX7nVzIFrbjLpU/XPHaWrHa6M1ifyu1y2msXe5U1ln
 oOVjJXTVsyoNAt8wzf73I4St2+pY7kQBlv5AUTssa4T22hZs3BImcd4OsLpct2aIGd3NGofN
 ksiLB3ZiE/vKJkXWIbx9/hm8nuKlQuHGo+sHho8T+QQcc+YCo66BYBznzD+yEv/UALjgHWU/
 PXw3RVM8kqQ3WlmWsYKqQYgkaA2cVPrkbLlxiHg28Y4deu6oZR4oSovXjJk4jj3m/UckaN0f
 c47BG1VwKVHxjg/c8hy1elunhJv0Vf2eLA6pc0UfAcpSkJZNkOLjFZ9YROHdiKiUE4pEej4/
 o3WE76TIX58aURuouVAVwe14sIED3QLoO+4wczTZsOX/jcOg2D2qPquby5taOAM6yPP/v7fy
 TAG9UYdxq1L9/wKwhH1pmagkTmLu7k5XzgQ/6rrR4NJPRRMETrtqDFJNb2UxhRlnl/Cavkt6
 5BK7D0QJ9n9phFWC2oTIaMd5suFZK3I71UdeTaBOlrqmqLzuBVhzQeAK2vaJI1c6IzqjGRlx
 PEm6BuHfRWaf+LLj4Z7wrupWwAxLjHgPUCL2Chk2ZwARAQABwsF8BBgBCgAmAhsMFiEEn83u
 nho4HzEepip0BNBB6BcZAcwFAl8NaJcFCRK/pHcACgkQBNBB6BcZAcxUhg//fmeZNMlB7NPJ
 bT4dLsnSTCRAl1zqCxqowPyG4ux79qiG73KW/vLT1EUQTm4ANyl5Mwyf+3ssfzxl/Flp7i93
 57rENZRMWj80JluU8w68sUrxKlTNZfrukHttoNPmTh9TTuvP0yQXysJyy0p6VvdBT5euf2Iw
 LMERoaln4h2VuhLSL80VcJfou0TVl9Aq47HerwTPXQdC4Rm/bYrdDdZhEJMrEQuDP6eLIjmC
 4vI51LwnPcXABan3WudfEaxdpI9acwcCy9XQ32vIjhxV9D3fx0dsfo6PDXFdKEY9q+bfOjUt
 GyqZWRtqe/EWM8T1w4H4svpGpTh2mB8Du/1jNy5CiSgLiDySd6Gz8vP0rqFGYuLN1fCBNpd4
 PzF29dPO8xJ++K5pVi+pXpKzIfW9f2ZL0fabrsKP1Rht+q+3ldgGSvgw3v2aFffvEuRmodiY
 Vkby7UMuABQGlgE89z+cffBRhelgNzoVs/PtIuWb/y5BgOBGD9zUn4Z2FjB5eby230qkP1uQ
 +vyunBj6QnANa7qBxycL+xXbW8HBksArQ/HX+OZs7hagrP0qGMnjmCzsblv0wixghgvQTkpg
 61RTH34ieLUkzE0oFkrqJyNZcoH0wStdP/9zwK1Av0cZcFcvlLdIL956v4IpZozW1ScG7OJw
 766VTOg4l2PTPCnIdNFy1Os=
In-Reply-To: <20240424213019.make.366-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/24/24 23:40, Kees Cook wrote:
> Hi,
> 
> Series change history:
> 
>  v3:
>   - clarify rationale and purpose in commit log
>   - rebase to -next (CONFIG_CODE_TAGGING)
>   - simplify calling styles and split out bucket plumbing more cleanly
>   - consolidate kmem_buckets_*() family introduction patches
>  v2: https://lore.kernel.org/lkml/20240305100933.it.923-kees@kernel.org/
>  v1: https://lore.kernel.org/lkml/20240304184252.work.496-kees@kernel.org/
> 
> For the cover letter, I'm repeating commit log for patch 4 here, which has
> additional clarifications and rationale since v2:
> 
>     Dedicated caches are available for fixed size allocations via
>     kmem_cache_alloc(), but for dynamically sized allocations there is only
>     the global kmalloc API's set of buckets available. This means it isn't
>     possible to separate specific sets of dynamically sized allocations into
>     a separate collection of caches.
>     
>     This leads to a use-after-free exploitation weakness in the Linux
>     kernel since many heap memory spraying/grooming attacks depend on using
>     userspace-controllable dynamically sized allocations to collide with
>     fixed size allocations that end up in same cache.
>     
>     While CONFIG_RANDOM_KMALLOC_CACHES provides a probabilistic defense
>     against these kinds of "type confusion" attacks, including for fixed
>     same-size heap objects, we can create a complementary deterministic
>     defense for dynamically sized allocations that are directly user
>     controlled. Addressing these cases is limited in scope, so isolation these
>     kinds of interfaces will not become an unbounded game of whack-a-mole. For
>     example, pass through memdup_user(), making isolation there very
>     effective.

What does "Addressing these cases is limited in scope, so isolation
these kinds of interfaces will not become an unbounded game of
whack-a-mole." mean exactly?

>     
>     In order to isolate user-controllable sized allocations from system
>     allocations, introduce kmem_buckets_create(), which behaves like
>     kmem_cache_create(). Introduce kmem_buckets_alloc(), which behaves like
>     kmem_cache_alloc(). Introduce kmem_buckets_alloc_track_caller() for
>     where caller tracking is needed. Introduce kmem_buckets_valloc() for
>     cases where vmalloc callback is needed.
>     
>     Allows for confining allocations to a dedicated set of sized caches
>     (which have the same layout as the kmalloc caches).
>     
>     This can also be used in the future to extend codetag allocation
>     annotations to implement per-caller allocation cache isolation[1] even
>     for dynamic allocations.
Having per-caller allocation cache isolation looks like something that
has already been done in
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3c6152940584290668b35fa0800026f6a1ae05fe
albeit in a randomized way. Why not piggy-back on the infra added by
this patch, instead of adding a new API?

>     Memory allocation pinning[2] is still needed to plug the Use-After-Free
>     cross-allocator weakness, but that is an existing and separate issue
>     which is complementary to this improvement. Development continues for
>     that feature via the SLAB_VIRTUAL[3] series (which could also provide
>     guard pages -- another complementary improvement).
>     
>     Link: https://lore.kernel.org/lkml/202402211449.401382D2AF@keescook [1]
>     Link: https://googleprojectzero.blogspot.com/2021/10/how-simple-linux-kernel-memory.html [2]
>     Link: https://lore.kernel.org/lkml/20230915105933.495735-1-matteorizzo@google.com/ [3]

To be honest, I think this series is close to useless without allocation
pinning. And even with pinning, it's still routinely bypassed in the
KernelCTF
(https://github.com/google/security-research/tree/master/pocs/linux/kernelctf).

Do you have some particular exploits in mind that would be completely
mitigated by your series?

Moreover, I'm not aware of any ongoing development of the SLAB_VIRTUAL
series: the last sign of life on its thread is from 7 months ago.

> 
> After the core implementation are 2 patches that cover the most heavily
> abused "repeat offenders" used in exploits. Repeating those details here:
> 
>     The msg subsystem is a common target for exploiting[1][2][3][4][5][6]
>     use-after-free type confusion flaws in the kernel for both read and
>     write primitives. Avoid having a user-controlled size cache share the
>     global kmalloc allocator by using a separate set of kmalloc buckets.
>     
>     Link: https://blog.hacktivesecurity.com/index.php/2022/06/13/linux-kernel-exploit-development-1day-case-study/ [1]
>     Link: https://hardenedvault.net/blog/2022-11-13-msg_msg-recon-mitigation-ved/ [2]
>     Link: https://www.willsroot.io/2021/08/corctf-2021-fire-of-salvation-writeup.html [3]
>     Link: https://a13xp0p0v.github.io/2021/02/09/CVE-2021-26708.html [4]
>     Link: https://google.github.io/security-research/pocs/linux/cve-2021-22555/writeup.html [5]
>     Link: https://zplin.me/papers/ELOISE.pdf [6]
>     Link: https://syst3mfailure.io/wall-of-perdition/ [7]
> 
>     Both memdup_user() and vmemdup_user() handle allocations that are
>     regularly used for exploiting use-after-free type confusion flaws in
>     the kernel (e.g. prctl() PR_SET_VMA_ANON_NAME[1] and setxattr[2][3][4]
>     respectively).
>     
>     Since both are designed for contents coming from userspace, it allows
>     for userspace-controlled allocation sizes. Use a dedicated set of kmalloc
>     buckets so these allocations do not share caches with the global kmalloc
>     buckets.
>     
>     Link: https://starlabs.sg/blog/2023/07-prctl-anon_vma_name-an-amusing-heap-spray/ [1]
>     Link: https://duasynt.com/blog/linux-kernel-heap-spray [2]
>     Link: https://etenal.me/archives/1336 [3]
>     Link: https://github.com/a13xp0p0v/kernel-hack-drill/blob/master/drill_exploit_uaf.c [4]

What's the performance impact of this series? Did you run some benchmarks?

> 
> Thanks!
> 
> -Kees
> 
> 
> Kees Cook (6):
>   mm/slab: Introduce kmem_buckets typedef
>   mm/slab: Plumb kmem_buckets into __do_kmalloc_node()
>   mm/slab: Introduce __kvmalloc_node() that can take kmem_buckets
>     argument
>   mm/slab: Introduce kmem_buckets_create() and family
>   ipc, msg: Use dedicated slab buckets for alloc_msg()
>   mm/util: Use dedicated slab buckets for memdup_user()
> 
>  include/linux/slab.h | 44 ++++++++++++++++--------
>  ipc/msgutil.c        | 13 +++++++-
>  lib/fortify_kunit.c  |  2 +-
>  lib/rhashtable.c     |  2 +-
>  mm/slab.h            |  6 ++--
>  mm/slab_common.c     | 79 +++++++++++++++++++++++++++++++++++++++++---
>  mm/slub.c            | 14 ++++----
>  mm/util.c            | 21 +++++++++---
>  8 files changed, 146 insertions(+), 35 deletions(-)
> 


