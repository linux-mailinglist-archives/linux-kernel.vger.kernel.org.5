Return-Path: <linux-kernel+bounces-167509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D3B8BAA95
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 110521C21111
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B4114F9FC;
	Fri,  3 May 2024 10:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuKEKTPk"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07C114F9EC
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 10:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714731491; cv=none; b=m2QFm62re4ZY+tJIbIB0fuG+sOiV/u3hNdrgXzHo0x1Of61B6Z7PZ1WQkaNLgIP2gQfRQwbylEviyrr0WG6uqMSnUBbp19SwEIRxogDg/9OKsAYwO9PpXPK/byjbis9IpHZmCJOCCyCrOnmpDt53+bcEm0hez4VXq6a+t3M15NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714731491; c=relaxed/simple;
	bh=svGaVYnkZtNYyjK4rLIc3IdvrJp1R/uL4ljtioBpO/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KHqLjJ21AQSmGCsdq/tZReb9xHRlPCEZSdP+Z51P91lH59q7nE+TiXhAJwy0OCmhgduv/1+F9fmlinv51i/XYYcXeg+RD6lrj4EtJNLpuhhdqgsCulOH/9acwhlaBir15rfW7n2eLkEUdGk67iG0xnuDCJzFPqezru7lkxv2UAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GuKEKTPk; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7f3c944ff8eso781307241.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 03:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714731489; x=1715336289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOCxihFTZ93q9UGZxwfGJW39u3GtAUTg2XU6hUmy/Z4=;
        b=GuKEKTPk3YrFmNmVIY5umaBlgp1E2JUAoOfvrwLT7ctwofuzWNmSf61X4dksHINz1h
         Dub8ssrC1pRs/oL/9YOMbAS7hYnc5UoRDxFPFddRZ8jxulxXdBgtPzA6pWf6Wcu30OKH
         SWkTJBaiuIdXbz6nrdNBP5Te6WTZYv6D8ftuwdEHJyitk0stB9gkUJHWxL51bcH0vGvK
         VyDgp3Y82NAp5sJA3M2eGki3F8KNf9ThoxSaoSM5z1wY+CbdbAyy4gy97P7Mb7+f13qq
         7pdRHNpN8em0iBKWO32vXtejJkU6v0TIflAUn8iWNSGglmNh/qbIa74lCzYyYh2+rPS+
         BBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714731489; x=1715336289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOCxihFTZ93q9UGZxwfGJW39u3GtAUTg2XU6hUmy/Z4=;
        b=BWD7tKWuotP6rkJjSvNMJCrKuD0ifQsLTiVzT/TEGNtSg5Zt/y6MBmVQw5bY5xfr42
         N5FBcTSHlyfh5ARmI4JgZlLG+NdgMKVwpYZ6JJzdEcdzRKquCK9ad4h/QR4wDYjlPWaO
         M9lCiu71lp92Qg9usQpMdsONbVn5uA7qtCt+XBRpTCr7pCj5naV7YH3AmbLN7lQqRE6j
         nfUhR/GYD0rjLbMEERshBhR1k4cSPEFd89mx2o/LQCAJXjGzFbEpIlhAR262h9O9DdVo
         G4c6CSBd3E2kSxMoPiM7tmHa+cdD71Q1r83oZBKyNmV82euOoRDTnycMYGgQ2GyeuP1h
         VxtA==
X-Forwarded-Encrypted: i=1; AJvYcCWHdzt+tpAqEkNdslcwBToZda4hPLxfMZWzOSSePp1hYZIIXlBg6Ttvgci0sI+m6Sx5GSHVD2DGh1RjO2kjw/84oxGTHtk5dj8DJND9
X-Gm-Message-State: AOJu0YwiIC35FhRcnJHpiYXl3AMl0A4R6st6CCjQcTLXOtEEFFNuKtAY
	js6OjSn5hVv9Q2Q8czSZxVejpYmiis7+7q+9YLTNZtaKET5DHhiLmUMtKAc2jqkju+Z+GWnOlLQ
	DEkQn5Kic4Bx5E2vRGRcbnyD0kDE=
X-Google-Smtp-Source: AGHT+IEj9v66eFqgfUMLdRmx/EmJgZY6G+pUj3Rf1mrK3BlE9un23aRz/tmRV9V/khRjFWRTP0QEVqlsYwpitqyiROU=
X-Received: by 2002:a67:ce89:0:b0:47b:d7e7:a8a9 with SMTP id
 c9-20020a67ce89000000b0047bd7e7a8a9mr2511690vse.5.1714731488736; Fri, 03 May
 2024 03:18:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503020924.208431-1-21cnbao@gmail.com> <c055203a-4365-4f5e-8276-5c57634abe73@arm.com>
