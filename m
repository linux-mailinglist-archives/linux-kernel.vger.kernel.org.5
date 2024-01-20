Return-Path: <linux-kernel+bounces-31869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C017F8335AE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 19:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBDC71C20DD3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 18:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D3511C94;
	Sat, 20 Jan 2024 18:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yXpCh+am"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FBB12E47
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 18:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705775267; cv=none; b=ojukHt0IlE/cATPPxt0j8i1MKWp32wIvvFi+JeXe64q3qF6xPjxB7+qgnVYb6qRZjEREZo5QeAq8A+qPF071y5xLv1tiaXX7H1Odu3G/LGBL2ABEiGyCW1TKvia7PAuQiurOUInyZ51PE7Y0SLRJfcDkRqEeB9P6BKnuObk8D14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705775267; c=relaxed/simple;
	bh=1hf+qwbJwv3MVMHc/wh7Ygtzwg0tCma3od5Jc10HMcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YzIrBrXgTsvuqQVdZqFaQ6OOsjUfU0YDziWdDNrVIydYQegN9c+KRHtb9cqNs9gSPXP4XWBfSpkObitELFuloMItSQexD0lhHuTw+05cMYH+pV5/m8cq8C5+q3wygdoAMHCydrNEFYaCeevGOdz2Ck0Hv+HhB32ctqCRFc/lxOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yXpCh+am; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d5ce88b51cso95065ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 10:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705775265; x=1706380065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3854fvVy32prlae+7huGpzU5WMZkqW2CNhkEGD6k6B0=;
        b=yXpCh+amjJ57qoA6fqAP91tfjWNCeQc/D0vUSHrR0hUWOmszqfb46X0suo1cV/wiK3
         fSoYxOx8CD0EzI6kB9Po995nBvFTyBhLi+tVB4wtJOLkgt1Y7+ktn3DSFdYbZfpkV++c
         DMv9Ssae0QLoVbjrPK3pEvTJlsuwCzDaHw5MTWdeYoZwCkyOweSFVjnoaJR0eYjmIOd6
         8RnaEcCLOdJbxO8dH1di9xPsmK1bpPMTGnh3Few76yuZdf3YZzlXYQuivaobClWNaCgZ
         UYDWm2Lb+gLaV5Jvo6/SIEirUcU+wDkoIKCe1hS6sENMTtAtsWXLtXASVoAXlww9mvOP
         3WaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705775265; x=1706380065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3854fvVy32prlae+7huGpzU5WMZkqW2CNhkEGD6k6B0=;
        b=NMWn6xAAQXl5GeAhP7HsQt3RTH3Hu/20bVMXHNqqqSwW/bGXHQry7aloC0G2Dt8hwl
         aB4Yy96XV08cceus5nPIE7gLY5wsxVYn8WuR/cYOM6O6oCC93txTFf68PMG5gnukO4/K
         msPu7fgYrtz9AZJ4uZMSBW5UETL8Ti8Sy9/BjCitkMMp4jsJG0f+94rgxU2zzJV5Nr3x
         qmUKwSxyOas2AiYuq+xYkQWFhUAV0sx4BJVDxHsLTJshOQuiilZYUhz1I8j7maV2/b2S
         69X+sqt3F55vScgAW32X1TM/M2HcY1tRgAzOb5ePh1eXZegl9KBA6gylkHr/trSApQE6
         mJuA==
X-Gm-Message-State: AOJu0Ywrpi6HqKfn2FDT78BE4MFghDyePwv9oktMEpWdsK9H+adOAlAs
	5q4k9Y8AO8+6HK8/28PCoezBXRGx36aTwpzLy3M2eH1R1mTR
X-Google-Smtp-Source: AGHT+IGNaAuEGNhVmCT+PzwiibXTaI7ucuBwHfkuFKJi8dSkILZkitB5nSeOyE9mvMNsw/tj9E9B8h9vNHsHEv7pQxU=
X-Received: by 2002:a17:902:a509:b0:1d6:fc65:4633 with SMTP id
 s9-20020a170902a50900b001d6fc654633mr60019plq.25.1705775265277; Sat, 20 Jan
 2024 10:27:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116170348.463479-1-mark.rutland@arm.com>
