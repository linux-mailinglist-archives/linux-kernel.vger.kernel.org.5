Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC457C9126
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 01:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjJMXDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 19:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbjJMXDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 19:03:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1BAC9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 16:03:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08918C433C8;
        Fri, 13 Oct 2023 23:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697238217;
        bh=iqMnf/BMDJwzFbazhNU1KYWGcCmtvvfRHnstjXFUjjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZUTjQumTZ1JveX+KrzUF3EwwZD/Pxno1XqLO1TzfKno1IuxXHIs3vOK/nIfwOPdL/
         xeNNkczh+TtrWXDVYrRIdnn7+9im/UhKjbxO6iuLlPojtaRryOFXJoj3ncg/btA51H
         lhaub5grrZ5APfH3VqKgGNR8JfXkMfVrdtn2irjS/dpnBUjVLtwerlQSXIHgak5Pv5
         aKfZi82HsYKYQfNcZ2efxAUVK+KngZj4/7R0Z0j+zymh8hBKyEPLkcJkQC+pRtV6M0
         +Gqolbt6tMZKLKv/MzdjR5NT1zKtUfu4QvQbUKXDYp8KHYD5JgCWH0+nCMHY9uYnNs
         cHFmtLLXJ9qow==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 32A7D40016; Fri, 13 Oct 2023 20:03:34 -0300 (-03)
Date:   Fri, 13 Oct 2023 20:03:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf bench sched pipe: Add -G/--cgroups option
Message-ID: <ZSnMxtnt7o5mLj+w@kernel.org>
References: <20231004204741.985422-1-namhyung@kernel.org>
 <ZSnHek1HlQTkfjhG@kernel.org>
 <CAM9d7cip5qmPRhWF37JH_21Q8SjKQCTBVyF_PLE-ytTFOwpasg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cip5qmPRhWF37JH_21Q8SjKQCTBVyF_PLE-ytTFOwpasg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 13, 2023 at 03:57:27PM -0700, Namhyung Kim escreveu:
> Hi Arnaldo,
> 
> On Fri, Oct 13, 2023 at 3:41 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Wed, Oct 04, 2023 at 01:47:41PM -0700, Namhyung Kim escreveu:
> > > The -G/--cgroups option is to put sender and receiver in different
> > > cgroups in order to measure cgroup context switch overheads.
> > >
> > > Users need to make sure the cgroups exist and accessible.
> > >
> > >   # perf stat -e context-switches,cgroup-switches \
> > >   > taskset -c 0 perf bench sched pipe -l 10000 > /dev/null
> > >
> > >    Performance counter stats for 'taskset -c 0 perf bench sched pipe -l 10000':
> > >
> > >               20,001      context-switches
> > >                    2      cgroup-switches
> > >
> > >          0.053449651 seconds time elapsed
> > >
> > >          0.011286000 seconds user
> > >          0.041869000 seconds sys
> > >
> > >   # perf stat -e context-switches,cgroup-switches \
> > >   > taskset -c 0 perf bench sched pipe -l 10000 -G AAA,BBB > /dev/null
> > >
> > >    Performance counter stats for 'taskset -c 0 perf bench sched pipe -l 10000 -G AAA,BBB':
> > >
> > >               20,001      context-switches
> > >               20,001      cgroup-switches
> > >
> > >          0.052768627 seconds time elapsed
> >
> > So I tried with:
> >
> > [root@quaco ~]# perf bench sched pipe -G system.slice,user.slice
> > # Running 'sched/pipe' benchmark:
> > cannot enter to cgroup: system.slice
> > cannot enter to cgroup: user.slice
> > # Executed 1000000 pipe operations between two processes
> >
> >      Total time: 6.301 [sec]
> >
> >        6.301478 usecs/op
> >          158692 ops/sec
> > [root@quaco ~]#
> >
> > Should't it bail out when not managing to enter the cgroups?
> 
> Hmm.. right.  Will fix.
> 
> >
> > Also:
> >
> > [root@quaco ~]# mkdir /sys/fs/cgroup/AAA
> > [root@quaco ~]# mkdir /sys/fs/cgroup/BBB
> > [root@quaco ~]#
> > [root@quaco ~]# perf bench sched pipe -G AAA,BBB
> > # Running 'sched/pipe' benchmark:
> > cannot enter to cgroup: AAA
> > cannot enter to cgroup: BBB
> > # Executed 1000000 pipe operations between two processes
> >
> >      Total time: 6.397 [sec]
> >
> >        6.397830 usecs/op
> >          156302 ops/sec
> > [root@quaco ~]#
> >
> > -rw-r--r--. 1 root root 0 Oct 13 19:22 /sys/fs/cgroup/AAA/cgroup.procs
> > [root@quaco ~]# ls -la /sys/fs/cgroup/AAA/cgroup.threads
> > -rw-r--r--. 1 root root 0 Oct 13 19:22 /sys/fs/cgroup/AAA/cgroup.threads
> > [root@quaco ~]# ls -la /sys/fs/cgroup/BBB/cgroup.threads
> > -rw-r--r--. 1 root root 0 Oct 13 19:22 /sys/fs/cgroup/BBB/cgroup.threads
> > [root@quaco ~]# ls -la /sys/fs/cgroup/BBB/cgroup.procs
> > -rw-r--r--. 1 root root 0 Oct 13 19:22 /sys/fs/cgroup/BBB/cgroup.procs
> > [root@quaco ~]#
> >
> > [root@quaco ~]# perf bench sched pipe -G AAA,BBB
> > # Running 'sched/pipe' benchmark:
> > cannot enter to cgroup: AAA (written=-1, len=6, errno=Operation not supported)
> > cannot enter to cgroup: BBB (written=-1, len=6, errno=Operation not supported)
> > # Executed 1000000 pipe operations between two processes
> >
> >      Total time: 6.303 [sec]
> >
> >        6.303221 usecs/op
> >          158649 ops/sec
> > [root@quaco ~]#
> >
> > I'm certainly missing something here :-\
> 
> Try to enable some cgroup controllers first.  Like
> 
>   # echo +cpu > /sys/fs/cgroup/AAA/cgroup.subtree_control
>   # echo +cpu > /sys/fs/cgroup/BBB/cgroup.subtree_control

[root@quaco cgroup]# echo +cpu > /sys/fs/cgroup/AAA/cgroup.subtree_control
[root@quaco cgroup]# echo +cpu > /sys/fs/cgroup/BBB/cgroup.subtree_control
[root@quaco cgroup]# perf bench sched pipe -G AAA,BBB
# Running 'sched/pipe' benchmark:
cannot enter to cgroup: AAA (written=-1, len=6, errno=Operation not supported)
cannot enter to cgroup: BBB (written=-1, len=6, errno=Operation not supported)
# Executed 1000000 pipe operations between two processes

     Total time: 6.267 [sec]

       6.267680 usecs/op
         159548 ops/sec
[root@quaco cgroup]# cat /sys/fs/cgroup/AAA/cgroup.subtree_control
cpu
[root@quaco cgroup]# cat /sys/fs/cgroup/BBB/cgroup.subtree_control
cpu
[root@quaco cgroup]# uname -a
Linux quaco 6.5.6-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Oct  6 19:02:35 UTC 2023 x86_64 GNU/Linux
[root@quaco cgroup]#
