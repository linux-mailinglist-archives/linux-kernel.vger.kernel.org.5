Return-Path: <linux-kernel+bounces-159523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 349588B2FC2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D81128430C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1D513A3EC;
	Fri, 26 Apr 2024 05:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9U1FN/2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBF91849;
	Fri, 26 Apr 2024 05:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714109709; cv=none; b=i0TyRNldMASKg9XKHzL/rmXAArvegyTrJImjf7Ijze5cQxoD7qNMuJqxc1jLsb9z67i+G+DHvvWlyAYd8d8o8+ETpJ9THkGVRY5wlfImjdQKML+Ssft8lpkePiaBdxQ5Q/rs+8JDlhA+Il8/yQYNfp19v5hC/1DfsLDrULTPQdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714109709; c=relaxed/simple;
	bh=1WCFz9g7vTUTNKQ3TiTEs820xuQE/CC/C1Y28k+/o60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWiHq+sUaKDg/klaEmVG2ck8Dcr+YtCOnck7KEi+lj1NvleJPSh1yAOt40MWxicZVbXNBBTYNrjSMnomlHXBFhgwW2tJdaWCKkBfGhqJ+lY0j+IFDPrPMVy9Rc848dgmOAfbQXHI7oljub8Z7ComCDvEXTLelMsftu15commrM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9U1FN/2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F1DC113CD;
	Fri, 26 Apr 2024 05:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714109709;
	bh=1WCFz9g7vTUTNKQ3TiTEs820xuQE/CC/C1Y28k+/o60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D9U1FN/20RXfKopPasfFAShCCrhI3NZlsOg+C2eP02+0f+PVfhCFII+xKjnSQlGiA
	 WDtJWv9d9PJoPXD6bMntp9AlPegnDBvKFHnValE1Slnn1GwGwkCbfyChnxSq4pf8IS
	 IlIGbt3gh+bI7cmVaw6gZ10KEhToTg0YZ2qcGa/9+EU2l5v52L6oalNAdhS0TSe6u/
	 0Kk7MZA1SmDJrP5HU7QISnArPbpTRD6P3/7KuAUDPEm/TRiSA0Ufnoe5QEptNkmw1X
	 3g5D8qANo93l/o0OFPibSM8NgVzIy9w9G2/ZcjTfejylb25AXON8HJnIb593qoAXRt
	 jM7RBaqkgkRqw==
Date: Fri, 26 Apr 2024 08:33:47 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] riscv: fix overlap of allocated page and PTR_ERR
Message-ID: <Zis8u5qiewKqNzfs@kernel.org>
References: <20240425115201.3044202-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240425115201.3044202-1-namcao@linutronix.de>

On Thu, Apr 25, 2024 at 01:52:01PM +0200, Nam Cao wrote:
> On riscv32, it is possible for the last page in virtual address space
> (0xfffff000) to be allocated. This page overlaps with PTR_ERR, so that
> shouldn't happen.
> 
> There is already some code to ensure memblock won't allocate the last page.
> However, buddy allocator is left unchecked.
> 
> Fix this by reserving physical memory that would be mapped at virtual
> addresses greater than 0xfffff000.
> 
> Reported-by: Björn Töpel <bjorn@kernel.org>
> Closes: https://lore.kernel.org/linux-riscv/878r1ibpdn.fsf@all.your.base.are.belong.to.us
> Fixes: 76d2a0493a17 ("RISC-V: Init and Halt Code")
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Cc: <stable@vger.kernel.org>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/riscv/mm/init.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 968761843203..7c985435b3fc 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -235,18 +235,19 @@ static void __init setup_bootmem(void)
>  		kernel_map.va_pa_offset = PAGE_OFFSET - phys_ram_base;
>  
>  	/*
> -	 * memblock allocator is not aware of the fact that last 4K bytes of
> -	 * the addressable memory can not be mapped because of IS_ERR_VALUE
> -	 * macro. Make sure that last 4k bytes are not usable by memblock
> -	 * if end of dram is equal to maximum addressable memory.  For 64-bit
> -	 * kernel, this problem can't happen here as the end of the virtual
> -	 * address space is occupied by the kernel mapping then this check must
> -	 * be done as soon as the kernel mapping base address is determined.
> +	 * Reserve physical address space that would be mapped to virtual
> +	 * addresses greater than (void *)(-PAGE_SIZE) because:
> +	 *  - This memory would overlap with ERR_PTR
> +	 *  - This memory belongs to high memory, which is not supported
> +	 *
> +	 * This is not applicable to 64-bit kernel, because virtual addresses
> +	 * after (void *)(-PAGE_SIZE) are not linearly mapped: they are
> +	 * occupied by kernel mapping. Also it is unrealistic for high memory
> +	 * to exist on 64-bit platforms.
>  	 */
>  	if (!IS_ENABLED(CONFIG_64BIT)) {
> -		max_mapped_addr = __pa(~(ulong)0);
> -		if (max_mapped_addr == (phys_ram_end - 1))
> -			memblock_set_current_limit(max_mapped_addr - 4096);
> +		max_mapped_addr = __va_to_pa_nodebug(-PAGE_SIZE);
> +		memblock_reserve(max_mapped_addr, (phys_addr_t)-max_mapped_addr);
>  	}
>  
>  	min_low_pfn = PFN_UP(phys_ram_base);
> -- 
> 2.39.2
> 

-- 
Sincerely yours,
Mike.

