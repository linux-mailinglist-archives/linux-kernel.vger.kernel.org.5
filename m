Return-Path: <linux-kernel+bounces-66177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC26785582B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C8C21F22F50
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CC31866;
	Thu, 15 Feb 2024 00:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qxWdQe4a"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF52F19A
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 00:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707955706; cv=none; b=GzRGqj9LJI0BzkshvMpdCkqzIZSjAMA2GinglqvXC1vHheEopIBaPB3aICRfbqT39pHZ1B5+KzjaWyQlX4vCNO+NRb2KrKfKMXRju1MSNKHN0A6lYrQnO/6ykmVPx2IrkjKmzLRc4VtUcbblYByy1zQSIRn+gZQyNID1mfIBM+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707955706; c=relaxed/simple;
	bh=eRVr7WNQeECFAwC9LL6F7iVBaxb9s3Hq0tVpyIkyaTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R0TlSYlbBjzt9cnosvrun8X3CTQpCwABVCahlpsIvBTBir657YoirZuwUdAL+D1m2qiyDIVVWQ5Kmy8/BQ03kJPnoGbH1qOAF9r6H5EamZVO68DUi2lnu1WNmSa45tcc9mnuDOtDIIrNo9XPCx5zjws/s2Ku8YbwEZ7KPmWbvCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qxWdQe4a; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1db35934648so34485ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 16:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707955704; x=1708560504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYW5x9I6IoVVyZN2S5QMODnYnRF6g1ixxb2U6BARuiA=;
        b=qxWdQe4a3p/nqAb1IJVCef5AYMFjJ1IZOdMRn2MJpzR3AZjgFf6CoX2V5vL7lVmFJa
         +MqsYyMdSO3E2C79bDse8XIe9qJQn5j4IqOegaUQ8FEpeP06sXfaL5GimRPElU7fqI6+
         xrrhtackXZ+tqi3d3+621cDh/zmGGW/zcNWD+DymUPKLZSjqZq9dA4APZH8oTFupYWlp
         fXMrgE7X2q9UOjzsqgZ5J4sPi0TpWSXw3XXZmH7uJ1mAgkTYz+gk8y6QjJAEk4rSLe/0
         nzKj6d8RtTGbj9mUNbiAz+CH1bs9KL8OOwTgcBT9LtA4pstF3km68/gsXAvdtq22m0vs
         IJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707955704; x=1708560504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jYW5x9I6IoVVyZN2S5QMODnYnRF6g1ixxb2U6BARuiA=;
        b=D0Q/BxnxEgvm9YWOg8lFAd8qIqsrja9wOYPFnZ+JMHztuVHXodmzHm8FmucCe3wO3u
         WhEkAT5Iv0qJAcmTT8zo3BNiuWuh8Q8ISTK30l5m9yY2aH34/yNLFNoX7UdndcjFiw5Z
         f4pIWXJteGWN16BRlXQvOjiwhCstuNcWCd7CfP+M2TNewMr0GNvxuWzFJputa3vQK2MP
         vrSkl8Vdy/TWZR24HrZMx/+++vDGiNzZaagrfmdmx2aZZ1H6PDELnFZMp1OqLQ0HV74R
         07lRWPYlgft8zjiHEzU7Ujb5YKbqZLu5qHOQTq+OlgFaV0Mni6v0FAuiJEa5E2L8ca5A
         cPrw==
X-Forwarded-Encrypted: i=1; AJvYcCUx4YHJs0hl/aQM/zVrRlOOzM2rDaUDa8yn7QtzUDF3aIq3E8lpTo2Q4tCBzohTw2oC876525xN93BonOdVAoz0lO9OLNo+r5zKOgZF
X-Gm-Message-State: AOJu0YySzRyn4TZXnise3hbofR+7jlqNU0oGRGWDGqFd4rEf6UCN4R/N
	HH50G3bI1hQyZpZBbMVkKPyzu/wCxYpfJR6xFnab5jfcois/7wIMXcY93sWzMGOqgDkVVSAi+Yg
	e64YIfZJiCpNcw/wEKW8qxr5RbsNI1H9c9BOT
