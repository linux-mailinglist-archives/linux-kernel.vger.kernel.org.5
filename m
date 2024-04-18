Return-Path: <linux-kernel+bounces-149779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A99F68A95C4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6534D282DA9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D120015AAC9;
	Thu, 18 Apr 2024 09:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6iaNygG"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F299415A499
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 09:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713431699; cv=none; b=YHThQnvxE0Ng0isCQ5lQvBK/02LpWitl140eLyF6k3PJUH+Mv5o/DYXJ0cfjNqu2WmXg+d/l5yFtUzGiZ/i319uzSr1TynYpzUBX7QlHEtyLPmV2WJfFMBi6v78o+/CuxPhuyDEUK8XBbC5DEl6SMtM2ctPlztM7h08u3XIv/HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713431699; c=relaxed/simple;
	bh=f2D1GhcySDMy8/qnRUNzAmyV+jZJk9VQdN2gJIvQ2OQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bRp08eAQCZOGfN0gutxEyecUeXgtowKMDpB9SHlcJ4+vrTNNAxWM4qi+SfebIeJvhjId6Jo6jYX/Q/BXlrGWCDSmM1o5oNyHqiqMU900M8RXs5Abi+PqIM9lnGvj91dmotw2Um5KK/ZlllvtlfdvnjJsF9B5wEf3ev9/c1sURk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6iaNygG; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4dac112e142so208078e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 02:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713431696; x=1714036496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0uFXiqaMwXoo8/JHTKBB1Bo8adWkXp3D6NyREx2fjsg=;
        b=G6iaNygGRJ88+01qQ8OB2SAimWZsWm/euz8IGLd6E8eSMuslAs4LgVQaHmFsc+jcYG
         kKi8E3PeMZ+sQuPgZ6sMaZ5QoS5XH0qaVsqpVQL2Rdi93afxHLjKaDR1iAnrZ0qFlRQp
         KqvtlYv6g7q0kYJ1S/hSZEFupYL70jsDsUi4MUzkUTOkXz5AHIs3ZyRzOj9F38RRx8x2
         nTHJIOlHnb0fTgXLzczQ4U6Olql+0KRf+h0JrdS0CNdDscZXvOvweu4+NVPbkhJBXUF6
         +o0p+4pwmfGsa6hc+y+S+I9g4X3FcXZUrfmuZtoUJt1vwnv5rC9dkLaHzxuvvtZYLs48
         AdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713431696; x=1714036496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0uFXiqaMwXoo8/JHTKBB1Bo8adWkXp3D6NyREx2fjsg=;
        b=KEUZu9LNdwCtG3pEY1/O7f+78CnQ/halIrp3/Xc35vFJk5yw05V6oKCK/YOLZ1j8yg
         UMStV2s9BheclL0Q/WUgzsSOGu394vZu9c0RH2OcrW2qw34JD4UWYLus7EfPxYSqRFRB
         3aHtP+e3AKpsWvmO77OUXxXkmPPYB5zdhO+5XTo6UTaNTyrNLV/VDeu7JRS88PAifxUP
         BE8IdLcoEAZqwDmKj12z+1J9FO2xwFm7POitPSFClM/3SL63zGybbfosLk+jegckmbRL
         zriftwy8Wxlbs9ZD80AIFGRTA5EyAAOwMBhPAr4CVF0IhDBOdofzLy0vQN0h9Er7XnDF
         0EFg==
X-Forwarded-Encrypted: i=1; AJvYcCWTSY52j5sLbHvCzNP8CnI7L37nPQulXm2AAcMxscFJk+ujgtpMJG+3ez4gmvqCe2i/3L9WiLAs7HQZLPCIzgWj+smZ0u+Brfp9M7iI
X-Gm-Message-State: AOJu0YyhM7WVRV1TtMW1/X3tZt1MTN2BL7JYOfiJKvPW83SctoGV6Q+z
	4w8pZsireM+FVOBK+BFPhQnCPjxqANlV142oPa/ksVEaym76KSXNRv4AeR/B9X13zGNHmYfjTpM
	FwMtaze4BCj/TxZVdqm/Q7zCwhNI=
