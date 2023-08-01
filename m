Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF38676B3AF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbjHALqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbjHALqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:46:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA0B11A;
        Tue,  1 Aug 2023 04:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ziNPMPkgZbjnyw4o3Yiy+e5PXDvLaLqinVQyax6y4tI=; b=gCImosHCb8eTt1d5VbBVrSEbjF
        lbZzqpVBYMsdBzCyD77NVrvxMXcJIaL8itHlGapNPvFdOuFeZFzYM6/Hum6o/066Uq1f8Y7srvEop
        rB/Uz92QRwN1dksks2Nlbh2I1VNfFSYzSXzC2/8NkovxsLlGsSigvpFqM0SIjsZ7sOIN/inVOQKyC
        DU6prbfAbdLwmkCgSppxuhcAQWq26kFUWVb4uh1vEe4eZM2SI4fvSSvuGEVHhASpl3Uay/ACizKQK
        SotJp4vOhbmL4q17rZ3V080h3RnYkLzMqnXCEd/QGTx2nNCGN6w2/jv7Vs7210lharyFk5ee7wj+C
        gYylc0oQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQnow-00EdeF-0n;
        Tue, 01 Aug 2023 11:45:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3DF3B300134;
        Tue,  1 Aug 2023 13:45:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 20D71200C570F; Tue,  1 Aug 2023 13:45:45 +0200 (CEST)
Date:   Tue, 1 Aug 2023 13:45:45 +0200
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
Message-ID: <20230801114545.GD79828@hirez.programming.kicks-ass.net>
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
> @@ -233,6 +255,7 @@ TRACE_EVENT(sched_switch,
>  		__field(	pid_t,	prev_pid			)
>  		__field(	int,	prev_prio			)
>  		__field(	long,	prev_state			)
> +		__field(	char,	prev_state_char			)
>  		__array(	char,	next_comm,	TASK_COMM_LEN	)
>  		__field(	pid_t,	next_pid			)
>  		__field(	int,	next_prio			)

And this again will wreck everybody that consumes the raw tracepoint
without looking at tracefs.
