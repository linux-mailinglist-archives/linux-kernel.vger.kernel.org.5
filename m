Return-Path: <linux-kernel+bounces-141674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D4D8A21DB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDE12B2375F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BA645C14;
	Thu, 11 Apr 2024 22:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxaZ2Nh3"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7722581
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 22:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712875224; cv=none; b=n/iYC+j//jAvjcZ58G5lH3wA8TbBPBFcFIhN72w9s9L8RPtMxQaOIxD3N4bHlgqVck6d9N2eFzKx/tMhfTtZ5zfNGq1/40po0MlPg+hjGMI3hNkUL8q9RvkAyc7afdaNyS7bz1H7uib+V2h3e0FnbAU9W7Dd/r24+hj23YKi8G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712875224; c=relaxed/simple;
	bh=0mzXVunsPI5azrRDdPMzpzxQut6Ped1P/OAFWU+qxy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pXzuz8skA8fosGFsbc97KlQKRga+QcVJqZ/rpwEnTgrkeWAPcMpH5HhtMETVrCOBKY0JGmI8FPx0gSCE+X7Jt1/ZTA18LbDNdrOQRttTX40/BOOy3f6UlQAzID9RNma6BWHhb0GY5x0vD+5izE13AnvmcTcG/EE/rBYfgeqWtMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxaZ2Nh3; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-479d6ab7585so161667137.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712875221; x=1713480021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7gD6KArFKxNHqKzeEt+LV7nGI39tXVKdn0tSPVL+0k=;
        b=LxaZ2Nh3KL1P8RMa3pSjJ0kVuoqOdNBfNT/QOrd9GXJS00RCcx2J/2LNZWuC7ll6z8
         qrL1HoNRiAHCzrkPuxwWrZM33zaNdmYlmm69Mnxj+cHiNuBr1ZovmnbRTB4BC9BgNbKG
         GmOUJQw8LY6hXeTENX2RFXqfJPof2GevtDRPLoS1rG0ei6CPZ8apbzGH1J5o5EOWf848
         rz5Uo3wbsYOdOSUDnat1pCiXKWgZhj7UtC2HHOiDxALQMlwXSLQSGpEyXQ8swRQqiky4
         0hCHQ/23MkNaFUlzbW1c1ZWrse106Gmt6UH8pZZOEbpnjMxe5oBqAQsflo0+tcyGmD1n
         MEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712875221; x=1713480021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R7gD6KArFKxNHqKzeEt+LV7nGI39tXVKdn0tSPVL+0k=;
        b=KOOBKWkde3ugVvPc+ovqXulhn5X1DSRccVGvbz7I0eaZOL9OLla98lE3Qpbgj9l1GS
         GHC3FjQ8X9xTE5IPiWWwqah8n5TxlHoHcxJmp8J2HjGNf3TxQ65fCxH9LcWKNUUUQ/xG
         6cUgazQy40SFxiUBkgSkqKUWFwfaOzYmv0iovFqEJUrS3+QcNobaSolCpF1dlLZ8gBkh
         HkvsLls3VdcJVdg3HyZnj9zxuPs2rSCu0fS288rK4NclWdL7aQaWkM0/vCRKhi+IVdY2
         RI+Ac94ylRYttRbbVHcXjwY0aI6uM6sqSet6jJ6YUfp9uwMuGgnIQhrE3qn+smEhU5HS
         Tiiw==
X-Forwarded-Encrypted: i=1; AJvYcCV7vQGOnFObW2Iv5dcZXjCDX5kCSY/OgtGnNHMEzEiZ8tCfUr7UkFZ1nSNXS+i0cgGysk0J7a1nY5/WxPowHvlhq/Nmp7p5hZC2ZeAu
X-Gm-Message-State: AOJu0YyUB7PSIA/0ZRz3WafgJB3jJuKMhX6p69dr42oB+g3SD6Z5bLl2
	1xU7oFEVBckRxFfoM5XI0eaRfVFXCUa+8aSXcxb9bC193TcL6F9A2Wd21SglK5dv5GLZDFbx33C
	WuFXc7EgeMtpF36c9I0LdU8qe/U0=
