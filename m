Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AA97941A1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 18:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237591AbjIFQnS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Sep 2023 12:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbjIFQnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:43:17 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A537A1997;
        Wed,  6 Sep 2023 09:43:11 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-792726d3aeeso166957139f.0;
        Wed, 06 Sep 2023 09:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694018591; x=1694623391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fdur3Nxp4iSAbsNGs5pw1u0030rGBz45vpHxbt7j4e4=;
        b=OgOTXeYS/VG52N6PjgrFTm4GkuJc0gabPiRj8bml/povWOdD18QrV0NXCGJ9ZBHJRd
         1CcPgasuP9xqzeuAr+2xJZpf2n+VLTs8Ph0hvi8CKqJe+OoyTy9IRIVXwp/i6r4+TrgP
         k3WG59kMm2NkvR0cGtMl26WdqvGcj51B0agb7nNQM3y26Nc+geJRtb038f9lWUTb2zZb
         ntctYqK/ZL3+MAfU2NlsQGmStFGImxQjDiBFo6tajprSr632JPnzAI9Y0YoCA3VoEupA
         W5iFHVgDLZ8FoqUV/TDvmQJmmm3rwBV0+Lx4tN8a4BKz+hmfDx5lVgPjocp+969jfMxC
         5/dQ==
X-Gm-Message-State: AOJu0YwJ0Ci6pi7ldPQbWzhiIna62/LoOVMGGqs2eaSeZLsJrt2ygVJ4
        UK0UpUA4p8IXoVS2xWf5jyUGYrQzX9oY2iOOKB3UjVRM
X-Google-Smtp-Source: AGHT+IFhzDjwp3J8vlD5TE9XH+TAex8H9QyLYVERxjjZ52pDp1nEDotMOcRPrjS8YLqKgte3ag8nNlPxYqGg5QbHKV8=
X-Received: by 2002:a6b:6f11:0:b0:787:4f3c:730d with SMTP id
 k17-20020a6b6f11000000b007874f3c730dmr19442163ioc.18.1694018590698; Wed, 06
 Sep 2023 09:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230830230126.260508-1-namhyung@kernel.org> <20230830230126.260508-2-namhyung@kernel.org>
 <ZPic6Fegc7PGSvmp@kernel.org> <ZPidlwe2yXEDZB+U@kernel.org>
In-Reply-To: <ZPidlwe2yXEDZB+U@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 6 Sep 2023 09:42:59 -0700
Message-ID: <CAM9d7citcFGPiupaJamb3ujdvZUjzuXkVQ_0iTJzpfEjsu71pw@mail.gmail.com>
Subject: Re: [PATCH 1/5] perf tools: Add read_all_cgroups() and __cgroup_find()
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
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

Hi Arnaldo,

On Wed, Sep 6, 2023 at 8:41 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Wed, Sep 06, 2023 at 12:38:17PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Aug 30, 2023 at 04:01:22PM -0700, Namhyung Kim escreveu:
> > > The read_all_cgroups() is to build a tree of cgroups in the system and
> > > users can look up a cgroup using __cgroup_find().
> >
> > ⬢[acme@toolbox perf-tools-next]$ alias m='make -k BUILD_BPF_SKEL=1 CORESIGHT=1 O=/tmp/build/perf-tools-next -C tools/perf install-bin && git status && perf test python'
> > ⬢[acme@toolbox perf-tools-next]$ m
> > make: Entering directory '/var/home/acme/git/perf-tools-next/tools/perf'
> >   BUILD:   Doing 'make -j32' parallel build
> > Warning: Kernel ABI header differences:
> >   diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event.h
> >   diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h
> >   diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h
> >   diff -u tools/arch/arm64/include/uapi/asm/perf_regs.h arch/arm64/include/uapi/asm/perf_regs.h
> >
> >   INSTALL libsubcmd_headers
> >   INSTALL libperf_headers
> >   INSTALL libapi_headers
> >   INSTALL libsymbol_headers
> >   INSTALL libbpf_headers
> >   CC      /tmp/build/perf-tools-next/builtin-lock.o
> >   CC      /tmp/build/perf-tools-next/util/bpf_lock_contention.o
> > builtin-lock.c: In function ‘__cmd_contention’:
> > builtin-lock.c:2162:9: error: too few arguments to function ‘lock_contention_finish’
> >  2162 |         lock_contention_finish();
> >       |         ^~~~~~~~~~~~~~~~~~~~~~
> > In file included from builtin-lock.c:14:
> > util/lock-contention.h:156:5: note: declared here
> >   156 | int lock_contention_finish(struct lock_contention *con);
> >       |     ^~~~~~~~~~~~~~~~~~~~~~
> > make[3]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:97: /tmp/build/perf-tools-next/builtin-lock.o] Error 1
> > make[3]: *** Waiting for unfinished jobs....
> > util/bpf_lock_contention.c: In function ‘lock_contention_get_name’:
> > util/bpf_lock_contention.c:231:34: error: ‘struct contention_key’ has no member named ‘lock_addr_or_cgroup’
> >   231 |                 u64 cgrp_id = key->lock_addr_or_cgroup;
> >       |                                  ^~
> > make[4]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:97: /tmp/build/perf-tools-next/util/bpf_lock_contention.o] Error 1
> > make[3]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:150: util] Error 2
> > make[2]: *** [Makefile.perf:662: /tmp/build/perf-tools-next/perf-in.o] Error 2
> > make[1]: *** [Makefile.perf:238: sub-make] Error 2
> > make: *** [Makefile:113: install-bin] Error 2
> > make: Leaving directory '/var/home/acme/git/perf-tools-next/tools/perf'
> > ⬢[acme@toolbox perf-tools-next]$
> >
> > Trying to figure this out.
>
> So it works on the following patch:
>
> ⬢[acme@toolbox perf-tools-next]$ git log --oneline -5
> 94a54d498ae35c66 (HEAD) perf lock contention: Add -g/--lock-cgroup option
> defe88978441a00d perf lock contention: Prepare to handle cgroups
> cc0717270d2f0daa perf cgroup: Add read_all_cgroups() and __cgroup_find()
> 752d73a1dd62cd4a perf shell completion: Support completion of metrics/metricgroups
> 72aa5816258bf9fe perf completion: Support completion of libpfm4 events
> ⬢[acme@toolbox perf-tools-next]$
>
> Please check and submit a v2.

Thanks for the report, I'll fix it.

Thanks,
Namhyung
