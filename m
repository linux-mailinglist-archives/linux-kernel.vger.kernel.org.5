Return-Path: <linux-kernel+bounces-166720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB358B9E88
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B3301C236BB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB00A15CD72;
	Thu,  2 May 2024 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wqzXVd5D"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD24515E5B9
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714667150; cv=none; b=Lpp1KMMK3OrW+Zcm6ThJAHSSiuqMO4bBL/Umy09t9lD2eVBWihvPLOYUrLtJpaA1sZ8Izd6hcTkzlWrDNh46zzXqD02VXrQQqxNL6gzHyuUJlOs8FQvMSG1jhpe0pfvtV5yjoFROkn6qHm3gFLi6pUQ3BOSu0c/Nqq42SeHhpZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714667150; c=relaxed/simple;
	bh=4mXnxYuyE4V6VCm5aQCB1D/pwSjJB4SGdR59W7Y1ZUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=flVVu6vx3+BCGd4JR7x/eiqQOeIqDTA9AIf8okwTnZxqtfDNU4exvfqhHI8RjBqHubIogQHZ5KVtnj2X7bEJOLPBW44FYClTF+CjtgCwpc9srC+p9CD5pH43wLtkDFyaASdqPSKNoxCq3F0WQzPZQ9/GYzMhSeh5QA8be1EJin8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wqzXVd5D; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e1d01191-fd96-4b17-b223-7147eb427315@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714667146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AN8xdb1IOqM8B6dtORjftXrgW+S1XF62ODJxIj/2mvU=;
	b=wqzXVd5DEvBRvixSMLLlWTtSgq/brVCrTYO0CwcEoU1bIfI4P/0GTCj0EvcN++fFrUIftl
	7BAWTBPa26LKnCFIkhmGZyYO6y6gRYlRJn60Tvdh57bRd5BfuKMYoAisAQiTmzmB9CHYs5
	DWXBOs7fmzOqAPxiIFY5X8IPZVFl5+M=
Date: Fri, 3 May 2024 00:25:17 +0800
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
 <9e69b129-7539-4403-a621-bf3775aab995@linux.dev>
 <ZjNPiBvLF3WcBftn@smile.fi.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <ZjNPiBvLF3WcBftn@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/5/2 16:32, Andy Shevchenko wrote:
> On Wed, May 01, 2024 at 12:27:14AM +0800, Sui Jingfeng wrote:
>> On 2024/4/30 22:13, Andy Shevchenko wrote:
>>> On Fri, Apr 26, 2024 at 05:13:43AM +0800, Sui Jingfeng wrote:
> ...
>
>>> the former might be subdivided to "is it swnode backed or real fwnode one?"
>>>
>> Yeah,
>> On non-DT cases, it can be subdivided to swnode backed case and ACPI fwnode backed case.
>>
>>   - For swnode backed case: the device_get_match_data() don't has a implemented backend.
>>   - For ACPI fwnode backed case: the device_get_match_data() has a implemented backend.
>>
>> But the driver has *neither* software node support
> True.
>
>> nor ACPI support,
> Not true.

Why this is not true? Are you means that the panel-ilitek-ili9341 driver has ACPI support?
I'm asking because I don't see struct acpi_device_id related stuff in that source file,
am I miss something?


> So, slow down and take your time to get into the code and understand how it works.
>
>> so that the rotation property can not get and ili9341_dpi_probe() will fails.
>> So in total, this is not a 100% correct use of device property APIs.
>>
>> But I'm fine that if you want to leave(ignore) those less frequent use cases temporarily,
>> there may have programmers want to post patches, to complete the missing in the future.
>>
>> So, there do have some gains on non-DT cases.
>>
>>   - As you make it be able to compiled on X86 with the drm-misc-defconfig.
>>   - You cleanup the code up (at least patch 2 in this series is no obvious problem).
>>   - You allow people to modprobe it, and maybe half right and half undefined.
>>
>> But you do helps moving something forward, so congratulations for the wake up.

-- 
Best regards,
Sui


