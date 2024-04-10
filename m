Return-Path: <linux-kernel+bounces-139248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EB08A0065
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FC102854A2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1EC181303;
	Wed, 10 Apr 2024 19:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J8R0v2V6"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB85617F370
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 19:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712776493; cv=none; b=fGEg+FQVbvu2m9LZ10+XUDeL0RTm1RSjgN2eks6q7xka8X9XjIaTfS+kHyFqROAFMyWJ/Grw3IONyCPrALmAc24UNU1ykrdCFvLnutLVzI563uCAO2HRuzsmXeGNTKlgzjDG0dKjV7XA5mhG67hefE2OWacTb87eKCkA2eCFb5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712776493; c=relaxed/simple;
	bh=1svL0E74yAjpQMbTutyztcwNrRVSEN5XvfFbGICi+Zg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gG7juhx5ndQNK3l9McniCkRlo9p6LWQ34LbXtphXoRvvgdEHMk8rtzTCzoibLm+oJaIO4FUPsyEENAlEF3aQh9Sph+Pn/eQptB5WmGn59dwhDsuG44i+jZBeUMRQYZuHY0uZjgTYsLym3kTL1IFydFpTKl75HCA8VXas0OstjGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J8R0v2V6; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-43477091797so56331cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 12:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712776491; x=1713381291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnSzzFgP2liAY4gSnshhFACs6sQ4XACv2JFHDRUpzPA=;
        b=J8R0v2V6gHZEtzvofZ/erUeB0bClsvAtgKVPe9YXzsfRluAJkhffpF4lRmT6yXdNX+
         vKhSjurTB9HisjNg8sHokfKQ/9jLxsIozqs4VJQhPHPW6xmt7UF9fZ2XcvmovbzR7EQF
         QfZSf6tVFwZFpiaOhVVRfTTTHH1cvJWbDQ3AatGkpid+9g0uz11PIFy6NJ57KnaxxCjO
         TxrmFProz1T2RJiKDBWhH2bd64SAVhhAqWaqi+lJSSQxw3+kM5o8p+eTgsKK20GYqhnX
         2NmO6d4Nwg0KU3sm/4+MOIZxtEkd9gj6ahPS8RbqnsPhEGykuSmakUxF70hVDy/zysFt
         epzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712776491; x=1713381291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnSzzFgP2liAY4gSnshhFACs6sQ4XACv2JFHDRUpzPA=;
        b=tn84u3/9xTPtG9wVUK3ZzWLzyvuMepF4syNWBUu64CSuIcoep58+LVljoJfyfmvv5G
         86ku6Vqjalfi9bKfg21PrxX+5ogNIsmPWm81eBUDHftFc5aITQdEEnBhlJHA9hgGJ4U7
         vH81fUv1A/QgXsQI4iZ9Da7aktdttKM20EmSExHQWCYypuvP8zRsZwdy1rCTQh0HfT75
         s70oXNImRsUKPQq7pDklSJop2KSshMnN79ecE0U4i/0mC2UdrHGV8meCQucAb/woa0ZH
         tOc3d0HXN2X9Ex8kY4VNN/rBh/Jj5NldHPb1dD2T/bacMSb2SdiYV7S/t7B6hrdyTq27
         Og9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWI3kq0Y+cm/j0g7t4BqVv1Lyxh5hbfdWUknDCbCD01S/dlC5GoTS7uYvUdUbS++d3YO5uvb6tDeLxJAJLR4lrdp2LJTNwpYZks/IaK
X-Gm-Message-State: AOJu0Yx8Lvw/LRoYt+6IHFfUMvJH0ldJoKTiEu2TYk4Da8QEgpKW/XBS
	z8a7vCeevVsjYQGD6JPA+RgwkcKegZx/q4hO71v1g472UFP/lhWyFNDJoN/eEYs6SVRS7Xom5bP
	r35rgfSKuMe6Bug5uvHqO630wOLPKPm5OipND
X-Google-Smtp-Source: AGHT+IHXVM/rxOkvyaDPAoKQ59qRsklTHGKlP31SHouUdoafoSVXDuobM6bY0ykUcWsmXEHIn5XFlcm2mx9dboBqHMY=
X-Received: by 2002:a05:622a:4d88:b0:434:4a49:da75 with SMTP id
 ff8-20020a05622a4d8800b004344a49da75mr30363qtb.11.1712776490581; Wed, 10 Apr
 2024 12:14:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410185117.1987239-1-namhyung@kernel.org>
In-Reply-To: <20240410185117.1987239-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 10 Apr 2024 12:14:37 -0700
Message-ID: <CAP-5=fXeM32=wnkMnp49wLYDS1PWwhKtK9UiKyAa=XvJz9kANg@mail.gmail.com>
Subject: Re: [PATCH] perf annotate: Skip DSOs not found
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 11:51=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> In some data file, I see the following messages repeated.  It seems it
> doesn't have DSOs in the system and the dso->binary_type is set to
> DSO_BINARY_TYPE__NOT_FOUND.  Let's skip them to avoid the followings.
>
>   No output from objdump  --start-address=3D0x0000000000000000 --stop-add=
ress=3D0x00000000000000d4  -d --no-show-raw-insn       -C "$1"
>   Error running objdump  --start-address=3D0x0000000000000000 --stop-addr=
ess=3D0x0000000000000631  -d --no-show-raw-insn       -C "$1"
>   ...
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Perhaps: Closes:
https://lore.kernel.org/linux-perf-users/15e1a2847b8cebab4de57fc68e033086aa=
6980ce.camel@yandex.ru/

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian


> ---
>  tools/perf/util/disasm.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index a1219eb930aa..92937809be85 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -1669,6 +1669,8 @@ int symbol__disassemble(struct symbol *sym, struct =
annotate_args *args)
>                 return symbol__disassemble_bpf(sym, args);
>         } else if (dso->binary_type =3D=3D DSO_BINARY_TYPE__BPF_IMAGE) {
>                 return symbol__disassemble_bpf_image(sym, args);
> +       } else if (dso->binary_type =3D=3D DSO_BINARY_TYPE__NOT_FOUND) {
> +               return -1;
>         } else if (dso__is_kcore(dso)) {
>                 kce.kcore_filename =3D symfs_filename;
>                 kce.addr =3D map__rip_2objdump(map, sym->start);
> --
> 2.44.0.478.gd926399ef9-goog
>

