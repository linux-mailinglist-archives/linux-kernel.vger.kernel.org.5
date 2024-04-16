Return-Path: <linux-kernel+bounces-146487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB38E8A65E3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10974281AC0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA2784FD4;
	Tue, 16 Apr 2024 08:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtYBuNpD"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C5C210EC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713255420; cv=none; b=uAC3kNyY15cUTaS1j5drjcnVfceAMyxgiOjT4kNve69kHG6AV5djxIpsjOI54sLaXNod9BXK91IfqKf/Inv1bf5Ce9bSBvkVrbqQja+fJU1Wb0MvTOwpVqilRGtIDktui5aubr/BHPoYXvXgrf+FAVMfOOhkExRbT5yBQnAQsDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713255420; c=relaxed/simple;
	bh=mBuGKRw0nA0wK2uppvYP6jUoOvPECW880MLWYd2vq5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b7yQT+aEf22voJvjqCTAy+91ioegmkH94F2ZhFEfp7jHFpBDnr8ra5aAohmgJFttvh8YprQPItdr5JNKs2yWiFdHt88AdvdWf+ORU9K3DLhHgKKIibbF0xcR1I97U//F9OWRTIkaVWgnCtkW0rFDzLQV7+V04wcxiwkGPIdCLzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtYBuNpD; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7e7af556187so1230352241.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 01:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713255415; x=1713860215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVgAYjECE+nKVpMzUrAngo9/IB8/wgbbo5xP3b16YfE=;
        b=DtYBuNpDCt7BkR/cOonnaedM9jP/bgEhNGFm17tYYe3il09uRtqRZlFczMQSyeGKae
         YugQuIHfneKqAlZ0jJCjNt/Q9VeysTz8xmfD7bdDP46XgHA4uAmZeLGwQUoYqlGA9qYR
         i0t6VELB5M44Pm+y4MrBJciq207/yPMp6mk4FqIEnADHd412fd6IVwzg9BLI0yXLGGhT
         v5+S4Jrh0+xwTU+GnhV8RxP/NbazRP+e1NSjl6A4b5w9zjyGknUOXGqJjnbyEG010X3B
         +KgtULyexNIrCWDLgQnHiL+Cl7t9DQDbIVGuVfPSpR3KRr7smPpb+FZ/rAFSGyU8LN/g
         5A1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713255415; x=1713860215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVgAYjECE+nKVpMzUrAngo9/IB8/wgbbo5xP3b16YfE=;
        b=eaL6qTMJgtNB74kD8Ol8wIHO2VvTjOLXwA+34dCVKmFRDAw+oVJuQ5yGfRUXxqeG5m
         CuD2loJ2bRYz6kB/eXb4jJFtmLO3dwpwccxdJl9V2dwEntWxIzdzR+7cvkVfq1RDHlDv
         W+frgriAe7XXCEQ69qhXysq2ktXOpf7cWJM+YB0skPJafolLiDXQOva9v6zaTd83Fp2w
         4MZmHzExi08/0nZJ4IwbHgqpZyq7QF0EgZoUAjDZEvQJWe2zNel6RwRbn030N8Ji533u
         2YZ7jRxbQdeEcgBBdHjRt6aaA0QE3XEBQ7gSUKyY/TuyocUHX6bxRHORVfGApEmjaE5d
         zMWw==
X-Forwarded-Encrypted: i=1; AJvYcCXj30h1klhADHgW71p8iWNDW7ZUGoxV51vYpfTawjv4Qy7GmRXu3TmphCtPz06xGdCmu4Mor9RKzmjscuSVMDkWh8LiORSCNXwBIvkf
X-Gm-Message-State: AOJu0YzwrLlruMLliDr6mJnHM3KS7KbNRFhDxL7K8qP/o63Io0wSzW/J
	uwDIif5VxEX6vdOkeVMv+gQxqFexHQ+zHpjwtMIgJicJPXinSsyrHN9IkKFPINiaC1M7p4TaxP5
	ikLrQ64qpl13EsRLH8AeFd4NNqZHNs0/Rho8=
X-Google-Smtp-Source: AGHT+IG+N/0g9P/7k+8omx6yAgvdDPvAI9/mPVhuUnE6iDgf6GIuPBNBHKHgnFLjbKNIvQ2p12hHSgt//XVViHM3ATM=
X-Received: by 2002:a05:6102:41a9:b0:47b:6718:6c34 with SMTP id
 cd41-20020a05610241a900b0047b67186c34mr9914863vsb.23.1713255413730; Tue, 16
 Apr 2024 01:16:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412114858.407208-1-21cnbao@gmail.com> <20240412114858.407208-3-21cnbao@gmail.com>
 <fba4f0cb-6d18-4d7c-8b2e-3300be1c20e3@redhat.com>
