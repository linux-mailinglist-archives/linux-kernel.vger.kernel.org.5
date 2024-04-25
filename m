Return-Path: <linux-kernel+bounces-159049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4E98B289F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 114CE1F21D35
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CBD1509AE;
	Thu, 25 Apr 2024 18:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVHp0Iqo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D187C14F118;
	Thu, 25 Apr 2024 18:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071535; cv=none; b=L7kED5D++cDotw8mIEf+/MmCKGkTM94tYDJe+P+9BvrYm1YQZRmoBeLN6gSx60+WTGYExanck803t1/doC2V/41RnHjJSWYnDDltlFxthKB2THA2R7p4am9jQS+7fcaEoP9HBgACJFXS5byIGm1HH0soePjTz0VATt0+o5dwolU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071535; c=relaxed/simple;
	bh=4Sx4sYmGqoS09z606peTfqhN5qWJQdHwsKYaEAQY4ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vc+7Nki6/Lb+jdWv4q+2PuQG+p30+TrqkcZ/4+gHXO0Y1p6OlA3ieCb95l9SnHdAgWqZIDxWJH56XLdCnZjZDqkmXPBj7/GEPQNXKq82hidHoIDKwGF1RxGYvHgLVsfuWDBR2xi4y3n//DoMHEiu20gA0OOph0v/T6fdUOddJ8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVHp0Iqo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3084C113CC;
	Thu, 25 Apr 2024 18:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714071535;
	bh=4Sx4sYmGqoS09z606peTfqhN5qWJQdHwsKYaEAQY4ZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fVHp0Iqo1nNOv0NlQqAY6MhJrIELR+vsYbhGImeZDbSWcT4lW+ZcU4UpL5S0hDyIc
	 +1My9aExWwxuIsW7gwdJ9GtsfR2gTOYyrp6GgRn6FrhFzYGTmQOml2ZQOXmVayL1Tl
	 n8/98w4QwClbVknf/1f0vjjSINn8ULQZFKw3+Vs/DrxuYcvDN3NwNydUeSYl7w8QWz
	 GT5081UEmq4ev4W5jFHcMY7RqaAuD6SZ5cpdRBDgyGvwxlaUUBDfYlFKsOuJNOa9Or
	 kUfYfwdTghRSosdcG3qHRaprxMU+Eddt+M4JDdDl64naVSkKybOkgLQ9+3Cqi7d+uO
	 RJEX3JxoRGeSg==
Date: Thu, 25 Apr 2024 15:58:50 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Veronika Molnarova <vmolnaro@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf test: Be more tolerant of metricgroup failures
Message-ID: <Ziqn6nPtxHCc6RpR@x1>
References: <20240403164818.3431325-1-irogers@google.com>
 <CAGa8GX5MhP3FUhafN5QivHaE3Fg+p5MgvTq3SW6MQy4NeZ1sYQ@mail.gmail.com>
 <CAP-5=fU_EvN-bSjwbWMP8R+WyG-jeAQ1p4ziyejy2FCH0kgYig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU_EvN-bSjwbWMP8R+WyG-jeAQ1p4ziyejy2FCH0kgYig@mail.gmail.com>

On Mon, Apr 22, 2024 at 08:42:17AM -0700, Ian Rogers wrote:
> On Mon, Apr 22, 2024 at 4:51 AM Veronika Molnarova <vmolnaro@redhat.com> wrote:
> >
> > Hi Ian,
> >
> > On Wed, Apr 3, 2024 at 6:48 PM Ian Rogers <irogers@google.com> wrote:
> >>
> >> Previously "set -e" meant any non-zero exit code from perf stat would
> >> cause a test failure. As a non-zero exit happens when there aren't
> >> sufficient permissions, check for this case and make the exit code
> >> 2/skip for it.
> >>
> >> Signed-off-by: Ian Rogers <irogers@google.com>
> >> ---
> >>  .../perf/tests/shell/stat_all_metricgroups.sh | 28 +++++++++++++++----
> >>  1 file changed, 22 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/tools/perf/tests/shell/stat_all_metricgroups.sh b/tools/perf/tests/shell/stat_all_metricgroups.sh
> >> index 55ef9c9ded2d..d6db192b9f18 100755
> >> --- a/tools/perf/tests/shell/stat_all_metricgroups.sh
> >> +++ b/tools/perf/tests/shell/stat_all_metricgroups.sh
> >> @@ -1,9 +1,7 @@
> >> -#!/bin/sh
> >> +#!/bin/bash
> >>  # perf all metricgroups test
> >>  # SPDX-License-Identifier: GPL-2.0
> >>
> >> -set -e
> >> -
> >>  ParanoidAndNotRoot()
> >>  {
> >>    [ "$(id -u)" != 0 ] && [ "$(cat /proc/sys/kernel/perf_event_paranoid)" -gt $1 ]
> >> @@ -14,11 +12,29 @@ if ParanoidAndNotRoot 0
> >>  then
> >>    system_wide_flag=""
> >>  fi
> >> -
> >> +err=0
> >>  for m in $(perf list --raw-dump metricgroups)
> >>  do
> >>    echo "Testing $m"
> >> -  perf stat -M "$m" $system_wide_flag sleep 0.01
> >> +  result=$(perf stat -M "$m" $system_wide_flag sleep 0.01 2>&1)
> >> +  result_err=$?
> >> +  if [[ $result_err -gt 0 ]]
> >> +  then
> >> +    if [[ "$result" =~ \
> >> +          "Access to performance monitoring and observability operations is limited" ]]
> >> +    then
> >> +      echo "Permission failure"
> >> +      echo $result
> >> +      if [[ $err -eq 0 ]]
> >> +      then
> >> +        err=2 # Skip
> >> +      fi
> >> +    else
> >> +      echo "Metric group $m failed"
> >> +      echo $result
> >> +      err=1 # Fail
> >> +    fi
> >> +  fi
> >>  done
> >>
> >> -exit 0
> >> +exit $err
> >> --
> >> 2.44.0.478.gd926399ef9-goog
> >>
> >>
> >
> > The patch looks good and thanks for taking care of it.
> >
> > Just wanted to check what is the desired outcome for metric groups
> > with events that are invalid in per-thread mode causing the test to fail.
> >
> > ```
> > $ ./stat_all_metricgroups.sh
> > Testing smi
> > Metric group smi failed
> > Error: Invalid event (msr/smi/u) in per-thread mode, enable system wide with '-a'.
> > ```
> >
> > Wouldn't it be better if in these cases the test would result in skip instead of fail?
> 
> Hi Veronika,
> 
> I agree that fail isn't best here. I'm wondering:
> 
>  - why doesn't msr/smi/ support per-thread mode? Can't we save/restore
> the count on a context switch? The implementation is here:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/arch/x86/events/msr.c?h=perf-tools-next#n234
> There's clearly something going on as pperf appears to have other restrictions:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/arch/x86/events/msr.c?h=perf-tools-next#n115
> I'm wondering if aggregation is working right if these counters are
> more than per hyperthread (I'm guessing why the restrictions exist).
> 
>  - the tool error message is doing pretty good. In the test I guess we
> can spot the per-thread error and turn the fail to a skip. It's a
> shame to bucket things as skip, but it seems easier than listing
> metrics in the test or spotting particular events.
> 
> I can do a v2 to add this.

Ok, I'll wait for v2 then.

- Arnaldo

