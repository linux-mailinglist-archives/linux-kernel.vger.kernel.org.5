Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA615781DF0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 15:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjHTNSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 09:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjHTNSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 09:18:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BC6423A;
        Sun, 20 Aug 2023 06:18:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7D8F60B63;
        Sun, 20 Aug 2023 13:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B155C433C8;
        Sun, 20 Aug 2023 13:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692537507;
        bh=OI+S8xxvHSRCoiBDJj07tDGEHoc69+izHX3yEEM/1Pw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nUtPkc20s7VVBPcFDY2ZNMjgr6kGqqQBTuXFTKaFwgRdQ4uoRypDM8dDd3htly2SE
         y1nRoBv7zfQ6DeG7oUa1sSfJL2BlpNJKTPhaxOIeQhfALreN0E/mNTgRVEdyZ8Jgxw
         +9KzMyYwgMtj4MjZqPAYkG+4wI5nPcKVqdkRSay2JfC3iNm/lqGEAB5MLSTfRcjeYF
         Hfumo2MXZs0xeXq3Uh5nry2Cp03AbO0CHXPW2XQT1AIxAZvtdhLpcNhEYzvAfR1uRy
         yT9PhkwEo4H0/DPWry5YsVDWxR3AMBUwZrNsDgsWIo3riyb07D1CcMD4N3uN+qL0nM
         4ExaGauOxBChg==
Date:   Sun, 20 Aug 2023 22:18:22 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Zheng Yejian <zhengyejian1@huawei.com>, <laijs@cn.fujitsu.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tracing: Introduce pipe_cpumask to avoid race on
 trace_pipes
Message-Id: <20230820221822.8a38273100324aacc59e48ac@kernel.org>
In-Reply-To: <20230819104257.80203c3916509cc9eb9327c1@kernel.org>
References: <20230817115057.1637676-1-zhengyejian1@huawei.com>
        <20230818022645.1948314-1-zhengyejian1@huawei.com>
        <20230818140309.b0a720afa87b05a2b7b27315@kernel.org>
        <20230818094128.7cf1d58b@gandalf.local.home>
        <20230818232301.902ad9319569379ebd7df557@kernel.org>
        <20230818115322.3dfda470@gandalf.local.home>
        <20230819104257.80203c3916509cc9eb9327c1@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Aug 2023 10:42:57 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Fri, 18 Aug 2023 11:53:22 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Fri, 18 Aug 2023 23:23:01 +0900
> > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > 
> > > It uses trace_pipe_raw. I guess if splice(from trace_pipe_raw to virtio-serial)
> > > returns -1 and errno == EAGAIN, the trace data will be lost?
> > 
> > It shouldn't. If it does, then there's likely a bug. The code will block
> > and if an interrupt comes in it will return immediately without reading
> > from the buffer.
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/trace/trace.c#n8262
> > 
> > I don't see where it would return -EINTR and consume data, but I may be
> > missing something.
> 
> Hmm, I suspect the case if the spilice_to_pipe() returns -EAGAIN.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/trace/trace.c#n8491
> 
> It seems not handling such case.
> 
> Anyway, I also think something wrong in virtio-serial (or misusing?), since
> it can not read anything from the host sometimes. I just setup the virtio-trace
> with below patch (ignore EAGAIN).

Hmm, I couldn't reproduce it. (maybe a host security update change something?)
Anyway, I confirmed that the ring buffer pages will not be consumed unless
splice_to_pipe() succeeded.

Thank you,

> 
> 
> From 92242480285448360c9390a743ea7b3751bb3e61 Mon Sep 17 00:00:00 2001
> From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
> Date: Thu, 17 Aug 2023 14:08:40 +0900
> Subject: [PATCH 1/3] tools/virtio-trace: Ignore EAGAIN error on splice()
> 
> splice() can return EAGAIN error instead of returning 0 size read.
> In that case, wait a while and try to call splice() again.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  tools/virtio/virtio-trace/trace-agent-rw.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/virtio/virtio-trace/trace-agent-rw.c b/tools/virtio/virtio-trace/trace-agent-rw.c
> index ddfe7875eb16..e8a4c4f0c499 100644
> --- a/tools/virtio/virtio-trace/trace-agent-rw.c
> +++ b/tools/virtio/virtio-trace/trace-agent-rw.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #define _GNU_SOURCE
> +#include <errno.h>
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> @@ -127,10 +128,10 @@ static void *rw_thread_main(void *thread_info)
>  		rlen = splice(ts->in_fd, NULL, ts->read_pipe, NULL,
>  				ts->pipe_size, SPLICE_F_MOVE | SPLICE_F_MORE);
>  
> -		if (rlen < 0) {
> -			pr_err("Splice_read in rw-thread(%d)\n", ts->cpu_num);
> +		if (rlen < 0 && errno != EAGAIN) {
> +			pr_err("Splice_read error (%d) in rw-thread(%d)\n", errno, ts->cpu_num);
>  			goto error;
> -		} else if (rlen == 0) {
> +		} else if (rlen == 0 || errno == EAGAIN) {
>  			/*
>  			 * If trace data do not exist or are unreadable not
>  			 * for exceeding the page size, splice_read returns
> -- 
> 2.34.1
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
