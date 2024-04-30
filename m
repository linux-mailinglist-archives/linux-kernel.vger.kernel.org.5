Return-Path: <linux-kernel+bounces-164367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CAC8B7CCE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEE3F1C232D4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF53177992;
	Tue, 30 Apr 2024 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NgYLm3LA"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58007176FB2
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494450; cv=none; b=W5kp4NpoOAtF48yMW6leccDgancXAp1/SSmVbQ8IIK760LCZmYrDirMScHijxi+seKN2H3lwCj6RYzQ8jwQc84vLS5OpK1rPER6z8Y+1jCnCESWD3ahFnGpYMpj+eqOS1NtuCVIDHZXhn6gLxNnaeuHXCulRimhHDhNTY1GLBps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494450; c=relaxed/simple;
	bh=02xiOotCQo9PeSTWH1KfjlrWzbCSPMbVq74nspWqnWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UTAaJnwex6gmQps0H1eLYG8fTTJ6OZQpWVfx79HB05qyaUySQj2HHh95sbrIykVaOBxoq0N3VOtIEnby/YnCaVQ2I4t3IziVq+WgPswicS/p/74HHaTxeW9C5725/mhwQYniJ0X56r7e9YNzjYjbskcYQMIpl2LODI3v4JeeV9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NgYLm3LA; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9e69b129-7539-4403-a621-bf3775aab995@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714494446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y1by8GsdMWKw134eR9hE/t6tHIy3cs78DewQoszO3sk=;
	b=NgYLm3LAcH42Avb2+BlN2xBECpjXo94MHTwTsjds22RBQbTDuKha6faK48gFkG1GBSK3h7
	LcG9CgJiGYAzvoCcErorWdQcl+u40Py2DPH8PJLzWC2DGp6LdJc0i7UcGLoS0P+aWl7gtr
	gObeLzViBGsjKOutV7DC9PW1v4j7Psg=
Date: Wed, 1 May 2024 00:27:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [v1,1/3] drm/panel: ili9341: Correct use of device property APIs
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Jessica Zhang <quic_jesszhan@quicinc.com>,
 Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
References: <20240425142706.2440113-2-andriy.shevchenko@linux.intel.com>
 <c2d41916-0b6c-43b5-98eb-514eb0511f84@linux.dev>
 <ce6a480d-80b3-46b0-a32d-26bc6480d02f@linux.dev>
 <ZiqrLfezhns4UycR@smile.fi.intel.com>
 <b5ffd984-4031-4a8a-adbc-75a1e1dfe765@linux.dev>
 <ZjD8eoO3TmuCUj-a@smile.fi.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <ZjD8eoO3TmuCUj-a@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2024/4/30 22:13, Andy Shevchenko wrote:
> On Fri, Apr 26, 2024 at 05:13:43AM +0800, Sui Jingfeng wrote:
>> On 2024/4/26 03:12, Andy Shevchenko wrote:
>>> On Fri, Apr 26, 2024 at 02:53:22AM +0800, Sui Jingfeng wrote:
>>>> On 2024/4/26 02:08, Sui Jingfeng wrote:
> ...
>
>>> Are you speaking to yourself? I'm totally lost.
>>>
>>> Please, if you want to give a constructive feedback, try to understand
>>> the topic from different aspects and then clearly express it.
>> OK,
>>
>> The previous email analysis the non-DT cases exhaustively, this email intend to
>> demonstrate the more frequently use case.
>>
>> That is, in the *DT('OF')* based systems,
>> device_get_match_data() is completely equivalent to
>> of_device_get_match_data().
>> So the net results of applying this patch are "no gains and no lost".
> This is not true.

Yes, I'm true.

I have mentionedin previous(earlier) paragraph  with "in the DT(OF) based systems" or similar words.


> It's only part of the cases, i.e. DT. So, I assume you meant
>
>    "So the net results of applying this patch are "no gains and no lost" in DT case".


Yeah,it is true that this patch are "no gains and no lost" in DT case.


>> Things will become clear if we divide the whole problem into two cases(DT and non-DT)
>> to discuss, that's it. That's all I can tell.
> Not really.


I'm very clear before our conversation, really!


> non-DT cases can also be divided to "fwnode backed or not",

For non fwnode backed case of non-DT cases, there is not decent way to acquire
large set of device properties. And is out of the scope of "Correct use of
device property APIs".


> and
> the former might be subdivided to "is it swnode backed or real fwnode one?"
>
Yeah,
On non-DT cases, it can be subdivided to swnode backed case and ACPI fwnode backed case.

  - For swnode backed case: the device_get_match_data() don't has a implemented backend.
  - For ACPI fwnode backed case: the device_get_match_data() has a implemented backend.

But the driver has *neither* software node support nor ACPI support, so that the rotation
property can not get and ili9341_dpi_probe() will fails. So in total, this is not a 100%
correct use of device property APIs.

But I'm fine that if you want to leave(ignore) those less frequent use cases temporarily,
there may have programmers want to post patches, to complete the missing in the future.


So, there do have some gains on non-DT cases.

  - As you make it be able to compiled on X86 with the drm-misc-defconfig.
  - You cleanup the code up (at least patch 2 in this series is no obvious problem).
  - You allow people to modprobe it, and maybe half right and half undefined.

But you do helps moving something forward, so congratulations for the wake up.

-- 
Best regards,
Sui


