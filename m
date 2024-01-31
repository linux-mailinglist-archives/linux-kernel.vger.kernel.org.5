Return-Path: <linux-kernel+bounces-46535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3CA844107
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B28D41C20F5A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B23580BF9;
	Wed, 31 Jan 2024 13:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LVNj2Nr6"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D1380BF1
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706709109; cv=none; b=cNA8K/vN9jipHhNlaXZkp61JNLwqE/+bqWjAUEA8KcZnAZPiOE074TQCXv4xcZhi3ItWO/g3dqXLcBWxHYPFqhtQdGbdwFdaFLvJn2oQm2x65oMdfl4jQVaMdP/7bH7rTWkZ0iaaRZfLtsCED7EZVYX/KdSHoGwDCeuVCvVMds8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706709109; c=relaxed/simple;
	bh=fyn7CNrrVrpYyrM58B+ntXebk8wUTe3fdYprQRco57w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ngoonFkEhpC93hqjGm6ETrZHSKxWhFJMDYW2FNvuep6QzgVp21mrBEuw5uOqeOueaa/snNOoMvCIjoqq2jeWrTXqgnKCDO85wtobCBESytSFPrWLuHu/iTskgboiJtzDQ9f16JcRIaHMOXBjUJZpXfvE03NFMfL1/HYRKbHo1NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LVNj2Nr6; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-36394219fbfso141325ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 05:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706709107; x=1707313907; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qp92m4+7j1oe526U6TZ1do3LliICAajgI9vCOPFkmF0=;
        b=LVNj2Nr6xDNiGEKjMbxMD3UBG8y8693Dl7x8vddOiBWwVoHRaufFXh59Exy3JCu2Wb
         SdrG4/5109P/Me7ug+ZOrleUu17dgYY6sfbGPf7rWGR8+w5pIF5ds+VecaS4qc662Cd5
         YIN9NE13v9rhcAC//SAqO9EHdmdrrp/cwX4VER0ius6ykdU4t5hQUnDNcQVIHpOGRgQm
         aZvU8JqagTcXAFm7aLpZAY9ofytkarq3JrL1h4kmfYZO9jML7S31xYSe2n+dj6IvSuab
         h3w/6Yw6QVuptWTsSwz+SAhRvkuS7DOd0LTiPmIPppz+6Mtfzn4PQprDXuF+our48xnq
         jD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706709107; x=1707313907;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qp92m4+7j1oe526U6TZ1do3LliICAajgI9vCOPFkmF0=;
        b=RCCrHsbayjuwgJbQPRgessjKGcS6Iqg3+Ein3x6YVME6dEaqFG1pB5swbay/81jjTq
         UJA5umX3WX0KkRYUL5W2Co//0CQK0xs1f+5h8lddslz/tkvyIcRNsYtuH2UunNCYzPy0
         HZSoYZLjuAvICbpQEG/FTsAtO54jHCet8HtC0s6BAAkGNv20jZXkebiLJpEUYZyrvRBJ
         xSVXXHoWmQPyGLdMw8RFVNYQnTepPy2fHFqAZftKSYKoTtx9WaWvbdjpES2SA6wvw7Zq
         /HhG+asTlISJZ9KFsdrBQlGyGW7Y3stpw/dBK41PKdIRyaaSRhuPeQwuzhGMLzYhhiZj
         4log==
X-Gm-Message-State: AOJu0YwbY7GyAcZHjNQBrAdvpUo5ZA5f+thT+tQL3hZ5ACiDk4AsHKad
	qLFCnYukz+qK8Q5cZ3WXRD3pkARfZD5IUNirr74c4m8IBPFrV8JX9VU19aoDwhpLjJBDf+qL5gP
	Racz1BBTqDoLt5F+QJVyL2UOEIW7r7lSXllGy
X-Google-Smtp-Source: AGHT+IFz910e95ewtwhhYN+Tk20AQOgrnpskxCJV00zrcITe64YiZIZkOE0LSPtKjShspk5+kSPGqENdP6DEEZRg6mk=
X-Received: by 2002:a05:6e02:e0b:b0:363:8007:d7dd with SMTP id
 a11-20020a056e020e0b00b003638007d7ddmr468225ilk.3.1706709107325; Wed, 31 Jan
 2024 05:51:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131134940.593788-1-irogers@google.com>
In-Reply-To: <20240131134940.593788-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 31 Jan 2024 05:51:36 -0800
Message-ID: <CAP-5=fVf6A2dxLpFKo4S5A7KUtVqBsBH0u1P29ksf1TjYZvhaQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] perf tsc: Add missing newlines to debug statements
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tchen168@asu.edu, Michael Petlan <mpetlan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 5:49=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> It is assumed that debug statements always print a newline, fix two
> missing ones.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sorry forgot to add:
Reviewed-by: James Clark <james.clark@arm.com>
To this one.

Thanks,
Ian

> ---
> This patch was inspired by bad debug output in:
> https://lore.kernel.org/linux-perf-users/CAGjhMsg_bVKJ_zfsLUR32+oZwGDr3Oi=
BHV_BJ3QtFjyKAs7Sgg@mail.gmail.com/
> ---
>  tools/perf/arch/x86/util/tsc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/arch/x86/util/tsc.c b/tools/perf/arch/x86/util/ts=
c.c
> index 9b99f48b923c..e2d6cfe21057 100644
> --- a/tools/perf/arch/x86/util/tsc.c
> +++ b/tools/perf/arch/x86/util/tsc.c
> @@ -33,7 +33,7 @@ static double cpuinfo_tsc_freq(void)
>
>         cpuinfo =3D fopen("/proc/cpuinfo", "r");
>         if (!cpuinfo) {
> -               pr_err("Failed to read /proc/cpuinfo for TSC frequency");
> +               pr_err("Failed to read /proc/cpuinfo for TSC frequency\n"=
);
>                 return NAN;
>         }
>         while (getline(&line, &len, cpuinfo) > 0) {
> @@ -48,7 +48,7 @@ static double cpuinfo_tsc_freq(void)
>         }
>  out:
>         if (fpclassify(result) =3D=3D FP_ZERO)
> -               pr_err("Failed to find TSC frequency in /proc/cpuinfo");
> +               pr_err("Failed to find TSC frequency in /proc/cpuinfo\n")=
;
>
>         free(line);
>         fclose(cpuinfo);
> --
> 2.43.0.429.g432eaa2c6b-goog
>

