Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E4A7D1708
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 22:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjJTUcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 16:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJTUcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 16:32:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598DB1A4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 13:32:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66C0C433C7;
        Fri, 20 Oct 2023 20:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697833930;
        bh=4gcbCVldBqv13HwyWncnUbVgIxvEAM6vWbNe5FdwbzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i5N/3VspUfptQF2Q8sSj4M06jjU6kst2InC8Rood0yAjrYZat/BhK/c5Ot51N41nf
         ebalsmLk2sWmra8/NhmLZj1c4s+r6ZjI5K5gjAfLQBlEQjo9ATehL7BRE8e4rQrTuZ
         weKSzJ2LX7eKaNIzx0hFc9IZfEUxBiurCtnHUQxQPveck/Vvy6xZzYYvzaM+tGQWtC
         4BcZqz+jHQ0QBzNYRTHEB0/P2IOIt3+h+VpvkikbNgbA17yiYwFpmND+Up3BpsSas5
         L4hsIttQCmrAiPIElnHoeNsmpUqvxT1pVdjeACh0ehouw4I/xZi4dmG3SDU3tT00qG
         t1PIRcgKr4P6A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 493954035D; Fri, 20 Oct 2023 17:32:07 -0300 (-03)
Date:   Fri, 20 Oct 2023 17:32:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4] perf bench sched pipe: Add -G/--cgroups option
Message-ID: <ZTLjx3A8LBQMYWHJ@kernel.org>
References: <20231017202342.1353124-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017202342.1353124-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 17, 2023 at 01:23:42PM -0700, Namhyung Kim escreveu:
> The -G/--cgroups option is to put sender and receiver in different
> cgroups in order to measure cgroup context switch overheads.
<SNIP>
>   > taskset -c 0 perf bench sched pipe -l 10000 -G AAA,BBB > /dev/null
 
>    Performance counter stats for 'taskset -c 0 perf bench sched pipe -l 10000 -G AAA,BBB':
> 
>               20,001      context-switches
>               20,001      cgroup-switches

Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

[root@five ~]# perf stat -e context-switches,cgroup-switches taskset -c 0 perf bench sched pipe -l 10000
# Running 'sched/pipe' benchmark:
# Executed 10000 pipe operations between two processes

     Total time: 0.063 [sec]

       6.367500 usecs/op
         157047 ops/sec

 Performance counter stats for 'taskset -c 0 perf bench sched pipe -l 10000':

            20,004      context-switches
                 4      cgroup-switches

       0.084191842 seconds time elapsed

       0.008332000 seconds user
       0.067193000 seconds sys


[root@five ~]# perf stat -e context-switches,cgroup-switches taskset -c 0 perf bench sched pipe -l 10000 -G AAA,BBB
# Running 'sched/pipe' benchmark:
no access to cgroup /sys/fs/cgroup/BBB
Failed to open cgroup file in BBB
 Hint: create the cgroup first, like 'mkdir /sys/fs/cgroup/BBB'
no access to cgroup /sys/fs/cgroup/AAA
Failed to open cgroup file in AAA
 Hint: create the cgroup first, like 'mkdir /sys/fs/cgroup/AAA'

 Performance counter stats for 'taskset -c 0 perf bench sched pipe -l 10000 -G AAA,BBB':

                 2      context-switches
                 1      cgroup-switches

       0.010356533 seconds time elapsed

       0.003209000 seconds user
       0.007122000 seconds sys


[root@five ~]# vim /tmp/bla
[root@five ~]#
[root@five ~]# mkdir /sys/fs/cgroup/BBB /sys/fs/cgroup/AAA
[root@five ~]# perf stat -e context-switches,cgroup-switches taskset -c 0 perf bench sched pipe -l 10000 -G AAA,BBB
# Running 'sched/pipe' benchmark:
# Executed 10000 pipe operations between two processes

     Total time: 0.079 [sec]

       7.987800 usecs/op
         125190 ops/sec

 Performance counter stats for 'taskset -c 0 perf bench sched pipe -l 10000 -G AAA,BBB':

            20,008      context-switches
            20,007      cgroup-switches

       0.089361029 seconds time elapsed

       0.009004000 seconds user
       0.065376000 seconds sys


[root@five ~]#
