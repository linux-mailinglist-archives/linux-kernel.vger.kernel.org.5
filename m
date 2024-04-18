Return-Path: <linux-kernel+bounces-149852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AC08A96CE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45D69B22E3A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C52715B548;
	Thu, 18 Apr 2024 09:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZldljFQX"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D5F15AAAD;
	Thu, 18 Apr 2024 09:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713434121; cv=none; b=gd4sE74m3uDLMsJW+NHA+OPxmJw3Ptg7H8bMgYcaBMm3CfE3XFinL3OOhC7V4BHE4lk1VK5MlfuTvoohG8+Af8eqLVj0LWemGiCufaTval5sxkaFi3wEMjYIrWwiqQpif5kZ/JezPcd7m7KjTiWXfU3cJqoLGk42GExZZ4qODX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713434121; c=relaxed/simple;
	bh=3O4VXBmq13hTwbbI7YnN0BOaaWIeJbncdRXQP4KB/68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eW6c7ABlzOiCFQns+g9tQMnmutKkTKkDCgwsCncrUNjWgK5nWnnLAIHPPT202F3aKIlJAOSfOQfzmwHdb2+ifATua0O9Opt/IKlY6Ys+i2ocGQb6dx62aOPkTVAnfwwksXDoqXaP+36Xgjh+I44k9CBzBlhX7Sv9L3cI3cK/uCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZldljFQX; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-479dd0261c8so794959137.0;
        Thu, 18 Apr 2024 02:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713434119; x=1714038919; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=23lIG3TvMr9vKJrzIXmok+99Y+uLlvdIb8Z9VEsm6UA=;
        b=ZldljFQXX26Hob/f/y/waUER6JboYUBDfR2j6yXqNHrlnWlF+e+QdL3ipdOGeVTG+a
         5UfuGBRVZ4VGkHdmt8w4KVnlt2kpW5g9MwyGd+q/GT8hnQtWP+hETtQXN0mQQyek+2oN
         ltkMSC6bv/H5+DO5BFLlBkEvfOQzlhNRU2o1gmO8LNZDoE971zQ3YWUrNvZtrDkbVRAT
         1cxvKh8TA7iY96I6y4d8kcRshTXkQCis7RcNzpkBqdDeyDbiPDoAKfFsDAmGneWLNnVK
         iVVGXSUlsIfLJ2moy0EZ/13IjeyzLmLe1fxbrNW1zsDFERb1FvPxdRt/WZJGiLBqKFF1
         gtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713434119; x=1714038919;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=23lIG3TvMr9vKJrzIXmok+99Y+uLlvdIb8Z9VEsm6UA=;
        b=oFshnPRAS4ye2VsN1lZBZjJOA57Qzi5kt5lakdTFGwOYW+mjDuSomY39EQ/uVGTUz9
         HoSXsbOZfxndN+O/ucVsfL252lY2xllPi9cZm7/2B/dwYxS2wYOtXY46FeQ8KNg1YnxF
         bLdl1a5gKajve74/sPSunP3CbnXawgu6YykohYEAvDf97awWD3I+KYYFg2aT2pnK+EaI
         d/OiGHDSA183fXjDTt03X7nFMD5tIGmYqyhcLSW/9U9swxWR0kVVs8l34nL6ksa4LFjJ
         7iD5jGr9tB4hKxOXM8bencylgWZpRp61K8+JM/VteNRgHrtM4Q/JtVwiwaA+t8xpYRA+
         IUPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmCk3yHCIcQ0c/wXGfYbvg6rXfLVwg2Y0aPPMyR+z2XjH6iC+7J4IbbYy+m0sh27FeuJs2LSdTF/dokr0vwhD2Lz7x3NhB/9GnI43Nm1jsYijfHmvZSEClYM6dT5ZNcc0BltAjTCR1fA==
X-Gm-Message-State: AOJu0YzWlCPXwdisROzs5tpf5HXEnclf+bJrJlW8tvyD5oKlIK00aSh1
	cYfB4UbY+x+HRoDzNUfWE8ZlyFNRqQOhmOEIJI7WLdYZh3VPy7fMVzabKGrUD0ikOkjmcAg9fj+
	1X/GpKclqhTg0vFdjuyXO+cubVx8=
X-Google-Smtp-Source: AGHT+IHGbdjFtzwMlZyafVRC/B4/XYa6y0rqJeTmsifzombtE+Knj8iAIOzodI0FPv9LCko1GnibHJF+bInK7wUSYo8=
X-Received: by 2002:a05:6102:3b8a:b0:47b:beaf:b4d1 with SMTP id
 z10-20020a0561023b8a00b0047bbeafb4d1mr750162vsu.14.1713434119202; Thu, 18 Apr
 2024 02:55:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409082631.187483-1-21cnbao@gmail.com> <20240409082631.187483-5-21cnbao@gmail.com>
 <87frvn2f89.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4x_bOchG=bJjR8WE=vQxu3ke8fkxcDOFhqX5FS_a-0heA@mail.gmail.com>
 <8734rm2gdj.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4xHVN_QXu5Q8c_FcjsnffZYWsjOx4KR4G_2GNyaxfVWAw@mail.gmail.com>
