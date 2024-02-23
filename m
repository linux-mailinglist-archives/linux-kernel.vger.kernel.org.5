Return-Path: <linux-kernel+bounces-78070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 068B4860E97
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C38A1C20B4D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991BC12E5E;
	Fri, 23 Feb 2024 09:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXH0aMPe"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E525C916
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681576; cv=none; b=qme2nonq+zVktl89zoJXAfMeePzkSBO9ILC1ngT3nZIAETQASpZytP1yaJqz2JSc9pcgL3QJWHVP4YSuWVhFUj/QBOst3xMQDghPLvF9U0jFKNWaE886/ugXZhmx4FmrEWw6mqeAqc+qp4xcTofXUm/YKcyJgVyIs3WQ/mVYdRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681576; c=relaxed/simple;
	bh=SOyENI2O40BLD/+M9IaxRzjGE/noxTCciUfHSnYac7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q19IzxzmpJD7xTW+FiVClA5vlnbRU+dyBBp+6b5P1Fj79oEbTlY+HvQsjrYHz6TlBc2w8Ek0eRgKuJr+gMZulsvM3QVfdZQnnn4+iH1beelSUDC+atQX1UOyLrR8fbinAw1HguRedOZ4r9m+QYuzjOzD2ebolHo3jZiBH5R+LCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXH0aMPe; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7d2e007751eso105045241.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708681573; x=1709286373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2M7A9OXj74j9IPRozvW1OVuzfe+3xdUDawNt5dPev8s=;
        b=GXH0aMPeKg85/ldQkuVPmt3Cw/JXSJ/V9l8yRzvrCGU6u9UcTKQ4cT7fuzqqkUPBBK
         g9Rb/R0NILHFifRJAuD5f5lrzU3tJnWyVycl0jrAVo7xpFsAeY7VR0w5pDSAET5z4ewr
         pDmkYRCY38sx7+2mv47Zrj7IlttUvnFAtV2fUPiFBM+UcR9R7x1hZ4QtaEKIAiuFx4I+
         7kD+4MNSS4nazXLSTv8Nzb1fQPdneQ7HT+ZlPrT1ed9hD4qOQazykL4SSP8/R/jVzVy6
         4LBOaB2kRb8nOACy1C5oFFfmtWypEZLfr/8bFiUHAwxhFdWkh3UuVFu6AsugIdRxUV6Q
         Kokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708681573; x=1709286373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2M7A9OXj74j9IPRozvW1OVuzfe+3xdUDawNt5dPev8s=;
        b=iibEuQJeidBDy2hw09mU/WOGzTpB+bmHNf58n+5tVRtxU3UFWZIs2vGH/VTplNNzWa
         fcPGXiHn5OSFof8YA/2zcApeESXSdjn2fEesq6N+nieJkFcN2kqQoMhaD/DW2qk99BIm
         vMv82+icPf5RPgiyysGchx8MQ656bIegonvmd5GWyH2jbVtoqF3bnc9W0nt2vZ2laxUg
         g0XFP0mJCm6Ll02qqKjjZhXD5+UFiWjkWXXN6UxU1SIMllxUJgmRt7hSIAHyBgYukScL
         29cnRDRw3RdS/rUg+gZJ/gZyFSFwvTmV9i1FyebG2H4vC+PAMXH3SssXhqocZ5qNisuz
         aMjg==
X-Forwarded-Encrypted: i=1; AJvYcCVjnKo4VKesP+Cs5FnOeScelYXb4DkCA+f6GeMbf8IXjrD2hr1tIPj57zliWt4aFEePGDre5K/ptaL0B1Pl/kL4Tu2v1tGJbh6DkH5j
X-Gm-Message-State: AOJu0Yyydj8OsiTL9FkKQgvjCDNlsuXdsjqSLscKsqkqQIGqP8BQLsqH
	UMN9uBpz/onjl/KX+fEBmkCv8mMh8kRWF8coVjFPAW1eTCv3KtWcNsy6AkD2PMYx19rN4bIqbAu
	8STAUofaSwu0nTk6zlrmpmwloJ0U=
