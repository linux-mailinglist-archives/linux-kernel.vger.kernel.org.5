Return-Path: <linux-kernel+bounces-99900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE871878EEF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD5621C20BF7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8BC69952;
	Tue, 12 Mar 2024 06:49:21 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468F169944;
	Tue, 12 Mar 2024 06:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710226160; cv=none; b=ht13XW5F49VDXK71gjpWCgca30CnDgIElpqQciHZp9JkXKGjNvL7p15gEDF+dBvYY72liwMOqQtM47RE2b8oIEGJg+RdmIV70/5kUR53K5n7ljI/mJwJORlWrBPaY/D5ClCOGrLzrzsfDJS9nZx35RzdSOsEwSlSyKSE4qBAXUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710226160; c=relaxed/simple;
	bh=NpTpzOFpjTFaXZX5FuKeyjBow4yCTS2iQk19N51842M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qm6RATTZhK5q11FMjgwGyYUD4Qxn62wzHSKjCekh8+WtlFWCGBEz5JcjT/Pzoa2tnMPu70bCeJ3iwWCeeVHxsy7oSUYkxPAJ1HZThMdUWhVpHRuNda3m/2tcexCBhN9F98C0zHjq1PvFX3vfC5cwEYKC2x0/0752C+hWAbwoaZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso4414152a12.2;
        Mon, 11 Mar 2024 23:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710226158; x=1710830958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dcrdLEFHw+u0g7KmoV4uvHmtfMU74jrO4Ftzic9JdHY=;
        b=w+JzyRFAPkfsyHTDa7K2jJxbjZ2OMTpi2ey3NeG7PKw1/twG4l99XDfJok+8wPbGzf
         oysxQq3OO0A5lSPo/ryfCLVTYSLeSWFq6plnNkwZDMgChAmdQolJMPaCKeuio6nTmOiC
         Y5LaXs6LJ3ibuRAFVp8bI6tEfVj0Srm5VLY7DDXSBNaFoUquMd5yuSgzsnS9I9/0ij7p
         Unv1XD98YTxaVd+HFONypE8+n0AodXkeR0kq9ZZCzWyY7bObN1usXmlZa7wLicuaWHj/
         AheWs1wzGIxX89qlHW/Kux5Ol2rNAMCaZnBrucmvo1DPf2xnmaHGUYJC+4B95gUFyK3u
         XQ0g==
X-Forwarded-Encrypted: i=1; AJvYcCV7CKA792BUj2v8FumZXxp0apr1UL2avnFuG2nibVYQSwbpIPU/4z6CXrtBSSS8E8htGsjsZXEouSCfCZTe0GmLTEIUzrYR26Ql3Fczoh4+33EMXqpEvUE9MgpshbN1i+LnbAU4caZNMtGOze9MEA==
X-Gm-Message-State: AOJu0YyFIf2KqGlxUtiwqadtAZ/jg9vATCykvcKvs0ShixhgD1pnDDO9
	AfWokTctrVJ34WFvhI0Ycuk8pyB+w6tyLzPobpZFT6tIkU8c/J0P37LNgvtx85w2k1WoHnQjMiV
	XJl6tzNh9uLyFjJ86VF1VL6GULbs=
X-Google-Smtp-Source: AGHT+IHEEQ4htWFGblRT2MDrS6Alav/pYfvCk8JQ92wqkOomZN63ZSyGvbrCmp/vxvJ76Dpnic40NYf7b1gVWwK3A14=
X-Received: by 2002:a05:6a20:2443:b0:1a1:847f:8e8c with SMTP id
 t3-20020a056a20244300b001a1847f8e8cmr10907618pzc.20.1710226158531; Mon, 11
 Mar 2024 23:49:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240302001139.604829-1-weilin.wang@intel.com> <20240302001139.604829-6-weilin.wang@intel.com>
In-Reply-To: <20240302001139.604829-6-weilin.wang@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 11 Mar 2024 23:49:07 -0700
Message-ID: <CAM9d7ciP5HJP__Hoh70q5F2drCwtyqzSmvLzMS06dvkYeVu2-g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 5/6] perf stat: Add retire latency print functions
 to print out at the very end of print out
