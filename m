Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958B57742F0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjHHRwZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 8 Aug 2023 13:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbjHHRvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:51:20 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD39B5E9E;
        Tue,  8 Aug 2023 09:23:02 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2685102cd16so3152495a91.1;
        Tue, 08 Aug 2023 09:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511466; x=1692116266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RyjB3DvpLyVB9YtJshIE8bO28uWsWCZqV/6QNano1sw=;
        b=dVsdXUTbeBJhdpOPqX7FV5I2HBtH8Mspj68hHJykcAjQT6FCVxAdkiBs5Ci09D5slA
         pM+9TO+zPFx0zpw02NwiS+REi8T+0RHIaKHCbxkLS6ozPqt9j/Vp7VI3StMMTnGeiKaa
         KY52BZxZYex8Gf9hDf82QNR6PwQ9gq5S41WK1nUW/kAwG9Ka54mwN3tyiL0mQWaKygvu
         9uqeTtGCy+zksk6zAatklEnpiEcGfVPQmg87bow8BkGdMulz9MBTj2OISdWg3rcGMLJQ
         LHhZTnvgjscFattF2VYvMgwDtXrRRTnBgumj83fIMSgjcIKRIBHM9Zf5LJtSLg9j7+sQ
         G1Xw==
X-Gm-Message-State: AOJu0YxN2RNPgDpx1g5jhmSq0opPREuv5GMflmED+oIP8ZmpxFLgqeTw
        eJfrXHaUwDtg0gKbCDPRJRmmdIYyzLQ0lU68bY5mIT0r
X-Google-Smtp-Source: AGHT+IGFRlO9HZz8hqaNZFctAw+1vM5NyR8+o4mQXAik7MBydyIDbym6M/65lcwHG2hwaPvChr24c8mpWMyd9xPewSA=
X-Received: by 2002:a25:d0d1:0:b0:d4f:7f64:df19 with SMTP id
 h200-20020a25d0d1000000b00d4f7f64df19mr5934415ybg.14.1691502577549; Tue, 08
 Aug 2023 06:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <CABWYdi2MwP1u5V+RCpvSjqazo7rS9h_oZoJN6o0UoWFdSQNOyQ@mail.gmail.com>
 <ZNJGunGxqspEB5iC@kernel.org>
In-Reply-To: <ZNJGunGxqspEB5iC@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 8 Aug 2023 22:49:26 +0900
Message-ID: <CAM9d7chFqkYKESsHhSfipV6hGcRtDn+CtLcUOnLjzhQmfZotMg@mail.gmail.com>
Subject: Re: [PATCH] perf script: print cgroup on the same line as comm
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ivan Babrou <ivan@cloudflare.com>, Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, kernel-team@cloudflare.com,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Sorry for the late reply.

On Tue, Aug 8, 2023 at 10:44 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Aug 07, 2023 at 11:02:01AM -0700, Ivan Babrou escreveu:
> > On Fri, Jul 28, 2023 at 10:57 AM Ian Rogers <irogers@google.com> wrote:
> > > On Fri, Jul 28, 2023 at 10:42 AM Ivan Babrou <ivan@cloudflare.com> wrote:
> > > > On Mon, Jul 17, 2023 at 5:07 PM Ivan Babrou <ivan@cloudflare.com> wrote:
> > > > > Commit 3fd7a168bf51 ("perf script: Add 'cgroup' field for output")
> > > > > added support for printing cgroup path in perf script output.
>
> > > > > It was okay if you didn't want any stacks:
>
> > > > >     $ sudo perf script --comms jpegtran:23f4bf -F comm,tid,cpu,time,cgroup
> > > > >     jpegtran:23f4bf 3321915 [013] 404718.587488:  /idle.slice/polish.service
> > > > >     jpegtran:23f4bf 3321915 [031] 404718.592073:  /idle.slice/polish.service
>
> > > > > With stacks it gets messier as cgroup is printed after the stack:
>
> > > > >     $ perf script --comms jpegtran:23f4bf -F comm,tid,cpu,time,cgroup,ip,sym
> > > > >     jpegtran:23f4bf 3321915 [013] 404718.587488:
> > > > >                     5c554 compress_output
> > > > >                     570d9 jpeg_finish_compress
> > > > >                     3476e jpegtran_main
> > > > >                     330ee jpegtran::main
> > > > >                     326e2 core::ops::function::FnOnce::call_once (inlined)
> > > > >                     326e2 std::sys_common::backtrace::__rust_begin_short_backtrace
> > > > >     /idle.slice/polish.service
> > > > >     jpegtran:23f4bf 3321915 [031] 404718.592073:
> > > > >                     8474d jsimd_encode_mcu_AC_first_prepare_sse2.PADDING
> > > > >                 55af68e62fff [unknown]
> > > > >     /idle.slice/polish.service
> > > > >
> > > > > Let's instead print cgroup on the same line as comm:
> > > > >
> > > > >     $ perf script --comms jpegtran:23f4bf -F comm,tid,cpu,time,cgroup,ip,sym
> > > > >     jpegtran:23f4bf 3321915 [013] 404718.587488:  /idle.slice/polish.service
> > > > >                     5c554 compress_output
> > > > >                     570d9 jpeg_finish_compress
> > > > >                     3476e jpegtran_main
> > > > >                     330ee jpegtran::main
> > > > >                     326e2 core::ops::function::FnOnce::call_once (inlined)
> > > > >                     326e2 std::sys_common::backtrace::__rust_begin_short_backtrace
> > > > >
> > > > >     jpegtran:23f4bf 3321915 [031] 404718.592073:  /idle.slice/polish.service
> > > > >                     8474d jsimd_encode_mcu_AC_first_prepare_sse2.PADDING
> > > > >                 55af68e62fff [unknown]
> > > > >
> > > > > Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
> > > > > Fixes: 3fd7a168bf51 ("perf script: Add 'cgroup' field for output")
>
> > > This change makes sense to me. Namhyung, wdyt?
>
> > Hi Namhyung,
> >
> > This is a really trivial patch and it would be good to get a word from you.
>
> Hi, this solves the case for cgroup and I think it should be merged, but
> what about the other fields that are being printed after the callchain
> gets printed?
>
> I looked and we would have to introduce a __sample__fprintf_sym that
> didn't call sample__fprintf_callchain and use it in perf script's
> process_event() then later call sample__fprintf_callchain after all the
> fields that print on the same line.
>
> Anyway, Namhyung, can I have your Acked-by for this patch to move things
> forward at least for cgroups?

I'm ok with the change itself.  But I'm afraid other fields might be
changed too.  Anyway,

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