X-Google-Smtp-Source: AGHT+IEH1UBe4r5gDOje4+5/5IxMxCr5XWtqpmKtsFUIoLLvCEIuK5DL1UZFw1AbR1BUHH5CSTYk0MfLEn6LdY3Ir+Y=
X-Received: by 2002:a05:6122:9a4:b0:4da:9bcd:b097 with SMTP id
 g36-20020a05612209a400b004da9bcdb097mr2261447vkd.9.1713431694667; Thu, 18 Apr
 2024 02:14:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409082631.187483-1-21cnbao@gmail.com> <20240409082631.187483-2-21cnbao@gmail.com>
 <87y19f2lq3.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4yPQyQpWvB2KmuOh2vyUQA0A6hNHsypEC9Gptp9XtuDgg@mail.gmail.com>
 <87jzkz2g3t.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4wm4SfkyTBHpU46EPTFvhq8e54F3KRkKj6gTBcnOjCw1g@mail.gmail.com>
 <87bk6b2elo.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4zH4RHhZembtXOqzBDL75MA5NiEjMHx7eCN-a1ifnKTBw@mail.gmail.com>
 <877cgy2ifu.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4yim-PQW0JBjZD8dpGBG3FQm=xZb1V51+Nr37nJEwEPzA@mail.gmail.com>
 <87ttk20zns.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4xigDba15o9K84z9nR_ZW1nXsUWa0LRNmUAfDdxcqsddw@mail.gmail.com>
 <87jzkw25hl.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4wTsJe2yK3k+Tif6obgL9LUUuqXEBxhqMSZSFZpbvrzmA@mail.gmail.com>
 <CAGsJ_4ymv-tmpmH0s1D5+GF13UOPv5UdRFrLOxVE5X+xNUHveg@mail.gmail.com> <87le5bxd6n.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87le5bxd6n.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 18 Apr 2024 21:14:42 +1200
Message-ID: <CAGsJ_4wtpkGrfAP23+LgUuUi0BDqS3jjdGu6Y2JDbwTskgA3yQ@mail.gmail.com>
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

