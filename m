Return-Path: <linux-kernel+bounces-66774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9835C856159
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5448A28339B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA8169970;
	Thu, 15 Feb 2024 11:20:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF221754B
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996029; cv=none; b=hbJPM3vdW77NP9IAoFztzzYDEW198WZ6sMtLZ9yIttnRzt/gAW4sb1Fk4Tr6HlXK61daTISA7PkHwl3U+xfvPCcEvu4x2YCzKI7TYSJSvc/aXKtbSxE/1Cq4qhcB7boN2QLrYBl/uNt9lBqb6UnNe/XSUUrbuAqZ/iAXQdyfmYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996029; c=relaxed/simple;
	bh=ERm7crb8AKRDzU3t/QbI3t84e5YD5OM9MQl25WQ8QDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDwZ1bUR6KRlM/7OnYybfzddBQR21v4D/HyzCxqDXLwrj2VRuMNAv7u34IsSJutumhgpOaIUW79nVqBdP01OX1mkx+iMPbQ5Z295Ggj0dMLLoZ4LVdfiQiimQGx5wFh6gbZrTjzVQGTNsCtYk2cdCFDfNcCB9+lAP3Rg72Eb4xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 816FD150C;
	Thu, 15 Feb 2024 03:21:08 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.68.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 045423F7B4;
	Thu, 15 Feb 2024 03:20:23 -0800 (PST)
Date: Thu, 15 Feb 2024 11:20:21 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
	Barry Song <21cnbao@gmail.com>,
	Alistair Popple <apopple@nvidia.com>,
	Yang Shi <shy828301@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 09/18] arm64/mm: Convert ptep_clear() to
 ptep_get_and_clear()
Message-ID: <Zc3zdawsMCsEb9Q4@FVFF77S0Q05N>
References: <20240215103205.2607016-1-ryan.roberts@arm.com>
 <20240215103205.2607016-10-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215103205.2607016-10-ryan.roberts@arm.com>

On Thu, Feb 15, 2024 at 10:31:56AM +0000, Ryan Roberts wrote:
> ptep_clear() is a generic wrapper around the arch-implemented
> ptep_get_and_clear(). We are about to convert ptep_get_and_clear() into
> a public version and private version (__ptep_get_and_clear()) to support
> the transparent contpte work. We won't have a private version of
> ptep_clear() so let's convert it to directly call ptep_get_and_clear().
> 
> Tested-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/mm/hugetlbpage.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 27f6160890d1..48e8b429879d 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -229,7 +229,7 @@ static void clear_flush(struct mm_struct *mm,
>  	unsigned long i, saddr = addr;
>  
>  	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
> -		ptep_clear(mm, addr, ptep);
> +		ptep_get_and_clear(mm, addr, ptep);
>  
>  	flush_tlb_range(&vma, saddr, addr);
>  }
> -- 
> 2.25.1
> 

