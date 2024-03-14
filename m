Return-Path: <linux-kernel+bounces-103362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8449087BE8B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A56C41C217E7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3A96AFAC;
	Thu, 14 Mar 2024 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ETUK4psn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E607C6EB4B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 14:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710425342; cv=none; b=rc5hCW9GJ9SQLoAAwfDq/h19Xp8GTMmKwjD5uInb3EiXxcCR9gBGHCrZFhDogA79qnAzKlkbXGtjNNlMilHuOXxdaxcjndb1UIMLA0nTJBlpLTggjPfkBVwSaxVURU1eOw7PVHCvH5kkPL1cS1wERI4DSE8yiy1062nYXuekoBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710425342; c=relaxed/simple;
	bh=Z0ILnZeNBHrRrotQP/MGhhY17p/IzYz2MVEg1mCXeQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzeS+7w4br5TImrlV/r6NsMKYh0fVjFBmhxbJF5+3XLuONSX036Bgcfhgx1neEm/oOQx2mYSgkHyVS1uIabGpXlD4h78i74R+EzRd46YjBce/RhD9LWUMRTdnUko1c4zHFJXHZhwa554hV5JI3pJR154wgXOoBiP26f2hGOyXE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ETUK4psn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710425339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H0Ur324GEdYx6Na4EUzT7uu0LrdRXgiT37bQ9SRfD/k=;
	b=ETUK4psn3Asc5IGuCN8XF7Dk7AygTR7DEVSzbLgqrcG7FYY2kgYDtz5q/ccuge4Ul6cTO1
	TcyYjU/atSLAqLbOiHwD4wXdCDYQ7zafcFmGxu3B3p8g0h/ZjYJhDRHUgc2UBx9DpGCAaE
	xaXZdTXZbF3iGl4bvgpnZAbECkhaf0U=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-dJnb5UZGMce_dbcVOEcYSQ-1; Thu, 14 Mar 2024 10:08:58 -0400
X-MC-Unique: dJnb5UZGMce_dbcVOEcYSQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-690ab2b0de1so3111886d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 07:08:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710425338; x=1711030138;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H0Ur324GEdYx6Na4EUzT7uu0LrdRXgiT37bQ9SRfD/k=;
        b=Cg+birCxDZHxHg4yrFGyqH420frWBHrVO+FLSVmBiG/2sbkzF8i1erg+dB+IbU1ISY
         Gi1HEvIRTQwC3szI9TKpAkX/tNrkv5OPdwrVJDWEzXNYjYMGNB5hWNxtqCmM4zPIVJPw
         t5OMyc5ZpkKVYVvSF+y29GSR0KXuGX3o+Txhqn89KT5DLxVYKXMHnoXMTaZ0KNzZxSs+
         4xtBDVLAxESRu/7Wtds/D3Xfw4hDFbMoApfaz+4IehUmruRIPseWZQtPFZnLJ2AzmbNE
         NG71Mbdpt+UcgGBU8NSWtJFA2mWtWo196qf9ihqeqAprj/n59qNFDckBN03v8GNnJZVn
         zRTg==
X-Gm-Message-State: AOJu0YxOWch4oQfSgJzucIkeZVxFDv1DnBPmbGXkc1lOm5fboeKkfXXM
	1OpXpi0zWB0uH8ZO1/gy+no/wg3H9tUqvl0ra48OcIJBi4lemYuQu/ZLlsmRcGz3qoGaIvF/N0Y
	+fCXSyS+PGIMc3MiTi7KH/2t26tSMPtmpBZjBdEsIj8lpMtUyyr270oKx9Q8XMg==
X-Received: by 2002:a05:6214:568f:b0:690:d848:5223 with SMTP id qm15-20020a056214568f00b00690d8485223mr1929999qvb.1.1710425336051;
        Thu, 14 Mar 2024 07:08:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHucQiNsYz/grbilWzCKNHDTJ2JNCr8u+qXqtyrFQdPGNDAiC8YJGtZ0KjeTmr272RirFzDNA==
X-Received: by 2002:a05:6214:568f:b0:690:d848:5223 with SMTP id qm15-20020a056214568f00b00690d8485223mr1929810qvb.1.1710425332941;
        Thu, 14 Mar 2024 07:08:52 -0700 (PDT)
Received: from x1n ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id eq9-20020ad45969000000b0069155a36f67sm499868qvb.9.2024.03.14.07.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 07:08:52 -0700 (PDT)
Date: Thu, 14 Mar 2024 10:08:50 -0400
From: Peter Xu <peterx@redhat.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"x86@kernel.org" <x86@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 12/13] mm/treewide: Remove pXd_huge()
Message-ID: <ZfME8vjFhl8AdyFe@x1n>
References: <20240313214719.253873-1-peterx@redhat.com>
 <20240313214719.253873-13-peterx@redhat.com>
 <7e93ab99-c956-42d0-9afd-3c856f3ad951@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e93ab99-c956-42d0-9afd-3c856f3ad951@csgroup.eu>

