Return-Path: <linux-kernel+bounces-112591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C63D887BC3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 06:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395761C20DCF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 05:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DAE14012;
	Sun, 24 Mar 2024 05:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MX/Gxhq/"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAD21A38DE
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 05:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711257622; cv=none; b=I5n3PgceO/jsBkmtX/zrkitGZFCXii/0px60S0j2k4oyLvvJAatNU5eQF2nogz4B95K2eXZWau1J/HOUrwAwxFi+9eDDFSi7TtWhnqQ1UyE0WpB4eqihShV1TLlXDFa57E+0uJiqAWVkypZyJDyW+zxlRJrIBwz/eSQNNHR3P+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711257622; c=relaxed/simple;
	bh=huo0FqZh8qWe0LH5J17ricm/+PWwwHEYbbGfD/miNbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pE872O+Off0FOTsrKrmZwyrVzgyiaR7CC2M9m2Eq4c7IhvaYlQHtjEtKUmnPDM7W1jerWDwMhNoxBuwVvpI3sLkt/u0CTqU0bFVE+FY/XgdjmCYEY8xbWnKqydEzEWksX0kn72ZyfLNxiuQAGo7axOFuKtdfuMMUMDK9fwgPIg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MX/Gxhq/; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-36880dc41c0so108415ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 22:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711257620; x=1711862420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kw1SuZHQQ91QtNOEACeszDGcG3fk1mZSY8v6Xr5GmH4=;
        b=MX/Gxhq/iIiiZ0Sdenq12yPvEWRUUl1mXn60P8HUlAsHSElFe10T3vARJX9bJrAZD0
         qe9yvrNldhqjsxiO1MiCOCi0Zcsi4UKjRJj6W1Oq8p67qzRPy5ANWUsvwnbyg/+VJLf1
         990jLIs7D5Ev9UAWGT07ZFq+1wYrNz0pYLNMMzSw2cH/ViR4wNi/kyWCZrbY65yLKDw2
         PWx2da4c9A+Q8gibEy0ucZH59JowEQGG03DD+LnO4rQ5yN4eitBLk7k8CBee/uS0hsk5
         TxDB+8Qkvm7nhSxPxeJe/Nj6FholAyvLuz502eF2oWBKRBeA7huYfCbm1t87dpX1sClF
         DFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711257620; x=1711862420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kw1SuZHQQ91QtNOEACeszDGcG3fk1mZSY8v6Xr5GmH4=;
        b=fxYmiBDlttMOZrF+WjBRtbiCcK66H74WyhR25W4IA/yFr7CdsqWCqDiQY8CKRisffB
         r1CRKPyUJ/b3QBn2LRdU80yOKbuF+8mE7emwnW+UXfHx3y4n6Wvp/7DF5Qfa63lYqCUQ
         x31o6ZToQ/v1XjZhZ7Xal+OCLrrVezI4jKneL2AInvv8PF1SAaT3Dp211mP9zbtVHfIV
         byc2AASJWoVLPBYok9INlzWbd/D0bvJ7c0M43Ja786febDvBt5IzsPjmVTCoI+Xmf/0/
         LbLknaUJjMmqh0lZHN+Uu6X1AC1iEWrsKFikjs4HA2QKU1ccngV/x7jas62D+szLYMIY
         2DJw==
X-Forwarded-Encrypted: i=1; AJvYcCXniOd3XjPKZsm/AOtcSd5qcanbncA+iD3bPEg6Isfq5fFHbm1npdayj1Hc84xvZksQtkJjml+AznUmxCLRELVmeuUMe0WHT92N8Qug
X-Gm-Message-State: AOJu0YxUBAMcvNYJq2hqNZwZ36Z4FEq5EcbBTrGlcN4yhgG3XYfcXc2H
	Xi3eW7CluTlwEED8tCnwShBxHbZrllr23OnBOu88kRtlSj++YePhMDKMxOjtURsZAaRTZIuvuk8
	jmeKdiFBGFlRDFS0GcBsaEDX2RPAJvdI3Iteb
