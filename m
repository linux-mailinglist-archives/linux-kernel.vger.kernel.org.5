Return-Path: <linux-kernel+bounces-74685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C20D285D7B3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA6A51C215B6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2CD4E1C8;
	Wed, 21 Feb 2024 12:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="LN3beWz7"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7EB4E1A2
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708517394; cv=none; b=OJKEYttN28G3g1mr1HIehWqKvKTncBrE6wxeadlxugSOLJ1WKiTqqSbOykOVFyYHiQhn4zFFaCcxGyjhOTjjLtc2gZcBFqsFxLniTodcY/QqPE4vU0yOZ+EbxGy9v/h7bI4N3AmYq3ESa1alZRo70pVgnwema8sns4DWtXsC6yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708517394; c=relaxed/simple;
	bh=bdbLCKE7g0+66MpcSh4hmpkman0aHyydQ8cY0Eti/WU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S1C9Xe4YXtUnZ+oql3y0wm2O8DBEOmG90dYfjA49FAGCt6kFQO/oRFXPvbYTggGg9hOW/BPmN7rhhw5p69m8JMokyAMUbjz2U8c8Mx0TQ0LusZCD6xKJxin3y3r1rWdvBgU/KbnCkeinKVo1eJshJ6m2D2DBS5zdYWUJvuBAJwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=LN3beWz7; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1708517388;
	bh=PLDtI67f/xui7jHsmCWFGzmJCY6GWA6bDHlnXiY857Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LN3beWz7/pvuDSRvRn77DI/Hme3p4aKDtAhHswqCONrhYqaIbh4nmPvEoPxzT8tCJ
	 8S83csJ/yXkEWtKoJzMY5JUyOavAcBiKRN2bGz6MttMbAtJWaoC66G4SgFCALXKJtw
	 z8l3G4iW/RobmgNITGAdNPVZAwTtFHsTAcWA5kSEWS4rifBIeAv7FdOIANX91B2Wvl
	 vLQUbUwKwfJXXLimfpBRIKXtVz5ejhkmYKOrYVwrNEsQBcIoFk0knvXRjvkOkpZBjQ
	 ErJlzzhyYBhNqyPh4NuamqhPE0hPYarQh4KSGcHkUOdZYn/EQGh8XMyibmKIeZket/
	 xpOop9pvvHT6g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tfw7c2P1Tz4wbp;
	Wed, 21 Feb 2024 23:09:45 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Nicholas Piggin
 <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc: Don't ignore errors from set_memory_{n}p()
 in __kernel_map_pages()
In-Reply-To: <20ef75884aa6a636e8298736f3d1056b0793d3d9.1708078640.git.christophe.leroy@csgroup.eu>
References: <3656d47c53bff577739dac536dbae31fff52f6d8.1708078640.git.christophe.leroy@csgroup.eu>
 <20ef75884aa6a636e8298736f3d1056b0793d3d9.1708078640.git.christophe.leroy@csgroup.eu>
Date: Wed, 21 Feb 2024 23:09:43 +1100
Message-ID: <878r3eauig.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> set_memory_p() and set_memory_np() can fail.
>
> As mentioned in linux/mm.h:
>
> /*
>  * To support DEBUG_PAGEALLOC architecture must ensure that
>  * __kernel_map_pages() never fails
>  */
>
> So panic in case set_memory_p() or set_memory_np() fail
> in __kernel_map_pages().
>
> Link: https://github.com/KSPP/linux/issues/7
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/book3s/64/hash.h |  2 +-
>  arch/powerpc/mm/book3s64/hash_utils.c     |  3 ++-
>  arch/powerpc/mm/pageattr.c                | 10 +++++++---
>  3 files changed, 10 insertions(+), 5 deletions(-)
>
..
> diff --git a/arch/powerpc/mm/pageattr.c b/arch/powerpc/mm/pageattr.c
> index 16b8d20d6ca8..62b678585878 100644
> --- a/arch/powerpc/mm/pageattr.c
> +++ b/arch/powerpc/mm/pageattr.c
> @@ -106,17 +106,21 @@ int change_memory_attr(unsigned long addr, int numpages, long action)
>  #ifdef CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC
>  void __kernel_map_pages(struct page *page, int numpages, int enable)
>  {
> +	int err;
>  	unsigned long addr = (unsigned long)page_address(page);
>  
>  	if (PageHighMem(page))
>  		return;
>  
>  	if (IS_ENABLED(CONFIG_PPC_BOOK3S_64) && !radix_enabled())
> -		hash__kernel_map_pages(page, numpages, enable);
> +		err = hash__kernel_map_pages(page, numpages, enable);
>  	else if (enable)
> -		set_memory_p(addr, numpages);
> +		err = set_memory_p(addr, numpages);
>  	else
> -		set_memory_np(addr, numpages);
> +		err = set_memory_np(addr, numpages);
> +
> +	if (err)
> +		panic("%s: set_memory_%sp() failed\n", enable ? "" : "n");

This doesn't compile, it's missing __func__ I guess.

Seems like we could keep it simpler though, it should hopefully never
happen anyway, eg:

  panic("%s: changing memory protections failed\n", __func__);


cheers

