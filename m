Return-Path: <linux-kernel+bounces-108295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 247238808DA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8521D1F23B09
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651001388;
	Wed, 20 Mar 2024 01:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ClVEhYFk"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3E6A47
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 01:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710896512; cv=none; b=E3IRwnFlyJ1C6/1/rzxszETzMDYIVCWhA51ubnpix0xpSqItHaHYnsg5dcUGmryzddB9RD0SfGRumB/Hp7vzgTdnubX59JQSZPaqcxdpfVVYuqS5IFlHxmrxDaLxQFz7RT4EfXLkuxrPRC/Ijw6bmP6cVxxDVxY63dvlT73yKMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710896512; c=relaxed/simple;
	bh=L4ekNnZJBJQCdBiJrurgbWZbl+dv+0cR5wcH0ZLHdLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bUjYP3GPu0NcmIggdDgYxPvsq/3lHTQc8q6ibBHEvQd2kGIWxIT7Ty6tUllc+GD+iQx6L0zJvo6ExdHqygmQO78jCysMxWv+K1hgD4QdIiGiwDK8ZfKBPxBM7UK8dta8g5TbsO2BrpVQRjti+rVEzYlquzZmBFk3W7ifem8LkEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ClVEhYFk; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1deddb82b43so85045ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 18:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710896510; x=1711501310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpWW1bFpJVMD3sRuOnLO32nSb544c3j1m+DkhHID8gY=;
        b=ClVEhYFkllBHJofQCDU3EklbyGkkqW2MaM+Zk3rcANnre4Wl/L5jTZd6FJ3RNx1qMx
         QhfA52vAXxFYSwDQZZApIlKPkHBZTfccEUUAcv8ulQOxDo/uljlt4+3hna8SwSncXCjj
         RNiET2A+7YfEz+fNTjI31SKjEU31LTzcuBG7r8TGX4KTrv5AUguIql/AJNfPKX0hHDvM
         QpdB+mIoH+6nJ3uMEVaIQgg/drGXVVQYA25v/N4GVXTHJKFaXy3I8PmvFcYuXIjlbjQs
         Rqfa9FLApSfLyFKQEBy9iyW/KJk3Etlndav4bf/LuNiBRbOgGttNi8svJzCJlAZaVUPS
         uALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710896510; x=1711501310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kpWW1bFpJVMD3sRuOnLO32nSb544c3j1m+DkhHID8gY=;
        b=SSmOPw8J6PCa1bFKNsCfPu2RMYgMJkeJQNdXJSOqUNv6pBaOvc9LdkcczrH5h2ofji
         8SCNdsn2PduMaxehDqCVOCwK5smGEcX89UqMjnGDeNg264nXsqx1JbMgCa9AJT+x0dLE
         kK1szDlTcm/cjc52YAgK2m1GERAloNydHqF08bSHod7AjM0mRAFNy0vB8kcJIhkWYS5M
         F3759CdMktv5FnEpbiCFbuO9l7L5ibn10xkEetLN60BNem3SyYFnP8dPv0C1eRvvCJxD
         yIOkHQ2V96/jvk0fgqemDj96w8R65WVfyjd712gRBt11Bixrxkd+0ptE+Cticu9oeUIs
         mD+w==
X-Forwarded-Encrypted: i=1; AJvYcCXKrG/ASkWdHSFC4c2M1jG0h1MdVxMpOCp7Cvv+1Y4WIl8I2aj2eD+MYT3ZTbV3LXIL9od/XW0w5ZGciIxI42ztEQmMdnnfmBuVb5v2
X-Gm-Message-State: AOJu0YwSrbAfk4Cl9ydQnxvg+JgHyo6aMlqVMAoTsGxF7EfndBAbU8jv
	SmubAXsn0gMK2A6AuUvYhy3QqiqKaETtDFE4ABcj/NdGq3e7RjdRU+BQSjAACzKglO4ebqmJcZh
	k0+88Vn7KpkNUv5lM88e8ipkvI5Ptc9fUakFB
X-Google-Smtp-Source: AGHT+IG+L+f/SBk0W3esZ49IqdSRTH4MYcpaA1eBHDFF2MNr4SueBl3e/hceRKoL5PYiMH96Ek0i1g0Yqc1MG4JOGGc=
X-Received: by 2002:a17:902:e5cd:b0:1de:fbe1:beb1 with SMTP id
 u13-20020a170902e5cd00b001defbe1beb1mr80891plf.7.1710896510100; Tue, 19 Mar
 2024 18:01:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308001915.4060155-1-irogers@google.com> <89249fc5-6102-45d4-9345-5dd80d06e001@linux.intel.com>
 <CAP-5=fWGhZHnsBWo4=+9PdfaAPNEnx7u40G+BHAWR+4rPC2Udw@mail.gmail.com>
