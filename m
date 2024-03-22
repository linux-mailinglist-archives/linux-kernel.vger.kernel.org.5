Return-Path: <linux-kernel+bounces-111074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B90D886796
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C13C1F226B8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D6616430;
	Fri, 22 Mar 2024 07:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUryIe8y"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D11112E51
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 07:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711093320; cv=none; b=AfLrTRcDM0Ny0XigxZvfWeJYKk+88YNTOAmO3ePw2PBDDMxG28NdI9qykXbB3Ju7bKkJkwRqLJdaHEqdpZNNxqE9RvCfEUU6kxXoAlOh6YqrA1scCjg10MN9F+G0k0IuJopCenB9XAuhyGGa2RGsxDL/nXEBQs0P3be2RU4JCsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711093320; c=relaxed/simple;
	bh=24dQKSS219MtapPvG2qUnTtLLIVUaPzzYSoKQfVTXig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VIYJ8cSpictpmmFkSEgzNJlb37TqzQNg8IBKzAffpC9Jg1g26vufc59szkWPgJL52cB+6MncsbNCJaS1ePi53jLvvzi7aeZEkzU+OjULYtR567Id+IH8Ra3MVHAbTQ+CmA+uthaPHd3lEyIf9fuCf4Ik/TnH4VkzW3K0FSunJsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUryIe8y; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-476d13e405fso197969137.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 00:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711093317; x=1711698117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJxf/0IRyXWCJtbi5qbbmLaPh0sQtHW5xcaUos/BySI=;
        b=GUryIe8yAs9+3lpkyV48QKi96fdHspWGymPyheROUhpVUsMpeeb+k6PhSEXdb51xAH
         vpgo/goL+7tT8rrEQRSqLqY/Vqfq6Lqi6Dz4CR8+JcCqofMrbkGUd+69qm0r+hkGT6XZ
         gaMiHpcmySOTCR6ZysX5kkF8vXuWN0MS/eHV+VgVQkGtxvTKggx6ezBNDFnxiF3c8SER
         JAPwL9GeipU9sQkABSWsPxkrqTtUAtgk1qSmGQosUXRbbRTCdW6mmiCCmxQZbDIcp1rA
         aPf3mt398mjLT3NbgBlvBrmkhTXqGKBRF1ZSYFIeDw/n/y9CzZ3vsbpY2w/kN6lzpc6d
         d3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711093317; x=1711698117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJxf/0IRyXWCJtbi5qbbmLaPh0sQtHW5xcaUos/BySI=;
        b=FIDKmnFz7fqeIInD//70I4Hj7oKeqmgnPK+tZGTSrYBNVSboJZhhaxbhOx+tAgO7kl
         BAuZuRQZGyR8ghjaZTk2pZbEAxwXW9lZNY7CUs5g3uxik13WzHWnjrdd9F3XjWQYEkH8
         a7GZb6ybAaHZ7RfviaiPgtRMrx98XB+vLl4YGVjECr5m61OLn7OnW1XEShh23wYZ3Jrd
         lkhQmO2Rj8Mb6y8xcUTuYSW6OiuGOH2X1B1R5m38GBtlYmtVXKaBPqgy3GgZf69ul2pb
         AaQ1Dtzmu/SUfpBvAa8Vp13gRlj9Dmsd8OeDEJwR75RhiuICftLdKm6QX67pkk+DHTaC
         q5pQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1OLF2mGlYk3VutkM6fIMe+3gPNHDCF0CjTpE6sOvUpovSv0QYYRXsiPM3A+vsm039NfbVN3QyNdJiNIpkXFyE8ECrne/47/OWOFWE
X-Gm-Message-State: AOJu0Yw2bRKy+xf2lUVQaXRc9RCtsbBLWnVYkOxKVwBZjRbj9q/LkX2d
	I4uuQSJYGjIEQbxw8lhN2RNbD8U71mgI9rA0v3Cauq9wwjDKdGXphaweTBPB47wB93tCXqTJKFl
	BZapQpE7VIpOOxPR8WxjFeKp0eMo=
