Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056A178DF89
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243707AbjH3TN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242176AbjH3HWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 03:22:36 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F01F1BE;
        Wed, 30 Aug 2023 00:22:32 -0700 (PDT)
Received: from [192.168.1.110] (unknown [103.251.226.104])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5592EE4;
        Wed, 30 Aug 2023 09:21:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693380066;
        bh=F2nGmB1UG3evPTDDcWso39hwyLzIhuxO2BI6OO2Pi+Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Z9FqDaEP8P4aOcP88r/iZLjd3ciBk/UzHVOsdLy8KzpG250/90osEOhQ/uw+wHBrb
         cJKwISNNlCrI5Qb+e7TxagVObySgN8qI7ShaCzzRTvE2dLP8OyJu1TbbSW1S0T7ozg
         /urT4HY+fUMcBR9AhVG4eEvTh7vIEBdJZSnUbP64=
Message-ID: <4efee746-f59c-fc61-7811-fc3c7ceb1e7f@ideasonboard.com>
Date:   Wed, 30 Aug 2023 12:52:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] media: i2c: imx214: Use v4l2_subdev_get_fmt()
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
References: <20230830045323.71768-1-umang.jain@ideasonboard.com>
 <20230830045323.71768-2-umang.jain@ideasonboard.com>
 <20230830071929.GI6477@pendragon.ideasonboard.com>
Content-Language: en-US
From:   Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <20230830071929.GI6477@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 8/30/23 12:49 PM, Laurent Pinchart wrote:
> On Wed, Aug 30, 2023 at 10:23:22AM +0530, Umang Jain wrote:
>> The imx214 driver uses the subdev active state, there's no
> Does it ? I don't see a call to v4l2_subdev_init_finalize(), and the
> imx214 struct has fmt and crop fields in which it stores the active
> format.

Yes, It doesn't. Got confused with one of the pad ops (.init_cfg) which 
led me thinking this driver uses active state, whereas I should have 
checked v4l2_subdev_init_finalize()

Apologies for the noise.

This patch should be discarded.
>
>> need to implement the .get_fmt() operation manually. Use the
>> v4l2_subdev_get_fmt() helper instead.
>>
>> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
>> ---
>>   drivers/media/i2c/imx214.c | 17 +----------------
>>   1 file changed, 1 insertion(+), 16 deletions(-)
>>
>> diff --git a/drivers/media/i2c/imx214.c b/drivers/media/i2c/imx214.c
>> index 2f9c8582f940..d8bdc52f552a 100644
>> --- a/drivers/media/i2c/imx214.c
>> +++ b/drivers/media/i2c/imx214.c
>> @@ -548,21 +548,6 @@ __imx214_get_pad_format(struct imx214 *imx214,
>>   	}
>>   }
>>   
>> -static int imx214_get_format(struct v4l2_subdev *sd,
>> -			     struct v4l2_subdev_state *sd_state,
>> -			     struct v4l2_subdev_format *format)
>> -{
>> -	struct imx214 *imx214 = to_imx214(sd);
>> -
>> -	mutex_lock(&imx214->mutex);
>> -	format->format = *__imx214_get_pad_format(imx214, sd_state,
>> -						  format->pad,
>> -						  format->which);
>> -	mutex_unlock(&imx214->mutex);
>> -
>> -	return 0;
>> -}
>> -
>>   static struct v4l2_rect *
>>   __imx214_get_pad_crop(struct imx214 *imx214,
>>   		      struct v4l2_subdev_state *sd_state,
>> @@ -842,7 +827,7 @@ static const struct v4l2_subdev_pad_ops imx214_subdev_pad_ops = {
>>   	.enum_mbus_code = imx214_enum_mbus_code,
>>   	.enum_frame_size = imx214_enum_frame_size,
>>   	.enum_frame_interval = imx214_enum_frame_interval,
>> -	.get_fmt = imx214_get_format,
>> +	.get_fmt = v4l2_subdev_get_fmt,
>>   	.set_fmt = imx214_set_format,
>>   	.get_selection = imx214_get_selection,
>>   	.init_cfg = imx214_entity_init_cfg,

