Return-Path: <linux-kernel+bounces-66169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BF985580C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 487811C210F6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCBF145B37;
	Wed, 14 Feb 2024 23:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TlZH3qPC"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F44145339
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 23:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707955058; cv=none; b=rJTdwy0TwGQooiLdTno4M6ve1GYe4Oy6+sqzZjZHqIKh8Dp4ng2ouoj55ujrPlYIvSO8/tGlETFM11ymJ7DQnEuW4rmG6yCKfgKKY0lLSetKGROI6tbdirKTvXiA1XkhfKuFHeofv7Lz+fSfRqhOkfsyE8+W0GAX7lqmb3LmWDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707955058; c=relaxed/simple;
	bh=8vPNE4CvmZCjziYpHcM1v12cyFLhM99eJn8J6lClXuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YX8p7+y4GuElY4YQAvfnDkWL9w4Ei0fuvwwdVa3A3t5/dmZi2wMQFpdS8H+qqWLjNxYgjhmB50XpK24NRz6rBi65k+YWDH+G5S1UsgLQtSStGlhXVC27xLYZ0hHeC2vqMv/cjdaLV+B+UVFM1S2ojK/Cf9VKPogpd9RgQFmTCIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TlZH3qPC; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d5ce88b51cso50125ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 15:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707955056; x=1708559856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIBxaHWarN7o+HmBexnudXdpGfzk7rHChsQ05quL728=;
        b=TlZH3qPCZFPfQjhote24ik2btsOTl1P2vZHmsdz/bUbuZr4SpHmsoilPI5fedhJf5Y
         uv59eAmy7SWE8hC6LMuXqgUHkdl22gS9y8vxZO1idamG36MgFr0u/YFz6bY5P0SwMDrl
         8B0Td7aV1JzMlrTV/dYjHdixY83gXhzhsLPBJqbDan4H/EZmhN2aXikd+X7avOhWesRt
         MAMPzsOo6wDjxm8HrnmrgkrpccD8H9MAMhySKfQ8JBjsPElEPVXAS/XxPIag2+IgO5zs
         oLIEO5r3k/jKoJVC+o1BAKHuLMoK98hrje5mV8izzzvylve2z0cu0vkIM7IQB8pTI/2m
         87yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707955056; x=1708559856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIBxaHWarN7o+HmBexnudXdpGfzk7rHChsQ05quL728=;
        b=LxvfZRweFrqppWgZZXRsxDdPrndl/Q9Tg2JJSgn9hdGmWPCdUy8fEMpdYdigSWSUtS
         3MVb3plU+HgcLo+EFFXpR3uGa4POY68pCNl3JEoghH5/gudKiySQ6UZPhthrdqDfLmgF
         hkEtwFsQQcC8+v3F3Lz5+6TYOy93uxuJhWwE1mD2/Pfwm7GJcGlvLWW9xtfxvVWmrswX
         6HopiyvRnECYwHII6DMI6r0N0gmvq8MkQfkg7kVjfo9VtrJY6ujm9GKonwco8kn2vAC5
         czEmri6XkinEZWuF+FfThoyk/qcxoh15nfDMwjrxpPDMWWo1yaDoT6vZ3gQ93e3n0qtI
         NvQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEGWwf+Q2Hr0kcISwJkekmXC1hsQPJnGb9YOJk4eFlKL+B8t+MtnIW1hoVGIkiwSZRkSFvNfC2jL0yjX29lyTQxiui4jPTWYPy4+d6
X-Gm-Message-State: AOJu0YzfCMuj8YG3Je3nr/4dPq/rnHjmcNkw13JqGmMWhsTt5MB+UjW/
	0U1p5foDoO2zRLm0mQdbXydBCpIM+YRGr0D7Nf4nAFnMZ++9cyTQziRDUVEvShVIi/cCrweZivg
	XJs2/XJGyzeT795lxGW6iZX+N2k3AS/FaT5lj
X-Google-Smtp-Source: AGHT+IFK6j6KIJNThyA/TwBKcdh2EobBpSmFy7M1sgQSgIfBkmDgs8oqmgVsKTfsyfH78edSFJfjw+Vk/88oD9Thn4g=
X-Received: by 2002:a17:902:c385:b0:1db:7284:a766 with SMTP id
 g5-20020a170902c38500b001db7284a766mr141128plg.0.1707955055615; Wed, 14 Feb
 2024 15:57:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213075256.1983638-1-namhyung@kernel.org> <20240213075256.1983638-3-namhyung@kernel.org>