In-Reply-To: <fba4f0cb-6d18-4d7c-8b2e-3300be1c20e3@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 16 Apr 2024 20:16:42 +1200
Message-ID: <CAGsJ_4zzk2VoR1eZ3NpxhfSF08uC_HGwNp7iQEYz6K1XxHB3Sg@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] mm: add per-order mTHP anon_swpout and
 anon_swpout_fallback counters
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, cerasuolodomenico@gmail.com, 
	chrisl@kernel.org, kasong@tencent.com, linux-kernel@vger.kernel.org, 
	peterx@redhat.com, ryan.roberts@arm.com, surenb@google.com, 
	v-songbaohua@oppo.com, willy@infradead.org, yosryahmed@google.com, 
	yuzhao@google.com, corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 8:14=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 12.04.24 13:48, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > This helps to display the fragmentation situation of the swapfile, know=
ing
> > the proportion of how much we haven't split large folios.  So far, we o=
nly
> > support non-split swapout for anon memory, with the possibility of
> > expanding to shmem in the future.  So, we add the "anon" prefix to the
> > counter names.
> >
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> > Cc: Chris Li <chrisl@kernel.org>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> > Cc: Kairui Song <kasong@tencent.com>
> > Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: Ryan Roberts <ryan.roberts@arm.com>
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: Yosry Ahmed <yosryahmed@google.com>
> > Cc: Yu Zhao <yuzhao@google.com>
> > ---
> >   include/linux/huge_mm.h | 2 ++
> >   mm/huge_memory.c        | 4 ++++
> >   mm/page_io.c            | 1 +
> >   mm/vmscan.c             | 3 +++
> >   4 files changed, 10 insertions(+)
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index d4fdb2641070..7cd07b83a3d0 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -268,6 +268,8 @@ enum mthp_stat_item {
> >       MTHP_STAT_ANON_FAULT_ALLOC,
> >       MTHP_STAT_ANON_FAULT_FALLBACK,
> >       MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
> > +     MTHP_STAT_ANON_SWPOUT,
> > +     MTHP_STAT_ANON_SWPOUT_FALLBACK,
> >       __MTHP_STAT_COUNT
> >   };
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index dfc38cc83a04..58f2c4745d80 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -555,11 +555,15 @@ static struct kobj_attribute _name##_attr =3D __A=
TTR_RO(_name)
> >   DEFINE_MTHP_STAT_ATTR(anon_fault_alloc, MTHP_STAT_ANON_FAULT_ALLOC);
> >   DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLB=
ACK);
> >   DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAUL=
T_FALLBACK_CHARGE);
> > +DEFINE_MTHP_STAT_ATTR(anon_swpout, MTHP_STAT_ANON_SWPOUT);
> > +DEFINE_MTHP_STAT_ATTR(anon_swpout_fallback, MTHP_STAT_ANON_SWPOUT_FALL=
BACK);
> >
> >   static struct attribute *stats_attrs[] =3D {
> >       &anon_fault_alloc_attr.attr,
> >       &anon_fault_fallback_attr.attr,
> >       &anon_fault_fallback_charge_attr.attr,
> > +     &anon_swpout_attr.attr,
> > +     &anon_swpout_fallback_attr.attr,
> >       NULL,
> >   };
> >
> > diff --git a/mm/page_io.c b/mm/page_io.c
> > index a9a7c236aecc..46c603dddf04 100644
> > --- a/mm/page_io.c
> > +++ b/mm/page_io.c
> > @@ -217,6 +217,7 @@ static inline void count_swpout_vm_event(struct fol=
io *folio)
> >               count_memcg_folio_events(folio, THP_SWPOUT, 1);
> >               count_vm_event(THP_SWPOUT);
> >       }
> > +     count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_SWPOUT);
> >   #endif
> >       count_vm_events(PSWPOUT, folio_nr_pages(folio));
> >   }
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index bca2d9981c95..49bd94423961 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -1231,6 +1231,8 @@ static unsigned int shrink_folio_list(struct list=
_head *folio_list,
> >                                               goto activate_locked;
> >                               }
> >                               if (!add_to_swap(folio)) {
> > +                                     int __maybe_unused order =3D foli=
o_order(folio);
> > +
> >                                       if (!folio_test_large(folio))
> >                                               goto activate_locked_spli=
t;
> >                                       /* Fallback to swap normal pages =
*/
> > @@ -1242,6 +1244,7 @@ static unsigned int shrink_folio_list(struct list=
_head *folio_list,
> >                                                       THP_SWPOUT_FALLBA=
CK, 1);
> >                                               count_vm_event(THP_SWPOUT=
_FALLBACK);
> >                                       }
> > +                                     count_mthp_stat(order, MTHP_STAT_=
ANON_SWPOUT_FALLBACK);
>
> Why the temporary variable for order?
>
> count_mthp_stat(folio_order(order),
>                  MTHP_STAT_ANON_SWPOUT_FALLBACK);
>
> ... but now I do wonder if we want to pass the folio to count_mthp_stat()=
 ?

because we have called split_folio_to_list() before counting. that is also
why Ryan is using if (nr_pages >=3D HPAGE_PMD_NR) but not pmd_mappable.


>
> Anyhow
>
> Acked-by: David Hildenbrand <david@redhat.com>

thanks!

>
> --
> Cheers,
>
> David / dhildenb
>
Barry

