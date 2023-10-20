Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C7D7D17E3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 23:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjJTVOK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 20 Oct 2023 17:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjJTVOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 17:14:08 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CD5D60;
        Fri, 20 Oct 2023 14:14:02 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-27d329a704bso961208a91.0;
        Fri, 20 Oct 2023 14:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697836441; x=1698441241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xqiAA7yUfcFNuJz9yt0cNSqQJ4Uy3bxmqwHDlGSMdg=;
        b=X9I7DJntWiszeBtiKkAP0U17+rnkOyVfsAclN6i5ekgGD2VQzpcCRhBMdbwm9ANE+l
         UEDjWubM92hPhw6AzolrwmyKEIJkJzQyMEhd97ldijvg8NTbATqKHTBWU9aUsimrUhYf
         h6HCtPsrbDGhmbi6bWiPgv/jh1LVh3SdHom7EpZOPLaFs+AA02xWMzmXK8y3W+4Xxa69
         Pkc94z0H+CJtPouKiN8saK+ALyAYRnbSHKAObhgDUFqwz63mhm9wOFfaHAORn1/IqOLt
         abitL/rtpGpyjfZHVlYjb6kACWh5mZaue9sgzKCFrHLnUxCxOrBaQJbP4a3Chq8YGsLE
         CTDA==
X-Gm-Message-State: AOJu0YwITC4aWqHUaEKgL/5yjuRhzrX7FrC9T3ZQ1PiPOaT4hlCayJep
        pudwj8gFvXWI4aPlQAxyvPkD7vy0IMdL/YEuJmDdx9we
X-Google-Smtp-Source: AGHT+IG/VoXI1JBpVoEZfBg384XC3qm1W8eZsSVL/jQ0J3rl4+8O3vWvxeYru+v+dhM1C9hmc8pMaid13NsUKFacJKI=
X-Received: by 2002:a17:90b:3d87:b0:27d:1532:e736 with SMTP id
 pq7-20020a17090b3d8700b0027d1532e736mr2690226pjb.48.1697836441372; Fri, 20
 Oct 2023 14:14:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231017202342.1353124-1-namhyung@kernel.org> <ZTLjx3A8LBQMYWHJ@kernel.org>
In-Reply-To: <ZTLjx3A8LBQMYWHJ@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 20 Oct 2023 14:13:50 -0700
Message-ID: <CAM9d7cjoStnwi+UbruGKxYbmKnD0+TU4u5suacQFLt6sb5tf=g@mail.gmail.com>
Subject: Re: [PATCH v4] perf bench sched pipe: Add -G/--cgroups option
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 1:32 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Oct 17, 2023 at 01:23:42PM -0700, Namhyung Kim escreveu:
> > The -G/--cgroups option is to put sender and receiver in different
> > cgroups in order to measure cgroup context switch overheads.
> <SNIP>
> >   > taskset -c 0 perf bench sched pipe -l 10000 -G AAA,BBB > /dev/null
>
> >    Performance counter stats for 'taskset -c 0 perf bench sched pipe -l 10000 -G AAA,BBB':
> >
> >               20,001      context-switches
> >               20,001      cgroup-switches
>
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Thanks a lot Arnaldo!

Ingo, can I keep you Acked-by here? (forgot to add in v4, sorry!)

Thanks,
Namhyung

>
> [root@five ~]# perf stat -e context-switches,cgroup-switches taskset -c 0 perf bench sched pipe -l 10000
> # Running 'sched/pipe' benchmark:
> # Executed 10000 pipe operations between two processes
>
>      Total time: 0.063 [sec]
>
>        6.367500 usecs/op
>          157047 ops/sec
>
>  Performance counter stats for 'taskset -c 0 perf bench sched pipe -l 10000':
>
>             20,004      context-switches
>                  4      cgroup-switches
>
>        0.084191842 seconds time elapsed
>
>        0.008332000 seconds user
>        0.067193000 seconds sys
>
>
> [root@five ~]# perf stat -e context-switches,cgroup-switches taskset -c 0 perf bench sched pipe -l 10000 -G AAA,BBB
> # Running 'sched/pipe' benchmark:
> no access to cgroup /sys/fs/cgroup/BBB
> Failed to open cgroup file in BBB
>  Hint: create the cgroup first, like 'mkdir /sys/fs/cgroup/BBB'
> no access to cgroup /sys/fs/cgroup/AAA
> Failed to open cgroup file in AAA
>  Hint: create the cgroup first, like 'mkdir /sys/fs/cgroup/AAA'
>
>  Performance counter stats for 'taskset -c 0 perf bench sched pipe -l 10000 -G AAA,BBB':
>
>                  2      context-switches
>                  1      cgroup-switches
>
>        0.010356533 seconds time elapsed
>
>        0.003209000 seconds user
>        0.007122000 seconds sys
>
>
> [root@five ~]# vim /tmp/bla
> [root@five ~]#
> [root@five ~]# mkdir /sys/fs/cgroup/BBB /sys/fs/cgroup/AAA
> [root@five ~]# perf stat -e context-switches,cgroup-switches taskset -c 0 perf bench sched pipe -l 10000 -G AAA,BBB
> # Running 'sched/pipe' benchmark:
> # Executed 10000 pipe operations between two processes
>
>      Total time: 0.079 [sec]
>
>        7.987800 usecs/op
>          125190 ops/sec
>
>  Performance counter stats for 'taskset -c 0 perf bench sched pipe -l 10000 -G AAA,BBB':
>
>             20,008      context-switches
>             20,007      cgroup-switches
>
>        0.089361029 seconds time elapsed
>
>        0.009004000 seconds user
>        0.065376000 seconds sys
>
>
> [root@five ~]#