X-Google-Smtp-Source: AGHT+IHigMdEYAO2J3Z4fjjtOYRWKL2kMzsCcMD4dNVi2KoEaLkn4p4BgPJtGTyWcCoCSgqgzoDB9vXkIj9DVnqLPgM=
X-Received: by 2002:a05:6102:674:b0:47a:1517:a9ac with SMTP id
 z20-20020a056102067400b0047a1517a9acmr3397916vsf.16.1712875221434; Thu, 11
 Apr 2024 15:40:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405102704.77559-1-21cnbao@gmail.com> <20240405102704.77559-2-21cnbao@gmail.com>
 <7cf0a47b-0347-4e81-956f-34bef4ef794a@arm.com>
In-Reply-To: <7cf0a47b-0347-4e81-956f-34bef4ef794a@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 12 Apr 2024 10:40:10 +1200
Message-ID: <CAGsJ_4zWiYguj1y6Q7Ls41yFkuL5=-ii7pY=rYHg1AZeXe4uTQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm: add per-order mTHP anon_alloc and
 anon_alloc_fallback counters
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: david@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cerasuolodomenico@gmail.com, chrisl@kernel.org, kasong@tencent.com, 
	peterx@redhat.com, surenb@google.com, v-songbaohua@oppo.com, 
	willy@infradead.org, yosryahmed@google.com, yuzhao@google.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 4:38=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 05/04/2024 11:27, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > Profiling a system blindly with mTHP has become challenging due to the
> > lack of visibility into its operations. Presenting the success rate of
> > mTHP allocations appears to be pressing need.
> >
> > Recently, I've been experiencing significant difficulty debugging
> > performance improvements and regressions without these figures.
> > It's crucial for us to understand the true effectiveness of mTHP in
> > real-world scenarios, especially in systems with fragmented memory.
> >
> > This patch sets up the framework for per-order mTHP counters, starting
> > with the introduction of anon_alloc and anon_alloc_fallback counters.
> > Incorporating additional counters should now be straightforward as well=
.
> >
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  include/linux/huge_mm.h | 19 ++++++++++++++++
> >  mm/huge_memory.c        | 48 +++++++++++++++++++++++++++++++++++++++++
> >  mm/memory.c             |  2 ++
> >  3 files changed, 69 insertions(+)
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index e896ca4760f6..c5d33017a4dd 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -264,6 +264,25 @@ unsigned long thp_vma_allowable_orders(struct vm_a=
rea_struct *vma,
> >                                         enforce_sysfs, orders);
> >  }
> >
> > +enum mthp_stat_item {
> > +     MTHP_STAT_ANON_ALLOC,
> > +     MTHP_STAT_ANON_ALLOC_FALLBACK,
> > +     __MTHP_STAT_COUNT
> > +};
> > +
> > +struct mthp_stat {
> > +     unsigned long stats[PMD_ORDER + 1][__MTHP_STAT_COUNT];
>
> I saw a fix for this allocation dynamically due to powerpc PMD_ORDER not =
being
> constant. I wonder if ilog2(MAX_PTRS_PER_PTE) would help here?
>

It's a possibility. However, since we've passed all the build tests
using dynamic
allocation, it might not be worth the effort to attempt static
allocation again. Who
knows what will happen next :-)

> > +};
> > +
> > +DECLARE_PER_CPU(struct mthp_stat, mthp_stats);
> > +
> > +static inline void count_mthp_stat(int order, enum mthp_stat_item item=
)
>
> I thought we were going to call this always counting up type of stat and =
event?
> "count_mthp_event"? But I'm happy with it as is, personally.
>
> > +{
> > +     if (unlikely(order > PMD_ORDER))
> > +             return;
>
> I'm wondering if it also makes sense to ignore order =3D=3D 0? Although I=
 guess if
> called for order-0 its safe since the storage exists and sum_mthp_stat() =
is
> never be called for 0. Ignore this comment :)

Agreed. I'd like to change it to ignore oder 0;

