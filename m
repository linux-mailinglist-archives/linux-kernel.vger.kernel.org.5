Return-Path: <linux-kernel+bounces-57502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A1A84D9E6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DB1A281E74
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC9067C77;
	Thu,  8 Feb 2024 06:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ch0eIee+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6181E4C84;
	Thu,  8 Feb 2024 06:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707372953; cv=none; b=mryJ4bghVIvPjF6EPdk+FYlTa3AhbPNnhK7qPWaHnmPx0+2Mw16TNIcOmH68f+S8K3gf9PBrZLQEUythkhOrR6WWCfGdghQph7soPPTP3Zrqgcx3TeLfO7hcu6Lw4HLcJCqTfWpZi3BSBKiu422UTmCeLCOFNblYTLzf7KEveqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707372953; c=relaxed/simple;
	bh=4cpBdMWcDp/URDDivrNC/5C2U/2Get9Hcj59TpzJo88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dV3DV2AmhFbVk+EgFymKpo8oAZOIrZ8h5ZpS/AmAxoKVedavVV/rpQ7IdErkGz7yw/W2vZrGJvCbH8hOqWDHgmj47DiUgTygdVqG1Liadp1nHYohdrc/Sz7yFCBYFfsmfhzsu/Nn/YOVKJRZVM4klIU+84I2oivfSHrJBCwx0Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ch0eIee+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF23C433F1;
	Thu,  8 Feb 2024 06:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707372952;
	bh=4cpBdMWcDp/URDDivrNC/5C2U/2Get9Hcj59TpzJo88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ch0eIee+TLQVcxJA1IRkGd00XN03txLrgzYzC4XgFSxqfrFQSz9Zg39KFHirnk8Dn
	 HXqAbI6jaZMcaFtq1/+Jv5yhTQ9qnjaAWh0Up4V4v771H3bVOa0RD6klWQxgL/9ASp
	 H01qOpHlb0gOleU7AQDWReSZtL8qLnAwMAUt1celTZxbjdnteZmnSZq/EFqUAx0mmN
	 AeiyEEztyQtpKTBUo5oFZUSCHlnRBQ6ufZqDEhgsiFbZNBOAR+LBNUD5WKDlfHZnAd
	 6Z+vqa2O+e9MDNRJCcItgHJ2iQFkpDLAcYLkQgY9uErSvCDDSuXkWQjkTilp2CM8Ph
	 nkWZ07IuNEqyg==
Date: Thu, 8 Feb 2024 08:15:27 +0200
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
Subject: Re: [PATCH v3 06/15] s390/pgtable: define PFN_PTE_SHIFT
Message-ID: <ZcRxfx4Ze-_KXzE7@kernel.org>
References: <20240129124649.189745-1-david@redhat.com>
 <20240129124649.189745-7-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129124649.189745-7-david@redhat.com>

On Mon, Jan 29, 2024 at 01:46:40PM +0100, David Hildenbrand wrote:
> We want to make use of pte_next_pfn() outside of set_ptes(). Let's
> simply define PFN_PTE_SHIFT, required by pte_next_pfn().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/s390/include/asm/pgtable.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> index 1299b56e43f6..4b91e65c85d9 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -1316,6 +1316,8 @@ pgprot_t pgprot_writecombine(pgprot_t prot);
>  #define pgprot_writethrough	pgprot_writethrough
>  pgprot_t pgprot_writethrough(pgprot_t prot);
>  
> +#define PFN_PTE_SHIFT		PAGE_SHIFT
> +
>  /*
>   * Set multiple PTEs to consecutive pages with a single call.  All PTEs
>   * are within the same folio, PMD and VMA.
> -- 
> 2.43.0
> 
> 

-- 
Sincerely yours,
Mike.

