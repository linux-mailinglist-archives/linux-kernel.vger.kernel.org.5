Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5F7787764
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 20:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242954AbjHXSCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 14:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242963AbjHXSBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 14:01:53 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BAB1BE9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:01:45 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-4036bd4fff1so39811cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692900105; x=1693504905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIzsd1z1v5q0zT+t3tj7Zr/vc4gw5mWKfXzVBU6LAvY=;
        b=l1ILoTfr+PR8gDX8IMy9mclysop/b4uO6h84xlQ6TC5iDBSbIZMjMLx5gEt0L2J6Df
         lIIfzOFyl7x2e3pFCR3ukGtC9iBzIdzF9uCDOwC2m/tX6X8+NUZ8HsewcvMJRCiyXIDB
         GqOwLzT2XPwou4ijIS4jJdBeclxwaY47OQUZr7xveHGz9UWqssieRIw6DXqaLlOxaKpK
         8YVQt/qyn3FI8ulR8mt+hTMGuLeCLRByEHGHvvlzWZZW5gcC7JMlyv0zbCqnB/zLQrZw
         9vRcOHpJdUGODFmMnXcdB4x8rVmiObGob4gu33P94pEXQ7mWlQ6vxvRkG3TfpeZQiD3I
         hhug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692900105; x=1693504905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIzsd1z1v5q0zT+t3tj7Zr/vc4gw5mWKfXzVBU6LAvY=;
        b=CaNUfzdlq7JBl3qpNdq8oabqVAa1on1/SwtY+4ptHw6pZajOhrtr6GEKmOhJWNlYwj
         O4eHDwY0VApuNT5et1UrZt8go1ctQL4A4SY6nrIN+f/HOMRiGqaP+ZhIldKOkykODUtJ
         OoQryUPglGRc57DABqPrtlWuJ8U07xaO9s3uWAxZvGDY8nrEZCNDgf9P5vtig13f2uIS
         XTCObam46hA2s5dPS91t9x1QNNMkq2BsF88qZbejbeXdwZykZ/5VR2vcADy0mLFqVy+X
         Qv0wKGsGvK3fQLJr9cgwbI4UPposekS5JV67svN4kCzzFi7MV0gOweizU9Xjf1MEKPOD
         U8hA==
X-Gm-Message-State: AOJu0YyE1OdGRwffc7EFxWZLPF4QwCTUSh2u9riasW1MryNEIiZXg73i
        9CG69GzBqZWUe/TudnZ/bh9EXkI7E1L+CzB58awQKg==
X-Google-Smtp-Source: AGHT+IFPU/hypYSgqHQIktrv1Xn7iaQwf2jWMDyKNDI1d9lVCy0v3wmU+EjCvPzxMr0Sd7UywtPTZqGWP4YHeKUemiU=
X-Received: by 2002:ac8:5a83:0:b0:3ef:5f97:258f with SMTP id
 c3-20020ac85a83000000b003ef5f97258fmr31883qtc.16.1692900104609; Thu, 24 Aug
 2023 11:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230824041330.266337-1-irogers@google.com> <ZOduqlhnP6+HNSUl@kernel.org>
