Return-Path: <linux-kernel+bounces-104166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7FF87C9F9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE1821C225C5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56F2171AD;
	Fri, 15 Mar 2024 08:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aunEy3E0"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26C263DF
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 08:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710491687; cv=none; b=NdoT+u998qeAbSKQ8JiVyZBxoUSAUEoP7pHSPd9QjUqlvAYnaNbURkexRpo0FcDFLAk2QcSwG9RROoIy7d1EHsu6d1yXcKzx4z9svaE3TH1Z8UnagzpmPzY8eQ7l8ycE2TcID344uH9h4xBKMMoa7rbgq9pNoQDO3GTQ6abXVXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710491687; c=relaxed/simple;
	bh=SJEaGO5NsUAbBmgBSc1L7H5kizZNZaD0RAPjUrMxesg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cmQjtT42WLhL79RxyzDvcnyZSMYTUz8YKCC1CpUrEPY3NOt4LxLQDQ63GK4o8J1l1eL+05Csid9ZFYePKkoLcsk/qDYqlbcYyYhrs0kozWt6TOJbt1HZc2oevm85n2rYwcN91+mU6mWFq5wpvoWrGldncTJljNWzbMAFrhq0VIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aunEy3E0; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-568a3292916so1725429a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 01:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710491684; x=1711096484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dEcH2CQoMqPC9jL2XzwLkEEUQ4/4awp4zhF56g7bw4=;
        b=aunEy3E0FMr5CWOamv7ofM5qr6WNrOhh7WhFle2Y6dicTpo/TJ65G1DZZGx5DbHQbO
         85jBznMBGxPfnc7m0JYcTL43Z1GGOGkPsz5Sm9rK8uc2R381nhYKuVfQkgRqwRR2k3y5
         zrq7/fjBP31zMpBmfPjR3BAr3tZ+OKuAZDBSVy1QkWKrYaUaQn9A80pRbec3A/cc1wPr
         d0j6pLFF+y7KLmsIrN2xnms4yflshOwV042kOsAWerQLJWLtwYaz62wIrWy6qPvJbWDr
         xymqB5RrQuR3tPQFkuK3VTZyTTcOXiQ49bvZsGwJ+qEtdRpIWkjVYSsBKz1FKSB9E4Za
         R4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710491684; x=1711096484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4dEcH2CQoMqPC9jL2XzwLkEEUQ4/4awp4zhF56g7bw4=;
        b=uAryJZDKtp8h+WKNSDtPoodd6mAXMLaDdIGHYUGV1dwZXR7JnurBdjbjdR6249QI03
         y6nMc13M2pb3o0wHEVARULPy79IhO/O91dAh4QfMrSqynqsw9qi8FwvjUue2KjVBiGjt
         l4tPdJHG8Kw2dmVwtq8h5x2CenicrXALEX/NObJbt0gw3KMx/GDrfNXnuxWxYkxxQZ6l
         MRSFyOB7pjHZV++rgvb+6bHNF/hKk0CxSrx/BIma2v0YaLgMp5lPgamUTYsT1s0A4qKh
         otZgD5fxLEzPQzIpVNE9c0WtaRVnB0W0WfNgXTWGcIRe3xwjB7AbEm+a3E13JM26J2eZ
         mlTA==
X-Forwarded-Encrypted: i=1; AJvYcCVlR9kBCPVMRJLNoH7Wxlfqc9xMxB0xJDZJSP2fmyIhkumOw6wJpdUrfsCIwix9Y5gv/qSdjmUQUouajsrOXSdWTbvXv/1vzgratQZd
X-Gm-Message-State: AOJu0Yw3cqSH/Fd27n06Kn92lwHaX9WW4RlBvQv5mx6nxdhiZQMkguBN
	pQDsf785S/f+XTP4DWZPmIW+cxu8vWroUXAIKDuA8ovaqymmA1KzhKnegLIwzA2cWoP73TNPd1e
	iZynumHv9HLVXqWEexSH+EjH1qOI=
X-Google-Smtp-Source: AGHT+IEXjSdkvjtxWYQcLRf8qaSUdAMJ6mc7CJ5VQN66uNb72ne3E0QX85V2VErvE87IpbMsOezEdKKt7Nr1SCWGQis=
X-Received: by 2002:a05:6402:3707:b0:567:504e:e7b0 with SMTP id
 ek7-20020a056402370700b00567504ee7b0mr2585995edb.3.1710491683938; Fri, 15 Mar
 2024 01:34:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304081348.197341-1-21cnbao@gmail.com> <20240304081348.197341-3-21cnbao@gmail.com>
 <499a60c6-eeb8-4bbd-8563-9717c0d2e43d@arm.com> <CANzGp4+kSxc_JbOsOcvm6vXfu2KORaqqGyuKK_eJwCLTK5X__Q@mail.gmail.com>
 <716bb29c-d2a2-4eef-b300-b037f08f458f@arm.com>