X-Google-Smtp-Source: AGHT+IGTOYkpTHymA0CLqK81q3hxRHctyivYZqYvk894pQGeM/8NnWaokwxnxIg6HftWAlCLa9kLVmeCbgfrWMLOk1k=
X-Received: by 2002:a67:f41a:0:b0:470:5c4a:86ab with SMTP id
 p26-20020a67f41a000000b004705c4a86abmr1295771vsn.0.1708681573263; Fri, 23 Feb
 2024 01:46:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025144546.577640-5-ryan.roberts@arm.com> <20240222070544.133673-1-21cnbao@gmail.com>
 <1a9fcdcd-c0dd-46dd-9c03-265a6988eeb2@redhat.com>
In-Reply-To: <1a9fcdcd-c0dd-46dd-9c03-265a6988eeb2@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 23 Feb 2024 22:46:01 +1300
Message-ID: <CAGsJ_4zWU91J_71zVjKua-RTO4hDUJMkL7z_RP1GnYf3W1dNEA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] mm: swap: Swap-out small-sized THP without splitting
To: David Hildenbrand <david@redhat.com>
Cc: ryan.roberts@arm.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com, 
	shy828301@gmail.com, wangkefeng.wang@huawei.com, willy@infradead.org, 
	xiang@kernel.org, ying.huang@intel.com, yuzhao@google.com, chrisl@kernel.org, 
	surenb@google.com, hanchuanhua@oppo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 11:09=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 22.02.24 08:05, Barry Song wrote:
