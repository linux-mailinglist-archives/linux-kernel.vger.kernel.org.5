Return-Path: <linux-kernel+bounces-156287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 593D08B00D1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A44191F2242E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3645013C82F;
	Wed, 24 Apr 2024 05:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f9ycVAQP"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513BA1E868
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 05:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713935356; cv=none; b=muWXC+l8H+beW3pRH2hLwNA/EAdk0bxVq9ODbr4IVL9jp7tRy8Njg1dJIy2eER+ff9cEORXu4hkpMrZEnHJeTH9NCuuokQhF4DpQZjDsCJY509i933aSx8gEySzDhtA45B86GZTJ7AEnJlaziE1lx+guhumhc0f1kZrvLfRp7Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713935356; c=relaxed/simple;
	bh=hsPjuTbiN/dIW997zkTnai903v/BUpXXdiPKRMY47wk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ph+LOHGZCUkb/vpnQbqElZKS0Tqa/2zzOlA3Q3sH/JLhKs6GDIbTd4JYYDODxCotelIGir72x5p5z5S4R2x+iUj2byWN8ytLXNWvWCxg6JLFRstG+iRW2uxRrxxuUY5/jb7YJqZFB+NVzhlWQFnfCRw0zbuFI744kgOG/UTxQLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f9ycVAQP; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <22979e28-ed48-467f-a5cf-82be57bcc2f7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713935351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kn9GVgtEXwasErGqw/29COA8cUkcHNCt3wrEGRAtFN4=;
	b=f9ycVAQPnotRUb3NSIfT4hkf5CwCbI7ej7CXuagnK8SRHaUqdNw1ZPAtFO9I7KmYF5PyMN
	tUHJ2u/7m/jLqkNxC6IWf21Tza35Q7GH6LakrldMRVkHqml0fab6vK9IoBvnM5TmlvIgtJ
	41S5HClq9Qqs5utQFiDNm+ah0biH7OE=
Date: Wed, 24 Apr 2024 13:09:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] software node: Implement device_get_match_data fwnode
 callback
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <20240422164658.217037-1-sui.jingfeng@linux.dev>
 <Zie3ebHOEpWHj1qV@smile.fi.intel.com>
 <d5bc1e73-a553-451e-ab74-f5f0ca259c6b@linux.dev>
 <hcltp2bbxxg2t7ibmzgiib7mgbwgmvzwnnq6mochdh7c4h76r3@bxj6yk5zq64e>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <hcltp2bbxxg2t7ibmzgiib7mgbwgmvzwnnq6mochdh7c4h76r3@bxj6yk5zq64e>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/4/24 05:37, Dmitry Baryshkov wrote:
> On Wed, Apr 24, 2024 at 12:49:18AM +0800, Sui Jingfeng wrote:
>> Hi,
>>
>> Thanks a for you reviewing my patch.
>>
>>
>> On 2024/4/23 21:28, Andy Shevchenko wrote:
>>> On Tue, Apr 23, 2024 at 12:46:58AM +0800, Sui Jingfeng wrote:
>>>> Because the software node backend of the fwnode API framework lacks an
>>>> implementation for the .device_get_match_data function callback. This
>>>> makes it difficult to use(and/or test) a few drivers that originates
>>> Missing space before opening parenthesis.
>> OK, will be fixed at the next version.
>>
>>
>>>> from DT world on the non-DT platform.
>>>>
>>>> Implement the .device_get_match_data fwnode callback, device drivers or
>>>> platform setup codes are expected to provide a string property, named as
>>>> "compatible", the value of this software node string property is used to
>>>> match against the compatible entries in the of_device_id table.
>>> Yep and again, how is this related? If you want to test a driver originating
>>> from DT, you would probably want to have a DT (overlay) to be provided.
>> There are a few reasons, please fixed me if I'm wrong.
>>
>> DT (overlay) can be possible solution, but DT (overlay) still depend on DT.
>> For example, one of my x86 computer with Ubuntu 22.04 Linux/x86 6.5.0-28-generic
>> kernel configuration do not has the DT enabled. This means that the default kernel
>> configuration is decided by the downstream OS distribution. It is not decided by
>> usual programmers. This means that out-of-tree device drivers can never utilize
>> DT or DT overlay, right?
> No, this is not fully correct. The drivers anyway have to adopted for
> the platforms they are used with. It is perfectly fine to have a driver
> that supports both DT and ACPI at the same time.
>
>> I means that Linux kernel is intended to be used by both in-tree drivers and out-of-tree drivers.
>> Out-of-tree device drivers don't have a chance to alter kernel config, they can only managed to
>> get their source code compiled against the Linux kernel the host in-using.
>>
>> Some out-of-tree device drivers using DKMS to get their source code compiled,
>> with the kernel configuration already *fixed*. So they don't have a opportunity
>> to use DT overlay.
>>
>> Relying on DT overlay is *still* *DT* *dependent*, and I not seeing matured solution
>> get merged into upstream kernel yet. However, software node has *already* been merged
>> into Linux kernel. It can be used on both DT systems and non-DT systems. Software node
>> has the least requirement, it is *handy* for interact with drivers who only need a small
>> set properties.
>>
>> In short, I still think my patch maybe useful for some peoples. DT overlay support on
>> X86 is not matured yet, need some extra work. For out-of-tree kernel module on
>> downstream kernel. Select DT and DT overlay on X86 is out-of-control. And I don't want
>> to restrict the freedom of developers.
> I don't think upstream developers care about the downstream kernels.


