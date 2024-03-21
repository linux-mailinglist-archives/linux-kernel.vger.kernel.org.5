Return-Path: <linux-kernel+bounces-109553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80588881AC2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0FA1F2190B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 01:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7346FB9;
	Thu, 21 Mar 2024 01:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="grOJyBM0"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A42883C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 01:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710985864; cv=none; b=o8JONVwDOmJNS8R4Vak3+J/2YVF0Fi0JwDri8riR509CV/CXaguKQwXOY9Vo1G0ESDSMcAjn2roTTbGD4T5xT30+oZES6rlHsAOvh1rZ7dohrISuro2hkbMwqow7YqN3DognG+9z754vhzrGnyLOiuSQmIyXNKO1f095dI4ThOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710985864; c=relaxed/simple;
	bh=5OH1HhBNQ4E7KZG0KnYehzuDvsgYQmJCQoB0QMizlpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YxQkuZuAIFdrY0Fp7jwHpi73OM+NJeD0iIhgBJJYDjr58VLjwliV4dgk8+sSu4poG/XZ3kcV6HCe+PVOJqQUHjB7avFR/6dfOfriEVCeBnz2vcazK4WsqrI7lNXsjQOhX8zldUIxgs1/W7svMBauR81w2xR5g1hFk9OQLITpsBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=grOJyBM0; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-36849db2578so42315ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 18:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710985862; x=1711590662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYU9J7zFBTCo8/TGqyh4wiUR0hjUIzHAyC/ggld+LKI=;
        b=grOJyBM0KiIt4uguVTA0aw/sb195Xlg6RRWn4eQg1KNx0anlMYM9vmai1GkBGSc2IZ
         3lObZ1LeYDDvtkjoSEXC3Mvj0HrsoA6p6wVOP8W+zcorSE1ciiD0os4ArK4QfOmIlIU8
         z1vsUrVJQYerQDSPuQDvw75+y58N0nvgu5Nh4OkcJC0cYqEG4bajjXzrudcPWMGGMDuF
         4cIEGDP9Nahs2bjwPJ2QzwPENSRndq0cHJK30pyOy5yS5Qy8Y2xFF3GcR76Ftuj+joLk
         YUzYOfy562njtbZBunR282Q0CgDSqnYfkl03OgsBk+JAS5/if3ZRMRD6MY4QpPU8+3Eg
         Ke9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710985862; x=1711590662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nYU9J7zFBTCo8/TGqyh4wiUR0hjUIzHAyC/ggld+LKI=;
        b=nKdSCGWIGq2JS7DSyAmYOZyZ5QrLuMQYmmudAjbYnNbMlX/+NxgX1f+FJiW9/BSTxH
         4bDUW646yxep4ovH0qSv+i/CrkuvG6BnkZ14pfYZCHpF93lfr8gmSmNz7JOajIcPPPJh
         eU6DCR4wmsFoScVMP8wE3M+3WAwTcipy2e/EJn+Azz27mIbDgAuu2zlAib0tZHD87lQS
         mSE9KSZIYJu5dLJYAxzBDXFEqX5dBJbH1bIWIqJfku4U5COk1XcnXRFzQfsDdZWDskp1
         kVy0SH03KgpaGjITP/aN5WaCrzb/Lb1TDKI4H8Xv7wcEq5XgPuxBsA0ibvYv8QKJH1xz
         Zs0A==
X-Forwarded-Encrypted: i=1; AJvYcCU9cR0kctJAl3b3refn5iSCfeF79j1e8VwDrTyWhvfnoUIJbOavCmZpmb1YFzZKu6gYSzdAmW1/NbUQ+hssr4A64FVeHbmLIK3YToQV
X-Gm-Message-State: AOJu0YwFa129IO7kWyiDSCcMPl4Hsp9Bu8O0QIKNI3sFxO86zCDyrhJ1
	kiqZwH8mS6DFhew7hvqp0YLjy6JyUi+t70etBBwqvhhRvD8FM/h+40uHkwNFKHkX/iFJeP1ghYS
	WlXlPrWE1TRTWus3Of94zn1guugUcMuuZjB7h
