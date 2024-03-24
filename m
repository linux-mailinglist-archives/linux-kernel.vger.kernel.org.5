Return-Path: <linux-kernel+bounces-112567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C779887B8E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 04:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B28AB20CDF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 03:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B9A3D76;
	Sun, 24 Mar 2024 03:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EyZlVcOf"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA8D17F3
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 03:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711251930; cv=none; b=sdCL68Tx47BvxhohPj218K2TJHch50Fb+63XJCxRI6iCFE4EtkW+9m+68ZXu0FbeqBK7ziZNzbtn6sFCJtIOqJfnkJF8/MVNzeRKbORjqkH8hQvwYWWni/Ks0N2RKW6Sp4+/GsQjwPdkyqTKQRkO83HsucFrwlc0oYtZLu2Wdio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711251930; c=relaxed/simple;
	bh=iUzFpA4Fu9YSmQkZKCSOgGKftUekVbN3SUQ87quTRH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l93OqGvtAWijo4KKBnohVOst53Std5h1bslgiNljyUxe52jq5Dl0b5F+pPJtdy3wXRRclsg/Dq7JGNn/oxftTTd2DG3QAV3XZ+Wo1oBDvzL+3uD8d4Lf2+Btn/hCW3lIN/7CbvugOrycbRi1W/fjiuLSHg0IObeWAmUNujl8W2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EyZlVcOf; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3686ad91b9bso140765ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 20:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711251928; x=1711856728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZCokTmZle4WRUisGL16ZDZ627DO4HnlPXhDi+B1ycU=;
        b=EyZlVcOfn2+UYty3BpUX1+7YyL3lxQjtz8AUUZel2B/mIOJAMY+lZ9OWrbHvGiMGzc
         zvNw+RsA29fgra0RFXlwmVsBB2ganmy4MzWMU13uJHGT8JXIK3tiv+bNv8JfNAtllEos
         cn5c0H/DH6nY+XLAJprv/Y9tWKuyIFMvpEEdGITOa+bj0Bt6tWCFVh0OQzGTXjRC0suE
         h4Usmmqu4hnATBbFVjCvrs+d1HDohMP4JCwfNSInUmwngVDyd8IBEW96ubyU5ZhWOyLC
         MB57+kMQCKP/eUyt0lMTFPu1p+lgK/Ezi43PApZUVDkcMxMaV1gdG+rYLmms9/V3cMEY
         n8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711251928; x=1711856728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZCokTmZle4WRUisGL16ZDZ627DO4HnlPXhDi+B1ycU=;
        b=DsQgLD4IsOJxzQGN95OSDK0n6a0uXlhspaHLLxk1C2EtlV33z+63i165heWGzmlIqK
         Kbu+oWhChMnRRsjLPWY8BN61Ru249d08PT6EwFFzpNpDLM5WY+TfXA4ZBi5Q+foy49M3
         0M2hXp/n4rJRw9hhUosntPidorLCraHUX6cNDCJ2JAg9j2uHFOAwZbWMUPNl8K8mMUMC
         reOyTC+gJ9oAn9S4s3/3MiVrQ0BQ0pe9T+AYq+vZu++BmkQIrK3T1fDqH5+Qo1DDhe8g
         dlFtRl5TivoIkY3cx7ZsqNzIgzBF6rHfw1gYPj7IOHP5rhLfp1Ro+tunQIxTVlKEqg6Y
         0TGA==
X-Forwarded-Encrypted: i=1; AJvYcCWT0hwvbhxHNO39i4gHchxKA3T4oPE/zFtnjSwFbqyQTRBi/E5WoXH1F5oFTbuyzaM42DDvcbGMAs/CUiktOjYTxMxwcPOAshdw2rrf
X-Gm-Message-State: AOJu0YzIMUvnWZjCIEfIZhc1BspuABX5B51b9toliRWilfFAhvAKa5jg
	dLIDf+WATRxr5ur3TdN+P7qM6loH8cc81L01T1bHNK5wsdNIx1WM7s3lWTv99T1oHPS0EqVjCCy
	z1G/1p/kVnnqsIDmH+bH2ycZ4U6d1k0VY8r6cVKLH6gfuszoWAdMe
