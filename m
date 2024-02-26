Return-Path: <linux-kernel+bounces-80438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78ECE86686E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CBA01C215F8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575D81B7E3;
	Mon, 26 Feb 2024 02:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvhIQhfe"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691591B275
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 02:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708916394; cv=none; b=KwnlFKyvttQk1rGaQojm+BrM6Zz4barrLk5dN/tO9v7A3o6l0v3PpCYvD/9cqwUK1ZvVD/15i9EpMM3+kuERndyGU15UJLOzyA9lQJQ6ZUJTAq6ZlNd6NSGeSUV1OheDvn/HCJUTd4UH7AHql2pXyGTkNMnhKHZNJQ8KQYw3zPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708916394; c=relaxed/simple;
	bh=QPW/fOjEHbRQAlGyIo5vpERAVGCVVbQEDn6YX5i9X64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o3wk1dmJRK6U8Np9mJB8/srEpbWWjhD2WoPhIKawQkmEJe1Ns2gwmsBYnxiiL/gtXdtx79fnbaAVnhz2tIiW7j1sMlKjQ6/C2un59mReUbOZQwxndNJMNHA25YVwC6ys0TI5EB06370GvzSmpAzY95fWXBYFLepTRQW1h0To7lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvhIQhfe; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7d5c40f874aso1307573241.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 18:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708916391; x=1709521191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxgyv7Hl9XGA+yew2AuEx/r3B9iAfdwbZeCvSOYqb0g=;
        b=jvhIQhfeod25T7gpuPim4b5D2Rejx+zgySbutBYfhEuhwuttFKR+Pn9aInDb3o5fnt
         eP+kEV389LiukOs/+z0VY7iamASJkhM0pGokekViYS8ePp7eulbw44BWVm028flLGgRS
         0NmZAw5qGOzx8owg3NF/CV/97mGEojxcEfcZaW7ROe1ZNBhjJCYvNTD0ygGJCATXLdrd
         mqins7OuuPQuMvSg+lRzR7q5emF3POqh0F2lY9n0L2VgtP+MOM4L3hNN3MLhxwBJ+Vwb
         aD4OUkvt5xLZ46UvRilr67mJqeeY92PKxIOwvGJ2Sw3t9k5jtBdrPX66gb5bo8htS7Eo
         dEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708916391; x=1709521191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxgyv7Hl9XGA+yew2AuEx/r3B9iAfdwbZeCvSOYqb0g=;
        b=Sfv32jHfqWz/j6GwZSUiRh6UA6GjSL4vdMWZYUjvIrTUu/AIgdJ9Wdk9M6RsnEQAF7
         pYWD1voSCnUDLxwtGTa9euJtfYCYGSFiKSPtDb1IOQwztHdkhemt8Bz/j2ebmerutMxU
         M9et8zX9zAndF5PNc2xVZjCQyDgQ2zI+FRD6GNfCexKUt2c6hIZ2vcmgijWEEG8is7HM
         bXdgX6xqAqo3r/xP0GlOH/7aUJjNBRlm+aiECDaFjXAwmKcNTfI3+WRZe55P+wGuqOSL
         18SecWA4g8Fax1x7XG+jSAXm4vqpceK2Ua7j3oZHOC3WoyQP4fOOUxoioh8FuDCx8SP0
         qlMg==
X-Forwarded-Encrypted: i=1; AJvYcCUDSZMHQOLnSWxR70Z95SE5z1bKUC0t3z68yFciVhI18z3wcDh6HXh56L2m8B0x/+s2hdGRf7LFzG7Ox3dTvqrnB2RCZ7OKJv/2LEbV
X-Gm-Message-State: AOJu0Yz2aMofP+jbl88P4zvdCQScaWsUnvqQP6SvDL8/xFB5Bpc85zq3
	6fedXEwjF/5FSno7YkgH2j9TwVZmMMExYcHmhvTe1ImSc8ZbR7/Bq8hcLDlx56fjfkqqokukesq
	uNCW6Z0+Geb9JZ6CF6CyvwE/whCU=
