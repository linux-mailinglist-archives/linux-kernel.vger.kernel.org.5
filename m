Return-Path: <linux-kernel+bounces-57498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E4084D9D9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C35FB2253D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2B967C7E;
	Thu,  8 Feb 2024 06:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLAWOOle"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3AE67C68;
	Thu,  8 Feb 2024 06:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707372848; cv=none; b=nuZsys8IvIWuQpwKkPJaMzZewxk1YegRPQgKRVCcmro6OrGvorx1n1ohxw++2cQ9NHbO4r9I0qKbeGyArUPtzNj30qlIio1vmSQhTm9db/aC/COD4USAJvEgVkFIiY1QzuLWnxnKOv1AZd/1uHe3uLUZB4vTNzU9oWkW1XGI2jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707372848; c=relaxed/simple;
	bh=4QzBds67XGtNERWYDx/aWm1ENgSNhTtOrGmuQ4p3/TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkgLhM00GSHXXJR91PkcSY1YxLo9rQrD7aFECKO9ChIoY2cGpTBLJtblCSppjKA3P4z+HelfDpEQf6zGzo9OHL8NiRVhmhe+Jx4X6xabZXKhVtIGFXaAvugO1SJhkGtYPkY7JNSp+8JLvnMN+/Tbuk8CeC4c3TiGCYPIB8q39j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLAWOOle; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F03C433F1;
	Thu,  8 Feb 2024 06:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707372848;
	bh=4QzBds67XGtNERWYDx/aWm1ENgSNhTtOrGmuQ4p3/TU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rLAWOOleFLG4hRBau/SC1x4YiU+yav60epvbD/PBxvZknWftP+db02erpl8/XutxW
	 uey6GkKb/C3I2U0iRfZhMgOeBcOD0odNJyLJw9mVBIDLXfayM0jVcXiDYHffi29bE9
	 mVDI6jdFirFyhd8X6DPXQAgJ6w7Emw3JvMDQauyxGuk+5quPjETb0qH0w+WdUqQkMI
	 /vuHrzGJzlEVOMEX6bJ+1KW/tveopwAdW5hTT+sewWvbXo/YCZyMOIheTEWJMkvqlP
	 1vgwzSaIYuL0CjVbngFLUeJsZbhKg1++8Uzl+V8pAzA3VKJEivhTaCRxOlOK+cTZnG
	 bgRWPEBmybWPQ==
Date: Thu, 8 Feb 2024 08:13:42 +0200
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
Subject: Re: [PATCH v3 04/15] powerpc/pgtable: define PFN_PTE_SHIFT
Message-ID: <ZcRxFksWIcN5Cdgx@kernel.org>
References: <20240129124649.189745-1-david@redhat.com>
 <20240129124649.189745-5-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129124649.189745-5-david@redhat.com>

On Mon, Jan 29, 2024 at 01:46:38PM +0100, David Hildenbrand wrote:
> We want to make use of pte_next_pfn() outside of set_ptes(). Let's
> simply define PFN_PTE_SHIFT, required by pte_next_pfn().
> 
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/powerpc/include/asm/pgtable.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
> index 9224f23065ff..7a1ba8889aea 100644
> --- a/arch/powerpc/include/asm/pgtable.h
> +++ b/arch/powerpc/include/asm/pgtable.h
> @@ -41,6 +41,8 @@ struct mm_struct;
>  
>  #ifndef __ASSEMBLY__
>  
> +#define PFN_PTE_SHIFT		PTE_RPN_SHIFT
> +
>  void set_ptes(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
>  		pte_t pte, unsigned int nr);
>  #define set_ptes set_ptes
> -- 
> 2.43.0
> 
> 

-- 
Sincerely yours,
Mike.

