Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA197A2BDC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 02:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbjIPAWK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 15 Sep 2023 20:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238200AbjIPAVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 20:21:49 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65143AB5;
        Fri, 15 Sep 2023 17:17:26 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-77ac14ff51bso89735339f.3;
        Fri, 15 Sep 2023 17:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694823261; x=1695428061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mg+2dCrd8UTwfK+HAOc17X5FOQTPFeCWzvxdUscOZgU=;
        b=DTlwS6CxIg2qK8ZRwHlGZ6Ia0BhPhdBqHKUtb3haTAtOlZ39RBc/Fr064/TvVMIE8f
         oMriKAJA5XpfnjZ80snDe2JpaGxTpIQWRs1ZdVvkXl4BnhJDDExWlYMqMItMD6N5r6KN
         I+h58DPVmioeWdpcekKd/GjzTpAHLxqJTWraBJWMtHhQQCdMsQ0+WwylyQOuLzmVvXQg
         qomeH33I6bR7QC/8tKgnODdGhQNvRAt7hB6G3Ghx9ojRpdZV0yqvfZBY+kTe6WKKWSHg
         mlAWSgTfO5br6QXDe6LgsvSl37ILxWkctImXu6pp9/o3xIhmL2CEUqkvLBsSZu+OgEHd
         LCQA==
X-Gm-Message-State: AOJu0YxP30y7jr5IvrX9IpGpB/cPE6++2wJ5xgYGAWYVFb1iwTMpOCYT
        f4S0l0U0/dFOiKuZHHyMNEifpDP6vG2xZNvRShzb5XfBy4g=
X-Google-Smtp-Source: AGHT+IFIZ6gQXt/jo/6ORQjPMRep/mYCOtnjiQF+55Lhva85OmID1+3tz8ye/WhfUe1m4yrXl1+0fsAJPZeww5BJQ3o=
X-Received: by 2002:a6b:5809:0:b0:791:1739:d525 with SMTP id
 m9-20020a6b5809000000b007911739d525mr2515952iob.20.1694823260628; Fri, 15 Sep
 2023 17:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230904023340.12707-1-yangjihong1@huawei.com>
 <453bd95c-932d-c60a-bd7b-96f87bc7779a@amd.com> <ZQDK4kZhwyZL/8tx@kernel.org>
In-Reply-To: <ZQDK4kZhwyZL/8tx@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 15 Sep 2023 17:14:09 -0700
Message-ID: <CAM9d7cgNH2+zhSAmA3en_6as915UsF25MoLbfjE350tAP43Bog@mail.gmail.com>
Subject: Re: [PATCH v8 0/6] perf record: Track sideband events for all CPUs
 when tracing selected CPUs
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>,
        Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, james.clark@arm.com,
        tmricht@linux.ibm.com, ak@linux.intel.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Sep 12, 2023 at 1:32 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Sep 12, 2023 at 02:41:56PM +0530, Ravi Bangoria escreveu:
