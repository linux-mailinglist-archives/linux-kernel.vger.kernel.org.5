Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4890A77B620
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbjHNKLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236196AbjHNKKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:10:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23850171D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 03:10:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA6CF648EA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 10:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC1EC433C8;
        Mon, 14 Aug 2023 10:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692007829;
        bh=KwEYWO1MLwfGzs8d9axTJTvThPuNr1FoAll8e/c5bs8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rEvUnJQPmABiDutqgr8m+OXFoOgC0DhNrvPLd7YomjZcp4lnxy4MITsRKzGRN2oq5
         TmeYBaI0M7NAn47UxTKIq6Xb/SpULm9/2tyAPJtCME2t+sjFTGZ+nxBGRu5HkrgXOL
         xSEN9pzffJheMZldCQuIFqRvSK8/GUA+M0pkGrXcWnaB8y9+KlYgDHAaXm5oTrdrLc
         ZspwTOE3FH7i0Fk/YLhAnI4kFDBrUuTUNPIeHkU2xDZ8usPbiBKuel2AY7OoLh3bbT
         TjScp4/AOggVZjLykJvzzUMfi/goVWMPCnT+nbzzx+C+gXG6wqHGtWu2vLpIBtIZ9Q
         rfpgkmCPmjoTQ==
Date:   Mon, 14 Aug 2023 13:10:25 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dong Chenchen <dongchenchen2@huawei.com>
Cc:     steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, fw@strlen.de, timo.teras@iki.fi,
        yuehaibing@huawei.com, weiyongjun1@huawei.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: xfrm: skip policies marked as dead while
 reinserting policies
Message-ID: <20230814101025.GD3921@unreal>
References: <20230814013352.2771452-1-dongchenchen2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814013352.2771452-1-dongchenchen2@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 09:33:52AM +0800, Dong Chenchen wrote:
> BUG: KASAN: slab-use-after-free in xfrm_policy_inexact_list_reinsert+0xb6/0x430
> Read of size 1 at addr ffff8881051f3bf8 by task ip/668
> 
> CPU: 2 PID: 668 Comm: ip Not tainted 6.5.0-rc5-00182-g25aa0bebba72-dirty #64
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x72/0xa0
>  print_report+0xd0/0x620
>  kasan_report+0xb6/0xf0
>  xfrm_policy_inexact_list_reinsert+0xb6/0x430
>  xfrm_policy_inexact_insert_node.constprop.0+0x537/0x800
>  xfrm_policy_inexact_alloc_chain+0x23f/0x320
>  xfrm_policy_inexact_insert+0x6b/0x590
>  xfrm_policy_insert+0x3b1/0x480
>  xfrm_add_policy+0x23c/0x3c0
>  xfrm_user_rcv_msg+0x2d0/0x510
>  netlink_rcv_skb+0x10d/0x2d0
>  xfrm_netlink_rcv+0x49/0x60
>  netlink_unicast+0x3fe/0x540
>  netlink_sendmsg+0x528/0x970
>  sock_sendmsg+0x14a/0x160
>  ____sys_sendmsg+0x4fc/0x580
>  ___sys_sendmsg+0xef/0x160
>  __sys_sendmsg+0xf7/0x1b0
>  do_syscall_64+0x3f/0x90
>  entry_SYSCALL_64_after_hwframe+0x73/0xdd
> 
> The root cause is:
> 
> cpu 0			cpu1
> xfrm_dump_policy
> xfrm_policy_walk
> list_move_tail
> 			xfrm_add_policy
> 			... ...
> 			xfrm_policy_inexact_list_reinsert
> 			list_for_each_entry_reverse
> 				if (!policy->bydst_reinsert)
> 				//read non-existent policy
> xfrm_dump_policy_done
> xfrm_policy_walk_done
> list_del(&walk->walk.all);
> 
> If dump_one_policy() returns err (triggered by netlink socket),
> xfrm_policy_walk() will move walk initialized by socket to list
> net->xfrm.policy_all. so this socket becomes visible in the global
> policy list. The head *walk can be traversed when users add policies
> with different prefixlen and trigger xfrm_policy node merge.
> 
> It can be fixed by skip such "policies" with walk.dead set to 1.
> 
> Fixes: 9cf545ebd591 ("xfrm: policy: store inexact policies in a tree ordered by destination address")
> Fixes: 12a169e7d8f4 ("ipsec: Put dumpers on the dump list")
> Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
> ---
>  net/xfrm/xfrm_policy.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
