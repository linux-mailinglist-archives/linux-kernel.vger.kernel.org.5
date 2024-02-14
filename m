Return-Path: <linux-kernel+bounces-66018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B02AA855579
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D53411C2165E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703DD14198B;
	Wed, 14 Feb 2024 22:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S0lruz5D"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D8013F00D
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 22:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707948181; cv=none; b=mgMNJ0DlXvrCBRvgU0t/peTEuKkByFkOTQdTONKTbjsSjWD0TXZGhNMJvVPLs7GtFJYT6U8AcwmOH14/S0b57CGFOTLN+NUKxkq8Dl2wOG/AYY4ag3gHkGlRtxZsxSjKfREszVgDw+0YYik7tQIrBNy7xDx2YKMsSY4Ut6Ofeu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707948181; c=relaxed/simple;
	bh=mowh5P/4USMz1hX4Z6lQ+7O67PyHytCTcWCBD3Z33XA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=OaAfL52OCuOcqykhLlPGYG7ze9Qh/TnnqP16gsv1jqhz4OF7phwr1rfGwUVaTXhd1bRGTL+RugH/n8jcvxRiiLplkD0sU3OyDw7s4aCApYzjgghFK4TYlGWrRzFUKlE6h9SpZsetG27MywtrJdCxWQRW/FpUOIeDpUSn2Z+jvQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S0lruz5D; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1db35934648so11725ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 14:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707948179; x=1708552979; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wYfCtUOcHCknKPxjQLZZJYk5nY9b53cOSCJihn+f7U=;
        b=S0lruz5DM19Czn95YTg5N1eYWkyGuqgN2rW2k3HLvRXe6vU+6tfgFMul3IRePjVrJB
         OoMwkuxojD+sa0da/NcMv6PDJdT0TQlmKteQIemHTw+LyrGT5+Sl3c9eTTPqVAolXFH/
         8uhPAp0qCaR7VYXByn7CSzAJnHhDQmoYfmNectK5EXJDk3LMJNNEEmjJGVGh0bSkwApD
         I/3Muv8zZfl7AzW0po/OAMSbtdRvFfDa//hUNUiiVTrLdKNAJ4zcXwaFO1tJE//HzRaf
         xooz8e4hwOET5Bu8Ln8ek9UyAupr4DXplVSz0gOcvHRJ43+MjXPM8eQwz411Kmn3CAnx
         PKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707948179; x=1708552979;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wYfCtUOcHCknKPxjQLZZJYk5nY9b53cOSCJihn+f7U=;
        b=Q3nuMB0cMI8gvzJ238a9ickBKX8XdZVuj0Z8QRqrf5dsleWgb44ZkrXAmePPj1Ne8K
         HY8SpUxhi3OqdjwptCUMopKcpRLVYwY57KtlMVxKvLmE2bxR/VcWIJgs9xKJcWCT7zrb
         bbTTzVHt1Um1hH7CixN0qEcea6x1ODzmjOryMlTJQWA4Y1o8GcVfu+tIj1HknoSG8xX5
         afKMReO6XGBPR/kl7e9IMle7kEgpj9heWwyPnJgnPnuYVFaTNWggc7Jym91hvzAeDFr4
         b7Dk9eo1KXSNsmRy88R7zyEmH6aBLO9z/dqbEqzIi1scZCvjdM2um1owqqL3wiu38zaH
         GfUg==
X-Forwarded-Encrypted: i=1; AJvYcCVSoEBAtqd6FOQFXdZ/aNmmW1yIdaCRKgGXAF9BG7GesbXaHpAGJjJqrJbdrsZxOveTxhcGh8qx+cemyZD1uMEYLjb60Obj3F2PEzCd
X-Gm-Message-State: AOJu0Ywn682iMKDSK39nqMo+AMXoVxteGT9r/6b7eqExImZ8p8zSBr3M
	Os06a4rX+gHzkR75eowYseOq8zZ/9dA+U2J+F8vXd99hyjGwFXvHk+49iH16A6RoMbuS8E5GES+
	GYDfYnQ2+2ViaTd02GKHQAu8ZX4HfwbLIj4Ls
