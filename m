Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911D1811244
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379001AbjLMNAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379074AbjLMNAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:00:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7149126
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:00:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0A1C433CB;
        Wed, 13 Dec 2023 13:00:43 +0000 (UTC)
Date:   Wed, 13 Dec 2023 08:01:27 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        <mathieu.desnoyers@efficios.com>, <mhiramat@kernel.org>,
        <yeweihua4@huawei.com>
Subject: Re: [PATCH v2] tracing: Fix uaf issue when open the hist or
 hist_debug file
Message-ID: <20231213080127.6ef26247@gandalf.local.home>
In-Reply-To: <20231213015138.281888-1-zhengyejian1@huawei.com>
References: <20231212113546.6a51d359@gandalf.local.home>
        <20231213015138.281888-1-zhengyejian1@huawei.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2023 09:51:38 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> ---
>  kernel/trace/trace_events_hist.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> Steve, thanks for your review!
> 
> v2:
>   - Introduce tracing_single_release_file_tr() to add the missing call for
>     single_release() as suggested by Steve;
>     Link: https://lore.kernel.org/all/20231212113546.6a51d359@gandalf.local.home/
>   - Slightly modify the commit message and comments.
> 
> v1:
>   Link: https://lore.kernel.org/all/20231212113317.4159890-1-zhengyejian1@huawei.com/
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 1abc07fba1b9..5296a08c0641 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -5619,14 +5619,22 @@ static int hist_show(struct seq_file *m, void *v)
>  	return ret;
>  }
>  
> +static int tracing_single_release_file_tr(struct inode *inode, struct file *filp)
> +{
> +	tracing_release_file_tr(inode, filp);
> +	return single_release(inode, filp);
> +}
> +

Hi Zheng,

Could you put the tracing_single_release_file_tr() into trace.c as a non
static function. Put the protocol in kernel/trace/trace.h.

Even though it's only used in trace_events_hist.c, I rather not hide it
there. If this issue appears for another file, I would look in trace.c and
trace.h for available functions to use.

Thanks,

-- Steve