In-Reply-To: <20240116170348.463479-1-mark.rutland@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 20 Jan 2024 10:27:33 -0800
Message-ID: <CAP-5=fVABSBZnsmtRn1uF-k-G1GWM-L5SgiinhPTfHbQsKXb_g@mail.gmail.com>
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

On Tue, Jan 16, 2024 at 9:04=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> Currently the perf tool doesn't deteect support for extneded event types

nit: s/deteect/detect/
nit: s/extneded/extended/

> on Apple M1/M2 systems, and will not auto-expand plain PERF_EVENT_TYPE
> hardware events into per-PMU events. This is due to the detection of
> extended event types not handling mandatory filters required by the
> M1/M2 PMU driver.
>
> PMU drivers and the core perf_events code can require that
> perf_event_attr::exclude_* filters are configured in a specific way and
> may reject certain configurations of filters, for example:
>
> (a) Many PMUs lack support for any event filtering, and require all
>     perf_event_attr::exclude_* bits to be clear. This includes Alpha's
>     CPU PMU, and ARM CPU PMUs prior to the introduction of PMUv2 in
>     ARMv7,
>
> (b) When /proc/sys/kernel/perf_event_paranoid >=3D 2, the perf core
>     requires that perf_event_attr::exclude_kernel is set.
>
> (c) The Apple M1/M2 PMU requires that perf_event_attr::exclude_guest is
>     set as the hardware PMU does not count while a guest is running (but
>     might be extended in future to do so).
>
> In is_event_supported(), we try to account for cases (a) and (b), first
> attempting to open an event without any filters, and if this fails,
> retrying with perf_event_attr::exclude_kernel set. We do not account for
> case (c), or any other filters that drivers could theoretically require
> to be set.
>
> Thus is_event_supported() will fail to detect support for any events
> targetting an Apple M1/M2 PMU, even where events would be supported with

nit: s/targetting/targeting/

