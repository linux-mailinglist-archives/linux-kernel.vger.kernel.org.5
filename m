Return-Path: <linux-kernel+bounces-25830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D1D82D679
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF011C21636
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA1AEAF2;
	Mon, 15 Jan 2024 09:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvOrwRci"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34379DF4C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 09:55:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6460AC433F1;
	Mon, 15 Jan 2024 09:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705312517;
	bh=Y0aXOS+b6gFxoHVGLnmvCujUW0jIxABtyiwWOpMnOy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uvOrwRcibUEOPd2gfHpwl68cNRhLAGmvLkmx3PXLjDOsB5f4Y/snIEUNpq+T3ctVu
	 /aHgT65BQiXO7wIGoXCaSSqAvd4/Hn1pWpnhnvsvWr6G80vkTcmUt8MeyAlKLQNMKa
	 C/RroNXYaoP34iFrd88FdhbO9AOpt0QrxAJSkod1JZ5iZU5EaXhLuEsEcN+xHanK8h
	 LzM58DvkhUylMOv6WWSjwlcmqMPaA1h48+LSHH6rY5J3fTHNuac+QSxkCJ0R3j4yIt
	 pxWn4SSzhTtf0i7ToQ5y4v1vVRt3JbDYV+1s3juWg4vxyZW9AlrRpWdGBqPeyqG6V7
	 umTEvzDbXCjsg==
Date: Mon, 15 Jan 2024 17:42:26 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: mm: implement pgprot_nx
Message-ID: <ZaT+Ai+Lbzx1qBYr@xhacker>
References: <20231121160637.3856-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231121160637.3856-1-jszhang@kernel.org>

On Wed, Nov 22, 2023 at 12:06:37AM +0800, Jisheng Zhang wrote:
> commit cca98e9f8b5e ("mm: enforce that vmap can't map pages
> executable") enforces the W^X protection by not allowing remapping
> existing pages as executable. Add riscv bits so that riscv can benefit
> the same protection.

And this simple patch to enforce W^X protection is also missed ;)

Thanks in advance
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/include/asm/pgtable.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 294044429e8e..4fc6ee5226fb 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -608,6 +608,12 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
>  	return ptep_test_and_clear_young(vma, address, ptep);
>  }
>  
> +#define pgprot_nx pgprot_nx
> +static inline pgprot_t pgprot_nx(pgprot_t _prot)
> +{
> +	return __pgprot(pgprot_val(_prot) & ~_PAGE_EXEC);
> +}
> +
>  #define pgprot_noncached pgprot_noncached
>  static inline pgprot_t pgprot_noncached(pgprot_t _prot)
>  {
> -- 
> 2.42.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

