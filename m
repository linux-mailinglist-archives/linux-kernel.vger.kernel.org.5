Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C126A77071F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 19:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjHDRbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 13:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjHDRbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:31:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE093C25;
        Fri,  4 Aug 2023 10:31:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2110620BC;
        Fri,  4 Aug 2023 17:31:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D1AC433C8;
        Fri,  4 Aug 2023 17:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691170268;
        bh=svLxVh9EeYIhyoGvToGfRdn37hDgyQdFwVgjw2oh8nQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PIUqNuaYxNoZft5tJIhSnXfn7eaWCdwyqPXcwCtmloo2Z5chJXv8A8XcKrcP/Xh1q
         4H/QW+fk25Ia3xV1e/Uo+QeydoCgr5/UNtVbZmgsbo+yIA2nmDuyolv4bzwWMIKzHD
         q7mx3rdHg1DRuUo8DlH1q7Cz46gNuzK6NyaUM67HawGWpqI/l2QMfyc4g2m/BmJC3S
         90WGVQJ4aQEACno7QEdLmnFHS6wGBbOqVUkfJu/SSsZS+m2j8p5TH77DbU1XaZgnM3
         KshU0IaBDpQRDGfiyrAx1B9u9PAZw6un+5gsC5Ng6vKoYGyPEiawjpM4vDwAB+sg49
         DoUV+5BnZ3M8A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 85710CE0591; Fri,  4 Aug 2023 10:31:07 -0700 (PDT)
Date:   Fri, 4 Aug 2023 10:31:07 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     thunder.leizhen@huaweicloud.com
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH v6 0/5] rcu: Dump memory object info if callback function
 is invalid
Message-ID: <7af1d3d8-2d51-40a8-8021-0141e4bf1a0e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230804091136.1177-1-thunder.leizhen@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804091136.1177-1-thunder.leizhen@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 05:11:30PM +0800, thunder.leizhen@huaweicloud.com wrote:
> From: Zhen Lei <thunder.leizhen@huawei.com>
> 
> v5 --> v6:
> 1. Use print_hex_dump() to dump the memory of slab object.
> 2. Add a new dump prefix DUMP_PREFIX_ADDRESS_LOW16
> 3. Minimize the output width of the offset
> 
> v4 --> v5:
> 1. Add Reviewed-by Acked-by for patch 1/3
> 2. Add patch 3/3:
>    mm: Dump the memory of slab object in kmem_dump_obj()
> 
> v3 --> v4:
> 1. Remove kmem_valid_obj() and convert kmem_dump_obj() to work the same way
>    as vmalloc_dump_obj().
> 2. In kernel/rcu/rcu.h
> -#include <linux/mm.h>
> +#include <linux/slab.h>
> 
> v2 --> v3:
> 1. I made statistics about the source of 'rhp'. kmem_valid_obj() accounts for
>    more than 97.5%, and vmalloc accounts for less than 1%. So change call
>    mem_dump_obj() to call kmem_dump_obj() can meet debugging requirements and
>    avoid the potential deadlock risk of vmalloc_dump_obj().
> -		mem_dump_obj(rhp);
> +		if (kmem_valid_obj(rhp))
> +			kmem_dump_obj(rhp);
> 
>    The discussion about vmap_area_lock deadlock in v2:
>    https://lkml.org/lkml/2022/11/11/493
> 
> 2. Provide static inline empty functions for kmem_valid_obj() and kmem_dump_obj()
>    when CONFIG_PRINTK=n.
> 
> v1 --> v2:
> 1. Remove condition "(unsigned long)rhp->func & 0x3", it have problems on x86.
> 2. Paul E. McKenney helped me update the commit message, thanks.

I would be happy to take the patch that Matthew and Vlastimil are happy
with, and also the one against RCU.  But unless you tell me otherwise,
I will assume that you would prefer me to wait until the entire series
is ready.  The best way to tell me otherwise is of course to resend just
those two patches in their own series.  ;-)

							Thanx, Paul

> Zhen Lei (5):
>   hexdump: add a new dump prefix DUMP_PREFIX_ADDRESS_LOW16
>   hexdump: minimize the output width of the offset
>   mm: Remove kmem_valid_obj()
>   mm: Dump the memory of slab object in kmem_dump_obj()
>   rcu: Dump memory object info if callback function is invalid
> 
>  include/linux/printk.h |  1 +
>  include/linux/slab.h   |  5 ++--
>  kernel/rcu/rcu.h       |  7 +++++
>  kernel/rcu/srcutiny.c  |  1 +
>  kernel/rcu/srcutree.c  |  1 +
>  kernel/rcu/tasks.h     |  1 +
>  kernel/rcu/tiny.c      |  1 +
>  kernel/rcu/tree.c      |  1 +
>  lib/hexdump.c          | 17 +++++++++--
>  mm/slab_common.c       | 68 ++++++++++++++++++++++--------------------
>  mm/util.c              |  4 +--
>  11 files changed, 67 insertions(+), 40 deletions(-)
> 
> -- 
> 2.34.1
> 
