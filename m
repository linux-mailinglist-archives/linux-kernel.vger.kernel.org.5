Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FF1768A78
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 05:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjGaDxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 23:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjGaDxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 23:53:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048D818D;
        Sun, 30 Jul 2023 20:53:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F95860E8D;
        Mon, 31 Jul 2023 03:53:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED03C433C8;
        Mon, 31 Jul 2023 03:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690775581;
        bh=Y9lgSgz5fjO9KmaWx63oLAt23LyF/pyHoSo8cniMsME=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h/xhvo4F9dornzS8cdSJXF1rL85JfZ/EtzMDO0KpFHrSy8+WqRVz9SBnvFCXrLWRY
         LiNn6LGmQIO89egztL9ybFWm0VTyzoEJ+X2L8jNjFsIGUrJfe4a6TnQj+sInvezkZg
         UhQnRvwthsq/lf+GYWteOybzSoySE7O7HwkuRPCtNZu2iyoAErRdwBwwp327fCTBLZ
         5sJaI+u9NXDwycJJfXWj7zer/EOf65IguwjcpW+wNgaLFvUnksUlqljcEheiYJRfVq
         1PCtOHNuj5JaqZPDzBwyc3RwDNIU9yA/SMJLnba++1sq7sPU+FhpKMVQWEI+BbVq76
         lFKaguqOe9u8Q==
Date:   Mon, 31 Jul 2023 12:52:54 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Ze Gao <zegao2021@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Subject: Re: [RFC PATCH v2 0/3] report task state in symbolic chars from
 sched tracepoint
Message-Id: <20230731125254.b059f0c7f29761d018dedbe8@kernel.org>
In-Reply-To: <20230726121618.19198-1-zegao@tencent.com>
References: <20230726121618.19198-1-zegao@tencent.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2023 20:16:15 +0800
Ze Gao <zegao2021@gmail.com> wrote:

> 
> This is the 2nd attempt to fix the report task state issue in sched
> tracepint, here is the first version:
> 
> https://lore.kernel.org/linux-trace-kernel/20230725072254.32045-1-zegao@tencent.com
> 
> Against v1, add a new var to report task state in symbolic char instead
> of replacing the old one and to not to break anything.
> 
> --
> 
> In the status quo, we should see three different outcomes of the reported
> sched-out task state from perf-script, perf-sched-timehist, and Tp_printk
> of tracepoint sched_switch.  And it's not hard to figure out that the
> former two are built upon the third one, and the reason why we see this
> inconsistency is that the former two does not catch up with the internal
> change of reported task state definitions as the kernel evolves.
> 
> IMHO, exporting internal representations of task state in the tracepoint
> sched_switch is not a good practice and not encouraged at all, which can
> easily break userspace tools that relies on it. Especially when tracepoints
> are massively used in many observability tools nowadays due to its stable
> nature, which makes them no longer used for debug only purpose and we
> should be careful to decide what ought to be reported to userspace and what
> ought not.
> 
> Therefore, to fix the issues mentioned above for good, instead of choosing
> I proposed to add a new variable to report task state in sched_switch with
> a symbolic character along with the old hardcoded value, and save the
> further processing of userspace tools and spare them from knowing
> implementation details in the kernel.
> 
> After this patch seires, we report 'RSDTtXZPI' the same as in procfs, plus
> a 'p' which denotes PREEMP_ACTIVE and is used for sched_switch tracepoint only.

This series looks good to me. Putting the flag in the trace record is
a good idea :)

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

for this series.

Thank you,

> 
> Reviews welcome!
> 
> Regards,
> 
> Ze
> 
> Ze Gao (2):
>   sched, tracing: add to report task state in symbolic chars
>   perf sched: use the new prev_state_char instead in tracepoint
>     sched_switch
> 
>  include/trace/events/sched.h | 60 +++++++++++++++++++++---------------
>  tools/perf/builtin-sched.c   | 57 ++++++----------------------------
>  2 files changed, 45 insertions(+), 72 deletions(-)
> 
> Ze Gao (1):
>   libtraceevent: use the new prev_state_char instead in tracepoint
>     sched_switch
> 
>  plugins/plugin_sched_switch.c | 29 ++++-------------------------
>  1 file changed, 4 insertions(+), 25 deletions(-)
> 
> -- 
> 2.40.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
