Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FA778C50D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbjH2NVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235971AbjH2NUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:20:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6724E184;
        Tue, 29 Aug 2023 06:20:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E428B625B0;
        Tue, 29 Aug 2023 13:20:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3184C433C7;
        Tue, 29 Aug 2023 13:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693315247;
        bh=MfwuHruJ6Rhgv/8z7bttUwZK+cXgbWq7esBbHtdttzw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mgSeJpmIFgB5cXwtLRYCdsbzKfwbDa3dHuo9exNoDuGJfccIea1UV+0OiFLEt+6Iu
         SyxjWOL4hL1POoz3jYOAA4krfyiIL1ypzO5JcJmYHs9lrFMrpbgu2r+/LIT3o+q+Dd
         hwN58ng6N9xFDpa158F8SP+ZE5e8m+ZYnX0Jtz7kN5eYHJgq/WwaMZb2CwYKE6wuWP
         xCz7UZtHxwad9+PNn0ZcDEgTJJ1CVQq8ME9y9UL9OiNcPY/Kz2kvPtLSSYYD5RAJKl
         /FxxiF3mNC86Tf3RdqoA9FN85s1bhSQt7+9nOxHHW1B8+juWqsInvg+qcs+uC9wIMY
         izoqkGf23BwOg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DBA6740722; Tue, 29 Aug 2023 10:20:43 -0300 (-03)
Date:   Tue, 29 Aug 2023 10:20:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     Ian Rogers <irogers@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/18] perf s390 s390_cpumcfdg_dump: Don't scan all
 PMUs
Message-ID: <ZO3wq4qnkCCePtd2@kernel.org>
References: <ZOdiX4eJHFfFbQhi@kernel.org>
 <428afeb4-d5ca-8115-73fc-881119a1cd51@linux.ibm.com>
 <CAP-5=fVt1vxK0CJ=aYjZzs4mushbxAx8056uxVQZUfsLAKpVoQ@mail.gmail.com>
 <4f2438fc-2360-8833-3751-fe3bc8b11afb@linux.ibm.com>
 <ZOkVYoN17A8wwP3k@kernel.org>
 <CAP-5=fUqLXdu2=TPSASFBbZ+B1oTFbuFra38z5YwYHWpX-V=hw@mail.gmail.com>
 <ZOzdFPOLhNdd59PG@kernel.org>
 <ZOzfHEuJkXfajmWO@kernel.org>
 <CAP-5=fV81WPRAXrGoMJDuT3aKHJBThEscq=NX=Jn_4UUPOutAg@mail.gmail.com>
 <c32809b4-353b-fecb-a7bf-b7bda1604574@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c32809b4-353b-fecb-a7bf-b7bda1604574@linux.alibaba.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 29, 2023 at 05:20:09PM +0800, Jing Zhang escreveu:
> 在 2023/8/29 上午8:59, Ian Rogers 写道:
> > On Mon, Aug 28, 2023 at 10:53 AM Arnaldo Carvalho de Melo
> > I can't explain this, how come the line numbers don't agree with?
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/pmu.c?h=tmp.perf-tools-next#n449
> > 
> > The values are coming from the json event data. I'd need to see the
> > generated pmu-events.c.

Its at:

http://vger.kernel.org/~acme/perf/pmu-events.c.txt
 
> I pulled the lastest tmp.perf-tools-next, and build with JEVENT_ARCH=all on ARM(KunPeng) system. The test 10 also fails.

acme@roc-rk3399-pc:~/git/perf-tools-next$ git log --oneline -10
3d63ae82aa12 (HEAD -> perf-tools-next, quaco/perf-tools-next, perf-tools-next/tmp.perf-tools-next, five/perf-tools-next) perf jevents: Use "default_core" for events with no Unit
686cca7e97eb perf test stat_bpf_counters_cgrp: Enhance perf stat cgroup BPF counter test
a77abc103942 perf test shell stat_bpf_counters: Fix test on Intel
db02f820603e perf test shell record_bpf_filter: Skip 6.2 kernel
c96b84e89f8a libperf: Get rid of attr.id field
ee6906d247f1 perf tools: Convert to perf_record_header_attr_id()
fd36ca012e0c libperf: Add perf_record_header_attr_id()
bb7eb7458e52 perf tools: Handle old data in PERF_RECORD_ATTR
982d23d6e5e6 perf pmus: Skip duplicate PMUs and don't print list suffix by default
a700b0367364 perf pmus: Sort pmus by name then suffix
acme@roc-rk3399-pc:~/git/perf-tools-next$

