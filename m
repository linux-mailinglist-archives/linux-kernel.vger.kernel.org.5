Return-Path: <linux-kernel+bounces-95880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF85687546D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12754B26F0A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B98112FF6B;
	Thu,  7 Mar 2024 16:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HSolM5VP"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9009712F5B0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 16:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709829970; cv=none; b=qvffnE+qG7H9KT0ovhivLb+N1QB+lyYtd2oVrqKvU6Tj+cnpKX1ycffiGWQvi5LXECS5ppPbOYCFLKysMnnPgYgmMIn8Os+v0x238TykdNQM0NtU4R4zqDc34lvyB3kuby5npt/pWgCdZTfNOjg3BNuhYE50l2W8MDIe+ADTyAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709829970; c=relaxed/simple;
	bh=ca2ECfmGdh+lPb0ZgM6o3LCAKKCh4yup/fgnToovGz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dbgnd0SBWUEmnDJOjQEU7SOsTsqmRshm/rjb7J7KAkMc/YvxKG326dpfvRy2Qja03lIVTTS2NDYNkiTQ3+yZ5xXCGqwxM5dLRDY0V2CD3TbsaHW4c70ZSpyAUzeDVvB3EC3YbAzqy3NsDbYC0sRqFuteooNW4Bs/UynKLn7nakQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HSolM5VP; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42f024b809cso342351cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 08:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709829967; x=1710434767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9/McXY1cqhuGh0I/LrZgjK1iM+tpaM0etIsMoa6+mM=;
        b=HSolM5VPvP20crJTHNLM6mxjjAKj/VA0VyTMqqp6f0e1wvd3+CpS2e1Tpw0Wq9pW54
         MqCsEcVCcVTvcliCEcn65k9Ufm5K6MS8aixOsiUJAwcekfowNedlMosqOoQl6+QSDcv+
         6/Ib8L5lB/BplylXaKjJjzP2y/7X3QqgnruZD5l+sWsI0NJqgfY/ED+o1gMv6sNntUm9
         4H8uUxHjFgdc5urfRei3aa/aWpSLvWsauOvw2Rg0Zp89D2thta/Ns3H+kOm38LpkCDU4
         DeGj0Fi5MoK1+ioF+vG7sqrmvaOPoC6AHU1Xr4z5Qtd3H73qHfwpGi76vD4GwOm5S109
         tM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709829967; x=1710434767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n9/McXY1cqhuGh0I/LrZgjK1iM+tpaM0etIsMoa6+mM=;
        b=RihlTcWUfabrEdkv43LK3FNuF1QbeyGwVqzRdsNxDkVtBnaWVYIsTRFulj+EPJTRUC
         E5NTWO+NFff5sMnWeORLmBqgMtkrY8TYsjvHSYsCH1JT7JRN0VsWAF1QP/N+sTDoIcf3
         u4zGszG2c0UomUESAfgHHBEtt5yaFg6l0XAcw6bMjvM2EzrlDzHEFtv4H17qOb51lnZO
         Z+AugQRn2RX5paGyI66japJIlOinM2L2fnZ9C5LBJwGSD6Xa6ehOzl1yWLnZv08PMAzs
         7wXT4UEh9X9MzMixKvv1cyNJCcgExgSdmXNpQzOUtO3PntYGnEzx6ijHGLJfoLl4JeuD
         ifGw==
X-Forwarded-Encrypted: i=1; AJvYcCUTSeVHO1BmJTv8EdYK7kh2a2QFeM0tgDy5jNdqVIb2dkplg0aBpr0QKF6WnFF/H1eQsQD0C2IxlRj5Fu0ZNgkS8zsuJ4qExSla5zIi
X-Gm-Message-State: AOJu0YxqzD+fy0Po8DslVgvErJZRRNtaT9mf0MJnlvccMuJ8kIa2xLR+
	uLnWzUAx7E0p1o1UNbxQLU+JSMX8zZtTGcSZ2+TlmC1daDB1r7ObyAR+TmZjqGrioGPCNVVvEoO
	FwpW4zkgbz/xLQY+eTzJc264iRwQUR4vLxgox
X-Google-Smtp-Source: AGHT+IGGaXzx67xcFvyAWUW6MFQTgwc95aB/V2T54UX2bkhrsBrYdzneVEzZIYQ9mEh9g6qo6RtT1xNO0GNtViV8vcI=
X-Received: by 2002:ac8:590f:0:b0:42e:6de9:cd13 with SMTP id
 15-20020ac8590f000000b0042e6de9cd13mr334460qty.3.1709829967309; Thu, 07 Mar
 2024 08:46:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307081412.3933750-1-irogers@google.com> <20240307081412.3933750-6-irogers@google.com>
 <c22e0d67-cf63-4bb7-8cef-05fccc384214@linux.intel.com>
