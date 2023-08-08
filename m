Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9F57742A8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjHHRrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbjHHRps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:45:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A5B25EFB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:20:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4272A624DA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 11:33:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62B7C433C8;
        Tue,  8 Aug 2023 11:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691494387;
        bh=zPQVZA2bYSxwCU7Qt24oCwtT7WsU+CJx5qmZPXjM4nw=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=W6z8p4EOQkKq8F4V6ISKH5JVTBVOxPy9s8s8k+1ozawe46TIvVUu2oUxM4GW6LAjV
         D024Kz2Woi6e/qCeiC4qXd1bHU/iMjZyXMuaRbNia1t8JvbY/r1PWpWWWEonbbSgTP
         ZZ73/6bqb4e1Q4kW1gtJd/d0muWJwhvfwvZJetpmynxTSQSKkYrc6kT+3P4dW3vw8t
         HQ/mKznQwl+VBI2SwjiGSc2DIInlzskkyZtkpIOZIKvhRKSqbjTkzilHY2tXa0CjfV
         FCW4Zi7kjIGGenoat+KfuntjFAGKBWuc9DM77xOVBrxYPZwitz9WEv1C1zcTYOltqk
         eta5+GSpR3Kcg==
Message-ID: <aa9ec752-9f59-056f-da52-7ec5047e4642@kernel.org>
Date:   Tue, 8 Aug 2023 13:33:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH V3 net-next] net: fec: add XDP_TX feature support
Content-Language: en-US
To:     Wei Fang <wei.fang@nxp.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>
References: <20230731060025.3117343-1-wei.fang@nxp.com>
 <20230802104706.5ce541e9@kernel.org>
 <AM5PR04MB313985C61D92E183238809138808A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <1bf41ea8-5131-7d54-c373-00c1fbcac095@redhat.com>
 <AM5PR04MB31398ABF941EBDD0907E845B8808A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <cc24e860-7d6f-7ec8-49cb-a49cb066f618@kernel.org>
 <AM5PR04MB3139D8AAAB6B96B58425BBA08809A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <ba96db35-2273-9cc5-9a32-e924e8eff37c@kernel.org>
 <AM5PR04MB313903036E0DF277FEC45722880CA@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <8fd0313b-8f6f-9814-247d-c2687d053e2a@kernel.org>
 <AM5PR04MB313980263DAD261D114B3DA4880DA@AM5PR04MB3139.eurprd04.prod.outlook.com>
From:   Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <AM5PR04MB313980263DAD261D114B3DA4880DA@AM5PR04MB3139.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/08/2023 07.02, Wei Fang wrote:
>>> For XDP_REDIRECT, the performance show as follow.
>>> root@imx8mpevk:~# ./xdp_redirect eth1 eth0 Redirecting from eth1
>>> (ifindex 3; driver st_gmac) to eth0 (ifindex 2; driver fec)
>>
>> This is not exactly the same as XDP_TX setup as here you choose to redirect
>> between eth1 (driver st_gmac) and to eth0 (driver fec).
>>
>> I would like to see eth0 to eth0 XDP_REDIRECT, so we can compare to
>> XDP_TX performance.
>> Sorry for all the requests, but can you provide those numbers?
>>
> 
> Oh, sorry, I thought what you wanted were XDP_REDIRECT results for different
> NICs. Below is the result of XDP_REDIRECT on the same NIC.
> root@imx8mpevk:~# ./xdp_redirect eth0 eth0
> Redirecting from eth0 (ifindex 2; driver fec) to eth0 (ifindex 2; driver fec)
> Summary        232,302 rx/s        0 err,drop/s      232,344 xmit/s
> Summary        234,579 rx/s        0 err,drop/s      234,577 xmit/s
> Summary        235,548 rx/s        0 err,drop/s      235,549 xmit/s
> Summary        234,704 rx/s        0 err,drop/s      234,703 xmit/s
> Summary        235,504 rx/s        0 err,drop/s      235,504 xmit/s
> Summary        235,223 rx/s        0 err,drop/s      235,224 xmit/s
> Summary        234,509 rx/s        0 err,drop/s      234,507 xmit/s
> Summary        235,481 rx/s        0 err,drop/s      235,482 xmit/s
> Summary        234,684 rx/s        0 err,drop/s      234,683 xmit/s
> Summary        235,520 rx/s        0 err,drop/s      235,520 xmit/s
> Summary        235,461 rx/s        0 err,drop/s      235,461 xmit/s
> Summary        234,627 rx/s        0 err,drop/s      234,627 xmit/s
> Summary        235,611 rx/s        0 err,drop/s      235,611 xmit/s
>    Packets received    : 3,053,753
>    Average packets/s   : 234,904
>    Packets transmitted : 3,053,792
>    Average transmit/s  : 234,907
>>
>> I'm puzzled that moving the MMIO write isn't change performance.
>>
>> Can you please verify that the packet generator machine is sending more
>> frame than the system can handle?
>>
>> (meaning the pktgen_sample03_burst_single_flow.sh script fast enough?)
>>
> 
> Thanks very much!
> You remind me, I always started the pktgen script first and then ran the xdp2
> program in the previous tests. So I saw the transmit speed of the generator
> was always greater than the speed of XDP_TX when I stopped the script. But
> actually, the real-time transmit speed of the generator was degraded to as
> equal to the speed of XDP_TX.
> 

