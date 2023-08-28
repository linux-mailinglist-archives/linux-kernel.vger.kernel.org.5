Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2C078B6AD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbjH1Rp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbjH1RpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:45:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316F912D;
        Mon, 28 Aug 2023 10:44:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD321645D9;
        Mon, 28 Aug 2023 17:44:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A2BC433C7;
        Mon, 28 Aug 2023 17:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693244696;
        bh=Ml70oHL0Z/84whA5vWHTnpHyCSMlNFYS7Ebk0SBYDSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PrFDJ0rHyyT6sqBC71pXB8cTSM8I6bxV5PRuB3XJS4OrvATMwk88M5g+ONDcpkp9A
         CBdkMzrFgTbNSjpuBb/HZFuuIW+GCyw7WuNWfNjfgf8koREBIpnIms1wcPElmMIYBS
         XRJGVIJzj7JYTe7x/r6FT6SA0IkELdkKmX4YChujIG7n4kAY86sEA9+xZHh3QrD5r6
         l/yFm+4QLKfd+wALcqttpIlNNNCgDKLdYCG/NzsSJusE0xHGVUDaux5GT0I3lGNeej
         7zEwZaT/RhJfL16W+WzPhNpepRqYM9xZW6ukNmQX7eRfJwyO5kG4GUAirPXL9QuUwn
         9GCYrZhnNGczw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0886C40722; Mon, 28 Aug 2023 14:44:52 -0300 (-03)
Date:   Mon, 28 Aug 2023 14:44:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/18] perf s390 s390_cpumcfdg_dump: Don't scan all
 PMUs
Message-ID: <ZOzdFPOLhNdd59PG@kernel.org>
References: <20230824041330.266337-1-irogers@google.com>
 <20230824041330.266337-7-irogers@google.com>
 <ZOdiX4eJHFfFbQhi@kernel.org>
 <428afeb4-d5ca-8115-73fc-881119a1cd51@linux.ibm.com>
 <CAP-5=fVt1vxK0CJ=aYjZzs4mushbxAx8056uxVQZUfsLAKpVoQ@mail.gmail.com>
 <4f2438fc-2360-8833-3751-fe3bc8b11afb@linux.ibm.com>
 <ZOkVYoN17A8wwP3k@kernel.org>
 <CAP-5=fUqLXdu2=TPSASFBbZ+B1oTFbuFra38z5YwYHWpX-V=hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUqLXdu2=TPSASFBbZ+B1oTFbuFra38z5YwYHWpX-V=hw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 25, 2023 at 03:56:54PM -0700, Ian Rogers escreveu:
> On Fri, Aug 25, 2023 at 1:56 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Fri, Aug 25, 2023 at 04:39:22PM +0200, Thomas Richter escreveu:
> > > On 8/25/23 15:14, Ian Rogers wrote:
> > > > On Fri, Aug 25, 2023 at 1:20 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
> >
> > > >> On 8/24/23 15:59, Arnaldo Carvalho de Melo wrote:
> > > >>> Em Wed, Aug 23, 2023 at 09:13:18PM -0700, Ian Rogers escreveu:
> > > >>>> Rather than scanning all PMUs for a counter name, scan the PMU
> > > >>>> associated with the evsel of the sample. This is done to remove a
> > > >>>> dependence on pmu-events.h.
> >
> > > >>> I'm applying this one, and CCing the S/390 developers so that they can
> > > >>> try this and maybe provide an Acked-by/Tested-by,
> >
> > > >> I have downloaded this patch set of 18 patches (using b4), but they do not
> > > >> apply on my git tree.
> >
> > > >> Which git branch do I have to use to test this. Thanks a lot.
> >
> > > > the changes are in the perf-tools-next tree:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/
> >
> > > Unfurtunately this patch set fails again on s390.
> > > Here is the test output from the current 6.5.0rc7 kernel:
> > >
> > > # ./perf test 6 10 'perf all metricgroups test' 'perf all metrics test'
> > >   6: Parse event definition strings                                  :
> > >   6.1: Test event parsing                                            : Ok
> > >   6.2: Parsing of all PMU events from sysfs                          : Ok
> > >   6.3: Parsing of given PMU events from sysfs                        : Ok
> > >   6.4: Parsing of aliased events from sysfs                          : Skip (no aliases in sysfs)
> > >   6.5: Parsing of aliased events                                     : Ok
> > >   6.6: Parsing of terms (event modifiers)                            : Ok
> > >  10: PMU events                                                      :
> > >  10.1: PMU event table sanity                                        : Ok
> > >  10.2: PMU event map aliases                                         : Ok
> > >  10.3: Parsing of PMU event table metrics                            : Ok
> > >  10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
> > >  10.5: Parsing of metric thresholds with fake PMUs                   : Ok
> > >  95: perf all metricgroups test                                      : Ok
> > >  96: perf all metrics test                                           : Ok
> > > #
> > >
> > > This looks good.
> >
> > Reproduced:
> >
> > # grep -E vendor_id\|^processor -m2 /proc/cpuinfo
> > vendor_id       : IBM/S390
> > processor 0: version = 00,  identification = 1A33E8,  machine = 2964
> > #
> > # perf test 6 10 'perf all metricgroups test' 'perf all metrics test'
> >   6: Parse event definition strings                                  :
> >   6.1: Test event parsing                                            : Ok
> >   6.2: Parsing of all PMU events from sysfs                          : Ok
> >   6.3: Parsing of given PMU events from sysfs                        : Ok
> >   6.4: Parsing of aliased events from sysfs                          : Skip (no aliases in sysfs)
> >   6.5: Parsing of aliased events                                     : Ok
> >   6.6: Parsing of terms (event modifiers)                            : Ok
> >  10: PMU events                                                      :
> >  10.1: PMU event table sanity                                        : Ok
> >  10.2: PMU event map aliases                                         : Ok
> >  10.3: Parsing of PMU event table metrics                            : Ok
> >  10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
> >  10.5: Parsing of metric thresholds with fake PMUs                   : Ok
> >  95: perf all metricgroups test                                      : Ok
> >  96: perf all metrics test                                           : Ok
> > # perf -v
> > perf version 6.5.rc7.g6f0edbb833ec
> > #
> >
> > > However when I use the check-out from perf-tools-next, I get this output:
> > > # ./perf test 6 10 'perf all metricgroups test' 'perf all metrics test'
> > >   6: Parse event definition strings                                  :
> > >   6.1: Test event parsing                                            : Ok
> > >   6.2: Parsing of all PMU events from sysfs                          : FAILED!
> > >   6.3: Parsing of given PMU events from sysfs                        : Ok
> > >   6.4: Parsing of aliased events from sysfs                          : Skip (no aliases in sysfs)
> > >   6.5: Parsing of aliased events                                     : FAILED!
> > >   6.6: Parsing of terms (event modifiers)                            : Ok
> > >  10: PMU events                                                      :
> > >  10.1: PMU event table sanity                                        : Ok
> > >  10.2: PMU event map aliases                                         : FAILED!
> > >  10.3: Parsing of PMU event table metrics                            : Ok
> > >  10.4: Parsing of PMU event table metrics with fake PMUs             : FAILED!
> > >  10.5: Parsing of metric thresholds with fake PMUs                   : Ok
> > >  93: perf all metricgroups test                                      : FAILED!
> > >  94: perf all metrics test                                           : FAILED!
> > > #
> > >
> > > So some tests are failing again.
> > >
> > > I am out for the next two weeks, Sumanth Korikkar (on to list) might be able to help.
> > > Thanks a lot.
> >
> > [root@kernelqe3 linux]# git checkout perf-tools-next
> > git Switched to branch 'perf-tools-next'
> > Your branch is up to date with 'perf-tools-next/perf-tools-next'.
> > [root@kernelqe3 linux]# git log --oneline -5
> > eeb6b12992c4 (HEAD -> perf-tools-next, perf-tools-next/perf-tools-next) perf jevents: Don't append Unit to desc
> > f208b2c6f984 (perf-tools-next/tmp.perf-tools-next) perf scripts python gecko: Launch the profiler UI on the default browser with the appropriate URL
> > 43803cb16f99 perf scripts python: Add support for input args in gecko script
> > f85d120c46e7 perf jevents: Sort strings in the big C string to reduce faults
> > 8d4b6d37ea78 perf pmu: Lazily load sysfs aliases
> > [root@kernelqe3 linux]# make BUILD_BPF_SKEL=1 -C tools/perf O=/tmp/build/perf install-bin
> >
> > [root@kernelqe3 linux]# perf -v
> > perf version 6.5.rc5.geeb6b12992c4
> > [root@kernelqe3 linux]# git log --oneline -1
> > eeb6b12992c4 (HEAD -> perf-tools-next, perf-tools-next/perf-tools-next) perf jevents: Don't append Unit to desc
> > [root@kernelqe3 linux]# perf test 6 10 'perf all metricgroups test' 'perf all metrics test'
> >   6: Parse event definition strings                                  :
> >   6.1: Test event parsing                                            : Ok
> >   6.2: Parsing of all PMU events from sysfs                          : FAILED!
> >   6.3: Parsing of given PMU events from sysfs                        : Ok
> >   6.4: Parsing of aliased events from sysfs                          : Skip (no aliases in sysfs)
> >   6.5: Parsing of aliased events                                     : FAILED!
> >   6.6: Parsing of terms (event modifiers)                            : Ok
> >  10: PMU events                                                      :
> >  10.1: PMU event table sanity                                        : Ok
> >  10.2: PMU event map aliases                                         : FAILED!
> >  10.3: Parsing of PMU event table metrics                            : Ok
> >  10.4: Parsing of PMU event table metrics with fake PMUs             : FAILED!
> >  10.5: Parsing of metric thresholds with fake PMUs                   : Ok
> >  93: perf all metricgroups test                                      : FAILED!
> >  94: perf all metrics test                                           : FAILED!
> > [root@kernelqe3 linux]#
> >
> > Bisecting the first problem:
> >
> >  10.2: PMU event map aliases                                         : FAILED!
> >
> > make: Leaving directory '/root/git/linux/tools/perf'
> >   6: Parse event definition strings                                  :
> >   6.1: Test event parsing                                            : Ok
> >   6.2: Parsing of all PMU events from sysfs                          : Ok
> >   6.3: Parsing of given PMU events from sysfs                        : Ok
> >   6.4: Parsing of aliased events from sysfs                          : Skip (no aliases in sysfs)
> >   6.5: Parsing of aliased events                                     : Ok
> >   6.6: Parsing of terms (event modifiers)                            : Ok
> >  10: PMU events                                                      :
> >  10.1: PMU event table sanity                                        : Ok
> >  10.2: PMU event map aliases                                         : FAILED!
> >  10.3: Parsing of PMU event table metrics                            : Ok
> >  10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
> >  10.5: Parsing of metric thresholds with fake PMUs                   : Ok
> >  93: perf all metricgroups test                                      : Ok
> >  94: perf all metrics test                                           : Ok
> > [root@kernelqe3 linux]# git bisect bad
> > 2e255b4f9f41f137d9e3dc4fae3603a9c2c3dd28 is the first bad commit
> > commit 2e255b4f9f41f137d9e3dc4fae3603a9c2c3dd28
> > Author: Ian Rogers <irogers@google.com>
> > Date:   Wed Aug 23 21:13:16 2023 -0700
> >
> >     perf jevents: Group events by PMU
> >
> >     Prior to this change a cpuid would map to a list of events where the PMU
> >     would be encoded alongside the event information. This change breaks
> >     apart each group of events so that there is a group per PMU. A new table
> >     is added with the PMU's name and the list of events, the original table
> >     now holding an array of these per PMU tables.
> >
> >     These changes are to make it easier to get per PMU information about
> >     events, rather than the current approach of scanning all events. The
> >     perf binary size with BPF skeletons on x86 is reduced by about 1%. The
> >     unidentified PMU is now always expanded to "cpu".
> >
> >     Signed-off-by: Ian Rogers <irogers@google.com>
> >     Cc: Adrian Hunter <adrian.hunter@intel.com>
> >     Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> >     Cc: Gaosheng Cui <cuigaosheng1@huawei.com>
> >     Cc: Ingo Molnar <mingo@redhat.com>
> >     Cc: James Clark <james.clark@arm.com>
> >     Cc: Jing Zhang <renyu.zj@linux.alibaba.com>
> >     Cc: Jiri Olsa <jolsa@kernel.org>
> >     Cc: John Garry <john.g.garry@oracle.com>
> >     Cc: Kajol Jain <kjain@linux.ibm.com>
> >     Cc: Kan Liang <kan.liang@linux.intel.com>
> >     Cc: Mark Rutland <mark.rutland@arm.com>
> >     Cc: Namhyung Kim <namhyung@kernel.org>
> >     Cc: Peter Zijlstra <peterz@infradead.org>
> >     Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> >     Cc: Rob Herring <robh@kernel.org>
> >     Link: https://lore.kernel.org/r/20230824041330.266337-5-irogers@google.com
> >     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> >  tools/perf/pmu-events/jevents.py | 181 +++++++++++++++++++++++++++++----------
> >  tools/perf/tests/pmu-events.c    |  30 ++++---
> >  2 files changed, 154 insertions(+), 57 deletions(-)
> > [root@kernelqe3 linux]#
> >
> 
> This change defaulted events without a specified PMU to being for the
> PMU 'cpu', so that events in pmu-events.c were associated with a PMU
> and we could find per-PMU information easily. The test events have no
> PMU and so this has broken s390 where the the PMU should be "cpum_cf".
> It has probably also broken x86 hybrid and arm where their default PMU
> isn't cpu. I'll work on a fix, but the problem will be limited to the
> test.

