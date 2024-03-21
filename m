Return-Path: <linux-kernel+bounces-109610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E758B881B5D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BF101F21511
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCA46FA8;
	Thu, 21 Mar 2024 02:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Ryjpc9G2"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF515660
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 02:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710989960; cv=none; b=ZG94TNXn5tKkBSE65VUzLVQUR6YWXFlJjaPmPs0klp2fyiJoFVanRvDX5IE31hJKMKybHIFQFsnLrICOWLGUleSXkXCpiCBMJKSOsofVjwazua56ZlilTSVYimu9Em2j2bMr+GXq4NhJ8wazBerwj/KZ6Asb/ik4Niq25a4ZBxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710989960; c=relaxed/simple;
	bh=EjRrdnSlSqLeRHzJerJ26z8jXsiR5lW18G484JLGgFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=tMcWtPSHxlgXzv4dOuadNWe8Jv43E7iClvZSYC10dm/6eaCg19zb2GWYb1LMKlh0W3vj5mt1GcwnDKTYvHqiUhe8ghzMAf+pVuiRYlrHNlyoTe9RhFGGjd0nr8mCd5o/VGLagskS9UOmY8zPZQsNDTP0s5Uvl/AT7Aa2UfPFgmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ryjpc9G2; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1deddb82b43so91795ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 19:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710989958; x=1711594758; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOCWhX/Y1Zj3mfL1r+Yvr+Ag8M+NipZNhGY0tYQmAso=;
        b=Ryjpc9G216SVusEkBmGYkDcHo9C21XixDq4TlFlkkbgYc7g4yxdbWGbhOExuX4E1Gw
         DuWlynUB3KC29ZqZYa3dEMWrmkiH6y34Blg0YAD0s7A/Hmja55HFVhAQY5rWHuW8c+U1
         XQUzwUK0+JXgOUmdi1PHWyglMi7G8HyIodM5c3F8+gC8FmFVAO1SLT/kH3Z+Bqn3PP2o
         RuonLxiSjSaylQhcpL3sk2gqiuIZfwPr84B69ok9/G2gvuzYgC2bCQei/bCVQDVQOjxv
         xE5ozJfS1/QG7t8Eg0cm5++A/Ts7QOD+luoDLc6ed7fn5agU+hQs6G++CQSm1yiKmROU
         ODIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710989958; x=1711594758;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOCWhX/Y1Zj3mfL1r+Yvr+Ag8M+NipZNhGY0tYQmAso=;
        b=V2yREKIyiEDojiF7sDA1zTj3DZ5Ig4FMdsEUsqS1Fu38CfuYGVTbtTd4sfmEMV+KWI
         JJO8sJmKfu6vOFzdVkgDJ9zpoMwU8QWC++/6rW0QeGxb1WaduO1xyVX38y8kLQDo4BOy
         ooGffLUY/ysojjvrbV5z2aP5BzF+SGwmq8MLhQC34v8Xzrq9ITzARCh0+0hhjKKSD5Ck
         OlbJiOymR+3CPBC2rUOaYVgrNZYGzUKjiMGNEf1v6dafujGH5A7iPZZy/Kn9v3GsecI9
         veN1QBtAcNtx43w1URTN5JJUmKHQRnEA4jWqDeYgofbkjYSnlgXHw3KRQ23ssh0ffcdM
         tWlw==
X-Forwarded-Encrypted: i=1; AJvYcCXHk6nt7KbhNnwhlPaSIfR+BVVXA//6+btKgnEL+wG5qxdLC6sWvCIDeNcE+Lif6dgiT3P8W6cI47YfPSA3OyO4f7qn+XzztwNv6JUX
X-Gm-Message-State: AOJu0YxMeR8LnZmorSsNfUIqbdNvRnaQJDs9CYE0iQSrGMhHP4lSqHKk
	nt08aHTDRr1JdVU1GuflcI7kB3DH1/VHi6mw+hhEiBD+nViqBR+77tdqsqAhvhzhDDyJaRu871s
	Oo5/Xlz/9knjnpievLyoCuEfdTB3OnqWTbBrJ
