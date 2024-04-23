Return-Path: <linux-kernel+bounces-154469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A3C8ADC60
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1DA61F21B62
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0BF1C687;
	Tue, 23 Apr 2024 03:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OBZhF7Up"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B5618E1D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 03:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713843893; cv=none; b=jK8Mr8Puh1uBJL9NCa0C68JJj3n7H8xow8UAsN7s/haRnMtentfApn/CVBrm4Xb9eDUKb3vDK2Bxnw28vEl1zggmUbidhgxd+2qNlrgNb+M8N10N8C6YfBY3jzI+Ar8Inwhgy1H1KyDmLrgkA9XoH/yWPWs214RCnpnOl6MRtDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713843893; c=relaxed/simple;
	bh=Ilct6yVB8390vNnlX2J+xw65EcqkTRnZxwsdd6zmqhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V1Gj8+j2aW21GyeGZLUttXOh1e7+QmbX/k/oRf2IuHOvoeK5jPlKvS+OavJ20DzfMk0pEJKpOM62kQAEfxF47vUhwK05zAop5r9n4vJc+MOgHPoGbE8+mcns0eFB5lQpoku0RfLPdt/mZkvd3HHC02LiCsCMHslnd9DjeJQe6IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OBZhF7Up; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-43989e6ca42so189671cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 20:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713843890; x=1714448690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vt4JG8qCeL1iP0aOwkW0C+7/hL6q3fArHCZyUFLbwpQ=;
        b=OBZhF7UpSWeJUr6t3G46xdI4cKdjhlKAh0ib4rHk38I986d66bNiAkwMiHtLmP/5je
         jfSoFI2iH3+ltTyIm5Ev8GgPs/3rp3tp+0FKyj24uCAXeOyLa1RmKhRwO2o7I/53m35R
         7v7BaaQqlMgypclx8jeUnDJFeG/c+h+DxiiIH9+Y3SCSB1E6pMJVQQiMQVfppRyfDadG
         flg2TCkk0fGyYYazZJw+803+LVwIJmjpD0K6Dmz/JOryHxX2HE4c9CTWQ1dnrelj+MtR
         i8DhgnYB8HWf3IH/bqYknCo167AKD1Re8qYUjYGq90bdkCguRMsZJfMX3XGSUk0iT9Ho
         vqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713843890; x=1714448690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vt4JG8qCeL1iP0aOwkW0C+7/hL6q3fArHCZyUFLbwpQ=;
        b=OIaZB86CBmZoGWjViODuzOCwft6Ez9GMoVJ8LlpyAx+CkdM5k3Kz04qMsH3cZ9PlcL
         ggiANiFZsJikIGHqhS0HcBPjbg4KYfxaBcLkIt48/tWdZIrkaDt2IED0Zt2iHYxI13Eb
         lpfFXHcAdV8KFF4lrMEmKxFXkOBRNv8faoNSKaa5PLc5lU2Lajoywm/uBF3pUOLQq2bO
         Sb6bP/8TOsSYZw0BmlgbYLdB3WvGgkGsRV8Yj5GfWxdGr3voN4cEKZSsqn/WSAgZOh9M
         G5tSwKEjqnJtKDCt//5LcPEmleP+O+ev5UqpQ7nhfVClpIsfjHXk3KrBixrpSYapVlPr
         I4SQ==
X-Forwarded-Encrypted: i=1; AJvYcCV78G+zd1WqD+I7UuFFtuQxPbK2u0cYwCS8kaTDhCuqSBTnuL8rzs2T3oBoWdge3C2b7q8MFWj8GfsMUTD91/2lQa6i/e1aE9DKrIf2
X-Gm-Message-State: AOJu0YwnY5z9r3uQ3PU/o4vID0B8A8FAwFU+Y3qTRJb0GjAeMmbeRONA
	enyfBpRVL2OrAG1+b7jw3E6i7FW5ZITuK0fgFmFUAw5jfJn6atAKnKXSU0MkcKiKN54BRzEO9hc
	1fOJKsTdzHeyb0CWi1+mB1w+LPdEthTtgZ/E8