>
> > +     this_cpu_inc(mthp_stats.stats[order][item]);
> > +}
> > +
> >  #define transparent_hugepage_use_zero_page()                         \
> >       (transparent_hugepage_flags &                                   \
> >        (1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG))
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 9d4b2fbf6872..5b875f0fc923 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -526,6 +526,46 @@ static const struct kobj_type thpsize_ktype =3D {
> >       .sysfs_ops =3D &kobj_sysfs_ops,
> >  };
> >
> > +DEFINE_PER_CPU(struct mthp_stat, mthp_stats) =3D {{{0}}};
> > +
> > +static unsigned long sum_mthp_stat(int order, enum mthp_stat_item item=
)
> > +{
> > +     unsigned long sum =3D 0;
> > +     int cpu;
> > +
> > +     for_each_online_cpu(cpu) {
>
> What happens if a cpu that was online and collected a bunch of stats gets
> offlined? The user will see stats get smaller?
>
> Perhaps this should be for_each_possible_cpu()? Although I'm not sure wha=
t
> happens to percpu data when a cpu goes offline? Is the data preserved? Or=
 wiped,
> or unmapped? dunno. Might we need to rescue stats into a global counter a=
t
> offline-time?

Good catch. I see /proc/vmstat is always using the  for_each_online_cpu() b=
ut it
doesn't have the issue, but mTHP counters do have the problem.

* step 1: cat  the current thp_swpout value before running a test
program which does
swpout;

/ # cat /proc/vmstat | grep thp_swpout
thp_swpout 0
/ # cat /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/stats/anon_swp=
out
0

* step 2: run the test program on cpu2;

/ # taskset -c 2 /home/barry/develop/linux/swpcache-2m

* step 3: cat the current thp_swpout value after running a test
program which does
swpout;

/ # cat /proc/vmstat | grep thp_swpout
thp_swpout 98
/ # cat /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/stats/anon_swp=
out
98

*step 4: offline cpu2 and read thp_swpout;

/ # echo 0 > /sys/devices/system/cpu/cpu2/online
[  339.058661] psci: CPU2 killed (polled 0 ms)

/ # cat /proc/vmstat | grep thp_swpout
thp_swpout 98
/ # cat /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/stats/anon_swp=
out
0

*step 5: online cpu2 and read thp_swpout

/ # echo 1 > /sys/devices/system/cpu/cpu2/online
[  791.642058] CPU2: Booted secondary processor 0x0000000002 [0x000f0510]

/ # cat /proc/vmstat | grep thp_swpout
thp_swpout 98
/ # cat /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/stats/anon_swp=
out
98



As you can see, in step 4, /proc/vmstat is all good but mTHP counters becom=
e
zero.

The reason is /proc/vmstat will fold the offline cpu to an online cpu
but mthp counters lack
it:

/*
 * Fold the foreign cpu events into our own.
 *
 * This is adding to the events on one processor
 * but keeps the global counts constant.
 */
void vm_events_fold_cpu(int cpu)
{
        struct vm_event_state *fold_state =3D &per_cpu(vm_event_states, cpu=
);
        int i;

        for (i =3D 0; i < NR_VM_EVENT_ITEMS; i++) {
                count_vm_events(i, fold_state->event[i]);
                fold_state->event[i] =3D 0;
        }
}

static int page_alloc_cpu_dead(unsigned int cpu)
{
        ...
        /*
         * Spill the event counters of the dead processor
         * into the current processors event counters.
         * This artificially elevates the count of the current
         * processor.
         */
        vm_events_fold_cpu(cpu);
        ...

        return 0;
}

So I will do the same thing for mTHP counters - fold offline cpu
counters to online one.

>
> > +             struct mthp_stat *this =3D &per_cpu(mthp_stats, cpu);
> > +
> > +             sum +=3D this->stats[order][item];
> > +     }
> > +
> > +     return sum;
> > +}
> > +
> > +#define DEFINE_MTHP_STAT_ATTR(_name, _index)                          =
       \
> > +static ssize_t _name##_show(struct kobject *kobj,                    \
> > +                     struct kobj_attribute *attr, char *buf)         \
> > +{                                                                    \
> > +     int order =3D to_thpsize(kobj)->order;                           =
 \
> > +                                                                     \
> > +     return sysfs_emit(buf, "%lu\n", sum_mthp_stat(order, _index));  \
> > +}                                                                    \
> > +static struct kobj_attribute _name##_attr =3D __ATTR_RO(_name)
>
> Very nice!

