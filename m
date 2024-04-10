Return-Path: <linux-kernel+bounces-138421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B4689F100
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6DC9285F59
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97E515A488;
	Wed, 10 Apr 2024 11:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7q9XSW/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2415A1598E1
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 11:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712749042; cv=none; b=S0FGZwMkxyXC+LancfM4Frx2hIcRb3drXOhz9dyPQ/ovKEoXd5bGp1362GEtg0G97Res6rtuYkVpVvr29oBmgT4sEPVd5/A2w2PRnsg0HHSHHiWrTEYyAQlWJVAx2BO25gOEiG26fdqG9D8MC+S+Z3BPdgsV4K7upV/o5YkWquk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712749042; c=relaxed/simple;
	bh=7oON7cOddajSwTN3/yWbMtsuGKob/yQQTi8rWFjjQlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JoNraVKXewjDZ2TtliFJS9LWmZE+t9kaG+dEDK6xvGYWCyXPellXS1TCqvL8fSOr2+qRp8zN1AVm8RXzAZtGoXRPRqJEAgMlgLeoNF+ho8rjNiG2ZDDRfrLEeowYZr/NuyzjB14K7MCoFXt/Uxe/wiv1FJ0G4F3FAdGRe/a+Q+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I7q9XSW/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712749037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xFjkKUYQn2aYC2d9BkP85Ela4iCot6vhTrroEMmx6Os=;
	b=I7q9XSW/xNZgGdzAZ4J5SYlkUozAAPv81HqFFSi9F0JSxTn61X45OSbXPPkspsg5k14vwF
	XiCySHX5eKOWu2G024MIN09/FyenE1uWz3HR4CGz5I1zREzexHV0BUoeawwTChVVypUiJ4
	oNCctd+rDfCzqU3+s/18GuvRh0GIVUk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-7_HCAsYMOgGbgscCFtbP4Q-1; Wed, 10 Apr 2024 07:37:16 -0400
X-MC-Unique: 7_HCAsYMOgGbgscCFtbP4Q-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-516ea200c2eso3153169e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 04:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712749035; x=1713353835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xFjkKUYQn2aYC2d9BkP85Ela4iCot6vhTrroEMmx6Os=;
        b=lbKFERRUrjfPhtbqwVo5qma9UrPyFjIPhi+si7D+37HPI74SS4AXcTV8Jtn26LxuAg
         0Nyzcn2x7+KReAlWIZMvqVJdDi2PHNAq37eOesvssNlPmfl8VtjbfwB+uJVHE/vpP+uf
         aJS9kEMoqPADkyz/C1P3xSqu8kkSWFSqduYGnoW2FEqlcqE0j7FbenWUl8n4sbsIK0Yr
         7SFGVXryTOriRYCvOY3vtnZBhn5cKPE7d46humtB47attg7feGAnJ0qVJTJgGJ1/B2EX
         UAS+5tM5B82FB//EfRCh5PIQP0Dte1ZJJz3ZkNhoR7o2HgyL+CIOOg0zyfjAtq69Uoi2
         hG6w==
X-Forwarded-Encrypted: i=1; AJvYcCV7UjBrH27QTcWzKz1sYGy23WTMtdj1+gS6KAe+aNiM9tK/rG8clUn54NqPeXr+/TYhPIVJ4tmbMN2YYFLUq7+1FT93+2RLXNWFOtQP
X-Gm-Message-State: AOJu0Yym/urUO08CiX0R2VMNfayX4N3ReF4GTJaFJ+6pZN87dkG3ZsS+
	2+5tglby9UmvDWurjoqUbIjUEvUNcgqMKbItq4c6drT/IUIHy0gF1bVeERstxDe7IbDCcnjJV6Z
	P0CZWhRSrgKEDZm681ZKT1f6XHptAoIVb5m2czsf/NjzoN0ACcjX32CTbXgu26Q==
X-Received: by 2002:ac2:5931:0:b0:515:b93d:c885 with SMTP id v17-20020ac25931000000b00515b93dc885mr1730496lfi.23.1712749034910;
        Wed, 10 Apr 2024 04:37:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbphutsM2FA89vlZLpw4MP5lpj0+mKGLuqiEJ/phy92kBNj2JfvmBmJlj87qC8PJqSSRbZFg==
X-Received: by 2002:ac2:5931:0:b0:515:b93d:c885 with SMTP id v17-20020ac25931000000b00515b93dc885mr1730477lfi.23.1712749034539;
        Wed, 10 Apr 2024 04:37:14 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ld8-20020a170906f94800b00a51fa3c46a0sm1835045ejb.4.2024.04.10.04.37.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 04:37:14 -0700 (PDT)