In-Reply-To: <CAP-5=fWGhZHnsBWo4=+9PdfaAPNEnx7u40G+BHAWR+4rPC2Udw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 19 Mar 2024 18:01:35 -0700
Message-ID: <CAP-5=fXXACwattr9fEcmxoDfGNNi8zmzrDUc8RjUtuX5sV4M9w@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Extra verbose/perf-list details
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

On Fri, Mar 8, 2024 at 8:34=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Fri, Mar 8, 2024 at 7:39=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.=
com> wrote:
>>
>>
>>
>> On 2024-03-07 7:19 p.m., Ian Rogers wrote:
>> > Add more encoding detail and raw event details in perf list. Add PMU
>> > name and reverse lookup from config to event name to
>> > perf_event_attr_fprintf. This makes the verbose output easier to read,
>> > and the perf list information more specific.
>> >
>> > v3. Fix to reverse lookup to ensure or aliases are loaded and if
>> >     getting the config value fails for an event/alias just continue to
>> >     the next one.
>> > v2. Address feedback from Kan Liang, "Raw hardware event descriptor"
>> >     becomes "Raw event descriptor" add assert to keep term numbers in
>> >     sync, fix a commit message.
>> >
>> > Ian Rogers (6):
>> >   perf list: Add tracepoint encoding to detailed output
>> >   perf pmu: Drop "default_core" from alias names
>> >   perf list: Allow wordwrap to wrap on commas
>> >   perf list: Give more details about raw event encodings
>> >   perf tools: Use pmus to describe type from attribute
>> >   perf tools: Add/use PMU reverse lookup from config to name
>>
>> The patch series look good to me.
>> I verified it on a hybrid machine. The new format is the same as the
>> advertise.
>>
>> Tested-by: Kan Liang <kan.liang@linux.intel.com>

Ping.

Thanks,
Ian

>
> Thanks Kan! Just to add another feature of perf_event_attr_fprintf change=
s is that it shows up in perf trace output:
>
> ```
> $ perf trace -e perf_event_open perf stat -e data_read true
>      0.000 ( 0.011 ms): :36857/36857 perf_event_open(attr_uptr: { type: 2=
4 (uncore_imc_free_running_0), size: 136, config: 0x20ff (unc_mc0_rdcas_cou=
nt_freerun), sample_type: IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL=
_TIME_RUNNING, disabled: 1, inherit: 1, exclude_guest: 1 }, pid: -1, group_=
fd: -1, flags: FD_CLOEXEC) =3D -1 EINVAL (Invalid argument)
>      0.014 ( 0.002 ms): :36857/36857 perf_event_open(attr_uptr: { type: 2=
4 (uncore_imc_free_running_0), size: 136, config: 0x20ff (unc_mc0_rdcas_cou=
nt_freerun), sample_type: IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL=
_TIME_RUNNING, disabled: 1, inherit: 1, exclude_guest: 1 }, pid: -1, group_=
fd: -1) =3D -1 EINVAL (Invalid argument)
>      0.020 ( 0.008 ms): :36857/36857 perf_event_open(attr_uptr: { type: 2=
4 (uncore_imc_free_running_0), size: 136, config: 0x20ff (unc_mc0_rdcas_cou=
nt_freerun), sample_type: IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL=
_TIME_RUNNING, disabled: 1, inherit: 1 }, pid: -1, group_fd: -1) =3D 8
>      0.031 ( 0.006 ms): :36857/36857 perf_event_open(attr_uptr: { type: 2=
5 (uncore_imc_free_running_1), size: 136, config: 0x20ff (unc_mc1_rdcas_cou=
nt_freerun), sample_type: IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL=
_TIME_RUNNING, disabled: 1, inherit: 1, exclude_guest: 1 }, pid: -1, group_=
fd: -1) =3D -1 EINVAL (Invalid argument)
>      0.044 ( 0.004 ms): :36857/36857 perf_event_open(attr_uptr: { type: 2=
5 (uncore_imc_free_running_1), size: 136, config: 0x20ff (unc_mc1_rdcas_cou=
nt_freerun), sample_type: IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL=
_TIME_RUNNING, disabled: 1, inherit: 1 }, pid: -1, group_fd: -1) =3D 9
>
>  Performance counter stats for 'system wide':
>
>               5.07 MiB  data_read
>
>        0.001178187 seconds time elapsed
> ```
>
> Thanks,
> Ian
>
>>
>> Thanks,
>> Kan
>> >
>> >  tools/perf/builtin-list.c                 | 21 ++++-
>> >  tools/perf/util/perf_event_attr_fprintf.c | 26 +++++--
>> >  tools/perf/util/pmu.c                     | 82 +++++++++++++++++++-
>> >  tools/perf/util/pmu.h                     |  4 +
>> >  tools/perf/util/pmus.c                    | 94 ++++++++++++++++++++++=
+
>> >  tools/perf/util/pmus.h                    |  1 +
>> >  tools/perf/util/print-events.c            | 55 +++++++------
>> >  7 files changed, 242 insertions(+), 41 deletions(-)
>> >

