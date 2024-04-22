Return-Path: <linux-kernel+bounces-153648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E558AD11F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ECBA1F230D0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4559D1534E2;
	Mon, 22 Apr 2024 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="PPYY8eI1"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0792C1534EB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713800553; cv=none; b=ZpqXNJYo+Rb6ua1BLBaI/brn6ZteG1TCFDFBkTambf19Hvkv/ArcwLuMzaHcwX1lEo79WvwJkLDOp0TyHvvH2VIGa+q3FAzDSULCi2yLOoswAaRa62mNmTmgKB8RvkNbVqfQFXAM0kwgywRzOIoqOA9UY5broKR/CfeTjTjsdjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713800553; c=relaxed/simple;
	bh=tXjSwVBeGb/Eb0FtFwqpwFwRnMr6GKOhM4c8ow2qQ9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRyBg2VgscKLavQaWsWixHN67ETipLRr64qnUiq3abEjOaJcuaKHSDslxvirPPnFsGDzAMp+M74q979cTjWBiyU+3gMIeLLqfy1DTR+z96uZ0fGNzRyuCw/9Qoi7r8lfqjstH5BRjkSpLI2raHzAdzyWC0paYObtgRsUGZ5CHnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PPYY8eI1; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-436ed871225so538951cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713800550; x=1714405350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LWWbUhCinHZ4pRRDKlPFXeIrr7YidOY2PqyCtNwxyA=;
        b=PPYY8eI1S3O8scbt6x/Zx50IcR/bxB1i8qTziTZ2FJwijamJTwQNKWJSkXCi2HglH0
         Lsk5sAAXOxKDVhZ/cGjPpGv3iIMbDYjQXsKziJX5ZySsBwe/wpIddI1L8qovi63gJpLQ
         EmC9eJXp+yVA8SVwth+RhQNDuFZqWMHU5MiYpiv391y8mGeEgmJSAibPA6CRHd+DQxJY
         zA0Thf1llvmHvZB2gXZRKGnwTG6Tq37zby+kd71UYqG4C2f56PujYbsln1b4tzR1ojBt
         VhKREBjN/LeepQpNl8RFpoobhiW7i6K7JH8q+sramtnacV1xK/1X6V3pVq1C2dsePtAn
         oXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713800550; x=1714405350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5LWWbUhCinHZ4pRRDKlPFXeIrr7YidOY2PqyCtNwxyA=;
        b=XzC11KCPPAf2JlbBdSZYE44gCff7+aDUqxSWpz53ctqH+kkYzlTekR2kM46EHHH1j7
         ld5fwI4v3Ij441AnmREIa4rhQ48h8sgEtbenD5sfZL2/e22VGs+W6LCf1gY2lX4dkUHE
         ofNPHtxgYSZpJFDImnvRfrQPQmDn2waAoruF+ItB+fJDvwmROQCj/Mif8Do4AARXTATC
         HroNddjDC4gfhvYBAFzfWSaLJ7H/vFimbtWpyombKQ+QUculR0z6ps4Nqy9UmTfMgk30
         lB3AM1zVTIzyV6JUkyWUGrm0cMz3e6s+sFIiGbE8DCn2CsMJk/oNyZKUyyLiwhodXm6U
         6Wow==
X-Forwarded-Encrypted: i=1; AJvYcCUwcqx43mNfIgf5ZNOufHmkd7Egoe6oN79vtsDiMruzck4/ZYHiMeeMFd1x6p1zBVcJmnH/q5LgL0mMVm3ciIQfI2+VAWD0CYFM0GRV
X-Gm-Message-State: AOJu0YwxdZB1daLeryZmRBeXydTLMrZwUEhQLhW9D8sB6jAkrp5p2JCz
	Fmul+3QGGPPzUzNCbSxrGR/6iduIECtSJ6+iOhpu08n/a5RNPWTmOL+kAPa73fR94VEsVQCt7MP
	hXFUIOX+2TCrbUTQ4xq0PibZm1mLXPBtaaWB3
X-Google-Smtp-Source: AGHT+IGqGSjYwcJiVDgalrNn9TAUZdU5fgYKsr64wzHajwJV8/cKH1NAZTOsWkwmjf3FzaLTTq7w5Jmo5xwj/l8huMk=
X-Received: by 2002:ac8:5885:0:b0:437:c4ae:f3b4 with SMTP id
 t5-20020ac85885000000b00437c4aef3b4mr542257qta.26.1713800549734; Mon, 22 Apr
 2024 08:42:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403164818.3431325-1-irogers@google.com> <CAGa8GX5MhP3FUhafN5QivHaE3Fg+p5MgvTq3SW6MQy4NeZ1sYQ@mail.gmail.com>