In-Reply-To: <ZOduqlhnP6+HNSUl@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 24 Aug 2023 11:01:32 -0700
Message-ID: <CAP-5=fXjJzHX9AsnAn-KHG03-D9RBCFdUsaybsAbpefHwcXagg@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] Lazily load PMU data
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 7:52=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Aug 23, 2023 at 09:13:12PM -0700, Ian Rogers escreveu:
> > Lazily load PMU data both from sysfs and json files. Reorganize
> > json data to be more PMU oriented to facilitate this, for
> > example, json data is now sorted into arrays for their PMU.
> >
> > In refactoring the code some changes were made to get rid of maximum
> > encoding sizes for events (256 bytes), with input files being directly
> > passed to the lex generated code. There is also a small event parse
> > error message improvement.
> >
> > Some results from an Intel tigerlake laptop running Debian:
> >
> > Binary size reduction of 5.3% or 552,864 bytes because the PMU
> > name no longer appears in the string or desc field.
> >
> > stat -e cpu/cycles/ minor faults reduced from 1733 to 1667, open calls =
reduced
> > from 171 to 94.
> >
> > stat default minor faults reduced from 1805 to 1717, open calls reduced
> > from 654 to 343.
> >
> > Average PMU scanning reduced from 4720.641usec to 2927.293usec.
> > Average core PMU scanning reduced from 1004.658usec to 232.668usec
> > (4.3x faster).
> >
> > v2: Add error path for failing strdup when allocating a format,
> >     suggested by Arnaldo. Rebased on top of tmp.perf-tools-next
> >     removing 8 patches. Added "perf jevents: Don't append Unit to
> >     desc" to save yet more encoding json event space.
>
> So this is failing here:
>
> [acme@quaco ~]$ perf test 10
>  10: PMU events                                 :
>  10.1: PMU event table sanity                           : FAILED!
>  10.2: PMU event map aliases                            : FAILED!
>  10.3: Parsing of PMU event table metrics               : Ok
>  10.4: Parsing of PMU event table metrics with fake PMUs: Ok
>  10.5: Parsing of metric thresholds with fake PMUs      : Ok
> [acme@quaco ~]$
>
> [root@quaco ~]# grep -m1 "model name" /proc/cpuinfo
> model name      : Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz
> [root@quaco ~]#
>
>
> [root@quaco ~]# perf test -vv -F 10 |& head -40
>  10: PMU events                                                      :
>  10.1: PMU event table sanity                                        :
> --- start ---
> testing event table bp_l1_btb_correct: pass
> testing event table bp_l2_btb_correct: pass
> testing event table dispatch_blocked.any: pass
> testing event table eist_trans: pass
> testing event table l3_cache_rd: pass
> testing event table segment_reg_loads.any: pass
> testing event e1 uncore_hisi_ddrc.flux_wcmd: mismatched desc, DDRC write =
commands vs DDRC write commands. Unit: hisi_sccl,ddrc
>
>
> Strange:
>
>         if (!is_same(e1->desc, e2->desc)) {
>                 pr_debug2("testing event e1 %s: mismatched desc, %s vs %s=
\n",
>                           e1->name, e1->desc, e2->desc);
>                 return -1;
>         }
>
> Adding "" around those descs:
>
> testing event e1 uncore_hisi_ddrc.flux_wcmd: mismatched desc, "DDRC write=
 commands" vs "DDRC write commands. Unit: hisi_sccl,ddrc"
>
> I see, its the last patch, removing it the tests passes, please take a
> look at tmp.perf-tools-next
>
> - Arnaldo

Thanks, I'll address the issue (hardcoded assumption on jevents.py
output) and resend the patch.

Ian

> ---- end ----
> PMU events subtest 1: FAILED!
>  10.2: PMU event map aliases                                         :
> --- start ---
> Using CPUID GenuineIntel-6-8E-A
> testing aliases core PMU cpu: matched event bp_l1_btb_correct
> testing aliases core PMU cpu: matched event bp_l2_btb_correct
> testing aliases core PMU cpu: matched event segment_reg_loads.any
> testing aliases core PMU cpu: matched event dispatch_blocked.any
> testing aliases core PMU cpu: matched event eist_trans
> testing aliases core PMU cpu: matched event l3_cache_rd
> testing core PMU cpu aliases: pass
> testing aliases PMU hisi_sccl1_ddrc2: mismatched desc, DDRC write command=
s vs DDRC write commands. Unit: hisi_sccl,ddrc
> testing aliases uncore PMU hisi_sccl1_ddrc2: could not match alias uncore=
_hisi_ddrc.flux_wcmd
> ---- end ----
> PMU events subtest 2: FAILED!
>  10.3: Parsing of PMU event table metrics                            :
> --- start ---
> Found metric 'CPI'
> metric expr 1 / IPC for CPI
> parsing metric: 1 / IPC
> metric expr inst_retired.any / cpu_clk_unhalted.thread for IPC
> parsing metric: inst_retired.any / cpu_clk_unhalted.thread
> found event inst_retired.any
> found event cpu_clk_unhalted.thread
> Parsing metric events '{inst_retired.any/metric-id=3Dinst_retired.any/,cp=
u_clk_unhalted.thread/metric-id=3Dcpu_clk_unhalted.thread/}:W'
> Attempting to add event pmu 'inst_retired.any' with '(null),' that may re=
sult in non-fatal errors
> After aliases, add event pmu 'inst_retired.any' with '(null),' that may r=
esult in non-fatal errors
> Attempting to add event pmu 'cpu_clk_unhalted.thread' with '(null),' that=
 may result in non-fatal errors
