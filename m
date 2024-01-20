Return-Path: <linux-kernel+bounces-31873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19158335B7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 19:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8255B282ED0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 18:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2E81376;
	Sat, 20 Jan 2024 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lLXExiU7"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B343A125CC
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 18:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705775408; cv=none; b=t+yXcisi6495H9WrXAiPgdiMkVDmMnwF0J51pfc01PRMBhkU6D6Iz8ZDUjd0qIgJBxRaZaprajuBYkKqo/yvDlIlYpdMz0l5Z5U87aqzvAzaqYiLJ3eaEaa2LAG9xOCfZ36jbhjiNFYvCJL8Wc8nGlRx5L6kcm6KqLQdvAkbogk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705775408; c=relaxed/simple;
	bh=meG0ZscSAxljuo0mJkyR4houfil6LDThwXiauv18hUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uv355jWvkVSiABbwmZ3bqSg0anfDMA6niksQIGiVXLuD73vEa1sqV1awI3aBG5uCTwKg5p7tC5CPig2MJ+/SJx57bcM7OMhCCAoTRPS37XdqoTTNtBKNZdtCVxEhQkoAdU4UyREpC6bQ30gEcJNfP7HZHn2N8LQjSXXjQnoSApM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lLXExiU7; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-361b24d1a9eso99125ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 10:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705775406; x=1706380206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NdRfKea1tyAVfEakUSuu/NRx0RELAafVQhu5PyDRPs=;
        b=lLXExiU7SKhN99yS/uRwngy6qeTA438Sf4qMMf8lOIIRjkH9iHXLjPdyazunHqx0S/
         YAaXQqA9jlmkXwFr1USvblDuRQEJ/QOlzOH3T40EgpW4xxDq9WXAAskPOboNwuv4D8Rm
         lbrXTPNMYcDzhsBOlw6tCKlfsPpASRZDiLEgMWnImrBvklgJAunbxC72SPQkWoQ77q9f
         vKfcgWhOZwQdDUtKRfYuQuNzC9r4Hnk+DSA4Do/JMaU1P1uhy2UzpoaguaYrFweATXHS
         gScDl6t8GTKnZWm6iLLJDty4+hgJSj8Ry3N09P66MK4ldWuWbNEzpTKckhUz6jQuN3W1
         tadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705775406; x=1706380206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NdRfKea1tyAVfEakUSuu/NRx0RELAafVQhu5PyDRPs=;
        b=nEEGaEv59VkEZI9B4YjuJjdt54L2Uc5Q7YGEKx9QioiqR0YjAntmu7qpt2GT9U4exq
         IJReG59IQI2TGr4pKPrz+nsfFlip3GRJ5yVl9WIJXymB/muxomuDYxf29I/W7H6+eM4Q
         7em1HEuvXu2v7pxVjJlu0pkwtbWjtXrKczEAMowaSvO7LzMY13r5WCfzIBGQE+B5hJam
         84WDSgqIVNGSY24obqPaBESKNlnZnCJz5GISnPFQpLxCggQHwIfrKB5vC3eJnzCFJ8S6
         XcfLR/IUMeJXxgyLPuj1KdVpXjpoyqL+fRHskPFK+ktUR1fVgjgUTeG+s1NyAC7hrF7K
         ofXA==
X-Gm-Message-State: AOJu0YwIDFTEbkJ3oTdV6Irr2a9+hk7qVedbMbz97Og2FBaOb11aqnFB
	bFoFmu7c6lOhghB2MiOZeUSt3y1vE49OI5V0ym/frP9OzVnJ
X-Google-Smtp-Source: AGHT+IERgiXXlCQViMuSiq6eDNod7GNvcjkhaox9riy0AK4hHK4G6Jz5an1k2WiI6NrvlYa31INRoCA9TWYmQ/xS85E=
X-Received: by 2002:a92:d152:0:b0:360:8a7d:b53d with SMTP id
 t18-20020a92d152000000b003608a7db53dmr90589ilg.5.1705775405605; Sat, 20 Jan
 2024 10:30:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116170348.463479-1-mark.rutland@arm.com> <CAP-5=fVABSBZnsmtRn1uF-k-G1GWM-L5SgiinhPTfHbQsKXb_g@mail.gmail.com>
In-Reply-To: <CAP-5=fVABSBZnsmtRn1uF-k-G1GWM-L5SgiinhPTfHbQsKXb_g@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 20 Jan 2024 10:29:54 -0800
Message-ID: <CAP-5=fXtbhX8qx=B+8QTm00WhCPAQNxH-=NSrEfOVo8wz8yd6A@mail.gmail.com>
Subject: Re: [PATCH] perf print-events: make is_event_supported() more robust
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>, 
	Marc Zyngier <maz@kernel.org>, acme@redhat.com, james.clark@arm.com, 
	john.g.garry@oracle.com, leo.yan@linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	mike.leach@linaro.org, namhyung@kernel.org, suzuki.poulose@arm.com, 
	tmricht@linux.ibm.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 20, 2024 at 10:27=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Tue, Jan 16, 2024 at 9:04=E2=80=AFAM Mark Rutland <mark.rutland@arm.co=
