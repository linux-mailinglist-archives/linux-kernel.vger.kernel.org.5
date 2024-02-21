Return-Path: <linux-kernel+bounces-75454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7386785E8F0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4C16B241E8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C257A86AD4;
	Wed, 21 Feb 2024 20:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="lQxararq"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791741272B4
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 20:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708546793; cv=none; b=miDA8zfpp2yFCtnA8mkkDDzDdZLE9XcUm9sAz+Vs+Tk6dNdRXavGGY/6+P/o0mKsPlKCsFzKJU+FR9/LekTmIeivoxpMNcITTyc6xQ308hm6S0JZdrkrcbLn4YUxAMGbt9RfSStbGZjrdGEu8N/K5fCVvvCrAcWp6iSeYbJDOWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708546793; c=relaxed/simple;
	bh=bDP0uOp71ZJ40SPhEcYqiixXc34u57l7lBzJrlk2B0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xq0VHbXU87BNRcXO3+mJXJ6N1ELllbzTJQMOafDvoAyZNO7vGYOUiqLxgJpd2fV5EHtqQpTzrwGU+n0+PAG/AG6zlLGJ9q7AciBiHOVbOyZzDQJNmRYpWlUii9mVmsYAZiINJiaEG2XgrwHMM8n50rR4cPwFIAa2LBd6NT+TlaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lQxararq; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dbcf58b05cso35815ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 12:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708546777; x=1709151577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBnEL2Nv2EtdY0R7cxkdDh94aICzF8VYHKyI9ju4cqU=;
        b=lQxararqoLm6XEyXgZOZdyZQam5QOKSPAIfhCU4OCzXPQJCoMd3px3khOh86myk1yU
         9Si0EryC0Si5Ze+wr2jjTv9ohcsMVq7rCsDawFlzI6z1NQ4xFAePrrc84FLd3O3hBpNK
         lcpkgNIgWtdjZEMcS4ij84Y7bCeMMNGCKPohaUTtCoQh/muawnoi2qIETQSeydtGA4Bh
         V/bS7MafDllxeJo80UtlfWTlZ3HG67OXHC+dALHKqXO2443Vo18XVA8sI9U0otXVsFmD
         Kq3yCv1YKPY+1m9fFhe7UJXvRZv0YUW5iXOJ+NJ3DBNg9GY4M3SsdkGL07BbI4hefSFW
         nSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708546777; x=1709151577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BBnEL2Nv2EtdY0R7cxkdDh94aICzF8VYHKyI9ju4cqU=;
        b=exZQLtURHStQlhXG5ZMcoS92VlarMWNpBh0foVqSQrndjh65pgwfQ9E9I7ixXli70+
         hNP9X2jXWALrl0QY2tT27/HRNMF7gJVRZIIX//gVKAw8MqPPQ+PTHbfQCJB8xVOQEzNu
         qGmKyxqRp+f2YMTbW7CiAGtEvsCwDfJUUy+Yka+qNxqy1+ckJnkAXYImGVuvbDznYSg6
         Q5OcT6CFrINKMCy2ul1U1FQ1N6PSUGGrX+7kGL/68FPGJUtDeEcoS3kGfYl1QzAag7A6
         qF1/dDmlPRmuiIlvsc3A+IqRIRw7jaHNHgynk5CLsh+FopONcY26Yyk3nxClw7C5lza9
         EQAA==
X-Gm-Message-State: AOJu0YxRPMVsdVrUK/4Fgntm4YjGgxb7pCWXYpdbKrqhaTmX2opVqRuu
	CJWXdlUzmtpp1sJDxcZA3NdSeHtJlhnOY/WEyNTw62g2v7CTmjf6YVPhjYvIGPApa+uD3M6viAW
	AFa0/iLx4NN/ghIjosMpKVHfCmbN7pZ2IO8mw
X-Google-Smtp-Source: AGHT+IEftC3CAOyYPuNtEgw2Qhn1fJdvdDmS7a2SXukzfo4kwiSPBH0aTLNADF7WZMl4BWy3giXAJdshznQ3TSNsx8M=
X-Received: by 2002:a17:903:2808:b0:1d9:aa55:e4c1 with SMTP id
 kp8-20020a170903280800b001d9aa55e4c1mr323224plb.20.1708546777286; Wed, 21 Feb
 2024 12:19:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126145605.1005472-1-mark.rutland@arm.com>
In-Reply-To: <20240126145605.1005472-1-mark.rutland@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 21 Feb 2024 12:19:22 -0800
Message-ID: <CAP-5=fURS0OQxHcukS1+NprgyMpAQSr3+BMiYPj5x7=+tcZ8hw@mail.gmail.com>
Subject: Re: [PATCH v2] perf print-events: make is_event_supported() more robust
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, acme@redhat.com, james.clark@arm.com, 
	john.g.garry@oracle.com, leo.yan@linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	marcan@marcan.st, maz@kernel.org, mike.leach@linaro.org, namhyung@kernel.org, 
	suzuki.poulose@arm.com, tmricht@linux.ibm.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 6:56=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> Currently the perf tool doesn't detect support for extended event types
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
> targeting an Apple M1/M2 PMU, even where events would be supported with
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
> events to be detected on Apple M1/M2 systems. I believe that this is
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
> Tested-by: Ian Rogers <irogers@google.com>
> Tested-by: James Clark <james.clark@arm.com>
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

Ping. Could we land this one?

Thanks,
Ian

> ---
>  tools/perf/util/print-events.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
>
> Since v1 [1]:
> * Fix typos in commit message
> * Accumulate tags
>
> [1] https://lore.kernel.org/lkml/20240116170348.463479-1-mark.rutland@arm=
com/
>
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