> > On 04-Sep-23 8:03 AM, Yang Jihong wrote:
> > > User space tasks can migrate between CPUs, track sideband events for all
> > > CPUs.
> > >
> > > The specific scenarios are as follows:
> > >
> > >          CPU0                                 CPU1
> > >   perf record -C 0 start
> > >                               taskA starts to be created and executed
> > >                                 -> PERF_RECORD_COMM and PERF_RECORD_MMAP
> > >                                    events only deliver to CPU1
> > >                               ......
> > >                                 |
> > >                           migrate to CPU0
> > >                                 |
> > >   Running on CPU0    <----------/
> > >   ...
> > >
> > >   perf record -C 0 stop
> > >
> > > Now perf samples the PC of taskA. However, perf does not record the
> > > PERF_RECORD_COMM and PERF_RECORD_COMM events of taskA.
> > > Therefore, the comm and symbols of taskA cannot be parsed.
> > >
> > > The sys_perf_event_open invoked is as follows:
> > >
> > >   # perf --debug verbose=3 record -e cpu-clock -C 1 true
> > >   <SNIP>
> > >   Opening: cpu-clock
> > >   ------------------------------------------------------------
> > >   perf_event_attr:
> > >     type                             1 (PERF_TYPE_SOFTWARE)
> > >     size                             136
> > >     config                           0 (PERF_COUNT_SW_CPU_CLOCK)
> > >     { sample_period, sample_freq }   4000
> > >     sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
> > >     read_format                      ID|LOST
> > >     disabled                         1
> > >     inherit                          1
> > >     freq                             1
> > >     sample_id_all                    1
> > >     exclude_guest                    1
> > >   ------------------------------------------------------------
> > >   sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 5
> > >   Opening: dummy:u
> > >   ------------------------------------------------------------
> > >   perf_event_attr:
> > >     type                             1 (PERF_TYPE_SOFTWARE)
> > >     size                             136
> > >     config                           0x9 (PERF_COUNT_SW_DUMMY)
> > >     { sample_period, sample_freq }   1
> > >     sample_type                      IP|TID|TIME|CPU|IDENTIFIER
> > >     read_format                      ID|LOST
> > >     inherit                          1
> > >     exclude_kernel                   1
> > >     exclude_hv                       1
> > >     mmap                             1
> > >     comm                             1
> > >     task                             1
> > >     sample_id_all                    1
> > >     exclude_guest                    1
> > >     mmap2                            1
> > >     comm_exec                        1
> > >     ksymbol                          1
> > >     bpf_event                        1
> > >   ------------------------------------------------------------
> > >   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
> > >   sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 7
> > >   sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 9
> > >   sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 10
> > >   sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 = 11
> > >   sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 = 12
> > >   sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 = 13
> > >   sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 = 14
> > >   <SNIP>
> > >
> > > Changes since_v7:
> > >  - The condition for requiring system_wide sideband is changed to
> > >    "as long as a non-dummy event exists" (patch4).
> > >  - Modify the corresponding test case to record only dummy event (patch6).
> > >  - Thanks to tested-by tag from Ravi, but because the solution is modified,
> > >    the tested-by tag of Ravi is not added to this version.
> >
> > I've re-tested v8 with my simple test.
> >
> > Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
>
>
> Thanks, applied to the csets that were still sitting in an umpublished
> perf-tools-next local branch, soon public.

Now I'm seeing a perf test failure on perf-tools-next.


$ sudo ./perf test -v 17
 17: Setup struct perf_event_attr                                    :
--- start ---
test child forked, pid 1616372
Using CPUID GenuineIntel-6-8C-1
running './tests/attr/test-record-branch-filter-k'
running './tests/attr/test-record-period'
running './tests/attr/test-record-graph-default'
test limitation '!aarch64'
excluded architecture list ['aarch64']
running './tests/attr/test-record-branch-filter-any'
running './tests/attr/test-record-data'
running './tests/attr/test-stat-detailed-1'
running './tests/attr/test-record-branch-filter-hv'
running './tests/attr/test-record-graph-fp'
test limitation '!aarch64'
excluded architecture list ['aarch64']
running './tests/attr/test-record-basic'
running './tests/attr/test-record-group2'
running './tests/attr/test-stat-detailed-3'
running './tests/attr/test-record-branch-any'
running './tests/attr/test-record-branch-filter-ind_call'
running './tests/attr/test-stat-detailed-2'
running './tests/attr/test-record-group1'
running './tests/attr/test-record-count'
running './tests/attr/test-record-no-samples'
running './tests/attr/test-record-graph-dwarf'
running './tests/attr/test-record-spe-period'
test limitation 'aarch64'
skipped [x86_64] './tests/attr/test-record-spe-period'
running './tests/attr/test-record-graph-fp-aarch64'
test limitation 'aarch64'
skipped [x86_64] './tests/attr/test-record-graph-fp-aarch64'
running './tests/attr/test-record-freq'
running './tests/attr/test-record-pfm-period'
running './tests/attr/test-record-no-buffering'
running './tests/attr/test-record-no-inherit'
running './tests/attr/test-record-branch-filter-any_ret'
running './tests/attr/test-record-raw'
running './tests/attr/test-record-dummy-C0'
expected read_format=4, got 20
FAILED './tests/attr/test-record-dummy-C0' - match failure
test child finished with -1
---- end ----
Setup struct perf_event_attr: FAILED!