In-Reply-To: <CAGsJ_4xHVN_QXu5Q8c_FcjsnffZYWsjOx4KR4G_2GNyaxfVWAw@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 18 Apr 2024 21:55:07 +1200
Message-ID: <CAGsJ_4yOrn3OP-jP+hZxrb__AarK+U7Pc15z0XmQ26RmT7h8xQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] mm: swap: entirely map large folios found in swapcache
To: "Huang, Ying" <ying.huang@intel.com>, Khalid Aziz <khalid.aziz@oracle.com>, 
	sparclinux@vger.kernel.org
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hanchuanhua@oppo.com, hannes@cmpxchg.org, hughd@google.com, 
	kasong@tencent.com, ryan.roberts@arm.com, surenb@google.com, 
	v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org, 
	yosryahmed@google.com, yuzhao@google.com, ziy@nvidia.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[snip]

> > >> >
> > >> >       VM_BUG_ON(!folio_test_anon(folio) ||
> > >> >                       (pte_write(pte) && !PageAnonExclusive(page)));
> > >> > -     set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
> > >> > -     arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);
> > >> > +     set_ptes(vma->vm_mm, start_address, start_pte, pte, nr_pages);
> > >> > +     vmf->orig_pte = ptep_get(vmf->pte);
> > >> > +     arch_do_swap_page(vma->vm_mm, vma, start_address, pte, pte);
> > >>
> > >> Do we need to call arch_do_swap_page() for each subpage?  IIUC, the
> > >> corresponding arch_unmap_one() will be called for each subpage.
> > >
> > > i actually thought about this very carefully, right now, the only one who
> > > needs this is sparc and it doesn't support THP_SWAPOUT at all. and
> > > there is no proof doing restoration one by one won't really break sparc.
> > > so i'd like to defer this to when sparc really needs THP_SWAPOUT.
> >
> > Let's ask SPARC developer (Cced) for this.
> >
> > IMHO, even if we cannot get help, we need to change code with our
> > understanding instead of deferring it.
>
> ok. Thanks for Ccing sparc developers.

Hi Khalid & Ying (also Cced sparc maillist),

SPARC is the only platform which needs arch_do_swap_page(), right now,
its THP_SWAPOUT is not enabled. so we will not really hit a large folio
in swapcache. just in case you might need THP_SWAPOUT later, i am
changing the code as below,

@@ -4286,7 +4285,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
        VM_BUG_ON(!folio_test_anon(folio) ||
                        (pte_write(pte) && !PageAnonExclusive(page)));
        set_ptes(vma->vm_mm, start_address, start_ptep, pte, nr_pages);
-       arch_do_swap_page(vma->vm_mm, vma, start_address, pte, pte);
+       for (int i = 0; i < nr_pages; i++) {
+               arch_do_swap_page(vma->vm_mm, vma, start_address + i *
PAGE_SIZE,
+                                 pte, pte);
+               pte = pte_advance_pfn(pte, 1);
+       }

        folio_unlock(folio);
        if (folio != swapcache && swapcache) {

for sparc, nr_pages will always be 1(THP_SWAPOUT not enabled). for
arm64/x86/riscv,
it seems redundant to do a for loop "for (int i = 0; i < nr_pages; i++)".

so another option is adding a helper as below to avoid the idle loop
for arm64/x86/riscv etc.

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index e2f45e22a6d1..ea314a5f9b5e 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1085,6 +1085,28 @@ static inline void arch_do_swap_page(struct
mm_struct *mm,
 {

 }
+
+static inline void arch_do_swap_page_nr(struct mm_struct *mm,
+                                    struct vm_area_struct *vma,
+                                    unsigned long addr,
+                                    pte_t pte, pte_t oldpte,
+                                    int nr)
+{
+
+}
+#else
+static inline void arch_do_swap_page_nr(struct mm_struct *mm,
+                                    struct vm_area_struct *vma,
+                                    unsigned long addr,
+                                    pte_t pte, pte_t oldpte,
+                                    int nr)
+{
+       for (int i = 0; i < nr; i++) {
+               arch_do_swap_page(vma->vm_mm, vma, addr + i * PAGE_SIZE,
+                                pte_advance_pfn(pte, i),
+                                pte_advance_pfn(oldpte, i));
+       }
+}
 #endif

Please tell me your preference.

BTW, i found oldpte and pte are always same in do_swap_page(), is it
something wrong? does arch_do_swap_page() really need two same
arguments?


vmf->orig_pte = pte;
..
arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);


>
> >
> > > on the other hand, it seems really bad we have both
> > > arch_swap_restore  - for this, arm64 has moved to using folio
> > > and
> > > arch_do_swap_page
> > >
> > > we should somehow unify them later if sparc wants THP_SWPOUT.

Thanks
Barry

