Return-Path: <linux-kernel+bounces-134012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E21789AC1A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 18:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8ABA2822BE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 16:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CF23EA86;
	Sat,  6 Apr 2024 16:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="KGer5/Rh"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A552D3839D
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 16:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712421956; cv=none; b=EFMVR8JkWgraqXHhrn+mTV88GblYHDdJLHEc43XWtyvCiUI04j+qYkf+rEQQkxj0bWbSpYZa80NiPnWlroLmhuHW+RQBfHr9WRGhhxMNQq6Rl3qlkf4et4L3IKSLSMjq3TRw8Oy0QEh5vGcpjbU3/XaSiG85LGONudXWQ22u5ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712421956; c=relaxed/simple;
	bh=7yQ+QmR4Ay0dnL1lrEcKdS/T+SzwCs+q9uObIrWoPs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pGmUkj1LNTfZreDWO3UQhkPftpGnKEchLjWztTEqGDCgUzdQCrmAPeZ3dYBdnNcswpTDSaransTKjSlNAXHvERV2uilEbKPB/pvB62U1T/NipBd7EkOqIS5sSzTyp4FiUsqNQIDHZ+90aejzn6HlS1HtBvmugRnQsuS3SOBQ/Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=KGer5/Rh; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-434761b37d3so1805951cf.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 09:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1712421953; x=1713026753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xUzxhIyO9Z42EWr6hvKS7Qfwp4EqErW6SFdavLE1o5g=;
        b=KGer5/Rhz4pi9fzFMfw5acJXZ7fpYfCM19uLp7DLpxnXTiva2/NH1HIMWC3zXikzIF
         ZPBGYfZolhwa4D3xIprsKzc0KkpA2cDT4jNQ9giTpZzCzjeUUVFgZLoTKWvwMfFT+XCJ
         Y0f7SUFDBoMJ+cB4MkSF8sM03tOHP4XWLvJrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712421953; x=1713026753;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xUzxhIyO9Z42EWr6hvKS7Qfwp4EqErW6SFdavLE1o5g=;
        b=Xl/8JdJtpH6JBwKyS1z6nCY/ydDkNYPIqpL0HIjL0QhP/F99xCN1KIZbofQ++kEl5/
         5HN8dOsLjqP4iM+/tZYjbv8SwOLny85FmwTYrOzip146WFFVpDeaev10phydDCs90ryk
         r6pUBedPdlIJLDvR0aBGz33oag2TEAM+t9mswVV7ujlEMdWp1RsPo4G9C60OTLr9H2zz
         g4SxxRJrgqunDITcy8RqUdolGTn/ff/1+ioZ0+y9F9J1rbsyyKbxZx6SxmNf8LVSXebv
         X1aeI7lJAznvwZCc0Dqo2o3WX87/5NAloX9QDjcA1FkIJbV0uwhnQpvRRlj2Y/gTeBi4
         S78A==
X-Forwarded-Encrypted: i=1; AJvYcCV1N7+pQOoVuYo6iKZqITZW3daFFpUO64hGuq1Js723+vtikpHfPND71reIIc+bar6qvC7kmjiSb03XPLRNfkyfhoBwgZXX3gMCfRMP
X-Gm-Message-State: AOJu0YxPLnheUUW3ZenB8UY+HSAb1o3C7DpNuhn6x2Wusa6reZ7oDwI4
	LSGtPO4ryEdgtzxLCLDhdsyDLzhs7yMaISh0vdwoOkQGXjIAecn7nqDeBy/mjw==
X-Google-Smtp-Source: AGHT+IEvslkQ6rXgUW5EvmlGfHPFV2jcGN7xIZ4kQjPo99VaaKYYs8/WO0XY1HAROkySf3cJQl69Jw==
X-Received: by 2002:ac8:594a:0:b0:431:5f09:83cb with SMTP id 10-20020ac8594a000000b004315f0983cbmr5549704qtz.32.1712421953535;
        Sat, 06 Apr 2024 09:45:53 -0700 (PDT)
