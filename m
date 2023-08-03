Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609D176DE83
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 04:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjHCCs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 22:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbjHCCs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 22:48:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1387D198B;
        Wed,  2 Aug 2023 19:48:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5A4361BBD;
        Thu,  3 Aug 2023 02:48:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50875C433C8;
        Thu,  3 Aug 2023 02:48:51 +0000 (UTC)
Date:   Wed, 2 Aug 2023 22:48:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ze Gao <zegao2021@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Subject: Re: [RFC PATCH v4 5/7] sched, tracing: add to report task state in
 symbolic chars
Message-ID: <20230802224849.215b96b0@gandalf.local.home>
In-Reply-To: <CAD8CoPDUkUOc8_p8Ygnoy6xfQZtPhiDDPgnhTMfoEtmrQFRwMw@mail.gmail.com>
References: <20230802121116.324604-1-zegao@tencent.com>
        <20230802121116.324604-6-zegao@tencent.com>
        <20230802110701.5227346d@gandalf.local.home>
        <CAD8CoPDUkUOc8_p8Ygnoy6xfQZtPhiDDPgnhTMfoEtmrQFRwMw@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2023 10:38:43 +0800
Ze Gao <zegao2021@gmail.com> wrote:

> > > +static inline char __trace_sched_switch_state_char(bool preempt,
> > > +                                                unsigned int prev_state,
> > > +                                                struct task_struct *p)
> > > +{
> > > +     long state;
> > > +
> > > +#ifdef CONFIG_SCHED_DEBUG
> > > +     BUG_ON(p != current);  
> >
> > BUG? Why not WARN_ON()?  
> 
> I directly copied it from __trace_sched_switch_state since they
> are very similar. I had doubt on this too but decided to keep it in
> case people want to be 100% sure that the current task is exactly
> the one that is being switched, otherwise it's a fatal problem for
> scheduler at the point where trace_sched_switch is called.
> 
> If you think WARN_ON_ONCE is more appropriate, I can fix both
> in v6.
> 
> Thoughts?

Yeah, that BUG_ON is from 2014, and really should not BUG.

I'd fix both.

Thanks!

-- Steve