X-Google-Smtp-Source: AGHT+IGSWRAJ9gjsG4eeTTY/nblTiq5QeqYiwnF+Rbt1tpJoAuOXcku4SJVgiWKD5APBHwtOSx7kjgf7WGjMj5DWhAU=
X-Received: by 2002:ac8:7748:0:b0:437:b572:6a with SMTP id g8-20020ac87748000000b00437b572006amr100951qtu.23.1713843890003;
 Mon, 22 Apr 2024 20:44:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103165438.633054-1-samuel.holland@sifive.com>
 <CAOnJCUJ4rC+Rrs6GV4t+=NWA=LtTZix5Nk1VzgP9CK-3+5-jAg@mail.gmail.com>
 <06e71142-e113-40ac-b2c2-b20893aa714f@sifive.com> <a4c4c9f2-9fe1-4c22-a99c-1667481ddd6b@rivosinc.com>
 <CAAhSdy1yoCMtR52X7tS6dB2x_ysgA8K4hSSXH044bbq2uFY7jQ@mail.gmail.com>
In-Reply-To: <CAAhSdy1yoCMtR52X7tS6dB2x_ysgA8K4hSSXH044bbq2uFY7jQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 22 Apr 2024 20:44:35 -0700
Message-ID: <CAP-5=fX5JRYxZ26buLujSVP7roQTaWofqdiX1y1rAKQ70Yu+QQ@mail.gmail.com>
Subject: Re: [PATCH] perf: RISC-V: Check standard event availability
To: Anup Patel <anup@brainfault.org>, Ian Rogers <irogers@google.com>
Cc: Atish Patra <atishp@rivosinc.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Atish Patra <atishp@atishpatra.org>, Albert Ou <aou@eecs.berkeley.edu>, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 9:07=E2=80=AFPM Anup Patel <anup@brainfault.org> wr=
ote:
>
> On Tue, Apr 16, 2024 at 5:31=E2=80=AFAM Atish Patra <atishp@rivosinc.com>=
 wrote:
> >
> > On 4/10/24 18:40, Samuel Holland wrote:
> > > Hi Atish,
> > >
> > > On 2024-03-18 2:44 PM, Atish Patra wrote:
> > >> On Wed, Jan 3, 2024 at 8:54=E2=80=AFAM Samuel Holland <samuel.hollan=
d@sifive.com> wrote:
> > >>>
> > >>> The RISC-V SBI PMU specification defines several standard hardware =
and
> > >>> cache events. Currently, all of these events appear in the `perf li=
st`
> > >>> output, even if they are not actually implemented. Add logic to che=
ck
> > >>> which events are supported by the hardware (i.e. can be mapped to s=
ome
> > >>> counter), so only usable events are reported to userspace.
> > >>>
> > >>
> > >> Thanks for the patch.
> > >> This adds tons of SBI calls at every boot for a use case which is at
> > >> best confusing for a subset of users who actually wants to run perf.
> > >
> > > I should have been clearer in the patch description. This is not just=
 a cosmetic
> > > change; because perf sees these as valid events, it tries to use them=
 in
> > > commands like `perf stat`. When the error from SBI_EXT_PMU_COUNTER_CF=
G_MATCH
> > > causes the ->add() callback to fail, this prevents any other events f=
rom being
> > > scheduled on that same CPU (search can_add_hw in kernel/events/core.c=
). That is
> > > why the dTLB/iTLB miss counts are missing in the "before" example bel=
ow.
> > >
> >
> > Thanks for explaining the problem. I can reproduce it in qemu as well i=
f
> > enough number of invalid events given on the command line and the
> > workload is short enough.
> >
> > >> This probing can be done at runtime by invoking the
> > >> pmu_sbi_check_event from pmu_sbi_event_map.
> > >> We can update the event map after that so that it doesn't need to
> > >> invoke pmu_sbi_check_event next time.
> > >
> > > I tried to implement this suggestion, but it did not work. The SBI in=
terface
> > > does not distinguish between "none of the counters can monitor the sp=
ecified
> > > event [because the event is unsupported]" and "none of the counters c=
an monitor
> > > the specified event [because the counters are busy]". It is not suffi=
cient for
> > > the kernel to verify that at least one counter is available before pe=
rforming
> > > the check, because certain events may only be usable on a subset of c=
ounters
> > > (per riscv,event-to-mhpmcounters), and the kernel does not know that =
mapping.
> > >
> >
> > Yeah. My suggestion was to fix the perf list issue which is different
> > than the issue reported now.
> >
> > > As a result, checking for event support is only reliable when none of=
 the