> After aliases, add event pmu 'cpu_clk_unhalted.thread' with '(null),' tha=
t may result in non-fatal errors
> [root@quaco ~]#
>
> Trying on a AMD 5950x:
>
> [root@five ~]# perf test -F -vv 10 |& head -40
>  10: PMU events                                                      :
>  10.1: PMU event table sanity                                        :
> --- start ---
> testing event table bp_l1_btb_correct: pass
> testing event table bp_l2_btb_correct: pass
> testing event table dispatch_blocked.any: pass
> testing event table eist_trans: pass
> testing event table l3_cache_rd: pass
> testing event table segment_reg_loads.any: pass
> testing event e1 uncore_hisi_ddrc.flux_wcmd: mismatched desc, DDRC write =
commands vs DDRC write commands. Unit: hisi_sccl,ddrc
> ---- end ----
> PMU events subtest 1: FAILED!
>  10.2: PMU event map aliases                                         :
> --- start ---
> Using CPUID AuthenticAMD-25-21-0
> testing aliases core PMU cpu: matched event bp_l1_btb_correct
> testing aliases core PMU cpu: matched event bp_l2_btb_correct
> testing aliases core PMU cpu: matched event segment_reg_loads.any
> testing aliases core PMU cpu: matched event dispatch_blocked.any
> testing aliases core PMU cpu: matched event eist_trans
> testing aliases core PMU cpu: matched event l3_cache_rd
> testing core PMU cpu aliases: pass
> testing aliases PMU hisi_sccl1_ddrc2: mismatched desc, DDRC write command=
s vs DDRC write commands. Unit: hisi_sccl,ddrc
> testing aliases uncore PMU hisi_sccl1_ddrc2: could not match alias uncore=
_hisi_ddrc.flux_wcmd
> ---- end ----
> PMU events subtest 2: FAILED!
>  10.3: Parsing of PMU event table metrics                            :
> --- start ---
> Found metric 'CPI'
> metric expr 1 / IPC for CPI
> parsing metric: 1 / IPC
> metric expr inst_retired.any / cpu_clk_unhalted.thread for IPC
> parsing metric: inst_retired.any / cpu_clk_unhalted.thread
> found event inst_retired.any
> found event cpu_clk_unhalted.thread
> Parsing metric events '{inst_retired.any/metric-id=3Dinst_retired.any/,cp=
u_clk_unhalted.thread/metric-id=3Dcpu_clk_unhalted.thread/}:W'
> Attempting to add event pmu 'inst_retired.any' with '(null),' that may re=
sult in non-fatal errors
> After aliases, add event pmu 'inst_retired.any' with '(null),' that may r=
esult in non-fatal errors
> Attempting to add event pmu 'cpu_clk_unhalted.thread' with '(null),' that=
 may result in non-fatal errors
> After aliases, add event pmu 'cpu_clk_unhalted.thread' with '(null),' tha=
t may result in non-fatal errors
> [root@five ~]#