On Thu, Apr 18, 2024 at 8:57=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Wed, Apr 17, 2024 at 1:35=E2=80=AFPM Barry Song <21cnbao@gmail.com> =
wrote:
> >>
> >> On Wed, Apr 17, 2024 at 12:34=E2=80=AFPM Huang, Ying <ying.huang@intel=
com> wrote:
> >> >
> >> > Barry Song <21cnbao@gmail.com> writes:
> >> >
> >> > > On Tue, Apr 16, 2024 at 3:13=E2=80=AFPM Huang, Ying <ying.huang@in=
tel.com> wrote:
> >> > >>
> >> > >> Barry Song <21cnbao@gmail.com> writes:
> >> > >>
> >> > >> > On Tue, Apr 16, 2024 at 1:42=E2=80=AFPM Huang, Ying <ying.huang=
@intel.com> wrote:
> >> > >> >>
> >> > >> >> Barry Song <21cnbao@gmail.com> writes:
> >> > >> >>
> >> > >> >> > On Mon, Apr 15, 2024 at 8:53=E2=80=AFPM Huang, Ying <ying.hu=
ang@intel.com> wrote:
> >> > >> >> >>
> >> > >> >> >> Barry Song <21cnbao@gmail.com> writes:
> >> > >> >> >>
> >> > >> >> >> > On Mon, Apr 15, 2024 at 8:21=E2=80=AFPM Huang, Ying <ying=
huang@intel.com> wrote:
> >> > >> >> >> >>
> >> > >> >> >> >> Barry Song <21cnbao@gmail.com> writes:
> >> > >> >> >> >>
> >> > >> >> >> >> > On Mon, Apr 15, 2024 at 6:19=E2=80=AFPM Huang, Ying <y=
ing.huang@intel.com> wrote:
> >> > >> >> >> >> >>
> >> > >> >> >> >> >> Barry Song <21cnbao@gmail.com> writes:
> >> > >> >> >> >> >>
> >> > >> >> >> >> >> > From: Chuanhua Han <hanchuanhua@oppo.com>
> >> > >> >> >> >> >> >
> >> > >> >> >> >> >> > While swapping in a large folio, we need to free sw=
aps related to the whole
> >> > >> >> >> >> >> > folio. To avoid frequently acquiring and releasing =
swap locks, it is better
> >> > >> >> >> >> >> > to introduce an API for batched free.
> >> > >> >> >> >> >> >
> >> > >> >> >> >> >> > Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> >> > >> >> >> >> >> > Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> >> > >> >> >> >> >> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >> > >> >> >> >> >> > ---
> >> > >> >> >> >> >> >  include/linux/swap.h |  5 +++++
> >> > >> >> >> >> >> >  mm/swapfile.c        | 51 ++++++++++++++++++++++++=
++++++++++++++++++++
> >> > >> >> >> >> >> >  2 files changed, 56 insertions(+)
> >> > >> >> >> >> >> >
> >> > >> >> >> >> >> > diff --git a/include/linux/swap.h b/include/linux/s=
wap.h
> >> > >> >> >> >> >> > index 11c53692f65f..b7a107e983b8 100644
> >> > >> >> >> >> >> > --- a/include/linux/swap.h
> >> > >> >> >> >> >> > +++ b/include/linux/swap.h
> >> > >> >> >> >> >> > @@ -483,6 +483,7 @@ extern void swap_shmem_alloc(sw=
p_entry_t);
> >> > >> >> >> >> >> >  extern int swap_duplicate(swp_entry_t);
> >> > >> >> >> >> >> >  extern int swapcache_prepare(swp_entry_t);
> >> > >> >> >> >> >> >  extern void swap_free(swp_entry_t);
> >> > >> >> >> >> >> > +extern void swap_free_nr(swp_entry_t entry, int nr=
_pages);
> >> > >> >> >> >> >> >  extern void swapcache_free_entries(swp_entry_t *en=
tries, int n);
> >> > >> >> >> >> >> >  extern void free_swap_and_cache_nr(swp_entry_t ent=
ry, int nr);
> >> > >> >> >> >> >> >  int swap_type_of(dev_t device, sector_t offset);
> >> > >> >> >> >> >> > @@ -564,6 +565,10 @@ static inline void swap_free(s=
wp_entry_t swp)
> >> > >> >> >> >> >> >  {
> >> > >> >> >> >> >> >  }
> >> > >> >> >> >> >> >
> >> > >> >> >> >> >> > +void swap_free_nr(swp_entry_t entry, int nr_pages)
> >> > >> >> >> >> >> > +{
> >> > >> >> >> >> >> > +}
> >> > >> >> >> >> >> > +
> >> > >> >> >> >> >> >  static inline void put_swap_folio(struct folio *fo=
lio, swp_entry_t swp)
> >> > >> >> >> >> >> >  {
> >> > >> >> >> >> >> >  }
> >> > >> >> >> >> >> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> >> > >> >> >> >> >> > index 28642c188c93..f4c65aeb088d 100644
> >> > >> >> >> >> >> > --- a/mm/swapfile.c
> >> > >> >> >> >> >> > +++ b/mm/swapfile.c
> >> > >> >> >> >> >> > @@ -1356,6 +1356,57 @@ void swap_free(swp_entry_t e=
ntry)
> >> > >> >> >> >> >> >               __swap_entry_free(p, entry);
> >> > >> >> >> >> >> >  }
> >> > >> >> >> >> >> >
> >> > >> >> >> >> >> > +/*
> >> > >> >> >> >> >> > + * Free up the maximum number of swap entries at o=
nce to limit the
> >> > >> >> >> >> >> > + * maximum kernel stack usage.
> >> > >> >> >> >> >> > + */
> >> > >> >> >> >> >> > +#define SWAP_BATCH_NR (SWAPFILE_CLUSTER > 512 ? 51=
2 : SWAPFILE_CLUSTER)
> >> > >> >> >> >> >> > +
> >> > >> >> >> >> >> > +/*
> >> > >> >> >> >> >> > + * Called after swapping in a large folio,
> >> > >> >> >> >> >>
> >> > >> >> >> >> >> IMHO, it's not good to document the caller in the fun=
ction definition.
> >> > >> >> >> >> >> Because this will discourage function reusing.
> >> > >> >> >> >> >
> >> > >> >> >> >> > ok. right now there is only one user that is why it is=
 added. but i agree
> >> > >> >> >> >> > we can actually remove this.
> >> > >> >> >> >> >
> >> > >> >> >> >> >>
> >> > >> >> >> >> >> > batched free swap entries
> >> > >> >> >> >> >> > + * for this large folio, entry should be for the f=
irst subpage and
> >> > >> >> >> >> >> > + * its offset is aligned with nr_pages
> >> > >> >> >> >> >>
> >> > >> >> >> >> >> Why do we need this?
> >> > >> >> >> >> >
> >> > >> >> >> >> > This is a fundamental requirement for the existing ker=
nel, folio's
> >> > >> >> >> >> > swap offset is naturally aligned from the first moment=
 add_to_swap
> >> > >> >> >> >> > to add swapcache's xa. so this comment is describing t=
he existing
> >> > >> >> >> >> > fact. In the future, if we want to support swap-out fo=
lio to discontiguous
> >> > >> >> >> >> > and not-aligned offsets, we can't pass entry as the pa=
rameter, we should
> >> > >> >> >> >> > instead pass ptep or another different data struct whi=
ch can connect
> >> > >> >> >> >> > multiple discontiguous swap offsets.
> >> > >> >> >> >> >
> >> > >> >> >> >> > I feel like we only need "for this large folio, entry =
should be for
> >> > >> >> >> >> > the first subpage" and drop "and its offset is aligned=
 with nr_pages",
> >> > >> >> >> >> > the latter is not important to this context at all.
> >> > >> >> >> >>
> >> > >> >> >> >> IIUC, all these are requirements of the only caller now,=
 not the
> >> > >> >> >> >> function itself.  If only part of the all swap entries o=
f a mTHP are
> >> > >> >> >> >> called with swap_free_nr(), can swap_free_nr() still do =
its work?  If
> >> > >> >> >> >> so, why not make swap_free_nr() as general as possible?
> >> > >> >> >> >
> >> > >> >> >> > right , i believe we can make swap_free_nr() as general a=
s possible.
> >> > >> >> >> >
> >> > >> >> >> >>
> >> > >> >> >> >> >>
> >> > >> >> >> >> >> > + */
> >> > >> >> >> >> >> > +void swap_free_nr(swp_entry_t entry, int nr_pages)
> >> > >> >> >> >> >> > +{
> >> > >> >> >> >> >> > +     int i, j;
> >> > >> >> >> >> >> > +     struct swap_cluster_info *ci;
> >> > >> >> >> >> >> > +     struct swap_info_struct *p;
> >> > >> >> >> >> >> > +     unsigned int type =3D swp_type(entry);
> >> > >> >> >> >> >> > +     unsigned long offset =3D swp_offset(entry);
> >> > >> >> >> >> >> > +     int batch_nr, remain_nr;
> >> > >> >> >> >> >> > +     DECLARE_BITMAP(usage, SWAP_BATCH_NR) =3D { 0 =
};
> >> > >> >> >> >> >> > +
> >> > >> >> >> >> >> > +     /* all swap entries are within a cluster for =
mTHP */
> >> > >> >> >> >> >> > +     VM_BUG_ON(offset % SWAPFILE_CLUSTER + nr_page=
s > SWAPFILE_CLUSTER);
> >> > >> >> >> >> >> > +
> >> > >> >> >> >> >> > +     if (nr_pages =3D=3D 1) {
> >> > >> >> >> >> >> > +             swap_free(entry);
> >> > >> >> >> >> >> > +             return;
> >> > >> >> >> >> >> > +     }
> >> > >> >> >> >> >>
> >> > >> >> >> >> >> Is it possible to unify swap_free() and swap_free_nr(=
) into one function
> >> > >> >> >> >> >> with acceptable performance?  IIUC, the general rule =
in mTHP effort is
> >> > >> >> >> >> >> to avoid duplicate functions between mTHP and normal =
small folio.
> >> > >> >> >> >> >> Right?
> >> > >> >> >> >> >
> >> > >> >> >> >> > I don't see why.
> >> > >> >> >> >>
> >> > >> >> >> >> Because duplicated implementation are hard to maintain i=
n the long term.
> >> > >> >> >> >
> >> > >> >> >> > sorry, i actually meant "I don't see why not",  for some =
reason, the "not"
> >> > >> >> >> > was missed. Obviously I meant "why not", there was a "but=
" after it :-)
> >> > >> >> >> >
> >> > >> >> >> >>
> >> > >> >> >> >> > but we have lots of places calling swap_free(), we may
> >> > >> >> >> >> > have to change them all to call swap_free_nr(entry, 1)=
; the other possible
> >> > >> >> >> >> > way is making swap_free() a wrapper of swap_free_nr() =
always using
> >> > >> >> >> >> > 1 as the argument. In both cases, we are changing the =
semantics of
> >> > >> >> >> >> > swap_free_nr() to partially freeing large folio cases =
and have to drop
> >> > >> >> >> >> > "entry should be for the first subpage" then.
> >> > >> >> >> >> >
> >> > >> >> >> >> > Right now, the semantics is
> >> > >> >> >> >> > * swap_free_nr() for an entire large folio;
> >> > >> >> >> >> > * swap_free() for one entry of either a large folio or=
 a small folio
> >> > >> >> >> >>
> >> > >> >> >> >> As above, I don't think the these semantics are importan=
t for
> >> > >> >> >> >> swap_free_nr() implementation.
> >> > >> >> >> >
> >> > >> >> >> > right. I agree. If we are ready to change all those calle=
rs, nothing
> >> > >> >> >> > can stop us from removing swap_free().
> >> > >> >> >> >
> >> > >> >> >> >>
> >> > >> >> >> >> >>
> >> > >> >> >> >> >> > +
> >> > >> >> >> >> >> > +     remain_nr =3D nr_pages;
> >> > >> >> >> >> >> > +     p =3D _swap_info_get(entry);
> >> > >> >> >> >> >> > +     if (p) {
> >> > >> >> >> >> >> > +             for (i =3D 0; i < nr_pages; i +=3D ba=
tch_nr) {
> >> > >> >> >> >> >> > +                     batch_nr =3D min_t(int, SWAP_=
BATCH_NR, remain_nr);
> >> > >> >> >> >> >> > +
> >> > >> >> >> >> >> > +                     ci =3D lock_cluster_or_swap_i=
nfo(p, offset);
> >> > >> >> >> >> >> > +                     for (j =3D 0; j < batch_nr; j=
++) {
> >> > >> >> >> >> >> > +                             if (__swap_entry_free=
_locked(p, offset + i * SWAP_BATCH_NR + j, 1))
> >> > >> >> >> >> >> > +                                     __bitmap_set(=
usage, j, 1);
> >> > >> >> >> >> >> > +                     }
> >> > >> >> >> >> >> > +                     unlock_cluster_or_swap_info(p=
, ci);
> >> > >> >> >> >> >> > +
> >> > >> >> >> >> >> > +                     for_each_clear_bit(j, usage, =
batch_nr)
> >> > >> >> >> >> >> > +                             free_swap_slot(swp_en=
try(type, offset + i * SWAP_BATCH_NR + j));
> >> > >> >> >> >> >> > +
> >> > >> >> >> >> >> > +                     bitmap_clear(usage, 0, SWAP_B=
ATCH_NR);
> >> > >> >> >> >> >> > +                     remain_nr -=3D batch_nr;
> >> > >> >> >> >> >> > +             }
> >> > >> >> >> >> >> > +     }
> >> > >> >> >> >> >> > +}
> >> > >> >> >> >> >> > +
> >> > >> >> >> >> >> >  /*
> >> > >> >> >> >> >> >   * Called after dropping swapcache to decrease ref=
cnt to swap entries.
> >> > >> >> >> >> >> >   */
> >> > >> >> >> >> >>
> >> > >> >> >> >> >> put_swap_folio() implements batching in another metho=
d.  Do you think
> >> > >> >> >> >> >> that it's good to use the batching method in that fun=
ction here?  It
> >> > >> >> >> >> >> avoids to use bitmap operations and stack space.
> >> > >> >> >> >> >
> >> > >> >> >> >> > Chuanhua has strictly limited the maximum stack usage =
to several
> >> > >> >> >> >> > unsigned long,
> >> > >> >> >> >>
> >> > >> >> >> >> 512 / 8 =3D 64 bytes.
> >> > >> >> >> >>
> >> > >> >> >> >> So, not trivial.
> >> > >> >> >> >>
> >> > >> >> >> >> > so this should be safe. on the other hand, i believe t=
his
> >> > >> >> >> >> > implementation is more efficient, as  put_swap_folio()=
 might lock/
