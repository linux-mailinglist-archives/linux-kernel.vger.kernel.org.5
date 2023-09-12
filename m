Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426C779DA17
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 22:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbjILUcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 16:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235866AbjILUct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 16:32:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EBF189;
        Tue, 12 Sep 2023 13:32:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C201C433C9;
        Tue, 12 Sep 2023 20:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694550757;
        bh=+ayGb/8rfO8sMl9eGtsq7VjyvF/TUJehfrAzBanbfd4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u/IcWo3sNlbJnyWNLoZPnR8JHYf5ZkFCoVkPRX/IMR5XDzEVlKC4PWvCS5pFai/17
         WcY7QwF/WZGvngVEPshytqECTdIpRrh8uyDPiZsUjRH6VkH9y8Fx5zapUSoM3TbXcV
         IhoD+roMDvhyd9a0qgdkqOmcmPGQ+RwIZr2VIh83x1J9luh55U57nL8iR8CBlyY023
         IhXkmwoB7cPfvAllzy6yCQLDsmeOgoTDPdAJEAuHIvoflZxGAJEBLm9i79f4/RqnpZ
         WUXNcdSM8dGi1pttoL86DSRlrV4tdrVilceKAiDULEADHeeFg8IsX06/sZJoLPg7NJ
         jlW0Ew9fiW0IQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6A29A403F4; Tue, 12 Sep 2023 17:32:34 -0300 (-03)
Date:   Tue, 12 Sep 2023 17:32:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, james.clark@arm.com,
        tmricht@linux.ibm.com, ak@linux.intel.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v8 0/6] perf record: Track sideband events for all CPUs
 when tracing selected CPUs
Message-ID: <ZQDK4kZhwyZL/8tx@kernel.org>
References: <20230904023340.12707-1-yangjihong1@huawei.com>
 <453bd95c-932d-c60a-bd7b-96f87bc7779a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <453bd95c-932d-c60a-bd7b-96f87bc7779a@amd.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 12, 2023 at 02:41:56PM +0530, Ravi Bangoria escreveu:
> On 04-Sep-23 8:03 AM, Yang Jihong wrote:
> > User space tasks can migrate between CPUs, track sideband events for all
> > CPUs.
> > 
> > The specific scenarios are as follows:
> > 
> >          CPU0                                 CPU1
> >   perf record -C 0 start
> >                               taskA starts to be created and executed
> >                                 -> PERF_RECORD_COMM and PERF_RECORD_MMAP
> >                                    events only deliver to CPU1
> >                               ......
> >                                 |
> >                           migrate to CPU0
> >                                 |
> >   Running on CPU0    <----------/
> >   ...
> > 
> >   perf record -C 0 stop
> > 
> > Now perf samples the PC of taskA. However, perf does not record the
> > PERF_RECORD_COMM and PERF_RECORD_COMM events of taskA.
> > Therefore, the comm and symbols of taskA cannot be parsed.
> > 
> > The sys_perf_event_open invoked is as follows:
> > 
> >   # perf --debug verbose=3 record -e cpu-clock -C 1 true
> >   <SNIP>
> >   Opening: cpu-clock
> >   ------------------------------------------------------------
> >   perf_event_attr:
> >     type                             1 (PERF_TYPE_SOFTWARE)
> >     size                             136
> >     config                           0 (PERF_COUNT_SW_CPU_CLOCK)
> >     { sample_period, sample_freq }   4000
> >     sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
> >     read_format                      ID|LOST
> >     disabled                         1
> >     inherit                          1
> >     freq                             1
> >     sample_id_all                    1
> >     exclude_guest                    1
> >   ------------------------------------------------------------
> >   sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 5
> >   Opening: dummy:u
> >   ------------------------------------------------------------
> >   perf_event_attr:
> >     type                             1 (PERF_TYPE_SOFTWARE)
> >     size                             136
> >     config                           0x9 (PERF_COUNT_SW_DUMMY)
> >     { sample_period, sample_freq }   1
> >     sample_type                      IP|TID|TIME|CPU|IDENTIFIER
> >     read_format                      ID|LOST
> >     inherit                          1
> >     exclude_kernel                   1
> >     exclude_hv                       1
> >     mmap                             1
> >     comm                             1
> >     task                             1
> >     sample_id_all                    1
> >     exclude_guest                    1
> >     mmap2                            1
> >     comm_exec                        1
> >     ksymbol                          1
> >     bpf_event                        1
> >   ------------------------------------------------------------
> >   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
> >   sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 7
> >   sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 9
> >   sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 10
> >   sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 = 11
> >   sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 = 12
> >   sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 = 13
> >   sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 = 14
> >   <SNIP>
> > 
> > Changes since_v7:
> >  - The condition for requiring system_wide sideband is changed to
> >    "as long as a non-dummy event exists" (patch4).
> >  - Modify the corresponding test case to record only dummy event (patch6).
> >  - Thanks to tested-by tag from Ravi, but because the solution is modified,
> >    the tested-by tag of Ravi is not added to this version.
> 
> I've re-tested v8 with my simple test.
> 
> Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>


Thanks, applied to the csets that were still sitting in an umpublished
perf-tools-next local branch, soon public.

- Arnaldo

