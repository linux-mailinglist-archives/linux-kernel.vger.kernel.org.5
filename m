Return-Path: <linux-kernel+bounces-94910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 804B8874691
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3624E282AB9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E89EDDA0;
	Thu,  7 Mar 2024 03:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YRTcnn0q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78693D71
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 03:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709781065; cv=none; b=DuUO2c8ymEV1/dglBSbt5QTjDdW1XbmjaDSa+HBPb75bfX3i9gP9nnhcAaFWCRfLf4uXPBkKrz/426XNyoBd4Q+433swP5X9bBMi1cU/LvzEJ8x9worC9K2szAXtDRK+jzgcIK0jFGngVxNEwlOjLrzd77Ux7QMKAGombXEB1/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709781065; c=relaxed/simple;
	bh=aTfnNVOzuTStvs0tdoETXdWCW8y9BVUMXLGNAwHRpZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKBEj1+t5M4WjwlGpcmAKD6UnFjfU4ZLQLR0BalCJ9gEja0ET0M5RYz5exnNkxvQBS16Np1SDO8M2qaZixK6EppLNgRPnwpMMe2sIjiwNqQkk1kA5+xcCrZ5oapVSQpmj29aDOMQayNTK1L3duieYuAuQEjRDkY1PYFZ5FUcG48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YRTcnn0q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709781059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PkR96+oCUTcXVjSNgBM5A0Wxc2Bmtn+g3wn0Jg6Nemc=;
	b=YRTcnn0q5L0aUsLotbTTqhUCsG/hJyjQjt8om/mnqNDz2hPJ/LCbDWjYqdxiNPFeOXeb0B
	ZY/cr1XuCJRPa6HuXgBgEtWgKhi49muYfrEj+gkpFPuLWvQKItyAY2uKD37+G07KIHZkqy
	szXSsxNmPKn+tTc9ZwAc6c04MdJVxDw=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-Rkch0yRaNGaWiJBXJnd_vA-1; Wed, 06 Mar 2024 22:10:57 -0500
X-MC-Unique: Rkch0yRaNGaWiJBXJnd_vA-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6e644dcdc0dso32401b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 19:10:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709780736; x=1710385536;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PkR96+oCUTcXVjSNgBM5A0Wxc2Bmtn+g3wn0Jg6Nemc=;
        b=uoaqtNEX/0uC0aM6NAujtCLAWTwug65SseDQjgG+wNjekTNGLQVOmN9bEPesmQ5qeH
         hB2NvPUchXtndFs1ElimaEpp61NCPjtRf/9+WTZRTXbLYtApI3sbQPPBvw+KhIFWgcu3
         I5q5YqYoTTb/Ht+Zc2UszWnMeT+wc75PbyyHV+Ca8f37onaq9JdiLn75hVqexnDp4lgj
         LlIgb+lyC4uHhF5iiB32f5tMjz17g3aIfjnBRnYIAUOf+aMdynpd4yAJLY4d5///TriS
         AI8nZErtCHXWhtyYADrCiPGzAxRN0aZBff4ji2CvUnO5wmHySmQdxAlZXi7ik6t+PrCe
         ke1A==
X-Forwarded-Encrypted: i=1; AJvYcCWvYmX6nTeDyPzCbHHR7SdAEdSd9SRF6/20b1A1wEd6mMy4+BgrIP3aqPCiEmtCT+Cii6biwKStUrnpMVZeJFgJso5LvHahehcOcvD4
X-Gm-Message-State: AOJu0YxG2svYGAsc1gZjyWv3kxTGA/Ou2Htrlx27oARSbDyNWrimwXrj
	F6BJDGyPsqtYqZR+ZVvC5994fZHosz+62f4ECK1hBJq/Myk5Ztcvr1KW3x5FNzNL2/tYL5D4Y33
	vQAgBZaZoMcCldH10acvlRc7C0Vro2oBjqcMaIVCnOvrutQLymgPokoX/XmUWjA==
X-Received: by 2002:a05:6a00:cce:b0:6e6:c6f:dc7e with SMTP id b14-20020a056a000cce00b006e60c6fdc7emr1026105pfv.3.1709780736632;
        Wed, 06 Mar 2024 19:05:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkCBHVN9ZAc+1XyRReKazlag268zheivJJl2EtGptHK/Yo1IMFuR7cjV0MKh9sysGGci92ug==
