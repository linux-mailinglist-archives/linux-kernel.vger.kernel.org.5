Return-Path: <linux-kernel+bounces-50812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FF5847E3E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 02:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19F121F24EA3
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3684253A1;
	Sat,  3 Feb 2024 01:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D/WBXHhD"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DEF2581
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 01:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706924529; cv=none; b=PjGV1fbjScrl+h4Bo+c/+CJh/WicrjHhbFY3oy9Zbu9AwD4PV++Fxrf7FwwHrZGcMU5ucY2RO6Pgm+ySoSK+TPDqz4CN2fH28ILWsX0AWEqXdeF9ItiogXaR3zsvredfr+HBLihZ0pdfUNbCwovxmqJn1fAzM2L3GGthOTcgGSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706924529; c=relaxed/simple;
	bh=GL/NWsRNvwetg0ZgKm/CnIK8EZZYE3j8znwpXi+d+6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nt2ODNB0Z57h70uupBF/jCC79TttMUeg56kPWLB6y6H6ZU+FAfdsblZSsE7yg2RkxlKdlSx0iqwq9lcjngS0ChswHEOT9y8CbnV/cHdGHKVDL3BICnIVZ4A/9bmrwG8NpTO6X4/hPPqVKV+o6ai9+tD/p1bQvbdzvUhPkTwMFik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D/WBXHhD; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d89f0ab02bso31065ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 17:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706924527; x=1707529327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1tmXsSnp3camgDs1JiIWN7PNv+Db/yDFJhwZXZV06A=;
        b=D/WBXHhDzyKrowiHj1GMrP31KK5M/OAnZsRTqSjBT438hdoJcLSiMQ8wGVoWjgBEKb
         lCqzFLtXIHtrY/fuIhFYdy+9ledBCKhQMlPPMHMH+TAqoLn6kucLBW7aSNQsKrhLMYt1
         Jv3iFm51hQ73wUqAkAJHa0ny1D7Bpbi6CkwhBeB6MlVKjcfzPtCP1doz/PL5F+iNR7yw
         sK7QmlpUtBRuLPsuGZ4V/avM0VafKTgE+2A3gKy/vcq41XqLN5dCFc+XFh++Ig+R8JFr
         9zI7SgNHzXOi/iFdWHAr+5vI7aVXesPoluqm87X8V8kiqHPznjJ7/SF0Pn0FnbKAWaNy
         TG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706924527; x=1707529327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1tmXsSnp3camgDs1JiIWN7PNv+Db/yDFJhwZXZV06A=;
        b=GgZzD3upn/tAjLeK9q2szHKT42SGOZBW3nc4CFJSkjyPp/s5SYSMr1hra08HcqpMrc
         ax/Ve6kFM3r0io4ZPxr1bLZXlAfXiPXlw8hD+x9gTfCMXgmnacfLRkqv3ui24151EagJ
         mvmmsVlDo1tJsSSfR99KyVt094fWRmXq6ASEEVv8db5PcZD72Hgt91IxusHaBW9R1qgg
         ItANgcC07/wJ+qnp65VQKr+kkCekBtEa4Oii+X6S5Bn+LkCCNWimtwU9BpCAZbQtBt/z
         WGMX7bOzDGTK253N+ZNUjEpDulR0hjAYGjbuyNDL5rOtgwc7TVPNVUXU336C4EFQRNc5
         KX7w==
X-Gm-Message-State: AOJu0YwRrm6tsmDadKfG6cUbEmWh4zPAkvbacZMrcXsv29RPslBD1Pdn
	UUIOqJCWdGZpx8XIUC/Rm2QHIQIcgJ68xUqQhVFXuXgM/3BR1qYDWUnvHyio9xUsVJ5DJvVaNR7
	5anHBg1j921CjR8KfB9TpUmladXn5HKUpiDBV
X-Google-Smtp-Source: AGHT+IFvVXrppMHSh7EsMSe+LktgAY1bvnADV80hP2rmsBLFLZkqA4D0C/pdQHOx+A5VfLjdqqxNYj4YHwkYqewRHaI=
X-Received: by 2002:a17:902:b489:b0:1d7:48ef:e239 with SMTP id
 y9-20020a170902b48900b001d748efe239mr72459plr.18.1706924527056; Fri, 02 Feb
 2024 17:42:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202220459.527138-1-namhyung@kernel.org> <20240202220459.527138-5-namhyung@kernel.org>
In-Reply-To: <20240202220459.527138-5-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 2 Feb 2024 17:41:55 -0800
Message-ID: <CAP-5=fU=P-ib+n+OfqJAbm8gS2RY-W-KcBskoSHkC+aCmXYcXQ@mail.gmail.com>
Subject: Re: [PATCH 04/14] perf map: Add map__objdump_2rip()
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Stephane Eranian <eranian@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-toolchains@vger.kernel.org, 
	linux-trace-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 2:05=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Sometimes we want to convert an address in objdump output to
> map-relative address to match with a sample data.  Let's add
> map__objdump_2rip() for that.

Hi Namhyung,

I think the naming can be better here. Aren't the objdump addresses
DSO relative offsets? Is the relative IP relative to the map or the
DSO?

Thanks,
Ian

> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/map.c | 20 ++++++++++++++++++++
>  tools/perf/util/map.h |  3 +++
>  2 files changed, 23 insertions(+)
>
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index 54c67cb7ecef..66542864b7b5 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -594,6 +594,26 @@ u64 map__objdump_2mem(struct map *map, u64 ip)
>         return ip + map__reloc(map);
>  }
>
> +u64 map__objdump_2rip(struct map *map, u64 ip)
> +{
> +       const struct dso *dso =3D map__dso(map);
> +
> +       if (!dso->adjust_symbols)
> +               return ip;
> +
> +       if (dso->rel)
> +               return ip + map__pgoff(map);
> +
> +       /*
> +        * kernel modules also have DSO_TYPE_USER in dso->kernel,
> +        * but all kernel modules are ET_REL, so won't get here.
> +        */
> +       if (dso->kernel =3D=3D DSO_SPACE__USER)
> +               return ip - dso->text_offset;
> +
> +       return map__map_ip(map, ip + map__reloc(map));
> +}
> +
>  bool map__contains_symbol(const struct map *map, const struct symbol *sy=
m)
>  {
>         u64 ip =3D map__unmap_ip(map, sym->start);
> diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
> index 49756716cb13..65e2609fa1b1 100644
> --- a/tools/perf/util/map.h
> +++ b/tools/perf/util/map.h
> @@ -132,6 +132,9 @@ u64 map__rip_2objdump(struct map *map, u64 rip);
>  /* objdump address -> memory address */
>  u64 map__objdump_2mem(struct map *map, u64 ip);
>
> +/* objdump address -> rip */
> +u64 map__objdump_2rip(struct map *map, u64 ip);
> +
>  struct symbol;
>  struct thread;
>
> --
> 2.43.0.594.gd9cf4e227d-goog
>

