Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CA37CC32D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343642AbjJQM2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbjJQM2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:28:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACD513A
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:28:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E166DC433C8;
        Tue, 17 Oct 2023 12:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697545693;
        bh=LrC/4LpK+Qmq0CP6UaMCTxygoYhd7Sg2HB4cCDrUJc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kg9x2Do69Icb6QII7+Io3nHRzveUyZry0e0JacmXaIJpNh2f3rfQiKupjBHtMZ5s/
         d5dVrOt4WL0tgQCkxWBz/OKzrqRWbpz0x4m/RDRwOHmyhkXnNQW+sH4AzH5VcaqhaU
         NRwEhG7kuCf1/eITPY1z2N3apSxJO5IY4c0Q7rO1lOHpR8fE3HTFJgKKg5X8qWzJia
         0Z63N0VmVJkneIX2M94YJpD90ckqOuDoerA9tvZ8I/Jta/spjaMQqco60wQEbIzjuX
         C1q0ngXNnzhC+HejD/9VUp6mG0LOqZ7kfkmilOm/lyZXvnjrR+68jdjUSTmuF42Vgh
         XRQ6R8JwuZ2fQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1FB0840016; Tue, 17 Oct 2023 09:28:10 -0300 (-03)
Date:   Tue, 17 Oct 2023 09:28:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [perf stat] Extend --cpu to non-system-wide runs too? was Re: [PATCH
 v3] perf bench sched pipe: Add -G/--cgroups option
Message-ID: <ZS592qxF3YxmCoG1@kernel.org>
References: <20231016044225.1125674-1-namhyung@kernel.org>
 <ZS0D53ckVx356k4o@gmail.com>
 <ZS1Y5PhXhp384ynY@kernel.org>
 <ZS1ajf/9HmgUyyCl@kernel.org>
 <ZS1cGMgyEDJQbwq9@kernel.org>
 <ZS1c9RCh9MkzPbFG@kernel.org>
 <ZS2ecyCVpK8B2cQq@kernel.org>
 <ZS5yl3RzVGKBkCvY@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS5yl3RzVGKBkCvY@gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 17, 2023 at 01:40:07PM +0200, Ingo Molnar escreveu:
> Side note: it might make sense to add a sane cpumask/affinity setting 
> option to perf stat itself:
> 
>   perf stat --cpumask 
> 
> ... or so?
> 
> We do have -C:
> 
>     -C, --cpu <cpu>       list of cpus to monitor in system-wide
> 
> ... but that's limited to --all-cpus, right?
> 
> Perhaps we could extend --cpu to non-system-wide runs too?

Maybe I misunderstood your question, but its a list of cpus to limit the
counting:

On a mostly idle system (some browsers, etc):

[root@five ~]# perf stat -C 0,2 -e cycles -I 1000
#           time             counts unit events
     1.001012960        207,999,675      cycles
     2.002152464        157,058,633      cycles
     3.002985969        174,590,102      cycles
     4.003411871        216,250,416      cycles
     5.004392310        180,537,857      cycles
     6.005387846        171,036,571      cycles
     7.006386564        156,461,753      cycles
     8.007532366        158,010,466      cycles
     9.008682339        164,971,366      cycles
^C     9.377946210         77,242,809      cycles

[root@five ~]#

Then:

[root@five ~]# perf stat -C 0 -e cycles -I 1000
#           time             counts unit events
     1.001019469         69,833,637      cycles
     2.002133490        111,297,731      cycles
     3.003225211         90,416,063      cycles
     4.003663853         34,189,884      cycles
     5.004689751         34,583,822      cycles
     6.005659918         33,284,110      cycles
     7.006660396         62,080,246      cycles
^C     7.229236075         23,250,207      cycles

[root@five ~]#

But:

[root@five ~]# taskset -c 0 stress-ng --cpu 32  &
[1] 9859
[root@five ~]# stress-ng: info:  [9859] defaulting to a 1 day, 0 secs run per stressor
stress-ng: info:  [9859] dispatching hogs: 32 cpu

[root@five ~]#

[root@five ~]# perf stat -C 0,2 -e cycles -I 1000
#           time             counts unit events
     1.001024379      4,838,680,041      cycles
     2.008891551      4,849,936,963      cycles
     3.017168975      4,835,710,170      cycles
     4.025437789      4,847,294,589      cycles
     5.033239780      4,825,463,385      cycles
     6.039332959      4,834,989,373      cycles
^C     6.067478756        125,338,359      cycles

[root@five ~]# perf stat -C 2 -e cycles -I 1000
#           time             counts unit events
     1.000215845         21,244,609      cycles
     2.001216573         51,337,887      cycles
     3.002278103         49,421,924      cycles
     4.003339432         33,270,235      cycles
^C     4.338990744         14,178,759      cycles

[root@five ~]# perf stat -C 0 -e cycles -I 1000
#           time             counts unit events
     1.000801562      4,767,090,700      cycles
     2.001800540      4,761,384,154      cycles
     3.002801468      4,768,816,073      cycles
^C     3.313349213      1,479,254,494      cycles

[root@five ~]#

If we try to specify a pid and cpu:

[root@five ~]# taskset -c 0 sleep 100m &
[2] 9964
[root@five ~]#
[root@five ~]# perf stat -C 0 -p 9964 -e cycles -I 1000
PID/TID switch overriding CPU
#           time             counts unit events
     1.000929383      <not counted>      cycles
     2.001933839      <not counted>      cycles
     3.002927605      <not counted>      cycles
     4.003983793      <not counted>      cycles
     5.005051180      <not counted>      cycles
     6.006123168      <not counted>      cycles
     7.007182796      <not counted>      cycles
     8.008261274      <not counted>      cycles
     9.009324991      <not counted>      cycles
^C     9.454324736      <not counted>      cycles

[root@five ~]#


[root@five ~]# pidof stress-ng
9891 9890 9889 9888 9887 9886 9885 9884 9883 9882 9881 9880 9879 9878 9877 9876 9875 9874 9873 9872 9871 9870 9869 9868 9867 9866 9865 9864 9863 9862 9861 9860 9859
[root@five ~]# perf stat -C 0 -p 9860 -e cycles -I 1000
PID/TID switch overriding CPU
#           time             counts unit events
     1.001045336        144,691,886      cycles
     2.002170624        134,088,343      cycles
     3.003257911        149,148,823      cycles
^C     3.301585761         40,468,152      cycles

[root@five ~]#

Do you want to profile some specific PID only when it runs on some
specific CPU?

That should work, as per man perf_event_open:

       pid == 0 and cpu >= 0
              This measures the calling process/thread only when running on the specified CPU.

But, as we saw above, tooling is preventing us from doing that :-\

- Arnaldo