> > Hi Ryan,
> >
> >> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >> index 2cc0cb41fb32..ea19710aa4cd 100644
> >> --- a/mm/vmscan.c
> >> +++ b/mm/vmscan.c
> >> @@ -1212,11 +1212,13 @@ static unsigned int shrink_folio_list(struct l=
ist_head *folio_list,
> >>                                      if (!can_split_folio(folio, NULL)=
)
> >>                                              goto activate_locked;
> >>                                      /*
> >> -                                     * Split folios without a PMD map=
 right
> >> -                                     * away. Chances are some or all =
of the
> >> -                                     * tail pages can be freed withou=
t IO.
> >> +                                     * Split PMD-mappable folios with=
out a
> >> +                                     * PMD map right away. Chances ar=
e some
> >> +                                     * or all of the tail pages can b=
e freed
> >> +                                     * without IO.
> >>                                       */
> >> -                                    if (!folio_entire_mapcount(folio)=
 &&
> >> +                                    if (folio_test_pmd_mappable(folio=
) &&
> >> +                                        !folio_entire_mapcount(folio)=
 &&
> >>                                          split_folio_to_list(folio,
> >>                                                              folio_lis=
t))
> >>                                              goto activate_locked;
> >
> > I ran a test to investigate what would happen while reclaiming a partia=
lly
> > unmapped large folio. for example, for 64KiB large folios, MADV_DONTNEE=
D
> > 4KB~64KB, and keep the first subpage 0~4KiB.
>
> IOW, something that already happens with ordinary THP already IIRC.
>
> >
> > My test wants to address my three concerns,
> > a. whether we will have leak on swap slots
> > b. whether we will have redundant I/O
> > c. whether we will cause races on swapcache
> >
> > what i have done is printing folio->_nr_pages_mapped and dumping 16 swa=
p_map[]
> > at some specific stage
> > 1. just after add_to_swap   (swap slots are allocated)
> > 2. before and after try_to_unmap   (ptes are set to swap_entry)
> > 3. before and after pageout (also add printk in zram driver to dump all=
 I/O write)
> > 4. before and after remove_mapping
> >
> > The below is the dumped info for a particular large folio,
> >
> > 1. after add_to_swap
> > [   27.267357] vmscan: After add_to_swap shrink_folio_list 1947 mapnr:1
> > [   27.267650] vmscan: offset:101b0 swp_map 40-40-40-40-40-40-40-40-40-=
40-40-40-40-40-40-40
> >
> > as you can see,
> > _nr_pages_mapped is 1 and all 16 swap_map are SWAP_HAS_CACHE (0x40)
> >
> >
> > 2. before and after try_to_unmap
> > [   27.268067] vmscan: before try to unmap shrink_folio_list 1991 mapnr=
:1
> > [   27.268372] try_to_unmap_one address:ffff731f0000 pte:e8000103cd0b43=
 pte_p:ffff0000c36a8f80
> > [   27.268854] vmscan: after try to unmap shrink_folio_list 1997 mapnr:=
0
> > [   27.269180] vmscan: offset:101b0 swp_map 41-40-40-40-40-40-40-40-40-=
40-40-40-40-40-40-40
> >
> > as you can see, one pte is set to swp_entry, and _nr_pages_mapped becom=
es
> > 0 from 1. The 1st swp_map becomes 0x41, SWAP_HAS_CACHE + 1
> >
> > 3. before and after pageout
> > [   27.269602] vmscan: before pageout shrink_folio_list 2065 mapnr:0
> > [   27.269880] vmscan: offset:101b0 swp_map 41-40-40-40-40-40-40-40-40-=
40-40-40-40-40-40-40
> > [   27.270691] zram: zram_write_page page:fffffc00030f3400 index:101b0
> > [   27.271061] zram: zram_write_page page:fffffc00030f3440 index:101b1
> > [   27.271416] zram: zram_write_page page:fffffc00030f3480 index:101b2
> > [   27.271751] zram: zram_write_page page:fffffc00030f34c0 index:101b3
> > [   27.272046] zram: zram_write_page page:fffffc00030f3500 index:101b4
> > [   27.272384] zram: zram_write_page page:fffffc00030f3540 index:101b5
> > [   27.272746] zram: zram_write_page page:fffffc00030f3580 index:101b6
> > [   27.273042] zram: zram_write_page page:fffffc00030f35c0 index:101b7
> > [   27.273339] zram: zram_write_page page:fffffc00030f3600 index:101b8
> > [   27.273676] zram: zram_write_page page:fffffc00030f3640 index:101b9
> > [   27.274044] zram: zram_write_page page:fffffc00030f3680 index:101ba
> > [   27.274554] zram: zram_write_page page:fffffc00030f36c0 index:101bb
> > [   27.274870] zram: zram_write_page page:fffffc00030f3700 index:101bc
> > [   27.275166] zram: zram_write_page page:fffffc00030f3740 index:101bd
> > [   27.275463] zram: zram_write_page page:fffffc00030f3780 index:101be
> > [   27.275760] zram: zram_write_page page:fffffc00030f37c0 index:101bf
> > [   27.276102] vmscan: after pageout and before needs_release shrink_fo=
lio_list 2124 mapnr:0
> >
> > as you can see, obviously, we have done redundant I/O - 16 zram_write_p=
age though
> > 4~64KiB has been zap_pte_range before, we still write them to zRAM.
> >
> > 4. before and after remove_mapping
> > [   27.276428] vmscan: offset:101b0 swp_map 41-40-40-40-40-40-40-40-40-=
40-40-40-40-40-40-40
> > [   27.277485] vmscan: after remove_mapping shrink_folio_list 2169 mapn=
r:0 offset:0
> > [   27.277802] vmscan: offset:101b0 01-00-00-00-00-00-00-00-00-00-00-00=
-00-00-00-00
> >
> > as you can see, swp_map 1-15 becomes 0 and only the first swp_map is 1.
> > all SWAP_HAS_CACHE has been removed. This is perfect and there is no sw=
ap
> > slot leak at all!
> >
> > Thus, only two concerns are left for me,
> > 1. as we don't split anyway, we have done 15 unnecessary I/O if a large=
 folio
> > is partially unmapped.
> > 2. large folio is added as a whole as a swapcache covering the range wh=
ose
> > part has been zapped. I am not quite sure if this will cause some probl=
ems
> > while some concurrent do_anon_page, swapin and swapout occurs between 3=
 and
> > 4 on zapped subpage1~subpage15. still struggling.. my brain is explodin=
g...
>
> Just noting: I was running into something different in the past with
> THP. And it's effectively the same scenario, just swapout and
> MADV_DONTNEED reversed.
>
> Imagine you swapped out a THP and the THP it still is in the swapcache.
>
> Then you unmap/zap some PTEs, freeing up the swap slots.
>
> In zap_pte_range(), we'll call free_swap_and_cache(). There, we run into
> the "!swap_page_trans_huge_swapped(p, entry)", and we won't be calling
> __try_to_reclaim_swap().

I guess you mean swap_page_trans_huge_swapped(p, entry)  not
!swap_page_trans_huge_swapped(p, entry) ?

at that time, swap_page_trans_huge_swapped should be true as there are stil=
l
some entries whose swap_map=3D0x41 or above (SWAP_HAS_CACHE and
swap_count >=3D 1)

static bool swap_page_trans_huge_swapped(struct swap_info_struct *si,
                                         swp_entry_t entry,
                                         unsigned int nr_pages)
{
        ...
        for (i =3D 0; i < nr_pages; i++) {
                if (swap_count(map[offset + i])) {
                        ret =3D true;
                        break;
                }
        }
unlock_out:
        unlock_cluster_or_swap_info(si, ci);
        return ret;
}
So this will stop the swap free even for those ptes which have been
zapped?

Another case I have reported[1] is that while reclaiming a large folio,
in try_to_unmap_one, we are calling  page_vma_mapped_walk().
as it only begins to hold PTL after it hits a valid pte, a paralel
break-before-make might make 0nd, 1st and beginning PTEs zero,
try_to_unmap_one can read intermediate ptes value, thus we can run
into this below case.  afte try_to_unmap_one,
pte 0   -  untouched, present pte
pte 1   - untouched, present pte
pte 2  - swap entries
pte 3 - swap entries
..
pte n - swap entries

or

pte 0   -  untouched, present pte
pte 1  - swap entries
pte 2  - swap entries
pte 3  - swap entries
..
pte n - swap entries

etc.

Thus, after try_to_unmap, the folio is still mapped with some ptes becoming
swap entries, some PTEs are still present. it might be staying in swapcache
for a long time with a broken CONT-PTE.

I also hate that and hope for a SYNC way to let large folio hold PTL from t=
he
0nd pte, thus, it won't get intermediate PTEs from other break-before-make.

This also doesn't increase PTL contention as my test shows we will always
get PTL for a large folio after skipping zero, one or two PTEs in
try_to_unmap_one.
but skipping 1 or 2 is really bad and sad, breaking a large folio from the =
same
whole to nr_pages different segments.

[1] https://lore.kernel.org/linux-mm/CAGsJ_4wo7BiJWSKb1K_WyAai30KmfckMQ3-mC=
JPXZ892CtXpyQ@mail.gmail.com/

>
> So we won't split the large folio that is in the swapcache and it will
> continue consuming "more memory" than intended until fully evicted.
>
> >
> > To me, it seems safer to split or do some other similar optimization if=
 we find a
> > large folio has partial map and unmap.
>
> I'm hoping that we can avoid any new direct users of _nr_pages_mapped if
> possible.
>

Is _nr_pages_mapped < nr_pages a reasonable case to split as we
have known the folio has at least some subpages zapped?

> If we find that the folio is on the deferred split list, we might as
> well just split it right away, before swapping it out. That might be a
> reasonable optimization for the case you describe.

i tried to change Ryan's code as below

@@ -1905,11 +1922,12 @@ static unsigned int shrink_folio_list(struct
list_head *folio_list,
                                         * PMD map right away. Chances are =
some
                                         * or all of the tail pages can be =
freed
                                         * without IO.
+                                        * Similarly, split PTE-mapped foli=
os if
+                                        * they have been already
deferred_split.
                                         */
-                                       if (folio_test_pmd_mappable(folio) =
&&
-                                           !folio_entire_mapcount(folio) &=
&
-                                           split_folio_to_list(folio,
-                                                               folio_list)=
)
+                                       if
(((folio_test_pmd_mappable(folio) && !folio_entire_mapcount(folio)) ||
+
(!folio_test_pmd_mappable(folio) &&
!list_empty(&folio->_deferred_list)))
+                                           &&
split_folio_to_list(folio, folio_list))
                                                goto activate_locked;
                                }
                                if (!add_to_swap(folio)) {

It seems to work as expected. only one I/O is left for a large folio
with 16 PTEs
but 15 of them have been zapped before.

>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry

