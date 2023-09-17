Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785597A33DA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 07:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjIQFew convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 17 Sep 2023 01:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjIQFei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 01:34:38 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0041F19F;
        Sat, 16 Sep 2023 22:34:32 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-79d1fbeeb41so21953739f.3;
        Sat, 16 Sep 2023 22:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694928872; x=1695533672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GxY0Ht6R0I62ky/tGjQSPNcYGfHuwyIcdRzQUOW8tgc=;
        b=EnwrtBeiJXZ/BmqBfWfDNHr6VXaBknsdxaTDAFTIlBzRI02W5mT0zkEz/CH+ul5s1K
         d+oY5FwSzi9bJSwNOttkCKUV3BpTxLLvJhI0VXeBqaci5Zh9fuoMGv9zGGIFPqcB4lU0
         EVzkheX9+t6LUtXSMKgKS6M6T4d9TcTA/N2oy2F73g54HrHRCvKP81yd3xnSEnnygn7b
         ypaT00xXvS3W/Fg8k/yvLWoqxTlH0IuoBq+tv9siM4UqZa09B2vJWtJmoe56ElS6n61W
         PUdhHw4bYfeOh02bHrFQDU/KFwUSGlKn+iIDub4Bb5E/hweqTX61LTiyDJ4TgEv+qTch
         4Zbw==
X-Gm-Message-State: AOJu0YzQoi2R9NE8DLq85gtKo0CM1hf0GPwRPUi+QA2XVfEmVAM2qMDs
        NxH72Nr68bKWclrdm17lhaKwefHsVaq2CvUPlFA=
X-Google-Smtp-Source: AGHT+IGCgZNfNiO9cm0SU6mGviVPjiT6yaBnAe94K8c7b2ujbDwbzp0ggeKmU077DobgR9ttOrQfNKGJyTFqX1a2hPs=
X-Received: by 2002:a5d:8784:0:b0:787:822:30f1 with SMTP id
 f4-20020a5d8784000000b00787082230f1mr7311988ion.1.1694928872220; Sat, 16 Sep
 2023 22:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230904023340.12707-1-yangjihong1@huawei.com>
 <453bd95c-932d-c60a-bd7b-96f87bc7779a@amd.com> <ZQDK4kZhwyZL/8tx@kernel.org>
 <CAM9d7cgNH2+zhSAmA3en_6as915UsF25MoLbfjE350tAP43Bog@mail.gmail.com> <c9f60c53-191c-e323-e641-bcdcd5b61c38@huawei.com>
In-Reply-To: <c9f60c53-191c-e323-e641-bcdcd5b61c38@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 16 Sep 2023 22:34:20 -0700
Message-ID: <CAM9d7cg3-Uw0peCEgC=d4a-s80NjAWLrkDqjp=_CXMXLfdzPhg@mail.gmail.com>
Subject: Re: [PATCH v8 0/6] perf record: Track sideband events for all CPUs
 when tracing selected CPUs
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>, peterz@infradead.org,
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 16, 2023 at 2:24 AM Yang Jihong <yangjihong1@huawei.com> wrote:
>
> Hello,
>
> On 2023/9/16 8:14, Namhyung Kim wrote:
> > Hello,
> >
> > On Tue, Sep 12, 2023 at 1:32 PM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> >>
> >> Em Tue, Sep 12, 2023 at 02:41:56PM +0530, Ravi Bangoria escreveu:
> >>> On 04-Sep-23 8:03 AM, Yang Jihong wrote:
> >>>> User space tasks can migrate between CPUs, track sideband events for all
> >>>> CPUs.
> >>>>
> >>>> The specific scenarios are as follows:
> >>>>
> >>>>           CPU0                                 CPU1
> >>>>    perf record -C 0 start
> >>>>                                taskA starts to be created and executed
> >>>>                                  -> PERF_RECORD_COMM and PERF_RECORD_MMAP
> >>>>                                     events only deliver to CPU1
> >>>>                                ......
> >>>>                                  |
> >>>>                            migrate to CPU0
> >>>>                                  |
> >>>>    Running on CPU0    <----------/
> >>>>    ...
> >>>>
> >>>>    perf record -C 0 stop
> >>>>
> >>>> Now perf samples the PC of taskA. However, perf does not record the
> >>>> PERF_RECORD_COMM and PERF_RECORD_COMM events of taskA.
> >>>> Therefore, the comm and symbols of taskA cannot be parsed.
> >>>>
> >>>> The sys_perf_event_open invoked is as follows:
> >>>>
> >>>>    # perf --debug verbose=3 record -e cpu-clock -C 1 true
> >>>>    <SNIP>
> >>>>    Opening: cpu-clock
> >>>>    ------------------------------------------------------------
> >>>>    perf_event_attr:
> >>>>      type                             1 (PERF_TYPE_SOFTWARE)
> >>>>      size                             136
> >>>>      config                           0 (PERF_COUNT_SW_CPU_CLOCK)
> >>>>      { sample_period, sample_freq }   4000
> >>>>      sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
> >>>>      read_format                      ID|LOST
> >>>>      disabled                         1
> >>>>      inherit                          1
> >>>>      freq                             1
> >>>>      sample_id_all                    1
> >>>>      exclude_guest                    1
> >>>>    ------------------------------------------------------------
> >>>>    sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 5
> >>>>    Opening: dummy:u
> >>>>    ------------------------------------------------------------
> >>>>    perf_event_attr:
> >>>>      type                             1 (PERF_TYPE_SOFTWARE)
> >>>>      size                             136
> >>>>      config                           0x9 (PERF_COUNT_SW_DUMMY)
> >>>>      { sample_period, sample_freq }   1
> >>>>      sample_type                      IP|TID|TIME|CPU|IDENTIFIER
> >>>>      read_format                      ID|LOST
> >>>>      inherit                          1
> >>>>      exclude_kernel                   1
> >>>>      exclude_hv                       1
> >>>>      mmap                             1
> >>>>      comm                             1
> >>>>      task                             1
> >>>>      sample_id_all                    1
> >>>>      exclude_guest                    1
> >>>>      mmap2                            1
> >>>>      comm_exec                        1
> >>>>      ksymbol                          1
> >>>>      bpf_event                        1
> >>>>    ------------------------------------------------------------
> >>>>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
> >>>>    sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 7
> >>>>    sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 9
> >>>>    sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 10
> >>>>    sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 = 11
> >>>>    sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 = 12
> >>>>    sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 = 13
> >>>>    sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 = 14
> >>>>    <SNIP>
> >>>>
> >>>> Changes since_v7:
> >>>>   - The condition for requiring system_wide sideband is changed to
> >>>>     "as long as a non-dummy event exists" (patch4).
> >>>>   - Modify the corresponding test case to record only dummy event (patch6).
> >>>>   - Thanks to tested-by tag from Ravi, but because the solution is modified,
> >>>>     the tested-by tag of Ravi is not added to this version.
> >>>
> >>> I've re-tested v8 with my simple test.
> >>>
> >>> Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
> >>
> >>
> >> Thanks, applied to the csets that were still sitting in an umpublished
> >> perf-tools-next local branch, soon public.
> >
> > Now I'm seeing a perf test failure on perf-tools-next.
>
> Uh.. the kernel I was using before didn't support PERF_FORMAT_LOST, so
> forget about supporting PERF_FORMAT_LOST. I've updated the kernel and
> retested it.
>
> The link to the fixed patch is as follows:
> https://lore.kernel.org/all/20230916091641.776031-1-yangjihong1@huawei.com/

Thank you for the quick fix!
Namhyung
