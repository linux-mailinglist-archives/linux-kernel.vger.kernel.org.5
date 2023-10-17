Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5067CC2BE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbjJQMQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235134AbjJQMPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:15:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB838681
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:11:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B8BC433C7;
        Tue, 17 Oct 2023 12:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697544552;
        bh=Nbr+W9iQN07rxrGeF9ml8ztmKyGXJr/6WE1uNPvYYws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lylVMsvcb6xDmtPi9qyEtGHKKdlAR28RVW/kf/UNFXmpUy81m7tNI4hHgx8AtE3aV
         kQOCMg6e8N+7d6hKtAM1LY5NuiQ505/TikPzND2NZq1aMk8Xvp5ISZadWXdtOOAq5o
         NW67qK2xEqDdNj5ITe41i+n1KtSx5JUxYgE+mD7fm2cl2ZgNAgeVLjNZ3Ai5G92lZ+
         8EKACzpRtV35Yxr8Lymnck/iyRlCRy45gfDeQebL2A+8NMtfhwkS4iRWmTy+BlnjMA
         G9tfAJYXSpu5LxKvspHQRF1b9KAZ65pG1P7K8P/donx/LsZO1RSkF7/S9VO/JV3Du+
         a1PQFT9RCUIIA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0946C40016; Tue, 17 Oct 2023 09:09:10 -0300 (-03)
Date:   Tue, 17 Oct 2023 09:09:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3] perf bench sched pipe: Add -G/--cgroups option
Message-ID: <ZS55ZfRFGbQMIbbh@kernel.org>
References: <20231016044225.1125674-1-namhyung@kernel.org>
 <ZS0D53ckVx356k4o@gmail.com>
 <ZS1Y5PhXhp384ynY@kernel.org>
 <ZS1ajf/9HmgUyyCl@kernel.org>
 <ZS1cGMgyEDJQbwq9@kernel.org>
 <ZS1c9RCh9MkzPbFG@kernel.org>
 <ZS2ecyCVpK8B2cQq@kernel.org>
 <CAM9d7cjH+c30MChKyOpMNB6-k6Vy4F4ZbB1Eih0Dk5tgXP8mEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cjH+c30MChKyOpMNB6-k6Vy4F4ZbB1Eih0Dk5tgXP8mEg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 16, 2023 at 02:44:23PM -0700, Namhyung Kim escreveu:
> On Mon, Oct 16, 2023 at 1:35 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> > Em Mon, Oct 16, 2023 at 12:55:33PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Mon, Oct 16, 2023 at 12:51:52PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > Now back at testing with with cgroups.
> >
> > > Humm, even without the -G I get:
> >
> > > [root@five ~]# perf stat -e context-switches,cgroup-switches perf bench sched pipe  -l 10000
> > > # Running 'sched/pipe' benchmark:
> > > # Executed 10000 pipe operations between two processes
> >
> > >      Total time: 0.082 [sec]
> >
> > >        8.246400 usecs/op
> > >          121265 ops/sec
> >
> > >  Performance counter stats for 'perf bench sched pipe -l 10000':
> >
> > >             20,002      context-switches
> > >             20,002      cgroup-switches
> >
> > Same number, but then I forgot to add the 'taskset -c 0' part of the
> > command line, if I have it:
> >
> > [root@five ~]# perf stat -e context-switches,cgroup-switches taskset -c 0 perf bench sched pipe -l 10000
> > # Running 'sched/pipe' benchmark:
> > # Executed 10000 pipe operations between two processes
> >
> >      Total time: 0.072 [sec]
> >
> >        7.231500 usecs/op
> >          138283 ops/sec
> >
> >  Performance counter stats for 'taskset -c 0 perf bench sched pipe -l 10000':
> >
> >             20,002      context-switches
> >                  3      cgroup-switches
> >
> >        0.082855113 seconds time elapsed
> >
> >        0.007765000 seconds user
> >        0.074020000 seconds sys
> >
> >
> > [root@five ~]# perf stat -e context-switches,cgroup-switches taskset -c 0 perf bench sched pipe -l 10000 -G AAA,BBB
> > # Running 'sched/pipe' benchmark:
> > # Executed 10000 pipe operations between two processes
> >
> >      Total time: 0.093 [sec]
> >
> >        9.341800 usecs/op
> >          107045 ops/sec
> >
> >  Performance counter stats for 'taskset -c 0 perf bench sched pipe -l 10000 -G AAA,BBB':
> >
> >             20,004      context-switches
> >             20,003      cgroup-switches
> >
> >        0.103436330 seconds time elapsed
> >
> >        0.018109000 seconds user
> >        0.063058000 seconds sys
> >
> >
> > [root@five ~]#
> >
> > I.e. it works as in your results, but can you please spell out why that
> > 'taskset -c 0' is needed to get these results?
> >
> > I wasn't expecting the same number of cgroup-switches when not using
> > 'taskset -c 0' :-\
> 
> Without taskset, each task is likely to run on different CPUs
> and other tasks (including idle) on that CPU would be in
> different cgroup so it'll create cgroup switches everytime
> if they run in AAA or BBB.

Sure, and the 'perf stat' is counting _just_ that workload and its
children (no -a).

Can you please add this to the cset commit log message? I.e. describe
the test setup thoroughly to help in reviewing and for us to quickly
understand what is being tested, the purpose of the test and how the
results match our expectations.

This will be specially helpful in the future, when we do bisects, try to
understand why changes were made, etc.

Even in the man page this information would be useful in helping users
to understand the purpose of the 'perf bench' -G option. So I think its
better to have it there instead of in the cset commit log message.
 
> With taskset, both sender and receiver would run on the
> same CPU.  So it'd see the impact of cgroup switches
> with this option.

Thanks!

- Arnaldo