> >> > >> >> >> >> > unlock much more often whenever __swap_entry_free_lock=
ed returns
> >> > >> >> >> >> > 0.
> >> > >> >> >> >>
> >> > >> >> >> >> There are 2 most common use cases,
> >> > >> >> >> >>
> >> > >> >> >> >> - all swap entries have usage count =3D=3D 0
> >> > >> >> >> >> - all swap entries have usage count !=3D 0
> >> > >> >> >> >>
> >> > >> >> >> >> In both cases, we only need to lock/unlock once.  In fac=
t, I didn't
> >> > >> >> >> >> find possible use cases other than above.
> >> > >> >> >> >
> >> > >> >> >> > i guess the point is free_swap_slot() shouldn't be called=
 within
> >> > >> >> >> > lock_cluster_or_swap_info? so when we are freeing nr_page=
s slots,
> >> > >> >> >> > we'll have to unlock and lock nr_pages times?  and this i=
s the most
> >> > >> >> >> > common scenario.
> >> > >> >> >>
> >> > >> >> >> No.  In put_swap_folio(), free_entries is either SWAPFILE_C=
LUSTER (that
> >> > >> >> >> is, nr_pages) or 0.  These are the most common cases.
> >> > >> >> >>
> >> > >> >> >
> >> > >> >> > i am actually talking about the below code path,
> >> > >> >> >
> >> > >> >> > void put_swap_folio(struct folio *folio, swp_entry_t entry)
> >> > >> >> > {
> >> > >> >> >         ...
> >> > >> >> >
> >> > >> >> >         ci =3D lock_cluster_or_swap_info(si, offset);
> >> > >> >> >         ...
> >> > >> >> >         for (i =3D 0; i < size; i++, entry.val++) {
> >> > >> >> >                 if (!__swap_entry_free_locked(si, offset + i=
, SWAP_HAS_CACHE)) {
> >> > >> >> >                         unlock_cluster_or_swap_info(si, ci);
> >> > >> >> >                         free_swap_slot(entry);
> >> > >> >> >                         if (i =3D=3D size - 1)
> >> > >> >> >                                 return;
> >> > >> >> >                         lock_cluster_or_swap_info(si, offset=
);
> >> > >> >> >                 }
> >> > >> >> >         }
> >> > >> >> >         unlock_cluster_or_swap_info(si, ci);
> >> > >> >> > }
> >> > >> >> >
> >> > >> >> > but i guess you are talking about the below code path:
> >> > >> >> >
> >> > >> >> > void put_swap_folio(struct folio *folio, swp_entry_t entry)
> >> > >> >> > {
> >> > >> >> >         ...
> >> > >> >> >
> >> > >> >> >         ci =3D lock_cluster_or_swap_info(si, offset);
> >> > >> >> >         if (size =3D=3D SWAPFILE_CLUSTER) {
> >> > >> >> >                 map =3D si->swap_map + offset;
> >> > >> >> >                 for (i =3D 0; i < SWAPFILE_CLUSTER; i++) {
> >> > >> >> >                         val =3D map[i];
> >> > >> >> >                         VM_BUG_ON(!(val & SWAP_HAS_CACHE));
> >> > >> >> >                         if (val =3D=3D SWAP_HAS_CACHE)
> >> > >> >> >                                 free_entries++;
> >> > >> >> >                 }
> >> > >> >> >                 if (free_entries =3D=3D SWAPFILE_CLUSTER) {
> >> > >> >> >                         unlock_cluster_or_swap_info(si, ci);
> >> > >> >> >                         spin_lock(&si->lock);
> >> > >> >> >                         mem_cgroup_uncharge_swap(entry, SWAP=
FILE_CLUSTER);
> >> > >> >> >                         swap_free_cluster(si, idx);
> >> > >> >> >                         spin_unlock(&si->lock);
> >> > >> >> >                         return;
> >> > >> >> >                 }
> >> > >> >> >         }
> >> > >> >> > }
> >> > >> >>
> >> > >> >> I am talking about both code paths.  In 2 most common cases,
> >> > >> >> __swap_entry_free_locked() will return 0 or !0 for all entries=
 in range.
