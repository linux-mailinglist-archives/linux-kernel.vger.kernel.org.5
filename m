Return-Path: <linux-kernel+bounces-57501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AABF84D9E2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A87CB21CE7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED6A67C79;
	Thu,  8 Feb 2024 06:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAN3NWHU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEA567E63;
	Thu,  8 Feb 2024 06:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707372913; cv=none; b=TJf6nrI2rly7JlMiM+7vGWDlDAor9vzY9h43YfxyCFFVRHiXfq76WLKDjXtn8xGlxxt0mk1FXXaskQrihz8m2Mn6JgtqWRBSXM3lVstWJ6OB7x4qGpTqWhfqp2LiAFwC0R/vRPlXw8+kVDvnZ6UM3HrHHiJYaeUlRHhY1pkLMZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707372913; c=relaxed/simple;
	bh=GtOxHpQlJPbwoRannd2MAAO/IcfWNYmAXcwGmqFXwjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPUPHN8AzELuQxvhCHbHuHV2qyLjIeYQxmVSwvVaslNYm2sH3JgtLO1jMcZu5g5h6GSgOIZNNsTk+g7eJotd+thT8NigT+3ky8Ci8SvmMm4q0QL15VJghzoZNVIS/BOpPTzyxtUS1IwuNsTpGsl+DTu54g9OzlCmWUbzbmcHl8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAN3NWHU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F90C433F1;
	Thu,  8 Feb 2024 06:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707372912;
	bh=GtOxHpQlJPbwoRannd2MAAO/IcfWNYmAXcwGmqFXwjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qAN3NWHUgAp6xKLvQ0e8yFo37cydTMg89g97KgoVIregyOwzbHZk4hqQ3sub2hCoQ
	 hwe0CdW4bLnS5IePSVLUqqS0MuuGvJA+5FdWAqCBJPZGNUnGeQCtpVOkvjE1Gz9XSo
	 5xjczVpDmR6gYjOyqEkppqllHNPtdfx9WSEBmpQNcCQ2hUtwmJ6ZdiUOZTqrfTdnLZ
	 Mj0yGe+GtEY945WdAUDvOC+bojkB9gTWZGJtrrYvw6T2MmSzxu91pmMkOX3+8wCpJN
	 2nJc45RuQ04OQl9ZjLVBanjRZpBun16YaB8T9shpv+hT3YI4fkzjzytGNhBmxHHxa+
	 nPwOFg0DIBeAw==
Date: Thu, 8 Feb 2024 08:14:47 +0200
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
	sparclinux@vger.kernel.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH v3 05/15] riscv/pgtable: define PFN_PTE_SHIFT
Message-ID: <ZcRxVwWdvIjva9Vz@kernel.org>
References: <20240129124649.189745-1-david@redhat.com>
 <20240129124649.189745-6-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129124649.189745-6-david@redhat.com>

On Mon, Jan 29, 2024 at 01:46:39PM +0100, David Hildenbrand wrote:
> We want to make use of pte_next_pfn() outside of set_ptes(). Let's
> simply define PFN_PTE_SHIFT, required by pte_next_pfn().
> 
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/riscv/include/asm/pgtable.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 0c94260b5d0c..add5cd30ab34 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -523,6 +523,8 @@ static inline void __set_pte_at(pte_t *ptep, pte_t pteval)
>  	set_pte(ptep, pteval);
>  }
>  
> +#define PFN_PTE_SHIFT		_PAGE_PFN_SHIFT
> +
>  static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
>  		pte_t *ptep, pte_t pteval, unsigned int nr)
>  {
> -- 
> 2.43.0
> 
> 

-- 
Sincerely yours,
Mike.

