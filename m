Return-Path: <linux-kernel+bounces-57507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C233284D9F9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E01C282D96
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551A467C7B;
	Thu,  8 Feb 2024 06:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOPbdVla"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97333679FB;
	Thu,  8 Feb 2024 06:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707373234; cv=none; b=oGGLngUKzb4uUCF8MnNS6GTBL2jyiN9Ap3955R/uQd23GuWPWFcUrSt0cXFqpAdq1nrprsm3Qovhwu9/xFqsIB7mO5UxNP7zEIaVtPJCCoMkg+08VQlQLljbQ7mLWjVsItXOr+A12Hx2+DY8P/gh/siw0Hs/dammtMOAQSOmThc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707373234; c=relaxed/simple;
	bh=7wP0q4tFEy5WW95c3el7rqakiH4FhWwfyKIVHhjI1XU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOsuH8VtQTDo0X8CcXb0YhAEuHauB9OIsrTIepseRjcMhiQbr3W8N/zW4XWcZ8kJsbCMDcEHpDIDSpStu1sTlBSXB35/DyEVEReCC8cXByXakTGE/fCg9tGNGSQrAtYmrxKkYtU3KnWDSL8MLluGfMeWbe4AmRKShX9G1DZuy+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOPbdVla; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F51C433C7;
	Thu,  8 Feb 2024 06:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707373234;
	bh=7wP0q4tFEy5WW95c3el7rqakiH4FhWwfyKIVHhjI1XU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sOPbdVlaZ3j/34dFxXa4vB+wTlOrsQtoASWw+x3+65jJdyyCZoBVCQttsp96W2s7h
	 +dA1wJ8Ez9ve5rimAhiY5/4mPY3ZzWQwsKvTsF8Cxkf1yL7WeETY3nbsyR+7vIMF8Q
	 GuW4dxu/JPlWiqXJs/DKi3m2ES/5EmCcjon1rqH0D/VCX6tV4q7cOK3KzzTX7qrvVd
	 SaM/kU/bAIRKAwb3SSP5QVrWdMzjitoySDGdjiasABQyDO4rXXsC3R9hRw7viriNL9
	 SVm1OEQ8+qwo3As8rwgD9NWsvKsOyP5hEKMltiXMj0Y+3MHGqcNEYmdsehVkRtlm8W
	 KYecGRtEzfD7A==
Date: Thu, 8 Feb 2024 08:20:09 +0200
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
Subject: Re: [PATCH v3 09/15] arm/mm: use pte_next_pfn() in set_ptes()
Message-ID: <ZcRymY35KnPAuuzY@kernel.org>
References: <20240129124649.189745-1-david@redhat.com>
 <20240129124649.189745-10-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129124649.189745-10-david@redhat.com>

On Mon, Jan 29, 2024 at 01:46:43PM +0100, David Hildenbrand wrote:
> Let's use our handy helper now that it's available on all archs.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/arm/mm/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 674ed71573a8..c24e29c0b9a4 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -1814,6 +1814,6 @@ void set_ptes(struct mm_struct *mm, unsigned long addr,
>  		if (--nr == 0)
>  			break;
>  		ptep++;
> -		pte_val(pteval) += PAGE_SIZE;
> +		pteval = pte_next_pfn(pteval);
>  	}
>  }
> -- 
> 2.43.0
> 
> 

-- 
Sincerely yours,
Mike.