Received: from [10.211.55.3] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id e1-20020ac81301000000b004317c90d0d6sm3321qtj.65.2024.04.06.09.45.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Apr 2024 09:45:53 -0700 (PDT)
Message-ID: <5e1c5156-d906-4473-970b-bff71e4dcd96@ieee.org>
Date: Sat, 6 Apr 2024 11:45:51 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: greybus: Clear up precedence for gcam logging
 macros
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Jackson Chui <jacksonchui.qwerty@gmail.com>
Cc: Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240404001627.94858-1-jacksonchui.qwerty@gmail.com>
 <658e1f40-d1eb-4ba7-9ba3-0aa05a1ed06e@ieee.org>
 <ZhBrff8qkkmum4wc@jc-ubuntu-dev-korn-1>
 <5eb3afe2-da7b-4f98-aac2-bff529a02cea@moroto.mountain>
From: Alex Elder <elder@ieee.org>
In-Reply-To: <5eb3afe2-da7b-4f98-aac2-bff529a02cea@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/6/24 4:09 AM, Dan Carpenter wrote:
> On Fri, Apr 05, 2024 at 02:22:05PM -0700, Jackson Chui wrote:
>> On Thu, Apr 04, 2024 at 05:05:09PM -0500, Alex Elder wrote:
>>> On 4/3/24 7:16 PM, Jackson Chui wrote:
>>>> Reported by checkpatch:
>>>>
>>>> CHECK: Macro argument 'gcam' may be better as '(gcam)' to avoid
>>>> precedence issues
>>>
>>> I agree with your argument about the way the macro should be
>>> defined.  But perhaps these gcam_*() functions could just
>>> be eliminated?
>>>
>>> I see 15 calls to gcam_err(), 1 call to gcam_dbg(), and none
>>> to gcam_info().  It would be a different patch, but maybe
>>> you could do that instead?
>>>
>>> 					-Alex
>>>
>>>
>>>>
>>>> Disambiguates '&' (address-of) operator and '->' operator precedence,
>>>> accounting for how '(gcam)->bundle->dev' is a 'struct device' and not a
>>>> 'struct device*', which is required by the dev_{dbg,info,err} driver
>>>> model diagnostic macros. Issue found by checkpatch.
>>>>
>>>> Signed-off-by: Jackson Chui <jacksonchui.qwerty@gmail.com>
>>>> ---
>>>>    drivers/staging/greybus/camera.c | 6 +++---
>>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
>>>> index a8173aa3a995..d82a2d2abdca 100644
>>>> --- a/drivers/staging/greybus/camera.c
>>>> +++ b/drivers/staging/greybus/camera.c
>>>> @@ -180,9 +180,9 @@ static const struct gb_camera_fmt_info *gb_camera_get_format_info(u16 gb_fmt)
>>>>    #define GB_CAMERA_MAX_SETTINGS_SIZE	8192
>>>> -#define gcam_dbg(gcam, format...)	dev_dbg(&gcam->bundle->dev, format)
>>>> -#define gcam_info(gcam, format...)	dev_info(&gcam->bundle->dev, format)
>>>> -#define gcam_err(gcam, format...)	dev_err(&gcam->bundle->dev, format)
>>>> +#define gcam_dbg(gcam, format...)	dev_dbg(&((gcam)->bundle->dev), format)
>>>> +#define gcam_info(gcam, format...)	dev_info(&((gcam)->bundle->dev), format)
>>>> +#define gcam_err(gcam, format...)	dev_err(&((gcam)->bundle->dev), format)
>>>>    static int gb_camera_operation_sync_flags(struct gb_connection *connection,
>>>>    					  int type, unsigned int flags,
>>>
>>
>> Thanks for the feedback, Alex!
>>
>> I thought about refactoring it, but I feel it is worth keeping
>> the macro around. It acts as an apdater between callers, who
>> have 'gcam' and want to log and what the dynamic debug macros
>> expect. Without it, the code gets pretty ugly.
> 
> Another idea would be to create a function:
> 
> struct device *gcam_dev(struct gb_camera *gcam)
> {
> 	return &gcam->bundle->dev;
> }
> 
> 	dev_dbg(gcam_dev(gcam), "received metadata ...
> 
> (I don't know how to actually compile this code so I haven't tried it).

Yes, I prefer this over the original suggestion.  But
even here the gcam_dev() function doesn't add all that
much value; it saves four characters I guess.

Jackson, the basic principle that makes me say I don't
like the wrapper macros is that the wrapper obscures
the simple call(s) to dev_dbg(), etc.  If there was
something you wanted to do every time--along with
calling dev_dbg()--then maybe the wrapper would be
helpful, but instead it simply hides the standard call.
Better to have the code just use the functions kernel
programmers recognize.

					-Alex
> 
> regards,
> dan carpenter


