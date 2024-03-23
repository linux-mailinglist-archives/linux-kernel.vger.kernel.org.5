Return-Path: <linux-kernel+bounces-112180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F155588769C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 03:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C68D51C20ECC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 02:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFA01362;
	Sat, 23 Mar 2024 02:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AO1I73Gj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F46A55
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 02:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711160130; cv=none; b=Gm8eGq5er3IprtjdKnRHndgTC8+VS0sA4iilvFTyO5vtB/XDRrQlDBgwxZTmQFoT+dCM9h+kW1ZIgOPb+5mPiHfYzqwnQaCEiHXcEPCKqi8TR6tbNVRTgFUBXK+tXbsvCuAFeJ6gLy/lv6kmhTBo6HXZUGhQI/Qhfa+ZCl0xyZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711160130; c=relaxed/simple;
	bh=HWk4rhv45BR0tZSX/OV2YEgxhOZHVZ7T7goB3gqFABs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NaOkuNsEW8bTiZC3hV0HOO1CHZPyWTiJ9RuRDoDz5bLej78B0IV6oVlWzA8LdwbDl9OOxRbUudqokxDiRnO2E6mnnsfXBzp7Zmr57QJc7Vi/yagv1gatIz4syCRQLEtiGNAuCjuqbLHT8rm55qYoNsKm4y/BQ4CZXJUbEErUAkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AO1I73Gj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711160127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pAkp5p3e769nx5gm8jMLR0gRsGSeiOkGgQjUssudat0=;
	b=AO1I73Gjd9aalYfhXlJkTCMXhlS0vPbU9DOxdC68lafokdMTpa4WUYW8bhVOwrAxRULMDB
	07YF5g2XpvuTrVLJJ8PbRZ7yHoyB5viJzQnaT+577XlFN4CelGJz8dv1UTJvs2GMYsaYrB
	HdP02+w0n2zx450qaVhxhe3boHM0hqo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-pYUlXAOjPbS4H5Zume3OdA-1; Fri, 22 Mar 2024 22:15:26 -0400
X-MC-Unique: pYUlXAOjPbS4H5Zume3OdA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-430d45c66acso4759591cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 19:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711160124; x=1711764924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAkp5p3e769nx5gm8jMLR0gRsGSeiOkGgQjUssudat0=;
        b=whQv368SXCKow///XSKUtmf/viAmRtU/IyouYmzGN6iRjQ+HuB/9FVV6hTNY0mxrVt
         HRV+pPrelAs7amNZr4oWXGgGGf73rE1SPQ3fTnMmAowjIgkElaSbmGUTS15ObGb2Urkp
         MS3EgNjEoQ1Ys1JebfFFGfSnGb+A4SIjdp7nqi+EPTLFNrI7aiG3/iDYSB7MoQcc1o/4
         uz7LEVgy8gstwov12y7DZF2ixfyX+SbASSYbx8zmaGuUa9b6WThn89oU8BvYN1PDKTcX
         z52EcuFrScFWhCnTSgsziq1ewgM6tB2wFG9m7nFuDnjqsec51xkpR+gk5eJp/UnVev7a
         duQg==
X-Forwarded-Encrypted: i=1; AJvYcCXqX53o/+lDRuDnd/I6f9X5uBdb4r9sa1RGWGi7YWN9xens48nylYh0TKTVByH7QaOFWlZOHp86bKxD/ZHVzHCVzlVa3fY/+lOIWvAM
X-Gm-Message-State: AOJu0YxBYqng50VNxuWjDCuA0SPN4ayk1DrHVbumj0VUxgeSdDs4enwi
	7LqqMYdIRr0GawdNiEelMtryVABNH7Y8gHSNGuaHeOFxL4MRc6VoHnQeC0IHmJs60jyiGx3h31z
	yyiP7ngcJL7XU4NUdU/z33TcyDrdhfj00ALR78yPb80N+DNbSNPqFx4H4+g+2rg==
X-Received: by 2002:a05:622a:528b:b0:431:3e97:fb0b with SMTP id dr11-20020a05622a528b00b004313e97fb0bmr798997qtb.3.1711160124068;
        Fri, 22 Mar 2024 19:15:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSSiaxwf9qVJ61bWD658BkK6bIoISbqMAPHSz2R/uod8u0yF1+dnf1k4ZlNnixmtjYf7I/qg==
X-Received: by 2002:a05:622a:528b:b0:431:3e97:fb0b with SMTP id dr11-20020a05622a528b00b004313e97fb0bmr798965qtb.3.1711160123562;
        Fri, 22 Mar 2024 19:15:23 -0700 (PDT)
Received: from x1n ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id f9-20020a05622a114900b0043140cd9996sm152221qty.38.2024.03.22.19.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 19:15:23 -0700 (PDT)
Date: Fri, 22 Mar 2024 22:15:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Matthew Wilcox <willy@infradead.org>,
	Rik van Riel <riel@surriel.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yang Shi <shy828301@gmail.com>, John Hubbard <jhubbard@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Andrew Jones <andrew.jones@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Christoph Hellwig <hch@infradead.org>,
	linux-riscv@lists.infradead.org,
	James Houghton <jthoughton@google.com>,
	David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v3 12/12] mm/gup: Handle hugetlb in the generic
 follow_page_mask code
Message-ID: <Zf47OKjYjkUhs6AT@x1n>
References: <20240321220802.679544-1-peterx@redhat.com>
 <20240321220802.679544-13-peterx@redhat.com>
 <20240322134818.9b312f77629f79fcf1564b6f@linux-foundation.org>
 <Zf4mR_OxE5Ft4VJg@x1n>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zf4mR_OxE5Ft4VJg@x1n>

