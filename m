Return-Path: <linux-kernel+bounces-134618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C26589B3BC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 21:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F6F71C209C6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 19:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D553C3D3AC;
	Sun,  7 Apr 2024 19:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BXbQICRZ"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120633C082
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 19:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712516918; cv=none; b=adT3kePugf2T2W6SpYqksXAk4/e+O5OnkQPAdxO+MWN57Ouj6n3aDY8f5z412NEzKJGDm8n7ra6S2yVQ7yMeD440outFQqC/J7vWx6fGoHWfiBlZfUu0CGT01M+12MnMfFLS8Iof8Hq+9kmsOYjNPvTJBkGacvpi/DY70RcQv3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712516918; c=relaxed/simple;
	bh=OWf9iMYU718Cfwl9zV/F2GWj0Yvqhq3vGoGy/+ELSgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YfVFRc2f1JDcnI9ZGFAlOEWI9Sx61sbZ5yAGRcReGDIR83rXzhJegvJi2Wsn1zUxK8Pkqzq33vzdzKPRCvLdReTlEzS6YcSzvJEp0LG5gXuBKrZHXb+034FNuBomy9Lro61/KEygpdjQUrVlHZW4qVYDQDkl24n7w+IEOLA/kfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BXbQICRZ; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-36a267bb43aso8345ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 12:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712516916; x=1713121716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5YRgmYN/L7JWBp5a51XmuKrKNy5xHlYAyqPW0wO7Hs=;
        b=BXbQICRZQ51QDqh7zhrCwopElbuLd8cKQLvJ0et+rNsaAxX3gwHQsujlfX9lHL2Hgu
         yyFVe0WrUA7s7mo83E3enHcpLUXs82T8aJL/6uy5nfDWrjM2NfiMxuHJVJLkpeyOo1i3
         DtVN0/VU7mar9jvsFAq0VBe4xLhdXiG442eD7yNpu8CQ2Mb5CiWBd54ezRpiZKFRsU0p
         03EUnucuLrwfsXRt83zkVKoIAQqTAzK/npchK7iwFGWYOT7l4vu+iuaaRyo3+IRuNktT
         mV3honNZedgK/F4bEeGDE1saE2wX9xrXU2YH4FLL9FyJZmkPjsqqNNoaqMUTARqnR4BZ
         o/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712516916; x=1713121716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5YRgmYN/L7JWBp5a51XmuKrKNy5xHlYAyqPW0wO7Hs=;
        b=O16PXysb3M5WD/d+0IuXtugmTFipTZ7+UOPgJIXQjsDD/cbwPoF/ildIZ5PpOIYlLR
         tRF0iA+edyYqGwpmyojfHwxWE626d9m3fHrTzZ8MByGJ604dfWcobY+xOL4z49227H4z
         3IOBu5jlYu61+1Yozd1SneRPtfwe7jE+RHQ9Qr25FrHAEmeAxAjr7+/ya0zGmKzmb5iB
         CdwVNXiaV4AOYuFx6dhwrGzvElnqND0etmdEPNOv7NQ4o3TFsDpr8Rm4SmxCB9NTwMeA
         aCtLugb7FzVKdx1GU/JlpbnKQLcdh/tQ+iqw69FhucP5nHU1kQebh8882c/1dQAq7Kij
         rJXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJep/96TXM7VOIcOkEsFOQo8j/ojcGRce2gyp3Awh1pTPhGTxbndwtJZo+LO35vbk0H5aVgNOT4SEfOW4znM/7W+6NAOkidBs/1GIo
X-Gm-Message-State: AOJu0YxKEyy3HwXhdQMBaf9L7ia6WFQ3eIbbYD/SN3FLIwWeCRkjF5MX
	EXp5rdM6TEpqYxTQN4lU7vRT/Bses85Zr8595MVXaGbv+rHf5Lcv1KpKB7tTUSiEkYA389d96eR
	/at+AFEzlaZVsxoEka0OT6OPqczWq1LXnkMZ94NqP3aXVTXr99QpT
X-Google-Smtp-Source: AGHT+IGdlR/gwGxmaiZ8d30vDLkRJydnlWZJZS+iymAoZFFHQYGUj8c89wfkczS+kPXW5B/yWkFTc01EbOBT7I/vwUs=
X-Received: by 2002:a92:cc42:0:b0:369:e18b:bda2 with SMTP id
 t2-20020a92cc42000000b00369e18bbda2mr297969ilq.6.1712516915950; Sun, 07 Apr
 2024 12:08:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407083715.851461-1-maobibo@loongson.cn>
