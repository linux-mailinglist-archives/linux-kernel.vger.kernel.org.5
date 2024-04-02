Return-Path: <linux-kernel+bounces-128805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF125895FC2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E9611C2364A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F003115D5AF;
	Tue,  2 Apr 2024 22:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Io7YLuta"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A2943ADD
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 22:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712097845; cv=none; b=m6ylFoz45IWifn/V0zPIMoDCU9UGiNCODh07cGROGPNDYmXSdRGOKW7BRJaJT3rJg+IB0w/52DVCUtzkCvhGAY1cg7hka66NmFYtSjqwOrh4bzzp8Pf4JHeCVhgl12W1Vnpr38RY+VRv8EgBgD4If55C+IIcQskuNo3BcdeDcDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712097845; c=relaxed/simple;
	bh=WQA/tqVRtvM2c1zYCd8tZ1U+pxzMtVwo0oawguaO/Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cvyrobz1/d1vlW+QWDzMZtRhpBJlLRL7xkwENcyzQ18VNqVOMcLdWjx0lnDnhwN6oPytCu2CP8uzq9oXx3j4JdC4uwr3blc5qE6PiFloRjjdVQJC6pa7+tbExTzINAbnWpGOpsb3mG5mb7v/Lo5FYj9b5Gq5UlP6poEYFLr212c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Io7YLuta; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712097842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=msm30zqdysTm36DA/rZCqzTJxXxvA+rydv8lKPCKRNo=;
	b=Io7YLutabILOn+LMiD+4N/FK3QqdTtTYpXzhtfoy/FoDjAFK6yYLnlapoS93mtmEfdKfMP
	8qHC3wTUbBPgI3qcVcxvgd2ZsOL5pc9TKSrdH3aRg/PtoQCWueKu32IHv9cHsO7MMJVjqb
	P8ABZyQopNJE1t9/oR422SLoUKoDDWk=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-ZA-r0HcjM5GUsJZ9SdJ7gQ-1; Tue, 02 Apr 2024 18:44:01 -0400
X-MC-Unique: ZA-r0HcjM5GUsJZ9SdJ7gQ-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6e6cb8055b8so1924010a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 15:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712097840; x=1712702640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msm30zqdysTm36DA/rZCqzTJxXxvA+rydv8lKPCKRNo=;
        b=Q6496LHr8fMXcpCYVgSfmIRfzXmOTYrAxxMpvNUXCerfcbEkvz+UO3w2rJIrdpGIad
         afsxLbQFEyybelSdvK1BWPCBYe8ltBPdyOzb5zOLeH7y96T/I/zQvfGBUtATaSHCPOqs
         1gb0BDD5cs/vOxCE20vVWrGJ8gQi38kBmjt2jU0HZHofrhPWdjlNrBbJLwd588BPV3cp
         h0Jj+7jjP6PgHgf32r8yDGCwjrYcySmWPCQVJ21aVmSwCXMUIfY3y7Mch8Ln/UcDUqeC
         cIsnFsn0aCj+uDO+nNQilkY1tnzjgz73Gl73cSH1RwZsAb8XoFLip9qTL3xm/jlRPY2p
         NTlQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3Jk7Nd5Vi+vwERR1nnVX9mz0VzwxIsD+sgVjI4K8tewhnmE9fyuG06FQOAVISZLJqDgUyzso0bXzGMiGl4BgGnGj92e5IYindEv8z
X-Gm-Message-State: AOJu0Ywphk8MPHgF5e3M+b/HEuFt7YEDsFlT+4Qp/X1FqLf7qLZrC7Vj
	Ezwx1VpS8KHXyXwkJfExilQMmcOHKrmkPwUr2hchbij2a3Fk1BlvIpf0vyGljfsxsC2GAbidb1+
	aZVB7wi3h+eWfyjjTTEtZnhtAU1Wpzs2S5sSVEZCXl3zKp96DzS+ayeTA/OX5ZQ==
X-Received: by 2002:a05:6808:15a1:b0:3c4:f2b2:2c20 with SMTP id t33-20020a05680815a100b003c4f2b22c20mr4238882oiw.2.1712097840169;
        Tue, 02 Apr 2024 15:44:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6a1W8aoV0zchhQZ+4+B4MiM4kTW0SJ53OaThQIv9a42FW90adjoyx8moZXDxiuklchxwa7w==
X-Received: by 2002:a05:6808:15a1:b0:3c4:f2b2:2c20 with SMTP id t33-20020a05680815a100b003c4f2b22c20mr4238865oiw.2.1712097839620;
        Tue, 02 Apr 2024 15:43:59 -0700 (PDT)