X-Google-Smtp-Source: AGHT+IH8fTyTH+/fM9kh+waGifLqVnENEU1P+zY6NsEz1lp6qycSifgB+8s/ccRmemr7gEoPy9nvbyQJ7zrcjZ+apN0=
X-Received: by 2002:a17:903:2053:b0:1da:292b:cf94 with SMTP id
 q19-20020a170903205300b001da292bcf94mr405169pla.4.1707948179247; Wed, 14 Feb
 2024 14:02:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202234057.2085863-1-irogers@google.com>
In-Reply-To: <20240202234057.2085863-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 14 Feb 2024 14:02:44 -0800
Message-ID: <CAP-5=fVjAHqAHHLqE=3v2bP6S6k98psiuZds7TUTFCT7RgMFdQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] Clean up libperf cpumap's empty function
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>, 
	Leo Yan <leo.yan@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Kan Liang <kan.liang@linux.intel.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Atish Patra <atishp@rivosinc.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	Changbin Du <changbin.du@huawei.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Paran Lee <p4ranlee@gmail.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 3:41=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> Rename and clean up the use of libperf CPU map functions particularly
> focussing on perf_cpu_map__empty that may return true for maps
> containing CPUs but also with an "any CPU"/dummy value.
>
> perf_cpu_map__nr is also troubling in that iterating an empty CPU map
> will yield the "any CPU"/dummy value. Reduce the appearance of some
> calls to this by using the perf_cpu_map__for_each_cpu macro.
>
> v3: Address handling of "any" is arm-spe/cs-etm patch.
> v2: 6 patches were merged by Arnaldo. New patch added ensure empty
>     maps are allocated as NULL (suggested by James Clark). Hopefully a
>     fix to "perf arm-spe/cs-etm: Directly iterate CPU maps".
>
> Ian Rogers (8):
>   libperf cpumap: Add any, empty and min helpers
>   libperf cpumap: Ensure empty cpumap is NULL from alloc
>   perf arm-spe/cs-etm: Directly iterate CPU maps
>   perf intel-pt/intel-bts: Switch perf_cpu_map__has_any_cpu_or_is_empty
>     use
>   perf cpumap: Clean up use of perf_cpu_map__has_any_cpu_or_is_empty
>   perf arm64 header: Remove unnecessary CPU map get and put
>   perf stat: Remove duplicate cpus_map_matched function
>   perf cpumap: Use perf_cpu_map__for_each_cpu when possible

Ping. Thanks,
Ian

>  tools/lib/perf/cpumap.c                       |  33 ++++-
>  tools/lib/perf/include/perf/cpumap.h          |  16 +++
>  tools/lib/perf/libperf.map                    |   4 +
>  tools/perf/arch/arm/util/cs-etm.c             | 114 ++++++++----------
>  tools/perf/arch/arm64/util/arm-spe.c          |   4 +-
>  tools/perf/arch/arm64/util/header.c           |  13 +-
>  tools/perf/arch/x86/util/intel-bts.c          |   4 +-
>  tools/perf/arch/x86/util/intel-pt.c           |  10 +-
>  tools/perf/builtin-c2c.c                      |   6 +-
>  tools/perf/builtin-stat.c                     |  31 +----
>  tools/perf/tests/bitmap.c                     |  13 +-
>  tools/perf/tests/topology.c                   |  46 +++----
>  tools/perf/util/auxtrace.c                    |   4 +-
>  tools/perf/util/bpf_kwork.c                   |  16 +--
>  tools/perf/util/bpf_kwork_top.c               |  12 +-
>  tools/perf/util/cpumap.c                      |  12 +-
>  tools/perf/util/record.c                      |   2 +-
>  .../scripting-engines/trace-event-python.c    |  12 +-
>  tools/perf/util/session.c                     |   5 +-
>  tools/perf/util/stat.c                        |   2 +-
>  tools/perf/util/svghelper.c                   |  20 ++-
>  21 files changed, 192 insertions(+), 187 deletions(-)
>
> --
> 2.43.0.594.gd9cf4e227d-goog
>

