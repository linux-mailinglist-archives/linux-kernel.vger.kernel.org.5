Return-Path: <linux-kernel+bounces-112138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4035F887622
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 01:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECF6D284CB5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 00:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F8B623;
	Sat, 23 Mar 2024 00:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DvoqD8Lh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3707EDE
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 00:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711153833; cv=none; b=LF7iOF0ehE4HX9wSfE7XZ9y5x2td+oPvxQYtPaSRS4HHM9FZFJxB8bFX+cMP8hNT+bAggvuMP+xLmXkf77ytgyINAkki1Ph3JIVwQ+gok9jf/LnLxhCIkno58rVWxQy+E7Zj1gqzuGRvKZDKqharmm1HWZ4/LIPSc46qjbBVoGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711153833; c=relaxed/simple;
	bh=eDUnmack5CR8AHJe5tuRk+RrWAFaU7DscA2eLcDKh8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqg1vfjQ2G3NT3FBrtUCc04RdSkvtPGN2IPAFIv2u0HXNfN9COwTey5ykG3M1wXMyCBgQlV/iS3QxM+vcPOvhNhD0mN/3a3hpvd+lMu+5j3XO6FbDERJza9eZajRdatSkBfFW/lM+grWMk0LL0oV5I/l9jdwb4aa6d46SjZgfFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DvoqD8Lh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711153830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dXzFSacRUGOz3guP7FE0TFnIIG/3J2Y+D5Xv5mcIJ4I=;
	b=DvoqD8LhL6+PNudPvIUPa/bZZmtU+oguNK1vzlWrxy4yKM9weEpqAYEFUawxPlQuGKqHDr
	0lQd4KT7Is1JZc03CrOjFKcmn5wC9+dp/awFWelBG1PRa8osrTT/YDxSV4BeoUT1MnmW4X
	taJBca7ec6jeuRsfkalc/YoZmw+WBtk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-M2IWI7AVOpO1XlzYdDg2xQ-1; Fri, 22 Mar 2024 20:30:29 -0400
X-MC-Unique: M2IWI7AVOpO1XlzYdDg2xQ-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-43137863434so2142781cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 17:30:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711153829; x=1711758629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXzFSacRUGOz3guP7FE0TFnIIG/3J2Y+D5Xv5mcIJ4I=;
        b=EGDMHUxG7SPK6e7z2sfREocyEFKC+OAG/5wOVYD4jj0md0+gQnJwIdMq+/S+mNSRio
         Ot9ww9lou5dGzJ9ggI0KX8Z7LA2bIK3hCZCCFIWxRnL8DA3WJDnwU6YzfsqNOsEQbNOw
         QjF4xMMxXkj/8d6IukU1MkvZRWeudm4rd9L4IrZgGtZMjTAX7XOEvj55rEEjXzQDUQHI
         Ta9ofPx+8Y7GUneR819youRm2+mjSmSD9p8QfBykm/toi8poNEYknfi/ha5PamOLG0DC
         ab8RRFxi1SqWPAyIQiM2qW+l0zjkA9DkdqJ0cGr261NbRZ0DytO6KfFZWAOQvu7GygC8
         0JaA==
X-Forwarded-Encrypted: i=1; AJvYcCWOnI6WHEiBw37wmk2j8n89nXXXfs7SuX5hZkg5NYGWATfSe8mUKVv03XNmYG9m1schjdc8wBztNmuaeLv77qvW5qKTAkPYA5GkWZDu
X-Gm-Message-State: AOJu0Yyn1H2KrVEbAzQPiAChOeOuq9g9LTBxAc0luG50N0w8RhVacCKw
	83Lb1iDcBycYWvhx1dfcnoe0nFsQjDXbF9EUkPG211x5PWO89hpLNCsXAl8juhl6wGL5/qPgJqR
	ttXZeR9bI2Tv3NwrNiud9VPj/4ZAf/dc19tg73ZA4mC1i25uZuLdTQ148qacrLw==
X-Received: by 2002:a05:622a:1a97:b0:430:c2dc:a5ef with SMTP id s23-20020a05622a1a9700b00430c2dca5efmr1126582qtc.2.1711153828673;
        Fri, 22 Mar 2024 17:30:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3Zwwie8lW8e1zjPdHeXjIabqqIya++N3e9UmqxHEMxwmGbP31eJT5HvpFdJCDH7G39Ns7UA==
X-Received: by 2002:a05:622a:1a97:b0:430:c2dc:a5ef with SMTP id s23-20020a05622a1a9700b00430c2dca5efmr1126562qtc.2.1711153828186;
        Fri, 22 Mar 2024 17:30:28 -0700 (PDT)
Received: from x1n ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id fy15-20020a05622a5a0f00b00430911bac01sm315722qtb.74.2024.03.22.17.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 17:30:27 -0700 (PDT)
Date: Fri, 22 Mar 2024 20:30:24 -0400
From: Peter Xu <peterx@redhat.com>
To: SeongJae Park <sj@kernel.org>
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
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Christoph Hellwig <hch@infradead.org>,
	linux-riscv@lists.infradead.org,
	James Houghton <jthoughton@google.com>,
	David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v3 03/12] mm: Make HPAGE_PXD_* macros even if !THP
Message-ID: <Zf4ioDkuSNJ0f1vR@x1n>
References: <20240321220802.679544-4-peterx@redhat.com>
 <20240322171456.118997-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240322171456.118997-1-sj@kernel.org>

On Fri, Mar 22, 2024 at 10:14:56AM -0700, SeongJae Park wrote:
> Hi Peter,

