Return-Path: <linux-kernel+bounces-132119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6847B898FDC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C9531C22D0F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771FC13B280;
	Thu,  4 Apr 2024 21:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqeQpyPC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E7A12D1EF
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 21:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712264684; cv=none; b=m+4l3r8ZolfmEiKRKSAXCmyxtNDnk45NKK7EMuWr+8baIx2kKysq4BatI3ENiq5P+1jwvs0nliuer2SnDLsWmtMQ2DuJlflDuvYfKYIP1zku8Xo9FIOLgo/fLRfojTPsY/dyhEA/czwQxiYwcrdM+TC7zWRWTDcaoCRo5spcKTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712264684; c=relaxed/simple;
	bh=xMpCcRwDZ/nxs064iLcAhPMEIwQ9TMPDjE0MRAeJxN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICAL3YDn7bGYyGcM7lpnIvZLAsEmu/iGUm1g4TwKjezBitPHL/j52tuj04vQoYKxf8z3xo/I6LhTaeepAz6K10KQTPt5kn79UwUMivswngkWFDwyx4ZULpbaCnzGq7SN5i8h8qUUbyDdUD2pvdgHsOvx2LZhimJF+qQDmoYZgdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JqeQpyPC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712264681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hUgDUhG3HIXFbkjkshMpADyV4u/Ui5LQyO5DFIIXqgk=;
	b=JqeQpyPC9J4XISDaPiNPQs+NyBFinw0PLk+XFxYO4kTQyTG2XypE5oyPnUISxHdAitfwHw
	WujDwum1nMWAPLkiryeh6gynFI9rWRQQh+5HSl/MAqPnrEqUyqEB26Hxv81jz7hOm0cn4O
	0HF3sEyn9LRPItMKDB5KjqYzihxLy/k=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-abTDMXaOMcq8AIqqXw2IhQ-1; Thu, 04 Apr 2024 17:04:40 -0400
X-MC-Unique: abTDMXaOMcq8AIqqXw2IhQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6993e4680d7so127896d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 14:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712264680; x=1712869480;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hUgDUhG3HIXFbkjkshMpADyV4u/Ui5LQyO5DFIIXqgk=;
        b=ZrLGecCklA3lzu5TOQOxAZdrFUUnvkH/cmNFFI9eJylGPPiaQXpdesfG4P0rdRBIEW
         67EeKfxBYGVeendj1ADlvU0/afHPrwAJxzfy2GNTXp4YxyPKunXuisqQJhQavjxl5sKR
         yHWvyy3Gd6YrnZvGhqiseEhQzB4liu+I9Xmy5KUBDCUMvdtf1wAIeW5fv1gJ9B89od+0
         wyk2uh2UXR/srr9OAq/XxQ/LGyg+d447AglXa79AxjKs6JlqZeBo/4USN7O2yarhYbH7
         i+E1sZpgcD81QKAk9L6do/VtfLY/9VavxIdzZL4ruBfH8h0AWt6rQ0q1uU2FG/Hv+ddM
         qPwg==
X-Forwarded-Encrypted: i=1; AJvYcCWGNPGmnPbr3juZRYpM9t24yREK/xYidiviFiku8sQgCkzeJdp6fGmlSHJ0vrCHKs3O2iVEa32YGJtsX4Pr77R4RK+JwtXpArqE4bBt
X-Gm-Message-State: AOJu0YzRFe3H1HDFxilw/o89nKJUNM57EZ+euqqnGlQ+t7ocLo64Hmn9
	p0zA+180naAvfXJ9715GvcAF51giHgnoR+MJZlIQEk8J2n++JbyHDLUX9mFhLv77iLddgtyHFsT
	tAfufo8tdDbdW2n9Eg74zw+Z12cdOcZa2oHAFeCNIXDUDIFc89JqL/aIsTj5R0Q==
X-Received: by 2002:a05:6214:da1:b0:690:c35c:7590 with SMTP id h1-20020a0562140da100b00690c35c7590mr3582421qvh.2.1712264679510;
        Thu, 04 Apr 2024 14:04:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGd25oECSiWeotr+DeqrKMuWiZa2C+O1IQw5Iq5hwr/oAUoe2kVPaxSIx4TWN3eZ1JafmxKGA==
X-Received: by 2002:a05:6214:da1:b0:690:c35c:7590 with SMTP id h1-20020a0562140da100b00690c35c7590mr3582391qvh.2.1712264678979;
        Thu, 04 Apr 2024 14:04:38 -0700 (PDT)
Received: from x1n ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id j9-20020a0ceb09000000b0069931523262sm61042qvp.129.2024.04.04.14.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 14:04:38 -0700 (PDT)
Date: Thu, 4 Apr 2024 17:04:36 -0400
From: Peter Xu <peterx@redhat.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Lokesh Gidra <lokeshgidra@google.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@android.com, aarcange@redhat.com, david@redhat.com,
	zhengqi.arch@bytedance.com, kaleshsingh@google.com,
	ngeoffray@google.com
Subject: Re: [PATCH] userfaultfd: change src_folio after ensuring it's
 unpinned in UFFDIO_MOVE
Message-ID: <Zg8V5OycPYYk7-Qp@x1n>
References: <20240404171726.2302435-1-lokeshgidra@google.com>
 <Zg7hrt5HudXLBUn_@casper.infradead.org>
 <Zg8OYYV7DDo7S2Yf@x1n>
 <CAJuCfpGHe2=noJomL0XonT4dVGvZmVujRMEbgpYgVg_d5wo-+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGHe2=noJomL0XonT4dVGvZmVujRMEbgpYgVg_d5wo-+g@mail.gmail.com>

On Thu, Apr 04, 2024 at 01:55:07PM -0700, Suren Baghdasaryan wrote:
> On Thu, Apr 4, 2024 at 1:32 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Thu, Apr 04, 2024 at 06:21:50PM +0100, Matthew Wilcox wrote:
> > > On Thu, Apr 04, 2024 at 10:17:26AM -0700, Lokesh Gidra wrote:
> > > > -           folio_move_anon_rmap(src_folio, dst_vma);
> > > > -           WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, dst_addr));
> > > > -
> > > >             src_pmdval = pmdp_huge_clear_flush(src_vma, src_addr, src_pmd);
> > > >             /* Folio got pinned from under us. Put it back and fail the move. */
> > > >             if (folio_maybe_dma_pinned(src_folio)) {
> > > > @@ -2270,6 +2267,9 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
> > > >                     goto unlock_ptls;
> > > >             }
> > > >
> > > > +           folio_move_anon_rmap(src_folio, dst_vma);
> > > > +           WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, dst_addr));
> > > > +
> > >
> > > This use of WRITE_ONCE scares me.  We hold the folio locked.  Why do
> > > we need to use WRITE_ONCE?  Who's looking at folio->index without
> > > holding the folio lock?
> >
> > Seems true, but maybe suitable for a separate patch to clean it even so?
> > We also have the other pte level which has the same WRITE_ONCE(), so if we
> > want to drop we may want to drop both.
> 
> Yes, I'll do that separately and will remove WRITE_ONCE() in both places.

Thanks, Suren.  Besides, any comment on below?

It's definely a generic per-vma question too (besides my willingness to
remove that userfault specific code..), so comments welcomed.

> 
> >
> > I just got to start reading some the new move codes (Lokesh, apologies on
> > not be able to provide feedbacks previously..), but then I found one thing
> > unclear, on special handling of private file mappings only in userfault
> > context, and I didn't know why:
> >
> > lock_vma():
> >         if (vma) {
> >                 /*
> >                  * lock_vma_under_rcu() only checks anon_vma for private
> >                  * anonymous mappings. But we need to ensure it is assigned in
> >                  * private file-backed vmas as well.
> >                  */
> >                 if (!(vma->vm_flags & VM_SHARED) && unlikely(!vma->anon_vma))
> >                         vma_end_read(vma);
> >                 else
> >                         return vma;
> >         }
> >
> > AFAIU even for generic users of lock_vma_under_rcu(), anon_vma must be
> > stable to be used.  Here it's weird to become an userfault specific
> > operation to me.
> >
> > I was surprised how it worked for private file maps on faults, then I had a
> > check and it seems we postponed such check until vmf_anon_prepare(), which
> > is the CoW path already, so we do as I expected, but seems unnecessary to
> > that point?
> >
> > Would something like below make it much cleaner for us?  As I just don't
> > yet see why userfault is special here.
> >
> > Thanks,
> >
> > ===8<===
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 984b138f85b4..d5cf1d31c671 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3213,10 +3213,8 @@ vm_fault_t vmf_anon_prepare(struct vm_fault *vmf)
> >
> >         if (likely(vma->anon_vma))
> >                 return 0;
> > -       if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> > -               vma_end_read(vma);
> > -               return VM_FAULT_RETRY;
> > -       }
> > +       /* We shouldn't try a per-vma fault at all if anon_vma isn't solid */
> > +       WARN_ON_ONCE(vmf->flags & FAULT_FLAG_VMA_LOCK);
> >         if (__anon_vma_prepare(vma))
> >                 return VM_FAULT_OOM;
> >         return 0;
> > @@ -5817,9 +5815,9 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
> >          * find_mergeable_anon_vma uses adjacent vmas which are not locked.
> >          * This check must happen after vma_start_read(); otherwise, a
> >          * concurrent mremap() with MREMAP_DONTUNMAP could dissociate the VMA
> > -        * from its anon_vma.
> > +        * from its anon_vma.  This applies to both anon or private file maps.
> >          */
> > -       if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma))
> > +       if (unlikely(!(vma->vm_flags & VM_SHARED) && !vma->anon_vma))
> >                 goto inval_end_read;
> >
> >         /* Check since vm_start/vm_end might change before we lock the VMA */
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index f6267afe65d1..61f21da77dcd 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -72,17 +72,8 @@ static struct vm_area_struct *lock_vma(struct mm_struct *mm,
> >         struct vm_area_struct *vma;
> >
> >         vma = lock_vma_under_rcu(mm, address);
> > -       if (vma) {
> > -               /*
> > -                * lock_vma_under_rcu() only checks anon_vma for private
> > -                * anonymous mappings. But we need to ensure it is assigned in
> > -                * private file-backed vmas as well.
> > -                */
> > -               if (!(vma->vm_flags & VM_SHARED) && unlikely(!vma->anon_vma))
> > -                       vma_end_read(vma);
> > -               else
> > -                       return vma;
> > -       }
> > +       if (vma)
> > +               return vma;
> >
> >         mmap_read_lock(mm);
> >         vma = find_vma_and_prepare_anon(mm, address);
> > --
> > 2.44.0
> >
> >
> > --
> > Peter Xu
> >
> 

-- 
Peter Xu


