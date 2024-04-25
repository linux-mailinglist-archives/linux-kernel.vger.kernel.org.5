Return-Path: <linux-kernel+bounces-158615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DD18B2302
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDD431F22044
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9ACD149DF9;
	Thu, 25 Apr 2024 13:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qh+fbmxw"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77324149C67
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 13:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714052588; cv=none; b=OJffMB+PzvybDQ0dwdH4VxwTVymM0GqO4rbw6r2H/b3+F2+OaH1sXvda7hOu+GA48GAfZEjcrtAI4U/YSF6I53dS0alH/36fN2LFub/hr8JsZ0BsK639ILKRuaF09tHzrMkMDHEJX/ZOYNxHwNT1oNZkpfK/YoT1wRq9J6kaK+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714052588; c=relaxed/simple;
	bh=FYUm8/jsSbolhzGW8nVV7JKBaPVgVAGk/UemDJ9yAkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JLxAdj6bJMD7qBDNPjP1ZE5bqvJm6h0/k3JMvR26J+TS5o8detnSjJ1r3xAGRrtjoOKIeAme/8B9PaLURqlinlQjGC5aE9DYuHrSLuoI5sZOUFdvZ/rSqQQjO6+mLRqA1WgpPu3Nv2wbSc3aIVNUn8ugbFdNvMaRjCBTKfgAUw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qh+fbmxw; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c81f770b-5fe4-4212-bfce-fedb3fced94e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714052584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B40s8PwSIdtJ8VKzMJF2QOyXb1ZhIpWphE6PaQ8co9M=;
	b=qh+fbmxwR9UmPyb42yBLOM0tKjcJwrT5TCPpL6XcRbRjtwl3SkYp0LCpqqX7DtT6w17ZVT
	RIr44sEjAgn6gEvlxWLDAFYKtJDG+7B1ZT63He+26YwT7Z3geobad5WBLysQ4sVnZ+COzt
	0l4agMa/b5XL31jQp8canBwG3bEzH54=
Date: Thu, 25 Apr 2024 21:42:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] software node: Implement device_get_match_data fwnode
 callback
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <20240422164658.217037-1-sui.jingfeng@linux.dev>
 <Zie3ebHOEpWHj1qV@smile.fi.intel.com>
 <d5bc1e73-a553-451e-ab74-f5f0ca259c6b@linux.dev>
 <hcltp2bbxxg2t7ibmzgiib7mgbwgmvzwnnq6mochdh7c4h76r3@bxj6yk5zq64e>
 <ZikE4qOVO7rgIs9a@smile.fi.intel.com>
 <CAA8EJpr1FSjizAh6Dp5Bmux3NrGYh=BfHFL4D1fa87Og4ymY0w@mail.gmail.com>
 <Zikck2FJb4-PgXX0@smile.fi.intel.com>
 <kucey3jsydjye3ndflns3cqolcpizhnxgzz3fkmcatlnpbnwrk@22ulsqfh2vf6>
 <Zik3AjiWkytSVn-1@smile.fi.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <Zik3AjiWkytSVn-1@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2024/4/25 00:44, Andy Shevchenko wrote:
> On Wed, Apr 24, 2024 at 07:34:54PM +0300, Dmitry Baryshkov wrote:
>> On Wed, Apr 24, 2024 at 05:52:03PM +0300, Andy Shevchenko wrote:
>>> On Wed, Apr 24, 2024 at 04:34:39PM +0300, Dmitry Baryshkov wrote:
>>>> On Wed, 24 Apr 2024 at 16:11, Andy Shevchenko
>>>> <andriy.shevchenko@linux.intel.com> wrote:
>>>>> On Wed, Apr 24, 2024 at 12:37:16AM +0300, Dmitry Baryshkov wrote:
>>>>>> On Wed, Apr 24, 2024 at 12:49:18AM +0800, Sui Jingfeng wrote:
>>>>>>> On 2024/4/23 21:28, Andy Shevchenko wrote:
>>>>>>>> On Tue, Apr 23, 2024 at 12:46:58AM +0800, Sui Jingfeng wrote:
> ...
>
>>>>>> But let me throw an argument why this patch (or something similar) looks
>>>>>> to be necessary.
>>>>>>
>>>>>> Both on DT and non-DT systems the kernel allows using the non-OF based
>>>>>> matching. For the platform devices there is platform_device_id-based
>>>>>> matching.
>>>>>>
>>>>>> Currently handling the data coming from such device_ids requires using
>>>>>> special bits of code, e.g. platform_get_device_id(pdev)->driver_data to
>>>>>> get the data from the platform_device_id. Having such codepaths goes
>>>>>> against the goal of unifying DT and non-DT paths via generic property /
>>>>>> fwnode code.
>>>>>>
>>>>>> As such, I support Sui's idea of being able to use device_get_match_data
>>>>>> for non-DT, non-ACPI platform devices.
>>>>> I'm not sure I buy this. We have a special helpers based on the bus type to
>>>>> combine device_get_match_data() with the respective ID table crawling, see
>>>>> the SPI and I²C cases as the examples.
>>>> I was thinking that we might be able to deprecate these helpers and
>>>> always use device_get_match_data().
>>> True, but that is orthogonal to swnode match_data support, right?
>>> There even was (still is?) a patch series to do something like a new
>>> member to struct device_driver (? don't remember) to achieve that.
>> Maybe the scenario was not properly described in the commit message, or
>> maybe I missed something. The usecase that I understood from the commit
>> message was to use instatiated i2c / spi devices, which means
>> i2c_device_id / spi_device_id. The commit message should describe why
>> the usecase requires using 'compatible' property and swnode. Ideally it
>> should describe how these devices are instantiated at the first place.
> Yep. I also do not clearly understand the use case and why we need to have
> a board file, because the swnodes all are about board files that we must not
> use for the new platforms.
>

Would you like to tell us what's the 'board file'?

I am asking because I can not understand those two words at all.
I'm really don't know what's the meanings of 'board file'.

Do you means that board file is something like the dts, or
somethings describe the stuff on the motherboard but outside
the CPU?

Does the hardware IP core belong to the "board file"?

Can we using more concrete vocabulary instead of the vague
vocabulary to communicate?


-- 
Best regards,
Sui


