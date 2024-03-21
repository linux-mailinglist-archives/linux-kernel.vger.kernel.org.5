Return-Path: <linux-kernel+bounces-109551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67068881ABF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DF3A28301F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 01:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C547494;
	Thu, 21 Mar 2024 01:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ScjHQM8l"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6877470
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 01:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710985841; cv=none; b=vBU6x+kHhyUx88rX1gLOUdExRL0pXtwsUpSkNl+OXtudA2uyy2+6f+yB3BUzJS+ALGk0x2B3ofToXrrmsH5wXygbb8kNPWrm1DWJKVgv4inZ0ashUUbmYwZ5Vr/hscPrlBBY5OnwKj+cnoUnTGurn/uhSZJUrAj1CRwUbueytVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710985841; c=relaxed/simple;
	bh=R7zrijesuvQqmNNwfNJ1OzbmHqLbGTLOtVIZOBj5Gfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nLfno88Zb06ARzffvwGDuIoy3N0ZTH0UWMmxL/B5sjFOZi/RQniCHz+vDacv1oYaD4fuRXaJEyFjBoWsyHjVWLnGoX/E53oSut9Q66jEo08/Ab7xSFrYSoUJ8TCf5ksLQu0pguo6tQSv6Or0r5v7jvClXJ8/ZHgBZCGpUPsZK1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ScjHQM8l; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e058b9e479so88935ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 18:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710985839; x=1711590639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mc+skKU4QeCkSwTpMdOslAlbmrHBOUhgUxYcHE46Yps=;
        b=ScjHQM8lyKUaWh055DRHoKyD90T0MkdPGeAwNkpwRIb8lNze3SXdfOK7lyWipZ5Ahx
         WDQ6bE9EXjaPzCcAz+iDAUUSggBA7LwzGo04QvMEXVRXnqS4ufJ1+GFANgRqPBiEDVhy
         Vf107gT3BoQ7Sg9HuoVbE84RmnT+Sa+RKxbpMKgQihU94R/Sz3MmVll5bXpcM3Vi9lUQ
         tCs2VMUf7LfKYbej4KW6xFET3bwqyIVaTEjJr21Oeb+UuMNrpylthS5BJAYvwRE+yWMA
         Rh4gKUmuZx9m5eh6C0UjSJ+coQ6EvJMy8ZxT2DvzGZNFlucHSvTwhSx86q+SHRFhtBRY
         /hUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710985839; x=1711590639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mc+skKU4QeCkSwTpMdOslAlbmrHBOUhgUxYcHE46Yps=;
        b=mBLzpkVJ2UhUJEucsUUMLNZK/L/hqBDDkVaHlVv2b9RkpRTW4DdxjrbyjcL4CFOXmT
         k1XBqif5ZspZo+c/5Rb++/kwf7mJkBQ9IJAIhos+MD7riYbYzePT2mvrgnx6i+gE6fT1
         D/k93/tjL4igI4lkpuG7v5vZxO5f2fH7a0/miw1BDmurngCDWRwTw12hH6F1jgp/wWUl
         HwhceAKg0Rg0yo7qSLYApYd6XdYJH1wB/A924H3NaE6JB0sOtgWKnwnYYBMFxiEf63+n
         wV3gMNo3riexqnPyMwBY480q7hibTZP7RZK4j4TAwQSP1CpdwfckVdyWKZCFlHZiuz/8
         f26g==
X-Forwarded-Encrypted: i=1; AJvYcCU9vPIbpzHkn7/6/lnHe/zzOqKpgWcbRncw/zzh9wz0BvqhWiJ6DoEvT53ILu8L9xZr5BEHCtnpEVUqBm6+CxiIZU2R1V5xN95m8kMu
X-Gm-Message-State: AOJu0YwLQXjU/FHMwq0YEjk09/eqYXi5tg6K+nl21crmoZ6g/U5/kehl
	mw2X0ELrwQZ3K3VhrNpgC4DYMq+H+ppu+uHoPc+H7jtcPCUrhKVUw+J1jKbJ734GKGtJrFBovA2
	1REKTWhHDjnI5G48T4lbdPuj1+/khiK/dRb/1
X-Google-Smtp-Source: AGHT+IEsoCQPqVzJEWJkUcjD/b+B37rNwRY73AmQVN2jEMdyV1hGWH6jIVGKzGtm6hPF7a4AdUxbzQStyWbvN1VfYPs=
X-Received: by 2002:a17:903:2282:b0:1dd:6e0b:75fb with SMTP id
 b2-20020a170903228200b001dd6e0b75fbmr74752plh.9.1710985838761; Wed, 20 Mar
 2024 18:50:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320193115.811899-1-acme@kernel.org> <20240320193115.811899-5-acme@kernel.org>
In-Reply-To: <20240320193115.811899-5-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 20 Mar 2024 18:50:27 -0700
Message-ID: <CAP-5=fVmB=E-MMyhA2WBQV8OLcPH20tw+11XjCeecMU6hce5jQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] perf trace: Beautify the 'flags' arg of unlinkat
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
> Reusing the fs_at_flags array done for the 'stat' syscall.
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
>  tools/perf/builtin-trace.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 58546e8af9fcf481..ef0dfffd99fdf3cc 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -1171,7 +1171,9 @@ static const struct syscall_fmt syscall_fmts[] =3D =
{
>           .arg =3D { [0] =3D { .scnprintf =3D SCA_FILENAME, /* name */ },=
 }, },
>         { .name     =3D "uname", .alias =3D "newuname", },
>         { .name     =3D "unlinkat",
> -         .arg =3D { [0] =3D { .scnprintf =3D SCA_FDAT, /* dfd */ }, }, }=
,
> +         .arg =3D { [0] =3D { .scnprintf =3D SCA_FDAT,         /* dfd */=
 },
> +                  [1] =3D { .scnprintf =3D SCA_FILENAME,     /* pathname=
 */ },
> +                  [2] =3D { .scnprintf =3D SCA_FS_AT_FLAGS,  /* flags */=
 }, }, },
>         { .name     =3D "utimensat",
>           .arg =3D { [0] =3D { .scnprintf =3D SCA_FDAT, /* dirfd */ }, },=
 },
>         { .name     =3D "wait4",      .errpid =3D true,
> --
> 2.44.0
>

