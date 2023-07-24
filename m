Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3E775F51E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 13:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjGXLcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 07:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjGXLbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 07:31:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40667E65
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 04:31:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 135DE61118
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 11:31:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8409C433D9;
        Mon, 24 Jul 2023 11:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690198259;
        bh=p7v9priVhxS6OpRqrU1U0OeVZS6L2EHIujm2fZHvIKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tv7JCflXiDkmz1RVLX3aSIyORlhMSjolJC7tFHNqNYvj3MXJ4gv04aNhTVKkANH04
         vop9syQd12WOHXaA8XenB0rxC97ji6mZ4cOjSwvmpOxvwHv9uU0dgP1wdNNi1HiZWY
         bH3ItqABfo+v31kLAHm/MD/FMrX/TZ4iOprDJrzcsgcpOesL4SM/XbISnCSQ5hDAnN
         miVAeP3W/xwy/8FM4AyLSmS/az3eTkNJXyvl/YYTwVuc2lWtT857eGq5YTrMckIBxj
         2EzsOcPaWdG6WNLT3wG9LZk22j5XeUct/vIMGtX3n9dwSfGHz6ysaKZmKcHJA0Nr/c
         ijRWNSrWbBayg==
Date:   Mon, 24 Jul 2023 14:30:55 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Lin Ma <linma@zju.edu.cn>
Cc:     steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] xfrm: add NULL check in xfrm_update_ae_params
Message-ID: <20230724113055.GC9776@unreal>
References: <20230721145103.2714073-1-linma@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721145103.2714073-1-linma@zju.edu.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 10:51:03PM +0800, Lin Ma wrote:
> Normally, x->replay_esn and x->preplay_esn should be allocated at
> xfrm_alloc_replay_state_esn(...) in xfrm_state_construct(...), hence the
> xfrm_update_ae_params(...) is okay to update them. However, the current
> implementation of xfrm_new_ae(...) allows a malicious user to directly
> dereference a NULL pointer and crash the kernel like below.
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> PGD 8253067 P4D 8253067 PUD 8e0e067 PMD 0
> Oops: 0002 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 0 PID: 98 Comm: poc.npd Not tainted 6.4.0-rc7-00072-gdad9774deaf1 #8
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.o4
> RIP: 0010:memcpy_orig+0xad/0x140
> Code: e8 4c 89 5f e0 48 8d 7f e0 73 d2 83 c2 20 48 29 d6 48 29 d7 83 fa 10 72 34 4c 8b 06 4c 8b 4e 08 c
> RSP: 0018:ffff888008f57658 EFLAGS: 00000202
> RAX: 0000000000000000 RBX: ffff888008bd0000 RCX: ffffffff8238e571
> RDX: 0000000000000018 RSI: ffff888007f64844 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff888008f57818
> R13: ffff888007f64aa4 R14: 0000000000000000 R15: 0000000000000000
> FS:  00000000014013c0(0000) GS:ffff88806d600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 00000000054d8000 CR4: 00000000000006f0
> Call Trace:
>  <TASK>
>  ? __die+0x1f/0x70
>  ? page_fault_oops+0x1e8/0x500
>  ? __pfx_is_prefetch.constprop.0+0x10/0x10
>  ? __pfx_page_fault_oops+0x10/0x10
>  ? _raw_spin_unlock_irqrestore+0x11/0x40
>  ? fixup_exception+0x36/0x460
>  ? _raw_spin_unlock_irqrestore+0x11/0x40
>  ? exc_page_fault+0x5e/0xc0
>  ? asm_exc_page_fault+0x26/0x30
>  ? xfrm_update_ae_params+0xd1/0x260
>  ? memcpy_orig+0xad/0x140
>  ? __pfx__raw_spin_lock_bh+0x10/0x10
>  xfrm_update_ae_params+0xe7/0x260
>  xfrm_new_ae+0x298/0x4e0
>  ? __pfx_xfrm_new_ae+0x10/0x10
>  ? __pfx_xfrm_new_ae+0x10/0x10
>  xfrm_user_rcv_msg+0x25a/0x410
>  ? __pfx_xfrm_user_rcv_msg+0x10/0x10
>  ? __alloc_skb+0xcf/0x210
>  ? stack_trace_save+0x90/0xd0
>  ? filter_irq_stacks+0x1c/0x70
>  ? __stack_depot_save+0x39/0x4e0
>  ? __kasan_slab_free+0x10a/0x190
>  ? kmem_cache_free+0x9c/0x340
>  ? netlink_recvmsg+0x23c/0x660
>  ? sock_recvmsg+0xeb/0xf0
>  ? __sys_recvfrom+0x13c/0x1f0
>  ? __x64_sys_recvfrom+0x71/0x90
>  ? do_syscall_64+0x3f/0x90
>  ? entry_SYSCALL_64_after_hwframe+0x72/0xdc
>  ? copyout+0x3e/0x50
>  netlink_rcv_skb+0xd6/0x210
>  ? __pfx_xfrm_user_rcv_msg+0x10/0x10
>  ? __pfx_netlink_rcv_skb+0x10/0x10
>  ? __pfx_sock_has_perm+0x10/0x10
>  ? mutex_lock+0x8d/0xe0
>  ? __pfx_mutex_lock+0x10/0x10
>  xfrm_netlink_rcv+0x44/0x50
>  netlink_unicast+0x36f/0x4c0
>  ? __pfx_netlink_unicast+0x10/0x10
>  ? netlink_recvmsg+0x500/0x660
>  netlink_sendmsg+0x3b7/0x700
> 
> This Null-ptr-deref bug is assigned CVE-2023-3772. And this commit
> adds additional NULL check in xfrm_update_ae_params to fix the NPD.
> 
> Fixes: d8647b79c3b7 ("xfrm: Add user interface for esn and big anti-replay windows")
> Signed-off-by: Lin Ma <linma@zju.edu.cn>
> ---
> V1 -> V2: fix some typos: impelementation -> implementation,
>           frm_update_ae_params -> xfrm_update_ae_params
> 
>  net/xfrm/xfrm_user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index c34a2a06ca94..bf2564967501 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -628,7 +628,7 @@ static void xfrm_update_ae_params(struct xfrm_state *x, struct nlattr **attrs,
>  	struct nlattr *rt = attrs[XFRMA_REPLAY_THRESH];
>  	struct nlattr *mt = attrs[XFRMA_MTIMER_THRESH];
>  
> -	if (re) {
> +	if (re && x->replay_esn && x->preplay_esn) {

If x->replay_esn is valid, x->preplay_esn will be valid too.

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