X-Google-Smtp-Source: AGHT+IEgum0vXLed6NbuUwGmJ7FXxoDws9TF50Q15ohjHnrKGyAZHh3ZXJb/gugHgM0BpVGrx3rlI3tuTpp/saspbHE=
X-Received: by 2002:a05:6e02:12e4:b0:366:526f:17b2 with SMTP id
 l4-20020a056e0212e400b00366526f17b2mr815554iln.9.1711251928224; Sat, 23 Mar
 2024 20:45:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312234921.812685-1-weilin.wang@intel.com> <20240312234921.812685-4-weilin.wang@intel.com>
In-Reply-To: <20240312234921.812685-4-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 23 Mar 2024 20:45:14 -0700
Message-ID: <CAP-5=fVmnAaJAuC5oZcP7H3BVz3+8n5zVu_UxZTyXsS3LEj3TA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 3/6] perf stat: Add retire latency values into the
 expr_parse_ctx to prepare for final metric calculation
To: weilin.wang@intel.com
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 4:49=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> Retire latency values of events are used in metric formulas. This update =
adds
> code to process data from perf record for required retire latency values.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/perf/builtin-stat.c     |  1 +
>  tools/perf/util/metricgroup.h |  1 +
>  tools/perf/util/stat-shadow.c | 19 +++++++++++++++++++
>  3 files changed, 21 insertions(+)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 4e92e73cbeaf..a479b21874b0 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -786,6 +786,7 @@ static int process_sample_event(struct perf_tool *too=
l __maybe_unused,
>                 if (!strcmp(evname, t->name)) {
>                         t->count +=3D 1;
>                         t->sum +=3D sample->retire_lat;
> +                       t->val =3D (double) t->sum / t->count;
>                         break;
>                 }
>         }
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.=
h
> index 3c37d80c4d34..38f9134d8b54 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -82,6 +82,7 @@ struct tpebs_retire_lat {
>         const char *tpebs_name;
>         size_t count;
>         int sum;
> +       double val;

Given the similarity of count, sum and val it would be good to document the=
m.

>  };
>
>  struct metric_event *metricgroup__lookup(struct rblist *metric_events,
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.=
c
> index 3466aa952442..8fc3415de106 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -355,6 +355,20 @@ static void print_nsecs(struct perf_stat_config *con=
fig,
>                 print_metric(config, ctxp, NULL, NULL, "CPUs utilized", 0=
);
>  }
>
> +static int prepare_retire_lat(struct expr_parse_ctx *pctx,
> +                            struct list_head *retire_lats)
> +{
> +       int ret =3D 0;
> +       struct tpebs_retire_lat *t;
> +
> +       list_for_each_entry(t, retire_lats, nd) {
> +               ret =3D expr__add_id_val(pctx, strdup(t->tpebs_name), t->=
val);
> +               if (ret < 0)
> +                       return ret;
> +       }
> +       return ret;
> +}
> +
>  static int prepare_metric(const struct metric_expr *mexp,
>                           const struct evsel *evsel,
>                           struct expr_parse_ctx *pctx,
> @@ -486,6 +500,11 @@ static void generic_metric(struct perf_stat_config *=
config,
>                 pctx->sctx.user_requested_cpu_list =3D strdup(config->use=
r_requested_cpu_list);
>         pctx->sctx.runtime =3D runtime;
>         pctx->sctx.system_wide =3D config->system_wide;
> +       i =3D prepare_retire_lat(pctx, &config->tpebs_results);
> +       if (i < 0) {
> +               expr__ctx_free(pctx);
> +               return;
> +       }
>         i =3D prepare_metric(mexp, evsel, pctx, aggr_idx);
>         if (i < 0) {
>                 expr__ctx_free(pctx);
> --
> 2.43.0
>

