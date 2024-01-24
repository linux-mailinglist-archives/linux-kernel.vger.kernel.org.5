Return-Path: <linux-kernel+bounces-37525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C55B83B143
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A19081C22DF7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCF1131730;
	Wed, 24 Jan 2024 18:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="U7NLxADn"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5A477F3E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 18:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706121428; cv=none; b=MJJGvASR8DjhEYiKb2oU+/C3fb964TwaBX858GkCUO+LmVsmYFbrB9I5kN3dKvshQ2FQykoG3qq09HWrg0iAwd5Be0yZUmTaW89pzgGxLChY1A7D0XhZ8+iyfdhMEQAQTYCZzMhsc40Z564sxIodCs2BR64V/anFKRESkfQZDrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706121428; c=relaxed/simple;
	bh=T/o6Qsq0W2hymOaLp02g4fovPXgDUYeIHFNN8KhMRyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TVbInTWoU89SjpA7TEIcYA1PXSnndZNuiC0IYkzpGfg7reQf6c8iZ01Oe6tFAQFdKazOsI3nsI6+2FoZ6+xPOcfZUEgmP6XtPVayg22oOk6UYlr9DdksuBJ6AA1Oxu53Nkhih+rIZKZ0Fwd6fUkal3s12S7hyTBcwY/b1nPtFJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U7NLxADn; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-361b23b9328so5895ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 10:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706121426; x=1706726226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fp9O201GdAOPAy/wQ9YQYfW1NpxoLVvkuKvh+iJBzfY=;
        b=U7NLxADnnCbla5M/UZGEGI0eHts+vxQp0++jEfrh5yGdcmwPLVOXV68UTSdSOa2TXL
         aQOvDxXR+jEL+kU0tNtmDI36G17vjChYMqPFIWAHLqjz6TKkVBE8IFIg5M8iUPex0ews
         VtNZz/DOSUAQN32ZpzqZrEHOcb2qlJXuVjAyLoNgOofw0t0A7dEGAmqftzX+LXk7Zqhk
         KxM1gqPcJ7p6OWXHldFvRm/aFub9HtNMH4oZgfOmESLv18o3DxSO6KSa0mCjHMwei0bi
         JMnfirZWs+aLGXmWXZGEJopoUK+g3+NEPSSiL5CsQVaxCu/cVrQj+BDUyD7WEyf9OY1k
         btzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706121426; x=1706726226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fp9O201GdAOPAy/wQ9YQYfW1NpxoLVvkuKvh+iJBzfY=;
        b=RwGiV3pM44CPNqKye6cPcNBjhUUXiArL+ia8cl6VB7Q4NBdH5/o3jKIyZialy828yN
         3cqqVwz2jIQSUpMhSmugIJrTEpMmo4RhBmTg5tKHv5QOduPcEILrLUL+W39y3qT+E7I8
         DEqREVlBaS2zXx9PBwv5RhmkvDS1p8IVli3zs0p78GizMcvEoFCK7w2VQKcgSzbMYBYg
         ZV5Mc9p1PmCqIb9cVu9Xkv2PSSLu5/r+AiBM6NB4fIBpsNqxg5EIEWeegz58vjy5r6iY
         9B0fN1jkacmloUE99/JmM5weiKn1eIuswubFEsoGPXFElPEAAZUG+jugqqZiUS1IDuiW
         jK8g==
X-Gm-Message-State: AOJu0Yz/mAO/9+3PQmSAdoi70YnO3hajlZsHjK/fj8I91gq+3D2MXtGL
	VcwgT0MpcfjK4VWy6VAHnYytNeGQoNDQ/SegRkfoSyZCGmX9xBSNcVpOPrw0mXtjupQNt/AzzBS
	huJaXnR45PBLe47976ZFAVgOKmUbBx+LI1hUh
X-Google-Smtp-Source: AGHT+IGQPYi5CEBiSsdQwWfNVxRWBpiOM7bWVEh2LqkmqlKo/dlvOnYQ1qSpbhY82zyDnIPnWvyvjIArlyIRiauFzL4=
X-Received: by 2002:a05:6e02:142:b0:360:61f5:91ed with SMTP id
 j2-20020a056e02014200b0036061f591edmr16088ilr.28.1706121426245; Wed, 24 Jan
 2024 10:37:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212230224.1473300-1-weilin.wang@intel.com> <20231212230224.1473300-12-weilin.wang@intel.com>
In-Reply-To: <20231212230224.1473300-12-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 24 Jan 2024 10:36:54 -0800
Message-ID: <CAP-5=fXncZ1eqSzsv6YFy1=6z4va_LJjAP9Zr2PVw6LJdp3x-w@mail.gmail.com>
Subject: Re: [RFC PATCH v3 10/18] perf stat: Add build string function and
 topdown events handling in hardware-grouping
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
> Add the function to generate final grouping strings. This function is
> very similar to the existing metricgroup__build_event_string() function.
> The difference is that the input data includes a list of grouping lists.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

> ---
>  tools/perf/util/metricgroup.c | 96 +++++++++++++++++++++++++++++++++--
>  1 file changed, 93 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index 9d06fe4488dc..5d9ed22963be 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1899,6 +1899,96 @@ static int assign_event_grouping(struct metricgrou=
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
> +                       ret =3D strbuf_addf(events, "}:W");
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
> @@ -1910,8 +2000,8 @@ static int assign_event_grouping(struct metricgroup=
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
> @@ -1927,6 +2017,7 @@ static int create_grouping(struct list_head *pmu_in=
fo_list,
>                 if (ret)
>                         goto out;
>         }
> +       ret =3D hw_aware_metricgroup__build_event_string(groupings, modif=
ier, &groups);
>  out:
>         metricgroup__free_group_list(&groups);
>         return ret;
> @@ -1957,7 +2048,6 @@ static int hw_aware_build_grouping(struct expr_pars=
e_ctx *ctx __maybe_unused,
>                 const char *id =3D cur->pkey;
>
>                 pr_debug("found event %s\n", id);
> -

nit: unnecessary whitespace change for the patch

>                 ret =3D get_metricgroup_events(id, etable, &event_info_li=
st);
>                 if (ret)
>                         goto err_out;
> --
> 2.39.3
>

