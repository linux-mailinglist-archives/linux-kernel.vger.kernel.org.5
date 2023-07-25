Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C930761A00
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjGYNcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjGYNcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:32:14 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062811BC2;
        Tue, 25 Jul 2023 06:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cJS9hWdS3WIM11d6kg/J2cpVY/K0AghRcBxdtWBel3E=; b=fu+uGT2qcg8H3XiKFVWP5UKtUq
        lKTdMja9KLM/RBM3EcVilsF1p6x9bJYZyEu8mCJq15cab7zWZYLSH8YhSJkaxEU9CifjHcmYyyEZO
        Cf53hw9g1ptZIAbpS3kVqcJxy5W6LlO+BIHvpK8CEjL57HhwzJxe5xBN1J5V/aFKGzgONGBUkldOd
        ahHKi1y7acZIY4uAlNt/Kf784xjSInYAkfOjQ8OgNI//f0XwDKkMx9yjgysj7/lfDfPTogfHM5+tA
        NdyAbLHorlLqctEgX4rPYQT901Yl7uMHDgFYn16OELr/frraKQpiR1ToCCuHV5//3Y8ce15wO9r5E
        OJZUQz4Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qOI7x-004A0r-0c;
        Tue, 25 Jul 2023 13:31:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 42AC4300095;
        Tue, 25 Jul 2023 15:31:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 265B52CCD6AC0; Tue, 25 Jul 2023 15:31:00 +0200 (CEST)
Date:   Tue, 25 Jul 2023 15:31:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ze Gao <zegao2021@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Subject: Re: [RFC PATCH 1/3] sched, tracing: report task state in symbolic
 chars instead
Message-ID: <20230725133100.GL3765278@hirez.programming.kicks-ass.net>
References: <20230725072254.32045-1-zegao@tencent.com>
 <20230725072254.32045-2-zegao@tencent.com>
 <20230725083357.GA3765278@hirez.programming.kicks-ass.net>
 <CAD8CoPAdRUxk3FWdNX6g0V6Kdr3+sXv8fdQ9NhgKUR29-ZLaug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD8CoPAdRUxk3FWdNX6g0V6Kdr3+sXv8fdQ9NhgKUR29-ZLaug@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 06:53:07PM +0800, Ze Gao wrote:

> > > @@ -232,7 +235,7 @@ TRACE_EVENT(sched_switch,
> > >               __array(        char,   prev_comm,      TASK_COMM_LEN   )
> > >               __field(        pid_t,  prev_pid                        )
> > >               __field(        int,    prev_prio                       )
> > > -             __field(        long,   prev_state                      )
> > > +             __field(        char,   prev_state                      )
> > >               __array(        char,   next_comm,      TASK_COMM_LEN   )
> > >               __field(        pid_t,  next_pid                        )
> > >               __field(        int,    next_prio                       )
> >
> > This is a format change and will likely break a ton of programs :/
> 

> BTW, could you help to point to any possible tools/programs that would
> break other than perf/libtraceevent, because these two are the only
> users I run into so far.

Latencytop was the one breaking a few years ago, but there's a metric
ton of sched_switch users out there, this is bound to generate pain.

Steve, you remember what the status of all this was? at the time
breaking this was considered on par with ABI breakage and we reverted or
something. Is this still so?
