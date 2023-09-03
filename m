Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E43790C95
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 17:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241959AbjICPE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 11:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjICPE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 11:04:57 -0400
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D45116
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 08:04:50 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id coedqFIfsPnvscoedq11w0; Sun, 03 Sep 2023 17:04:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1693753488;
        bh=jKoUYb09gGu7FzODWXf/YNYwwFG/WPF7F5CxMSBP/HI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=XUSqYTLhGozU6PLT24lNsYtT/2KsRirBALIAlLT0ExJ0CwqoCZNtqftriK8hX7G6m
         44k4wJcpKYnS/4JW/fYW+lhL3Kd+wO+G98jAvbZvbOmQBAr9xO3pHi+Uv2P/QQerNY
         wMsqDcidCNnc2V/thuAdH37Q/p8/A2QJzPuAAjB6Bb4PJhATYKzY7Fh31LyYG10zcv
         nzUg/algK73W7i2Y6UOAMu7zxcU2J98GslvvLtHohEeOGqwhYD66+YTUx8iRhtn6YC
         fh2wj5Mr3hIG12wO6jpqYoynIx/OHiXs15LV7JNYsJ7zjmCe7zY0QxLaLlzSvPriQu
         l32SvQ7+hUsNQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 03 Sep 2023 17:04:48 +0200
X-ME-IP: 86.243.2.178
Message-ID: <8cde2320-517f-3a38-8c3f-f807791c6c52@wanadoo.fr>
Date:   Sun, 3 Sep 2023 17:04:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ALSA: usb-audio: Fix a potential memory leak in
 scarlett2_init_notify()
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        alsa-devel@alsa-project.org
References: <fc275ed315b9157952dcf2744ee7bdb78defdb5f.1693746347.git.christophe.jaillet@wanadoo.fr>
 <871qffmj2d.wl-tiwai@suse.de>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <871qffmj2d.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 03/09/2023 à 16:23, Takashi Iwai a écrit :
> On Sun, 03 Sep 2023 15:06:00 +0200,
> Christophe JAILLET wrote:
>>
>> If usb_alloc_coherent() or usb_urb_ep_type_check() fail, we should release
>> the resources previously allocated.
> 
> Those are freed in the caller side, start_input_streams() instead.

Thanks for the fast review.

Hmpm, If IIUC, resources allocated *before* the ending "ep->num_urbs++" 
still need to be freed here, otherwise free_midi_urbs() in the caller 
will not free them.

Do you agree?

If yes, I can send v2 which would look like:
	usb_alloc_urb()
	if (err)
		return -ENOMEM

	usb_alloc_coherent()
	if (err) {
		usb_free_urb()
		urb = NULL
		return -ENOMEM
	}
	
	 usb_urb_ep_type_check()
	if (err) {
		usb_free_coherent()
		usb_free_urb()
		urb = NULL
		return -err
	}

Or, if yuo prefer, with an error handling path just like below, but 
without the final free_midi_urbs() + a comment explaining that the 
caller does this part of job instead.

CJ

> 
> 
> thanks,
> 
> Takashi
> 
>>
>> Fixes: ff49d1df79ae ("ALSA: usb-audio: USB MIDI 2.0 UMP support")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   sound/usb/midi2.c | 17 ++++++++++++++---
>>   1 file changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/sound/usb/midi2.c b/sound/usb/midi2.c
>> index a27e244650c8..4109c82adff6 100644
>> --- a/sound/usb/midi2.c
>> +++ b/sound/usb/midi2.c
>> @@ -302,7 +302,8 @@ static int alloc_midi_urbs(struct snd_usb_midi2_endpoint *ep)
>>   		ctx->urb = usb_alloc_urb(0, GFP_KERNEL);
>>   		if (!ctx->urb) {
>>   			dev_err(&ep->dev->dev, "URB alloc failed\n");
>> -			return -ENOMEM;
>> +			err = -ENOMEM;
>> +			goto err_free_all;
>>   		}
>>   		ctx->ep = ep;
>>   		buffer = usb_alloc_coherent(ep->dev, len, GFP_KERNEL,
>> @@ -310,7 +311,8 @@ static int alloc_midi_urbs(struct snd_usb_midi2_endpoint *ep)
>>   		if (!buffer) {
>>   			dev_err(&ep->dev->dev,
>>   				"URB buffer alloc failed (size %d)\n", len);
>> -			return -ENOMEM;
>> +			err = -ENOMEM;
>> +			goto err_free_cur_urb;
>>   		}
>>   		if (ep->interval)
>>   			usb_fill_int_urb(ctx->urb, ep->dev, ep->pipe,
>> @@ -322,13 +324,22 @@ static int alloc_midi_urbs(struct snd_usb_midi2_endpoint *ep)
>>   		if (err < 0) {
>>   			dev_err(&ep->dev->dev, "invalid MIDI EP %x\n",
>>   				endpoint);
>> -			return err;
>> +			goto err_free_cur_dma;
>>   		}
>>   		ctx->urb->transfer_flags = URB_NO_TRANSFER_DMA_MAP;
>>   		ep->num_urbs++;
>>   	}
>>   	ep->urb_free = ep->urb_free_mask = GENMASK(ep->num_urbs - 1, 0);
>>   	return 0;
>> +
>> +err_free_cur_dma:
>> +	usb_free_coherent(ep->dev, len, buffer, ctx->urb->transfer_dma);
>> +err_free_cur_urb:
>> +	usb_free_urb(ctx->urb);
>> +	ctx->urb = NULL;
>> +err_free_all:
>> +	free_midi_urbs(ep);
>> +	return err;
>>   }
>>   
>>   static struct snd_usb_midi2_endpoint *
>> -- 
>> 2.34.1
>>
> 

