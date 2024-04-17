Return-Path: <linux-kernel+bounces-147971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0268A7BFB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6300281DC4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF2D535A9;
	Wed, 17 Apr 2024 05:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="F5YpazE7"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECC35339F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 05:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713333423; cv=none; b=FcIMSEHW2Jzvig7YMwSOyxpK9XpGjhpfTMWtsYsE3AhAYMw1Kvl/DFKUetXjECfRwSXKyUzRiaX2OTI8nVWhO2VJtQxXYIm6Cde6ZqOAI4yvqKXi4wdTtxaYOLhK6HPvbjAV0RK5Cq/jt1I5zEujz3wDtILNjg6q+sElQzZVg5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713333423; c=relaxed/simple;
	bh=lm54SJ/O7IYMxp/QB0zKZ2/bJKy0bBQjO5RzxEeUHe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgDAyjGqc0UBrnzps5gcUZfbx0FghDSyq/UZUwri9tZy1Sx9TFyGwD/rsKpWgDgb5aFEio7hrdjz5FEZFHYN1H6DmHKgVWLBbSXKawpULdWADC8hWqBUSUxArjeXBjTEFwS/96TC/8j0tnE/ngSjlWAzvAdqoAIRTRL+CXvwLiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F5YpazE7; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-434b5abbb0dso182921cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 22:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713333421; x=1713938221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idWSq/0o9oIFgx3nMvgu9dbZngn+bQQVL+s5Mq9Jbbo=;
        b=F5YpazE7itnfPCHEYsy/JG3HyYBbJr7vBPL1BV7LAhORcFQUXXIM3Gj4jol0fCjU7t
         Ug8xnIHFV3lSTDYPBWQSiIQYpO0ZHIXDt/R7+kBiWCULk0hv+pSIvj2DNst2rohc3V9h
         wdOSgm8zpFP/00wm1K/W3GjbsInpZRucffDbblFY3Xs7p+1XiJlOiAKO4x1m8cHPXr1y
         O6O609UhWggvcMi/Yaz0lewq/K7Kc5UyP/HOxaYDtab8+3awoLgzvEBOk5n4z9iZ1MMu
         pwkiUxWEbIRy/lzag2IbdQxJFz5umBqzPYiORderizv1e0qtlN6GAIhkv7KwuwcuUEkd
         n7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713333421; x=1713938221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=idWSq/0o9oIFgx3nMvgu9dbZngn+bQQVL+s5Mq9Jbbo=;
        b=UVEoX4eXDBdlsyVcpmcGBfcb63X+YdcDK3ej+xi/rTbWJJ8AX42jEn7DMkP8FjQOxE
         xvZrFq1fYVUBOY1jm8y77QvWe3oBX3fHXZQ/aOFu07nUSE7lAnFqwQlfYdEVl8+FZh/i
         wiFwKNrS1x02FSpD7GA4u1kNMJRJp1KRvYNVUHJs0JW2hU/BukHcJVIC31FeIBcM+1hN
         LeIvW6B8cRLlW8GF4dhkyFIEe+Lfsk8MHUtmh0E/bWXreQRuvZdYa3xBovsCe/6Wzq6S
         RELvs41LrJurPZP7qAMrn966pQybVkOAFu+zrEfUhqenYiQ95S5+/S5X84AO+K0YVrVH
         oY1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVfFo61WwmahFNIdXR/e23D0krTm4yI7pz/HhFZ+ph6CwadF822iBw099sbs2Qg+lGQa2DHmpeUF6UL23lfO8lC4MGOzwLSepc95Ag8
X-Gm-Message-State: AOJu0YyYywqqW5AeL7Tbn9VyJyX6kVH/gzvOVDsVEkruBk30LVqAsBs+
	sHgBgHo1rOC/3EKRUTw1r3ByD5C/j5DTKiRUjY3leixPh4CY0dDSNC+rSIPh6z2kr3WCevlaKd0
	2XVPfakUM/AR6jE2OQwmRFjcsAW8kJLiBB2eq
X-Google-Smtp-Source: AGHT+IFIcZG/e2Y0dUnbYeOk4YZExQx85btZ2aS9xsScxkv0eFijeaSC4OKQGoXtPncNvu8Pbp1WHlWznhTlm09gGos=
X-Received: by 2002:a05:622a:118c:b0:434:3f4c:6f33 with SMTP id
 m12-20020a05622a118c00b004343f4c6f33mr211141qtk.16.1713333420800; Tue, 16 Apr
 2024 22:57:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412210756.309828-1-weilin.wang@intel.com> <20240412210756.309828-9-weilin.wang@intel.com>
