Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1D07BAFDC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 03:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjJFBBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 21:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjJFBBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 21:01:01 -0400
Received: from out-199.mta1.migadu.com (out-199.mta1.migadu.com [95.215.58.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64819110
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 18:01:00 -0700 (PDT)
Message-ID: <7aa47549-5a95-22d7-1d03-ffdd251cec6d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696554056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3uFabqeCC0ZaRLQsefD4hwIIguPVcY2YJuzj553oCas=;
        b=hwGL3kkX/wvNGM5EF592wWTbKt6DKNsaYezKHyVPJEY0O2hUwc/F/BRLiId2/qWzJT6N/C
        w8z+e8XnmevSY9uBv9ZZmir7GByWW/08ch2uBW/6wNFE30BD6sjQg4YmS6uzWUUjeL6uYk
        Id9AS6BVmiIk5Y3DZ8yXK9BHwqB6CAg=
Date:   Thu, 5 Oct 2023 18:00:46 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3] net/xdp: fix zero-size allocation warning in
 xskq_create()
Content-Language: en-US
To:     Andrew Kanner <andrew.kanner@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+fae676d3cf469331fc89@syzkaller.appspotmail.com,
        syzbot+b132693e925cbbd89e26@syzkaller.appspotmail.com,
        bjorn@kernel.org, magnus.karlsson@intel.com,
        maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, aleksander.lobakin@intel.com,
        xuanzhuo@linux.alibaba.com, ast@kernel.org, hawk@kernel.org,
        john.fastabend@gmail.com, daniel@iogearbox.net
References: <20231005193548.515-1-andrew.kanner@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231005193548.515-1-andrew.kanner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/23 12:35 PM, Andrew Kanner wrote:
> Syzkaller reported the following issue:
>   ------------[ cut here ]------------
>   WARNING: CPU: 0 PID: 2807 at mm/vmalloc.c:3247 __vmalloc_node_range (mm/vmalloc.c:3361)
>   Modules linked in:
>   CPU: 0 PID: 2807 Comm: repro Not tainted 6.6.0-rc2+ #12
>   Hardware name: Generic DT based system
>   unwind_backtrace from show_stack (arch/arm/kernel/traps.c:258)
>   show_stack from dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1))
>   dump_stack_lvl from __warn (kernel/panic.c:633 kernel/panic.c:680)
>   __warn from warn_slowpath_fmt (./include/linux/context_tracking.h:153 kernel/panic.c:700)
>   warn_slowpath_fmt from __vmalloc_node_range (mm/vmalloc.c:3361 (discriminator 3))
>   __vmalloc_node_range from vmalloc_user (mm/vmalloc.c:3478)
>   vmalloc_user from xskq_create (net/xdp/xsk_queue.c:40)
>   xskq_create from xsk_setsockopt (net/xdp/xsk.c:953 net/xdp/xsk.c:1286)
>   xsk_setsockopt from __sys_setsockopt (net/socket.c:2308)
>   __sys_setsockopt from ret_fast_syscall (arch/arm/kernel/entry-common.S:68)
> 
> xskq_get_ring_size() uses struct_size() macro to safely calculate the
> size of struct xsk_queue and q->nentries of desc members. But the
> syzkaller repro was able to set q->nentries with the value initially
> taken from copy_from_sockptr() high enough to return SIZE_MAX by
> struct_size(). The next PAGE_ALIGN(size) is such case will overflow
> the size_t value and set it to 0. This will trigger WARN_ON_ONCE in

Please ignore the pw-bot email. A question just came to my mind after applying.

> diff --git a/net/xdp/xsk_queue.c b/net/xdp/xsk_queue.c
> index f8905400ee07..c7e8bbb12752 100644
> --- a/net/xdp/xsk_queue.c
> +++ b/net/xdp/xsk_queue.c
> @@ -34,6 +34,11 @@ struct xsk_queue *xskq_create(u32 nentries, bool umem_queue)
>   	q->ring_mask = nentries - 1;
>   
>   	size = xskq_get_ring_size(q, umem_queue);
> +	if (unlikely(size == SIZE_MAX)) {

What if "size" is SIZE_MAX-1? Would it still overflow the PAGE_ALIGN below?

> +		kfree(q);
> +		return NULL;
> +	}
> +
>   	size = PAGE_ALIGN(size);
>   
>   	q->ring = vmalloc_user(size);

