Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C717C905B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 00:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjJMWlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 18:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJMWlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 18:41:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE41AB7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 15:41:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DC1C433C7;
        Fri, 13 Oct 2023 22:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697236862;
        bh=w5/NPLmu7MtZsZVVLte85Zwy4WqEOc54OWUu9qmyrvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hG4W2RMUHsaEqwOCNz9stfK3ICMpL0xfiA9ZCgXuk8FIXM3kbo5nGojmEyK9sl0Ve
         TnUhs/Zc+bCg+zc7bDqgcRs5td6gA73tzZ1yK3AadQFKGiP/uA3Xk7gp01CDs9bKwM
         6oHEF/nSrFGVz62YyXvkJCLGVpUr2nBcpGFvw5x2mRnSkwsGy2W9R9a27LHau64i7m
         6qQ8INPJ4lRW/o3NljNqUV735NSWWnuVj0rDHyjMsONa0Y0QOcDCFLa5zHuLS/8XZN
         fjLbN9+pIftaXA0nFJXkELV7wfRw4l+TBJn1qQ8EMoWY4LCl5ypmYRfSQ5aUVF2sko
         hbkgbJUskQRKw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7A01A40016; Fri, 13 Oct 2023 19:40:58 -0300 (-03)
Date:   Fri, 13 Oct 2023 19:40:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf bench sched pipe: Add -G/--cgroups option
Message-ID: <ZSnHek1HlQTkfjhG@kernel.org>
References: <20231004204741.985422-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004204741.985422-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 04, 2023 at 01:47:41PM -0700, Namhyung Kim escreveu:
> The -G/--cgroups option is to put sender and receiver in different
> cgroups in order to measure cgroup context switch overheads.
> 
> Users need to make sure the cgroups exist and accessible.
> 
>   # perf stat -e context-switches,cgroup-switches \
>   > taskset -c 0 perf bench sched pipe -l 10000 > /dev/null
> 
>    Performance counter stats for 'taskset -c 0 perf bench sched pipe -l 10000':
> 
>               20,001      context-switches
>                    2      cgroup-switches
> 
>          0.053449651 seconds time elapsed
> 
>          0.011286000 seconds user
>          0.041869000 seconds sys
> 
>   # perf stat -e context-switches,cgroup-switches \
>   > taskset -c 0 perf bench sched pipe -l 10000 -G AAA,BBB > /dev/null
> 
>    Performance counter stats for 'taskset -c 0 perf bench sched pipe -l 10000 -G AAA,BBB':
> 
>               20,001      context-switches
>               20,001      cgroup-switches
> 
>          0.052768627 seconds time elapsed

So I tried with:

[root@quaco ~]# perf bench sched pipe -G system.slice,user.slice
# Running 'sched/pipe' benchmark:
cannot enter to cgroup: system.slice
cannot enter to cgroup: user.slice
# Executed 1000000 pipe operations between two processes

     Total time: 6.301 [sec]

       6.301478 usecs/op
         158692 ops/sec
[root@quaco ~]#

Should't it bail out when not managing to enter the cgroups?

Also:

[root@quaco ~]# mkdir /sys/fs/cgroup/AAA
[root@quaco ~]# mkdir /sys/fs/cgroup/BBB
[root@quaco ~]#
[root@quaco ~]# perf bench sched pipe -G AAA,BBB
# Running 'sched/pipe' benchmark:
cannot enter to cgroup: AAA
cannot enter to cgroup: BBB
# Executed 1000000 pipe operations between two processes

     Total time: 6.397 [sec]

       6.397830 usecs/op
         156302 ops/sec
[root@quaco ~]#

-rw-r--r--. 1 root root 0 Oct 13 19:22 /sys/fs/cgroup/AAA/cgroup.procs
[root@quaco ~]# ls -la /sys/fs/cgroup/AAA/cgroup.threads
-rw-r--r--. 1 root root 0 Oct 13 19:22 /sys/fs/cgroup/AAA/cgroup.threads
[root@quaco ~]# ls -la /sys/fs/cgroup/BBB/cgroup.threads
-rw-r--r--. 1 root root 0 Oct 13 19:22 /sys/fs/cgroup/BBB/cgroup.threads
[root@quaco ~]# ls -la /sys/fs/cgroup/BBB/cgroup.procs
-rw-r--r--. 1 root root 0 Oct 13 19:22 /sys/fs/cgroup/BBB/cgroup.procs
[root@quaco ~]#

[root@quaco ~]# perf bench sched pipe -G AAA,BBB
# Running 'sched/pipe' benchmark:
cannot enter to cgroup: AAA (written=-1, len=6, errno=Operation not supported)
cannot enter to cgroup: BBB (written=-1, len=6, errno=Operation not supported)
# Executed 1000000 pipe operations between two processes

     Total time: 6.303 [sec]

       6.303221 usecs/op
         158649 ops/sec
[root@quaco ~]#

I'm certainly missing something here :-\

- Arnaldo