In-Reply-To: <20240213075256.1983638-3-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 14 Feb 2024 15:57:24 -0800
Message-ID: <CAP-5=fWnVFabJ8MqsnAQAC5Bbk9AQmcnTCWJNrd3RGk8Ucoe-w@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf hist: Simplify hist printing logic for group events
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 11:53=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> It can uses an array to save the period (or percent) values for member
> events and print them together in a loop.  This simplify the logic to
> handle missing samples in members with zero values.
>
> No functional change intended.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/ui/hist.c | 55 +++++++++++++++++---------------------------
>  1 file changed, 21 insertions(+), 34 deletions(-)
>
> diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
> index 2bf959d08354..5f4c110d840f 100644
> --- a/tools/perf/ui/hist.c
> +++ b/tools/perf/ui/hist.c
> @@ -33,6 +33,7 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hist=
_entry *he,
>         char *buf =3D hpp->buf;
>         size_t size =3D hpp->size;
>
> +       /* print stand-alone or group leader events separately */
>         if (fmt_percent) {
>                 double percent =3D 0.0;
>                 u64 total =3D hists__total_period(hists);
> @@ -45,12 +46,19 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hi=
st_entry *he,
>                 ret =3D hpp__call_print_fn(hpp, print_fn, fmt, len, get_f=
ield(he));
>
>         if (evsel__is_group_event(evsel)) {
> -               int prev_idx, idx_delta;
> +               int idx;
>                 struct hist_entry *pair;
>                 int nr_members =3D evsel->core.nr_members;
> +               union {
> +                       u64 period;
> +                       double percent;
> +               } *val;
>
> -               prev_idx =3D evsel__group_idx(evsel);
> +               val =3D calloc(nr_members, sizeof(*val));
> +               if (val =3D=3D NULL)
> +                       return 0;

Looks good, but should this return value be negative to indicate an
error? Snprintf gives a negative result on error, its result is
sometimes returned from hpp__fmt_acc, as is this result.

Thanks,
Ian

>
> +               /* collect values in the group members */
>                 list_for_each_entry(pair, &he->pairs.head, pairs.node) {
>                         u64 period =3D get_field(pair);
>                         u64 total =3D hists__total_period(pair->hists);
> @@ -59,47 +67,26 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hi=
st_entry *he,
>                                 continue;
>
>                         evsel =3D hists_to_evsel(pair->hists);
> -                       idx_delta =3D evsel__group_idx(evsel) - prev_idx =
- 1;
> -
> -                       while (idx_delta--) {
> -                               /*
> -                                * zero-fill group members in the middle =
which
> -                                * have no sample
> -                                */
> -                               if (fmt_percent) {
> -                                       ret +=3D hpp__call_print_fn(hpp, =
print_fn,
> -                                                                 fmt, le=
n, 0.0);
> -                               } else {
> -                                       ret +=3D hpp__call_print_fn(hpp, =
print_fn,
> -                                                                 fmt, le=
n, 0ULL);
> -                               }
> -                       }
> -
> -                       if (fmt_percent) {
> -                               ret +=3D hpp__call_print_fn(hpp, print_fn=
, fmt, len,
> -                                                         100.0 * period =
/ total);
> -                       } else {
> -                               ret +=3D hpp__call_print_fn(hpp, print_fn=
, fmt,
> -                                                         len, period);
> -                       }
> +                       idx =3D evsel__group_idx(evsel);
>
> -                       prev_idx =3D evsel__group_idx(evsel);
> +                       if (fmt_percent)
> +                               val[idx].percent =3D 100.0 * period / tot=
al;
> +                       else
> +                               val[idx].period =3D period;
>                 }
>
> -               idx_delta =3D nr_members - prev_idx - 1;
> -
> -               while (idx_delta--) {
> -                       /*
> -                        * zero-fill group members at last which have no =
sample
> -                        */
> +               /* idx starts from 1 to skip the leader event */
> +               for (idx =3D 1; idx < nr_members; idx++) {
>                         if (fmt_percent) {
>                                 ret +=3D hpp__call_print_fn(hpp, print_fn=
,
> -                                                         fmt, len, 0.0);
> +                                                         fmt, len, val[i=
dx].percent);
>                         } else {
>                                 ret +=3D hpp__call_print_fn(hpp, print_fn=
,
> -                                                         fmt, len, 0ULL)=
;
> +                                                         fmt, len, val[i=
dx].period);
>                         }
>                 }
> +
> +               free(val);
>         }
>
>         /*
> --
> 2.43.0.687.g38aa6559b0-goog
>

