Return-Path: <linux-kernel+bounces-112596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AA0887BCC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 06:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8229E282393
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 05:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CB815E86;
	Sun, 24 Mar 2024 05:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m2rWLvRP"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4821C14AA9
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 05:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711259208; cv=none; b=NQ6lyt4gqqKItaODrBIxhxYwlNIlnAA3HF7HH3amH2XIzGZV+qOA11QbGQt0l83BKhJaF1yjwk+6Wu86ptyOsMMVcWOofzKfpghpuQSRWQCQKrDSym7uUeuNmHc95sRu+tnFCmO/6x9SsCSC2nSsjDMpaB1YzDgJUjN+/5VFxhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711259208; c=relaxed/simple;
	bh=O0XldRplkMLNWV58ngQOMmBKvGWitMJyVzfI5WPr5Yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K8Dr3q7vW+m2ztraEZ2sbItQjeIAD4SuWrGb16EusGpGp55xdane4FTgeDQUHUQcKqCmPZ+zaTosZZkAJgW5rXRCzz7mJv4Z/KGCK/FYaVoX/N0RaeHKz1OhC66VUL1/afjVN/OueJIgZFvuw/M9LJ2AwbPPKbhbtsgcIoyvqXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m2rWLvRP; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e062f3a47bso98195ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 22:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711259206; x=1711864006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dUARXd4gdSbPM+q5LS9OaBlde6RxChbJRkKpkQ0Eh8=;
        b=m2rWLvRPMhkv6HOxec8LpjOsR77IpGpm9rjXx9wL+Ttq2ub4yAks4lCDa4ocWGuZpV
         WTlvzHOFuQoF7TDhnImIyPgtuqPV5XH3Q3vBZmRqNSYeXZ5LH0P0XPnGhQrAcJC+9zhh
         C7g3m5ZfCHv8Im55/XI/4IH2mjoAhvvcxH91s8JmbBMiyXD8dzdlBQeQZghiGICSspOA
         T/W4jfBw8s4MTl1ndZxByIHTmeJTPGKthjSWOrhEmF9zeF+SPgpvM+jtZxCTBIDLot0J
         29wnaJP367oKx1u/mAIlaSIkUve1l38bD4bmGrANqa92cD770AkrOoDAFtbTo/nyD+4D
         SHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711259206; x=1711864006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0dUARXd4gdSbPM+q5LS9OaBlde6RxChbJRkKpkQ0Eh8=;
        b=ZL0FdcJGynaJVkCxRdtDCeBeK1zelPvduqZQtJ/JJLyrMQf455huc68iK5QSzDoPK4
         2vt8f5f3J0LIsNBWKnhetZSyPUBxes9HxufgxvM9mZb7L5fcJAwF+MK2VZEe0DAguOZY
         vcBDyGMNC7etpANWX5jxt9jp9SI4M4sxvG7XpUm9ymRfaHroePfO3/NOzoJPr2oKajoE
         /6PpIWdyXNh9I0miZ/+pfgXSLLye9Qd33wVNA5rpiHj3JDF8+96wkv+Bpavap4McB+Ci
         TGCh1OLci8UOFftbpolr+1rt+mzbs2QEnls2L+YZO9fSyTeiensI7f8Eo04lTS5LYUcR
         qxgw==
X-Forwarded-Encrypted: i=1; AJvYcCWeEFseFQ9FkPanNn8shqpXsdz0eIQK1dkEyvp8mrMVjgLhSgKcbdFKOZ/GjWYu7PNE+ZAEol1e/L4dAr/BUOmkHPRG43wKNWWb3Ai8
X-Gm-Message-State: AOJu0Ywb9+fOb8ZjIz9cUcgozNPZ9XndggU0X6thseM5EtbuZkgRVGZL
	Jtee6mvSxTPynK8IS0RcJmNSCB1MGDkJCZj27WkCd5cQDw0/nHm08Y91lyMdPm90Vbvqn3gSmiq
	35wvVBOnt2YJquKkahBzzkNU8q4efiN0z+5x9
X-Google-Smtp-Source: AGHT+IFOWExseneOH0bN94qKvv3VaKIFnz3HaXYyPDGXlocCZ9qQHN0NxvsWUK3ofddfUvEsNhuI35TweVOZtkNCWow=
X-Received: by 2002:a17:902:ecc6:b0:1de:e36a:d3aa with SMTP id
 a6-20020a170902ecc600b001dee36ad3aamr775557plh.6.1711259205866; Sat, 23 Mar
 2024 22:46:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209031441.943012-1-weilin.wang@intel.com> <20240209031441.943012-14-weilin.wang@intel.com>
