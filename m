Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DCE75A21E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjGSWmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjGSWmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:42:07 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4118C1FF3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 15:42:06 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-3460770afe2so29015ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 15:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689806525; x=1692398525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BU75HP7ou8V17HR9NjRcbCm0e51n/tpfKu20LZ2/p24=;
        b=LvIcf6ni0oT8cAiEW9c/9QiG1mp+afngoiHVfpjBDP6v5tEHNFRWpHnGKBzZPDXSyv
         JzzEygMwHi97xjFVo35EU0t2Zqf9DNkmBWLEXM29UcwkrJvOST/UPnRtw7BLaAO54Qfi
         U0a3YMW70kPigTCc0+Z4KXpR+Sz8VWThkblZniPG6dLE93Wuf9E8hz+zhp2+ZlDOrHr2
         /ModFLSh55Fek60iBmNqm8jdYMby6LYCYuccO3Rxth9FrTyVpeG+nWVcEMyDlERwHzGe
         RAxdbg3KNgXUHBlsFoDtTzCAO/fSyEyWvRECMmaXRxwd63JhZAHRnm8jzYFhxvTjgiNi
         /Gcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689806525; x=1692398525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BU75HP7ou8V17HR9NjRcbCm0e51n/tpfKu20LZ2/p24=;
        b=bp4uIG4py9k39PuPcnt+WoZSRvoEan052QHwMn5LMn1oAM1irReaUPjlPhyeXuRc1l
         Ik+9GdftGngk6omYtzuSR0un12mflkgqC2Rq9gutGESR9O8h2mVOVQG4nCLy/MvM0BOu
         9B0JjJQQRr+0qEQShNwG4cbsdGLUW3Thlm5gRXAW0LtWCYpc+0hDfEt0sKJcZNgQEtdI
         1tGJpleziaSvPVnGylbotEcOtoHv4tjUKjUGsG04QPyPOA/VH54pGJXBbifIGQxIJpT8
         Z9MrhDSQIiZ6qgeF/35Ht6DnYa2qnSixxqwl/l+bq/lBatGLpT9zc2zgFQIWKZMs0vo/
         wIoA==
X-Gm-Message-State: ABy/qLbbbhbXg0TnZ3z6nwnE7zn6xVINLcQfUISKNr96eCcZP7A/9pGD
        TEy6Iz57z2yzETzLTo7pyONmH6wCW1gQoQVlpacHOQ==
X-Google-Smtp-Source: APBJJlGyQN7MKJ33nEYVGGc4luvKaEpoaQS/fi6LzKc2RtEHVenhRvaJ0N0KOCnCGmRzJ1fjesHGoyY6NhT6Jtt9Iwg=
X-Received: by 2002:a05:6e02:b42:b0:346:676f:3517 with SMTP id
 f2-20020a056e020b4200b00346676f3517mr43100ilu.11.1689806525595; Wed, 19 Jul
 2023 15:42:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230719204910.539044-1-acme@kernel.org>
In-Reply-To: <20230719204910.539044-1-acme@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 19 Jul 2023 15:41:54 -0700
Message-ID: <CAP-5=fVF6yE-Lo3xpqLz7ZyZ6sXzPvDTij6BcrYzjvMTEi+jRg@mail.gmail.com>
Subject: Re: [PATCHES/RFC 1/5] perf bench uprobe + BPF skel
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 1:49=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Hi,
>
>         This adds a 'perf bench' to test the overhead of uprobes + BPF
> programs, for now just a few simple tests, but I plan to make it
> possible to specify the functions to attach the uprobe + BPF, other BPF
> operations dealing with maps, etc.
>
>         This is how it looks like now:
>
>   [root@five ~]# perf bench uprobe all
>   # Running uprobe/baseline benchmark...
>   # Executed 1,000 usleep(1000) calls
>        Total time: 1,053,963 usecs
>
>    1,053.963 usecs/op
>
>   # Running uprobe/empty benchmark...
>   # Executed 1,000 usleep(1000) calls
>        Total time: 1,056,293 usecs +2,330 to baseline
>
>    1,056.293 usecs/op 2.330 usecs/op to baseline
>
>   # Running uprobe/trace_printk benchmark...
>   # Executed 1,000 usleep(1000) calls
>        Total time: 1,056,977 usecs +3,014 to baseline +684 to previous
>
>    1,056.977 usecs/op 3.014 usecs/op to baseline 0.684 usecs/op to previo=
us
>
>   [root@five ~]
>
> I put it here:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?=
h=3Dperf-bench-uprobe
>
>   git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf-bench-uprob=
e
>
> Further ideas, problems?

No problems. Perhaps it would be interesting to measure the uprobe
overhead compared to say the overhead attaching to the nanosleep
syscall?

Thanks,
Ian

> - Arnaldo
>
>
>
> Arnaldo Carvalho de Melo (5):
>   perf bench uprobe: Add benchmark to test uprobe overhead
>   perf bench uprobe: Print diff to baseline
>   perf bench uprobe: Show diff to previous
>   perf bench uprobe empty: Add entry attaching an empty BPF program
>   perf bench uprobe trace_printk: Add entry attaching an BPF program that=
 does a trace_printk
>
>  tools/perf/Documentation/perf-bench.txt     |   3 +
>  tools/perf/Makefile.perf                    |   1 +
>  tools/perf/bench/Build                      |   1 +
>  tools/perf/bench/bench.h                    |   3 +
>  tools/perf/bench/uprobe.c                   | 198 ++++++++++++++++++++
>  tools/perf/builtin-bench.c                  |   8 +
>  tools/perf/util/bpf_skel/bench_uprobe.bpf.c |  23 +++
>  7 files changed, 237 insertions(+)
>  create mode 100644 tools/perf/bench/uprobe.c
>  create mode 100644 tools/perf/util/bpf_skel/bench_uprobe.bpf.c
>
> --
> 2.41.0
>