> > > counters are in use. So the check can be asynchronous/deferred to lat=
er in the
> > > boot process, but I believe it still needs to be performed for all ev=
ents before
> > > userspace starts using the counters.
> > >
> >
> > We should defer it a work queue for sure. We can also look at improving
> > SBI PMU extension to support bulk matching behavior as well.
> >
> > However, I think a better solution would be to just rely on the json
> > file mappings instead of making SBI calls. We are going to have the
> > event encoding and mappings in the json in the future.
>
> The problem with JSON based event encoding is how to deal in-case
> we are running inside Guest/VM because Host could be anything.
>
> IMO, the JSON based approach is not suitable for SBI PMU. For now,
> we either defer the work using the work queue or keep the approach
> of this patch as-is.
>
> The good part about SBI PMU extension is that we do have a standard
> set of events and we only need a way to discover supported standard
> events with a minimum number of SBI calls. It is better to add a new
> SBI PMU call to assist supported event discovery which will also
> help us virtualize it.
>
> Regards,
> Anup

+Ian Rogers

`perf list` will already filter some events depending on whether the
PMU supports them, for example, legacy cache events. I think we can
extend this to json events.

Thanks,
Ian

> >
> > I had added it only for platforms with counter delegation[1] but I thin=
k
> > this can be generalized for platforms with SBI PMU as well.
> >
> > I had some hacks to specify the legacy event encodings but Ian rogers
> > improved with a generic support by preferring sysfs/json event encoding=
s
> > over fixed ones. I am yet to rebase and try Ian's series on top of the
> > counter delegation though. Thoughts ?
> >
> > [1]
> > https://lore.kernel.org/lkml/20240217005738.3744121-1-atishp@rivosinc.c=
om/
> > [2]
> > https://lore.kernel.org/bpf/20240415063626.453987-2-irogers@google.com/=
T/
> >
> >
> > > Regards,
> > > Samuel
> > >
> > >>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> > >>> ---
> > >>> Before this patch:
> > >>> $ perf list hw
> > >>>
> > >>> List of pre-defined events (to be used in -e or -M):
> > >>>
> > >>>    branch-instructions OR branches                    [Hardware eve=
nt]
> > >>>    branch-misses                                      [Hardware eve=
nt]
> > >>>    bus-cycles                                         [Hardware eve=
nt]
> > >>>    cache-misses                                       [Hardware eve=
nt]
> > >>>    cache-references                                   [Hardware eve=
nt]
> > >>>    cpu-cycles OR cycles                               [Hardware eve=
nt]
> > >>>    instructions                                       [Hardware eve=
nt]
> > >>>    ref-cycles                                         [Hardware eve=
nt]
> > >>>    stalled-cycles-backend OR idle-cycles-backend      [Hardware eve=
nt]
> > >>>    stalled-cycles-frontend OR idle-cycles-frontend    [Hardware eve=
nt]
> > >>>
> > >>> $ perf stat -ddd true
> > >>>
> > >>>   Performance counter stats for 'true':
> > >>>
> > >>>                4.36 msec task-clock                       #    0.74=
4 CPUs utilized
> > >>>                   1      context-switches                 #  229.32=
5 /sec
> > >>>                   0      cpu-migrations                   #    0.00=
0 /sec
> > >>>                  38      page-faults                      #    8.71=
4 K/sec
> > >>>           4,375,694      cycles                           #    1.00=
3 GHz                         (60.64%)
> > >>>             728,945      instructions                     #    0.17=
  insn per cycle
