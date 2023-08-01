Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A7176B357
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbjHALeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbjHALed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:34:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38536D3;
        Tue,  1 Aug 2023 04:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m1F9HPkA3rCfG5++ie5WawGo0UTj2vVNhV/5rI+7dho=; b=mB9lQRj8ne7QFWU/SvSHLBtwb6
        h8xkNxWTv4f5uznh/z9xyszKEHyfllEKko5I05DM439vdurXjN3Ng5UlhclOvPdYJlzKN75ic1PuZ
        MkQx7FVcynX8dz8FJWvDGDtTmTY6w2TLbbQbh1NXLy0plifn86o+u0GEsiobPMM55N+aULATCl7o5
        IdlMhHYGS/bCJUhVDMRtgJ0e44vX5wwj0q4PNb9Z8iad4ngKUWtCkhUbkQ5tg+F1QUWm/fiUrNvg3
        EPHixlaFooaWC4Zv49H6rXFD2n+pHXC40U/U929HsM7rOoe7LlXEaVvwd+4uv5LM1aBGZQGY/RYTp
        2VqoqZEA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qQndb-008R8A-MR; Tue, 01 Aug 2023 11:34:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3184E300134;
        Tue,  1 Aug 2023 13:34:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EDD41200C570F; Tue,  1 Aug 2023 13:34:01 +0200 (CEST)
Date:   Tue, 1 Aug 2023 13:34:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ze Gao <zegao2021@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Subject: Re: [RFC PATCH v3 3/6] sched, tracing: add to report task state in
 symbolic chars
Message-ID: <20230801113401.GC79828@hirez.programming.kicks-ass.net>
References: <20230801090124.8050-1-zegao@tencent.com>
 <20230801090124.8050-4-zegao@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801090124.8050-4-zegao@tencent.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 05:01:21PM +0800, Ze Gao wrote:
> Internal representations of task state are likely to be changed
> or ordered, and reporting them to userspace without exporting
> them as part of API is basically wrong, which can easily break
> a userspace observability tool as kernel evolves. For example,
> perf suffers from this and still reports wrong states as of this
> writing.
> 
> OTOH, some masqueraded states like TASK_REPORT_IDLE and
> TASK_REPORT_MAX are also reported inadvertently, which confuses
> things even more and most userspace tools do not even take them
> into consideration.
> 
> So add a new variable in company with the old raw value to
> report task state in symbolic chars, which are self-explaining
> and no further translation is needed. Of course this does not
> break any userspace tool.
> 
> Note for PREEMPT_ACTIVE, we introduce 'p' to report it and use
> the old conventions for the rest.

*sigh*... just because userspace if daft, we need to change the kernel?

Why do we need this character anyway, why not just print the state in
hex and leave it at that? These single character state things are a
relic, please just let them die.
