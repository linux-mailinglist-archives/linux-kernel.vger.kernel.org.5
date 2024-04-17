Return-Path: <linux-kernel+bounces-149224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 765498A8D54
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D9D2282135
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C3C47F7D;
	Wed, 17 Apr 2024 20:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L3YQHP70"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC1579D8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 20:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713387257; cv=none; b=iNgZdab6XK5ECM7azZkUxGUOoKaC4C77HC+lJfmFZRdSifRQW2U05I75bcUr+sCZ6n0r/IUm3ZXZodMxgKIZU8LPirG75hHlNsrQNxnIW2HFBEoel+uh7UwBAoq/YNXGkkoCLCOTne9dE4eouHeccpiETmxq9YeDnbCNbhEYh6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713387257; c=relaxed/simple;
	bh=5trknKPDwgM3ZHXvlVM7xQdThaVM8cOkkHsieY9CaRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdWu7s1KC0LukfJqmyrRKDyPqMWjr6BJF7sMkV27AtA3Zzz7PvTdlYzsJSpIlLSYNes7oOv98A607ttT6UQMdzh1M1sA96shP4i+WfHpQSJoTqEzrhjf4rBJMzt232+f0HvVQlr9iHFITzci4XBIXJ+uNc5VGd7dUDcB1+RPynw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L3YQHP70; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713387254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WxVps9eo7fKiokjE5p2dXVAq1Ns0BOvxX7WHeY7GD0Y=;
	b=L3YQHP70fJLc3cT4lx5kbqMANuXFOrH+/6261MFrX+0Z6BX3ssSY0aBgONi5DqJOScPX/M
	BDaFVq6x5G0H4beqB4/Wvit8v06FXy9x7Jl2T4TWaNSgO6iV7gChMVgBKLnAebR/1/JOeR
	EFKizWVCBNGu+ef7sBC0wLfyvjYQACY=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-WktgbEZVOkmrKkbqcTIV6w-1; Wed, 17 Apr 2024 16:54:13 -0400
X-MC-Unique: WktgbEZVOkmrKkbqcTIV6w-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5aa35f3393bso43409eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 13:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713387253; x=1713992053;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WxVps9eo7fKiokjE5p2dXVAq1Ns0BOvxX7WHeY7GD0Y=;
        b=jW3jy9u3DUq6Nvbx3n736Jh0onIv0J4b+1z65/lk8+PkrxKtM5+sM7PvHsPuKImBsu
         j0IrL/OCJ3UC6y+gCDnfvnIAxlaIf13TTypsJegosaQ78AQTC8XgI66otCGmrB3eK2Hl
         iAWyPC64Ma7gLnTYJCm7Ky7ioCkXBp8K86q7opl1F5D5AEfUC4pvgLki1wv2kvCsZnmK
         yjVKIm/TpvxIwDJHQLmOCvbb4zriE882xbezHovF2IxMI/OH+4z22Er0JvrrGLeEF/wz
         d/HDhJ6Ml90cMs/uBlPNrl2tyjli2TgBLH+5oCe1z1GMV+b7lQP5528lggKGG5h1p6PO
         EbSQ==
X-Gm-Message-State: AOJu0YxtHo59JX56B9t1D8Sq79pCQJq/HO9HqHTQEy7knx9HpTX881HL
	rGc8egHq3Rjh/WxX80dfrvTHr6amur+b+XcWQeiN8SjgjH6+y8Qa/YN+YtQnru2pQ6o+qR6lIlx
	P3SSG8LcOSIq6J3pfIq3lgfc1ltn5mPRaXw3upFoiZtwu1q8nWJ7vObupnrW5pQ==
X-Received: by 2002:a4a:b605:0:b0:5aa:6a31:4f53 with SMTP id z5-20020a4ab605000000b005aa6a314f53mr967207oon.0.1713387252722;
        Wed, 17 Apr 2024 13:54:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWGUZrTe7cf5mjN8f+tB8tf5bzpBYCB+ahmV2tQBDGKxmqdwX9Gk5b28HM+irN2ttqKfx4nQ==
X-Received: by 2002:a4a:b605:0:b0:5aa:6a31:4f53 with SMTP id z5-20020a4ab605000000b005aa6a314f53mr967186oon.0.1713387252290;
        Wed, 17 Apr 2024 13:54:12 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id e15-20020ac8490f000000b00434d86fb403sm8417343qtq.86.2024.04.17.13.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 13:54:11 -0700 (PDT)
