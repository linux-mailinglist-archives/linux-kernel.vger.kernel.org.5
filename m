Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676E8790CA2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 17:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243127AbjICPIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 11:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243123AbjICPIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 11:08:31 -0400
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A5B116
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 08:08:24 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id coi3qCr0AbNd0coi4qbqwR; Sun, 03 Sep 2023 17:08:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1693753703;
        bh=3vbBQKPo4LJHiDDNu1Lpt1WO/D8AzSItjWjmWe5gbq8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=hpsDbBq0hKZCwQat/ZIqq9w4sx53uM36YjYqIk+2GzJJnrbYsApNAK6K376YZMh3Y
         YridCz3gFWp99me5kiRpM16zf2tf34HZ36JkGtxfTHRa1D1vh2XMPJy5u8EtwO16gO
         Yn2lXRujKdf5NwRv4+ELdOABRCwznCAfk+ClZB4b85aPxetGtTJdubXx/8D+lYVV50
         5PNFxk55viO4pR6TjXvvEb2ortM6IId3uWUMgOKGho1dsj2uCVJ8OuafX4i0ouPeuZ
         SrXDiuvpDBYtfW8jPB/SEOU7K/mRTYhhNHnLdqogvBwp3CraKUGNEFDuWNEn4vR+ma
         VXSZagSubZefA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 03 Sep 2023 17:08:23 +0200
X-ME-IP: 86.243.2.178
Message-ID: <6014901d-8fe6-9e80-171e-a1017cc9e0f9@wanadoo.fr>
Date:   Sun, 3 Sep 2023 17:08:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ALSA: scarlett2: Fix a potential memory leak in
 scarlett2_init_notify()
Content-Language: fr, en-US
To:     Takashi Iwai <tiwai@suse.de>
Cc:     "Geoffrey D. Bennett" <g@b4.vu>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org
References: <73aab53d53df156a5df2bc61314ff26448526749.1693744859.git.christophe.jaillet@wanadoo.fr>
 <87zg23l4bn.wl-tiwai@suse.de>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <87zg23l4bn.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 03/09/2023 à 16:27, Takashi Iwai a écrit :
> On Sun, 03 Sep 2023 14:41:45 +0200,
> Christophe JAILLET wrote:
>>
>> If kmalloc() fails, we should release 'mixer->urb'.
> 
> This is released at the common error path in mixer.c,
> snd_usb_mixer_free(), hence it's not needed.

Agreed, sorry for the noise.

CJ

> 
> And, even if freeing here, you must NULL-clear mixer->urb, too;
> otherwise it'll lead to double-free.
> 
> 
> thanks,
> 
> Takashi
> 
>>
>> Fixes: 9e4d5c1be21f ("ALSA: usb-audio: Scarlett Gen 2 mixer interface")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   sound/usb/mixer_scarlett_gen2.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
>> index 9d11bb08667e..a439c7f64b2e 100644
>> --- a/sound/usb/mixer_scarlett_gen2.c
>> +++ b/sound/usb/mixer_scarlett_gen2.c
>> @@ -4060,8 +4060,10 @@ static int scarlett2_init_notify(struct usb_mixer_interface *mixer)
>>   		return -ENOMEM;
>>   
>>   	transfer_buffer = kmalloc(private->wMaxPacketSize, GFP_KERNEL);
>> -	if (!transfer_buffer)
>> +	if (!transfer_buffer) {
>> +		usb_free_urb(mixer->urb);
>>   		return -ENOMEM;
>> +	}
>>   
>>   	usb_fill_int_urb(mixer->urb, dev, pipe,
>>   			 transfer_buffer, private->wMaxPacketSize,
>> -- 
>> 2.34.1
>>
> 

