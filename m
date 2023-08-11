Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C3D778DFD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbjHKLnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjHKLnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:43:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF342FA;
        Fri, 11 Aug 2023 04:43:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8979465644;
        Fri, 11 Aug 2023 11:43:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C46C433C8;
        Fri, 11 Aug 2023 11:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691754182;
        bh=TQCzZnkuHpoP3dZH4vAu/XWOXP2gTQQ50jakD2TlpKw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IgZXuvBY5QTt7Q4pQ8U7wQrHHy58ToautzIhnNzAXAuVeDALFOjGgIU5dJcd35QCO
         awT88MoBf4W0F5QUUBJfGMh8e3eepiEB6BrYo/hIBCh0pGHzwN3jKtZuKe+WH2X41f
         jIS9zSZbCB7v+L0CKeF/VYQkqaJpO6w4SMsItpzElLkPOs9P83iAPPXu21qIMj4d8O
         bLhKPo1V5/5uzP9Mj8ttG2M3rHcgl5OKHKDX8B/Drs70YHaUatKufAKZPogxdVm+Ws
         uFt+EQeRU6uqOANckN79NjGUxCSLYUIrFoM7WzFkDg/fXWY4THEkl6J8YWmjPTmsnF
         ss1zD78PnZg6g==
Date:   Fri, 11 Aug 2023 20:42:57 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     <rostedt@goodmis.org>, <laijs@cn.fujitsu.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: Fix race when concurrently splice_read
 trace_pipe
Message-Id: <20230811204257.99df8ba60d591f5bace38615@kernel.org>
In-Reply-To: <20230810123905.1531061-1-zhengyejian1@huawei.com>
References: <20230810123905.1531061-1-zhengyejian1@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 20:39:05 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> When concurrently splice_read file trace_pipe and per_cpu/cpu*/trace_pipe,
> there are more data being read out than expected.
> 
> The root cause is that in tracing_splice_read_pipe(), an entry is found
> outside locks, it may be read by multiple readers or consumed by other
> reader as starting printing it.
> 
> To fix it, change to find entry after holding locks.
> 
> Fixes: 7e53bd42d14c ("tracing: Consolidate protection of reader access to the ring buffer")
> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
> ---
>  kernel/trace/trace.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index b8870078ef58..f169d33b948f 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -7054,14 +7054,16 @@ static ssize_t tracing_splice_read_pipe(struct file *filp,
>  	if (ret <= 0)
>  		goto out_err;
>  
> -	if (!iter->ent && !trace_find_next_entry_inc(iter)) {
> +	trace_event_read_lock();
> +	trace_access_lock(iter->cpu_file);
> +
> +	if (!trace_find_next_entry_inc(iter)) {

It seems you skips '!iter->ent' check. Is there any reason for this change?

Thank you,

> +		trace_access_unlock(iter->cpu_file);
> +		trace_event_read_unlock();
>  		ret = -EFAULT;
>  		goto out_err;
>  	}
>  
> -	trace_event_read_lock();
> -	trace_access_lock(iter->cpu_file);
> -
>  	/* Fill as many pages as possible. */
>  	for (i = 0, rem = len; i < spd.nr_pages_max && rem; i++) {
>  		spd.pages[i] = alloc_page(GFP_KERNEL);
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
