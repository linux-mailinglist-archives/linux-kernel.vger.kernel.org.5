Return-Path: <linux-kernel+bounces-158741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 779BA8B245A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0496A1F21BDE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C6C14A4F1;
	Thu, 25 Apr 2024 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SKQ3HHDh"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B67F14A4E0
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714056620; cv=none; b=GSS0IDjmeVxvHUnoKbyx3rJ+SOL+Vq93ZM4lCt/kCc2Xm2U4lcEpVfcnQvRAuS31zD9tAvO56LmowcNzdusGxSBZOJwwCEG56R65kv0B2AtYDwX1Mm4VW0L87/URfFS2eZedT2gZfkXz5zxQ7H61Yfl1FlVabBqGF9OM/5pvdqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714056620; c=relaxed/simple;
	bh=Ycf9a2j2RJtUdhdofXQYYbRhrCc3ymXuWyYAmriuaf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lmPMKUAEyx4f4/rD221n5U6LQLR/SV3ABjpv2cjVYUGtUxkA6sKfkmJPptzUagV1VTcM9DwsfDwhqgI7qXWpiYs86XMpgt0XOnCPQuI/kdxA6iJkZU58GCDgrv4tq7yHvm8UrcmzUbgXQpy6pj7n1r98pgBidertW4hiNlA5xvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SKQ3HHDh; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-36b3738f01cso133995ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 07:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714056618; x=1714661418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2s/tnVUk7RhbjTUQ58lGklT1XmTBfjSiMBuxZZqOek=;
        b=SKQ3HHDhXgXx/cOsc8X5IV9OnKEaftdAsl2Em2tjq7lRhM75s7DGK4vT2MmVlUPXzq
         y1+sif2QKUTZWRor9CN8N0rTyki9XuJSVa//5zvEWSVE/gnfP/KQRFIyt6isM6+h5P0V
         6KzJDw9LkXLhApS/yyqR1MYXJIobbOiNBnOcgVwhqd/yuyA8njieP1cgWs0J3C9ysO79
         jLffgQvhA4elpWZpfTn7c+E24aKndshHHzcL565QAez6Du/qhfzNjnF1w/ZtSas1Y/yh
         7C+jEy+3e9bsXnbDBMXaaeKv0nHVIAiFVAKVsj6GNQz9DIYd1XSabl7kzkG5tyKHrrSg
         ccsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714056618; x=1714661418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2s/tnVUk7RhbjTUQ58lGklT1XmTBfjSiMBuxZZqOek=;
        b=dbR1b9ID1tYmPZJkUzeK6WoUZYB3bJu+A6aUED6HrZn12hcSlP1eqfwfF+SB5L5Mv7
         rOu+Xump52PmBvJMhvG7PFqBjWPC3WdoqOzC6ECk636oHhPT0xXxZYRDV+T8QMC4QwbI
         +/zd2GO2GYn0YYKsS3XnD9X+hdSG6R+q+TRRuBS5U5Q/PdP3J9o0x9WKKe+VxTpZUHep
         VUqwXjz/+aprYpxsippF3TYaNSXbETnp0mleZAnz4Y8cf32q0B6L3Lp1GGR7y9NuHUAT
         X6milrApw3+fqj4beHqz1au0gJvUSRDTuYW/sILRu/YykYdKeaHPT5l+ixzJr05nqqAe
         cURg==
X-Forwarded-Encrypted: i=1; AJvYcCViZjTNM8McZ3Rji0KKdxxeE6QX89xHlbO/0zzfogkDeDeu0qRVbsqbBaArwybHFEmN4yIILUqOnpDmx9rdhOuGVohH9yUvnalhtWYB
X-Gm-Message-State: AOJu0YwWL/jLQu6pbxJ/0I87aDX6qlKfkVrKWiyIk5/tGrOV28pEViN2
	VwHXHo1Bjmc0Izqgzsv6D8JkzncpDSi8RHHJvDWZJofyxjX/r5qZzMpMOkdvfEsYINZlEVmq7w3
	/OR43PP5UFki2fFRbop1sRu9+/6PHye/T4djb
X-Google-Smtp-Source: AGHT+IESDwd5zTDdz3/OORzEa4baR+AKJ83B5+ExBjdkF7TvDtkTAUrbIq+YmuQhoPaCa2kRSfxH2ljrrvc3VfKKgkA=
X-Received: by 2002:a92:da4a:0:b0:36b:f9c1:7ae3 with SMTP id
 p10-20020a92da4a000000b0036bf9c17ae3mr188764ilq.19.1714056617895; Thu, 25 Apr
 2024 07:50:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425005157.1104789-1-namhyung@kernel.org> <20240425005157.1104789-2-namhyung@kernel.org>
 <Zipk0p08bxO7werD@x1>
In-Reply-To: <Zipk0p08bxO7werD@x1>
From: Ian Rogers <irogers@google.com>
Date: Thu, 25 Apr 2024 07:50:03 -0700
Message-ID: <CAP-5=fXbJsdioDLjKMM3d=WJ_VGLtfygL8f6G+bfpDmK7_CPeQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf annotate: Update dso binary type when try build-id
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 7:12=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Apr 24, 2024 at 05:51:57PM -0700, Namhyung Kim wrote:
> > dso__disassemble_filename() tries to get the filename for objdump (or
> > capstone) using build-id.  But I found sometimes it didn't disassemble
> > some functions.  It turned out that those functions belong to a dso
> > which has no binary type set.  It seems it sets the binary type for som=
e
> > special files only - like kernel (kallsyms or kcore) or BPF images.  An=
d
> > there's a logic to skip dso with DSO_BINARY_TYPE__NOT_FOUND.
> >
> > As it's checked the build-id cache linke, it should set the binary type
> > as DSO_BINARY_TYPE__BUILD_ID_CACHE.
> >
> > Fixes: 873a83731f1c ("perf annotate: Skip DSOs not found")
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/disasm.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> > index 412101f2cf2a..6d1125e687b7 100644
> > --- a/tools/perf/util/disasm.c
> > +++ b/tools/perf/util/disasm.c
> > @@ -1156,6 +1156,8 @@ static int dso__disassemble_filename(struct dso *=
dso, char *filename, size_t fil
> >                       }
> >               }
> >               mutex_unlock(&dso->lock);
> > +     } else if (dso->binary_type =3D=3D DSO_BINARY_TYPE__NOT_FOUND) {
> > +             dso->binary_type =3D DSO_BINARY_TYPE__BUILD_ID_CACHE;
> >       }
> >
> >       free(build_id_path);
>
> Fixed up to take into account a recent patch by Ian that turned that
> &dso->lock into dso__lock(dso):
>
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index 70650808e2e7bf88..2921b32357705a02 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -1156,6 +1156,8 @@ static int dso__disassemble_filename(struct dso *ds=
o, char *filename, size_t fil
>                         }
>                 }
>                 mutex_unlock(dso__lock(dso));
> +       } else if (dso->binary_type =3D=3D DSO_BINARY_TYPE__NOT_FOUND) {

With reference count checking on dsos, this will need to be:

dso__binary_type(dso)

too.

Thanks,
Ian

> +               dso->binary_type =3D DSO_BINARY_TYPE__BUILD_ID_CACHE;
>         }
>
>         free(build_id_path);

