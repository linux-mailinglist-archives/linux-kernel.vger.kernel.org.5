Return-Path: <linux-kernel+bounces-63721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1C785339C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F7331C22320
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B72058AC5;
	Tue, 13 Feb 2024 14:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HDPjwyQq"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A02757884
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707835943; cv=none; b=oufHmSkfX9EyDbJuCP5Yi134XZzIIQ2CbsfeQWP98wEpcUhkgqTeWqbS3f8LfzgLWXxiDWMErFFqJ62HbIlaBi4ouWJ1UfuZt3CKwLcGyoLZJfm7MK7DU+g6BzEOkbvU9bItbq9INofmtMS6zCX/SgjWfERN0lJGFUkJ0U0BRQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707835943; c=relaxed/simple;
	bh=4Qwjb6ZrAdOSeTS+D+f4Gq6FIh461czGIAR2cjNXXCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WzTGd8be+t3NWJDBfudhi2QFtU49zvE8omtJsXGAJqzejcR2ZBWZcrtdQg8u7nBouiAdX2jShBWBkpjI5vLpRba71+wlijeUPSKHLYSgokfSFk6EmvFm+I21VRERNbTvnlaWy5LDUZnilYYkyzcAdxFuemBk47C8jNJKjB8disE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HDPjwyQq; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <89b3bee3-5ee3-4b75-99e3-881b759e79de@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707835938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7kiEddb6ZgbgAcQqtUc29c6kM6P5RdAUD0eQtc6YWJ4=;
	b=HDPjwyQqT5PKJchEPXB/BV8P4RY1AAtmjjCldRRg1f38Fa/Z2tJE0lRhLTsJhJaYTHeVxK
	zFArtqla2pFR+9kJKEqOM9UsIxtOdKxak7k1dmXdR0HuV7NGK9rcDeyrZw5Vi5JtGs0jTj
	s7DVNIufZ5xLN+8zHG3w2+FIQdH4txk=
Date: Tue, 13 Feb 2024 22:52:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 1/2] padata: downgrade padata_do_multithreaded to
 serial execution for non-SMP
To: Gang Li <gang.li@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Daniel Jordan <daniel.m.jordan@oracle.com>, Jane Chu <jane.chu@oracle.com>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, kernel test robot <lkp@intel.com>,
 Gang Li <ligang.bdlg@bytedance.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240213111347.3189206-1-gang.li@linux.dev>
 <20240213111347.3189206-2-gang.li@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240213111347.3189206-2-gang.li@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2024/2/13 19:13, Gang Li wrote:
> Randy Dunlap and kernel test robot reported a warning:
>
> ```
> WARNING: unmet direct dependencies detected for PADATA
>    Depends on [n]: SMP [=n]
>    Selected by [y]:
>    - HUGETLBFS [=y] && (X86 [=y] || SPARC64 || ARCH_SUPPORTS_HUGETLBFS [=n] || BROKEN [=n]) && (SYSFS [=y] || SYSCTL [=n])
> ```
>
> hugetlb parallelization depends on PADATA, and PADATA depends on SMP.
>
> PADATA consists of two distinct functionality: One part is
> padata_do_multithreaded which disregards order and simply divides
> tasks into several groups for parallel execution. Hugetlb
> init parallelization depends on padata_do_multithreaded.
>
> The other part is composed of a set of APIs that, while handling data in
> an out-of-order parallel manner, can eventually return the data with
> ordered sequence. Currently Only `crypto/pcrypt.c` use them.
>
> All users of PADATA of non-SMP case currently only use
> padata_do_multithreaded. It is easy to implement a serial one in
> include/linux/padata.h. And it is not necessary to implement another
> functionality unless the only user of crypto/pcrypt.c does not depend on
> SMP in the future.
>
> Fixes: a2cefb08be66 ("hugetlb: have CONFIG_HUGETLBFS select CONFIG_PADATA")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/lkml/ec5dc528-2c3c-4444-9e88-d2c48395b433@infradead.org/
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202402020454.6EPkP1hi-lkp@intel.com/
> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
> ---
>   fs/Kconfig             |  2 +-
>   include/linux/padata.h | 13 +++++++++----
>   2 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 4a51331f172e5..7963939592d70 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -261,7 +261,7 @@ menuconfig HUGETLBFS
>   	depends on X86 || SPARC64 || ARCH_SUPPORTS_HUGETLBFS || BROKEN
>   	depends on (SYSFS || SYSCTL)
>   	select MEMFD_CREATE
> -	select PADATA
> +	select PADATA if SMP

I'd like to drop this dependence since HugeTLB does not depend
on PADATA anymore. If some users take care about the kernel
image size, it also can disable PADATA individually.

>   	help
>   	  hugetlbfs is a filesystem backing for HugeTLB pages, based on
>   	  ramfs. For architectures that support it, say Y here and read
> diff --git a/include/linux/padata.h b/include/linux/padata.h
> index 8f418711351bc..7b84eb7d73e7f 100644
> --- a/include/linux/padata.h
> +++ b/include/linux/padata.h
> @@ -180,10 +180,6 @@ struct padata_instance {
>   
>   #ifdef CONFIG_PADATA
>   extern void __init padata_init(void);
> -#else
> -static inline void __init padata_init(void) {}
> -#endif
> -
>   extern struct padata_instance *padata_alloc(const char *name);
>   extern void padata_free(struct padata_instance *pinst);
>   extern struct padata_shell *padata_alloc_shell(struct padata_instance *pinst);
> @@ -194,4 +190,13 @@ extern void padata_do_serial(struct padata_priv *padata);
>   extern void __init padata_do_multithreaded(struct padata_mt_job *job);
>   extern int padata_set_cpumask(struct padata_instance *pinst, int cpumask_type,
>   			      cpumask_var_t cpumask);
> +#else
> +static inline void __init padata_init(void) {}
> +static inline void __init padata_do_multithreaded(struct padata_mt_job *job)
> +{
> +	if (job->size)

I think we could drop this check, at least now there is no users will
pass a zero of ->size to this function, and even if someone does in the
future, I think it is really a corner case, it is unnecessary to optimize
it and ->thread_fn is supporsed to handle case of zero size if it dose
pass a zero size.

Thanks.

> +		job->thread_fn(job->start, job->start + job->size, job->fn_arg);
> +}
> +#endif
> +
>   #endif


