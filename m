Return-Path: <linux-kernel+bounces-35097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C97A838C25
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A44288558
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1905C61E;
	Tue, 23 Jan 2024 10:34:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3015A11D;
	Tue, 23 Jan 2024 10:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706006071; cv=none; b=PfK1s9K+bGYdTZSllOi8keQAbrLZ27YZ7URUM4q0fHPwsCVYhgoPZ6VMqY3MxmyC5xq6kBEC3CoLOg+sL8i8SWAcICZdRkRjc4BL5uQy4RYqeD6LYboNimesZZOtw/KGtGy6AN09mg9afMSXrthxOTSFMdgAytJbBAfNM1Ak5D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706006071; c=relaxed/simple;
	bh=FJvfs7CYHa4toEiqJIlYVBNv0As+dQRUyxWh8ToUlaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWWzrrF1dQuUbzcP/Vubl7Wx+ZkmYRsulWN57D8epQco8QJYI0xyzk1q4wq6mus53gQNkyCN+NcjkZy2D7YS1T5XdBN0+HHF3Y4eShoKYaWFWLqo5iHCQgHRVQ7crbH1eyhALbHdlc7keLoNC2CwyXwiXJulmqPMdKX2PfKtWBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43C5E1FB;
	Tue, 23 Jan 2024 02:35:14 -0800 (PST)
Received: from [10.57.77.165] (unknown [10.57.77.165])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD0EF3F5A1;
	Tue, 23 Jan 2024 02:34:23 -0800 (PST)
Message-ID: <fdaeb9a5-d890-499a-92c8-d171df43ad01@arm.com>
Date: Tue, 23 Jan 2024 10:34:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/11] arm/pgtable: define PFN_PTE_SHIFT on arm and
 arm64
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
 <20240122194200.381241-2-david@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240122194200.381241-2-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/01/2024 19:41, David Hildenbrand wrote:
> We want to make use of pte_next_pfn() outside of set_ptes(). Let's
> simpliy define PFN_PTE_SHIFT, required by pte_next_pfn().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/arm/include/asm/pgtable.h   | 2 ++
>  arch/arm64/include/asm/pgtable.h | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
> index d657b84b6bf70..be91e376df79e 100644
> --- a/arch/arm/include/asm/pgtable.h
> +++ b/arch/arm/include/asm/pgtable.h
> @@ -209,6 +209,8 @@ static inline void __sync_icache_dcache(pte_t pteval)
>  extern void __sync_icache_dcache(pte_t pteval);
>  #endif
>  
> +#define PFN_PTE_SHIFT		PAGE_SHIFT
> +
>  void set_ptes(struct mm_struct *mm, unsigned long addr,
>  		      pte_t *ptep, pte_t pteval, unsigned int nr);
>  #define set_ptes set_ptes
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 79ce70fbb751c..d4b3bd96e3304 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -341,6 +341,8 @@ static inline void __sync_cache_and_tags(pte_t pte, unsigned int nr_pages)
>  		mte_sync_tags(pte, nr_pages);
>  }
>  
> +#define PFN_PTE_SHIFT		PAGE_SHIFT

I think this is buggy. And so is the arm64 implementation of set_ptes(). It
works fine for 48-bit output address, but for 52-bit OAs, the high bits are not
kept contigously, so if you happen to be setting a mapping for which the
physical memory block straddles bit 48, this won't work.

Today, only the 64K base page config can support 52 bits, and for this,
OA[51:48] are stored in PTE[15:12]. But 52 bits for 4K and 16K base pages is
coming (hopefully v6.9) and in this case OA[51:50] are stored in PTE[9:8].
Fortunately we already have helpers in arm64 to abstract this.

So I think arm64 will want to define its own pte_next_pfn():

#define pte_next_pfn pte_next_pfn
static inline pte_t pte_next_pfn(pte_t pte)
{
	return pfn_pte(pte_pfn(pte) + 1, pte_pgprot(pte));
}

I'll do a separate patch to fix the already broken arm64 set_ptes() implementation.

I'm not sure if this type of problem might also apply to other arches?


> +
>  static inline void set_ptes(struct mm_struct *mm,
>  			    unsigned long __always_unused addr,
>  			    pte_t *ptep, pte_t pte, unsigned int nr)


