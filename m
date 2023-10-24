Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EC27D4458
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 02:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjJXA4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 20:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJXA4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 20:56:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FAFEE
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 17:56:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75ACBC433C8;
        Tue, 24 Oct 2023 00:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698108994;
        bh=9JswtvnuZeTfrT6UZLP6xIqZ8XMw44neq1OfJu39tX8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LRXHqzNBrMKDyCAdYOdYwVgT4WQyVM8fTk4yL4MHlur0W/WVUqxkMerFmrVpmy7Pz
         +Zuw7gKSH8Te+DuE9dmexdWyNSQNNhaWtsBSAKaxBLdPERZp0M8JjUDh6ggJBlmJzB
         knjsLHqxfQpya1MnCgQpYw/l/YfQWbgYmvKGrplu9T/fic/xqAnkvdB4DN6cnZZzHc
         63VSFYRngBPJ0j2tgymYkcpMwtAlA5OD500++zDN7WJ9WU2kOKXNXDOvJ5ld+lOYZ6
         baDHA9tFED6SGjJO8h69YIFo1R5uSNtgfFVsn7KuBMJjhV7DdOyPv4BQoemvPAMjTl
         zw4GiBtioOyUg==
Date:   Tue, 24 Oct 2023 09:56:27 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "wuqiang.matt" <wuqiang.matt@bytedance.com>
Cc:     linux-trace-kernel@vger.kernel.org, davem@davemloft.net,
        anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.ibm.com,
        rostedt@goodmis.org, peterz@infradead.org,
        akpm@linux-foundation.org, sander@svanheule.net,
        ebiggers@google.com, dan.j.williams@intel.com, jpoimboe@kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com
Subject: Re: [PATCH v1] lib,kprobes: using try_cmpxchg_local in objpool_push
Message-Id: <20231024095627.0d19118925bb6d3c370671a7@kernel.org>
In-Reply-To: <20231023112452.6290-1-wuqiang.matt@bytedance.com>
References: <20231023112452.6290-1-wuqiang.matt@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023 19:24:52 +0800
"wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:

> The objpool_push can only happen on local cpu node, so only the local
> cpu can touch slot->tail and slot->last, which ensures the correctness
> of using cmpxchg without lock prefix (using try_cmpxchg_local instead
> of try_cmpxchg_acquire).
> 
> Testing with IACA found the lock version of pop/push pair costs 16.46
> cycles and local-push version costs 15.63 cycles. Kretprobe throughput
> is improved to 1.019 times of the lock version for x86_64 systems.
> 
> OS: Debian 10 X86_64, Linux 6.6rc6 with freelist
> HW: XEON 8336C x 2, 64 cores/128 threads, DDR4 3200MT/s
> 
>                  1T         2T         4T         8T        16T
>   lock:    29909085   59865637  119692073  239750369  478005250
>   local:   30297523   60532376  121147338  242598499  484620355
>                 32T        48T        64T        96T       128T
>   lock:   957553042 1435814086 1680872925 2043126796 2165424198
>   local:  968526317 1454991286 1861053557 2059530343 2171732306
> 

Yeah, slot->tail is only used on the local CPU. This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
> ---
>  lib/objpool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/objpool.c b/lib/objpool.c
> index ce0087f64400..a032701beccb 100644
> --- a/lib/objpool.c
> +++ b/lib/objpool.c
> @@ -166,7 +166,7 @@ objpool_try_add_slot(void *obj, struct objpool_head *pool, int cpu)
>  		head = READ_ONCE(slot->head);
>  		/* fault caught: something must be wrong */
>  		WARN_ON_ONCE(tail - head > pool->nr_objs);
> -	} while (!try_cmpxchg_acquire(&slot->tail, &tail, tail + 1));
> +	} while (!try_cmpxchg_local(&slot->tail, &tail, tail + 1));
>  
>  	/* now the tail position is reserved for the given obj */
>  	WRITE_ONCE(slot->entries[tail & slot->mask], obj);
> -- 
> 2.40.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
