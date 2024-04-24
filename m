Return-Path: <linux-kernel+bounces-156060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 959CB8AFD64
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B40283201
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 00:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2554C9A;
	Wed, 24 Apr 2024 00:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="OPbkrgIL"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA524A23
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 00:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713919018; cv=none; b=O+N1pzDOyEav8nq1kdMZMfFm/JqkWL35kvs9h/rXnOE+I8kn/9QjYzX7jTmbNIZjqpxLsvjvjW54lRYLEwGJw+yq7sSMw+mJGatw+2ktlAyrk6U9e/PA6WI1UViElaQOGYWjWxgSJXNptXbepUWudsS7dTuo516OQN1q4z/kcmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713919018; c=relaxed/simple;
	bh=JZKE0VLIuYHlWWsduY7XRGc91HJo3QjGeCNbto3ZtH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ec76+S4rCbeBd4nGl9XfL3BS158jpYRiJLe9Yf9wcGCsdnUXOAJ5wJkf4YfyEAwR4Y+EnPgFncXIfo9eNtOL5m27OZ7D6vBvoY0M/5vwHPNcVnR4r6sh0h3iXZrHvDhOF8ISkLdDzvCbincHpvsOdOQwbroZkldSQgkqZDHenhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=OPbkrgIL; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d895e2c6efso94754601fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 17:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713919014; x=1714523814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjMend16t+yctgEkyNx77THL6Gw8VehuufV8DrVcY+I=;
        b=OPbkrgIL17DGGJerG6GbyJrE7BXrNIlPEjlJbUUDdm4EEcuQJl3niy/yMmDY3e9yeg
         fpouzS6bTj0b6XPLA5MvAabovS2QgwvWrOo/NtYbUajI98LhUViGyirj8ktpioMY6V2Z
         W5PlSsgZUpUVr2b/t9FRdmdJPhYqG0r/b9x6WTp+cqhWV3AxOt6VOyOWDj049+8IQWfN
         xDXFFQaxl/NZfkHfu2Nw3+CI0hf833Kk+bu7owQTQw6bo0UcIL7vzPHipR8b2C50Zz30
         1AMnYBhEUiCqFapu72cBGtxTsFOzw3vP17SiiupJpc8McGhdOSWeNokKWgiMnoTzYLIj
         ysRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713919014; x=1714523814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NjMend16t+yctgEkyNx77THL6Gw8VehuufV8DrVcY+I=;
        b=l5yxwWwEjDyIfNJkLpH6nQNH4paWonZzEI8Wq0iBM9Y+TROaX+Ke/rGdujrv/1SMVV
         dEOM6gzLwbPRGi0aHxIjYxDZtqqchahCb1KoymXMfw25MmE+I6w2bwwbwvUu/M9c05QD
         z/ql1e8e3Z8OhSKvOkyngeczA1X9qhOpK8WOfaH3ToH0muEGvPWqneXaa0WtO7frX2qN
         SLwP2ZSf/QE5Sav1XA+F5DGg/rjG4NMgs/hgB0XaI0Txg6RAEJXOdQoDJDpJM/OVT6LB
         Dh00ClQtv1enpQCwZKlkZr6ggypmlE3ct09iK+vfbZ2yAwzzN+OpvjxEcJOKnHN4ilxE
         u5RQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVGISZUXVZx9nIDZsJDfqLrFtmQvvnpDZobrW44bmHSd5j6UOa3OK7o9kK5wn2SlrAYNe4be+SVT8wt4jVFhiXZCekgt0pS4FVffCS
X-Gm-Message-State: AOJu0YwfoD0gP2j7kJa3RPiB6e3qr5IPdGKRdMcz9Qz1EnjZfFk0bGJY
	sRquih/rWTK2ZMo9ZYOE2Y2adPMwOyaImpuxz8Zn+ZK6NwbNmV91hSxLV2iBSZ0yxDCVVxe+B0c
	wPQCUu7FuwzTs22gqa9ZhBddfOine5N761Fi5uA==
