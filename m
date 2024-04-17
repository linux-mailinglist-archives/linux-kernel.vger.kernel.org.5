Return-Path: <linux-kernel+bounces-148937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FBF8A8961
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2793284B79
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFC6148847;
	Wed, 17 Apr 2024 16:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y0M+6ya8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E83F16FF38
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713372825; cv=none; b=CycOUSm2T95l6oFqEYKw8F6qZuCj3M0QvE99ZzH/vzmXGXHEIB1N0jtVcH6x18wqyeUeYwaMrot7T4Lr5t1474LERC3+pgizOx/F5mPyM3fdKfZ68GqsjFKbWBCcXApkJmZe2pp4cUpIQ6hIlPDWkMgOhlluXvsNml/OcV5Mk4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713372825; c=relaxed/simple;
	bh=bQG1MaJUaFy8g/RwWGQeRbVd3yteYykZFW4in/5zhSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bw22jPNTsRQvCt/UXZXRVgaxTn9ocmGWKfJd5+e02yFRDmf+24IfsvAO9sa9K3C52Ru30QovR5q7ELAK/WFI7LUw/BPjfk1cYO6rqEKECRylk6Mm8+HR79WdzQuTbdLP/EXeRD2ipzFvl9Ezvvz3sm6y+Ub1UaRiR7qc+AGZPy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y0M+6ya8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713372822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H02MyDugUniOD5Yjk6O9xR+QftxPqn6fGk14KKlCFGA=;
	b=Y0M+6ya8NsNwWJQXVIoYD5Wh5KGuEo08/2zrIBIbjyImFhlyMFqOfWO0ZrKha7qc/mLdZn
	tQlyyCG8WbfOqmJ3KTfp2ZQ5YpSbqFN2nSd+ZClZReWtikET2PxzWuoBg5pHP+oEpyDVo5
	3DYha/Hy3OfepRymawrRF1cs5O9xbVs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-HkWj8JGSNXCkzTLwy-wtBg-1; Wed, 17 Apr 2024 12:53:39 -0400
X-MC-Unique: HkWj8JGSNXCkzTLwy-wtBg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-69b27e4ed7aso7606d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 09:53:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713372819; x=1713977619;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H02MyDugUniOD5Yjk6O9xR+QftxPqn6fGk14KKlCFGA=;
        b=DbT+SeEfkBgdKPLFLT3zHweKtZVExxt+9TB+IJawqndSQxG1nsYuXluV1DafPfXv8K
         WxpE33wYy4IzianNPB5NFoXvHtmM1TckH+fFyN2HEPCjLtwMwNHu/38L1gowVhHdFeXL
         WBinUyMV+zpm3aFCoEwcs4lfVR9Z7KoF5EYjFvsZCJMgdy9w1dwtV9VRLbEw9CYfVJfu
         c5wmVepfA9xKqMiDZ+MmzR34EkEqPXhCVIHwPiuca6Iaiug6kJrrxvwMem12wpDfxMjP
         +/OMjh73lsz2qkrH4GdKekK+sdnpr6FkKDIjvPEz2X3wsS5eEvV7Z3ZFLMfV0cK/WPc/
         adfA==
X-Gm-Message-State: AOJu0Yy72OGKSDGB4KFJGrjx3JszUhShvoXEBz0VEdls4LumQPAVwT9E
	YOFis/fQwzr2mm7lz87ECK+vSjYC6dc+Xmwb1VPUBEl0rGg3Ky9dHfvwUAbWsMcqOUZfyAlunsM
	IhbwxW2/5dw91Zl0ZqIYsoiDRSW/yRq1l09mBNaxMwaKTl9avSjPQDKhvWAsAnw==
X-Received: by 2002:a05:620a:2443:b0:78e:c793:14b2 with SMTP id h3-20020a05620a244300b0078ec79314b2mr19654580qkn.3.1713372818474;
        Wed, 17 Apr 2024 09:53:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0ciY3X1h8yZAfYCjUW47evOs8smKQz9wB6AiReJa8oNK5KXTgyDXgta4lHqk6A8oTjCxxRw==
X-Received: by 2002:a05:620a:2443:b0:78e:c793:14b2 with SMTP id h3-20020a05620a244300b0078ec79314b2mr19654539qkn.3.1713372817539;
        Wed, 17 Apr 2024 09:53:37 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id bl36-20020a05620a1aa400b0078efd872d3csm886416qkb.14.2024.04.17.09.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 09:53:37 -0700 (PDT)
Date: Wed, 17 Apr 2024 12:53:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nadav Amit <nadav.amit@gmail.com>,
	Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH] mm/page_table_check: Support userfault wr-protect entries
Message-ID: <Zh_-j56_0RWxd33E@x1n>
References: <20240415205259.2535077-1-peterx@redhat.com>
 <CA+CK2bCSs8om+7tO_Sq2fAUD+gzD_4unUXMtO9oRUB+=4biv-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bCSs8om+7tO_Sq2fAUD+gzD_4unUXMtO9oRUB+=4biv-Q@mail.gmail.com>

