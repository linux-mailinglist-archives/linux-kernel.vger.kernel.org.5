Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A917CAE36
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjJPPwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjJPPv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:51:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E5D83
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:51:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B4AC433C7;
        Mon, 16 Oct 2023 15:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697471516;
        bh=/ePzPKPVEWPSljsfxP51lXr/Y+dsHVxyCCJk+IzUOvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ungjz8PNUeeLU0/S869BDNj5+TRS9s9XMTKlW1GlQD5elg6Qbb9Xzz+4kZ0lq9JoD
         W57Ey+bR4dni3mKCAqJT+eNIzNndIjAMzRHaV3++aD5Qhum1HBYHQ6bf5aE07UHsLd
         KHaNPB+YovLQAFgEqvHFyjqq1jFCFTjWnyGXlf81pMt0DlGanEFjspczdRJFMAvjmz
         ea9LhbHUNJ0/Bel+VfmGwuf5rWvMe9o22YBlmL/MeMf93hMpBL/1QqGL6XkEacYKJk
         9OFHw1qbEqCGUzQL3Cq38HPd3ijfCXV2F0GnAQ84lPJ48fYiN7MZLxFwa+T79QwTx5
         GuX+QIQINJCfw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E4E1340016; Mon, 16 Oct 2023 12:51:52 -0300 (-03)
Date:   Mon, 16 Oct 2023 12:51:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3] perf bench sched pipe: Add -G/--cgroups option
Message-ID: <ZS1cGMgyEDJQbwq9@kernel.org>
References: <20231016044225.1125674-1-namhyung@kernel.org>
 <ZS0D53ckVx356k4o@gmail.com>
 <ZS1Y5PhXhp384ynY@kernel.org>
 <ZS1ajf/9HmgUyyCl@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS1ajf/9HmgUyyCl@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 16, 2023 at 12:45:17PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Oct 16, 2023 at 12:38:12PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, Oct 16, 2023 at 11:35:35AM +0200, Ingo Molnar escreveu:
> > > * Namhyung Kim <namhyung@kernel.org> wrote:
> > > 
> > > > +	/* try cgroup v2 interface first */
> > > > +	if (threaded)
> > > > +		fd = openat(cgrp->fd, "cgroup.threads", O_WRONLY);
> > > > +	else
> > > > +		fd = openat(cgrp->fd, "cgroup.procs", O_WRONLY);
> > > > +
> > > > +	/* try cgroup v1 if failed */
> > > > +	if (fd < 0)
> > > > +		fd = openat(cgrp->fd, "tasks", O_WRONLY);
> > > > +
> > > > +	if (fd < 0) {
> > > > +		char mnt[PATH_MAX];
> > > > +
> > > > +		printf("Failed to open cgroup file in %s\n", cgrp->name);
> > > > +
> > > > +		if (cgroupfs_find_mountpoint(mnt, sizeof(mnt), "perf_event") == 0)
> > > > +			printf(" Hint: create the cgroup first, like 'mkdir %s/%s'\n",
> > > > +			       mnt, cgrp->name);
> > > 
> > > Ok, this works too I suppose.
> > > 
> > > Acked-by: Ingo Molnar <mingo@kernel.org>
> > 
> > I'm not getting that:
> > 
> > [root@five ~]# perf bench sched pipe -l 10000 -G AAA,BBB
> > # Running 'sched/pipe' benchmark:
> > no access to cgroup /sys/fs/cgroup/AAA
> > cannot open sender cgroup: AAA
> >  Usage: perf bench sched pipe <options>
> > 
> >     -G, --cgroups <SEND,RECV>
> >                           Put sender and receivers in given cgroups
> > [root@five ~]#
> > 
> > Its better now as it bails out, but it is not emitting any message that
> > helps with running the test, well, there is that /sys/fs/cgroup/AAA
> > path, lemme try doing a mkdir:
> > 
> > [root@five ~]# perf bench sched pipe -l 10000 -G AAA,BBB
> > # Running 'sched/pipe' benchmark:
> > no access to cgroup /sys/fs/cgroup/BBB
> > cannot open receiver cgroup: BBB
> >  Usage: perf bench sched pipe <options>
> > 
> >     -G, --cgroups <SEND,RECV>
> >                           Put sender and receivers in given cgroups
> > [root@five ~]#
> > 
> > [root@five ~]# perf bench sched pipe -l 10000 -G AAA,BBB
> > # Running 'sched/pipe' benchmark:
> > [root@five ~]#
> > 
> > It seems to be bailing out but doesn't run the test nor emits any
> > warning.
> 
> (gdb) run bench sched pipe -l 10000
> Starting program: /root/bin/perf bench sched pipe -l 10000
> # Running 'sched/pipe' benchmark:
> [Detaching after fork from child process 33618]
> 
> Breakpoint 1, bench_sched_pipe (argc=0, argv=0x7fffffffe3d8) at bench/sched-pipe.c:259
> 259		if (threads[0].cgroup_failed || threads[1].cgroup_failed)
> (gdb) p threads[0].cgroup_failed
> $1 = 137
> (gdb) p threads[1].cgroup_failed
> $2 = false
> (gdb) n
> 260			return 0;
> (gdb)
> 
> But I'm not even using cgroups?

So, with the patch below 'perf bench sched pipe -l 1000' is back working
for me:

[root@five ~]# perf bench sched pipe  -l 1000
# Running 'sched/pipe' benchmark:
# Executed 1000 pipe operations between two processes

     Total time: 0.007 [sec]

       7.671000 usecs/op
         130361 ops/sec
[root@five ~]#

Now back at testing with with cgroups.

- Arnaldo

