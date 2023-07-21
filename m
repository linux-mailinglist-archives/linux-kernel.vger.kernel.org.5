Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B393675CA10
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 16:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjGUOc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 10:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjGUOc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 10:32:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F892D56;
        Fri, 21 Jul 2023 07:32:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 588A761B27;
        Fri, 21 Jul 2023 14:32:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBCCC433C8;
        Fri, 21 Jul 2023 14:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689949944;
        bh=I+Szsk39PJsQ9rBjntkMFEeaQ2Uou8mYStFXkpPodnQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t8c62hEL00dKY9g1WQo6gimsW3dDBw7KmddXLWbL/3YIY9UWNQcBrcuOlBQk0Q886
         xZl/m9G96MNUZlEt15j5QmX+ENAkl7+AcXD8Zwhc6L8lAAMyWoYNA15jWVaMnuwzGu
         /e2O2InmcgM9I3bC7BVKFUPkl4C8IYFpRV0gi2oniXBUmfGebKu/vZsvOs0KYltM8i
         h/SFtEbgrYP5/9iZhvoTynjsPOjJllrc7qvw6zcj4tQ/RgspFvVloDFhP93D3nEnHi
         X75rAfyWCANdP4V3u4d+Mll7vFrQllJO5PN+uVR0PDNZ9W5bV7aO7bHGcVSsg+LWUY
         u8eKLqKF1ZvLg==
Date:   Fri, 21 Jul 2023 23:32:19 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCHES/RFC 1/5] perf bench uprobe + BPF skel
Message-Id: <20230721233219.9105d8e48d67e5eda3797e4e@kernel.org>
In-Reply-To: <20230719204910.539044-1-acme@kernel.org>
References: <20230719204910.539044-1-acme@kernel.org>
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

On Wed, 19 Jul 2023 17:49:05 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi,
> 
> 	This adds a 'perf bench' to test the overhead of uprobes + BPF
> programs, for now just a few simple tests, but I plan to make it
> possible to specify the functions to attach the uprobe + BPF, other BPF
> operations dealing with maps, etc.
> 
> 	This is how it looks like now:
> 
>   [root@five ~]# perf bench uprobe all
>   # Running uprobe/baseline benchmark...
>   # Executed 1,000 usleep(1000) calls
>        Total time: 1,053,963 usecs
>   
>    1,053.963 usecs/op
>   
>   # Running uprobe/empty benchmark...
>   # Executed 1,000 usleep(1000) calls
>        Total time: 1,056,293 usecs +2,330 to baseline
>   
>    1,056.293 usecs/op 2.330 usecs/op to baseline
>   
>   # Running uprobe/trace_printk benchmark...
>   # Executed 1,000 usleep(1000) calls
>        Total time: 1,056,977 usecs +3,014 to baseline +684 to previous
>   
>    1,056.977 usecs/op 3.014 usecs/op to baseline 0.684 usecs/op to previous
>   
>   [root@five ~]

Looks great! maybe we can also make kprobes benchmark too (but it depends
on optimization and ftrace-based...)

Thank you,

> 
> I put it here:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=perf-bench-uprobe
> 
>   git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf-bench-uprobe
> 
> Further ideas, problems?
> 
> - Arnaldo
> 
> 
> 
> Arnaldo Carvalho de Melo (5):
>   perf bench uprobe: Add benchmark to test uprobe overhead
>   perf bench uprobe: Print diff to baseline
>   perf bench uprobe: Show diff to previous
>   perf bench uprobe empty: Add entry attaching an empty BPF program
>   perf bench uprobe trace_printk: Add entry attaching an BPF program that does a trace_printk
> 
>  tools/perf/Documentation/perf-bench.txt     |   3 +
>  tools/perf/Makefile.perf                    |   1 +
>  tools/perf/bench/Build                      |   1 +
>  tools/perf/bench/bench.h                    |   3 +
>  tools/perf/bench/uprobe.c                   | 198 ++++++++++++++++++++
>  tools/perf/builtin-bench.c                  |   8 +
>  tools/perf/util/bpf_skel/bench_uprobe.bpf.c |  23 +++
>  7 files changed, 237 insertions(+)
>  create mode 100644 tools/perf/bench/uprobe.c
>  create mode 100644 tools/perf/util/bpf_skel/bench_uprobe.bpf.c
> 
> -- 
> 2.41.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