X-Google-Smtp-Source: AGHT+IF7+ggaYaKgeJw+F1HL9Ggy+Zjxt9GGCumvpwnyrkhV9VS3BOVEWt8GVMzYyTN6Ero1/F+4FilHOSKHi3I89Pk=
X-Received: by 2002:a1f:4843:0:b0:4c9:98f8:83d0 with SMTP id
 v64-20020a1f4843000000b004c998f883d0mr2484773vka.0.1708916391205; Sun, 25 Feb
 2024 18:59:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025144546.577640-1-ryan.roberts@arm.com> <20240118111036.72641-1-21cnbao@gmail.com>
 <20240118111036.72641-2-21cnbao@gmail.com> <CAF8kJuPtR86rhZ1-8Y96w36-+J2qgzJh=tWJCtCmVjaqYHJqqA@mail.gmail.com>
In-Reply-To: <CAF8kJuPtR86rhZ1-8Y96w36-+J2qgzJh=tWJCtCmVjaqYHJqqA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 26 Feb 2024 15:59:40 +1300
Message-ID: <CAGsJ_4xa1rNS_mKqAvvU0GFHf4tZRGJSUZ+SxbmuucpAv=eQFw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/6] arm64: mm: swap: support THP_SWAP on hardware
 with MTE
To: Chris Li <chrisl@kernel.org>
Cc: ryan.roberts@arm.com, akpm@linux-foundation.org, david@redhat.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com, 
	shy828301@gmail.com, wangkefeng.wang@huawei.com, willy@infradead.org, 
	xiang@kernel.org, ying.huang@intel.com, yuzhao@google.com, surenb@google.com, 
	steven.price@arm.com, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

Thanks for reviewing. sorry for the late reply as I=E2=80=99ve been getting=
 a lot to do
recently.

On Sat, Jan 27, 2024 at 12:14=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote=
:
>
> On Thu, Jan 18, 2024 at 3:11=E2=80=AFAM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > Commit d0637c505f8a1 ("arm64: enable THP_SWAP for arm64") brings up
> > THP_SWAP on ARM64, but it doesn't enable THP_SWP on hardware with
> > MTE as the MTE code works with the assumption tags save/restore is
> > always handling a folio with only one page.
> >
> > The limitation should be removed as more and more ARM64 SoCs have
> > this feature. Co-existence of MTE and THP_SWAP becomes more and
> > more important.
> >
> > This patch makes MTE tags saving support large folios, then we don't
> > need to split large folios into base pages for swapping out on ARM64
> > SoCs with MTE any more.
> >
> > arch_prepare_to_swap() should take folio rather than page as parameter
> > because we support THP swap-out as a whole. It saves tags for all
> > pages in a large folio.
> >
> > As now we are restoring tags based-on folio, in arch_swap_restore(),
> > we may increase some extra loops and early-exitings while refaulting
> > a large folio which is still in swapcache in do_swap_page(). In case
> > a large folio has nr pages, do_swap_page() will only set the PTE of
> > the particular page which is causing the page fault.
> > Thus do_swap_page() runs nr times, and each time, arch_swap_restore()
> > will loop nr times for those subpages in the folio. So right now the
> > algorithmic complexity becomes O(nr^2).
> >
> > Once we support mapping large folios in do_swap_page(), extra loops
> > and early-exitings will decrease while not being completely removed
> > as a large folio might get partially tagged in corner cases such as,
> > 1. a large folio in swapcache can be partially unmapped, thus, MTE
> > tags for the unmapped pages will be invalidated;
> > 2. users might use mprotect() to set MTEs on a part of a large folio.
> >
> > arch_thp_swp_supported() is dropped since ARM64 MTE was the only one
> > who needed it.
> >
> > Reviewed-by: Steven Price <steven.price@arm.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  arch/arm64/include/asm/pgtable.h | 21 +++-------------
> >  arch/arm64/mm/mteswap.c          | 42 ++++++++++++++++++++++++++++++++
> >  include/linux/huge_mm.h          | 12 ---------
> >  include/linux/pgtable.h          |  2 +-
> >  mm/page_io.c                     |  2 +-
> >  mm/swap_slots.c                  |  2 +-
> >  6 files changed, 49 insertions(+), 32 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/=
pgtable.h
> > index 79ce70fbb751..9902395ca426 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -45,12 +45,6 @@
> >         __flush_tlb_range(vma, addr, end, PUD_SIZE, false, 1)
> >  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> >
> > -static inline bool arch_thp_swp_supported(void)
> > -{
> > -       return !system_supports_mte();
> > -}
> > -#define arch_thp_swp_supported arch_thp_swp_supported
> > -
> >  /*
> >   * Outside of a few very special situations (e.g. hibernation), we alw=
ays
> >   * use broadcast TLB invalidation instructions, therefore a spurious p=
age
> > @@ -1042,12 +1036,8 @@ static inline pmd_t pmdp_establish(struct vm_are=
a_struct *vma,
> >  #ifdef CONFIG_ARM64_MTE
> >
> >  #define __HAVE_ARCH_PREPARE_TO_SWAP
> > -static inline int arch_prepare_to_swap(struct page *page)
> > -{
> > -       if (system_supports_mte())
> > -               return mte_save_tags(page);
> > -       return 0;
> > -}
> > +#define arch_prepare_to_swap arch_prepare_to_swap
>
> This seems a noop, define "arch_prepare_to_swap" back to itself.
> What am I missing?
>
> I see. Answer my own question, I guess you want to allow someone to
> overwrite the arch_prepare_to_swap.
> Wouldn't testing against  __HAVE_ARCH_PREPARE_TO_SWAP enough to support t=
hat?

you are right. i was blindly copying my previous code

static inline bool arch_thp_swp_supported(void)
{
        return !system_supports_mte();
}
#define arch_thp_swp_supported arch_thp_swp_supported

for arch_thp_swp_supported, there isn't a similar MACRO. so we are dependin=
g
on arch_thp_swp_supported as a MACRO for itself in include/linux/huge_mm.h.

/*
 * archs that select ARCH_WANTS_THP_SWAP but don't support THP_SWP due to
 * limitations in the implementation like arm64 MTE can override this to
 * false
 */
