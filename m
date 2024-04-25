Return-Path: <linux-kernel+bounces-158564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 841398B2217
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25A021F244D9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09AA149C61;
	Thu, 25 Apr 2024 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkcNfV3L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206E0149C54;
	Thu, 25 Apr 2024 12:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714049897; cv=none; b=Em9dE7PRjnt/utif5oOdVx1gTkVQ623oDVsbbjKWdv9gdDKJyVewovpw6ebn4H3t777/rclrIgt4fhQndkJ2K1sBkabAaVoEjF7aBdtYPuLrQ6Az0yC/YyDOgHnevK4iP+ySjEHUsHqZPaQX9bJ1MMn6jk6fSguediDloZLmNwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714049897; c=relaxed/simple;
	bh=JyQm9VGmJkZTxCcFWAIKfFZx/qAJNcE1EJUqGNLUBZc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CDcVursr0N6MuFXRB0fMbbSXbgOVPEBweG3sYnqTwnu/k+mOs/BA7hUzBonZZtMS4tCZwocoX/Xi6mIlsXr7BjDMFdRatYG2ZgFxQTynzck6az+TDpFiLj9TTT5DQdP0QQuoNyZLfcccBXqeMFFqrEdbu9GjxPwAJhy2hCozFgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkcNfV3L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B1DC113CC;
	Thu, 25 Apr 2024 12:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714049896;
	bh=JyQm9VGmJkZTxCcFWAIKfFZx/qAJNcE1EJUqGNLUBZc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PkcNfV3LVD62NBTVN5zwqCBk8/ewv7iodL7F3a/SAIaUh2T5MMh0bSJooF51j5UEz
	 MP4G6fU64nvIX49BeQBIFPQnXuTs0bghJGDbrwZBxWyyEX7G2zx58jfsCsjNKJQbbO
	 EGUnKZrlA7r1Fn8SKH5AsnFGlKbOb1XfaBx/ogxkjSH3I6iBa96oRkIFBCbYaTv0zf
	 JUkyQK94PZIc2XeMiNRmEi+tEL1U5IbrZ8YORU1Uk5xxOGwKYE3CKY58tAp+/fNpQh
	 wKQqkNnLZges1L9IoV/SBAfR9BKWuZpy+IOIxVAjXw8TKEJgGD0Nhmz+tyDSfTCoLC
	 dhfx0rfL12Kgw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Nam Cao <namcao@linutronix.de>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>, Andrew
 Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Sami
 Tolvanen <samitolvanen@google.com>, Chen Jiahao <chenjiahao16@huawei.com>,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, rppt@kernel.org
Cc: Nam Cao <namcao@linutronix.de>, stable@vger.kernel.org
Subject: Re: [PATCH] riscv: fix overlap of allocated page and PTR_ERR
In-Reply-To: <20240425115201.3044202-1-namcao@linutronix.de>
References: <20240425115201.3044202-1-namcao@linutronix.de>
Date: Thu, 25 Apr 2024 14:58:12 +0200
Message-ID: <87bk5xbnvf.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Nam Cao <namcao@linutronix.de> writes:

> On riscv32, it is possible for the last page in virtual address space
> (0xfffff000) to be allocated. This page overlaps with PTR_ERR, so that
> shouldn't happen.
>
> There is already some code to ensure memblock won't allocate the last pag=
e.
> However, buddy allocator is left unchecked.
>
> Fix this by reserving physical memory that would be mapped at virtual
> addresses greater than 0xfffff000.
>
> Reported-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> Closes: https://lore.kernel.org/linux-riscv/878r1ibpdn.fsf@all.your.base.=
are.belong.to.us
> Fixes: 76d2a0493a17 ("RISC-V: Init and Halt Code")
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Cc: <stable@vger.kernel.org>


Thanks for picking it up again, Nam.

This passes my test:
Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

> ---
>  arch/riscv/mm/init.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 968761843203..7c985435b3fc 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -235,18 +235,19 @@ static void __init setup_bootmem(void)
>  		kernel_map.va_pa_offset =3D PAGE_OFFSET - phys_ram_base;
>=20=20
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
> -		max_mapped_addr =3D __pa(~(ulong)0);
> -		if (max_mapped_addr =3D=3D (phys_ram_end - 1))
> -			memblock_set_current_limit(max_mapped_addr - 4096);
> +		max_mapped_addr =3D __va_to_pa_nodebug(-PAGE_SIZE);
> +		memblock_reserve(max_mapped_addr, (phys_addr_t)-max_mapped_addr);

Nit (and only if you respin for some reason): Move max_mapped_addr into
the if-clause, or simply get rid of it (all on one line).

Regardless:
Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>


Bj=C3=B6rn