In-Reply-To: <716bb29c-d2a2-4eef-b300-b037f08f458f@arm.com>
From: Chuanhua Han <chuanhuahan@gmail.com>
Date: Fri, 15 Mar 2024 16:34:31 +0800
Message-ID: <CANzGp4KC4ucxJv_h2CZCgLUZ=x8J5sp4i46C02Gx9ddvF3sKrg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/5] mm: swap: introduce swap_nr_free() for batched swap_free()
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	chengming.zhou@linux.dev, chrisl@kernel.org, david@redhat.com, 
	hannes@cmpxchg.org, kasong@tencent.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, mhocko@suse.com, nphamcs@gmail.com, 
	shy828301@gmail.com, steven.price@arm.com, surenb@google.com, 
	wangkefeng.wang@huawei.com, willy@infradead.org, xiang@kernel.org, 
	ying.huang@intel.com, yosryahmed@google.com, yuzhao@google.com, 
	Chuanhua Han <hanchuanhua@oppo.com>, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ryan Roberts <ryan.roberts@arm.com> =E4=BA=8E2024=E5=B9=B43=E6=9C=8814=E6=
=97=A5=E5=91=A8=E5=9B=9B 21:43=E5=86=99=E9=81=93=EF=BC=9A
>
> On 14/03/2024 13:12, Chuanhua Han wrote:
> > Ryan Roberts <ryan.roberts@arm.com> =E4=BA=8E2024=E5=B9=B43=E6=9C=8812=
=E6=97=A5=E5=91=A8=E4=BA=8C 02:51=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On 04/03/2024 08:13, Barry Song wrote:
> >>> From: Chuanhua Han <hanchuanhua@oppo.com>
> >>>
> >>> While swapping in a large folio, we need to free swaps related to the=
 whole
> >>> folio. To avoid frequently acquiring and releasing swap locks, it is =
better
> >>> to introduce an API for batched free.
> >>>
> >>> Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> >>> Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> >>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >>> ---
> >>>  include/linux/swap.h |  6 ++++++
> >>>  mm/swapfile.c        | 35 +++++++++++++++++++++++++++++++++++
> >>>  2 files changed, 41 insertions(+)
> >>>
> >>> diff --git a/include/linux/swap.h b/include/linux/swap.h
> >>> index 2955f7a78d8d..d6ab27929458 100644
> >>> --- a/include/linux/swap.h
> >>> +++ b/include/linux/swap.h
> >>> @@ -481,6 +481,7 @@ extern void swap_shmem_alloc(swp_entry_t);
> >>>  extern int swap_duplicate(swp_entry_t);
> >>>  extern int swapcache_prepare(swp_entry_t);
> >>>  extern void swap_free(swp_entry_t);
> >>> +extern void swap_nr_free(swp_entry_t entry, int nr_pages);
> >>
> >> nit: In my swap-out v4 series, I've created a batched version of
> >> free_swap_and_cache() and called it free_swap_and_cache_nr(). Perhaps =
it is
> >> preferable to align the naming schemes - i.e. call this swap_free_nr()=
 Your
