Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6AD7EB886
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 22:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbjKNVU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 16:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjKNVUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 16:20:54 -0500
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C56FC9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 13:20:50 -0800 (PST)
Received: from eig-obgw-6009a.ext.cloudfilter.net ([10.0.30.184])
        by cmsmtp with ESMTPS
        id 2urGrHVfoWcCI30q1riGQY; Tue, 14 Nov 2023 21:20:49 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id 30q0rofbSBOcc30q0r8DqL; Tue, 14 Nov 2023 21:20:48 +0000
X-Authority-Analysis: v=2.4 cv=J+25USrS c=1 sm=1 tr=0 ts=6553e4b0
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=4phrzMesRlFG3ZuAd8AA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fqvdjHSSkvRmHNFL6Pv4n1V2wTIvkAGySUpqtAfFSms=; b=f51cZ98KRhtRisZYT+jer9cNAh
        eWgA4QhUoN0SZBoylMKbOhqG3sBkDA+DrCOZFRj6EupY/7B90kgfO/Kd78IyAavMG0eWqgONbn27S
        dScfs/NVeg4r+f1Bs68pcOEeFrzdBu18v3a+Txn3MtvzPdO8VRviZKuyZPsH4pPB23jImmTRVVJFo
        sy6kH9aNxz8CoXG/3r3fn11KezGgoB4fVzu/ZMqBNduWxlN5kOXZ317VjbdafAiK0iKw3cKdA8AX0
        iXAvqstxxvsXXSfkuPMnzmTaM0YkhQAd2x5fz5xHFZtsocHUHT75z4IYSYqit2M56Kvb24/HjOlHW
        ojLm6raQ==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:58556 helo=[192.168.15.10])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1r30pz-003oHt-2B;
        Tue, 14 Nov 2023 15:20:47 -0600
Message-ID: <c353ba94-0712-422b-bfbb-f166c7690cf8@embeddedor.com>
Date:   Tue, 14 Nov 2023 15:20:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] hwmon: (aspeed-pwm-tacho) Fix -Wstringop-overflow
 warning in aspeed_create_fan_tach_channel()
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <ZVJ7JBFoULzY3VGx@work>
 <6a28c219-b047-411b-ab43-02fc8f1824db@roeck-us.net>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <6a28c219-b047-411b-ab43-02fc8f1824db@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1r30pz-003oHt-2B
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:58556
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMA002fjW9Sl4KP950YdEfYVVVox3Zdbkk0Pko6JFEcAhEVkUnuN0YVJbJiu6oB5hlN5VHYM1p++wxnH7ZjNkmDVKIlKOgWwuQfMhx/hYaBghESP0WLy
 U5Sl7VC4Utw8y5BaaOGeNAn3zV9hmZWvc6lwBGofoqWbOLpyr3w7VVv7zKYbe5/mEok8wZGIfIwLssPDxjgtUAXwVD5emzQFYkP8SGIh313teBzMfxgsbiCt
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/14/23 08:52, Guenter Roeck wrote:
> On Mon, Nov 13, 2023 at 01:38:12PM -0600, Gustavo A. R. Silva wrote:
>> Based on the documentation below, the maximum number of Fan tach
>> channels is 16:
>>
>> Documentation/devicetree/bindings/hwmon/aspeed-pwm-tacho.txt:45:
>>   45 - aspeed,fan-tach-ch : should specify the Fan tach input channel.
>>   46                 integer value in the range 0 through 15, with 0 indicating
>>   47                 Fan tach channel 0 and 15 indicating Fan tach channel 15.
>>   48                 At least one Fan tach input channel is required.
>>
>> However, the compiler doesn't know that, and legitimaly warns about a potential
>> overwrite in array `u8 fan_tach_ch_source[16]` in `struct aspeed_pwm_tacho_data`,
>> in case `index` takes a value outside the boundaries of the array:
>>
> 
> All that doesn't warrant introducing checkpatch warnings.

Do you mean this?

WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#17:
  46                 integer value in the range 0 through 15, with 0 indicating

I honestly didn't consider that relevant, and I didn't want to alter the format of
the Doc text.

However, if you want me to split any offending line, that's not a problem. Just let
me know. :)

> 
>> drivers/hwmon/aspeed-pwm-tacho.c:
>> 179 struct aspeed_pwm_tacho_data {
>> ...
>> 184         bool fan_tach_present[16];
>> ...
>> 193         u8 fan_tach_ch_source[16];
>> ...
>> 196 };
>>
>> In function ‘aspeed_create_fan_tach_channel’,
>>      inlined from ‘aspeed_create_fan’ at drivers/hwmon/aspeed-pwm-tacho.c:877:2,
>>      inlined from ‘aspeed_pwm_tacho_probe’ at drivers/hwmon/aspeed-pwm-tacho.c:936:9:
>> drivers/hwmon/aspeed-pwm-tacho.c:751:49: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
>>    751 |                 priv->fan_tach_ch_source[index] = pwm_source;
>>        |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
>> drivers/hwmon/aspeed-pwm-tacho.c: In function ‘aspeed_pwm_tacho_probe’:
>> drivers/hwmon/aspeed-pwm-tacho.c:193:12: note: at offset [48, 255] into destination object ‘fan_tach_ch_source’ of size 16
>>    193 |         u8 fan_tach_ch_source[16];
>>        |            ^~~~~~~~~~~~~~~~~~
>>
>> Fix this by sanity checking `index` before using it to index arrays of
>> size 16 elements in `struct aspeed_pwm_tacho_data`. Also, and just for
>> completeness, add a `pr_err()` message to display in the unlikely case
>> `0 > index >= 16`.
>>
>> This is probably the last remaining -Wstringop-overflow issue in the
>> kernel, and this patch helps with the ongoing efforts to enable such
>> compiler option globally.
>>
> 
> I am sorry, but this description almost completely misses the point.
> The real issue is that the values in aspeed,fan-tach-ch are not range
> checked, which can cause real problems if is elements are set to values
> larger than 15. This is a real problem and has nothing to do with string
> overflows.

Yeah, the above paragraph was extra, and I removed it in v2[1]. The rest
of the changelog text describes the issue in the code.

> 
> This should use dev_err() (and, yes, that means dev needs to be passed
> as argument), and the function should return -EINVAL if this is
> encountered. Also, error handling should come first.
> 
> 		if (index >= MAX_ASPEED_FAN_TACH_CHANNELS) {
> 			dev_err(dev, "Invalid Fan Tach input channel %u\n.", index);
> 			return -EINVAL;
> 		}

Done in v2.

Thanks a lot for the feedback.
--
Gustavo

[1] https://lore.kernel.org/linux-hardening/ZVPQJIP26dIzRAr6@work/
