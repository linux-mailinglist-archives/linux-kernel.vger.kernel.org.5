Return-Path: <linux-kernel+bounces-167253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 857F88BA675
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 06:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BF4A1C21C52
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 04:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B437413957D;
	Fri,  3 May 2024 04:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cWkNpHNc"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0656A003
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 04:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714712275; cv=none; b=fd1uuPWR6Ul1xbHiUOZk1NPKsVlRnNbp7BxWtsnc7kBnPaTWoPgMOaBnrEe6KyRrjGqQuXKpharKdeRI9/x2XRndOWNeHEeEEckhYT68/a8GjEjhUJSvyT+x2CBMStXqWaM3tr99hxkReU4RmDv/QKpoqq4EjefFdEGHoJRTg8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714712275; c=relaxed/simple;
	bh=GTeOd0oq0fTMidocIfaQ5BcfghD8+EUvjz3d6M01P3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a8PwDglumxtuAh8ocCf1HvS5gb4E7YVCWn6ByK2k1vTws/VskCDqNGG+Z57PvIzzl4sUWkrzP3MXsaoeraf5tW0Urn0KM5PKAOdipThS7hek7JmMgxlt1qcJOD9CfD3NOWi2sDEZ/phmWRoLJ5yCP+yI1khc4/uSNy+gKqRv0Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cWkNpHNc; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a8509e96-bfe2-4c50-8624-8f418c88edfa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714712271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1bjK9PtJs5eiMbNc1nzVSEvcIBcaBcUO/u0dG22mt5E=;
	b=cWkNpHNcQE6f6fdSRfj7KFFTa06VHrf/73JiA9/J33usVpLl+8dqzHDvQnXW98QrgdqEU4
	YuFB99NnuSD0Uxnj6fog0Ka49ADV9JxtvXHAIhXGCmTLMg0HST90JDJkH9k1ml7EFXNtas
	IhfhUKHcRhRFy54Q3k6Oyawp0WANllQ=
Date: Fri, 3 May 2024 12:57:33 +0800
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
 <e1d01191-fd96-4b17-b223-7147eb427315@linux.dev>
 <ZjPNU24ZJIzGFDNg@smile.fi.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <ZjPNU24ZJIzGFDNg@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 2024/5/3 01:28, Andy Shevchenko wrote:
> On Fri, May 03, 2024 at 12:25:17AM +0800, Sui Jingfeng wrote:
>> On 2024/5/2 16:32, Andy Shevchenko wrote:
>>> On Wed, May 01, 2024 at 12:27:14AM +0800, Sui Jingfeng wrote:
>>>> On 2024/4/30 22:13, Andy Shevchenko wrote:
>>>>> On Fri, Apr 26, 2024 at 05:13:43AM +0800, Sui Jingfeng wrote:
> ...
>
>>>>> the former might be subdivided to "is it swnode backed or real fwnode one?"
>>>>>
>>>> Yeah,
>>>> On non-DT cases, it can be subdivided to swnode backed case and ACPI fwnode backed case.
>>>>
>>>>    - For swnode backed case: the device_get_match_data() don't has a implemented backend.
>>>>    - For ACPI fwnode backed case: the device_get_match_data() has a implemented backend.
>>>>
>>>> But the driver has *neither* software node support
>>> True.
>>>
>>>> nor ACPI support,
>>> Not true.
>> Why this is not true? Are you means that the panel-ilitek-ili9341 driver has ACPI support?
> That's the idea (as far as I see the copy of the code from tinyDRM),
> but broken over the copy'n'paste. This patch rectifies that to be
> in align with the original code, which *does* support ACPI.
>
>> I'm asking because I don't see struct acpi_device_id related stuff in that source file,
>> am I miss something?
> Yes, you are. I leave it for you to research.
>

After researching a few hours I still don't understand how does
the panel-ilitek-ili9341 driver has the ACPI support and be able
to ACPI probed when compiled as module.

As far as I know, drivers that has the ACPI support *must* has the
acpi_match_table hooked, so that be able to be probed when the
driver is compiled as a module.

For example, see commit 75a1b44a54bd9 ("spi: tegra210-quad: add acpi support")
to get a feel what a SPI device with *real* ACPI support looks like.

I have double checked the panel-ilitek-ili9341 driver, it doesn't
has acpi_match_table hooked, which means that this driver won't
even be able probed. And probed as pure SPI device still out of
the scope of "correct use of device property APIs". Because SPI
device specific method don't belong to the device property API.
  
I don't really know what's we are missing, but we already intend
to let it go, thanks.


>>> So, slow down and take your time to get into the code and understand how it works.
>>>
>>>> so that the rotation property can not get and ili9341_dpi_probe() will fails.
>>>> So in total, this is not a 100% correct use of device property APIs.
>>>>
>>>> But I'm fine that if you want to leave(ignore) those less frequent use cases temporarily,
>>>> there may have programmers want to post patches, to complete the missing in the future.
>>>>
>>>> So, there do have some gains on non-DT cases.
>>>>
>>>>    - As you make it be able to compiled on X86 with the drm-misc-defconfig.
>>>>    - You cleanup the code up (at least patch 2 in this series is no obvious problem).
>>>>    - You allow people to modprobe it, and maybe half right and half undefined.
>>>>
>>>> But you do helps moving something forward, so congratulations for the wake up.

-- 
Best regards,
Sui


