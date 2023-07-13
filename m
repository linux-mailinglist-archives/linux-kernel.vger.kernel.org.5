Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DE87516A2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 05:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbjGMDMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 23:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjGMDMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 23:12:37 -0400
Received: from mail.aspeedtech.com (211-20-114-226.hinet-ip.hinet.net [211.20.114.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0285F1BF0;
        Wed, 12 Jul 2023 20:12:33 -0700 (PDT)
Received: from [192.168.2.181] (192.168.2.181) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 13 Jul
 2023 11:12:33 +0800
Message-ID: <e9a333d2-c633-2619-33fd-dd17816b7da8@aspeedtech.com>
Date:   Thu, 13 Jul 2023 11:12:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] media: aspeed: Fix memory overwrite if timing is 1600x900
To:     Paul Menzel <pmenzel@molgen.mpg.de>
CC:     <eajames@linux.ibm.com>, <mchehab@kernel.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <linux-media@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
References: <20230712092606.2508-1-jammy_huang@aspeedtech.com>
 <461f3b88-87e6-32f2-3ed8-5764a9a6e162@molgen.mpg.de>
Content-Language: en-US
From:   Jammy Huang <jammy_huang@aspeedtech.com>
In-Reply-To: <461f3b88-87e6-32f2-3ed8-5764a9a6e162@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.2.181]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,


On 2023/7/12 下午 06:09, Paul Menzel wrote:
> Dear Jammy,
>
>
> Thank you very much for your patch.
>
> Am 12.07.23 um 11:26 schrieb Jammy Huang:
>> When capturing 1600x900, system could crash when system memory usage is
>> tight.
>
> Please provide part of the trace, and if you have a commend to 
> reproduce it, please also add it. Is it documented somewhere, that it 
> needs to be aligned?

Sorry, but I didn't find trace when this issue happened.The system just 
crash and reboot.

It just takes a few minutes to reproduce this issue using the way as below,

1. Use 1600x900 to display on host

2. Mount ISO through 'Virtual media' on OpenBMC's web

3. Run script as below on host to do sha continuously

#!/bin/bash

while [ [1] ];
do
         find /media -type f -printf '"%h/%f"\n' | xargs sha256sum
done

4. Open KVM on OpenBMC's web


I will add above information to next patch.

>
>> The size of macro block captured is 8x8. Therefore, we should make sure
>> the height of src-buf is 8 aligned to fix this issue.
>>
>> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
>> ---
>>   drivers/media/platform/aspeed/aspeed-video.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/media/platform/aspeed/aspeed-video.c 
>> b/drivers/media/platform/aspeed/aspeed-video.c
>> index 374eb7781936..14594f55a77f 100644
>> --- a/drivers/media/platform/aspeed/aspeed-video.c
>> +++ b/drivers/media/platform/aspeed/aspeed-video.c
>> @@ -1130,7 +1130,7 @@ static void aspeed_video_get_resolution(struct 
>> aspeed_video *video)
>>   static void aspeed_video_set_resolution(struct aspeed_video *video)
>>   {
>>       struct v4l2_bt_timings *act = &video->active_timings;
>> -    unsigned int size = act->width * act->height;
>> +    unsigned int size = act->width * ALIGN(act->height, 8);
>>         /* Set capture/compression frame sizes */
>>       aspeed_video_calc_compressed_size(video, size);
>> @@ -1147,7 +1147,7 @@ static void aspeed_video_set_resolution(struct 
>> aspeed_video *video)
>>           u32 width = ALIGN(act->width, 64);
>>             aspeed_video_write(video, VE_CAP_WINDOW, width << 16 | 
>> act->height);
>> -        size = width * act->height;
>> +        size = width * ALIGN(act->height, 8);
>
> Maybe add a comment.
>
> Excuse my ignorance, but as `width` is already 64 bit aligned, how 
> does aligning the second factor make a difference for `size`? Can you 
> give an example?
>
>>       } else {
>>           aspeed_video_write(video, VE_CAP_WINDOW,
>>                      act->width << 16 | act->height);
>>
>> base-commit: 2605e80d3438c77190f55b821c6575048c68268e
>
>
> Kind regards,
>
> Paul

-- 
Best Regards
Jammy