X-Google-Smtp-Source: AGHT+IHwtFuKS0M+9JXdh2SzS2uymxjTB97BrZmWBdNX6ou/0JIxYzMuqmrJH9bf94Toso8Gtr+Y9pcbSVTguJ9wYfs=
X-Received: by 2002:a05:6102:4c18:b0:475:f444:748c with SMTP id
 jy24-20020a0561024c1800b00475f444748cmr1842524vsb.27.1711093316943; Fri, 22
 Mar 2024 00:41:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304081348.197341-1-21cnbao@gmail.com> <20240304081348.197341-2-21cnbao@gmail.com>
 <01c61b90-df90-4819-978b-414bb717ef64@arm.com> <CAGsJ_4z5xDtBj-nyvPXfgv+ZVmzPQzvptyBrf=kB49Q3=Dmq-Q@mail.gmail.com>
 <e77c18df-2796-4fd1-b589-57f0569587e8@arm.com> <CAGsJ_4zT5YCkSLthCGDe5t3B4dR2syJa_MA3ytZ3YmSCERn_TQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4zT5YCkSLthCGDe5t3B4dR2syJa_MA3ytZ3YmSCERn_TQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 22 Mar 2024 20:41:45 +1300
Message-ID: <CAGsJ_4wRNRbdXGV-2LUNNP2Dgi6JZ4fZbC2VGPS4ui8HdvuxnQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/5] arm64: mm: swap: support THP_SWAP on hardware
 with MTE
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, chengming.zhou@linux.dev, 
	chrisl@kernel.org, david@redhat.com, hannes@cmpxchg.org, kasong@tencent.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mhocko@suse.com, nphamcs@gmail.com, shy828301@gmail.com, steven.price@arm.com, 
	surenb@google.com, wangkefeng.wang@huawei.com, willy@infradead.org, 
	xiang@kernel.org, ying.huang@intel.com, yosryahmed@google.com, 
	yuzhao@google.com, Barry Song <v-songbaohua@oppo.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Peter Collingbourne <pcc@google.com>, Peter Xu <peterx@redhat.com>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, Hugh Dickins <hughd@google.com>, 
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 3:51=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Thu, Mar 21, 2024 at 11:31=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.c=
om> wrote:
> >
> > On 21/03/2024 08:42, Barry Song wrote:
> > > Hi Ryan,
> > > Sorry for the late reply.
> >
> > No problem!
> >
> > >
> > > On Tue, Mar 12, 2024 at 5:56=E2=80=AFAM Ryan Roberts <ryan.roberts@ar=
m.com> wrote:
> > >>
> > >> On 04/03/2024 08:13, Barry Song wrote:
> > >>> From: Barry Song <v-songbaohua@oppo.com>
> > >>>
> > >>> Commit d0637c505f8a1 ("arm64: enable THP_SWAP for arm64") brings up
> > >>> THP_SWAP on ARM64, but it doesn't enable THP_SWP on hardware with
> > >>> MTE as the MTE code works with the assumption tags save/restore is
> > >>> always handling a folio with only one page.
> > >>>
> > >>> The limitation should be removed as more and more ARM64 SoCs have
> > >>> this feature. Co-existence of MTE and THP_SWAP becomes more and
> > >>> more important.
> > >>>
> > >>> This patch makes MTE tags saving support large folios, then we don'=
t
> > >>> need to split large folios into base pages for swapping out on ARM6=
4
> > >>> SoCs with MTE any more.
> > >>>
> > >>> arch_prepare_to_swap() should take folio rather than page as parame=
ter
> > >>> because we support THP swap-out as a whole. It saves tags for all
> > >>> pages in a large folio.
> > >>>
> > >>> As now we are restoring tags based-on folio, in arch_swap_restore()=
,
> > >>> we may increase some extra loops and early-exitings while refaultin=
g
> > >>> a large folio which is still in swapcache in do_swap_page(). In cas=
e
> > >>> a large folio has nr pages, do_swap_page() will only set the PTE of
> > >>> the particular page which is causing the page fault.
> > >>> Thus do_swap_page() runs nr times, and each time, arch_swap_restore=
()
> > >>> will loop nr times for those subpages in the folio. So right now th=
e
> > >>> algorithmic complexity becomes O(nr^2).
> > >>>
> > >>> Once we support mapping large folios in do_swap_page(), extra loops
> > >>> and early-exitings will decrease while not being completely removed
> > >>> as a large folio might get partially tagged in corner cases such as=
,
> > >>> 1. a large folio in swapcache can be partially unmapped, thus, MTE
> > >>> tags for the unmapped pages will be invalidated;
> > >>> 2. users might use mprotect() to set MTEs on a part of a large foli=
o.
> > >>>
> > >>> arch_thp_swp_supported() is dropped since ARM64 MTE was the only on=
e
> > >>> who needed it.
> >
> > I think we should decouple this patch from your swap-in series. I suspe=
ct this
> > one could be ready and go in sooner than the swap-in series based on th=
e current
> > discussions :)
> >
> > >>>
> > >>> Cc: Catalin Marinas <catalin.marinas@arm.com>
> > >>> Cc: Will Deacon <will@kernel.org>
> > >>> Cc: Ryan Roberts <ryan.roberts@arm.com>
> > >>> Cc: Mark Rutland <mark.rutland@arm.com>
> > >>> Cc: David Hildenbrand <david@redhat.com>
> > >>> Cc: Kemeng Shi <shikemeng@huaweicloud.com>
> > >>> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > >>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> > >>> Cc: Peter Collingbourne <pcc@google.com>
> > >>> Cc: Steven Price <steven.price@arm.com>
> > >>> Cc: Yosry Ahmed <yosryahmed@google.com>
> > >>> Cc: Peter Xu <peterx@redhat.com>
> > >>> Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> > >>> Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > >>> Cc: Hugh Dickins <hughd@google.com>
> > >>> CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> > >>> Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
> > >>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > >>> Reviewed-by: Steven Price <steven.price@arm.com>
> > >>> Acked-by: Chris Li <chrisl@kernel.org>
> > >>> ---
> > >>>  arch/arm64/include/asm/pgtable.h | 19 ++------------
> > >>>  arch/arm64/mm/mteswap.c          | 43 ++++++++++++++++++++++++++++=
++++
> > >>>  include/linux/huge_mm.h          | 12 ---------
> > >>>  include/linux/pgtable.h          |  2 +-
> > >>>  mm/page_io.c                     |  2 +-
> > >>>  mm/swap_slots.c                  |  2 +-
> > >>>  6 files changed, 48 insertions(+), 32 deletions(-)
> > >>>
> > >>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/=
asm/pgtable.h
> > >>> index 401087e8a43d..7a54750770b8 100644
> > >>> --- a/arch/arm64/include/asm/pgtable.h
> > >>> +++ b/arch/arm64/include/asm/pgtable.h
> > >>> @@ -45,12 +45,6 @@
> > >>>       __flush_tlb_range(vma, addr, end, PUD_SIZE, false, 1)
> > >>>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> > >>>
> > >>> -static inline bool arch_thp_swp_supported(void)
> > >>> -{
> > >>> -     return !system_supports_mte();
> > >>> -}
> > >>> -#define arch_thp_swp_supported arch_thp_swp_supported
> > >>> -
> > >>>  /*
> > >>>   * Outside of a few very special situations (e.g. hibernation), we=
 always
> > >>>   * use broadcast TLB invalidation instructions, therefore a spurio=
us page
> > >>> @@ -1095,12 +1089,7 @@ static inline pmd_t pmdp_establish(struct vm=
_area_struct *vma,
> > >>>  #ifdef CONFIG_ARM64_MTE
> > >>>
> > >>>  #define __HAVE_ARCH_PREPARE_TO_SWAP
> > >>> -static inline int arch_prepare_to_swap(struct page *page)
> > >>> -{
> > >>> -     if (system_supports_mte())
> > >>> -             return mte_save_tags(page);
> > >>> -     return 0;
> > >>> -}
> > >>> +extern int arch_prepare_to_swap(struct folio *folio);
> > >>>
> > >>>  #define __HAVE_ARCH_SWAP_INVALIDATE
> > >>>  static inline void arch_swap_invalidate_page(int type, pgoff_t off=
set)
> > >>> @@ -1116,11 +1105,7 @@ static inline void arch_swap_invalidate_area=
(int type)
> > >>>  }
> > >>>
> > >>>  #define __HAVE_ARCH_SWAP_RESTORE
> > >>> -static inline void arch_swap_restore(swp_entry_t entry, struct fol=
io *folio)
> > >>> -{
> > >>> -     if (system_supports_mte())
> > >>> -             mte_restore_tags(entry, &folio->page);
> > >>> -}
> > >>> +extern void arch_swap_restore(swp_entry_t entry, struct folio *fol=
io);
> > >>>
> > >>>  #endif /* CONFIG_ARM64_MTE */
> > >>>
> > >>> diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
> > >>> index a31833e3ddc5..295836fef620 100644
> > >>> --- a/arch/arm64/mm/mteswap.c
> > >>> +++ b/arch/arm64/mm/mteswap.c
> > >>> @@ -68,6 +68,13 @@ void mte_invalidate_tags(int type, pgoff_t offse=
t)
> > >>>       mte_free_tag_storage(tags);
> > >>>  }
> > >>>
> > >>> +static inline void __mte_invalidate_tags(struct page *page)
> > >>> +{
> > >>> +     swp_entry_t entry =3D page_swap_entry(page);
> > >>> +
> > >>> +     mte_invalidate_tags(swp_type(entry), swp_offset(entry));
> > >>> +}
> > >>> +
> > >>>  void mte_invalidate_tags_area(int type)
> > >>>  {
> > >>>       swp_entry_t entry =3D swp_entry(type, 0);
> > >>> @@ -83,3 +90,39 @@ void mte_invalidate_tags_area(int type)
> > >>>       }
> > >>>       xa_unlock(&mte_pages);
> > >>>  }
> > >>> +
> > >>> +int arch_prepare_to_swap(struct folio *folio)
> > >>> +{
> > >>> +     long i, nr;
> > >>> +     int err;
> > >>> +
> > >>> +     if (!system_supports_mte())
> > >>> +             return 0;
> > >>> +
> > >>> +     nr =3D folio_nr_pages(folio);
> > >>> +
> > >>> +     for (i =3D 0; i < nr; i++) {
> > >>> +             err =3D mte_save_tags(folio_page(folio, i));
> > >>> +             if (err)
> > >>> +                     goto out;
> > >>> +     }
> > >>> +     return 0;
> > >>> +
> > >>> +out:
> > >>> +     while (i--)
> > >>> +             __mte_invalidate_tags(folio_page(folio, i));
> > >>> +     return err;
> > >>> +}
> > >>> +
> > >>> +void arch_swap_restore(swp_entry_t entry, struct folio *folio)
> > >>
> > >> I'm still not a fan of the fact that entry could be anywhere within =
folio.
> > >>
> > >>> +{
> > >>> +     if (system_supports_mte()) {
> > >>
> > >> nit: if you do:
> > >>
> > >> if (!system_supports_mte())
> > >>         return;
> > >
> > > Acked
> > >
> > >>
> > >> It will be consistent with arch_prepare_to_swap() and reduce the ind=
entation of
> > >> the main body.
> > >>
> > >>> +             long i, nr =3D folio_nr_pages(folio);
> > >>> +
> > >>> +             entry.val -=3D swp_offset(entry) & (nr - 1);
> > >>
> > >> This assumes that folios are always stored in swap with natural alig=
nment. Is
> > >> that definitely a safe assumption? My swap-out series is currently e=
nsuring that
> > >> folios are swapped-out naturally aligned, but that is an implementat=
ion detail.
> > >>
> > >
> > > I concur that this is an implementation detail. However, we should be
> > > bold enough
> > > to state that swap slots will be contiguous, considering we are
> > > currently utilizing
> > > folio->swap instead of subpage->swap ?
> >
> > Yes, I agree about contiguity. My objection is about assuming natural a=
lignment
> > though. It can still be contiguous while not naturally aligned in swap.
>
> Hi Ryan,
>
> While working on the new version of this patch, I've come to recognize
> that, for the time being, it's
> imperative to maintain a natural alignment. The following code
> operates on the basis of this
> assumption.
>
> /**
>  * folio_file_page - The page for a particular index.
>  * @folio: The folio which contains this index.
>  * @index: The index we want to look up.
>  *
>  * Sometimes after looking up a folio in the page cache, we need to
>  * obtain the specific page for an index (eg a page fault).
>  *
>  * Return: The page containing the file data for this index.
>  */
> static inline struct page *folio_file_page(struct folio *folio, pgoff_t i=
ndex)
> {
>         return folio_page(folio, index & (folio_nr_pages(folio) - 1));
> }
>
>
> It's invoked everywhere, particularly within do_swap_page(). Nonetheless,
> I remain confident that I can consistently pass the first entry to
> arch_swap_restore().

After grappling for a couple of hours, I've realized that the only
viable approach
is as follows: shifting the task of obtaining the first entry from the
callee to the
callers( looks silly). This is necessary due to various scenarios like
swap cache,
non-swap cache, and KSM, each presenting different cases. Since there's no
assurance of folio->swap being present, forcibly setting folio->swap could =
pose
risks (There might not even be any risk involved, but the associated
task getting
the first entry still cannot be overlooked by callers).

diff --git a/mm/internal.h b/mm/internal.h
index 7e486f2c502c..94d5b4b5a5da 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -76,6 +76,20 @@ static inline int folio_nr_pages_mapped(struct folio *fo=
lio)
        return atomic_read(&folio->_nr_pages_mapped) & FOLIO_PAGES_MAPPED;
 }

+/*
+ * Retrieve the first entry of a folio based on a provided entry within th=
e
+ * folio. We cannot rely on folio->swap as there is no guarantee that it h=
as
+ * been initialized. Used by arch_swap_restore()
+ */
+static inline swp_entry_t folio_swap(swp_entry_t entry, struct folio *foli=
o)
+{
+       swp_entry_t swap =3D {
+               .val =3D entry.val & (folio_nr_pages(folio) - 1),
+       };
+
+       return swap;
+}
+
 static inline void *folio_raw_mapping(struct folio *folio)
 {
        unsigned long mapping =3D (unsigned long)folio->mapping;
diff --git a/mm/memory.c b/mm/memory.c
index f2bc6dd15eb8..b7cab8be8632 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4188,7 +4188,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
         * when reading from swap. This metadata may be indexed by swap ent=
ry
         * so this must be called before swap_free().
         */
-       arch_swap_restore(entry, folio);
+       arch_swap_restore(folio_swap(entry, folio), folio);

        /*
         * Remove the swap entry and conditionally try to free up the swapc=
ache.
diff --git a/mm/shmem.c b/mm/shmem.c
index 0aad0d9a621b..82c9df4628f2 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1913,7 +1913,7 @@ static int shmem_swapin_folio(struct inode
*inode, pgoff_t index,
         * Some architectures may have to restore extra metadata to the
         * folio after reading from swap.
         */
-       arch_swap_restore(swap, folio);
+       arch_swap_restore(folio_swap(entry, folio), folio);

        if (shmem_should_replace_folio(folio, gfp)) {
                error =3D shmem_replace_folio(&folio, gfp, info, index);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 4919423cce76..5e6d2304a2a4 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1806,7 +1806,7 @@ static int unuse_pte(struct vm_area_struct *vma,
pmd_t *pmd,
         * when reading from swap. This metadata may be indexed by swap ent=
ry
         * so this must be called before swap_free().
         */
-       arch_swap_restore(entry, folio);
+       arch_swap_restore(folio_swap(entry, folio), folio);

        dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
        inc_mm_counter(vma->vm_mm, MM_ANONPAGES);


Meanwhile, natural alignment is essential even during the execution of
add_to_swap(), as failure to
do so will trigger the VM_BUG_ON condition below.

int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
                        gfp_t gfp, void **shadowp)
{
        struct address_space *address_space =3D swap_address_space(entry);
        pgoff_t idx =3D swp_offset(entry);
        XA_STATE_ORDER(xas, &address_space->i_pages, idx, folio_order(folio=
));
        unsigned long i, nr =3D folio_nr_pages(folio);
        ...
        folio_set_swapcache(folio);
        folio->swap =3D entry;

        do {
                xas_lock_irq(&xas);
                xas_create_range(&xas);
                if (xas_error(&xas))
                        goto unlock;
                for (i =3D 0; i < nr; i++) {
                        VM_BUG_ON_FOLIO(xas.xa_index !=3D idx + i, folio);
                        if (shadowp) {
                                old =3D xas_load(&xas);
                                if (xa_is_value(old))
                                        *shadowp =3D old;
                        }
                        xas_store(&xas, folio);
                        xas_next(&xas);
                }
}


Based on the information provided, Ryan, would it be feasible to retain the=
 task
of obtaining the first entry within the callee? Or, are you in favor
of utilizing the
new folio_swap() helper?

>
> >
> > >
> > >> Your cover note for swap-in says that you could technically swap in =
a large
> > >> folio without it having been swapped-out large. If you chose to do t=
hat in
> > >> future, this would break, right? I don't think it's good to couple t=
he swap
> > >
> > > Right. technically I agree. Given that we still have many tasks invol=
ving even
> > > swapping in contiguous swap slots, it's unlikely that swapping in lar=
ge folios
> > > for non-contiguous entries will occur in the foreseeable future :-)
> > >
> > >> storage layout to the folio order that you want to swap into. Perhap=
s that's an
> > >> argument for passing each *page* to this function with its exact, co=
rresponding
> > >> swap entry?
> > >
> > > I recall Matthew Wilcox strongly objected to using "page" as the
> > > parameter, so I've
> > > discarded that approach. Alternatively, it appears I can consistently=
 pass
> > > folio->swap to this function and ensure the function always retrieves
> > > the first entry?
> >
> > Yes, if we must pass a folio here, I'd prefer that entry always corresp=
onds to
> > the first entry for the folio. That will remove the need for this funct=
ion to do
> > the alignment above too. So win-win.
> >
> > >
> > >>
> > >>> +             for (i =3D 0; i < nr; i++) {
> > >>> +                     mte_restore_tags(entry, folio_page(folio, i))=
;
> > >>> +                     entry.val++;
> > >>> +             }
> > >>> +     }
> > >>> +}
> > >>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > >>> index de0c89105076..e04b93c43965 100644
> > >>> --- a/include/linux/huge_mm.h
> > >>> +++ b/include/linux/huge_mm.h
> > >>> @@ -535,16 +535,4 @@ static inline int split_folio_to_order(struct =
folio *folio, int new_order)
> > >>>  #define split_folio_to_list(f, l) split_folio_to_list_to_order(f, =
l, 0)
> > >>>  #define split_folio(f) split_folio_to_order(f, 0)
> > >>>
> > >>> -/*
> > >>> - * archs that select ARCH_WANTS_THP_SWAP but don't support THP_SWP=
 due to
> > >>> - * limitations in the implementation like arm64 MTE can override t=
his to
> > >>> - * false
> > >>> - */
> > >>> -#ifndef arch_thp_swp_supported
> > >>> -static inline bool arch_thp_swp_supported(void)
> > >>> -{
> > >>> -     return true;
> > >>> -}
> > >>> -#endif
> > >>> -
> > >>>  #endif /* _LINUX_HUGE_MM_H */
> > >>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > >>> index e1b22903f709..bfcfe3386934 100644
> > >>> --- a/include/linux/pgtable.h
> > >>> +++ b/include/linux/pgtable.h
> > >>> @@ -1106,7 +1106,7 @@ static inline int arch_unmap_one(struct mm_st=
ruct *mm,
> > >>>   * prototypes must be defined in the arch-specific asm/pgtable.h f=
ile.
> > >>>   */
> > >>>  #ifndef __HAVE_ARCH_PREPARE_TO_SWAP
> > >>> -static inline int arch_prepare_to_swap(struct page *page)
> > >>> +static inline int arch_prepare_to_swap(struct folio *folio)
> > >>>  {
> > >>>       return 0;
> > >>>  }
> > >>> diff --git a/mm/page_io.c b/mm/page_io.c
> > >>> index ae2b49055e43..a9a7c236aecc 100644
> > >>> --- a/mm/page_io.c
> > >>> +++ b/mm/page_io.c
> > >>> @@ -189,7 +189,7 @@ int swap_writepage(struct page *page, struct wr=
iteback_control *wbc)
> > >>>        * Arch code may have to preserve more data than just the pag=
e
> > >>>        * contents, e.g. memory tags.
> > >>>        */
> > >>> -     ret =3D arch_prepare_to_swap(&folio->page);
> > >>> +     ret =3D arch_prepare_to_swap(folio);
> > >>>       if (ret) {
> > >>>               folio_mark_dirty(folio);
> > >>>               folio_unlock(folio);
> > >>> diff --git a/mm/swap_slots.c b/mm/swap_slots.c
> > >>> index 90973ce7881d..53abeaf1371d 100644
> > >>> --- a/mm/swap_slots.c
> > >>> +++ b/mm/swap_slots.c
> > >>> @@ -310,7 +310,7 @@ swp_entry_t folio_alloc_swap(struct folio *foli=
o)
> > >>>       entry.val =3D 0;
> > >>>
> > >>>       if (folio_test_large(folio)) {
> > >>> -             if (IS_ENABLED(CONFIG_THP_SWAP) && arch_thp_swp_suppo=
rted())
> > >>> +             if (IS_ENABLED(CONFIG_THP_SWAP))
> > >>>                       get_swap_pages(1, &entry, folio_nr_pages(foli=
o));
> > >>>               goto out;
> > >>>       }
> > >>
> > >
> > > Thanks
> > > Barry
> >

