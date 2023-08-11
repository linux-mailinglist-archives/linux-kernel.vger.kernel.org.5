Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3CE779274
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbjHKPJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjHKPJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:09:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41044171F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:09:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C312F66C07
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 15:09:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E404BC433C8;
        Fri, 11 Aug 2023 15:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691766541;
        bh=B9H8DIEwZ4OoBS2kfl3LqlTOO0srRHKGp/4wPDMFu1Q=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=f1/eNXFXk5g4fN8S4EVmpVE3o75jiLV9hpORZaLzoHe8uS0Tn2nDNTKRRwG6mvHzV
         /EINHN+MYIEeRDYWtrANimCcTqWxnaIUGPupJG2PHiqFxWQnL6IXYenZOWEEnZJ1Z5
         ckIB7zwK2fJuXah2nmrvK+9u1Rh4Bd1owAYwn8Ari/SICmCOMviC0qn6wYSCngSqUG
         mIhBpwscIRgedhLHJGBj+9MdvAd0in7K8eXNifwR3ZDODA6igUg5fHkQdrRpnF98PQ
         tu9KhElc1ONi0qP33OqTWFK7LOyluLZ9hqNpKf4kz33mBz/YcvGR0ozNr7/0LMs/lI
         PyoQ4Va6VxsOw==
Message-ID: <cc3d1319-d67e-3031-9351-95b45af797d4@kernel.org>
Date:   Fri, 11 Aug 2023 17:08:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH V5 net-next 1/2] net: fec: add XDP_TX feature support
Content-Language: en-US
To:     Wei Fang <wei.fang@nxp.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "larysa.zaremba@intel.com" <larysa.zaremba@intel.com>,
        "aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>,
        "jbrouer@redhat.com" <jbrouer@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20230810064514.104470-1-wei.fang@nxp.com>
 <20230810064514.104470-2-wei.fang@nxp.com>
 <a7ede79c-8d5f-0036-7b8d-67c736cea058@kernel.org>
 <AM5PR04MB3139BB2A930C4D7297FDA3348810A@AM5PR04MB3139.eurprd04.prod.outlook.com>
From:   Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <AM5PR04MB3139BB2A930C4D7297FDA3348810A@AM5PR04MB3139.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/08/2023 03.26, Wei Fang wrote:
>> If you add below code comment you can add my ACK in V6:
>>
> Okay, I will add the annotation to the code in V6. Thanks.
> 

Great, one adjustment to my suggested comment below.

>> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>
>>> @@ -1482,7 +1488,13 @@ fec_enet_tx_queue(struct net_device *ndev,
>> u16 queue_id, int budget)
>>>    			/* Free the sk buffer associated with this last transmit */
>>>    			dev_kfree_skb_any(skb);
>>>    		} else {
>>> -			xdp_return_frame(xdpf);
>>> +			if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO) {
>>> +				xdp_return_frame_rx_napi(xdpf);
>>> +			} else {
>>> +				struct page *page = virt_to_head_page(xdpf->data);
>>> +
>>
>> I think this usage of page_pool_put_page() with dma_sync_size=0 requires a
>> comment, else we will forget why this okay...
>> I suggest:
>>
>> /* PP dma_sync_size=0 as xmit already synced DMA for_device */
>>

I update my suggestion to:

  /* PP dma_sync_size=0 as XDP_TX already synced DMA for_device */

Reading code path there is an simple "else" to reach this spot, and it
will be good to hint to code-reader that this code path deals with
XDP_TX completion handling.

You are of-cause free to come up with a better comment yourself.

>>> +				page_pool_put_page(page->pp, page, 0, true);
>>> +			}
>>>
>>>    			txq->tx_buf[index].xdp = NULL;
>>>    			/* restore default tx buffer type: FEC_TXBUF_T_SKB */
>> @@ -1541,7
> 

--Jesper
