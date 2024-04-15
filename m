Return-Path: <linux-kernel+bounces-144751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 756D18A4A34
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E01021F25E3C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCA8364BE;
	Mon, 15 Apr 2024 08:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KtRtT516"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67072CCA0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713169261; cv=none; b=MfGDR4cj/IE9bqichDP/F61qO9PmsTlWwQU98RM6alniHY7lZKOpBQ77la472kEgbt3yVmhoUeLrblk1C1LbLqbujjXSTkhQSNIowli14w/HTCFaj+L3YsOMFWC9gyMaRusb6fb3xP7nrl9pgSk7//0GhZ7xRQ8z4RWy5VjSJ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713169261; c=relaxed/simple;
	bh=g3apCSylVoUXQPkWFUXcaWmCe84hBETWAvlj8XEM98E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=etnzP4HYuZMPoTTFGUAM492eJvd8FyScBe0owuEAe7+szrpkxx+/6F9EDlimHKl5Nc7GCnnMB+lUVetQFuv0/nvgnW056T7MpjmPWrFvkffkqSjv6VjZpz3ytGPDC93DqU8l3kjepC/NvFAjDlW8KXoAzHlTXzCbol65n61lOp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KtRtT516; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713169260; x=1744705260;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=g3apCSylVoUXQPkWFUXcaWmCe84hBETWAvlj8XEM98E=;
  b=KtRtT516LRTv1A1gT6QdySIzwq4YKFhOE8qegBL3QUYSv4i7BgQxx2wO
   VLplpRKrz8j42cbA85WtQFycGP8TnymL1iaqM1zhzH0R6wCH0rEyYaNyD
   0T5zm2OzJwdk7HIeywldfxKx2orlc+eY0wdronfrBW7BMa2ok2nEtGjh0
   C8adHrB/lmqUaq4HJiHb5Ffs5NmlPi5uJvPVBBg9EEuG/UI3fMxHjiLkt
   ersBXvC33ENT98RpIjPee7yxQhLo+bUzNzbNTCiaJzxGRHXrxC4rAdDQr
   K7GUbcH4ZqKUCLBB2Kv+j8OtwhzDSBmrgMAwpIow/o4gFcNYGQeogqaeA
   g==;
X-CSE-ConnectionGUID: qpmN8BvRT9mjbzecfOji+g==
X-CSE-MsgGUID: EDvmWoZySre91zAkYAzx5w==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="26004211"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="26004211"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:20:59 -0700
X-CSE-ConnectionGUID: kKTqOL59SGq7JU4Pz7inVA==
X-CSE-MsgGUID: wxkIWeu1RLm5zBYp2pDu9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="26643090"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:20:55 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org,  linux-mm@kvack.org,
  baolin.wang@linux.alibaba.com,  chrisl@kernel.org,  david@redhat.com,
  hanchuanhua@oppo.com,  hannes@cmpxchg.org,  hughd@google.com,
  kasong@tencent.com,  ryan.roberts@arm.com,  surenb@google.com,
  v-songbaohua@oppo.com,  willy@infradead.org,  xiang@kernel.org,
  yosryahmed@google.com,  yuzhao@google.com,  ziy@nvidia.com,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] mm: swap: introduce swap_free_nr() for batched
 swap_free()