Message-ID: <b4960c23-4354-427b-8201-6b7531f1343e@redhat.com>
Date: Wed, 10 Apr 2024 13:37:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] media: v4l: Don't turn on privacy LED if streamon
 fails
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, tomi.valkeinen@ideasonboard.com,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Umang Jain <umang.jain@ideasonboard.com>, linux-kernel@vger.kernel.org
References: <20240410100301.658824-1-sakari.ailus@linux.intel.com>
 <50457efb-f145-4eac-a625-28e3bfc8a7af@redhat.com>
 <ZhZ4o_B99V1trEE2@kekkonen.localdomain>
 <ZhZ5dZ68CM5IBMtW@kekkonen.localdomain>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZhZ5dZ68CM5IBMtW@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/10/24 1:35 PM, Sakari Ailus wrote:
> On Wed, Apr 10, 2024 at 11:31:48AM +0000, Sakari Ailus wrote:
>> Hi Hans,
>>
>> Thanks for the review.
>>
>> On Wed, Apr 10, 2024 at 12:12:33PM +0200, Hans de Goede wrote:
>>> Hi Sakari,
>>>
>>> Thank you for fixing this.
>>>
>>> On 4/10/24 12:03 PM, Sakari Ailus wrote:
>>>> Turn on the privacy LED only if streamon succeeds. This can be done after
>>>> enabling streaming on the sensor.
>>>>
>>>> Fixes: b6e10ff6c23d ("media: v4l2-core: Make the v4l2-core code enable/disable the privacy LED if present")
>>>> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>>>> ---
>>>>  drivers/media/v4l2-core/v4l2-subdev.c | 19 ++++++++++---------
>>>>  1 file changed, 10 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
>>>> index 4c6198c48dd6..acb7c3003ab6 100644
>>>> --- a/drivers/media/v4l2-core/v4l2-subdev.c
>>>> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
>>>> @@ -412,15 +412,6 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
>>>>  	if (WARN_ON(!!sd->enabled_streams == !!enable))
>>>>  		return 0;
>>>>  
>>>> -#if IS_REACHABLE(CONFIG_LEDS_CLASS)
>>>> -	if (!IS_ERR_OR_NULL(sd->privacy_led)) {
>>>> -		if (enable)
>>>> -			led_set_brightness(sd->privacy_led,
>>>> -					   sd->privacy_led->max_brightness);
>>>> -		else
>>>> -			led_set_brightness(sd->privacy_led, 0);
>>>> -	}
>>>> -#endif
>>>>  	ret = sd->ops->video->s_stream(sd, enable);
>>>>  
>>>>  	if (!enable && ret < 0) {
>>>> @@ -431,6 +422,16 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
>>>>  	if (!ret)
>>>>  		sd->enabled_streams = enable ? BIT(0) : 0;
>>>>  
>>>> +#if IS_REACHABLE(CONFIG_LEDS_CLASS)
>>>> +	if (!IS_ERR_OR_NULL(sd->privacy_led) && !(enable && ret < 0)) {
>>>
>>> There already is a:
>>>
>>> 	if (!enable && ret < 0)
>>> 		ret = 0;
>>>
>>> block above to ignore stream-off errors, so you can just test for:
>>>
>>> 	if (!ret && !IS_ERR_OR_NULL(sd->privacy_led)) {
>>> 		...
>>> 	}
>>>
>>> And then you can move the whole block to inside the existing:
>>>
>>> 	if (!ret)
>>> 		sd->enabled_streams = enable ? BIT(0) : 0;
>>>
>>> block, so you get something like this:
>>>
>>> 	if (!ret) {
>>> 		sd->enabled_streams = enable ? BIT(0) : 0;
>>> #if IS_REACHABLE(CONFIG_LEDS_CLASS)
>>> 		if (!IS_ERR_OR_NULL(sd->privacy_led)) {
>>> 			if (enable)
>>> 				led_set_brightness(sd->privacy_led,
>>> 						   sd->privacy_led->max_brightness);
>>> 			else
>>> 				led_set_brightness(sd->privacy_led, 0);
>>> 		}
>>> #endif
>>> 	}
>>
>> Seems reasonable, I'll send v2.
> 
> I was a bit too fast to hit y. ret will be non-zero if streamon fails
> (enable non-zero), in which case the LED needs to be turned off. So you
> can't have !ret condition for all LED control.

But if stream-on fails then AFAICT the LED was never turned on in the first
place. stream on / off calls must always be balanced, right ?

IOW stream-on is not supposed to get called if the device is already
streaming and if the device is not already streaming then the LED will
already be off.

Regards,

Hans



> 
>>
>>>
>>> Which then cleans up nicely by Tomi's patch
>>> introducing the privacy LED helper functions,
>>> to something like this:
>>>
>>> 	if (!ret {
>>> 		if (enable) {
>>> 			sd->enabled_streams = BIT(0);
>>> 			v4l2_subdev_enable_privacy_led(sd);
>>> 		} else {
>>> 			sd->enabled_streams = 0;
>>> 			v4l2_subdev_disable_privacy_led(sd);
>>> 		}
>>> 	}
>>>
>>
> 


