Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352967E6679
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbjKIJRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjKIJRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:17:16 -0500
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA55C25BC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 01:17:13 -0800 (PST)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id B0F5A12000B;
        Thu,  9 Nov 2023 12:17:11 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B0F5A12000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1699521431;
        bh=bbSo/m0vSYcjPbzBQwrGodEysAY5jSopZaaAaAbrRcw=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=c0+ygr3yMenLOk+knqeJ0iLTt/zEwohclNi9i8s7p6MROGBuQoWjFzFxvaiFDz2CS
         40YDX6OUWtFTX3F/azVR/AfepUrMx9YAHf5OWnDmsYtjhsgxEGiH059xB12CT3vzME
         XKWtvhTjxx2RQJsU7x1HbSUiSiWYMo7Nkdup7aHhBm7wn56Ha0wz/c0lkWGi+bR0mT
         Ec2nVMTkiHD092DA/brJ6i7Ei21jR/HRF/8YMyPUze45Vs0wHdOl1RWJ3/+vcXdFMT
         Gbv7wxLupG9M0dUB/UxDyNk4QSOQoPGLQlI2a92LdAhndiuN6/kNu4AtICb+ncM8ZY
         Hk2D1Sl3f1vjw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Thu,  9 Nov 2023 12:17:10 +0300 (MSK)
Received: from [192.168.0.106] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 9 Nov 2023 12:17:09 +0300
Message-ID: <98c5a6ef-3865-9254-0af7-2d041a64d368@salutedevices.com>
Date:   Thu, 9 Nov 2023 12:09:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1] mtd: rawnand: meson: handle OOB buffer according OOB
 layout
To:     Viacheslav Bocharov <adeep@lexina.in>,
        Liang Yang <liang.yang@amlogic.com>,
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
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20231109053953.3863664-1-avkrasnov@salutedevices.com>
 <5a82e3b96c94b45821707eb5d392384e1a026c2e.camel@lexina.in>
Content-Language: en-US
From:   Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <5a82e3b96c94b45821707eb5d392384e1a026c2e.camel@lexina.in>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181232 [Nov 09 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/09 07:10:00 #22435383
X-KSMG-AntiVirus-Status: Clean, skipped
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, thanks for review!

On 09.11.2023 11:06, Viacheslav Bocharov wrote:
> Hi!
> 
> On Thu, 2023-11-09 at 08:39 +0300, Arseniy Krasnov wrote:
>> In case of MTD_OPS_AUTO_OOB mode, MTD/NAND layer fills/reads OOB buffer
>> according current OOB layout so we need to follow it in the driver.
>>
>> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>> ---
>>  drivers/mtd/nand/raw/meson_nand.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>> index 561d46d860b7..0d4d358152d7 100644
>> --- a/drivers/mtd/nand/raw/meson_nand.c
>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>> @@ -510,7 +510,7 @@ static void meson_nfc_set_user_byte(struct nand_chip *nand, u8 *oob_buf)
>>  	__le64 *info;
>>  	int i, count;
>>  
>> -	for (i = 0, count = 0; i < nand->ecc.steps; i++, count += 2) {
>> +	for (i = 0, count = 0; i < nand->ecc.steps; i++, count += (2 + nand->ecc.bytes)) {
>>  		info = &meson_chip->info_buf[i];
>>  		*info |= oob_buf[count];
>>  		*info |= oob_buf[count + 1] << 8;
> Seems something wrong with your logic here.
> I think this code should most likely look like this:
> 
> for (i = 0, count = 0; i < nand->ecc.steps; i++, count += nand->ecc.bytes) {
>     info = &meson_chip->info_buf[i];
>     *info |= oob_buf[count];
>     if (nand->ecc.bytes > 1)
>       *info |= oob_buf[count + 1] << 8;
> }

For 64 bytes OOB and 512 bytes ECC this driver reports free areas as:

AA AA BB BB BB BB BB BB BB BB BB BB BB BB BB BB
AA AA BB BB BB BB BB BB BB BB BB BB BB BB BB BB
AA AA BB BB BB BB BB BB BB BB BB BB BB BB BB BB
AA AA BB BB BB BB BB BB BB BB BB BB BB BB BB BB

where AA is free byte(user byte), BB - ECC codes. So to access user bytes
we need bytes 0,1,16,17,32,33,48,49. nand->ecc.bytes == 14, so 'count' is
increased at 16 every iteration, so i guess this is correct.

WDYT?

Thanks, Arseniy

> 
> 
>> @@ -523,7 +523,7 @@ static void meson_nfc_get_user_byte(struct nand_chip *nand, u8 *oob_buf)
>>  	__le64 *info;
>>  	int i, count;
>>  
>> -	for (i = 0, count = 0; i < nand->ecc.steps; i++, count += 2) {
>> +	for (i = 0, count = 0; i < nand->ecc.steps; i++, count += (2 + nand->ecc.bytes)) {
>>  		info = &meson_chip->info_buf[i];
>>  		oob_buf[count] = *info;
>>  		oob_buf[count + 1] = *info >> 8;
> And there:
> 
> for (i = 0, count = 0; i < nand->ecc.steps; i++, count += nand->ecc.bytes) {
>     info = &meson_chip->info_buf[i];
>     oob_buf[count] = *info;
>     if (nand->ecc.bytes > 1)
>         oob_buf[count + 1] = *info >> 8;
> }
> 
> 
> This is more similar to the behavior of similar functions in the proprietary U-Boot.
> 
> --
> Viacheslav Bocharov
> 
