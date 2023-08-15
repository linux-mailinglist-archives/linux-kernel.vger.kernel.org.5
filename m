Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A7B77CCBD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 14:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237196AbjHOMdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 08:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237275AbjHOMdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:33:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2EE1BFB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 05:32:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69ECB65804
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:32:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46171C433C7;
        Tue, 15 Aug 2023 12:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692102757;
        bh=LLZ+oH1hBLtH9rpeoXZ6k1vXhIAFpyRwaDQwn6U+yA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DLdmqkj9CfgBnyHRKEmlH116N2lwu/OQiIfQoRBMg67MgulJfDjp2WmTC4vKGRoSI
         N098HCZyRSCULluqMbbznhcgj8Mj07+CSuI+scqZa8jgtfOY2keLvKV9aYlJoktTom
         P+9wcszevEDuL6uvDd4PuHlv6no1JAdjk2Dz8ZgROA/gN+LI4gBBxzhakW8npGLZCx
         uOAP3HdGIl+dlF2/yza6TD4MzJJUqsc08RqQ121Ens+jaPQtPRSz8/cXD24oXftdkw
         97p55H2voWYgCOTqDEWvRC85x4c51LTrHi3n0HmHhwt6OKwVLXSbsrT5zAtlAkAxq5
         LRE6hc3AA37iA==
Date:   Tue, 15 Aug 2023 15:32:33 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dong Chenchen <dongchenchen2@huawei.com>
Cc:     fw@strlen.de, steffen.klassert@secunet.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        timo.teras@iki.fi, yuehaibing@huawei.com, weiyongjun1@huawei.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch net, v2] net: xfrm: skip policies marked as dead while
 reinserting policies
Message-ID: <20230815123233.GM22185@unreal>
References: <20230814140013.712001-1-dongchenchen2@huawei.com>
 <20230815060026.GE22185@unreal>
 <20230815091324.GL22185@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815091324.GL22185@unreal>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 07:35:13PM +0800, Dong Chenchen wrote:
> On Tue, Aug 15, 2023 at 04:47:58PM +0800, Dong Chenchen wrote:
> >> On Mon, Aug 14, 2023 at 10:00:13PM +0800, Dong Chenchen wrote:
> >> >> BUG: KASAN: slab-use-after-free in xfrm_policy_inexact_list_reinsert+0xb6/0x430
> >> >> Read of size 1 at addr ffff8881051f3bf8 by task ip/668
> >> >> 
> >> >> CPU: 2 PID: 668 Comm: ip Not tainted 6.5.0-rc5-00182-g25aa0bebba72-dirty #64
> >> >> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13 04/01/2014
> >> >> Call Trace:
> >> >>  <TASK>
> >> >>  dump_stack_lvl+0x72/0xa0
> >> >>  print_report+0xd0/0x620
> >> >>  kasan_report+0xb6/0xf0
> >> >>  xfrm_policy_inexact_list_reinsert+0xb6/0x430
> >> >>  xfrm_policy_inexact_insert_node.constprop.0+0x537/0x800
> >> >>  xfrm_policy_inexact_alloc_chain+0x23f/0x320
> >> >>  xfrm_policy_inexact_insert+0x6b/0x590
> >> >>  xfrm_policy_insert+0x3b1/0x480
> >> >>  xfrm_add_policy+0x23c/0x3c0
> >> >>  xfrm_user_rcv_msg+0x2d0/0x510
> >> >>  netlink_rcv_skb+0x10d/0x2d0
> >> >>  xfrm_netlink_rcv+0x49/0x60
> >> >>  netlink_unicast+0x3fe/0x540
> >> >>  netlink_sendmsg+0x528/0x970
> >> >>  sock_sendmsg+0x14a/0x160
> >> >>  ____sys_sendmsg+0x4fc/0x580
> >> >>  ___sys_sendmsg+0xef/0x160
> >> >>  __sys_sendmsg+0xf7/0x1b0
> >> >>  do_syscall_64+0x3f/0x90
> >> >>  entry_SYSCALL_64_after_hwframe+0x73/0xdd
> >> >> 
> >> >> The root cause is:
> >> >> 
> >> >> cpu 0			cpu1
> >> >> xfrm_dump_policy
> >> >> xfrm_policy_walk
> >> >> list_move_tail
> >> >> 			xfrm_add_policy
> >> >> 			... ...
> >> >> 			xfrm_policy_inexact_list_reinsert
> >> >> 			list_for_each_entry_reverse
> >> >> 				if (!policy->bydst_reinsert)
> >> >> 				//read non-existent policy
> >> >> xfrm_dump_policy_done
> >> >> xfrm_policy_walk_done
> >> >> list_del(&walk->walk.all);
> >> >> 
> >> >> If dump_one_policy() returns err (triggered by netlink socket),
> >> >> xfrm_policy_walk() will move walk initialized by socket to list
> >> >> net->xfrm.policy_all. so this socket becomes visible in the global
> >> >> policy list. The head *walk can be traversed when users add policies
> >> >> with different prefixlen and trigger xfrm_policy node merge.
> >> >> 
> >> >> The issue can also be triggered by policy list traversal while rehashing
> >> >> and flushing policies.
> >> >> 
> >> >> It can be fixed by skip such "policies" with walk.dead set to 1.
> >> >> 
> >> >> Fixes: 9cf545ebd591 ("xfrm: policy: store inexact policies in a tree ordered by destination address")
> >> >> Fixes: 12a169e7d8f4 ("ipsec: Put dumpers on the dump list")
> >> >> Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
> >> >> ---
> >> >> v2: fix similiar similar while rehashing and flushing policies
> >> >> ---
> >> >>  net/xfrm/xfrm_policy.c | 20 +++++++++++++++-----
> >> >>  1 file changed, 15 insertions(+), 5 deletions(-)
> >
> ><...>
> >
> >> >> @@ -1253,11 +1256,14 @@ static void xfrm_hash_rebuild(struct work_struct *work)
> >> >>  	 * we start with destructive action.
> >> >>  	 */
> >> >>  	list_for_each_entry(policy, &net->xfrm.policy_all, walk.all) {
> >> >> +		if (policy->walk.dead)
> >> >> +			continue;
> >> >> +
> >> >>  		struct xfrm_pol_inexact_bin *bin;
> >> >>  		u8 dbits, sbits;
> >> >
> >> >Same comment as above.
> >> >
> >> >>  
> >> >>  		dir = xfrm_policy_id2dir(policy->index);
> >> >> -		if (policy->walk.dead || dir >= XFRM_POLICY_MAX)
> >> >> +		if (dir >= XFRM_POLICY_MAX)
> >> >
> >> >This change is unnecessary, previous code was perfectly fine.
> >> >
> >> The walker object initialized by xfrm_policy_walk_init() doesnt have policy. 
> >> list_for_each_entry() will use the walker offset to calculate policy address.
> >> It's nonexistent and different from invalid dead policy. It will read memory 
> >> that doesnt belong to walker if dereference policy->index.
> >> I think we should protect the memory.
> >
> >But all operations here are an outcome of "list_for_each_entry(policy,
> >&net->xfrm.policy_all, walk.all)" which stores in policy iterator
> >the pointer to struct xfrm_policy.
> >
> >How at the same time access to policy->walk.dead is valid while
> >policy->index is not?
> >
> >Thanks
> 1.walker init: its only a list head, no policy
> xfrm_dump_policy_start
> 	xfrm_policy_walk_init(walk, XFRM_POLICY_TYPE_ANY);
> 		INIT_LIST_HEAD(&walk->walk.all);
> 		walk->walk.dead = 1;
> 
> 2.add the walk head to net->xfrm.policy_all
> xfrm_policy_walk
>     list_for_each_entry_from(x, &net->xfrm.policy_all, all)
> 	if (error) {
> 		list_move_tail(&walk->walk.all, &x->all);
> 		//add the walk to list tail
> 
> 3.traverse the walk list
> xfrm_policy_flush
> list_for_each_entry(pol, &net->xfrm.policy_all, walk.all)
> 	 dir = xfrm_policy_id2dir(pol->index);
> 
> it gets policy by &net->xfrm.policy_all-0x130(offset of walk in policy)
> but when walk is head, we will read others memory by the calculated policy.
> such as:
>   walk addr  		policy addr
> 0xffff0000d7f3b530    0xffff0000d7f3b400 (non-existent) 
> 
> head walker of net->xfrm.policy_all can be skipped by  list_for_each_entry().
> but the walker created by socket is located list tail. so we should skip it. 

list_for_each_entry_from(x, &net->xfrm.policy_all, all) gives you
pointer to "x", you can't access some of its fields and say they
exist and other doesn't. Once you can call to "x->...", you can 
call to "x->index" too.

Thanks
