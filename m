Return-Path: <linux-kernel+bounces-117264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD2188A969
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DDE81F3F85F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17F114A0B4;
	Mon, 25 Mar 2024 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gQ4C3N0h"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A84E84047
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711377279; cv=none; b=j0YmdyrMrx9QKzHZvf2gyJf6pLZHkXgPYuXaopYo0RIm4bfQzLcn5fkrNP6pBojEyU6xFiZnSih/Qfb2QQl75HjhIwTiK7D6s9Aj2oFgGgxvX7rMhRZ3YAYjE3WZBEOGNQ8kTdyhIyWVRYsos3ux1hFccz7IfloZmHlvJO061r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711377279; c=relaxed/simple;
	bh=FSU8nxuLRZyEBR/sJUxs+lckFjB8qs8rRlLhFigJQpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FjOBG0TGZ9Nr1mOhjsLEq4SOt7nOxUzUlw2jv2e2gshFNnfDU6LTybw5MJNO1dL6f7GYDHJxtHInCGz4WCI6bA6QNlmDixBPZmiVDk5fFpCx4/VbFLOKaBED667UY+AB/OpRlUV9Zm7wouPABO6JkQRHyoPBybeHXvrT1BSHYeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gQ4C3N0h; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e058b9e479so232505ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 07:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711377277; x=1711982077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8YEj37U1dlb1vZbCBV1T/aHB6t0dDPgqa1lum+Wmfs=;
        b=gQ4C3N0hzzoyTpZ6jmCL2FRwBVDyi/d2ksDO88M1MMOvjLg5L9mVLhnHlrZBwVRAUR
         Nxe6m7a8l59KFny6qqqfwTY0hSLD7f2SeY0nvzVl5vTfeltrgroW0KtqI2jDmkBhQwef
         XMij6colOFOzjScm3aeZORc/LdYnRXTirULC8DO7K5hMnxhvU/kZVENgtv9XMZ9dBuKU
         ibwPEKghuLALJTr9/bJL+i1nW92LQS/STp4P3v8EmPgiSfE7TMXMs1ziEtHHuB16Yp4g
         YkwRzoXYtA00VhhOlhA/UHQZzynqVln/3XY4wlfetBb/yjk5I9FumZ5TDTUfzs4tsKck
         3HIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711377277; x=1711982077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8YEj37U1dlb1vZbCBV1T/aHB6t0dDPgqa1lum+Wmfs=;
        b=SZWCn9rj5fWMegodq1dkKaRSIeOSLLLBEPNLAfA+zE14+kiDwVD3LgnfNQ/BbHqkdQ
         Ealiqb91nprXbwqHZXmcMpGcz9MXX5cZSqiLOFDly1lIg9o3c82OGjFDrmA6t6wwC+YP
         FqyFqHJn1pilP8cnltGwi4gvJpWZyA0grOofSbhhoddUBPYyc3Apzj5y/w25kNso1xLM
         FRFDN1Wa07SE8TT30YOeT81MGFGkkJZvkCeupqXYV2HnPfdQ1o6KZDYphX2V6d1R41sh
         ih34KIFbUm0UWtOVa4su552Bfb8nxwO8RkYSPN049RaXwCCcD3TJ6tY6LBgkx/ye3PY1
         3aHg==
X-Forwarded-Encrypted: i=1; AJvYcCVx7uVFs6Gc5YK4J4IFmYpHQ8G29RUXzxG1z+5PRUgrV6HDUGur9CqUVADVHOeCE0m26uh4IZ0uYriiW5qw0397fzbtasJQ//JVY79A
X-Gm-Message-State: AOJu0YzNZYJi8tm8FiEgXgcLPPZN7Qvkcpq+rto3AOOWynH5bLTNKpTW
	gwJQch42iKreZOt/vlYDe2xzBLL/POCUwvWaCQPjpwDxYyChT7EWFpvYXs342ce2OZMBlH17Ly7
	iQiHx9AIfd4Sun9XCSgSwBlv6JprHzl2CCkZF