In-Reply-To: <20240407083715.851461-1-maobibo@loongson.cn>
From: Ian Rogers <irogers@google.com>
Date: Sun, 7 Apr 2024 12:08:20 -0700
Message-ID: <CAP-5=fX4DtOWVAByfJudMEhHianK8nutybu4FN41yr8_2+W4TA@mail.gmail.com>
Subject: Re: [PATCH v2] perf kvm: Add kvm-stat for loongarch64
To: Bibo Mao <maobibo@loongson.cn>
Cc: Ming Wang <wangming01@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 7, 2024 at 1:37=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wrote=
:
>
> Add support for 'perf kvm stat' on loongarch64 platform, now only
> kvm exit event is supported.
>
> Here is example output about "perf kvm --host stat report" command
>
>    Event name   Samples   Sample%     Time (ns)   Time%   Mean Time (ns)
>     Mem store     83969    51.00%     625697070   8.00%             7451
>      Mem read     37641    22.00%     112485730   1.00%             2988
>     Interrupt     15542     9.00%      20620190   0.00%             1326
>         Iocsr     15207     9.00%      94296190   1.00%             6200
>     Hypercall      4873     2.00%      12265280   0.00%             2516
>          Idle      3713     2.00%    6322055860  87.00%          1702681
>           FPU      1819     1.00%       2750300   0.00%             1511
>        Ifecth       502     0.00%       1341740   0.00%             2672
>    Mem modify       324     0.00%        602240   0.00%             1858
>        Cpucfg        55     0.00%         77610   0.00%             1411
>           Csr        12     0.00%         19690   0.00%             1640
>          LASX         3     0.00%          4870   0.00%             1623
>           LSX         2     0.00%          2100   0.00%             1050
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> v1 --- v2:
>   1. Add child_ops for kvm exit event, split kvm:kvm_exit_gspr events
> into cpucfg/csr/iocsr/idle child events by decoding detailed gspr
> instruction.
>   2. Remove some exception code type which does not happen in current
> kvm implementation, such as meomry NR/NX/priviledge exception.
> ---
>  tools/perf/arch/loongarch/Makefile        |   1 +
>  tools/perf/arch/loongarch/util/Build      |   2 +
>  tools/perf/arch/loongarch/util/header.c   |  85 +++++++++++++
>  tools/perf/arch/loongarch/util/kvm-stat.c | 141 ++++++++++++++++++++++
>  4 files changed, 229 insertions(+)
>  create mode 100644 tools/perf/arch/loongarch/util/header.c
>  create mode 100644 tools/perf/arch/loongarch/util/kvm-stat.c
>
> diff --git a/tools/perf/arch/loongarch/Makefile b/tools/perf/arch/loongar=
ch/Makefile
> index 3992a67a87d9..c89d6bb6b184 100644
> --- a/tools/perf/arch/loongarch/Makefile
> +++ b/tools/perf/arch/loongarch/Makefile
> @@ -4,6 +4,7 @@ PERF_HAVE_DWARF_REGS :=3D 1
>  endif
>  PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET :=3D 1
>  PERF_HAVE_JITDUMP :=3D 1
> +HAVE_KVM_STAT_SUPPORT :=3D 1
>
>  #
>  # Syscall table generation for perf
> diff --git a/tools/perf/arch/loongarch/util/Build b/tools/perf/arch/loong=
arch/util/Build
> index d776125a2d06..e1a13761037b 100644
> --- a/tools/perf/arch/loongarch/util/Build
> +++ b/tools/perf/arch/loongarch/util/Build
> @@ -1,5 +1,7 @@
>  perf-y +=3D perf_regs.o
> +perf-y +=3D header.o
>
> +perf-$(CONFIG_LIBTRACEEVENT) +=3D kvm-stat.o
>  perf-$(CONFIG_DWARF)     +=3D dwarf-regs.o
>  perf-$(CONFIG_LOCAL_LIBUNWIND) +=3D unwind-libunwind.o
>  perf-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> diff --git a/tools/perf/arch/loongarch/util/header.c b/tools/perf/arch/lo=
ongarch/util/header.c
> new file mode 100644
> index 000000000000..8f7061cf6977
> --- /dev/null
> +++ b/tools/perf/arch/loongarch/util/header.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Implementation of get_cpuid().
> + *
> + * Author: Nikita Shubin <n.shubin@yadro.com>
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <api/fs/fs.h>
> +#include <errno.h>
> +#include "util/debug.h"
> +#include "util/header.h"
> +
> +#define CPUINFO_MODEL  "Model Name"
> +#define CPUINFO                "/proc/cpuinfo"
> +
> +static char *_get_field(const char *line)
> +{
> +       char *line2, *nl;
> +
> +       line2 =3D strrchr(line, ' ');
> +       if (!line2)
> +               return NULL;
> +
> +       line2++;
> +       nl =3D strrchr(line, '\n');
> +       if (!nl)
> +               return NULL;
> +
> +       return strndup(line2, nl - line2);
> +}
> +
> +static char *_get_cpuid(void)
> +{
> +       char *line =3D NULL;
> +       char *model =3D NULL;
> +       char *cpuid =3D NULL;
> +       int read;
> +       unsigned long line_sz;
> +       FILE *cpuinfo;
> +
> +       cpuinfo =3D fopen(CPUINFO, "r");
> +       if (cpuinfo =3D=3D NULL)
> +               return cpuid;
> +
> +       while ((read =3D getline(&line, &line_sz, cpuinfo)) !=3D -1) {
> +               if (strncmp(line, CPUINFO_MODEL, strlen(CPUINFO_MODEL)))
> +                       continue;
> +
> +               model =3D _get_field(line);
> +               if (!model)
> +                       goto free;
> +               break;
> +       }
> +
> +       if (asprintf(&cpuid, "%s", model) < 0)
> +               cpuid =3D NULL;
> +
> +free:
> +       fclose(cpuinfo);
> +       free(model);
> +       return cpuid;
> +}
> +
> +int get_cpuid(char *buffer, size_t sz)
> +{
> +       char *cpuid =3D _get_cpuid();
> +       int ret =3D 0;
> +
> +       if (sz < strlen(cpuid)) {

Could this not segfault if cpuid is NULL?

Thanks,
Ian

> +               ret =3D -EINVAL;
> +               goto free;
> +       }
> +
> +       scnprintf(buffer, sz, "%s", cpuid);
> +free:
> +       free(cpuid);
> +       return ret;
> +}
> +
> +char *get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
> +{
> +       return _get_cpuid();
> +}
> diff --git a/tools/perf/arch/loongarch/util/kvm-stat.c b/tools/perf/arch/=
loongarch/util/kvm-stat.c
> new file mode 100644
> index 000000000000..2c21d73cd855
> --- /dev/null
> +++ b/tools/perf/arch/loongarch/util/kvm-stat.c
> @@ -0,0 +1,141 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <errno.h>
> +#include <memory.h>
> +#include <errno.h>
> +#include "util/kvm-stat.h"
> +#include "util/parse-events.h"
> +#include "util/debug.h"
> +#include "util/evsel.h"
> +#include "util/evlist.h"
> +#include "util/pmus.h"
> +
> +#define LOONGARCH_EXCEPTION_INT                0
> +#define LOONGARCH_EXCEPTION_PIL                1
> +#define LOONGARCH_EXCEPTION_PIS                2
> +#define LOONGARCH_EXCEPTION_PIF                3
> +#define LOONGARCH_EXCEPTION_PME                4
> +#define LOONGARCH_EXCEPTION_FPD                15
> +#define LOONGARCH_EXCEPTION_SXD                16
> +#define LOONGARCH_EXCEPTION_ASXD       17
> +#define LOONGARCH_EXCEPTION_GSPR       22
> +#define  LOONGARCH_EXCEPTION_CPUCFG    100
> +#define  LOONGARCH_EXCEPTION_CSR       101
> +#define  LOONGARCH_EXCEPTION_IOCSR     102
> +#define  LOONGARCH_EXCEPTION_IDLE      103
> +#define  LOONGARCH_EXCEPTION_OTHERS    104
> +#define LOONGARCH_EXCEPTION_HVC                23
> +
> +#define loongarch_exception_type                               \
> +       {LOONGARCH_EXCEPTION_INT,  "Interrupt" },               \
> +       {LOONGARCH_EXCEPTION_PIL,  "Mem read" },                \
> +       {LOONGARCH_EXCEPTION_PIS,  "Mem store" },               \
> +       {LOONGARCH_EXCEPTION_PIF,  "Ifecth" },                  \
> +       {LOONGARCH_EXCEPTION_PME,  "Mem modify" },              \
> +       {LOONGARCH_EXCEPTION_FPD,  "FPU" },             \
> +       {LOONGARCH_EXCEPTION_SXD,  "LSX" },             \
> +       {LOONGARCH_EXCEPTION_ASXD, "LASX" },            \
> +       {LOONGARCH_EXCEPTION_GSPR, "Privilege Error" },         \
> +       {LOONGARCH_EXCEPTION_HVC,  "Hypercall" },               \
> +       {LOONGARCH_EXCEPTION_CPUCFG, "Cpucfg" },                \
> +       {LOONGARCH_EXCEPTION_CSR,    "Csr" },                   \
> +       {LOONGARCH_EXCEPTION_IOCSR,  "Iocsr" },                 \
> +       {LOONGARCH_EXCEPTION_IDLE,   "Idle" },                  \
> +       {LOONGARCH_EXCEPTION_OTHERS, "Others" }
> +
> +
> +define_exit_reasons_table(loongarch_exit_reasons, loongarch_exception_ty=
pe);
> +
> +const char *vcpu_id_str =3D "vcpu_id";
> +const char *kvm_exit_reason =3D "reason";
> +const char *kvm_entry_trace =3D "kvm:kvm_enter";
> +const char *kvm_reenter_trace =3D "kvm:kvm_reenter";
> +const char *kvm_exit_trace =3D "kvm:kvm_exit";
> +
> +const char *kvm_events_tp[] =3D {
> +       "kvm:kvm_enter",
> +       "kvm:kvm_reenter",
> +       "kvm:kvm_exit",
> +       "kvm:kvm_exit_gspr",
> +       NULL,
> +};
> +
> +static bool event_end(struct evsel *evsel,
> +               struct perf_sample *sample __maybe_unused,
> +               struct event_key *key __maybe_unused)
> +{
> +       /*
> +        * LoongArch kvm is a little different with other architectures
> +        *
> +        * There is kvm:kvm_reenter and kvm:kvm_enter event adjacent with
> +        * kvm:kvm_exit event.
> +        *   kvm:kvm_reenter means returning to guest immediately
> +        *   kvm:kvm_enter   means returning to vmm and then to guest
> +        */
> +       return evsel__name_is(evsel, kvm_entry_trace) ||
> +               evsel__name_is(evsel, kvm_reenter_trace);
> +}
> +
> +static void event_gspr_get_key(struct evsel *evsel,
> +                       struct perf_sample *sample,
> +                       struct event_key *key)
> +{
> +       unsigned int insn;
> +
> +       key->key =3D LOONGARCH_EXCEPTION_OTHERS;
> +       insn =3D evsel__intval(evsel, sample, "inst_word");
> +       switch (insn >> 24) {
> +       case 0:
> +               /* cpucfg inst trap */
> +               if ((insn >> 10) =3D=3D 0x1b)
> +                       key->key =3D LOONGARCH_EXCEPTION_CPUCFG;
> +               break;
> +       case 4:
> +               /* csr inst trap */
> +               key->key =3D LOONGARCH_EXCEPTION_CSR;
> +               break;
> +       case 6:
> +               /* iocsr inst trap */
> +               if ((insn >> 15) =3D=3D 0xc90)
> +                       key->key =3D LOONGARCH_EXCEPTION_IOCSR;
> +               else if ((insn >> 15) =3D=3D 0xc91)
> +                       /* idle inst trap */
> +                       key->key =3D LOONGARCH_EXCEPTION_IDLE;
> +               break;
> +       default:
> +               key->key =3D LOONGARCH_EXCEPTION_OTHERS;
> +               break;
> +       }
> +}
> +
> +static struct child_event_ops child_events[] =3D {
> +       { .name =3D "kvm:kvm_exit_gspr",
> +       .get_key =3D event_gspr_get_key },
> +       { NULL, NULL },
> +};
> +
> +static struct kvm_events_ops exit_events =3D {
> +       .is_begin_event =3D exit_event_begin,
> +       .is_end_event =3D event_end,
> +       .child_ops =3D child_events,
> +       .decode_key =3D exit_event_decode_key,
> +       .name =3D "VM-EXIT"
> +};
> +
> +struct kvm_reg_events_ops kvm_reg_events_ops[] =3D {
> +       {
> +               .name   =3D "vmexit",
> +               .ops    =3D &exit_events,
> +       },
> +       { NULL, NULL },
> +};
> +
> +const char * const kvm_skip_events[] =3D {
> +       NULL,
> +};
> +
> +int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid __maybe_un=
used)
> +{
> +       kvm->exit_reasons_isa =3D "loongarch64";
> +       kvm->exit_reasons =3D loongarch_exit_reasons;
> +       return 0;
> +}
>
> base-commit: f2f80ac809875855ac843f9e5e7480604b5cbff5
> --
> 2.39.3
>
>

