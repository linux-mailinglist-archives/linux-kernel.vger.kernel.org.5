Return-Path: <linux-kernel+bounces-30577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D178320E0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 22:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 479F81F23F3E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 21:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61D831A73;
	Thu, 18 Jan 2024 21:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AgaskupO"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8782EB06;
	Thu, 18 Jan 2024 21:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705613259; cv=none; b=YcUYmbI4OQT02oq9UUsy1ydRitHFcT3j4sMeEkKRO61fFRtN4mzaG6y3uZ049EhxVyiNWm8TN9uPzzKUALmiVyvQuoyun8h3XRirxL2Vt7ye67cs6U24d+2b+uJ4MruSZF2jS4eM8QFS132vvPuYq5HV8mJTs2t6vmvo8vT1enQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705613259; c=relaxed/simple;
	bh=o1e+rn++rLhlte5H4ynuj6Q7EkxY+flGdKcnbQY30JE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h+pffiezVJRpGARUmK6EoJpedtKCH91jfqIkMzG1xx9O3D6ViSTc+/03izApITiBCVczDK6TLNNUMg8ELwbKooab2z/68aGsc2h1iwCDgLAIwjTkkcVyyit61381cp0hgUd40fHuocVQ6rgEk0XrRXvZUIXqUKBIv36mg9PkIqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AgaskupO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=96kKANMzCe9nNl8cI1u18mwobQi0vfy5NziQ9GUpncM=; b=AgaskupOFSB6UW0FmnVibQmNY7
	QH0nNAZ8bfs4Wxkxzm3qbew3nj5oit0ed9lmUDPa32C86kpn7TKyZr7LTUMdQe5oH8dcjCllVL8Vu
	2ZBwXtpRQIQ3ri+cL8yZKBtcinpdqMO7gpcJo9mQaq06YI6b5YIM5WltL40BOuJMHuiffQ6ycGA5Y
	NxV/+PCF0DHLoowoUQ7O5yLyQj1h0iFvdNh6mGib1GHokbL8JUMcQL2KQt4wr1uYLaIWcieyUTSFN
	NDvxzOoHSrkcDuryKLEYEvrGaWcu0heI4ePMaHNBTRYWHXjIxoqeCNjPvtb1Y4OnkOyGmgTCO/Mxb
	5vYcbh7g==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rQZv9-003uUN-2d;
	Thu, 18 Jan 2024 21:27:32 +0000
Message-ID: <370e7792-a8ce-4e91-8c41-8eec623fdde1@infradead.org>
Date: Thu, 18 Jan 2024 13:27:31 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Fix build error on rv32 + XIP
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Frederik Haxel <haxel@fzi.de>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240118212120.2087803-1-alexghiti@rivosinc.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240118212120.2087803-1-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/18/24 13:21, Alexandre Ghiti wrote:
> commit 66f1e6809397 ("riscv: Make XIP bootable again") restricted page
> offset to the sv39 page offset instead of the default sv57, which makes
> sense since probably the platforms that target XIP kernels do not
> support anything else than sv39 and we do not try to find out the
> largest address space supported on XIP kernels (ie set_satp_mode()).
> 
> But PAGE_OFFSET_L3 is not defined for rv32, so fix the build error by
> restoring the previous behaviour which picks CONFIG_PAGE_OFFSET for rv32.
> 
> Fixes: 66f1e6809397 ("riscv: Make XIP bootable again")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/linux-riscv/344dca85-5c48-44e1-bc64-4fa7973edd12@infradead.org/T/#u
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.


> ---
>  arch/riscv/mm/init.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index f533dd667a83..32cad6a65ccd 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -1060,7 +1060,11 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  	kernel_map.virt_addr = KERNEL_LINK_ADDR + kernel_map.virt_offset;
>  
>  #ifdef CONFIG_XIP_KERNEL
> +#ifdef CONFIG_64BIT
>  	kernel_map.page_offset = PAGE_OFFSET_L3;
> +#else
> +	kernel_map.page_offset = _AC(CONFIG_PAGE_OFFSET, UL);
> +#endif
>  	kernel_map.xiprom = (uintptr_t)CONFIG_XIP_PHYS_ADDR;
>  	kernel_map.xiprom_sz = (uintptr_t)(&_exiprom) - (uintptr_t)(&_xiprom);
>  

-- 
#Randy

