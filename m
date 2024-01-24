Return-Path: <linux-kernel+bounces-37507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC4B83B109
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADFC71C226DC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA74512BE96;
	Wed, 24 Jan 2024 18:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OyL1Mj7W"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6690812AADD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 18:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706120641; cv=none; b=qLe9hHrxQ0WPzmpS4f/Musw+49Jq2f7ohc9cPOy4tuh65J0dpkc7TNLWUF8eCKxJD2JcQGHOrqmtg92SchUP2bqR6UBdw682bRo+ykgNObcI5mICcKOVTLpLnCo58MEhkW8S9xQbuKktb66T8sCwApCwCa3WV/qsDTRJ/O63mRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706120641; c=relaxed/simple;
	bh=aLdlWpro750gZBi5PSU2dkOK4wHdU0GzZ1iWLys3CjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PhubBWeNnxUoW5wxDba9eNi3GU/D2CYs/FLXJIGzijj0Pju0xoT0eCbXD3EE0S32bFpobOgif0duHNmakpX79KXXNr+6IBxd99dcKziq4bXn2TtdE3JCoKQ+XLjRvgrxseL4TWYLMu2L6iuX69srgpBuTWhZ74H4jc/TZ/hLz8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OyL1Mj7W; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-361a829e012so4455ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 10:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706120639; x=1706725439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYoVBveLHDJjbciWP+DoYEiv2kBqglZOhr3fp6u4H2I=;
        b=OyL1Mj7WaLOFYDFsqeV+OXlDuf26js9ZcKsCb9omX9r1pVTG83RBsCacS4ZW6O2sDe
         mDri1+h6AprVyh7p8OKEJ/DZT7Y7eefVnvsTvCnAc9foHo5FhbusAdotY2SGAzvTKGbH
         f6Tz/GR/kzlr+ojhRkuPFqJpTEBdyLFliEKea3tslVbIPRiWL5OAY/TqEVSOmkvx8k0Y
         5stp9x1VD4+od45Lo0sM9NQSrLIlJaEWXg6AO+vjr3T9jkGk9UGBxkpTgchSulfK236b
         +rCxPh1gLMR5Nw4RMof7t8HJ6LG+Gcs6BmNJSRsL2KEB+ULrZ6S64bvO5KcdJ4Uh8Kki
         qBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706120639; x=1706725439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYoVBveLHDJjbciWP+DoYEiv2kBqglZOhr3fp6u4H2I=;
        b=uWVwafIA2ErxRu56JDHwFUc1DM1/KZDwUwW7V+fLHC3hqauUnAiEXSLEQgDp8JjH8/
         /AaJnAn+ZeNt64Qz+pI424jNSRzbfj9INzYzbwKoyhGYDcHAPRZlhpRcFvVTF7lBc9Pr
         EvdXUIL5ML3t6nL8mlKlbNZ980dlAbGRC3JuA+05SBnxQuAZTi9jcqr/g4jVqndNm4Ef
         3M8yVrybiKukpwexEjj1sf36wiEV2zcnI2QS4byoaxX22QH5H57uwW05oYnmytP6bOch
         6MPd3TTIkVqH5PNL+YHYMWaggpvJ/rK2QIN6PijVgn2kY7QD3G0JDssPnLN147aznUZl
         3A2A==
X-Gm-Message-State: AOJu0Yz8UdFbS7oKFWFtpPInarNitdosBbRbvsLzK6otcEYgYemJqs2F
	4vuraNtMRVx+aIMmLtUBCBahRo6PBvrQ49NgI4V4miZsxcYzl2Pb1lS29mEiFkGgMq0g/X7CaAV
	LK7yk5QfePTN3LE+enQM7si0/p/+UK+eIzMHa
X-Google-Smtp-Source: AGHT+IGB8WZaSPaA7Tut29f0/08UMT2HYAcBLpp6bk7rKBB6ojPrYFXh6ES9Uk5r8AqrBCM5UG29AmCO6rAeO/M6as4=
X-Received: by 2002:a92:c801:0:b0:360:5e25:5c22 with SMTP id
 v1-20020a92c801000000b003605e255c22mr15253iln.8.1706120639249; Wed, 24 Jan
 2024 10:23:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123185036.3461837-1-kan.liang@linux.intel.com> <20240123185036.3461837-8-kan.liang@linux.intel.com>
