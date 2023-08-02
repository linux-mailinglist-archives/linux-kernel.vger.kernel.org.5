Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F79776CF4E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbjHBN5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234495AbjHBN5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:57:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF8126A8
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 06:57:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 012C6619AB
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 13:57:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56FCBC433C8;
        Wed,  2 Aug 2023 13:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690984620;
        bh=nVYITZ3442VbPOgOxFRsX45Sw7B8Dvf9MYJFP4+/ATE=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=YeJlWpjoSfqKczx6p8jnSI9ynNyBUJege1FBpTi5Hb5AF0a6RFt1m6IUpqNfKrBbp
         DRika2vTcRKhdwnFDtXH8LzxU1xZjKsJF8ryQcuMaVvAb/HJMWGHj9Os9wyDv5/AkA
         UDvej7uuS5Pg3Pu1n+rNsI1jYLddm+XowPLS4awZS+ueyI+3BWQwJ13IQr6/p1ta18
         01um6QQ1ViFMo2vFWdMeUGfKzS1WbY3gBA/dHucMMd41cPOvUvTx+kEm0V6fVNAhLy
         KyVl2CvtLnh85pm6VVv0XCGO5/RBXCWsp9ynxnu31TlELRz2Tqc68Qajw+KCumW1CL
         OPPC4UZoY5nvA==
Message-ID: <3a66abd7-690e-c15a-54dd-a0719fd723a1@kernel.org>
Date:   Wed, 2 Aug 2023 15:56:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com
Subject: Re: [PATCH v4 2/2] net: core: remove unnecessary frame_sz check in
 bpf_xdp_adjust_tail()
Content-Language: en-US
To:     Andrew Kanner <andrew.kanner@gmail.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jasowang@redhat.com, netdev@vger.kernel.org, dsahern@gmail.com,
        jbrouer@redhat.com, john.fastabend@gmail.com,
        linux-kernel@vger.kernel.org
References: <20230801220710.464-1-andrew.kanner@gmail.com>
 <20230801220710.464-2-andrew.kanner@gmail.com>
From:   Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20230801220710.464-2-andrew.kanner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/08/2023 00.07, Andrew Kanner wrote:
> Syzkaller reported the following issue:
> =======================================
> Too BIG xdp->frame_sz = 131072
> WARNING: CPU: 0 PID: 5020 at net/core/filter.c:4121
>    ____bpf_xdp_adjust_tail net/core/filter.c:4121 [inline]
> WARNING: CPU: 0 PID: 5020 at net/core/filter.c:4121
>    bpf_xdp_adjust_tail+0x466/0xa10 net/core/filter.c:4103
> ...
> Call Trace:
>   <TASK>
>   bpf_prog_4add87e5301a4105+0x1a/0x1c
>   __bpf_prog_run include/linux/filter.h:600 [inline]
>   bpf_prog_run_xdp include/linux/filter.h:775 [inline]
>   bpf_prog_run_generic_xdp+0x57e/0x11e0 net/core/dev.c:4721
>   netif_receive_generic_xdp net/core/dev.c:4807 [inline]
>   do_xdp_generic+0x35c/0x770 net/core/dev.c:4866
>   tun_get_user+0x2340/0x3ca0 drivers/net/tun.c:1919
>   tun_chr_write_iter+0xe8/0x210 drivers/net/tun.c:2043
>   call_write_iter include/linux/fs.h:1871 [inline]
>   new_sync_write fs/read_write.c:491 [inline]
>   vfs_write+0x650/0xe40 fs/read_write.c:584
>   ksys_write+0x12f/0x250 fs/read_write.c:637
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> xdp->frame_sz > PAGE_SIZE check was introduced in commit c8741e2bfe87
> ("xdp: Allow bpf_xdp_adjust_tail() to grow packet size"). But Jesper
> Dangaard Brouer <jbrouer@redhat.com> noted that after introducing the
> xdp_init_buff() which all XDP driver use - it's safe to remove this
> check. The original intend was to catch cases where XDP drivers have
> not been updated to use xdp.frame_sz, but that is not longer a concern
> (since xdp_init_buff).
> 
> Running the initial syzkaller repro it was discovered that the
> contiguous physical memory allocation is used for both xdp paths in
> tun_get_user(), e.g. tun_build_skb() and tun_alloc_skb(). It was also
> stated by Jesper Dangaard Brouer <jbrouer@redhat.com> that XDP can
> work on higher order pages, as long as this is contiguous physical
> memory (e.g. a page).
> 
> Reported-and-tested-by: syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/000000000000774b9205f1d8a80d@google.com/T/
> Link: https://syzkaller.appspot.com/bug?extid=f817490f5bd20541b90a
> Link: https://lore.kernel.org/all/20230725155403.796-1-andrew.kanner@gmail.com/T/
> Fixes: 43b5169d8355 ("net, xdp: Introduce xdp_init_buff utility routine")
> Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
> ---

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

You can include that ACK in V5.

>   net/core/filter.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 06ba0e56e369..28a59596987a 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4116,12 +4116,6 @@ BPF_CALL_2(bpf_xdp_adjust_tail, struct xdp_buff *, xdp, int, offset)
>   	if (unlikely(data_end > data_hard_end))
>   		return -EINVAL;
>   
> -	/* ALL drivers MUST init xdp->frame_sz, chicken check below */
> -	if (unlikely(xdp->frame_sz > PAGE_SIZE)) {
> -		WARN_ONCE(1, "Too BIG xdp->frame_sz = %d\n", xdp->frame_sz);
> -		return -EINVAL;
> -	}
> -
>   	if (unlikely(data_end < xdp->data + ETH_HLEN))
>   		return -EINVAL;
>   