In-Reply-To: <20240209031441.943012-14-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 23 Mar 2024 22:46:33 -0700
Message-ID: <CAP-5=fVEDik60cFZHevWDj4OdNynB+LF6r7jkuqc1x6M=4qyGg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 13/15] perf stat: Code refactoring in hardware-grouping
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
> Decouple the step to generate final grouping strings out from the
> build_grouping step so that we could do single metric grouping and then
> merge groups if needed later.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/metricgroup.c | 50 +++++++++++++++++------------------
>  1 file changed, 25 insertions(+), 25 deletions(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index f1eb73957765..cfdbb5f7fb77 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1896,9 +1896,10 @@ static int find_and_set_counters(struct metricgrou=
p__event_info *e,
>  {
>         int ret;
>         unsigned long find_bit =3D 0;
> -
> -       if (e->taken_alone && current_group->taken_alone)
> +       if (e->taken_alone && current_group->taken_alone) {
> +               pr_debug("current group with taken alone event already\n"=
);
>                 return -ENOSPC;
> +       }
>         if (e->free_counter)
>                 return 0;
>         if (e->fixed_counter) {
> @@ -2017,7 +2018,8 @@ static int assign_event_grouping(struct metricgroup=
__event_info *e,
>
>         list_for_each_entry(g, groups, nd) {
>                 if (!strcasecmp(g->pmu_name, e->pmu_name)) {
> -                       pr_debug("found group for event %s in pmu %s\n", =
e->name, g->pmu_name);
> +                       pr_debug("found group header for event %s in pmu =
%s\n",
> +                               e->name, g->pmu_name);
>                         pmu_group_head =3D g;
>                         break;
>                 }
> @@ -2146,26 +2148,22 @@ static int hw_aware_metricgroup__build_event_stri=
ng(struct list_head *group_strs
>   */
>  static int create_grouping(struct list_head *pmu_info_list,
>                           struct list_head *event_info_list,
> -                         struct list_head *groupings,
> -                         const char *modifier)
> +                         struct list_head *grouping)
>  {
>         int ret =3D 0;
>         struct metricgroup__event_info *e;
> -       LIST_HEAD(groups);
>         char *bit_buf =3D malloc(NR_COUNTERS);
>
> -       //TODO: for each new core group, we should consider to add events=
 that uses fixed counters
> +       //TODO: for each new core group, we could consider to add events =
that
> +       //uses fixed counters
>         list_for_each_entry(e, event_info_list, nd) {
>                 bitmap_scnprintf(e->counters, NR_COUNTERS, bit_buf, NR_CO=
UNTERS);
>                 pr_debug("Event name %s, [pmu]=3D%s, [counters]=3D%s, [ta=
ken_alone]=3D%d\n",
>                         e->name, e->pmu_name, bit_buf, e->taken_alone);
> -               ret =3D assign_event_grouping(e, pmu_info_list, &groups);
> +               ret =3D assign_event_grouping(e, pmu_info_list, grouping)=
;
>                 if (ret)
> -                       goto out;
> +                       return ret;
>         }
> -       ret =3D hw_aware_metricgroup__build_event_string(groupings, modif=
ier, &groups);
> -out:
> -       metricgroup__free_group_list(&groups);
>         return ret;
>  };
>
> @@ -2186,9 +2184,8 @@ static bool is_special_event(const char *id)
>   * @groupings: header to the list of final event grouping.
>   * @modifier: any modifiers added to the events.
>   */
> -static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_un=
used,
> -                                 struct list_head *groupings __maybe_unu=
sed,
> -                                 const char *modifier __maybe_unused)
> +static int hw_aware_build_grouping(struct expr_parse_ctx *ctx,
> +                                  struct list_head *grouping)
>  {
>         int ret =3D 0;
>         struct hashmap_entry *cur;
> @@ -2220,8 +2217,7 @@ static int hw_aware_build_grouping(struct expr_pars=
e_ctx *ctx __maybe_unused,
>         ret =3D get_pmu_counter_layouts(&pmu_info_list, ltable);
>         if (ret)
>                 goto err_out;
> -       ret =3D create_grouping(&pmu_info_list, &event_info_list, groupin=
gs,
> -                            modifier);
> +       ret =3D create_grouping(&pmu_info_list, &event_info_list, groupin=
g);
>
>  err_out:
>         metricgroup__free_event_info(&event_info_list);
> @@ -2267,23 +2263,25 @@ static int hw_aware_parse_ids(struct perf_pmu *fa=
ke_pmu,
>  {
>         struct parse_events_error parse_error;
>         struct evlist *parsed_evlist;
> -       LIST_HEAD(groupings);
> +       LIST_HEAD(grouping_str);
> +       LIST_HEAD(grouping);
>         struct metricgroup__group_strs *group;
>         int ret;
>
>         *out_evlist =3D NULL;
> -       ret =3D hw_aware_build_grouping(ids, &groupings, modifier);
> -       if (ret) {
> -               metricgroup__free_grouping_strs(&groupings);
> -               return ret;
> -       }
> +       ret =3D hw_aware_build_grouping(ids, &grouping);
> +       if (ret)
> +               goto out;
> +       ret =3D hw_aware_metricgroup__build_event_string(&grouping_str, m=
odifier, &grouping);
> +       if (ret)
> +               goto out;
>
>         parsed_evlist =3D evlist__new();
>         if (!parsed_evlist) {
>                 ret =3D -ENOMEM;
>                 goto err_out;
>         }
> -       list_for_each_entry(group, &groupings, nd) {
> +       list_for_each_entry(group, &grouping_str, nd) {
>                 struct strbuf *events =3D &group->grouping_str;
>
>                 pr_debug("Parsing metric events '%s'\n", events->buf);
> @@ -2303,7 +2301,9 @@ static int hw_aware_parse_ids(struct perf_pmu *fake=
_pmu,
>  err_out:
>         parse_events_error__exit(&parse_error);
>         evlist__delete(parsed_evlist);
> -       metricgroup__free_grouping_strs(&groupings);
> +out:
> +       metricgroup__free_group_list(&grouping);
> +       metricgroup__free_grouping_strs(&grouping_str);
>         return ret;
>  }
>
> --
> 2.42.0
>