Date: Wed, 17 Apr 2024 16:54:09 -0400
From: Peter Xu <peterx@redhat.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Nadav Amit <nadav.amit@gmail.com>,
	Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH v3] mm/page_table_check: Support userfault wr-protect
 entries
Message-ID: <ZiA28R09uaJRKH7z@x1n>
References: <20240417192643.2671335-1-peterx@redhat.com>
 <CA+CK2bALaCPW-=vRxY=7por9qEi4Ap7arOkYgAzee6_mzTyizQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bALaCPW-=vRxY=7por9qEi4Ap7arOkYgAzee6_mzTyizQ@mail.gmail.com>

On Wed, Apr 17, 2024 at 03:44:29PM -0400, Pasha Tatashin wrote:
> On Wed, Apr 17, 2024 at 3:26 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > Allow page_table_check hooks to check over userfaultfd wr-protect criteria
> > upon pgtable updates.  The rule is no co-existance allowed for any writable
> > flag against userfault wr-protect flag.
> >
> > This should be better than c2da319c2e, where we used to only sanitize such
> > issues during a pgtable walk, but when hitting such issue we don't have a
> > good chance to know where does that writable bit came from [1], so that
> > even the pgtable walk exposes a kernel bug (which is still helpful on
> > triaging) but not easy to track and debug.
> >
> > Now we switch to track the source.  It's much easier too with the recent
> > introduction of page table check.
> >
> > There are some limitations with using the page table check here for
> > userfaultfd wr-protect purpose:
> >
> >   - It is only enabled with explicit enablement of page table check configs
> >   and/or boot parameters, but should be good enough to track at least
> >   syzbot issues, as syzbot should enable PAGE_TABLE_CHECK[_ENFORCED] for
> >   x86 [1].  We used to have DEBUG_VM but it's now off for most distros,
> >   while distros also normally not enable PAGE_TABLE_CHECK[_ENFORCED], which
> >   is similar.
> >
> >   - It conditionally works with the ptep_modify_prot API.  It will be
> >   bypassed when e.g. XEN PV is enabled, however still work for most of the
> >   rest scenarios, which should be the common cases so should be good
> >   enough.
> >
> >   - Hugetlb check is a bit hairy, as the page table check cannot identify
> >   hugetlb pte or normal pte via trapping at set_pte_at(), because of the
> >   current design where hugetlb maps every layers to pte_t... For example,
> >   the default set_huge_pte_at() can invoke set_pte_at() directly and lose
> >   the hugetlb context, treating it the same as a normal pte_t. So far it's
> >   fine because we have huge_pte_uffd_wp() always equals to pte_uffd_wp() as
> >   long as supported (x86 only).  It'll be a bigger problem when we'll
> >   define _PAGE_UFFD_WP differently at various pgtable levels, because then
> >   one huge_pte_uffd_wp() per-arch will stop making sense first.. as of now
> >   we can leave this for later too.
> >
> > This patch also removes commit c2da319c2e altogether, as we have something
> > better now.
> >
> > [1] https://lore.kernel.org/all/000000000000dce0530615c89210@google.com/
> >
> > Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> > v2:
> > - Rename __page_table_check_pxx() to page_table_check_pxx_flags(),
> >   meanwhile move the pte check out of the loop [Pasha]
> > - Fix build issues reported from the bot, also added SWP_DEVICE_WRITE which
> >   was overlooked before
> > v3:
> > - Add missing doc update [Pasha]
> > ---
> >  Documentation/mm/page_table_check.rst |  9 ++++++-
> >  arch/x86/include/asm/pgtable.h        | 18 +------------
> >  mm/page_table_check.c                 | 39 +++++++++++++++++++++++++++
> >  3 files changed, 48 insertions(+), 18 deletions(-)
> >
> > diff --git a/Documentation/mm/page_table_check.rst b/Documentation/mm/page_table_check.rst
> > index c12838ce6b8d..5bd1d987d76d 100644
> > --- a/Documentation/mm/page_table_check.rst
> > +++ b/Documentation/mm/page_table_check.rst
> > @@ -14,7 +14,7 @@ Page table check performs extra verifications at the time when new pages become
> >  accessible from the userspace by getting their page table entries (PTEs PMDs
> >  etc.) added into the table.
> >
> > -In case of detected corruption, the kernel is crashed. There is a small
> > +In case of most detected corruption, the kernel is crashed. There is a small
> >  performance and memory overhead associated with the page table check. Therefore,
> >  it is disabled by default, but can be optionally enabled on systems where the
> >  extra hardening outweighs the performance costs. Also, because page table check
> > @@ -22,6 +22,13 @@ is synchronous, it can help with debugging double map memory corruption issues,
> >  by crashing kernel at the time wrong mapping occurs instead of later which is
> >  often the case with memory corruptions bugs.
> >
> > +It can also be used to do page table entry checks over various flags, dump
> > +warnings when illegal combinations of entry flags are detected.  Currently,
> > +userfaultfd is the only user of such to sanity check wr-protect bit against
> > +any writable flags.  Illegal flag combinations will not directly cause data
> > +corruption in this case immediately, but that will cause read-only data to
> > +be writable, causing data corrupt when the page content is later modified.
> 
> I would replace: "causing data corrupt ..." to "leading to corruption ..."

