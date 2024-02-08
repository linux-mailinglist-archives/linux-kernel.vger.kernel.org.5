Return-Path: <linux-kernel+bounces-57522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D41784DA1A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1DF7B23E41
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDC367E73;
	Thu,  8 Feb 2024 06:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOdTKonu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFFE67E6D;
	Thu,  8 Feb 2024 06:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707373670; cv=none; b=jSwUVEh2Ms6exM0wyfiVS90cl6P2KD+AtPJcc3OyUq5rPol2tvsdZtCZTSruWcQ6JtcAH+Odybr7HKPdWS94MfxINzIm9n7mh44saiuqmtBEZU2VKH3eWSYwOzasLSaI78FjvFgQnW8UGQozqOI77h0Qh1jf7jQeNz0JwPrjoz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707373670; c=relaxed/simple;
	bh=wxaBvjOQruR4Ppe5iBXVeEd+wF2Ez98jfGSuez99hUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y97S4/GTdI9O/oIF7I6BdCcqn+ceDEg17J/c5cHoki1ccmU8Nup2YVmxuNIN7dOqfZCGP0k3LNGillBV1Hn7CKg3lEL5J39/aEE951DVQEvRIvanDd5KWAKNJDjperBcmH7sXQqLAdXBj052zDPMo1tm/SUlZHKcx8hFl/7Xv/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOdTKonu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0D4C433C7;
	Thu,  8 Feb 2024 06:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707373669;
	bh=wxaBvjOQruR4Ppe5iBXVeEd+wF2Ez98jfGSuez99hUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kOdTKonuPOHT47MMueyUa62BOnNiiM/wNlezDtex/q6A6C+C0/4I75w1hs6HgvTcM
	 6hzU/xNlN2o7mllZJQrfNN8OS6yllsdwkypMwhdT9Zppi/oCLVm5oi0rjh8531W++l
	 VyhzaLbe16SPL0h9xcRPSV+cCkOkyBpKxf4y5KkH108vuZcpzPDikPbUG6HlcbyEC6
	 jTwJS9vdlSE+DGYuaJ63tvvk0g/PUUXVgtbv8Zylz7Hox9kBt886iEEM3kege/8EOf
	 NJ+pl0uRULV4iQ598Nv8XuegThQZaF4ao5iEmjzKtdYeRjwmfPMTOqKkZ7RotF7fHW
	 dTB19Ug9MhA4w==
Date: Thu, 8 Feb 2024 08:27:24 +0200
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
Subject: Re: [PATCH v3 12/15] mm/memory: pass PTE to copy_present_pte()
Message-ID: <ZcR0TF5d75ucLjBm@kernel.org>
References: <20240129124649.189745-1-david@redhat.com>
 <20240129124649.189745-13-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129124649.189745-13-david@redhat.com>

On Mon, Jan 29, 2024 at 01:46:46PM +0100, David Hildenbrand wrote:
> We already read it, let's just forward it.
> 
> This patch is based on work by Ryan Roberts.
> 
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  mm/memory.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index a3bdb25f4c8d..41b24da5be38 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -959,10 +959,9 @@ static inline void __copy_present_pte(struct vm_area_struct *dst_vma,
>   */
>  static inline int
>  copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
> -		 pte_t *dst_pte, pte_t *src_pte, unsigned long addr, int *rss,
> -		 struct folio **prealloc)
> +		 pte_t *dst_pte, pte_t *src_pte, pte_t pte, unsigned long addr,
> +		 int *rss, struct folio **prealloc)
>  {
> -	pte_t pte = ptep_get(src_pte);
>  	struct page *page;
>  	struct folio *folio;
>  
> @@ -1103,7 +1102,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>  		}
>  		/* copy_present_pte() will clear `*prealloc' if consumed */
>  		ret = copy_present_pte(dst_vma, src_vma, dst_pte, src_pte,
> -				       addr, rss, &prealloc);
> +				       ptent, addr, rss, &prealloc);
>  		/*
>  		 * If we need a pre-allocated page for this pte, drop the
>  		 * locks, allocate, and try again.
> -- 
> 2.43.0
> 
> 

-- 
Sincerely yours,
Mike.

