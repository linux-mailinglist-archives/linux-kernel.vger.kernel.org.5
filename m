Return-Path: <linux-kernel+bounces-108111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 448DD880616
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA1131F23318
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DE73CF63;
	Tue, 19 Mar 2024 20:33:44 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140803BBE4;
	Tue, 19 Mar 2024 20:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710880424; cv=none; b=aK43qi8gNQO/vwjKrSK3jMCBa6VBJ5cThhyf4T/50pyIlv/bec2bfqqQMtITasQSU8/5iEY7uZLrD0TneTt2o26ngcYXlt3eLe/KLmMiTkfjLb/I1wTWy4xl5+Rdrb79/O9ezd6Fk+J9KpQRBkNZdvDOW+gxTs69FlOpAaWCW00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710880424; c=relaxed/simple;
	bh=GHaaS61cuVehUyYWTQtvnFxq0VduXiSyyoD5R9DTXo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CuN+mRyMNTxrLOzQzeuXOTwvKCwzhrwy7hcybO1qfDYNm8AQ+lqpvXLu7Dy5rHjVJWlspt4Po3aWH/T+rmOzJ/k0yuwboYehaT/XVXCjSqq0e3xyYZ20eu0rQ7S6uMm5sLAFyesCpZ64xapRY0IfN59tHaL9E5XYoxrW2Xeoch8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-29ddfd859eeso4656813a91.1;
        Tue, 19 Mar 2024 13:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710880422; x=1711485222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tx6RY806OKUkk/RbkaOThSt7wlPButo1QiQRhyQO+XA=;
        b=gQlYAJTHTNCsdq6FopGXDdmjA5GWHSBmhP+cZzuXiVShUgObLzWMguwcKEwr9AsrBy
         5vs3gMAIlfzZC+cM5Yh1clO/iN7DHk701X953ZfZnWDrG8yUfd7L+91r+fK5d166GNsy
         Zp+Up4govbFyrT27G998QS0ZYTLmdq9lw/UW1cfv5Dr0Tc2xTTSqZZkhlZ9OT2QaH/yX
         KmeN9EElLnkmLvpP2/AF+b4JZ/uLBZtx7GCWnCiYy5H7lXGnrA1G11vLQw3BuS4cI4QG
         ZBXg04uLAf14wce1JCaF5ZUJQsCt7jPsnIpqDLs1qJZJ8VcgFALQ+q+RKVvqag0TeZMZ
         ZMXA==
X-Forwarded-Encrypted: i=1; AJvYcCUunxl1KiidjnDYeFH2fKOQDu/nuEZAq14ZmN5fFvmrCai01yK1NQ+nlsYGxOu6YpjK1AyKWlnA5wLUEA6vrMcquXsl1mm0/73/MRjnFuyL2fn5eHSHzqQ+SLJAFWRg/T+qAH4UNjXt/x3KkqDYRuSGkUGsDSG0o8s66K/1LmxeveJjVLHn8qQxBDtOAO5aMB5+Ar5+G0GqH5twb0cBIi+7JFvPEkngYn62zF5HH4h5lGjIiQ==
X-Gm-Message-State: AOJu0YzJ1aPRe1s+GJhzTX+ZZH3ztn4KqSl9rcSCXUFBB1N+9VToV3gK
	Q35Frty85SAv3CA/o3m3DNtrfqanZ6bhx+UGCtNX4SJST8CsONhqciAiI3L7+gWiP8X2XOHQC12
	MZzBqsPfb8XT7w066JSOSKLZyv6g=
X-Google-Smtp-Source: AGHT+IFZhCGELlaSzU4uTOt9n5b4RLP3nt8ivW6uGBkKRspAz69J0MLJmZG/MjK5g7Rf/EQPAYBz4JeKq9HAeK1WDxM=
X-Received: by 2002:a17:90a:f007:b0:29c:7690:2724 with SMTP id
 bt7-20020a17090af00700b0029c76902724mr306149pjb.16.1710880422133; Tue, 19 Mar
 2024 13:33:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319055115.4063940-1-namhyung@kernel.org> <20240319055115.4063940-5-namhyung@kernel.org>
 <ZfmZobDmVFxEQ6hU@x1> <CAM9d7chdEcA7qFS3k=DGfeXcdZP1xWvdory_-Q0WFPfGi0St_Q@mail.gmail.com>
 <ZfnXIm2rRnzVcZ4n@x1>
In-Reply-To: <ZfnXIm2rRnzVcZ4n@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 19 Mar 2024 13:33:31 -0700
Message-ID: <CAM9d7ciNeiDBmz_ip_mTAyMf3Vzi6tbCdCRQdJ3==xKMKGJ2jQ@mail.gmail.com>
Subject: Re: [PATCH 04/23] perf dwarf-aux: Add die_find_func_rettype()
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Stephane Eranian <eranian@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-toolchains@vger.kernel.org, 
	linux-trace-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 11:19=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Mar 19, 2024 at 10:42:00AM -0700, Namhyung Kim wrote:
> > On Tue, Mar 19, 2024 at 6:56=E2=80=AFAM Arnaldo Carvalho de Melo
> > > > +             return NULL;
> > > > +
> > > > +     if (die_get_real_type(&tmp_die, die_mem) =3D=3D NULL)
> > > > +             return NULL;
> > >
> > >
> > > Here you check die_get_real_type() return, may I go and do the same f=
or
> > > the previous patch to address my review comment?
> >
> > Sure thing! :)
>
> Ack?

Yep, looks good!

Thanks,
Namhyung

>
> - Arnaldo
>
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index cd9364d296b6bf42..09fd6f1f0ed8eac3 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -1856,7 +1856,10 @@ static int __die_find_member_offset_cb(Dwarf_Die *=
die_mem, void *arg)
>         if (offset =3D=3D loc)
>                 return DIE_FIND_CB_END;
>
> -       die_get_real_type(die_mem, &type_die);
> +       if (die_get_real_type(die_mem, &type_die) =3D=3D NULL) {
> +               // TODO: add a pr_debug_dtp() later for this unlikely fai=
lure
> +               return DIE_FIND_CB_SIBLING;
> +       }
>
>         if (dwarf_aggregate_size(&type_die, &size) < 0)
>                 size =3D 0;