> > >>>              79,199      branches                         #   18.16=
2 M/sec
> > >>>              17,709      branch-misses                    #   22.36=
% of all branches
> > >>>             181,734      L1-dcache-loads                  #   41.67=
6 M/sec
> > >>>               5,547      L1-dcache-load-misses            #    3.05=
% of all L1-dcache accesses
> > >>>       <not counted>      LLC-loads                                 =
                              (0.00%)
> > >>>       <not counted>      LLC-load-misses                           =
                              (0.00%)
> > >>>       <not counted>      L1-icache-loads                           =
                              (0.00%)
> > >>>       <not counted>      L1-icache-load-misses                     =
                              (0.00%)
> > >>>       <not counted>      dTLB-loads                                =
                              (0.00%)
> > >>>       <not counted>      dTLB-load-misses                          =
                              (0.00%)
> > >>>       <not counted>      iTLB-loads                                =
                              (0.00%)
> > >>>       <not counted>      iTLB-load-misses                          =
                              (0.00%)
> > >>>       <not counted>      L1-dcache-prefetches                      =
                              (0.00%)
> > >>>       <not counted>      L1-dcache-prefetch-misses                 =
                              (0.00%)
> > >>>
> > >>>         0.005860375 seconds time elapsed
> > >>>
> > >>>         0.000000000 seconds user
> > >>>         0.010383000 seconds sys
> > >>>
> > >>> After this patch:
> > >>> $ perf list hw
> > >>>
> > >>> List of pre-defined events (to be used in -e or -M):
> > >>>
> > >>>    branch-instructions OR branches                    [Hardware eve=
nt]
> > >>>    branch-misses                                      [Hardware eve=
nt]
> > >>>    cache-misses                                       [Hardware eve=
nt]
> > >>>    cache-references                                   [Hardware eve=
nt]
> > >>>    cpu-cycles OR cycles                               [Hardware eve=
nt]
> > >>>    instructions                                       [Hardware eve=
nt]
> > >>>
> > >>> $ perf stat -ddd true
> > >>>
> > >>>   Performance counter stats for 'true':
> > >>>
> > >>>                5.16 msec task-clock                       #    0.84=
8 CPUs utilized
> > >>>                   1      context-switches                 #  193.81=
7 /sec
> > >>>                   0      cpu-migrations                   #    0.00=
0 /sec
> > >>>                  37      page-faults                      #    7.17=
1 K/sec
> > >>>           5,183,625      cycles                           #    1.00=
5 GHz
> > >>>             961,696      instructions                     #    0.19=
  insn per cycle