X-Google-Smtp-Source: AGHT+IG97IT+pKG4kVZObTgVLGGuIN+Q4dsZ89nyfiz3iy42xhap1df934wbnlGR1HGpgQoYRuryoyYsvKyiT4ht6k0=
X-Received: by 2002:a05:6e02:164e:b0:366:a817:61e5 with SMTP id
 v14-20020a056e02164e00b00366a81761e5mr126039ilu.26.1710985862059; Wed, 20 Mar
 2024 18:51:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320193115.811899-1-acme@kernel.org> <20240320193115.811899-6-acme@kernel.org>
In-Reply-To: <20240320193115.811899-6-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 20 Mar 2024 18:50:50 -0700
Message-ID: <CAP-5=fWw9n=b02KOvh=OuWrSx0KgUikPdnhs70DHNqNsG6mWPA@mail.gmail.com>
Subject: Re: [PATCH 5/5] perf trace: Fix 'newfstatat'/'fstatat' argument
 pretty printing
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 12:31=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> There were needless two entries, one for 'newfstatat' and another for
> 'fstatat', keep just one and pretty print its 'flags' argument using the
> fs_at_flags scnprintf that is also used by other FS syscalls such as
> 'stat', now:
>
>   root@number:~# perf trace -e newfstatat --max-events=3D5
>        0.000 ( 0.010 ms): abrt-dump-jour/1400 newfstatat(dfd: 7, filename=
: "", statbuf: 0x7fff0d127000, flag: EMPTY_PATH) =3D 0
>        0.020 ( 0.003 ms): abrt-dump-jour/1400 newfstatat(dfd: 9, filename=
: "", statbuf: 0x55752507b0e8, flag: EMPTY_PATH) =3D 0
>        0.039 ( 0.004 ms): abrt-dump-jour/1400 newfstatat(dfd: 19, filenam=
e: "", statbuf: 0x557525061378, flag: EMPTY_PATH) =3D 0
>        0.047 ( 0.003 ms): abrt-dump-jour/1400 newfstatat(dfd: 20, filenam=
e: "", statbuf: 0x5575250b8cc8, flag: EMPTY_PATH) =3D 0
>        0.053 ( 0.003 ms): abrt-dump-jour/1400 newfstatat(dfd: 22, filenam=
e: "", statbuf: 0x5575250535d8, flag: EMPTY_PATH) =3D 0
>   root@number:~#
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-trace.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index ef0dfffd99fdf3cc..d3ec244e692a415e 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -978,7 +978,6 @@ static const struct syscall_fmt syscall_fmts[] =3D {
>                    [1] =3D { .scnprintf =3D SCA_FILENAME,     /* path */ =
},
>                    [2] =3D { .scnprintf =3D SCA_FSPICK_FLAGS, /* flags */=
 }, }, },
>         { .name     =3D "fstat", .alias =3D "newfstat", },
> -       { .name     =3D "fstatat", .alias =3D "newfstatat", },
>         { .name     =3D "futex",
>           .arg =3D { [1] =3D { .scnprintf =3D SCA_FUTEX_OP, /* op */ },
>                    [5] =3D { .scnprintf =3D SCA_FUTEX_VAL3, /* val3 */ },=
 }, },
> @@ -1060,8 +1059,10 @@ static const struct syscall_fmt syscall_fmts[] =3D=
 {
>           .arg =3D { [0] =3D { .scnprintf =3D SCA_FDAT, /* dfd */ }, }, }=
,
>         { .name     =3D "nanosleep",
>           .arg =3D { [0] =3D { .scnprintf =3D SCA_TIMESPEC,  /* req */ },=
 }, },
> -       { .name     =3D "newfstatat",
> -         .arg =3D { [0] =3D { .scnprintf =3D SCA_FDAT, /* dfd */ }, }, }=
,
> +       { .name     =3D "newfstatat", .alias =3D "fstatat",
> +         .arg =3D { [0] =3D { .scnprintf =3D SCA_FDAT,         /* dirfd =
*/ },
> +                  [1] =3D { .scnprintf =3D SCA_FILENAME,     /* pathname=
 */ },
> +                  [3] =3D { .scnprintf =3D SCA_FS_AT_FLAGS, /* flags */ =
}, }, },
>         { .name     =3D "open",
>           .arg =3D { [1] =3D { .scnprintf =3D SCA_OPEN_FLAGS, /* flags */=
 }, }, },
>         { .name     =3D "open_by_handle_at",
> --
> 2.44.0
>

