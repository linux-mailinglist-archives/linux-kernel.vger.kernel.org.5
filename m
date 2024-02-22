Return-Path: <linux-kernel+bounces-75940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8893B85F0F3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4D5EB23B50
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900BACA50;
	Thu, 22 Feb 2024 05:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="XTZpY45e"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D863723A6
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 05:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708579959; cv=none; b=JJV+hKELemHafsXUrvHUCZ+CYi4FjMl371jxU4C8CaQJEL2KzxOmGnoiTnALffjQ2E4dOFQP/WpqH7XIP8KdZ8L+76RiXqKh5EEkpCxJTnPH0JZwP/Yod7M8iWWu7ElviQo2+Zipc37S84IOXd0uAh7hhQfjLfA7GQ5SJcaXGzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708579959; c=relaxed/simple;
	bh=eKqYjKFqQ2Btb3DE8AT4v8U+GE6pvTD6rZwIP1P8Biw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jIoUABWHnoInMCgU2aryi3CY0lLgE8htm3uPXyQWBTlmhwMw+zzmVQqd7mSV8AgMm7u3Y+vckiu+8HTbH3uzVFjyEybvVraqpIkmGCIBSKIs9Udin7WmvNf/aBajZiS8JVart9t1yPGN2gF5JG6Biv1odlUXaB/HUI1ZJ0W8Bag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=XTZpY45e; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1708579952;
	bh=6rZVo5FTKhXSv7psKwvcsKt6sXdGaolXZqU702i5vXc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XTZpY45e7Lwj01jfq3e25ZOBFbG475EMb2eVy9dNhJ96a2LA5kUoX35Rur0bQqG/X
	 YkCq1iIm0fBztKObwraCr3LdlbHoPbAz+nDF6rE3Op5daigKdmDhngXzgRJdqka9Ha
	 zms4iuzJv3jsIkG+9gVzpep90X+NlKRUqsvIdV1/iWHEPckjfMsAu7KjW9/zdhKVNg
	 5SSLp8wPxVET5oVttiAARf+L0FMZ6KEg39sU4yi/RUjjGbi5sE2EybKaevZT+QssG/
	 o+f95DmMmlnUaW62cdod/ck0dRWbQIR3Ix82aB6tUyZyHxv6dxzGwf7k8bUE+RG/hc
	 HBrlv+D0DQ1IA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TgMGm5vQgz4wc4;
	Thu, 22 Feb 2024 16:32:32 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Nicholas Piggin
 <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc: Refactor __kernel_map_pages()
In-Reply-To: <3656d47c53bff577739dac536dbae31fff52f6d8.1708078640.git.christophe.leroy@csgroup.eu>
References: <3656d47c53bff577739dac536dbae31fff52f6d8.1708078640.git.christophe.leroy@csgroup.eu>
Date: Thu, 22 Feb 2024 16:32:31 +1100
Message-ID: <8734tlawsw.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> __kernel_map_pages() is almost identical for PPC32 and RADIX.
>
> Refactor it.
>
> On PPC32 it is not needed for KFENCE, but to keep it simple
> just make it similar to PPC64.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 10 ----------
>  arch/powerpc/include/asm/book3s/64/radix.h   |  2 --
>  arch/powerpc/mm/book3s64/radix_pgtable.c     | 14 --------------
>  arch/powerpc/mm/pageattr.c                   | 19 +++++++++++++++++++
>  arch/powerpc/mm/pgtable_32.c                 | 15 ---------------
>  5 files changed, 19 insertions(+), 41 deletions(-)
>
> diff --git a/arch/powerpc/mm/pageattr.c b/arch/powerpc/mm/pageattr.c
> index 421db7c4f2a4..16b8d20d6ca8 100644
> --- a/arch/powerpc/mm/pageattr.c
> +++ b/arch/powerpc/mm/pageattr.c
> @@ -101,3 +101,22 @@ int change_memory_attr(unsigned long addr, int numpages, long action)
>  	return apply_to_existing_page_range(&init_mm, start, size,
>  					    change_page_attr, (void *)action);
>  }
> +
> +#if defined(CONFIG_DEBUG_PAGEALLOC) || defined(CONFIG_KFENCE)
> +#ifdef CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC
> +void __kernel_map_pages(struct page *page, int numpages, int enable)
> +{
> +	unsigned long addr = (unsigned long)page_address(page);
> +
> +	if (PageHighMem(page))
> +		return;
> +
> +	if (IS_ENABLED(CONFIG_PPC_BOOK3S_64) && !radix_enabled())
> +		hash__kernel_map_pages(page, numpages, enable);
> +	else if (enable)
> +		set_memory_p(addr, numpages);
> +	else
> +		set_memory_np(addr, numpages);
> +}

This doesn't build on 32-bit, eg. ppc32_allmodconfig:

./arch/powerpc/mm/pageattr.c: In function '__kernel_map_pages':
./arch/powerpc/mm/pageattr.c:116:23: error: implicit declaration of function 'hash__kernel_map_pages' [-Werror=implicit-function-declaration]
  116 |                 err = hash__kernel_map_pages(page, numpages, enable);
      |                       ^~~~~~~~~~~~~~~~~~~~~~

I couldn't see a nice way to get around it, so ended up with:

void __kernel_map_pages(struct page *page, int numpages, int enable)
{
	int err;
	unsigned long addr = (unsigned long)page_address(page);

	if (PageHighMem(page))
		return;

#ifdef CONFIG_PPC_BOOK3S_64
	if (!radix_enabled())
		err = hash__kernel_map_pages(page, numpages, enable);
	else
#endif
	if (enable)
		err = set_memory_p(addr, numpages);
	else
		err = set_memory_np(addr, numpages);



cheers

