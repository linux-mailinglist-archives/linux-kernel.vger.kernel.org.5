Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28467F7104
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345505AbjKXKOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345440AbjKXKOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:14:38 -0500
Received: from mx.msync.work (mx.msync.work [62.182.159.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2821AB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:14:45 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4758262409;
        Fri, 24 Nov 2023 10:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1700820882; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:content-language:in-reply-to:references:autocrypt;
        bh=zAa8KfhS0OY4Dr6ZXjOsmkXuSyqZRHPE2ALmEU1633Q=;
        b=A8NLSpaGchzPYg8U/On3TW1DCPVS31Yir17LRqipktNHor/u4UVXrsuZnfLQdII0revXqQ
        HzFHRFep0mPkq5oXdzmPwrRJELDfg9hv4SXqBH1PkGW5kS5LJiAzIUBIoohvqMzcl8V6el
        CwS1dyZrV8qLu+/opSR5DGJrYeJgmVwlXeUFBHMTZfEuGWDBmcCJPtypypdQCnwDIPMjCb
        +vKkjlYS6zvbXAI82IQb1lYjldO1Bcjd4EvlqjeNrDuBk2BnmzTBycGCQwNQOg8meh5yzs
        Cpi6L1A1eb65aZCsH983m0xYN90nWpr8bWdEg+lxAssG7iKAgRZarG9t/L+quQ==
Message-ID: <608cf897-55b3-4ccd-b99f-2ebba8bbf17f@lexina.in>
Date:   Fri, 24 Nov 2023 13:14:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mtd: rawnand: meson: handle OOB buffer according OOB
 layout
Content-Language: en-US, ru-RU
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        oxffffaa@gmail.com, kernel@sberdevices.ru,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231109053953.3863664-1-avkrasnov@salutedevices.com>
 <5a82e3b96c94b45821707eb5d392384e1a026c2e.camel@lexina.in>
 <98c5a6ef-3865-9254-0af7-2d041a64d368@salutedevices.com>
 <ab3f6734-357c-9937-2e21-a935850d3af8@salutedevices.com>
 <20231124100657.245d258f@xps-13>
From:   Viacheslav <adeep@lexina.in>
Autocrypt: addr=adeep@lexina.in; keydata=
 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
In-Reply-To: <20231124100657.245d258f@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Miquel!

24/11/2023 12.06, Miquel Raynal wrote:
> Hi Arseniy,
> 
> avkrasnov@salutedevices.com wrote on Fri, 24 Nov 2023 10:50:54 +0300:
> 
>> Hello all, 2 weeks from 9.11, please ping
> 
> I'm waiting for Viacheslav.

We discussed this update with Arseniy. My suggestion was based on the 
difference in patch from the algorithms used in amlogic u-boot.  Arseniy 
claims that everything works for them.

Unfortunately, I don't have the devices available to test this.

> 
>>
>> Thanks, Arseniy
>>
>>
>> On 09.11.2023 12:09, Arseniy Krasnov wrote:
>>> Hello, thanks for review!
>>>
>>> On 09.11.2023 11:06, Viacheslav Bocharov wrote:
>>>> Hi!
>>>>
>>>> On Thu, 2023-11-09 at 08:39 +0300, Arseniy Krasnov wrote:
>>>>> In case of MTD_OPS_AUTO_OOB mode, MTD/NAND layer fills/reads OOB buffer
>>>>> according current OOB layout so we need to follow it in the driver.
>>>>>
>>>>> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>>>>> ---
>>>>>   drivers/mtd/nand/raw/meson_nand.c | 4 ++--
>>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>>>>> index 561d46d860b7..0d4d358152d7 100644
>>>>> --- a/drivers/mtd/nand/raw/meson_nand.c
>>>>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>>>>> @@ -510,7 +510,7 @@ static void meson_nfc_set_user_byte(struct nand_chip *nand, u8 *oob_buf)
>>>>>   	__le64 *info;
>>>>>   	int i, count;
>>>>>   
>>>>> -	for (i = 0, count = 0; i < nand->ecc.steps; i++, count += 2) {
>>>>> +	for (i = 0, count = 0; i < nand->ecc.steps; i++, count += (2 + nand->ecc.bytes)) {
>>>>>   		info = &meson_chip->info_buf[i];
>>>>>   		*info |= oob_buf[count];
>>>>>   		*info |= oob_buf[count + 1] << 8;
>>>> Seems something wrong with your logic here.
>>>> I think this code should most likely look like this:
>>>>
>>>> for (i = 0, count = 0; i < nand->ecc.steps; i++, count += nand->ecc.bytes) {
>>>>      info = &meson_chip->info_buf[i];
>>>>      *info |= oob_buf[count];
>>>>      if (nand->ecc.bytes > 1)
>>>>        *info |= oob_buf[count + 1] << 8;
>>>> }
>>>
>>> For 64 bytes OOB and 512 bytes ECC this driver reports free areas as:
>>>
>>> AA AA BB BB BB BB BB BB BB BB BB BB BB BB BB BB
>>> AA AA BB BB BB BB BB BB BB BB BB BB BB BB BB BB
>>> AA AA BB BB BB BB BB BB BB BB BB BB BB BB BB BB
>>> AA AA BB BB BB BB BB BB BB BB BB BB BB BB BB BB
>>>
>>> where AA is free byte(user byte), BB - ECC codes. So to access user bytes
>>> we need bytes 0,1,16,17,32,33,48,49. nand->ecc.bytes == 14, so 'count' is
>>> increased at 16 every iteration, so i guess this is correct.
>>>
>>> WDYT?
>>>
>>> Thanks, Arseniy
>>>    
>>>>
>>>>   
>>>>> @@ -523,7 +523,7 @@ static void meson_nfc_get_user_byte(struct nand_chip *nand, u8 *oob_buf)
>>>>>   	__le64 *info;
>>>>>   	int i, count;
>>>>>   
>>>>> -	for (i = 0, count = 0; i < nand->ecc.steps; i++, count += 2) {
>>>>> +	for (i = 0, count = 0; i < nand->ecc.steps; i++, count += (2 + nand->ecc.bytes)) {
>>>>>   		info = &meson_chip->info_buf[i];
>>>>>   		oob_buf[count] = *info;
>>>>>   		oob_buf[count + 1] = *info >> 8;
>>>> And there:
>>>>
>>>> for (i = 0, count = 0; i < nand->ecc.steps; i++, count += nand->ecc.bytes) {
>>>>      info = &meson_chip->info_buf[i];
>>>>      oob_buf[count] = *info;
>>>>      if (nand->ecc.bytes > 1)
>>>>          oob_buf[count + 1] = *info >> 8;
>>>> }
>>>>
>>>>
>>>> This is more similar to the behavior of similar functions in the proprietary U-Boot.
>>>>
>>>> --
>>>> Viacheslav Bocharov
>>>>   
> 
> 
> Thanks,
> Miquèl

--
Viacheslav Bocharov