> >> > >> >
> >> > >> > I grasp your point, but if conditions involving 0 or non-0 valu=
es fail, we'll
> >> > >> > end up repeatedly unlocking and locking. Picture a scenario wit=
h a large
> >> > >> > folio shared by multiple processes. One process might unmap a p=
ortion
> >> > >> > while another still holds an entire mapping to it. This could l=
ead to situations
> >> > >> > where free_entries doesn't equal 0 and free_entries doesn't equ=
al
> >> > >> > nr_pages, resulting in multiple unlock and lock operations.
> >> > >>
> >> > >> This is impossible in current caller, because the folio is in the=
 swap
> >> > >> cache.  But if we move the change to __swap_entry_free_nr(), we m=
ay run
> >> > >> into this situation.
> >> > >
> >> > > I don't understand why it is impossible, after try_to_unmap_one() =
has done
> >> > > on one process, mprotect and munmap called on a part of the large =
folio
> >> > > pte entries which now have been swap entries, we are removing the =
PTE
> >> > > for this part. Another process can entirely hit the swapcache and =
have
> >> > > all swap entries mapped there, and we call swap_free_nr(entry, nr_=
pages) in
> >> > > do_swap_page. Within those swap entries, some have swapcount=3D1 a=
nd others
> >> > > have swapcount > 1. Am I missing something?
> >> >
> >> > For swap entries with swapcount=3D1, its sis->swap_map[] will be
> >> >
> >> > 1 | SWAP_HAS_CACHE
> >> >
> >> > so, __swap_entry_free_locked() will return SWAP_HAS_CACHE instead of=
 0.