In-Reply-To: <CAGa8GX5MhP3FUhafN5QivHaE3Fg+p5MgvTq3SW6MQy4NeZ1sYQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 22 Apr 2024 08:42:17 -0700
Message-ID: <CAP-5=fU_EvN-bSjwbWMP8R+WyG-jeAQ1p4ziyejy2FCH0kgYig@mail.gmail.com>
Subject: Re: [PATCH v1] perf test: Be more tolerant of metricgroup failures
To: Veronika Molnarova <vmolnaro@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 4:51=E2=80=AFAM Veronika Molnarova <vmolnaro@redhat=
com> wrote:
>
> Hi Ian,
>
> On Wed, Apr 3, 2024 at 6:48=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>>
>> Previously "set -e" meant any non-zero exit code from perf stat would
>> cause a test failure. As a non-zero exit happens when there aren't
>> sufficient permissions, check for this case and make the exit code
>> 2/skip for it.
>>
>> Signed-off-by: Ian Rogers <irogers@google.com>
>> ---
>>  .../perf/tests/shell/stat_all_metricgroups.sh | 28 +++++++++++++++----
>>  1 file changed, 22 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/perf/tests/shell/stat_all_metricgroups.sh b/tools/per=
f/tests/shell/stat_all_metricgroups.sh
>> index 55ef9c9ded2d..d6db192b9f18 100755
>> --- a/tools/perf/tests/shell/stat_all_metricgroups.sh
>> +++ b/tools/perf/tests/shell/stat_all_metricgroups.sh
>> @@ -1,9 +1,7 @@
>> -#!/bin/sh
>> +#!/bin/bash
>>  # perf all metricgroups test
>>  # SPDX-License-Identifier: GPL-2.0
>>
>> -set -e
>> -
>>  ParanoidAndNotRoot()
>>  {
>>    [ "$(id -u)" !=3D 0 ] && [ "$(cat /proc/sys/kernel/perf_event_paranoi=
d)" -gt $1 ]
>> @@ -14,11 +12,29 @@ if ParanoidAndNotRoot 0
>>  then
>>    system_wide_flag=3D""
>>  fi
>> -
>> +err=3D0
>>  for m in $(perf list --raw-dump metricgroups)
>>  do
>>    echo "Testing $m"
>> -  perf stat -M "$m" $system_wide_flag sleep 0.01
>> +  result=3D$(perf stat -M "$m" $system_wide_flag sleep 0.01 2>&1)
>> +  result_err=3D$?
>> +  if [[ $result_err -gt 0 ]]
>> +  then
>> +    if [[ "$result" =3D~ \
>> +          "Access to performance monitoring and observability operation=
s is limited" ]]
>> +    then
>> +      echo "Permission failure"
>> +      echo $result
>> +      if [[ $err -eq 0 ]]
>> +      then
>> +        err=3D2 # Skip
>> +      fi
>> +    else
>> +      echo "Metric group $m failed"
>> +      echo $result
>> +      err=3D1 # Fail
>> +    fi
>> +  fi
>>  done
>>
>> -exit 0
>> +exit $err
>> --
>> 2.44.0.478.gd926399ef9-goog
>>
>>
>
> The patch looks good and thanks for taking care of it.
>
> Just wanted to check what is the desired outcome for metric groups
> with events that are invalid in per-thread mode causing the test to fail.
>
> ```
> $ ./stat_all_metricgroups.sh
> Testing smi
> Metric group smi failed
> Error: Invalid event (msr/smi/u) in per-thread mode, enable system wide w=
ith '-a'.
> ```
>
> Wouldn't it be better if in these cases the test would result in skip ins=
tead of fail?

Hi Veronika,

I agree that fail isn't best here. I'm wondering:

 - why doesn't msr/smi/ support per-thread mode? Can't we save/restore
the count on a context switch? The implementation is here:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/arch/x86/events/msr.c?h=3Dperf-tools-next#n234
There's clearly something going on as pperf appears to have other restricti=
ons:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/arch/x86/events/msr.c?h=3Dperf-tools-next#n115
I'm wondering if aggregation is working right if these counters are
more than per hyperthread (I'm guessing why the restrictions exist).

 - the tool error message is doing pretty good. In the test I guess we
can spot the per-thread error and turn the fail to a skip. It's a
shame to bucket things as skip, but it seems easier than listing
metrics in the test or spotting particular events.

I can do a v2 to add this.

Thanks,
Ian

> Thanks,
> Veronika
>

