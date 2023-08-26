Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B9F78931D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 03:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjHZBjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 21:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjHZBiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 21:38:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD361BCD;
        Fri, 25 Aug 2023 18:38:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 161D461B07;
        Sat, 26 Aug 2023 01:38:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E32C433C8;
        Sat, 26 Aug 2023 01:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693013927;
        bh=/GRdRBgIXWHmbqe390xRnh53Yf3/xECvBB01VrOXMAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e485+cBL6dN3Hj5jjtlJV66UocwEcZ4e1Jib5rRnSFQYZL23TIeQM9ZcRToIs/rHp
         yyzqTYSceh1mwL/ONvdZPyH9jyuPO0D7HwCZE4egwUfZ01vXCNeDhn8JoJfh2kZONC
         I1UEpYdKybnzDN0PJPxfTzAbNIT3qkzw3+OMLyvEBqrUK42cRUDUb4lb3EwkUB6Qu0
         53yxVDOLMpS6VirFlLdfTLZu3f8WdXrVgoJJ3b6B7ZCu+ZybIfNC+kHG0Ktvw72LBD
         oQnhHtBx+d2rhyrvpsjp0/AUNkMvbUbjpmD+Ph5EuY+aYYpRaGUxkMf4xd+JuNECm2
         GJhrt3FeQARRQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 27A9740722; Fri, 25 Aug 2023 22:38:44 -0300 (-03)
Date:   Fri, 25 Aug 2023 22:38:44 -0300
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
Message-ID: <ZOlXpJM/ognSPlcz@kernel.org>
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
> On Fri, Aug 25, 2023 at 1:56 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
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
> 
> This change defaulted events without a specified PMU to being for the
> PMU 'cpu', so that events in pmu-events.c were associated with a PMU
> and we could find per-PMU information easily. The test events have no
> PMU and so this has broken s390 where the the PMU should be "cpum_cf".
> It has probably also broken x86 hybrid and arm where their default PMU
> isn't cpu. I'll work on a fix, but the problem will be limited to the
> test.

Ok, please use tmp.perf-tools-next as the basis for your work, that is
what I have right now.

- Arnaldo
