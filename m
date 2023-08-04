Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2B9770054
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 14:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjHDMgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 08:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjHDMgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 08:36:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8449046A8
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 05:36:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 227DC61FCF
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 12:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4418CC433C7;
        Fri,  4 Aug 2023 12:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691152600;
        bh=r4MNY7O5eaMs63HW20BxvgFW0K+py7nZoEnkFvTqx+c=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=Buz5UfffosTI/wRzWTWFn/2KSYzSDf9DffjdMxd5fxjGhLFr4YDCMW9POQt2O4DTU
         Gfn4SjmNNxWIZ2S4MBsqUk0Wy8MAinG8XzAMrhInh0X5Sd5zRsbY/4NAeLWYQiMPox
         kOFt7xDQC2wmE9xFzI6LNwe2xOcewCtzCzI3NyLk1jaAD9K0HNkKAiD540EUwdavYl
         nB7Dw5iBc/TwKzMY/kFGLzDK/OBcBChEOqaOqTQLRwQ7kZuOQiq2iQTNVwlwNRS152
         UinEqG5cXHGaTZ2CyveQ1+pHIXb4LYq2cue7NFq+uXSnbVp4rKgUT3mLqrHoijjqL8
         ESUKCm4BXvSuQ==
Message-ID: <ba96db35-2273-9cc5-9a32-e924e8eff37c@kernel.org>
Date:   Fri, 4 Aug 2023 14:36:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     hawk@kernel.org, "brouer@redhat.com" <brouer@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
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
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>
References: <20230731060025.3117343-1-wei.fang@nxp.com>
 <20230802104706.5ce541e9@kernel.org>
 <AM5PR04MB313985C61D92E183238809138808A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <1bf41ea8-5131-7d54-c373-00c1fbcac095@redhat.com>
 <AM5PR04MB31398ABF941EBDD0907E845B8808A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <cc24e860-7d6f-7ec8-49cb-a49cb066f618@kernel.org>
 <AM5PR04MB3139D8AAAB6B96B58425BBA08809A@AM5PR04MB3139.eurprd04.prod.outlook.com>
From:   Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <AM5PR04MB3139D8AAAB6B96B58425BBA08809A@AM5PR04MB3139.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/08/2023 05.06, Wei Fang wrote:
>>> The FEC of i.MX8MP-EVK has dma_coherent=false, and as I mentioned
>>> above, I did not see an obvious difference in the performance. :(
>>
>> That is surprising - given the results.
>>
>> (see below, lack of perf/diff might be caused by Ethernet flow-control).
>>
>>>
>>>>> The result of the current modification.
>>>>> root@imx8mpevk:~# ./xdp2 eth0
>>>>> proto 17:     260180 pkt/s
>>>>
>>>> These results are*significantly*  better than reported in patch-1.
>>>> What happened?!?
>>>>
>>> The test environment is slightly different, in patch-1, the FEC port
>>> was directly connected to the port of another board. But in the latest
>>> test, the ports of the two boards were connected to a switch, so the
>>> ports of the two boards are not directly connected.
>>>
>>
>> Hmm, I've seen this kind of perf behavior of direct-connected or via switch
>> before. The mistake I made was, that I had not disabled Ethernet flow-control.
>> The xdp2 XDP_TX program will swap the mac addresses, and send the packet
>> back to the packet generator (running pktgen), which will get overloaded
>> itself and starts sending Ethernet flow-control pause frames.
>>
>> Command line to disable:
>>    # ethtool -A eth0 rx off tx off
>>
>> Can I ask/get you to make sure that Ethernet flow-control is disabled (on
>> both generator and DUT (to be on safe-side)) and run the test again?
>>
> The flow-control was not disabled before, so according to your suggestion,
> I disable the flow-control on the both boards and run the test again, the
> performance is slightly improved, but still can not see a clear difference
> between the two methods. Below are the results.

Something else must be stalling the CPU.
When looking at fec_main.c code, I noticed that 
fec_enet_txq_xmit_frame() will do a MMIO write for every xdp_frame (to 
trigger transmit start), which I believe will stall the CPU.
The ndo_xdp_xmit/fec_enet_xdp_xmit does bulking, and should be the 
function that does the MMIO write to trigger transmit start.

$ git diff
diff --git a/drivers/net/ethernet/freescale/fec_main.c 
b/drivers/net/ethernet/freescale/fec_main.c
index 03ac7690b5c4..57a6a3899b80 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3849,9 +3849,6 @@ static int fec_enet_txq_xmit_frame(struct 
fec_enet_private *fep,

         txq->bd.cur = bdp;

-       /* Trigger transmission start */
-       writel(0, txq->bd.reg_desc_active);
-
         return 0;
  }

@@ -3880,6 +3877,9 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
                 sent_frames++;
         }

+       /* Trigger transmission start */
+       writel(0, txq->bd.reg_desc_active);
+
         __netif_tx_unlock(nq);

         return sent_frames;


> Result: use "sync_dma_len" method
> root@imx8mpevk:~# ./xdp2 eth0

The xdp2 (and xdp1) program(s) have a performance issue
(due to using

Can I ask you to test using xdp_rxq_info, like:

  sudo ./xdp_rxq_info --dev mlx5p1 --action XDP_TX


> proto 17:     258886 pkt/s
> proto 17:     258879 pkt/s

If you provide numbers for xdp_redirect, then we could better evaluate
if changing the lock per xdp_frame, for XDP_TX also, is worth it.

And also find out of moving the MMIO write have any effect.

I also noticed driver does a MMIO write (on rxq) for every RX-packet in
fec_enet_rx_queue() napi-poll loop.  This also looks like a potential
performance stall.

--Jesper