X-Google-Smtp-Source: AGHT+IHfIEpWY+UKyTJL5tlGScYFz/Ub+0+iS/aQY1imXrFMJtf8Ch/4u/JV4rS68dYWgcSOP1FOln6Z+3nL9aj/iBQ=
X-Received: by 2002:a17:903:2284:b0:1e0:bc64:a37e with SMTP id
 b4-20020a170903228400b001e0bc64a37emr162922plh.21.1711377276556; Mon, 25 Mar
 2024 07:34:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1711352180.git.sandipan.das@amd.com> <03d7fc8fa2a28f9be732116009025bdec1b3ec97.1711352180.git.sandipan.das@amd.com>
In-Reply-To: <03d7fc8fa2a28f9be732116009025bdec1b3ec97.1711352180.git.sandipan.das@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 25 Mar 2024 07:34:23 -0700
Message-ID: <CAP-5=fVLWMnT4TV2nvbOUTTkWHYowbEOFDYqAvf1hkUEDpkKfw@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf/x86/amd/core: Update stalled-cycles-* events for
 Zen 2 and later
To: Sandipan Das <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, peterz@infradead.org, mingo@kernel.org, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, tglx@linutronix.de, bp@alien8.de, 
	eranian@google.com, ravi.bangoria@amd.com, ananth.narayan@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 12:48=E2=80=AFAM Sandipan Das <sandipan.das@amd.com=
> wrote:
>
> AMD processors based on Zen 2 and later microarchitectures do not
> support PMCx087 (instruction pipe stalls) which is used as the backing
> event for "stalled-cycles-frontend" and "stalled-cycles-backend". Use
> PMCx0A9 (cycles where micro-op queue is empty) instead to count frontend
> stalls and remove the entry for backend stalls since there is no direct
> replacement.
>
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>

This looks good to me. Should there be a Fixes tag for the sake of backport=
s?

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  arch/x86/events/amd/core.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index aec16e581f5b..afe4a809f2ed 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -250,7 +250,7 @@ static const u64 amd_perfmon_event_map[PERF_COUNT_HW_=
MAX] =3D
>  /*
>   * AMD Performance Monitor Family 17h and later:
>   */
> -static const u64 amd_f17h_perfmon_event_map[PERF_COUNT_HW_MAX] =3D
> +static const u64 amd_zen1_perfmon_event_map[PERF_COUNT_HW_MAX] =3D
>  {
>         [PERF_COUNT_HW_CPU_CYCLES]              =3D 0x0076,
>         [PERF_COUNT_HW_INSTRUCTIONS]            =3D 0x00c0,
> @@ -262,10 +262,24 @@ static const u64 amd_f17h_perfmon_event_map[PERF_CO=
UNT_HW_MAX] =3D
>         [PERF_COUNT_HW_STALLED_CYCLES_BACKEND]  =3D 0x0187,
>  };
>
> +static const u64 amd_zen2_perfmon_event_map[PERF_COUNT_HW_MAX] =3D
> +{
> +       [PERF_COUNT_HW_CPU_CYCLES]              =3D 0x0076,
> +       [PERF_COUNT_HW_INSTRUCTIONS]            =3D 0x00c0,
> +       [PERF_COUNT_HW_CACHE_REFERENCES]        =3D 0xff60,
> +       [PERF_COUNT_HW_CACHE_MISSES]            =3D 0x0964,
> +       [PERF_COUNT_HW_BRANCH_INSTRUCTIONS]     =3D 0x00c2,
> +       [PERF_COUNT_HW_BRANCH_MISSES]           =3D 0x00c3,
> +       [PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =3D 0x00a9,
> +};
> +
>  static u64 amd_pmu_event_map(int hw_event)
>  {
> -       if (boot_cpu_data.x86 >=3D 0x17)
> -               return amd_f17h_perfmon_event_map[hw_event];
> +       if (cpu_feature_enabled(X86_FEATURE_ZEN2) || boot_cpu_data.x86 >=
=3D 0x19)
> +               return amd_zen2_perfmon_event_map[hw_event];
> +
> +       if (cpu_feature_enabled(X86_FEATURE_ZEN1))
> +               return amd_zen1_perfmon_event_map[hw_event];
>
>         return amd_perfmon_event_map[hw_event];
>  }
> --
> 2.34.1
>