X-Google-Smtp-Source: AGHT+IGFajvD9r3TtnhkoyDDj5ngVjHitTWx2l6VCzb021jVwYrKUvapXg4Hs8AYUApFp56SG/1y855GzgIoc89B9Lg=
X-Received: by 2002:a17:902:e750:b0:1de:ed50:41f8 with SMTP id
 p16-20020a170902e75000b001deed5041f8mr133357plf.22.1710989957442; Wed, 20 Mar
 2024 19:59:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308001915.4060155-1-irogers@google.com> <20240308001915.4060155-5-irogers@google.com>
In-Reply-To: <20240308001915.4060155-5-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 20 Mar 2024 19:59:06 -0700
Message-ID: <CAP-5=fVE3f-Q3Zcdi2qWb5EJSadp5c7xbhzWeq8PFw2NOZEEJw@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] perf list: Give more details about raw event encodings
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 4:19=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> List all the PMUs, not just the first core one, and list real format
> specifiers with value ranges.
>
> Before:
> ```
> $ perf list
> ...
>   rNNN                                               [Raw hardware event =
descriptor]
>   cpu/t1=3Dv1[,t2=3Dv2,t3 ...]/modifier                  [Raw hardware ev=
ent descriptor]
>        [(see 'man perf-list' on how to encode it)]
>   mem:<addr>[/len][:access]                          [Hardware breakpoint=
]
> ...
> ```
>
> After:
> ```
> $ perf list
> ...
>   rNNN                                               [Raw event descripto=
r]
>   cpu/event=3D0..255,pc,edge,.../modifier              [Raw event descrip=
tor]
>        [(see 'man perf-list' or 'man perf-record' on how to encode it)]
>   breakpoint//modifier                               [Raw event descripto=
r]
>   cstate_core/event=3D0..0xffffffffffffffff/modifier   [Raw event descrip=
tor]
>   cstate_pkg/event=3D0..0xffffffffffffffff/modifier    [Raw event descrip=
tor]
>   i915/i915_eventid=3D0..0x1fffff/modifier             [Raw event descrip=
tor]
>   intel_bts//modifier                                [Raw event descripto=
r]
>   intel_pt/ptw,event,cyc_thresh=3D0..15,.../modifier   [Raw event descrip=
tor]
>   kprobe/retprobe/modifier                           [Raw event descripto=
r]
>   msr/event=3D0..0xffffffffffffffff/modifier           [Raw event descrip=
tor]
>   power/event=3D0..255/modifier                        [Raw event descrip=
tor]
>   software//modifier                                 [Raw event descripto=
r]
>   tracepoint//modifier                               [Raw event descripto=
r]
>   uncore_arb/event=3D0..255,edge,inv,.../modifier      [Raw event descrip=
tor]
>   uncore_cbox/event=3D0..255,edge,inv,.../modifier     [Raw event descrip=
tor]
>   uncore_clock/event=3D0..255/modifier                 [Raw event descrip=
tor]
>   uncore_imc_free_running/event=3D0..255,umask=3D0..255/modifier[Raw even=
t descriptor]
>   uprobe/ref_ctr_offset=3D0..0xffffffff,retprobe/modifier[Raw event descr=
iptor]
>   mem:<addr>[/len][:access]                          [Hardware breakpoint=
]
> ...
> ```
>
> With '--details' provide more details on the formats encoding:
> ```
>   cpu/event=3D0..255,pc,edge,.../modifier              [Raw event descrip=
tor]
>        [(see 'man perf-list' or 'man perf-record' on how to encode it)]
>         cpu/event=3D0..255,pc,edge,offcore_rsp=3D0..0xffffffffffffffff,ld=
lat=3D0..0xffff,inv,
>         umask=3D0..255,frontend=3D0..0xffffff,cmask=3D0..255,config=3D0..=
0xffffffffffffffff,
>         config1=3D0..0xffffffffffffffff,config2=3D0..0xffffffffffffffff,c=
onfig3=3D0..0xffffffffffffffff,
>         name=3Dstring,period=3Dnumber,freq=3Dnumber,branch_type=3D(u|k|hv=
|any|...),time,
>         call-graph=3D(fp|dwarf|lbr),stack-size=3Dnumber,max-stack=3Dnumbe=
r,nr=3Dnumber,inherit,no-inherit,
>         overwrite,no-overwrite,percore,aux-output,aux-sample-size=3Dnumbe=
r/modifier
>   breakpoint//modifier                               [Raw event descripto=
r]
>         breakpoint//modifier
>   cstate_core/event=3D0..0xffffffffffffffff/modifier   [Raw event descrip=
tor]
>         cstate_core/event=3D0..0xffffffffffffffff/modifier
>   cstate_pkg/event=3D0..0xffffffffffffffff/modifier    [Raw event descrip=
tor]
>         cstate_pkg/event=3D0..0xffffffffffffffff/modifier
>   i915/i915_eventid=3D0..0x1fffff/modifier             [Raw event descrip=
tor]
>         i915/i915_eventid=3D0..0x1fffff/modifier
>   intel_bts//modifier                                [Raw event descripto=
r]
>         intel_bts//modifier
>   intel_pt/ptw,event,cyc_thresh=3D0..15,.../modifier   [Raw event descrip=
tor]
>         intel_pt/ptw,event,cyc_thresh=3D0..15,pt,notnt,branch,tsc,pwr_evt=
,fup_on_ptw,cyc,noretcomp,
>         mtc,psb_period=3D0..15,mtc_period=3D0..15/modifier
>   kprobe/retprobe/modifier                           [Raw event descripto=
r]
>         kprobe/retprobe/modifier
>   msr/event=3D0..0xffffffffffffffff/modifier           [Raw event descrip=
tor]
>         msr/event=3D0..0xffffffffffffffff/modifier
>   power/event=3D0..255/modifier                        [Raw event descrip=
tor]
>         power/event=3D0..255/modifier
>   software//modifier                                 [Raw event descripto=
r]
>         software//modifier
>   tracepoint//modifier                               [Raw event descripto=
r]
>         tracepoint//modifier
>   uncore_arb/event=3D0..255,edge,inv,.../modifier      [Raw event descrip=
tor]
>         uncore_arb/event=3D0..255,edge,inv,umask=3D0..255,cmask=3D0..31/m=
odifier
>   uncore_cbox/event=3D0..255,edge,inv,.../modifier     [Raw event descrip=
tor]
>         uncore_cbox/event=3D0..255,edge,inv,umask=3D0..255,cmask=3D0..31/=
modifier
>   uncore_clock/event=3D0..255/modifier                 [Raw event descrip=
tor]
>         uncore_clock/event=3D0..255/modifier
>   uncore_imc_free_running/event=3D0..255,umask=3D0..255/modifier[Raw even=
t descriptor]
>         uncore_imc_free_running/event=3D0..255,umask=3D0..255/modifier
>   uprobe/ref_ctr_offset=3D0..0xffffffff,retprobe/modifier[Raw event descr=
iptor]
>         uprobe/ref_ctr_offset=3D0..0xffffffff,retprobe/modifier
> ```
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/pmu.c          | 61 +++++++++++++++++++++-
>  tools/perf/util/pmu.h          |  3 ++
>  tools/perf/util/pmus.c         | 94 ++++++++++++++++++++++++++++++++++
>  tools/perf/util/pmus.h         |  1 +
>  tools/perf/util/print-events.c | 20 +-------
>  5 files changed, 160 insertions(+), 19 deletions(-)
>
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 24be587e3537..e24bc3b8f696 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1603,6 +1603,61 @@ bool perf_pmu__has_format(const struct perf_pmu *p=
mu, const char *name)
>         return false;
>  }
>
> +int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_for=
mat_callback cb)
> +{
> +       static const char *const terms[] =3D {
> +               "config=3D0..0xffffffffffffffff",
> +               "config1=3D0..0xffffffffffffffff",
> +               "config2=3D0..0xffffffffffffffff",
> +               "config3=3D0..0xffffffffffffffff",
> +               "name=3Dstring",
> +               "period=3Dnumber",
> +               "freq=3Dnumber",
> +               "branch_type=3D(u|k|hv|any|...)",
> +               "time",
> +               "call-graph=3D(fp|dwarf|lbr)",
> +               "stack-size=3Dnumber",
> +               "max-stack=3Dnumber",
> +               "nr=3Dnumber",
> +               "inherit",
> +               "no-inherit",
> +               "overwrite",
> +               "no-overwrite",
> +               "percore",
> +               "aux-output",
> +               "aux-sample-size=3Dnumber",
> +       };
> +       struct perf_pmu_format *format;
> +       int ret;
> +
> +       /*
> +        * max-events and driver-config are missing above as are the inte=
rnal
> +        * types user, metric-id, raw, legacy cache and hardware. Assert =
against
> +        * the enum parse_events__term_type so they are kept in sync.
> +        */
> +       _Static_assert(ARRAY_SIZE(terms) =3D=3D __PARSE_EVENTS__TERM_TYPE=
_NR - 6);

For C11 it is required that a 2nd message argument be passed:
https://en.cppreference.com/w/c/language/_Static_assert

This line needs to be something like:
_Static_assert(ARRAY_SIZE(terms) =3D=3D __PARSE_EVENTS__TERM_TYPE_NR - 6,
"Unexpected array size");

Let me know if we I should send a fix, resend all the patches or if
you can fix in tmp.perf-tools-next.

Thanks,
Ian

> +       list_for_each_entry(format, &pmu->format, list) {
> +               perf_pmu_format__load(pmu, format);
> +               ret =3D cb(state, format->name, (int)format->value, forma=
t->bits);
> +               if (ret)
> +                       return ret;
> +       }
> +       if (!pmu->is_core)
> +               return 0;
> +
> +       for (size_t i =3D 0; i < ARRAY_SIZE(terms); i++) {
> +               int config =3D PERF_PMU_FORMAT_VALUE_CONFIG;
> +
> +               if (i < PERF_PMU_FORMAT_VALUE_CONFIG_END)
> +                       config =3D i;
> +
> +               ret =3D cb(state, terms[i], config, /*bits=3D*/NULL);
> +               if (ret)
> +                       return ret;
> +       }
> +       return 0;
> +}
> +
>  bool is_pmu_core(const char *name)
>  {
>         return !strcmp(name, "cpu") || !strcmp(name, "cpum_cf") || is_sys=
fs_pmu_core(name);
> @@ -1697,8 +1752,12 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu,=
 bool skip_duplicate_pmus,
>         pmu_add_cpu_aliases(pmu);
>         list_for_each_entry(event, &pmu->aliases, list) {
>                 size_t buf_used;
> +               int pmu_name_len;
>
>                 info.pmu_name =3D event->pmu_name ?: pmu->name;
> +               pmu_name_len =3D skip_duplicate_pmus
> +                       ? pmu_name_len_no_suffix(info.pmu_name, /*num=3D*=
/NULL)
> +                       : (int)strlen(info.pmu_name);
>                 info.alias =3D NULL;
>                 if (event->desc) {
>                         info.name =3D event->name;
> @@ -1723,7 +1782,7 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, =
bool skip_duplicate_pmus,
>                 info.encoding_desc =3D buf + buf_used;
>                 parse_events_terms__to_strbuf(&event->terms, &sb);
>                 buf_used +=3D snprintf(buf + buf_used, sizeof(buf) - buf_=
used,
> -                               "%s/%s/", info.pmu_name, sb.buf) + 1;
> +                               "%.*s/%s/", pmu_name_len, info.pmu_name, =
sb.buf) + 1;
>                 info.topic =3D event->topic;
>                 info.str =3D sb.buf;
>                 info.deprecated =3D event->deprecated;
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index e35d985206db..9f5284b29ecf 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -196,6 +196,8 @@ struct pmu_event_info {
>  };
>
>  typedef int (*pmu_event_callback)(void *state, struct pmu_event_info *in=
fo);
> +typedef int (*pmu_format_callback)(void *state, const char *name, int co=
nfig,
> +                                  const unsigned long *bits);
>
>  void pmu_add_sys_aliases(struct perf_pmu *pmu);
>  int perf_pmu__config(struct perf_pmu *pmu, struct perf_event_attr *attr,
> @@ -215,6 +217,7 @@ int perf_pmu__find_event(struct perf_pmu *pmu, const =
char *event, void *state, p
>  int perf_pmu__format_parse(struct perf_pmu *pmu, int dirfd, bool eager_l=
oad);
>  void perf_pmu_format__set_value(void *format, int config, unsigned long =
*bits);
>  bool perf_pmu__has_format(const struct perf_pmu *pmu, const char *name);
> +int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_for=
mat_callback cb);
>
>  bool is_pmu_core(const char *name);
>  bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu);
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index 16505071d362..2fd369e45832 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -16,6 +16,7 @@
>  #include "pmus.h"
>  #include "pmu.h"
>  #include "print-events.h"
> +#include "strbuf.h"
>
>  /*
>   * core_pmus:  A PMU belongs to core_pmus if it's name is "cpu" or it's =
sysfs
> @@ -503,6 +504,99 @@ void perf_pmus__print_pmu_events(const struct print_=
callbacks *print_cb, void *p
>         zfree(&aliases);
>  }
>
> +struct build_format_string_args {
> +       struct strbuf short_string;
> +       struct strbuf long_string;
> +       int num_formats;
> +};
> +
> +static int build_format_string(void *state, const char *name, int config=
,
> +                              const unsigned long *bits)
> +{
> +       struct build_format_string_args *args =3D state;
> +       unsigned int num_bits;
> +       int ret1, ret2 =3D 0;
> +
> +       (void)config;
> +       args->num_formats++;
> +       if (args->num_formats > 1) {
> +               strbuf_addch(&args->long_string, ',');
> +               if (args->num_formats < 4)
> +                       strbuf_addch(&args->short_string, ',');
> +       }
> +       num_bits =3D bits ? bitmap_weight(bits, PERF_PMU_FORMAT_BITS) : 0=
;
> +       if (num_bits <=3D 1) {
> +               ret1 =3D strbuf_addf(&args->long_string, "%s", name);
> +               if (args->num_formats < 4)
> +                       ret2 =3D strbuf_addf(&args->short_string, "%s", n=
ame);
> +       } else if (num_bits > 8) {
> +               ret1 =3D strbuf_addf(&args->long_string, "%s=3D0..0x%llx"=
, name,
> +                                  ULLONG_MAX >> (64 - num_bits));
> +               if (args->num_formats < 4) {
> +                       ret2 =3D strbuf_addf(&args->short_string, "%s=3D0=
.0x%llx", name,
> +                                          ULLONG_MAX >> (64 - num_bits))=
;
> +               }
> +       } else {
> +               ret1 =3D strbuf_addf(&args->long_string, "%s=3D0..%llu", =
name,
> +                                 ULLONG_MAX >> (64 - num_bits));
> +               if (args->num_formats < 4) {
> +                       ret2 =3D strbuf_addf(&args->short_string, "%s=3D0=
.%llu", name,
> +                                          ULLONG_MAX >> (64 - num_bits))=
;
> +               }
> +       }
> +       return ret1 < 0 ? ret1 : (ret2 < 0 ? ret2 : 0);
> +}
> +
> +void perf_pmus__print_raw_pmu_events(const struct print_callbacks *print=
_cb, void *print_state)
> +{
> +       bool skip_duplicate_pmus =3D print_cb->skip_duplicate_pmus(print_=
state);
> +       struct perf_pmu *(*scan_fn)(struct perf_pmu *);
> +       struct perf_pmu *pmu =3D NULL;
> +
> +       if (skip_duplicate_pmus)
> +               scan_fn =3D perf_pmus__scan_skip_duplicates;
> +       else
> +               scan_fn =3D perf_pmus__scan;
> +
> +       while ((pmu =3D scan_fn(pmu)) !=3D NULL) {
> +               struct build_format_string_args format_args =3D {
> +                       .short_string =3D STRBUF_INIT,
> +                       .long_string =3D STRBUF_INIT,
> +                       .num_formats =3D 0,
> +               };
> +               int len =3D pmu_name_len_no_suffix(pmu->name, /*num=3D*/N=
ULL);
> +               const char *desc =3D "(see 'man perf-list' or 'man perf-r=
ecord' on how to encode it)";
> +
> +               if (!pmu->is_core)
> +                       desc =3D NULL;
> +
> +               strbuf_addf(&format_args.short_string, "%.*s/", len, pmu-=
>name);
> +               strbuf_addf(&format_args.long_string, "%.*s/", len, pmu->=
name);
> +               perf_pmu__for_each_format(pmu, &format_args, build_format=
_string);
> +
> +               if (format_args.num_formats > 3)
> +                       strbuf_addf(&format_args.short_string, ",.../modi=
fier");
> +               else
> +                       strbuf_addf(&format_args.short_string, "/modifier=
");
> +
> +               strbuf_addf(&format_args.long_string, "/modifier");
> +               print_cb->print_event(print_state,
> +                               /*topic=3D*/NULL,
> +                               /*pmu_name=3D*/NULL,
> +                               format_args.short_string.buf,
> +                               /*event_alias=3D*/NULL,
> +                               /*scale_unit=3D*/NULL,
> +                               /*deprecated=3D*/false,
> +                               "Raw event descriptor",
> +                               desc,
> +                               /*long_desc=3D*/NULL,
> +                               format_args.long_string.buf);
> +
> +               strbuf_release(&format_args.short_string);
> +               strbuf_release(&format_args.long_string);
> +       }
> +}
> +
>  bool perf_pmus__have_event(const char *pname, const char *name)
>  {
>         struct perf_pmu *pmu =3D perf_pmus__find(pname);
> diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
> index 94d2a08d894b..eec599d8aebd 100644
> --- a/tools/perf/util/pmus.h
> +++ b/tools/perf/util/pmus.h
> @@ -18,6 +18,7 @@ struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *=
pmu);
>  const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str);
>
>  void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb,=
 void *print_state);