X-Google-Smtp-Source: AGHT+IGYydBzPnvIyLBOkgTVsPf/w4Hsbth1sBp4Ruk6c2NmegMDf+zQvL0zIBoepoYg0qD0P0cCnht/yPTJ+9yxokg=
X-Received: by 2002:a2e:9cc6:0:b0:2d8:930c:bbfa with SMTP id
 g6-20020a2e9cc6000000b002d8930cbbfamr434577ljj.5.1713919014429; Tue, 23 Apr
 2024 17:36:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103165438.633054-1-samuel.holland@sifive.com>
 <CAOnJCUJ4rC+Rrs6GV4t+=NWA=LtTZix5Nk1VzgP9CK-3+5-jAg@mail.gmail.com>
 <06e71142-e113-40ac-b2c2-b20893aa714f@sifive.com> <a4c4c9f2-9fe1-4c22-a99c-1667481ddd6b@rivosinc.com>
 <CAAhSdy1yoCMtR52X7tS6dB2x_ysgA8K4hSSXH044bbq2uFY7jQ@mail.gmail.com> <CAP-5=fX5JRYxZ26buLujSVP7roQTaWofqdiX1y1rAKQ70Yu+QQ@mail.gmail.com>
In-Reply-To: <CAP-5=fX5JRYxZ26buLujSVP7roQTaWofqdiX1y1rAKQ70Yu+QQ@mail.gmail.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Tue, 23 Apr 2024 17:36:43 -0700
Message-ID: <CAHBxVyGuxQLTnBUiK2w=9atqNXs0sWC9KcWjssgzhNnbp_Z-mg@mail.gmail.com>
Subject: Re: [PATCH] perf: RISC-V: Check standard event availability
To: Ian Rogers <irogers@google.com>
Cc: Anup Patel <anup@brainfault.org>, Samuel Holland <samuel.holland@sifive.com>, 
	Atish Patra <atishp@atishpatra.org>, Albert Ou <aou@eecs.berkeley.edu>, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 8:44=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Mon, Apr 15, 2024 at 9:07=E2=80=AFPM Anup Patel <anup@brainfault.org> =
wrote:
> >
> > On Tue, Apr 16, 2024 at 5:31=E2=80=AFAM Atish Patra <atishp@rivosinc.co=
m> wrote:
> > >
> > > On 4/10/24 18:40, Samuel Holland wrote:
> > > > Hi Atish,
> > > >
> > > > On 2024-03-18 2:44 PM, Atish Patra wrote:
> > > >> On Wed, Jan 3, 2024 at 8:54=E2=80=AFAM Samuel Holland <samuel.holl=
and@sifive.com> wrote:
> > > >>>
> > > >>> The RISC-V SBI PMU specification defines several standard hardwar=
e and
> > > >>> cache events. Currently, all of these events appear in the `perf =
list`
> > > >>> output, even if they are not actually implemented. Add logic to c=
heck
> > > >>> which events are supported by the hardware (i.e. can be mapped to=
 some
> > > >>> counter), so only usable events are reported to userspace.
> > > >>>
> > > >>
> > > >> Thanks for the patch.
> > > >> This adds tons of SBI calls at every boot for a use case which is =
at
> > > >> best confusing for a subset of users who actually wants to run per=
f.
> > > >
> > > > I should have been clearer in the patch description. This is not ju=
st a cosmetic
> > > > change; because perf sees these as valid events, it tries to use th=
em in
> > > > commands like `perf stat`. When the error from SBI_EXT_PMU_COUNTER_=
CFG_MATCH
> > > > causes the ->add() callback to fail, this prevents any other events=
 from being
> > > > scheduled on that same CPU (search can_add_hw in kernel/events/core=
c). That is
> > > > why the dTLB/iTLB miss counts are missing in the "before" example b=
elow.
> > > >
> > >
> > > Thanks for explaining the problem. I can reproduce it in qemu as well=
 if
> > > enough number of invalid events given on the command line and the
> > > workload is short enough.
> > >
> > > >> This probing can be done at runtime by invoking the
> > > >> pmu_sbi_check_event from pmu_sbi_event_map.
> > > >> We can update the event map after that so that it doesn't need to
> > > >> invoke pmu_sbi_check_event next time.
> > > >
> > > > I tried to implement this suggestion, but it did not work. The SBI =
interface
> > > > does not distinguish between "none of the counters can monitor the =
specified
> > > > event [because the event is unsupported]" and "none of the counters=
 can monitor
> > > > the specified event [because the counters are busy]". It is not suf=
ficient for
> > > > the kernel to verify that at least one counter is available before =
performing
> > > > the check, because certain events may only be usable on a subset of=
 counters
