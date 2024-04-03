Return-Path: <linux-kernel+bounces-130158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 565368974DB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4DDDB30699
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D0114D289;
	Wed,  3 Apr 2024 16:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CiX6esBp"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A17C14A4FC
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160133; cv=none; b=Y0dwv7lIxhkmcgbGwI0I8qP/+efT3Ewth+m6AOfbW0lGqgrvaXEJ4lINibZU0WAL+kzbN3kkxSwEIVhnqJHZJr37do5RRDGSBM3cM0Kw2sO56mkJWeigJVg2VuIb16bvRjJczXkRMdxHQxbMSkUtBDuqdYBmakuwfN/3a7QPAFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160133; c=relaxed/simple;
	bh=fggrNF/asutMtICgsplQTd2yCftvwfY2ORt4VRhq/9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXXkvAkZau5dHz4+l6lzOJC9NiZmDDg1uAg5VhIGHmkOE1C2KJcFfMU7F4joUKyw/FI7ohnBWtUhILFheane0hWeNnQANr5q6ALXaybi/gX2IjnauJWned7PfyU51EhFVNMISPZh2oDUUuSdfw7SdAo+FzjGxJ7aF3tUSjWsdnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CiX6esBp; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-430d3fcc511so349241cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 09:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712160131; x=1712764931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNJPWByWF1sf2cxiFuFQ8vnWOdBcEetEGpATM1VlKMY=;
        b=CiX6esBpThvPhW1aV6nDa/R4olmPWgwlpgy08y649c7Rlyf8W3bTQHZGMG3FX0vS80
         2CtzbAVwoP19UufoG7CoKWEtiSM5nK+YryI480c04LKYFFAFZIlZHeTC8emE80dQb59z
         1Yvzd7lFiSUXFYC7dyHK1kDKZ6alrLDvV6o9tpCN9CVNbZzj+n7J8rqa3P5pVJxj3Mse
         1OUmVBNyaGhySqOfjtIPGQhfqHoRjCgK4PD7jyIdbp8vw+NyhRD6UhqUND1UmAeUZUWX
         VHzQxSZFB7FTBl82Zb6nVk66b77eeLJX7F3apgq1X2izbYRn4lpn3K+hsZI7YUY1dmyv
         AsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712160131; x=1712764931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNJPWByWF1sf2cxiFuFQ8vnWOdBcEetEGpATM1VlKMY=;
        b=mjbYi18WdAb4yMlbgrhTLwj5mdPddPBEkAVeD35YyeWd++E4SaXjXEyhwjYz84709m
         YUglAP3RH9pjKIhV0i/UZOfSIxg2pgPtS7C6K4HmfvkSRVyGFW1VEfqe4jt9ElMB0Qb7
         TccvgyqharwD/klJ1255KG8uGXTBJbtQnezPyDWncYsSdtmkqQg41lGmZtNdsAMSQI0f
         NrIV38jaInOCzoI3mfntf7jxdieYs1FBjT7N8mh1VdC9YgRO9rve7oKDaPg0QJYU3Fgw
         P3dj+fmuFAc12DHiLI9pqy2kQM/Qdj4afhyvkvgniRl63EVkg/RI0o0H+i1yg5bfaIvC
         AsTw==
X-Forwarded-Encrypted: i=1; AJvYcCXV1CD/arMNOCIdCNHOFi2vOz+rv4mM8mCb4pZnFfBfElPnf8M/NkPyq/Cbr2EWzjE1/zoS57a2wJXJ+rgAXg8OoPsQh1WnVfYKDiyQ
X-Gm-Message-State: AOJu0YzBbLIDC1nPbIYEeU7X+eR32Iy8+Ne2BXYoQxV9/XoRbm+Kqbwi
	3LrOxr2T6Jc9ZlzfxrThQ2k0i9TMsN3607hVfoc9/idRDdrM5nDPKX1VoHpw53llnmTiba2M1WE
	IwvXERNBeA6r21E9VsGhRHNSgtodwCQ7CElVQs30AluBvq5xBuJ80EoY=
X-Google-Smtp-Source: AGHT+IENWms5jjCWU9j5a5dPOPABkTHq7MDhw3vNngKqO3lbmYYO0VFfdiD+9I6XOWjohuGAZWWLx/KeC8p1iUA4meQ=
X-Received: by 2002:a05:622a:164d:b0:431:3d25:f699 with SMTP id
 y13-20020a05622a164d00b004313d25f699mr269309qtj.19.1712160130621; Wed, 03 Apr
 2024 09:02:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zg1ywF7uRsfXYfYS@x1>
In-Reply-To: <Zg1ywF7uRsfXYfYS@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Apr 2024 09:01:56 -0700
Message-ID: <CAP-5=fUqtjxAsmdGrnkjhUTLHs-JvV10TtxyocpYDJK_+LYTiQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf annotate: Initialize 'arch' variable not to trip
 some -Werror=maybe-uninitialized
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 8:16=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> In some older distros the build is failing due to
> -Werror=3Dmaybe-uninitialized, in this case we know that this isn't the
> case because 'arch' gets initialized by evsel__get_arch(), so just init
> it to NULL to silence those cases.
>
> E.g.:
>
>     32    17.12 opensuse:15.5                 : FAIL gcc version 7.5.0 (S=
USE Linux)
>         util/annotate.c: In function 'hist_entry__get_data_type':
>     util/annotate.c:2269:15: error: 'arch' may be used uninitialized in t=
his function [-Werror=3Dmaybe-uninitialized]
>       struct arch *arch;
>                    ^~~~
>     cc1: all warnings being treated as errors
>
>       43     7.30 ubuntu:18.04-x-powerpc64el    : FAIL gcc version 7.5.0 =
(Ubuntu 7.5.0-3ubuntu1~18.04)
>     util/annotate.c: In function 'hist_entry__get_data_type':
>     util/annotate.c:2351:36: error: 'arch' may be used uninitialized in t=
his function [-Werror=3Dmaybe-uninitialized]
>        if (map__dso(ms->map)->kernel && arch__is(arch, "x86") &&
>                                         ^~~~~~~~~~~~~~~~~~~~~
>     cc1: all warnings being treated as errors
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

This looks fine but I couldn't line up the errors with code in the
tree. I was curious why the "maybe-uninitialized" was failing. Perhaps
evsel__get_arch should set the out argument to NULL when an error
occurs. This fix is also good but may potentially need repeating for
other evsel__get_arch cases, so a fix in evsel__get_arch may be
preferable.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/annotate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index b795f27f26024f35..f316e0b65897957a 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -2266,7 +2266,7 @@ struct annotated_data_type *hist_entry__get_data_ty=
pe(struct hist_entry *he)
>  {
>         struct map_symbol *ms =3D &he->ms;
>         struct evsel *evsel =3D hists_to_evsel(he->hists);
> -       struct arch *arch;
> +       struct arch *arch =3D NULL;
>         struct disasm_line *dl;
>         struct annotated_insn_loc loc;
>         struct annotated_op_loc *op_loc;
> --
> 2.44.0
>