#ifndef arch_thp_swp_supported
static inline bool arch_thp_swp_supported(void)
{
        return true;
}
#endif

Now the case is different, we do have  __HAVE_ARCH_PREPARE_TO_SWAP
instead.

>
> Maybe I need to understand better how you want others to extend this
> code to make suggestions.
> As it is, this looks strange.
>
> > +extern int arch_prepare_to_swap(struct folio *folio);
> >
> >  #define __HAVE_ARCH_SWAP_INVALIDATE
> >  static inline void arch_swap_invalidate_page(int type, pgoff_t offset)
> > @@ -1063,11 +1053,8 @@ static inline void arch_swap_invalidate_area(int=
 type)
> >  }
> >
> >  #define __HAVE_ARCH_SWAP_RESTORE
> > -static inline void arch_swap_restore(swp_entry_t entry, struct folio *=
folio)
> > -{
> > -       if (system_supports_mte())
> > -               mte_restore_tags(entry, &folio->page);
> > -}
> > +#define arch_swap_restore arch_swap_restore
>
> Same here.

you are right, again.

>
> > +extern void arch_swap_restore(swp_entry_t entry, struct folio *folio);
> >
> >  #endif /* CONFIG_ARM64_MTE */
> >
> > diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
> > index a31833e3ddc5..b9ca1b35902f 100644
> > --- a/arch/arm64/mm/mteswap.c
> > +++ b/arch/arm64/mm/mteswap.c
> > @@ -68,6 +68,13 @@ void mte_invalidate_tags(int type, pgoff_t offset)
> >         mte_free_tag_storage(tags);
> >  }
> >
> > +static inline void __mte_invalidate_tags(struct page *page)
> > +{
> > +       swp_entry_t entry =3D page_swap_entry(page);
> > +
> > +       mte_invalidate_tags(swp_type(entry), swp_offset(entry));
> > +}
> > +
> >  void mte_invalidate_tags_area(int type)
> >  {
> >         swp_entry_t entry =3D swp_entry(type, 0);
> > @@ -83,3 +90,38 @@ void mte_invalidate_tags_area(int type)
> >         }
> >         xa_unlock(&mte_pages);
> >  }
> > +
> > +int arch_prepare_to_swap(struct folio *folio)
> > +{
> > +       int err;
> > +       long i;
> > +
> > +       if (system_supports_mte()) {
> Very minor nitpick.
>
> You can do
> if (!system_supports_mte())
>     return 0;
>
> Here and the for loop would have less indent. The function looks flatter.

I agree.

>
> > +               long nr =3D folio_nr_pages(folio);
> > +
> > +               for (i =3D 0; i < nr; i++) {
> > +                       err =3D mte_save_tags(folio_page(folio, i));
> > +                       if (err)
> > +                               goto out;
> > +               }
> > +       }
> > +       return 0;
> > +
> > +out:
> > +       while (i--)
> > +               __mte_invalidate_tags(folio_page(folio, i));
> > +       return err;
> > +}
> > +
> > +void arch_swap_restore(swp_entry_t entry, struct folio *folio)
> > +{
> > +       if (system_supports_mte()) {
>
> Same here.
>
> Looks good otherwise. None of the nitpicks are deal breakers.
>
> Acked-by: Chris Li <chrisl@kernel.org>

Thanks!

>
>
> Chris
>
> > +               long i, nr =3D folio_nr_pages(folio);
> > +
> > +               entry.val -=3D swp_offset(entry) & (nr - 1);
> > +               for (i =3D 0; i < nr; i++) {
> > +                       mte_restore_tags(entry, folio_page(folio, i));
> > +                       entry.val++;
> > +               }
> > +       }
> > +}
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 5adb86af35fc..67219d2309dd 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -530,16 +530,4 @@ static inline int split_folio(struct folio *folio)
> >         return split_folio_to_list(folio, NULL);
> >  }
> >
> > -/*
> > - * archs that select ARCH_WANTS_THP_SWAP but don't support THP_SWP due=
 to
> > - * limitations in the implementation like arm64 MTE can override this =
to
> > - * false
> > - */
> > -#ifndef arch_thp_swp_supported
> > -static inline bool arch_thp_swp_supported(void)
> > -{
> > -       return true;
> > -}
> > -#endif
> > -
> >  #endif /* _LINUX_HUGE_MM_H */
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index f6d0e3513948..37fe83b0c358 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -925,7 +925,7 @@ static inline int arch_unmap_one(struct mm_struct *=
mm,
> >   * prototypes must be defined in the arch-specific asm/pgtable.h file.
> >   */
> >  #ifndef __HAVE_ARCH_PREPARE_TO_SWAP
> > -static inline int arch_prepare_to_swap(struct page *page)
> > +static inline int arch_prepare_to_swap(struct folio *folio)
> >  {
> >         return 0;
> >  }
> > diff --git a/mm/page_io.c b/mm/page_io.c
> > index ae2b49055e43..a9a7c236aecc 100644
> > --- a/mm/page_io.c
> > +++ b/mm/page_io.c
> > @@ -189,7 +189,7 @@ int swap_writepage(struct page *page, struct writeb=
ack_control *wbc)
> >          * Arch code may have to preserve more data than just the page
> >          * contents, e.g. memory tags.
> >          */
> > -       ret =3D arch_prepare_to_swap(&folio->page);
> > +       ret =3D arch_prepare_to_swap(folio);
> >         if (ret) {
> >                 folio_mark_dirty(folio);
> >                 folio_unlock(folio);
> > diff --git a/mm/swap_slots.c b/mm/swap_slots.c
> > index 0bec1f705f8e..2325adbb1f19 100644
> > --- a/mm/swap_slots.c
> > +++ b/mm/swap_slots.c
> > @@ -307,7 +307,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
> >         entry.val =3D 0;
> >
> >         if (folio_test_large(folio)) {
> > -               if (IS_ENABLED(CONFIG_THP_SWAP) && arch_thp_swp_support=
ed())
> > +               if (IS_ENABLED(CONFIG_THP_SWAP))
> >                         get_swap_pages(1, &entry, folio_nr_pages(folio)=
);
> >                 goto out;
> >         }
> > --
> > 2.34.1
> >

Best Regards,
Barry

