Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA0F762321
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjGYURK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGYURI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:17:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADAF2118;
        Tue, 25 Jul 2023 13:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KgbnKQVKozyRRVh5Hy+ZdlwSXnYvtcdueZ7WwcU9Xdw=; b=r9TPHFyS3h8bLc5zSBRg+fO5xh
        H7DPDph8cfJg3Tvu5W/fqGfid8VvholxPTXWMCqbFAs0pOqPWSzoK+SXHfd0x2XUhCTviSrIwRjw7
        C5GWEUf3Jk0n++0DzORPa1P35LcK7U5RXElpJxV5Ti2fYOGA3j/Dwx+fY6JmQU36oxLh678czKQOw
        mjlX8vGTi4TZ9cw9sviWatC2TryJ4ABPYmfZgX71lfE9eEI5bbyjOffLuO29S8BVSs7H3nwesBBJk
        GDcTGMHYLtj7KjUBU8Cg23+VqmPJ7yahLAJaiJ26fu8ojU+wHC9IkiAv8phD/9/GOLyNdAUeJyG7t
        gP/naydw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qOORx-005qN5-Qs; Tue, 25 Jul 2023 20:16:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 772F830049D;
        Tue, 25 Jul 2023 22:16:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 359002B5A0648; Tue, 25 Jul 2023 22:16:03 +0200 (CEST)
Date:   Tue, 25 Jul 2023 22:16:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ze Gao <zegao2021@gmail.com>, Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <20230725201603.GB3784071@hirez.programming.kicks-ass.net>
References: <20230725072254.32045-1-zegao@tencent.com>
 <20230725072254.32045-2-zegao@tencent.com>
 <20230725135938.1e056a02@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725135938.1e056a02@rorschach.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 01:59:38PM -0400, Steven Rostedt wrote:
> > @@ -232,7 +235,7 @@ TRACE_EVENT(sched_switch,
> >  		__array(	char,	prev_comm,	TASK_COMM_LEN	)
> >  		__field(	pid_t,	prev_pid			)
> >  		__field(	int,	prev_prio			)
> > -		__field(	long,	prev_state			)
> > +		__field(	char,	prev_state			)
> >  		__array(	char,	next_comm,	TASK_COMM_LEN	)
> >  		__field(	pid_t,	next_pid			)
> >  		__field(	int,	next_prio			)
> 
> This will break userspace. Just because you update libtraceevent
> doesn't mean that it will get to all the users of it. There's still
> tools that have the old method hard coded and doesn't use the library.
> 
> Now, because the old tools still do the parsing of this format, we can
> add a new field called prev_state_char that will give you this. Now to
> save space, we should change prev_state to int (can't make it short as
> there's that test for "+" which does sometimes happen). I believe we
> can make prev_prio and next prio into shorts (and possibly chars!).

Or just leave the thing alone?
