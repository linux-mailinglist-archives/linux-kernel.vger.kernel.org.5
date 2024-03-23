Return-Path: <linux-kernel+bounces-112434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2976D8879C9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 18:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D29A4281F77
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 17:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C69553361;
	Sat, 23 Mar 2024 17:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b7rXe1WJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D061EEF8
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 17:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711215583; cv=none; b=tby+Mn6Ru8H4Ot0OTd4xoOGHAsr4NQsqOnFIDbdeyuxcV/bAK/FxVhJxQTQvB2b1IhKy2q5VuzgjJLHav/65y3i5Y1un6Eb9/7vDQySR7+kgqPM334qzwDFyPlu0GLaI+W6IDLcE009cfKt/ibHIpUb496p2RHoVpzOlGa9xhkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711215583; c=relaxed/simple;
	bh=j9UFQgyd+OsiMupJULgRA4Qa5h7TfdAkWv+OvJ2HSbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SB8PXwHr5z9Y0JtbexJGUeFaoP7aY/PlcOEyyBQt0HjFCj6p9uto4DW0g68jjcrHQd1mXtWU3CtMsRe3g5lGlu4q/gi1CHxisPCPUhu5hHcMo3Bq8LqXn9jQ4hSCveJ3hhP++7tf9yVv8MpqtwHPrrw4B0ULHaYTFWuv2tLZefs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b7rXe1WJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711215580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3KpHjticzOUnHT2dPif+lyhzudngj6gqkO1DTO8r5w0=;
	b=b7rXe1WJPS/kwOD1ZdsLWagJcvJKAmuNK51SkpA4myoOwXjCxtcd5EdO+pfcv//dV19ugy
	U9dBHWEAxHhPiWevVxZjQHKv/I+7uIwQj50AlnO2gsCjN12NJDllcW49afbpKPjKnuVjqi
	Na+wTcWyrMWZhUJPQzfpO7dPI0coGEA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-TLGdvmDOMTyAwuR_3ahwSg-1; Sat, 23 Mar 2024 13:39:37 -0400
X-MC-Unique: TLGdvmDOMTyAwuR_3ahwSg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-69651ab4c4fso8506996d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 10:39:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711215577; x=1711820377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KpHjticzOUnHT2dPif+lyhzudngj6gqkO1DTO8r5w0=;
        b=sSefwtcKsqFfSNsw75KCfa148+uKfgta08e97ncLFqoXkJU+EGM13+zR/uHrOs+nk3
         I3woD0gJcJCxcQbYIpzVGu2VBgjEH0HxDYwjkZ2GQuEh1TxCai7j95F/WEPPt41HEXgj
         3YV/X40QemA+rtXg++4fxoWZCUJJr583RNmkNZjzG1rrn2z35AdwHf3G5DgH3rQE28gN
         DPBstILZcE+8aOtLuUzE5NmkzcN29VWF6qc6TVhVNc0y7ACYRYIII6ZNJ/38++5XXtkS
         8W4Zy1L4Vb+n2H/AMeh4+WRM7eE+iAJcp6YLx8TKeE8umndTFxb734OOqR9tjj8BSULU
         ibEw==
X-Gm-Message-State: AOJu0YwPw8yR6LEdcjmR09esn+7S512c85I21P1pwn728q3pUsTPPjPc
	220GQfUL39PqNrJR03SfDEZESo5iKQYvkW3zBuYfPXpvSCiOqd9Bzr7HYcSB3wvqqgV7VpG2tui
	DqluJgr2+/MhCXIg6pO/Kndbsk4SKSXQo1vJsBSX2ttBxuc/ImXwmd8EGyK0C+XX/zQU7U7l/ID
	sNvYyK6uZgGWNmcfPG43uM7tbxo/kHEM8feAgPtsJRHEs=
X-Received: by 2002:a05:6214:2b81:b0:695:c55d:fdf8 with SMTP id kr1-20020a0562142b8100b00695c55dfdf8mr3085731qvb.1.1711215577052;
        Sat, 23 Mar 2024 10:39:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8UMOaZJTo0ystqWAJsb4XvzGXuMmMjMRALL1k+nYpAcZE+Nyvfo2Ng3iSlKC7841Sl6rP/Q==
X-Received: by 2002:a05:6214:2b81:b0:695:c55d:fdf8 with SMTP id kr1-20020a0562142b8100b00695c55dfdf8mr3085704qvb.1.1711215576448;
        Sat, 23 Mar 2024 10:39:36 -0700 (PDT)