To: weilin.wang@intel.com
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 4:11=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> Add print out functions so that users could read retire latency values.

Can you please put some example output here?

Thanks,
Namhyung


>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/perf/util/stat-display.c | 65 ++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
> index bfc1d705f437..e2996ba67bfe 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -21,6 +21,7 @@
>  #include "iostat.h"
>  #include "pmu.h"
>  #include "pmus.h"
> +#include "metricgroup.h"
>
>  #define CNTR_NOT_SUPPORTED     "<not supported>"
>  #define CNTR_NOT_COUNTED       "<not counted>"
> @@ -34,6 +35,7 @@
>  #define COMM_LEN     16
>  #define PID_LEN       7
>  #define CPUS_LEN      4
> +#define RETIRE_LEN    8
>
>  static int aggr_header_lens[] =3D {
>         [AGGR_CORE]     =3D 18,
> @@ -426,6 +428,67 @@ static void print_metric_std(struct perf_stat_config=
 *config,
>         fprintf(out, " %-*s", METRIC_LEN - n - 1, unit);
>  }
>
> +static void print_retire_lat_std(struct perf_stat_config *config,
> +                                struct outstate *os)
> +{
> +       FILE *out =3D os->fh;
> +       bool newline =3D os->newline;
> +       struct tpebs_retire_lat *t;
> +       struct list_head *retire_lats =3D &config->tpebs_results;
> +
> +       list_for_each_entry(t, retire_lats, nd) {
> +               if (newline)
> +                       do_new_line_std(config, os);
> +               fprintf(out, "%'*.2f %-*s", COUNTS_LEN, t->val, EVNAME_LE=
N, t->name);
> +               fprintf(out, "%*ld %*d\n", RETIRE_LEN, t->count,
> +                        RETIRE_LEN, t->sum);
> +       }
> +}
> +
> +static void print_retire_lat_csv(struct perf_stat_config *config,
> +                                struct outstate *os)
> +{
> +       FILE *out =3D os->fh;
> +       struct tpebs_retire_lat *t;
> +       struct list_head *retire_lats =3D &config->tpebs_results;
> +       const char *sep =3D config->csv_sep;
> +
> +       list_for_each_entry(t, retire_lats, nd) {
> +               fprintf(out, "%f%s%s%s%s%ld%s%d\n", t->val, sep, sep, t->=
name, sep,
> +                       t->count, sep, t->sum);
> +       }
> +}
> +
> +static void print_retire_lat_json(struct perf_stat_config *config,
> +                                 struct outstate *os)
> +{
> +       FILE *out =3D os->fh;
> +       struct tpebs_retire_lat *t;
> +       struct list_head *retire_lats =3D &config->tpebs_results;
> +
> +       fprintf(out, "{");
> +       list_for_each_entry(t, retire_lats, nd) {
> +               fprintf(out, "\"retire_latency-value\" : \"%f\", ", t->va=
l);
> +               fprintf(out, "\"event-name\" : \"%s\"", t->name);
> +               fprintf(out, "\"sample-counts\" : \"%ld\"", t->count);
> +               fprintf(out, "\"retire_latency-sum\" : \"%d\"", t->sum);
> +       }
> +       fprintf(out, "}");
> +}
> +
> +static void print_retire_lat(struct perf_stat_config *config,
> +                            struct outstate *os)
> +{
> +       if (!&config->tpebs_results)
> +               return;
> +       if (config->json_output)
> +               print_retire_lat_json(config, os);
> +       else if (config->csv_output)
> +               print_retire_lat_csv(config, os);
> +       else
> +               print_retire_lat_std(config, os);
> +}
> +
>  static void new_line_csv(struct perf_stat_config *config, void *ctx)
>  {
>         struct outstate *os =3D ctx;
> @@ -1609,6 +1672,8 @@ void evlist__print_counters(struct evlist *evlist, =
struct perf_stat_config *conf
>                 break;
>         }
>
> +       print_retire_lat(config, &os);
> +
>         print_footer(config);
>
>         fflush(config->output);
> --
> 2.43.0
>