Received: from x1n ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id u6-20020a05620a120600b00789e8860ef7sm4617106qkj.121.2024.04.02.15.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 15:43:59 -0700 (PDT)
Date: Tue, 2 Apr 2024 18:43:56 -0400
From: Peter Xu <peterx@redhat.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Yang Shi <shy828301@gmail.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Andrew Jones <andrew.jones@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Rik van Riel <riel@surriel.com>,
	linux-arm-kernel@lists.infradead.org,
	Andrea Arcangeli <aarcange@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	James Houghton <jthoughton@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Mike Rapoport <rppt@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev
Subject: Re: [PATCH v4 05/13] mm/arch: Provide pud_pfn() fallback
Message-ID: <ZgyKLLVZ4vN56uZE@x1n>
References: <20240327152332.950956-1-peterx@redhat.com>
 <20240327152332.950956-6-peterx@redhat.com>
 <20240402190549.GA706730@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240402190549.GA706730@dev-arch.thelio-3990X>

On Tue, Apr 02, 2024 at 12:05:49PM -0700, Nathan Chancellor wrote:
> Hi Peter (and LoongArch folks),
> 
> On Wed, Mar 27, 2024 at 11:23:24AM -0400, peterx@redhat.com wrote:
> > From: Peter Xu <peterx@redhat.com>
> > 
> > The comment in the code explains the reasons.  We took a different approach
> > comparing to pmd_pfn() by providing a fallback function.
> > 
> > Another option is to provide some lower level config options (compare to
> > HUGETLB_PAGE or THP) to identify which layer an arch can support for such
> > huge mappings.  However that can be an overkill.
> > 
> > Cc: Mike Rapoport (IBM) <rppt@kernel.org>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  arch/riscv/include/asm/pgtable.h    |  1 +
> >  arch/s390/include/asm/pgtable.h     |  1 +
> >  arch/sparc/include/asm/pgtable_64.h |  1 +
> >  arch/x86/include/asm/pgtable.h      |  1 +
> >  include/linux/pgtable.h             | 10 ++++++++++
> >  5 files changed, 14 insertions(+)
> > 
> > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> > index 20242402fc11..0ca28cc8e3fa 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -646,6 +646,7 @@ static inline unsigned long pmd_pfn(pmd_t pmd)
> >  
> >  #define __pud_to_phys(pud)  (__page_val_to_pfn(pud_val(pud)) << PAGE_SHIFT)
> >  
> > +#define pud_pfn pud_pfn
> >  static inline unsigned long pud_pfn(pud_t pud)
> >  {
> >  	return ((__pud_to_phys(pud) & PUD_MASK) >> PAGE_SHIFT);
> > diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> > index 1a71cb19c089..6cbbe473f680 100644
> > --- a/arch/s390/include/asm/pgtable.h
> > +++ b/arch/s390/include/asm/pgtable.h
> > @@ -1414,6 +1414,7 @@ static inline unsigned long pud_deref(pud_t pud)
> >  	return (unsigned long)__va(pud_val(pud) & origin_mask);
> >  }
> >  
> > +#define pud_pfn pud_pfn
> >  static inline unsigned long pud_pfn(pud_t pud)
> >  {
> >  	return __pa(pud_deref(pud)) >> PAGE_SHIFT;
> > diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
> > index 4d1bafaba942..26efc9bb644a 100644
> > --- a/arch/sparc/include/asm/pgtable_64.h
> > +++ b/arch/sparc/include/asm/pgtable_64.h
> > @@ -875,6 +875,7 @@ static inline bool pud_leaf(pud_t pud)
> >  	return pte_val(pte) & _PAGE_PMD_HUGE;
> >  }
> >  
> > +#define pud_pfn pud_pfn
> >  static inline unsigned long pud_pfn(pud_t pud)
> >  {
> >  	pte_t pte = __pte(pud_val(pud));
> > diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> > index cefc7a84f7a4..273f7557218c 100644
> > --- a/arch/x86/include/asm/pgtable.h
> > +++ b/arch/x86/include/asm/pgtable.h
> > @@ -234,6 +234,7 @@ static inline unsigned long pmd_pfn(pmd_t pmd)
> >  	return (pfn & pmd_pfn_mask(pmd)) >> PAGE_SHIFT;
> >  }
> >  
> > +#define pud_pfn pud_pfn
> >  static inline unsigned long pud_pfn(pud_t pud)
> >  {
> >  	phys_addr_t pfn = pud_val(pud);
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index 600e17d03659..75fe309a4e10 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -1817,6 +1817,16 @@ typedef unsigned int pgtbl_mod_mask;
> >  #define pte_leaf_size(x) PAGE_SIZE
> >  #endif
> >  
> > +/*
> > + * We always define pmd_pfn for all archs as it's used in lots of generic
> > + * code.  Now it happens too for pud_pfn (and can happen for larger
> > + * mappings too in the future; we're not there yet).  Instead of defining
> > + * it for all archs (like pmd_pfn), provide a fallback.
> > + */
> > +#ifndef pud_pfn
> > +#define pud_pfn(x) ({ BUILD_BUG(); 0; })
> > +#endif
> > +
> >  /*
> >   * Some architectures have MMUs that are configurable or selectable at boot
> >   * time. These lead to variable PTRS_PER_x. For statically allocated arrays it
> > -- 
> > 2.44.0
> > 
> 
> This BUILD_BUG() triggers for LoongArch with their defconfig, so it
> seems like they need to provide an implementation of pud_pfn()?
> 
>   In function 'follow_huge_pud',
>       inlined from 'follow_pud_mask' at mm/gup.c:1075:10,
>       inlined from 'follow_p4d_mask' at mm/gup.c:1105:9,
>       inlined from 'follow_page_mask' at mm/gup.c:1151:10:
>   include/linux/compiler_types.h:460:45: error: call to '__compiletime_assert_382' declared with attribute error: BUILD_BUG failed
>     460 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>         |                                             ^
>   include/linux/compiler_types.h:441:25: note: in definition of macro '__compiletime_assert'
>     441 |                         prefix ## suffix();                             \
>         |                         ^~~~~~
>   include/linux/compiler_types.h:460:9: note: in expansion of macro '_compiletime_assert'
>     460 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>         |         ^~~~~~~~~~~~~~~~~~~
>   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>         |                                     ^~~~~~~~~~~~~~~~~~
>   include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>      59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>         |                     ^~~~~~~~~~~~~~~~
>   include/linux/pgtable.h:1887:23: note: in expansion of macro 'BUILD_BUG'
>    1887 | #define pud_pfn(x) ({ BUILD_BUG(); 0; })
>         |                       ^~~~~~~~~
>   mm/gup.c:679:29: note: in expansion of macro 'pud_pfn'
>     679 |         unsigned long pfn = pud_pfn(pud);
>         |                             ^~~~~~~

I actually tested this without hitting the issue (even though I didn't
mention it in the cover letter..).  I re-kicked the build test, it turns
out my "make alldefconfig" on loongarch will generate a config with both
HUGETLB=n && THP=n, while arch/loongarch/configs/loongson3_defconfig has
THP=y (which I assume was the one above build used).  I didn't further
check how "make alldefconfig" generated the config; a bit surprising that
it didn't fetch from there.

(and it also surprises me that this BUILD_BUG can trigger.. I used to try
 triggering it elsewhere but failed..)

For loongarch the best thing is not compile in follow_huge_pud(), as it
doesn't support pud dax, neither does it support pud hugetlb.  However
again that may require some more CONFIG_* options to declare the level one
arch supports on HUGETLB_PAGE.  Here maybe the simplest (and it should also
cover all the rest archs on similar issues if ever possible to happen) is
we remove the BUILD_BUG() and explain why.  It should be safe for loongarch
too here in this case to not defined it until properly supported.

Thanks,

===8<===
From 585f34aa3d5b12cd2186367b0882d4293f792062 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Tue, 2 Apr 2024 18:31:07 -0400
Subject: [PATCH] fixup! mm/arch: provide pud_pfn() fallback

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/pgtable.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index fa8f92f6e2d7..0f4b2faa1d71 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1882,9 +1882,13 @@ typedef unsigned int pgtbl_mod_mask;
  * code.  Now it happens too for pud_pfn (and can happen for larger
  * mappings too in the future; we're not there yet).  Instead of defining
  * it for all archs (like pmd_pfn), provide a fallback.
+ *
+ * Note that returning 0 here means any arch that didn't define this can
+ * get severely wrong when it hits a real pud leaf.  It's arch's
+ * responsibility to properly define it when a huge pud is possible.
  */
 #ifndef pud_pfn
-#define pud_pfn(x) ({ BUILD_BUG(); 0; })
+#define pud_pfn(x) 0
 #endif
 
 /*
-- 
2.44.0

-- 
Peter Xu