> > > > (per riscv,event-to-mhpmcounters), and the kernel does not know tha=
t mapping.
> > > >
> > >
> > > Yeah. My suggestion was to fix the perf list issue which is different
> > > than the issue reported now.
> > >
> > > > As a result, checking for event support is only reliable when none =
of the
> > > > counters are in use. So the check can be asynchronous/deferred to l=
ater in the
> > > > boot process, but I believe it still needs to be performed for all =
events before
> > > > userspace starts using the counters.
> > > >
> > >
> > > We should defer it a work queue for sure. We can also look at improvi=
ng
> > > SBI PMU extension to support bulk matching behavior as well.
> > >
> > > However, I think a better solution would be to just rely on the json
> > > file mappings instead of making SBI calls. We are going to have the
> > > event encoding and mappings in the json in the future.
> >
> > The problem with JSON based event encoding is how to deal in-case
> > we are running inside Guest/VM because Host could be anything.
> >
> > IMO, the JSON based approach is not suitable for SBI PMU. For now,
> > we either defer the work using the work queue or keep the approach
> > of this patch as-is.
> >
> > The good part about SBI PMU extension is that we do have a standard
> > set of events and we only need a way to discover supported standard
> > events with a minimum number of SBI calls. It is better to add a new
> > SBI PMU call to assist supported event discovery which will also
> > help us virtualize it.
> >
> > Regards,
> > Anup
>
> +Ian Rogers
>
> `perf list` will already filter some events depending on whether the
> PMU supports them, for example, legacy cache events. I think we can
> extend this to json events.
>

Yes. That's what I was thinking as well. However, that may be a
problem in virtualization
as Anup pointed out.

As per my understanding, cloud providers provide json files for VMs
based on the host
architecture and allow migration only between hosts with the same
family of cpu. In RISC-V, the mapfile.csv works based on 3 registers
indicating marchid, mimpid, and mvendorid. Thus, the json file has to
be tied with the host machine it is going to be run.

We will end up doing the same if we only rely on the json file to
filter events in the future. Please let me know if the assumption is
incorrect.

If we allow a SBI call route to discover which events are supported,
the guest can always support legacy events on any host even though it
doesn't have a json file.

+Andrew Jones :
Any thoughts ?

> Thanks,
> Ian
>
> > >
> > > I had added it only for platforms with counter delegation[1] but I th=
ink
> > > this can be generalized for platforms with SBI PMU as well.
> > >
> > > I had some hacks to specify the legacy event encodings but Ian rogers
> > > improved with a generic support by preferring sysfs/json event encodi=
ngs
> > > over fixed ones. I am yet to rebase and try Ian's series on top of th=
e
> > > counter delegation though. Thoughts ?
> > >
> > > [1]
> > > https://lore.kernel.org/lkml/20240217005738.3744121-1-atishp@rivosinc=
com/
> > > [2]
> > > https://lore.kernel.org/bpf/20240415063626.453987-2-irogers@google.co=
m/T/
> > >
> > >
> > > > Regards,
> > > > Samuel
> > > >
> > > >>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> > > >>> ---
> > > >>> Before this patch:
> > > >>> $ perf list hw
> > > >>>
> > > >>> List of pre-defined events (to be used in -e or -M):
> > > >>>
> > > >>>    branch-instructions OR branches                    [Hardware e=
vent]
> > > >>>    branch-misses                                      [Hardware e=
vent]
> > > >>>    bus-cycles                                         [Hardware e=
vent]
> > > >>>    cache-misses                                       [Hardware e=
vent]
> > > >>>    cache-references                                   [Hardware e=
vent]
> > > >>>    cpu-cycles OR cycles                               [Hardware e=
vent]
> > > >>>    instructions                                       [Hardware e=
vent]
> > > >>>    ref-cycles                                         [Hardware e=
vent]
> > > >>>    stalled-cycles-backend OR idle-cycles-backend      [Hardware e=
vent]
> > > >>>    stalled-cycles-frontend OR idle-cycles-frontend    [Hardware e=
vent]
> > > >>>
> > > >>> $ perf stat -ddd true
> > > >>>
> > > >>>   Performance counter stats for 'true':
> > > >>>
> > > >>>                4.36 msec task-clock                       #    0.=
744 CPUs utilized
> > > >>>                   1      context-switches                 #  229.=
325 /sec
> > > >>>                   0      cpu-migrations                   #    0.=
000 /sec
> > > >>>                  38      page-faults                      #    8.=
714 K/sec
> > > >>>           4,375,694      cycles                           #    1.=
003 GHz                         (60.64%)
> > > >>>             728,945      instructions                     #    0.=
17  insn per cycle
> > > >>>              79,199      branches                         #   18.=
162 M/sec
> > > >>>              17,709      branch-misses                    #   22.=
36% of all branches
> > > >>>             181,734      L1-dcache-loads                  #   41.=
676 M/sec
> > > >>>               5,547      L1-dcache-load-misses            #    3.=
05% of all L1-dcache accesses
> > > >>>       <not counted>      LLC-loads                               =
                                (0.00%)
