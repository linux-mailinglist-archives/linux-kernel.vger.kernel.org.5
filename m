Return-Path: <linux-kernel+bounces-144726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA428A49C4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E52285953
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5FE2EAE6;
	Mon, 15 Apr 2024 08:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNBLxjGr"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27912C848
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713168380; cv=none; b=cwvYAyQknBr8QtntQqij1gPa2wn5l1K/AsfwHohu/YIeqsNcB6sXfstuW2prvzChsF8V60bpAktn6QAVovdkcLS3WLp4xbvFyk1Or4wTzsFDkh8Ke+bDZ9GrvwS49er1V/Qss5FhKWWn+FmsOFUEMxLEo7H4RZBPeVnJrcK/UXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713168380; c=relaxed/simple;
	bh=rgybqiglY94WB5ajv9EF4jmrw4McpOOaxj01E9RCkiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fdtY9LknGuUdm78VYY1e8jtcQaRGeOw+69AxVGRrkKtxyuzRih4in7x5MzeEnMz08e2ZIwYGH2m5syrVRIQVVrZTrJsgPi1fbQDJyU3o+mRUr1n2Hvpq2y9RJJ7plg2JTrO3D13pyNE9mG6TBAakfmhqZMXh8nKdGWguo+vYbvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNBLxjGr; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4db27d21a22so879776e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 01:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713168374; x=1713773174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZov5IXbVD5zRtgFDmBf+N6QydhzyAhsqPviO3FYvFo=;
        b=MNBLxjGrBBgFvbCHzt+br5/3m2z4QlIYj8Y3LICLLw5rC2XOA7Rd19qL11WCK+41JD
         FhT4fD8Ki+tfV2yw83d7hogYeCgTk3nBrr9TFTzo9I9VkhZ42ZjiNBkF7YQ3oBNxIjem
         oim+WoRThif4v0pUgs8h2/w6mQt1wnIkbEj5PYSaBSqPlBR25ERTbiKgt5bFJIrkegDt
         5F4tYFpC/+8DTkrl5VY+eB7Ljk4PS5v/YZeAIvvIDsj8wIQP4u9rfmRHSNEF4gNk0sHp
         kn7rNUMNzBdEg0MZF1h56J/2aCdtWYx3pyDjGaSbfyFzIzw0K5OTXQHBfGzhlwONfG7i
         gzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713168374; x=1713773174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZov5IXbVD5zRtgFDmBf+N6QydhzyAhsqPviO3FYvFo=;
        b=wkHTtTVdxMeMAD2y8BwMmi8sMtedGWneqo6u0CZCR6BRdjcUNeLjFTQwi0fcMq+ayM
         PyOtJo4nJK3wW9rTPL9aOvG0tt+ed+tyYHNRcT1Qc9pYObY/gjKKLuxPLjBVOEGVm5mT
         0UDp7/lkd9VLiMtrLPUjBT0nO6nD6L92SMbtXj/sHt0fbVEAxRz9oqDHKPhNlagYLid2
         ittKIUiRpUy5Z9DqLCE2tvEqQ7kBbLiTs08qojdKKPgaLGA8Mb73zXRu9MbxA6ogt4BC
         uYSEnMYvNP75qT+TSwt6a7lUjxVHM1tCAkepbmLtN5xno1+EwuB5kyLAwLld1SHMKGH2
         bN6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBHfZ85KSr4ubM0x/2t7CWKHJS7ClHCrazmJG7xdxpL/79XFHMMXElBu+Rn6a0Ce+EMnwFqMcwrNWriUo2mTR3oNY03mI0G/L4U29U
X-Gm-Message-State: AOJu0YxuTZjl6KjE31rBDdG/+o3LwvvQI++p15RDS1sdw+jRoLYn9VLL
	dwzpqNOVAZ7qVtkvn7eTF8beZgLApHy0fW+cSzZ5YYm/akT5oCyQE8wYqsrjaDsNG/MdBOuAcq9
	9VvBlEpresILco49QTzZfcls8psw=