In-Reply-To: <c055203a-4365-4f5e-8276-5c57634abe73@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 3 May 2024 22:17:57 +1200
Message-ID: <CAGsJ_4zurpmR6bdOR+RtwZaV1CS49yiQ03+gQ4y2wVgnEQpoyw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/vmstat: sum up all possible CPUs instead of using vm_events_fold_cpu
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, david@redhat.com, v-songbaohua@oppo.com, 
	vbabka@suse.cz, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 5:16=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 03/05/2024 03:09, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > When unplugging a CPU, the current code merges its vm_events
> > with an online CPU. Because, during summation, it only considers
> > online CPUs, which is a crude workaround. By transitioning to
> > summing up all possible CPUs, we can eliminate the need for
> > vm_events_fold_cpu.
> >
> > Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  originally suggested by Ryan while he reviewed mTHP counters
> >  patchset[1]; I am also applying this suggestion to vm_events
> >
> >  -v2:
> >  also drop cpus_read_lock() as we don't care about cpu hotplug any more=
;
> >  -v1:
> >  https://lore.kernel.org/linux-mm/20240412123039.442743-1-21cnbao@gmail=
com/
> >
> >  [1] https://lore.kernel.org/linux-mm/ca73cbf1-8304-4790-a721-3c3a42f9d=
293@arm.com/
> >
> >  include/linux/vmstat.h |  5 -----
> >  mm/page_alloc.c        |  8 --------
> >  mm/vmstat.c            | 21 +--------------------
> >  3 files changed, 1 insertion(+), 33 deletions(-)
> >
> > diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> > index 735eae6e272c..f7eaeb8bfa47 100644
> > --- a/include/linux/vmstat.h
> > +++ b/include/linux/vmstat.h
> > @@ -83,8 +83,6 @@ static inline void count_vm_events(enum vm_event_item=
 item, long delta)
> >
> >  extern void all_vm_events(unsigned long *);
> >
> > -extern void vm_events_fold_cpu(int cpu);
> > -
> >  #else
> >
> >  /* Disable counters */
> > @@ -103,9 +101,6 @@ static inline void __count_vm_events(enum vm_event_=
item item, long delta)
> >  static inline void all_vm_events(unsigned long *ret)
> >  {
> >  }
> > -static inline void vm_events_fold_cpu(int cpu)
> > -{
> > -}
> >
> >  #endif /* CONFIG_VM_EVENT_COUNTERS */
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index cd584aace6bf..8b56d785d587 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -5826,14 +5826,6 @@ static int page_alloc_cpu_dead(unsigned int cpu)
> >       mlock_drain_remote(cpu);
> >       drain_pages(cpu);
> >
> > -     /*
> > -      * Spill the event counters of the dead processor
> > -      * into the current processors event counters.
> > -      * This artificially elevates the count of the current
> > -      * processor.
> > -      */
> > -     vm_events_fold_cpu(cpu);
> > -
> >       /*
> >        * Zero the differential counters of the dead processor
> >        * so that the vm statistics are consistent.
> > diff --git a/mm/vmstat.c b/mm/vmstat.c
> > index db79935e4a54..aaa32418652e 100644
> > --- a/mm/vmstat.c
> > +++ b/mm/vmstat.c
> > @@ -114,7 +114,7 @@ static void sum_vm_events(unsigned long *ret)
> >
> >       memset(ret, 0, NR_VM_EVENT_ITEMS * sizeof(unsigned long));
> >
> > -     for_each_online_cpu(cpu) {
> > +     for_each_possible_cpu(cpu) {
>
> One thought comes to mind (due to my lack of understanding exactly what
> "possible" means): Linux is compiled with a max number of cpus - NR_CPUS =
- 512
> for arm64's defconfig. Does all possible cpus include all 512? On an 8 CP=
U
> system that would be increasing the number of loops by 64 times.
>
> Or perhaps possible just means CPUs that have ever been online?

Hi Ryan,

On arm64, we get possible CPUs either from device tree or ACPI. they are bo=
th
much less than NR_CPUS.

/*
 * Enumerate the possible CPU set from the device tree or ACPI and build th=
e
 * cpu logical map array containing MPIDR values related to logical
 * cpus. Assumes that cpu_logical_map(0) has already been initialized.
 */
void __init smp_init_cpus(void)

