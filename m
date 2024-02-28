Return-Path: <linux-kernel+bounces-84447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7CD86A6DB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E24091C2345F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC5A20DEB;
	Wed, 28 Feb 2024 02:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4eSMhms"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D409208DA
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 02:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709088391; cv=none; b=b4V29EMtmlCkL3sWGUwNBW2KHkB9ezgETopbmME1aCwPqMiEfK0ihmUVMGOMsPt0Q+oLEP2DlKrMJzeER39dLBvC6HcfZX/ZsfJa6eIpwFzB/8rWNWHIxmIQshIrF8t9CIgi0cDMmY/9o/g6RW5qbUUuGI8gr2mji+ahCtbuSC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709088391; c=relaxed/simple;
	bh=2E2vRkNRtmEeRYN8e3onKMrtdI9vowsvYy6vvJc1WAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lln6u8vqaFQb4Ciofrd978fmcxBopDLCAZa/hyVe5szR8iQLV9bh1dtvvIqMeFRug46wMiehCLjT85o3/HiUPe6Zyn8+Tnv+2/mTuF+2WYLe7Y3aki8OWIHsDTN3VoBjL5WttlVOYX1kvg5YxOrKLtAZFv1LVHCr/vSBocV1Kes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4eSMhms; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7d5bbbe57b9so2281465241.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 18:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709088388; x=1709693188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68asS/bl/MvTXrNLASBMAC6AdOXFPqHpDjzmE7L2cfA=;
        b=R4eSMhmszIY5jHHEt0Y2JqOJJ/yZG0B6+Giy3aRHO7slLdULWH5dWqfPIB2ZEzxERJ
         NfLRXg3ZDXDWGwuRk7AUFwQ536vMB66Dc0WAF8XTbQcCS8bEtPg/CAJLjwHymR/P/wj/
         pwl8A8LKEOAr++ZL6TTvl43aWMcZw022YMue3aVnfgQnDRLI7HZzdhQluhgHFZVgkMVn
         Qra7MbIlVKXfz/5DLbijlOU8eVUqbbAw6BPFVmX4ji4ddNSnXJT8HyDI5OQr+TpESltX
         06O7anLJFBVh1l7fEJWCRaEAW4jd+WzXBsmVX2/VmHI37ExOE5IgAGHnMKo8I6t1nDrx
         44Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709088388; x=1709693188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68asS/bl/MvTXrNLASBMAC6AdOXFPqHpDjzmE7L2cfA=;
        b=rfHOflDtSRUTyvSWh3S6QdPuIvw3x4hco7n0zBWArNvVHLrnrcEZ1Jm00IKPbAXDgJ
         JTZh0rOWt2vcAfYB6ao9kkOr5GlCDjb0UJv0AnACuKU36QaWt/Q5XCBNZpkkbtCHeToT
         a/wV4hyrSMNNI6KYi5lzYNS/C1/riw6F3SZ7mVFNi33udpRwap4FacYtDMDhBUnFySmf
         qVcF7SVfqGVUNZaX55NDVZ+kuRvrPC6ve/6oIUp1/ysatDrXal88X6j8wjq7zdk6qCVM
         7JtQLT7kngSzZaqwA6RGPlABqJErmwyTTl+hWWwAAqtKs6k/h4qb7TxpNycadaYdlO7g
         C/eg==
X-Forwarded-Encrypted: i=1; AJvYcCWfnh/jT5pSDFzKYcYAPZpeyuersUVjZiigHVVADFv+TxhebOHpZPn/LWG2JxzB89YPVWfsKuaCgwUXgs7DcXx6FDBhzT29L/2XnYRp
X-Gm-Message-State: AOJu0Yx/fHFHsv2K5c+Rhc3wzyZlGzpG3ETu4FzOeHWDJJ1O77yGuMMk
	TPZvzx0z2Dck7D6jGyE+MneZ7mUj70GRmvBT94t+CDU+o7gSPAeql4uxHeOZV+qLz5YtMH7bRpE
	8S7M6m1zyjya6rxB5AKsRwYNIjtk=