In-Reply-To: <c22e0d67-cf63-4bb7-8cef-05fccc384214@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 7 Mar 2024 08:45:56 -0800
Message-ID: <CAP-5=fWeNgEPrHwXcFoLKB64v=DpQqKnNaZ_ckxK7B+tE8XWNQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] perf tools: Use pmus to describe type from attribute
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 6:36=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
>
>
>
> On 2024-03-07 3:14 a.m., Ian Rogers wrote:
> > When dumping a perf_event_attr, use pmus to find the PMU and its name
> > by the type number. This allows dynamically added PMUs to be described.
> >
> > Before:
> > ```
> > $ perf stat -vv -e data_read true
> > ...
> > perf_event_attr:
> >   type                             24
> >   size                             136
> >   config                           0x20ff
> >   sample_type                      IDENTIFIER
> >   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNIN=
G
> >   disabled                         1
> >   inherit                          1
> >   exclude_guest                    1
> > ...
> > ```
> >
> > After:
> > ```
> > $ perf stat -vv -e data_read true
> > ...
> > perf_event_attr:
> >   type                             24 (uncore_imc_free_running_0)
> >   size                             136
> >   config                           0x20ff
> >   sample_type                      IDENTIFIER
> >   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNIN=
G
> >   disabled                         1
> >   inherit                          1
> >   exclude_guest                    1
> > ...
> > ```
> >
> > However, it also means that when we have a PMU name we prefer it to a
> > hard coded name:
> >
> > Before:
> > ```
> > $ perf stat -vv -e cycles true
>
> faults?

Thanks, will fix in v2. It does highlight we lack a struct pmu in pmus
for legacy types like hardware, hence switching to faults as a
software event that has a PMU. Perhaps we should just make legacy PMUs
anyway, to avoid special case logic. Anyway, not in these changes.

Thanks,
Ian

> Thanks,
> Kan
> > ...
> > perf_event_attr:
> >   type                             1 (PERF_TYPE_SOFTWARE)
> >   size                             136
> >   config                           0x2 (PERF_COUNT_SW_PAGE_FAULTS)
> >   sample_type                      IDENTIFIER
> >   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNIN=
G
> >   disabled                         1
> >   inherit                          1
> >   enable_on_exec                   1
> >   exclude_guest                    1
> > ...
> > ```
> >
> > After:
> > ```
> > $ perf stat -vv -e faults true
> > ...
> > perf_event_attr:
> >   type                             1 (software)
> >   size                             136
> >   config                           0x2 (PERF_COUNT_SW_PAGE_FAULTS)
> >   sample_type                      IDENTIFIER
> >   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNIN=
G
> >   disabled                         1
> >   inherit                          1
> >   enable_on_exec                   1
> >   exclude_guest                    1
> > ...
> > ```
> >
> > It feels more consistent to do this, rather than only prefer a PMU
> > name when a hard coded name isn't available.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/perf_event_attr_fprintf.c | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/uti=
l/perf_event_attr_fprintf.c
> > index 8f04d3b7f3ec..29e66835da3a 100644
> > --- a/tools/perf/util/perf_event_attr_fprintf.c
> > +++ b/tools/perf/util/perf_event_attr_fprintf.c
> > @@ -7,6 +7,8 @@
> >  #include <linux/types.h>
> >  #include <linux/perf_event.h>
> >  #include "util/evsel_fprintf.h"
> > +#include "util/pmu.h"
> > +#include "util/pmus.h"
> >  #include "trace-event.h"
> >
> >  struct bit_names {
> > @@ -75,9 +77,12 @@ static void __p_read_format(char *buf, size_t size, =
u64 value)
> >  }
> >
> >  #define ENUM_ID_TO_STR_CASE(x) case x: return (#x);
> > -static const char *stringify_perf_type_id(u64 value)
> > +static const char *stringify_perf_type_id(struct perf_pmu *pmu, u32 ty=
pe)
> >  {
> > -     switch (value) {
> > +     if (pmu)
> > +             return pmu->name;
> > +
> > +     switch (type) {
> >       ENUM_ID_TO_STR_CASE(PERF_TYPE_HARDWARE)
> >       ENUM_ID_TO_STR_CASE(PERF_TYPE_SOFTWARE)
> >       ENUM_ID_TO_STR_CASE(PERF_TYPE_TRACEPOINT)
> > @@ -175,9 +180,9 @@ do {                                               =
               \
> >  #define print_id_unsigned(_s)        PRINT_ID(_s, "%"PRIu64)
> >  #define print_id_hex(_s)     PRINT_ID(_s, "%#"PRIx64)
> >
> > -static void __p_type_id(char *buf, size_t size, u64 value)
> > +static void __p_type_id(struct perf_pmu *pmu, char *buf, size_t size, =
u64 value)
> >  {
> > -     print_id_unsigned(stringify_perf_type_id(value));
> > +     print_id_unsigned(stringify_perf_type_id(pmu, value));
> >  }
> >
> >  static void __p_config_hw_id(char *buf, size_t size, u64 value)
> > @@ -246,7 +251,7 @@ static void __p_config_id(char *buf, size_t size, u=
32 type, u64 value)
> >  #define p_sample_type(val)   __p_sample_type(buf, BUF_SIZE, val)
> >  #define p_branch_sample_type(val) __p_branch_sample_type(buf, BUF_SIZE=
, val)
> >  #define p_read_format(val)   __p_read_format(buf, BUF_SIZE, val)
> > -#define p_type_id(val)               __p_type_id(buf, BUF_SIZE, val)
> > +#define p_type_id(val)               __p_type_id(pmu, buf, BUF_SIZE, v=
al)
> >  #define p_config_id(val)     __p_config_id(buf, BUF_SIZE, attr->type, =
val)
> >
> >  #define PRINT_ATTRn(_n, _f, _p, _a)                  \
> > @@ -262,6 +267,7 @@ do {                                               =
       \
> >  int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
> >                            attr__fprintf_f attr__fprintf, void *priv)
> >  {
> > +     struct perf_pmu *pmu =3D perf_pmus__find_by_type(attr->type);
> >       char buf[BUF_SIZE];
> >       int ret =3D 0;
> >