> >> >
> >> > The swap entries will be free in
> >> >
> >> > folio_free_swap
> >> >   delete_from_swap_cache
> >> >     put_swap_folio
> >> >
> >>
> >> Yes. I realized this after replying to you yesterday.
> >>
> >> > >> > Chuanhua has invested significant effort in following Ryan's su=
ggestion
> >> > >> > for the current approach, which generally handles all cases, es=
pecially
> >> > >> > partial unmapping. Additionally, the widespread use of swap_fre=
e_nr()
> >> > >> > as you suggested across various scenarios is noteworthy.
> >> > >> >
> >> > >> > Unless there's evidence indicating performance issues or bugs, =
I believe
> >> > >> > the current approach remains preferable.
> >> > >>
> >> > >> TBH, I don't like the large stack space usage (64 bytes).  How ab=
out use
> >> > >> a "unsigned long" as bitmap?  Then, we use much less stack space,=
 use
> >> > >> bitmap =3D=3D 0 and bitmap =3D=3D (unsigned long)(-1) to check th=
e most common
> >> > >> use cases.  And, we have enough batching.
> >> > >
> >> > > that is quite a straightforward modification like,
> >> > >
> >> > > - #define SWAP_BATCH_NR (SWAPFILE_CLUSTER > 512 ? 512 : SWAPFILE_C=
LUSTER)
> >> > > + #define SWAP_BATCH_NR (SWAPFILE_CLUSTER > 64 ? 64 : SWAPFILE_CLU=
STER)
> >> > >
> >> > > there is no necessity to remove the bitmap API and move to raw
> >> > > unsigned long operations.
> >> > > as bitmap is exactly some unsigned long. on 64bit CPU, we are now =
one
> >> > > unsigned long,
> >> > > on 32bit CPU, it is now two unsigned long.
> >> >
> >> > Yes.  We can still use most bitmap APIs if we use "unsigned long" as
> >> > bitmap.  The advantage of "unsigned long" is to guarantee that
> >> > bitmap_empty() and bitmap_full() is trivial.  We can use that for
> >> > optimization.  For example, we can skip unlock/lock if bitmap_empty(=
).
> >>
> >> anyway we have avoided lock_cluster_or_swap_info and unlock_cluster_or=
_swap_info
> >> for each individual swap entry.
> >>
> >> if bitma_empty(), we won't call free_swap_slot() so no chance to
> >> further take any lock,
> >> right?
> >>
> >> the optimization of bitmap_full() seems to be more useful only after w=
e have
> >> void free_swap_slot(swp_entry_t entry, int nr)
> >>
> >> in which we can avoid many spin_lock_irq(&cache->free_lock);
> >>
> >> On the other hand, it seems we can directly call
> >> swapcache_free_entries() to skip cache if
> >> nr_pages >=3D SWAP_BATCH(64) this might be an optimization as we are n=
ow
> >> having a bitmap exactly equals 64.
> >
> > Hi ying,
> > considering the below code which has changed bitmap to 64 and generally=
 support
