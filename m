Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6147EA39F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjKMTQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjKMTPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:15:53 -0500
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB58C385C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:14:44 -0800 (PST)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 2cNFrerPZFh5i2cOPrKNl3; Mon, 13 Nov 2023 20:14:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1699902882;
        bh=cw7DzfrPCld7xSzODOtzNR7CsG05Gedc/Tg0+WmnlFY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Vus6hJZdgAD6gPCyctSi31zSnS0OffNGTJcUNC8rjmd7KNN8TVaQHEsaYDS0DbwfE
         BNjCprzVTYa0zAKJSAOnNn1BWahlyLOoeqgyL7L//dd3zzr35cfjlQ3Er4/xgMhNSa
         rkgvBPTxuq4KV40bgzZQ+PBA33/XWVHoSsP30vch+9OCwYhmTWtzOM+pkJNu0x/P4I
         oJrrPJWNjjMYh+Ocfww8DN+wDBzbH1U8rtPstYuMm6mGtJVEJxpb6s6bkRKk2mtuA+
         GRLBzAlkeqejoUEIsr8O9gKrpldQ3i4myYLIO7WAV6s9TV1ZV+Rzol11mzFSz/SvNO
         0xBX2LYqcD6ng==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 13 Nov 2023 20:14:42 +0100
X-ME-IP: 86.243.2.178
Message-ID: <cc2273ef-3539-41c3-b333-f87b309e895b@wanadoo.fr>
Date:   Mon, 13 Nov 2023 20:14:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: pata_pxa: convert not to use
 dma_request_slave_channel()
Content-Language: fr
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <f177835b7f0db810a132916c8a281bbdaf47f9d3.1699801657.git.christophe.jaillet@wanadoo.fr>
 <ZVHYK1rI9Z8DcKJP@x1-carbon> <6e798343-1880-1c58-dd8e-1bd556f6a75b@omp.ru>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <6e798343-1880-1c58-dd8e-1bd556f6a75b@omp.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 13/11/2023 à 11:17, Sergey Shtylyov a écrit :
> On 11/13/23 11:05 AM, Niklas Cassel wrote:
> [...]
>>> dma_request_slave_channel() is deprecated. dma_request_chan() should
>>> be used directly instead.
>>>
>>> Switch to the preferred function and update the error handling accordingly.
>>>
>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>> ---
>>>   drivers/ata/pata_pxa.c | 5 ++---
>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
>>> index 5275c6464f57..0c9c9cf63d36 100644
>>> --- a/drivers/ata/pata_pxa.c
>>> +++ b/drivers/ata/pata_pxa.c
>>> @@ -274,9 +274,8 @@ static int pxa_ata_probe(struct platform_device *pdev)
>>>   	/*
>>>   	 * Request the DMA channel
>>>   	 */
>>> -	data->dma_chan =
>>> -		dma_request_slave_channel(&pdev->dev, "data");
>>> -	if (!data->dma_chan)
>>> +	data->dma_chan = dma_request_chan(&pdev->dev, "data");
>>
>> While the previous API could only return NULL on failure, the new API can
>> return an actual error.
>>
>> I think we should return the actual error instead of -EBUSY.
>>
>> i.e.:
>>
>> if (IS_ERR(data->dma_chan))
>> 	return PTR_ERR(data->dma_chan);
> 
>     Agreed. Christophe, please fix.

Will do.

Thx for both of you for the review.

CJ

> 
> [...]
>>> +	if (IS_ERR(data->dma_chan))
>>>   		return -EBUSY;
>>>   	ret = dmaengine_slave_config(data->dma_chan, &config);
>>>   	if (ret < 0) {
> [...]
> 
>> Kind regards,
>> Niklas
> 
> MBR, Sergey
> 