> perf_event_attr:::exclude_guest set.
>
> Since commit:
>
>   82fe2e45cdb00de4 ("perf pmus: Check if we can encode the PMU number in =
perf_event_attr.type")
>
> ... we use is_event_supported() to detect support for extended types,
> with the PMU ID encoded into the perf_event_attr::type. As above, on an
> Apple M1/M2 system this will always fail to detect that the event is
> supported, and consequently we fail to detect support for extended types
> even when these are supported, as they have been since commit:
>
>   5c816728651ae425 ("arm_pmu: Add PERF_PMU_CAP_EXTENDED_HW_TYPE capabilit=
y")
>
> Due to this, the perf tool will not automatically expand plain
> PERF_TYPE_HARDWARE events into per-PMU events, even when all the
> necessary kernel support is present.
>
> This patch updates is_event_supported() to additionally try opening
> events with perf_event_attr::exclude_guest set, allowing support for
> events to be detected on Apple M1/M2 systems. I beleive that this is

nit: s/beleive/believe/

> sufficient for all contemporary CPU PMU drivers, though in future it may
> be necessary to check for other combinations of filter bits.
>
> I've deliberately changed the check to not expect a specific error code
> for missing filters, as today ;the kernel may return a number of
> different error codes for missing filters (e.g. -EACCESS, -EINVAL, or
> -EOPNOTSUPP) depending on why and where the filter configuration is
> rejected, and retrying for any error is more robust.
>
> Note that this does not remove the need for commit:
>
>   a24d9d9dc096fc0d ("perf parse-events: Make legacy events lower priority=
 than sysfs/JSON")
>
> ... which is still necessary so that named-pmu/event/ events work on
> kernels without extended type support, even if the event name happens to
> be the same as a PERF_EVENT_TYPE_HARDWARE event (e.g. as is the case for
> the M1/M2 PMU's 'cycles' and 'instructions' events).
>
> Fixes: 82fe2e45cdb00de4 ("perf pmus: Check if we can encode the PMU numbe=
r in perf_event_attr.type")
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Hector Martin <marcan@marcan.st>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@arm.com>
> Cc: John Garry <john.g.garry@oracle.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Thomas Richter <tmricht@linux.ibm.com>
> Cc: Will Deacon <will@kernel.org>
> ---
>  tools/perf/util/print-events.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
>
> Hector, Marc, I'd appreciate if either of you could give this a spin on
> your M1/M2 machines. I've given it local testing with the arm_pmuv3
> driver modified to behave the same as the apple_m1_pmu driver (requiring
> exclude_guest, having a 'cycles' event in sysfs), but that might not
> perfectly replicate your setup.
>
> The patch is based on the 'perf-tools-for-v6.8-1-2024-01-09' tag in the
> perf-tools tree:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git/
>
> ... and I've pushed it out to the 'perf-tools/event-supported-filters'
> branch in my tree:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/
>
> This patch *should* make it possible to do:
>
>         perf stat -e cycles ./workload
>         perf stat -e instructions ./workload
>
> ... with those 'cycles' and 'instructions' events being automatically
> expanded and reported as separate events per-PMU, which is a nice
> quality-of-life improvement.
>
> Comparing before and after this patch:
>
> | # ./perf-before stat -e cycles true
> |
> |  Performance counter stats for 'true':
> |
> |      <not counted>      cycles                                         =
                         (0.00%)
> |
> |        0.000990250 seconds time elapsed
> |
> |        0.000934000 seconds user
> |        0.000000000 seconds sys
> |
> | # ./perf-after stat -e cycles true
> |
> |  Performance counter stats for 'true':
> |
> |             965175      armv8_pmuv3_0/cycles/
> |      <not counted>      armv8_pmuv3_1/cycles/                          =
                         (0.00%)
> |      <not counted>      armv8_pmuv3_2/cycles/                          =
                         (0.00%)
> |      <not counted>      armv8_pmuv3_3/cycles/                          =
                         (0.00%)
> |
> |        0.000836555 seconds time elapsed
> |
> |        0.000884000 seconds user
> |        0.000000000 seconds sys

Just to check, this is the expected expansion of cycles? I'm unclear
why 4 core PMUs.

>
> This *shouldn't* change the interpetation of named-pmu events, e.g.
>
>         perf stat -e apple_whichever_pmu/cycles/ ./workload
>
> ... should behave the same as without this patch
>
> Comparing before and after this patch:
>
> | # ./perf-before stat -e armv8_pmuv3_0/cycles/ -e armv8_pmuv3_1/cycles/ =
-e armv8_pmuv3_2/cycles/ -e armv8_pmuv3_3/cycles/ true
> |
> |  Performance counter stats for 'true':
> |
> |      <not counted>      armv8_pmuv3_0/cycles/                          =
                         (0.00%)
> |      <not counted>      armv8_pmuv3_1/cycles/                          =
                         (0.00%)
> |      <not counted>      armv8_pmuv3_2/cycles/                          =
                         (0.00%)
> |             901415      armv8_pmuv3_3/cycles/
> |
> |        0.000756590 seconds time elapsed
> |
> |        0.000811000 seconds user
> |        0.000000000 seconds sys
> |
> | # ./perf-after stat -e armv8_pmuv3_0/cycles/ -e armv8_pmuv3_1/cycles/ -=
e armv8_pmuv3_2/cycles/ -e armv8_pmuv3_3/cycles/ true
> |
> |  Performance counter stats for 'true':
> |
> |             923314      armv8_pmuv3_0/cycles/
> |      <not counted>      armv8_pmuv3_1/cycles/                          =
                         (0.00%)
> |      <not counted>      armv8_pmuv3_2/cycles/                          =
                         (0.00%)
> |      <not counted>      armv8_pmuv3_3/cycles/                          =
                         (0.00%)
> |
> |        0.000782420 seconds time elapsed
> |
> |        0.000836000 seconds user
> |        0.000000000 seconds sys
>
> One thing I'm still looing into is that this doesn't seem to do anything
> for a default perf stat session, e.g.
>
>         perf stat ./workload
>
> ... doesn't automatically expand the implicitly-created events into per-p=
mu
> events.

Ugh, weak symbols. x86 has overridden the default adding of attributes
to do it for hybrid:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/arch/x86/util/evlist.c?h=3Dperf-tools-next#n36
I think we should lose the adding events via attributes and just go to
using parse events for everything. I'll see if I can do some cleanup
and that should resolve this - I also want to cleanup the default
events/metrics and the detailed ones as we can drop the unsupported
events, etc.

> Comparing before and after this patch:
>
> | # ./perf-before stat true
> |
> |  Performance counter stats for 'true':
> |
> |               0.42 msec task-clock                       #    0.569 CPU=
s utilized
> |                  0      context-switches                 #    0.000 /se=
c
> |                  0      cpu-migrations                   #    0.000 /se=
c
> |                 38      page-faults                      #   89.796 K/s=
ec
> |      <not counted>      cycles                                         =
                         (0.00%)
> |      <not counted>      instructions                                   =
                         (0.00%)
> |      <not counted>      branches                                       =
                         (0.00%)
> |      <not counted>      branch-misses                                  =
                         (0.00%)
> |
> |        0.000744185 seconds time elapsed
> |
> |        0.000795000 seconds user
> |        0.000000000 seconds sys
> |
> | # ./perf-after stat true
> |
> |  Performance counter stats for 'true':
> |
> |               0.43 msec task-clock                       #    0.582 CPU=
s utilized
> |                  0      context-switches                 #    0.000 /se=
c
> |                  0      cpu-migrations                   #    0.000 /se=
c
> |                 38      page-faults                      #   88.960 K/s=
ec
> |      <not counted>      cycles                                         =
                         (0.00%)
> |      <not counted>      instructions                                   =
                         (0.00%)
> |      <not counted>      branches                                       =
                         (0.00%)
> |      <not counted>      branch-misses                                  =
                         (0.00%)
> |
> |        0.000734120 seconds time elapsed
> |
> |        0.000786000 seconds user
> |        0.000000000 seconds sys
>
> Ian, how does that behave on x86? Is that the same, or do the default
> events get expanded?

The default events are expanded, the not counted is a feature of a
fast binary (true here). I'm trying to remove custom code paths so
that things like this don't happen, sorry that you've come across
another instance but at least I can fix it.

Thanks,
Ian

> Thanks,
> Mark.
>
> diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-event=
s.c
> index b0fc48be623f3..4f67e8f00a4d6 100644
> --- a/tools/perf/util/print-events.c
> +++ b/tools/perf/util/print-events.c
> @@ -232,7 +232,6 @@ void print_sdt_events(const struct print_callbacks *p=
rint_cb, void *print_state)
>  bool is_event_supported(u8 type, u64 config)
>  {
>         bool ret =3D true;
> -       int open_return;
>         struct evsel *evsel;
>         struct perf_event_attr attr =3D {
>                 .type =3D type,
> @@ -246,20 +245,32 @@ bool is_event_supported(u8 type, u64 config)
>
>         evsel =3D evsel__new(&attr);
>         if (evsel) {
> -               open_return =3D evsel__open(evsel, NULL, tmap);
> -               ret =3D open_return >=3D 0;
> +               ret =3D evsel__open(evsel, NULL, tmap) >=3D 0;
>
> -               if (open_return =3D=3D -EACCES) {
> +               if (!ret) {
>                         /*
> -                        * This happens if the paranoid value
> +                        * The event may fail to open if the paranoid val=
ue
>                          * /proc/sys/kernel/perf_event_paranoid is set to=
 2
> -                        * Re-run with exclude_kernel set; we don't do th=
at
> -                        * by default as some ARM machines do not support=
 it.
> -                        *
> +                        * Re-run with exclude_kernel set; we don't do th=
at by
> +                        * default as some ARM machines do not support it=
.
>                          */
>                         evsel->core.attr.exclude_kernel =3D 1;
>                         ret =3D evsel__open(evsel, NULL, tmap) >=3D 0;
>                 }
> +
> +               if (!ret) {
> +                       /*
> +                        * The event may fail to open if the PMU requires
> +                        * exclude_guest to be set (e.g. as the Apple M1 =
PMU
> +                        * requires).
> +                        * Re-run with exclude_guest set; we don't do tha=
t by
> +                        * default as it's equally legitimate for another=
 PMU
> +                        * driver to require that exclude_guest is clear.
> +                        */
> +                       evsel->core.attr.exclude_guest =3D 1;
> +                       ret =3D evsel__open(evsel, NULL, tmap) >=3D 0;
> +               }
> +
>                 evsel__delete(evsel);
>         }
>
> --
> 2.30.2
>

