Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9828D7793E0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjHKQHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHKQHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:07:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C59E58;
        Fri, 11 Aug 2023 09:07:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9898D60FBB;
        Fri, 11 Aug 2023 16:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0125FC433C7;
        Fri, 11 Aug 2023 16:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691770041;
        bh=6VvrmSIW6cPl+IAjFwpiICETdVuCXpsKWZNGmIpEQx0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fmW+jn6Rz18nR/ip1Z0weHQbJZNkqd50JJW2gbqh4VUvJWevWUQRxpxM/tm2OQAiL
         +f70QN5H/8neTlFe+zG3frJn4WgpEAtP4XPW8WmKa7kjgvBUIe8O7NgNHDNLobs1NK
         IU5Zix8ZOGJiiHT3Hsgjs8neyeWYO5tPc4U0FlLgfABbhx5Y/tDQNX9LTWL4VVhW2z
         mlnBW1guvxdBvIK5xF1GmV2dFwMbBKwFvJv3XfDDfoZ33zO5c35ZzJ6M7JXU074PyM
         cq6bNkp14iHu3UrTjiaFRE+BvHg34Mzlu6NBSdIA4Fj3a/5VOO4BAzh1Hu7Q3OAkjx
         7MIXQOriZuoEA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8855BCE0593; Fri, 11 Aug 2023 09:07:20 -0700 (PDT)
Date:   Fri, 11 Aug 2023 09:07:20 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     thunder.leizhen@huaweicloud.com
Cc:     Christoph Lameter <cl@linux.com>,
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
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH v7 0/2] rcu: Dump memory object info if callback function
 is invalid
Message-ID: <75ece297-e936-48f5-9daa-35a6bd740f76@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230805031726.1230-1-thunder.leizhen@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230805031726.1230-1-thunder.leizhen@huaweicloud.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2023 at 11:17:24AM +0800, thunder.leizhen@huaweicloud.com wrote:
> From: Zhen Lei <thunder.leizhen@huawei.com>
> 
> v6 --> v7:
> To avoid snowballing, resend the two RCU-related patches that we've discussed
> OK. The remaining three patches themselves do not need to be gone into RCU tree,
> I'll send them separately for discussion.
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
> 
> 
> Zhen Lei (2):
>   mm: Remove kmem_valid_obj()
>   rcu: Dump memory object info if callback function is invalid

Queued both on -rcu, thank you all!

							Thanx, Paul

>  include/linux/slab.h  |  5 +++--
>  kernel/rcu/rcu.h      |  7 +++++++
>  kernel/rcu/srcutiny.c |  1 +
>  kernel/rcu/srcutree.c |  1 +
>  kernel/rcu/tasks.h    |  1 +
>  kernel/rcu/tiny.c     |  1 +
>  kernel/rcu/tree.c     |  1 +
>  mm/slab_common.c      | 41 +++++++++++------------------------------
>  mm/util.c             |  4 +---
>  9 files changed, 27 insertions(+), 35 deletions(-)
> 
> -- 
> 2.34.1
> 
