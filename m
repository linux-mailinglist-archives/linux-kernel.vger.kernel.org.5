Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12D0786839
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 09:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240321AbjHXHTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 03:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240317AbjHXHT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 03:19:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDA6E66;
        Thu, 24 Aug 2023 00:19:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B5F26400A;
        Thu, 24 Aug 2023 07:19:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53527C433C8;
        Thu, 24 Aug 2023 07:19:24 +0000 (UTC)
Message-ID: <2b05ceb2-5d95-63bf-fba8-16e68c64089b@xs4all.nl>
Date:   Thu, 24 Aug 2023 09:19:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] UBSAN: shift-out-of-bounds in set_flicker
Content-Language: en-US, nl
To:     Greg KH <greg@kroah.com>, coolrrsh@gmail.com
Cc:     mchehab@kernel.org, slark_xiao@163.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+e27f3dbdab04e43b9f73@syzkaller.appspotmail.com
References: <20230824070630.8209-1-coolrrsh@gmail.com>
 <2023082425-argue-tartar-4652@gregkh>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <2023082425-argue-tartar-4652@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2023 09:13, Greg KH wrote:
> On Thu, Aug 24, 2023 at 12:36:30PM +0530, coolrrsh@gmail.com wrote:
>> From: Rajeshwar R Shinde <coolrrsh@gmail.com>
>>
>> Syzkaller reported the following issue:
>>
>> UBSAN: shift-out-of-bounds in drivers/media/usb/gspca/cpia1.c:1031:27
>> shift exponent 245 is too large for 32-bit type 'int'
>>
>> shift-out-of-bounds error was triggered when variable 
>> 'sd->params.exposure.gain' is greater than the number of bits of int.
>> When the variable 'currentexp' is left shifted beyond 31 bits then
>> the error is produced. Therefore added the conditional expression to 
>> verify valid range.
>>
>> Tested via syzbot.
>>
>> Reported-by: syzbot+e27f3dbdab04e43b9f73@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/all/20230818164522.12806-1-coolrrsh@gmail.com
>>
>> Link: https://syzkaller.appspot.com/bug?extid=e27f3dbdab04e43b9f73
>>
>> Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>
> 
> Please do not have blank lines beween these tags.
> 
> You also have trailing whitespace in your changelog text :(

And please mention the driver name in your subject! E.g. something like:

"media: gspca/cpia1: UBSAN: shift-out-of-bounds in set_flicker"

That way I can actually know that this is a patch for a driver that I
maintain.

Regards,

	Hans

> 
>> ---
>> v1->v2
>> changed the patch
>> changed commit message and tested with checkpatch 
>>
>> ---
>>  drivers/media/usb/gspca/cpia1.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/media/usb/gspca/cpia1.c b/drivers/media/usb/gspca/cpia1.c
>> index 46ed95483e22..dafc522d5e7b 100644
>> --- a/drivers/media/usb/gspca/cpia1.c
>> +++ b/drivers/media/usb/gspca/cpia1.c
>> @@ -1028,6 +1028,8 @@ static int set_flicker(struct gspca_dev *gspca_dev, int on, int apply)
>>  			sd->params.exposure.expMode = 2;
>>  			sd->exposure_status = EXPOSURE_NORMAL;
>>  		}
>> +		if (sd->params.exposure.gain > 31)
>> +			return -1;
> 
> Do not make up error codes, please return a valid one and not a random
> negative number.  Unless -1 is a valid value for this function?
> 
> thanks,
> 
> greg k-h