In-Reply-To: <20240123185036.3461837-8-kan.liang@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 24 Jan 2024 10:23:48 -0800
Message-ID: <CAP-5=fVc1PYFr=wJMBvQVPnHon4uDOLWFFMPP2VYyne8S+M_ag@mail.gmail.com>
Subject: Re: [PATCH V4 7/7] perf mem: Clean up perf_pmus__num_mem_pmus()
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
> The number of mem PMUs can be calculated by searching the
> perf_pmus__scan_mem().
>
> Remove the ARCH specific perf_pmus__num_mem_pmus()
>
> Tested-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/arch/x86/util/pmu.c | 10 ----------
>  tools/perf/builtin-c2c.c       |  2 +-
>  tools/perf/builtin-mem.c       |  2 +-
>  tools/perf/util/mem-events.c   | 14 ++++++++++++++
>  tools/perf/util/mem-events.h   |  1 +
>  tools/perf/util/pmus.c         |  6 ------
>  tools/perf/util/pmus.h         |  1 -
>  7 files changed, 17 insertions(+), 19 deletions(-)
>
> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pm=
u.c
> index 0f49ff13cfe2..c3d89d6ba1bf 100644
> --- a/tools/perf/arch/x86/util/pmu.c
> +++ b/tools/perf/arch/x86/util/pmu.c
> @@ -42,13 +42,3 @@ void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_=
unused)
>                         pmu->mem_events =3D perf_mem_events_intel;
>         }
>  }
> -
> -int perf_pmus__num_mem_pmus(void)
> -{
> -       /* AMD uses IBS OP pmu and not a core PMU for perf mem/c2c */
> -       if (x86__is_amd_cpu())
> -               return 1;
> -
> -       /* Intel uses core pmus for perf mem/c2c */
> -       return perf_pmus__num_core_pmus();
> -}
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 3bcb903b6b38..16b40f5d43db 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -3278,7 +3278,7 @@ static int perf_c2c__record(int argc, const char **=
argv)
>                              PARSE_OPT_KEEP_UNKNOWN);
>
>         /* Max number of arguments multiplied by number of PMUs that can =
support them. */
> -       rec_argc =3D argc + 11 * perf_pmus__num_mem_pmus();
> +       rec_argc =3D argc + 11 * (perf_pmu__mem_events_num_mem_pmus(pmu) =
+ 1);
>
>         rec_argv =3D calloc(rec_argc + 1, sizeof(char *));
>         if (!rec_argv)
> diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
> index 1d92e309c97c..5b851e64e4a1 100644
> --- a/tools/perf/builtin-mem.c
> +++ b/tools/perf/builtin-mem.c
> @@ -106,7 +106,7 @@ static int __cmd_record(int argc, const char **argv, =
struct perf_mem *mem)
>                              PARSE_OPT_KEEP_UNKNOWN);
>
>         /* Max number of arguments multiplied by number of PMUs that can =
support them. */
> -       rec_argc =3D argc + 9 * perf_pmus__num_mem_pmus();
> +       rec_argc =3D argc + 9 * (perf_pmu__mem_events_num_mem_pmus(pmu) +=
 1);
>
>         if (mem->cpu_list)
>                 rec_argc +=3D 2;
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index a20611b4fb1b..637cbd4a7bfb 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -62,6 +62,20 @@ struct perf_pmu *perf_mem_events_find_pmu(void)
>         return perf_pmus__scan_mem(NULL);
>  }
>
> +/**
> + * perf_pmu__mem_events_num_mem_pmus - Get the number of mem PMUs since =
the given pmu
> + * @pmu: Start pmu. If it's NULL, search the entire PMU list.
> + */
> +int perf_pmu__mem_events_num_mem_pmus(struct perf_pmu *pmu)
> +{
> +       int num =3D 0;
> +
> +       while ((pmu =3D perf_pmus__scan_mem(pmu)) !=3D NULL)
> +               num++;
> +
> +       return num;
> +}
> +
>  static const char *perf_pmu__mem_events_name(int i, struct perf_pmu *pmu=
)
>  {
>         struct perf_mem_event *e;
> diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
> index c97cd3caa766..15d5f0320d27 100644
> --- a/tools/perf/util/mem-events.h
> +++ b/tools/perf/util/mem-events.h
> @@ -43,6 +43,7 @@ int perf_pmu__mem_events_init(struct perf_pmu *pmu);
>
>  struct perf_mem_event *perf_pmu__mem_events_ptr(struct perf_pmu *pmu, in=
t i);
>  struct perf_pmu *perf_mem_events_find_pmu(void);
> +int perf_pmu__mem_events_num_mem_pmus(struct perf_pmu *pmu);
>  bool is_mem_loads_aux_event(struct evsel *leader);
>
>  void perf_pmu__mem_events_list(struct perf_pmu *pmu);
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index ce4931461741..16505071d362 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -345,12 +345,6 @@ const struct perf_pmu *perf_pmus__pmu_for_pmu_filter=
(const char *str)
>         return NULL;
>  }
>
> -int __weak perf_pmus__num_mem_pmus(void)
> -{
> -       /* All core PMUs are for mem events. */
> -       return perf_pmus__num_core_pmus();
> -}
> -
>  /** Struct for ordering events as output in perf list. */
>  struct sevent {
>         /** PMU for event. */
> diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
> index 4c67153ac257..94d2a08d894b 100644
> --- a/tools/perf/util/pmus.h
> +++ b/tools/perf/util/pmus.h
> @@ -17,7 +17,6 @@ struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *=
pmu);
>
>  const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str);
>
> -int perf_pmus__num_mem_pmus(void);
>  void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb,=
 void *print_state);
>  bool perf_pmus__have_event(const char *pname, const char *name);
>  int perf_pmus__num_core_pmus(void);
> --
> 2.35.1
>