Theupstream kernels are facing the same problem,by default drm-misc-x86_defconfigdon't has the CONFIG_OF and CONFIG_OF_OVERLAY  selected.
See [1] for an example.
  
[1] https://cgit.freedesktop.org/drm/drm-tip/tree/drm-misc-x86_defconfig?h=rerere-cache


> But let me throw an argument why this patch (or something similar) looks
> to be necessary.

Agreed till to here.


> Both on DT and non-DT systems the kernel allows using the non-OF based
> matching. For the platform devices there is platform_device_id-based
> matching.


Yeah, still sounds good.


> Currently handling the data coming from such device_ids requires using
> special bits of code,


It get started to deviate from here, as you are going to rash onto a narrow way.
Because you made the wrong assumption, it can be platform devices, it can *also*
be of platform device created by the of_platform_device_create(). The patch itself
won't put strong restrictions about its users.


> e.g. platform_get_device_id(pdev)->driver_data to
> get the data from the platform_device_id.

Right, but you run into a narrow area and stuck yourself.
The so called non-DT, non-ACPI platform devices are all you basis of you argument, right?

There have plenty i2c device and SPI device associated with software note properties.
After applied this patch, it means that device_get_match_data() can also works for
those device.

And the approach you provide already generate a lot of *boilerplate*...

> Having such codepaths goes
> against the goal of unifying DT and non-DT paths via generic property /
> fwnode code.


Who's goal? your goal or community's goal? is it documented somewhere?

Andy's goal is just to make those two drivers truely DT independent,
and I agree with Andy. I'm going to cooperate with Andy to achieve this
small goal.

However, apparently, our goal is *different* with your goal, your goal
is a big goal. If you have such a ambitious goal, you can definitely do
something on behalf of yourself.

For example, improving DT overlay support for the FPGA device, Or making
the of_device_id stuff truly platform neutral before telling people that
"XXXX doesn't depend on DT". I guess task of removing the of_node member
from the struct device already in you job list, as you want to unify
the DT and non-DT code paths...

All I want is just be able to contribute, do something useful and do the
right thing. So please don't throw your personal goal or taste onto the
body of other people. Thanks.


> As such, I support Sui's idea


OK so far. But,


> of being able to use device_get_match_data
> for non-DT, non-ACPI platform devices.

Please *stop* the making biased assumptions!
Please stop the making *biased* assumptions!
Please stop the making biased *assumptions*!


Currently, the various display drivers don't have the acpi_device_id associated.
This means that those drivers won't probed even in ACPI enabled systems either.
Adding acpi_device_id to those drivers is another topic. If you have that ambitious,
you can take the job. But this again is another problem.

Back to the concern itself, I didn't mention what device or what drivers will
be benefits in my commit message. In fact, after applied this patch,
device_get_match_data() will works for the i2c device and SPI device associated
with software note. Hence, "non-DT, non-ACPI platform devices" are just an imaginary
of yourself. So please stop bring you own confusion to us.

> Sui, if that fits your purpose,


That doesn't fits my purpose, please stop the recommendation, thanks.


> please make sure that with your patch
> (or the next iteration of it) you can get driver_data from the matched
> platform_device_id.


No, that's a another problem.

The 'platform_get_device_id(pdev)->driver_data' you mentioned is completely
off the domain of fwnode API framework. You are completely deviate what we
are currently talking about.

What we are talking about is something within the fwnode API framework.

You can hack the device_get_match_data() function to call platform_get_device_id()
as a fallback code path when the fwnode subsystem couldn't return a match data to
you. But this is another problem.