X-Google-Smtp-Source: AGHT+IED+9sf543RzJirjUl5aNXvzu27yPceSLZRH9ht0dBKq9pS75a0eIKE4M/5BeJKrwvn86jBTogHFUlTizIXiMc=
X-Received: by 2002:a1f:c4c2:0:b0:4cd:44db:b24b with SMTP id
 u185-20020a1fc4c2000000b004cd44dbb24bmr7350487vkf.5.1709088388368; Tue, 27
 Feb 2024 18:46:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025144546.577640-5-ryan.roberts@arm.com> <20240205095155.7151-1-v-songbaohua@oppo.com>
 <6a55e785-73dd-4951-bad8-2670810a13b6@arm.com>
In-Reply-To: <6a55e785-73dd-4951-bad8-2670810a13b6@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 28 Feb 2024 15:46:17 +1300
Message-ID: <CAGsJ_4zdh5kOG7QP4UDaE-wmLFiTEJC2PX-_LxtOj=QrZSvkCA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] mm: swap: Swap-out small-sized THP without splitting
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mhocko@suse.com, shy828301@gmail.com, 
	wangkefeng.wang@huawei.com, willy@infradead.org, xiang@kernel.org, 
	ying.huang@intel.com, yuzhao@google.com, chrisl@kernel.org, surenb@google.com, 
	hanchuanhua@oppo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 2:37=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 05/02/2024 09:51, Barry Song wrote:
> > +Chris, Suren and Chuanhua
> >
> > Hi Ryan,
> >
> >> +    /*
> >> +     * __scan_swap_map_try_ssd_cluster() may drop si->lock during dis=
card,
> >> +     * so indicate that we are scanning to synchronise with swapoff.
> >> +     */
> >> +    si->flags +=3D SWP_SCANNING;
> >> +    ret =3D __scan_swap_map_try_ssd_cluster(si, &offset, &scan_base, =
order);
> >> +    si->flags -=3D SWP_SCANNING;
> >
> > nobody is using this scan_base afterwards. it seems a bit weird to
> > pass a pointer.
> >
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
> >> --
> >
> > Chuanhua and I ran this patchset for a couple of days and found a race
> > between reclamation and split_folio. this might cause applications get
> > wrong data 0 while swapping-in.
> >
> > in case one thread(T1) is reclaiming a large folio by some means, still
> > another thread is calling madvise MADV_PGOUT(T2). and at the same time,
> > we have two threads T3 and T4 to swap-in in parallel. T1 doesn't split
> > and T2 does split as below,
>

Hi Ryan,

> Hi Barry,
>
> Do you have a test case you can share that provokes this problem? And is =
this a
> separate problem to the race you solved with TTU_SYNC or is this solving =
the
> same problem?

They are the same.

After sending you the report about the races, I spent some time and
finally figured
out what was happening, why corrupted data came while swapping in. it
is absolutely
not your fault, but TTU_SYNC does somehow resolve my problem though it is n=
ot
the root cause. this corrupted data only can reproduce after applying
patch 4[1] of
swap-in series,
[1]  [PATCH RFC 4/6] mm: support large folios swapin as a whole
https://lore.kernel.org/linux-mm/20240118111036.72641-5-21cnbao@gmail.com/

In case we have a large folio with 16 PTEs as below, and after
add_to_swap(), they get
swapoffset 0x10000,  their PTEs are all present as they are still mapped.
PTE          pte_stat
PTE0        present
PTE1        present
PTE2        present
PTE3        present
..
PTE15       present

then we get to try_to_unmap_one, as try_to_unmap_one doesn't hold PTL
from PTE0, while it scans PTEs, we might have
PTE          pte_stat
PTE0        none (someone is writing PTE0 for various reasons)
PTE1        present
PTE2        present
PTE3        present
..
PTE15       present

We hold PTL from PTE1.

after try_to_unmap_one, PTEs become

PTE          pte_stat
PTE0        present (someone finished the write of PTE0)
PTE1        swap 0x10001
PTE2        swap 0x10002
PTE3        swap 0x10003
..
..
PTE15      swap 0x1000F

Thus, after try_to_unmap_one, the large folio is still mapped. so its swapc=
ache
will still be there.

Now a parallel thread runs MADV_PAGEOUT, and it finds this large folio
is not completely mapped, so it splits the folio into 16 small folios but t=
heir
swap offsets are kept.