OK.

> 
> > +
> >  Double mapping detection logic
> >  ==============================
> >
> > diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> > index 273f7557218c..65b8e5bb902c 100644
> > --- a/arch/x86/include/asm/pgtable.h
> > +++ b/arch/x86/include/asm/pgtable.h
> > @@ -388,23 +388,7 @@ static inline pte_t pte_wrprotect(pte_t pte)
> >  #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
> >  static inline int pte_uffd_wp(pte_t pte)
> >  {
> > -       bool wp = pte_flags(pte) & _PAGE_UFFD_WP;
> > -
> > -#ifdef CONFIG_DEBUG_VM
> > -       /*
> > -        * Having write bit for wr-protect-marked present ptes is fatal,
> > -        * because it means the uffd-wp bit will be ignored and write will
> > -        * just go through.
> > -        *
> > -        * Use any chance of pgtable walking to verify this (e.g., when
> > -        * page swapped out or being migrated for all purposes). It means
> > -        * something is already wrong.  Tell the admin even before the
> > -        * process crashes. We also nail it with wrong pgtable setup.
> > -        */
> > -       WARN_ON_ONCE(wp && pte_write(pte));
> > -#endif
> > -
> > -       return wp;
> > +       return pte_flags(pte) & _PAGE_UFFD_WP;
> >  }
> >
> >  static inline pte_t pte_mkuffd_wp(pte_t pte)
> > diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> > index af69c3c8f7c2..388bcf60d8b5 100644
> > --- a/mm/page_table_check.c
> > +++ b/mm/page_table_check.c
> > @@ -7,6 +7,8 @@
> >  #include <linux/kstrtox.h>
> >  #include <linux/mm.h>
> >  #include <linux/page_table_check.h>
> > +#include <linux/swap.h>
> > +#include <linux/swapops.h>
> >
> >  #undef pr_fmt
> >  #define pr_fmt(fmt)    "page_table_check: " fmt
> > @@ -182,6 +184,31 @@ void __page_table_check_pud_clear(struct mm_struct *mm, pud_t pud)
> >  }
> >  EXPORT_SYMBOL(__page_table_check_pud_clear);
> >
> > +/* Whether the swap entry cached writable information */
> > +static inline bool swap_cached_writable(swp_entry_t entry)
> > +{
> > +       unsigned type = swp_type(entry);
> > +
> > +#ifdef CONFIG_DEVICE_PRIVATE
> > +       if (type == SWP_DEVICE_EXCLUSIVE_WRITE || type == SWP_DEVICE_WRITE)
> > +               return true;
> > +#endif
> > +#ifdef CONFIG_MIGRATION
> > +       if (type == SWP_MIGRATION_WRITE)
> > +               return true;
> > +#endif
> > +
> > +       return false;
> > +}
> 
> This should be re-written like this:
> 
> static inline bool swap_cached_writable(swp_entry_t entry)
> {
>         return is_writable_device_exclusive_entry(entry) ||
>                 is_writable_device_private_entry(entry) ||
>                 is_writable_migration_entry(entry);
> }
> 
> Otherwise the patch looks good.

Oops, yes definitely..  I'll prepare one more.

-- 
Peter Xu