> +void perf_pmus__print_raw_pmu_events(const struct print_callbacks *print=
_cb, void *print_state);
>  bool perf_pmus__have_event(const char *pname, const char *name);
>  int perf_pmus__num_core_pmus(void);
>  bool perf_pmus__supports_extended_type(void);
> diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-event=
s.c
> index e0d2b49bab66..3f38c27f0157 100644
> --- a/tools/perf/util/print-events.c
> +++ b/tools/perf/util/print-events.c
> @@ -39,7 +39,7 @@ static const char * const event_type_descriptors[] =3D =
{
>         "Software event",
>         "Tracepoint event",
>         "Hardware cache event",
> -       "Raw hardware event descriptor",
> +       "Raw event descriptor",
>         "Hardware breakpoint",
>  };
>
> @@ -416,8 +416,6 @@ void print_symbol_events(const struct print_callbacks=
 *print_cb, void *print_sta
>   */
>  void print_events(const struct print_callbacks *print_cb, void *print_st=
ate)
>  {
> -       char *tmp;
> -
>         print_symbol_events(print_cb, print_state, PERF_TYPE_HARDWARE,
>                         event_symbols_hw, PERF_COUNT_HW_MAX);
>         print_symbol_events(print_cb, print_state, PERF_TYPE_SOFTWARE,
> @@ -441,21 +439,7 @@ void print_events(const struct print_callbacks *prin=
t_cb, void *print_state)
>                         /*long_desc=3D*/NULL,
>                         /*encoding_desc=3D*/NULL);
>
> -       if (asprintf(&tmp, "%s/t1=3Dv1[,t2=3Dv2,t3 ...]/modifier",
> -                    perf_pmus__scan_core(/*pmu=3D*/NULL)->name) > 0) {
> -               print_cb->print_event(print_state,
> -                               /*topic=3D*/NULL,
> -                               /*pmu_name=3D*/NULL,
> -                               tmp,
> -                               /*event_alias=3D*/NULL,
> -                               /*scale_unit=3D*/NULL,
> -                               /*deprecated=3D*/false,
> -                               event_type_descriptors[PERF_TYPE_RAW],
> -                               "(see 'man perf-list' on how to encode it=
)",
> -                               /*long_desc=3D*/NULL,
> -                               /*encoding_desc=3D*/NULL);
> -               free(tmp);
> -       }
> +       perf_pmus__print_raw_pmu_events(print_cb, print_state);
>
>         print_cb->print_event(print_state,
>                         /*topic=3D*/NULL,
> --
> 2.44.0.278.ge034bb2e1d-goog
>