Now in swapcache, we have 16 folios with contiguous swap offsets.
MADV_PAGEOUT will reclaim these 16 folios, after new 16 try_to_unmap_one,

PTE          pte_stat
PTE0        swap 0x10000  SWAP_HAS_CACHE
PTE1        swap 0x10001  SWAP_HAS_CACHE
PTE2        swap 0x10002  SWAP_HAS_CACHE
PTE3        swap 0x10003  SWAP_HAS_CACHE
..
PTE15        swap 0x1000F  SWAP_HAS_CACHE

From this time, we can have various different cases for these 16 PTEs.
for example,

PTE          pte_stat
PTE0        swap 0x10000  SWAP_HAS_CACHE =3D 0 -> become false due to
finished pageout and remove_mapping
PTE1        swap 0x10001  SWAP_HAS_CACHE =3D 0 -> become false due to
finished pageout and remove_mapping
PTE2        swap 0x10002  SWAP_HAS_CACHE =3D 0 -> become false due to
concurrent swapin and swapout
PTE3        swap 0x10003  SWAP_HAS_CACHE =3D 1
..
PTE13        swap 0x1000D  SWAP_HAS_CACHE =3D 1
PTE14        swap 0x1000E  SWAP_HAS_CACHE =3D 1
PTE15        swap 0x1000F  SWAP_HAS_CACHE =3D 1

but all of them have swp_count =3D 1 and different SWAP_HAS_CACHE. some of =
these
small folios might be in swapcache, some others might not be in.

then we do_swap_page at one PTE whose SWAP_HAS_CACHE=3D0 and
swap_count=3D1 (the folio is not in swapcache, thus has been written to swa=
p),
we do this check:

static bool pte_range_swap(pte_t *pte, int nr_pages)
{
        int i;
        swp_entry_t entry;
        unsigned type;
        pgoff_t start_offset;

        entry =3D pte_to_swp_entry(ptep_get_lockless(pte));
        if (non_swap_entry(entry))
                return false;
        start_offset =3D swp_offset(entry);
        if (start_offset % nr_pages)
                return false;

        type =3D swp_type(entry);
        for (i =3D 1; i < nr_pages; i++) {
                entry =3D pte_to_swp_entry(ptep_get_lockless(pte + i));
                if (non_swap_entry(entry))
                        return false;
                if (swp_offset(entry) !=3D start_offset + i)
                        return false;
                if (swp_type(entry) !=3D type)
                        return false;
        }

        return true;
}

as those swp entries are contiguous, we will call swap_read_folio().
For those folios which are still in swapcache and haven't been written,
we get zero-filled data from zRAM.

So the root cause is that pte_range_swap should check
all 16 swap_map have the same SWAP_HAS_CACHE as
false.

static bool is_pte_range_contig_swap(pte_t *pte, int nr_pages)
{
       ...
       count =3D si->swap_map[start_offset];
       for (i =3D 1; i < nr_pages; i++) {
               entry =3D pte_to_swp_entry(ptep_get_lockless(pte + i));
               if (non_swap_entry(entry))
                       return false;
               if (swp_offset(entry) !=3D start_offset + i)
                       return false;
               if (swp_type(entry) !=3D type)
                       return false;
               /* fallback to small folios if SWAP_HAS_CACHE isn't same */
               if (si->swap_map[start_offset + i] !=3D count)
                       return false;
       }

       return true;
}

but somehow TTU_SYNC "resolves" it by giving no chance to
MADV_PAGEOUT to split this folio as the large folio are either
entirely written by swap entries, or entirely keep present PTEs.

Though the bug is within the swap-in series, I am still a big fan of
TTU_SYNC for large folio reclamation for at least three reasons,

1. We remove some possibility that large folios fail to be reclaimed, impro=
ving
reclamation efficiency.

2. We avoid many strange cases and potential folio_split during reclamation=
.
without TTU_SYNC, folios can be splitted later, or partially being set to s=
wap
entries while partially being still present

3. we don't increase PTL contention. My test shows try_to_unmap_one
will always get PTL after it sometimes skips one or two PTEs because
intermediate break-before-makes are short. Of course, most time try_to_unma=
p_one
will get PTL from PTE0.

>
> Thanks,
> Ryan
>

Thanks
Barry