X-Received: by 2002:a05:6a00:cce:b0:6e6:c6f:dc7e with SMTP id b14-20020a056a000cce00b006e60c6fdc7emr1026089pfv.3.1709780736228;
        Wed, 06 Mar 2024 19:05:36 -0800 (PST)
Received: from x1n ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n11-20020a056a000d4b00b006e65720e892sm568324pfv.94.2024.03.06.19.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 19:05:35 -0800 (PST)
Date: Thu, 7 Mar 2024 11:05:21 +0800
From: Peter Xu <peterx@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Matthew Wilcox <willy@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>, x86@kernel.org,
	sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Nicholas Piggin <npiggin@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH RFC 09/13] mm/powerpc: Redefine pXd_huge() with pXd_leaf()
Message-ID: <Zeku8SsorvytLJGe@x1n>
References: <20240306104147.193052-1-peterx@redhat.com>
 <20240306104147.193052-10-peterx@redhat.com>
 <87v85zo6w7.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v85zo6w7.fsf@mail.lhotse>

On Wed, Mar 06, 2024 at 11:56:56PM +1100, Michael Ellerman wrote:
> peterx@redhat.com writes:
> > From: Peter Xu <peterx@redhat.com>
> >
> > PowerPC book3s 4K mostly has the same definition on both, except pXd_huge()
> > constantly returns 0 for hash MMUs.  AFAICT that is fine to be removed,
> > because pXd_huge() reflects a hugetlb entry, while it's own hugetlb pgtable
> > lookup function (__find_linux_pte() shared by all powerpc code) already use
> > pXd_leaf() irrelevant of the MMU type.  It means pXd_leaf() should work all
> > fine with hash MMU pgtables or something could already went wrong.
> 
> Yes I think that's correct.
> 
> 4K Hash MMU doesn't support any hugepage size at PMD or PUD level (the
> geometry is wrong), so pmd/pud_huge() were written with that in mind,
> ie. they are hard coded to return false.
> 
> But it should be OK to use pmd/pud_leaf(), they will actually look for
> _PAGE_PTE, but it should never be set for 4K Hash.
> 
> See eg. arch/powerpc/include/asm/book3s/64/hash-4k.h:
> 
> static inline pmd_t hash__pmd_mkhuge(pmd_t pmd)
> {
> 	BUG();
> 	return pmd;
> }

Good to get confirmation on this, thanks, Michael.  These explanations also
look better than what I wrote, I'll amend the commit message.

> 
> > The goal should be that we will have one API pXd_leaf() to detect all kinds
> > of huge mappings.  AFAICT we need to use the pXd_leaf() impl (rather than
> > pXd_huge() ones) to make sure ie. THPs on hash MMU will also return true.
> >
> > This helps to simplify a follow up patch to drop pXd_huge() treewide.
> >
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> > Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> > Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  arch/powerpc/include/asm/book3s/64/pgtable-4k.h | 14 ++------------
> >  1 file changed, 2 insertions(+), 12 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/book3s/64/pgtable-4k.h b/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
> > index 48f21820afe2..92545981bb49 100644
> > --- a/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
> > +++ b/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
> > @@ -8,22 +8,12 @@
> >  #ifdef CONFIG_HUGETLB_PAGE
> >  static inline int pmd_huge(pmd_t pmd)
> >  {
> > -	/*
> > -	 * leaf pte for huge page
> > -	 */
> > -	if (radix_enabled())
> > -		return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
> > -	return 0;
> > +	return pmd_leaf(pmd);
> >  }
> >  
> >  static inline int pud_huge(pud_t pud)
> >  {
> > -	/*
> > -	 * leaf pte for huge page
> > -	 */
> > -	if (radix_enabled())
> > -		return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
> > -	return 0;
> > +	return pud_leaf(pud);
> >  }
> 
> This doesn't actually compile though.
> 
>   arch/powerpc/include/asm/book3s/64/pgtable-4k.h:11:16: error: implicit declaration of function ‘pmd_leaf’; did you mean ‘pgd_clear’? [-Werror=implicit-function-declaration]
> 
> etc.
> 
> To make it compile we'd need to relocate the pmd/pud_leaf() definitions:
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index df66dce8306f..fd7180fded75 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -262,6 +262,18 @@ extern unsigned long __kernel_io_end;
> 
>  extern struct page *vmemmap;
>  extern unsigned long pci_io_base;
> +
> +#define pmd_leaf pmd_leaf
> +static inline bool pmd_leaf(pmd_t pmd)
> +{
> +       return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
> +}
> +
> +#define pud_leaf pud_leaf
> +static inline bool pud_leaf(pud_t pud)
> +{
> +       return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
> +}
>  #endif /* __ASSEMBLY__ */
> 
>  #include <asm/book3s/64/hash.h>
> @@ -1436,20 +1448,5 @@ static inline bool is_pte_rw_upgrade(unsigned long old_val, unsigned long new_va
>         return false;
>  }
> 
> -/*
> - * Like pmd_huge(), but works regardless of config options
> - */
> -#define pmd_leaf pmd_leaf
> -static inline bool pmd_leaf(pmd_t pmd)
> -{
> -       return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
> -}
> -
> -#define pud_leaf pud_leaf
> -static inline bool pud_leaf(pud_t pud)
> -{
> -       return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
> -}
> -
>  #endif /* __ASSEMBLY__ */
>  #endif /* _ASM_POWERPC_BOOK3S_64_PGTABLE_H_ */

Thanks for the help, I'll fix that.  I'm wondering when syzbot will start
to feed my series into the testers; I do still rely on those feedbacks on
compilation issues with such treewide changes, but so far I didn't yet
receive any reports.

I've also attached the new patch directly here in case of any further
comment.

Thanks,

==========8<===========
From 9e75aef2141170f241577e7786aaa4bbbfd93360 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Wed, 6 Mar 2024 14:49:48 +0800
Subject: [PATCH] mm/powerpc: Redefine pXd_huge() with pXd_leaf()

PowerPC book3s 4K mostly has the same definition on both, except pXd_huge()
constantly returns 0 for hash MMUs.  As Michael Ellerman pointed out [1],
it is safe to check _PAGE_PTE on hash MMUs, as the bit will never be set so
it will keep returning false.

As a reference, __p[mu]d_mkhuge() will trigger a BUG_ON trying to create
such huge mappings for 4K hash MMUs.  Meanwhile, the major powerpc hugetlb
pgtable walker __find_linux_pte(), already used pXd_leaf() to check hugetlb
mappings.

The goal should be that we will have one API pXd_leaf() to detect all kinds
of huge mappings.  AFAICT we need to use the pXd_leaf() impl (rather than
pXd_huge() ones) to make sure ie. THPs on hash MMU will also return true.

This helps to simplify a follow up patch to drop pXd_huge() treewide.

NOTE: *_leaf() definition need to be moved before the inclusion of
asm/book3s/64/pgtable-4k.h, which defines pXd_huge() with it.

[1] https://lore.kernel.org/r/87v85zo6w7.fsf@mail.lhotse

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 .../include/asm/book3s/64/pgtable-4k.h        | 14 ++--------
 arch/powerpc/include/asm/book3s/64/pgtable.h  | 27 +++++++++----------
 2 files changed, 14 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable-4k.h b/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
index 48f21820afe2..92545981bb49 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
@@ -8,22 +8,12 @@
 #ifdef CONFIG_HUGETLB_PAGE
 static inline int pmd_huge(pmd_t pmd)
 {
-	/*
-	 * leaf pte for huge page
-	 */
-	if (radix_enabled())
-		return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
-	return 0;
+	return pmd_leaf(pmd);
 }
 
 static inline int pud_huge(pud_t pud)
 {
-	/*
-	 * leaf pte for huge page
-	 */
-	if (radix_enabled())
-		return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
-	return 0;
+	return pud_leaf(pud);
 }
 
 /*
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index df66dce8306f..fd7180fded75 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -262,6 +262,18 @@ extern unsigned long __kernel_io_end;
 
 extern struct page *vmemmap;
 extern unsigned long pci_io_base;
+
+#define pmd_leaf pmd_leaf
+static inline bool pmd_leaf(pmd_t pmd)
+{
+	return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
+}
+
+#define pud_leaf pud_leaf
+static inline bool pud_leaf(pud_t pud)
+{
+	return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
+}
 #endif /* __ASSEMBLY__ */
 
 #include <asm/book3s/64/hash.h>
@@ -1436,20 +1448,5 @@ static inline bool is_pte_rw_upgrade(unsigned long old_val, unsigned long new_va
 	return false;
 }
 
-/*
- * Like pmd_huge(), but works regardless of config options
- */
-#define pmd_leaf pmd_leaf
-static inline bool pmd_leaf(pmd_t pmd)
-{
-	return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
-}
-
-#define pud_leaf pud_leaf
-static inline bool pud_leaf(pud_t pud)
-{
-	return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
-}
-
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_POWERPC_BOOK3S_64_PGTABLE_H_ */
-- 
2.44.0

-- 
Peter Xu