m> wrote:
> >
> > Currently the perf tool doesn't deteect support for extneded event type=
s
>
> nit: s/deteect/detect/
> nit: s/extneded/extended/
>
> > on Apple M1/M2 systems, and will not auto-expand plain PERF_EVENT_TYPE
> > hardware events into per-PMU events. This is due to the detection of
> > extended event types not handling mandatory filters required by the
> > M1/M2 PMU driver.
> >
> > PMU drivers and the core perf_events code can require that
> > perf_event_attr::exclude_* filters are configured in a specific way and
> > may reject certain configurations of filters, for example:
> >
> > (a) Many PMUs lack support for any event filtering, and require all
> >     perf_event_attr::exclude_* bits to be clear. This includes Alpha's
> >     CPU PMU, and ARM CPU PMUs prior to the introduction of PMUv2 in
> >     ARMv7,
> >
> > (b) When /proc/sys/kernel/perf_event_paranoid >=3D 2, the perf core
> >     requires that perf_event_attr::exclude_kernel is set.
> >
> > (c) The Apple M1/M2 PMU requires that perf_event_attr::exclude_guest is
> >     set as the hardware PMU does not count while a guest is running (bu=
t
> >     might be extended in future to do so).
> >
> > In is_event_supported(), we try to account for cases (a) and (b), first
> > attempting to open an event without any filters, and if this fails,
> > retrying with perf_event_attr::exclude_kernel set. We do not account fo=
r
> > case (c), or any other filters that drivers could theoretically require
> > to be set.
> >
> > Thus is_event_supported() will fail to detect support for any events
> > targetting an Apple M1/M2 PMU, even where events would be supported wit=
h
>
> nit: s/targetting/targeting/
>
> > perf_event_attr:::exclude_guest set.
> >
> > Since commit:
> >
> >   82fe2e45cdb00de4 ("perf pmus: Check if we can encode the PMU number i=
n perf_event_attr.type")
> >
> > ... we use is_event_supported() to detect support for extended types,
> > with the PMU ID encoded into the perf_event_attr::type. As above, on an
> > Apple M1/M2 system this will always fail to detect that the event is
> > supported, and consequently we fail to detect support for extended type=
s
> > even when these are supported, as they have been since commit:
> >
> >   5c816728651ae425 ("arm_pmu: Add PERF_PMU_CAP_EXTENDED_HW_TYPE capabil=
ity")
> >
> > Due to this, the perf tool will not automatically expand plain
> > PERF_TYPE_HARDWARE events into per-PMU events, even when all the
> > necessary kernel support is present.
> >
> > This patch updates is_event_supported() to additionally try opening
> > events with perf_event_attr::exclude_guest set, allowing support for
> > events to be detected on Apple M1/M2 systems. I beleive that this is
>
> nit: s/beleive/believe/
>
> > sufficient for all contemporary CPU PMU drivers, though in future it ma=
y
> > be necessary to check for other combinations of filter bits.
> >
> > I've deliberately changed the check to not expect a specific error code
> > for missing filters, as today ;the kernel may return a number of
> > different error codes for missing filters (e.g. -EACCESS, -EINVAL, or
> > -EOPNOTSUPP) depending on why and where the filter configuration is
> > rejected, and retrying for any error is more robust.
> >
> > Note that this does not remove the need for commit:
> >
> >   a24d9d9dc096fc0d ("perf parse-events: Make legacy events lower priori=
ty than sysfs/JSON")
> >
> > ... which is still necessary so that named-pmu/event/ events work on
> > kernels without extended type support, even if the event name happens t=
o
> > be the same as a PERF_EVENT_TYPE_HARDWARE event (e.g. as is the case fo=
r
> > the M1/M2 PMU's 'cycles' and 'instructions' events).
> >
> > Fixes: 82fe2e45cdb00de4 ("perf pmus: Check if we can encode the PMU num=
ber in perf_event_attr.type")
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Cc: Hector Martin <marcan@marcan.st>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: James Clark <james.clark@arm.com>
> > Cc: John Garry <john.g.garry@oracle.com>
> > Cc: Leo Yan <leo.yan@linaro.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Mike Leach <mike.leach@linaro.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Cc: Thomas Richter <tmricht@linux.ibm.com>
> > Cc: Will Deacon <will@kernel.org>

Also:
Tested-by: Ian Rogers <irogers@google.com>

No regressions on Alderlake except a pre-existing problem I noted here:
https://lore.kernel.org/lkml/CAP-5=3DfWVQ-7ijjK3-w1q+k2WYVNHbAcejb-xY0ptbjR=
w476VKA@mail.gmail.com/

Thanks,
Ian

> > ---
> >  tools/perf/util/print-events.c | 27 +++++++++++++++++++--------
> >  1 file changed, 19 insertions(+), 8 deletions(-)
> >
> > Hector, Marc, I'd appreciate if either of you could give this a spin on
> > your M1/M2 machines. I've given it local testing with the arm_pmuv3
> > driver modified to behave the same as the apple_m1_pmu driver (requirin=
g
> > exclude_guest, having a 'cycles' event in sysfs), but that might not
> > perfectly replicate your setup.
> >
> > The patch is based on the 'perf-tools-for-v6.8-1-2024-01-09' tag in the
> > perf-tools tree:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git/
> >
> > ... and I've pushed it out to the 'perf-tools/event-supported-filters'
> > branch in my tree:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/
> >
> > This patch *should* make it possible to do:
> >
> >         perf stat -e cycles ./workload
> >         perf stat -e instructions ./workload
> >
> > ... with those 'cycles' and 'instructions' events being automatically
> > expanded and reported as separate events per-PMU, which is a nice
> > quality-of-life improvement.
> >
> > Comparing before and after this patch:
> >
> > | # ./perf-before stat -e cycles true
> > |
> > |  Performance counter stats for 'true':
> > |
> > |      <not counted>      cycles                                       =
                           (0.00%)
> > |
> > |        0.000990250 seconds time elapsed
> > |
> > |        0.000934000 seconds user
> > |        0.000000000 seconds sys
> > |
> > | # ./perf-after stat -e cycles true
> > |
> > |  Performance counter stats for 'true':
> > |
> > |             965175      armv8_pmuv3_0/cycles/
> > |      <not counted>      armv8_pmuv3_1/cycles/                        =
                           (0.00%)
> > |      <not counted>      armv8_pmuv3_2/cycles/                        =
                           (0.00%)
> > |      <not counted>      armv8_pmuv3_3/cycles/                        =
                           (0.00%)
> > |
> > |        0.000836555 seconds time elapsed
> > |
> > |        0.000884000 seconds user
> > |        0.000000000 seconds sys
>
> Just to check, this is the expected expansion of cycles? I'm unclear
> why 4 core PMUs.
>
> >
> > This *shouldn't* change the interpetation of named-pmu events, e.g.
> >
> >         perf stat -e apple_whichever_pmu/cycles/ ./workload
> >
> > ... should behave the same as without this patch
> >
> > Comparing before and after this patch:
> >
> > | # ./perf-before stat -e armv8_pmuv3_0/cycles/ -e armv8_pmuv3_1/cycles=
/ -e armv8_pmuv3_2/cycles/ -e armv8_pmuv3_3/cycles/ true
> > |
> > |  Performance counter stats for 'true':
> > |
> > |      <not counted>      armv8_pmuv3_0/cycles/                        =
                           (0.00%)
> > |      <not counted>      armv8_pmuv3_1/cycles/                        =
                           (0.00%)
> > |      <not counted>      armv8_pmuv3_2/cycles/                        =
                           (0.00%)
> > |             901415      armv8_pmuv3_3/cycles/
> > |
> > |        0.000756590 seconds time elapsed
> > |
> > |        0.000811000 seconds user
> > |        0.000000000 seconds sys
> > |
> > | # ./perf-after stat -e armv8_pmuv3_0/cycles/ -e armv8_pmuv3_1/cycles/=
 -e armv8_pmuv3_2/cycles/ -e armv8_pmuv3_3/cycles/ true
> > |
> > |  Performance counter stats for 'true':
> > |
> > |             923314      armv8_pmuv3_0/cycles/
> > |      <not counted>      armv8_pmuv3_1/cycles/                        =
                           (0.00%)
> > |      <not counted>      armv8_pmuv3_2/cycles/                        =
                           (0.00%)
> > |      <not counted>      armv8_pmuv3_3/cycles/                        =
                           (0.00%)
> > |
> > |        0.000782420 seconds time elapsed
> > |
> > |        0.000836000 seconds user
> > |        0.000000000 seconds sys
> >
> > One thing I'm still looing into is that this doesn't seem to do anythin=
g
> > for a default perf stat session, e.g.
> >
> >         perf stat ./workload
> >
> > ... doesn't automatically expand the implicitly-created events into per=
-pmu
> > events.
>
> Ugh, weak symbols. x86 has overridden the default adding of attributes
> to do it for hybrid:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/=
tree/tools/perf/arch/x86/util/evlist.c?h=3Dperf-tools-next#n36
> I think we should lose the adding events via attributes and just go to
> using parse events for everything. I'll see if I can do some cleanup
> and that should resolve this - I also want to cleanup the default
> events/metrics and the detailed ones as we can drop the unsupported
> events, etc.
>
> > Comparing before and after this patch:
> >
> > | # ./perf-before stat true
> > |
> > |  Performance counter stats for 'true':
> > |
> > |               0.42 msec task-clock                       #    0.569 C=
PUs utilized
> > |                  0      context-switches                 #    0.000 /=
sec
> > |                  0      cpu-migrations                   #    0.000 /=
sec
> > |                 38      page-faults                      #   89.796 K=
/sec
> > |      <not counted>      cycles                                       =
                           (0.00%)
> > |      <not counted>      instructions                                 =
                           (0.00%)
> > |      <not counted>      branches                                     =
                           (0.00%)
> > |      <not counted>      branch-misses                                =
                           (0.00%)
> > |
> > |        0.000744185 seconds time elapsed
> > |
> > |        0.000795000 seconds user
> > |        0.000000000 seconds sys
> > |
> > | # ./perf-after stat true
> > |
> > |  Performance counter stats for 'true':
> > |
> > |               0.43 msec task-clock                       #    0.582 C=
PUs utilized
> > |                  0      context-switches                 #    0.000 /=
sec
> > |                  0      cpu-migrations                   #    0.000 /=
sec
> > |                 38      page-faults                      #   88.960 K=
/sec
> > |      <not counted>      cycles                                       =
                           (0.00%)
> > |      <not counted>      instructions                                 =
                           (0.00%)
> > |      <not counted>      branches                                     =
                           (0.00%)
> > |      <not counted>      branch-misses                                =
                           (0.00%)
> > |
> > |        0.000734120 seconds time elapsed
> > |
> > |        0.000786000 seconds user
> > |        0.000000000 seconds sys
> >
> > Ian, how does that behave on x86? Is that the same, or do the default
> > events get expanded?
>
> The default events are expanded, the not counted is a feature of a
> fast binary (true here). I'm trying to remove custom code paths so
> that things like this don't happen, sorry that you've come across
> another instance but at least I can fix it.
>
> Thanks,
> Ian
>
> > Thanks,
> > Mark.
> >
> > diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-eve=
nts.c
> > index b0fc48be623f3..4f67e8f00a4d6 100644
> > --- a/tools/perf/util/print-events.c
> > +++ b/tools/perf/util/print-events.c
> > @@ -232,7 +232,6 @@ void print_sdt_events(const struct print_callbacks =
*print_cb, void *print_state)
> >  bool is_event_supported(u8 type, u64 config)
> >  {
> >         bool ret =3D true;
> > -       int open_return;
> >         struct evsel *evsel;
> >         struct perf_event_attr attr =3D {
> >                 .type =3D type,
> > @@ -246,20 +245,32 @@ bool is_event_supported(u8 type, u64 config)
> >
> >         evsel =3D evsel__new(&attr);
> >         if (evsel) {
> > -               open_return =3D evsel__open(evsel, NULL, tmap);
> > -               ret =3D open_return >=3D 0;
> > +               ret =3D evsel__open(evsel, NULL, tmap) >=3D 0;
> >
> > -               if (open_return =3D=3D -EACCES) {
> > +               if (!ret) {
> >                         /*
> > -                        * This happens if the paranoid value
> > +                        * The event may fail to open if the paranoid v=
alue
> >                          * /proc/sys/kernel/perf_event_paranoid is set =
to 2
> > -                        * Re-run with exclude_kernel set; we don't do =
that
> > -                        * by default as some ARM machines do not suppo=
rt it.
> > -                        *
> > +                        * Re-run with exclude_kernel set; we don't do =
that by
> > +                        * default as some ARM machines do not support =
it.
> >                          */
> >                         evsel->core.attr.exclude_kernel =3D 1;
> >                         ret =3D evsel__open(evsel, NULL, tmap) >=3D 0;
> >                 }
> > +
> > +               if (!ret) {
> > +                       /*
> > +                        * The event may fail to open if the PMU requir=
es
> > +                        * exclude_guest to be set (e.g. as the Apple M=
1 PMU
> > +                        * requires).
> > +                        * Re-run with exclude_guest set; we don't do t=
hat by
> > +                        * default as it's equally legitimate for anoth=
er PMU
> > +                        * driver to require that exclude_guest is clea=
r.
> > +                        */
> > +                       evsel->core.attr.exclude_guest =3D 1;
> > +                       ret =3D evsel__open(evsel, NULL, tmap) >=3D 0;
> > +               }
> > +
> >                 evsel__delete(evsel);
> >         }
> >
> > --
> > 2.30.2
> >

