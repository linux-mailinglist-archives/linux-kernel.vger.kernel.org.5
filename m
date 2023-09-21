Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713187A907E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 03:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjIUBbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 21:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjIUBbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 21:31:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6108A9;
        Wed, 20 Sep 2023 18:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=oDg0WGIN2fvsDDknMzDVZr16rUkRGc5v11vaiK+QtYs=; b=dM9d58dTaZPTuT//EVl1bbpczu
        XedYnCmkaILRfWmUhNA04eZjGZLV7ABuenKqnuqlwTSl7fr97TA1t3zyXXhikYrNR8o8bw8xOX1fH
        EhLtjdsh+HUu+JDaAbXHpW3ltASl70Y0OFRD/nwH/02QrtASzyduONNlxs8raGmSh7phWQPRXosII
        DTjmI5rYljQQjfPacRMRvrwmmS79s/i+9o+W/6cgHViAidNUVk59y8Q97Ou+PMIngEAUX7+/Cyci5
        BubskgM9gSmDq+KMGiATuL2V8J59sUKGq1mUpv4QZgEuk6AaggiJh7A9c35YfskLoI1XH3z8zT8ou
        6r4jHwgg==;
Received: from [2601:1c2:980:9ec0::9fed]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qj8Wz-004eOO-2w;
        Thu, 21 Sep 2023 01:31:01 +0000
Message-ID: <8eaece43-a30d-45e8-9610-28ed2af842fc@infradead.org>
Date:   Wed, 20 Sep 2023 18:30:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next 3/3] idpf: fix undefined
 reference to tcp_gro_complete() when !CONFIG_INET
Content-Language: en-US
To:     Jacob Keller <jacob.e.keller@intel.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Michal Michalik <michal.michalik@intel.com>,
        netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
        linux-kernel@vger.kernel.org,
        Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
        intel-wired-lan@lists.osuosl.org,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Milena Olech <milena.olech@intel.com>
References: <20230920180745.1607563-1-aleksander.lobakin@intel.com>
 <20230920180745.1607563-4-aleksander.lobakin@intel.com>
 <2038f544-859f-4ffb-9840-37c1ba289259@infradead.org>
 <0df556eb-71b2-9612-a81d-cd83c27a2cd7@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <0df556eb-71b2-9612-a81d-cd83c27a2cd7@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/20/23 17:04, Jacob Keller wrote:
> 
> 
> On 9/20/2023 2:30 PM, Randy Dunlap wrote:
>>
>>
>> On 9/20/23 11:07, Alexander Lobakin wrote:
>>> When CONFIG_INET is not set, tcp_gro_complete is not compiled, although
>>> the drivers using it may still be compiled (spotted by Randy):
>>>
>>> aarch64-linux-ld: drivers/net/ethernet/intel/idpf/idpf_txrx.o:
>>> in function `idpf_rx_rsc.isra.0':
>>> drivers/net/ethernet/intel/idpf/idpf_txrx.c:2909:(.text+0x40cc):
>>> undefined reference to `tcp_gro_complete'
>>>
>>> The drivers need to guard the calls to it manually.
>>> Return early from the RSC completion function if !CONFIG_INET, it won't
>>> work properly either way. This effectively makes it be compiled-out
>>> almost entirely on such builds.
>>>
>>> Fixes: 3a8845af66ed ("idpf: add RX splitq napi poll support")
>>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>>> Closes: https://lore.kernel.org/linux-next/4c84eb7b-3dec-467b-934b-8a0240f7fb12@infradead.org
>>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>
>> That builds for me.  Thanks.
>>
>> Tested-by: Randy Dunlap <rdunlap@infradead.org>
>>
>> I hope that these patches can be merged into the v6.6 instead of
>> v6.7 kernel at some point (i.e., [PATCH net] instead of net-next).
>>
> 
> Did any of the offending code make it into 6.6? I thought all of this
> was from recent merges after 6.6 closed.
> 
> Thanks,
> Jake

Oh, I think that you are correct. Sorry about my comment.
Thanks.

> 
>>
>>> ---
>>>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
>>> index 6fa79898c42c..aa45afeb6496 100644
>>> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
>>> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
>>> @@ -2876,6 +2876,9 @@ static int idpf_rx_rsc(struct idpf_queue *rxq, struct sk_buff *skb,
>>>  	if (unlikely(!(ipv4 ^ ipv6)))
>>>  		return -EINVAL;
>>>  
>>> +	if (!IS_ENABLED(CONFIG_INET))
>>> +		return 0;
>>> +
>>>  	rsc_segments = DIV_ROUND_UP(skb->data_len, rsc_seg_len);
>>>  	if (unlikely(rsc_segments == 1))
>>>  		return 0;
>>

-- 
~Randy