Good that we finally found the root-cause, that explains why it seems
our code changes didn't have any effect.  The generator gets affected
and slowed down due to the traffic that is bounced back to it. (I tried
to hint this earlier with the Ethernet Flow-Control settings).

> So I turned off the rx function of the generator in case of increasing the CPU
> loading of the generator due to the returned traffic from xdp2. 

How did you turned off the rx function of the generator?
(I a couple of tricks I use)

> And I tested
> the performance again. Below are the results.
> 
> Result 1: current method
> root@imx8mpevk:~# ./xdp2 eth0
> proto 17:     326539 pkt/s
> proto 17:     326464 pkt/s
> proto 17:     326528 pkt/s
> proto 17:     326465 pkt/s
> proto 17:     326550 pkt/s
> 
> Result 2: sync_dma_len method
> root@imx8mpevk:~# ./xdp2 eth0
> proto 17:     353918 pkt/s
> proto 17:     352923 pkt/s
> proto 17:     353900 pkt/s
> proto 17:     352672 pkt/s
> proto 17:     353912 pkt/s
> 

This looks more promising:
  ((353912/326550)-1)*100 = 8.37% faster.

Or gaining/saving approx 236 nanosec per packet ((1/326550-1/353912)*10^9).

> Note: the speed of the generator is about 935397pps.
> 
> Compared result 1 with result 2. The "sync_dma_len" method actually improves
> the performance of XDP_TX, so the conclusion from the previous tests is *incorrect*.
> I'm so sorry for that. :(
> 

I'm happy that we finally found the root-cause.
Thanks for doing all the requested tests I asked for.

> In addition, I also tried the "dma_sync_len" + not use xdp_convert_buff_to_frame()
> method, the performance has been further improved. Below is the result.
> 
> Result 3: sync_dma_len + not use xdp_convert_buff_to_frame() method
> root@imx8mpevk:~# ./xdp2 eth0
> proto 17:     369261 pkt/s
> proto 17:     369267 pkt/s
> proto 17:     369206 pkt/s
> proto 17:     369214 pkt/s
> proto 17:     369126 pkt/s
> 
> Therefore, I'm intend to use the "dma_sync_len"+ not use xdp_convert_buff_to_frame()
> method in the V5 patch. Thank you again, Jesper and Jakub. You really helped me a lot. :)
> 

I suggest, that V5 patch still use xdp_convert_buff_to_frame(), and then
you send followup patch (or as 2/2 patch) that remove the use of
xdp_convert_buff_to_frame() for XDP_TX.  This way it is easier to keep
track of the changes and improvements.

I would be very interested in knowing if the MMIO test change after this
correction to the testlab/generator.

--Jesper