X-Google-Smtp-Source: AGHT+IEguMJk6sVsnBx1nzumoGp0cmby0evnp5vCG0b+ofR/u37oNJCgx+vCXf0v0YB9+dVM8Ux7XVoUQ9O1oe8UbCY=
X-Received: by 2002:a17:903:22d1:b0:1d8:e076:21f3 with SMTP id
 y17-20020a17090322d100b001d8e07621f3mr434878plg.2.1707955703980; Wed, 14 Feb
 2024 16:08:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213075256.1983638-1-namhyung@kernel.org> <20240213075256.1983638-4-namhyung@kernel.org>
In-Reply-To: <20240213075256.1983638-4-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 14 Feb 2024 16:08:10 -0800
Message-ID: <CAP-5=fVK3vvNoaGHPep8NCweGw9cztKBGQh5+0bVX91PhWp5Eg@mail.gmail.com>
Subject: Re: [PATCH 3/4] perf hist: Do not use event index in hpp__fmt()
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 11:52=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> The __hpp__fmt() is to print period values in a hist entry.  It handles
> event groups using linked pair entries.  Until now, it used event index
> to print values of group members.  But we want to make it more robust
> and support groups even if some members in the group were removed.

I'm unclear how it breaks currently. The evsel idx is set the evlist
nr_entries on creation and not updated by a remove. A remove may
change a groups leader, should the remove also make the next entry's
index idx that of the previous group leader?

> Let's use an index table from evsel to value array so that we can skip
> dummy events in the output later.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/ui/hist.c | 34 ++++++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
> index 5f4c110d840f..9c4c738edde1 100644
> --- a/tools/perf/ui/hist.c
> +++ b/tools/perf/ui/hist.c
> @@ -48,15 +48,30 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hi=
st_entry *he,
>         if (evsel__is_group_event(evsel)) {
>                 int idx;
>                 struct hist_entry *pair;
> -               int nr_members =3D evsel->core.nr_members;
> +               int nr_members =3D evsel->core.nr_members - 1;

A comment on the -1 would be useful.

Thanks,
Ian


>                 union {
>                         u64 period;
>                         double percent;
>                 } *val;
> +               struct evsel *member;
> +               struct evsel **idx_table;
>
>                 val =3D calloc(nr_members, sizeof(*val));
>                 if (val =3D=3D NULL)
> -                       return 0;
> +                       goto out;
> +
> +               idx_table =3D calloc(nr_members, sizeof(*idx_table));
> +               if (idx_table =3D=3D NULL)
> +                       goto out;
> +
> +               /*
> +                * Build an index table for each evsel to the val array.
> +                * It cannot use evsel->core.idx because removed events m=
ight
> +                * create a hole so the index is not consecutive anymore.
> +                */
> +               idx =3D 0;
> +               for_each_group_member(member, evsel)
> +                       idx_table[idx++] =3D member;
>
>                 /* collect values in the group members */
>                 list_for_each_entry(pair, &he->pairs.head, pairs.node) {
> @@ -66,8 +81,15 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct his=
t_entry *he,
>                         if (!total)
>                                 continue;
>
> -                       evsel =3D hists_to_evsel(pair->hists);
> -                       idx =3D evsel__group_idx(evsel);
> +                       member =3D hists_to_evsel(pair->hists);
> +                       for (idx =3D 0; idx < nr_members; idx++) {
> +                               if (idx_table[idx] =3D=3D member)
> +                                       break;
> +                       }
> +
> +                       /* this should not happen */
> +                       if (idx =3D=3D nr_members)
> +                               continue;
>
>                         if (fmt_percent)
>                                 val[idx].percent =3D 100.0 * period / tot=
al;
> @@ -75,8 +97,7 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hist=
_entry *he,
>                                 val[idx].period =3D period;
>                 }
>
> -               /* idx starts from 1 to skip the leader event */
> -               for (idx =3D 1; idx < nr_members; idx++) {
> +               for (idx =3D 0; idx < nr_members; idx++) {
>                         if (fmt_percent) {
>                                 ret +=3D hpp__call_print_fn(hpp, print_fn=
,
>                                                           fmt, len, val[i=
dx].percent);
> @@ -89,6 +110,7 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct his=
t_entry *he,
>                 free(val);
>         }
>
> +out:
>         /*
>          * Restore original buf and size as it's where caller expects
>          * the result will be saved.
> --
> 2.43.0.687.g38aa6559b0-goog
>

