Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF5476E4F8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbjHCJwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbjHCJwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:52:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4353598;
        Thu,  3 Aug 2023 02:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qU8YEraO1AZOCSwuw27i3Y0ODQiAYGXh13HQoLBIsog=; b=BypKVbFo8h+COLtwnZ8ZtOTAvf
        QpAkA5IB3tGo1sxQ/nQwWiSEp5tZteJsHWh/6NUpCvitGx1t+apHS48BUqI2gG6/k8gXggyj7HriI
        pI4MkyEBHXGZIg+I/lYgECmu5b86GwUOyfHmBJc4Y/O7TaMl3x3TZPobcb/rQtvCNb3mGt3qjriNx
        lRKg3ZQ3ntq2FRgrbwd/Sxo2RuCJqnfVJ/r2KtFgKTWIgvyihLzAeU9fyLaWlRd1AlWKUH/xqAmbb
        8gP1dRwIz44Qjyy8VmTNdW8RA2UIPVhh3yxp/wFu4tOvhpf5V70xQGoelw4wmoEuh75td2CGlOHxt
        EuOrmcJg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRUzW-002vWx-FC; Thu, 03 Aug 2023 09:51:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 195AC3001DD;
        Thu,  3 Aug 2023 11:51:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D05D1203719D9; Thu,  3 Aug 2023 11:51:32 +0200 (CEST)
Date:   Thu, 3 Aug 2023 11:51:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
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
        linux-trace-kernel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Subject: Re: [RFC PATCH v6 3/5] sched, tracing: reorganize fields of switch
 event struct
Message-ID: <20230803095132.GI212435@hirez.programming.kicks-ass.net>
References: <20230803083352.1585-1-zegao@tencent.com>
 <20230803083352.1585-4-zegao@tencent.com>
 <20230803051826.25ba7973@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803051826.25ba7973@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 05:18:26AM -0400, Steven Rostedt wrote:
> On Thu,  3 Aug 2023 04:33:50 -0400
> Ze Gao <zegao2021@gmail.com> wrote:
> 
> > Report prioritiy and prev_state in 'short' to save some buffer
> > space. And also reorder the fields so that we take struct
> > alignment into consideration to make the record compact.
> 
> If I were to write this, I would have wrote:
> 
>   The prev_state field in the sched_switch event is assigned by
>   __trace_sched_switch_state(). The largest number that function will return
>   is TASK_REPORT_MAX which is just 0x100. There's no reason that the
>   prev_state field is a full 32 bits when it is using just 9 bits max. In
>   order to save space on the ring buffer, shrink the prev_state to 16 bits
>   (short).
> 
>   Also, change the positions of the other fields to accommodate the short
>   value of prev_state to eliminate any holes that were created in the
>   structure.
> 
> See the difference?

This also doesn't mention you broke the data format for all trace events
a while back to ensure people are using libtracefs and are thus
confident this won't break things.
