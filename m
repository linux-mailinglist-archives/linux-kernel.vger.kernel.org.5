Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA787CB4AB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjJPUfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjJPUfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:35:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19FF95
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:35:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB7DC433C7;
        Mon, 16 Oct 2023 20:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697488502;
        bh=wGAWECJL1BSXHvDFaMRrPSWSvwLJYHm/I9oGrujUIAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BdYuJjt1GSddf/zrQSv0pdrIjA45COUidcM3VPniZAQYxH6XC0ZG9D6vybAA2cQup
         52zTEMSK+XeARFKnvYMKoMgdyPQTIjKPZ/12kF2cXBG5DuAak0F/G3nR8qWJMBurxg
         sTl/k9XqmiNvsIVp3/SNK3ovp9J6mGzclimZPtps3yDU8qNdTM9ee0c9a7o62n6SUq
         tVF4akZRpQnRyCytZI/B238907lNT3PSowAQ3swgFY3KtiQEEI1+Dr5pe0snxJkHLH
         j8sU7x7O80bIuhLDA9OFTmBGYrDN9UrnzgDZGk8iXbS1gMDXu/uTvIAf4W8/4S7UEX
         qKZOAANLT63mA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 89DE040016; Mon, 16 Oct 2023 17:34:59 -0300 (-03)
Date:   Mon, 16 Oct 2023 17:34:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3] perf bench sched pipe: Add -G/--cgroups option
Message-ID: <ZS2ecyCVpK8B2cQq@kernel.org>
References: <20231016044225.1125674-1-namhyung@kernel.org>
 <ZS0D53ckVx356k4o@gmail.com>
 <ZS1Y5PhXhp384ynY@kernel.org>
 <ZS1ajf/9HmgUyyCl@kernel.org>
 <ZS1cGMgyEDJQbwq9@kernel.org>
 <ZS1c9RCh9MkzPbFG@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS1c9RCh9MkzPbFG@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 16, 2023 at 12:55:33PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Oct 16, 2023 at 12:51:52PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Now back at testing with with cgroups.

> Humm, even without the -G I get:

> [root@five ~]# perf stat -e context-switches,cgroup-switches perf bench sched pipe  -l 10000
> # Running 'sched/pipe' benchmark:
> # Executed 10000 pipe operations between two processes
 
>      Total time: 0.082 [sec]
 
>        8.246400 usecs/op
>          121265 ops/sec
 
>  Performance counter stats for 'perf bench sched pipe -l 10000':
 
>             20,002      context-switches
>             20,002      cgroup-switches

Same number, but then I forgot to add the 'taskset -c 0' part of the
command line, if I have it:

[root@five ~]# perf stat -e context-switches,cgroup-switches taskset -c 0 perf bench sched pipe -l 10000
# Running 'sched/pipe' benchmark:
# Executed 10000 pipe operations between two processes

     Total time: 0.072 [sec]

       7.231500 usecs/op
         138283 ops/sec

 Performance counter stats for 'taskset -c 0 perf bench sched pipe -l 10000':

            20,002      context-switches
                 3      cgroup-switches

       0.082855113 seconds time elapsed

       0.007765000 seconds user
       0.074020000 seconds sys


[root@five ~]# perf stat -e context-switches,cgroup-switches taskset -c 0 perf bench sched pipe -l 10000 -G AAA,BBB
# Running 'sched/pipe' benchmark:
# Executed 10000 pipe operations between two processes

     Total time: 0.093 [sec]

       9.341800 usecs/op
         107045 ops/sec

 Performance counter stats for 'taskset -c 0 perf bench sched pipe -l 10000 -G AAA,BBB':

            20,004      context-switches
            20,003      cgroup-switches

       0.103436330 seconds time elapsed

       0.018109000 seconds user
       0.063058000 seconds sys


[root@five ~]#

I.e. it works as in your results, but can you please spell out why that
'taskset -c 0' is needed to get these results?

I wasn't expecting the same number of cgroup-switches when not using
'taskset -c 0' :-\

- Arnaldo

