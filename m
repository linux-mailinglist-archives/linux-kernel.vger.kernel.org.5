Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FDF7CB569
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 23:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbjJPVoj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Oct 2023 17:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPVoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 17:44:37 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD390A2;
        Mon, 16 Oct 2023 14:44:35 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1c8a1541233so30643775ad.1;
        Mon, 16 Oct 2023 14:44:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697492675; x=1698097475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kkk29UbbJeUjUEXsSEVlDZ83lbWXtvn6d+sY/zRkICE=;
        b=seWmexfd9jD8lkjDGAqawgWowiaSP5pMOmMMW9jllI5tX3sUfMizGeYo8z1CaiGgJl
         7PYHFXGZf2M8a3vAaCsGPHbvNwuLH2eHPIDalWmq71HHmSrZOf5poVzqBVM98ULeopjQ
         bXgBdBDyG7777n8lRJC8/fB0RrZcoDdRFcn9SEJgc5zJuEJXvlYuvkQrclIleVjfWIvb
         C9ATomiogHrbdl/ZIVLSPDMmZ/+LoraszpIP/U5t2qCXoiBvhvenTs0Um8dxdlaiMXKy
         RskCscEbcSVKsJPfNITJZ86XKKaG3cOZyMINqeP4CB2Gx7Pq6y1llli3txaGNGKMnTXE
         CE+Q==
X-Gm-Message-State: AOJu0YyFsCX6scFJVzO5tcclDK8qpSPhJCV8FVw+oa74hbBqWSsBd+Br
        1xaYeS/ykR6LscKCUGKujs6Vxme6cU691awjAtFzgIxG
X-Google-Smtp-Source: AGHT+IGVDa+CMvtgz/wOO8igO9aVN+x+RmbkSp16F4uJ22IEvImd62LPJ/WcyH023P6S3uqu8jcHWSVCl5azFcMQZZw=
X-Received: by 2002:a17:90a:58:b0:27d:b22b:fb89 with SMTP id
 24-20020a17090a005800b0027db22bfb89mr320452pjb.35.1697492675213; Mon, 16 Oct
 2023 14:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231016044225.1125674-1-namhyung@kernel.org> <ZS0D53ckVx356k4o@gmail.com>
 <ZS1Y5PhXhp384ynY@kernel.org> <ZS1ajf/9HmgUyyCl@kernel.org>
 <ZS1cGMgyEDJQbwq9@kernel.org> <ZS1c9RCh9MkzPbFG@kernel.org> <ZS2ecyCVpK8B2cQq@kernel.org>
In-Reply-To: <ZS2ecyCVpK8B2cQq@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 16 Oct 2023 14:44:23 -0700
Message-ID: <CAM9d7cjH+c30MChKyOpMNB6-k6Vy4F4ZbB1Eih0Dk5tgXP8mEg@mail.gmail.com>
Subject: Re: [PATCH v3] perf bench sched pipe: Add -G/--cgroups option
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 1:35 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Oct 16, 2023 at 12:55:33PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, Oct 16, 2023 at 12:51:52PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Now back at testing with with cgroups.
>
> > Humm, even without the -G I get:
>
> > [root@five ~]# perf stat -e context-switches,cgroup-switches perf bench sched pipe  -l 10000
> > # Running 'sched/pipe' benchmark:
> > # Executed 10000 pipe operations between two processes
>
> >      Total time: 0.082 [sec]
>
> >        8.246400 usecs/op
> >          121265 ops/sec
>
> >  Performance counter stats for 'perf bench sched pipe -l 10000':
>
> >             20,002      context-switches
> >             20,002      cgroup-switches
>
> Same number, but then I forgot to add the 'taskset -c 0' part of the
> command line, if I have it:
>
> [root@five ~]# perf stat -e context-switches,cgroup-switches taskset -c 0 perf bench sched pipe -l 10000
> # Running 'sched/pipe' benchmark:
> # Executed 10000 pipe operations between two processes
>
>      Total time: 0.072 [sec]
>
>        7.231500 usecs/op
>          138283 ops/sec
>
>  Performance counter stats for 'taskset -c 0 perf bench sched pipe -l 10000':
>
>             20,002      context-switches
>                  3      cgroup-switches
>
>        0.082855113 seconds time elapsed
>
>        0.007765000 seconds user
>        0.074020000 seconds sys
>
>
> [root@five ~]# perf stat -e context-switches,cgroup-switches taskset -c 0 perf bench sched pipe -l 10000 -G AAA,BBB
> # Running 'sched/pipe' benchmark:
> # Executed 10000 pipe operations between two processes
>
>      Total time: 0.093 [sec]
>
>        9.341800 usecs/op
>          107045 ops/sec
>
>  Performance counter stats for 'taskset -c 0 perf bench sched pipe -l 10000 -G AAA,BBB':
>
>             20,004      context-switches
>             20,003      cgroup-switches
>
>        0.103436330 seconds time elapsed
>
>        0.018109000 seconds user
>        0.063058000 seconds sys
>
>
> [root@five ~]#
>
> I.e. it works as in your results, but can you please spell out why that
> 'taskset -c 0' is needed to get these results?
>
> I wasn't expecting the same number of cgroup-switches when not using
> 'taskset -c 0' :-\

Without taskset, each task is likely to run on different CPUs
and other tasks (including idle) on that CPU would be in
different cgroup so it'll create cgroup switches everytime
if they run in AAA or BBB.

With taskset, both sender and receiver would run on the
same CPU.  So it'd see the impact of cgroup switches
with this option.

Thanks,
Namhyung
