Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C031A75B089
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjGTN4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbjGTN4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:56:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D73A2;
        Thu, 20 Jul 2023 06:56:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4983461B04;
        Thu, 20 Jul 2023 13:56:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D017C433C9;
        Thu, 20 Jul 2023 13:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689861366;
        bh=xaotAmYtR+6ed1XycHVZdoqdUJ+IadpeuySsE7fU++o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PEtd+9hT/NrJSfyW9xhPT5yEKM78wWVOplsoMPLHsFwi5SaM3bEU0kD9vHLoXAgGy
         KcfZShRSPledbZiUSu7kr4eGajDlktkWsvEo0A0btEx+9JBVhenkNzADEu9mlECUZe
         pxENdal6nEjEbm6Kadfd0nM0qCk1HsjH7QJh1YMMQnzU+nj16fC+bTMRS53zE+TZur
         Zo68XbVax9re9AX+yVTsjTGCLE101oxRy8wdpZ2wrBGCYFRr5xJvguE38cuA84Yu2e
         RwAa1xBAky3N32z/Lh+oZduFp/w1mafiUBwp/oebF1zBB3MW9nKcrJ1P81UKGsl61m
         N7xkzoBUFLFEQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7CCB240516; Thu, 20 Jul 2023 10:56:03 -0300 (-03)
Date:   Thu, 20 Jul 2023 10:56:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCHES/RFC 1/5] perf bench uprobe + BPF skel
Message-ID: <ZLk88+EYaWeXA3Gm@kernel.org>
References: <20230719204910.539044-1-acme@kernel.org>
 <CAP-5=fVF6yE-Lo3xpqLz7ZyZ6sXzPvDTij6BcrYzjvMTEi+jRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVF6yE-Lo3xpqLz7ZyZ6sXzPvDTij6BcrYzjvMTEi+jRg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 19, 2023 at 03:41:54PM -0700, Ian Rogers escreveu:
> On Wed, Jul 19, 2023 at 1:49 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Hi,
> >
> >         This adds a 'perf bench' to test the overhead of uprobes + BPF
> > programs, for now just a few simple tests, but I plan to make it
> > possible to specify the functions to attach the uprobe + BPF, other BPF
> > operations dealing with maps, etc.
> >
> >         This is how it looks like now:
> >
> >   [root@five ~]# perf bench uprobe all
> >   # Running uprobe/baseline benchmark...
> >   # Executed 1,000 usleep(1000) calls
> >        Total time: 1,053,963 usecs
> >
> >    1,053.963 usecs/op
> >
> >   # Running uprobe/empty benchmark...
> >   # Executed 1,000 usleep(1000) calls
> >        Total time: 1,056,293 usecs +2,330 to baseline
> >
> >    1,056.293 usecs/op 2.330 usecs/op to baseline
> >
> >   # Running uprobe/trace_printk benchmark...
> >   # Executed 1,000 usleep(1000) calls
> >        Total time: 1,056,977 usecs +3,014 to baseline +684 to previous
> >
> >    1,056.977 usecs/op 3.014 usecs/op to baseline 0.684 usecs/op to previous
> >
> >   [root@five ~]
> >
> > I put it here:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=perf-bench-uprobe
> >
> >   git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf-bench-uprobe
> >
> > Further ideas, problems?
> 
> No problems. Perhaps it would be interesting to measure the uprobe
> overhead compared to say the overhead attaching to the nanosleep
> syscall?

Can you rephrase your question?

The test is comparing the overhead attaching to the clock_nanosleep
syscall:

[root@five ~]# strace -c ~/bin/perf bench uprobe baseline
# Running 'uprobe/baseline' benchmark:
# Executed 1,000 usleep(1000) calls
     Total time: 1,077,139 usecs

 1,077.139 usecs/op
==7056==LeakSanitizer has encountered a fatal error.
==7056==HINT: For debugging, try setting environment variable LSAN_OPTIONS=verbosity=1:log_threads=1
==7056==HINT: LeakSanitizer does not work under ptrace (strace, gdb, etc)
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ------------------
 52.87    0.002973           2      1000           clock_nanosleep
 22.55    0.001268           3       370           mmap
  8.87    0.000499           4       106           read
  5.42    0.000305           4        62           munmap
  2.42    0.000136           3        38           openat
  1.69    0.000095           1        48           mprotect
  1.28    0.000072           1        57           close
  1.19    0.000067           3        18           open
  0.98    0.000055           1        40         1 newfstatat
  0.44    0.000025           0        30           pread64
  0.44    0.000025           6         4           getdents64
  0.32    0.000018          18         1           readlink
  0.28    0.000016           2         8           write
  0.23    0.000013           1         9         4 prctl
  0.21    0.000012           6         2         2 access
  0.12    0.000007           0         8           madvise
  0.11    0.000006           1         4           clock_gettime
  0.11    0.000006           1         4           prlimit64
  0.07    0.000004           1         3           rt_sigaction
  0.07    0.000004           1         4           sigaltstack
  0.07    0.000004           4         1           sched_getaffinity
  0.05    0.000003           0         6           getpid
  0.04    0.000002           0         3           rt_sigprocmask
  0.04    0.000002           1         2         1 arch_prctl
  0.04    0.000002           1         2           futex
  0.04    0.000002           2         1           set_robust_list
  0.02    0.000001           1         1           set_tid_address
  0.02    0.000001           1         1           rseq
  0.00    0.000000           0         1           brk
  0.00    0.000000           0        14           sched_yield
  0.00    0.000000           0         1           clone
  0.00    0.000000           0         1           execve
  0.00    0.000000           0         1           wait4
  0.00    0.000000           0         1           gettid
------ ----------- ----------- --------- --------- ------------------
100.00    0.005623           3      1852         8 total
[root@five ~]#