So, with your "default_core" branche we go to:

[root@kernelqe3 linux]# perf test 10
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : FAILED!
 10.5: Parsing of metric thresholds with fake PMUs                   : Ok
[root@kernelqe3 linux]# perf --version
perf version 6.5.rc5.g3d63ae82aa12
[root@kernelqe3 linux]#

The other tests:

[root@kernelqe3 linux]# perf --version
perf version 6.5.rc5.g3d63ae82aa12
[root@kernelqe3 linux]# perf test 6 10 'perf all metricgroups test' 'perf all metrics test'
  6: Parse event definition strings                                  :
  6.1: Test event parsing                                            : Ok
  6.2: Parsing of all PMU events from sysfs                          : FAILED!
  6.3: Parsing of given PMU events from sysfs                        : Ok
  6.4: Parsing of aliased events from sysfs                          : Skip (no aliases in sysfs)
  6.5: Parsing of aliased events                                     : FAILED!
  6.6: Parsing of terms (event modifiers)                            : Ok
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : FAILED!
 10.5: Parsing of metric thresholds with fake PMUs                   : Ok
 93: perf all metricgroups test                                      : FAILED!
 94: perf all metrics test                                           : FAILED!
[root@kernelqe3 linux]#

Trying to bisect it now.

- Arnaldo
