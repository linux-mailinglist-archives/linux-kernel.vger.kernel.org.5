Return-Path: <linux-kernel+bounces-107851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD2988027A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33D521F24BE5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA85A1804A;
	Tue, 19 Mar 2024 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Erl0TSIa"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D0D107B2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866227; cv=none; b=P5DjrFhHSVvVXdUQWTpKwo3dwzoklsWA7HOVgGWthb3RqXJU+bmnZUe8/09TLFX/e9cP7L7Wtiib3QCpQUkwfd3NCmUQgvCKDzpmDv8E9BvqOn/nRKQMhWEo6Z1yzO8mB7UCKKqlxJoJ/Do6KfLE/7hrGSh2NRJxlIpWQP5Xz74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866227; c=relaxed/simple;
	bh=DiDJbXClJgb1cM5ngsf4599IGKIEVZmVsszUVM95sbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tOsT4Sz2gJ07WfcZpzmRAokqYYegZQlmuR9GGfoLb//LifGjVDpYCJiBxVAhZcb2lTUHmi60QLccG8z0gKMhHk37taUSazPYXNLCCWYHpxv623BUtev2X4gDfx1hJE8Bg/wEuzPWWCEeLGffxLX2oYHam1QqJKK2ygfE+ztClp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Erl0TSIa; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dddd7d64cdso182575ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710866226; x=1711471026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrjuHZ6Kox9TX/BS1xzAx8QX4KFAzs+jwjCKuYq+Z68=;
        b=Erl0TSIazOiH1pzrH86ukj6jM3ECmKjzYspXNd2Q135p+sahli/zfgZQmCXfEBmHcA
         bE4+yejrYTxtIriqesRxxNyQ3sXVq4rOY4WjUXhXxQNdM2VG6k8jlTMOmiLeGQhuMszE
         +DhHPz3vd+nb6fG3hn2YL8WM/1UnnB1rTUmqPXiL6YIa2j+QYceukkPleqRoniI22kHk
         8e4nm2WkDNhLa//e9R9uJpFPCnfABymJ+9GRQaV1X3tfRQXx+7ISVcilmWRn6QNGljC5
         5DLhEfxZoC3d/f4847ID2BvQ6oYfGOokoA2jnuqFTiTeLSZV/9vaOFsDPuS7tXcwjNZm
         N3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710866226; x=1711471026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RrjuHZ6Kox9TX/BS1xzAx8QX4KFAzs+jwjCKuYq+Z68=;
        b=HZhXKR3rc7Yll7EhUTRVfhxBN+9bChWF1ac8C1ZCjw6iucVIPRDpuZmGwDDJH4rhmO
         YIzDGORkd1rZKELSEipKhqZ9iuRStmrYflrl/JGLxu1nANUqzhkotfQGfS0poAQ8Yuut
         vii9FUU+AF4EVoL1CDfg/FJqHtRuKc/E1H7Y7e9Auqanq830hwedYUy2vQGUY1h4LPPG
         TIxoMUS0J7GqsXRDw2dky5hPmLa9vrxe0x4/uFQKie/Azk+tOWWwwVR58Eq9bzXjPVo0
         /zjF0Wk5c6Ha8cbp/3vUVFc9/YBf+RY1gV0MrBy4bpeq6NqIsPZK22Xo1tXdWs8P/Swa
         hYCA==
X-Gm-Message-State: AOJu0YwnDwB4fmfhgoIrZT/WaMNyrEr0TfZIgmA5JOE93/PrO0aT2/lV
	syS/QaxxEbnvsyOaX/ZTHTzFOavl6GSYPOpBrGxP2MkcTh4vTpLJnSkLPSvXQf0G+H4ZYGwnFU+
	G8c05X4adgBIxfmhpL1/lKnGTWtMdAlpVPP/p
X-Google-Smtp-Source: AGHT+IFuvEAMa2HYTMxxsWcOsREdY/SJEi2+0RBp9e4eNZ6k3M7DL2FnItc0sbxzD2yuKBpCxQkz1IlPltYAjqPnXO4=
X-Received: by 2002:a17:903:2292:b0:1df:f726:8b50 with SMTP id
 b18-20020a170903229200b001dff7268b50mr1044plh.10.1710866225128; Tue, 19 Mar
 2024 09:37:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319095043.857594-1-tmricht@linux.ibm.com> <20240319095043.857594-2-tmricht@linux.ibm.com>
In-Reply-To: <20240319095043.857594-2-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 19 Mar 2024 09:36:51 -0700
Message-ID: <CAP-5=fUGakVrS36u73dSU8KMbp1zQBQea6N5zOidMKoQoL0F7w@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf list: do not print metrics on s390 zvm systems
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	acme@kernel.org, namhyung@kernel.org, svens@linux.ibm.com, gor@linux.ibm.com, 
	sumanthk@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 2:56=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> On s390 z/VM virtual machines command perf list also displays metrics:
>
>  # ./perf list | grep -A 20 'Metric Groups:'
>  Metric Groups:
>
>  No_group:
>   cpi
>        [Cycles per Instruction]
>   est_cpi
>        [Estimated Instruction Complexity CPI infinite Level 1]
>   finite_cpi
>        [Cycles per Instructions from Finite cache/memory]
>   l1mp
>        [Level One Miss per 100 Instructions]
>   l2p
>        [Percentage sourced from Level 2 cache]
>   l3p
>        [Percentage sourced from Level 3 on same chip cache]
>   l4lp
>        [Percentage sourced from Level 4 Local cache on same book]
>   l4rp
>        [Percentage sourced from Level 4 Remote cache on different book]
>   memp
>        [Percentage sourced from memory]
>   ....
>  #
>
> This is not correct, on s390 z/VM virtual machines the referenced
> CPU Counter Measurement facility does not exist. The command
>
>  # ./perf stat -M cpi -- true
>  event syntax error: '{CPU_CYCLES/metric-id=3DCPU_CYCLES/.....'
>                        \___ Bad event or PMU
>
>  Unable to find PMU or event on a PMU of 'CPU_CYCLES'
>
>  event syntax error: '{CPU_CYCLES/metric-id=3DCPU_CYCLES/...'
>                        \___ Cannot find PMU `CPU_CYCLES'.
>                             Missing kernel support?
>  #
>
> fails.
>
> Perf list should not display the metrics when the referenced
> CPU Counter Measurement PMU is not available.
>
> Output after:
>  # ./perf list | grep -A 20 'Metric Groups:'
>  #
>
> Fixes: 7f76b3113068 ("perf list: Add IBM z16 event description for s390")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> ---
>  tools/perf/arch/s390/util/pmu.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/tools/perf/arch/s390/util/pmu.c b/tools/perf/arch/s390/util/=
pmu.c
> index 886c30e001fa..2dc27acc860c 100644
> --- a/tools/perf/arch/s390/util/pmu.c
> +++ b/tools/perf/arch/s390/util/pmu.c
> @@ -8,6 +8,7 @@
>  #include <string.h>
>
>  #include "../../../util/pmu.h"
> +#include "../../../util/pmus.h"
>
>  #define        S390_PMUPAI_CRYPTO      "pai_crypto"
>  #define        S390_PMUPAI_EXT         "pai_ext"
> @@ -20,3 +21,19 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
>             !strcmp(pmu->name, S390_PMUCPUM_CF))
>                 pmu->selectable =3D true;
>  }
> +
> +const struct pmu_metrics_table *pmu_metrics_table__find(void)
> +{
> +       struct perf_pmu *pmu;
> +
> +       /*
> +        * Metrics defined on events from PMU cpum_cf aren't supported
> +        * on z/VM. Make sure the PMU exists and return NULL if that
> +        * PMU cannot be found.
> +        */
> +       pmu =3D perf_pmus__find("cpum_cf");
> +       if (pmu)
> +               return perf_pmu__find_metrics_table(pmu);
> +
> +       return NULL;
> +}

Hi Thomas,

Thank you for this, it is good the patch addresses the issue but I'm
less keen on the approach. The approach is to disable all metrics when
the PMU cpum_cf isn't present.

Similar to the metric cpi there is a hard coded IPC metric:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/stat-shadow.c?h=3Dperf-tools-next#n314
I'd like to delete this code :-) The hard coded metrics magically fire
when certain events are present. This causes issues with code that
processes the output as some metrics can accidentally fire unasked for
additional hard coded metrics. The hard coded metrics also don't use
groups for events, etc. I do like they have more color options
(thresholds) than the json metrics.

Using python to generate metrics achieves a lot of simplification and
hopefully lowers the bar for new metrics being written. Having metrics
disabled when a PMU isn't present means that the only way to get the
metric could be to hard code it - something I want to delete :-) There
are metrics like cycles (looking for review/unmerged):
https://lore.kernel.org/lkml/20240314055801.1973422-3-irogers@google.com/
that don't use sysfs or json events and that could work on s390. I
think ideally we'd work to enable this.

(1) For the cpi metric here, presumably CPU_CYCLES is used to avoid
the legacy cpu-cycles event. Would using cpu-cycles fix the metric
(assuming legacy events work in a virtual machine) ? An aside, it is
kind of gross that the event names are so similar as event names
aren't case sensitive. As sysfs/json events now have priority over
legacy events, using the name cpu-cycles is a possibility (x86 uses
this name).

(2) Another option is that in the metric you can use the "has_event"
function. So:
    "MetricExpr": "CPU_CYCLES / INSTRUCTIONS"
becomes something like :
    "MetricExpr": "(CPU_CYCLES / INSTRUCTIONS) if has_event(CPU_CYCLES) els=
e 0"
This has been the existing approach taken.

(3) We could also make "perf list" not show metrics when the events
aren't present. We do something similar for legacy cache events:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/print-events.c?h=3Dperf-tools-next#n306
This could complicate testing as we iterate through all metrics
expecting them to work. An event name typo would hide the metric in
the list from and we'd miss the typo in testing.

So I think solution (2) is best, wdyt?

Thanks,
Ian


> --
> 2.44.0
>