Received: from x1n ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id f7-20020a0562141d2700b00690f0d7057esm2269983qvd.39.2024.03.23.10.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 10:39:36 -0700 (PDT)
Date: Sat, 23 Mar 2024 13:39:34 -0400
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Mike Rapoport <rppt@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] mm/arch: Provide pud_pfn() fallback
Message-ID: <Zf8T1hztUyslmW51@x1n>
References: <20240323151643.1047281-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240323151643.1047281-1-peterx@redhat.com>

On Sat, Mar 23, 2024 at 11:16:43AM -0400, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> The comment in the code explains the reasons.  We took a different approach
> comparing to pmd_pfn() by providing a fallback function.
> 
> Another option is to provide some lower level config options (compare to
> HUGETLB_PAGE or THP) to identify which layer an arch can support for such
> huge mappings.  However that can be an overkill.
> 
> Cc: Mike Rapoport (IBM) <rppt@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202403231529.HRev1zcD-lkp@intel.com/

Also:

Closes: https://lore.kernel.org/oe-kbuild-all/202403240112.kHKVSfCL-lkp@intel.com/

> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> 
> Andrew,
> 
> If we care about per-commit build errors (and if it is ever feasible to
> reorder), we can move this patch to be before the patch "mm/gup: handle
> huge pud for follow_pud_mask()" in mm-unstable to unbreak build on that
> commit.
> 
> Thanks,
> ---
>  arch/riscv/include/asm/pgtable.h    |  1 +
>  arch/s390/include/asm/pgtable.h     |  1 +
>  arch/sparc/include/asm/pgtable_64.h |  1 +
>  arch/x86/include/asm/pgtable.h      |  1 +
>  include/linux/pgtable.h             | 10 ++++++++++
>  5 files changed, 14 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 20242402fc11..0ca28cc8e3fa 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -646,6 +646,7 @@ static inline unsigned long pmd_pfn(pmd_t pmd)
>  
>  #define __pud_to_phys(pud)  (__page_val_to_pfn(pud_val(pud)) << PAGE_SHIFT)
>  
> +#define pud_pfn pud_pfn
>  static inline unsigned long pud_pfn(pud_t pud)
>  {
>  	return ((__pud_to_phys(pud) & PUD_MASK) >> PAGE_SHIFT);
> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> index 1a71cb19c089..6cbbe473f680 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -1414,6 +1414,7 @@ static inline unsigned long pud_deref(pud_t pud)
>  	return (unsigned long)__va(pud_val(pud) & origin_mask);
>  }
>  
> +#define pud_pfn pud_pfn
>  static inline unsigned long pud_pfn(pud_t pud)
>  {
>  	return __pa(pud_deref(pud)) >> PAGE_SHIFT;
> diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
> index 4d1bafaba942..26efc9bb644a 100644
> --- a/arch/sparc/include/asm/pgtable_64.h
> +++ b/arch/sparc/include/asm/pgtable_64.h
> @@ -875,6 +875,7 @@ static inline bool pud_leaf(pud_t pud)
>  	return pte_val(pte) & _PAGE_PMD_HUGE;
>  }
>  
> +#define pud_pfn pud_pfn
>  static inline unsigned long pud_pfn(pud_t pud)
>  {
>  	pte_t pte = __pte(pud_val(pud));
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index cefc7a84f7a4..273f7557218c 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -234,6 +234,7 @@ static inline unsigned long pmd_pfn(pmd_t pmd)
>  	return (pfn & pmd_pfn_mask(pmd)) >> PAGE_SHIFT;
>  }
>  
> +#define pud_pfn pud_pfn
>  static inline unsigned long pud_pfn(pud_t pud)
>  {
>  	phys_addr_t pfn = pud_val(pud);
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 2a1c044ae467..deae9e50f1a8 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1817,6 +1817,16 @@ typedef unsigned int pgtbl_mod_mask;
>  #define pte_leaf_size(x) PAGE_SIZE
>  #endif
>  
> +/*
> + * We always define pmd_pfn for all archs as it's used in lots of generic
> + * code.  Now it happens too for pud_pfn (and can happen for larger
> + * mappings too in the future; we're not there yet).  Instead of defining
> + * it for all archs (like pmd_pfn), provide a fallback.
> + */
> +#ifndef pud_pfn
> +#define pud_pfn(x) ({ BUILD_BUG(); 0; })
> +#endif
> +
>  /*
>   * Some architectures have MMUs that are configurable or selectable at boot
>   * time. These lead to variable PTRS_PER_x. For statically allocated arrays it
> -- 
> 2.44.0
> 

-- 
Peter Xu