> >> scheme doesn't really work when applied to free_swap_and_cache().
> > Thanks for your suggestions, and for the next version, we'll see which
> > package is more appropriate!
> >>
> >>>  extern void swapcache_free_entries(swp_entry_t *entries, int n);
> >>>  extern int free_swap_and_cache(swp_entry_t);
> >>>  int swap_type_of(dev_t device, sector_t offset);
> >>> @@ -561,6 +562,11 @@ static inline void swap_free(swp_entry_t swp)
> >>>  {
> >>>  }
> >>>
> >>> +void swap_nr_free(swp_entry_t entry, int nr_pages)
> >>> +{
> >>> +
> >>> +}
> >>> +
> >>>  static inline void put_swap_folio(struct folio *folio, swp_entry_t s=
wp)
> >>>  {
> >>>  }
> >>> diff --git a/mm/swapfile.c b/mm/swapfile.c
> >>> index 3f594be83b58..244106998a69 100644
> >>> --- a/mm/swapfile.c
> >>> +++ b/mm/swapfile.c
> >>> @@ -1341,6 +1341,41 @@ void swap_free(swp_entry_t entry)
> >>>               __swap_entry_free(p, entry);
> >>>  }
> >>>
> >>> +/*
> >>> + * Called after swapping in a large folio, batched free swap entries
> >>> + * for this large folio, entry should be for the first subpage and
> >>> + * its offset is aligned with nr_pages
> >>> + */
> >>> +void swap_nr_free(swp_entry_t entry, int nr_pages)
> >>> +{
> >>> +     int i;
> >>> +     struct swap_cluster_info *ci;
> >>> +     struct swap_info_struct *p;
> >>> +     unsigned type =3D swp_type(entry);
> >>
> >> nit: checkpatch.py will complain about bare "unsigned", preferring "un=
signed
> >> int" or at least it did for me when I did something similar in my swap=
-out patch
> >> set.
> > Gee, thanks for pointing that out!
> >>
> >>> +     unsigned long offset =3D swp_offset(entry);
> >>> +     DECLARE_BITMAP(usage, SWAPFILE_CLUSTER) =3D { 0 };
> >>
> >> I don't love this, as it could blow the stack if SWAPFILE_CLUSTER ever
> >> increases. But the only other way I can think of is to explicitly loop=
 over
> >> fixed size chunks, and that's not much better.
> > Is it possible to save kernel stack better by using bit_map here?  If
> > SWAPFILE_CLUSTER=3D512, we consume only (512/64)*8=3D 64 bytes.
>
> I'm not sure I've understood what you are saying? You're already using
> DECLARE_BITMAP(), so its already consuming 64 bytes if SWAPFILE_CLUSTER=
=3D512, no?
>
> I actually did a bad job of trying to express a couple of different point=
s:
>
> - Are there any configurations today where SWAPFILE_CLUSTER > 512? I'm no=
t sure.
> Certainly not for arm64, but not sure about other architectures. For exam=
ple if
> an arch had 64K pages with 8192 entries per THP and supports SWAP_THP, th=
at's 1K
> for the bitmap, which is now looking pretty big for the stack.
I agree with you.The current bit_map grows linearly with the
SWAPFILE_CLUSTER, which may cause the kernel stack to swell.
I need to think of a way to save more memory .
>
> - Would it be better to decouple stack usage from SWAPFILE_CLUSTER and in=
stead
> define a fixed stack size (e.g. 64 bytes -> 512 entries). Then free the r=
ange of
> entries in batches no bigger than this size. This approach could also all=
ow
> removing the constraint that the range has to be aligned and fit in a sin=
gle
> cluster. Personally I think an approach like this would be much more robu=
st, in
> return for a tiny bit more complexity.
Because we cannot determine how many swap entries a cluster has in an
architecture or a configuration, we do not know how large the variable
needs to be defined=EF=BC=9F
>
> >>
> >>> +
> >>> +     /* all swap entries are within a cluster for mTHP */
> >>> +     VM_BUG_ON(offset % SWAPFILE_CLUSTER + nr_pages > SWAPFILE_CLUST=
ER);
> >>> +
> >>> +     if (nr_pages =3D=3D 1) {
> >>> +             swap_free(entry);
> >>> +             return;
> >>> +     }
> >>> +
> >>> +     p =3D _swap_info_get(entry);
> >>
> >> You need to handle this returning NULL, like swap_free() does.
> > Yes, you're right! We did forget to judge NULL here.
> >>
> >>> +
> >>> +     ci =3D lock_cluster(p, offset);
> >>
> >> The existing swap_free() calls lock_cluster_or_swap_info(). So if swap=
 is backed
> >> by rotating media, and clusters are not in use, it will lock the whole=
 swap
> >> info. But your new version only calls lock_cluster() which won't lock =
anything
> >> if clusters are not in use. So I think this is a locking bug.
> > Again, you're right, it's bug!
> >>
> >>> +     for (i =3D 0; i < nr_pages; i++) {
> >>> +             if (__swap_entry_free_locked(p, offset + i, 1))
> >>> +                     __bitmap_set(usage, i, 1);
> >>> +     }
> >>> +     unlock_cluster(ci);
> >>> +
> >>> +     for_each_clear_bit(i, usage, nr_pages)
> >>> +             free_swap_slot(swp_entry(type, offset + i));
> >>> +}
> >>> +
> >>>  /*
> >>>   * Called after dropping swapcache to decrease refcnt to swap entrie=
s.
> >>>   */
> >>
> >> Thanks,
> >> Ryan
> >>
> >>
> >
> >
>


--=20
Thanks,
Chuanhua