> > > >>>       <not counted>      LLC-load-misses                         =
                                (0.00%)
> > > >>>       <not counted>      L1-icache-loads                         =
                                (0.00%)
> > > >>>       <not counted>      L1-icache-load-misses                   =
                                (0.00%)
> > > >>>       <not counted>      dTLB-loads                              =
                                (0.00%)
> > > >>>       <not counted>      dTLB-load-misses                        =
                                (0.00%)
> > > >>>       <not counted>      iTLB-loads                              =
                                (0.00%)
> > > >>>       <not counted>      iTLB-load-misses                        =
                                (0.00%)
> > > >>>       <not counted>      L1-dcache-prefetches                    =
                                (0.00%)
> > > >>>       <not counted>      L1-dcache-prefetch-misses               =
                                (0.00%)
> > > >>>
> > > >>>         0.005860375 seconds time elapsed
> > > >>>
> > > >>>         0.000000000 seconds user
> > > >>>         0.010383000 seconds sys
> > > >>>
> > > >>> After this patch:
> > > >>> $ perf list hw
> > > >>>
> > > >>> List of pre-defined events (to be used in -e or -M):
> > > >>>
> > > >>>    branch-instructions OR branches                    [Hardware e=
vent]
> > > >>>    branch-misses                                      [Hardware e=
vent]
> > > >>>    cache-misses                                       [Hardware e=
vent]
> > > >>>    cache-references                                   [Hardware e=
vent]
> > > >>>    cpu-cycles OR cycles                               [Hardware e=
vent]
> > > >>>    instructions                                       [Hardware e=
vent]
> > > >>>
> > > >>> $ perf stat -ddd true
> > > >>>
> > > >>>   Performance counter stats for 'true':
> > > >>>
> > > >>>                5.16 msec task-clock                       #    0.=
848 CPUs utilized
> > > >>>                   1      context-switches                 #  193.=
817 /sec
> > > >>>                   0      cpu-migrations                   #    0.=
000 /sec
> > > >>>                  37      page-faults                      #    7.=
171 K/sec
> > > >>>           5,183,625      cycles                           #    1.=
005 GHz
> > > >>>             961,696      instructions                     #    0.=
19  insn per cycle
> > > >>>              85,853      branches                         #   16.=
640 M/sec
> > > >>>              20,462      branch-misses                    #   23.=
83% of all branches
> > > >>>             243,545      L1-dcache-loads                  #   47.=
203 M/sec
> > > >>>               5,974      L1-dcache-load-misses            #    2.=
45% of all L1-dcache accesses
> > > >>>     <not supported>      LLC-loads
> > > >>>     <not supported>      LLC-load-misses
> > > >>>     <not supported>      L1-icache-loads
> > > >>>     <not supported>      L1-icache-load-misses
> > > >>>     <not supported>      dTLB-loads
> > > >>>              19,619      dTLB-load-misses
> > > >>>     <not supported>      iTLB-loads
> > > >>>               6,831      iTLB-load-misses
> > > >>>     <not supported>      L1-dcache-prefetches
> > > >>>     <not supported>      L1-dcache-prefetch-misses
> > > >>>
> > > >>>         0.006085625 seconds time elapsed
> > > >>>
> > > >>>         0.000000000 seconds user
> > > >>>         0.013022000 seconds sys
> > > >>>
> > > >>>
> > > >>>   drivers/perf/riscv_pmu_sbi.c | 37 +++++++++++++++++++++++++++++=
+++++--
> > > >>>   1 file changed, 35 insertions(+), 2 deletions(-)
> > > >>>
> > > >>> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pm=
u_sbi.c
> > > >>> index 16acd4dcdb96..b58a70ee8317 100644
> > > >>> --- a/drivers/perf/riscv_pmu_sbi.c
> > > >>> +++ b/drivers/perf/riscv_pmu_sbi.c
> > > >>> @@ -86,7 +86,7 @@ struct sbi_pmu_event_data {
> > > >>>          };
> > > >>>   };
> > > >>>
> > > >>> -static const struct sbi_pmu_event_data pmu_hw_event_map[] =3D {
> > > >>> +static struct sbi_pmu_event_data pmu_hw_event_map[] =3D {
> > > >>>          [PERF_COUNT_HW_CPU_CYCLES]              =3D {.hw_gen_eve=
nt =3D {
> > > >>>                                                          SBI_PMU_=
HW_CPU_CYCLES,
> > > >>>                                                          SBI_PMU_=
EVENT_TYPE_HW, 0}},
> > > >>> @@ -120,7 +120,7 @@ static const struct sbi_pmu_event_data pmu_hw=
_event_map[] =3D {
> > > >>>   };
> > > >>>
> > > >>>   #define C(x) PERF_COUNT_HW_CACHE_##x
> > > >>> -static const struct sbi_pmu_event_data pmu_cache_event_map[PERF_=
COUNT_HW_CACHE_MAX]
> > > >>> +static struct sbi_pmu_event_data pmu_cache_event_map[PERF_COUNT_=
HW_CACHE_MAX]
> > > >>>   [PERF_COUNT_HW_CACHE_OP_MAX]
> > > >>>   [PERF_COUNT_HW_CACHE_RESULT_MAX] =3D {
> > > >>>          [C(L1D)] =3D {
> > > >>> @@ -265,6 +265,36 @@ static const struct sbi_pmu_event_data pmu_c=
ache_event_map[PERF_COUNT_HW_CACHE_M
> > > >>>          },
> > > >>>   };
> > > >>>
> > > >>> +static void pmu_sbi_check_event(struct sbi_pmu_event_data *edata=
)
> > > >>> +{
> > > >>> +       struct sbiret ret;
> > > >>> +
> > > >>> +       ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MA=
TCH,
> > > >>> +                       0, cmask, 0, edata->event_idx, 0, 0);
> > > >>> +       if (!ret.error) {
> > > >>> +               sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
> > > >>> +                         ret.value, 0x1, SBI_PMU_STOP_FLAG_RESET=
, 0, 0, 0);
> > > >>> +       } else if (ret.error =3D=3D SBI_ERR_NOT_SUPPORTED) {
> > > >>> +               /* This event cannot be monitored by any counter =
*/
> > > >>> +               edata->event_idx =3D -EINVAL;
> > > >>> +       }
> > > >>> +}
> > > >>> +
> > > >>> +static void pmu_sbi_update_events(void)
> > > >>> +{
> > > >>> +       /* Ensure events are not already mapped to a counter */
> > > >>> +       sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
> > > >>> +                 0, cmask, SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
> > > >>> +
> > > >>> +       for (int i =3D 0; i < ARRAY_SIZE(pmu_hw_event_map); i++)
> > > >>> +               pmu_sbi_check_event(&pmu_hw_event_map[i]);
> > > >>> +
> > > >>> +       for (int i =3D 0; i < ARRAY_SIZE(pmu_cache_event_map); i+=
+)
> > > >>> +               for (int j =3D 0; j < ARRAY_SIZE(pmu_cache_event_=
map[i]); j++)
> > > >>> +                       for (int k =3D 0; k < ARRAY_SIZE(pmu_cach=
e_event_map[i][j]); k++)
> > > >>> +                               pmu_sbi_check_event(&pmu_cache_ev=
ent_map[i][j][k]);
> > > >>> +}
> > > >>> +
> > > >>>   static int pmu_sbi_ctr_get_width(int idx)
> > > >>>   {
> > > >>>          return pmu_ctr_list[idx].width;
> > > >>> @@ -1046,6 +1076,9 @@ static int pmu_sbi_device_probe(struct plat=
form_device *pdev)
> > > >>>          if (pmu_sbi_get_ctrinfo(num_counters, &cmask))
> > > >>>                  goto out_free;
> > > >>>
> > > >>> +       /* Check which standard events are available */
> > > >>> +       pmu_sbi_update_events();
> > > >>> +
> > > >>>          ret =3D pmu_sbi_setup_irqs(pmu, pdev);
> > > >>>          if (ret < 0) {
> > > >>>                  pr_info("Perf sampling/filtering is not supporte=
d as sscof extension is not available\n");
> > > >>> --
> > > >>> 2.42.0
> > > >
> > > >
> > > > _______________________________________________
> > > > linux-riscv mailing list
> > > > linux-riscv@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > >
> >

