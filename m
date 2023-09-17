Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B32A7A33CF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 07:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjIQFZN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 17 Sep 2023 01:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjIQFY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 01:24:56 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC5A19F;
        Sat, 16 Sep 2023 22:24:51 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-79275d86bc3so132230739f.0;
        Sat, 16 Sep 2023 22:24:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694928291; x=1695533091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L2PEWOCH3Oi47G+B9Ydh9wql/Nmm8hAKIK7292mMif4=;
        b=PseFOhamYPY86kP2wWePbglRydbtQMdzzblGs66pb134GlmjMXGDA7w/s/fHMRnWh7
         WBTHCxpqzrGoY2VA1n1Ge4WcEUX8ObDyksep/ZDWKqkIk4tqOm6XZk5cfIaNjxwYqX0P
         rtAa/SJi5yxKEPJSvheCVxqgjM1xvLFd/4N8OOl2FhPIWvRMzZIzfwb2ojJolp8R8vxK
         AolfCx2qclkHhs6dzPcDMgnufG9E1HoMq8CQGu0kJl93SF0rT19sMFQ/3kAU09JQA6y5
         /hpjdDpuWCybblHiAITaUw0ASHVBVnvzv/jKGTRvDRy2ZopwJUI84jk9BlViN9t6CRbE
         RivA==
X-Gm-Message-State: AOJu0YwFqfnJNFNmalYAFqALdGTGlae9ZwaeNCJydPyguHGubhPpyH81
        C8AiijRVEZFNJHYQ8B17pAf8YAgsrEM3fAlcOTw=
X-Google-Smtp-Source: AGHT+IEUc1ta25FnPXE/IAqubi2VacL2DsWca0BHvbo26FJ/O+/4pWBKEh3PYoKjqTm0RfRsj7RHteFcoc3tNRSa3vQ=
X-Received: by 2002:a6b:7319:0:b0:776:fd07:3c96 with SMTP id
 e25-20020a6b7319000000b00776fd073c96mr6420841ioh.7.1694928290868; Sat, 16 Sep
 2023 22:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230913153355.138331-1-james.clark@arm.com>
In-Reply-To: <20230913153355.138331-1-james.clark@arm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 16 Sep 2023 22:24:38 -0700
Message-ID: <CAM9d7ciKDBz8k6bvtyVcr-FUkXjqNYZ=8GAuObfPhcBn4whzrg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] perf: strcmp_cpuid_str() expression fixups
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, irogers@google.com,
        acme@kernel.org, John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Haixin Yu <yuhaixin.yhx@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Sep 13, 2023 at 8:34 AM James Clark <james.clark@arm.com> wrote:
>
> Set of fixes related to the comments here [1]. Mainly cleanups,
> additional tests and refactoring since adding the new strcmp_cpuid_str()
> metric expression.
>
> I added the string replace function to the perf utils
> rather than tools/lib/string.c because it didn't seem
> easy to add tests for tools/lib.
>
> [1]: https://lore.kernel.org/linux-arm-kernel/CAP-5=fVnUx0BnJC7X1rrm42OD7Bk=ZsHWNwAZMBYyB7yWhBfhQ@mail.gmail.com/
> [2]: https://lore.kernel.org/linux-perf-users/ZQC7da2AM9ih8RMz@kernel.org/
>
> ---
> Changes since v2:
>   * Drop patches that were already applied (which makes the cover letter
>     mostly redundant)
>   * Avoid generating the compiler warning reported here [2]
>
> Changes since v1:
>   * s -> haystack
>   * find -> needle
>
> James Clark (3):
>   perf pmu: Move pmu__find_core_pmu() to pmus.c
>   perf pmus: Simplify perf_pmus__find_core_pmu()
>   perf pmu: Remove unused function

Applied to perf-tools-next, thanks!
