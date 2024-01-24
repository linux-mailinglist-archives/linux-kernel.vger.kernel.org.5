Return-Path: <linux-kernel+bounces-37561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E5783B1A3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C353287D5A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F744131E3A;
	Wed, 24 Jan 2024 18:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kvLPi7yF"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D371131E24
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 18:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706122744; cv=none; b=s+Kf/gO1rUPNlCdozA7dy2CnFE2K2sKQPJ4oxF1ExbmTk8jqblmeg89nrg5CB0U52+ps9I78YTDXuwGbWxHbpmgE7YrodhRuGK1U4g1ERjrnwY8aFmdZ7q4HbuV0lTJVZnf2q2pJRB3qYxztn2D/7Y5FYukkZgVaRD1ULWP6PMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706122744; c=relaxed/simple;
	bh=pf6HAXY38MjiKrdrgIHZI2hzdVKiya6tRAX3fKMTagE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jYVPJPZCrIcYnxDp79DWX857Aq8C9C7KDYqabaE8WIfCOzky2k8f3UNphUcOqReOcM07dI78KHS88GNbrt9y89647A09SKcIogVo0ho446J8bDYN0R3IF0fSOF+rs1RGL3MkiPxH7fvqQAbZeFSjfNSEErSVRX9fRd8BOTbkfWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kvLPi7yF; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3600b2c43a8so13155ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 10:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706122742; x=1706727542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9asDGqDhkNFDxcWQSWQOBO5y+hvi+No9XWYkklaHfY=;
        b=kvLPi7yFgB6g+F2eFTRZRU5cTbyhfWjiDz5+Dqxe6CYElZiMVUTUN0sT1C6uk0cXAg
         AYvgulV60uMF9QA7L7ti8dXNzpmMMihCEbk9K5D5zk+PlkY5KDSl3Og6dbtnj2ln4WwM
         DvFLQMTpRy8sSHc0L06Hq968QBBOVEKqVX0KcD+qmvftJ1u3KQmi52ie2vMTO7XosWBD
         eW4SiJ5fmBvI8MQet3mbqFprDl8Ihk1eJRex1UJZuNF8T7W3bbOGonAJTgdxhCupKzQ/
         EJub8WB1PANaL/9HODhQ7F3zSSJePwFMttjv6uBmqiFh3Odvzdvf/gOQsiSgoCS8MDYk
         4DKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706122742; x=1706727542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9asDGqDhkNFDxcWQSWQOBO5y+hvi+No9XWYkklaHfY=;
        b=rcajJKewHqE6DMABQATrv4nA+AEaL9VCYV+0SS/NDqWfby8LqZLfZe5A/jloFrr7sU
         ChFM94wrZLTCtyNTtbH4ePLFLvIBVuto+MFEu7YPEqBHQ4grIUjr7PMPnJvUT3HP1tVS
         7i7O0N7wpuPDu1I2wHTxZktUXvap3uhc/5yFm/yHoijwcYkxaWmxOBPKGTRh42R1mGpN
         ZCW8YCsFvRacdnH7FaWwzsobpu/gwfmkLCwJWOvtjR4vfJblhQ40Bp4JqSgXfRb8RSp/
         UQIUhQeR1CYDQQA4xT9fCoU1bkKGVUFReNmeGxZthBwDfe+3jSxFooc5pYH7w4F9DU71
         BPZA==
X-Gm-Message-State: AOJu0YzUJ/G04LBrdeE6ywckszxIDr3ZgV4nS3TibsJGpoXHbox1mr47
	l51JXnQqUQGCTWlKIXIGlqXNKxUHAmnQgwCjNeRnGuDLw+dCqU5byo9OtEQepHFQ+0u03wLcExj
	oGGXxFBOq/MhYKYRvOjoMplYjHdzjLOqzcJwI
X-Google-Smtp-Source: AGHT+IEud34L//OA5jtGYMwK66C58nc43tzaCQZPGKNesGQqdsxO4FbQLZMsWuQ0yrFhdU9w3B4yN9gxnxauvhVEER8=
X-Received: by 2002:a05:6e02:1c06:b0:360:1740:182b with SMTP id
 l6-20020a056e021c0600b003601740182bmr23482ilh.1.1706122741656; Wed, 24 Jan
 2024 10:59:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212230224.1473300-1-weilin.wang@intel.com> <20231212230224.1473300-13-weilin.wang@intel.com>
In-Reply-To: <20231212230224.1473300-13-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 24 Jan 2024 10:58:50 -0800
Message-ID: <CAP-5=fXRZuvTk4Ronkam72CgKVzEA_qU-5FCnzEsxDL7wTaShA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 11/18] perf stat: Add function to handle special
 events in hardware-grouping
To: weilin.wang@intel.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Mark Rutland <mark.rutland@arm.com>, 
	Yang Jihong <yangjihong1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 3:03=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> There are some special events like topdown events and TSC that are not
> decribed in pmu-event JSON files. Add support to handle this type of

nit: described.

> events. This should be considered as a temporary solution because includi=
ng
> these events in JSON files would be a better solution.

Agreed on this being temporary. We have a similar hack with
arch_evsel__must_be_in_group, could that be reused here?
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/arch/x86/util/evsel.c?h=3Dperf-tools-next#n41
It doesn't cover TSC but parse-events makes TSC a separate group
during parsing as the PMU (msr) differs from the PMU of the events
(typically cpu). Fixing the metrics and events to be json is very
do-able. I see on Icelake, for example, TOPDOWN.BACKEND_BOUND_SLOTS is
available while frontend isn't.

As an aside, we may want to treat msr as a software pmu:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/pmu.c?h=3Dperf-tools-next#n1761
which may be a metric regression.

Thanks,
Ian

> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/perf/util/metricgroup.c | 25 +++++++++++++++++++++++--
>  tools/perf/util/metricgroup.h | 15 +++++++++++++++
>  2 files changed, 38 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index 5d9ed22963be..03383f820e06 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -2023,6 +2023,15 @@ static int create_grouping(struct list_head *pmu_i=
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
> @@ -2047,7 +2056,17 @@ static int hw_aware_build_grouping(struct expr_par=
se_ctx *ctx __maybe_unused,
>         hashmap__for_each_entry(ctx->ids, cur, bkt) {
>                 const char *id =3D cur->pkey;
>
> -               pr_debug("found event %s\n", id);
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
> @@ -2519,8 +2538,10 @@ int metricgroup__parse_groups(struct evlist *perf_=
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
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.=
h
> index 51596e4b4341..37fdf8c5ba77 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -79,6 +79,21 @@ struct metric_expr {
>  #define TRANSFER_FIRST_BYTE(pos) (7 - pos)
>  #define TRANSFER_SEC_BYTE(pos) (23 - pos)
>
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
> +
>  /**
>   * An event used in a metric. This info is for metric grouping.
>   */
> --
> 2.39.3
>