> > >>>              85,853      branches                         #   16.64=
0 M/sec
> > >>>              20,462      branch-misses                    #   23.83=
% of all branches
> > >>>             243,545      L1-dcache-loads                  #   47.20=
3 M/sec
> > >>>               5,974      L1-dcache-load-misses            #    2.45=
% of all L1-dcache accesses
> > >>>     <not supported>      LLC-loads
> > >>>     <not supported>      LLC-load-misses
> > >>>     <not supported>      L1-icache-loads
> > >>>     <not supported>      L1-icache-load-misses
> > >>>     <not supported>      dTLB-loads
> > >>>              19,619      dTLB-load-misses
> > >>>     <not supported>      iTLB-loads
> > >>>               6,831      iTLB-load-misses
> > >>>     <not supported>      L1-dcache-prefetches
> > >>>     <not supported>      L1-dcache-prefetch-misses
> > >>>
> > >>>         0.006085625 seconds time elapsed
> > >>>
> > >>>         0.000000000 seconds user
> > >>>         0.013022000 seconds sys
> > >>>
> > >>>
> > >>>   drivers/perf/riscv_pmu_sbi.c | 37 +++++++++++++++++++++++++++++++=
+++--
> > >>>   1 file changed, 35 insertions(+), 2 deletions(-)
> > >>>
> > >>> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_=
sbi.c
> > >>> index 16acd4dcdb96..b58a70ee8317 100644
> > >>> --- a/drivers/perf/riscv_pmu_sbi.c
> > >>> +++ b/drivers/perf/riscv_pmu_sbi.c
> > >>> @@ -86,7 +86,7 @@ struct sbi_pmu_event_data {
> > >>>          };
> > >>>   };
> > >>>
> > >>> -static const struct sbi_pmu_event_data pmu_hw_event_map[] =3D {
> > >>> +static struct sbi_pmu_event_data pmu_hw_event_map[] =3D {
> > >>>          [PERF_COUNT_HW_CPU_CYCLES]              =3D {.hw_gen_event=
 =3D {
> > >>>                                                          SBI_PMU_HW=
_CPU_CYCLES,
> > >>>                                                          SBI_PMU_EV=
ENT_TYPE_HW, 0}},
> > >>> @@ -120,7 +120,7 @@ static const struct sbi_pmu_event_data pmu_hw_e=
vent_map[] =3D {
> > >>>   };
> > >>>
> > >>>   #define C(x) PERF_COUNT_HW_CACHE_##x
> > >>> -static const struct sbi_pmu_event_data pmu_cache_event_map[PERF_CO=
UNT_HW_CACHE_MAX]
> > >>> +static struct sbi_pmu_event_data pmu_cache_event_map[PERF_COUNT_HW=
_CACHE_MAX]
> > >>>   [PERF_COUNT_HW_CACHE_OP_MAX]
> > >>>   [PERF_COUNT_HW_CACHE_RESULT_MAX] =3D {
> > >>>          [C(L1D)] =3D {
> > >>> @@ -265,6 +265,36 @@ static const struct sbi_pmu_event_data pmu_cac=
he_event_map[PERF_COUNT_HW_CACHE_M
> > >>>          },
> > >>>   };
> > >>>
> > >>> +static void pmu_sbi_check_event(struct sbi_pmu_event_data *edata)
> > >>> +{
> > >>> +       struct sbiret ret;
> > >>> +
> > >>> +       ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATC=
H,
> > >>> +                       0, cmask, 0, edata->event_idx, 0, 0);
> > >>> +       if (!ret.error) {
> > >>> +               sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
> > >>> +                         ret.value, 0x1, SBI_PMU_STOP_FLAG_RESET, =
0, 0, 0);
> > >>> +       } else if (ret.error =3D=3D SBI_ERR_NOT_SUPPORTED) {
> > >>> +               /* This event cannot be monitored by any counter */
> > >>> +               edata->event_idx =3D -EINVAL;
> > >>> +       }
> > >>> +}
> > >>> +
> > >>> +static void pmu_sbi_update_events(void)
> > >>> +{
> > >>> +       /* Ensure events are not already mapped to a counter */
> > >>> +       sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
> > >>> +                 0, cmask, SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
> > >>> +
> > >>> +       for (int i =3D 0; i < ARRAY_SIZE(pmu_hw_event_map); i++)
> > >>> +               pmu_sbi_check_event(&pmu_hw_event_map[i]);
> > >>> +
> > >>> +       for (int i =3D 0; i < ARRAY_SIZE(pmu_cache_event_map); i++)
> > >>> +               for (int j =3D 0; j < ARRAY_SIZE(pmu_cache_event_ma=
p[i]); j++)
> > >>> +                       for (int k =3D 0; k < ARRAY_SIZE(pmu_cache_=
event_map[i][j]); k++)
> > >>> +                               pmu_sbi_check_event(&pmu_cache_even=
t_map[i][j][k]);
> > >>> +}
> > >>> +
> > >>>   static int pmu_sbi_ctr_get_width(int idx)
> > >>>   {
> > >>>          return pmu_ctr_list[idx].width;
> > >>> @@ -1046,6 +1076,9 @@ static int pmu_sbi_device_probe(struct platfo=
rm_device *pdev)
> > >>>          if (pmu_sbi_get_ctrinfo(num_counters, &cmask))
> > >>>                  goto out_free;
> > >>>
> > >>> +       /* Check which standard events are available */
> > >>> +       pmu_sbi_update_events();
> > >>> +
> > >>>          ret =3D pmu_sbi_setup_irqs(pmu, pdev);
> > >>>          if (ret < 0) {
> > >>>                  pr_info("Perf sampling/filtering is not supported =
as sscof extension is not available\n");
> > >>> --
> > >>> 2.42.0
> > >
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
>

