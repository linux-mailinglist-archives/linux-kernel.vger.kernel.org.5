Return-Path: <linux-kernel+bounces-51497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCD2848BE8
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1E71C21A98
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 07:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FFAD510;
	Sun,  4 Feb 2024 07:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kXzeiZnf"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5622BA57
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 07:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707032680; cv=none; b=bilZXss3ENdGRGNWsEWrrg+FNlZ71hweFi7YI85HvoERamlLkm7ZQr3+ToBFND5WD/1QiNp/gkO5oug1kM0KjCj7cm/2nXwdTXiRxJPbJf4sG8kFdvsYczcIwdIDj+Idvi3xc8KZ7jcjV0c9Bu6YWga/WOqCm5ujRU48gd67t1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707032680; c=relaxed/simple;
	bh=KcUQS9KaviPrUiGpEwBjuSuhOXzyV6fa/aehuoXcrpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n4IHW8kwA6zsQtIAUGr0xNc6r3j3zW1KRl2N+/i/+hWjAoWKjLhVPVKf//a4MFruC52UCoJy5GiDOhXwXSuHCSv8+JXCE55Cd4iPzux6c5mTnqiyCUvQUGf3C8WZPa4FDIntuqRssGl3LNpFnk6rbVUwyORyTRfCAdye74lQEDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kXzeiZnf; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f05f658a-78fa-45cd-ad07-11d87b824702@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707032675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PYmkSyAiI8ZNFZt9h2B5b9tnwLmATn/wLxZOMDo8mKg=;
	b=kXzeiZnfqHf+rROkc2BSnppq0lJy1pPlYyZFAiXuLA07iCziWLDn0VEFbrUa74a8OrFi8T
	ZF9xku65yVr5aUqN5rs69O2TpU50pH5zjuRu1SJ70GKaEFMYMfcsPZDIK4y2kh/9W52kgq
	/cInjIwCZVYdR3kTSIkdujIh7lf8HVI=
Date: Sun, 4 Feb 2024 15:44:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] hugetlb: fix CONFIG_PADATA dependency for non-SMP
 system
To: Gang Li <gang.li@linux.dev>
Cc: Gang Li <ligang.bdlg@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Randy Dunlap <rdunlap@infradead.org>,
 kernel test robot <lkp@intel.com>
References: <20240204072525.1986626-1-gang.li@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240204072525.1986626-1-gang.li@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2024/2/4 15:25, Gang Li wrote:
> Randy Dunlap and kernel test robot reported a warning:
>
> ```
> WARNING: unmet direct dependencies detected for PADATA
>    Depends on [n]: SMP [=n]
>    Selected by [y]:
>    - HUGETLBFS [=y] && (X86 [=y] || SPARC64 || ARCH_SUPPORTS_HUGETLBFS [=n] || BROKEN [=n]) && (SYSFS [=y] || SYSCTL [=n])
> ```
>
> hugetlb parallelization depends on PADATA, and PADATA depends on SMP, so
> when the SMP config is disabled, the dependency of hugetlb on padata
> should be downgraded to single thread.
>
> Fixes: f2f635264b98 ("hugetlb: have CONFIG_HUGETLBFS select CONFIG_PADATA")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/lkml/ec5dc528-2c3c-4444-9e88-d2c48395b433@infradead.org/
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202402020454.6EPkP1hi-lkp@intel.com/
> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
> ```
> Hi Andrew, this fix patch is based on mm/mm-unstable.
> Thanks!
> ```
> ---
>   fs/Kconfig   | 2 +-
>   mm/hugetlb.c | 9 ++++++++-
>   2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 3abc107ab2fbd..f2bc73fc0417e 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -261,7 +261,7 @@ menuconfig HUGETLBFS
>   	depends on X86 || SPARC64 || ARCH_SUPPORTS_HUGETLBFS || BROKEN
>   	depends on (SYSFS || SYSCTL)
>   	select MEMFD_CREATE
> -	select PADATA
> +	select PADATA if SMP

I don't think it is a clear way to fix this. If someone want to
use PADATA in a non-SMP system, he should be carefully to handle
the non-SMP case himself. I think the better way is to make PADATA
handle the non-SMP case, I think it should be easy for it, which
could just call ->thread_fn() many times instead of creating many
threads in the non-SMP case.

Thanks.

>   	help
>   	  hugetlbfs is a filesystem backing for HugeTLB pages, based on
>   	  ramfs. For architectures that support it, say Y here and read
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index bf3d5dfb921e6..1b01b244fb50b 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3457,6 +3457,7 @@ static void __init gather_bootmem_prealloc_node(unsigned long start, unsigned lo
>   
>   static void __init gather_bootmem_prealloc(void)
>   {
> +#ifdef CONFIG_PADATA
>   	struct padata_mt_job job = {
>   		.thread_fn	= gather_bootmem_prealloc_node,
>   		.fn_arg		= NULL,
> @@ -3469,6 +3470,9 @@ static void __init gather_bootmem_prealloc(void)
>   	};
>   
>   	padata_do_multithreaded(&job);
> +#else
> +	gather_bootmem_prealloc_node(0, 0, NULL);
> +#endif
>   }
>   
>   static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
> @@ -3568,6 +3572,7 @@ static unsigned long __init hugetlb_gigantic_pages_alloc_boot(struct hstate *h)
>   
>   static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
>   {
> +#ifdef CONFIG_PADATA
>   	struct padata_mt_job job = {
>   		.fn_arg		= h,
>   		.align		= 1,
> @@ -3600,7 +3605,9 @@ static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
>   	job.max_threads	= num_node_state(N_MEMORY) * 2;
>   	job.min_chunk	= h->max_huge_pages / num_node_state(N_MEMORY) / 2;
>   	padata_do_multithreaded(&job);
> -
> +#else
> +	hugetlb_pages_alloc_boot_node(0, h->max_huge_pages, h);
> +#endif
>   	return h->nr_huge_pages;
>   }
>   