In-Reply-To: <CAGsJ_4yPQyQpWvB2KmuOh2vyUQA0A6hNHsypEC9Gptp9XtuDgg@mail.gmail.com>
	(Barry Song's message of "Mon, 15 Apr 2024 19:04:08 +1200")
References: <20240409082631.187483-1-21cnbao@gmail.com>
	<20240409082631.187483-2-21cnbao@gmail.com>
	<87y19f2lq3.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4yPQyQpWvB2KmuOh2vyUQA0A6hNHsypEC9Gptp9XtuDgg@mail.gmail.com>
Date: Mon, 15 Apr 2024 16:19:02 +0800
Message-ID: <87jzkz2g3t.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Barry Song <21cnbao@gmail.com> writes:

> On Mon, Apr 15, 2024 at 6:19=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Barry Song <21cnbao@gmail.com> writes:
>>
>> > From: Chuanhua Han <hanchuanhua@oppo.com>
>> >
>> > While swapping in a large folio, we need to free swaps related to the =
whole
>> > folio. To avoid frequently acquiring and releasing swap locks, it is b=
etter
>> > to introduce an API for batched free.
>> >
>> > Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
>> > Co-developed-by: Barry Song <v-songbaohua@oppo.com>
>> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>> > ---
>> >  include/linux/swap.h |  5 +++++
>> >  mm/swapfile.c        | 51 ++++++++++++++++++++++++++++++++++++++++++++
>> >  2 files changed, 56 insertions(+)
>> >
>> > diff --git a/include/linux/swap.h b/include/linux/swap.h
>> > index 11c53692f65f..b7a107e983b8 100644
>> > --- a/include/linux/swap.h
>> > +++ b/include/linux/swap.h
>> > @@ -483,6 +483,7 @@ extern void swap_shmem_alloc(swp_entry_t);
>> >  extern int swap_duplicate(swp_entry_t);
>> >  extern int swapcache_prepare(swp_entry_t);
>> >  extern void swap_free(swp_entry_t);
>> > +extern void swap_free_nr(swp_entry_t entry, int nr_pages);
>> >  extern void swapcache_free_entries(swp_entry_t *entries, int n);
>> >  extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
>> >  int swap_type_of(dev_t device, sector_t offset);
>> > @@ -564,6 +565,10 @@ static inline void swap_free(swp_entry_t swp)
>> >  {
>> >  }
>> >
>> > +void swap_free_nr(swp_entry_t entry, int nr_pages)
>> > +{
>> > +}
>> > +
>> >  static inline void put_swap_folio(struct folio *folio, swp_entry_t sw=
p)
>> >  {
>> >  }
>> > diff --git a/mm/swapfile.c b/mm/swapfile.c
>> > index 28642c188c93..f4c65aeb088d 100644
>> > --- a/mm/swapfile.c
>> > +++ b/mm/swapfile.c
>> > @@ -1356,6 +1356,57 @@ void swap_free(swp_entry_t entry)
>> >               __swap_entry_free(p, entry);
>> >  }
>> >
>> > +/*
>> > + * Free up the maximum number of swap entries at once to limit the
>> > + * maximum kernel stack usage.
>> > + */
>> > +#define SWAP_BATCH_NR (SWAPFILE_CLUSTER > 512 ? 512 : SWAPFILE_CLUSTE=
R)
>> > +
>> > +/*
>> > + * Called after swapping in a large folio,
>>
>> IMHO, it's not good to document the caller in the function definition.
>> Because this will discourage function reusing.
>
> ok. right now there is only one user that is why it is added. but i agree
> we can actually remove this.
>
>>
>> > batched free swap entries
>> > + * for this large folio, entry should be for the first subpage and
>> > + * its offset is aligned with nr_pages
>>
>> Why do we need this?
>
> This is a fundamental requirement for the existing kernel, folio's
> swap offset is naturally aligned from the first moment add_to_swap
> to add swapcache's xa. so this comment is describing the existing
> fact. In the future, if we want to support swap-out folio to discontiguous
> and not-aligned offsets, we can't pass entry as the parameter, we should
> instead pass ptep or another different data struct which can connect
> multiple discontiguous swap offsets.
>
> I feel like we only need "for this large folio, entry should be for
> the first subpage" and drop "and its offset is aligned with nr_pages",
> the latter is not important to this context at all.

IIUC, all these are requirements of the only caller now, not the
function itself.  If only part of the all swap entries of a mTHP are
called with swap_free_nr(), can swap_free_nr() still do its work?  If
so, why not make swap_free_nr() as general as possible?

>>
>> > + */
>> > +void swap_free_nr(swp_entry_t entry, int nr_pages)
>> > +{
>> > +     int i, j;
>> > +     struct swap_cluster_info *ci;
>> > +     struct swap_info_struct *p;
>> > +     unsigned int type =3D swp_type(entry);
>> > +     unsigned long offset =3D swp_offset(entry);
>> > +     int batch_nr, remain_nr;
>> > +     DECLARE_BITMAP(usage, SWAP_BATCH_NR) =3D { 0 };
>> > +
>> > +     /* all swap entries are within a cluster for mTHP */
>> > +     VM_BUG_ON(offset % SWAPFILE_CLUSTER + nr_pages > SWAPFILE_CLUSTE=
R);
>> > +
>> > +     if (nr_pages =3D=3D 1) {
>> > +             swap_free(entry);
>> > +             return;
>> > +     }
>>
>> Is it possible to unify swap_free() and swap_free_nr() into one function
>> with acceptable performance?  IIUC, the general rule in mTHP effort is
>> to avoid duplicate functions between mTHP and normal small folio.
>> Right?
>
> I don't see why.

Because duplicated implementation are hard to maintain in the long term.

> but we have lots of places calling swap_free(), we may
> have to change them all to call swap_free_nr(entry, 1); the other possible
> way is making swap_free() a wrapper of swap_free_nr() always using
> 1 as the argument. In both cases, we are changing the semantics of
> swap_free_nr() to partially freeing large folio cases and have to drop
> "entry should be for the first subpage" then.
>
> Right now, the semantics is
> * swap_free_nr() for an entire large folio;
> * swap_free() for one entry of either a large folio or a small folio

As above, I don't think the these semantics are important for
swap_free_nr() implementation.

>>
>> > +
>> > +     remain_nr =3D nr_pages;
>> > +     p =3D _swap_info_get(entry);
>> > +     if (p) {
>> > +             for (i =3D 0; i < nr_pages; i +=3D batch_nr) {
>> > +                     batch_nr =3D min_t(int, SWAP_BATCH_NR, remain_nr=
);
>> > +
>> > +                     ci =3D lock_cluster_or_swap_info(p, offset);
>> > +                     for (j =3D 0; j < batch_nr; j++) {
>> > +                             if (__swap_entry_free_locked(p, offset +=
 i * SWAP_BATCH_NR + j, 1))
>> > +                                     __bitmap_set(usage, j, 1);
>> > +                     }
>> > +                     unlock_cluster_or_swap_info(p, ci);
>> > +
>> > +                     for_each_clear_bit(j, usage, batch_nr)
>> > +                             free_swap_slot(swp_entry(type, offset + =
i * SWAP_BATCH_NR + j));
>> > +
>> > +                     bitmap_clear(usage, 0, SWAP_BATCH_NR);
>> > +                     remain_nr -=3D batch_nr;
>> > +             }
>> > +     }
>> > +}
>> > +
>> >  /*
>> >   * Called after dropping swapcache to decrease refcnt to swap entries.
>> >   */
>>
>> put_swap_folio() implements batching in another method.  Do you think
>> that it's good to use the batching method in that function here?  It
>> avoids to use bitmap operations and stack space.
>
> Chuanhua has strictly limited the maximum stack usage to several
> unsigned long,

512 / 8 =3D 64 bytes.

So, not trivial.

> so this should be safe. on the other hand, i believe this
> implementation is more efficient, as  put_swap_folio() might lock/
> unlock much more often whenever __swap_entry_free_locked returns
> 0.

There are 2 most common use cases,

- all swap entries have usage count =3D=3D 0
- all swap entries have usage count !=3D 0

In both cases, we only need to lock/unlock once.  In fact, I didn't
find possible use cases other than above.

And, we should add batching in __swap_entry_free().  That will help
free_swap_and_cache_nr() too.

--
Best Regards,
Huang, Ying

