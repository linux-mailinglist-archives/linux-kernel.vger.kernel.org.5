Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9347943E3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 21:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbjIFTqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 15:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbjIFTqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 15:46:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8DD10F1;
        Wed,  6 Sep 2023 12:46:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A2BC433C7;
        Wed,  6 Sep 2023 19:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694029566;
        bh=b3ahWp9uGucvjkWBa+4Q7o6tAHZIBp0zKXsW4RcP77M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W7dDnkIS8NtzH9aeDLHBwbxpV9xLBZs7MfBssUVPbl3q+Lb74CqSxUsH0BFRJcQhm
         7n1N3XubaKAZrcCjY9XxhXuvnl+YZwIHQrRky8Wa1Y8ySSWeUrVY6mZs9m92M1gS86
         zrWqPzWbeV30IkDxfy1z0yRB6LWRvfrOAkOg0DZQ=
Date:   Wed, 6 Sep 2023 20:46:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5p2O5qOSKOS8r+WFrik=?= <libang.li@antgroup.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.1.y] perf/core: Fix possible deadlock in
 sys_perf_event_open()
Message-ID: <2023090652-obsessed-scrutiny-d388@gregkh>
References: <20230906163821.85031-1-libang.li@antgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230906163821.85031-1-libang.li@antgroup.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 12:38:21AM +0800, 李棒(伯兮) wrote:
> In certain scenarios, gctx and ctx may be equal in the
> __perf_event_ctx_lock_double() function, resulting in a deadlock.
> 
> Thread 1, thread 2 and thread 3 belong to the same process, and the
> process number is assumed to be M. The deadlock scenario is as follows:
> 
> 1) Thread 1 creates a pure software group through the system call
>    sys_perf_event_open() and returns an fd, assuming the value of fd is N.
>    The parameters of sys_perf_event_open() are as follows.
> 
>    For example:
>     perf_event_attr.type = PERF_TYPE_SOFTWARE;
>     pid = M;
>     cpu = 0;
>     group_fd = -1;
>     flags = 0;
>     N = sys_perf_event_open(&perf_event_attr, pid, cpu, group_fd, flags);
> 
> 2) Thread 2 and thread 3 call the perf_event_open() function concurrently
>    with the same parameters on a different cpu. And use the fd generated
>    by thread 1 as group_fd. The parameters of sys_perf_event_open() are
>    as follows.
> 
>    For example:
>     perf_event_attr.type = PERF_TYPE_HARDWARE;
>     pid = M;
>     cpu = 0;
>     group_fd = N;
>     flags = 0;
>     sys_perf_event_open(&perf_event_attr, pid, cpu, group_fd, flags);
> 
> 3) In the __perf_event_ctx_lock_double function, assuming that thread 2
>    successfully acquires gctx->mutex and ctx->mutex first, thread 3 will
>    wait here. At the same time, thread 2 will move the pure software gruop
>    to the hardware context and change group_leader->ctx to the hardware
>    context.
> 
> 4) When thread 2 releases gctx->mutex and ctx->mutex, thread 3 acquires
>    gctx->mutex and ctx->mutex. And find that group_leader->ctx != gctx,
>    then reacquires gctx. At this time, gctx is equal to the ctx of thread
>    3, triggering a deadlock.
> 
> Fixes: 321027c1fe77 ("perf/core: Fix concurrent sys_perf_event_open() vs. 'move_group' race")
> Signed-off-by: Bang Li <libang.li@antgroup.com>
> ---
>  kernel/events/core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