In-Reply-To: <20240412210756.309828-9-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 16 Apr 2024 22:56:46 -0700
Message-ID: <CAP-5=fUKsLjPi3Q4ObkdtciuoiNh++REzXkM97mgi-4+XrUQVw@mail.gmail.com>
Subject: Re: [RFC PATCH v5 08/16] perf stat: Add build string function and
 topdown events handling in hardware-grouping
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
> Add the function to generate final grouping strings. This function is
> very similar to the existing metricgroup__build_event_string() function.
> The difference is that the input data includes a list of grouping lists.
>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/perf/util/metricgroup.c | 97 +++++++++++++++++++++++++++++++++--
>  1 file changed, 93 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index 88c86664c90c..04d988ace734 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -2018,6 +2018,96 @@ static int assign_event_grouping(struct metricgrou=
p__event_info *e,
>         return ret;
>  }
>
> +static int hw_aware_metricgroup__build_event_string(struct list_head *gr=
oup_strs,
> +                                          const char *modifier,
> +                                          struct list_head *groups)
> +{
> +       struct metricgroup__pmu_group_list *p;
> +       struct metricgroup__group *g;
> +       struct metricgroup__group_events *ge;
> +       bool no_group =3D true;
> +       int ret =3D 0;
> +
> +#define RETURN_IF_NON_ZERO(x) do { if (x) return x; } while (0)
> +
> +       list_for_each_entry(p, groups, nd) {
> +               list_for_each_entry(g, &p->group_head, nd) {
> +                       struct strbuf *events;
> +                       struct metricgroup__group_strs *new_group_str =3D
> +                               malloc(sizeof(struct metricgroup__group_s=
trs));
> +
> +                       if (!new_group_str)
> +                               return -ENOMEM;
> +                       strbuf_init(&new_group_str->grouping_str, 0);
> +                       events =3D &new_group_str->grouping_str;
> +                       ret =3D strbuf_addch(events, '{');
> +                       RETURN_IF_NON_ZERO(ret);
> +                       no_group =3D true;
> +                       list_for_each_entry(ge, &g->event_head, nd) {
> +                               const char *sep, *rsep, *id =3D ge->event=
_name;
> +
> +                               pr_debug("found event %s\n", id);
> +
> +                               /* Separate events with commas and open t=
he group if necessary. */
> +                               if (!no_group) {
> +                                       ret =3D strbuf_addch(events, ',')=
;
> +                                       RETURN_IF_NON_ZERO(ret);
> +                               }
> +                               /*
> +                                * Encode the ID as an event string. Add =
a qualifier for
> +                                * metric_id that is the original name ex=
cept with characters
> +                                * that parse-events can't parse replaced=
 For example,
> +                                * 'msr@tsc@' gets added as msr/tsc,metri=
c-id=3Dmsr!3tsc!3/
> +                                */
> +                               sep =3D strchr(id, '@');
> +                               if (sep) {
> +                                       ret =3D strbuf_add(events, id, se=
p - id);
> +                                       RETURN_IF_NON_ZERO(ret);
> +                                       ret =3D strbuf_addch(events, '/')=
;
> +                                       RETURN_IF_NON_ZERO(ret);
> +                                       rsep =3D strrchr(sep, '@');
> +                                       ret =3D strbuf_add(events, sep + =
1, rsep - sep - 1);
> +                                       RETURN_IF_NON_ZERO(ret);
> +                                       ret =3D strbuf_addstr(events, ",m=
etric-id=3D");
> +                                       RETURN_IF_NON_ZERO(ret);
> +                                       sep =3D rsep;
> +                               } else {
> +                                       sep =3D strchr(id, ':');
> +                                       if (sep) {
> +                                               ret =3D strbuf_add(events=
, id, sep - id);
> +                                               RETURN_IF_NON_ZERO(ret);
> +                                       } else {
> +                                               ret =3D strbuf_addstr(eve=
nts, id);
> +                                               RETURN_IF_NON_ZERO(ret);
> +                                       }
> +                                       ret =3D strbuf_addstr(events, "/m=
etric-id=3D");
> +                                       RETURN_IF_NON_ZERO(ret);
> +                               }
> +                               ret =3D encode_metric_id(events, id);
> +                               RETURN_IF_NON_ZERO(ret);
> +                               ret =3D strbuf_addstr(events, "/");
> +                               RETURN_IF_NON_ZERO(ret);
> +
> +                               if (sep) {
> +                                       ret =3D strbuf_addstr(events, sep=
 + 1);
> +                                       RETURN_IF_NON_ZERO(ret);
> +                               }
> +                               if (modifier) {
> +                                       ret =3D strbuf_addstr(events, mod=
ifier);
> +                                       RETURN_IF_NON_ZERO(ret);
> +                               }
> +                               no_group =3D false;
> +                       }
> +                       ret =3D strbuf_addf(events, "}");
> +                       RETURN_IF_NON_ZERO(ret);
> +                       pr_debug("events-buf: %s\n", events->buf);
> +                       list_add_tail(&new_group_str->nd, group_strs);
> +               }
> +       }
> +       return ret;
> +#undef RETURN_IF_NON_ZERO
> +}
> +
>  /**
>   * create_grouping - Create a list of groups and place all the events of
>   * event_info_list into these groups.
> @@ -2029,8 +2119,8 @@ static int assign_event_grouping(struct metricgroup=
__event_info *e,
>   */
>  static int create_grouping(struct list_head *pmu_info_list,
>                           struct list_head *event_info_list,
> -                         struct list_head *groupings __maybe_unused,
> -                         const char *modifier __maybe_unused)
> +                         struct list_head *groupings,
> +                         const char *modifier)
>  {
>         int ret =3D 0;
>         struct metricgroup__event_info *e;
> @@ -2046,6 +2136,7 @@ static int create_grouping(struct list_head *pmu_in=
fo_list,
>                 if (ret)
>                         goto out;
>         }
> +       ret =3D hw_aware_metricgroup__build_event_string(groupings, modif=
ier, &groups);
>  out:
>         metricgroup__free_group_list(&groups);
>         return ret;
> @@ -2075,8 +2166,6 @@ static int hw_aware_build_grouping(struct expr_pars=
e_ctx *ctx __maybe_unused,
>         hashmap__for_each_entry(ctx->ids, cur, bkt) {
>                 const char *id =3D cur->pkey;
>
> -               pr_debug("found event %s\n", id);
> -

Looks like these 2 lines got removed by accident.

Thanks,
Ian

>                 ret =3D get_metricgroup_events(id, etable, &event_info_li=
st);
>                 if (ret)
>                         goto err_out;
> --
> 2.42.0
>

