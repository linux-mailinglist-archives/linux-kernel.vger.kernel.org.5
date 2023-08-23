Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD81785298
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbjHWIWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbjHWISJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:18:09 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F24F30E8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:12:39 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-40a47e8e38dso177151cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692778359; x=1693383159;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hAS0PucsjGJ0x+ONVaiQoPrUdvJWs0Q6o9fYxtLr1Y=;
        b=jH89Lz24KB4c4HeG4wUCO0s6Q7VX+mz8HZQmZAsTCy1XOaRjkXM3VVAkCwsTGOXHau
         /wipm8OF2SsaEqCBDl3n1ssRgdH+09Yjgdhe97QfoXAnESDZKP7M0x9YgEyAZP7V/U1/
         ypUJOvwz9jzxWi6Oj60FWEhagE27LYaTRgcxAzmr12jWM/M1J2y7W4WUCJZWV234iawA
         Pvh0pJ0HQKNg5P0RMiqlTYWjclXeBLGXQ0CWC5th8JfEat7EDEKmlLjwK509liO9qE9u
         18df3qnXWzO9AI9J0lANmDZiHYBUL0VISHc72rVD01xI8mbIjpyuQpqGFe///Z4J3AfQ
         9ZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692778359; x=1693383159;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+hAS0PucsjGJ0x+ONVaiQoPrUdvJWs0Q6o9fYxtLr1Y=;
        b=HSnXJwa4eJnt8h4X+U88bymhJgxb5cGtHqrVuHWY8ECHb1ak51Y06OmtYAV/GCIAQb
         iLdrDQEpVP6tvMl+uIOaXCpTKQ2OWVjTPYsfmB3PRiWJd78CXSfMFRiGZSykvBRmdlHR
         f8O2pj6eBL09zn8Fx6BbnJR1qZwlUDaMDARKe/UrhboYzHi/3udtrRBVjnD1MLbj5t18
         wzqAWlTVtaDfwqS2Cw+eqLJEzr3roXg8e6EIIQXeA2JnC1JwfvG9+EuYBrzczCEuoZAk
         BFzovDKBLOZT+Cpzsf3paRxSPN8qY7tMtxfykJKibG+bE4ZHkzoH5++h1njUtRGQWKiW
         aL+w==
X-Gm-Message-State: AOJu0YxtUcPNA6MyRG+saN8O7DHQ9c/WXWk0DBirb2OcSmIB9QfzQhKr
        WDQDWG69IhVdrRYV5wAxPuLpg+Rf7LcN8vCi70Z2HaUAJ1RbXVddSowE5w==
X-Google-Smtp-Source: AGHT+IE77K8yRPmJ2SQORc9C/8F23EPMFOTtGihYaUoykwCv43DtexAo6gDBGFGSHRNTiHfVT1iWXndiEs+MoCe4pzk=
X-Received: by 2002:ac8:5a47:0:b0:410:653f:90e8 with SMTP id
 o7-20020ac85a47000000b00410653f90e8mr425655qta.11.1692778358905; Wed, 23 Aug
 2023 01:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230823080828.1460376-1-irogers@google.com>
In-Reply-To: <20230823080828.1460376-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 23 Aug 2023 01:12:27 -0700
Message-ID: <CAP-5=fX3a=Ng=8Gd-DNx1+dKj7QEZJxMCFW_=brdU52ADuwf7g@mail.gmail.com>
Subject: Re: [PATCH v1 00/25] Lazily load PMU data
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 1:08=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> Lazily load PMU data both from sysfs and json files. Reorganize
> json data to be more PMU oriented to facilitate this, for
> example, json data is now sorted into arrays for their PMU.
>
> In refactoring the code some changes were made to get rid of maximum
> encoding sizes for events (256 bytes), with input files being directly
> passed to the lex generated code. There is also a small event parse
> error message improvement.
>
> Some results from an Intel tigerlake laptop running Debian:
>
> Binary size reduction of 1.4% or 143,264 bytes because the PMU
> name no longer appears in the string.
>
> stat -e cpu/cycles/ minor faults reduced from 1733 to 1667, open calls re=
duced
> from 171 to 94.
>
> stat default minor faults reduced from 1085 to 1727, open calls reduced
> from 654 to 343.

s/1085/1805/

Thanks,
Ian

>
> Average PMU scanning reduced from 4720.641usec to 2927.293usec.
> Average core PMU scanning reduced from 1004.658usec to 232.668usec
> (4.3x faster).
>
> Ian Rogers (25):
>   perf script ibs: Remove unused include
>   perf pmu: Avoid a path name copy
>   perf pmu: Move perf_pmu__set_format to pmu.y
>   perf pmu: Reduce scope of perf_pmu_error
>   perf pmu: Avoid passing format list to perf_pmu__config_terms
>   perf pmu: Avoid passing format list to perf_pmu__format_type
>   perf pmu: Avoid passing format list to perf_pmu__format_bits
>   perf pmu: Pass PMU rather than aliases and format
>   perf pmu: Make the loading of formats lazy
>   perf pmu: Abstract alias/event struct
>   perf pmu-events: Add extra underscore to function names
>   perf jevents: Group events by PMU
>   perf parse-events: Improve error message for double setting
>   perf s390 s390_cpumcfdg_dump: Don't scan all PMUs
>   perf pmu-events: Reduce processed events by passing PMU
>   perf pmu-events: Add pmu_events_table__find_event
>   perf pmu: Parse sysfs events directly from a file
>   perf pmu: Prefer passing pmu to aliases list
>   perf pmu: Merge json events with sysfs at load time
>   perf pmu: Cache json events table
>   perf pmu: Lazily add json events
>   perf pmu: Scan type early to fail an invalid PMU quickly
>   perf pmu: Be lazy about loading event info files from sysfs
>   perf pmu: Lazily load sysfs aliases
>   perf jevents: Sort strings in the big C string to reduce faults
>
>  tools/perf/arch/x86/util/intel-pt.c      |  39 +-
>  tools/perf/bench/pmu-scan.c              |   8 +-
>  tools/perf/pmu-events/empty-pmu-events.c |  49 +-
>  tools/perf/pmu-events/jevents.py         | 319 +++++++--
>  tools/perf/pmu-events/pmu-events.h       |  15 +-
>  tools/perf/tests/parse-events.c          |   2 +-
>  tools/perf/tests/pmu-events.c            | 183 ++---
>  tools/perf/tests/pmu.c                   |  76 +-
>  tools/perf/util/amd-sample-raw.c         |   1 -
>  tools/perf/util/metricgroup.c            |  10 +-
>  tools/perf/util/parse-events.c           |  91 ++-
>  tools/perf/util/parse-events.h           |   3 +-
>  tools/perf/util/pmu.c                    | 872 +++++++++++++++--------
>  tools/perf/util/pmu.h                    | 110 ++-
>  tools/perf/util/pmu.y                    |  32 +-
>  tools/perf/util/pmus.c                   | 230 ++----
>  tools/perf/util/s390-sample-raw.c        |  50 +-
>  17 files changed, 1251 insertions(+), 839 deletions(-)
>
> --
> 2.42.0.rc1.204.g551eb34607-goog
>