On Tue, Apr 16, 2024 at 05:34:50PM -0400, Pasha Tatashin wrote:
> Hi Peter,

Pasha,

> 
> Thanks for this patch, I like this extra checking logic, my comments below:

Thanks for taking a look.

> 
> On Mon, Apr 15, 2024 at 4:53 PM Peter Xu <peterx@redhat.com> wrote:
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
> >  arch/x86/include/asm/pgtable.h | 18 +-----------------
> >  mm/page_table_check.c          | 32 +++++++++++++++++++++++++++++++-
> 
> Please add the new logic to: Documentation/mm/page_table_check.rst

Will do.

> 
> >  2 files changed, 32 insertions(+), 18 deletions(-)
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
> > index af69c3c8f7c2..d4eb1212f0f5 100644
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
> > @@ -182,6 +184,23 @@ void __page_table_check_pud_clear(struct mm_struct *mm, pud_t pud)
> >  }
> >  EXPORT_SYMBOL(__page_table_check_pud_clear);
> >
> > +/* Whether the swap entry cached writable information */
> > +static inline bool swap_cached_writable(swp_entry_t entry)
> > +{
> > +       unsigned type = swp_type(entry);
> > +
> > +       return type == SWP_DEVICE_EXCLUSIVE_WRITE ||
> > +           type == SWP_MIGRATION_WRITE;
> > +}
> > +
> > +static inline void __page_table_check_pte(pte_t pte)
> 
> may be something like:
> page_table_check_new_pte() ? Naming is starting to get confusing. The
> idea for this function is to check the pte that is about to be set
> into the page table.

But then we keep __page_table_check_ptes_set() as is?

It feels more natural if we keep using those underscores if all the rest
does so.  The "_new" is also not matching with what you used to have as
"_set".  If you see that's how I carefully chose the current name, with the
hope to match everything..

No strong opinions on these, but let me know your final choice of such
name.  I'm happy to align that to your preference.

> 
> > +{
> > +       if (pte_present(pte) && pte_uffd_wp(pte))
> > +               WARN_ON_ONCE(pte_write(pte));
> > +       else if (is_swap_pte(pte) && pte_swp_uffd_wp(pte))
> > +               WARN_ON_ONCE(swap_cached_writable(pte_to_swp_entry(pte)));
> > +}
> > +
> >  void __page_table_check_ptes_set(struct mm_struct *mm, pte_t *ptep, pte_t pte,
> >                 unsigned int nr)
> >  {
> > @@ -190,18 +209,29 @@ void __page_table_check_ptes_set(struct mm_struct *mm, pte_t *ptep, pte_t pte,
> >         if (&init_mm == mm)
> >                 return;
> >
> > -       for (i = 0; i < nr; i++)
> > +       for (i = 0; i < nr; i++) {
> > +               __page_table_check_pte(pte);
> 
> This should really be called only once after this loop.

This is also my intention to keep it in the loop just to make it as generic
e.g. to have no assumption of "ignoring PFNs", and I didn't worry on perf
much as we'll read/write these ptes anyway, also because it's only enabled
for debugging kernels.

But I made it at least inaccurate by checking pte not *ptep..

How about I move it out, rename it to __page_table_check_pte_flags(pte)?

> 
> >                 __page_table_check_pte_clear(mm, ptep_get(ptep + i));
> > +       }
> >         if (pte_user_accessible_page(pte))
> >                 page_table_check_set(pte_pfn(pte), nr, pte_write(pte));
> >  }
> >  EXPORT_SYMBOL(__page_table_check_ptes_set);
> >
> > +static inline void __page_table_check_pmd(pmd_t pmd)
> 
> page_table_check_new_pmd() ?

This is the same "careful choice" of mine on that, same reasoning as
above on the pte helpers. :)

But again, let me know your final decision on the namings of both.

Thanks,

> 
> > +{
> > +       if (pmd_present(pmd) && pmd_uffd_wp(pmd))
> > +               WARN_ON_ONCE(pmd_write(pmd));
> > +       else if (is_swap_pmd(pmd) && pmd_swp_uffd_wp(pmd))
> > +               WARN_ON_ONCE(swap_cached_writable(pmd_to_swp_entry(pmd)));
> > +}
> > +
> >  void __page_table_check_pmd_set(struct mm_struct *mm, pmd_t *pmdp, pmd_t pmd)
> >  {
> >         if (&init_mm == mm)
> >                 return;
> >
> > +       __page_table_check_pmd(pmd);
> >         __page_table_check_pmd_clear(mm, *pmdp);
> >         if (pmd_user_accessible_page(pmd)) {
> >                 page_table_check_set(pmd_pfn(pmd), PMD_SIZE >> PAGE_SHIFT,
> > --
> > 2.44.0
> >
> 
> Thanks,
> Pasha
> 

-- 
Peter Xu