> > different nr_pages(1 and ever cross cluster),
> >
> > #define SWAP_BATCH_NR (SWAPFILE_CLUSTER > 64 ? 64 : SWAPFILE_CLUSTER)
> >
> > void swap_free_nr(swp_entry_t entry, int nr_pages)
> > {
> >         int i =3D 0, j;
> >         struct swap_cluster_info *ci;
> >         struct swap_info_struct *p;
> >         unsigned int type =3D swp_type(entry);
> >         unsigned long offset =3D swp_offset(entry);
> >         int batch_nr, remain_nr;
> >         DECLARE_BITMAP(usage, SWAP_BATCH_NR) =3D { 0 };
> >
> >         remain_nr =3D nr_pages;
> >         p =3D _swap_info_get(entry);
> >         if (!p)
> >                 return;
> >
> >         for ( ; ; ) {
> >                 batch_nr =3D min3(SWAP_BATCH_NR, remain_nr,
> >                                 (int)(SWAPFILE_CLUSTER - (offset %
> > SWAPFILE_CLUSTER)));
> >
> >                 ci =3D lock_cluster_or_swap_info(p, offset);
> >                 for (j =3D 0; j < batch_nr; j++) {
> >                         if (__swap_entry_free_locked(p, offset + i *
> > SWAP_BATCH_NR + j, 1))
> >                                 __bitmap_set(usage, j, 1);
> >                 }
> >                 unlock_cluster_or_swap_info(p, ci);
> >
> >                 for_each_clear_bit(j, usage, batch_nr)
> >                         free_swap_slot(swp_entry(type, offset + i *
> > SWAP_BATCH_NR + j));
> >
> >                 i +=3D batch_nr;
> >                 if (i >=3D nr_pages)
> >                         break;
> >
> >                 bitmap_clear(usage, 0, SWAP_BATCH_NR);
> >                 remain_nr -=3D batch_nr;
> >         }
> > }
> >
> > I still don't see the benefits of using bitmap_full and bitmap_empty ov=
er simple
> > for_each_clear_bit() unless we begin to support free_swap_slot_nr(), wh=
ich,
> > I believe, needs a separate incremental patchset.
> >
> > using bitmap_empty and full, if we want to free all slots, we need
> > if (bitmap_empty(usage))
> > {
> >     for (i=3D0;i<batch_nr;i++)
> >               free_swap_slot(swp_entry(type, offset + i * SWAP_BATCH_NR=
 + j));
> > }
> > This seems just a game replacing for_each_clear_bit by
> > bitmap_empty()+another for loop.
> >
> > if we don't want to free any one, we need
> > if(bitmap_full(usage)
> >        do_nothing.
> >
> > in the for_each_clear_bit() case, the loop just simply ends.
> >
> > What's your proposal code to use bitmap_empty and bitmap_full here?
> > Am I missing something?
>
> My idea is something as below.  It's only build tested.
>
> static void cluster_swap_free_nr(struct swap_info_struct *sis,
>                                  unsigned long offset, int nr_pages)
> {
>         struct swap_cluster_info *ci;
>         DECLARE_BITMAP(to_free, BITS_PER_LONG) =3D { 0 };
>         int i, nr;
>
>         ci =3D lock_cluster_or_swap_info(sis, offset);
>         while (nr_pages) {
>                 nr =3D min(BITS_PER_LONG, nr_pages);
>                 for (i =3D 0; i < nr; i++) {
>                         if (!__swap_entry_free_locked(sis, offset + i, 1)=
)
>                                 bitmap_set(to_free, i, 1);
>                 }
>                 if (!bitmap_empty(to_free, BITS_PER_LONG)) {
>                         unlock_cluster_or_swap_info(sis, ci);
>                         for_each_set_bit(i, to_free, BITS_PER_LONG)
>                                 free_swap_slot(swp_entry(sis->type, offse=
t + i));
>                         if (nr =3D=3D nr_pages)
>                                 return;
>                         bitmap_clear(to_free, 0, BITS_PER_LONG);
>                         ci =3D lock_cluster_or_swap_info(sis, offset);
>                 }
>                 offset +=3D nr;
>                 nr_pages -=3D nr;
>         }
>         unlock_cluster_or_swap_info(sis, ci);
> }
>
> void swap_free_nr(swp_entry_t entry, int nr_pages)
> {
>         int nr;
>         struct swap_info_struct *sis;
>         unsigned long offset =3D swp_offset(entry);
>
>         sis =3D _swap_info_get(entry);
>         if (!sis)
>                 return;
>
>         while (nr_pages >=3D 0) {
>                 nr =3D min_t(int, nr_pages, SWAPFILE_CLUSTER - offset % S=
WAPFILE_CLUSTER);
>                 cluster_swap_free_nr(sis, offset, nr);
>                 offset +=3D nr;
>                 nr_pages -=3D nr;
>         }
> }

Thanks!
It seems quite promising. I guess your intention is appreciating the
advantage of
small_const_nbits().
Conversely, you've created a distinct function for entries within a cluster=
.

I also agree with your change to:
if (!__swap_entry_free_locked(sis, offset + i, 1))

This adjustment ensures that for_each_set_bit() can also benefit from
small_const_nbits.
The original code didn't pass a compile-time const to for_each_clear_bit.

>
> --
> Best Regards,
> Huang, Ying

Thanks
Barry