Hi, SeongJae,

> 
> On Thu, 21 Mar 2024 18:07:53 -0400 peterx@redhat.com wrote:
> 
> > From: Peter Xu <peterx@redhat.com>
> > 
> > These macros can be helpful when we plan to merge hugetlb code into generic
> > code.  Move them out and define them even if !THP.
> > 
> > We actually already defined HPAGE_PMD_NR for other reasons even if !THP.
> > Reorganize these macros.
> > 
> > Reviewed-by: Christoph Hellwig <hch@infradead.org>
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/linux/huge_mm.h | 17 ++++++-----------
> >  1 file changed, 6 insertions(+), 11 deletions(-)
> > 
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index de0c89105076..3bcdfc7e5d57 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -64,9 +64,6 @@ ssize_t single_hugepage_flag_show(struct kobject *kobj,
> >  				  enum transparent_hugepage_flag flag);
> >  extern struct kobj_attribute shmem_enabled_attr;
> >  
> > -#define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
> > -#define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
> > -
> >  /*
> >   * Mask of all large folio orders supported for anonymous THP; all orders up to
> >   * and including PMD_ORDER, except order-0 (which is not "huge") and order-1
> > @@ -87,14 +84,19 @@ extern struct kobj_attribute shmem_enabled_attr;
> >  #define thp_vma_allowable_order(vma, vm_flags, smaps, in_pf, enforce_sysfs, order) \
> >  	(!!thp_vma_allowable_orders(vma, vm_flags, smaps, in_pf, enforce_sysfs, BIT(order)))
> >  
> > -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >  #define HPAGE_PMD_SHIFT PMD_SHIFT
> >  #define HPAGE_PMD_SIZE	((1UL) << HPAGE_PMD_SHIFT)
> >  #define HPAGE_PMD_MASK	(~(HPAGE_PMD_SIZE - 1))
> > +#define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
> > +#define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
> >  
> >  #define HPAGE_PUD_SHIFT PUD_SHIFT
> >  #define HPAGE_PUD_SIZE	((1UL) << HPAGE_PUD_SHIFT)
> >  #define HPAGE_PUD_MASK	(~(HPAGE_PUD_SIZE - 1))
> > +#define HPAGE_PUD_ORDER (HPAGE_PUD_SHIFT-PAGE_SHIFT)
> > +#define HPAGE_PUD_NR (1<<HPAGE_PUD_ORDER)
> 
> I just found latest mm-unstable fails one of my build configurations[1] with
> below error.  'git bisect' says this is the first patch set started the
> failure.  I haven't looked in deep, but just reporting first.
> 
>     In file included from .../include/linux/mm.h:1115,
>                      from .../mm/vmstat.c:14:
>     .../mm/vmstat.c: In function 'zoneinfo_show_print':
>     .../include/linux/huge_mm.h:87:25: error: 'PMD_SHIFT' undeclared (first use in this function); did you mean 'PUD_SHIFT'?
>        87 | #define HPAGE_PMD_SHIFT PMD_SHIFT
>           |                         ^~~~~~~~~
> 
> [1] https://github.com/awslabs/damon-tests/blob/next/corr/tests/build_m68k.sh

Apologies for the issue.  This is caused by !CONFIG_MMU, I think.

I thought this would be fairly easy to fix by putting these macros under
CONFIG_PGTABLE_HAS_HUGE_LEAVES, however when doing this I could have found
some other issue that violates this rule.. mm/vmstat.c has referenced
HPAGE_PMD_NR even if vmstat_item_print_in_thp() wanted to guard it only
with CONFIG_THP.

/home/peterx/git/linux/mm/vmstat.c: In function 'zoneinfo_show_print':
/home/peterx/git/linux/mm/vmstat.c:1689:42: error: 'HPAGE_PMD_NR' undeclared (first use in this function)
 1689 |                                 pages /= HPAGE_PMD_NR;
      |                                          ^~~~~~~~~~~~
/home/peterx/git/linux/mm/vmstat.c:1689:42: note: each undeclared identifier is reported only once for each function it appears in
  CC      drivers/tty/tty_port.o
/home/peterx/git/linux/mm/vmstat.c: In function 'vmstat_start':
/home/peterx/git/linux/mm/vmstat.c:1822:33: error: 'HPAGE_PMD_NR' undeclared (first use in this function)
 1822 |                         v[i] /= HPAGE_PMD_NR;
      |                                 ^~~~~~~~~~~~
make[4]: *** [/home/peterx/git/linux/scripts/Makefile.build:243: mm/vmstat.o] Error 1

static __always_inline bool vmstat_item_print_in_thp(enum node_stat_item item)
{
        if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
                return false;
        ...
}

I think the problem is vmstat_item_print_in_thp() uses IS_ENABLED() however
that won't stop compiler from looking into the "if".. so it'll still try to
find the HPAGE_PMD_NR macro.

It means, I may need to further change vmstat_item_print_in_thp() to make
this work in the clean way.. by properly switching to a #ifdef.

For that I'll need to post a formal patch and add people to review.  I'll
keep you posted.

Side note: thank you for your script, just to mention make.cross has been
moved to kbuild/, and it'll also need kbuild.sh now to work.  So you may
want to fix your test script (and it worked for you because you kept the
old make.cross around), like:

  wget https://raw.githubusercontent.com/intel/lkp-tests/master/kbuild/make.cross -O ./bin/make.cross
  wget https://raw.githubusercontent.com/intel/lkp-tests/master/kbuild/kbuild.sh -O ./bin/kbuild.sh

Thanks,

-- 
Peter Xu


