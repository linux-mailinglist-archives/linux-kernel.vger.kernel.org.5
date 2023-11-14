Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902797EABC9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjKNIm4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Nov 2023 03:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjKNImz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:42:55 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3091AA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 00:42:49 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id C888C24E249;
        Tue, 14 Nov 2023 16:42:46 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 14 Nov
 2023 16:42:46 +0800
Received: from [192.168.100.10] (172.16.6.8) by EXMBX066.cuchost.com
 (172.16.6.66) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 14 Nov
 2023 16:42:45 +0800
Message-ID: <d0e473f3-7b05-2d18-9874-eb9fe26f8478@starfivetech.com>
Date:   Tue, 14 Nov 2023 16:42:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/1] i3c: Add fallback method for GETMXDS CCC
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <alexandre.belloni@bootlin.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20231114033430.9623-1-joshua.yeong@starfivetech.com>
 <20231114033430.9623-2-joshua.yeong@starfivetech.com>
 <20231114091956.0b8dd6c5@xps-13>
From:   Joshua Yeong <joshua.yeong@starfivetech.com>
In-Reply-To: <20231114091956.0b8dd6c5@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-Originating-IP: [172.16.6.8]
X-ClientProxiedBy: EXCAS081.cuchost.com (172.16.6.41) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On 14-Nov-23 4:19 PM, Miquel Raynal wrote:
> Hi Joshua,
>
> joshua.yeong@starfivetech.com wrote on Tue, 14 Nov 2023 11:34:30 +0800:
>
>> Some I3C hardware will report error when incorrect length is received from
> 					an
>
>> device. GETMXDS CCC are availble in 2 formats; without turnaround time (format
> 			  available		:
>
>> 1) and with turnaround time (format 2). There is no mechanics to determine which
>> format is supported by device. In case sending GETMXDS CCC format 2 resulted
> 				So in case?
>
>> failure, try sending GETMXDS CCC format 1 instead.
> in a
>
>> Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
>> ---
>>   drivers/i3c/master.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
>> index 0cdc94e4cb77..2fc04d97f07e 100644
>> --- a/drivers/i3c/master.c
>> +++ b/drivers/i3c/master.c
>> @@ -1099,8 +1099,16 @@ static int i3c_master_getmxds_locked(struct i3c_master_controller *master,
>>   
>>   	i3c_ccc_cmd_init(&cmd, true, I3C_CCC_GETMXDS, &dest, 1);
>>   	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
>> -	if (ret)
>> -		goto out;
>> +	if (ret) {
>> +		/*
> 		 ^
> Wrong alignment of the starts below
> 		v
>> +		* Retry when the device does not support max read turnaround
>> +		* while expecting shorter length from this CCC command
> period?
>
>> +		*/
>> +		dest->payload.len -= 3;
>> +		ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
>> +		if (ret)
>> +			goto out;
>> +	}
> I believe this is a per-device configuration and we should save this in
> order to only fail once, no?

This behavior depends on the hardware designed whether it will return an 
error
in case of shorter length from i3c devices in dest->payload.len. I made 
it so it
will retry by expecting a shorter length instead, in case it still fails 
then
it means GETMXDS CCC really failed.

We do not have to initialize the same hardware twice and do GETMXDS CCC more
than once as far as I know?

>
>>   
>>   	if (dest.payload.len != 2 && dest.payload.len != 5) {
>>   		ret = -EIO;
>
> Thanks,
> Miquèl
>