Right. I got duplicated copy-paste and bad small in code so I wrote this ma=
cro.

>
> > +
> > +DEFINE_MTHP_STAT_ATTR(anon_alloc, MTHP_STAT_ANON_ALLOC);
> > +DEFINE_MTHP_STAT_ATTR(anon_alloc_fallback, MTHP_STAT_ANON_ALLOC_FALLBA=
CK);
> > +
> > +static struct attribute *stats_attrs[] =3D {
> > +     &anon_alloc_attr.attr,
> > +     &anon_alloc_fallback_attr.attr,
> > +     NULL,
> > +};
> > +
> > +static struct attribute_group stats_attr_group =3D {
> > +     .name =3D "stats",
> > +     .attrs =3D stats_attrs,
> > +};
> > +
> >  static struct thpsize *thpsize_create(int order, struct kobject *paren=
t)
> >  {
> >       unsigned long size =3D (PAGE_SIZE << order) / SZ_1K;
> > @@ -549,6 +589,12 @@ static struct thpsize *thpsize_create(int order, s=
truct kobject *parent)
> >               return ERR_PTR(ret);
> >       }
> >
> > +     ret =3D sysfs_create_group(&thpsize->kobj, &stats_attr_group);
> > +     if (ret) {
> > +             kobject_put(&thpsize->kobj);
> > +             return ERR_PTR(ret);
> > +     }
> > +
> >       thpsize->order =3D order;
> >       return thpsize;
> >  }
> > @@ -1050,8 +1096,10 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_=
fault *vmf)
> >       folio =3D vma_alloc_folio(gfp, HPAGE_PMD_ORDER, vma, haddr, true)=
;
> >       if (unlikely(!folio)) {
> >               count_vm_event(THP_FAULT_FALLBACK);
> > +             count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_ALLOC_FAL=
LBACK);
>
> I think we should aim for the PMD-oder MTHP_STAT_ANON_ALLOC and
> MTHP_STAT_ANON_ALLOC_FALLBACK to match THP_FAULT_ALLOC and THP_FAULT_FALL=
BACK.
> Its not currently setup this way...

right. I also realized this and asked for your comments on this in another
thread.

>
>
> >               return VM_FAULT_FALLBACK;
> >       }
> > +     count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_ALLOC);
> >       return __do_huge_pmd_anonymous_page(vmf, &folio->page, gfp);
> >  }
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 649e3ed94487..1723c8ddf9cb 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4374,8 +4374,10 @@ static struct folio *alloc_anon_folio(struct vm_=
fault *vmf)
> >                       }
> >                       folio_throttle_swaprate(folio, gfp);
> >                       clear_huge_page(&folio->page, vmf->address, 1 << =
order);
> > +                     count_mthp_stat(order, MTHP_STAT_ANON_ALLOC);
> >                       return folio;
> >               }
> > +             count_mthp_stat(order, MTHP_STAT_ANON_ALLOC_FALLBACK);
>
> ...And we should follow the usage same pattern for the smaller mTHP here =
too.
> Which means MTHP_STAT_ANON_ALLOC_FALLBACK should be after the next: label=
 We

The only difference is the case

if (mem_cgroup_charge(folio, vma->vm_mm, gfp))
      goto next;

but vmstat is counting this as fallback so i feel good to move after next,

        if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
                folio_put(folio);
                count_vm_event(THP_FAULT_FALLBACK);
                count_vm_event(THP_FAULT_FALLBACK_CHARGE);
                return VM_FAULT_FALLBACK;
        }

> could introduce a MTHP_STAT_ANON_ALLOC_FALLBACK_CHARGE which would only t=
rigger
> on a fallback due to charge failure, just like THP_FAULT_FALLBACK_CHARGE?

it is fine to add this THP_FAULT_FALLBACK_CHARGE though it is not that
useful for profiling buddy fragmentation.

>
> >  next:
> >               order =3D next_order(&orders, order);
> >       }
>

Thanks
Barry

