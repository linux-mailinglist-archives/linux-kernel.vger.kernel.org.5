Return-Path: <linux-kernel+bounces-147981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE878A7C20
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 164C9285114
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DEA5A784;
	Wed, 17 Apr 2024 06:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zC55f8uj"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2F95A4CA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 06:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713334392; cv=none; b=LEVswHmUvpmEEBZfi7NB26fNDLl4DtXFeUHcNqT/tMqknTXVw7oFBXvGY06y96ECFhiCzyVAbxedWkMeKeWq7ZC+58vhTJT0gW57NsJgLnx1XZi5JIOa7Tfh+yakhEVRJQPZJ0eh4/qV9u0o2E8lvAr9bMaF7Ey+0CIqjrM0N7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713334392; c=relaxed/simple;
	bh=fb+0KvFW42aGyQpvl/s9xJ33+n9e0MexEqdW+W3rE6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kcAb1l65lfOubV82c1S1dU/GczCiiMTvNkE0BzbHLkWEamnK5b0B12BLNpzU3QBrIwtc+h/LBjg4ipjjps2ncZ9OSrIBVQpaAkldlw9nfsGStHvaketKdsrBzo7abs3Y2jfHyepsKthfkqNxbvgxEIanzdePwTOm6zHIpBVu6RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zC55f8uj; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e3c89f3d32so119435ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 23:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713334390; x=1713939190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0QM4xyZ6m0oZ8CjKXaD14IECN6XKZ3rAJvNeQeOSl4=;
        b=zC55f8ujpzcrZJlJ5+dTO8PYqYlRlaAvQK02jO6lK9XQQPmxTP5A04ztrLGkKpG0wB
         6W+qISjPqAMmDBiFkzFlSLwLm+5BVKBxwKmFWg2ewaj2YIkL5ysvd6ekQFp28Cje44H9
         Zr4zsdzWd1dfXyJTlKz2NKtVj8WiwU49pujY4b+G8a+ZkBPvx42TLQH9U9rTNyAYn176
         mgO3YIiDad9pO7/h6JKVe2lOOCr/m5sGb8kyc/ysrT7Q4uCYINj05w3dxIjY5KsEafwx
         SpZVST/uFOH7ZZzCp9yxyQfMvTOhQvXnhsGTubnG4R0OmB6X3srfNQzwAR9IWwVn/YY5
         jpRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713334390; x=1713939190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s0QM4xyZ6m0oZ8CjKXaD14IECN6XKZ3rAJvNeQeOSl4=;
        b=AexESDAYKS32kA/aqD9aRZ0ii+4dYMxLIhHQxroCY4ixrRpE7sKfmLJbY89JavnrZu
         2uikHPRXj4w0JRe4cah4cwI/O4UW1grGS242EMAcQb6ue93Qy8hWYLTm79NOCALhsVkP
         lw2fQDM+pR0ayCaSlnIMCgDaDC/2GST/xcbHWqy7Sp8t6wF2MRC2f6BI91qCBOx03rnd
         Ugt//xjD2hlERVSz03ogJzGCyKaQ/QSZt6jmJH+/oTZi3tC6gWsR1v2/nTdARZ9colCG
         SaENjjJ6MB3YadZO3Vd21i2KB6clqX1qfTm81uEGVpidFRgly+Kx5Zyx0ziPu53YfGpQ
         gadg==
X-Forwarded-Encrypted: i=1; AJvYcCXIcTs3caBXUesXoAxsQkiB6O8rgKBJ58yP6xFyWQ8HLU2EuydF5rTK7i6hq/ZMOTPj6bsMu8ZwTH9K3TtqGhDXg3sqyrvaJKDlii86
X-Gm-Message-State: AOJu0YzoSrUr3wdlIRKdjNsBKto6GuCgnoBydHC03AXiUxvRXOJ9u/+j
	fGXwSAwhtHC7B1Msf6wq4cPTYOaQ+VUokALn0JNOTnVLFYiFv//LFQgTvphEX4gWnt9NHbKCKnp
	MbiaAR6VAQ9zXZ0MXl3+KXJklWPu5P1RCoVmL
X-Google-Smtp-Source: AGHT+IH8mOGOBUhCe+0cq7ePkplra86zlU5S+8x8/7j1rbp8bFyJ1MLz1Lu2xQq91/ND/dDiZGl2G66BLhrgH0sah0k=
X-Received: by 2002:a17:902:c652:b0:1e2:c902:57b9 with SMTP id
 s18-20020a170902c65200b001e2c90257b9mr141175pls.28.1713334389642; Tue, 16 Apr
 2024 23:13:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412210756.309828-1-weilin.wang@intel.com> <20240412210756.309828-10-weilin.wang@intel.com>
In-Reply-To: <20240412210756.309828-10-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 16 Apr 2024 23:12:58 -0700
Message-ID: <CAP-5=fXtfu4Kvz0xKA3uxwvmZCacCmYPyP9Pa6dWFF8L_ZTcLg@mail.gmail.com>
Subject: Re: [RFC PATCH v5 09/16] perf stat: Add function to handle special
 events in hardware-grouping
To: weilin.wang@intel.com
Cc: Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 2:08=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> There are some special events like topdown events and TSC that are not
> described in pmu-event JSON files. Add support to handle this type of
> events. This should be considered as a temporary solution because includi=
ng
> these events in JSON files would be a better solution.

What is going to happen in other cases uncore, software and core
events for other architectures? Topdown is annoyingly special but the
MSR events should be similar to tool events like duration_time, in
that they don't have grouping restrictions.

Thanks,
Ian

>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/perf/util/metricgroup.c | 38 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index 04d988ace734..681aacc15787 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -162,6 +162,20 @@ struct metric {
>
>  /* Maximum number of counters per PMU*/
>  #define NR_COUNTERS    16
> +/* Special events that are not described in pmu-event JSON files.
> + * topdown-* and TSC use dedicated registers, set as free
> + * counter for grouping purpose
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
> @@ -2142,6 +2156,15 @@ static int create_grouping(struct list_head *pmu_i=
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
> @@ -2166,6 +2189,17 @@ static int hw_aware_build_grouping(struct expr_par=
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
> @@ -2636,8 +2670,10 @@ int metricgroup__parse_groups(struct evlist *perf_=
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

