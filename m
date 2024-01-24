Return-Path: <linux-kernel+bounces-37505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C9983B105
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED0071C221B9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D296512AADA;
	Wed, 24 Jan 2024 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="097l/vib"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779201272DD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 18:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706120593; cv=none; b=gm/N/ZpD0ADsl62sE9lqhAwHpWtlf2DicFIbeBJzNQ8kb2r52twK/mAtzWuJPCt0Y52czFid+La/iuSL+lUrKYOyktri/NiKubscaKZBXDcTW6RsOll7dMqrNELOEtaO/EQrYQ4F2oTNAjQHTRVqKkoO+xxuAXxw4QL8JZx33hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706120593; c=relaxed/simple;
	bh=2mXvrAHHwck2/+NZUSDwz1ny21p8dc8cBOMPp/7aqvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W2mfQPRfqHxjom36B5tsYey4dkNFeHzQf7Q49LcTooQMMSus8rBUuPc912S/wfN2m+PtQoHavqtDiWr0nIAyCUqOo4OV9S9x2BWu6dFMOS8/q0niFOCmW04h/g11hHrQdeJWeKMsmqjhDh2WZr3CpkFige3SoVrpLUinuJNTsnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=097l/vib; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d72d240c69so7215ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 10:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706120591; x=1706725391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBSlGGzC+ndsfxMntMp63Rfkey8ww42uOli1u6PEN00=;
        b=097l/vibJUV614gykJEaTlVs6BqkaMBIUeywHHtJgZ5XKF94DtX6puy3c2mBtFi+cw
         di21L+0RxqAeUiXeyyKJRuqYclXkDDjjTVO37lHe9Nth4Hpa5o1RcOk5Hlf9eAXVHTwc
         vwrd3lR4e9Al23IJBB5KwOyJjayWWiLgS266YCcQuF/oMIujiP5y/BWrBUa0pqlx+Pj9
         d6t47R+QadTEbmt3F+PoryWVHUT5x215B/enEUFaGacELjxDrhd3zCOqO/CtAJN9iqm2
         jNVpc4ARzeqkFGar6C3CWM+TJcdTGcbAVTKM0mlQBk3RBlX309L9r+HSyMEUjAuNxJFO
         pZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706120591; x=1706725391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBSlGGzC+ndsfxMntMp63Rfkey8ww42uOli1u6PEN00=;
        b=ls/0oEotSjoR0bYDNPExX2eW7GZhfme1stSanXZlncpsNVgdtXBdGJiDYvaFzT/Dni
         VmVaNNJ15TCbWx1x1muIrv0NXVyV6LVoMzgBYzzN0JHu/mspx/BXout3nFlnyY58qkEm
         Yp1zhGrWjYx/pjbAM4OALCtrb1KehHTMN6t3lXAmA+/vMMK9Iax6GT7SNsx+RJZHJgm4
         39HIZuyrfozdwQ8vMM1ptiInQ+EkOkqK1unyywWRv1bMwJVJkH+gVJvLjXJjzMPHi+Xg
         /20kAfmeNzuJQKxkeB5zTXhReNisc+WJ+wIRiDEKUWXIFULjuZVZxjhp8k1tC8Fp2hiW
         /d7g==
X-Gm-Message-State: AOJu0YzR+uI24OxVHTZJ1CiGnE2oH2ONVzhVrfUdN/OGkj6Vup5qo4fs
	Ms7kUeQ6q+2kWq2u00ws7+Xn56yd8M6Z1nLjnY4T5zzt4wDCqA0CsCsD7+J0LEVlM+AG8jekY6q
	FqHuShjcO6qPN06QA3E9W/ro4Fg+jhZYEgK5J
X-Google-Smtp-Source: AGHT+IGB8cGJJ/pFXDswRQL3IHeDH/3NQA7pnTuUCdyhwdXibmDEqjKMpvDavHlMfPT5MSYOfGyDn+hWonc7OGeb7BU=
X-Received: by 2002:a17:902:ec84:b0:1d7:4b04:108e with SMTP id
 x4-20020a170902ec8400b001d74b04108emr186100plg.15.1706120590477; Wed, 24 Jan
 2024 10:23:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123185036.3461837-1-kan.liang@linux.intel.com> <20240123185036.3461837-7-kan.liang@linux.intel.com>
