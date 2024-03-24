Return-Path: <linux-kernel+bounces-112601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B1B887BD2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 06:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6B60B214F1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 05:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E527914012;
	Sun, 24 Mar 2024 05:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XPoVzkjs"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E4D1401B
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 05:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711259831; cv=none; b=RYmzmUx0QAk+szqZkT8KN3xwNlQc203vOUE18uCp6dUICE7bcRMs8LBkdlAp3FTnAN+drv7d3PXxSztQ3cn1PG9r3q4hcOh7UV18EhyojeRsoiKCXPF3Pfka9kQUG3ZYZdk8kLU1IwgZZLfPO51Ja4pbZGbXreG6EeiHLlL/iW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711259831; c=relaxed/simple;
	bh=6IzC5f7q8Hc8Q5UlfrkfYNWS4BY11Ec+KoaESDdZrUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iXx5NbhnnrgtInLv9r3ln12T7WNlZ9Xsrv1M518+hpy7rje5TPBNI1zGa3MQeVV8KZxSb8hHfMyb+MXoySpcvcSMTweBd4Gx61ZulmhI9ulVsQSd1S3ClLVG99fFo9fxNV8z9MCCsmrXxgrcCIhaN+3/eWv8OLLtNhepRfSVvrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XPoVzkjs; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-428405a0205so202901cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 22:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711259829; x=1711864629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXAIIcbgeJRRW587MHc7p7n/VVnxiytnklGzR/XF9Zg=;
        b=XPoVzkjsqhiIXeTp86bFWQ16f0/SArp1Gfiz3hzU2b/WTuyDPk9eTu07nNs9qWSXGI
         /9XRJ4FIBRpaTEsMWN/CCnZa4Xktf1xrkE15IAeYXjY1bvdaQ1Rrs06FEEyRl4zQq8xh
         i6UjGQ+nm7gjIgWPeLiN7067Pwu39gzBCKrWT9ZeKsNc/6+i7vwNcoouX5FCD2rYUhh/
         MVu1a4qQaOQOKHzHnoKxBIPpW7cs/QTzeGW0qXVGNj/nXjpeAf2H6onBtS+IFFo9XEbv
         ivyWC8N260B7zFtSNcd+Lp3hHnWr1BH6nuTzUbJ9cSKruferSk1A7ojY03Ub45r+w/O1
         98Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711259829; x=1711864629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OXAIIcbgeJRRW587MHc7p7n/VVnxiytnklGzR/XF9Zg=;
        b=vagQXPZ04B0Q6+rxhjvJIzAvhZRdkjjFPT5gCZmUw0AkJoqB1wisWkv9d+pn0ptJ/h
         aJyvrvbolWuGo+KpUr7INn2oRVeSS1mJYDPcQ+125Zpgra7E9kGpV8iKU+dNwGiR72wq
         Q9/0G93LR/81fvM9W7e7kmCV1E3Y+2wfEbLW34K/RDSrMOk0k+3XKrFrKb0ztpf43U/r
         OQBInartwzHjKTEQkhjjui7V6vO5EF9bTbh4JUxGcUF0yRPQefeimS/68kiC0/ZNCOvu
         ycL6lqj+4CUYh2TyvazWCit/hkF/QQ7CGvUVV7sw9636UZNQ3ZnsRIXyAzRxmR+ZpOHs
         JcgA==
X-Forwarded-Encrypted: i=1; AJvYcCVHhlPwxcneyQpLQ9C3/3t1a4hvrYSIYnFhBewE9jgNRxZi+pYxlhvnBZ5ilatlCB3Nbl4Jl6h8PbCiwJj1JdPH1ZOYmyJ8e29+qtFZ
X-Gm-Message-State: AOJu0YyPGLJ0eVZE9ce3Wbycz53Rhji/Z1ws8kBDNoU9jVs/ZUpQbo3t
	gRz0/G1LQUnN1uSHSvJTKYHjsjsBEaj1qfflDGLbHjy7MeL2XWha0P03DL8G1vvmi21BzJ9ngSp
	rlo4FkRitob6JOOARH9mahhgt3xzLXnnWSy+o
X-Google-Smtp-Source: AGHT+IFcaFG52euAc0uSDI2LIkoC6Mhhjoa6yC0WqUakrZmwGJK1Xnzfk63eZIMRoOtjvDFWTW6ZpPCOQOPK15SweSI=
X-Received: by 2002:a05:622a:102:b0:431:20e1:a28 with SMTP id
 u2-20020a05622a010200b0043120e10a28mr890714qtw.22.1711259828614; Sat, 23 Mar
 2024 22:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209031441.943012-1-weilin.wang@intel.com> <20240209031441.943012-16-weilin.wang@intel.com>
In-Reply-To: <20240209031441.943012-16-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 23 Mar 2024 22:56:57 -0700
Message-ID: <CAP-5=fXh=CF2e57P_yVJGGPxu7RbOYA5d=HBxU-7y-_kgSqX1w@mail.gmail.com>
Subject: Re: [RFC PATCH v4 15/15] perf stat: Add hardware-grouping cmd option
 to perf stat
To: weilin.wang@intel.com
Cc: Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 7:14=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> Add a cmd option to allow user to choose this new metric grouping method.
>
> $ perf stat -M TopdownL1 -a --hardware-grouping
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-stat.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index d08a40c4bae1..e30f7a856122 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1257,6 +1257,8 @@ static struct option stat_options[] =3D {
>                        "don't try to share events between metrics in a gr=
oup"),
>         OPT_BOOLEAN(0, "metric-no-threshold", &stat_config.metric_no_thre=
shold,
>                        "disable adding events for the metric threshold ca=
lculation"),
> +       OPT_BOOLEAN(0, "hardware-grouping", &stat_config.hardware_aware_g=
rouping,
> +                               "Use hardware aware metric grouping metho=
d"),
>         OPT_BOOLEAN(0, "topdown", &topdown_run,
>                         "measure top-down statistics"),
>         OPT_UINTEGER(0, "td-level", &stat_config.topdown_level,
> --
> 2.42.0
>