X-Google-Smtp-Source: AGHT+IGXW7+hY2jMvtyJ3Z+5CSKVwo38ThgHuB85w+Tj37wRqEtGUCd1FDt5/WygLFYUwmoRhZql8ze4TzHINlVA+uw=
X-Received: by 2002:a05:6122:2209:b0:4c9:a9c9:4b3b with SMTP id
 bb9-20020a056122220900b004c9a9c94b3bmr7330288vkb.9.1713168374572; Mon, 15 Apr
 2024 01:06:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409082631.187483-1-21cnbao@gmail.com> <20240409082631.187483-2-21cnbao@gmail.com>
 <87y19f2lq3.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4yPQyQpWvB2KmuOh2vyUQA0A6hNHsypEC9Gptp9XtuDgg@mail.gmail.com>
In-Reply-To: <CAGsJ_4yPQyQpWvB2KmuOh2vyUQA0A6hNHsypEC9Gptp9XtuDgg@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 15 Apr 2024 20:06:03 +1200
Message-ID: <CAGsJ_4wLvRNx0dHvoS3Vc+d19BmfioceJdmPm5Ge+Kj55q3Lsw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] mm: swap: introduce swap_free_nr() for batched swap_free()
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hanchuanhua@oppo.com, hannes@cmpxchg.org, hughd@google.com, 
	kasong@tencent.com, ryan.roberts@arm.com, surenb@google.com, 
	v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org, 
	yosryahmed@google.com, yuzhao@google.com, ziy@nvidia.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 7:04=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Mon, Apr 15, 2024 at 6:19=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
> >
> > Barry Song <21cnbao@gmail.com> writes:
> >
> > > From: Chuanhua Han <hanchuanhua@oppo.com>
> > >
> > > While swapping in a large folio, we need to free swaps related to the=
 whole