X-Google-Smtp-Source: AGHT+IGzjQ9GZvPCCC08VsFv7CWQiTGELgPQgjgxPRZOGgogAqPAoIQPy2YAoAWbaMlFrohJxx8Y6IHi9FwsjM1Fr0c=
X-Received: by 2002:a05:6e02:2184:b0:366:63a7:78e6 with SMTP id
 j4-20020a056e02218400b0036663a778e6mr820057ila.28.1711257620064; Sat, 23 Mar
 2024 22:20:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209031441.943012-1-weilin.wang@intel.com> <20240209031441.943012-10-weilin.wang@intel.com>
In-Reply-To: <20240209031441.943012-10-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 23 Mar 2024 22:20:05 -0700
Message-ID: <CAP-5=fV8fUBZihx-7wQf+DgOqoii5VVMs+Y3kFmg+5JdkD0NQA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 09/15] perf stat: Add function to handle special
 events in hardware-grouping
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
> There are some special events like topdown events and TSC that are not
> described in pmu-event JSON files. Add support to handle this type of
> events. This should be considered as a temporary solution because includi=
ng
> these events in JSON files would be a better solution.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/perf/util/metricgroup.c | 38 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index 660c6b9b5fa7..a0579b0f81e5 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -160,6 +160,20 @@ struct metric {
>
>  /* Maximum number of counters per PMU*/
>  #define NR_COUNTERS    16
> +/* Special events that are not described in pmu-event JSON files.
> + * topdown-* and TSC use dedicated registers, set as free
> + * counter for grouping purpose

msr/tsc/ is a software event where reading the value is done by rdtsc.
Unlike tool events like duration_time we want msr/tsc/ in the group
with the other hardware events so its running/enabled time scaling
matches.

To some extent the topdown- events do exist in the json as
"TOPDOWN.*". Looking at
tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json I see just
TOPDOWN.BACKEND_BOUND_SLOTS. Perhaps we can add the rest rather than
have a workaround here?

If topdown events are in json and msr/tsc/ is treated like a software
event, as we do here:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/parse-events.c?h=3Dperf-tools-next#n1920
perhaps we don't need the special events category?

Thanks,
Ian

> + */
> +enum special_events {
> +       TOPDOWN =3D 0,
> +       TSC     =3D 1,
> +       SPECIAL_EVENT_MAX,
> +};
> +
> +static const char *const special_event_names[SPECIAL_EVENT_MAX] =3D {
> +       "topdown-",
> +       "TSC",
> +};
>
>  /**
>   * An event used in a metric. This info is for metric grouping.
> @@ -2102,6 +2116,15 @@ static int create_grouping(struct list_head *pmu_i=
nfo_list,
>         return ret;
>  };
>
> +static bool is_special_event(const char *id)
> +{
> +       for (int i =3D 0; i < SPECIAL_EVENT_MAX; i++) {
> +               if (!strncmp(id, special_event_names[i], strlen(special_e=
vent_names[i])))
> +                       return true;
> +       }
> +       return false;
> +}
> +
>  /**
>   * hw_aware_build_grouping - Build event groupings by reading counter
>   * requirement of the events and counter available on the system from
> @@ -2126,6 +2149,17 @@ static int hw_aware_build_grouping(struct expr_par=
se_ctx *ctx __maybe_unused,
>         hashmap__for_each_entry(ctx->ids, cur, bkt) {
>                 const char *id =3D cur->pkey;
>
> +               if (is_special_event(id)) {
> +                       struct metricgroup__event_info *event;
> +
> +                       event =3D event_info__new(id, "default_core", "0"=
,
> +                                               /*free_counter=3D*/true);
> +                       if (!event)
> +                               goto err_out;
> +
> +                       list_add(&event->nd, &event_info_list);
> +                       continue;
> +               }
>                 ret =3D get_metricgroup_events(id, etable, &event_info_li=
st);
>                 if (ret)
>                         goto err_out;
> @@ -2597,8 +2631,10 @@ int metricgroup__parse_groups(struct evlist *perf_=
evlist,
>                 ret =3D hw_aware_parse_groups(perf_evlist, pmu, str,
>                             metric_no_threshold, user_requested_cpu_list,=
 system_wide,
>                             /*fake_pmu=3D*/NULL, metric_events, table);
> -               if (!ret)
> +               if (!ret) {
> +                       pr_info("Hardware aware grouping completed\n");
>                         return 0;
> +               }
>         }
>
>         return parse_groups(perf_evlist, pmu, str, metric_no_group, metri=
c_no_merge,
> --
> 2.42.0
>