>>
>>>> This also helps to keep the three backends of the fwnode API aligned as
>>>> much as possible, which is a fundamential step to make device driver
>>>> OF-independent truely possible.
>>>>
>>>> Fixes: ffb42e64561e ("drm/tiny/repaper: Make driver OF-independent")
>>>> Fixes: 5703d6ae9573 ("drm/tiny/st7735r: Make driver OF-independent")
>>> How is it a fix?
>>
>> Because the drm/tiny/repaper driver and drm/tiny/st7735r driver requires extra
>> device properties. We can not make them OF-independent simply by switching to
>> device_get_match_data(). As the device_get_match_data() is a *no-op* on non-DT
>> environment.
> This doesn't constitute a fix.


No, it does.

> It's not that there is a bug that you are
> fixing. You are adding new feature ('support for non-DT platforms').


Yes, it's a bit of farfetched.

But as our goal is to make driver OF-independent, as mentioned in the commit title.
when the needed feature is missing, the goal can not be achieved. Fix the missing.


>> Hence, before my patch is applied, the two "Make driver OF-independent" patch
>> have no effect. Using device_get_match_data() itself is exactly *same* with
>> using of_device_get_match_data() as long as the .device_get_match_data hook is
>> not implemented.
>>
>>
>> See my analysis below:
>>
>> When the .device_get_match_data hook is not implemented:
>>
>> 1) On DT systems, device_get_match_data() just redirect to of_fwnode_device_get_match_data(),
>>     which is just a wrapper of of_device_get_match_data().
>>
>> 2) On Non-DT system, device_get_match_data() has *ZERO* effect, it just return NULL.
>>
>>
>> Therefore, device_get_match_data() adds *ZERO* benefits to the mentioned drivers if
>> the .device_get_match_data is not implemented.
>>
>> Only when the .device_get_match_data hook get implemented, device_get_match_data()
>> can redirect tosoftware_node_get_match_data() function in this patch.
>> Therefore, the two driver has a way to get a proper driver match data on
>> non-DT environment. Beside, the users of those two driver can provide
>> additional software node property at platform setup code. as long as at
>> somewhere before the driver is probed.
>>
>> So the two driver really became OF-independent after applied my patch.
>>
>>
>>>> Closes: https://lore.kernel.org/lkml/20230223203713.hcse3mkbq3m6sogb@skbuf/
>>> Yes, and then Reported-by, which is missing here.
>>>
>>>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>> Cc: Daniel Scally <djrscally@gmail.com>
>>>> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>>>> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>>> Please, move these after the cutter '---' line (note you may have that line in
>>> your local repo).
>>>
>>> ...
>>>
>> OK, thanks a lot for teaching me.
>>
>>
>>>> +static const void *
>>>> +software_node_get_match_data(const struct fwnode_handle *fwnode,
>>>> +			     const struct device *dev)
>>>> +{
>>>> +	struct swnode *swnode = to_swnode(fwnode);
>>>> +	const struct of_device_id *matches = dev->driver->of_match_table;
>>>> +	const char *val = NULL;
>>>> +	int ret;
>>>> +	ret = property_entry_read_string_array(swnode->node->properties,
>>>> +					       "compatible", &val, 1);
>>> And if there are more than one compatible provided?
>> Nope, I think this is kind of limitation of the software node,
>> platform setup code generally could provide a compatible property.
>> No duplicate name is allowed. But we the best explanation would be
>> platform setup code should provide the "best" or "default" compatible
>> property.
> The implementation is still incorrect.


No, it is correct.


> The swnode code shouldn't look
> into the OF data. Please use non-DT match IDs.

Please stop the misleading,  the software_node_get_match_data() is a mimic to (subset of)
acpi_fwnode_device_get_match_data(), Software node is kind of complement to ACPI, it's
definitely need to follow the code style of ACPI counterpart. The initial implementation
choose to take a look at the dev->driver->of_match_table, which is to avoid ugly duplication.
This introducing no *boilerplate*, and partly reflect what you goal: "Unifying".
   
So, please don't go against with yourself and Please read the implement
of acpi_fwnode_device_get_match_data() before objects, thanks.


>>
>>>> +	if (ret < 0 || !val)
>>>> +		return NULL;
>>>> +	while (matches && matches->compatible[0]) {
>>> First part of the conditional is invariant to the loop. Can be simply
>>
>> Right, thanks.
>>
>>
>>> 	matches = dev->driver->of_match_table;
>>> 	if (!matches)
>>> 		return NULL;
>>>
>>> 	while (...)
>>>
>>>> +		if (!strcmp(matches->compatible, val))
>>>> +			return matches->data;
>>>> +
>>>> +		matches++;
>>>> +	}
>>>> +
>>>> +	return NULL;
>>>> +}
>> -- 
>> Best regards,
>> Sui
>>
-- 
Best regards,
Sui