In-Reply-To: <20240123185036.3461837-7-kan.liang@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 24 Jan 2024 10:22:59 -0800
Message-ID: <CAP-5=fWhvkeo7CCcn0p4+fSo9vv7G9t9Pvp4HxjahfKTCr14ug@mail.gmail.com>
Subject: Re: [PATCH V4 6/7] perf mem: Clean up perf_mem_events__record_args()
To: kan.liang@linux.intel.com
Cc: acme@kernel.org, namhyung@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	john.g.garry@oracle.com, will@kernel.org, james.clark@arm.com, 
	mike.leach@linaro.org, leo.yan@linaro.org, yuhaixin.yhx@linux.alibaba.com, 
	renyu.zj@linux.alibaba.com, tmricht@linux.ibm.com, ravi.bangoria@amd.com, 
	atrajeev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 10:51=E2=80=AFAM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The current code iterates all memory PMUs. It doesn't matter if the
> system has only one memory PMU or multiple PMUs. The check of
> perf_pmus__num_mem_pmus() is not required anymore.
>
> The rec_tmp is not used in c2c and mem. Removing them as well.
>
> Suggested-by: Leo Yan <leo.yan@linaro.org>
> Tested-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks for the cleanup!
Ian

> ---
>  tools/perf/builtin-c2c.c     | 15 ++-------------
>  tools/perf/builtin-mem.c     | 18 ++----------------
>  tools/perf/util/mem-events.c | 34 ++++++++++++----------------------
>  tools/perf/util/mem-events.h |  3 +--
>  4 files changed, 17 insertions(+), 53 deletions(-)
>
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 838481505e08..3bcb903b6b38 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -3245,9 +3245,8 @@ static const char * const *record_mem_usage =3D __u=
sage_record;
>
>  static int perf_c2c__record(int argc, const char **argv)
>  {
> -       int rec_argc, i =3D 0, j, rec_tmp_nr =3D 0;
> +       int rec_argc, i =3D 0, j;
>         const char **rec_argv;
> -       char **rec_tmp;
>         int ret;
>         bool all_user =3D false, all_kernel =3D false;
>         bool event_set =3D false;
> @@ -3285,12 +3284,6 @@ static int perf_c2c__record(int argc, const char *=
*argv)
>         if (!rec_argv)
>                 return -1;
>
> -       rec_tmp =3D calloc(rec_argc + 1, sizeof(char *));
> -       if (!rec_tmp) {
> -               free(rec_argv);
> -               return -1;
> -       }
> -
>         rec_argv[i++] =3D "record";
>
>         if (!event_set) {
> @@ -3319,7 +3312,7 @@ static int perf_c2c__record(int argc, const char **=
argv)
>         rec_argv[i++] =3D "--phys-data";
>         rec_argv[i++] =3D "--sample-cpu";
>
> -       ret =3D perf_mem_events__record_args(rec_argv, &i, rec_tmp, &rec_=
tmp_nr);
> +       ret =3D perf_mem_events__record_args(rec_argv, &i);
>         if (ret)
>                 goto out;
>
> @@ -3346,10 +3339,6 @@ static int perf_c2c__record(int argc, const char *=
*argv)
>
>         ret =3D cmd_record(i, rec_argv);
>  out:
> -       for (i =3D 0; i < rec_tmp_nr; i++)
> -               free(rec_tmp[i]);
> -
> -       free(rec_tmp);
>         free(rec_argv);
>         return ret;
>  }
> diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
> index ef64bae77ca7..1d92e309c97c 100644
> --- a/tools/perf/builtin-mem.c
> +++ b/tools/perf/builtin-mem.c
> @@ -72,10 +72,9 @@ static const char * const *record_mem_usage =3D __usag=
e;
>
>  static int __cmd_record(int argc, const char **argv, struct perf_mem *me=
m)
>  {
> -       int rec_argc, i =3D 0, j, tmp_nr =3D 0;
> +       int rec_argc, i =3D 0, j;
>         int start, end;
>         const char **rec_argv;
> -       char **rec_tmp;
>         int ret;
>         bool all_user =3D false, all_kernel =3D false;
>         struct perf_mem_event *e;
> @@ -116,15 +115,6 @@ static int __cmd_record(int argc, const char **argv,=
 struct perf_mem *mem)
>         if (!rec_argv)
>                 return -1;
>
> -       /*
> -        * Save the allocated event name strings.
> -        */
> -       rec_tmp =3D calloc(rec_argc + 1, sizeof(char *));
> -       if (!rec_tmp) {
> -               free(rec_argv);
> -               return -1;
> -       }
> -
>         rec_argv[i++] =3D "record";
>
>         e =3D perf_pmu__mem_events_ptr(pmu, PERF_MEM_EVENTS__LOAD_STORE);
> @@ -163,7 +153,7 @@ static int __cmd_record(int argc, const char **argv, =
struct perf_mem *mem)
>                 rec_argv[i++] =3D "--data-page-size";
>
>         start =3D i;
> -       ret =3D perf_mem_events__record_args(rec_argv, &i, rec_tmp, &tmp_=
nr);
> +       ret =3D perf_mem_events__record_args(rec_argv, &i);
>         if (ret)
>                 goto out;
>         end =3D i;
> @@ -193,10 +183,6 @@ static int __cmd_record(int argc, const char **argv,=
 struct perf_mem *mem)
>
>         ret =3D cmd_record(i, rec_argv);
>  out:
> -       for (i =3D 0; i < tmp_nr; i++)
> -               free(rec_tmp[i]);
> -
> -       free(rec_tmp);
>         free(rec_argv);
>         return ret;
>  }
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 7d7df3d0b2b9..a20611b4fb1b 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -218,14 +218,14 @@ void perf_pmu__mem_events_list(struct perf_pmu *pmu=
)
>         }
>  }
>
> -int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
> -                                char **rec_tmp, int *tmp_nr)
> +int perf_mem_events__record_args(const char **rec_argv, int *argv_nr)
>  {
>         const char *mnt =3D sysfs__mount();
>         struct perf_pmu *pmu =3D NULL;
> -       int i =3D *argv_nr, k =3D 0;
>         struct perf_mem_event *e;
> -
> +       int i =3D *argv_nr;
> +       const char *s;
> +       char *copy;
>
>         while ((pmu =3D perf_pmus__scan_mem(pmu)) !=3D NULL) {
>                 for (int j =3D 0; j < PERF_MEM_EVENTS__MAX; j++) {
> @@ -240,30 +240,20 @@ int perf_mem_events__record_args(const char **rec_a=
rgv, int *argv_nr,
>                                 return -1;
>                         }
>
> -                       if (perf_pmus__num_mem_pmus() =3D=3D 1) {
> -                               rec_argv[i++] =3D "-e";
> -                               rec_argv[i++] =3D perf_pmu__mem_events_na=
me(j, pmu);
> -                       } else {
> -                               const char *s =3D perf_pmu__mem_events_na=
me(j, pmu);
> -
> -                               if (!perf_pmu__mem_events_supported(mnt, =
pmu, e))
> -                                       continue;
> +                       s =3D perf_pmu__mem_events_name(j, pmu);
> +                       if (!s || !perf_pmu__mem_events_supported(mnt, pm=
u, e))
> +                               continue;
>
> -                               rec_argv[i++] =3D "-e";
> -                               if (s) {
> -                                       char *copy =3D strdup(s);
> -                                       if (!copy)
> -                                               return -1;
> +                       copy =3D strdup(s);
> +                       if (!copy)
> +                               return -1;
>
> -                                       rec_argv[i++] =3D copy;
> -                                       rec_tmp[k++] =3D copy;
> -                               }
> -                       }
> +                       rec_argv[i++] =3D "-e";
> +                       rec_argv[i++] =3D copy;
>                 }
>         }
>
>         *argv_nr =3D i;
> -       *tmp_nr =3D k;
>         return 0;
>  }
>
> diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
> index f817a507b106..c97cd3caa766 100644
> --- a/tools/perf/util/mem-events.h
> +++ b/tools/perf/util/mem-events.h
> @@ -46,8 +46,7 @@ struct perf_pmu *perf_mem_events_find_pmu(void);
>  bool is_mem_loads_aux_event(struct evsel *leader);
>
>  void perf_pmu__mem_events_list(struct perf_pmu *pmu);
> -int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
> -                                char **rec_tmp, int *tmp_nr);
> +int perf_mem_events__record_args(const char **rec_argv, int *argv_nr);
>
>  int perf_mem__tlb_scnprintf(char *out, size_t sz, struct mem_info *mem_i=
nfo);
>  int perf_mem__lvl_scnprintf(char *out, size_t sz, struct mem_info *mem_i=
nfo);
> --
> 2.35.1
>

