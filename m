Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E53C7EDCFD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 09:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344953AbjKPIhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 03:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjKPIhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 03:37:16 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76D7CDA;
        Thu, 16 Nov 2023 00:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
        Content-Type; bh=iC6re8bhGSbP0IHnm/yopCrP8EccfrztIJgc08TxhZY=;
        b=NksxZ/8kqZc/gMg7+cjw836HLhLKmXpoKmMMEIhVRsYbVTnhpB9b9uhj4T7cUS
        z/eeOoSyB+sG96JcnlR3cfuzA/TpE0TaV8JYl2U1lc9NEPBn5+Ao4KF/WYxHkPdR
        5FHHq9aMZK10vfytGQpeh2m5nD7sJTpni1LM60Nwy+OJo=
Received: from [172.20.10.2] (unknown [39.144.137.0])
        by zwqz-smtp-mta-g3-0 (Coremail) with SMTP id _____wB3n9yY1FVlnTDiDA--.20924S3;
        Thu, 16 Nov 2023 16:36:41 +0800 (CST)
Message-ID: <d4b2882d-93d0-4223-9e53-f35a57163b94@163.com>
Date:   Thu, 16 Nov 2023 16:36:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hwmon: (nct6775) Fix logic error for PWM enable
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, xingtong.wu@siemens.com,
        tobias.schaffner@siemens.com, gerd.haeussler.ext@siemens.com
References: <20231116022330.2696-1-xingtong_wu@163.com>
 <20231116022330.2696-3-xingtong_wu@163.com>
 <4616f6a2-f81d-47cb-9574-2319d04d3f34@roeck-us.net>
Content-Language: en-US
From:   "xingtong.wu" <xingtong_wu@163.com>
In-Reply-To: <4616f6a2-f81d-47cb-9574-2319d04d3f34@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _____wB3n9yY1FVlnTDiDA--.20924S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar18GrWkArykCF4ktw4xJFb_yoW8tw4Dp3
        ykXFsYkF1qqayYvF4xtayfW34fAanaqFW7JF1DCw1Fqr9xJr12gF4xKr1FyF1DAFs5Ja4j
        vryxtr1xC3W5AFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jU4SrUUUUU=
X-Originating-IP: [39.144.137.0]
X-CM-SenderInfo: p0lqw35rqjs4rx6rljoofrz/1tbiEBoq0F8YMg7H0AABsd
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/11/16 16:07, Guenter Roeck wrote:
> On Thu, Nov 16, 2023 at 10:23:29AM +0800, Xing Tong Wu wrote:
>> From: Xing Tong Wu <xingtong.wu@siemens.com>
>>
>> The determination of the "pwm_enable" should be based solely on the mode,
>> regardless of the pwm value.
>> According to the specification, the default values for pwm and pwm_enable
>> are 255 and 0 respectively. However, there is a bug in the code where the
>> fan control is actually enabled, but the file "pwm_enable" incorrectly
>> displays "off", indicating that fan control is disabled. This contradiction
>> needs to be addressed and resolved.
>> Solution: Update the logic so that "pwm_enable" is determined by mode + 1,
>> remove the "off" value for "pwm_enable" since it is not specified in the
>> documentation.
> 
> The chip specification is irrelevant. What is relevant is the hwmon ABI,
> which says
> 
> What:           /sys/class/hwmon/hwmonX/pwmY_enable
> Description:
>                 Fan speed control method:
> 
>                 - 0: no fan speed control (i.e. fan at full speed)
> 		^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

I think this description may lead to misunderstanding. There are certain
fans that cannot be controlled and operate at full speed while system is
running. However, there are also fans whose speed can be controlled, even
if they are currently set to full speed. In this particular situation, it
would be better to inform the user that the fan can still be controlled
despite being at full speed.
How do you think that?

>                 - 1: manual fan speed control enabled (using `pwmY`)
>                 - 2+: automatic fan speed control enabled
> 
> which is what the code currently implements or at least tries to
> implement.
> 
> Guenter
> 
>>
>> Signed-off-by: Xing Tong Wu <xingtong.wu@siemens.com>
>> ---
>>  drivers/hwmon/nct6775-core.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/hwmon/nct6775-core.c b/drivers/hwmon/nct6775-core.c
>> index 2111f0cd9787..575db6cb96e9 100644
>> --- a/drivers/hwmon/nct6775-core.c
>> +++ b/drivers/hwmon/nct6775-core.c
>> @@ -900,8 +900,6 @@ static const u16 NCT6116_REG_TSI_TEMP[] = { 0x59, 0x5b };
>>  
>>  static enum pwm_enable reg_to_pwm_enable(int pwm, int mode)
>>  {
>> -	if (mode == 0 && pwm == 255)
>> -		return off;
>>  	return mode + 1;
>>  }
>>  
>> -- 
>> 2.25.1
>>

