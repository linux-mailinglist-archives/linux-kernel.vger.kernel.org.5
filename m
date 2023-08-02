Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8110D76CFCB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbjHBOOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjHBOOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:14:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7DB10E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 07:14:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D70E619A5
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 14:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09C9C433C7;
        Wed,  2 Aug 2023 14:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690985641;
        bh=ixO3LW1/xG1Uw3thkOLsUVsmX4WxJS5JtOiOzZ6KopY=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=kAuYgegW0u5NM64phkQrrDrwF4h7B7xnXN7p6M/F8Cd2MBPO4F4ncJ0OmtVgZJd6n
         PpfcX8GuHc+9uqwDuCdBIgRYjUyPa+lqbOb+xeUHSAS1lcGeFoi3JpiWoN4Ag/trJS
         3Gssh3DwqDbyIPqIzi/ymfay+iI/x6/9y+t4vEd8SvqPUQXkFt17viu78FZyXoP0DF
         z/tX65EyO7MUu9U/wGTATJ/2GA1h0d2pcy6Jc4CE/g8tZnT6gDSk97ZTcMSSZ1Xpk3
         NzQmFE+TooPwhS+mlV7Yii3FF4Cqt8Y7D4f4kSl1sXBvMs0eAEqc75DJAVUZLUw0il
         aiV+0RKKtxCdA==
Message-ID: <2cb34364-0d7c-cf0a-487f-c15ba6568ac8@kernel.org>
Date:   Wed, 2 Aug 2023 16:13:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com
Subject: Re: [PATCH v4 1/2] drivers: net: prevent tun_build_skb() to exceed
 the packet size limit
Content-Language: en-US
To:     Andrew Kanner <andrew.kanner@gmail.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jasowang@redhat.com, netdev@vger.kernel.org, dsahern@gmail.com,
        jbrouer@redhat.com, john.fastabend@gmail.com,
        linux-kernel@vger.kernel.org
References: <20230801220710.464-1-andrew.kanner@gmail.com>
From:   Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20230801220710.464-1-andrew.kanner@gmail.com>
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
> Using the syzkaller repro with reduced packet size it was discovered
> that XDP_PACKET_HEADROOM is not checked in tun_can_build_skb(),
> although pad may be incremented in tun_build_skb(). This may end up
> with exceeding the PAGE_SIZE limit in tun_build_skb().
> 
> Fixes: 7df13219d757 ("tun: reserve extra headroom only when XDP is set")
> Link: https://syzkaller.appspot.com/bug?extid=f817490f5bd20541b90a
> Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
> ---
> 
> Notes:
>      v3 -> v4:
>      * fall back to v1, fixing only missing XDP_PACKET_HEADROOM in pad and
>        removing bpf_xdp_adjust_tail() check for frame_sz.
>      * added rcu read lock, noted by Jason Wang <jasowang@redhat.com> in v1
>      * I decided to leave the packet length check in tun_can_build_skb()
>        instead of moving to tun_build_skb() suggested by Jason Wang
>        <jasowang@redhat.com>. Otherwise extra packets will be dropped
>        without falling back to tun_alloc_skb(). And in the discussion of v3
>        Jesper Dangaard Brouer <jbrouer@redhat.com> noticed that XDP is ok
>        with a higher order pages if it's a contiguous physical memory
>        allocation, so falling to tun_alloc_skb() -> do_xdp_generic() should
>        be ok.
>      
>      v2 -> v3:
>      * attach the forgotten changelog
>      
>      v1 -> v2:
>      * merged 2 patches in 1, fixing both issues: WARN_ON_ONCE with
>        syzkaller repro and missing XDP_PACKET_HEADROOM in pad
>      * changed the title and description of the execution path, suggested
>        by Jason Wang <jasowang@redhat.com>
>      * move the limit check from tun_can_build_skb() to tun_build_skb() to
>        remove duplication and locking issue, and also drop the packet in
>        case of a failed check - noted by Jason Wang <jasowang@redhat.com>
> 
>   drivers/net/tun.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index d75456adc62a..a1d04bc9485f 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1582,6 +1582,9 @@ static void tun_rx_batched(struct tun_struct *tun, struct tun_file *tfile,
>   static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *tfile,
>   			      int len, int noblock, bool zerocopy)
>   {
> +	struct bpf_prog *xdp_prog;
> +	int pad = TUN_RX_PAD;
> +
>   	if ((tun->flags & TUN_TYPE_MASK) != IFF_TAP)
>   		return false;
>   
> @@ -1594,7 +1597,13 @@ static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *tfile,
>   	if (zerocopy)
>   		return false;
>   
> -	if (SKB_DATA_ALIGN(len + TUN_RX_PAD) +
> +	rcu_read_lock();
> +	xdp_prog = rcu_dereference(tun->xdp_prog);
> +	if (xdp_prog)
> +		pad += XDP_PACKET_HEADROOM;
> +	rcu_read_unlock();
> +

Isolated seen, I guess, this is a correct fix to 7df13219d757.

> +	if (SKB_DATA_ALIGN(len + pad) +
>   	    SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) > PAGE_SIZE)
>   		return false;
>   

Question to Jason Wang:
Why fall back (to e.g. tun_alloc_skb()) when size is above PAGE_SIZE?

AFAIK tun_build_skb() *can* create get larger packets than PAGE_SIZE
from it's page_frag.  Is there a reason for this limitation?

(To Andrew, I assume a change in this area is another patch).

--Jesper