> > > folio. To avoid frequently acquiring and releasing swap locks, it is =
better
> > > to introduce an API for batched free.
> > >
> > > Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> > > Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> > > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > > ---
> > >  include/linux/swap.h |  5 +++++
> > >  mm/swapfile.c        | 51 ++++++++++++++++++++++++++++++++++++++++++=
++
> > >  2 files changed, 56 insertions(+)
> > >
> > > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > > index 11c53692f65f..b7a107e983b8 100644
> > > --- a/include/linux/swap.h
> > > +++ b/include/linux/swap.h
> > > @@ -483,6 +483,7 @@ extern void swap_shmem_alloc(swp_entry_t);
> > >  extern int swap_duplicate(swp_entry_t);
> > >  extern int swapcache_prepare(swp_entry_t);
> > >  extern void swap_free(swp_entry_t);
> > > +extern void swap_free_nr(swp_entry_t entry, int nr_pages);
> > >  extern void swapcache_free_entries(swp_entry_t *entries, int n);
> > >  extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
> > >  int swap_type_of(dev_t device, sector_t offset);
> > > @@ -564,6 +565,10 @@ static inline void swap_free(swp_entry_t swp)
> > >  {
> > >  }
> > >
> > > +void swap_free_nr(swp_entry_t entry, int nr_pages)
> > > +{
> > > +}
> > > +
> > >  static inline void put_swap_folio(struct folio *folio, swp_entry_t s=
wp)
> > >  {
> > >  }
> > > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > > index 28642c188c93..f4c65aeb088d 100644
> > > --- a/mm/swapfile.c
> > > +++ b/mm/swapfile.c
> > > @@ -1356,6 +1356,57 @@ void swap_free(swp_entry_t entry)
> > >               __swap_entry_free(p, entry);
> > >  }
> > >
> > > +/*
> > > + * Free up the maximum number of swap entries at once to limit the
> > > + * maximum kernel stack usage.
> > > + */
> > > +#define SWAP_BATCH_NR (SWAPFILE_CLUSTER > 512 ? 512 : SWAPFILE_CLUST=
ER)
> > > +
> > > +/*
> > > + * Called after swapping in a large folio,
> >
> > IMHO, it's not good to document the caller in the function definition.
> > Because this will discourage function reusing.
>
> ok. right now there is only one user that is why it is added. but i agree
> we can actually remove this.
>
> >
> > > batched free swap entries
> > > + * for this large folio, entry should be for the first subpage and
> > > + * its offset is aligned with nr_pages
> >
> > Why do we need this?
>
> This is a fundamental requirement for the existing kernel, folio's
> swap offset is naturally aligned from the first moment add_to_swap
> to add swapcache's xa. so this comment is describing the existing
> fact. In the future, if we want to support swap-out folio to discontiguou=
s
> and not-aligned offsets, we can't pass entry as the parameter, we should
> instead pass ptep or another different data struct which can connect
> multiple discontiguous swap offsets.
>
> I feel like we only need "for this large folio, entry should be for
> the first subpage" and drop "and its offset is aligned with nr_pages",
> the latter is not important to this context at all.

upon further consideration, the comment is inaccurate since we do support
nr_pages =3D=3D 1, and do_swap_page() has indeed been invoked with this val=
ue.
Therefore, we should completely remove the comment.

>
> >
> > > + */
> > > +void swap_free_nr(swp_entry_t entry, int nr_pages)
> > > +{
> > > +     int i, j;
> > > +     struct swap_cluster_info *ci;
> > > +     struct swap_info_struct *p;
> > > +     unsigned int type =3D swp_type(entry);
> > > +     unsigned long offset =3D swp_offset(entry);
> > > +     int batch_nr, remain_nr;
> > > +     DECLARE_BITMAP(usage, SWAP_BATCH_NR) =3D { 0 };
> > > +
> > > +     /* all swap entries are within a cluster for mTHP */
> > > +     VM_BUG_ON(offset % SWAPFILE_CLUSTER + nr_pages > SWAPFILE_CLUST=
ER);
> > > +
> > > +     if (nr_pages =3D=3D 1) {
> > > +             swap_free(entry);
> > > +             return;
> > > +     }
> >
> > Is it possible to unify swap_free() and swap_free_nr() into one functio=
n
> > with acceptable performance?  IIUC, the general rule in mTHP effort is
> > to avoid duplicate functions between mTHP and normal small folio.
> > Right?
>
> I don't see why. but we have lots of places calling swap_free(), we may
> have to change them all to call swap_free_nr(entry, 1); the other possibl=
e
> way is making swap_free() a wrapper of swap_free_nr() always using
> 1 as the argument. In both cases, we are changing the semantics of
> swap_free_nr() to partially freeing large folio cases and have to drop
> "entry should be for the first subpage" then.
>
> Right now, the semantics is
> * swap_free_nr() for an entire large folio;
> * swap_free() for one entry of either a large folio or a small folio
>
> >
> > > +
> > > +     remain_nr =3D nr_pages;
> > > +     p =3D _swap_info_get(entry);
> > > +     if (p) {
> > > +             for (i =3D 0; i < nr_pages; i +=3D batch_nr) {
> > > +                     batch_nr =3D min_t(int, SWAP_BATCH_NR, remain_n=
r);
> > > +
> > > +                     ci =3D lock_cluster_or_swap_info(p, offset);
> > > +                     for (j =3D 0; j < batch_nr; j++) {
> > > +                             if (__swap_entry_free_locked(p, offset =
+ i * SWAP_BATCH_NR + j, 1))
> > > +                                     __bitmap_set(usage, j, 1);
> > > +                     }
> > > +                     unlock_cluster_or_swap_info(p, ci);
> > > +
> > > +                     for_each_clear_bit(j, usage, batch_nr)
> > > +                             free_swap_slot(swp_entry(type, offset +=
 i * SWAP_BATCH_NR + j));
> > > +
> > > +                     bitmap_clear(usage, 0, SWAP_BATCH_NR);
> > > +                     remain_nr -=3D batch_nr;
> > > +             }
> > > +     }
> > > +}
> > > +
> > >  /*
> > >   * Called after dropping swapcache to decrease refcnt to swap entrie=
s.
> > >   */
> >
> > put_swap_folio() implements batching in another method.  Do you think
> > that it's good to use the batching method in that function here?  It
> > avoids to use bitmap operations and stack space.
>
> Chuanhua has strictly limited the maximum stack usage to several
> unsigned long, so this should be safe. on the other hand, i believe this
> implementation is more efficient, as  put_swap_folio() might lock/
> unlock much more often whenever __swap_entry_free_locked returns
> 0.
>
> >
> > --
> > Best Regards,
> > Huang, Ying
>
> Thanks
> Barry

