Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78DB7C9132
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 01:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbjJMXKw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 13 Oct 2023 19:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJMXKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 19:10:51 -0400
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0F5B7;
        Fri, 13 Oct 2023 16:10:47 -0700 (PDT)
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5aaebfac4b0so811097a12.2;
        Fri, 13 Oct 2023 16:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697238647; x=1697843447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jq9pAKpCKsuW4M2aVm6h0RSLxNTvAXPcyrENZdgKoqs=;
        b=FLbHlM+CsBJ1q47Hkw7tR76MR8JZFIFLdspOuZXXKY3TZRKhgR1znJVNuN5lfOxBRa
         MXGX021UqhZYrnHPIYseFgpoH/0x4HH7hVB+JclKdNHOb2k6SMjjribeHW+vRyieApz4
         S7Q5mZ8pXrUmH4wcf8+v9+fgvQNJ7BoYsJxXtGRfm6T8JSWhPfQBlvA7dgGJm4XCEfDM
         9kbaVcbMQAa2xNrbqMBnKCnRlWMChCPoM6igRwfwjPoPbm2GtsQcr9rcrvTwAJRV4dzq
         Ok+dgXPMCqwJh2eryd3C/P6E4XC5Ra86r94qHASgcLj43rQ3HI3PL5hjwkw2+G/v0GZJ
         RKCA==
X-Gm-Message-State: AOJu0Yy5+mxUrgjh7GGMu1oTHcLCAQlrRL+YtrY239W3nbE6bXTl/4EK
        go4JtluQ9irS9RuWJrDjA55eUVF6w3aFpBUlYbI=
X-Google-Smtp-Source: AGHT+IHDM6Zprp24HuVjm/VUZDe7ubNTycIxI/bJLO0R9kpM/9xOBcfm4CfYf+9QwsazMBT1ncN8EY2QEFZc66A0/Lc=
X-Received: by 2002:a05:6a20:3c90:b0:171:75ef:d636 with SMTP id
 b16-20020a056a203c9000b0017175efd636mr14759284pzj.21.1697238646628; Fri, 13
 Oct 2023 16:10:46 -0700 (PDT)
MIME-Version: 1.0
References: <20231004204741.985422-1-namhyung@kernel.org> <ZSnHek1HlQTkfjhG@kernel.org>
 <CAM9d7cip5qmPRhWF37JH_21Q8SjKQCTBVyF_PLE-ytTFOwpasg@mail.gmail.com> <ZSnMxtnt7o5mLj+w@kernel.org>
In-Reply-To: <ZSnMxtnt7o5mLj+w@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 13 Oct 2023 16:10:35 -0700
Message-ID: <CAM9d7cg75rnPpOUB4wUqUPCbsEZucOyu0sB1UwF3kk-4E8q2SA@mail.gmail.com>
Subject: Re: [PATCH] perf bench sched pipe: Add -G/--cgroups option
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
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

On Fri, Oct 13, 2023 at 4:03 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Oct 13, 2023 at 03:57:27PM -0700, Namhyung Kim escreveu:
> > Hi Arnaldo,
> >
> > On Fri, Oct 13, 2023 at 3:41 PM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > > -rw-r--r--. 1 root root 0 Oct 13 19:22 /sys/fs/cgroup/AAA/cgroup.procs
> > > [root@quaco ~]# ls -la /sys/fs/cgroup/AAA/cgroup.threads
> > > -rw-r--r--. 1 root root 0 Oct 13 19:22 /sys/fs/cgroup/AAA/cgroup.threads
> > > [root@quaco ~]# ls -la /sys/fs/cgroup/BBB/cgroup.threads
> > > -rw-r--r--. 1 root root 0 Oct 13 19:22 /sys/fs/cgroup/BBB/cgroup.threads
> > > [root@quaco ~]# ls -la /sys/fs/cgroup/BBB/cgroup.procs
> > > -rw-r--r--. 1 root root 0 Oct 13 19:22 /sys/fs/cgroup/BBB/cgroup.procs
> > > [root@quaco ~]#
> > >
> > > [root@quaco ~]# perf bench sched pipe -G AAA,BBB
> > > # Running 'sched/pipe' benchmark:
> > > cannot enter to cgroup: AAA (written=-1, len=6, errno=Operation not supported)
> > > cannot enter to cgroup: BBB (written=-1, len=6, errno=Operation not supported)
> > > # Executed 1000000 pipe operations between two processes
> > >
> > >      Total time: 6.303 [sec]
> > >
> > >        6.303221 usecs/op
> > >          158649 ops/sec
> > > [root@quaco ~]#
> > >
> > > I'm certainly missing something here :-\
> >
> > Try to enable some cgroup controllers first.  Like
> >
> >   # echo +cpu > /sys/fs/cgroup/AAA/cgroup.subtree_control
> >   # echo +cpu > /sys/fs/cgroup/BBB/cgroup.subtree_control
>
> [root@quaco cgroup]# echo +cpu > /sys/fs/cgroup/AAA/cgroup.subtree_control
> [root@quaco cgroup]# echo +cpu > /sys/fs/cgroup/BBB/cgroup.subtree_control
> [root@quaco cgroup]# perf bench sched pipe -G AAA,BBB
> # Running 'sched/pipe' benchmark:
> cannot enter to cgroup: AAA (written=-1, len=6, errno=Operation not supported)
> cannot enter to cgroup: BBB (written=-1, len=6, errno=Operation not supported)
> # Executed 1000000 pipe operations between two processes
>
>      Total time: 6.267 [sec]
>
>        6.267680 usecs/op
>          159548 ops/sec
> [root@quaco cgroup]# cat /sys/fs/cgroup/AAA/cgroup.subtree_control
> cpu
> [root@quaco cgroup]# cat /sys/fs/cgroup/BBB/cgroup.subtree_control
> cpu
> [root@quaco cgroup]# uname -a
> Linux quaco 6.5.6-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Oct  6 19:02:35 UTC 2023 x86_64 GNU/Linux
> [root@quaco cgroup]#

Hmm... I don't know, I've tested it on v1 only ;-p  I'll take a look.

Also I found a bug, will fix too.

Thanks,
Namhyung


diff --git a/tools/perf/bench/sched-pipe.c b/tools/perf/bench/sched-pipe.c
index 1103fd658d5d..25236f339b90 100644
--- a/tools/perf/bench/sched-pipe.c
+++ b/tools/perf/bench/sched-pipe.c
@@ -118,9 +118,9 @@ static void enter_cgroup(struct cgroup *cgrp)

        /* try cgroup v2 interface first */
        if (threaded)
-               fd = openat(cgrp->fd, "cgroup.procs", O_WRONLY);
-       else
                fd = openat(cgrp->fd, "cgroup.threads", O_WRONLY);
+       else
+               fd = openat(cgrp->fd, "cgroup.progs", O_WRONLY);

        /* try cgroup v1 if failed */
        if (fd < 0)