Trying to do everything from scratch, to maybe avoid some leftover file
from a previous build:

acme@roc-rk3399-pc:~/git/perf-tools-next$ for a in tools/* ; do make -C $a clean; done
acme@roc-rk3399-pc:~/git/perf-tools-next$ rm -rf /tmp/build/$(basename $(pwd)) ; mkdir -p /tmp/build/$(basename $(pwd)) ;
acme@roc-rk3399-pc:~/git/perf-tools-next$ alias m='make -k DEBUG=1 BUILD_BPF_SKEL=1 CORESIGHT=1 O=/tmp/build/perf-tools-next -C tools/perf install-bin && git status && perf test python'

Then run the 'm' alias to build it, then:

root@roc-rk3399-pc:~# perf test -v 10 |& tail -40
Matched metric-id cpa_cycles to cpa_cycles
Matched metric-id cpa_p1_wr_dat to cpa_p1_wr_dat
Matched metric-id cpa_p1_rd_dat_64b to cpa_p1_rd_dat_64b
Matched metric-id cpa_p1_rd_dat_32b to cpa_p1_rd_dat_32b
Result nan
test child finished with 0
---- end ----
PMU events subtest 3: Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             :
--- start ---
test child forked, pid 12897
parsing '': '(unc_p_power_state_occupancy.cores_c0 / unc_p_clockticks) * 100.'
Using CPUID 0x00000000410fd082
perf: Segmentation fault
Obtained 16 stack frames.
perf(dump_stack+0x27) [0xaaaade0f19af]
perf(sighandler_dump_stack+0x33) [0xaaaade0f1a7f]
linux-vdso.so.1(+0x7a7) [0xffffa16967a7]
/lib/aarch64-linux-gnu/libc.so.6(__strcasecmp+0x2c) [0xffffa0841dac]
perf(+0x2233db) [0xaaaade1233db]
perf(+0x22364f) [0xaaaade12364f]
perf(+0x343143) [0xaaaade243143]
perf(pmu_events_table__find_event+0xa3) [0xaaaade24335f]
perf(+0x223a4b) [0xaaaade123a4b]
perf(+0x223f6b) [0xaaaade123f6b]
perf(+0x2232bb) [0xaaaade1232bb]
perf(perf_pmu__have_event+0x33) [0xaaaade1268f3]
perf(parse_events_multi_pmu_add+0x127) [0xaaaade0b7077]
perf(parse_events_parse+0xf3f) [0xaaaade120917]
perf(+0x1b7e6f) [0xaaaade0b7e6f]
perf(__parse_events+0xa3) [0xaaaade0b88c7]
test child interrupted
---- end ----
PMU events subtest 4: FAILED!
 10.5: Parsing of metric thresholds with fake PMUs                   :
--- start ---
test child forked, pid 12899
test child finished with 0
---- end ----
PMU events subtest 5: Ok
root@roc-rk3399-pc:~#

Doing it in gdb it doesn't crash, then I try with -F in gdb and it also
doesn't crash:

(gdb) run test -F 10
Starting program: /root/bin/perf test -F 10
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/aarch64-linux-gnu/libthread_db.so.1".
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            :failed: recursion detected for M1
failed: recursion detected for M2
failed: recursion detected for M3
 Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
 10.5: Parsing of metric thresholds with fake PMUs                   : Ok
[Inferior 1 (process 12925) exited normally]
(gdb)

root@roc-rk3399-pc:~# perf test -F 10
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            :failed: recursion detected for M1
failed: recursion detected for M2
failed: recursion detected for M3
 Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
 10.5: Parsing of metric thresholds with fake PMUs                   : Ok
root@roc-rk3399-pc:~#

root@roc-rk3399-pc:~# perf test -v -F 10 |& grep ": Ok"
PMU events subtest 1: Ok
PMU events subtest 2: Ok
PMU events subtest 3: Ok
PMU events subtest 4: Ok
PMU events subtest 5: Ok
root@roc-rk3399-pc:~#

Will continue investigating later...

- Arnaldo
 
> The bad commit maybe is "edb217f perf pmu: Parse sysfs events directly from a file". Hope it helps.
> 
> #git log --oneline -1
> 3d63ae8 perf jevents: Use "default_core" for events with no Unit
> 
> #./perf test 10
>  10: PMU events                                                      :
>  10.1: PMU event table sanity                                        : Ok
>  10.2: PMU event map aliases                                         : Ok
>  10.3: Parsing of PMU event table metrics                            : FAILED!
>  10.4: Parsing of PMU event table metrics with fake PMUs             : FAILED!
>  10.5: Parsing of metric thresholds with fake PMUs                   : FAILED!

 
> Found metric 'tsx_aborted_cycles'
> metric expr (max(cycles\-t - cycles\-ct, 0) / cycles if has_event(cycles\-t) else 0) for tsx_aborted_cycles
> parsing metric: (max(cycles\-t - cycles\-ct, 0) / cycles if has_event(cycles\-t) else 0)
> perf: Segmentation fault
> Obtained 16 stack frames.
> ./perf() [0x514a23]
> linux-vdso.so.1(+0x7c3) [0xffff8ac847c3]
> ./perf() [0x52bb08]
> ./perf() [0x52ffc3]
> ./perf() [0x4e8cab]
> ./perf() [0x4ea27b]
> ./perf() [0x532137]
> ./perf() [0x53273b]
> ./perf() [0x533ed7]
> ./perf() [0x4ed58b]
> ./perf() [0x530763]
> ./perf() [0x4e8c47]
> ./perf() [0x4ea5e3]
> ./perf() [0x4eaa8f]
> ./perf() [0x595393]
> ./perf() [0x593753]
> test child interrupted
> ---- end ----
> PMU events subtest 3: FAILED!
>  10.4: Parsing of PMU event table metrics with fake PMUs             :
> --- start ---
> test child forked, pid 24107
> parsing '': '(unc_p_power_state_occupancy.cores_c0 / unc_p_clockticks) * 100.'
> parsing metric: (unc_p_power_state_occupancy.cores_c0 / unc_p_clockticks) * 100.
> Using CPUID 0x00000000481fd010
> perf: Segmentation fault
> Obtained 16 stack frames.
> ./perf() [0x514a23]
> linux-vdso.so.1(+0x7c3) [0xffff8ac847c3]
> ./perf() [0x52bb08]
> ./perf() [0x52ffc3]
> ./perf() [0x4e8cab]
> ./perf() [0x4ea27b]
> ./perf() [0x532137]
> ./perf() [0x53273b]
> ./perf() [0x533ed7]
> ./perf() [0x4ed58b]
> ./perf() [0x530763]
> ./perf() [0x4e8c47]
> ./perf() [0x4ea5e3]
> ./perf() [0x4a50b3]
> ./perf() [0x4a5343]
> ./perf() [0x48fef7]
> test child interrupted
> ---- end ----
> PMU events subtest 4: FAILED!
>  10.5: Parsing of metric thresholds with fake PMUs                   :
> --- start ---
> test child forked, pid 24108
> parsing 'tma_alloc_restriction': 'tma_alloc_restriction > 0.1'
> parsing metric: tma_alloc_restriction > 0.1
> Using CPUID 0x00000000481fd010
> perf: Segmentation fault
> Obtained 16 stack frames.
> ./perf() [0x514a23]
> linux-vdso.so.1(+0x7c3) [0xffff8ac847c3]
> ./perf() [0x52bb08]
> ./perf() [0x52ffc3]
> ./perf() [0x4e8cab]
> ./perf() [0x4ea27b]
> ./perf() [0x532137]
> ./perf() [0x53273b]
> ./perf() [0x533ed7]
> ./perf() [0x4ed58b]
> ./perf() [0x530763]
> ./perf() [0x4e8c47]
> ./perf() [0x4ea5e3]
> ./perf() [0x4a50b3]
> ./perf() [0x5dec0b]
> ./perf() [0x5df117]
> test child interrupted
> ---- end ----
> PMU events subtest 5: FAILED!

-- 

- Arnaldo
