Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C4679817E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 07:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235871AbjIHFTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 01:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjIHFTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 01:19:06 -0400
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFBE1997
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 22:19:01 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id eTtSq3ExTwJ7JeTtSquAk1; Fri, 08 Sep 2023 07:18:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1694150339;
        bh=1aKK5/OKSU14ilyxwV1rrS2kE29ll/URZdd4NMDeNTc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=q4q6Wh9m0Z8Hyd9KGJQn1ZO4FH++Lpx9m0OUr59vZqQ09pZgTASZweCl/EWRilv89
         TeGiAtBOWhxs/cPalwIIDYqhItW+UBPH1jc46eCW5pDp0vhsmLhpY0USFPiFXbVrB5
         wOQAfmhfXxkOpCRbSLogIrEYmelyAeyMRT8f+lv/HaWAqbM1OM4A0Mbh0PnOMcVypW
         khEh+QB4PIKDwUYXUddtGezVBq+z2zJccttUhRV4PHd+oyvDnFL1IHiH/GzM/YWEsG
         7JGof2Jpy+mcfswNUoltHNWW9Ju2/uXrJ0o7V3MckF78PzcZeE8U1L6MyOAaIZ7tY5
         DuyqKGuSVJzSw==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 08 Sep 2023 07:18:59 +0200
X-ME-IP: 86.243.2.178
Message-ID: <2b36ae3d-de9b-4125-a0e3-e1083a67cf4a@wanadoo.fr>
Date:   Fri, 8 Sep 2023 07:18:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ata: sata_mv: Fix incorrect string length computation in
 mv_dump_mem()
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-ide@vger.kernel.org
References: <1a35e114a3dcc33053ca7cca41cb06b8426d8c40.1693857262.git.christophe.jaillet@wanadoo.fr>
 <b5dcc85d-f709-a3a3-e7ad-9c71f278842a@kernel.org>
 <9150d691-49b8-c102-a5de-d1fa207d61ed@wanadoo.fr>
 <3b7f0d1d-57ec-7870-fc6e-0449e3112461@kernel.org>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <3b7f0d1d-57ec-7870-fc6e-0449e3112461@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 06/09/2023 à 03:11, Damien Le Moal a écrit :
> On 9/6/23 00:28, Christophe JAILLET wrote:
>>
>>
>> Le 05/09/2023 à 07:04, Damien Le Moal a écrit :
>>> On 9/5/23 04:54, Christophe JAILLET wrote:
>>>> snprintf() returns the "number of characters which *would* be generated for
>>>> the given input", not the size *really* generated.
>>>>
>>>> In order to avoid too large values for 'o' (and potential negative values
>>>> for "sizeof(linebuf) o") use scnprintf() instead of snprintf().
>>>>
>>>> Note that given the "w < 4" in the for loop, the buffer can NOT
>>>> overflow, but using the *right* function is always better.
>>>>
>>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>>
>>> Doesn't this need Fixes and CC stable tags ?
>>
>> I don't think so.
>> As said in the commit message :
>>      Note that given the "w < 4" in the for loop, the buffer can NOT
>>      overflow, but using the *right* function is always better.
>>
>> linebuf is 38 chars.
>> In each iteration, we write 9 bytes + NULL.
>> We write only 4 elements per line (because of w < 4), so 9 * 4 + 1 = 37
>> bytes are needed.
>> 9 is for %08x<space>
>>
>> It can't overflow.
>> Moreover, it is really unlikely that the size of linebuf or the number
>> of elements on each line change in a stable kernel.
>>
>> So, from my POV, this patch is more a clean-up than anything else.
>>
>> I would even agree that it is maybe not even needed. But should someone
>> cut'n'paste it one day, then using the correct function could maybe help
>> him.
> 
> OK. Fine. But then maybe the patch title should be something like "Improve
> string length computation in mv_dump_mem()" as the "Fix" word you used seems to
> be somewhat misleading. With the patch title as is, the stable bot will likely
> pick up that patch for stable. Fine with me, unless you see an issue with that.

Hi,

up to you to tweak it if desired.

My POV is that it *fixes* the length calculation, but having it "wrong" 
is harmless.
Should it trigger a backport, it wouldn't be a real issue either. And we 
can still ask to remove it from the backport list when notified.

And as said, leaving things as-is looks also fine to me.

I let you choose the best option.

CJ

> 
>>
>> CJ
>>
>>>
>>>> ---
>>>>    drivers/ata/sata_mv.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
>>>> index d105db5c7d81..45e48d653c60 100644
>>>> --- a/drivers/ata/sata_mv.c
>>>> +++ b/drivers/ata/sata_mv.c
>>>> @@ -1255,8 +1255,8 @@ static void mv_dump_mem(struct device *dev, void __iomem *start, unsigned bytes)
>>>>    
>>>>    	for (b = 0; b < bytes; ) {
>>>>    		for (w = 0, o = 0; b < bytes && w < 4; w++) {
>>>> -			o += snprintf(linebuf + o, sizeof(linebuf) - o,
>>>> -				      "%08x ", readl(start + b));
>>>> +			o += scnprintf(linebuf + o, sizeof(linebuf) - o,
>>>> +				       "%08x ", readl(start + b));
>>>>    			b += sizeof(u32);
>>>>    		}
>>>>    		dev_dbg(dev, "%s: %p: %s\n",
>>>
> 

