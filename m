Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1446A7F6D6E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 08:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344795AbjKXH7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 02:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbjKXH6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 02:58:39 -0500
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C52D6E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 23:58:44 -0800 (PST)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 1781312000B;
        Fri, 24 Nov 2023 10:58:43 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 1781312000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1700812723;
        bh=XiPAdbXliZniND8LePCe3rsXF8NuS8152HmP6D/YTM0=;
        h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type:From;
        b=FCByyw0n1Ceh77g5C0UYaQXaKHhQKYGDzLt5pMMphW40G3gtMipxqiVxYtLXXV48y
         ZUjkJdwwrQEyHpuiQ63Wj12xFB3cE6nA3b1J1VBQOuS8aOpg+fP26lK4RKTTpaouLM
         HqDpgb/xnIwRT6T+Nomy/9TF1/BTPT59I6deAzKBglPBqjJDZ22hP+P4ropH34xrE4
         ArYx+GQyvMPgZ9XvA/lIWcCdIc3Vo0nGyr9Ys48zgz09h6+Y0QTe6Wj8fTGLjAGYMR
         yRDREczNMnmfFHZe9/AioO2Ol78YgwIe3GPhvSGZhMBHt/bqYDI3kL+ymvrg+xg7J7
         U4G/L3tqjdxtA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Fri, 24 Nov 2023 10:58:42 +0300 (MSK)
Received: from [192.168.0.106] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 24 Nov 2023 10:58:42 +0300
Message-ID: <ab3f6734-357c-9937-2e21-a935850d3af8@salutedevices.com>
Date:   Fri, 24 Nov 2023 10:50:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1] mtd: rawnand: meson: handle OOB buffer according OOB
 layout
Content-Language: en-US
From:   Arseniy Krasnov <avkrasnov@salutedevices.com>
To:     Viacheslav Bocharov <adeep@lexina.in>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20231109053953.3863664-1-avkrasnov@salutedevices.com>
 <5a82e3b96c94b45821707eb5d392384e1a026c2e.camel@lexina.in>
 <98c5a6ef-3865-9254-0af7-2d041a64d368@salutedevices.com>
In-Reply-To: <98c5a6ef-3865-9254-0af7-2d041a64d368@salutedevices.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181570 [Nov 24 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 4 0.3.4 720d3c21819df9b72e78f051e300e232316d302a, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/24 06:01:00 #22520095
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all, 2 weeks from 9.11, please ping

Thanks, Arseniy


On 09.11.2023 12:09, Arseniy Krasnov wrote:
> Hello, thanks for review!
> 
> On 09.11.2023 11:06, Viacheslav Bocharov wrote:
>> Hi!
>>
>> On Thu, 2023-11-09 at 08:39 +0300, Arseniy Krasnov wrote:
>>> In case of MTD_OPS_AUTO_OOB mode, MTD/NAND layer fills/reads OOB buffer
>>> according current OOB layout so we need to follow it in the driver.
>>>
>>> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>>> ---
>>>  drivers/mtd/nand/raw/meson_nand.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>>> index 561d46d860b7..0d4d358152d7 100644
>>> --- a/drivers/mtd/nand/raw/meson_nand.c
>>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>>> @@ -510,7 +510,7 @@ static void meson_nfc_set_user_byte(struct nand_chip *nand, u8 *oob_buf)
>>>  	__le64 *info;
>>>  	int i, count;
>>>  
>>> -	for (i = 0, count = 0; i < nand->ecc.steps; i++, count += 2) {
>>> +	for (i = 0, count = 0; i < nand->ecc.steps; i++, count += (2 + nand->ecc.bytes)) {
>>>  		info = &meson_chip->info_buf[i];
>>>  		*info |= oob_buf[count];
>>>  		*info |= oob_buf[count + 1] << 8;
>> Seems something wrong with your logic here.
>> I think this code should most likely look like this:
>>
>> for (i = 0, count = 0; i < nand->ecc.steps; i++, count += nand->ecc.bytes) {
>>     info = &meson_chip->info_buf[i];
>>     *info |= oob_buf[count];
>>     if (nand->ecc.bytes > 1)
>>       *info |= oob_buf[count + 1] << 8;
>> }
> 
> For 64 bytes OOB and 512 bytes ECC this driver reports free areas as:
> 
> AA AA BB BB BB BB BB BB BB BB BB BB BB BB BB BB
> AA AA BB BB BB BB BB BB BB BB BB BB BB BB BB BB
> AA AA BB BB BB BB BB BB BB BB BB BB BB BB BB BB
> AA AA BB BB BB BB BB BB BB BB BB BB BB BB BB BB
> 
> where AA is free byte(user byte), BB - ECC codes. So to access user bytes
> we need bytes 0,1,16,17,32,33,48,49. nand->ecc.bytes == 14, so 'count' is
> increased at 16 every iteration, so i guess this is correct.
> 
> WDYT?
> 
> Thanks, Arseniy
> 
>>
>>
>>> @@ -523,7 +523,7 @@ static void meson_nfc_get_user_byte(struct nand_chip *nand, u8 *oob_buf)
>>>  	__le64 *info;
>>>  	int i, count;
>>>  
>>> -	for (i = 0, count = 0; i < nand->ecc.steps; i++, count += 2) {
>>> +	for (i = 0, count = 0; i < nand->ecc.steps; i++, count += (2 + nand->ecc.bytes)) {
>>>  		info = &meson_chip->info_buf[i];
>>>  		oob_buf[count] = *info;
>>>  		oob_buf[count + 1] = *info >> 8;
>> And there:
>>
>> for (i = 0, count = 0; i < nand->ecc.steps; i++, count += nand->ecc.bytes) {
>>     info = &meson_chip->info_buf[i];
>>     oob_buf[count] = *info;
>>     if (nand->ecc.bytes > 1)
>>         oob_buf[count + 1] = *info >> 8;
>> }
>>
>>
>> This is more similar to the behavior of similar functions in the proprietary U-Boot.
>>
>> --
>> Viacheslav Bocharov
>>
