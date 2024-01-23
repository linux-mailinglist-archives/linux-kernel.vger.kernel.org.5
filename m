Return-Path: <linux-kernel+bounces-35125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F262838C75
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACC21B234F5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DBA5C914;
	Tue, 23 Jan 2024 10:47:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDA55C8F3;
	Tue, 23 Jan 2024 10:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706006865; cv=none; b=kkhKIPT+1dJZ4hb055kXbGJMwIWzb4EKVWtloGmuaq2Sx6YkjTWVRp+nNzhMLpd8KgTf+TAG1ZGsNkewTm5NqEcFPHDtWiH8ZpMP4NIYX0s1FUz6XkdyS4kqlIuRQjcH+UZvQAEKiZzBPvsIrSTUpr2rudhJecnfJ1f/6koLCkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706006865; c=relaxed/simple;
	bh=XdCg3Fl5iCQH7oD4ZD7hlyaOXUB+y8vwYJ2Nw8dx7B4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DAQ8uI+WHY4t0b7Hm64oqnWBXn759xXkYKnYbj2fkpo8ZfJFxYbYioNtuBkE9zyjYZZtnFmTjXhhtwKNU7TFAijQkgI4y/AR/aSacKl3f6WJOQlalI1fRJEJ7iCgKYcPVkq+NbZdkhSPv59Zu5TdsfZBDDmXxDjFzNFIwK3omA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A3EA1FB;
	Tue, 23 Jan 2024 02:48:28 -0800 (PST)
Received: from [10.57.77.165] (unknown [10.57.77.165])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F16A33F5A1;
	Tue, 23 Jan 2024 02:47:37 -0800 (PST)
Message-ID: <26286ea5-2781-4e70-b52b-f8a44a1b1407@arm.com>
Date: Tue, 23 Jan 2024 10:47:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/11] mm/memory: pass PTE to copy_present_pte()
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Dinh Nguyen <dinguyen@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S. Miller"
 <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
References: <20240122194200.381241-1-david@redhat.com>
 <20240122194200.381241-9-david@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240122194200.381241-9-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/01/2024 19:41, David Hildenbrand wrote:
> We already read it, let's just forward it.
> 
> This patch is based on work by Ryan Roberts.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  mm/memory.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 2aa2051ee51d3..185b4aff13d62 100644
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
> @@ -1104,7 +1103,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>  		}
>  		/* copy_present_pte() will clear `*prealloc' if consumed */
>  		ret = copy_present_pte(dst_vma, src_vma, dst_pte, src_pte,
> -				       addr, rss, &prealloc);
> +				       ptent, addr, rss, &prealloc);
>  		/*
>  		 * If we need a pre-allocated page for this pte, drop the
>  		 * locks, allocate, and try again.


