Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000D47691E7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjGaJiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjGaJh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:37:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B2910D;
        Mon, 31 Jul 2023 02:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t2+TzLb7sWKIP1es6o89LAr2hjHeBB9vBotRjORzxp8=; b=Xx3N1Yerc4trPakPXJjx9xoHgB
        LK6y2tw/YWytSFaJC2Wde5BfJJhzJQvHD2P257W+7+BEhOcNMBNIeudVvNUbEhRfehVSVKpxBYXqS
        dIFIEnleYdnGJYqxXyLZhX3L0Fxs6oAGMjvLdYg8SeeezzxYjOS1Za6Qsg9nwHTvcFttcz47l+AOv
        ZdP5JkJEykPzCWwS+6boiIDyLuXdDxc/wVxNiv8lD2LnA9/Htr94YF7rmHeZ0WH8LNLfMmAgX3t/6
        O6UTvKd4yz5zK22CWCKerIOQPVgNnlDlgSPfMkTFnurkJIO+TDBaJdCQYZ2mkayaCLZS3pUnlpVab
        ytlmSiFg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qQPKi-000uM6-FO; Mon, 31 Jul 2023 09:36:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 80F363001DD;
        Mon, 31 Jul 2023 11:36:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D1A220238A9A; Mon, 31 Jul 2023 11:36:55 +0200 (CEST)
Date:   Mon, 31 Jul 2023 11:36:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ze Gao <zegao2021@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Subject: Re: [RFC PATCH v2 1/3] sched, tracing: add to report task state in
 symbolic chars
Message-ID: <20230731093655.GC29590@hirez.programming.kicks-ass.net>
References: <20230726121618.19198-1-zegao@tencent.com>
 <20230726121618.19198-2-zegao@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726121618.19198-2-zegao@tencent.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 08:16:16PM +0800, Ze Gao wrote:
> Internal representations of task state are likely to be changed or
> ordered, and reporting them to userspace without exporting them as
> part of API is not a good choice, which can easily break a userspace
> observability tool as kernel evolves. For example, perf suffers from
> this and still reports wrong states by this patch.
> 
> OTOH, some masqueraded state like TASK_REPORT_IDLE and TASK_REPORT_MAX
> are also reported inadvertently, which confuses things even more.
> 
> So add a new variable in company with the old raw value to report task
> state in symbolic char, which is self-explaining and no further
> translation is needed, and also report priorities in 'short' to save
> some buffer space.  Of course this does not break any userspace tool.
> 
> Note for PREEMPT_ACTIVE, we introduce 'p' to report it and use the old
> conventions for the rest.

So I really dont much like this. This looses the ability to see the
actual wait state flags, there could be multiple. Eg, things like
TASK_FREEZEABLE gets lost completely.

And this is on top of my reluctance to touch any of this at all, for
fear of further regressions.
