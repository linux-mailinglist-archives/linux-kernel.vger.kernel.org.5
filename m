Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2A87856D7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 13:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbjHWLf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 07:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjHWLfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 07:35:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C239710FE;
        Wed, 23 Aug 2023 04:35:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 846F36604B;
        Wed, 23 Aug 2023 11:34:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA5CC433C7;
        Wed, 23 Aug 2023 11:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692790486;
        bh=X+mD8swD/B1r/WRr0uFCG3p2J8HJeLmr49XtjHrY3rg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FFiQ3GR2WJwIDQIqUsxJjDMCH2ORBgAT83hGsRoK5oPSChQPW4l3qR1YRM57zy4Op
         yOEftZUgZsehgNUDUAYyh2WHGGUeIV7g8/9iuLQeSecG+YxnpDLvl/euLaf+SfeoSZ
         XshcwZurmE9w6FKZbKQ83Ye3j2d5Jl8y+huK6lFwEhd7wmU6wObKp+r2xbjUuQmLDF
         iFI+4WjWaTHI2miFjqnzKBughovclp7caSW2TjoQ8pM7aYEzu2ltABCv8SSHsfWRrr
         PNkMUw2SmCnTTpSlUtkCz6vbPp4ypLGH03btzxdTVLp9XAsUhR2mEEYzYrD0W9iy+0
         743CN/c2mv4sw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 09DBD40722; Wed, 23 Aug 2023 08:34:44 -0300 (-03)
Date:   Wed, 23 Aug 2023 08:34:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] perf test: Add perf record sample filtering test
Message-ID: <ZOXu0xq7fgwsZ5Co@kernel.org>
References: <20230811025822.3859771-1-namhyung@kernel.org>
 <20230811025822.3859771-2-namhyung@kernel.org>
 <ZNu2KrbgFPY69K2+@kernel.org>
 <ZNu47CYXV0nuav+G@kernel.org>
 <CAM9d7ciZaH1KkGannC=69FgtyOO7M_1opu-xgdDCkske+en1jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7ciZaH1KkGannC=69FgtyOO7M_1opu-xgdDCkske+en1jg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 22, 2023 at 05:50:26PM -0700, Namhyung Kim escreveu:
> Hi Arnaldo,
> 
> On Tue, Aug 15, 2023 at 10:42 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Tue, Aug 15, 2023 at 02:30:18PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Thu, Aug 10, 2023 at 07:58:22PM -0700, Namhyung Kim escreveu:
> > > >   $ sudo ./perf test 'sample filter' -v
> > > >    94: perf record sample filtering (by BPF) tests                     :
> > > >   --- start ---
> > > >   test child forked, pid 3817527
> > > >   Checking BPF-filter privilege
> > > >   Basic bpf-filter test
> > > >   Basic bpf-filter test [Success]
> > > >   Failing bpf-filter test
> > > >   Error: task-clock event does not have PERF_SAMPLE_CPU
> > > >   Failing bpf-filter test [Success]
> > > >   Group bpf-filter test
> > > >   Error: task-clock event does not have PERF_SAMPLE_CPU
> > > >   Error: task-clock event does not have PERF_SAMPLE_CODE_PAGE_SIZE
> > > >   Group bpf-filter test [Success]
> > > >   test child finished with 0
> > > >   ---- end ----
> > > >   perf record sample filtering (by BPF) tests: Ok
> > >
> > > [root@five ~]# perf test -v "by BPF"
> > >  91: perf record sample filtering (by BPF) tests                     :
> > > --- start ---
> > > test child forked, pid 64165
> > > Checking BPF-filter privilege
> > > Basic bpf-filter test
> > >  ffffffff97f4f688
> > >  ffffffff97f73859
> > >  ffffffff97412ce6
> > >  ffffffff976da215
> > >  ffffffff973a92bf
> > >  ffffffff97376ad7
> > >  ffffffff97f73859
> > <SNIP
> > >  ffffffff971fdca5
> > >  ffffffff9737dbc4
> > >  ffffffff971b4e04
> > > Basic bpf-filter test [Failed invalid output]
> > > test child finished with -1
> > > ---- end ----
> > > perf record sample filtering (by BPF) tests: FAILED!
> > > [root@five ~]#
> > >
> > > [root@five ~]# uname -a
> > > Linux five 6.2.15-100.fc36.x86_64 #1 SMP PREEMPT_DYNAMIC Thu May 11 16:51:53 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux
> > > [root@five ~]#
> >
> > Above was on a AMD Ryzen 5950X, the following was on a lenovo t480s,
> > Intel notebook:
> 
> Thanks for the test.  I think it's a matter of the kernel version
> rather than the CPU vendor.  6.1 or before will fail the check
> in the beginning but 6.2 kernel lacks a feature to set sample
> flags for some fields and silently accept all samples.  IIRC it's
> added in v6.3.
> 
> Probably I need to add a version check in the error path.

Yeah, we need to do a wider testing of all things enabled
BUILD_BPF_SKEL=1, in more kernels, architectures, distributions.

Thanks for the feedback,

- Arnaldo

 
> Thanks,
> Namhyung
> 
> >
> > [root@quaco ~]# uname -a
> > Linux quaco 6.4.7-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Jul 27 20:01:18 UTC 2023 x86_64 GNU/Linux
> > [root@quaco ~]# perf test "filter"
> >  30: Filter hist entries                                             : Ok
> >  36: Filter fds with revents mask in a fdarray                       : Ok
> >  67: dlfilter C API                                                  : Ok
> >  91: perf record sample filtering (by BPF) tests                     : Ok
> > [root@quaco ~]# perf test -v "by BPF"
> >  91: perf record sample filtering (by BPF) tests                     :
> > --- start ---
> > test child forked, pid 273609
> > Checking BPF-filter privilege
> > Basic bpf-filter test
> > Basic bpf-filter test [Success]
> > Failing bpf-filter test
> > Error: task-clock event does not have PERF_SAMPLE_CPU
> > Failing bpf-filter test [Success]
> > Group bpf-filter test
> > Error: task-clock event does not have PERF_SAMPLE_CPU
> > Error: task-clock event does not have PERF_SAMPLE_CODE_PAGE_SIZE
> > Group bpf-filter test [Success]
> > test child finished with 0
> > ---- end ----
> > perf record sample filtering (by BPF) tests: Ok
> > [root@quaco ~]#

-- 

- Arnaldo