On Fri, Mar 22, 2024 at 08:45:59PM -0400, Peter Xu wrote:
> On Fri, Mar 22, 2024 at 01:48:18PM -0700, Andrew Morton wrote:
> > On Thu, 21 Mar 2024 18:08:02 -0400 peterx@redhat.com wrote:
> > 
> > > From: Peter Xu <peterx@redhat.com>
> > > 
> > > Now follow_page() is ready to handle hugetlb pages in whatever form, and
> > > over all architectures.  Switch to the generic code path.
> > > 
> > > Time to retire hugetlb_follow_page_mask(), following the previous
> > > retirement of follow_hugetlb_page() in 4849807114b8.
> > > 
> > > There may be a slight difference of how the loops run when processing slow
> > > GUP over a large hugetlb range on cont_pte/cont_pmd supported archs: each
> > > loop of __get_user_pages() will resolve one pgtable entry with the patch
> > > applied, rather than relying on the size of hugetlb hstate, the latter may
> > > cover multiple entries in one loop.
> > > 
> > > A quick performance test on an aarch64 VM on M1 chip shows 15% degrade over
> > > a tight loop of slow gup after the path switched.  That shouldn't be a
> > > problem because slow-gup should not be a hot path for GUP in general: when
> > > page is commonly present, fast-gup will already succeed, while when the
> > > page is indeed missing and require a follow up page fault, the slow gup
> > > degrade will probably buried in the fault paths anyway.  It also explains
> > > why slow gup for THP used to be very slow before 57edfcfd3419 ("mm/gup:
> > > accelerate thp gup even for "pages != NULL"") lands, the latter not part of
> > > a performance analysis but a side benefit.  If the performance will be a
> > > concern, we can consider handle CONT_PTE in follow_page().
> > > 
> > > Before that is justified to be necessary, keep everything clean and simple.
> > > 
> > 
> > mm/gup.c:33:21: warning: 'follow_hugepd' declared 'static' but never defined [-Wunused-function]
> >    33 | static struct page *follow_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
> >       |                     ^~~~~~~~~~~~~
> > 
> > --- a/mm/gup.c~mm-gup-handle-hugepd-for-follow_page-fix
> > +++ a/mm/gup.c
> > @@ -30,10 +30,12 @@ struct follow_page_context {
> >  	unsigned int page_mask;
> >  };
> >  
> > +#ifdef CONFIG_HAVE_FAST_GUP
> >  static struct page *follow_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
> >  				  unsigned long addr, unsigned int pdshift,
> >  				  unsigned int flags,
> >  				  struct follow_page_context *ctx);
> > +#endif
> >  
> >  static inline void sanity_check_pinned_pages(struct page **pages,
> >  					     unsigned long npages)
> > _
> > 
> > 
> > This looks inelegant.
> > 
> > That's two build issues so far.  Please be more expansive in the
> > Kconfig variations when testing.  Especially when mucking with pgtable
> > macros.
> 
> Andrew,
> 
> Apologies for that, and also for a slightly late response.  Yeah it's time
> I'll need my set of things to do serious build tests, and I'll at least
> start to cover a few error prone configs/archs in with that.
> 
> I was trying to rely on the build bot in many of previous such cases, as
> that was quite useful to me to cover many build issues without investing my
> own test setups, but I think for some reason it retired and stopped working
> for a while.  Maybe I shouldn't have relied on it at all.
> 
> For this specific issue, I'm not sure if CONFIG_HAVE_FAST_GUP is proper?
> As follow_hugepd() is used in slow gup not fast.  So maybe we can put that
> under CONFIG_MMU below that code (and I think we can drop "static" too as I
> don't think it's anything useful).  My version of fixup attached at the end

the static is useful; below patch did pass on m68k but won't on
x86.. ignore that please.

> of email, and I verified it on m68k build.
> 
> I do plan to post a small fixup series to fix these issues (so far it may
> contain 1 formal patch to touch up vmstat_item_print_in_thp, and 2 fixups
> where I'll mark the subject with "fixup!" properly).  Either you can pick
> up below or you can wait for my small patchset, should be there either
> today or tomorrow.

I changed plan here too; I found more users of HPAGE_PMD_NR assuming it's
defined even if !CONFIG_MMU.  That's weird, as CONFIG_MMU doesn't even
define PMD_SHIFT...  To fix this I decided to use the old trick on using
BUILD_BUG() like it used to work before; frankly I don't know how that
didn't throw warnings, but i'll make sure it passes all known builds (ps: I
still haven't got my build harness ready, so that will still be limited but
should solve known issues).

In short: please wait for my fixup series.  Thanks.

> 
> Thanks,
> 
> ===8<===
> diff --git a/mm/gup.c b/mm/gup.c
> index 4cd349390477..a2ed8203495a 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -30,11 +30,6 @@ struct follow_page_context {
>         unsigned int page_mask;
>  };
>  
> -static struct page *follow_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
> -                                 unsigned long addr, unsigned int pdshift,
> -                                 unsigned int flags,
> -                                 struct follow_page_context *ctx);
> -
>  static inline void sanity_check_pinned_pages(struct page **pages,
>                                              unsigned long npages)
>  {
> @@ -505,6 +500,12 @@ static inline void mm_set_has_pinned_flag(unsigned long *mm_flags)
>  }
>  
>  #ifdef CONFIG_MMU
> +
> +struct page *follow_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
> +                          unsigned long addr, unsigned int pdshift,
> +                          unsigned int flags,
> +                          struct follow_page_context *ctx);
> +
>  static struct page *no_page_table(struct vm_area_struct *vma,
>                                   unsigned int flags, unsigned long address)
>  {
> ===8<===
> 
> -- 
> Peter Xu

-- 
Peter Xu


