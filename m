Return-Path: <linux-kernel+bounces-57496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A39284D9D2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 177921F23BD0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5BD67C7D;
	Thu,  8 Feb 2024 06:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdIp4XnV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5CA149E1B;
	Thu,  8 Feb 2024 06:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707372790; cv=none; b=cUA7oTMWFnx7tiU+Gapil9F1WwR/ZCb6DDU0qVtcSf+tL3L+0HyLaU5cQHSFNo50Hs0dIoqymsnqz7lygU26pTqyY7iOi33gqqburCdqcb0C5eKtRi8SSh+8vgveDGvtmaXtwowuhHyEZBxyKAGOwaXHtU2kotssRd0oVEOUJAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707372790; c=relaxed/simple;
	bh=GM6dCu14KCN1BOx/s18QrtfrcQp10p30WtEoq/gOMJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWrZNngueczW1yqh1tx8DSln6EV3NYwu0AzARlEJcOJHDSV1zItsqY/Ko0nMNRXaZJk4jdMxsbJo/rY2eymUjAruiAqR2ByWkF8JfNxVYAf0q3wMmNEkI2PlN4ZJ8VoWoZ7slXVqfYDiqyt3hyluRDq862BUMZduy3akjzcc1p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdIp4XnV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14665C433F1;
	Thu,  8 Feb 2024 06:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707372790;
	bh=GM6dCu14KCN1BOx/s18QrtfrcQp10p30WtEoq/gOMJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jdIp4XnVq2YCQ14TsRYu7WYNhoVL6BtKWfrsAzOeRc9Q/LguXmaF83ZhM1oP2znC0
	 siSpiD4L44v0Kuav3FN/xGm6jWEBJo8+TeNLIF+gp4XZpws4AEcgm0b+gUqDsD4nu/
	 mPww9jaa2QmsL/6Blxo4KILZsLAhwPAv4xojEYk8GtoK6rqv3I2dTvyt0zotDTLn03
	 pIyzShY74h7lo4nvR7U7/QBb8+rwHG007doptEwwKyv2ORXjLL3eJOGKQzSrpnI7gO
	 7Geegg/lj6oFSJVhLduHTHpZgQcBaQWBYS5ib3MOz3fvWQ50+I2DUGSCC0ku6pAFSO
	 q8ndS3rQIwGZA==
Date: Thu, 8 Feb 2024 08:12:44 +0200
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
Subject: Re: [PATCH v3 03/15] nios2/pgtable: define PFN_PTE_SHIFT
Message-ID: <ZcRw3GoICHW_KgT4@kernel.org>
References: <20240129124649.189745-1-david@redhat.com>
 <20240129124649.189745-4-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129124649.189745-4-david@redhat.com>

On Mon, Jan 29, 2024 at 01:46:37PM +0100, David Hildenbrand wrote:
> We want to make use of pte_next_pfn() outside of set_ptes(). Let's
> simply define PFN_PTE_SHIFT, required by pte_next_pfn().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/nios2/include/asm/pgtable.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/nios2/include/asm/pgtable.h b/arch/nios2/include/asm/pgtable.h
> index 5144506dfa69..d052dfcbe8d3 100644
> --- a/arch/nios2/include/asm/pgtable.h
> +++ b/arch/nios2/include/asm/pgtable.h
> @@ -178,6 +178,8 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
>  	*ptep = pteval;
>  }
>  
> +#define PFN_PTE_SHIFT		0
> +
>  static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
>  		pte_t *ptep, pte_t pte, unsigned int nr)
>  {
> -- 
> 2.43.0
> 
> 

-- 
Sincerely yours,
Mike.