for device tree case, it is,

/*
 * Enumerate the possible CPU set from the device tree and build the
 * cpu logical map array containing MPIDR values related to logical
 * cpus. Assumes that cpu_logical_map(0) has already been initialized.
 */
static void __init of_parse_and_init_cpus(void)
{
        struct device_node *dn;

        for_each_of_cpu_node(dn) {
                u64 hwid =3D of_get_cpu_hwid(dn, 0);

                if (hwid & ~MPIDR_HWID_BITMASK)
                        goto next;

                if (is_mpidr_duplicate(cpu_count, hwid)) {
                        pr_err("%pOF: duplicate cpu reg properties in the D=
T\n",
                                dn);
                        goto next;
                }

                /*
                 * The numbering scheme requires that the boot CPU
                 * must be assigned logical id 0. Record it so that
                 * the logical map built from DT is validated and can
                 * be used.
                 */
                if (hwid =3D=3D cpu_logical_map(0)) {
                        if (bootcpu_valid) {
                                pr_err("%pOF: duplicate boot cpu reg
property in DT\n",
                                        dn);
                                goto next;
                        }

                        bootcpu_valid =3D true;
                        early_map_cpu_to_node(0, of_node_to_nid(dn));

                        /*
                         * cpu_logical_map has already been
                         * initialized and the boot cpu doesn't need
                         * the enable-method so continue without
                         * incrementing cpu.
                         */
                        continue;
                }

                if (cpu_count >=3D NR_CPUS)
                        goto next;

                pr_debug("cpu logical map 0x%llx\n", hwid);
                set_cpu_logical_map(cpu_count, hwid);

                early_map_cpu_to_node(cpu_count, of_node_to_nid(dn));
next:
                cpu_count++;
        }
}

even for ARM32, we get that sometimes from scu_get_core_count(),
eg.
static void __init omap4_smp_init_cpus(void)
{
        unsigned int i =3D 0, ncores =3D 1, cpu_id;

        /* Use ARM cpuid check here, as SoC detection will not work so earl=
y */
        cpu_id =3D read_cpuid_id() & CPU_MASK;
        if (cpu_id =3D=3D CPU_CORTEX_A9) {
                /*
                 * Currently we can't call ioremap here because
                 * SoC detection won't work until after init_early.
                 */
                cfg.scu_base =3D  OMAP2_L4_IO_ADDRESS(scu_a9_get_base());
                BUG_ON(!cfg.scu_base);
                ncores =3D scu_get_core_count(cfg.scu_base);
        } else if (cpu_id =3D=3D CPU_CORTEX_A15) {
                ncores =3D OMAP5_CORE_COUNT;
        }

        /* sanity check */
        if (ncores > nr_cpu_ids) {
                pr_warn("SMP: %u cores greater than maximum (%u), clipping\=
n",
                        ncores, nr_cpu_ids);
                ncores =3D nr_cpu_ids;
        }

        for (i =3D 0; i < ncores; i++)
                set_cpu_possible(i, true);
}

Other architectures do exactly the same jobs.



>
> Either way, I guess it's not considered a performance bottleneck because,=
 from
> memory, the scheduler and many other places are iterating over all possib=
le cpus.
>
> >               struct vm_event_state *this =3D &per_cpu(vm_event_states,=
 cpu);
> >
> >               for (i =3D 0; i < NR_VM_EVENT_ITEMS; i++)
> > @@ -129,29 +129,10 @@ static void sum_vm_events(unsigned long *ret)
> >  */
> >  void all_vm_events(unsigned long *ret)
> >  {
> > -     cpus_read_lock();
> >       sum_vm_events(ret);
> > -     cpus_read_unlock();
> >  }
> >  EXPORT_SYMBOL_GPL(all_vm_events);
> >
> > -/*
> > - * Fold the foreign cpu events into our own.
> > - *
> > - * This is adding to the events on one processor
> > - * but keeps the global counts constant.
> > - */
> > -void vm_events_fold_cpu(int cpu)
> > -{
> > -     struct vm_event_state *fold_state =3D &per_cpu(vm_event_states, c=
pu);
> > -     int i;
> > -
> > -     for (i =3D 0; i < NR_VM_EVENT_ITEMS; i++) {
> > -             count_vm_events(i, fold_state->event[i]);
> > -             fold_state->event[i] =3D 0;
> > -     }
> > -}
> > -
> >  #endif /* CONFIG_VM_EVENT_COUNTERS */
> >
> >  /*
>

Thanks
Barry

