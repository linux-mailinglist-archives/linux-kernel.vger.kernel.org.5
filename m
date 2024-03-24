Return-Path: <linux-kernel+bounces-112593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51979887BC6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 06:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63927281FDD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 05:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B410F1401B;
	Sun, 24 Mar 2024 05:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="omb7Xomm"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F10134BE
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 05:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711258017; cv=none; b=HNAbPLt89KZc5AuYy4vqFpINvPYsxprq+Kg1XZmu4TRRQNRMtOsZa3gjPGxyxquT2kyQ5YmODcM6U+AE8NJTrM3FfI6CXXSAvqp8QRy+SFEXTZ0NqNzbiGOP7Xgim38GTGo/9vFX9o+rJkx6yztNsIMxZWkE3HpbQ7ygfpEr5FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711258017; c=relaxed/simple;
	bh=j079EurHa/3stFGZ/lRDTfWJwJKaoNSnmge157CW+jE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b8EJ1AyVQn0cRdEZq3yW4AyMEGigcY/QUhqjViSc48yCOVUan64BVa7C4HwEgl5cPfbU7CvlSrQ5qpIr6Z9xxPh21TjlONbs3aLZ+KAWO7JMrFkxJNk9wxw86iyNlxYqNj/ug1jCyAM3UqtZVhBOzWdj+oMaj4MKmqh83ohr1/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=omb7Xomm; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-430d3fcc511so176711cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 22:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711258014; x=1711862814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IN8g/xZoptYVJ5FsfZed15QS7HE6W3eYDa46wXkoQOw=;
        b=omb7XommhwB66mnlrULq4jZ4dtml9VgUz92meYpHGBzDZk6nM0d+8qRAijvqJR3gef
         1+y6n13u2mttmp1Hv90CMGyY0mA0Ua+YU898q5uSP/ksD2q04qRV4V/yzOK8vUWNrmiq
         drA7WXizibgg5uutLX4ZgShfCFDKSrlWTO+czzGezqrav0RLhJh19dz3ZB0v+BiDsYyo
         J1b6xpMfT/4BpmIiGIPZzviJleoi5zDjTamYe4imrVHM8DNHZkPEIm4Igjpkr+n0sjtY
         4i/LdEpuZpq9JT3iaqv1llOadF3nUiNg9sacVrFJy1+7hEUWDmUZcyqi5gOUGfI3D6pC
         f7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711258014; x=1711862814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IN8g/xZoptYVJ5FsfZed15QS7HE6W3eYDa46wXkoQOw=;
        b=PxSM2DI1Eq4/BKgzVwXxRAuVF+tpuUxbbSgLb/es012cLlTNRSpif/wgd4ys7XKzch
         hrWGRicir0SpT+coh7rNFcdyKcqsVEwwVA0AbTVBI8/GYmYwIGcC7LYfuYvWD1t9FonL
         YYkIjBeUh1CL8HAQ/ZwvCVKSolPvT9YwATLzHehXPFjcO3Rs4ybUzFRzcSLk/J/jSN9u
         5WUijfQlk3eMs81tUh+tf9qHH4mxK0ZUI97DUjvY7ZsLOZJ9BUG9nAfPrBNEiHpG79YN
         2SwvZgb1lzDClJzrTSsN0jQtrB1ryV/cE9FSIQlyiP0rfbumTLwvmS3IJP6d1oIWvi7b
         F9pg==
X-Forwarded-Encrypted: i=1; AJvYcCVA/A+r/DtCEUGVEDzU1OhueW02H5Hq323kERoYjsDQLgyrF4Kgk6A2d2GsKKcnV6SELS5/32dX8kxFxPgDyi+kMB6GJxYHYond5fgh
X-Gm-Message-State: AOJu0Yzh5R/H7VRksng+SWqJiftcavXdgM3efYXZnSjaehnQ2FieEyCd
	/S2BwuW/xGkTvsb1JjrnIDypTbMghh6AruL1ba1YXvMKD5eHvDTlP9ikc1ueBN+fgsC4+A0Hxxm
	2E55CrqCwfirErhQXTIHK2bkzeb9Wcoic/FSm
X-Google-Smtp-Source: AGHT+IHY9kyWE3pD9lQTodwqBCg4s4JbXqjdoB+7slTo1auRAaUk6lay/L+V8Pmbxl6l+zP3Tch5JnLoQLSsgD1azzw=
X-Received: by 2002:a05:622a:8c7:b0:431:3d4d:92ed with SMTP id
 i7-20020a05622a08c700b004313d4d92edmr223747qte.9.1711258014088; Sat, 23 Mar
 2024 22:26:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209031441.943012-1-weilin.wang@intel.com> <20240209031441.943012-13-weilin.wang@intel.com>
In-Reply-To: <20240209031441.943012-13-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 23 Mar 2024 22:26:43 -0700
Message-ID: <CAP-5=fW2VFA9fdHiiufrDD011gFHGP6dzdRTV7HT-cBQ0HL5sw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 12/15] perf stat: Handle NMI in hardware-grouping
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
> Add an easy nmi watchdog support in grouping. When nmi watchdog is enable=
d,
> we reduce the total num of events could be assigned to one group by 1. A
> more efficient solution will be added in later.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/metricgroup.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index 95d3868819e3..f1eb73957765 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1947,6 +1947,10 @@ static int insert_new_group(struct list_head *head=
,
>                            size_t num_fixed_counters)
>  {
>         INIT_LIST_HEAD(&new_group->event_head);
> +       if (sysctl__nmi_watchdog_enabled()) {
> +               pr_debug("NMI watchdog is enabled. Reduce num of counters=
 by 1\n");
> +               num_counters -=3D 1;
> +       }
>         fill_counter_bitmap(new_group->gp_counters, 0, num_counters);
>         fill_counter_bitmap(new_group->fixed_counters, 0, num_fixed_count=
ers);
>         new_group->taken_alone =3D false;
> --
> 2.42.0
>

