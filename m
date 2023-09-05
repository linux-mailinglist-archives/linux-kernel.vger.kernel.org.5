Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD793792C1B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353922AbjIERGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353610AbjIEQ2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 12:28:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2F42D54;
        Tue,  5 Sep 2023 09:18:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08A3160A71;
        Tue,  5 Sep 2023 16:17:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B81C433C7;
        Tue,  5 Sep 2023 16:17:25 +0000 (UTC)
Date:   Tue, 5 Sep 2023 12:17:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     <mhiramat@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <yeweihua4@huawei.com>
Subject: Re: [PATCH] tracing: Fix unexpected ring buffer expand by instance
Message-ID: <20230905121744.538b92cc@gandalf.local.home>
In-Reply-To: <20230905121714.3229131-1-zhengyejian1@huawei.com>
References: <20230905121714.3229131-1-zhengyejian1@huawei.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Sep 2023 20:17:14 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> The ring buffer of global_trace is set to the minimum size in
> order to save memory on boot up and then it will be expand when
> some trace feature enabled.
> 
> However currently operations under an instance can also cause
> global_trace ring buffer being expanded, and the expanded memory
> would be wasted if global_trace then not being used.
> 
> See following case, we enable 'sched_switch' event in instance 'A', then
> ring buffer of global_trace is unexpectedly expanded to be 1410KB, also
> the '(expanded: 1408)' from 'buffer_size_kb' of instance is confusing.
> 
>   # cd /sys/kernel/tracing
>   # mkdir instances/A
>   # cat buffer_size_kb
>   7 (expanded: 1408)
>   # cat instances/A/buffer_size_kb
>   1410 (expanded: 1408)
>   # echo sched:sched_switch > instances/A/set_event
>   # cat buffer_size_kb
>   1410
>   # cat instances/A/buffer_size_kb
>   1410
> 
> To fix it, we can:
>   - Make 'ring_buffer_expanded' as a member of 'struct trace_array';
>   - Make 'ring_buffer_expanded' of instance is defaultly true,
>     global_trace is defaultly false;
>   - In order not to expose 'global_trace' outside of file
>     'kernel/trace/trace.c', introduce trace_set_ring_buffer_expanded()
>     to set 'ring_buffer_expanded' as 'true';
>   - Pass the expected trace_array to tracing_update_buffers().
> 
> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
> ---
>  kernel/trace/trace.c        | 46 ++++++++++++++++++++-----------------
>  kernel/trace/trace.h        |  9 ++++++--
>  kernel/trace/trace_events.c | 22 ++++++++++--------
>  3 files changed, 44 insertions(+), 33 deletions(-)
> 

Looks good, but as the merge window is still open, it will need to wait
till it is closed to be reviewed.

Thanks,

-- Steve
