Return-Path: <linux-kernel+bounces-57509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4539B84D9FF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAABAB242A9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB4367C7D;
	Thu,  8 Feb 2024 06:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOuzsSbB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6616467E7B;
	Thu,  8 Feb 2024 06:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707373283; cv=none; b=XGdiqL8GjrKziexXeoL4VksDSXPibPwdVffppOWuDBDwldRwdWbsBtJAdcN7Eopc2ErDzAfyFq0XRgzqYFXRe6R/svTGb07i8Gj9oHoldQnK2bqRnljsAF2bjRTt2AFgUXkG0ls3cltqLqyPoyOexj058uoqYRLhY7bcXx6P/ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707373283; c=relaxed/simple;
	bh=lD1lrtMMdOBpkeLYHTDECguSxgees/c78w0lL7yv0bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYE7gZf77QNXTKPvJtntoy9edjDckkMy2amlti7qCoPmG2IoyKDiiX8W2ub2onSBQN7wkoXZqJidNJ0EDkNDmtdON9D+wZf47cAIXrx2wYWXjfPmrZaqPfVCR/b9VOdzQt9v5mLHserrK/WQPjJdrXxJjYG3BNO3rcSajOaCBes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOuzsSbB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA67C433C7;
	Thu,  8 Feb 2024 06:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707373282;
	bh=lD1lrtMMdOBpkeLYHTDECguSxgees/c78w0lL7yv0bw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kOuzsSbB27uwSEFp6QnBBwF4c8wSiOnHMBpoT0jJuV3IEfQ/f661CpCyRQBuvLibE
	 lLQXgNR3XCQOOP5nvA2vnYrZmZkM/dZXQxbM9FSzlFF4YpKjZv+hycd+20Elp8ywEL
	 LAv0lEURquSyS6AsBFqOIDxwSjBdh4LEyqj78PHMjfRFx1Z2x+WKh2zG2BJ8sNyFaF
	 HujNOdc0xlfRqZUvzM5o9jvnfWteYJRjhw62WISYKo869NMnlPw7V7xJ1+fXv/PF/u
	 pHUOw3YaYaqgO8HS3ztmkMy9JMAmPt1+mxKkvDu4Ht04n+bkQbqIzXeGeuiFUFesQd
	 NG/ZDh6p/DJXg==
Date: Thu, 8 Feb 2024 08:20:57 +0200
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: Re: [PATCH v3 10/15] powerpc/mm: use pte_next_pfn() in set_ptes()
Message-ID: <ZcRyyTjbq8jxoPWC@kernel.org>
References: <20240129124649.189745-1-david@redhat.com>
 <20240129124649.189745-11-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129124649.189745-11-david@redhat.com>

On Mon, Jan 29, 2024 at 01:46:44PM +0100, David Hildenbrand wrote:
> Let's use our handy new helper. Note that the implementation is slightly
> different, but shouldn't really make a difference in practice.
> 
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/powerpc/mm/pgtable.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
> index a04ae4449a02..549a440ed7f6 100644
> --- a/arch/powerpc/mm/pgtable.c
> +++ b/arch/powerpc/mm/pgtable.c
> @@ -220,10 +220,7 @@ void set_ptes(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
>  			break;
>  		ptep++;
>  		addr += PAGE_SIZE;
> -		/*
> -		 * increment the pfn.
> -		 */
> -		pte = pfn_pte(pte_pfn(pte) + 1, pte_pgprot((pte)));
> +		pte = pte_next_pfn(pte);
>  	}
>  }
>  
> -- 
> 2.43.0
> 
> 

-- 
Sincerely yours,
Mike.