On Thu, Mar 14, 2024 at 08:56:59AM +0000, Christophe Leroy wrote:
> 
> 
> Le 13/03/2024 à 22:47, peterx@redhat.com a écrit :
> > From: Peter Xu <peterx@redhat.com>
> > 
> > This API is not used anymore, drop it for the whole tree.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   arch/arm/mm/Makefile                          |  1 -
> >   arch/arm/mm/hugetlbpage.c                     | 29 -------------------
> >   arch/arm64/mm/hugetlbpage.c                   | 10 -------
> >   arch/loongarch/mm/hugetlbpage.c               | 10 -------
> >   arch/mips/include/asm/pgtable-32.h            |  2 +-
> >   arch/mips/include/asm/pgtable-64.h            |  2 +-
> >   arch/mips/mm/hugetlbpage.c                    | 10 -------
> >   arch/parisc/mm/hugetlbpage.c                  | 11 -------
> >   .../include/asm/book3s/64/pgtable-4k.h        | 10 -------
> >   .../include/asm/book3s/64/pgtable-64k.h       | 25 ----------------
> >   arch/powerpc/include/asm/nohash/pgtable.h     | 10 -------
> >   arch/riscv/mm/hugetlbpage.c                   | 10 -------
> >   arch/s390/mm/hugetlbpage.c                    | 10 -------
> >   arch/sh/mm/hugetlbpage.c                      | 10 -------
> >   arch/sparc/mm/hugetlbpage.c                   | 10 -------
> >   arch/x86/mm/hugetlbpage.c                     | 16 ----------
> >   include/linux/hugetlb.h                       | 24 ---------------
> >   17 files changed, 2 insertions(+), 198 deletions(-)
> >   delete mode 100644 arch/arm/mm/hugetlbpage.c
> > 
> 
> > diff --git a/arch/mips/include/asm/pgtable-32.h b/arch/mips/include/asm/pgtable-32.h
> > index 0e196650f4f4..92b7591aac2a 100644
> > --- a/arch/mips/include/asm/pgtable-32.h
> > +++ b/arch/mips/include/asm/pgtable-32.h
> > @@ -129,7 +129,7 @@ static inline int pmd_none(pmd_t pmd)
> >   static inline int pmd_bad(pmd_t pmd)
> >   {
> >   #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
> > -	/* pmd_huge(pmd) but inline */
> > +	/* pmd_leaf(pmd) but inline */
> 
> Shouldn't this comment have been changed in patch 11 ?

IMHO it's fine to be here, as this is the patch to finally drop _huge().
Patch 11 only converts the callers to use _leaf()s.  So this comment is
still valid until this patch, because this patch removes that definition.

> 
> >   	if (unlikely(pmd_val(pmd) & _PAGE_HUGE))
> 
> Unlike pmd_huge() which is an outline function, pmd_leaf() is a macro so 
> it could be used here instead of open coping.

I worry it will break things as pmd_leaf() can sometimes be defined after
arch *pgtable.h headers.  So I avoided touching it except what I think I'm
confident.  I had a feeling it's inlined just because of a similar reason
for the old _huge().

> 
> >   		return 0;
> >   #endif
> > diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
> > index 20ca48c1b606..7c28510b3768 100644
> > --- a/arch/mips/include/asm/pgtable-64.h
> > +++ b/arch/mips/include/asm/pgtable-64.h
> > @@ -245,7 +245,7 @@ static inline int pmd_none(pmd_t pmd)
> >   static inline int pmd_bad(pmd_t pmd)
> >   {
> >   #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
> > -	/* pmd_huge(pmd) but inline */
> > +	/* pmd_leaf(pmd) but inline */
> 
> Same
> 
> >   	if (unlikely(pmd_val(pmd) & _PAGE_HUGE))
> 
> Same
> 
> >   		return 0;
> >   #endif
> 
> > diff --git a/arch/powerpc/include/asm/book3s/64/pgtable-64k.h b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
> > index 2fce3498b000..579a7153857f 100644
> > --- a/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
> > +++ b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
> > @@ -4,31 +4,6 @@
> >   
> >   #ifndef __ASSEMBLY__
> >   #ifdef CONFIG_HUGETLB_PAGE
> > -/*
> > - * We have PGD_INDEX_SIZ = 12 and PTE_INDEX_SIZE = 8, so that we can have
> > - * 16GB hugepage pte in PGD and 16MB hugepage pte at PMD;
> > - *
> > - * Defined in such a way that we can optimize away code block at build time
> > - * if CONFIG_HUGETLB_PAGE=n.
> > - *
> > - * returns true for pmd migration entries, THP, devmap, hugetlb
> > - * But compile time dependent on CONFIG_HUGETLB_PAGE
> > - */
> 
> Should we keep this comment somewhere for documentation ?

The 2nd/3rd paragraphs are definitely obsolete, so should be dropped.

OTOH, I'm not sure how much that will help if e.g. I move that over to
pmd_leaf(): a check over cpu_to_be64(_PAGE_PTE) is an implementation as
simple as it could be to explain itself with even no comment to me..

I also don't fully digest why that 1st paragraph discusses PGD entries: for
example, there's no pgd_huge() defined.  It may not mean that the comment
is wrong, perhaps it means that I may lack some knowledge around this area
on Power..

Would you suggest how I should move paragraph 1 (and help to explain what
it is describing)?  Or maybe we can provide a separate patch for Power's
huge page sizes but posted separately (and very possibly I'm not the best
candidate then..).

> 
> > -static inline int pmd_huge(pmd_t pmd)
> > -{
> > -	/*
> > -	 * leaf pte for huge page
> > -	 */
> > -	return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
> > -}
> > -
> > -static inline int pud_huge(pud_t pud)
> > -{
> > -	/*
> > -	 * leaf pte for huge page
> > -	 */
> > -	return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
> > -}
> >   
> >   /*
> >    * With 64k page size, we have hugepage ptes in the pgd and pmd entries. We don't

-- 
Peter Xu


