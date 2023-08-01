Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A1376B78B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbjHAOdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjHAOdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:33:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D245AE5C;
        Tue,  1 Aug 2023 07:33:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CE10615C9;
        Tue,  1 Aug 2023 14:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F9AC433C8;
        Tue,  1 Aug 2023 14:33:42 +0000 (UTC)
Date:   Tue, 1 Aug 2023 10:33:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ze Gao <zegao2021@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Subject: Re: [RFC PATCH v3 4/6] sched, tracing: reorganize fields of switch
 event struct
Message-ID: <20230801103340.5dfa7133@gandalf.local.home>
In-Reply-To: <20230801114650.GE79828@hirez.programming.kicks-ass.net>
References: <20230801090124.8050-1-zegao@tencent.com>
        <20230801090124.8050-5-zegao@tencent.com>
        <20230801114650.GE79828@hirez.programming.kicks-ass.net>
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

On Tue, 1 Aug 2023 13:46:50 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Aug 01, 2023 at 05:01:22PM +0800, Ze Gao wrote:
> > Report priorities in 'short' and prev_state in 'int' to save
> > some buffer space. And also reorder the fields so that we take
> > struct alignment into consideration to make the record compact.
> > 
> > Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>  
> 
> I don't see a single line describing the effort you've done to audit
> consumers of this tracepoint.
> 
> *IF* you're wanting to break this tracepoint ABI, because seriously
> that's what it is, then you get to invest the time and effort to audit
> the users.

The known major users that I am aware of is raesdaemon,
powertop/latencytop, perf, trace-cmd and some bpf tools. The bpf tooling is
known to update per kernel. The others all use libtraceevent that can
handle this change.

What other tools are there? There's Perfetto, but it also looks at tracefs
to examine where the values are. There's LTTng, but I believe it uses the
raw tracepoint directly and doesn't look at the layout of the ftrace/perf
buffers.

All other tooling I am slightly aware of uses libtracefs and libtraceveent,
as I've been giving many talks on how to use those libraries.

-- Steve
