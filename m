Return-Path: <linux-kernel+bounces-57506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8C184D9F3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3FF283298
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D29067C79;
	Thu,  8 Feb 2024 06:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfNiMFha"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A14692F9;
	Thu,  8 Feb 2024 06:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707373192; cv=none; b=nfP/6RHbCRGNTtM0m/UHS9p2PnAsO2h6r7r0A2kkT/RH4oaA8OS7ePZpSGMr2klPsmrs19NnJx2CfNNjdYr6v6Uv/O0vomDxHKX4wZh2mixbMabXfvApuyaF05GSYQVbiQrMHICgKgosA3NKkBtajo+WJN9j708NEBGv3Yf7uC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707373192; c=relaxed/simple;
	bh=nxciaXphWmGCQZgRp+6AraxUwzLXbBBeY7cwt8JPcBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0FdlBZEj3OWo+WcB5WMHtNTRCYFUP57NMuEianEiy1bDq+aQ9TLbVBLHPsaCnA67ggDEndjzkqAUvDoDFp2Yoc+FIYJPISDI3vlJ2QFYUMGTOEu+gQP/nf6yIhSa2uHF7+wzHG2Sw40lgGUS4KaKNqUOiKdqiS3la36sx1q+1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfNiMFha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2B9C433C7;
	Thu,  8 Feb 2024 06:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707373191;
	bh=nxciaXphWmGCQZgRp+6AraxUwzLXbBBeY7cwt8JPcBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dfNiMFhazIYH10xRr5CgSsEUKx1/MHtqdKR5dLOtoLSCnzVdAATtU7nxrVFXM4BpC
	 gCGwotvDn7ACXKus06eXzj+eZFYm9wAopITxFL8a8tezWcb5Lap0xHbr493kIoHncD
	 Ji8m2xjisvxTYwQzAoYpx49/a9Zp+h1Kt+4N1ta6uMLLzeAGNNcMHTSIzdp5pDP730
	 wyrBnBWla/DtCF/gympbDZ+QYOcvjC5PLvCSqHgYCqiQyCQdmHKGPyxvZv6QkTBUnH
	 M9Idx2TB81kcYGZKOss9xP7XeuY91FZ5wUyl1ETidkY4l1k3mGk5EtF84qqV9GR0PD
	 xUtpEa/HDCbrA==
Date: Thu, 8 Feb 2024 08:19:27 +0200
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
Subject: Re: [PATCH v3 08/15] mm/pgtable: make pte_next_pfn() independent of
 set_ptes()
Message-ID: <ZcRyb2o_lq2XITH_@kernel.org>
References: <20240129124649.189745-1-david@redhat.com>
 <20240129124649.189745-9-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129124649.189745-9-david@redhat.com>

On Mon, Jan 29, 2024 at 01:46:42PM +0100, David Hildenbrand wrote:
> Let's provide pte_next_pfn(), independently of set_ptes(). This allows for
> using the generic pte_next_pfn() version in some arch-specific set_ptes()
> implementations, and prepares for reusing pte_next_pfn() in other context.
> 
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  include/linux/pgtable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index f6d0e3513948..351cd9dc7194 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -212,7 +212,6 @@ static inline int pmd_dirty(pmd_t pmd)
>  #define arch_flush_lazy_mmu_mode()	do {} while (0)
>  #endif
>  
> -#ifndef set_ptes
>  
>  #ifndef pte_next_pfn
>  static inline pte_t pte_next_pfn(pte_t pte)
> @@ -221,6 +220,7 @@ static inline pte_t pte_next_pfn(pte_t pte)
>  }
>  #endif
>  
> +#ifndef set_ptes
>  /**
>   * set_ptes - Map consecutive pages to a contiguous range of addresses.
>   * @mm: Address space to map the pages into.
> -- 
> 2.43.0
> 
> 

-- 
Sincerely yours,
Mike.

